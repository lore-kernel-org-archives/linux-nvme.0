Return-Path: <SRS0=FbzM=CZ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6087BC43461
	for <linux-nvme@archiver.kernel.org>; Wed, 16 Sep 2020 15:37:03 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C7C9D2220E
	for <linux-nvme@archiver.kernel.org>; Wed, 16 Sep 2020 15:37:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="dMIGQnaX";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nwh4CIe8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7C9D2220E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=77OpWMkEMVUdiwKFphs31k4VOV7OeTJVtQFV744BTRI=; b=dMIGQnaXUFYJ6Eaq8Uy3ooYStK
	wkKX1XSCAqXrYTgb0AZ7z93Z81Y0/uE/MWblFXCZPDjk0/EV6bBFtSN6k5Sjs17zabJG5C1i5kq6P
	FYaCDH43mZZGTAemmt71E5Wd1m1+Uv3uQxHfshJ/sdoGZvpxY0DcWVGpX4sS6PDRjKlvV07IYw9Kc
	+dSCHE34rRY/ApTznaHH77awIjIMEN9WcREdnaE5N1pakCCZ4Ixnc48wDpKE/WA7b7MCC3Fg4DzwT
	s6n/GAFJWa1FhD6Ff+OstWr0H5fQQtuTXBNmdweAR6sdAiwHEJV6fSLO9VZjGzxr+NhirYe066eo3
	qppg8l6w==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kIZUS-0000mg-Sb; Wed, 16 Sep 2020 15:37:00 +0000
Received: from mail-qt1-x842.google.com ([2607:f8b0:4864:20::842])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kIZUP-0000m8-Uc
 for linux-nvme@lists.infradead.org; Wed, 16 Sep 2020 15:36:58 +0000
Received: by mail-qt1-x842.google.com with SMTP id z2so6407052qtv.12
 for <linux-nvme@lists.infradead.org>; Wed, 16 Sep 2020 08:36:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=TTuIKeDT4oZBu9/PmyTJFWVXKqpQ0FNzrmIL6pppv2w=;
 b=Nwh4CIe8iyvAdxENM+gMC5s21hXvVZ07MqkMYP+6Kj2yaWgRuSTRzMvAirfHGbsZTK
 HmvIXCkPww+m+kEGQEHQkW7i02uR9n1QL6lDu3VPGjUBYiDbEFgDOW1GDRWo8m5s7fbJ
 wBGSlVylOqphT2VFgvz7zluzNVD34a7XeAtRBUKLkA/XZ5QsZL8kc74MXigRyF+Ny1E1
 Su+NhuLQY2qx2IXQqt6r3y16d2IfJx+HHs+aOHhqQ4ZMsPNOFhAiPllrOiefgqKb4uyp
 1mqQRJ43phNT799cpQUQ3i2NozpWaiyIsbykC00DwdeYPlgXKKMB/DtAx4kJF5Q35859
 vHiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=TTuIKeDT4oZBu9/PmyTJFWVXKqpQ0FNzrmIL6pppv2w=;
 b=WsKmjtamYK6zaKktSZcTJcuTndj9y0YclEuQaziQKl7KMGFsID3olqv6GeWgnAXIUZ
 vgpaJDly8bCprDMQdGV+KmvuXXiipF/1wEm2CM9yxZRtGC0pgUL6TU0hmDaCbReQjB9f
 KBTTWqV6zYEohYhM9hhm0c/x/MwOcprRHIkQjT4wHkpZTEs4YaJ+mmhXDyBieriQe0dr
 3tjiffsSbf2BRhpHZzTAhOADLXOBZSytoTdANfRKbRHmvfu/zVaZ4oThOCBxdJ/YPUUS
 vgXjSJ9O7muBRvrxfQCq+/Hckg25veO/Coj5338aH1ye7mR3YhGbJaN6+0dIr/PRRYMT
 fp4g==
X-Gm-Message-State: AOAM530vs90s1Ax48v6zggo6MLeXt2J9+bAPN+gow3uFjhtHfXX25zSD
 sj1IPg9+5e3zYqgtpbi0Wew=
X-Google-Smtp-Source: ABdhPJxmRJoZnXvvEr70yS68oDpU4wfvDGLr4WCGB6/Ql/9c8V0oIJFNGn8BHMarY8skC5JEnK5VpQ==
X-Received: by 2002:aed:36e7:: with SMTP id f94mr23372706qtb.369.1600270615917; 
 Wed, 16 Sep 2020 08:36:55 -0700 (PDT)
