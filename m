From: keith.busch@linux.intel.com (Keith Busch)
Date: Tue, 22 May 2018 08:06:53 -0600
Subject: [RFC PATCH 0/3] blk-mq: Timeout rework
In-Reply-To: <9ca27e059fbd12a976e1e2f1ee1aa5c8ca579ad0.camel@wdc.com>
References: <20180521231131.6685-1-keith.busch@intel.com>
 <9ca27e059fbd12a976e1e2f1ee1aa5c8ca579ad0.camel@wdc.com>
Message-ID: <20180522140653.GP5528@localhost.localdomain>

On Mon, May 21, 2018@11:29:21PM +0000, Bart Van Assche wrote:
> Can you explain why the NVMe driver needs reference counting of requests but
> no other block driver needs this? Additionally, why is it that for all block
> drivers except NVMe the current block layer API is sufficient
> (blk_get_request()/blk_execute_rq()/blk_mq_start_request()/
> blk_mq_complete_request()/blk_mq_end_request())?

Hi Bart,

I'm pretty sure NVMe isn't the only driver where a call to
blk_mq_complete_request silently fails to transition the request to
COMPLETE, forcing unnecessary error handling. This patch isn't so
much about NVMe as it is about removing that silent exception from the
block API.

Thanks,
Keith
