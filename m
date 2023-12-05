Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3DA9C10F05
	for <linux-nvme@archiver.kernel.org>; Tue,  5 Dec 2023 04:40:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uMCXbORpjMbrd4ngCy+I+8n3Uap43ihrr+0dBH0/4Tg=; b=wdztwt2c8UbnxH+O7yqodyxFj0
	7LycWc/xtmJw2ucR/nljWXsfNUlmjnlWfsAtUoDNOocaCkf2SY95728GrVIwvLpK7tfTuN6liVsRe
	bpogAZWTqs41jch/dfVVxQtKHgGo8W5Tr1xtYtm3l7tQKOuDEk96bqQY1JU8/5/IlBMdLBb4SGAE7
	uKKarL0ExhTeanOUIJJeM3Axv89ae+1pP1c8R2wDDrJRzuojE7rCX7H2jwWy2WTr4S3ciix5Qx50I
	du8AGlMTWPIej/hKa2+5FaQdrD//Kb0+TMOSAhY91XbnLTljPdIv4REGZQe7yRhiKx6R43rNdB58E
	6/C8r0ZA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rANEl-006FBj-00;
	Tue, 05 Dec 2023 04:40:47 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rANEi-006FAf-1T
	for linux-nvme@lists.infradead.org;
	Tue, 05 Dec 2023 04:40:46 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id EC780227A8E; Tue,  5 Dec 2023 05:40:35 +0100 (CET)
Date: Tue, 5 Dec 2023 05:40:35 +0100
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Jirong Feng <jirong.feng@easystack.cn>, Jens Axboe <axboe@fb.com>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org, peng.xiao@easystack.cn
Subject: Re: Should NVME_SC_INVALID_NS be translated to BLK_STS_IOERR
 instead of BLK_STS_NOTSUPP so that multipath(both native and dm)
 can failover on the failure?
Message-ID: <20231205044035.GA28685@lst.de>
References: <9b1589fb-6f47-40bb-8aa6-22ae61145de4@easystack.cn> <ZW6pJAm9wgqj1HEW@kbusch-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZW6pJAm9wgqj1HEW@kbusch-mbp>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231204_204044_658225_29E46D15 
X-CRM114-Status: GOOD (  14.01  )
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

On Mon, Dec 04, 2023 at 09:37:56PM -0700, Keith Busch wrote:
> So the controller through that path used to be able to access the
> Namespace, then suddenly lost ability to do so, but some other path can
> still access it if we retry on a failover/alternate path? I think your
> target is returning the wrong error code. It should be SCT/SC 303h,
> Asymmetric Access Persistent Loss (NVME_SC_ANA_TRANSITION), for what
> you're describing.

Yes, assuming ANA is actually supported by the controllers..

