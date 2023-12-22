Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A210DC41535
	for <linux-nvme@archiver.kernel.org>; Fri, 22 Dec 2023 05:37:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Ehc4XtP4Bj0BvCjkQ22XyePVUvM6sFI9MypjiGFf6p4=; b=ojZYDKEItx6Wm0Po7EYM1YQB92
	VdC3H9jGkA5j9wywKKE45ko6cuhYmh2R/tFIruPffZKDj9MEPk4Jp2K0WxGo/PJdzHR7LosJglSFb
	yRbuwPVpwJrGPD1V9QqY79b9MvFd/aM5p7JRwLOZ1C4JTQngHFJYA0NmOh7Dd4QK2qQ9Wy/XwWXpG
	5vsfXTyi+xFsnmsO/rb9WzzgPJf8cQBtQWs/JOq4n0gIdRk5GAxCwVjMFr0vQvoSqWB6gJZks1uBj
	Q3BIzQabdp+0+ATsUFJZJZ9q9v0XO4l4/zluOtWIA8yBItI4lppRkrXR7JRFi/zFvjqb60LD+nxEQ
	NzrpjkTA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rGYE9-0050FQ-0L;
	Fri, 22 Dec 2023 05:37:41 +0000
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rGYE7-0050F9-2x;
	Fri, 22 Dec 2023 05:37:39 +0000
Date: Thu, 21 Dec 2023 21:37:39 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: Bart Van Assche <bvanassche@acm.org>, Hannes Reinecke <hare@suse.de>,
	lsf-pc@lists.linuxfoundation.org, linux-mm@kvack.org,
	linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [LSF/MM/BPF TOPIC] Large block for I/O
Message-ID: <ZYUgo0a51nCgjLNZ@infradead.org>
References: <7970ad75-ca6a-34b9-43ea-c6f67fe6eae6@iogearbox.net>
 <4343d07b-b1b2-d43b-c201-a48e89145e5c@iogearbox.net>
 <03ebbc5f-2ff5-4f3c-8c5b-544413c55257@suse.de>
 <5c356222-fe9e-41b0-b7fe-218fbcde4573@acm.org>
 <ZYUbB3brQ0K3rP97@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZYUbB3brQ0K3rP97@casper.infradead.org>
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

On Fri, Dec 22, 2023 at 05:13:43AM +0000, Matthew Wilcox wrote:
> It clearly solves a problem (and the one I think it's solving is the
> size of the FTL map).  But I can't see why we should stop working on it,
> just because not all drive manufacturers want to support it.

I don't think it is drive vendors.  It is is the SSD divisions which
all pretty much love it (for certain use cases) vs the UFS/eMMC
divisions which tends to often be fearful and less knowledgeable (to
say it nicely) no matter what vendor you're talking to.


