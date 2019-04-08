From: hare@suse.de (Hannes Reinecke)
Date: Mon, 8 Apr 2019 10:37:58 +0200
Subject: FC-NVMe csn initialisation
Message-ID: <7f105083-7e74-7191-d321-acdeafa25f88@suse.de>

Hi James,

checking the FC-NVMe spec it states:

a) the CSN shall be equal to zero for the first NVMe_CMND IU for each 
NVMeoFC connection and shall be incremented by one for each subsequent 
command on the NVMeoFC connection;

yet we have:

static void
nvme_fc_init_queue(struct nvme_fc_ctrl *ctrl, int idx)
{
	struct nvme_fc_queue *queue;

	queue = &ctrl->queues[idx];
	memset(queue, 0, sizeof(*queue));
	queue->ctrl = ctrl;
	queue->qnum = idx;
	atomic_set(&queue->csn, 1);
	queue->dev = ctrl->dev;

Is this by design?
Or a simple bug?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare at suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Mary Higgins, Sri Rasiah
HRB 21284 (AG N?rnberg)
