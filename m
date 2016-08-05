From: akpm@linux-foundation.org (Andrew Morton)
Date: Fri, 5 Aug 2016 10:01:08 -0700
Subject: [PATCH v4 0/3] dma-mapping, powerpc, nvme: introduce the
 DMA_ATTR_NO_WARN attribute
In-Reply-To: <57A487CC.3040205@linux.vnet.ibm.com>
References: <1470092390-25451-1-git-send-email-mauricfo@linux.vnet.ibm.com>
 <20160804150145.fb5690e9a873121db1dfa0b1@linux-foundation.org>
 <57A3DB17.3060603@linux.vnet.ibm.com>
 <20160804180501.f80c9b919341c486e2a95894@linux-foundation.org>
 <57A487CC.3040205@linux.vnet.ibm.com>
Message-ID: <20160805100108.8f09fb7c1e63cd4ca06b16bd@linux-foundation.org>

On Fri, 5 Aug 2016 09:34:20 -0300 Mauricio Faria de Oliveira <mauricfo@linux.vnet.ibm.com> wrote:

> On 08/04/2016 10:05 PM, Andrew Morton wrote:
> > Of course, the alternative is to just delete the damn warnings from
> > ppc_iommu_map_sg().  Imagine that!  Have they ever been of any use to
> > anyone?
> 
> Sure. I submitted a patch to convert it to dynamic debug (so it would
> still be available if one wanted to), but it wasn't accepted [1]; so
> I guess it apparently is, in some cases.
> 
> [1] https://lists.ozlabs.org/pipermail/linuxppc-dev/2016-June/144196.html
> 

Bah.  What about WARN__ON_ONCE()?  Or much heavier ratelimiting?
