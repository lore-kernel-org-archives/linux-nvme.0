From: jonathan.derrick@intel.com (Jon Derrick)
Date: Tue, 18 Oct 2016 13:49:40 -0600
Subject: [PATCH 3/7 v2] nvme-fabrics: Add FC transport FC-NVME definitions
In-Reply-To: <1f0b3b42-241a-65db-f842-08a1c378b559@broadcom.com>
References: <57f82b10.h/qKXTOsgeHQsdmh%james.smart@broadcom.com>
 <20161012085834.GD12972@infradead.org>
 <1f0b3b42-241a-65db-f842-08a1c378b559@broadcom.com>
Message-ID: <20161018194939.GA2048@localhost.localdomain>

Hi James,

Fair warning, I don't really deal with the fabrics part of our driver,
and I don't see where your macro is actually used.

On Tue, Oct 18, 2016@10:59:43AM -0700, James Smart wrote:
> 
> 
> On 10/12/2016 1:58 AM, Christoph Hellwig wrote:
> >
> >>+/* fills in length of a descriptor. Struture minus descriptor header */
> >>+#define FCNVME_LSDESC_LEN(lsdesc) \
> >>+		cpu_to_be32(sizeof(lsdesc) - (2*(sizeof(u32))))
> >Make this an inline function and use spaces between the operators,
> >please.
> >
> 
> Christoph,
> 
> This can't be an inline - the "lsdesc" field is a type declaration ("struct
> x") and varies. That's the purpose of the define: so it can be applied to
> different structures- e.g. FCNVME_LSDESC_LEN(struct foo) and
> FCNVME_LSDESC_LEN(struct bar)

How about:
static inline __be32 fcnvme_lsdesc_len(size_t lsdesc_sz)
{
	return cpu_to_be32(lsdesc_sz - 2 * sizeof(u32));
}

foo = fcnvme_lsdesc_len(sizeof(struct bar));
