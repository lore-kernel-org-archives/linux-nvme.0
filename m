From: sjones@kalray.eu (Samuel Jones)
Date: Thu, 16 Mar 2017 11:57:13 +0100
Subject: NVMe RDMA driver: CX4 send queue fills up when nvme queue depth is low
Message-ID: <1fd21f46-e8db-8d4a-0a4a-01d591c3fa71@kalray.eu>

Hi all,

I have a Mellanox Connect x4 that I am using as an NVMf initiator to 
communicate with an NVMe device.  I am running a 4.8.17 kernel, with the 
vanilla drivers for the Mellanox card. When I reduce the IO queue size 
exposed by my NVMe device to < 32, I get an error from the NVMe RDMA driver:

[ 2048.693355] mlx5_0:mlx5_ib_post_send:3765:(pid 7273):
[ 2048.693360] nvme nvme1: nvme_rdma_post_send failed with error code -12

Then everything locks up.

This is because the function mlx5_wq_overflow in mlx5/qp.c has failed, 
implying the send queue is full.

The same setup works with a Connect x3 Pro card.

I believe the issue is related to the following snippet in the NVMe RDMA 
code:

/*
  * Unsignalled send completions are another giant desaster in the
  * IB Verbs spec:  If we don't regularly post signalled sends
  * the send queue will fill up and only a QP reset will rescue us.
  * Would have been way to obvious to handle this in hardware or
  * at least the RDMA stack..
  *
  * This messy and racy code sniplet is copy and pasted from the iSER
  * initiator, and the magic '32' comes from there as well.
  *
  * Always signal the flushes. The magic request used for the flush
  * sequencer is not allocated in our driver's tagset and it's
  * triggered to be freed by blk_cleanup_queue(). So we need to
  * always mark it as signaled to ensure that the "wr_cqe", which is
  * embeded in request's payload, is not freed when __ib_process_cq()
  * calls wr_cqe->done().
  */

if ((++queue->sig_count % 32) == 0 || flush)
	wr.send_flags |= IB_SEND_SIGNALED;

The iSER initiator, as I understand it, sizes send queues with a 
constant that is at least 512. The NVMe code however, sizes send queues 
based on the size of the NVMe queue: in nvme_rdma_create_qp:

init_attr.cap.max_send_wr = factor * queue->queue_size + 1;

This attribute is then used by the mlx4 and mlx5 drivers to size the HW 
queue taking into account various HW-related factors. With an NVMe queue 
= 16, the mlx4 driver gives me a queue of 111 elements. The mlx5 driver 
gives me a queue of 85.

The send_wr_factor used in the NVMe RDMA code to take into account that 
we push potentially MR, SEND and INV commands into the send queue seems 
to imply that we need a minimum queue depth of 32 * 3 = 96, or that we 
should not use a constant 32 for the send signalling but a min(32, 
queue_depth).

Does anyone have an opinion on this issue? I'd be grateful for any help.

Samuel Jones
