Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF0FEC4167B
	for <linux-nvme@archiver.kernel.org>; Thu,  7 Dec 2023 14:22:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JYg2Ua18gfoK91NYq0zgMpgjLm5CM5Tzubo/eGrnCN0=; b=sXE9wm2iNjgwHrEyygrQPzBztL
	Noi4/E5lgr0WH1HVHIL1rTFgydNwF6r2O/22RPWvo6g1Swle8mSFesKKV1R9tjgCOLV5QdEO2/E2A
	tT3yn/G7mUI/YYJKQeGLFXdymzywCB6GiONvDMLQZ4ulktex9tO4hMpooKrHkF59kPeL7CH2w2DiS
	KWZcYFmy0trKNEYgAPh8WSXeVf88gTL/oYcwt25l+qhuP9zAefekH2SlazW86gBdsuQzb7jk/Q5iy
	xf5F9bPm7r96SDFbNleKRoui8YrYk8IJhAAGxsx7HJB2Q+kzltzIwWy3Q4bwYwsgXht5PiMzWBJUw
	1tt+VuHw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rBFGS-00D0a3-2A;
	Thu, 07 Dec 2023 14:22:08 +0000
Received: from mail.tuxedocomputers.com ([157.90.84.7])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rBFGP-00D0Z1-0k
	for linux-nvme@lists.infradead.org;
	Thu, 07 Dec 2023 14:22:07 +0000
Received: from [192.168.178.76] (business-24-134-105-141.pool2.vodafone-ip.de [24.134.105.141])
	(Authenticated sender: g.gottleuber@tuxedocomputers.com)
	by mail.tuxedocomputers.com (Postfix) with ESMTPSA id B51292FC01FB;
	Thu,  7 Dec 2023 15:21:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tuxedocomputers.com;
	s=default; t=1701958916;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JYg2Ua18gfoK91NYq0zgMpgjLm5CM5Tzubo/eGrnCN0=;
	b=R/5e5cgtTOfpzfdej3UkNEmlkDTvc7oF3LwcIUnycinpxhqJjp/mOu/dzU/oDwU9/HqgYy
	LNF5K+EHHMP+9WgeTJpSN7+rvf0RbA+RC/3j3SUQME+/UME0zJs4kIsGh5q+8ey15daE81
	zB5RdrdVw593+cwUIQU3zhDSRCxKdbY=
Authentication-Results: mail.tuxedocomputers.com;
	auth=pass smtp.auth=g.gottleuber@tuxedocomputers.com smtp.mailfrom=g.gottleuber@tuxedocomputers.com
Message-ID: <c930e543-7dab-4559-95d2-270b8df38f3b@tuxedocomputers.com>
Date: Thu, 7 Dec 2023 15:21:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme-pci: Add sleep quirk for Kingston drives
To: Christoph Hellwig <hch@lst.de>, Werner Sembach <wse@tuxedocomputers.com>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Sagi Grimberg <sagi@grimberg.me>, Georg Gottleuber
 <ggo@tuxedocomputers.com>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20230920085210.22573-1-wse@tuxedocomputers.com>
 <12d32e8e-e20b-4023-8299-39d2a69c0cd9@tuxedocomputers.com>
 <20231206092420.GA27348@lst.de>
From: Georg Gottleuber <g.gottleuber@tuxedocomputers.com>
Content-Language: en-US
In-Reply-To: <20231206092420.GA27348@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231207_062205_750605_459FBE18 
X-CRM114-Status: UNSURE (   8.40  )
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

Am 06.12.23 um 10:24 schrieb Christoph Hellwig:
> What does save a lot of power mean, and why does it only apply to
> some platforms?  I suspect the more likely case is that APST is
> simply completely broken on this device?

Hello,

power consumption in s0ix varies depending on mainboard and NVMe SSD. 
Some examples:
Board,           nvme(id), mW w/o patch, mW with patch, kernel
NS5X_SN7XAU,     0x500f,   2691mW,       487mW,         6.2.0
NS5X_SN7XAU,     0x2263,   2262mW,       741mW,         6.2.0
PH4PRX1_PH6PRX1, 0x2263,   3042mW,       760mW,         6.2.0
NS5X_SN7XPU,     0x500f,   3135mW,       779mW,         6.5.0

All measurements were taken with the battery disconnected and a
modified adapter plug.

I don't have a deeper insight into APST to judge whether something is 
not working. But all other NVMe SSDs we have tested sleep with a power 
consumption below 2W (Samsung 970 Evo, Samsung 980, Corsair MP600 PRO 
NH, other Kingston NV1 with ID != 0x500f).

We originally noticed that newer Kingston NV1 (with id 500f) led to 
higher standby consumption. With some trial and error I came to the 
conclusion that the problem lies with 'Simple Suspend'.

Kind regards,

Georg Gottleuber

