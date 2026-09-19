Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77DB1C982D7
	for <linux-nvme@archiver.kernel.org>; Sat, 19 Sep 2026 07:58:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:References:To:
	From:Subject:Cc:Message-Id:Date:Content-Type:Content-Transfer-Encoding:
	Mime-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0HqoWMrXdNO5OfQgnTTPtNIXED40IV8fU6rDuuYARqI=; b=AQMC2P4/Ghl8javV4/SAqHrXVA
	GF241JaITte43RBxcKeSnVEym7UpsyqhC9/Sq5P9wAqeKBrKtTUNUwZzP7NAZFqLnnOmmSs9z6FR2
	VeAGMkQUoM0ZKwckc0UbGoBMA5C1v/sO73MlFdUNuNBS4zJAt+P5y1v8rsoVcz0pxORREiAPCQCKU
	L64BfpHo0tfZOcR/UVrwhGFFkXFhlHSKepUboDqvF46EZBuU0lq5A6Dbl6brERtdNWQmJclUmG1Wb
	a5wiPQ40nuTtxts+NFdRPxuaDhGNOXGf4w9veQoDgJIOiH7qNDj9Iovxp64OlsALvUrwBppYDQdDc
	vix2jp+A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x7pxT-0000000G5Sx-0brr;
	Sat, 19 Sep 2026 07:58:03 +0000
Received: from 128-116-240-228.dyn.eolo.it ([128.116.240.228] helo=arkamax.eu)
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x7pxQ-0000000G5Se-3RXo
	for linux-nvme@lists.infradead.org;
	Sat, 19 Sep 2026 07:58:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; s=mail1; bh=0HqoWMrXdNO5Of
	QgnTTPtNIXED40IV8fU6rDuuYARqI=; h=in-reply-to:references:to:from:
	subject:cc:date; d=arkamax.eu; b=dyeQMdacFdNOkNT3Q+GqDPR/AfxG96L3SIDuX
	xYuEouDjAdGBjBDnQ/S7PcPSRDci0dDce6PWljneC89Wtqh8WVEB2U8QSLggQVxrr2JoZ6
	cKqx4Qn64itO89S1+kqM/0yGT/Mk4rIlJ8AUP6nBxoluudCn8OnLXQNbhbNxc/JiDJNjMY
	q18Hj8PxSWUy124OVpPyufssRMwchD3NKHnB44wZF8DcqWYu3Ocec4CMRSpKfk73l7jeKK
	kQs6lDT8DQ0JvNVptYepomm6jZ8M4nDCihJzqI5Qh7PnHWBrSrSmfcEFFvBRUJ3tmSSCws
	6NvIdCSzV1ozV/pZmER3Y3Fow==
Received: from localhost (128-116-240-228.dyn.eolo.it [128.116.240.228])
	by arkamax.eu (OpenSMTPD) with ESMTPSA id 0d7dc368 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Sat, 19 Sep 2026 09:57:58 +0200 (CEST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 19 Sep 2026 09:57:58 +0200
Message-Id: <DLJ4T2GRQSA7.1NN9YA9M8XUDK@arkamax.eu>
Cc: <hch@lst.de>, <sagi@grimberg.me>, <kch@nvidia.com>,
 <linux-nvme@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] nvmet-tcp: report a bounded MDTS instead of "no
 limit"
From: "Maurizio Lombardi" <mlombard@arkamax.eu>
To: "Maurizio Lombardi" <mlombard@arkamax.eu>, "Ing. Alfonso Kuen Arroyo"
 <gerencia@idkmanager.com>
X-Mailer: aerc 0.22.0
References: <DL41D2NGEUHW.2UUHTZ6LLM9X7@arkamax.eu>
 <178978683646.43804.6940923486189370705@idkmanager.com>
 <DLJ4POIDTYXQ.2AOJP9BJAWEOX@arkamax.eu>
In-Reply-To: <DLJ4POIDTYXQ.2AOJP9BJAWEOX@arkamax.eu>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260919_005801_200699_A9CFDE92 
X-CRM114-Status: UNSURE (   6.16  )
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

On Sat Sep 19, 2026 at 9:53 AM CEST, Maurizio Lombardi wrote:
>
> Yes, but your patch sets NVMET_RDMA_MAX_MDTS to 8, which means 1MiB, not
> 4MiB, so a 2MiB command should be rejected, even if it's under the MAXH2C=
DATA
> limit of 4MiB; or am I missing something?
>

Typo, I meant NVMET_TCP_MAX_MDTS, not NVMET_RDMA_MAX_MDTS.

Maurizio


