Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9326CA0FE9
	for <linux-nvme@archiver.kernel.org>; Mon, 25 Aug 2025 11:28:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Message-Id:Date:Subject:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=zghTXtuCYjnVRSoEXYMypswuA6Dsts2VEXA78wNOPAY=; b=SyVTcTfgGuBPcZ
	182iVZvuk146iT/EI1RC0/yN0ixcVdJ18NH1gG5G1+sqX4TA8v6B8/0uPR5B10vU+4XBvhhmeGcgr
	B+6wwY0kFePhzOAKF9IfpykNBUmIkDAPaOJrCaTFxKRAzzWzWisdCNbyesoSU3g4WbOIh80oAp50+
	4ad5gclu+K5PpBYdyVtZPn62VHkQFVPM66oxC3ar3Vh5Tv4g0GkhAy4BCQXcvVQS59O3Mvueedh6U
	n/95tuQe0Pk4sue5ZVbL9T1pFdWIF1gM+yOXLRx6xK0+gT2+FVJstvcx4oLK9/ojLxQMunKcbWOgG
	V1mP+dRmjdJHivsPsewg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uqVNI-00000007k6J-2bad;
	Mon, 25 Aug 2025 11:28:32 +0000
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uqTJA-00000007Snu-1MKV;
	Mon, 25 Aug 2025 09:16:10 +0000
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-2467de5160eso12036355ad.0;
        Mon, 25 Aug 2025 02:16:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756113367; x=1756718167; darn=lists.infradead.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zghTXtuCYjnVRSoEXYMypswuA6Dsts2VEXA78wNOPAY=;
        b=IUXGKOEWl3ae7yhe6fW4awTf0QqAu5T3UvW15H7c5ferUUTVeRQCsUFXxGqIT/hmq8
         4dPr7RiKzc1eovb452TIbpiujXxM21bTVy5Bf0rpRMgECFtPOeyaahnPYGZi/OCWgR49
         8W6wslyvtDQSjilmiGXGv+I0hTiztOiJSRs1vlA93fXC+OaLEaIdxZEGJmW0LUqaF7i5
         3vwAwABU6X+hPobLLPEeG7jGtjpkOE9E9ogpPcfPjOm9jWV+gievE6yA7yvRSY7vLKQS
         f6UypGTnfPF86m0OEUxbjYID2hMhGMInC5gYUFIXDGJrB2TxY5FKfmQPG60K+3JMsSBN
         960w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756113367; x=1756718167;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zghTXtuCYjnVRSoEXYMypswuA6Dsts2VEXA78wNOPAY=;
        b=RRtqN+NNbSqxy+5qmiRgUuo01fJdUvcnFcxmOouhZzH+u7mrHO30OsjThIsbDQBrGi
         LPlUITq8xl7L+7pmJOR2yyNOJUJuoMTaPh7nLYykg7Qjz5NsicR77HZMlU1ybtYqmEVn
         4+ZAoP6VzVFbFg/rnW+XTXGuOs9cQz+jeU/NEaBIVaprKwIpiXZAFwXa+6mHw4qBOQfw
         Oba++sI/wGHqJKLzXCOTaJmSNiM3v3yRle0NnsDClyPLcaEMEnAhCFEKPKszuUp7yyiZ
         3rRx81XKMiPfLJW54LFck5gUOenIsT2hhnJogbCNe2SG3nre7I53eJOfQgmA5MJl4QdK
         jOFw==
X-Forwarded-Encrypted: i=1; AJvYcCUIczP9UTn77HdD3FwxioMYT43tElSMWd76KBhxVV1krdvUPN6kuDyIbggYumtQWyehCkkKGbGPrglaYQeQJWo8@lists.infradead.org, AJvYcCVLRhA0H6GgydRFojZbDUaDe0vPKkYkG0tFD83c8g07fmwbtyumpgoW5mowBU28pLeosnfh/AMEdxLozg==@lists.infradead.org
X-Gm-Message-State: AOJu0YwK50PDINPx20hgcnwHyGGIRsbd9lqFU+thaZrdV/0zhtpVO3HZ
	W2Jr5L3HKG4atXWBPJ3w89VV6PxJcrReE3icz0mfeydF8Qo5FpvvsSvH
X-Gm-Gg: ASbGncuGbV4RQgIJujpF9qhOWyliW+NyDBD/gMYC2siXpZF5LoD/BntlKB2M4P6v/bz
	HprlSTz82yzYE3rLjivyCfQCE8y09Nl/JOR00Z3kNyGKG4jiVaHdTNNOmCfURW/aQ1aCI9lRFtp
	YBIks6NJTtsXRicQZnd0//npI/C9NzmNuqXKoNgJgB8vr58sOcYAac+I0iCDQQNnEQgm/2nJgkv
	MyMXT4EIV4Ns3xDy2ijPUZ6zz0DR/YU55Qpkl5ckJWVn39rJU4vo8HwlNOexYx3b2sEK6idYoYS
	Nj/6773qluAbd2otUZpnU/cJaySyI/I/ImGwtZy4hS9KKDbrTj2XVk2uxgu+cidVKAz+24RHG0Q
	V2U6PxLc8ldoPVKtgjzlItpxAyC2usLJV8dj9Ng==
X-Google-Smtp-Source: AGHT+IGQmvgqTO1Pc+LATLeh/0scu3vAbktfAXwaSdHu+HIQat1iA60/9EZKZDEAckcrYALxg4j33w==
X-Received: by 2002:a17:902:c946:b0:246:c0c9:13a2 with SMTP id d9443c01a7336-246c0c91b6dmr49998085ad.16.1756113366971;
        Mon, 25 Aug 2025 02:16:06 -0700 (PDT)
