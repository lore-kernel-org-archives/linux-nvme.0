Return-Path: <SRS0=/IAj=27=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4569BC33CA2
	for <linux-nvme@archiver.kernel.org>; Fri, 10 Jan 2020 13:25:18 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C6B220721
	for <linux-nvme@archiver.kernel.org>; Fri, 10 Jan 2020 13:25:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="UdKN7wTk";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T+Sa4LDO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C6B220721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=TWPVYv9HawrgiLS7R47jO5wQ8BqNZ2PpspcQOgescx4=; b=UdKN7wTkbDpNUo
	SUifgdsfypAAcTJEJrFvpRF5KVSwxcif9GfixPQsPbTWKwbfBLTe+eZC/16f7QgzvrnqOyD2z1g/6
	/34yz4P9kGJ73TV7IWdCqJ+CI2OLnn9kEXgEI1Kl8wDhZzno1j/dYsQLb9NTxMHFSsIaxEq3mvCff
	cx5s6SeH1bu+IIy2eM655sdsieF09Y92cG2GidMz8SbJP9wYLpmI38OdbiArPfHOVV4829+Ox3rSP
	yA2zMA4HzpO7YWdNizN75hN7nwwiqFfvjzBznn00B1Xqsvtca/o/SKKfZt1rvLGWI2ZZhQWIA3rsv
	J4n6ipyU6sHEsd+6GPXw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1ipuHr-0001Da-0l; Fri, 10 Jan 2020 13:25:15 +0000
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1ipuHo-0001Cb-1P
 for linux-nvme@lists.infradead.org; Fri, 10 Jan 2020 13:25:13 +0000
Received: by mail-pf1-x443.google.com with SMTP id i6so1159195pfc.1
 for <linux-nvme@lists.infradead.org>; Fri, 10 Jan 2020 05:25:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=UFiZIlIgmkNA3t4b+dQtP70neZja23u9OLrKEBFh9OQ=;
 b=T+Sa4LDOSdvRALNgrgFkTf5iZDS1Jm4fYUVw8rWYiU0HP3HgNchXKGwUMyMzyjboUb
 xI0eAOoHSzDzeUaUeDSWW2VfwfDtEhTaU9+LIqME2jGXd03LCV8OYqv8IrycYHUb0NJf
 1A/B6xh5eYTegzoDUGz+gLlRI/92rrcURlROO9A5519cupAKeCxMGeAH+NvUhVti2t3k
 JEWeBOQ4LJNQSMSlqwpmBeeYVELpLiEWkQREpLJ42bGkdKGQ7e+NnI+OetbpT11nOIuL
 ciYlfS+NXKleg6I/8eE3BmEJmX7LSVF5TfWdzBy4UGgET28TdOYaI6si2cBbDJb/EyVT
 M2Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=UFiZIlIgmkNA3t4b+dQtP70neZja23u9OLrKEBFh9OQ=;
 b=pv0QMKgaRbAbedRBtdHGawGalTo2x/SHVoOXfaAH1Z5lYZ1PlX2BK6eIpwAE14pbFc
 NyFP3/3ocT5CN2+x8zhi3zsClnhMMrr+L8Urx2lcznVqOhWzGOdQuXWliVjlW1gxhfsu
 Mh69zkBiuKOvsY+N7Awtl6xjx0onu0ADIUVqg812UUHTsj8/ktKlcNPAs+1skZ/pvu8T
 n/6WJJIuo//l7I0MiCrBbrMNX6zbUv+ssahx3DduWZN8Id2jDOKbP7dVF6Tds5DSwQUT
 1LZ32QNQJ2mYVlfjZo1zLhtCyclR+fGCNNTp1L/W22oVzckd7ou2cizbgHIRmMp7ln4y
 mIjg==
X-Gm-Message-State: APjAAAXazxuFDr7E+0emKw/A0FraEwFHntdJvZ1hIGj4EpclVxZuRINH
 fCtru624+6wWGHYLsk3o9Mo=
X-Google-Smtp-Source: APXvYqxhW94ndLVj5iXTpBpWRfqrS0M7EiNqDD0W2XvB0sPK6eEAA8r1f0ydpuMft0C1J2vg65kx+g==
X-Received: by 2002:a62:e30f:: with SMTP id g15mr4044199pfh.124.1578662711271; 
 Fri, 10 Jan 2020 05:25:11 -0800 (PST)
Received: from localhost.localdomain ([103.211.17.220])
 by smtp.googlemail.com with ESMTPSA id l2sm2907749pjt.31.2020.01.10.05.25.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jan 2020 05:25:10 -0800 (PST)
From: Amol Grover <frextrite@gmail.com>
To: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH] drivers: nvme: target: core: Pass lockdep expression to RCU
 lists
Date: Fri, 10 Jan 2020 18:53:58 +0530
Message-Id: <20200110132356.27110-1-frextrite@gmail.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200110_052512_107200_703ED2BC 
X-CRM114-Status: GOOD (  11.93  )
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
Cc: "Paul E . McKenney" <paulmck@kernel.org>, Amol Grover <frextrite@gmail.com>,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 Joel Fernandes <joel@joelfernandes.org>,
 linux-kernel-mentees@lists.linuxfoundation.org,
 Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

ctrl->subsys->namespaces and subsys->namespaces are traversed with
hlist_for_each_entry_rcu outside an RCU read-side critical section
but under the protection of subsys->lock.

Hence, add the corresponding lockdep expression to the list traversal
primitive to silence false-positive lockdep warnings, and
harden RCU lists.

Add macro for the corresponding lockdep expression to make the code
clean and concise.

Signed-off-by: Amol Grover <frextrite@gmail.com>
---
 drivers/nvme/target/core.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 28438b833c1b..7caab4ba6a04 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -15,6 +15,9 @@
 
 #include "nvmet.h"
 
+#define subsys_lock_held() \
+	lockdep_is_held(&subsys->lock)
+
 struct workqueue_struct *buffered_io_wq;
 static const struct nvmet_fabrics_ops *nvmet_transports[NVMF_TRTYPE_MAX];
 static DEFINE_IDA(cntlid_ida);
@@ -555,7 +558,8 @@ int nvmet_ns_enable(struct nvmet_ns *ns)
 	} else {
 		struct nvmet_ns *old;
 
-		list_for_each_entry_rcu(old, &subsys->namespaces, dev_link) {
+		list_for_each_entry_rcu(old, &subsys->namespaces, dev_link,
+							subsys_lock_held()) {
 			BUG_ON(ns->nsid == old->nsid);
 			if (ns->nsid < old->nsid)
 				break;
@@ -1172,7 +1176,8 @@ static void nvmet_setup_p2p_ns_map(struct nvmet_ctrl *ctrl,
 
 	ctrl->p2p_client = get_device(req->p2p_client);
 
-	list_for_each_entry_rcu(ns, &ctrl->subsys->namespaces, dev_link)
+	list_for_each_entry_rcu(ns, &ctrl->subsys->namespaces, dev_link,
+							subsys_lock_held())
 		nvmet_p2pmem_ns_add_p2p(ctrl, ns);
 }
 
-- 
2.24.1


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
