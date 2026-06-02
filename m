Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 236FBCD6E57
	for <linux-nvme@archiver.kernel.org>; Tue,  2 Jun 2026 15:05:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=osFFDntGuMQ7DyJIj/RJ0QI5M/0VHXkI0pt9DWRkGoo=; b=whWEt2j3RjYaLiO1othEReDhrR
	DD68PWQCOOu314jXso09qUzgRXEkl/pRsK3atsPmMpCTmFS2rhli/mnroqedlmNxk8IJ/+JIfmInY
	Abv3N4fjmBlnSHoco6jpiTySYR51aeR7X15c54VU2eUIXvMjF/CMpvvmciHr8B8Gd9jhMRHQNGwR6
	0z1YppCsDS4FR/CKAv/KdUNKpHa3uJuXy25Cw1YrCH+YVI2KcFJPoTWrjYKRs4BQSHw1/rVhvcvWp
	rDg8MXgPQEFBVa1XF4U8hQ953XpothITXlNDecPHZn4FFvVaY3/s1EVwjKUCX9SLCK9kYp9QJgdmt
	EeU1ORYQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wUQgX-0000000DFRx-1gQk;
	Tue, 02 Jun 2026 15:05:41 +0000
Received: from mgamail.intel.com ([198.175.65.9])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wULK8-0000000Ce3Y-2gA4
	for linux-nvme@lists.infradead.org;
	Tue, 02 Jun 2026 09:22:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780392132; x=1811928132;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qx9Oyz913PcMyr3DRCcFWEjLHUEyxDQo5cOmQloCccg=;
  b=LbFO37gPZtpEIBpRoMN5RwwLulYWOSEGXShacFCKfeYh8ohbWJyVRpc4
   Ko7vfb+5NSUmPQmRBISimrX0RYwZzh1mM14WJRAp5r0zYkb695T8+X3vJ
   D9TzSGQRZon4CYheKURZhJ7t1W7hWctPZcSIixldtC2T3E5US1q5xmCKs
   YLoEYnl2tgBReC6kaWeG5dih+2a0iDOMHSe6vKJF4B0th19jcG8ofg/2r
   i09lY0VhR9TabnknHOG3c/oQKTbb9SLH3YS3orNfy/NRQsdqNqmmpZH+4
   G/bWSd0pFa3KFx0bAIYdOb6+qamToLv8pJ4EP/F+FfT/i14f+tCpFuC+Y
   Q==;
X-CSE-ConnectionGUID: GluCivrjSdqGEwETqQtsfA==
X-CSE-MsgGUID: THZInk48Qr2jjszoXW0MnA==
X-IronPort-AV: E=McAfee;i="6800,10657,11804"; a="103833895"
X-IronPort-AV: E=Sophos;i="6.24,183,1774335600"; 
   d="scan'208";a="103833895"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2026 02:22:11 -0700
X-CSE-ConnectionGUID: 6MlgT1ArRse4ecPJiJxjWQ==
X-CSE-MsgGUID: dpH2w+yIR4iKpkksHiG1RQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,183,1774335600"; 
   d="scan'208";a="281963145"
Received: from mkosciow-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.229])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2026 02:22:01 -0700
Date: Tue, 2 Jun 2026 12:21:58 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Erni Sri Satya Vennela <ernis@linux.microsoft.com>,
	mkalderon@marvell.com, Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>, zyjzyj2000@gmail.com,
	sagi@grimberg.me, mgurtovoy@nvidia.com, haris.iqbal@ionos.com,
	jinpu.wang@ionos.com, kbusch@kernel.org,
	Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	kch@nvidia.com, smfrench@gmail.com, linkinjeon@kernel.org,
	metze@samba.org, tom@talpey.com, chuck.lever@oracle.com,
	jlayton@kernel.org, neil@brown.name, okorniev@redhat.com,
	Dai.Ngo@oracle.com, trondmy@kernel.org, anna@kernel.org,
	achender@kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	kees@kernel.org, ebadger@purestorage.com,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
	target-devel@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-cifs@vger.kernel.org, samba-technical@lists.samba.org,
	linux-nfs@vger.kernel.org, netdev@vger.kernel.org,
	rds-devel@oss.oracle.com, Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH rdma-next v6] RDMA: Change capability fields in
 ib_device_attr from int to u32
Message-ID: <ah6gtquGDMvEXjcb@ashevche-desk.local>
References: <20260601092534.1764560-1-ernis@linux.microsoft.com>
 <5d3cac2b-4011-49c5-a142-55c85d38e90f@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5d3cac2b-4011-49c5-a142-55c85d38e90f@acm.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260602_022212_738182_3EA15D82 
X-CRM114-Status: GOOD (  11.30  )
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

On Mon, Jun 01, 2026 at 08:51:40AM -0700, Bart Van Assche wrote:
> On 6/1/26 2:25 AM, Erni Sri Satya Vennela wrote:

...

> > -	sdev->srq_size = min(srpt_srq_size, sdev->device->attrs.max_srq_wr);
> > +	sdev->srq_size = min_t(u32, srpt_srq_size, sdev->device->attrs.max_srq_wr);
> 
> min_t() shouldn't be used if there is an alternative available. For the
> SRP drivers, please make sure that both arguments of min() are unsigned
> instead of using min_t().

Ah, I just answered in similar way against v5. I also mentioned clamp() there.

-- 
With Best Regards,
Andy Shevchenko



