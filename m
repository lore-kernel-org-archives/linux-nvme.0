Return-Path: <SRS0=ymBk=4T=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D11ADC3F2D1
	for <linux-nvme@archiver.kernel.org>; Mon,  2 Mar 2020 04:32:09 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A2CD2246B6
	for <linux-nvme@archiver.kernel.org>; Mon,  2 Mar 2020 04:32:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Ww9BV6Ih"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2CD2246B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kioxia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=bC2MjBYoo6dECT6s0BcubnKuc4anjGLdvjUlfJh2SKk=; b=Ww9BV6IhHLldaN
	tqWYKF7i+dVSBQgIJmJcBNJHZCVDkkcVVbN9sqfkQOHhLZd+7Sn01r3qD+1uwjK9nI2GaVely1JEU
	GH29WP07LBjzllNaL8U/YJNPpZupu3lAT6UFVJOEjDOcype7vsSDP+9/G20pOgHVspl0jS7lFqvm+
	uv22WbeJ+imk5CEeLzbIH/oXhN2TXcik3l9FHnQ/oOuapQQEdFBhv1uopRTldrjgjsb19NUi9G6eh
	4Xfk1UT1F7dcFyUVdYIvXhFngBWTSrh58L3W8W7yGXMNxAuiY0QTP2OcKNe5aWy/Jsdl4q/jLIKE4
	gUSsoQvQi/rz6OB3MdRQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1j8ckP-0006pV-W3; Mon, 02 Mar 2020 04:32:05 +0000
Received: from mo-csw1516.securemx.jp ([210.130.202.155]
 helo=mo-csw.securemx.jp)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1j8ckN-0006p4-FW
 for linux-nvme@lists.infradead.org; Mon, 02 Mar 2020 04:32:05 +0000
Received: by mo-csw.securemx.jp (mx-mo-csw1516) id 0224VLkZ026820;
 Mon, 2 Mar 2020 13:31:21 +0900
X-Iguazu-Qid: 34tMS0bDK47Se8YtgA
X-Iguazu-QSIG: v=2; s=0; t=1583123481; q=34tMS0bDK47Se8YtgA;
 m=V2/eAlm3BqBCqan/3t+LPaiW6760SY8Xqa/I/6MJDOE=
Received: from imx12.toshiba.co.jp (imx12.toshiba.co.jp [61.202.160.132])
 by relay.securemx.jp (mx-mr1511) id 0224VJbL003938;
 Mon, 2 Mar 2020 13:31:19 +0900
Received: from enc02.toshiba.co.jp ([61.202.160.51])
 by imx12.toshiba.co.jp  with ESMTP id 0224VJj7020887;
 Mon, 2 Mar 2020 13:31:19 +0900 (JST)
Received: from hop101.toshiba.co.jp ([133.199.85.107])
 by enc02.toshiba.co.jp  with ESMTP id 0224VIFS022182;
 Mon, 2 Mar 2020 13:31:18 +0900
From: <masahiro31.yamada@kioxia.com>
To: <hch@infradead.org>
Subject: RE: [PATCH] nvme: fix NVME_IOCTL_SUBMIT_IO for compat_ioctl
Thread-Topic: [PATCH] nvme: fix NVME_IOCTL_SUBMIT_IO for compat_ioctl
Thread-Index: AdXuGMxvHgc8BpX4QzmU2g6f3T18FAAzhnOAAFjp0yA=
Date: Mon, 2 Mar 2020 04:31:17 +0000
X-TSB-HOP: ON
Message-ID: <b30b0bf2864444989f5a4e70eafbe6b8@TGXML281.toshiba.local>
References: <2caa4c913579464bbfdf06b36001ffc9@TGXML281.toshiba.local>
 <20200229185915.GB5698@infradead.org>
In-Reply-To: <20200229185915.GB5698@infradead.org>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [133.118.177.171]
msscp.transfermailtomossagent: 103
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200301_203203_731968_1A92F09A 
X-CRM114-Status: UNSURE (   4.39  )
X-CRM114-Notice: Please train this message.
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: sagi@grimberg.me, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, axboe@fb.com, kbusch@kernel.org, hch@lst.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

>We can't just change the existing structure, instead we'll need
>a compat handler for the 32-bit x86 case.

Thank you for your comment.
OK. I'll recreate this patch which adds a handler for compat_ioctl,
not to change the existing structure.

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
