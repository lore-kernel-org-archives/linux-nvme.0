Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB503C4345F
	for <linux-nvme@archiver.kernel.org>; Mon, 22 Apr 2024 02:08:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=GHDXc07fAiXKvVfPLmO3rPdeNJyX4lFaHVpoK7fDPJQ=; b=t/p5BxUPglXQMqHzssmacrxk5l
	ATKtKEYcWDr4kczGyYp9Bcy8CVXc1ZDUeE+zhI0UMrRCld0KKl2rOOrJsgrY03n1VbloTMyXmCdrC
	5EYumz1zf03X8Lc5jbEyFsoCkRcm+0s+JapVBLMkc68v2HqZlC5el5BiUl5px4UvhDrwj5y+hd2Mg
	gshLkky1ochiv9HItGOOh7bV/0/3ioIq0zGaFPDsmqqMQuLswKgaE3oP4u6r8XXhNk4bz1zMWP1Jz
	PRquBiGhWms9TMFPaubJLDkjsZxvQRHmgORp+KHBd1oy2oxt/LAW0f4Kom5y1Fhzsq0ZMYgyZlLjd
	SZqJ22kg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ryj6Y-0000000BjRY-1ptE;
	Mon, 22 Apr 2024 02:08:26 +0000
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ryj6V-0000000BjQJ-0WTl
	for linux-nvme@lists.infradead.org;
	Mon, 22 Apr 2024 02:08:24 +0000
Received: by mail-pg1-x533.google.com with SMTP id 41be03b00d2f7-5dbf7b74402so2249884a12.0
        for <linux-nvme@lists.infradead.org>; Sun, 21 Apr 2024 19:08:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713751701; x=1714356501; darn=lists.infradead.org;
        h=content-language:thread-index:content-transfer-encoding
         :mime-version:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=GHDXc07fAiXKvVfPLmO3rPdeNJyX4lFaHVpoK7fDPJQ=;
        b=d/yBMiZsMgA82ZagcvCnbxjCTyLiO9n3a7rCgRZ/N4lNxWsVBJV6W2NoxzBygTNRXH
         5UU210L8t0MVm5M9atMm8y5++vUEGh9yIj7+HbAcQmGU5WYRh0GW8fjfCJzeMBgo21uC
         vykY2HX85aZ96Sqw2jVtSTbPuru0munQEP815CTWYtDxNXw+gizQp8EIthvI2idSAP0S
         wPFlC4hW/myreQiiMW65yf5QTxLeui1qXs7Cbf+N/Mhv8JcerCZDv0FhAGtMcZSqg58Z
         nKEDMt6CA9dqCuMs5xD0lesf7ZTq549Mo93nXxZ/UA0E353q35rS/cefBBKzBKvAxNAv
         cewg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713751701; x=1714356501;
        h=content-language:thread-index:content-transfer-encoding
         :mime-version:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GHDXc07fAiXKvVfPLmO3rPdeNJyX4lFaHVpoK7fDPJQ=;
        b=mmLxx/E3wLNgJ2+aiF4zYu6DuDPmVwYntbgIhXtmHVyneVLKh/117sZlPFxpkthGhn
         /Gh/21cRRwpaZlalQcDsl4lDW5KZwyGFs1XQlRWkdWavfHCqhchvaTxWUW208NTLAGkZ
         Wul1XUOaKKRC0+0As43h3BXn9RMPE28Y2MuDdhxnPtR/k744S50Y7ZGEiA63y4WgDzbs
         /6cAelvi3MK5a5q08IlZ5/vCwS2nv6aO2ASI3Obnetn9yrzJCVAF6yNa/oG3Nl07vhez
         c8E3BF725GHyCUgw5tBrxYbW7jBGxdQGmExc/m07csSJUJsDkMUDb6zh2IYy/3bZndVA
         LJ2A==
