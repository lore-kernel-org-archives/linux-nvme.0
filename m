Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFD8DC43458
	for <linux-nvme@archiver.kernel.org>; Sun,  5 Jul 2026 16:11:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yRAFSJIHfKYfcoLa7p9OCuf45yo/IeXfUlLSrWg6JFA=; b=ULlBv9DND1i8YQ5QjYWq/8Rold
	3ArgCFwN3Q4k2gKLh4GsD2fz1V2/9FnZHuuHW52s02z5+cV4P8N9qaboIiAnevRKAsuN8MvpQVHwg
	PGfFe0ma6EErbZNacDF0VkoGhSgPnXz7nppwsLRFiaUulbF0yEkbg7SwBSTcguCHnYcxqkZEWAWkk
	4vIGRlHPrny0m3D2YDlUoOpFOQtFcdYdAxwJBIW69i8tHUJyyDH/vvwTauCJvErpPsf1FCfuMHQtb
	K8fLzc7cmSdrIRUtey9kwoiVdgvY9eBdTTRLbS1FCVSQcOTW1Mvqx0zArndHYUnVDh70jPArMTaIR
	mJyl0r2A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wgPRI-00000009TC0-1hGQ;
	Sun, 05 Jul 2026 16:11:28 +0000
Received: from mgamail.intel.com ([192.198.163.15])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wfDIl-00000003wQv-2XHh
	for linux-nvme@lists.infradead.org;
	Thu, 02 Jul 2026 09:01:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782982904; x=1814518904;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=gYLTkBsJEUClTNfXhPkNzHUVAl7MUmlSeasGQSngDn4=;
  b=bI50ofzIsnkBy09laXuccr4dPks4hgMjnuhMtzub+4YwYiaMdsBxXI4O
   XQwr1dfb8cURgPlG28EMG3/Hu5fK1oBqog9ccmzFZAf9TwvonTL+p0u3k
   PUKBYOqoa/Ku9TR7DJi046cM4+Ru8+y9Q/nDeUr9RH2/yIb8hveKNq1ad
   ekhI18KEGu/wVa7p4ueKg71onTQgfzpfh1m8S42PDPY3kczkZXTlnZ4jE
   fP2DNxA/m6PfjjddGje0HySVRwDVsjP4QrFC6mTJObPrykq/6Zn4rThrX
   Mb/8ukFGJhAhzH4pddXtSwzXcXrprmIf+7eU2JQ3O5iYIMC4jBgH2GPzW
   g==;
X-CSE-ConnectionGUID: VjZNOSVUTeaM6EiY0CBS5g==
X-CSE-MsgGUID: 4gK6o0cORCKIlLqPYq5gvw==
X-IronPort-AV: E=McAfee;i="6800,10657,11834"; a="83861766"
X-IronPort-AV: E=Sophos;i="6.25,143,1779174000"; 
   d="scan'208";a="83861766"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2026 01:59:42 -0700
X-CSE-ConnectionGUID: YjT0r9y3SOWMz/XZRomMBw==
X-CSE-MsgGUID: ZStAWpo+QtOOnZ714iy4cA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,143,1779174000"; 
   d="scan'208";a="257146674"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.213])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2026 01:59:33 -0700
Date: Thu, 2 Jul 2026 11:59:30 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
	mkalderon@marvell.com, zyjzyj2000@gmail.com, sagi@grimberg.me,
	mgurtovoy@nvidia.com, haris.iqbal@ionos.com, jinpu.wang@ionos.com,
	bvanassche@acm.org, kbusch@kernel.org, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, kch@nvidia.com, smfrench@gmail.com,
	linkinjeon@kernel.org, metze@samba.org, tom@talpey.com,
	trondmy@kernel.org, anna@kernel.org, chuck.lever@oracle.com,
	jlayton@kernel.org, neil@brown.name, okorniev@redhat.com,
	Dai.Ngo@oracle.com, achender@kernel.org, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	horms@kernel.org, kees@kernel.org, markzhang@nvidia.com,
	ebadger@purestorage.com, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org, target-devel@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-cifs@vger.kernel.org,
	samba-technical@lists.samba.org, linux-nfs@vger.kernel.org,
	netdev@vger.kernel.org, rds-devel@oss.oracle.com,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH rdma-next v8] RDMA: Change capability fields in
 ib_device_attr from int to u32
Message-ID: <akYocsiHWdH8Tncq@ashevche-desk.local>
References: <20260619203107.606359-1-ernis@linux.microsoft.com>
 <akX/P/0TiSQ38YdS@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <akX/P/0TiSQ38YdS@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260702_020143_656507_55B8528C 
X-CRM114-Status: GOOD (  17.25  )
X-Mailman-Approved-At: Sun, 05 Jul 2026 09:11:23 -0700
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

On Wed, Jul 01, 2026 at 11:03:43PM -0700, Erni Sri Satya Vennela wrote:
> On Fri, Jun 19, 2026 at 01:30:39PM -0700, Erni Sri Satya Vennela wrote:
> > The capability counter fields in struct ib_device_attr are declared
> > as signed int, but these values are inherently non-negative. Drivers
> > maintain their cached caps as u32 and assign them directly into these
> > int fields; if a cap exceeds INT_MAX the implicit narrowing yields a
> > negative value visible to the IB core.
> > 
> > Change the signed int capability fields to u32 to match the
> > underlying nature of the data. Also update consumers across the IB
> > core, ULPs, NVMe-oF target, RDS, and NFS/RDMA so the new u32 values
> > are not forced back through signed int or u8 via min()/min_t() or
> > narrowing local variables.
> 
> Just a friendly follow-up on this patch. The Sashiko review mentioned a
> low-priority item, and I'd appreciate any guidance on whether the change
> is needed.

As I read this it needs to be fixed, the problem is that there is
a potential of a weird case (not sure they are IRL) when somebody can use
INT_MIN (in representation of signed number) to actually mean 0x80000000
size.

> https://sashiko.dev/#/patchset/20260619203107.606359-1-ernis%40linux.microsoft.com

-- 
With Best Regards,
Andy Shevchenko



