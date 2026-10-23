Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ECA4606A31B
	for <linux-nvme@archiver.kernel.org>; Fri, 23 Oct 2026 14:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=P861UGII;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=nBOFZMWC
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Unsubscribe-Post:List-Owner;
	bh=cLk50NXj5ka9LAwFir4QQNGga7EeL9QGu47H8Erf1+E=; b=P861UGII95cKlJLFjIFiHQ26Ex
	TZJVxspPAyWQ+TsPd6ENCOjFz2AmdLOFTOplA+xQwMgiB7rV/0gASy11+js4tCVeSArHB65YarfNL
	dEts4qDqqdh6NarBNu16kstfhzC4WlFTJIIWqGS7Id3QcRmSZYKaqx9ZLlO7Ws6DQP988mIg0y7iC
	D+G0NjFZloETIlb+lUGYeWR0lgJFL2nkKaZNbPQW6ag2jiKIZo6Ve+aH8IY87qkTt/wnfR5sDt92q
	zg1AYXUHpyB4ShATyB5JnsBQr24+gWr7wXRRP9KHtmRCQRwkURr03cc0r+CcLsZ9LZ29jnRf1Ftom
	oEmL4aMw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xKFpp-0000000GSYG-3ZvR;
	Fri, 23 Oct 2026 14:01:29 +0000
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xKFpl-0000000GSXN-0XqG
	for linux-nvme@lists.infradead.org;
	Fri, 23 Oct 2026 14:01:27 +0000
Received: by mail-pg1-x52f.google.com with SMTP id 41be03b00d2f7-cc4c02ddd62so536052a12.0
        for <linux-nvme@lists.infradead.org>; Fri, 23 Oct 2026 07:01:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792764084; x=1793368884; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=cLk50NXj5ka9LAwFir4QQNGga7EeL9QGu47H8Erf1+E=;
        b=nBOFZMWCnkYOI2O75Vm41pvWVTH2nfzFY+a+7uRrOJUDQEaNhStJM3YXcTVDY5FMWM
         IGOazNG4RsE9qK7tiI9JHExxkGmjUMItf1Uj9TFJiTr8EPgPt5gv9XegBbXXImiDwFby
         s6txK4AukOi8qmzmAvNmGzTHjlB1Z5I6YxZz221JnmWFs8MZvLfhrorN/GcGVYl3ljnj
         w1LMyYyR1Wa/ffvX/YNlTu/cKhskgIPAhA1yGjdq5o7xGceI/xea/VrZPiYaAIgek003
         ioKWToQpJGumSRCgxb0QclpCtLMJL06i15YtRCR/av/MQDe4eceAegasFikYMrTMcMiz
         9ypw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792764084; x=1793368884;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cLk50NXj5ka9LAwFir4QQNGga7EeL9QGu47H8Erf1+E=;
        b=c/AlgvPXBxbTOT/4tbaGndgQAlkoiHS+8FSAT4oiKbb3hXLn7W+Uf7O+wkKmJ8bxoq
         uqYpkvp0cKboCQN+Ydh0uyZ8pOd9A7jRObT9li33HO06pCWuOCUgBuJt6o+KdlDD1nJa
         VhCZGTSEUk/AurJ7rRCQhossXt8IH23tZCNx9dQGiOr23plHYDSuqi3udlI5BvtrK9HH
         AHeoBao9xeYwIgkOxmRMgw8zxG1vsPEzR02LgpZgIZafmFVUiVMiFsXlq1aKsEOes+5Y
         ls7jBNDjYV1AeTqOmqtBD/MBnaAeLGnrv0H7sPdmz9GHHndT8/Zl6SCjtN6EV/5L2tvC
         Grpg==
X-Gm-Message-State: AFq9FYJwGxmHL9PacP2sk2O/Epukaqq1UQegNECfhY3g6SLNzD/Dd556
	aFsluF/yDPxwJvI78+MEVtGP9hhO7Mh0KROQchXKRBUf/mjQENM2Qjqo
