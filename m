Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E875710BA426
	for <linux-nvme@archiver.kernel.org>; Fri, 27 Mar 2026 06:20:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	Content-Type:Content-Transfer-Encoding:Date:Message-ID:In-Reply-To:CC:To:From
	:Subject:Mime-Version:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XnJA/5zwAPxZ6vMIZJbzIFubHwh+nIkMH+ZqspPFCx0=; b=uzF9L8RdqhrJq8K/9ADTSsq6Kj
	sCDxU55FueX+XiKZ8/HJ1OkxHHw/QO54Z1q6lEoCVDXDcfi9W/jOcLPvsovVt8IuoLySZJGKxmN7X
	OB6b1b+tuGxwQOZU+9evemSvWjTxRUNk8IrjQoq2qdEILcGD1JRihfbnVbXMcEtwY4hI8z3beVfI5
	mOV/Pw1zGAqUL+r4vlkXjbauA+qHXRT0+IzivB7RLSaqlq9dRUWpLr2M0277MRNGRbzDefT0WOhrb
	U4KbqiufIuD6q3VJWgfFnNs/EYY6Vmawq4edUkfGAhLVjDn+aqZ8KekZD/AtMyDcWOvDKhEFpUYH+
	j3Q4hBsg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w60Y8-00000006lrA-0MIO;
	Fri, 27 Mar 2026 06:20:04 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w60Y5-00000006lno-0owL
	for linux-nvme@bombadil.infradead.org;
	Fri, 27 Mar 2026 06:20:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=References:Content-Type:
	Content-Transfer-Encoding:Date:Message-ID:In-Reply-To:CC:To:From:Sender:
	Reply-To:Subject:Mime-Version:Content-ID:Content-Description;
	bh=XnJA/5zwAPxZ6vMIZJbzIFubHwh+nIkMH+ZqspPFCx0=; b=f7zDVLCoc8m45URLWrOLfUOVLu
	4MM8A6aKydcOgve6yHZBYbngLLDWeMf+4gINlAdqwawA6Irx9t68sAEdwB04b//RBgjJmCKDM7hec
	iQcHJFdZ+OlVSqvNXotlEFA0//w029fFQNNBgF3mBrrC58GIRNiWSWfoXBDGtSPtiwUpiXl2GO4vH
	Lrx9tUttEpU6HGUkOnqGv09JQRk+FGmj+baRTYgrhyXH5wHc/LFSEDPApnT6l68SrGjsVmOKo/ItU
	oGxmw+ly2HK6PDqRcjNgaQtxGBU2DkVB2wcBvo/j4gCjdX9h0vSO0iGHZeWx3ScyYa5MQ9XgaEcRq
	07mUGmJw==;
Received: from mailout2.samsung.com ([203.254.224.25])
	by desiato.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w60Xy-00000009kqI-373q
	for linux-nvme@lists.infradead.org;
	Fri, 27 Mar 2026 06:19:58 +0000
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20260327061942epoutp029816f23990c999a19f0487fb7ed170ac~gnl6Z1Wyi1198011980epoutp026
	for <linux-nvme@lists.infradead.org>; Fri, 27 Mar 2026 06:19:42 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20260327061942epoutp029816f23990c999a19f0487fb7ed170ac~gnl6Z1Wyi1198011980epoutp026
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1774592382;
	bh=XnJA/5zwAPxZ6vMIZJbzIFubHwh+nIkMH+ZqspPFCx0=;
	h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
	b=rUoMx9hoGfks4r+dxmr5olSm/bblUxZcyt4PWgT7YJaBNdPalrNlN0cMvjQol1iJz
	 spAJj3ov5ZFNwm/P1ZcffyGowvWtNOfXs/ZS3bb1XA58vrY5YlcN7fyKFO2w2AyW8V
	 dhigBaDblg2q8IbpIaE8/WEF2q1syAyqZsN+lIxc=
Received: from epsnrtp01.localdomain (unknown [182.195.42.153]) by
	epcas2p1.samsung.com (KnoxPortal) with ESMTPS id
	20260327061941epcas2p17e4702f290bbe98e79942dda2d496d8c~gnl557Uoj3148231482epcas2p1K;
	Fri, 27 Mar 2026 06:19:41 +0000 (GMT)
