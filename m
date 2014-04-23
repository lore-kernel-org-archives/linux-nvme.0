From: willy@linux.intel.com (Matthew Wilcox)
Date: Wed, 23 Apr 2014 11:13:04 -0400
Subject: [PATCH] NVMe: Update namespace and controller identity
 structures as per 1.1a spec
In-Reply-To: <1397942397-29998-1-git-send-email-dimitri.ledkov@canonical.com>
References: <1397942397-29998-1-git-send-email-dimitri.ledkov@canonical.com>
Message-ID: <20140423151304.GF13050@linux.intel.com>

On Sat, Apr 19, 2014@10:19:57PM +0100, Dimitri John Ledkov wrote:
> Controller: add CNTLID, AVSCC, APSTA, NVSCC, ACWU, SGLS fields.
> 
> Namespace: add NMIC, RESCAP, EUI64 fields. EUI64 is specifically
> interesting, since it can be used to construct an UEFI NVMe device
> path for a boot entry.
> 
> As per NVM Express 1.1a spec:
> http://www.nvmexpress.org/wp-content/uploads/NVM-Express-1_1a.pdf

Thanks for the patch!

> -	__u8			rsvd78[178];
> +	__le16			cntlid;
> +	__u8			rsvd80[176];

I don't think cntlid is a little-endian value.  I think it's a cookie,
so this should be __u16.

> -	__u8			rsvd30[98];
> +	__u8			nmic;
> +	__u8			rescap;
> +	__u8			rsvd32[88];
> +	__le64			eui64;

eui64 isn't treated as a 64-bit value elsewhere in the kernel, rather as
an array of bytes.  So I think this one should be:

	__u8			eui64[8];

That matches the IEEE's recommendations:

An EUI-64 is a string of eight octets, labeled as eui[0] through eui[7].

(see http://standards.ieee.org/develop/regauth/tut/eui64.pdf)
