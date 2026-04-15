Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64DD8FA0C50
	for <linux-nvme@archiver.kernel.org>; Wed, 15 Apr 2026 08:41:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	Content-Type:Content-Transfer-Encoding:Date:Message-ID:CC:To:From:Subject:
	Mime-Version:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	bh=D6tryYkXEnIZ3Q/MHDH+/SYv72l+3TLo8ow/vCVPAfg=; b=11AFTS8onLqutaMyAQD9HLTM2E
	x1Yb3RApHc/SXKPdLhqli9bYMH+PTlzkngHjQ5ZaPB4trUpU0lt4UW2EjsKD0kbq3dsTlsEQG9fnH
	uIVbMEy9JquabCJA58+IV3L7/7VHFYJbvKnu+GkxmvAl8ERSsyXDLjH7Hu7W/YSc8FPeMfS35Yg9c
	+1TCsB2fdVu3ruHmbuVXEGMIiK6FEjgQkShA4rZri8aIzLW+PMXGYfZOX0LSsU+c31AceeDIAChiZ
	ozW3BLkDJJbIGTOeMAU4tmqp1uJQs3czNyCfx7CkSFA4m/pGfgrTofuXp0Gcl5ff6yCI7PFyNuIUR
	1zylOzmA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wCvoJ-00000000pzF-0o1R;
	Wed, 15 Apr 2026 08:41:23 +0000
Received: from mailout3.samsung.com ([203.254.224.33])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wCvoF-00000000pyB-1iRz
	for linux-nvme@lists.infradead.org;
	Wed, 15 Apr 2026 08:41:21 +0000
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20260415084108epoutp0377679f9c001dc1687d03184cde8ea579~mex1PMabT0961209612epoutp03i
	for <linux-nvme@lists.infradead.org>; Wed, 15 Apr 2026 08:41:08 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20260415084108epoutp0377679f9c001dc1687d03184cde8ea579~mex1PMabT0961209612epoutp03i
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1776242468;
	bh=D6tryYkXEnIZ3Q/MHDH+/SYv72l+3TLo8ow/vCVPAfg=;
	h=Subject:Reply-To:From:To:CC:Date:References:From;
	b=QV0aoYOzx3dSRD0wbpKXpR9/0QqLPB8tFAnvcNj1Y/Qd2orzXfM3Px1oQeuJorhDV
	 51cEJi9XMdGQyhM5fplBbyu8FyYWV5e13N1BaYaHr1TBGd0Hx4RwzJ1q4XqSMOQoIc
	 PXvPEwDZiIW0vAOv6ze3JqKH4T/i7VNE9NMGSzvQ=
Received: from epsnrtp04.localdomain (unknown [182.195.42.156]) by
	epcas2p2.samsung.com (KnoxPortal) with ESMTPS id
	20260415084108epcas2p275f275673985b535b0862157143099f3~mex0ultJl0724207242epcas2p2K;
	Wed, 15 Apr 2026 08:41:08 +0000 (GMT)
Received: from epcas2p2.samsung.com (unknown [182.195.38.208]) by
	epsnrtp04.localdomain (Postfix) with ESMTP id 4fwZNz6xcNz6B9m5; Wed, 15 Apr
	2026 08:41:07 +0000 (GMT)
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
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20260415084107epcms2p71b9c0d252180653ab96a9f5f2121be71@epcms2p7>
Date: Wed, 15 Apr 2026 17:41:07 +0900
X-CMS-MailID: 20260415084107epcms2p71b9c0d252180653ab96a9f5f2121be71
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
cpgsPolicy: CPGSC10-223,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20260415084107epcms2p71b9c0d252180653ab96a9f5f2121be71
References: <CGME20260415084107epcms2p71b9c0d252180653ab96a9f5f2121be71@epcms2p7>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260415_014119_970331_BD939D45 
X-CRM114-Status: GOOD (  10.61  )
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

Hi Keith, hch

Gentle ping for review on [PATCH v5] nvme: Skip trace complete_rq on 
host path error.

I agree with your propsed approach. Should I send a new version(v6) 
based on that?

