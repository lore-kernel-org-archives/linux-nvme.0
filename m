Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9A3CD2F036
	for <linux-nvme@archiver.kernel.org>; Tue, 27 Jan 2026 14:37:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:References:Cc:To
	:From:Subject:Message-Id:Date:Content-Type:Content-Transfer-Encoding:
	Mime-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wd4YnySgPyzR/hiE7aVqxqz+PWOhQTiZslNf/L6Nsbk=; b=oBAhBDazEqDhaVjYjuq77C7LRa
	LP9/xiUCOAnUlj1Q4tLy33jJW/9unJL6BuOeJwjE+xhW2dAjk+0KZMlY1cCxFLlEDMbDvNawd1FnY
	82lk3MN4RHxMPGGgYeldSzZH54ojvrAiJjA61ekmF3tPICEANrDOm87Pxq9vSnIwvHaf6HVOd21u0
	+H2mHMv4iDArE96CJA+ifLFdHfKobdYPqKGVU3wb3uo6ie+vk7oBZG4j3S7AYp86nH+pWx40vZWak
	HmGqEFM06WmyMyHcFJNIKJrWj0I7nhxVfTlirauvmye036fO/vgoyNR4ggWXFRM5pzNY8/uZsdKyO
	AaN6+Ysg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vkkBv-0000000EPLH-1Rk6;
	Tue, 27 Jan 2026 14:37:15 +0000
Received: from 128-116-240-228.dyn.eolo.it ([128.116.240.228] helo=bsdbackstore.eu)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vkkBr-0000000EPKT-2rBt
	for linux-nvme@lists.infradead.org;
	Tue, 27 Jan 2026 14:37:13 +0000
Received: from localhost (128-116-240-228.dyn.eolo.it [128.116.240.228])
	by bsdbackstore.eu (OpenSMTPD) with ESMTPSA id 1bd4c977 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 27 Jan 2026 15:37:09 +0100 (CET)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 27 Jan 2026 15:37:09 +0100
Message-Id: <DFZG4OIFIHO8.313E3KOTXSDL5@bsdbackstore.eu>
Subject: Re: [PATCH v3] nvmet-tcp: reject H2CData before ICReq
From: "Maurizio Lombardi" <mlombard@bsdbackstore.eu>
To: "Maurizio Lombardi" <mlombard@bsdbackstore.eu>, "YunJe Shin"
 <yjshin0438@gmail.com>, <kbusch@kernel.org>
Cc: <linux-nvme@lists.infradead.org>, <hch@lst.de>, <sagi@grimberg.me>,
 <gregkh@linuxfoundation.org>, <security@kernel.org>, "YunJe Shin"
 <ioerts@kookmin.ac.kr>
X-Mailer: aerc 0.21.0
References: <1a3d4d2d-db0c-4358-8229-c7d6f5e83bbe@grimberg.me>
 <20260126064248.591202-1-ioerts@kookmin.ac.kr>
 <DFZFBKPGNCD4.3EKJ4G1H2GBDC@bsdbackstore.eu>
In-Reply-To: <DFZFBKPGNCD4.3EKJ4G1H2GBDC@bsdbackstore.eu>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260127_063712_054869_DD89D00C 
X-CRM114-Status: UNSURE (   7.41  )
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

On Tue Jan 27, 2026 at 2:59 PM CET, Maurizio Lombardi wrote:
> On Mon Jan 26, 2026 at 7:41 AM CET, YunJe Shin wrote:
>> If H2CData arrives before ICReq/CONNECT, queue->connect is used but its
>> iov is not initialized yet, which can lead to a NULL dereference when
>> building the PDU iovec. Reject such requests early with -EPROTO.
>
> Doesn't nvmet_tcp_done_recv_pdu() reject all unexpected PDUs
> when the queue is in connecting state?

Nevermind, now I get what you mean: you can hit the bug if you send
H2CData after ICReq but before the execution
of the connect command.

Maurizio


