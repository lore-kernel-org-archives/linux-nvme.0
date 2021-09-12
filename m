Return-Path: <SRS0=sv4i=OC=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37E98C433EF
	for <linux-nvme@archiver.kernel.org>; Sun, 12 Sep 2021 01:08:59 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 02C606103D
	for <linux-nvme@archiver.kernel.org>; Sun, 12 Sep 2021 01:08:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 02C606103D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lightbitslabs.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Ru5BQL7vYu2WVfXVp69Zji26MztAIAnD5cIJd7CDqPU=; b=PcrmpGLsm7G4cN
	gWAwViswHR6lYuJo1o/IuLM+kB94RzzigyJYFmaU70Xnlani2Vngw8squWnQigv2CktXANBTaRWSf
	hbHgnyC9U7SYAFPzfrI78sE1BUnCFY9wI/rJoIJVzVnBWwlGfMlcYux0cI7GFSddHe5NQalOmoOTc
	I7PKCUDz3fPG/zzRfcOVPgvJSbglQOhoxTVpyWGg326z01ob8Ix3vooRDmDeDI7Z6HCjSTcoLSCEu
	FlWVLPTb2lpoVr1M/5YpO0VhgdqeJCtnJhiR5+OviZg3SP8/TdH49ZL3B/cR0SgI/T5lfEdVtFfC4
	IIHwAPTtsgQd+bYGoJlg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mPDzA-00Fekd-1c; Sun, 12 Sep 2021 01:08:44 +0000
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mPDz4-00Fejd-GQ
 for linux-nvme@lists.infradead.org; Sun, 12 Sep 2021 01:08:39 +0000
Received: by mail-wm1-x32f.google.com with SMTP id
 l18-20020a05600c4f1200b002f8cf606262so4228546wmq.1
 for <linux-nvme@lists.infradead.org>; Sat, 11 Sep 2021 18:08:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=lightbitslabs-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version; bh=t8V4yyvhRpecvh2u+HlbAdPUilnUXnIcLo8mVq2KJ3o=;
 b=RbSkpjZ4aL5XwK7l5/U0iZIdGCekaZ67tysHzps3A6tnn7TN+/ss7DvtreJGL3xjTj
 rAo7LZx3TgIJpefs8m5kSMgp01eU7zeuHHmhWz3Uv5qz1VjLN5ZQcym+uCPH0zghQZie
 O6TofihHs0S8sLcAz1eJg1aqWGNoW+fmjIhRQB4KVyDGBJ2crPhBPEp6+MS3pl42KcZH
 kokDQBAfR89u5Kxg8y7PTq0dd53I4uNe5r1Weer73YCtN4tOyNl1rd+0dz5vJyxIcZtp
 e4i8IQeLHLH8KCuJ6YwaiEGuADWrEVJJmJh5umscd6ZIrsb1deM04ydUgjhoupZtjZuY
 OX/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version;
 bh=t8V4yyvhRpecvh2u+HlbAdPUilnUXnIcLo8mVq2KJ3o=;
 b=5CrY8YQPLmF72AWLimREgOc9UrG9PhB9j73xK7szoV8HNSMuDE/yAITXZOGgb5+/Lh
 cx58LACJagBIwSI7QpEuA3RYd/vTrOEksW6uGnfGPsJ9y2VrvB138MeMNS3LJQWvA75j
 OaxLA+B8Qw7ceXFpflP323mzk9rIgDA4bDE9Z4DnjFok1c84mFaNO4S1vpAsAK5KE5CY
 tMdStSrcIf99h6qosy1/cIEMu/PipWAWYh4i+JzkKcbC+T+YEsBeDn/8ULHsMrEvQkKF
 pH3ZBTQzUwLfjryMYSjwEgslZR5x2gRitQUJ0VE62j9uFEbo1hpk2sbhy+NLPpktAOtG
 1qVg==
X-Gm-Message-State: AOAM53296MnjGZvK68bEeOY+qaSfls02ib0VRntSCpjB03at+IPxSjob
 rglSznt4rEITd411BoCwpxOHewGIfl9EIrmoltakywYbm/3parN6AT8T/eq+DQgu4qnAGe3t9BY
 VnUgPmWWbMztvsSW3B0f534OL+jd7
X-Google-Smtp-Source: ABdhPJwtNlKtTbImSGhtWa4WxghvTEqaI1zNWlShumvjov90E0Q1DshviDE66gFc0Iths+72Cp3+uw==
X-Received: by 2002:a1c:f405:: with SMTP id z5mr803202wma.72.1631408916861;
 Sat, 11 Sep 2021 18:08:36 -0700 (PDT)
Received: from anton-latitude..lbits (c-76-23-2-87.hsd1.ut.comcast.net.
 [76.23.2.87])
 by smtp.googlemail.com with ESMTPSA id h18sm3128922wrb.33.2021.09.11.18.08.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 11 Sep 2021 18:08:36 -0700 (PDT)
From: Anton Eidelman <anton@lightbitslabs.com>
To: linux-nvme@lists.infradead.org, hch@lst.de, kbusch@kernel.org,
 sagi@grimberg.me, axboe@fb.com
Cc: Anton Eidelman <anton@lightbitslabs.com>
Subject: [PATCH 2/3] nvme/multipath: cosmetic: keep ns nsid locally
Date: Sat, 11 Sep 2021 19:07:30 -0600
Message-Id: <20210912010731.471859-3-anton@lightbitslabs.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210912010731.471859-1-anton@lightbitslabs.com>
References: <20210912010731.471859-1-anton@lightbitslabs.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210911_180838_593651_E2EC7E1E 
X-CRM114-Status: GOOD (  11.84  )
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

Keep the nsid of the current namespace in a local variable.
Change the type to unsigned int to make checkpatch happy.

Signed-off-by: Anton Eidelman <anton@lightbitslabs.com>
---
 drivers/nvme/host/multipath.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index e8ccdd398f78..a51561d67b93 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -600,16 +600,18 @@ static int nvme_update_ana_state(struct nvme_ctrl *ctrl,
 
 	down_read(&ctrl->namespaces_rwsem);
 	list_for_each_entry(ns, &ctrl->namespaces, list) {
-		unsigned nsid;
+		unsigned int nsid;
+		unsigned int ns_nsid = ns->head->ns_id;
+
 again:
 		nsid = le32_to_cpu(desc->nsids[n]);
-		if (ns->head->ns_id < nsid)
+		if (ns_nsid < nsid)
 			continue;
-		if (ns->head->ns_id == nsid)
+		if (ns_nsid == nsid)
 			nvme_update_ns_ana_state(desc, ns);
 		if (++n == nr_nsids)
 			break;
-		if (ns->head->ns_id > nsid)
+		if (ns_nsid > nsid)
 			goto again;
 	}
 	up_read(&ctrl->namespaces_rwsem);
-- 
2.25.1


-- 


*Lightbits Labs**
*Lead the cloud-native data center
transformation by 
delivering *scalable *and *efficient *software
defined storage that is 
*easy *to consume.



*This message is sent in confidence for the addressee 
only.  It
may contain legally privileged information. The contents are not 
to be
disclosed to anyone other than the addressee. Unauthorized recipients 
are
requested to preserve this confidentiality, advise the sender 
immediately of
any error in transmission and delete the email from their 
systems.*


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
