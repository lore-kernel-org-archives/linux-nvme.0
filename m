Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FA44C021AA
	for <linux-nvme@archiver.kernel.org>; Mon, 17 Feb 2025 13:33:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:From:Subject:To:MIME-Version:Date:Message-ID:Reply-To:Cc:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=P9UDxOMqPg15gSOK7rUm5UQP+79Q5az5rgNjpHqZZAM=; b=2Z3eftrUo7aaaZcErI3liZ92fa
	ZlqTQX04VBmWvXGEe5KH8xerk5oABX6XfpLVBve74DqcZhD+0h5fqbGzC5Km8mSgu8PWeH9f028xA
	n8Htiwkt4OdZEBcH8PxXjF1WKMZ9AxqB2C1VAMdWjG+GjRf4LiPdUGvIOoNwpUn0j1ei8h1Ye5hR+
	h71tIQH1ocP8H6r/t5tRL2I0kCQZv0yqje7ohwIyveafJGmNeNHYkoczup9fIGYnX9XuMqx/WGzgi
	T/I8LDSfBpCRfQASghRC2rgFgDEC4ZsaNEdpa1OyQOK56pLq9L6I9jLmWw26Ekdr035GMlrnJ+MqI
	BuG79SkA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tk1FE-00000004gFk-3UMK;
	Mon, 17 Feb 2025 13:33:08 +0000
Received: from mail-yw1-f175.google.com ([209.85.128.175])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tk173-00000004eGu-0PPX
	for linux-nvme@lists.infradead.org;
	Mon, 17 Feb 2025 13:24:42 +0000
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-6fb6c36ba25so9358107b3.1
        for <linux-nvme@lists.infradead.org>; Mon, 17 Feb 2025 05:24:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739798678; x=1740403478; darn=lists.infradead.org;
        h=content-transfer-encoding:from:content-language:subject:to
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P9UDxOMqPg15gSOK7rUm5UQP+79Q5az5rgNjpHqZZAM=;
        b=g+u+pVPbKY3H2mN60Q6qIzLt7eGc+A532YT0EdoOUs4Y85OO4iruLYrePlvCLR99rh
         uAYod2SRnSbVqQ3pmLcv2J2fcMWktFLTs6/Emfuq6xj9GgGoPAIjZN1yRZXsWIw1Pg52
         WFPmKIG/U79RLLthRP0MSIMaLj/OyFycsrYM5Vi1L4W7BUsQDqjzoNv6lkTVyaYFxAMK
         Kg+c1i/48x8w4jthnkIEuKYDEh1xwrPyFqqq1fuvBCxRC9AkLPfsLD+/s9VAPvPydSNQ
         3ULVJ1MYWCBNV7wHEnQJkt8XsU8VMFmAdO6x92bZg/oYua3Qs1bAftkTtmdWl7mHKvYo
         DsXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739798678; x=1740403478;
        h=content-transfer-encoding:from:content-language:subject:to
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=P9UDxOMqPg15gSOK7rUm5UQP+79Q5az5rgNjpHqZZAM=;
        b=P6ilF042oOtJOLkVPaAwqFpubmGL9DGTrP8WZE1VyXRuwqey+dyn5bjD8YRi8sY0Xp
         9V0agIvKGQKA/FrOxL5m95zJ7+QaYek6sOpUYS4CyRTJXcQc2GJ7jtWB50OAxF1xsap4
         1c0In0MPSXs1qfwo/D0fMKADVdrwvXOrlpnyEKPVLkBpl7ZgQxId9E/oiAaEhQu0kn4U
         OQk8oVs1P9zAIZC1gnG4jNcBwcBxXsjFKdhBfboD9XH+zefPCOAi0KdHfz5lo30LEBtm
         sxoEJv53dKaByAXp3+Wh98cowtoQdEStNzovwzihvwtTF+dTk6Ga3vbxbngxg1AVcsKR
         E0pw==
X-Forwarded-Encrypted: i=1; AJvYcCXfjdV+MwYrtf0GYjtmuEeQ7/w4X1+uL/mEihpUwO2LYWpuzUkVvMHU9/8Z/zmCekR4bQNAiUBuYC5c@lists.infradead.org
X-Gm-Message-State: AOJu0YxK6U3SP8xJvyaVbADY7nST/0k+4X9b2YSyUY1q5sdT6IMhw5mM
	c031yYJbC3QYbDJR/gF4dhSt55Pq2CW+YA0iDRUwzmyv0+vor0xe
X-Gm-Gg: ASbGncuk2n/qS9z0vSNSpYppFVjFCwjtu7Xd1lcE9OBoXpNHCRtV/yjFfMbNV7gYOQK
	Fv5Or17vfSkpMa270hId3dtMF9+5YZwYJ6PkKur+kQsUzM3aSmSlMlYRddolHfsPkjyFK+Qtf+4
	GaS44RxQKDicKy3lukJ4yOZodorJffPXU1fm0QgfT1ua1/KkGkUu6f03C8+lfCuU3NhLfPX+bYF
	QuHRznTxT/WWTFNmckZ0Gd6GbTgb4uFwlmJF8boxPeMCtu8yr+gXOSoEFuAhT3WczjLbRU9c+Su
	NUhDXxPIjlo06T/RcT8Orx4SlRa4En49+UTpqEvVUA==
X-Google-Smtp-Source: AGHT+IF/RJ1kUREAalimaVm5FY124IyhsJBxFWPD95K5398MGwlE4Z37QEyheWCUJexj/KJROctS9w==
X-Received: by 2002:a05:690c:688f:b0:6f9:4b81:3dc7 with SMTP id 00721157ae682-6fb58a1d762mr69387017b3.1.1739798676364;
        Mon, 17 Feb 2025 05:24:36 -0800 (PST)
Received: from ?IPV6:2600:1702:2480:14d0::48? ([2600:1702:2480:14d0::48])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6fb361cabfbsm20749817b3.113.2025.02.17.05.24.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Feb 2025 05:24:35 -0800 (PST)
Message-ID: <71ea150b-9ea0-3e49-6195-ebbe761bacb1@gmail.com>
Date: Mon, 17 Feb 2025 08:24:34 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
To: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 "christopherericlentocha@gmail.com" <christopherericlentocha@gmail.com>
Subject: [PATCH] Fix two Acer FA100 SSDs from interfering in one PC
Content-Language: en-US
From: Christopher Lentocha <christopherericlentocha@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250217_052441_139119_0F3E3466 
X-CRM114-Status: GOOD (  16.24  )
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


In order for two Acer FA100 SSDs to work in one PC (in the case of myself,
a Lenovo Legion T5 28IMB05), and not show one drive and not the other,
and sometimes mix up what drive shows up (randomly), these two lines of
code need to be added, and then both of the SSDs will show up and not
conflict when booting off of one of them. If you boot up your computer with
both SSDs installed without this patch, you may also randomly get into a
kernel panic (if the initrd is not set up) or stuck in the initrd "/init"
process, it is set up, however, if you do apply this patch, there should
not be problems with booting or seeing both contents of the drive. Tested
with the btrfs filesystem with a RAID configuration of having the root
drive '/' combined to make two 256GB Acer FA100 SSDs become 512GB in total
storage.

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


