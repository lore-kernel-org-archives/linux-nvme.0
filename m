Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7C15C25B76
	for <linux-nvme@archiver.kernel.org>; Tue, 11 Jun 2024 10:02:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=Bb7TwbxjwE4z3urktL4tj3C/83DBgRI+FwFWe0rTRDI=; b=Itct1Ltdqsnz/naowF0TTERJZ0
	GGi/2E5QUPRrkDKNPC1LFHFt0h2e/CN6s7/k8NPtwOjb3xo6AnnkonY+iMhSHFeUdOWb6atITpMY0
	a3It7AQrq9dvIv0AxU4Y8Eyd4Q7cxMPX445k/I4wbEPMEpW5+HPcTel/zZlrQLiHLde4ddgl+EGI4
	bDzhBPbvnQJheRRFl2kEktcYtk5CjI2rRecTdQuSzPZeT/0YjrVwcpzNIgx8cR7lzbd6/+nqIzIdk
	XjMC6F2UE2rgid08/qp+FLrstziDmnppoW+T8MDAYzEI+f+05TI7XJ8fC3tQnp5eGCCaCqtMLMerQ
	2lVblpSw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sGyKW-00000008MkX-0nIY;
	Tue, 11 Jun 2024 10:02:16 +0000
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sGyKS-00000008MiW-2nlU
	for linux-nvme@lists.infradead.org;
	Tue, 11 Jun 2024 10:02:14 +0000
Received: by mail-pg1-x52b.google.com with SMTP id 41be03b00d2f7-6e7e23b42c3so2073258a12.1
        for <linux-nvme@lists.infradead.org>; Tue, 11 Jun 2024 03:02:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718100129; x=1718704929; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Bb7TwbxjwE4z3urktL4tj3C/83DBgRI+FwFWe0rTRDI=;
        b=l2Bf6kh7y7SsASRkyIM0aH7xJ0BOw+0I3IZG6NBKOKvThOhBktne9HT9ON6rm0qiFB
         weHa/QXYXFXJWedmYjWewT+bGYp+4rNfsnqJpcpNe0Qus212J9MM1AaC00uSlzwzt144
         JKjsyfDuZm7/466QiG7nLPo0ToW3bwlQuG0rnvc5/gMnzDetbXb+2AMZnbFYOjBAWklh
         2fs67ZIFyT8/7CFZPrGyFRLl65MEynwq4yThVu25AXzNM0F20f3BsGJRPVqVpdsHx1wu
         N/JP1pSRwzqH7cn1LxOaWleqXhsfccADL9LANWB8awq2V4GqUaGn/2ncWwicF4prQ0kR
         j8eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718100129; x=1718704929;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Bb7TwbxjwE4z3urktL4tj3C/83DBgRI+FwFWe0rTRDI=;
        b=XTqvOygiwAPHpGA81ggF1yYRQtS/QmQ4jtvtpfsXDUHj/DCjDXyb40ZI8Tn8eCsGxZ
         HNFaF/67RoeygiV3ro5ueQEO2GaCZNCKKQHllVOv6BRfw6oWDYuzxb0CAReDb2Ap1T35
         jxR+gFfgltBlEJEIB4f8fufQNvVLXoCqzwwIb58iLCjLNiJOHI9aEIePi/No6rAoJ+sW
         iDaiBpk3H/9ynAPvfsTnyOcL3q8SxB0ZHfyrMkrysJ83Esd2i9VoWlmVxID/Xq1x3bIu
         2XtpHKcyeht2tt+qFe5ndZSnCpxbqc80KbJi3WrD65um2sdDPDb2GWO5QmIKDkU+ImtD
         brFw==
X-Gm-Message-State: AOJu0Yz8VahXflXa5FXgWH+kXxV1Y12z0+5Ajm5i517uZH5jNc52Qj2+
	5L9LPqK7pHh7D0JohBtPBn+AwvqNs2Q1jsmixgKPuhlVLwfd7uJ4p5Od4Oo44Wo=
X-Google-Smtp-Source: AGHT+IFNwdlUQQWrWIO47c6hGSohBVikjT1TDbiNTz/FFIUFE0aPnw6NSVNXhn0QA4HypAKW1caO2g==
X-Received: by 2002:a17:902:d487:b0:1f6:612b:96eb with SMTP id d9443c01a7336-1f6d0395667mr139224545ad.50.1718100129058;
        Tue, 11 Jun 2024 03:02:09 -0700 (PDT)
Received: from localhost.localdomain ([143.92.64.17])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f6f96c37b6sm55302755ad.231.2024.06.11.03.02.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jun 2024 03:02:08 -0700 (PDT)
From: "brookxu.cn" <brookxu.cn@gmail.com>
To: kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me,
	maxg@mellanox.com
Cc: linux-nvme@lists.infradead.org
Subject: [PATCH] nvme: avoid double free special payload
Date: Tue, 11 Jun 2024 18:02:08 +0800
Message-Id: <20240611100208.115211-1-brookxu.cn@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240611_030212_977771_385FB2C0 
X-CRM114-Status: GOOD (  10.23  )
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

From: Chunguang Xu <chunguang.xu@shopee.com>

Now we may double free spacial payload for some requests, such as
discard. This will corrupt the memory and lead to kernel crash. Now we
will free special payload before retry it. If we disconnect device
before reconnect success, then we will fail request by
nvme_fail_nonready_command(), as a result we will double free
special payload. Here try to fix it, we may can clear RQF_SPECIAL_LOAD
bit after we cleanup command. This will not broken following clean
logic of blkmq, as nvme request will not be partial complete.

Fixes: 16686f3a6c3c ("nvme: move common call to nvme_cleanup_cmd to core layer")
Signed-off-by: Chunguang Xu <chunguang.xu@shopee.com>
---
 drivers/nvme/host/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index f5d150c62955..c40930d10bd3 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -998,6 +998,7 @@ void nvme_cleanup_cmd(struct request *req)
 			clear_bit_unlock(0, &ctrl->discard_page_busy);
 		else
 			kfree(bvec_virt(&req->special_vec));
+		req->rq_flags &= ~RQF_SPECIAL_PAYLOAD;
 	}
 }
 EXPORT_SYMBOL_GPL(nvme_cleanup_cmd);
-- 
2.25.1


