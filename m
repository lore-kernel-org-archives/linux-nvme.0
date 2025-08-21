Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7C45CA0EEB
	for <linux-nvme@archiver.kernel.org>; Thu, 21 Aug 2025 22:38:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Message-Id:Date:Subject:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=EqlRTlA4R1X2+J6LfIK/nlbcP+4L+ArUw8i4qlAeNpY=; b=m3gNMpvqisZxW+
	ivW67s+i6e64dheGpKMSYxmgU+6SWywLWEy28H6LhaN3gGI67lfCKb75wMhb/z0UUHPtjHuSiKg91
	o77qljmbf6nc3wSmd8AhWvQ2N0+c3/FKsHIp6Lc65h1ZEhyC2QBb3gODYXgWC/FAMKnH6gFz9QMmU
	f4smpEL0+la4DxapuM2On5sWiw9INB0U6drg8NEOeWpxzjatTi1kN7pwbykZqMNLPGC5UcYpACaHv
	o1vWJ8PXitm6rzKKPl290BQf2xfC0ev5yNMN3K94gXXZR3p0S5NghAQYIprz2hYnx5UvNBfZIjxmf
	S8ZNex6dZfUFtsNh8yuQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1upDvD-00000000nKL-2Vj1;
	Thu, 21 Aug 2025 22:38:15 +0000
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1up7fB-0000000HTuV-2W4b;
	Thu, 21 Aug 2025 15:57:18 +0000
Received: by mail-pj1-x102b.google.com with SMTP id 98e67ed59e1d1-324e7600bf0so1242342a91.0;
        Thu, 21 Aug 2025 08:57:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755791836; x=1756396636; darn=lists.infradead.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EqlRTlA4R1X2+J6LfIK/nlbcP+4L+ArUw8i4qlAeNpY=;
        b=SPfi4R8wgzhVDoKwyPOftLdUv9Ckzv0ihCJdBOSwUP/HX2T3cBemcXx97xgTljTV5T
         mzQpll4nhYg/YXpiBHk/dXiy9lhVpIv99/FM06E3dicKIhJlD4AC/D0ohltEce4B0g/Y
         mNz+t2liNS7pS/BzDjg/TfVkRAMry59ENGGxC1qMfza/vPRUX22y6SKnhEaNQ3KCske9
         K8SbV7wWbNsd1c+fqCCctXaeErzHM3PJvgjWPu8XJtLr5/Y91ulkBAhDrqXydk5IEoD2
         wMTAfzSAiw57I0W5rxj4I7AuXRkEnIw5Txg0qKr/F7tscJIHJJfPJ0OfLiGe0RPWWMlH
         TJpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755791836; x=1756396636;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EqlRTlA4R1X2+J6LfIK/nlbcP+4L+ArUw8i4qlAeNpY=;
        b=cmO+S4WMPnPNx/szLG9hn51wv6nGTjv6GXc4Q62LpY/YJWPR5hhJDf3hP34uUMUORx
         kdgJq6DBEINcqc4dYaIsf0jl2U5np+wlR6KZPNV9iQU6/G0FN40VvijWB4Utz3pbkfW6
         jZZwGmFPtlcVGP5P7sN7vtbAZy1NI3qYqDX2iEOWIiB+aWBLT2myKiF0bDHOjsp9t3AX
         +lv8vpUh7trKckxVL1ZPEOkHA6jKIgURc5bCudVHR6b3oB3PYW6iA2agpWooIwbQ8JSe
         sQqqZ/FvVreDkzannkkFL3AGe1Mm4+FN26aJ+EQdsoX0IbDSkScnh03Y1LbvPgdGtvyL
         9BdQ==
X-Forwarded-Encrypted: i=1; AJvYcCUFzAlBGecjIMgiZ3AETmcP1QN/Vu7EkGmVgG7nkep+IIh1hQ3sGJKHw582fSzNZSQnYZzM9aYrgsQ3Qw==@lists.infradead.org, AJvYcCVzI1g/9XrSP5H5I5zQjgey/V1tLhWLPXVjYraA68hFBSv7meH+IZ3beIcy0SXzHby8h1XLG2XOzpyp/MN0rMtu@lists.infradead.org
X-Gm-Message-State: AOJu0Yz113OouHWOm2Wm66kcauJci4FFk7PYcjUmHu0vfAqUbt5iKdfm
	84f1qcDERn2HjYafhjNovCUowcYe7CiMrOYujCurc11GqAHdhuUpOqKm
