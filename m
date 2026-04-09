Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4485E98FB5
	for <linux-nvme@archiver.kernel.org>; Thu,  9 Apr 2026 06:11:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=URRgUVJlTWx/CKziBdRiPf0dFdvo3BNwgSk1S+U6O3o=; b=4mY12WXLmoDC5T8Xo+NU/DE1b+
	knxggIWCulNN378FDsa8DwJIHxT0OFFdjOc2vTEcXM0LKATE/fI1KsxV6zhI88YdIppLxV449Ucen
	j+t38t3jTmKTkhkh1rsPg5MBRRK2bCxhG9UwCKK0G+v3apt1ZCOqvDpK8wAHB08n1nwEXVfLDAYoF
	nZAqRCldpmwy2x3uX1k0GbCXZENJxjrzwKsaa3cYCMqoK+ACM1xGcH3zXKItx28mF9CULVuwmHRQF
	C+CmdTj2nbDgw8T4rF0Sbo45GvzTMsiWqc/iGaHCGmopzebKRHXGdot3RYnfcnF25ENFUR4xMNUL6
	GCvIKMmQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wAicM-00000009kre-1BkA;
	Thu, 09 Apr 2026 06:11:54 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wAicH-00000009kqG-3mpt
	for linux-nvme@lists.infradead.org;
	Thu, 09 Apr 2026 06:11:51 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 2811C68CFE; Thu,  9 Apr 2026 08:11:47 +0200 (CEST)
Date: Thu, 9 Apr 2026 08:11:46 +0200
From: Christoph Hellwig <hch@lst.de>
To: John Garry <john.g.garry@oracle.com>
Cc: hch@lst.de, kbusch@kernel.org, sagi@grimberg.me, axboe@fb.com,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme-multipath: drop head pointer check in
 nvme_mpath_clear_current_path()
Message-ID: <20260409061146.GA6514@lst.de>
References: <20260408080357.3072749-1-john.g.garry@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260408080357.3072749-1-john.g.garry@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260408_231150_149502_4A1FB6A0 
X-CRM114-Status: GOOD (  11.76  )
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

On Wed, Apr 08, 2026 at 08:03:57AM +0000, John Garry wrote:
> A NS will always have a head pointer, so drop the check. As proof in
> practice, all the nvme_mpath_clear_current_path() callers also
> dereference ns->head.
> 
> This check has endured since the original changes to support multipath.

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


