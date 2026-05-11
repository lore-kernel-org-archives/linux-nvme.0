Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 990B9CD37AC
	for <linux-nvme@archiver.kernel.org>; Mon, 11 May 2026 08:12:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=O5mv3wxSmcu9/XvpNLkxjHiTCawlrw76HVk1JviWL+Y=; b=qaF1tiMDM0qU1bydSc2aj7nvLK
	JiVz8+SkrthZoMudeMOeWC3bdoQU3Yilt7/voDbeaEpavj4XZW34D8AssUpnAv6FCjHJLC1wJRfA+
	DoOdprdQeiw0hzWREJL/q8SPbaVZssGgEePqChu8AvDihfebasI44zEzUzfK1GLYZ1Fd8ZuYHrke4
	5qin0TGu7VDWNKMlii8TU8EO7Xns+ICAoe6UFcq8ffR9ZUdMy+gFgWKaadaVkDPDlLmJ7OdcTBlGp
	dDfxXNUV6QRC8vJtYr/R/1/25k3ZugitGKuvMzvPcMyeQwTHAebWlHY7aOVVtcSKcrApzby/mI95X
	momrnYhQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMLkN-0000000CikV-459k;
	Mon, 11 May 2026 08:12:16 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMLkL-0000000CijH-49oS
	for linux-nvme@lists.infradead.org;
	Mon, 11 May 2026 08:12:15 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 89B1068BEB; Mon, 11 May 2026 10:12:11 +0200 (CEST)
Date: Mon, 11 May 2026 10:12:11 +0200
From: Christoph Hellwig <hch@lst.de>
To: Maurizio Lombardi <mlombard@redhat.com>
Cc: kbusch@kernel.org, mheyne@amazon.de, emilne@redhat.com,
	jmeneghi@redhat.com, linux-nvme@lists.infradead.org,
	dwagner@suse.de, mlombard@arkamax.eu, mkhalfella@purestorage.com,
	chaitanyak@nvidia.com, hare@kernel.org, hch@lst.de
Subject: Re: [PATCH V4 8/9] nvmet-loop: do not alloc admin tag set during
 reset
Message-ID: <20260511081211.GA30362@lst.de>
References: <20260508133335.98612-1-mlombard@redhat.com> <20260508133335.98612-9-mlombard@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260508133335.98612-9-mlombard@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260511_011214_200520_6A2306CF 
X-CRM114-Status: UNSURE (   8.64  )
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

(I still wish we could consolidate some of the alloc/reset flow a little
more instead of having to do this in every driver)


