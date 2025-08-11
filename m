Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6218C87FD2
	for <linux-nvme@archiver.kernel.org>; Mon, 11 Aug 2025 13:55:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Message-Id:Date:Subject:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=nklRgqEsHAGsTa1ZY+Tu1pfGAj2pLA2XYPvzJl54xAU=; b=hsqeSc2JB76fP6
	H9uHtOiAo6Jpcqf0L+1OToNUEUm2qtNogLv3raPaTBGFiH0DdCRr+W35Ift6yZt2p0rw6bzP2SaOu
	CXJXac2Qp8BO+C8EwbUk57RdqzULVwgjPczRx/ij/d6/UCVASOVyOdwQptMuj/FLJlsfmLaqkVzKI
	ZULX98M3M5hv4sdroDepTBn1hSBot5/mKag5vI6waM1Rxi6HoJ5XB3cOW7lunlvS3nBnNOsYSe+9H
	cKgOk5/BdNfgJ1+ZgGEdrzifLCHp9m/Fh+VmS9Flp6wGiDudOoviBPbmq9cE42yQbDcGid9OXwflc
	VxjJpbg8ZZwEEu0dT70Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ulSzv-00000007txs-1Fry;
	Mon, 11 Aug 2025 13:55:35 +0000
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ulSvo-00000007stO-2vGI;
	Mon, 11 Aug 2025 13:51:21 +0000
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-76bc68cc9e4so4434121b3a.2;
        Mon, 11 Aug 2025 06:51:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754920279; x=1755525079; darn=lists.infradead.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nklRgqEsHAGsTa1ZY+Tu1pfGAj2pLA2XYPvzJl54xAU=;
        b=BtEtuq8kuZK8UUsSRc3mfiNZozzCZjFLfQ+xP+lhMYrJOlEsnNkRwfPrKTCcRIFnL0
         SyVWNNoC9YVkVaZhu/RRfaiJ2C0p4YljwVInMe6hzPX1PPm0cepDn6TzG15QcqC6HIex
         dNKFt0VVPAJpzFZnjpgbNSUInbAyrILc3fhjao6P7K0AizHn/kI/+8Jt62+hrhsLxh+S
         CqM4WYqPnC+HawsgFgo5F9XTDJ4MCLBlc4wg7WyNmMvlLVFS+bF/4e8d/w+yEqwzs2kU
         9CobH4dipMaL6XXH3kSgQb2eSXxMR6+H8Cjdyfp741Z+SbICnMvpIBtVyeR2FmaZcr6O
         PNqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754920279; x=1755525079;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nklRgqEsHAGsTa1ZY+Tu1pfGAj2pLA2XYPvzJl54xAU=;
        b=DR2LS4P6aMhcA1G21dHdZhSTMbFuN2Gr+PUZF6+I3C+DFFL5GY+lkkJJpWDquU5uxV
         RKrbr0OWE0448Nhbu8bsY1XSESjH5V9bdyZx25fLBxpo0kqalC4CbSzXUiFdAtdqvkPD
         poNDlf+aITXNsenkE1CxLzOI7TWpZ2F+21PZRkLO6NDWYu1JaSdmMizHyByiKDg43qHG
         g8x22ylEFwmuThMh9kcdmVwNZTlkaJ6ucWHX2Z5L4EGS671iSOQlF5hj3C0xBOladjK3
         IFCVSEAlPtsvU7dgh4pUq93UuU8qHD4Yp5QY5N2TEoCT4uf27im1HWqNfPQsGaoQ4eCp
         nNxQ==
X-Forwarded-Encrypted: i=1; AJvYcCUGj1BbEAGgdQW16j249rjWk5uMLO4TIep613TuAxz12GvQCDW8e6r5KTWRbrSyJ3i31ievGybH4WfQrk0UB7m+@lists.infradead.org, AJvYcCWcpx4Rhver6yWRuHzrk9qt0XUCPTJZZ1g8prlTg4mk0amUJMh6NsgxOAU2AbVFNFs4QLMLN5dD9yYpnA==@lists.infradead.org
X-Gm-Message-State: AOJu0YzmjTMNUk5kPMrHQPhpQ6l8Mpdv+Kuie6QhELRKgWz4wnUGbP7k
	WfxPuRG/e2gqd4usuvDqkW2OnYkvosA1cz7b/UJFu7/lbo55Bi9eauTJ
