From: maxg@mellanox.com (Max Gurtovoy)
Date: Tue, 7 Nov 2017 16:40:06 +0200
Subject: [PATCH 0/3] nvmet-rdma: SRQ per completion vector
In-Reply-To: <1504609157-3004-1-git-send-email-maxg@mellanox.com>
References: <1504609157-3004-1-git-send-email-maxg@mellanox.com>
Message-ID: <9602adeb-85a0-1db2-0195-31bdedd16d1b@mellanox.com>

Hi Christoph/Sagi,

On 9/5/2017 1:59 PM, Max Gurtovoy wrote:
> This is a new feature for NVMEoF RDMA target, that is intended to save resource allocation
> (by sharing them) and utilize the locality (completions and memory) to get the best
> performance with Shared Receive Queues (SRQs). We'll create a SRQ per completion vector
> (and not per device) and assosiate each created QP/CQ with an appropriate SRQ. This will
> also reduce the lock contention on the single SRQ per device (today's solution).
> 
> My testing environment included 4 initiators (CX5, CX5, CX4, CX3) that were connected to 4
> subsystems (1 ns per sub) throw 2 ports (each initiator connected to unique subsystem
> backed in a different bull_blk device) using a switch to the NVMEoF target (CX5).
> I used RoCE link layer.
> 

what is the approach for this SRQ feature ?
I haven't seen much progress with the CQ pool patches (we first wanted 
it to be on top of the CQ pool patches).
Should I resent it with your comments or wait till CQ pool will be in ?

-Max.
