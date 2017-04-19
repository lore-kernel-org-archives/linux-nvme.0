From: jsmart2021@gmail.com (James Smart)
Date: Wed, 19 Apr 2017 16:19:41 -0700
Subject: [PATCH v2 4/5] nvmet_fc: Rework target side abort handling
In-Reply-To: <20170419193625.GE18191@infradead.org>
References: <20170411183232.8955-1-jsmart2021@gmail.com>
 <20170411183232.8955-5-jsmart2021@gmail.com>
 <20170419193625.GE18191@infradead.org>
Message-ID: <00a1f313-d5d2-d750-9993-e815fa780ffe@gmail.com>

On 4/19/2017 12:36 PM, Christoph Hellwig wrote:
> This looks ok as a change to the existing code:
>
> Reviewed-by: Christoph Hellwig <hch at lst.de>
>
> But we really need to go to the NVMe technical working group about
> how to cater for the fact that the FC transport does transport aborts
> (and thus probably doesn't use NVMe aborts at all, although we'd need
> to clarify that).  Can you reach out to the working group and the T11
> folks?
>

Thanks.

I think there's a mis-understanding.  T11 doesn't use transport aborts 
in lieu of an NVMe Abort.  In fact, it's written that if it has an I/O 
failure and can't recover from it by retransmission/preserving the 
exchange (and currently it can't, as the T11 1.0 spec deferred 
retransmission support until 1.1), then it falls back to terminating the 
connection, which also terminates the association - which is per the 
language in the NVMe Fabric spec sec 7.1.  So, if it sees an ABTS for an 
exchange, it kills the association.  Note: there would be several issues 
if T11 tried to use ABTS's in lieu of Abort, or ABTS and cmd retry in 
lieu of real retransmission. So neither are allowed.

What you're probably seeing is the error being detected on the io, and 
the ABTS being pre-emptively sent for that io, and then that escalating 
to the connection/association failure, which usually spits out lots more 
ABTS's.   On the target side implementation in linux, the one io gets 
aborted, and it currently doesn't escalate to other commands - it 
expects the initiator to get the ABTS, thus an io error, thus the 
initiator to teardown the connection/association and send all the 
ABTS's.   This may need to be revisited after the T11 1.0 spec comes 
out, which I believe requires the target to also ABTS things on 
connection failure.  I do need to check that if the linux nvmet layer 
kills the association/connection its returning all the outstanding cmds 
to the transport so I can meet that requirement.

There are perhaps 2 things that could be improved on the linux initiator 
fc transport:
1) Use NVMe Aborts instead of defaulting to resetting the controller 
(like rdma). This was held off as: ) NVME Abort are "best effort" and 
there were a lot of comments in the tech group promoting lazy abort 
support by always returning Dword 0 bit 0 =1 (cmd not aborted); b) Abort 
vs SQ cmd delivery is even more asynchronous than on other transports, 
creating more hit/miss conditions and requiring Abort command retries 
(what is a reasonable policy?); and c) it really should be something in 
the core layer and managing vs the Abort Command Limit is a real pain. 
This can always change in the future.

2) There are a couple of io error cases that detect a transport error 
and set status to NVME_SC_FC_TRANSPORT and don't ABTS the cmds. They 
should per T11 spec.

-- james
