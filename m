Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30272CD6E60
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Jun 2026 23:23:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DoFQuUn//VEPKHTxWpoyKGMURH99p4nsZgAVxAI31mU=; b=qhZUz2Y/rR1WhdmFEbJePomUVM
	U9q9Pf0/U4OJQTlD1Ei2/ZpfVeVw4Ka5u3XJ5T3H6CSsmRT7FSsFoz8DIHOVjCmHCXLMZMXgafo/K
	LUIxiN+YN/L9ylfyvZ/vxEw1xrGYovHmkENdMKvADsQMHW4lFevP6vY1Jjh5aY5Dlcy50KQZNGRz/
	kk59v4MY+DdP6Sld94y52jz6vfC2B4gxUtX7d6WOo6Zj9gFPMAr0WkTRQiwvavj/Y1Lqp2B0t9QUn
	s/YA1jQqv1ebSZmPaM9fKGN22lqTVzj9IEXhIwgjIWwGD9m7BI1iJ0Qpvo+8mbMPlW0bWlMtAPgnB
	AxQahv6A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wUuw8-0000000Fvqh-1Rkk;
	Wed, 03 Jun 2026 23:23:48 +0000
Received: from mail-qk1-x72c.google.com ([2607:f8b0:4864:20::72c])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wUuw0-0000000FvqO-1T0S
	for linux-nvme@lists.infradead.org;
	Wed, 03 Jun 2026 23:23:41 +0000
Received: by mail-qk1-x72c.google.com with SMTP id af79cd13be357-9157b94a07aso24164985a.0
        for <linux-nvme@lists.infradead.org>; Wed, 03 Jun 2026 16:23:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780529018; x=1781133818; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DoFQuUn//VEPKHTxWpoyKGMURH99p4nsZgAVxAI31mU=;
        b=fnfir+xo6yVvfEiNr2TAkPHPGcSyL5lYVwhSeRdj57/x8+E4ZtyoYv4/26MTiIX+to
         pe/KmgOlQhYGeCNmg6YjmiEIVHpMc1SxR+KjWVw/7FpO8nljaOS56PgbUNpU7o6FzxUE
         +6ZjzJ0Rq0hzzzFw9GeO9BxOar+yJdAcP1t5ZCHjaQvdaDr9y3Eu83E9gxrd1ZVAqt3H
         f1UbZj+zaSnQSqAfkaCXXw95lKxLLEkHbxUX61MW0nXZ27LwdEGLWBymgDc/kJyzyW+O
         sh3d+CqszTQV8ep0lLWDsaV5fJvTGcXzbV/LF5OpM1JpsrKuCZiiaOx+86cdB3i6wh1b
         tJIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780529018; x=1781133818;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DoFQuUn//VEPKHTxWpoyKGMURH99p4nsZgAVxAI31mU=;
        b=Mqb36TWPw32qJls19gM6FvShpHd1VGm4YapB2qLxlXWBYlO0psFiKz51bKEgdtFq42
         0hSc468xvRJS4PnsSXRoaCSMnIBWNsN8HWlkSlRTVF6psoAmnn4SgWCsD1Vfa0BJNsjL
         u4uNKIP/8KdMHS4s9kFZFDMJDdy0tp5Q/nxl3fC4w7nQqNUlfOcd4geQMO/+QSI81wko
         iWthlWkHLXz0ltX/R3PMp1xGhAB00S68P1EelX3WD0KBParLfwpuOQiXQhPYFWFR+YaI
         o/hKWXmPH0H0LQ3EFCgODn9L2YsyS46/wI63qQLm7L0zx5BJI3s++P2ede1R9uONQYms
         OvsQ==
X-Gm-Message-State: AOJu0YxjfsEZBx6PM8PpYFu5eonzrAoHKvT2GESp66bFfdqRvqF+LPod
	xUbJWgxY4FtAl/yo7Nn92SXGGYUKF1+3kY5BMwhiQTh19yVJ6W/GcgXb
X-Gm-Gg: Acq92OGubXu4Vm7pQIV8c7qlG7EeKAmqeESvfFwILO2ai78MhLysEdhNc1LmoJxcvH7
	Tlpd5TxDgEWeRgjnLFqpgo6qhZhu5o0aNw9Ld5xCoNBMNcFzVnWxdTlXpRn22ja+BfTWNQUD08f
	i+bkQVmgGp8g9ibxojRt2oLY93gXw/eENWTpOmifGnKThhaQQhd+auFCWCsXqeDrASiW5oNaHbH
	PVrSQCNsNll6zZlKzF3j1swNFI//d0zFHU1dRuwhIEv0CMEYWct1PWV80hMFTx5BHaJd3BFq7kk
	LH0nOqEMtzFwiAImQNAGa2lpuDKU8rBUSp+TBv7TkdGFKd/Leb2oPesBhSDZNsNm0ctjrENkZ4g
	ITMo9EU7tTs0VHVkHNqiRI3Ceat4ItaX2HKuCSOIVlqBN+9XRyq+qbmSe+KxFsDtnHywhHYfr49
	kHSmLoJaN/GEiqEXIEZ+reuYxqbhgba+dTaNdcOFsTkrOhbWLCeANZeDUvwGr3jm88HltS+3sl6
	BMQ7srOqbIEOWo=
X-Received: by 2002:a05:620a:630a:20b0:915:10b7:36e2 with SMTP id af79cd13be357-9158a656e5fmr695748285a.12.1780529018426;
        Wed, 03 Jun 2026 16:23:38 -0700 (PDT)
Received: from [10.69.73.69] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9158a3e35dbsm392890685a.42.2026.06.03.16.23.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jun 2026 16:23:38 -0700 (PDT)
Message-ID: <56c826df-efe7-4c48-9142-c32c8e3415a8@gmail.com>
Date: Wed, 3 Jun 2026 16:22:05 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG] KASAN: slab-use-after-free in nvmet_fc_tgt_q_put
To: Shuangpeng <shuangpeng.kernel@gmail.com>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 justin.tee@broadcom.com, nareshgottumukkala83@gmail.com,
 paul.ely@broadcom.com, hch@lst.de, sagi@grimberg.me, kch@nvidia.com
References: <F54D7903-EA2A-4DF8-92BD-839877786139@gmail.com>
Content-Language: en-US
From: Justin Tee <justintee8345@gmail.com>
In-Reply-To: <F54D7903-EA2A-4DF8-92BD-839877786139@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260603_162340_395474_3B51A052 
X-CRM114-Status: UNSURE (   4.59  )
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

Hi Shuangpeng,

I will look into this and get back to you, but typically the nvme target 
fcloop module does not indicate a real life issue when utilizing the 
nvmet-fc stack on actual fibre channel hardware.

 > on commit: e8c2f9fdadee7cbc75134dc463c1e0d856d6e5c7 (May 25 2026)
Was wondering what this means?  Because it doesn’t look like that is an 
nvme commit.

Regards,
Justin

