Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA053FED3CC
	for <linux-nvme@archiver.kernel.org>; Fri, 24 Apr 2026 13:41:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=xGeJsRGGQszDlN3kuL/qLkESpL
	Fqv3fV/yLoceMef9AiGDtn+p31K2JpR/a+zu0maGs7QGGQeGkZBkXdeK0sGtry6XMLObjY1F8iYuk
	wdyLdARUnbRRaLtMj8I0oY9ed9jizE31ZdsCQK7YGG87yD+TduGCe8aahqLFKomFNMMvABN73EWcG
	GUVIdlGFydmxNFjASrfptiNGUlQ6XDfBomuiUmzzmg/iLeizIehExDaZy0JQbNOC7L0FY3kwghjQt
	g2+G6gU9z7m2lp+veSySxeguguLW3CNig3PUynhV+mPnpw4Liqof8mahPDNCYI8PkpZ6TWYlmmFU2
	cvsgNRhw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wGGmH-0000000DGEp-1Czi;
	Fri, 24 Apr 2026 13:41:05 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wGGmE-0000000DGEF-4BFK
	for linux-nvme@lists.infradead.org;
	Fri, 24 Apr 2026 13:41:04 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id E8E8E68C4E; Fri, 24 Apr 2026 15:40:59 +0200 (CEST)
Date: Fri, 24 Apr 2026 15:40:59 +0200
From: Christoph Hellwig <hch@lst.de>
To: Maurizio Lombardi <mlombard@redhat.com>
Cc: kbusch@kernel.org, mheyne@amazon.de, emilne@redhat.com,
	jmeneghi@redhat.com, linux-nvme@lists.infradead.org,
	dwagner@suse.de, mlombard@arkamax.eu, mkhalfella@purestorage.com,
	chaitanyak@nvidia.com, hare@kernel.org, hch@lst.de
Subject: Re: [PATCH V3 8/8] nvme-core: warn on allocating admin tag set
 with existing queue
Message-ID: <20260424134059.GC16434@lst.de>
References: <20260410073924.61078-1-mlombard@redhat.com> <20260410073924.61078-9-mlombard@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260410073924.61078-9-mlombard@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260424_064103_173211_F2401F68 
X-CRM114-Status: UNSURE (   7.39  )
X-CRM114-Notice: Please train this message.
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

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


