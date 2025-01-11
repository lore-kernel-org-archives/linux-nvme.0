Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A7B5E7719C
	for <linux-nvme@archiver.kernel.org>; Sat, 11 Jan 2025 16:14:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=itWvBZ2ex3ENkcY9Hxt33EzPFds1FI/Cs+UtfYnXDuo=; b=kOj1XSVCcvYRbRIL1GPnLGO1Uy
	YaZWxgt/oQVcNeqV1r12aMneox4NpKBVY9x4+Kjyaw8zYB8lZPSvEifErE5+q3qbXvNpzB38T4ego
	oRBgWiOqO54cIP8xNSrBBHYTvZedqD8irMHHSp/a42PbB0W12+eheUZsLI56Yn3cHk7FiN7iWkpfl
	N9xktdbAyNwi0/kUQvRpaydz02gCs/AbaGcifPzzz56UUNl/2fVDzdDYRkmxJj5N/h/jnBgFiINRr
	yOjdSbuRHCS23DUfocAYuiyGm6Q94AGRM1YI28WO4Hzyy9sls2Cj01i4Fywvp9dZK4ORXBzA1K3s4
	1UXJ/ejg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tWe8P-000000013I7-2U1L;
	Sat, 11 Jan 2025 16:14:49 +0000
Received: from mail-io1-xd2b.google.com ([2607:f8b0:4864:20::d2b])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tWe8M-000000013Hc-1JmW
	for linux-nvme@lists.infradead.org;
	Sat, 11 Jan 2025 16:14:48 +0000
Received: by mail-io1-xd2b.google.com with SMTP id ca18e2360f4ac-84cdacbc373so89898139f.1
        for <linux-nvme@lists.infradead.org>; Sat, 11 Jan 2025 08:14:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1736612084; x=1737216884; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=itWvBZ2ex3ENkcY9Hxt33EzPFds1FI/Cs+UtfYnXDuo=;
        b=kt9rlktBX6E5w4udREh4dilRqttB8Kd3/IgKluaxIReUEiaeTG2ubwSLRwf762Vops
         xxgioK08EC1h5JbK1CwTR+6w0dKv4Onh96CKNPqGmFrm0v92SuNDuuHwNrUIq7JItCan
         1w2nSxC4ERFg5TADVrnlHipt+tLBs4fxvk/iFHyqldJW0Hmf4BS8mN1Xa5nX9zcatmXN
         3B6dUX1z7mTakTdMXRS7P71SXo+zVdw3Z1D4OGmQZgC9QNJXjB87kahJZRXzJ4Zel03C
         sUccpPa4GZjx9PHoPcP0HLPiRrteX88oms/jhQtsAoDksEK5FxClH3th6kSMTdxRB/gX
         QCGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736612084; x=1737216884;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=itWvBZ2ex3ENkcY9Hxt33EzPFds1FI/Cs+UtfYnXDuo=;
        b=Y6SL692b0R3uy68TfGefId1sUT8XmBoTE7Zzz63nLChmljD5vHlfdhVldEZQH0GL4Z
         PJZDhYi+ijDZKJxXD5kGftPbIACxI+bc5gN3bwDCSJLnSj6PBTxCxqwGolyL/1bLGcuZ
         oGyzcyFvV8JxyaKYAISfJTun1oHz2C+m7eBxLg6iTLBgmsZlG22sQxudIs+0Xdgjbgy2
         BSAEfIFgVi3tn+vfAiXZv7x+2XjzP9hHncbXJ4m8hj/LMyC+dlj8GcqycAxCyqG3fAId
         eKYVfEjO74dNv8x0yqQcfnVC57+K65/D9E7poirdl5kQZNI5cTNYbWGZ2SDjlpUWvXs8
         bYbg==
X-Gm-Message-State: AOJu0Yw8aVm8Nxc1pmZTMQXqxnZz8TsTqQMjW7omGFLi7Ik6/JrQrl6p
	syfS/G8f8xe/1rfo46orGYt1WsH/Y2X1tCs30OzB8GXP4dlli2Q4YZTWcJtdVtE=
X-Gm-Gg: ASbGncs+SQN4b1MgGG+NPVVkP2URrbDl/4iMDGlLYmtWrTaTALjHc0qafeB/JsmCicr
	19nTIkVETeOBIQY1lpiGCgRqoXhaTTduLVEAjF02EJghFIftkp8Y0XZN8e2wF99C2Q/jgfqCaJ+
	FSKrRer3L+vFzJmG/qwBXbCwqAVDlXKAPck8CZ5LswcQ1ST2BfIve83HQJZjEEmUd/3La/iQGQ0
	M85WByJw2rktMhI1auiDdyU9VPbvakYlCoOFU42plrSwIIsbQ7yHw==
X-Google-Smtp-Source: AGHT+IGdR9Ska010HbbiAVZ+TV/rHBmP1acL7/olw9S1247H9j3x39FzzjeuG65tYuF4d6JR1qfbbA==
X-Received: by 2002:a05:6e02:388b:b0:3bd:c7f5:41d2 with SMTP id e9e14a558f8ab-3ce3a86a560mr112908745ab.4.1736612084494;
        Sat, 11 Jan 2025 08:14:44 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4ea1b5f93d2sm1577256173.22.2025.01.11.08.14.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 Jan 2025 08:14:43 -0800 (PST)
Message-ID: <2f050717-a91f-4736-97db-40ee5d5b45f4@kernel.dk>
Date: Sat, 11 Jan 2025 09:14:42 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] nvme updates for Linux 6.14
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me,
 kch@nvidia.com
References: <Z4HuOSnrCRIwy5PG@kbusch-mbp>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <Z4HuOSnrCRIwy5PG@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250111_081446_624819_C0096DA1 
X-CRM114-Status: UNSURE (   9.83  )
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

On 1/10/25 9:06 PM, Keith Busch wrote:
> The following changes since commit 844b8cdc681612ff24df62cdefddeab5772fadf1:
> 
>   nbd: don't allow reconnect after disconnect (2025-01-06 07:38:20 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/nvme.git tags/nvme-6.14-2024-01-10
> 
> for you to fetch changes up to 6d84dae9af94be43bb71d24353aef102fd0744da:
> 
>   nvme-pci: use correct size to free the hmb buffer (2025-01-10 19:30:51 -0800)
> 
> ----------------------------------------------------------------
> nvme updates for Linux 6.14
> 
>  - Target endpoint for PCI-Endpoint transport (Damien)
>  - Fabrics secure concatenation (Hannes)
>  - TCP IO queue spreading fixes (Sagi, Chaitanya)
>  - Target handling for "limited retry" flags (Guixen)
>  - Poll type fix (Yongsoo)
>  - Xarray storage error handling (Keisuke)
>  - Host memory buffer free size fix on error (Francis)

Pulled, thanks.

-- 
Jens Axboe


