Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34B8BC2BD09
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Jul 2024 11:45:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CjnIi1uCAvQ4YfIda9dkW5TyYzEKDEaiXzsXvnheRwI=; b=H0nB2vnXVO7RPAp2RHOwu/nDoz
	dQvxLgkx5q67iYTSYY6r7bijyiLOdNMO4PhyIWzkhsOGLW3/DDEJcWVu7Tm/tkKD70GPWfvrnzpcE
	YvOGamrHA39+T1z36U4bjL+tzsbfRvD9tQwtr3J7zHiAhCcdDbFzZZXMyeZXiXRJkcmouYGRsaEwb
	FRpXG0WxoPGDWmD2PulMk4bS/5J3XGpFls87yn7wIp5lS6NeDViJjK84mgxg1ACXI+PvYsm1oIlD7
	lsrw5USgNGOEKk7oz8sWafR5cWrGjVk4p/Kud/fIgb4dfXX6TXY6vZRoIrFFYHVNXC7Qexh6cdR78
	RnZkqL1w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sOyQl-0000000A3VI-1Ptn;
	Wed, 03 Jul 2024 11:45:47 +0000
Received: from smtpbgsg2.qq.com ([54.254.200.128])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sOxNs-00000009oqx-470x
	for linux-nvme@lists.infradead.org;
	Wed, 03 Jul 2024 10:39:05 +0000
X-QQ-mid: bizesmtpsz9t1720003071tpz2sub
X-QQ-Originating-IP: tPq2Z00b0loLhBPfxiZCnsYVWGynSo7q+PcRQPMmOtw=
Received: from [10.20.53.89] ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 03 Jul 2024 18:37:49 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 17256580716429354049
Message-ID: <2B5581C46AC6E335+9c7a81f1-05fb-4fd0-9fbb-108757c21628@uniontech.com>
Date: Wed, 3 Jul 2024 18:37:48 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] nvme/pci: Add DEEPEST_PS quirk for Lenovo N60z laptop
To: kbusch@kernel.org, axboe@fb.com, hch@lst.de, sagi@grimberg.me,
 guanwentao@uniontech.com, huanglin@uniontech.com
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <C0A44727E997523C+20240703101513.72590-1-wangyuli@uniontech.com>
From: WangYuli <wangyuli@uniontech.com>
Autocrypt: addr=wangyuli@uniontech.com; keydata=
 xjMEZoEsiBYJKwYBBAHaRw8BAQdAyDPzcbPnchbIhweThfNK1tg1imM+5kgDBJSKP+nX39DN
 IVdhbmdZdWxpIDx3YW5neXVsaUB1bmlvbnRlY2guY29tPsKJBBMWCAAxFiEEa1GMzYeuKPkg
 qDuvxdofMEb0C+4FAmaBLIgCGwMECwkIBwUVCAkKCwUWAgMBAAAKCRDF2h8wRvQL7g0UAQCH
 3mrGM0HzOaARhBeA/Q3AIVfhS010a0MZmPTRGVfPbwD/SrncJwwPAL4GiLPEC4XssV6FPUAY
 0rA68eNNI9cJLArOOARmgSyJEgorBgEEAZdVAQUBAQdA88W4CTLDD9fKwW9PB5yurCNdWNS7
 VTL0dvPDofBTjFYDAQgHwngEGBYIACAWIQRrUYzNh64o+SCoO6/F2h8wRvQL7gUCZoEsiQIb
 DAAKCRDF2h8wRvQL7sKvAP4mBvm7Zn1OUjFViwkma8IGRGosXAvMUFyOHVcl1RTgFQEAuJkU
 o9ERi7qS/hbUdUgtitI89efbY0TVetgDsyeQiwU=
In-Reply-To: <C0A44727E997523C+20240703101513.72590-1-wangyuli@uniontech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpsz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240703_033846_307868_4D1741E7 
X-CRM114-Status: UNSURE (   6.55  )
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

Sorry, please just don't merge this patch!!!


Just a few minutes after I sent this patch, right now (after I quiesced 
this lenovo n60z laptop for 10 hours),

its nvme disk crashed again! Just like before, nothing can wake it up 
except a reboot.


This is very surprising and it seems that only 'NVME_QUIRK_NO_APST' is 
the correct choice.

I'm sure that 'NVME_QUIRK_NO_APST' will not have the same problem, I 
have tested dozens of devices of the same model before.


I will send patch v3 to revert the code to its original state.


-- 
WangYuli <wangyuli@uniontech.com>

