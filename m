Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06F76C021AA
	for <linux-nvme@archiver.kernel.org>; Tue, 18 Feb 2025 14:00:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:From:To:Subject:MIME-Version:Date:Message-ID:Reply-To:Cc:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=mBTitMHW10mShDDuvyybiVh0MUPGAff1nlPO1Ig+Pnc=; b=zD4dqe09djEH9yxgR5HmIiFL8v
	lSQTGez79vJHPnszkBiHcg0wu5KARwz+0PUZ5mhXGqKjwcUgE1oN5atG1e6jHtSmNuSo8wigsLXfA
	340HodqRAiipzKXrK3SmfZn2CNxWBhmi/CugAURhwo2w4rHbl81yfIuCzvlhjskEYZ0yI54/uq6c0
	Iu0u5a6Oy2VZll2bBq5/IECs3G3Vgm5d/NiyCjMJJUtfsOPHnU/EXqZ5xybHITVqiL7bIvYmjBS8d
	j0lGoadbHKeZuB0y/gR2Ljf4N4rNQyHnK8b6fjyq1XFPhxsgJW8kFOcalg0IGCeKFhsUHXLcc8A9t
	Ct2lYVeQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tkO9X-00000008Pfk-0XdY;
	Tue, 18 Feb 2025 14:00:47 +0000
Received: from mail-yb1-xb35.google.com ([2607:f8b0:4864:20::b35])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tkO8K-00000008PVY-3zQf
	for linux-nvme@lists.infradead.org;
	Tue, 18 Feb 2025 13:59:34 +0000
Received: by mail-yb1-xb35.google.com with SMTP id 3f1490d57ef6-e5ad75ca787so4561665276.0
        for <linux-nvme@lists.infradead.org>; Tue, 18 Feb 2025 05:59:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739887171; x=1740491971; darn=lists.infradead.org;
        h=content-transfer-encoding:from:to:content-language:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mBTitMHW10mShDDuvyybiVh0MUPGAff1nlPO1Ig+Pnc=;
        b=dVMemNATtbcp4Rsxk5EFgksQN2fylLneHu2K6eIKcntjOfZpi/wwJRHb/Yv+Q7JQaL
         VLgAtwKd5srKD4hp8W3BXLXf1uwbAoR3V0O1Z1vKMILp5VbJMy/B+g7u5/JRjr+AvKEW
         OlCKmB+GEdiu2jWUoHzbQAaxYfj/R9VC3iYAcZ6i4g0Lo1UT1xINWZIBTTgB32zO0xfF
         KXjNecLh9syg/9rVrckZB1OK3vu/bpeYaIXExEwZZ/HlH7i9tW1RmmN6BIelUwp3AxzJ
         7llDJp633Yyrt4sn+UBAO13I0OWTmt27OPu5w9zpcm8dnMQ5dPvyLerVMQLW99uK6ctg
         moHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739887171; x=1740491971;
        h=content-transfer-encoding:from:to:content-language:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mBTitMHW10mShDDuvyybiVh0MUPGAff1nlPO1Ig+Pnc=;
        b=nnshiw3QYQj8pPc2kdM4SWQzauHWyXIPIvst3yURh3Xeaq+QSn0XTCq0qDEcZGy/dc
         mO6KcezGKSDIrv8ikFDfe88D7XceYCF8TMi5HqNkxdxJ64kFofos/fjIQLJ4tPGcxRsV
         DvRD92DJyPEG/iSxsTlCDsvCkvYuGIhCeccW7NR8g+jibe8yk3oSTFkJ4sL71n1YQhrz
         AqMrUrFpBqokjNMZzBm+j7TcvtcyRztVFa5yn6skVNBalUaUXiEMVj6nD0uY9Wfiv8RM
         cohib5mLjUxA040c3WGgrLOP2lLPrlIa8mb+AJIbQDyYNMeLv+X6Cdbu6kbHPzvwvu9v
         dHJA==
X-Forwarded-Encrypted: i=1; AJvYcCU106YDmyQK3mILiZ9oRKTT4TX0jZ7EwBGT3+TcKZPhZ7AGnf3ZsWfDQ8Oa2u0kl6mJu/6cMn5pM6JU@lists.infradead.org
X-Gm-Message-State: AOJu0YxtojC2EVisSiEhk1lvwA4MDMMDF8t7z0+ETus6pf472R1H6+Un
	OLlx4WdKMab0xEgqVzTZz6CzNxciYPDBTsELVQBu/E/XRWJEMtPP
X-Gm-Gg: ASbGncsdXQaYiUmuskf8NiIYudxfauKCnXasc26AGSUK3tkeU/Z+ysm4YCinFtzZUVs
	9yomZXmYm7eJV1Pgx7yM4RWmRLzfn6ACrbT/qJYjvDs5bVvCxYowb/K3M8Iv1GU7Ey88nghLi5F
	1ucP+MJYIdjaS3Rp+8XXec5o+OjFb7mLFRE/aVc0ii22MzLL+TXVmi+jMRkAKr135eu7l1ivGxX
	1llc/uA/z3eFotAorAxhFIc2/pOeezXhi5/n4ArbQaznllxA6ANuk4zSpPIUgiN4D+Q03u0AisA
	I1M9BlJIZo3h7xbGgK8eXehoYnGrfNP8PvKbsCTzxw==
