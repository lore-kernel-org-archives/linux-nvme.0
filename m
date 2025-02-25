Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0036EC021BB
	for <linux-nvme@archiver.kernel.org>; Wed, 26 Feb 2025 00:57:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Date:Message-Id:Subject:References:In-Reply-To:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pLp9Ea62UroP9Hu5zCjkj8kz5zOw20u3Q4aJrEzL0tk=; b=jg0VJsfbehOoznvA2+F3Idec8i
	J1hUvVx17gxdc3Kj9QHofGjndP4qfZjv8tsFlROjcIcOVh580r6DaOnDPuUMywGsNiWG/Vk5jCar+
	Vly18my3SkXEPQ4FiLEQltfM4qXfOwaXTBT596pr56tCcbckPgBcubVazWD3b7ISVYWH7dMGWvk/S
	LrywyhLkcNVuYfUfrRv9d/5Zi5wdl399Zbbx1db/6LNEq+tibwEuMf+lBR+52alu+TDEYbPUtKSSV
	jZ2jj2CClHglCh1GujheUvZF9tlGvKo26f5Iyg4HHmU/ZscXh8gMp5Fi5T5jBVNMtvkVdtIyZypsZ
	LlfnIq/g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tn5je-00000001vVa-18rI;
	Wed, 26 Feb 2025 00:57:14 +0000
Received: from mail-io1-f45.google.com ([209.85.166.45])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tn1Zh-00000001NCf-2HTA
	for linux-nvme@lists.infradead.org;
	Tue, 25 Feb 2025 20:30:43 +0000
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-8559461c2c2so159907739f.0
        for <linux-nvme@lists.infradead.org>; Tue, 25 Feb 2025 12:30:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1740515440; x=1741120240; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pLp9Ea62UroP9Hu5zCjkj8kz5zOw20u3Q4aJrEzL0tk=;
        b=L0I8f/C3Q35GT6gAa0mgtMtzj/z/XHece2HuFGjLD00HLJzeNBosLBPWeHCkaz8dkA
         NdU6mK989CPwqjNn8+TN5vKgdnpCDZW1/axruj5aOKSWEDvhj1H5kBAY7oRwRN/5YM8p
         C4fxLNYWFO5PAzr30YFSy2/6xtdGKIfJeABQKCF9PuZ+xe7lnCzdqIwOOQMM7QwmkFWE
         tzW9TodPEjn/WnoTG6O/0qrfDtaKFm+IQxHcwHIBmR93eiFeUmo9YqHgXPguavjkdIVw
         rYLfS/TCytvh8CALsIi0fDZGmy5hE8cK5X79qjQJEo5SP39na1jfErSesRX8dYKR30t9
         sNKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740515440; x=1741120240;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pLp9Ea62UroP9Hu5zCjkj8kz5zOw20u3Q4aJrEzL0tk=;
        b=Ek0VRMWmOdTV5QW4TW13PKlhzEeWgH99SMYvBLmchT0HkSs3pMS/971kpdIEjbWVKn
         InkhL4f5rB5lebWeAvvP8ss6HRS1KiJ1drxpm+EXx2Rd3u6JZflsOFTJp8hrNbvwtRNj
         YgmN51svkdy1SpOo1W+/jUB61+PWYDhW3vsSUDdxGb6XveXx+Q03IHi2DMf7HBlT7+Wy
         H1oQ/beGZoKYCdOg29M+GEuWQuvKMAWyiJ70jN4F1PNEcQ7Dy0xMhyW7Cg6DeIjB7e4O
         Lw0/cE5Q3YxdN2d6dduavQIG+p1btOuNUHDKzvZCR8sDKYjfbQTzx1sX8hjqJbABDIo/
         q08A==
X-Forwarded-Encrypted: i=1; AJvYcCWVv0FTmHNl1gl78LC+NF5y95kMyT+un/EZg8+lCYgbCDwO3xK2zzB8rNHQpbNSISIfJ4su4+TJc0HK@lists.infradead.org
X-Gm-Message-State: AOJu0YxIHL3jHMH2ftMGreKEdjL4LBnTQVhXIDXtBuerDGLeS0FP+Rnk
	z1ft+sNhLnH+WpAzqCTO0jJKf7Y/19F9JrKtKlfJIpPmdKv6HqMYm6s+FJQI7fI=
