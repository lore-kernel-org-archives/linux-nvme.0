From: bvanassche@acm.org (Bart Van Assche)
Date: Fri, 14 Jun 2019 16:56:28 -0700
Subject: [PATCH v2 2/3] nvmet: Export NVMe namespace attributes
In-Reply-To: <BYAPR04MB57499B4C1225252183F01ADC86EE0@BYAPR04MB5749.namprd04.prod.outlook.com>
References: <20190610210612.103952-1-bvanassche@acm.org>
 <20190610210612.103952-3-bvanassche@acm.org>
 <BYAPR04MB5749D68053F5CAF2456E17FC86EE0@BYAPR04MB5749.namprd04.prod.outlook.com>
 <4a104091-5ef2-ee3b-9653-cbb816b39a2e@acm.org>
 <BYAPR04MB57499B4C1225252183F01ADC86EE0@BYAPR04MB5749.namprd04.prod.outlook.com>
Message-ID: <d69d61df-c03e-e0db-e9dd-fd367e5a0958@acm.org>

On 6/14/19 10:18 AM, Chaitanya Kulkarni wrote:
> Sorry for not being clear, what I meant is uintXXX_t vs uXX. e.g.
> instead of uint16_t ->u16, uint32_t ->u32. My comment refereed to the
> consistency of the data type and not changing the size of the variable.

Hi Chaitanya,

I think the rule is that uint32_t etc. must be used in uapi header 
files. I'm not sure whether there is a strict rule for other kernel code 
than uapi header files. But since the NVMe code uses u32 etc., I will 
make this patch consistent with the rest of the NVMe code.

Bart.
