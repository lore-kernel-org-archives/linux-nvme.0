Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F4A6E66886
	for <linux-nvme@archiver.kernel.org>; Sun, 21 Dec 2025 21:26:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Message-Id:Date:Subject:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=XXNFIp9vLw9nLLBnAjdGhd5yV1ax+D2MO8MohMDXvxY=; b=1beqSNeBBIoqXw
	/k03VAYrGo3wTRt208m+hQTAJmHN+yCDw/O+prx2A5mvP2Oh/CdgallrLbxT5wzfuaIIEu+XgtTTH
	F0DTqD/WekIICNn64TPMlmMEDhPL99RO10pbDXzQ7XYxA4C1SkEYyUbf9j0N0KdEoWZrYxWJlc9yW
	1ITFV/VoMmW6LeOvDRTq2akqKTLW2hos55ZvjCw6jMlj8+Pxfjq7WW914poz9FA8GjQdY/oEFiedv
	DU4YFLzEbU9t18od5GJjqkDAIiSOtEK6/QXaG1G5rpI3gIxfHGdm78y0bVM9vHtZcdeUApTErEwnu
	zUjlOXybgcZzKwfC32aw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vXQwZ-0000000CmY3-1Iss;
	Sun, 21 Dec 2025 21:26:23 +0000
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vXQwW-0000000CmXL-3xQC
	for linux-nvme@lists.infradead.org;
	Sun, 21 Dec 2025 21:26:22 +0000
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-2a1022dda33so27301555ad.2
        for <linux-nvme@lists.infradead.org>; Sun, 21 Dec 2025 13:26:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766352379; x=1766957179; darn=lists.infradead.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XXNFIp9vLw9nLLBnAjdGhd5yV1ax+D2MO8MohMDXvxY=;
        b=X/iv9WDtPrL0JV7xJo1YXqUqydeSIeDslvtg4eKZjnNFrrN1NDQv/USvFxM1G86Oto
         3GwjDfrJyT3fVJVH/iJthnaGf8Xkhe9ArZJhSuJIw5PViiuzdlxXvnGxGbknn4L6xwuf
         cWy0y5A8L160GTf9bkfgmUBsABa1+oOoGBTyYrRSFyVabebXYffUVdAlQ3b3lda9ygZM
         5YHI2vO1XBL0KwWm9tPcVRI4L6PkG9ANqxa7xAh17b1D1QQ2SitXxkza1I+VtfnMZd52
         xYLE38tyK6ZUDHpIQHCOV3O8KDesKCZlnAy3+uMgpKUAQsELncysvZTexfOB8ICFZ9Zq
         z+yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766352379; x=1766957179;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XXNFIp9vLw9nLLBnAjdGhd5yV1ax+D2MO8MohMDXvxY=;
        b=vH9TbNjS4jn2VAFcIJDvlF1EF/t7NY4lOp+oiNIe2Gxwlqi2sSQiwKP8gG+cgP3f4n
         mUMTvWhsvRO0PQ+fBZ/XpFUv/trJ4wElO9+nG3DZBZoyXgQVGHVMq/N7V3pMwrsZyiLl
         0v+c4xYtGav9qZ+tNGIjwdS2Rj3aMlLzDiZADyRyAQIBLAMxY4pqPKp538gsLwXTDGTB
         Q3qanMx9kF9ovQr16PQ0JAL05P9wYlYoxiREcArwJCwmPMzkkyF24x+a4FE3X4FzIhbS
         nE/u9HLKCeBPKv0lh8vntS7XRLRztDMFKEq1xVLpu/p7kyso67f5/Sh6aoCcbMyY0O9s
         Z63A==
X-Gm-Message-State: AOJu0Yw9km6foUmqxJO9/SioSOtr8QoddqVrj0zVlYn62bzAe8dk2Ub3
	CRXfdnlyrd8etVS0FOx07s8VMx7ltgivp0SWPBUWodUlqM80df1bIDpg
X-Gm-Gg: AY/fxX6L2+D0smu36jtEcTRKBeocxJSnpEf/zqSfAZg3GzIAynwdfUSj/ATFG3uBECu
	LUCrn5H5aPIN+Ea1ak82zWLgS/NSr1Cn0DzNfVXkuMtxqFJXxj5QMwzgqYWaT13utXGnDlQCv93
	gDNMgRrJltlsxrn4ON4IHzxseZ0isvXj6Z+qaZFy6sENByktOKoXErDPwP+8qaGk/M4eITUMVZz
	SV2Z0ggF4tSRFE0YlQkC4AIP8UGluiKAaJCSxKl4Z/rPfeWo+mOr8soT3UMDh5Ah8XCRtlfEnLv
	tymp9pjejxD083rNspGNLi/co04116DGU7OcdNLGVIbW+6JLreuix2EzQ2+WsEPJ4xHmOmKkmBV
	QLzTkHknq/26+9iw1RKkgXUHnF+URiIf8oT6WCEaMjs8BLpP3IF9b55pjgeTFbSMQku+Gs13vBJ
	yCA1XH70RSLd6ubgm3WHOEuQ==
