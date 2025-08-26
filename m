Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B10ACA0EFA
	for <linux-nvme@archiver.kernel.org>; Tue, 26 Aug 2025 12:20:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Message-Id:Date:Subject:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=QMh6zEQZL3iNnuj0oodrCX5vuHjr614t/lFt4njww8Q=; b=E5bW1cFxlqPF7D
	bzgcDF8GYmIUiQ+6XlSSObcpMtAt5oFU/5i5MoTM5JIfB3oukatFKglDE8iHTHLVYHs4WeV3cDH21
	gw195AmMEB+pF+tJG7vS47XQq7tfe1uoqe+OA/oVokCv05JBczayanQcvXK8MNSjzoLpqlRP1xOOf
	u44AD9VkCJ2ro+MKj++I19GKHwEdedpyPHKNzyiRRvYDDtokIoj6kb1nNgIu630JvBJozyEKRxAXm
	2UdCQnnTE4uZKtag13ywB87uZAKDZHa07g/B32jJhmiqAajVroI+/YEeKmSe60WJEyB90M2v3aMak
	nsLN7/UJa53WXUbjnAzg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uqsep-0000000BvPT-1IyF;
	Tue, 26 Aug 2025 12:20:11 +0000
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uqsUk-0000000Bu3L-0mlg;
	Tue, 26 Aug 2025 12:09:47 +0000
Received: by mail-pj1-x102b.google.com with SMTP id 98e67ed59e1d1-32326e5f058so3750609a91.3;
        Tue, 26 Aug 2025 05:09:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756210185; x=1756814985; darn=lists.infradead.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QMh6zEQZL3iNnuj0oodrCX5vuHjr614t/lFt4njww8Q=;
        b=go4feRD+jxPn+C2XarL5RHEnqW3JCW3eVFcIKSskjl7WWavFpisUq6HbEmYkX0Ph/k
         mnYHyAyG/bzE7CR7XHwGk4h1GgysU+dk3wu2gN4thlX/G4fBD9lBEEEpru8wChyWxI81
         6DGk6YMPE1m8Wptt9xw62dPUI583egAtyPeV9BVVkHdYbzbkQmzZdZeu4lTz62q1JGZZ
         72FoJlP6XEPwdcEz7huDxm6uff0qN1S7IJakA57fZHo3dHsx1V3huARxCAofBuUfLfqi
         rmbKj6dNW8LUFm0pyeZpYR9I9WgnJjYgO9Y1fgs/UiijblmwpJoqpg4jrmdN0pPl+t6V
         dy4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756210185; x=1756814985;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QMh6zEQZL3iNnuj0oodrCX5vuHjr614t/lFt4njww8Q=;
        b=dP65ijoNpw0WkkgJfwDE39v13MbqOo9bieVcxCh2l8wxISWN6whugBtZ+HMUe40MmF
         InA9HR9LUA7iBdJXgjCGr4OKjHbERrOFs537Gp+WAjL+3Yvf9tOEJb3q7Ll1dKF0MqDl
         VVUR4GazScW+euxlTVc5pm/ORzqbbgOh9uJ9e52AhikJk9Uma328nEW820xYParA3p55
         ZEMTYovtmmzHJXPG8jAopcLkXXl51R3azoVVw4dekow4XW1ntXXeYCQaRqYx6u418pL2
         DvVeFD8Nof3pSprcoPVAWxCDzw4j4Ne6zAfg5V09b9zoGIm1IHBg8W3xjm1LOO3koSoZ
         F2kg==
X-Forwarded-Encrypted: i=1; AJvYcCWc/dMHSuBdzml+3ST+u1Fi05dUGOh0GK3JC0v8LqLS185AkMvrmr7ti5Ny+/S76Dplonhst3XlZB3aKA==@lists.infradead.org, AJvYcCXUj+rT9BinOHfzfvOaWpCP5UfDlYmejs6OTCb5X0tYrZ+VHPTNivwuFmdTBTF8Nc89vMGQOdp0GXQdRFCzb5kr@lists.infradead.org
X-Gm-Message-State: AOJu0Yws5jI+eYxrHFelIiAk847HTX2z0i+AmZuxJEJu78vpsI13uvJB
	QN86hkUJX5ivtyvfW8CFnQ74q7Deu0sHDBHwn5iLaAO6IbkG8dMcsfxN
X-Gm-Gg: ASbGncusg8nRUcmc7G9qdMa7JwkMdQS9X4fSz1noVeJKa8RD40sKZPSL8vmskYXAZ+d
	0kcEG48P7ofbl+DnMednmFP0/Xl61mwBWqRzT4bYnf9VstNu0TrYyW+iIWblEbcoP+h8G/tt4y5
	0HiXRjqs9yD4aUN2LxldzvGPeWpAldtD5hkSxBbUcTgRt6c5ozGNK483SQPJdHpGiMwldMHJeII
	p0ywMq4pEog8sqes1IoUfZ+B0ODC9M8vfwKrrMkD2QxrUJpaG0k2KjyQM6/xo/1FTU+jM+gxa+O
	g6SYUM7kVjUZTjl0lXc7VyWRxumkFjm1RMLWgs+436XX07jRjnPx8VsW5g//CUhZP6H6OCSrzZU
	bY88nx3dSuwUbHpLJ48XaCQnix9MEvcOxTUcDRQ==
