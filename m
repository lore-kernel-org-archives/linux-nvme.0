From: willy@linux.intel.com (Matthew Wilcox)
Date: Wed, 29 May 2013 17:04:19 -0400
Subject: Tree updated 2013-05-29
In-Reply-To: <20130517133517.GO6057@linux.intel.com>
References: <20130517133517.GO6057@linux.intel.com>
Message-ID: <20130529210419.GE8211@linux.intel.com>

On Fri, May 17, 2013@09:35:17AM -0400, Matthew Wilcox wrote:
> I've pulled in a few fixes:
[...]
> I'll ask Linus to pull them next week, and they should be in 3.10.

I didn't end up asking for a pull.  I pulled in three more fixes:

Chayan Biswas (1):
      Return the result from user admin command IOCTL even in case of failure

Matthew Wilcox (1):
      NVMe: Use dma_set_mask() correctly

Ramachandra Rao Gajula (1):
      NVMe: Add MSI support

I'll ask Linus to pull on Friday.  Please test.