Received: from [127.0.1.1] ([59.188.211.98])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-2466887fc8dsm62873875ad.122.2025.08.25.02.16.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 02:16:06 -0700 (PDT)
From: Nick Chan <towinchenmi@gmail.com>
Subject: [PATCH v4 0/4] Add support ANS2 NVMe on Apple A11
Date: Mon, 25 Aug 2025 17:15:03 +0800
Message-Id: <20250825-t8015-nvme-v4-0-6ffc8f891b6e@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJcprGgC/13OQQ6DIBCF4as0rEszIAh21Xs0XRAYlaRqA4a0M
 d69aLrALh/J9w8LiRg8RnI9LSRg8tFPYx7ifCK2N2OH1Lu8CQcuQYOmswYm6ZgGpKoyorXOcOk
 cyeAVsPXvPXZ/5N37OE/hs7cT215/GcbKTGIUKLaN5QCohFG3bjD+ebHTQLZM4iU9/CDxTGtZC
 20d0w3CP60Kyo9Xq0yZMIIpbVxb65Ku6/oF/kwU9hoBAAA=
X-Change-ID: 20250808-t8015-nvme-73a4fcda25dd
To: Sven Peter <sven@kernel.org>, Janne Grunau <j@jannau.net>, 
 Alyssa Rosenzweig <alyssa@rosenzweig.io>, Neal Gompa <neal@gompa.dev>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Keith Busch <kbusch@kernel.org>, 
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, 
 Sagi Grimberg <sagi@grimberg.me>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-nvme@lists.infradead.org, Nick Chan <towinchenmi@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2826; i=towinchenmi@gmail.com;
 h=from:subject:message-id; bh=Y05HCp2dKH+ELeXJposRHDcITa6nX6lbyaSJ7ik3B5Y=;
 b=owEBbQKS/ZANAwAKAQHKCLemxQgkAcsmYgBorCnMXLQOuXeccHo9ELkKgF8hXjMfU5ZldMBfc
 YKqkwbeqaCJAjMEAAEKAB0WIQRLUnh4XJes95w8aIMBygi3psUIJAUCaKwpzAAKCRABygi3psUI
 JCnbD/9sC1sqxHWRzIHlu9qKYOKxIXbhYxXbyQ6t/1cDjV3R8+TTx1Vi1JV/eSwIwUoEtUx76mE
 AYCIA73Ni/K6e9GouQoe9QP5+wiF2qjEvbWfP6y9++vyYOPMPRGZraOBMkiAA6oM+avbsYlP0Iw
 zIo+unU0gtwFgXDFiGDY9nWNU9nLCOmNMP7Gm3P1kh9szjB8XMWIUqE74K4ZRHHtK+b1e3Cot3T
 1OxEc01XQGCqmpdChZvVLQI/q69F4vrW4ONEduBd5gkHXbUZzUy1T2y8/8DsjTsYZ6mNeipU6hy
 Tr6u26a/9nvwY60Qzae4J3Ku7DN+PUAg7yPbCKQ70tKBLomOYRpF92vg6L98wU1J/k+Wm3skLZb
 bm9pUlF6bh2IUvhQ+KJCguqm7g5UFsKQBSiwO1PxtS8jIPASn9/wtMDU3kXlq3GfBwA/HJ1OKGc
 NpjNipHKVUIZ1MjeQs7CuCq/f5P18Usnsc4tEG6XKr79FYUNwBEgIbc0KuRjioF2XHDddaTL++k
 mKy9yQ1u6tUg2GsZglucG7PubDw7fHKEHStD1WMeLInxJ2zo6OQ8yWsEWrjS5K3CbzrvdwX8SFx
 eJRMqiei5wuiVba4v6jEbAdC6XDeh563fg2/LPIe4J/76gJXBC2yupC4ywRTNl+j6IlucXmG9kK
 /ovli0Umq5eRrxA==
X-Developer-Key: i=towinchenmi@gmail.com; a=openpgp;
 fpr=4B5278785C97ACF79C3C688301CA08B7A6C50824
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250825_021608_380669_20D9466B 
X-CRM114-Status: GOOD (  16.77  )
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
Changes in v4:
- Remove the remaining added long line in drivers/nvme/host/apple.c
- Drop already applied SART and mailbox patches (based on top of
  apple-soc/drivers-6.18)
- Link to v3: https://lore.kernel.org/r/20250821-t8015-nvme-v3-0-14a4178adf68@gmail.com

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
Nick Chan (4):
      dt-bindings: nvme: apple,nvme-ans: Add Apple A11
      nvme: apple: Add Apple A11 support
      arm64: dts: apple: t8015: Fix PCIE power domains dependencies
      arm64: dts: apple: t8015: Add NVMe nodes

 .../devicetree/bindings/nvme/apple,nvme-ans.yaml   |  15 +-
 arch/arm64/boot/dts/apple/t8015-pmgr.dtsi          |   1 +
 arch/arm64/boot/dts/apple/t8015.dtsi               |  34 ++++
 drivers/nvme/host/apple.c                          | 197 ++++++++++++++-------
 4 files changed, 181 insertions(+), 66 deletions(-)
---
base-commit: 58b28ca2e6697d7c4b2c31d9d6dc1f71cd356553
change-id: 20250808-t8015-nvme-73a4fcda25dd

Best regards,
-- 
Nick Chan <towinchenmi@gmail.com>