X-Google-Smtp-Source: AGHT+IF2JhoGLDdpcCyhYB5vKEXb+Oohh9jsfi2DZc9ihpiSA5Lpn8KkTerrgxEkmQDoa3FYE1QOXQ==
X-Received: by 2002:a17:90b:1649:b0:321:4182:2b9e with SMTP id 98e67ed59e1d1-32515e37410mr19456614a91.12.1756210184854;
        Tue, 26 Aug 2025 05:09:44 -0700 (PDT)
Received: from [127.0.1.1] ([59.188.211.98])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-327565d3924sm619966a91.13.2025.08.26.05.09.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 05:09:44 -0700 (PDT)
From: Nick Chan <towinchenmi@gmail.com>
Subject: [PATCH v5 0/4] Add support ANS2 NVMe on Apple A11
Date: Tue, 26 Aug 2025 20:09:11 +0800
Message-Id: <20250826-t8015-nvme-v5-0-caee6ab00144@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOejrWgC/13OQQ7CIBCF4asY1mIYCu3UlfcwLhCGlsS2phiiM
 b271LigLh/J9w9vFmkOFNlx92YzpRDDNOah9ztmezN2xIPLm0khtUCB/IECNB/TQLypjPLWGam
 dYxncZ/Lh+Y2dL3n3IT6m+fVtJ1hffxmAMpOAC06+tVIIapRpTt1gwu1gp4GtmSRLuvlBkpnWu
 lZoHWBL4p9WBZXbq1WmoIyCBo3zNf5TVVK9oWq96r1Fjy1cayrpsiwfLFL75lUBAAA=
X-Change-ID: 20250808-t8015-nvme-73a4fcda25dd
To: Sven Peter <sven@kernel.org>, Janne Grunau <j@jannau.net>, 
 Alyssa Rosenzweig <alyssa@rosenzweig.io>, Neal Gompa <neal@gompa.dev>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Keith Busch <kbusch@kernel.org>, 
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, 
 Sagi Grimberg <sagi@grimberg.me>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-nvme@lists.infradead.org, Nick Chan <towinchenmi@gmail.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2956; i=towinchenmi@gmail.com;
 h=from:subject:message-id; bh=Bw7BnPCmbOFL5LNbBdy2vjQjegS/SZRZkp5SZgnFQR0=;
 b=owEBbQKS/ZANAwAKAQHKCLemxQgkAcsmYgBoraP8K0/t+Xa1jn6vOgxkYaOQoVIcUzHLULZy0
 slUDQBPlgWJAjMEAAEKAB0WIQRLUnh4XJes95w8aIMBygi3psUIJAUCaK2j/AAKCRABygi3psUI
 JOAcD/4uapZ8pDC/dkHhGkAbW3Q5a7lulD46kXjfXY5qKn6oJXvKjVzdkW6yszmNQMkoM04uoAO
 bMzhG/N34H2LaFgNJZOJYyO2u+dSy7Uw7LjhYhGQmY7ZMIOuXmOY8AUx92hx2pnS1qMBzkJy1zv
 wIPA/UEIxv1hkPQkMfybuqXUSe4TM1W30RCeO021Jxavf4HyEcs1MuI7qv1rvkFncIfHJv6B5+w
 jnxYUaaloqZdUXeLtBly+X+W85VQLPwM0ssZJsyuBfb8dI/36efEkew1anJB0UK4uyyiN4w1qtD
 l0jA2e+HjvouspwRqO0l5mwR73mvmUOe/XARYJq0bjqIlXmTtw13zz7NqK2lp5ZvxG7V2Fxtbsu
 QzZm0pgqyeI6mYRTLRxtw6Yc9EwLart1UXlGcpfViZbpipvj3ek375hW5SLvK/FqoAlJfxQqABL
 DdkghX4nVpfgCaJHztrklJ5lIgmg4rPE5gRvMD8cud8Vc/u7wNxetklHCgAGOWMxXxaHNMBGWk6
 vvqtnUjABr7k7DnDAR2kaXqwBSdOAPlq6mw2wdYXTPZ4FUrP+3U0PvPFfrvB99hQK73Ga5d+b8J
 1YFZe3Gn5cPr6Qw/ohMS/Hgxld/TxJBlEyEk+C4V/G0ep/vHp2DCsUhAc91HRlLTRrp5cb7ufN0
 Cglzjhr4vPJSQZw==
X-Developer-Key: i=towinchenmi@gmail.com; a=openpgp;
 fpr=4B5278785C97ACF79C3C688301CA08B7A6C50824
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250826_050946_232353_7F0EA685 
X-CRM114-Status: GOOD (  17.22  )
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

SART and mailbox patches from previous versions has been applied.
Patch 1-2 adds support for the NVMe controller found in Apple A11 SoC
Patch 3-4 adds the required device tree nodes.

Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
Changes in v5:
- Add back krzk's r-b for the nvme bindings
- Link to v4: https://lore.kernel.org/r/20250825-t8015-nvme-v4-0-6ffc8f891b6e@gmail.com

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


