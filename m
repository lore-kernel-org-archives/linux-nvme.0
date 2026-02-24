Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20177F3C984
	for <linux-nvme@archiver.kernel.org>; Tue, 24 Feb 2026 14:39:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XCX3zLvOgX3LVI4GIkEI40Z+dwRBRhetwlg/96odtQo=; b=eHYRsCt2SIWbdC4izckNyRCPvl
	Z0yuaSr8KSOIJ8zjRFd+Jb76bpHDW/3xOJ12bb+2159EOPDDn4hVgcnImOVDOA/aGt/dlUT0qDHkb
	1G+skOaz7XYfakTdRxR8Lh66fXQFtEPah+5JJ3iydfScnchhLHXeF12fQGMUaIHeeHewrH5DVQyhI
	I5hgNaDbrlsbkrt0pE34s4t2VDEGTuB0/ysBIeCrW5td4rzzOycjU3Aa6TYWkOWNARHaoubWcLclJ
	FGHx9uizhBueFQrkswCLA1bLz7ue7eo+a3Y8amk+sdL2d4LZ+8+GQD+N4ikAVlF5mUqjfBhBQEwZ2
	GOKiZc2Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vutZa-00000002FOX-2KUJ;
	Tue, 24 Feb 2026 14:39:38 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vutZY-00000002FNB-1rOX
	for linux-nvme@lists.infradead.org;
	Tue, 24 Feb 2026 14:39:37 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 79F6E68D07; Tue, 24 Feb 2026 15:39:33 +0100 (CET)
Date: Tue, 24 Feb 2026 15:39:33 +0100
From: Christoph Hellwig <hch@lst.de>
To: Maurizio Lombardi <mlombard@redhat.com>
Cc: kbusch@kernel.org, hch@lst.de, hare@suse.de, chaitanyak@nvidia.com,
	bvanassche@acm.org, linux-scsi@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	James.Bottomley@HansenPartnership.com, mlombard@arkamax.eu,
	jmeneghi@redhat.com, emilne@redhat.com, bgurney@redhat.com
Subject: Re: [PATCH V2 3/3] scsi: Convert async scanning to use the
 completion chain helper
Message-ID: <20260224143933.GC12308@lst.de>
References: <20260224122505.52401-1-mlombard@redhat.com> <20260224122505.52401-4-mlombard@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260224122505.52401-4-mlombard@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260224_063936_622908_280A9BE9 
X-CRM114-Status: GOOD (  13.20  )
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

On Tue, Feb 24, 2026 at 01:25:05PM +0100, Maurizio Lombardi wrote:
> diff --git a/drivers/scsi/scsi_priv.h b/drivers/scsi/scsi_priv.h
> index 7a193cc04e5b..d8a157bc9078 100644
> --- a/drivers/scsi/scsi_priv.h
> +++ b/drivers/scsi/scsi_priv.h
> @@ -132,7 +132,7 @@ extern void scsi_exit_procfs(void);
>  
>  /* scsi_scan.c */
>  void scsi_enable_async_suspend(struct device *dev);
> -extern int scsi_complete_async_scans(void);
> +extern void scsi_complete_async_scans(void);

No need for the extern here.

> +DEFINE_COMPL_CHAIN(scanning_hosts);

This looks like it should be marked static.


