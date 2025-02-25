Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 553BBC021A4
	for <linux-nvme@archiver.kernel.org>; Tue, 25 Feb 2025 02:07:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QSBREAfPC2cBcJiV6Z6ErnCB7KVWOLRnp6Zvp62iV/4=; b=BCMrz7gftSN/ZK+0LKQhyK/Qfe
	sCgyCvvUf/aoVirvcs7gHTWBWvqQMdNMS2K0/79lMliy5nnIhbZmKFkYvA/zWfrLovmMNZjGj7QXu
	jJSt301HGlmoIwn2XKmzGkVFo/uxYxkBL+h8EUETJr3QhD/DyMEqBSheKgNfmNcSQB1FE1y/kRgRQ
	04K4R2qIgBYF5jux3QitgRNJYmm84bpwUNwxvJcsxSldYl52eF4lUL5SxFnCcRFkY5a9m2CSIz5Sw
	yN+In9RlKXcC2oajk/4NJbOqn/JDicp1Lxw9dyVMAVpYSvrxqMtpnXTwrFbdIIGJ6M4xWDNl5VGUv
	ftEHoJ2w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tmkMM-0000000Floo-2ud6;
	Tue, 25 Feb 2025 02:07:46 +0000
Received: from sender4-op-o15.zoho.com ([136.143.188.15])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tmkMK-0000000Flnn-0tZe
	for linux-nvme@lists.infradead.org;
	Tue, 25 Feb 2025 02:07:45 +0000
ARC-Seal: i=1; a=rsa-sha256; t=1740449260; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=ctMaYshhKAViVYmhi35VSTcCEPdynuESMYTGkoniXnPG1daZqPx6t/KikcKoqxAJ1ERGJ/+lDnmHr2ITxKERyrG9ZMtKLhEnRcZ9kwk+LW4bA5VxFv7GHvAPCvOAfvxyjuE+N76s7S6P9wGl29FTHQ1k4yWs9RQ6MqscWGhh3to=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1740449260; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=QSBREAfPC2cBcJiV6Z6ErnCB7KVWOLRnp6Zvp62iV/4=; 
	b=G40PjWNCsHQhdsFzGHJKcjzH8cQbb9KPPbvxiP9uXWXcrTGzGWGAFj/N1TKAeJBWUhGyhlT/0RzUgb0daOFUnRsbu/lgTjThEzv+F2Dcy8/qbJDxVHJ9j/MwcmJwpSoxZWKddVYhSz4BJNhneJwA2pridSnjUbv2/PGPEmoxn6U=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=icenowy.me;
	spf=pass  smtp.mailfrom=uwu@icenowy.me;
	dmarc=pass header.from=<uwu@icenowy.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1740449260;
	s=zmail2; d=icenowy.me; i=uwu@icenowy.me;
	h=Message-ID:Subject:Subject:From:From:To:To:Cc:Cc:Date:Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:MIME-Version:Message-Id:Reply-To;
	bh=QSBREAfPC2cBcJiV6Z6ErnCB7KVWOLRnp6Zvp62iV/4=;
	b=EFE3XvznyPbgmrBhXf+KnRD24ymQPxZ0akb45gr0nLgcbe9M8wxxUDUQKHiX0ATy
	BrOSVu1SkR+8/dUGIoH3E9+K1BTl1L+dDhy5J60QwShEK+E+RKW5JNod17OcOJB+2pd
	JOEhiqLcZUmZbnAy/io8KaAiQWspgJ5yqDQe6ESlg6vf8huCeXPqPs5+zzgi1nMCste
	pq4G8DyPas0AY5ydlWGXdAnoDQgNMFTAcg+QLVodGbCk905AN8XUgpTFZVwgI3DvWVK
	GR8j4VNTneKhQpHiKElqYia967rDkbnq4BjfYalQNLz8NjOUYD75WNsHFJdor5V91xE
	y8AUxUpQuw==
Received: by mx.zohomail.com with SMTPS id 1740449257618172.64096278561385;
	Mon, 24 Feb 2025 18:07:37 -0800 (PST)
Message-ID: <64ff1dcf9e46c15e062ccf05ae6f9efd3747f0fd.camel@icenowy.me>
Subject: Re: [PATCH 0/2] Misc fixes on registering PCI NVMe CMB
From: Icenowy Zheng <uwu@icenowy.me>
To: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>, 
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Date: Tue, 25 Feb 2025 10:07:31 +0800
In-Reply-To: <Z70MC0zoC0L-tOgO@kbusch-mbp>
References: <20250212170444.16138-1-uwu@icenowy.me>
	 <20250213055449.GB19370@lst.de> <Z70MC0zoC0L-tOgO@kbusch-mbp>
Organization: Anthon Open-Source Community
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 
MIME-Version: 1.0
X-ZohoMailClient: External
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250224_180744_318280_40344989 
X-CRM114-Status: GOOD (  14.65  )
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

=E5=9C=A8 2025-02-24=E6=98=9F=E6=9C=9F=E4=B8=80=E7=9A=84 17:17 -0700=EF=BC=
=8CKeith Busch=E5=86=99=E9=81=93=EF=BC=9A
> On Thu, Feb 13, 2025 at 06:54:49AM +0100, Christoph Hellwig wrote:
> > On Thu, Feb 13, 2025 at 01:04:42AM +0800, Icenowy Zheng wrote:
> > > Here is a small patchset that is developed during my
> > > investigation of
> > > a WARNING in my boot kernel log (AMD EPYC 7K62 CPU + Intel DC
> > > D4502
> > > SSD), which is because of the SSD's too-small CMB block (512KB
> > > only).
> >=20
> > Hah, that's certainly and odd CMB configuration.
>=20
> Should be okay if it's just for submission queues. The driver has an
> arbitrary requirement that the queues have at least 64 entries for
> CMB,
> and 512k allows us to create 128 submission queues like that. That's
> enough for most systems.

Yes, but this configuration seems to not fit the current driver code
that utilizes PCIe P2P setup code. (Is there any driver that could
utilize this configuration now?)


