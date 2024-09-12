Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D844CEED609
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Sep 2024 14:01:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pX/01c0Yoa9HfJRu/CnrO5GFbDkJs+9Nfn7vHKZ/1uk=; b=ls6AVMgKedSbBKOZ3wyPtsTKA8
	ej9w253rUgy/rqxuTClgxdsT3e06INVq+Quq8Iv1vZMEPYdGcX6nJ/6WBC/e3JptwO2XFIyhBmF4f
	qEwFGrBrRb2Twnb9UVxzvX2oEvsV/rffbRvOSMVTEMaPepFvy0Uk4kTAR4h3O7/VDEdgFQZMpGZfW
	PBFasnu1JB8Rup0kV3/xDv9/VEznA5BIXmm627AHhUBEL7mFxmXrl0p2/aVfLc0AK6w8lLbq2QJUx
	j/B84UMELQ1ClAPuOgs99GCilfxM0gQEKVluzGCW4sqvZfEyIs1+23ABiTnjGd3MX3NRJ5lc0pleE
	NWsqAeSw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sokNW-0000000DHWq-2U37;
	Thu, 12 Sep 2024 14:00:58 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sojLN-0000000D6tR-26XR
	for linux-nvme@lists.infradead.org;
	Thu, 12 Sep 2024 12:54:50 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id B2EFE227AB5; Thu, 12 Sep 2024 14:54:38 +0200 (CEST)
Date: Thu, 12 Sep 2024 14:54:38 +0200
From: Christoph Hellwig <hch@lst.de>
To: Kanchan Joshi <joshi.k@samsung.com>
Cc: axboe@kernel.dk, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
	martin.petersen@oracle.com, James.Bottomley@HansenPartnership.com,
	brauner@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz,
	jaegeuk@kernel.org, jlayton@kernel.org, chuck.lever@oracle.com,
	bvanassche@acm.org, linux-nvme@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net, linux-block@vger.kernel.org,
	linux-scsi@vger.kernel.org, gost.dev@samsung.com,
	vishak.g@samsung.com, javier.gonz@samsung.com
Subject: Re: [PATCH v5 2/5] fcntl: rename rw_hint_* to rw_lifetime_hint_*
Message-ID: <20240912125438.GB28068@lst.de>
References: <20240910150200.6589-1-joshi.k@samsung.com> <CGME20240910151048epcas5p3c610d63022362ec5fcc6fc362ad2fb9f@epcas5p3.samsung.com> <20240910150200.6589-3-joshi.k@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240910150200.6589-3-joshi.k@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240912_055441_752934_92C874DC 
X-CRM114-Status: GOOD (  13.16  )
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

On Tue, Sep 10, 2024 at 08:31:57PM +0530, Kanchan Joshi wrote:
> F_GET/SET_RW_HINT fcntl handlers query/set write life hints.
> Rename the handlers/helpers to be explicit that write life hints are
> being handled.
> 
> This is in preparation to introduce a new interface that supports more
> than one type of write hint.

Wouldn't it make more sense to stick with the name as exposed in the
uapi?  The same minda applies to the previous patch - in fact IFF we
decide to do the rename I'd probably expect both parts to go together.


