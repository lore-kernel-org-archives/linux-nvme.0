Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3D25C43334
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Jun 2022 19:29:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Message-ID:MIME-Version:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1rf93IH0ti/YkRyAR4sldd9DFVKv4GgG3DdOEPGj0lE=; b=rfjA4GT0DNIli8nCF9X2WQDVns
	RTUWEUeKdLzGJM9Tc7GViACyNFuzMpFlvbK9i4G0FYgTksDcAJP925d9IsF+lcU+pzOb68tO1egNW
	rgXcKx5jybxa38OIP/akN1nr2ObTNneqSPNaGlVxZJAoWbO5qatpVzRQMdiBHsNN/l8QjoRlj1nU9
	CJVbXefSE95veSY4Xt/X7u/Hj4MilITwzpan6IdBEwV9N5wCqPXJ5qR9iplgCVBdGLGpzGCZFgY09
	Bs4NhNOuMNlc9pzoa40jpXmhW602tll7XmjR2ejs0aBL2+N+nH2h/5U2ATe4uc22UwwamK1bMZYT4
	mxlUpxjA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o462B-00C5tr-Lb; Wed, 22 Jun 2022 19:29:03 +0000
Received: from smtpout06.a1.net ([80.75.33.6])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o4629-00C5sb-4S
	for linux-nvme@lists.infradead.org; Wed, 22 Jun 2022 19:29:02 +0000
Received: from localhost (unknown [100.77.12.61])
	by smtpout06.a1.net (Postfix) with ESMTPSA id 4LStj946gBzGrqnr;
	Wed, 22 Jun 2022 21:28:45 +0200 (CEST)
From: Leo Savernik <l.savernik@aon.at>
To: Christoph Hellwig <hch@infradead.org>
Cc: Keith Busch <kbusch@kernel.org>,
 <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH] Introduce NVMe quirk for multiple Micron MTFDKBA2T0TFH =?iso-8859-1?Q?SSDs?=
Date: Wed, 22 Jun 2022 21:28:44 +0200
MIME-Version: 1.0
Message-ID: <4c94e275-34c1-43a3-9ffd-f616c6b6bb2f@aon.at>
In-Reply-To: <YrLtNVIhLMwvfMZZ@infradead.org>
References: <af7628d5-2b91-4fea-a2bd-56825dbcb02f@aon.at>
 <YrDs2sPzH4RPzhGI@kbusch-mbp.dhcp.thefacebook.com>
 <86c55fb7-ef0f-4c3d-82cb-9d655f17baf9@aon.at>
 <YrLtNVIhLMwvfMZZ@infradead.org>
User-Agent: Trojita/v0.7-468-gd9d6944a; Qt/5.15.3; xcb; Linux; Ubuntu 22.04 LTS
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220622_122901_356472_825606D1 
X-CRM114-Status: UNSURE (   6.52  )
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

Am Mittwoch, 22. Juni 2022 12:21:41 CEST schrieb Christoph Hellwig:
> The patch seemed whitespace damaged.  I've manually applied it and
> use that opportunity to shorten the commit log a bit.
>
>

Oh, I'm sorry! I took care to send it as 7-bit ASCII but apparently it=20
still got mangled. Thank you everybody for reviewing and your efforts!

mfg
=09Leo