X-Google-Smtp-Source: AGHT+IFhhJk6b7F6fDODLk2MJzNl92covc+rnO5nJvw1HxoYxr70btshT+DQ1b01cLl5hm9gcZ4cVg==
X-Received: by 2002:a05:7300:ce89:b0:2ae:5d5e:9b1c with SMTP id 5a478bee46e88-2b05ebd0c26mr7965240eec.2.1766352378980;
        Sun, 21 Dec 2025 13:26:18 -0800 (PST)
Received: from [192.168.5.71] ([172.59.162.202])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b05fe99410sm24884636eec.2.2025.12.21.13.26.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Dec 2025 13:26:18 -0800 (PST)
From: Alex Tran <alex.t.tran@gmail.com>
Subject: [PATCH 0/2] nvme/host: perform delayed retries upon non-fatal
 error received during nvme namespace validation
Date: Sun, 21 Dec 2025 13:26:09 -0800
Message-Id: <20251221-nvme_ns_validation-v1-0-9f7a385707af@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPFlSGkC/x2MQQqAIBAAvxJ7TsilIvtKRGhutVAWGhJIf086D
 sxMgkCeKUBfJPAUOfDpMsiygHnTbiXBNjNghY1ElMLFgyYXpqh3tvrOurC1NoSmU0a1kMPL08L
 PPx3G9/0ANIDMRmQAAAA=
X-Change-ID: 20251221-nvme_ns_validation-d4abe2b89b96
To: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Alex Tran <alex.t.tran@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=954; i=alex.t.tran@gmail.com;
 h=from:subject:message-id; bh=Rqvm7f+Czer2vbdcb8BCmcKgdmVFLFgPVNr+VhNZiok=;
 b=owEBbQKS/ZANAwAKAXT5fTREJs3IAcsmYgBpSGX5rpoKB9vsYTQ9OP4Gp9i5EP6pv7SRAKlYw
 T6eZMA8PeSJAjMEAAEKAB0WIQQAohViG04SVxUVrcd0+X00RCbNyAUCaUhl+QAKCRB0+X00RCbN
 yNGTEACvOjhmEkZUR2DqMk5s8PW1xdCeaOqzauaisjKsvY1CRo0FlTj1zQ9EPsDfCzyqqb8Z8Ve
 V/F8W7L8UvMifA1yX1EryQwju3VA4x+h+wkUmLtsVuc63kKXBjmt+lKo5M5pgaLuCRi4kswMvSD
 ZjEcZg6uv6lm4nKu/1yGvXBG46GQqqOe2uJ/WJjJyy06Rcu1tYdtdGmlyo//32JBxlHwQ1Yz/QX
 FJk/tklHIKoy9BWKueRxWFivZXgOlAcX/B0v0jbjg0zY22RwN5ynuTUSJF5NrXb24S/DDq4MxpK
 3l5NEuCdJuJfWblGZqjUj2oQUljATprvVyXt5VhzOn6QOkGUkfSyP8fFAZ7xPBlv1oNUY3uMWbi
 FI7BOEA7OMHmpdlMTKNxZLep8j/AA1YJa2HoYdLjnKIFOsGmus1FnaRUrnEALaQBAvsj298kSpx
 QvOGJzW7472LuXEltww+0FU4Q4Xiuce5AMcXEez6ASt0hp2L8BeL6CJYVYyTC2tn6w/KHy++uhh
 rulu04KUnD4CKRcLBUIfRrrHNkxJg23+kR/0NeLmLoEqUkp2Q3jT2tL1SPK5aRUYlymy8phfZLC
 Car4aV5kfrBYrdqdapk0GzA5env/ysvnzaFYOPzkP3yOkOY9YuUdVOo6BHxhENTLnS1eOz4A4XW
 FnYjSTQscwwq7mw==
X-Developer-Key: i=alex.t.tran@gmail.com; a=openpgp;
 fpr=00A215621B4E12571515ADC774F97D344426CDC8
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251221_132620_994267_209D250D 
X-CRM114-Status: UNSURE (   8.61  )
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

This patch series aims to provide delayed retries for nvme namespace
validation when a non-fatal error occurs instead of ignoring it.
An arbitrary amount of retries are performed over an arbitrary interval.

Patch 1:
The nvme_ns_info struct is moved into the nvme header file.
Patch 2:
The implementation of the delayed retires performed on nvme ns validation.

Revision: 1

Signed-off-by: Alex Tran <alex.t.tran@gmail.com>
---
Alex Tran (2):
      nvme/host: move nvme_ns_info into nvme header file
      nvme/host: add delayed retries upon non-fatal error during ns validation

 drivers/nvme/host/core.c | 58 ++++++++++++++++++++++++++++++++----------------
 drivers/nvme/host/nvme.h | 24 ++++++++++++++++++++
 2 files changed, 63 insertions(+), 19 deletions(-)
---
base-commit: fa084c35afa13ab07a860ef0936cd987f9aa0460
change-id: 20251221-nvme_ns_validation-d4abe2b89b96

Best regards,
-- 
Alex Tran <alex.t.tran@gmail.com>


