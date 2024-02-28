Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CECBC5478C
	for <linux-nvme@archiver.kernel.org>; Wed, 28 Feb 2024 01:46:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hkcLQkbySrTdbjhxHQrPUETIcbjp7Rn1tSQdXwrRRyw=; b=UILgC8JBkgdmHMsr+13n/d3ir+
	E6IXyVK7i/BW8NgYIeVchsgkdbE+trJT2H+HmRaqDzugfic45WRnJN2/vJymdhC7UvyvLtQPK+nZX
	Fnfge+MxrK5Uw+CLZ2QimiK1GfA7iFsJYZ1omKVyeC3SG+SpSnqvMPAYY0Pat1YxPz0vCFI21XM98
	yp5gsWGK+rV++fV7T0xESZIRgJuxw8qBScxzKSV6y0ZkEtBfn5eDFqkn+0kvLeIYXdhzyshORiRFr
	Sk39yR8VFHcfpvLj5AhBZRxb4Xu3j7foEG6mzpVAMJNxnyE+x7POqcfmtkQ8VjB6t0Ek8Whi3iElt
	ApMlm7UA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rf91u-00000007b0A-3dtY;
	Wed, 28 Feb 2024 01:46:42 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rf80F-00000007QOf-3M8x
	for linux-nvme@bombadil.infradead.org;
	Wed, 28 Feb 2024 00:40:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=hkcLQkbySrTdbjhxHQrPUETIcbjp7Rn1tSQdXwrRRyw=; b=LJhdp6+/vOiPmowtjg2EZllT+S
	nPzP/+dn7aE2hj4f4jEv/T1Z2xXoDRykaEJjz/WfYSz8vzFvxNhrzUwoI6xnXvrswESkzztPFjZne
	6M0rRX/EQV4JSU991p+rMAtgkqGdCkNapavjKy0PL0jFafCEmCecSUpWpGVJGv8FmEbidtwbVD6Q4
	dtWoxBjpX9BsTKcPPokSMTqC5suIkhiTaWs8JvIhNrzIIS9QHPaC0tuiH3KyyHbOMBzbDAICEdqtW
	HhnHFnr4guU5jcBfh5i0HxveQtVm8HWM0R23u3n0Ix9JUGAu8WdN99aqXyCf2taShVuiLYTu+Ok3y
	MA3LXi4w==;
Received: from mail-pg1-f169.google.com ([209.85.215.169])
	by desiato.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rf80B-000000022fj-2Nz2
	for linux-nvme@lists.infradead.org;
	Wed, 28 Feb 2024 00:40:53 +0000
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-58962bf3f89so1699689a12.0
        for <linux-nvme@lists.infradead.org>; Tue, 27 Feb 2024 16:40:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709080846; x=1709685646;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hkcLQkbySrTdbjhxHQrPUETIcbjp7Rn1tSQdXwrRRyw=;
        b=vlvUnupk1AIvYIV7zgl/QxAUDu545gkLw4RRm4pP5QV6ybMPXznlewdACg6Rs/vI2p
         +OqaXRzsNx3DMW5GqAs+S7JYfivU5GW+hRG4y1TwqJ1Nrr3If6SekVYRcd298JEeKsb7
         QEmFDwqHWGGrpOAl8pfzu7Q3akO7a2LsnQsc0A2LPASgcXDeMWVvWmyOII3lO+DeqerX
         2ToAeJBmYRYS+pxYFm2uhuqdJP2WuLLuu0J8fSx1u3WyUZX3rKG5O+pqcuC3e9qDUe2F
         RkTafp2WG/sJAnU0prnNSG3Z/hOMoLYcbTok23LMf+7QXnaJ1PjxyheLi0RIroguUMtG
         DgMQ==
X-Gm-Message-State: AOJu0YwcpjGGFy+nWTfxNQqJlDUK1xbGjg//lrub5+OGL+SCEhjAb5dl
	tiKZxkaiKGPS/C+zgFOTeH4EZrUuJCZ6yADMP1pCo/kTGN0RVkDw
X-Google-Smtp-Source: AGHT+IG52ZPcuyxzp3rHlixzf4dPpVgcWYKGbWfEuG63x9S3JUJG0LEvHNP1aU1EVrvNho+zk+myCw==
X-Received: by 2002:a05:6a20:1595:b0:1a1:3e2:dcc5 with SMTP id h21-20020a056a20159500b001a103e2dcc5mr6026155pzj.6.1709080845921;
        Tue, 27 Feb 2024 16:40:45 -0800 (PST)
Received: from [172.16.72.75] ([64.114.255.114])
        by smtp.gmail.com with ESMTPSA id i2-20020a1709026ac200b001db66f3748fsm2102992plt.182.2024.02.27.16.40.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Feb 2024 16:40:45 -0800 (PST)
Message-ID: <ee516418-d072-4506-acba-d02f22cc4476@grimberg.me>
Date: Wed, 28 Feb 2024 02:40:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 1/1] nvmet: support reservation feature
To: Guixin Liu <kanie@linux.alibaba.com>, hch@lst.de, kch@nvidia.com
Cc: linux-nvme@lists.infradead.org
References: <20240201023207.112007-1-kanie@linux.alibaba.com>
 <20240201023207.112007-2-kanie@linux.alibaba.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240201023207.112007-2-kanie@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240228_004051_874511_8F9E1031 
X-CRM114-Status: UNSURE (   8.03  )
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

Hey Guixin,

On 01/02/2024 4:32, Guixin Liu wrote:
> This patch implements the reservation feature, includes:
> 1. reservation register(register, unregister and replace).
> 2. reservation acquire(acquire, preempt, preempt and abort).


Overall patchset looks in decent shape to me now.

I do have one more question though.

You say that this patchset implements preempt and abort, however I don't 
see how this is actually implemented or even how can it be implemented 
at all at this point.


