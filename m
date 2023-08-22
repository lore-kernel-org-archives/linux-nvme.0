Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B979EE4993
	for <linux-nvme@archiver.kernel.org>; Tue, 22 Aug 2023 15:42:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IfJrA5Tn6w+vdt3XiqV2QN8XMtDbKOAYVmHZEZoc+rM=; b=FTdQ1Hg+7Lk7lKi8qrY9slzc3S
	NLEwxkEOrVKgkRRUHz/J1IeQBx/x+M/l1c2y0NM8kzSMdyjgP2Tuns4+RJNdv1zNal/Qc9UH4lmsk
	638RzjRgEuM6TE8pRpa4ED717v4R0j0xapGJ7VedJ6F98NojshvsDESluGlygkxPHwDsDdOGdZlYm
	UrI6ON1vo2GwtOCCaL7C9BN8Nlla/8UbDLw3NDOG5uhxIC6Ff48LrHNAUvB/jPUI2jA4SJH3GvEbs
	s+EQ2z4+MhsOIWQdr0KrkZyzgtZ+r+bYnLLrcqpxOagFblAbQNsTM0oWGLZChwf7y46jk0fGhRmrl
	2YBUaTKg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qYTW2-00GO37-1S;
	Tue, 22 Aug 2023 15:41:58 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qYTW0-00GO2Y-0U
	for linux-nvme@lists.infradead.org;
	Tue, 22 Aug 2023 15:41:57 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id ACA0D61711;
	Tue, 22 Aug 2023 15:41:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9646C433C9;
	Tue, 22 Aug 2023 15:41:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692718915;
	bh=IfJrA5Tn6w+vdt3XiqV2QN8XMtDbKOAYVmHZEZoc+rM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pNQCr2j7a+EYlyIw/k+JQm/3YjST7au9r3g1F4YQbr6UXvU0+5p7HckSaSv/KfF8z
	 YPpGwf+0VjHXeRSZKR5Hxt5maMFM75koWlwVyblBYM5ZMtpTOYEjyESVVffL028GYe
	 Wms8lIdCDZwZWuPtE21LbpPPmSFc4zQ0gqOqAd5OpJCJ1kfozO5x1XTyFEt5/sfw1f
	 wY00EPeTL+WNLWCblhhwcGkdmBO1O8fzbnrX++fjfcGQUnsPIw2xcWNZhczP0JO1Lb
	 gEbVVnLeIe6K2xBOkGQatyaphhgSz71DNksKEeV88pxpNyZHPd1BRA3xBHIe0o83uf
	 iaMsLMIaO28Mw==
Date: Tue, 22 Aug 2023 09:41:52 -0600
From: Keith Busch <kbusch@kernel.org>
To: Varun Prakash <varun@chelsio.com>
Cc: sagi@grimberg.me, hch@lst.de, linux-nvme@lists.infradead.org,
	Rakshana Sridhar <rakshanas@chelsio.com>
Subject: Re: [PATCH v2 RESEND] nvmet-tcp: pass iov_len instead of sg->length
 to bvec_set_page()
Message-ID: <ZOTXQMOZdjn32sPy@kbusch-mbp.dhcp.thefacebook.com>
References: <20230809102645.47190-1-varun@chelsio.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230809102645.47190-1-varun@chelsio.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230822_084156_229387_8CC5CAB7 
X-CRM114-Status: UNSURE (   6.93  )
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

Thanks, applied for nvme-6.6.

