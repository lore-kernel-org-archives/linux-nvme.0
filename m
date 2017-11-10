From: keith.busch@intel.com (Keith Busch)
Date: Fri, 10 Nov 2017 14:35:43 -0700
Subject: [PATCH] NVMe: Add Quirk Delay Before CHK RDY for WDC SN200
In-Reply-To: <20171110211203.4782-1-jeff.lien@wdc.com>
References: <20171110211203.4782-1-jeff.lien@wdc.com>
Message-ID: <20171110213543.GA11328@localhost.localdomain>

On Fri, Nov 10, 2017@03:12:03PM -0600, jeffreyalien wrote:
>  #define NVME_QUIRK_DELAY_AMOUNT		2000
> +#define NVME_QUIRK_DELAY_AMOUNT_2	2300

These two delay times are close enough, let's just make it the higher of
the two so we only have one delay quirk.
