From: swise@opengridcomputing.com (Steve Wise)
Date: Tue, 16 Aug 2016 14:40:02 -0500
Subject: nvme/rdma initiator stuck on reboot
Message-ID: <043901d1f7f5$fb5f73c0$f21e5b40$@opengridcomputing.com>

Hey Sagi,

Here is another issue I'm seeing doing reboot testing.  The test does this:

1) connect 10 ram devices over iw_cxgb4
2) reboot the target node
3) the initiator goes into recovery/reconnect mode
4) reboot the inititator at this point.

The initiator gets stuck doing this continually and the system never reboots:

[  596.411842] nvme nvme1: Failed reconnect attempt, requeueing...
[  596.907865] nvme nvme9: rdma_resolve_addr wait failed (-104).
[  596.914461] nvme nvme9: Failed reconnect attempt, requeueing...
[  597.939935] nvme nvme10: rdma_resolve_addr wait failed (-104).
[  597.946625] nvme nvme10: Failed reconnect attempt, requeueing...
[  598.963995] nvme nvme2: rdma_resolve_addr wait failed (-110).
[  598.971968] nvme nvme2: Failed reconnect attempt, requeueing...
[  602.036135] nvme nvme3: rdma_resolve_addr wait failed (-104).
[  602.043797] nvme nvme3: Failed reconnect attempt, requeueing...
[  603.060171] nvme nvme4: rdma_resolve_addr wait failed (-104).
[  603.068153] nvme nvme4: Failed reconnect attempt, requeueing...
[  604.084223] nvme nvme5: rdma_resolve_addr wait failed (-104).
[  604.092191] nvme nvme5: Failed reconnect attempt, requeueing...
[  605.108294] nvme nvme6: rdma_resolve_addr wait failed (-104).
[  605.116251] nvme nvme6: Failed reconnect attempt, requeueing...

Debugging now...

Steve.
