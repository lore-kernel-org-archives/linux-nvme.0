Return-Path: <SRS0=S+bv=NP=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 373EAC432BE
	for <linux-nvme@archiver.kernel.org>; Tue, 24 Aug 2021 14:05:50 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F0D9D6124B
	for <linux-nvme@archiver.kernel.org>; Tue, 24 Aug 2021 14:05:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org F0D9D6124B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=9+as3n3zEi1Fy6eeLKdrloQTMUqCDD1trVKzj4+YK1E=; b=JzXUh3+PRZewT4
	WV/cjgg4XAW5AbhuuBX3knmUBSrisvBr5uXGoe7gqzDuM44e60Q1BCvaeaRM3QrMvpQC5HsTKrJ1X
	xVG3xbDfDHZy/qoffKVOtXHEgmuEr+ng/NFRsRKmUAWrE+txKi/pcCvPtffMO2dvx89i1hlzZio3n
	Qyf2OTWyPRa7wmkAsA0KiEGxMJzlmlB/xRWcnGXv5ZaYXu2LDxgK0wR3NsNCRJVEb3mP7c5/rQbP7
	i+4Aur2I1Ny8zxkbqeB4XPBGWyrcsasfw4ehAzjRF2c0oJekY/qFkReJDebTZFNDk7wH6EjhWONfQ
	9S7ahc0cOL/5UMxTb25A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mIX3X-003Px9-9E; Tue, 24 Aug 2021 14:05:35 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mIX2k-003PLE-VB
 for linux-nvme@bombadil.infradead.org; Tue, 24 Aug 2021 14:04:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=Z5ZhwVX2hcxbnxUcTQcxvFWV7vbWD52vHQ50IYDMAbo=; b=scErgCctxKhX0mDZl1c/UqjgxF
 SbVD70nuog5HtV0ObBDyjeyKhDLSft+/DQrtJy3FIrgqewrQoq4CjihyvE/vPVXJxX2YTZwzJjg/R
 +x7FqKsJItPnJLXFQOfl/ObLyGITa6uW6sugtpUFkjrpS/LZoIeTtse+mxq4KuGs1Sx+ut7ODKTqK
 X4l7K4Wtc4bCer/Sl37QjALe6M3VQEtc6DEbPU99MRzhIpRiGxKaqswOrVl9pTQjR0Kd8DvFZYum0
 BRCOtAIxDWRyR8htxrKhvvW56fnrPgpOZeQiVoJyWQUWDzoZZswOsCcCeI6Yh4LRLWnF4wtve2Brm
 ozKhvRTQ==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat
 Linux)) id 1mIWyH-00B8M4-Qh; Tue, 24 Aug 2021 14:00:37 +0000
Date: Tue, 24 Aug 2021 15:00:09 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Daniel Wagner <dwagner@suse.de>
Cc: Christoph Hellwig <hch@infradead.org>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org, Hannes Reinecke <hare@suse.de>,
 Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH v3] nvme: revalidate paths during rescan
Message-ID: <YST7adHFG0XLlPVG@infradead.org>
References: <20210811152803.30017-1-dwagner@suse.de>
 <93e8d113-55bb-e859-bf3d-54433dd23683@grimberg.me>
 <20210824134457.x33n7ihoe23jhyfx@carbon.lan>
 <20210824134830.gdl4vojwhlsoypne@carbon.lan>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210824134830.gdl4vojwhlsoypne@carbon.lan>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, Aug 24, 2021 at 03:48:30PM +0200, Daniel Wagner wrote:
> I am blind. The patch is queued up in nvme-5.15.
> 
> @Christoph, do you want me to send fix on top of this patch or do you
> want an updated version of this patch?

Either way is fine.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
