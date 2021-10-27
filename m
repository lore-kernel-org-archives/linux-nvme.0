Return-Path: <SRS0=8pqL=PP=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E092FC433F5
	for <linux-nvme@archiver.kernel.org>; Wed, 27 Oct 2021 05:58:46 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 80E3760FBF
	for <linux-nvme@archiver.kernel.org>; Wed, 27 Oct 2021 05:58:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 80E3760FBF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0YHLZvLC/xYlfH0XYhEFmgV1nKxhlxOO7Z/IK6ZmpAI=; b=CUjvXoBzmwU0JvHnoBsGLX7ViA
	94Cpo0axNayK/CStvNofEZpa3IT1G1VVbhclB6x53UvI3JmVjkQKWL9g+0d31fti/n8uugTRQtnbi
	OmFQAUcBL7dnwhuecxW+pAXtX/d/ThH8JHJTFOBiSd6FUDgVq1LJJU8rf2qspHER/Z5Za1nKjP7xZ
	ayJ3kvqtpScs0lGRS5OT3+mlaDUSefEi5TLYorKb4ZOgBXMW/bNK03K4AosQBK8JOq3cJpFKv4DfX
	6a6Ss4ih/yT1/expCjo3PDo/IwUPup5UzfrETtfz/3RM4Z8vjzaw12ZPPQB0lzM6fXZci5nauZG4/
	3OCW/FTQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mfbxU-003wlp-CN; Wed, 27 Oct 2021 05:58:44 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mfbxR-003wkj-PS
 for linux-nvme@lists.infradead.org; Wed, 27 Oct 2021 05:58:43 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 860EF67373; Wed, 27 Oct 2021 07:58:39 +0200 (CEST)
Date: Wed, 27 Oct 2021 07:58:39 +0200
From: Christoph Hellwig <hch@lst.de>
To: Varun Prakash <varun@chelsio.com>
Cc: sagi@grimberg.me, hch@lst.de, kbusch@kernel.org,
 linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme-tcp: fix possible req->offset corruption
Message-ID: <20211027055839.GC9635@lst.de>
References: <1635255115-3028-1-git-send-email-varun@chelsio.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1635255115-3028-1-git-send-email-varun@chelsio.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211026_225841_994364_B7245D99 
X-CRM114-Status: UNSURE (   7.85  )
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

