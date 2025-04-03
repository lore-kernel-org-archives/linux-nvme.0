Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3268DC3600C
	for <linux-nvme@archiver.kernel.org>; Thu,  3 Apr 2025 23:24:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:To:From:Reply-To:Cc:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=8Q1HJbhWKpyuQLE/tjeRz5EHmjAiJdcKFzsKrfzXyKE=; b=kJGIyGsTJsR3v8rH3ccEgyHePu
	WLAB0v+dPWp45oAjOwnL4MMtnb0kT/15dtlFINCMHq+xjKdSr2qa2KN8CozwuzvsiBQ7IUJ0jmpRU
	3EaK3p/9/IXxHkT/SYO7+LGmXRkA/FLVWbhr0hUUL1B9f3Y1q37pzc2YldeN0pHXtEDLXix+L/JMF
	2ls+k+EqvhxwdbW1bZzoUSmXgwtDIsOZqS/JH/NtzRmFNnzt7XvyzBSbV81dBAh+ArO9uCX8L56CO
	0D2KhosnZXgy5lS0Vj9AZGNf0V6Im1Nxb+4Ru4bKoMFOFa6fNHze48MJiw4RvbyDd9mFZ+IUM4Sby
	hsIlb/nQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u0TvO-0000000AJqu-0ldw;
	Thu, 03 Apr 2025 23:24:42 +0000
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
	by bombadil.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u0TvL-0000000AJqT-2KvL
	for linux-nvme@lists.infradead.org;
	Thu, 03 Apr 2025 23:24:40 +0000
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-224191d92e4so14380435ad.3
        for <linux-nvme@lists.infradead.org>; Thu, 03 Apr 2025 16:24:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743722678; x=1744327478; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=8Q1HJbhWKpyuQLE/tjeRz5EHmjAiJdcKFzsKrfzXyKE=;
        b=Yp+4Z1BSdi3U/95v0qFjTEObLL4Zgol8yL+VJzunogh1rDHFp4bu82PZtsuRCb9rXA
         4SleIKdSUTDeZlpM1R+xd8EBoV5V4QfXpV9eIed+ioBiBxpN5OrcHBOKeB7NsZxjeqjZ
         Fg8ZjT9vWxlURxhITaUM4USrIRwOfNB9tFBR6se38bEXmltpXZp14fjLRyX2PNM/wi6A
         +h9nWlLVon18cujY2GeWsBkBX3fk6SiF0jJf4nISWmC/s8glyZxR4j47qjcQfkokCTXB
         ninlB68xAnyMTYBOlm7mNF3Dw0WIxMciL3xqCBWbFnfTHoPIXzuiw32D0jwMzOtr/7Dc
         stXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743722678; x=1744327478;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8Q1HJbhWKpyuQLE/tjeRz5EHmjAiJdcKFzsKrfzXyKE=;
        b=ft/FyaU8dOR/MYtkRlywqDq4hm+CQELOGFXB+peN5ED8z76zAz4SxD927hAyOpAE4x
         NMRRZOHoG7tliJEjk5p+1xTYgmmv8Mm2LeUNb0xQWNQoMWzezacCq8kyUlw/JxU6Ffwy
         bqrJzSWMxJ7E3Wy19d/m70mHiIQnvZp7qauCfd2Xkqq39n+hhvxgVMrVrBApLYjfAD64
         Ugg2Sj7QqMuorZCnau3mDehEoYKRhmyr78MxCwYl2cBMXpD/CM3XQ1AlllAejN03U9dJ
         wJK63OKSrSh9PVJT0lhnUr9UZzS0aSLQLujkPrxeA06mtvz0E1YvQXr3mUD5XIkYj64V
         4c5Q==
X-Gm-Message-State: AOJu0YzCLNUqLLkzhDrV1ih/MMB95nMa7RnRYS2EnL3B3KtgQtomOPft
	k2c1wnMZiIaUz3txUvC2JbMELN1GVcykBEFnd4OJz8JhyMgHleP6FfM6QV8g
