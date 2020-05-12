#!/usr/bin/env python
""" Library for creating 2D graphs, and then determining free space and connections to generate a roadmap """

import sys
sys.path.insert(0,'..')
import roadmap_builder as rb 

roadmap = rb.RoadmapBuilder()
roadmap.construct_square(10)
roadmap.set_obstacles(1,2,10)
roadmap.init_roadmap()
roadmap.set_neighbors()

for inode in roadmap.roadmap:
    print(len(inode.neighbors))




# len_obs = len(roadmap.obstacles)
# print('Num obstacles: {}'.format(len_obs))
# print('---------------------')
# for obs_idx in range(0,len(roadmap.obstacles)):
#     len_seg = len(roadmap.obstacles[obs_idx])
#     print('{}| Num segments = {}'.format(obs_idx,len_seg))

# for obs_idx in range(0,len(roadmap.obstacles)):
#     for seg_idx in range(0,len(roadmap.obstacles[obs_idx])):
#         if seg_idx == 0:
#             x = roadmap.obstacles[obs_idx][seg_idx][0]
#             y = roadmap.obstacles[obs_idx][seg_idx][1]
#             print('Origin = ({},{})'.format(x,y))
#         else:
#             array = roadmap.obstacles[obs_idx][seg_idx]
#             delta_x = array[0]
#             delta_y = array[1]
#             print('Seg {} | ({},{})'.format(seg_idx,delta_x,delta_y))

# print roadmap.roadmap[0].neighbors[0]
# print roadmap.roadmap[0].neighbors_cost[0]