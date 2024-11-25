Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EEF5D59D60
	for <linux-nvme@archiver.kernel.org>; Mon, 25 Nov 2024 19:17:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vJPs+mIR0Yy608kx/9mrCGfRlolMiuEroEUYso0kgTc=; b=rX4NR1znpkOQasMx9n8RNkkMRX
	V6vRGm4SsxS60Ubd4UIGAYVvmMELvWcdmarfvIt+BoO/1NNT+GSq6+p8Gxdny9fxnzO4oL7fXLkYw
	bK9cbUUjY/i9EoCOgS9QtAJmmpXPgO63VF3m+fegF3MQ+Bhc3Yzpu5qohYCuc1Roik6++fNNKaMHr
	XIkU2RIf2KmlbokIOvui8694QkJaqmIL7kii7edxkv+Yc0EBPQ6RgOIA1qlHMECnbOWQ0+jRZKXh7
	y3G1LcvrvnNjsoTDsSFkFHwIaVGdtu76xCPPHlAEXqfmzpig5qTQCHhZw3tU+oAN8X+yYIOyclxZz
	z4Jfryww==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tFeaT-00000008wpK-1jsu;
	Mon, 25 Nov 2024 19:17:33 +0000
Received: from 009.lax.mailroute.net ([199.89.1.12])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tFeaQ-00000008woB-35Oj
	for linux-nvme@lists.infradead.org;
	Mon, 25 Nov 2024 19:17:32 +0000
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4XxwSp2L1PzlgVnN;
	Mon, 25 Nov 2024 19:17:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1732562248; x=1735154249; bh=vJPs+mIR0Yy608kx/9mrCGfR
	lolMiuEroEUYso0kgTc=; b=OsynLs7qTvqp77EePRk8Qasc4v6iKOUBe75hkwIa
	YdhZQlv46px544B35lTEVOW2nXdtMODh8FpIHb/mk2DRiCRV38UsdQHnIfsQ/sxq
	NIw2UIvIWDs6qA9dqLCVTHg5jjcsEEMs4iOyZe0yLBIxi1v7r/KeP5MFxdzReeyL
	TNxeQRbbcp1EoqN/2h1DDPJ2UO0CpPNNXmQAMcQgV3p90dTbMLky/FuY6fDYsf/H
	EOQycLGra5buhDpNq5tHhGO4sVkZ1o2ygdnI2d8hmNmQ2IR/f87LMBlqVlqdENuD
	iEKbOuoanF+VobTbrQfR1yXteyJoQ4582qBj1XTc4LipsQ==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id vXQvQ_AaO2_V; Mon, 25 Nov 2024 19:17:28 +0000 (UTC)
Received: from [100.66.154.22] (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4XxwSl1Qp7zlgVXv;
	Mon, 25 Nov 2024 19:17:26 +0000 (UTC)
Message-ID: <a6d7f0e0-76e3-424d-8e28-93214a6dce6e@acm.org>
Date: Mon, 25 Nov 2024 11:17:24 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH blktests] nvme/039: check for sector size of test device
To: Bryan Gurney <bgurney@redhat.com>
Cc: shinichiro.kawasaki@wdc.com, linux-nvme@lists.infradead.org,
 alan.adamson@oracle.com
References: <20241125162904.7326-1-bgurney@redhat.com>
 <7a220428-59fb-4b2a-8d67-ecbe40cba037@acm.org>
 <CAHhmqcSwxbvySBdb_mWhOXZBfiXZOv-frD_5bkvhJhs8rnO=7g@mail.gmail.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <CAHhmqcSwxbvySBdb_mWhOXZBfiXZOv-frD_5bkvhJhs8rnO=7g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241125_111730_791974_36B536BF 
X-CRM114-Status: UNSURE (   6.04  )
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

On 11/25/24 10:27 AM, Bryan Gurney wrote:
> Yes, I can do that.  Does "LB_SZ" work?

That sounds good to me :-)

Thanks,

Bart.


