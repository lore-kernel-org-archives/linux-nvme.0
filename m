From: jonathan.derrick@intel.com (Jon Derrick)
Date: Tue, 18 Oct 2016 17:32:24 -0600
Subject: [PATCH 3/7 v2] nvme-fabrics: Add FC transport FC-NVME definitions
In-Reply-To: <adbdd838-6bf9-ef8d-0008-507d507adb8a@broadcom.com>
References: <57f82b10.h/qKXTOsgeHQsdmh%james.smart@broadcom.com>
 <20161012085834.GD12972@infradead.org>
 <1f0b3b42-241a-65db-f842-08a1c378b559@broadcom.com>
 <20161018194939.GA2048@localhost.localdomain>
 <adbdd838-6bf9-ef8d-0008-507d507adb8a@broadcom.com>
Message-ID: <20161018233223.GA2202@localhost.localdomain>

> >On Tue, Oct 18, 2016@10:59:43AM -0700, James Smart wrote:
> >How about:
> >static inline __be32 fcnvme_lsdesc_len(size_t lsdesc_sz)
> >{
> >	return cpu_to_be32(lsdesc_sz - 2 * sizeof(u32));
> >}
> >
> >foo = fcnvme_lsdesc_len(sizeof(struct bar));
> 
> Yes - that would work.
> 
> What is the rule for when it should be a macro vs an inline ?   It makes
> sense to me to be an inline if you want to strongly check the type of an
> argument, but something simple like this, it's not so clear.  If I didn't
> have the "cpu_to_be32" part, I'd abandon the inline and the macro and code
> it directly.
In this case they will both provide the same error checking, due to
cpu_to_be32 returning type __be32. The only difference is that one adds
a macro and the other adds a function, and if we ever need to add some
caveats to the logic it will be simpler with the function. That and the
coding style dictates that all things being equal, we should still
prefer inline. Those are my only rationales in this case.