X-Gm-Gg: ASbGncs9N5UKy0a7vZsxgApjGwMJg66p05EzzzL2qJnsLUXzVHdjhA13BN0u97ZHIrL
	pPgQ9gr8vPjccx8FxK7ozjMz0iQM9vAF4uy77GWNvB4DpItvB8utckPsCfytSKKg/ngcFfLQl8C
	/W97oSoFzIhB3Qcih1Gdr8mEhhWpZG6V25Zog0kXOPiy8zzi2TI8hK356vExASaJH1Q09oxHcFA
	/R4/g7Y9fhXpTc9Uv6DjB3ao+N1NJXBKKid4E+SoOyFcPGid2qcF9GfQnXgdPPhYpcBqHsQ8R4a
	81CQ+0Cb0oZv9BtZK0WnIeVfsQy4uJBxFMLwuAXPj5ZUqX3oJAx4NtRIUzXRTMuzqAoy0EJkkb/
	PbuFCYjHRvgPR4tAjL9WlcA4C3xJW2ORuH6nkq+yRn4eohik=
X-Google-Smtp-Source: AGHT+IGY/0LdDkG3WlHhoiU3i1jzAfuDrGRNnzLZsjyafdBsIPbZDEnKdNCzVy+LG9syFh6upBaBLA==
X-Received: by 2002:a17:90a:d404:b0:312:1d2d:18e2 with SMTP id 98e67ed59e1d1-32515ec1334mr26076a91.20.1755791836352;
        Thu, 21 Aug 2025 08:57:16 -0700 (PDT)
Received: from [127.0.1.1] (061092221177.ctinets.com. [61.92.221.177])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-b47640afb33sm5094320a12.38.2025.08.21.08.57.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 08:57:15 -0700 (PDT)
From: Nick Chan <towinchenmi@gmail.com>
Subject: [PATCH v3 0/9] Add support ANS2 NVMe on Apple A11
Date: Thu, 21 Aug 2025 23:56:37 +0800
Message-Id: <20250821-t8015-nvme-v3-0-14a4178adf68@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALVBp2gC/1WOQQqDMBBFr1Jm3ZRJNBq76j1KFyEZdaBqSSS0i
 HdvlC7s8n14j79ApMAU4XpaIFDiyNOYoTifwPV27EiwzwwKlUaDRswGpRZjGkjUhS1b563S3kM
 WXoFafu+x+yNzz3GewmdvJ7mtv4yUx0ySAgW1jVOIVJe2vnWD5efFTQNsmaSO6t+DpLJa6ao0z
 kvTEB7VdV2/kjB/D98AAAA=
X-Change-ID: 20250808-t8015-nvme-73a4fcda25dd
To: Sven Peter <sven@kernel.org>, Janne Grunau <j@jannau.net>, 
 Alyssa Rosenzweig <alyssa@rosenzweig.io>, Neal Gompa <neal@gompa.dev>, 
 Jassi Brar <jassisinghbrar@gmail.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Hector Martin <marcan@marcan.st>, 
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
 Robin Murphy <robin.murphy@arm.com>, Keith Busch <kbusch@kernel.org>, 
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, 
 Sagi Grimberg <sagi@grimberg.me>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 iommu@lists.linux.dev, linux-nvme@lists.infradead.org, 
 Nick Chan <towinchenmi@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3117; i=towinchenmi@gmail.com;
 h=from:subject:message-id; bh=iUK4B/CmqL3+Q73zw9YIpvF6fPa74yfaI3WOfamJS8k=;
 b=owEBbQKS/ZANAwAKAQHKCLemxQgkAcsmYgBop0HOLQWhVWXbaGc0BzFZVP9f/db2mKxsmWbHT
 9Fs8JqKVcKJAjMEAAEKAB0WIQRLUnh4XJes95w8aIMBygi3psUIJAUCaKdBzgAKCRABygi3psUI
 JEpREACw1A07RdsR5Kch8lz/TYoO2c2/cr6rKNdpFHUNRYoKSVzpHzJq/CcFTMSa2dygiXmFfqS
 Sj2mZgt8ht24uJwjnCb57ETwEovCfCDGovUQNM4AiLK3VPQIvWNNDwzPVd4kUUozSoDwNCJm1lv
 zLKjN+L0GUuMCSJDdybD3oKpeKJhW6xc7szELbdh/f4S2BtKI4NL5U8BKs4a3NDxJI9nt1dmj9o
 5pR6USYp/56avbgcDjzmxxpdMqjdSmvzLArJBdFn5JKIXLKfV+VVRkKVmq7oWTmPJJx67mN12Pl
 LZZTgJMtSxvEJAwLx33rXs+37v59BHH7ZA+FBW9T8h3tx2Yw0ml/nKcVHoH/7fUgNYh1lEHHENS
 LBghUUrpEKW2JnFzkT+oXQj0YWkaj8zoCOH+SbEy595B/274nXqoEflHWbaTibgJulEtHSBa4rX
 1aLaJqA0WcJmlKNt3+m0wd1zwOamCqhbe4Dbw0j+AwiGo9ok1aRQ+EXlPF0Edbc5HBhP3tKhGIt
 tzhn9rFqwuQTgHwapzdeZ6RYQ6NTaQIcDdFkROyd9g86X6EhWqJjcifwLYKquolcPqaQJnj7q3V
 iNs5ABIsDuxlumXhSAt5KknZurOdsAP4n4oIQc43f169Qk8bsJSQZNaR3CroHRlDlIV3ESd02zn
 khOxWVzrkMWUlkQ==
