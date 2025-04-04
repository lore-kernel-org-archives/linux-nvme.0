Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73984C36010
	for <linux-nvme@archiver.kernel.org>; Fri,  4 Apr 2025 20:07:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=2M1hpXYJrQhzvhFIXGwXFXDV00AlUZW/lxOdiQ1kbxM=; b=4eHO+AZdxYyG46qscD6CTGGrn7
	7XoECDKlZo+kX5kCQ0NQa3cXWJDWW/vuiL//tLl1OuzFjVPRQroST8VyXB2ylhr7MflOYdqlTqNe7
	Goe2ww5BHMLadKa9rCX4WFj59p8O4H7w07cuzNR2CkHmqCkLQuGd1Zh0johYCW5ELtJCanb3YhMBs
	9ev2VGSJiqvr2E4PIWt9p6K2pR0uabXKzzsty+nCpcGF+NbLSRAqVLVsd0tsCrf7LDRVQueSdWVRq
	Za+gmtoAZoqSR1sJifLD7n4J5typRc+c8hazqkScE8upD3YR0F9T+heNKSu5YS3ar692Y7x/K+Sxh
	/UQG1OcQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u0nJd-0000000Cjxg-0x8I;
	Fri, 04 Apr 2025 20:07:01 +0000
Received: from mail-yw1-x1164.google.com ([2607:f8b0:4864:20::1164])
	by bombadil.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u0nJb-0000000Cjx3-0l6t
	for linux-nvme@lists.infradead.org;
	Fri, 04 Apr 2025 20:07:00 +0000
Received: by mail-yw1-x1164.google.com with SMTP id 00721157ae682-7020d8b110aso24843117b3.1
        for <linux-nvme@lists.infradead.org>; Fri, 04 Apr 2025 13:06:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1743797217; x=1744402017; darn=lists.infradead.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2M1hpXYJrQhzvhFIXGwXFXDV00AlUZW/lxOdiQ1kbxM=;
        b=O2lY2fn7+33+uE5qPLvxdJ5MAF2U3Q4llpt8oBtxrG9S/oSG6DRvZAOvgSr1coW1GD
         1bh9RiMjBpMbqVRdmgnDlrYWENW6YEYEU0TNXIhx8MiRlVOFpz1Q8fgSTLU/gTh5IUgW
         3IKFuUkhJ0JTkVW8xzAZlBP2iTjrpPFA10Bj4uvebvEmwQkuy2zLMAMQNrysXjIukeec
         BP7Nb5GvDLtonrW9bR+3X72Fq3gz8avhtUL3YVRCeVEiKGdoPgawoTTT2QU/keVff8Sd
         XN0VqKRK8XmT8F2+Mf8OL8tBGxN2jREPWkqQqj7/TQZRgBxBfJ6JKVdJ2gyO4NdWMDNJ
         W/LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743797217; x=1744402017;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2M1hpXYJrQhzvhFIXGwXFXDV00AlUZW/lxOdiQ1kbxM=;
        b=jHGZlh5MaIR5/FI5dchzVjNTJUQ7DFt7fVNRvoKIwfjj1nk760CctmXZdUFPYCZ+Az
         GLJmRcEyWKGnw2mKUTB0E4upiZXSP/4eYEtEk36lKC+EUZ80/AAwZppV2McuKQLMMSxb
         xXls8Lsobj5E1mUt9sxQ1XSuDbmWKl3/yWhld7RZMxA5CUGJJ63ROVqtlaI1S16Ef7pb
         ziBOBqza0eCEvfadRDLohCuo5t/Gc4DJaieLhupvzgGWHt8+epIYQ+1PTzJ0ibgGsEF4
         8yiGkSZ1n2abSqctx9vhe7jRwM++yQHfhDIjJ1sNAbZNHdVj7gCJbMeIT+ZYXznvAmzD
         UMHg==
