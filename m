From: Bart.VanAssche@wdc.com (Bart Van Assche)
Date: Tue, 22 May 2018 16:30:41 +0000
Subject: [RFC PATCH 0/3] blk-mq: Timeout rework
In-Reply-To: <20180522140653.GP5528@localhost.localdomain>
References: <20180521231131.6685-1-keith.busch@intel.com>
 <9ca27e059fbd12a976e1e2f1ee1aa5c8ca579ad0.camel@wdc.com>
 <20180522140653.GP5528@localhost.localdomain>
Message-ID: <56564c0694eb3a21dfdcfbc6c3053774f026d371.camel@wdc.com>

On Tue, 2018-05-22@08:06 -0600, Keith Busch wrote:
> On Mon, May 21, 2018@11:29:21PM +0000, Bart Van Assche wrote:
> > Can you explain why the NVMe driver needs reference counting of requests but
> > no other block driver needs this? Additionally, why is it that for all block
> > drivers except NVMe the current block layer API is sufficient
> > (blk_get_request()/blk_execute_rq()/blk_mq_start_request()/
> > blk_mq_complete_request()/blk_mq_end_request())?
> 
> I'm pretty sure NVMe isn't the only driver where a call to
> blk_mq_complete_request silently fails to transition the request to
> COMPLETE, forcing unnecessary error handling. This patch isn't so
> much about NVMe as it is about removing that silent exception from the
> block API.

Hello Keith,

Please have a look at v13 of the timeout handling rework patch that I posted.
That patch should not introduce any new race conditions and should also handle
the scenario fine in which blk_mq_complete_request() is called while the NVMe
timeout handling function is in progress.

Thanks,

Bart.
