Return-Path: <SRS0=KTc9=BF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D3BFC433E0
	for <linux-nvme@archiver.kernel.org>; Sun, 26 Jul 2020 15:43:20 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 66AC620714
	for <linux-nvme@archiver.kernel.org>; Sun, 26 Jul 2020 15:43:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="FUFLtA0T";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JvSPg230"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66AC620714
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=MQnrUtn3Qak1TO813585WjzzVlcQMykhs2UU4vCkFVo=; b=FUFLtA0TNoYJ2/s0fHMXeUWoF
	I+BxkSm5ahaCuLbsZmNV83zTLLlQ9yqc/6QOK7roMRIxc4cHap9ivTnyKPgcR4d7cx/Jvxec0yexn
	/zienzvohVliBtnlUaW79JCvt8huJXakbwuGIsVKLqwYKq4jI1a/jpscmDdVWaSaFTGwcjVuVEEsr
	zl9iTOQWT6Rtj0K6sakzFfY/vcOXW0UTEIRtqWPOJGmz60GDvsCM6XdN0q1dRZFkxqVFTdf7Ge6TG
	lJQPXM1LoUVWP8dklLsXKLDC+n/hrhvUQqtfdEzon/4bO6opCtrOlEx7rtP7NOBm+F5XbilL8HIEt
	nfBwr6fhQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jzio2-0000pw-Fk; Sun, 26 Jul 2020 15:43:18 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jzio1-0000pk-1j
 for linux-nvme@merlin.infradead.org; Sun, 26 Jul 2020 15:43:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=YxEFDJd2LiHUJZHU0U0wj25O0MJBQkRdlwAlA8XnHA8=; b=JvSPg2302wxoULu69hvrvuU9tK
 4zcZQoXj2ie6A4OP9+uPQs+bZa0gFiVOQZqqmYoRpVNiq2Bg2CX9cTJnSMXXBL3vbXU5PGUCz7KLg
 3mZzDFT3I/17LAfAn8+Bn1HR6H8Iw1hBMEFCvtmYZdKPWlIV6wrgnQf1lDRnxzv6CVkwdbmGdHMtb
 MVxkCI7KLjn/Q2Ll7088uIwarfeBUcAEvUqxQxjvo5Rwbtnnnotb9fM730BiwCrS0wM9OLeksJXlE
 cEQFWIijwzGduxVGkCOVxqrex64ucLXfMpyiuPtDXR8DChnwpZ0t5nH79RQsmQhGzJ0bfv9PPMXb+
 N8CT16Sg==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat
 Linux)) id 1jzinz-00082T-IZ; Sun, 26 Jul 2020 15:43:15 +0000
Date: Sun, 26 Jul 2020 16:43:15 +0100
From: Christoph Hellwig <hch@infradead.org>
To: James Smart <jsmart2021@gmail.com>
Subject: Re: [PATCH] nvme-fc: set max_segments to lldd max value
Message-ID: <20200726154315.GA30848@infradead.org>
References: <20200714190336.119013-1-jsmart2021@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200714190336.119013-1-jsmart2021@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Max Gurtovoy <maxg@mellanox.com>, "Ewan D . Milne" <emilne@redhat.com>,
 linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Applied to nvme-5.9, thanks.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
