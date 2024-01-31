Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DD6AC47258
	for <linux-nvme@archiver.kernel.org>; Wed, 31 Jan 2024 16:43:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZoqrfpWjUwoWaB5gNo0cbkLOTptHWLhNoaBCBLCwYi0=; b=yw31aQX7L0mffn/bn1YxUVK7fH
	lSeoDFBsZmxZYylBbP5BV3XzPK+uD/tHjH4LHXWX5w2vbCDITBlOxo53R69skhrSTJtSr3Sw0Co9a
	ZCbKojR40yklfhMUbxrIf538DSkbyTY+OlrfXFHPc4/cA1LIxvJVTA2ENKH8RXFJ8xYzP21g/ePFI
	Vk5c/s5rjMkpPAXhyuiLTRA61G+wchP2CFrS1sZbSGS35/f7MC9u8kSfut1V3fQupdI6vf1CQzzqe
	CFP0kx7qX0TVFp4ziHv6+iX3/1ONnwP1cp9NJCQKt96MzWCmoW5F/7zi6Gv8qKWmJnJK/LNkwyfqu
	czLc92Mw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rVDge-00000004any-1GZH;
	Wed, 31 Jan 2024 16:43:44 +0000
Received: from mail-io1-xd63.google.com ([2607:f8b0:4864:20::d63])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rVDgb-00000004amH-0wpA
	for linux-nvme@lists.infradead.org;
	Wed, 31 Jan 2024 16:43:42 +0000
Received: by mail-io1-xd63.google.com with SMTP id ca18e2360f4ac-7c00128de31so102286539f.3
        for <linux-nvme@lists.infradead.org>; Wed, 31 Jan 2024 08:43:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1706719419; x=1707324219; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZoqrfpWjUwoWaB5gNo0cbkLOTptHWLhNoaBCBLCwYi0=;
        b=MPUdtyaK14qysXw78rHN5yWOAZ/mP16GXYw97jKANttzhuY093AdFov15hnL2WgQHh
         fQNUl350yFKImOt7S9/Tavq3D9Lkh3IaG0jHqOqt46/lAM6Cf/zhlV/G+nndlG21q2lf
         ek3eIsDu2uswUs3Z5D0rLHzTWKhrXFvqGFM6lXarwF7LTvLZbOWAS6TWp6ia0BCaw8v9
         l3Rvsu6PtjvKguHJ733u4YVa/85kgNXvukpJ2Cwk4WE9BVJln+1qTNKs3Yxx5RxNQ49P
         rA5uYnkuX8a045l8GT1t1ki/hhG28TTNBarjXpRU+RaZmnBNT3zs+wX7MfBqmdlJLN/9
         0+Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706719419; x=1707324219;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZoqrfpWjUwoWaB5gNo0cbkLOTptHWLhNoaBCBLCwYi0=;
        b=jrgo9UT2bAqu2q/dHG3DlkWxiY4GGX1rRcpUflT8hDUhd9/9AnDe0LIxtp7utHBmfe
         VBwG8KAtMIo0w7BfSFnponAc6v9FNCxPbQwcRYbH0nIbWeGd4Uy8X4NYRo+VwOwvA/T2
         GWKLDXNJYZk5pGsOAPjFJvABx/2GzggmxAoFa0Z4Lf3ZyBEYhwQ+AKCchCRURPNgIvkH
         oSELG4OQWMHvhj77VBm0WOR9SPOf6Tk5i77y8O04DXcP+fuFPtR6UtELzu8spwznugE5
         mNDTEFPHvTvq3zPBhjZD3vupH6aWYq74zsiq36QkZV1W492GD2R+PO63hco6zU4rwJKK
         DKaw==
X-Gm-Message-State: AOJu0Yz8JpmBAE8iKUMBPZItwTrcY3DB3PmiZ46kR2Qig3NZEBLpPOAA
	0n7qFVDmXyk7gzJR4X3Q3NFj7ha/61+cq11LMy70apU3wP8M+tE4DVW0XWtusGkRth2nAupKRYT
	1ZPr1fPhsDSR8yyV++iDI2uOzzcnZ30tSBsmnjrMRmewcUz0a
X-Google-Smtp-Source: AGHT+IF1xdJeTcTLK/b9triR8eXfgGfAK+uxiAWF3Nkr8c5+SpBSS9ZQMgyA6txsYC170XQ0Tl7Xpr6aWO5N
X-Received: by 2002:a5d:994f:0:b0:7c0:273a:c060 with SMTP id v15-20020a5d994f000000b007c0273ac060mr1461516ios.8.1706719419628;
        Wed, 31 Jan 2024 08:43:39 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id gm3-20020a0566382b8300b0046d3419ebb0sm324216jab.82.2024.01.31.08.43.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 08:43:39 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.7.70.37])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id B1D4D34071F;
	Wed, 31 Jan 2024 09:43:37 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id AE08CE4FE75; Wed, 31 Jan 2024 09:43:37 -0700 (MST)
From: Caleb Sander <csander@purestorage.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	James Smart <james.smart@broadcom.com>,
	linux-nvme@lists.infradead.org
Cc: Caleb Sander <csander@purestorage.com>
Subject: [PATCH 3/5] nvme: take const cmd pointer in read-only helpers
Date: Wed, 31 Jan 2024 09:43:13 -0700
Message-Id: <20240131164315.160042-3-csander@purestorage.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240131164315.160042-1-csander@purestorage.com>
References: <20240131164315.160042-1-csander@purestorage.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240131_084341_466346_198D9F4F 
X-CRM114-Status: GOOD (  14.46  )
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

nvme_is_fabrics() and nvme_is_write() only read struct nvme_command,
so take it by const pointer. This allows callers to pass a const pointer
and communicates that these functions don't modify the command.

Signed-off-by: Caleb Sander <csander@purestorage.com>
---
 include/linux/nvme.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index 68eff8c86ce3..bc605ec4a3fd 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -1810,11 +1810,11 @@ struct nvme_command {
 		struct nvme_dbbuf dbbuf;
 		struct nvme_directive_cmd directive;
 	};
 };
 
-static inline bool nvme_is_fabrics(struct nvme_command *cmd)
+static inline bool nvme_is_fabrics(const struct nvme_command *cmd)
 {
 	return cmd->common.opcode == nvme_fabrics_command;
 }
 
 struct nvme_error_slot {
@@ -1829,11 +1829,11 @@ struct nvme_error_slot {
 	__u8		resv[3];
 	__le64		cs;
 	__u8		resv2[24];
 };
 
-static inline bool nvme_is_write(struct nvme_command *cmd)
+static inline bool nvme_is_write(const struct nvme_command *cmd)
 {
 	/*
 	 * What a mess...
 	 *
 	 * Why can't we simply have a Fabrics In and Fabrics out command?
-- 
2.25.1


