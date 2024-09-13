Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A6A8FA3757
	for <linux-nvme@archiver.kernel.org>; Fri, 13 Sep 2024 14:39:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jrkuGD2IqePRM946EDRrhkvGtVQtiz+QCaF/fVgBIOk=; b=pBCswUqltZ1/GjE7/lDXjezeZG
	0ox622r9SEp42Ni8LvBiCtwGzm8/ZBYu37KTk4WZ/q7VBKSKPF2GmCRGIKUoBSvEQLX6k3C2PatUe
	7/oZbnH3hstVg1qXDiyzMtlZLl9qERdu87HV8jHrXhew0czJGbWOy0CwT2CMdqe850BQCTo2ESBdV
	74Oa865JaI73AeRBbeGxdyBRG/CYcwrkd9nPYMVUGP0A0N75MOpNtv01maEeO2CojLCGoVsCo4c3P
	zHgp95ybknqSSYXYyeBVCy5GaOn5rhKaa5pMYctpl9zYhS9ryzYAk8c/T/jCAEyDuiZSMhRBxyWHW
	ZOR446AA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sp7Sm-0000000GE6v-3sA7;
	Fri, 13 Sep 2024 14:39:56 +0000
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sp7Sj-0000000GE5n-1XgM
	for linux-nvme@lists.infradead.org;
	Fri, 13 Sep 2024 14:39:55 +0000
Received: by mail-pj1-x102f.google.com with SMTP id 98e67ed59e1d1-2d8a7c50607so1569944a91.1
        for <linux-nvme@lists.infradead.org>; Fri, 13 Sep 2024 07:39:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1726238392; x=1726843192; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jrkuGD2IqePRM946EDRrhkvGtVQtiz+QCaF/fVgBIOk=;
        b=EBxJEsgp3sXuSLLHyAGUf93IcAlSF37NmyO9uosoOxk3PK046S2FqpP77ENH6c3DIj
         S8zqXU94+7ERxHb8fIaK/mZOAYl17e37yD8esCuS4PH8/r4cKcjcCvnlUe50PdA1T1Ak
         jxhSeixRbMOdrxusJv8kGrWc2VFfCBMPQ0+jdQj5UrJ32CDZ/vu2JXFPT4d0tSw2HfVA
         tnkHiZOIP6qLmJ35kRLZH1BDlEQYhv4vfxkMER28Grq1UehvY21SBbW+5zysy2jXrz/D
         xHvbJ8/sCuHOoY6yLOuwKNHQklBq7bCMtGucbmH4ID0FEFrwP1r2MqrzMqi5K9aO0xzs
         Q5oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726238392; x=1726843192;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jrkuGD2IqePRM946EDRrhkvGtVQtiz+QCaF/fVgBIOk=;
        b=Zn4GMMxwP682IdxzfKLjXwXeISXDUCuG/5lFEYX0/imw3GlVE8EL3bjt+pwYTKacVK
         5jKjPIb7dWl0yUMcL+q7vpDwfC1uKDDNJG1Qp8gZ26x/E8QAfyFi6UFrrRCNRmcQgWFQ
         ek/BYzcnGzKm49ZsxQlHNEAJAevccmi6RWiXCdV5wy2X5XcW5o14lsbnPgSuchsgJDlk
         vIEn3QKkgQjITvumVB6cGl+cTACHuTky6aHmc0QrjLlFlxeUw5uhzDULeOkzzWWaf9xw
         CXsHWJNNbpqo6bFATFk5Su19ee+KBdniwg7y3b670sdLPCwP19kJU0cx4v6ABNyieIjv
         wFJw==
X-Gm-Message-State: AOJu0YxcmVf8pHK0r3yXNA3JSwma/TKU0r/qu6c9N1rSMQpKPuzRRf3f
	0lqJLH1o25EcjfQkK9jUIYTBwwZ/pD7dBIGraFeV8ZID7cRE4HALFon6oDq5g0uzM/l8VK2bfTj
	c
X-Google-Smtp-Source: AGHT+IEiLFeIvTzjJAnzVbyQ526BtvXe6MaWt2rSAl8Nkz4MsNpM8+wxmEb0OrMJgvMb6Js6KrqFDw==
X-Received: by 2002:a17:90a:ac09:b0:2d8:898c:3e9b with SMTP id 98e67ed59e1d1-2dba0067f9amr7074552a91.25.1726238392299;
        Fri, 13 Sep 2024 07:39:52 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2dbb9ceeec4sm1821800a91.43.2024.09.13.07.39.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Sep 2024 07:39:51 -0700 (PDT)
Message-ID: <af5d647e-5d5c-4f58-8f29-6a3f921d48b6@kernel.dk>
Date: Fri, 13 Sep 2024 08:39:50 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] nvme fixes for linux 6.12
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me
References: <ZuRNXAVHqQJngQKe@kbusch-mbp>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <ZuRNXAVHqQJngQKe@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240913_073953_653609_397B360D 
X-CRM114-Status: GOOD (  10.16  )
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

On 9/13/24 8:34 AM, Keith Busch wrote:
> Sending a follow up sooner than usual: the important fix here is for a
> potential build error for certain configs.
> 
> The following changes since commit 68f31e88917f5608eb8da0bef37249648ffd48d4:
> 
>   Merge tag 'md-6.12-20240906' of https://git.kernel.org/pub/scm/linux/kernel/git/song/md into for-6.12/block (2024-09-06 14:43:16 -0600)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/nvme.git tags/nvme-6.12-2024-09-13
> 
> for you to fetch changes up to 83bdfcbdbe5d901c5fa432decf12e1725a840a56:
> 
>   nvme-pci: qdepth 1 quirk (2024-09-13 07:29:30 -0700)
> 
> ----------------------------------------------------------------
> nvme fixes for Linux 6.12
> 
>  - A syntax cleanup (Shen)
>  - Fix a Kconfig linking error (Arnd)
>  - New queue-depth quirk (Keith)

Pulled, thanks!

-- 
Jens Axboe

