Return-Path: <SRS0=sv4i=OC=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0478AC433EF
	for <linux-nvme@archiver.kernel.org>; Sun, 12 Sep 2021 18:55:52 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B4EA76103D
	for <linux-nvme@archiver.kernel.org>; Sun, 12 Sep 2021 18:55:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B4EA76103D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=5wfbCYgzc3HObKWKTBcTIkH0L7Vo1n4KBeZ4oHp9Mxc=; b=tNuIWThLiQ6+fi
	5zKOGY3Agac29Of+9KI2nt8E4qoyajbOjPdVKECZu2zrcF16r2hbEy6g2j6toNNH3xp4SvOSPRcEx
	LdVmVQTPyM7YmwNCH5T7IiovKYdJEJkG3BKbH7nE9QKT0lYLasIkjI1WIktEs2SU3MJwy1e0xD/fh
	xDxGENuyiQwguE56ggLpSqUqKuDmmrylQBLo1o1bhK/igcvi6jTAXT1XeNzwNC/qYAbU+U2VzXR0O
	T+IrxVezeZOCC+eSfV840zjGTyGcEpOLyVzMODIPhb1zFvqMp5XF9fPOn58t6VB2M3rqCE9SvwGjC
	74vYrFkIeCrdzi4LyUiQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mPUdY-00GxtF-Ka; Sun, 12 Sep 2021 18:55:32 +0000
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mPUdK-00GxpM-VZ
 for linux-nvme@lists.infradead.org; Sun, 12 Sep 2021 18:55:21 +0000
Received: by mail-wm1-x336.google.com with SMTP id
 r128-20020a1c4486000000b003065f0bc631so680400wma.0
 for <linux-nvme@lists.infradead.org>; Sun, 12 Sep 2021 11:55:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Z4fGpZPa4sVdTvq4PDM3uN1bROXMjFpQEKxZL4RZd0Q=;
 b=Jg5/cUy7BRPORsJE0pKVN+fUy6rh7VDxYFCsoUhPD6t3/WMXvpdp2OD618ziyAhHib
 n8yNXiSiRN+FUPRcWS0ihZ99g+Qs938iiGzthMTbIf0bENOlcmcjSig30xXgk+0ysokC
 bfZIF7ek9C6CR3UVKmf2taQ7LlWqQdG/wIBYJuaqHzlCVu8qvHSfrGsltBJrtcqOYtTs
 80t9D12gmNvBakJmeIzQaxZs+uasoCHY1vzHRlM2uOoz/Vb76KXD1IiNn7nfnmNOenxR
 s48QO1F7CgOfe/Lmj9BMeHUgbUvF5XLCE13Ft1dZRxvmZT1JlfZVI16g85ZjAzY9ZOxz
 W0xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Z4fGpZPa4sVdTvq4PDM3uN1bROXMjFpQEKxZL4RZd0Q=;
 b=PpijdoP6JhmbSvdpxwBL9KavQzXzKON2NvNR3lHastNjj909WugCLfazHrzZGCO7q+
 sjEWOMmBLma/kav+htG7YJh5qPegxuO9Vibqjz8nKmIWnHu4VgWcdT4497r2ABf6eP0h
 IJSOM/qT+57crbYv0snTztKU+Dc6BqT7bfV+HSR3jNa3ux9gbxltxJpnhcBPXuMHyIZR
 zGIpGlvQFKeoAhMGKPRhNXG3MCjT7F0MZjU9KyQmQQUvDM2zIrbGZ30BxXYhRNS8tpMp
 zXtLdlSkxQ7A30hISTTFn+Vbu67913TlgyQnVXV3cvHl8eoR/UYBwVJplX3nyXfRijAd
 RHfQ==
X-Gm-Message-State: AOAM5328QAtjER6LLbNH6mwFsUQJfAPI0jlSSoZKe9iLI873As6rAtRb
 zQrtShl/EgqVDBApOH9kk/s6p8sgYu/bJw==
X-Google-Smtp-Source: ABdhPJxnII/xPuOEUaUeXWaOh4HLOorqHt952Z14MyF/zSy0Vk4TdoagRWIxPlPEoaUXz6Jq10AvdQ==
X-Received: by 2002:a05:600c:4f81:: with SMTP id
 n1mr7795624wmq.99.1631472917196; 
 Sun, 12 Sep 2021 11:55:17 -0700 (PDT)
Received: from anton-latitude..lbits (c-76-23-2-87.hsd1.ut.comcast.net.
 [76.23.2.87])
 by smtp.googlemail.com with ESMTPSA id s15sm5196974wrb.22.2021.09.12.11.55.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 Sep 2021 11:55:16 -0700 (PDT)
From: Anton Eidelman <anton.eidelman@gmail.com>
X-Google-Original-From: Anton Eidelman <anton@lightbitslabs.com>
To: linux-nvme@lists.infradead.org, hch@lst.de, kbusch@kernel.org,
 sagi@grimberg.me, axboe@fb.com
Cc: Anton Eidelman <anton@lightbitslabs.com>
Subject: [PATCH 1/3] nvme/multipath: fix failure to update ns ana state
Date: Sun, 12 Sep 2021 12:54:57 -0600
Message-Id: <20210912185459.13496-2-anton@lightbitslabs.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210912185459.13496-1-anton@lightbitslabs.com>
References: <20210912185459.13496-1-anton@lightbitslabs.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210912_115519_068511_92C3B32F 
X-CRM114-Status: GOOD (  12.75  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

nvme_update_ana_state() has a deficiency that results
in failure to update the ana state for a namespace
in the following case:
nsid's in ctrl->namespaces: 1, 3, 4
nsid's in desc->nsids: 1, 2, 3, 4

Loop iteration 0:
    ns index = 0, n = 0, ns->head->ns_id = 1, nsid = 1, MATCH.
Loop iteration 1:
    ns index = 1, n = 1, ns->head->ns_id = 3, nsid = 2, NO MATCH.
Loop iteration 2:
    ns index = 2, n = 2, ns->head->ns_id = 4, nsid = 4, MATCH.

Result: missed nsid=3 and did not update its ana state.

Solution: when ns->head->ns_id is higher than nsid,
increment n and RETRY with the SAME ns.

Signed-off-by: Anton Eidelman <anton@lightbitslabs.com>
---
 drivers/nvme/host/multipath.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 5d7bc58a27bd..e8ccdd398f78 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -600,14 +600,17 @@ static int nvme_update_ana_state(struct nvme_ctrl *ctrl,
 
 	down_read(&ctrl->namespaces_rwsem);
 	list_for_each_entry(ns, &ctrl->namespaces, list) {
-		unsigned nsid = le32_to_cpu(desc->nsids[n]);
-
+		unsigned nsid;
+again:
+		nsid = le32_to_cpu(desc->nsids[n]);
 		if (ns->head->ns_id < nsid)
 			continue;
 		if (ns->head->ns_id == nsid)
 			nvme_update_ns_ana_state(desc, ns);
 		if (++n == nr_nsids)
 			break;
+		if (ns->head->ns_id > nsid)
+			goto again;
 	}
 	up_read(&ctrl->namespaces_rwsem);
 	return 0;
-- 
2.25.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
