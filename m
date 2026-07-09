Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 944C0C43458
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Jul 2026 07:25:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nKZpnGQj/Ua4IowFg+yfyy52gEMEKJC992Lw+8PS9Rk=; b=pq+WEM0fHZhL78ybGE0eJxmEXA
	uvHhr3qQzi/zrzszm5jh8YrJgzpuF6IFRglwP8Jsgbp0+3g515lmxlnMBpODnnFLVhLER7m4ZF1Kx
	mulKZ8EMH91AWNH0vvZpr0d2u6l8+PRVHiMRFKIGWKig8c9VBg0p7jB7SZvms9IEdQHrSX4VgQaLZ
	fUwTOT54APhhPLXD8TdqtrYCn/4KJ8TYmrBIDPyejyLpfSID0HREZSy6zX/4RP3ixOyLgGP8hRoLK
	MeL7CtmkaLLIR7ogQkVe7gHBjGwc52J16iTDrhXHUKM6ueDgZ6wenOtW+4tQQs0ZWXne9c2cgNsZ5
	Vjx989cQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjB2b-00000008Oea-16zS;
	Mon, 13 Jul 2026 07:25:25 +0000
Received: from mgamail.intel.com ([192.198.163.18])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1whkAy-00000001Qp6-12LY
	for linux-nvme@lists.infradead.org;
	Thu, 09 Jul 2026 08:32:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783585928; x=1815121928;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=tesK+oxJqsB49auQK1mjbbrkVhdKYiJrkTlVS/W/lOU=;
  b=aqOnfrwohYy6CTM21w0/xYpfju7bldEWmMf6w21+t4qqXOqOE4CQYOxT
   mtCUZvh/AFq8A94AwTISTwKfI9iHSYgsMIDrG/9m77Zue8ztpIJg6dcKn
   pNSeRVAnb7VHQwXVtBLt397GRbJIoky8Q5r66zJzUmii0MJGPlskUeat+
   GzJIgEZ2XiYZekzgvV14D3wbuSxw7efEmLOlPkMerDYf7xsXVcd8fMrZ6
   +Q9Uos46xhv/KA3yxY0agP5RssREnPhcVpviJQkFrG+huLVKtzhzQ+9e2
   7PVrzzCfuXm2EeRyKHcevH0SUkD8fJtyxEUo4NrJwhIiSp6cVAGNS7K+P
   g==;
X-CSE-ConnectionGUID: SUPJ8181TMCYFJWjXPNy8A==
X-CSE-MsgGUID: jkMoWTXqQie1EQhBDwGLLQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="83373180"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="83373180"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2026 01:32:07 -0700
X-CSE-ConnectionGUID: EEXzGbqiQH+fSuwG0kIRwg==
X-CSE-MsgGUID: Ubkrz2plSRGEjKFky/y1TA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="250537941"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.235])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2026 01:31:57 -0700
Date: Thu, 9 Jul 2026 11:31:55 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
	mkalderon@marvell.com, zyjzyj2000@gmail.com, sagi@grimberg.me,
	mgurtovoy@nvidia.com, haris.iqbal@ionos.com, jinpu.wang@ionos.com,
	bvanassche@acm.org, kbusch@kernel.org, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, kch@nvidia.com, smfrench@gmail.com,
	linkinjeon@kernel.org, metze@samba.org, tom@talpey.com,
	cel@kernel.org, jlayton@kernel.org, neil@brown.name,
	okorniev@redhat.com, Dai.Ngo@oracle.com, trondmy@kernel.org,
	anna@kernel.org, achender@kernel.org, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	horms@kernel.org, kees@kernel.org, michaelgur@nvidia.com,
	edwards@nvidia.com, phaddad@nvidia.com, eadavis@qq.com,
	yishaih@nvidia.com, kalesh-anakkur.purayil@broadcom.com,
	clm@meta.com, ebadger@purestorage.com, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org, target-devel@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-cifs@vger.kernel.org,
	samba-technical@lists.samba.org, linux-nfs@vger.kernel.org,
	netdev@vger.kernel.org, rds-devel@oss.oracle.com,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH v10 rdma-next] RDMA: Change capability fields in
 ib_device_attr from int to u32
Message-ID: <ak9ce4PaJ5n89zW9@ashevche-desk.local>
References: <20260709055211.2498307-1-ernis@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260709055211.2498307-1-ernis@linux.microsoft.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260709_013208_298423_6E7EE406 
X-CRM114-Status: GOOD (  15.78  )
X-Mailman-Approved-At: Mon, 13 Jul 2026 00:25:23 -0700
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, Jul 08, 2026 at 10:51:29PM -0700, Erni Sri Satya Vennela wrote:
> The capability counter fields in struct ib_device_attr are declared
> as signed int, but these values are inherently non-negative. Drivers
> maintain their cached caps as u32 and assign them directly into these
> int fields; if a cap exceeds INT_MAX the implicit narrowing yields a
> negative value visible to the IB core.
> 
> Change the signed int capability fields to u32 to match the
> underlying nature of the data. Also update consumers across the IB
> core, ULPs, NVMe-oF target, RDS, and NFS/RDMA so the new u32 values
> are not forced back through signed int or u8 via min()/min_t() or
> narrowing local variables.
> 
> The nvmet-rdma consumer of max_srq clamps it against
> ib_device.num_comp_vectors, which stays a signed int, so that site
> uses min_t() instead of min() to handle the signed/unsigned mismatch.

Assuming the functionality is left untouched, from code perspective LGTM,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

...

>  int ipoib_cm_dev_init(struct net_device *dev)
>  {
>  	struct ipoib_dev_priv *priv = ipoib_priv(dev);
> -	int max_srq_sge, i;
> +	u32 max_srq_sge;
> +	int i;
>  	u8 addr;

This can keep the reversed xmas tree ordering.

...

>  static int srq_size_set(const char *val, const struct kernel_param *kp)
>  {
> -	int n = 0, ret;
> +	unsigned int n;
> +	int ret;
>  
> -	ret = kstrtoint(val, 10, &n);
> +	ret = kstrtouint(val, 10, &n);
>  	if (ret != 0 || n < 256)
>  		return -EINVAL;

Side note (perhaps another patch?)

	ret = kstrtouint(val, 10, &n);
	if (ret)
		return ret;
	if (n < 256)
		return -ERANGE,

> -	return param_set_int(val, kp);
> +	return param_set_uint(val, kp);
>  }

...

Have you considered also replacing min_not_zero() or do some refactoring
around there?

-- 
With Best Regards,
Andy Shevchenko