X-Gm-Gg: ASbGnctPd1TIpdCH9JMw6edB7PnqBN4uyXPodkHHzhCCa3UPAxwDIRfee06f3mIfg5R
	2MesH8fUkiz+aUZhI33IAv55jS9BrvNDjrdR8xc1KQGnSMiK39aIn6FIlQFLgyqeLK9CcLi1n86
	wikq8bz9jSfqMO5m5pqLeJnklWY0r4JtjnRkSD18MtJwVh/R82DtSxOBi2xhuvg5Sl/QlIBpLVC
	xZhmktv4qQkp3EOV8bDHSQZQ8qbrin7lPJ8Am3xcrWPz1DgiICPuCe1X6YVc8Lof+83t+LuEL4Q
	NkJBtbaBtDzWTR3vsXKp/BLb6kg/Ej/oL8jq2V35ldsNvOtBZvJqlqFsk5LxjtHhBog792LjGGn
	4JUFnQFwl4cO+bPs0wM8bJ81JjsQyOBJDAW4cfstY1X4W9I4=
X-Google-Smtp-Source: AGHT+IGq94mROq1kQp74KcNsr2aCVZFxAFsqWWVl9F1p61/0vbOTUbqwhFkFA/aTivlG4DM2EdN36w==
X-Received: by 2002:a05:6a20:729b:b0:240:1b99:1595 with SMTP id adf61e73a8af0-2405503b294mr22135196637.17.1754920279511;
        Mon, 11 Aug 2025 06:51:19 -0700 (PDT)
Received: from [127.0.1.1] (061092221177.ctinets.com. [61.92.221.177])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-b422b7b2700sm23504993a12.15.2025.08.11.06.51.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 06:51:19 -0700 (PDT)
From: Nick Chan <towinchenmi@gmail.com>
Subject: [PATCH 0/9] Add support ANS2 NVMe on Apple A11
Date: Mon, 11 Aug 2025 21:50:52 +0800
Message-Id: <20250811-t8015-nvme-v1-0-ef9c200e74a7@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADz1mWgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDCwML3RILA0NT3byy3FRdc+NEk7TklEQj05QUJaCGgqLUtMwKsGHRsbW
 1ANwFyztcAAAA
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2166; i=towinchenmi@gmail.com;
 h=from:subject:message-id; bh=Oq5GQuC/JNsViijmu3PLBEoA7oCG3f8Cu1LxMk/jNbo=;
 b=kA0DAAoBAcoIt6bFCCQByyZiAGiZ9UygSJFejRzKvKje7erg2v7F8u8vJytX6bwLURWcvnxWf
 IkCMwQAAQoAHRYhBEtSeHhcl6z3nDxogwHKCLemxQgkBQJomfVMAAoJEAHKCLemxQgk5wUP/3Z+
 IKj6xYJEcai6WXIyhJi7FDyM77bltJK3+PIULBiRtdPo3V8TS7z2nCxFh2D/Om27QtBouxTNhfo
 LZ3JI385XvxrLVy+yrTGJkatN1VQU9Oom7RLzD/pip0MwP98eDlQboPFagc9tg1dHlUt7IuON9/
 /C4vjiAs+1yI+nTTt2p+tbxRE+MSvzjSvJm74RIuHWqYMf9KLb+QFJ56kiwL7P5N1ZpwNyBDoNP
 aYftDDeATWxKvtrhDjTtu86GMny/seIBA7dPAYL2zKcJvIQtm6OmPk9xD/NZylp2zh0SmjpNANA
 TaypNVSb8nihVS+e/c8KKgP9IWkmZOOU3aLXjmANOZtHuMZDH8cFqhMH8Zrh/BcobyKU9YbWqu+
 PlhglO1RC8nNDewJgtl+SHi3l3Rcapf2F1BIDui0QHtuTdEyBCGYscMTU5cuRHmIizl1xvsoj3r
 +qa/SRVfFLyAkJMR1nKzj7esueepkFlFrBy18zYroSKP2npoJuj82i1Xe+4gUpt/3WWdzZ7uG5z
 vjgqILbva16rbaTo/oT4cF1tGc8zlmkhD8KBYVsZVkYhx1ngmh2wgBET6fFTwnG0wTb2B6plO7R
 9TJ9wp4oDLPvERdEW6ohG0GwDfJFpra9woRWnUeQOj4uzZEBknwQVy4KFitG887WtsOBScs3gw+
 OKeg6
X-Developer-Key: i=towinchenmi@gmail.com; a=openpgp;
 fpr=4B5278785C97ACF79C3C688301CA08B7A6C50824
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250811_065120_742328_509F2226 
X-CRM114-Status: GOOD (  14.36  )
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
 arch/arm64/boot/dts/apple/t8015.dtsi               |  34 +++
 drivers/nvme/host/apple.c                          | 228 ++++++++++++++-------
 drivers/soc/apple/mailbox.c                        |  19 ++
 drivers/soc/apple/sart.c                           |  60 +++++-
 8 files changed, 282 insertions(+), 83 deletions(-)
---
base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585
change-id: 20250808-t8015-nvme-73a4fcda25dd

Best regards,
-- 
Nick Chan <towinchenmi@gmail.com>