X-Gm-Gg: AYBFou1CVwf4KsJdkMUy9bi0yJZzJbep+d4O3M/aFo+SIWLZlRRyOTwXH82YCoMbE64
	FAu7nVhB+n3D8KV1x/sEsYmFfVghShZxD375VRaWeddKny95qprqDzxvllRYPcI/UA7qqlvTZX9
	TuWnfR6fSplT+ax3UvGEHDJyf62bDv6wylVp4THCBhOdaR5mlYtWMicXOiApt6ceofnvm3a76B3
	njmhljR2OCFWsawt5N0ASeRHBtokkoAAiLwrwG6SG6hZy70WUTbtiyZ6CnTn5FaK/hJB3BQT5QK
	+STCCso286eFEbxHY2RvTREI6XwIho7Gn7iG2OJXZsVEvfRj6sf/zKmiL+KjoP4s9N4wuPgf+5h
	v8b/D1pUTXxePW7D6FfYF/2HVKgqVtf1nYNxewbIRclbC+7FLU9bGUX4DwmkMBZ/J8xZCYeAUtC
	vufnoU+iKNk9jb50Ix5XsyGXOoP6SKhXE3FgNrEi3LgVXHCA==
X-Received: by 2002:a17:90b:1cce:b0:3ac:8897:7ba5 with SMTP id 98e67ed59e1d1-3adce7cab40mr2077006a91.59.1792764083330;
        Fri, 23 Oct 2026 07:01:23 -0700 (PDT)
Received: from gooner.hq.netapp.com ([167.103.88.118])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3adde40a20fsm330505a91.3.2026.10.23.07.01.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 07:01:22 -0700 (PDT)
From: Martin George <martinus.gpy@gmail.com>
X-Google-Original-From: Martin George <marting@netapp.com>
To: linux-nvme@lists.infradead.org
Cc: hch@lst.de,
	kbusch@kernel.org,
	sagi@grimberg.me
Subject: [PATCH] nvme-fc: fix reference leak in nvme_fc_nvme_discovery_store()
Date: Fri, 23 Oct 2026 19:30:57 +0530
Message-ID: <20261023140057.6045-1-marting@netapp.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261023_070125_175049_A4845A72 
X-CRM114-Status: GOOD (  12.84  )
X-Spam-Score: -2.1 (--)
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

nvme_fc_nvme_discovery_store() takes an lport and rport reference before
checking whether the rport is already queued on the local discovery
list. On the retry path (goto restart), rports that were queued in an
earlier pass are skipped by the list_empty() check, but the references
taken for them in the current pass are never dropped, leaking one lport
and one rport reference per retry.

Check list_empty() first and only take references for rports that are
actually added to the local discovery list.

Signed-off-by: Martin George <marting@netapp.com>
---
 drivers/nvme/host/fc.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 48454cb7a0fc..03f6fffc9574 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -3778,6 +3778,9 @@ static ssize_t nvme_fc_nvme_discovery_store(struct device *dev,
 restart:
 	list_for_each_entry(lport, &nvme_fc_lport_list, port_list) {
 		list_for_each_entry(rport, &lport->endp_list, endp_list) {
+			/* skip rports already queued for discovery */
+			if (!list_empty(&rport->disc_list))
+				continue;
 			if (!nvme_fc_lport_get(lport))
 				continue;
 			if (!nvme_fc_rport_get(rport)) {
@@ -3799,9 +3802,7 @@ static ssize_t nvme_fc_nvme_discovery_store(struct device *dev,
 				       "failures\n");
 				goto process_local_list;
 			}
-			if (list_empty(&rport->disc_list))
-				list_add_tail(&rport->disc_list,
-					      &local_disc_list);
+			list_add_tail(&rport->disc_list, &local_disc_list);
 		}
 	}
 
-- 
2.43.0


