Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50975C4332F
	for <linux-nvme@archiver.kernel.org>; Thu, 24 Nov 2022 00:24:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kuAFcBA4f1jNM+vSIbezRoOWbKnqOkVLVtapFif7qnU=; b=sUZn5aE8/P+r08bNb1THs3tJff
	6l1gVL0ZrBhNjORR3PU0zUbLjzYDn64B8KpuHg/eeRrox5aOXVTZXj2uNPiw13VpUa0C4XjFMN/ZY
	MPie+Slqmcu1n36U3UNNZ/AlFGNeTIYedx52YHBkUdyyFaEFPR8riJANPuX/UMdVDs6BkyrwAjKba
	m3B1cxjd+p2NtbDI0xqKdmw4JCMEtIAsozNRgP6bxdivDHExh4xGyDivLpO5JImXFNMEXNk0pdUOs
	QTDtvA82xAvLYH9ryNCy//yX4LP/8V2wg/PHfDsqh3n7AVXpEY1wnZtihgZU0in3jTrk8YvA1nK4w
	Nw7G9udA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oy02n-0033He-5n; Thu, 24 Nov 2022 00:24:45 +0000
Received: from mail-ot1-x361.google.com ([2607:f8b0:4864:20::361])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oy02k-0033GG-Ts
	for linux-nvme@lists.infradead.org; Thu, 24 Nov 2022 00:24:44 +0000
Received: by mail-ot1-x361.google.com with SMTP id 94-20020a9d0067000000b0066c8d13a33dso31221ota.12
        for <linux-nvme@lists.infradead.org>; Wed, 23 Nov 2022 16:24:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kuAFcBA4f1jNM+vSIbezRoOWbKnqOkVLVtapFif7qnU=;
        b=TaPL1zktQFPQmPQ1UWlQRucF8Tzh0dxCLE+BnpDbgpwQf2hnkZ6nRgoUl7EiEuaKGx
         m+NGTTRXJyWtS2KJKtpD48RZ6tjmt05mKzlFTXYZFdKiwO5O3jV44PrKQTMoUrCEUqay
         EwBfAj5jOnA//8SIiViCler6nu0McNO9V3GEE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kuAFcBA4f1jNM+vSIbezRoOWbKnqOkVLVtapFif7qnU=;
        b=SbYCeZjfAW2kzDIqGA8G7yG4OAA3Tfyc3yXv9l6mpHQgr8Lzrep7yr6tewjB0KicfR
         sJexwiaZ6tvFdMObyWwFij/RnNp2YsWLOJ3R4MJ5dYuU5p1npwcQptbMGhGLGzqkOkGx
         8/PQZw6lEhF8/+n/TFctvyKqMbrEWUF+ciZxvcimc6QnROfxS4kyYafiCC+HBUc+n6fN
         qMNUlmZgRCtADFbVc1aryY7WTGsC/7tH/SBctuuLY4Yo/KBE5MKyjCZ8E856yCEzR0xi
         ZrRWpymPb4/St+we0FkYLTI0hNFodMfRyqFoJP6B70tqxvpTWxWDBIqOQRuCNVi3smek
         yGGw==
X-Gm-Message-State: ANoB5plBkJmNWg5iezXDPqdhGD61dhvvJtNbn20P7PVP/3yJIQ8XbEgI
	QijNPkz7vfieToqYIAqrhKZtR7Lj+aIx+VeTSlnAdyBIR0sY6aPjpNuk67Cw/TIWXQ==
X-Google-Smtp-Source: AA0mqf6EE4Nee+OQlk0uxA1XQyFeHQTIz7nBwSrDBhWM31RNpkitcAWDyIKldANdBEWYgZBFAO+mfFcGyVr8
X-Received: by 2002:a9d:810:0:b0:66c:2b17:bce4 with SMTP id 16-20020a9d0810000000b0066c2b17bce4mr6920619oty.38.1669249480047;
        Wed, 23 Nov 2022 16:24:40 -0800 (PST)
Received: from c7-smtp.dev.purestorage.com ([2620:125:9007:320:7:32:106:0])
        by smtp-relay.gmail.com with ESMTPS id v13-20020a056870b50d00b00132200cf245sm1269890oap.43.2022.11.23.16.24.39
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Nov 2022 16:24:40 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.7.70.37])
	by c7-smtp.dev.purestorage.com (Postfix) with ESMTP id 48E6822128;
	Wed, 23 Nov 2022 17:24:39 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 4463FE40961; Wed, 23 Nov 2022 17:24:39 -0700 (MST)
From: Caleb Sander <csander@purestorage.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@fb.com>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org
Cc: Uday Shankar <ushankar@purestorage.com>,
	Caleb Sander <csander@purestorage.com>
Subject: [PATCH] nvme: fix (S)RCU protection of nvme_ns_head list (alternate)
Date: Wed, 23 Nov 2022 17:24:32 -0700
Message-Id: <20221124002432.3715594-1-csander@purestorage.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221118232756.1457075-1-csander@purestorage.com>
References: <20221118232756.1457075-1-csander@purestorage.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221123_162442_978264_4846EDFC 
X-CRM114-Status: GOOD (  11.95  )
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

This is an alternate fix, protecting the nvme_ns_head siblings list
with both RCU and SRCU.
Use RCU in nvme_mpath_revalidate_paths(), which doesn't sleep.
And add synchronize_srcu() in nvme_ns_remove(),
since nvme_ns_head_submit_bio() protects the list with SRCU.

Signed-off-by: Caleb Sander <csander@purestorage.com>
---
 drivers/nvme/host/core.c      | 1 +
 drivers/nvme/host/multipath.c | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index da55ce45ac70..9b26d4781b32 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4305,6 +4305,7 @@ static void nvme_ns_remove(struct nvme_ns *ns)
 
 	/* guarantee not available in head->list */
 	synchronize_rcu();
+	synchronize_srcu(&ns->head->srcu);
 
 	if (!nvme_ns_head_multipath(ns->head))
 		nvme_cdev_del(&ns->cdev, &ns->cdev_device);
diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 93e2138a8b42..6d0aea477253 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -175,10 +175,12 @@ void nvme_mpath_revalidate_paths(struct nvme_ns *ns)
 	sector_t capacity = get_capacity(head->disk);
 	int node;
 
+	rcu_read_lock();
 	list_for_each_entry_rcu(ns, &head->list, siblings) {
 		if (capacity != get_capacity(ns->disk))
 			clear_bit(NVME_NS_READY, &ns->flags);
 	}
+	rcu_read_unlock();
 
 	for_each_node(node)
 		rcu_assign_pointer(head->current_path[node], NULL);
-- 
2.25.1


