Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79389C02198
	for <linux-nvme@archiver.kernel.org>; Wed, 12 Feb 2025 16:29:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:References:Cc:To
	:From:Subject:Message-Id:Date:Content-Type:Content-Transfer-Encoding:
	Mime-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=x/HTk1zHEpbPXjJjI1MXnbYMtO2pTeXcBXPACpOlCSg=; b=iibGWLtbIFq5EzKDyGNsh12/tI
	bFR9rrlEPlPmHB9oP/+jy/KZ5GYcDXeoNco3pClQAVla9j4smOm8bgMpY7/Zb02e59KjbybqmeAp9
	sXMCI7Uz2ql165Iv6QRdTZ2VkMpEPwL4aR1EExYV/owA/T83zYUlU4meC0E0KVJi+vybNF+vk+oLA
	Uucgx1qxKz98obQj5ytC/lfWjpZHG4re+Vn0M4af/srzJufDYG1lyw0GNdnTK0qvg8q0k5aupsoIa
	P5kSt0V9c5K82XrFKnMtZF+NiE08xUbp65NWdv8sbStIQvoIcxaTU9t1s1cnHK/9a/JDkUfkpRiab
	YNm69h8g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tiFbd-000000084yK-2jhv;
	Wed, 12 Feb 2025 16:28:57 +0000
Received: from 128-116-240-228.dyn.eolo.it ([128.116.240.228] helo=bsdbackstore.eu)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tiFHP-000000080Nl-3OZt
	for linux-nvme@lists.infradead.org;
	Wed, 12 Feb 2025 16:08:05 +0000
Received: from localhost (25.205.forpsi.net [80.211.205.25])
	by bsdbackstore.eu (OpenSMTPD) with ESMTPSA id 2ef4fa32 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 12 Feb 2025 17:08:01 +0100 (CET)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 12 Feb 2025 17:07:59 +0100
Message-Id: <D7QLI3PYQ877.1KH6K8K08P2IP@bsdbackstore.eu>
Subject: Re: nvme-tcp: fix a possible UAF when failing to send request
From: "Maurizio Lombardi" <mlombard@bsdbackstore.eu>
To: "Maurizio Lombardi" <mlombard@bsdbackstore.eu>,
 "zhang.guanghui@cestc.cn" <zhang.guanghui@cestc.cn>, "sagi"
 <sagi@grimberg.me>, "mgurtovoy" <mgurtovoy@nvidia.com>, "kbusch"
 <kbusch@kernel.org>, "sashal" <sashal@kernel.org>, "chunguang.xu"
 <chunguang.xu@shopee.com>
Cc: "linux-kernel" <linux-kernel@vger.kernel.org>, "linux-nvme"
 <linux-nvme@lists.infradead.org>, "linux-block"
 <linux-block@vger.kernel.org>
X-Mailer: aerc
References: <2025021015413817916143@cestc.cn>
 <D7QKRU1EXDXJ.K6ZXC4V4ZD68@bsdbackstore.eu>
In-Reply-To: <D7QKRU1EXDXJ.K6ZXC4V4ZD68@bsdbackstore.eu>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250212_080804_184347_7FE51627 
X-CRM114-Status: GOOD (  11.66  )
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

On Wed Feb 12, 2025 at 4:33 PM CET, Maurizio Lombardi wrote:
>
> Taking a step back. Let's take a different approach and try to avoid the
> double completion.
>
> The problem here is that apparently we received a nvme_tcp_rsp capsule
> from the target, meaning that the command has been processed (I guess
> the capsule has an error status?)
>
> So maybe only part of the command has been sent?
> Why we receive the rsp capsule at all? Shouldn't this be treated as a fat=
al
> error by the controller?


The NVMe/TCP specification says

******
When a controller detects a fatal error, that controller shall:
  1. stop processing any PDUs that arrive on the connection; and
  2. send a C2HTermReq PDU
******

And indeed I see in the dmesg this:

nvme nvme2: unsupported pdu type (3)

This means the controller detected the problem and sent to the host the
C2HTermReq command. Upon receiving this command, the host is supposed to
close the connection.

Now I get it.

Zhang, do you have commit aeacfcefa218f4ed11da478e9b7915a37d1afaff in
your kernel, I guess you are missing it. Check it please.

Maurizio


