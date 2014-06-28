From: willy@linux.intel.com (Matthew Wilcox)
Date: Sat, 28 Jun 2014 08:52:50 -0400
Subject: [PATCH -next 04/26] block: Use dma_zalloc_coherent
In-Reply-To: <ff8b612a77e9c4d5826df68b3e6fe27b800610e9.1402863905.git.joe@perches.com>
References: <cover.1402863904.git.joe@perches.com>
 <ff8b612a77e9c4d5826df68b3e6fe27b800610e9.1402863905.git.joe@perches.com>
Message-ID: <20140628125250.GT12025@linux.intel.com>

On Sun, Jun 15, 2014@01:37:33PM -0700, Joe Perches wrote:
> Use the zeroing function instead of dma_alloc_coherent & memset(,0,)

Applied