X-Gm-Gg: ASbGncuSs9vVd+MrMDJPFcrbMWlqfTKJh8qWhNf3Z7Zxfk4P4hrfesd16FiLHCyEYlW
	xX3/lwdPkPP4mGHvAB57i4CNCL1X/d7wBUyu8sXhw6ff61wKw60f4efqD+Tutz2Piv0iJ4xUURM
	gWf/FNmKq6ianlS14d71p7jnPT5L0A6d3tpT415bR2p5e06En79XzPCU65KCY8Ckuo95zry0K+x
	P+L8zrPd09HuZ/XSOvXNKVsa57cIh4A5FJxAiaElYm86LJbNA90byBqiucNKAIq/+WtyOeCiyaZ
	Ex+/jzzm3QhOgc5U/ER5WtGB5u8VeC5I8zee40tzgheg
X-Google-Smtp-Source: AGHT+IE9AV4Ouxje8y8MO1JFpgcDJYYxSVrmCuAmlacRE3v5vT/XRLmaf4o6IKCXeWbbNGcPd+jszA==
X-Received: by 2002:a17:902:c40e:b0:21f:4b01:b978 with SMTP id d9443c01a7336-22a8a0a3630mr15347415ad.36.1743722677760;
        Thu, 03 Apr 2025 16:24:37 -0700 (PDT)
Received: from fedora.. ([2804:14c:64:af90::1001])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2297877273bsm20108635ad.220.2025.04.03.16.24.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Apr 2025 16:24:37 -0700 (PDT)
From: Marcelo Moreira <marcelomoreira1905@gmail.com>
To: linux-nvme@lists.infradead.org,
	hch@lst.de,
	sagi@grimberg.me,
	kch@nvidia.com,
	skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linuxfoundation.org,
	~lkcamp/patches@lists.sr.ht
Subject: [PATCH v2] nvmet: replace strncpy with strscpy
Date: Thu,  3 Apr 2025 20:23:56 -0300
Message-ID: <20250403232432.25255-1-marcelomoreira1905@gmail.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250403_162439_595546_70912D0B 
X-CRM114-Status: GOOD (  13.16  )
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

The strncpy() function is deprecated for NUL-terminated strings as explained in
the "strncpy() on NUL-terminated strings" section of
Documentation/process/deprecated.rst. The key issues are:
- strncpy() fails to guarantee NULL-termination when source > destination.
- It unnecessarily zero-pads short strings, causing performance overhead.

strscpy() is the proper replacement because:
- Guarantees NULL-termination.
- Avoids redundant zero-padding.
- Aligns with current kernel string-copying best practice.

memcpy() was rejected because:
- NQN buffers (subsysnqn/hostnqn) are treated as NULL-terminated strings:
  - strcmp() usage in nvmet_host_allowed() (discovery.c)
  - strscpy() to copy subsysnqn in nvmet_execute_disc_identify()

seq_buf wasn't used because:
- This is a simple fixed-size buffer copy.
- No need for progressive string construction features.

Signed-off-by: Marcelo Moreira <marcelomoreira1905@gmail.com>
---
Changes in v2:

- Added references to where to find deprecated strncpy.
- Commit message with detailed rationale for choosing strscpy.
- Added explicit rejection reasons for memcpy and seq_buf alternatives.
- No code changes from v1.
- Link to v1: https://lore.kernel.org/linux-nvme/20250403042737.GE22360@lst.de/T/#t
---
 drivers/nvme/target/discovery.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/target/discovery.c b/drivers/nvme/target/discovery.c
index df7207640506..c06f3e04296c 100644
--- a/drivers/nvme/target/discovery.c
+++ b/drivers/nvme/target/discovery.c
@@ -119,7 +119,7 @@ static void nvmet_format_discovery_entry(struct nvmf_disc_rsp_page_hdr *hdr,
 	memcpy(e->trsvcid, port->disc_addr.trsvcid, NVMF_TRSVCID_SIZE);
 	memcpy(e->traddr, traddr, NVMF_TRADDR_SIZE);
 	memcpy(e->tsas.common, port->disc_addr.tsas.common, NVMF_TSAS_SIZE);
-	strncpy(e->subnqn, subsys_nqn, NVMF_NQN_SIZE);
+	strscpy(e->subnqn, subsys_nqn, NVMF_NQN_SIZE);
 }
 
 /*
-- 
2.49.0


