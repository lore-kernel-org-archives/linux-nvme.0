From: keith.busch@intel.com (Keith Busch)
Date: Wed, 8 Jun 2016 19:05:29 -0400
Subject: [PATCH 0/2] check the number of hw queues mapped to sw queues
In-Reply-To: <CAF1ivSbEf-069LBRLRJKDd-e7JuF3jKrZr6yu-fANFajMGR_=w@mail.gmail.com>
References: <1465415292-9416-1-git-send-email-mlin@kernel.org>
 <20160608222557.GC1696@localhost.localdomain>
 <CAF1ivSbEf-069LBRLRJKDd-e7JuF3jKrZr6yu-fANFajMGR_=w@mail.gmail.com>
Message-ID: <20160608230529.GD1696@localhost.localdomain>

On Wed, Jun 08, 2016@03:47:10PM -0700, Ming Lin wrote:
> On Wed, Jun 8, 2016@3:25 PM, Keith Busch <keith.busch@intel.com> wrote:
> > I've been trying to change blk_mq_update_queue_map to do this, but it's
> > not as easy as it sounds. The following is the simplest patch I came
> > up with that gets a better mapping *most* of the time.
> 
> Not working for my case with 6 hw queues(8 cpus):
> 
> [  108.318247] nvme nvme0: 6 hw queues created, but only 5 were mapped
> to sw queues
> 
> hctx_idx 0: 0 1 4 5
> hctx_idx 1: None
> hctx_idx 2: 2
> hctx_idx 3: 3
> hctx_idx 4: 6
> hctx_idx 5: 7

Heh, not one of the good cases I see. I don't think there's a simple
change to use all contexts. Might need a larger rewrite.
