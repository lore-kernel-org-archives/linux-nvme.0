From: hch@lst.de (Christoph Hellwig)
Date: Wed, 19 Aug 2015 10:16:04 +0200
Subject: [PATCH 1/2] nvme: remove spurious use of *_to_cpup helpers
In-Reply-To: <55D370B2.9060006@fb.com>
References: <1439838580-29647-1-git-send-email-hch@lst.de>
 <1439838580-29647-2-git-send-email-hch@lst.de>
 <20150817201237.GC9645@linux.intel.com> <55D370B2.9060006@fb.com>
Message-ID: <20150819081604.GA18215@lst.de>

On Tue, Aug 18, 2015@11:51:46AM -0600, Jens Axboe wrote:
> All those nvme equipped sparc and s390's? :-)

I'm pretty sure there are some power systems that have them.

> Joke aside, do we really have that 'load-reversed-endian' addition to the 
> endianness conversion API just because of two rather esoteric platforms? 
> Seems silly.

As mentioned before BE platforms don't need it, compilers have handled
it fine every since the invention of peephole optimization in the 60s.

The cpup helpers are more useful if you iterate over an array of
descriptors:

fs/nfs/blocklayout/dev.c:       b->type = be32_to_cpup(p++);
fs/nfs/blocklayout/dev.c:               b->simple.nr_sigs = be32_to_cpup(p++);
fs/nfs/blocklayout/dev.c:                       b->simple.sigs[i].sig_len = be32_to_cpup(p++);
fs/nfs/blocklayout/dev.c:               b->slice.volume = be32_to_cpup(p++);
fs/nfs/blocklayout/dev.c:               b->concat.volumes_count = be32_to_cpup(p++);
fs/nfs/blocklayout/dev.c:                       b->concat.volumes[i] = be32_to_cpup(p++);
fs/nfs/blocklayout/dev.c:               b->stripe.volumes_count = be32_to_cpup(p++);
fs/nfs/blocklayout/dev.c:                       b->stripe.volumes[i] = be32_to_cpup(p++);

XDR decoding is full of them for example.
