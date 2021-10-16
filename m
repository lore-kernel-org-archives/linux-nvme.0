Return-Path: <SRS0=EQPQ=PE=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A81F0C433EF
	for <linux-nvme@archiver.kernel.org>; Sat, 16 Oct 2021 04:42:58 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F59060F9D
	for <linux-nvme@archiver.kernel.org>; Sat, 16 Oct 2021 04:42:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5F59060F9D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0YHLZvLC/xYlfH0XYhEFmgV1nKxhlxOO7Z/IK6ZmpAI=; b=SAorc57ibIGyfnn6qPhm1Kwb5W
	BOpn8R5o8GSbrL6oPB5qvWU79qlksvn2xps3kkntZejIDexHdidKE7WlcTsuS3neArU0RJKiBJA1I
	qQLqirrrb4SIWMizggDZHXVUxcjkPPBEEBBjoB8FUoDMSR8OLAyD3lJVjBQm+/XAihDnjS/vVfWgo
	Z0ST1Vkn8qvCGEZIS/NdKXn0TrnRcCWZO/cFI+rcaQjvcmC8z6gosinkkf+FQrmNmK8PxhNDOACFv
	gY8S82Y4huv7yasFoh0+gitozfWPNrSnsa7ZzdFCH6h1VhmsiYvHV+jW6F3mayZFzyrF6u4STfvBp
	DhpYgq6w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mbbX5-009kYw-Th; Sat, 16 Oct 2021 04:42:55 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mbbX3-009kYT-E9
 for linux-nvme@lists.infradead.org; Sat, 16 Oct 2021 04:42:54 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 0DE0A68BFE; Sat, 16 Oct 2021 06:42:51 +0200 (CEST)
Date: Sat, 16 Oct 2021 06:42:50 +0200
From: Christoph Hellwig <hch@lst.de>
To: Maurizio Lombardi <mlombard@redhat.com>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me,
 hare@suse.de, chaitanya.kulkarni@wdc.com, jmeneghi@redhat.com
Subject: Re: [PATCH] nvmet-tcp: fix a memory leak when releasing a queue
Message-ID: <20211016044250.GA27435@lst.de>
References: <20211015082634.555494-1-mlombard@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211015082634.555494-1-mlombard@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211015_214253_648100_A8F6D563 
X-CRM114-Status: UNSURE (   7.40  )
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

Thanks,

applied to nvme-5.15.

