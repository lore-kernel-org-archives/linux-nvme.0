From: keith.busch@intel.com (Keith Busch)
Date: Thu, 5 Apr 2018 15:38:47 -0600
Subject: IRQ/nvme_pci_complete_rq: NULL pointer dereference yet again
In-Reply-To: <5d6d1a8c-6490-4046-0fba-da0a0df3d00c@gmail.com>
References: <5d6d1a8c-6490-4046-0fba-da0a0df3d00c@gmail.com>
Message-ID: <20180405213847.GG10098@localhost.localdomain>

On Thu, Apr 05, 2018@03:51:38PM -0500, Alex G. wrote:
> Hi Keith,
> 
> The NULL pointer dereference strikes yet again, but in a different
> place. I think you'll love this one, as we can get it with native AER.
> I'm not sure what to make of it, or why we get an invalid opcode with
> the package, but the error is consistently tied to nvme.

Interesting indeed.

Invaild opcode is a BUG_ON triggering a kernel panic when it evaluates
to true:

  [  938.971059] kernel BUG at mm/slub.c:296!

Which is this:

  static inline void set_freepointer(struct kmem_cache *s, void *object, void *fp)
  {
	unsigned long freeptr_addr = (unsigned long)object + s->offset;

  #ifdef CONFIG_SLAB_FREELIST_HARDENED
	BUG_ON(object == fp); /* naive detection of double free or corruption */
  #endif

	*(void **)freeptr_addr = freelist_ptr(s, fp, freeptr_addr);
  }

So the code thinks it's found memory corruption. Maybe it has.

At least one odd thing is the repeated "controller is down; will reset"
messages. This should come into play only if an IO timeout occurs, and
observing the message should mean the driver aborted and completed all
outstanding IO. There shouldn't be any more IO to timeout after that,
so not sure how we're repeatedly entering the timeout handler.
