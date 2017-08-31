From: hch@infradead.org (hch@infradead.org)
Date: Thu, 31 Aug 2017 06:10:48 -0700
Subject: [GIT PULL] nvme update for Linux 4.14, take 2
In-Reply-To: <1504112187.2526.47.camel@wdc.com>
References: <9a27048d-1252-985f-c905-b738d709b204@kernel.dk>
 <38ddd70f-3fec-09c0-dafb-eba1e8f9cc18@grimberg.me>
 <1504106914.2526.5.camel@wdc.com>
 <a798247e-cc89-f189-4ad9-92095a86106e@grimberg.me>
 <1504107991.2526.16.camel@wdc.com>
 <30e386a2-aac7-e9b7-59e2-52c481247e4e@kernel.dk>
 <0ca15e8f-fc04-7694-a471-379103c6428d@grimberg.me>
 <1504109513.2526.28.camel@wdc.com>
 <a2945cf7-93e5-11da-0780-3472b29f18bc@grimberg.me>
 <1504112187.2526.47.camel@wdc.com>
Message-ID: <20170831131048.GC19544@infradead.org>

On Wed, Aug 30, 2017@04:56:28PM +0000, Bart Van Assche wrote:
> How about renaming blk_mq_reinit_tagset() into blk_mq_tagset_iter() and
> to make the argument list of blk_mq_tagset_iter() more similar to that of
> blk_mq_queue_tag_busy_iter() such that callers of blk_mq_tagset_iter()
> can pass a pointer to any structure through the @priv argument? That would
> make this function more general and maybe also more useful to other block
> drivers.

I like that idea.  Even if it makes Sagi's work slightly harder :)

Can we get that into 4.14 still to have a good base?
