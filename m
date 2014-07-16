From: willy@linux.intel.com (Matthew Wilcox)
Date: Wed, 16 Jul 2014 10:16:32 -0400
Subject: [PATCH 1/1] Replace the dma_alloc_coherent() with
 dma_zalloc_coherent()
In-Reply-To: <CACuVHZ=-oROVOOXJRRoZ6EvXCky9DpXbjvUh0Uf3SmAjzhRGLQ@mail.gmail.com>
References: <1405447906-7220-1-git-send-email-mundu2510@gmail.com>
 <20140715182846.GG5855@linux.intel.com>
 <CACuVHZ=-oROVOOXJRRoZ6EvXCky9DpXbjvUh0Uf3SmAjzhRGLQ@mail.gmail.com>
Message-ID: <20140716141632.GI5855@linux.intel.com>

On Wed, Jul 16, 2014@11:27:38AM +0530, mundu agarwal wrote:
> Willy,
> 
> There is patch merged for dma_zalloc_coherent for cqee to avoid the
> memset, where as memset still happing for same in nvme_init_queue. I
> guess this is not needed, and rest are to maintain the consistancy. I
> feel instead of mix use of the apis, should be use as clean/single
> one. There are couple of places during initialization variables are
> reseting to 0 after allocating the memory using zalloc which we can
> avoid. In case this patch ok then my next task will be doing the
> cleanup without any impacting the current functionality.

Better not to guess.  Joe's quite careful to only do the ones that are
obviously correct.  I believe your patches to be incorrect, since some of
the places don't need to be zeroed (eg SQEs are zeroed before each use).

In the specific case of nvme_init_queue() zeroing the memory, I think
it's necessary on that path because that path is called on resume from
D3 and we need to reinitialise the CQ state to all zeroes.  Keith should
be able to confirm that.