X-Gm-Message-State: AOJu0Yzvd/HTtNBSwCvCg70J2wWKjwwhyaF/Lp3Q2LI3FhDrMWvzHtwx
	lH4nS5viXyqDs3hT58S7NI+plz0A3GaYoAatBLelMjzBVFFvYqOj+uUTd6Tt
X-Google-Smtp-Source: AGHT+IGxxc20sm1egCZP0JpIyVVAb5c2K4Z0V0SAfIk59YSGxR7VlnbwMyrkEzyeoTMXSGY1vs9rNA==
X-Received: by 2002:a17:90a:680e:b0:2a2:dcbd:9f01 with SMTP id p14-20020a17090a680e00b002a2dcbd9f01mr6869789pjj.38.1713751700437;
        Sun, 21 Apr 2024 19:08:20 -0700 (PDT)
Received: from DCLAPTOP ([212.102.51.248])
        by smtp.gmail.com with ESMTPSA id m15-20020a17090b068f00b0029b59bf77b4sm8216183pjz.42.2024.04.21.19.08.18
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 21 Apr 2024 19:08:20 -0700 (PDT)
From: "Deane Coleman" <deanewcoleman@gmail.com>
To: <linux-nvme@lists.infradead.org>
Cc: <deanewcoleman@gmail.com>
Subject: help re using nvme-cli to sanitize SSD
Date: Mon, 22 Apr 2024 12:08:17 +1000
Message-ID: <000001da9459$f353b340$d9fb19c0$@com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 12.0
Thread-Index: AdqTrub8hRJdfzgOSCypiU7im8dZNwAqu/uQ
Content-Language: en-au
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240421_190823_223543_8F1D5339 
X-CRM114-Status: GOOD (  10.80  )
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

Hi Gang,

I'm pre-novice when it comes to command lines, let alone nvme-cli, and
respectfully seek your assistance to successfully achieve the objective now
described.

I have an Acer laptop containing 1 x internal Samsung NVMe PCIe SSD running
Win11 OS and I wish to completely sanitize the SSD of all user data,
including over-provisioned / non-allocated space, whilst leaving vendor boot
capability intact (if possible) and causing least wear on the SSD. Once
sanitized, I wish to clean install Win 11 OS on the SSD. This is the
objective.

Win11 reports the SSD has 3 unencrypted partitions, as follows: 1) Fat32 EFI
system partition / volume; 2) NTFS data partition / boot volume; and 3) NTFS
MS recovery partition.

My limited use of nvme-cli identifies the SSD has only one controller
'nvme0' (with nvme0 containing all SSD data) and one namespace 'nvme0n1',
however I presume (and please correct me if I'm wrong) the 3 above mentioned
partitions in Linux = nvme0n1p1 + nvme0n1p2 + nvme0n1p3.

Based on above info (and presuming that info is sufficient), I respectfully
ask whether the following procedure will 'smoothly' achieve the objective:

1: backup all user data currently on SSD
2: have bootable Win11 ISO file prepped on USB drive via Rufus
3: boot laptop using Ubuntu Live USB
4: Open command terminal and run command - 'nvme sanitize -a 2 /dev/nvme0n1'
to start block erase sanitize operation
5: when sanitize operation is complete, exchange Ubuntu Live USB for Win11
USB and reboot laptop
6: Follow Win11 install procedures
7: Install Acer drivers
8: Install target apps

Additional questions arising from above:
- If any above element won't achieve objective, please clarify what needs
amending?
- I currently understand 'nvme sanitize -a 4 /dev/nvme0n1' (crypto erase)
causes least SSD wear but because all user data on the SSD is currently
unencrypted, I presume crypto erase is pointless to achieve objective?
- I've tried researching the following sanitize options but am currently
unable to appreciate their significance or relevance for the objective: 'No
Deallocate After Sanitize' and 'Sanitize Action...001b - Exit Failure Mode'.
Would you please help me discern whether I need to include either of these
options to meet the objective and, if so, the correct syntax placement in
the sanitize command for it/ them.

As I'm so novice, please respond in most simplistic terms for my sake.
Thanks for considering my request and kind regards,

Deane Coleman


