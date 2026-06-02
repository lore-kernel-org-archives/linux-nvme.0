Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5389CCD6E57
	for <linux-nvme@archiver.kernel.org>; Tue,  2 Jun 2026 15:05:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7gn2SCTXGYKGAdjPYnJlsXR/5r+hRDxN2u19V6XCrtQ=; b=HfFHAgOMu/FTzfy5N1vB8sMR6n
	xnGMLKdan587uXtewZDHAuq2MynVq1/zBH22MMnOfTIf/ATXHARlID2pNlTFUxRC7NwhsDdLmiMU/
	Q0oeAJhk4BRVVFeyaFK3ovVsWyosuSHg1P8r/vZ16AgCLCslz2NDbfLUi5qLU/8BDHsQlzdcS2OOh
	zf9Z1nIbL/6Ix6/WR+a4MavxtS92o4CLqFgiYTwBoqRedLDbmcTz1kJkE/GRb6/508dxUiUgPxQ7e
	9P31BRUdoUdNmRQd/upyrvaPu6+Viyv+ddMDd0F3vDwTKNPO1ooYEDEQNv8fJFb05EFENRfVL+hcB
	Vl4xDcYA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wUQgX-0000000DFRT-0nxw;
	Tue, 02 Jun 2026 15:05:41 +0000
Received: from mgamail.intel.com ([192.198.163.15])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wULIa-0000000Cdhk-273k
	for linux-nvme@lists.infradead.org;
	Tue, 02 Jun 2026 09:20:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780392036; x=1811928036;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6BQsHpGsUXg2fWEevShYArT8/T1HQSJKUOOi9RFcaco=;
  b=JOZY3BQdS3kMTkEkbHPL+PhTPdPomq/6CjVt1jCKqsn4ClRndtq0QRtl
   v95wZnSa9JrycFwlOMWdG6/m59ooG+p8+AIKL7RIzL9fpuaSYsWWRlGOT
   vbdL+LW1yKUADxRu+s5a+XkDYS5BeUiybEQRmOX48hV4mg+aGT2sBI6yV
   ALnIeGw2r+dhbWPh/oKu/i0kARWGeDbMj8O8BweP4Qrt7O88cNLXHMd2E
   uxLN3vj3yOL2llmaTyKrBxRc3RzQD/+ZrJ62tfS8kOdGk/PhA97lyFT41
   GWT+wEXeSf30SZurV1GEJCY9vTJKYjcHJyTl6eFeN7/kjetZ55vqLNQRr
   g==;
X-CSE-ConnectionGUID: 39rImW31TmyqHFQVQYFdIw==
X-CSE-MsgGUID: uqdq4JIlSq+d9Q1LcZd8Tw==
X-IronPort-AV: E=McAfee;i="6800,10657,11804"; a="81298082"
X-IronPort-AV: E=Sophos;i="6.24,183,1774335600"; 
   d="scan'208";a="81298082"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2026 02:20:35 -0700
X-CSE-ConnectionGUID: O7CD12lDRu+OSzqR/16fAw==
X-CSE-MsgGUID: LeqUzhbQREKqhxz6sCXoyA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,183,1774335600"; 
   d="scan'208";a="240848911"
Received: from mkosciow-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.229])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2026 02:20:26 -0700
Date: Tue, 2 Jun 2026 12:20:24 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
Cc: mkalderon@marvell.com, Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>, zyjzyj2000@gmail.com,
	sagi@grimberg.me, mgurtovoy@nvidia.com, haris.iqbal@ionos.com,
	jinpu.wang@ionos.com, bvanassche@acm.org, kbusch@kernel.org,
	Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	kch@nvidia.com, smfrench@gmail.com, linkinjeon@kernel.org,
	metze@samba.org, tom@talpey.com, trondmy@kernel.org,
	anna@kernel.org, chuck.lever@oracle.com, jlayton@kernel.org,
	neil@brown.name, okorniev@redhat.com, Dai.Ngo@oracle.com,
	achender@kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	kees@kernel.org, ebadger@purestorage.com,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
	target-devel@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-cifs@vger.kernel.org, samba-technical@lists.samba.org,
	linux-nfs@vger.kernel.org, netdev@vger.kernel.org,
	rds-devel@oss.oracle.com, Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH net-next v5] RDMA: Change capability fields in
 ib_device_attr from int to u32
Message-ID: <ah6gWPQP56RO6_ho@ashevche-desk.local>
References: <20260601091505.1763912-1-ernis@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260601091505.1763912-1-ernis@linux.microsoft.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260602_022036_628005_10FF328E 
X-CRM114-Status: GOOD (  11.59  )
X-Mailman-Approved-At: Tue, 02 Jun 2026 08:05:36 -0700
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

On Mon, Jun 01, 2026 at 02:14:44AM -0700, Erni Sri Satya Vennela wrote:
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

...

>  	attr->max_qp_rd_atom =
> -	    min(1 << (fls(qattr->max_qp_resp_rd_atomic_resc) - 1),
> -		attr->max_qp_init_rd_atom);
> +	    min_t(u32, 1 << (fls(qattr->max_qp_resp_rd_atomic_resc) - 1),
> +		  attr->max_qp_init_rd_atom);

Just no. min_t() usage has to be very well justified. It's a beast which may
stub one in the back. As Linus said in most of the cases one wants clamp()
rather than min().

Please, redo this and similar pieces.

-- 
With Best Regards,
Andy Shevchenko