X-Gm-Message-State: AOJu0YxHID8DAB/JOffciEPqlkUN66CVEJKpG2/qIGFr/02ThO7/TCG0
	yli1JsNl6IwowNPNS2o3p+abOCKU2w5axHx76Eej6Jgv+GBPfjmSL1R0I0j7dHN0IcusMHibta4
	qeBpT0I+9G/K8Fky95mYKReIJT/J5rl/I
X-Gm-Gg: ASbGncvHEdyAUPo8EWTOwL4fnV0CGpqCa8KSQNZaMH7rN4IzZ8fsRPmbd2tsrbLTbXq
	AMAtGKvQWF3g45APxz8d+Jz7U9GzYrNRdzjO3MHHMnl/PkSwRbwfWIDBaF9pmiNq4QMNh9CKXiW
	ZxfbuRAN3BSmadC7sgoqGN4SPrpezr2GtswfSykJwBeLuacTJJ5r4VitREK/94P3A4BmpNcZjgH
	5nPVDx1CFLjQ4rv3XzrBsE8eSqQCgL4aoyI89PMs3n7hAjDRGH5IEDe6uTfx7VOAamr+bki+irB
	Rr2izIShdeoxjNpJTqmrQG1ufLO8izZ9GO1HuPWSBk8BknV/FA==
X-Google-Smtp-Source: AGHT+IFcGdONDC85B/gSZoS4J+FgxMFotj48il2SfT+fCyI/ofRzxNcF2q2hE6zWGGUchQgcgJzgPHx2gnpx
X-Received: by 2002:a05:690c:4493:b0:6f0:23da:49a3 with SMTP id 00721157ae682-703e14f5708mr68698877b3.8.1743797217304;
        Fri, 04 Apr 2025 13:06:57 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.129])
        by smtp-relay.gmail.com with ESMTPS id 00721157ae682-703d1faebb6sm4324697b3.59.2025.04.04.13.06.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Apr 2025 13:06:57 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-ushankar.dev.purestorage.com (dev-ushankar.dev.purestorage.com [IPv6:2620:125:9007:640:7:70:36:0])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 998883401CC;
	Fri,  4 Apr 2025 14:06:55 -0600 (MDT)
Received: by dev-ushankar.dev.purestorage.com (Postfix, from userid 1557716368)
	id 86E48E40F18; Fri,  4 Apr 2025 14:06:55 -0600 (MDT)
From: Uday Shankar <ushankar@purestorage.com>
Date: Fri, 04 Apr 2025 14:06:43 -0600
Subject: [PATCH] nvme: multipath: fix return value of nvme_available_path
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250404-nvme_type-v1-1-920053372832@purestorage.com>
X-B4-Tracking: v=1; b=H4sIANI78GcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDEwMT3byy3NT4ksqCVN1EixRTE8PUtDTjlEQloPqCotS0zAqwWdGxtbU
 A0tRvhVsAAAA=
X-Change-ID: 20250404-nvme_type-a8d541eff3da
To: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Hannes Reinecke <hare@kernel.org>, Uday Shankar <ushankar@purestorage.com>
X-Mailer: b4 0.14.2
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250404_130659_419595_B3D0936F 
X-CRM114-Status: GOOD (  12.67  )
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

The function returns bool so we should return false, not NULL. No
functional changes are expected.

Signed-off-by: Uday Shankar <ushankar@purestorage.com>
---
 drivers/nvme/host/multipath.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 6b12ca80aa27305a759990348c4c107655664d94..94152cf423f165aaba9cbb57f370ef4708365f1a 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -427,7 +427,7 @@ static bool nvme_available_path(struct nvme_ns_head *head)
 	struct nvme_ns *ns;
 
 	if (!test_bit(NVME_NSHEAD_DISK_LIVE, &head->flags))
-		return NULL;
+		return false;
 
 	list_for_each_entry_srcu(ns, &head->list, siblings,
 				 srcu_read_lock_held(&head->srcu)) {

---
base-commit: 0514a1379e11c6b8038674f43a478b0857d47a5e
change-id: 20250404-nvme_type-a8d541eff3da

Best regards,
-- 
Uday Shankar <ushankar@purestorage.com>