Received: from tong-desktop.local ([2601:5c0:c100:b9d:d54e:5074:9d44:3698])
 by smtp.googlemail.com with ESMTPSA id x26sm18469219qtr.78.2020.09.16.08.36.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2020 08:36:55 -0700 (PDT)
From: Tong Zhang <ztong0001@gmail.com>
To: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] nvme: fix NULL pointer dereference
Date: Wed, 16 Sep 2020 11:36:49 -0400
Message-Id: <20200916153648.5475-1-ztong0001@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200916_113658_002957_5D45939D 
X-CRM114-Status: GOOD (  12.37  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Tong Zhang <ztong0001@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

blk_mq_tag_to_rq can return NULL and this condition must be checked

[  147.861050] BUG: KASAN: null-ptr-deref in nvme_irq+0xfc/0x410
[  147.861326] Write of size 2 at addr 0000000000000122 by task kworker/u4:1/56
[  147.861675]
[  147.861756] CPU: 1 PID: 56 Comm: kworker/u4:1 Not tainted 5.9.0-rc4+ #83
[  147.862657] Workqueue: nvme-wq nvme_scan_work
[  147.862876] Call Trace:
[  147.863002]  <IRQ>
[  147.863112]  dump_stack+0x7d/0xb0
[  147.863280]  kasan_report.cold+0x6a/0x7e
[  147.863478]  ? nvme_irq+0xfc/0x410
[  147.863650]  nvme_irq+0xfc/0x410
[  147.863815]  ? __x64_sys_getrandom+0xb0/0xb0
[  147.864030]  ? nvme_del_cq_end+0x70/0x70
[  147.864229]  __handle_irq_event_percpu+0x69/0x280
[  147.864465]  handle_irq_event_percpu+0x6a/0xe0
[  147.864689]  ? __handle_irq_event_percpu+0x280/0x280
[  147.864939]  ? _raw_spin_lock+0x75/0xd0
[  147.865131]  ? _raw_read_lock_irq+0x30/0x30
[  147.865345]  handle_irq_event+0x57/0x86
[  147.865537]  handle_edge_irq+0xe5/0x2d0
[  147.865732]  asm_call_on_stack+0x12/0x20
[  147.865929]  </IRQ>
[  147.866038]  common_interrupt+0xad/0x110
[  147.866236]  asm_common_interrupt+0x1e/0x40
[  147.866447] RIP: 0010:__asan_load4+0x40/0xa0
[  147.866663] Code: 00 00 ff 48 39 f8 77 56 48 8d 47 03 48 89 c2 83 e2 07 48 83 fa 02 76 2f 48 b9 00 00 00 00 00 fc ff df 48 c1 e8 03 0f b6 04 08 <84>0
[  147.867577] RSP: 0000:ffff8880666e6d48 EFLAGS: 00000a06
[  147.867837] RAX: 0000000000000000 RBX: ffff8880666e6e28 RCX: dffffc0000000000
[  147.868190] RDX: 0000000000000003 RSI: ffffffffb053e44f RDI: ffff8880666e6e30
[  147.868544] RBP: 0000000000000013 R08: ffffffffafb5ee6f R09: fffffbfff64977ad
[  147.868897] R10: ffffffffb24bbd63 R11: fffffbfff64977ac R12: ffffffffb053e44f
[  147.869250] R13: 0000000000000000 R14: ffff8880666d8040 R15: 0000000000000130

Signed-off-by: Tong Zhang <ztong0001@gmail.com>
---
 drivers/nvme/host/pci.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 899d2f4d7ab6..725d2263a0f5 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -960,6 +960,8 @@ static inline void nvme_handle_cqe(struct nvme_queue *nvmeq, u16 idx)
 	}
 
 	req = blk_mq_tag_to_rq(nvme_queue_tagset(nvmeq), cqe->command_id);
+	if (!req)
+		return;
 	trace_nvme_sq(req, cqe->sq_head, nvmeq->sq_tail);
 	if (!nvme_try_complete_req(req, cqe->status, cqe->result))
 		nvme_pci_complete_rq(req);
-- 
2.25.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
