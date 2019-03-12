From: sagi@grimberg.me (Sagi Grimberg)
Date: Tue, 12 Mar 2019 14:15:26 -0700
Subject: [PATCH v4 1/3] nvme: set 0 capacity if namespace block size
 exceeds PAGE_SIZE
In-Reply-To: <20190312143231.GA1149@lst.de>
References: <20190311220227.23656-1-sagi@grimberg.me>
 <20190311220227.23656-2-sagi@grimberg.me> <20190312143231.GA1149@lst.de>
Message-ID: <8a80ce70-0b98-6c82-a47c-f312a41d2d2a@grimberg.me>


> I like the idea behind this, but it looks rather convoluted.  I think
> for the unusable namespace case we should warn and have a common label
> that just sets the capacity, not touching anything else.
> 
> Does something like this work for you?

No, this is what I had done originally, but we need to always have the
queue set to a decent block size, otherwise blk_queue_stack_limits()
panics on div by 0..
