From: bart.vanassche@sandisk.com (Bart Van Assche)
Date: Thu, 20 Oct 2016 11:05:20 -0700
Subject: [PATCH 6/6] nvme/rdma: Make nvme_rdma_conn_rejected() more
 informative
In-Reply-To: <010801d22af9$c202c370$46084a50$@opengridcomputing.com>
References: <e96f7b21-9686-c24f-9c64-e6fb4b44fea0@sandisk.com>
 <66e66d19-5a2a-e867-401a-1ede0c845b3e@sandisk.com>
 <00bf01d22adf$43370ac0$c9a52040$@opengridcomputing.com>
 <0b3c125a-cdb8-7a28-deca-0ccad3d1ca22@sandisk.com>
 <010801d22af9$c202c370$46084a50$@opengridcomputing.com>
Message-ID: <31822981-0032-98aa-6570-450351020463@sandisk.com>

On 10/20/2016 10:45 AM, Steve Wise wrote:
> I agree.  What if we add a helper function in the core to map the
 > event->status value to something human readable?  That would at
 > least push this into the core.   The nvme host really doesn't do
 > anything other than display a different message...
>
> Something like rdma_event_msg(), but using event->status.

Hello Steve,

It won't be possible to let rdma_event_msg() decode the NVME_RDMA_CM_* 
status unless a callback function that performs such decoding is passed 
to rdma_event_msg(). Since such an approach would work for translating a 
status into a message but not for any more advanced CM status handling 
my preference is to unify the calling conventions for IB/RoCE and iWARP 
CM reject callbacks.

Bart.
