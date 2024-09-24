Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3DEBCF9C71
	for <linux-nvme@archiver.kernel.org>; Tue, 24 Sep 2024 09:32:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5m4RQ4VNBFMhAoRV2E/TBCUs2t7JhJdQ63Itw1dMMK4=; b=dInKs1g6IAtQl7smk2lCgfLdIJ
	+HiVR35yBH9H+Av4saJ7dJoyfe2oIy9+hlS146+UD1QVcq6eb3wvME2EMnO6AVfPEpSAHYPQZZjar
	xBG0ptH8oM+9W+2dk+7/3CZs5NmWFmM08rd6MkSErLsCMxOyWnPSq/Ns0ZPOF2tmMkfepmp1cMUcl
	EUongGBPni4DTNpE/Oywu+T99yNCK4fOSHnP5TLz3ewpZmtDoOm4ZbBT59Zha+4Tqpnk7zJ9za/Uh
	W0yBR6teG1nARyWjAXRyUj7nFgAc/PgXM3xwa7QqYgMI2pvQ19/Z6NZ83cKW37+s2oaMPdFb4koOk
	fxXAQNoA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1st1uN-00000001oeN-2fgf;
	Tue, 24 Sep 2024 09:32:35 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1st1qa-00000001nbN-142m
	for linux-nvme@lists.infradead.org;
	Tue, 24 Sep 2024 09:28:41 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id EE8A1227A8E; Tue, 24 Sep 2024 11:28:32 +0200 (CEST)
Date: Tue, 24 Sep 2024 11:28:32 +0200
From: Christoph Hellwig <hch@lst.de>
To: Kanchan Joshi <joshi.k@samsung.com>
Cc: Christoph Hellwig <hch@lst.de>, axboe@kernel.dk, kbusch@kernel.org,
	sagi@grimberg.me, martin.petersen@oracle.com,
	James.Bottomley@HansenPartnership.com, brauner@kernel.org,
	viro@zeniv.linux.org.uk, jack@suse.cz, jaegeuk@kernel.org,
	jlayton@kernel.org, chuck.lever@oracle.com, bvanassche@acm.org,
	linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net, linux-block@vger.kernel.org,
	linux-scsi@vger.kernel.org, gost.dev@samsung.com,
	vishak.g@samsung.com, javier.gonz@samsung.com,
	Nitesh Shetty <nj.shetty@samsung.com>
Subject: Re: [PATCH v5 4/5] sd: limit to use write life hints
Message-ID: <20240924092832.GA26208@lst.de>
References: <20240912130235.GB28535@lst.de> <e6ae5391-ae84-bae4-78ea-4983d04af69f@samsung.com> <20240913080659.GA30525@lst.de> <4a39215a-1b0e-3832-93bd-61e422705f8b@samsung.com> <20240917062007.GA4170@lst.de> <b438dddd-f940-dd2b-2a6c-a2dbbc4ee67f@samsung.com> <20240918064258.GA32627@lst.de> <197b2c1a-66d2-5f5a-c258-7e2f35eff8e4@samsung.com> <20240918120159.GA20658@lst.de> <edcbf69e-9ae9-06df-60c0-47393371fcd8@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <edcbf69e-9ae9-06df-60c0-47393371fcd8@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240924_022840_452786_5AEFBA9F 
X-CRM114-Status: GOOD (  16.37  )
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

On Tue, Sep 24, 2024 at 02:54:51PM +0530, Kanchan Joshi wrote:
> FS managed/created hints is a different topic altogether,
> and honestly 
> that is not the scope of this series. That needs to be thought at per-FS 
> level due to different data/meta layouts.

No, it is not.  If you design an API where hints bypass the file
system you fundamentally do the wrong thing when there is a file
system.  No one is asking to actually implement file system
support in this series, but we need to consider the fundamental
problem in the API design.

And yes, the actual implementation will be highly dependent on the
file system.

> This scope of this series is to enable application-managed hints passing 
> through the file system. FS only needs to pass what it receives.

Which fundamentally can't work for even a semi-intelligent file system.


