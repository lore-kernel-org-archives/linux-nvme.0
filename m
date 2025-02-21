Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F92AC021B4
	for <linux-nvme@archiver.kernel.org>; Fri, 21 Feb 2025 01:56:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wfwR4DnLBjMZ54V02k6vQRDlu6M79slaufHOfEFbN/w=; b=MqvzVbkwV8nzCeU16d0RIBsRGf
	oNvxtHLNJKiatz1U1LWmiIF+ZalP+0ZCULuOyMzVM+ufh1VATN8XD2xwXxRBdXTdFZUDtQxW6PUZD
	69MtamLwQw01yne1iKVoLPsm2aB0rdp6VE6QAbKE4rAu2BACizGgYMUO20uTSzPx277Q/Zhv50V6D
	PDKBujNseh/0TErJR4vuJT5SGmE5tmUAp2SxTgzcUmxPaDfCeyU1DdhAE3KLUOzJaGZ7ulBsQRpmb
	GccXF5lBlVq3Wg7tBzi667SviNBytN87qy89BbQ+Q7iq2K+pAc3MdZvCGKI+9wwGbDB2G2EFuHpm3
	fitEmXPQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tlIHB-00000003lkg-07hF;
	Fri, 21 Feb 2025 01:56:25 +0000
Received: from mail-io1-xd36.google.com ([2607:f8b0:4864:20::d36])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tlHAp-00000003Xzl-0Yjz
	for linux-nvme@lists.infradead.org;
	Fri, 21 Feb 2025 00:45:48 +0000
Received: by mail-io1-xd36.google.com with SMTP id ca18e2360f4ac-8559020a76aso42774339f.2
        for <linux-nvme@lists.infradead.org>; Thu, 20 Feb 2025 16:45:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1740098746; x=1740703546; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wfwR4DnLBjMZ54V02k6vQRDlu6M79slaufHOfEFbN/w=;
        b=0/oLGeAVbg4sgrFCNJ1uys3PDHQG25Ww8iGegCI/1hCBLhw7ORgajFtyAb8Ar33ZNf
         B2Dg7nbR5icWvitxIEThMYNJjobDfJ2DvH3tGIxttuFBaHKvdnmCR0Xory6/Q/+NqT5U
         TKlcaXHW2qh/aKnyPTCZdB3yPfBdl5/LnE7wyJT4HkjYzzm/m9XqYgXcqG9/d9dbVdUe
         qFjOqU66OtUV03HAF6iDjllR4EePIiNMM+JaAvFhnBqyPxfdltq86T44RpsSPe78LvKo
         K3p5DbI1oX/K8768sPYWVFUzOSISk02Lu2ZamA8aroUUZVMzmzcdGsqvt3hRz1Uh3mwP
         W5Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740098746; x=1740703546;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wfwR4DnLBjMZ54V02k6vQRDlu6M79slaufHOfEFbN/w=;
        b=tLm2Q3dCF0fwBAf8Z4FPtrC6RWap3C4oeHCLk33ZhJV11bZyBoV0VrqQd4AbeponKM
         GQSQ584RTpKgFdYhGM/PBZYS5wjQD0Tl2+IgnIDahLwHYZVmV01fqztP2z6/1tGpVBhF
         ryzD/e3TMMIBJy8II+p+I1S1GifnjgfuSRhdh/TffWNk0F8Lhs0MQ5o4YPReeEqP+THT
         3EvQR1yW5qldWyfJ5ss7yvK3w/6ClxAwUMYJFH+UyAAoguSRP0XLbWocgU+V+FbwSOW2
         riGfYBXbqg87OdBQ/3PFeHTEq5Z0YGwG0TEFJtX4xhHRV1t7tFWObnZxCecr1OEtJHUd
         b5eQ==
X-Gm-Message-State: AOJu0Yy3UDjumJQma7s9lAaq4naopHaGUWHXt2r3hTkXJnpngNHFZ748
	xVJBmjTTrs9es5NSx/yMQo9dAo6a0uq+262ejgMDTUCbL5ynn8XUOmjBB+Tr5C493LS9rFePdiv
	k
X-Gm-Gg: ASbGncuQANEYKNRlGOXWTff2CD8kTgaOogYJVVQz7UAWX1avwq38dVpyMxZRH4TeUxp
	oPUUAfvvasOK1VwLpboitQ/rC1+fcU4ptGiIj3DNLfwhQ79tAz45K1tr+2OWaLKDWGbThLMBeGG
	aR6+xev/JnsJu4807bpqa4eHNPdiXx/Ucq3ChM22n1V84oJmvC6db/AaT05fptcXHQDI1WlSeOr
	qLZvYjVmd3c4BUuHEQo0YacY82kEtNT+zwFgCgNaXthvEbJTG2hcsQ1RbP3fkza0/ddS9N92b5o
	FzVUdNbeICIE
X-Google-Smtp-Source: AGHT+IGhNlBXBlb77NM4oHoEMuTTxLHnggptovaQEyTFvZeuyrh+z146cb6ZuIFg9T4GpYWuKqvDww==
X-Received: by 2002:a05:6e02:12e8:b0:3d1:a75e:65dd with SMTP id e9e14a558f8ab-3d2cae6b927mr10947985ab.10.1740098745992;
        Thu, 20 Feb 2025 16:45:45 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4ee980374dasm2247962173.3.2025.02.20.16.45.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Feb 2025 16:45:44 -0800 (PST)
Message-ID: <ae08649f-e6ec-4899-b258-c59ab813c3c3@kernel.dk>
Date: Thu, 20 Feb 2025 17:45:42 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] nvme fixes for Linux 6.14
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me
References: <Z7fDvDmMihwtyUDV@kbusch-mbp>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <Z7fDvDmMihwtyUDV@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250220_164547_433771_6CF474B0 
X-CRM114-Status: GOOD (  10.04  )
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

On 2/20/25 5:07 PM, Keith Busch wrote:
> The following changes since commit dd8b0582e25e36bba483c60338741c0ba5bc426c:
> 
>   block: fix NULL pointer dereferenced within __blk_rq_map_sg (2025-02-17 09:04:07 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/nvme.git tags/nvme-6.14-2025-02-20
> 
> for you to fetch changes up to d2fe192348f93fe3a0cb1e33e4aba58e646397f4:
> 
>   nvme: only allow entering LIVE from CONNECTING state (2025-02-20 09:14:25 -0800)
> 
> ----------------------------------------------------------------
> nvme fixes for Linux 6.14
> 
>  - FC controller state check fixes (Daniel)
>  - PCI Endpoint fixes (Damien)
>  - TCP connection failure fix (Caleb)
>  - TCP handling C2HTermReq PDU (Maurizio)
>  - RDMA queue state check (Ruozhu)
>  - Apple controller fixes (Hector)
>  - Target crash on disbaled namespace (Hannes)

Pulled, thanks.

-- 
Jens Axboe


