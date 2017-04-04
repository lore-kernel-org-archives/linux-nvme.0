From: sagi@grimberg.me (Sagi Grimberg)
Date: Tue, 4 Apr 2017 13:42:57 +0300
Subject: [RFC 2/8] cxgb4: setup pcie memory window 4 and create p2pmem
 region
In-Reply-To: <1490911959-5146-3-git-send-email-logang@deltatee.com>
References: <1490911959-5146-1-git-send-email-logang@deltatee.com>
 <1490911959-5146-3-git-send-email-logang@deltatee.com>
Message-ID: <f269d9e1-8dcf-7970-382e-cb0d9a020efc@grimberg.me>


> +static void setup_memwin_p2pmem(struct adapter *adap)
> +{
> +	unsigned int mem_base = t4_read_reg(adap, CIM_EXTMEM2_BASE_ADDR_A);
> +	unsigned int mem_size = t4_read_reg(adap, CIM_EXTMEM2_ADDR_SIZE_A);
> +
> +	if (!use_p2pmem)
> +		return;

This is weird, why even call this if !use_p2pmem?

> +static int init_p2pmem(struct adapter *adapter)
> +{
> +	unsigned int mem_size = t4_read_reg(adapter, CIM_EXTMEM2_ADDR_SIZE_A);
> +	struct p2pmem_dev *p;
> +	int rc;
> +	struct resource res;
> +
> +	if (!mem_size || !use_p2pmem)
> +		return 0;

Again, weird...