Received: from epcas2p2.samsung.com (unknown [182.195.38.208]) by
	epsnrtp01.localdomain (Postfix) with ESMTP id 4fhr8Y3HDzz6B9m4; Fri, 27 Mar
	2026 06:19:41 +0000 (GMT)
Mime-Version: 1.0
Subject: Re: [PATCH v5] nvme: Skip trace complete_rq on host path error
From: =?UTF-8?B?7KCE66+87Iud?= <hmi.jeon@samsung.com>
To: Keith Busch <kbusch@kernel.org>, "hch@lst.de" <hch@lst.de>
CC: Justin Tee <justintee8345@gmail.com>, "axboe@kernel.dk"
	<axboe@kernel.dk>, "sven@kernel.org" <sven@kernel.org>, "j@jannau.net"
	<j@jannau.net>, "neal@gompa.dev" <neal@gompa.dev>, "sagi@grimberg.me"
	<sagi@grimberg.me>, "justin.tee@broadcom.com" <justin.tee@broadcom.com>,
	"nareshgottumukkala83@gmail.com" <nareshgottumukkala83@gmail.com>,
	"paul.ely@broadcom.com" <paul.ely@broadcom.com>, James Smart
	<james.smart@broadcom.com>, "kch@nvidia.com" <kch@nvidia.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>, "asahi@lists.linux.dev"
	<asahi@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, =?UTF-8?B?7J207J2A7IiY?=
	<euns212.lee@samsung.com>, =?UTF-8?B?7Lm47LCs?= <joshi.k@samsung.com>,
	=?UTF-8?B?7KCE66+87Iud?= <hmi.jeon@samsung.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <acVGECskf5pg3_MY@kbusch-mbp>
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20260327061940epcms2p576446826c1c5336a57ec19f433122386@epcms2p5>
Date: Fri, 27 Mar 2026 15:19:40 +0900
X-CMS-MailID: 20260327061940epcms2p576446826c1c5336a57ec19f433122386
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
cpgsPolicy: CPGSC10-223,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20260320052101epcms2p42ae135da60b36685e9b7fca6849b57a6
References: <acVGECskf5pg3_MY@kbusch-mbp> <acQxjZMOqj74yIJf@kbusch-mbp>
	<20260320052101epcms2p42ae135da60b36685e9b7fca6849b57a6@epcms2p4>
	<945a3e98-ee75-453c-ae80-f3c9e3e57e58@gmail.com>
	<20260325063333epcms2p60954532c1b65a1665bad6dcdcfd7d62c@epcms2p6>
	<CABPRKS8-x6Tfr90inpz1fR0=8a5HD=mkujtfLJ1h9ikEUjTvxg@mail.gmail.com>
	<20260326014429epcms2p135ffd3c2b2fface6423d045e9614c262@epcms2p1>
	<20260326065152epcms2p51a18d3bbecb6eb6dc2ddba09651e5152@epcms2p5>
	<acVCnozG1WKPkq1L@kbusch-mbp> <20260326143124.GA17507@lst.de>
	<CGME20260320052101epcms2p42ae135da60b36685e9b7fca6849b57a6@epcms2p5>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260327_061956_154672_3DA564AF 
X-CRM114-Status: GOOD (  18.91  )
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
Reply-To: hmi.jeon@samsung.com
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, Mar 26, 2026 at 03:43PM +0100, hch@lst.de wrote:
> Yeah, the spec is not very clear on their use. It just defines the codes
> and a one sentence description, and then never mentioned again. I think
> it allows the possibility for the controller to internally complete a
> command with such status from some undefined OOB mechanism. I'm not sure
> why the host needs to have their own self-generated status codes anyway
> since it can already attach whatever arbitrary flags it wants to its
> private data, like how we use NVME_REQ_CANCELLED.
> 
> Anyway if a controller did return it for whatever reason, even if it is
> a bug, we'd want to see it in the trace.


I've confirmed what you discussed, and it seems like the approach you
proposed is a better one.
Can I send patch v7 as above?

Regrad,
Minsik Jeon

