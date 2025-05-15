Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25FC2C3ABC9
	for <linux-nvme@archiver.kernel.org>; Thu, 15 May 2025 12:22:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LbhPwm2kQrXEE7I0F7tJYw0AO9eHa6UkyDJMDQ2wFeA=; b=eFKUwD/gsR6Tww27oj11pthuPg
	xSufisyPrV1c8a8aZDA8AhS/mivc14hsrO2vTI6Wb1iehjVB5pXlFmPuWOvtfdqyZ+4nrHnXncVXn
	cfj6Lhi6ddcEBtqtZvc0CF/ZvC9yGWdev1RDMzcCGr/uJRyVNUUDF+RghA9Hsk0loaIVRgz/+aiqp
	ID1KZw4LaFLRqJ7RKRl2zWvwXgLmgMK22eVzYlH2dSFFZTtvDx8qKNi2KMO+iMa4B7TNTMeswKUim
	4uVL2qp3B1zJ4M+vPQ6ITvnBxU27CRms0vutTbqX99Fvge8AxobmmDwR2HELw0MBqG3vvrifsRBx+
	0qJ/f6vg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uFXbx-00000000Y9L-2Vr2;
	Thu, 15 May 2025 12:22:53 +0000
Received: from mail-io1-xd2e.google.com ([2607:f8b0:4864:20::d2e])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uFXac-00000000XxG-2fac
	for linux-nvme@lists.infradead.org;
	Thu, 15 May 2025 12:21:32 +0000
Received: by mail-io1-xd2e.google.com with SMTP id ca18e2360f4ac-86135ad7b4cso39389939f.1
        for <linux-nvme@lists.infradead.org>; Thu, 15 May 2025 05:21:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1747311689; x=1747916489; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LbhPwm2kQrXEE7I0F7tJYw0AO9eHa6UkyDJMDQ2wFeA=;
        b=DccXDDVkeYmDjWKkxfORmFrstsyA6x9vzV8VVB+41l5jb5Csd0+OzGh0E0A+/JlCRz
         EGFNpZulASwWa+h9jYqbrT1eh3P5EcQDx56/qD5RoGE08SPgJd+zN8TtyhZatIwcWc6u
         0ZEPBYEUOl7+nT8arNzbNXK7Iqk/Inw6ScrrvgnMDiShC/zXangOqhObAc8NsGY+Fj/2
         5IxWq5Zz1BAOmFz6/K0Arx2by8yL0n8LXZ1croeudJyBjPJA6Dr9APlXfgLOPMox4u4c
         KjhCQOOSmMyN+ZV8wVvI3ruS/sFAaKuW0zt3RqdP6KInNvCnlZuDuAgRpxiPvZlj5puS
         q/Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747311689; x=1747916489;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LbhPwm2kQrXEE7I0F7tJYw0AO9eHa6UkyDJMDQ2wFeA=;
        b=AdZ4HH9wPttTGLcT1QOvcNkhZEIeGS92HLGgJ9wV4w6pmgB3VoDTzFuUm7qfyvL5Lt
         jq8niTC8t9tlKOrgY088n0MYdxvekdp1kj0UeooZnqhQ6WDU3XCkK6zjnFn1I6d96Tqg
         lZq8KmIVHShFgGgsyY9rzf6K4cNko2krrt21DJokpnqbULjogttTgkLM0cfO5E1Cd4pO
         YFKa9yR+a/zIqnnw9htcEK3IxiJ+0fpkK4RfNULRSXJPQGewvuT+nXYDlXW28504rwzi
         Lw0doUwc35X1LGp3sKrH93gkwfSoL7axck4WlZBvNOHbuuVO9SDHoLhIKOrC1bqmWbMK
         6q/w==
X-Forwarded-Encrypted: i=1; AJvYcCXPqAeGiUszxFuK/D0OT3D9eEn1qp7z4IsaqK8L2ge7COjRydSQZHfPIzWk21hs8rx98T6uD8xioQmS@lists.infradead.org
X-Gm-Message-State: AOJu0YymAVj94knKMd5ONgDVMS3T/RXiebFNBi+I7yAW7pZLI3TuMsiK
	cEiCveKCuSOSbaHzIN77jYYLAB5YW0+v1fNcaGI2wRveRqj1MoOjy6n0Tk1TzOU=
X-Gm-Gg: ASbGncv2E8qugy9uw0VslkXmF1iM46daOiQn7Kx6YwNuGFSOHSfVr90dfqkwxh+CPTG
	HPcsKH0al9VAtKEs4Z4EhTAY61iBDbOkJ6TdPWsHY9XYWmecjhd8Sv/+p2ZE8cJ8jOYtT+dLj8L
	deXoIKK4r15wFmTKFnLrb9VUHKZLhi+3iiXuNbsQx32kMjEZ5ILvFIWpIM/+WinduMlR8KdkTy+
	I7L5hpKO1UXBG2df0TaZ5ygFjSHxr75EHeQXgiyazFJbUQK0F9Vr4LHxpD+mtCv82NhfbNWW3JJ
	AV1JqL6yFBw+oC40TwhCzdbrH18zz8K1vfPJPqmhvcVHzEwW
X-Google-Smtp-Source: AGHT+IH9aRASV+LJDva4UaOVghaK7g1DLoDR7y2UWnzuWyWoRru5K5wOnKy+yA1wudSB2r+6kmq4OQ==
X-Received: by 2002:a05:6602:2744:b0:85b:3f8e:f186 with SMTP id ca18e2360f4ac-86a08dcadfdmr962758439f.6.1747311689219;
        Thu, 15 May 2025 05:21:29 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4fa4d01e25dsm2119491173.77.2025.05.15.05.21.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 May 2025 05:21:28 -0700 (PDT)
Message-ID: <b81d2ab9-0ebb-4498-a136-9a65eecfc6a1@kernel.dk>
Date: Thu, 15 May 2025 06:21:27 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] nvme fixes for Linux 6.15
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-block@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@fb.com>, Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <kch@nvidia.com>, linux-nvme@lists.infradead.org
References: <aCXWVQ0-cbSsQXFk@infradead.org>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <aCXWVQ0-cbSsQXFk@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250515_052130_943374_4354F7A9 
X-CRM114-Status: GOOD (  11.92  )
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

On 5/15/25 5:56 AM, Christoph Hellwig wrote:
> The following changes since commit 8098514bd5ca98beca6ec725751d82d0d5b492d8:
> 
>   block: always allocate integrity buffer when required (2025-05-12 07:14:03 -0600)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/nvme.git tags/nvme-6.15-2025-05-15
> 
> for you to fetch changes up to e765bf89f42b5c82132a556b630affeb82b2a21f:
> 
>   nvme-pci: add NVME_QUIRK_NO_DEEPEST_PS quirk for SOLIDIGM P44 Pro (2025-05-14 17:16:16 +0200)
> 
> ----------------------------------------------------------------
> nvme fixes for linux 6.15
> 
>  - fixes for atomic writes (Alan Adamson)
>  - fixes for polled CQs in nvmet-epf (Damien Le Moal)
>  - fix for polled CQs in nvme-pci (Keith Busch)
>  - fix compile on odd configs that need to be forced to inline
>    (Kees Cook)
>  - one more quirk (Ilya Guterman)

Pulled, thanks.

-- 
Jens Axboe


