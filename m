Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22E36C02198
	for <linux-nvme@archiver.kernel.org>; Wed, 12 Feb 2025 12:16:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:References:Cc:To
	:From:Subject:Message-Id:Date:Content-Type:Content-Transfer-Encoding:
	Mime-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3FtJRc2IltoMj+mCq22wPBFnDdU2IMjYKEhIx6mDmDA=; b=M5T4gO+iYFFIFKOj9hswShO0Kw
	9GWwFzXU1GtL9gnoBZfF6FPLgLHQZytPkANJ+si0IQkuI6HDEb8zQzRKG1vqZ6EX9F69/RmKoquv5
	x/Wnu7nuXrv237mHR0Oj8janq3ew8ri1ZdrMmlVqxOUr1zkTX6jXsYwRehBfqEvqpwz8RDvAtw4u+
	RgjDyKr5NU3yr/DpPXMdspshDo0BqxT7jFPvXPL110fKVOuAnax/0VC7ycg0tdK3j92JRJ0twLaC2
	256lroxSjezWzjPC1B6Rz801SFVYb8UosmgcBeiY0IXHq/gFtxE2yh4M/itV9p4IQd6BBYDmkJy3N
	YMtZ1apg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tiBeq-00000007Jki-1AJw;
	Wed, 12 Feb 2025 12:16:00 +0000
Received: from 128-116-240-228.dyn.eolo.it ([128.116.240.228] helo=bsdbackstore.eu)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tiBDM-00000007EdP-1ARa
	for linux-nvme@lists.infradead.org;
	Wed, 12 Feb 2025 11:47:37 +0000
Received: from localhost (25.205.forpsi.net [80.211.205.25])
	by bsdbackstore.eu (OpenSMTPD) with ESMTPSA id 25b47fee (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 12 Feb 2025 12:47:34 +0100 (CET)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 12 Feb 2025 12:47:32 +0100
Message-Id: <D7QFYOJVX22Z.CU0EL0NHPNS8@bsdbackstore.eu>
Subject: Re: nvme-tcp: fix a possible UAF when failing to send request
From: "Maurizio Lombardi" <mlombard@bsdbackstore.eu>
To: "Maurizio Lombardi" <mlombard@bsdbackstore.eu>,
 "zhang.guanghui@cestc.cn" <zhang.guanghui@cestc.cn>, "chunguang.xu"
 <chunguang.xu@shopee.com>
Cc: "mgurtovoy" <mgurtovoy@nvidia.com>, "sagi" <sagi@grimberg.me>, "kbusch"
 <kbusch@kernel.org>, "sashal" <sashal@kernel.org>, "linux-kernel"
 <linux-kernel@vger.kernel.org>, "linux-nvme"
 <linux-nvme@lists.infradead.org>, "linux-block"
 <linux-block@vger.kernel.org>
X-Mailer: aerc
References: <2025021015413817916143@cestc.cn>
 <D7OOGIOAJRUH.9LOJ3X4IUKQV@bsdbackstore.eu>
 <3f1f7ec3-cb49-4d66-b2b0-57276a6c62f0@nvidia.com>
 <D7OWXONOUZ1Y.19KIRCQDVRTKN@bsdbackstore.eu>
 <CAAO4dAWdsMjYMp9jdWXd_48aG0mTtVpRONqjJJ1scnc773tHzg@mail.gmail.com>
 <202502111604342976121@cestc.cn>
 <D7QBDBZMZTCI.1W40WVL5JJ3O7@bsdbackstore.eu>
 <D7QC8AQ7J89A.32TNPSFWV1VNX@bsdbackstore.eu>
 <202502121747455267343@cestc.cn>
 <D7QEA7XPBML4.1R0M64OD4BH43@bsdbackstore.eu>
 <D7QF99BR5YYA.2CXBBA5RYACTY@bsdbackstore.eu>
In-Reply-To: <D7QF99BR5YYA.2CXBBA5RYACTY@bsdbackstore.eu>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250212_034736_650379_9D7E0F27 
X-CRM114-Status: UNSURE (   8.81  )
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

On Wed Feb 12, 2025 at 12:14 PM CET, Maurizio Lombardi wrote:
> On Wed Feb 12, 2025 at 11:28 AM CET, Maurizio Lombardi wrote:
>> On Wed Feb 12, 2025 at 10:47 AM CET, zhang.guanghui@cestc.cn wrote:
>>> =C2=A0=C2=A0=C2=A0=C2=A0Hi, Thanks.
>>> =C2=A0=C2=A0=C2=A0=C2=A0I will test this patch, but I am worried whethe=
r it will affect the performance.
>>> Should we also consider null pointer protection?
>>
>> Yes, it will likely affect the performance, just check if it works.
>>
>> Probably it could be optimized by just protecting
>> nvme_tcp_fail_request(), which AFAICT is the only function in the
>> nvme_tcp_try_send() code that calls nvme_complete_rq().
>
> Something like that, maybe, not tested:

Ah wait, this won't fix anything because it will end up with a double
completion.
Ok I am not sure how to fix this, someone else maybe has better ideas.

Maurizio