X-Gm-Gg: ASbGncsPg2gtDGx3nxG92zmbE6ZV1jtemxySuRBcVG2CMuKIDmUKOol6Z5k1UarSIxy
	s0HJaoy9PWqx0zAHaqo0QilJm/RfnfimstVOUYetvRtz/F5i6qBsqhdeyJ44GviTkj7WRoQnxPI
	NO9JFHu2R1YQ5dex4EjYRZZ8YtXVvQv0DO0cNqxCqO2zmg1hGriBgPYhvd/pNwk6mhSl6XAeAYq
	qTPCw91k5mziDcHrDe38VPzk/5fddNIg0sSgXcE9zjOizwQPBr4md/vWauQVY4Bb1bLi1iJ/K9j
	GAFi7kqnnCx6Zose
X-Google-Smtp-Source: AGHT+IEI1HpA9fGHJ1GdkYmfu92FscKbuH3o9L2lVKiqa4D5puwjeIXVc4djLm6mFSVg2XH039gtQg==
X-Received: by 2002:a05:6e02:b2a:b0:3d1:968a:6d46 with SMTP id e9e14a558f8ab-3d3d1f40415mr9808255ab.6.1740515439644;
        Tue, 25 Feb 2025 12:30:39 -0800 (PST)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3d361ca3896sm4764255ab.53.2025.02.25.12.30.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 12:30:38 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: Andrew Morton <akpm@linux-foundation.org>, 
 Yaron Avizrat <yaron.avizrat@intel.com>, Oded Gabbay <ogabbay@kernel.org>, 
 Julia Lawall <Julia.Lawall@inria.fr>, Nicolas Palix <nicolas.palix@imag.fr>, 
 James Smart <james.smart@broadcom.com>, 
 Dick Kennedy <dick.kennedy@broadcom.com>, 
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, 
 "Martin K. Petersen" <martin.petersen@oracle.com>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, 
 David Sterba <dsterba@suse.com>, Ilya Dryomov <idryomov@gmail.com>, 
 Dongsheng Yang <dongsheng.yang@easystack.cn>, Xiubo Li <xiubli@redhat.com>, 
 Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>, 
 Carlos Maiolino <cem@kernel.org>, "Darrick J. Wong" <djwong@kernel.org>, 
 Sebastian Reichel <sre@kernel.org>, Keith Busch <kbusch@kernel.org>, 
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
 Frank Li <Frank.Li@nxp.com>, Mark Brown <broonie@kernel.org>, 
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, 
 Shyam Sundar S K <Shyam-sundar.S-k@amd.com>, 
 Hans de Goede <hdegoede@redhat.com>, 
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 Henrique de Moraes Holschuh <hmh@hmh.eng.br>, 
 Selvin Xavier <selvin.xavier@broadcom.com>, 
 Kalesh AP <kalesh-anakkur.purayil@broadcom.com>, 
 Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>, 
 Easwar Hariharan <eahariha@linux.microsoft.com>
Cc: cocci@inria.fr, linux-kernel@vger.kernel.org, 
 linux-scsi@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-sound@vger.kernel.org, linux-btrfs@vger.kernel.org, 
 ceph-devel@vger.kernel.org, linux-block@vger.kernel.org, 
 linux-ide@vger.kernel.org, linux-xfs@vger.kernel.org, 
 linux-pm@vger.kernel.org, linux-nvme@lists.infradead.org, 
 linux-spi@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, platform-driver-x86@vger.kernel.org, 
 ibm-acpi-devel@lists.sourceforge.net, linux-rdma@vger.kernel.org, 
 Takashi Iwai <tiwai@suse.de>, Carlos Maiolino <cmaiolino@redhat.com>
In-Reply-To: <20250225-converge-secs-to-jiffies-part-two-v3-0-a43967e36c88@linux.microsoft.com>
References: <20250225-converge-secs-to-jiffies-part-two-v3-0-a43967e36c88@linux.microsoft.com>
Subject: Re: (subset) [PATCH v3 00/16] Converge on using secs_to_jiffies()
 part two
Message-Id: <174051543709.2186691.13969880655903967909.b4-ty@kernel.dk>
Date: Tue, 25 Feb 2025 13:30:37 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-94c79
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250225_123041_714585_E4D015EC 
X-CRM114-Status: GOOD (  11.07  )
X-Mailman-Approved-At: Tue, 25 Feb 2025 16:56:55 -0800
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


On Tue, 25 Feb 2025 20:17:14 +0000, Easwar Hariharan wrote:
> This is the second series (part 1*) that converts users of msecs_to_jiffies() that
> either use the multiply pattern of either of:
> - msecs_to_jiffies(N*1000) or
> - msecs_to_jiffies(N*MSEC_PER_SEC)
> 
> where N is a constant or an expression, to avoid the multiplication.
> 
> [...]

Applied, thanks!

[06/16] rbd: convert timeouts to secs_to_jiffies()
        commit: c02eea7eeaebd7270cb8ff09049cc7e0fc9bc8da

Best regards,
-- 
Jens Axboe




