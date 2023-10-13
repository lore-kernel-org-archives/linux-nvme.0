Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BC8CCDB474
	for <linux-nvme@archiver.kernel.org>; Fri, 13 Oct 2023 01:26:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Content-Transfer-Encoding:Content-Type:Subject:Cc:To:From:MIME-Version:Date:
	Message-ID:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=GEuOLYirvX2qJcSkQz0Ax+n50FmQFGNzY6xHiGNtE4c=; b=OwD2knRhsjBH+X
	H41rXw7nz5+c4Oi2cjCjfM8P0HqJCK6giGWCuriIU78vp+52x/Qm3zy7r3i0JWkjKCqtZlObpGuCz
	5OwOIwfdFGcd020hqDMGWGX2nk/2TQ6swNbgD0TOV4Q4Ag4pXeDBGVSjbS6/obvBcEO9imiZfVFCX
	KcM+x6sofywxeYiykNUTgaYyUSD3aMcz0brUm1f19JnnGLybP3aA1ETc4O4/4X9ZsxkgyHNqni7WK
	Ia0TQyqYpbPJgfjbAasDSns+j/8mRYIU3Ra+v7+ksx25MwqWccdNqjY5cVpFDR2aFILZdtFho6mXz
	HeP5UdMm1FvRJS79geGg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qr6wB-002Elh-1F;
	Fri, 13 Oct 2023 01:25:59 +0000
Received: from mout.gmx.net ([212.227.17.22])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qr6w7-002ElA-2o
	for linux-nvme@lists.infradead.org;
	Fri, 13 Oct 2023 01:25:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net; s=s31663417;
 t=1697160341; x=1697765141; i=andreas.thalhammer-linux@gmx.net;
 bh=GEuOLYirvX2qJcSkQz0Ax+n50FmQFGNzY6xHiGNtE4c=;
 h=X-UI-Sender-Class:Date:Reply-To:From:To:Cc:Subject;
 b=Z3xZ8PYBo8RtrSobfge3vnwXV0PNkGf7cNcNDo9XeR5xqrdvi1ObZ1ZPTMXyXNpwZpEfJE1cbdV
 48tGvXO5iVsUr/8pvwYxND3DkF8+DzH6znXjsxIDFzzUFCprIHOw356zb3fH1rGQZiAY1/J5b/TTA
 7i07zfUycRuJm6vQO4C4ey+y6WGmA6hnmNBdfst17SUP+Dbueoj3QHMpxXq0TK+OVNJPD1jAHqXNN
 cMxD9e6nu84kXQgVIskfN+EKN7JZxp/UqdNtEiun/Nalz6C5rgfiNmrG4xxZ1Mg0lnfA8ri1ge326
 rcFSLUDG9ztEFv7MDrZOMme2obPAEtqmu47A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.21.211] ([72.187.224.130]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mf0BG-1rSteo2EEE-00gcXh; Fri, 13
 Oct 2023 03:25:40 +0200
Message-ID: <4933a8ea-56d4-4094-b9fd-bc16fc5dd920@gmx.net>
Date: Fri, 13 Oct 2023 03:25:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: de-AT, en-US
From: Andreas Thalhammer <andreas.thalhammer-linux@gmx.net>
To: linux-nvme@lists.infradead.org
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
Subject: Bug 216809 - nvme nvme0: I/O 0 (I/O Cmd) QID 1 timeout, aborting
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:cTSHDerG2AhE76PZ/1cKcRspW7Ud4zr407b7lE8P8dpJK0KX/pW
 RaRVAil89Tr9Cq5xlQtplWx0td0Si4pAp1JN2gB368hcVaB+u1Dqz2VKfwcz0y31SUMfjpp
 Og3rOL7A1TfgjFPxJA2sFTkktS+hGYz2SINwntPiQFl12L9COjcozqtLngzyhl3BsnpXnDy
 J1FZaaanNlAAoenQK9Fag==
UI-OutboundReport: notjunk:1;M01:P0:OsvhG2PKZVU=;nLZcRgIypCUx/YnrUap0U9DySCZ
 bWDa8ijIQHat1yDI4xKviCOLf5hr4cfRq9eNGqWbjZ3I0ktrvixfuTj6uoYyfNM6n8WpsnBD4
 nEdrEm7QWlsAS/OYUDPXaY2wZgvcH8PJyhjMFbik6sAR5dbtBmK6Nn3kPmk1/7cyBWk+QO8an
 Q69EsQU8p+7DoQEWl50z7nUeDJpN7A3Nb9cJvriHMD7Yd3qsdXFcQXzemnUz2HBEad2Zd94Pl
 X1qqLmqXSGCZ30AeuWFmVsO15HGLgmotNE4R0Ws/1ioHlnRIERMiw26RsiPvzYT/pQqnE5DQk
 gVYSiBDFz+XhKYwWq3edviTC9uAul7KNmYY/a40gx5RurWYC+WTjdPAsa1AWAiReI1F+adFFO
 b0aWTrC1+giag5Ee86CEh+BZTbmtP9IH8tptPXVVRY0ZLknovzZLnZeNbIkC9ij5pQnriGg91
 pot5DpMjuYbio6IQnEsYzlyJzneH9fqoKxbk8b9ZBns+3WDq27pZUSw2hNe8NN43HHIFVU72k
 PcWn9ZtCCTmMC9Kl3SsvTyBl6sH6VsPaaG0ib44UbqgjGPKXHdxrvflo3Ce7zifwqKDLxHOQL
 3QBH/VENFzWSMuhuVWeuhCWw9kW1eI4H42hbgNTw6+N40izwrdInLDmKt/530Rgwz//GX0Px7
 vwFXWbx2nS6daGju6y2wx1Fh2dDq0X3BTBrsw/9wSMM2z2IwssElVYKMNVDz5NdvrWvzIl5h7
 PE1TFniwhlqFDRRZJgxXD3vEC+65aeD+TRhAi8BQACqQVy9XpBfHkbNx/bJ9TzBDJ+7cUcLJC
 XyEKUgC8sCIJj018k6kO4a3bFKud01UnYBothvJNRJWPLp7uWV0L5OlPQle6hv4EQnwN41FwD
 AzwlxhKsolDLK7V+OLgtEgrYU2wfPb/fg0HhJs8274+YO3hG8Z0gucYvQN1s/XBvqP7w1N65t
 aWheOX9URBKi9cH+swRiyGS+pWw=
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231012_182556_414550_05C35BAA 
X-CRM114-Status: UNSURE (   5.45  )
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
Reply-To: andreas.thalhammer@linux.com
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hi!

I'd like to make you aware of
Bug 216809 - nvme nvme0: I/O 0 (I/O Cmd) QID 1 timeout, aborting

https://bugzilla.kernel.org/show_bug.cgi?id=3D216809

I personally don't see the reported errors AND system freeze on my own
systems, but the reporters do, which are:
jfhart085@gmail.com
Nelson G <konoha02@yahoo.com>

Help appreciated.
Andreas Thalhammer (not a developer, just a user)

