Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 348B4CD342C
	for <linux-nvme@archiver.kernel.org>; Wed,  6 May 2026 20:50:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8WGeH7RqjHCg76bCCZr770JcCfZkQPDQ6i0iWRywDEQ=; b=M0xiXFPxWY7IeVxowzTan82YWg
	va6aJGz9E7wPKch9JaKcV6ywPI+Fw97BY4NYA1LAb0A/e2/hkUQIjRsypoH8b4k4i8GOF3RxdD8+/
	ASsyizuFD0Y2ULNDSUEkoCUeZjkxdsdFbIZq4NZmFh+e7jvOeFlo5BlQcbUAgYajFrWXoRP0ReTkB
	nuBSYD6DGtvLw4a9BQEq1HJfJdhXD7xzGDLgibI3uYT2k+VM4MstIyHLCD90OYpo+eXM/EeKd8wRb
	FWRAQDT3xZZuuC6pAsF9o9bvmCnpQGn7sUwe35z/oR3Rbsek8Y+xs02+TWnsDUVkOJr3/eSotGcXG
	sAYdJ9jw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wKjCl-000000022y8-2v8z;
	Wed, 06 May 2026 20:50:51 +0000
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.53])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wKjCk-000000022xW-0YrB
	for linux-nvme@lists.infradead.org;
	Wed, 06 May 2026 20:50:50 +0000
ARC-Seal: i=1; a=rsa-sha256; t=1778100631; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=KvOXov0oLKsMDrYDhfIEM71hLQtAlrdfSYtY/WpNI1GNavaAX4y5WOAyU5B0vFhLiT
    18YjM6frLpaQLUsJq78YcizfyLWskL2mUsuVqsIR/AYHcay+rbP3J6i9rI5nYcG0bnvT
    Zoe2mFjnuVxzIf07NIX+fMsjBgGGzirTNoyEzwDvX8v2XD+ZF00bburQdynbvRnNj18c
    pfzTu28fPipdRSoMbPpvh8CzYkf0a7aVfuITTt0BKKKtWMG8fKkr6CwkDPI/tSFWUC5j
    mudn7tTCw0IA2BjEqSjdYmgVQ8WHGJAKp5A17H9Phtu42VWhmnllk65BX+hZMebyi2j3
    Z0/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1778100631;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=8WGeH7RqjHCg76bCCZr770JcCfZkQPDQ6i0iWRywDEQ=;
    b=T1369zBrIrfRPdEuQhm+bx2hNxwHwkRWsjtK9mgq52Jc9bfTrf+oNPr53L+8JIdqC5
    7eUp0MRI4FzXaO+A2mRgh/K5DcLYsm34HcOlQz+XrrZ8lk6sXTSA9Tk7wBsqYqhm4ZSZ
    mZjYCWongSxSoxjFkQUfRCxzeRoR++EAu0MtMryfYlrmzEOhAXM1f/ocOCgx3KloDS3L
    IrlLQFuTmUr2rKitFfqCos9XgcAFdbZyTsE2PDDC4l2i1PGpvEPWlE7TFfFXm5qe+Jj6
    FptQzHmgD2v5g0VHcNma7TSp6KmGr2HubtH98uy9UwDrA4+V7OOF8vKcmeuUbwIAW0Tq
    IOjQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1778100631;
    s=strato-dkim-0002; d=iokpp.de;
    h=References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=8WGeH7RqjHCg76bCCZr770JcCfZkQPDQ6i0iWRywDEQ=;
    b=rz0wiy2WH/Cy9gP3pFSrpxExBSF9miMX3DB1e2zPc1WN5FpEoS3100EBuaWUMI9eSr
    tw/+VvMB+wl04c34i2391Xcy3014RHbegfNUsW715sPJoeOV5anQeCnAKCTMlWv0cIcY
    gosatAlT/e/B7XBQPl4auJsJ+ZK2yh36PNz/cH/CErptu/7tKGSLPNmgViAEnBYy47Ih
    732k3WpzHH+ickSoArvibYgyZxCP/ACbTf5LLnZILDVSR8gZziES3fT74KY6p8x7nhRn
    EAiEcyoOuLiy91HKu3y8GVZWp3u/UiOI86n2Pr0tyIp1QyIu5cg5RsiDmcEZc6QpvMbI
    CeJg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1778100631;
    s=strato-dkim-0003; d=iokpp.de;
    h=References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=8WGeH7RqjHCg76bCCZr770JcCfZkQPDQ6i0iWRywDEQ=;
    b=aDw2XWlJuYCyPnqIPyLLDyS6hJ8UgjQLxTlPHrcvOelaVIyP67stCBIPkwtL//IbRz
    C7vNn4VK+c2yPtCAmEDg==
X-RZG-AUTH: ":LmkFe0i9dN8c2t4QQyGBB/NDXvjDB6pBSe9tgBDSDt0V0DpulXBkei/nxYyYL8UZ"
Received: from [172.20.1.251]
    by smtp.strato.de (RZmta 55.0.1 AUTH)
    with ESMTPSA id z79345246KoUJ2X
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Wed, 6 May 2026 22:50:30 +0200 (CEST)
Message-ID: <bbfffa354419f933e8c201bd8211f891298bd04a.camel@iokpp.de>
Subject: Re: [PATCH] nvme: skip I/O Command Set specific Identify Controller
 on pre-2.0 devices
From: Bean Huo <beanhuo@iokpp.de>
To: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>, 
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, Bean Huo
	 <beanhuo@micron.com>
Date: Wed, 06 May 2026 22:50:29 +0200
In-Reply-To: <aftCV3rDk3yeWA1d@kbusch-mbp>
References: <20260503200243.2968366-1-beanhuo@iokpp.de>
	 <20260504043655.GA9013@lst.de> <aftCV3rDk3yeWA1d@kbusch-mbp>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2.1 
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260506_135050_436601_1562A9E0 
X-CRM114-Status: UNSURE (   9.69  )
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

On Wed, 2026-05-06 at 15:29 +0200, Keith Busch wrote:
> On Mon, May 04, 2026 at 06:36:55AM +0200, Christoph Hellwig wrote:
> > No.=C2=A0 NVMe allow TPs to be implemented on devices claiming earlier
> > compliance.=C2=A0 We've had this patch and this answer probably half a
> > dozen times now.
>=20
> The proper solution is that vendors need to have their controllers stop
> logging pointless errors that don't help anything.

Thanks Christoph, Keith.

I wasn't aware that TPs can be implemented independently of the spec versio=
n
claimed by the device. I'll drop this patch and follow up with the vendor
instead.

Kind regards,=20
Bean

