Return-Path: <SRS0=w6YM=OR=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB97FC433F5
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Sep 2021 15:48:45 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B5A660F6C
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Sep 2021 15:48:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5B5A660F6C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=WN2gDTzs64LlqWKjgqkknVr+OLcgqO4/+8rqbLILbKk=; b=eJF19QwdZ/W9T0
	WV8B8ZfNruJ3I9x2IUO+iYeD96g9Wc8/zYkZkNs1GsUHbtQr0r8jslwXk8a3/NaObitkNp074C5tN
	0Z5lcuNIB6eQ4yyjFzrMbmmYYjmdBj2X2u/k4uWN/CKDhVDTKUUOYrSIeDChUFaScAMaPh1GtD5yF
	lkvWDXTez8M0SMgLVP+/Iq5p/wgg1N7yHEmFND1HJnUfAmwQs9zLcr6Qr2Yktsy278MfI1Q3TiMVY
	3kYj8KW14aX/GRS3yw/Vo5myJvHdSCa6IiweYti8QKZ5c4rzm3cLqCTQ4jTli3aWsoMJj9LWSZBhR
	lKoPSnX6L94emSnEP3Pw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mUsre-003FDI-FB; Mon, 27 Sep 2021 15:48:22 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mUsrb-003FB9-2u
 for linux-nvme@lists.infradead.org; Mon, 27 Sep 2021 15:48:20 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 2DE0267373; Mon, 27 Sep 2021 17:48:12 +0200 (CEST)
Date: Mon, 27 Sep 2021 17:48:12 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org, sagi@grimberg.me, hch@lst.de,
 linux-kernel@vger.kernel.org, axboe@kernel.dk,
 Sven Peter <sven@svenpeter.dev>,
 Orlando Chamberlain <redecorating@protonmail.com>,
 Aditya Garg <gargaditya08@live.com>
Subject: Re: [PATCHv2] nvme: add command id quirk for apple controllers
Message-ID: <20210927154812.GA9730@lst.de>
References: <20210927154306.387437-1-kbusch@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210927154306.387437-1-kbusch@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210927_084819_333038_8114D4E1 
X-CRM114-Status: GOOD (  10.02  )
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

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

Jens, given that you're on the thread, do you want to pick this up
directly to reduce the patch queue latency?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