X-Developer-Key: i=towinchenmi@gmail.com; a=openpgp;
 fpr=4B5278785C97ACF79C3C688301CA08B7A6C50824
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250821_085717_643266_8954619B 
X-CRM114-Status: GOOD (  17.41  )
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

Apple A11 SoC comes with an NVMe controller that is similar to the
NVMe controller in M1, but less customized. Notably, it does not
have NVMMU or Linear SQ.

The controller is wired to an older variant of the SART address filter,
and uses an older variant of ASC mailbox, so add support for them too.

This variant of mailbox is also present on Apple T2 SoC.

This series has everything required to support NVMe on Apple A11 SoC.
However, due to RTKit protocol version support limitation, it will
only work when booted with at least iOS 14 iBoot.

Tested on A11 as well as M1 Pro (to make sure nothing broke).

Patch 1-2 adds support for the older mailbox
Patch 3-5 adds support for the older SART
Patch 6-7 adds support for the NVMe controller found in Apple A11 SoC
Patch 8-9 adds the required device tree nodes.

Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
Changes in v3:
- Update comment about enabling NVMMU and Linear submission queues. It is
  required since T6000 and much of the comment has been removed as it was
  stating the T8015 (A11) code path as a possible alternative.
- Make sure all the code changes are within 80 columns
- Simplify apple_nvme_submit_cmd_t8015()
- Remove unnecessary cast of of_device_get_match_data()
- Use direct function calls for command submission
- Use existing enum in apple,sart binding when adding the "apple,t8015-sart"
  compatible.
- Link to v2: https://lore.kernel.org/r/20250818-t8015-nvme-v2-0-65648cd189e0@gmail.com

Changes in v2:
- Remove bogus command_id decrement followed by increment in apple_nvme_handle_cqe()
- Split apple_nvme_submit_cmd() into two functions for t8015 and t8103 since these
  two code paths were not sharing much code.
- Link to v1: https://lore.kernel.org/r/20250811-t8015-nvme-v1-0-ef9c200e74a7@gmail.com

---
Nick Chan (9):
      dt-bindings: mailbox: apple,mailbox: Add ASC mailboxes on Apple A11 and T2
      soc: apple: mailbox: Add Apple A11 and T2 mailbox support
      dt-bindings: iommu: apple,sart: Add Apple A11
      soc: apple: sart: Make allow flags SART version dependent
      soc: apple: sart: Add SARTv0 support
      dt-bindings: nvme: apple,nvme-ans: Add Apple A11
      nvme: apple: Add Apple A11 support
      arm64: dts: apple: t8015: Fix PCIE power domains dependencies
      arm64: dts: apple: t8015: Add NVMe nodes

 .../devicetree/bindings/iommu/apple,sart.yaml      |   1 +
 .../devicetree/bindings/mailbox/apple,mailbox.yaml |   7 +
 .../devicetree/bindings/nvme/apple,nvme-ans.yaml   |  15 +-
 arch/arm64/boot/dts/apple/t8015-pmgr.dtsi          |   1 +
 arch/arm64/boot/dts/apple/t8015.dtsi               |  34 ++++
 drivers/nvme/host/apple.c                          | 196 ++++++++++++++-------
 drivers/soc/apple/mailbox.c                        |  19 ++
 drivers/soc/apple/sart.c                           |  60 ++++++-
 8 files changed, 264 insertions(+), 69 deletions(-)
---
base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585
change-id: 20250808-t8015-nvme-73a4fcda25dd

Best regards,
-- 
Nick Chan <towinchenmi@gmail.com>


