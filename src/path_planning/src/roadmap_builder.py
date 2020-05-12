#!/usr/bin/env python
""" Library for creating 2D graphs, and then determining free space and connections to generate a roadmap """

import numpy as np
import math
import sys

class Obstacle(object):
    def __init__(self):
        self.vectors = []

    def create_obstacles(self,num,seg):
        for idx_vec in range(0,num):
            segments = np.random.randint(seg)
            if segments == 0:
                segments = 1
            
            obstacle = []
            pose = np.array([[0],[0]])
            for idx_seg in range(0,segments):
                x = np.random.randint(1)
                y = np.random.randint(1)

                if idx_seg == 0:
                    pose[0] = x
                    pose[1] = y
                else:
                    pose[0] += x
                    pose[1] += y

                obstacle.append(pose)

            self.vectors.append(obstacle)

    def translate_obstacles(self,max):
        for obs_idx in range(0,len(self.vectors)):
            for seg_idx in range(0,len(self.vectors[obs_idx])):
                x = np.random.randint(max)
                y = np.random.randint(max) 
                trans = np.array([[x],[y]])
                self.vectors[obs_idx][seg_idx] = self.vectors[obs_idx][seg_idx] + trans

# Class that constructs an empty node in a graph
class Node(object):
    def __init__(self):
        self.coord = np.array([[],[]])
        self.neighbors = []
        self.neighbors_cost = []
        self.backpointer = None
        self.backpointer_cost = None

# Class that builds a 2D roadmap
class RoadmapBuilder(object):
    def __init__(self):
        self.roadmap = []
        self.obstacles = []

        ### Start with two arrays
        # Array of zeros for free space
        # Array of ones for obstacles
        # Then loop through range of array and determine neighbors
        # and connectivity
    
    def construct_square(self,num):
        for x in range(0,num):
            for y in range(0,num):
                insert_node = Node()
                insert_node.coord = np.array([[x],[y]])
                self.roadmap.append(insert_node)
    
    def set_obstacles(self,num,seg,spread):
        if len(self.roadmap) == 0:
            raise Exception('Initialize graph first!')
        obstacles = Obstacle()
        obstacles.create_obstacles(num,seg)
        obstacles.translate_obstacles(spread)

        self.obstacles = obstacles.vectors

    def init_roadmap(self):
        tmp_roadmap = []
        for node_idx in range(0,len(self.roadmap)):
            x = self.roadmap[node_idx].coord[0]
            y = self.roadmap[node_idx].coord[1]
            
            collision = False
            for obs in self.obstacles:
                for seg in obs:
                    if x==seg[0] and y==seg[1]:
                        collision = True
                        break
                if collision:
                    break
            
            if not collision:
                tmp_roadmap.append(self.roadmap[node_idx])
        self.roadmap = tmp_roadmap
    
    def set_neighbors(self):
        for node_idx in range(0,len(self.roadmap)):
            # x = self.roadmap[node_idx].coord[0]
            # y = self.roadmap[node_idx].coord[1]
            # Count how many neighbors you have
            # Call nearest neighbors to fill remainer
            # num_neighbors = len(self.roadmap[node_idx].neighbors)

            nearest_neighbors,costs = self.find_nearest_neighbors(node_idx,4)
            # print(nearest_neighbors),
            # print(' : '),
            # print(costs)
            self.roadmap[node_idx].neighbors = nearest_neighbors
            self.roadmap[node_idx].neighbors_cost = costs

    def find_nearest_neighbors(self,node_idx,num_neighbors):
        nearest_idx = []
        nearest_dist = []
        nearest_neighbors = []
        costs = []

        for idx in range(0,len(self.roadmap)):
            dist = self.euclidian_distance(node_idx,idx)
            nearest_idx.append(idx)
            nearest_dist.append(dist)

        self_idx = nearest_idx.index(node_idx)
        nearest_dist.pop(self_idx)
        nearest_idx.pop(self_idx)

        for num in range(0,num_neighbors):
            idx = nearest_dist.index(min(nearest_dist))
            # print('%d'%(idx))
            
            neighbor = nearest_idx[idx]
            cost = nearest_dist[idx]
            nearest_neighbors.append(neighbor)
            costs.append(cost)
            
            nearest_dist.pop(idx)
            nearest_idx.pop(idx)
            
        # print(len(nearest_neighbors)),
        # print(len(costs))
        return nearest_neighbors,costs

    def euclidian_distance(self,idx_start,idx_end):
        start = self.roadmap[idx_start].coord
        end = self.roadmap[idx_end].coord
        return math.pow((math.pow(start[0]-end[0],2) + math.pow(start[1]-end[1],2)),.5)

            

                    