X-Google-Smtp-Source: AGHT+IGr/7yCTqFWAoZsEW/RB9JqyxCCCoN2i9ai0N6qMixFJeolznestAOTxgZkSj8FZSpKdp3qAg==
X-Received: by 2002:a05:6902:f84:b0:e5d:cbad:c961 with SMTP id 3f1490d57ef6-e5dcbadcc01mr7758222276.22.1739887171310;
        Tue, 18 Feb 2025 05:59:31 -0800 (PST)
Received: from ?IPV6:2600:1702:2480:14d0::48? ([2600:1702:2480:14d0::48])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e5dae0d9aadsm3067538276.35.2025.02.18.05.59.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Feb 2025 05:59:30 -0800 (PST)
Message-ID: <381a838c-bb8a-8e95-c35a-343601cbe8e3@gmail.com>
Date: Tue, 18 Feb 2025 08:59:29 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: [PATCH] nvme-pci: quirk Acer FA100 for non-uniqueue identifiers
Content-Language: en-US
To: "christopherericlentocha@gmail.com" <christopherericlentocha@gmail.com>,
 kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
From: Christopher Lentocha <christopherericlentocha@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250218_055932_991039_A99DAF58 
X-CRM114-Status: GOOD (  15.90  )
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


In order for two Acer FA100 SSDs to work in one PC (in the case of
myself, a Lenovo Legion T5 28IMB05), and not show one drive and not
the other, and sometimes mix up what drive shows up (randomly), these
two lines of code need to be added, and then both of the SSDs will
show up and not conflict when booting off of one of them. If you boot
up your computer with both SSDs installed without this patch, you may
also randomly get into a kernel panic (if the initrd is not set up) or
stuck in the initrd "/init" process, it is set up, however, if you do
apply this patch, there should not be problems with booting or seeing
both contents of the drive. Tested with the btrfs filesystem with a
RAID configuration of having the root drive '/' combined to make two
256GB Acer FA100 SSDs become 512GB in total storage.

Kernel Logs with patch applied (`dmesg -t | grep -i nvm`):

```
...
nvme 0000:04:00.0: platform quirk: setting simple suspend
nvme nvme0: pci function 0000:04:00.0
nvme 0000:05:00.0: platform quirk: setting simple suspend
nvme nvme1: pci function 0000:05:00.0
nvme nvme1: missing or invalid SUBNQN field.
nvme nvme1: allocated 64 MiB host memory buffer.
nvme nvme0: missing or invalid SUBNQN field.
nvme nvme0: allocated 64 MiB host memory buffer.
nvme nvme1: 8/0/0 default/read/poll queues
nvme nvme1: Ignoring bogus Namespace Identifiers
nvme nvme0: 8/0/0 default/read/poll queues
nvme nvme0: Ignoring bogus Namespace Identifiers
nvme0n1: p1 p2
...
```

Kernel Logs with patch not applied (`dmesg -t | grep -i nvm`):

```
...
nvme 0000:04:00.0: platform quirk: setting simple suspend
nvme nvme0: pci function 0000:04:00.0
nvme 0000:05:00.0: platform quirk: setting simple suspend
nvme nvme1: pci function 0000:05:00.0
nvme nvme0: missing or invalid SUBNQN field.
nvme nvme1: missing or invalid SUBNQN field.
nvme nvme0: allocated 64 MiB host memory buffer.
nvme nvme1: allocated 64 MiB host memory buffer.
nvme nvme0: 8/0/0 default/read/poll queues
nvme nvme1: 8/0/0 default/read/poll queues
nvme nvme1: globally duplicate IDs for nsid 1
nvme nvme1: VID:DID 1dbe:5216 model:Acer SSD FA100 256GB firmware:1.Z.J.2X
nvme0n1: p1 p2
...
```

Signed-off-by: Christopher Lentocha <christopherericlentocha@gmail.com>
---
  drivers/nvme/host/pci.c | 2 ++
  1 file changed, 2 insertions(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 9197a5b17..950289405 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3706,6 +3706,8 @@ static const struct pci_device_id nvme_id_table[] = {
  		.driver_data = NVME_QUIRK_BOGUS_NID, },
  	{ PCI_DEVICE(0x1cc1, 0x5350),   /* ADATA XPG GAMMIX S50 */
  		.driver_data = NVME_QUIRK_BOGUS_NID, },
+	{ PCI_DEVICE(0x1dbe, 0x5216),   /* Acer/INNOGRIT FA100/5216 NVMe SSD */
+		.driver_data = NVME_QUIRK_BOGUS_NID, },
  	{ PCI_DEVICE(0x1dbe, 0x5236),   /* ADATA XPG GAMMIX S70 */
  		.driver_data = NVME_QUIRK_BOGUS_NID, },
  	{ PCI_DEVICE(0x1e49, 0x0021),   /* ZHITAI TiPro5000 NVMe SSD */
-- 
2.38.1


