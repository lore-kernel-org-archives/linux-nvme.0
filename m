Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A18DCC433F5
	for <linux-nvme@archiver.kernel.org>; Tue, 10 May 2022 06:05:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xBM3SjSADpCtaGTcU20MqvmhiyUnvgFDR0aC/pBuNI4=; b=uNsIEX0uQysYfCcj/vsyBdyJbC
	SL1GywUrCSmUpTy1LoFiBPzqQMmviY3RZoTP0DWCIkE40+Z2kFjm8pItRUYBSSLxfO38JldFTuW5w
	l/ciTNpEYJ6JA/otZCawdkvSqxRZohDdCwSlXujrFju2XwDddFxfSpQCxpDFcp1xSTU8MWOuTn7DH
	YSJuOIMTu7eKulEroKNWbqOKBuynV8P7y1pqxv7gCQXCP47Zq9sR10aVSHTllxi94Na50rne6mSeR
	VBcat+xMvdqVSy2fCInZZ2VWMKppJWEXmG+jIIDjoHApmhRehcZr7raUBpn2ps2UoZBe9rhGkMBS8
	nHZ3Bcow==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1noIzZ-0005g3-W7; Tue, 10 May 2022 06:05:06 +0000
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red
 Hat Linux)) id 1noIzT-0005fW-Sq; Tue, 10 May 2022 06:04:59 +0000
Date: Mon, 9 May 2022 23:04:59 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Tom Yan <tom.ty89@gmail.com>
Cc: linux-nvme@lists.infradead.org, kbusch@kernel.org, hch@infradead.org,
 sagi@grimberg.me
Subject: Re: [PATCH v4] nvme: fix interpretation of dmrsl
Message-ID: <YnoAi1IaqS2rb6gA@infradead.org>
References: <YmrMSGDDn3UMnJ8t@kbusch-mbp.dhcp.thefacebook.com>
 <20220429045243.324403-1-tom.ty89@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220429045243.324403-1-tom.ty89@gmail.com>
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

applied to nvme-5.19.

