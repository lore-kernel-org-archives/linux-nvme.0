From: james.smart@broadcom.com (James Smart)
Date: Tue, 18 Oct 2016 10:59:43 -0700
Subject: [PATCH 3/7 v2] nvme-fabrics: Add FC transport FC-NVME definitions
In-Reply-To: <20161012085834.GD12972@infradead.org>
References: <57f82b10.h/qKXTOsgeHQsdmh%james.smart@broadcom.com>
 <20161012085834.GD12972@infradead.org>
Message-ID: <1f0b3b42-241a-65db-f842-08a1c378b559@broadcom.com>



On 10/12/2016 1:58 AM, Christoph Hellwig wrote:
>
>> +/* fills in length of a descriptor. Struture minus descriptor header */
>> +#define FCNVME_LSDESC_LEN(lsdesc) \
>> +		cpu_to_be32(sizeof(lsdesc) - (2*(sizeof(u32))))
> Make this an inline function and use spaces between the operators,
> please.
>

Christoph,

This can't be an inline - the "lsdesc" field is a type declaration 
("struct x") and varies. That's the purpose of the define: so it can be 
applied to different structures- e.g. FCNVME_LSDESC_LEN(struct foo) and 
FCNVME_LSDESC_LEN(struct bar)

I'll adjust for the spacing, but will leave as a define.

-- james
