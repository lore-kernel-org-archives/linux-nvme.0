Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02327CCF2D6
	for <linux-nvme@archiver.kernel.org>; Mon, 19 Oct 2026 10:33:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:References:To:
	From:Subject:Cc:Message-Id:Date:Content-Type:Content-Transfer-Encoding:
	Mime-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=o+cEQzUwUk+7icTlPi/hqgZTFbYbkqmaP1txcpqcsp8=; b=jFWCqzJv0/+pO4yfwszqCqjiYI
	hdl4nVItvc0NyYeKqeNPCXszFiJqWbrBoZni467Ml0xeYJSuXeVuxIFxOkDesE99zXpn8ByETgHWD
	GlJMlY9CeDvsNVd1xhXL5u3ErrR90m16sLoAeWi6Wuycrk8VYDTS8PD9+V2uzbWk3/RjM5m8Ic2xh
	ySj82lZ4iV3PDrf6nGifDnxhyj5DdI0HJt/EI+bQTssZRgelc5vkV2q6hLKzzIhNg20ypMzUlPkT6
	lZL5cB+IZNAAr2okLTxpO7UKDcSSmcD0NcI/HLP0LrqyGL6EWABCetDqeQYBkHVEiDy2l/5Yh1F/7
	qz2Nry1A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xIkgW-00000007Cyn-2voj;
	Mon, 19 Oct 2026 10:33:40 +0000
Received: from 128-116-240-228.dyn.eolo.it ([128.116.240.228] helo=arkamax.eu)
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xIkgU-00000007Cy0-0ugV
	for linux-nvme@lists.infradead.org;
	Mon, 19 Oct 2026 10:33:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; s=mail1; bh=fH5+pyqS19kg8f
	ahTGU24ILZEIcgl731ctrI3o40LaM=; h=in-reply-to:references:to:from:
	subject:cc:date; d=arkamax.eu; b=jzmmzP7KDDxbg5bohm67/+z1iP4LKrkEf3ydY
	azquM006oH1PgmTKfWR0pZGbIG2OoeecMbuwsTS5gH7ArOzNyCOfM2hR7/P64K0SKJ9OH6
	LGVGzOgFmSxHBJUfWmeKvTXxB11MfJ8Y3T46RSybvNGriYAITG+kkl+6OHZJ42jDi2IeMn
	0ZBlOCpIaV2bl209h5yPRd0F8uvEJLfTFRdcLljMTadLLRU5Nqc5avIC75RgCRz+1LiQ76
	iHf/LHPQAAkfQJva/i4ZC9cVYIugzCZu8imR7+8tKT4qHdIqyLi7hdaqLaKHY7uAV2VwIR
	IFXSaRcuhZGR3soFrSvdMgiIw==
Received: from localhost (128-116-240-228.dyn.eolo.it [128.116.240.228])
	by arkamax.eu (OpenSMTPD) with ESMTPSA id 9ef07066 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 19 Oct 2026 12:33:33 +0200 (CEST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 19 Oct 2026 12:33:32 +0200
Message-Id: <DM8QWISGYBCZ.FC52WMOJDZDF@arkamax.eu>
Cc: <linux-nvme@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: nvme-pci: nvme.quirks= on the kernel command line hangs early
 boot when nvme-pci is built in
From: "Maurizio Lombardi" <mlombard@arkamax.eu>
To: =?utf-8?q?Ram=C3=B3n_Jes=C3=BAs_Miranda?= <ramonjesusmiranda@gmail.com>,
 "Keith Busch" <kbusch@kernel.org>, "Jens Axboe" <axboe@kernel.dk>,
 "Christoph Hellwig" <hch@lst.de>, "Sagi Grimberg" <sagi@grimberg.me>
X-Mailer: aerc 0.22.0
References: <20261018155426.1299676-1-ramonjesusmiranda@gmail.com>
In-Reply-To: <20261018155426.1299676-1-ramonjesusmiranda@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261019_033338_894632_A276EF14 
X-CRM114-Status: GOOD (  12.62  )
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

On Sun Oct 18, 2026 at 5:54 PM CEST, Ram=C3=B3n Jes=C3=BAs Miranda wrote:
> Hi,
>
> Passing nvme.quirks=3DVID:DID:QUIRKS on the kernel command line with
> CONFIG_BLK_DEV_NVME=3Dy hangs the kernel immediately, before any console
> output, on arm64 (Microsoft Surface Pro 11, X1E80100, 7.2.8).
>
> As far as I can tell, quirks_param_set() runs during parse_args() for
> built-in modules, i.e. before memory management is initialised, and it
> allocates there. As a module (nvme.quirks=3D handled at module load) it
> works.
>
> Removing the parameter boots normally. I have not checked other
> architectures.
>

Hello, USB also allocates memory in that callback... but there is
a small difference...

Could you please test the following patch? (Compile-tested only)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 77317e5d00f9..6699c7da4b5a 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -243,7 +243,7 @@ static struct kparam_string quirks_param_string =3D {
        .string =3D quirks_param,
 };

-module_param_cb(quirks, &quirks_param_ops, &quirks_param_string, 0444);
+device_param_cb(quirks, &quirks_param_ops, &quirks_param_string, 0444);
 MODULE_PARM_DESC(quirks, "Enable/disable NVMe quirks by specifying "
                                                "quirks=3DVID:DID:quirk_nam=
es");


Thanks,
Maurizio

