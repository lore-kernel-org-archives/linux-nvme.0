From: Bart.VanAssche@wdc.com (Bart Van Assche)
Date: Wed, 18 Jul 2018 21:05:40 +0000
Subject: [RFC PATCH 3/3] blk-mq: Remove generation seqeunce
In-Reply-To: <20180718203936.GA21011@lst.de>
References: <20180521231131.6685-4-keith.busch@intel.com>
 <c42d13289e38df93bb35e9876b803420e40b03d3.camel@wdc.com>
 <20180712192437.GA16839@localhost.localdomain>
 <7cad25b821c3a640e036f28ff1bbe51e7362d25d.camel@wdc.com>
 <20180713154346.GA18955@localhost.localdomain>
 <a32b251bd3c0a186e5c5ba82656a85fbdcc0c5e4.camel@wdc.com>
 <20180713184712.GA19419@localhost.localdomain>
 <291a13b35af1b65fbbe99a3a9cfc7d570a620cd9.camel@wdc.com>
 <20180713235807.GA19967@localhost.localdomain>
 <20180718195650.GA20336@lst.de> <20180718203936.GA21011@lst.de>
Message-ID: <7aadef775fe67c3656830a8b9b029ec03cca3d26.camel@wdc.com>

On Wed, 2018-07-18@22:39 +0200, hch@lst.de wrote:
> On Wed, Jul 18, 2018@09:56:50PM +0200, hch@lst.de wrote:
> > The important bit is that we need to fix this issue quickly.  We are
> > past -rc5 so I'm rather concerned about anything too complicated.
> > 
> > I'm not even sure SCSI has a problem with multiple completions happening
> > at the same time, but it certainly has a problem with bypassing
> > blk_mq_complete_request from the EH path.
> > 
> > I think we can solve this properly, but I also think we are way to late
> > in the 4.18 cycle to fix it properly.  For now I fear we'll just have
> > to revert the changes and try again for 4.19 or even 4.20 if we don't
> > act quickly enough.
> 
> So here is a quick attempt at the revert while also trying to keep
> nvme working.  Keith, Bart, Jianchao - does this looks reasonable
> as a 4.18 band aid?
> 
> http://git.infradead.org/users/hch/block.git/shortlog/refs/heads/blk-eh-revert

Hello Christoph,

A patch series that first reverts the following patches:
* blk-mq: Fix timeout handling in case the timeout handler returns BLK_EH_DONE
* block: fix timeout changes for legacy request drivers
* blk-mq: don't time out requests again that are in the timeout handler
* blk-mq: simplify blk_mq_rq_timed_out
* block: remove BLK_EH_HANDLED
* block: rename BLK_EH_NOT_HANDLED to BLK_EH_DONE
* blk-mq: Remove generation seqeunce

and next renames BLK_EH_NOT_HANDLED again into BLK_EH_DONE would probably be
a lot easier to review.

Thanks,

Bart.
