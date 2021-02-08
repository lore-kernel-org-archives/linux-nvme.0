Return-Path: <SRS0=c0j7=HK=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0266EC433E0
	for <linux-nvme@archiver.kernel.org>; Mon,  8 Feb 2021 18:59:56 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6084764E73
	for <linux-nvme@archiver.kernel.org>; Mon,  8 Feb 2021 18:59:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6084764E73
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=Sx2DA1w70y46Hhe8d5jTgUAMbjXOKZQbVvO1TZExrvw=; b=E0B6ajOnM/sBWqLR7L6nU5T1A
	AWiDE+YZXGGT/q4TxF7Z5X4gBD6NAS4EWltzkJcYaX7A8j2Kys6pAFqe7m2ZnKMEU/wsJRuP8XhZd
	iHY3yH7C4xNGj5HMtjmnr+/cNFwyr+PWkqU6AEloiLtFHT/o/rgOs09uoKrwJ82xr2/Q07ZhQz3OW
	U8XsmYYpBBnGQGh2YINQYQsr0C86Y2mKgIgjaTp0vj1q1CmEqrgcqcOUFRI3j0DLGrrcnXIWJlqvX
	mYOdIOkei3SrUi/6UVkc7aQC7qg2zJsDveOwQqNUcsvHaNKdNbosAlg7QVjnfthVgsOSw54VF+OOp
	4Eu4Hn6fA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l9BlF-0002Du-PM; Mon, 08 Feb 2021 18:59:49 +0000
Received: from mail-wr1-f41.google.com ([209.85.221.41])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l9BlD-0002Cz-Cl
 for linux-nvme@lists.infradead.org; Mon, 08 Feb 2021 18:59:48 +0000
Received: by mail-wr1-f41.google.com with SMTP id v14so2924731wro.7
 for <linux-nvme@lists.infradead.org>; Mon, 08 Feb 2021 10:59:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=BjQlftpR8VF5xHz9TSKONLJDf2avun55X9zYF4/MnQ4=;
 b=s0lmEyc8TLHbrqjWjtMl6LYAjpvUWbFqouVoyMd2n/iW55AuCVdHw3amP4mKd7WiSu
 K5PAQ96n9oSNMyz7Xm2k14M2+Z9j/68ZzTCJILDAf6egUAMq+vDsaQurAhJNY2h+gNyQ
 fInGk2bgPjg9Sp/2bgokgMjx6xa9C1yPZm1uOM87x39sD/i5Xxw0l+NLqQXcYYfqzGAw
 L4CpoIIJ6Hu5+I66x+SRie0F5pvpw8czTtPoI3RMO/fZpCb3LlEMju7WrHhJ4Lzj/uoY
 HPDfotWjcQVjhSzNq5myaU8jsTSPzQpO/gkbdu3Dl+8OQD4ERIRpVZSRVpqsaKvQ+O52
 rC3g==
X-Gm-Message-State: AOAM533UbNY9/Ypt/TW0j9AsfSIkmTpAscTEOqWDnw//X7WCZ89J00ko
 owWPV1hb3OX5L6pHyLD5zn7CbTcslXA=
X-Google-Smtp-Source: ABdhPJzTmr/z/R0xs+RRgSvTAEeY2I59WxnXUNTzoE776+7ngsIarrEeO2hxYsOn2zFxx4bXtYPKqA==
X-Received: by 2002:a5d:4ccb:: with SMTP id c11mr20512380wrt.324.1612810786141; 
 Mon, 08 Feb 2021 10:59:46 -0800 (PST)
Received: from ?IPv6:2601:647:4802:9070:2121:4cf7:e6f6:2dc5?
 ([2601:647:4802:9070:2121:4cf7:e6f6:2dc5])
 by smtp.gmail.com with ESMTPSA id s4sm29029140wrt.85.2021.02.08.10.59.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 08 Feb 2021 10:59:45 -0800 (PST)
Subject: Re: Clarification regarding "nvme discover" and setting IOSQES/IOCQES
To: "Belanger, Martin" <Martin.Belanger@dell.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <SJ0PR19MB4544CE3903DEEA63D0C3929FF28F9@SJ0PR19MB4544.namprd19.prod.outlook.com>
 <4608296a-6c45-a252-8b49-88cf25cd7365@grimberg.me>
 <SJ0PR19MB454412891E589E03EF8DB948F28F9@SJ0PR19MB4544.namprd19.prod.outlook.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <c02ae0ac-ce0b-7081-9759-8c3751510ca7@grimberg.me>
Date: Mon, 8 Feb 2021 10:59:43 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <SJ0PR19MB454412891E589E03EF8DB948F28F9@SJ0PR19MB4544.namprd19.prod.outlook.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210208_135947_577388_86D3B192 
X-CRM114-Status: GOOD (  17.59  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


> Hi Sagi,
> 
> Yes. The Discovery Controller currently allows it. The problem, however, 
> is that the DC seems to be expecting these values to be non-zero.
> 
> I tried setting IOCQES=0 and IOSQES=0, which the DC allows (i.e. Prop 
> Set return status=0). However, when I follow this by a "Property Get - 
> Controller Status", the Status now shows "Controller Fatal Status (CFS)" 
> (see Base specs - Figure 79).

Yes, the oversight extends to the target that expects it (shared code
with I/O controllers).

Does this fix your issue?
--
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 546a10407385..a7578c601727 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2443,6 +2443,11 @@ int nvme_disable_ctrl(struct nvme_ctrl *ctrl)
  }
  EXPORT_SYMBOL_GPL(nvme_disable_ctrl);

+static inline bool nvme_discovery_ctrl(struct nvme_ctrl *ctrl)
+{
+       return ctrl->opts && ctrl->opts->discovery_nqn;
+}
+
  int nvme_enable_ctrl(struct nvme_ctrl *ctrl)
  {
         unsigned dev_page_min;
@@ -2468,7 +2473,8 @@ int nvme_enable_ctrl(struct nvme_ctrl *ctrl)
                 ctrl->ctrl_config = NVME_CC_CSS_NVM;
         ctrl->ctrl_config |= (NVME_CTRL_PAGE_SHIFT - 12) << 
NVME_CC_MPS_SHIFT;
         ctrl->ctrl_config |= NVME_CC_AMS_RR | NVME_CC_SHN_NONE;
-       ctrl->ctrl_config |= NVME_CC_IOSQES | NVME_CC_IOCQES;
+       if (!nvme_discovery_ctrl(ctrl))
+               ctrl->ctrl_config |= NVME_CC_IOSQES | NVME_CC_IOCQES;
         ctrl->ctrl_config |= NVME_CC_ENABLE;

         ret = ctrl->ops->reg_write32(ctrl, NVME_REG_CC, ctrl->ctrl_config);
@@ -2888,11 +2894,6 @@ static const struct attribute_group 
*nvme_subsys_attrs_groups[] = {
         NULL,
  };

-static inline bool nvme_discovery_ctrl(struct nvme_ctrl *ctrl)
-{
-       return ctrl->opts && ctrl->opts->discovery_nqn;
-}
-
  static bool nvme_validate_cntlid(struct nvme_subsystem *subsys,
                 struct nvme_ctrl *ctrl, struct nvme_id_ctrl *id)
  {
diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 8ce4d59cc9e7..baa26a65d83d 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -1107,9 +1107,14 @@ static void nvmet_start_ctrl(struct nvmet_ctrl *ctrl)
  {
         lockdep_assert_held(&ctrl->lock);

-       if (nvmet_cc_iosqes(ctrl->cc) != NVME_NVM_IOSQES ||
-           nvmet_cc_iocqes(ctrl->cc) != NVME_NVM_IOCQES ||
-           nvmet_cc_mps(ctrl->cc) != 0 ||
+       if (!ctrl->subsys->type == NVME_NQN_DISC &&
+           (nvmet_cc_iosqes(ctrl->cc) != NVME_NVM_IOSQES ||
+            nvmet_cc_iocqes(ctrl->cc) != NVME_NVM_IOCQES)) {
+               ctrl->csts = NVME_CSTS_CFS;
+               return;
+       }
+
+       if (nvmet_cc_mps(ctrl->cc) != 0 ||
             nvmet_cc_ams(ctrl->cc) != 0 ||
             nvmet_cc_css(ctrl->cc) != 0) {
                 ctrl->csts = NVME_CSTS_CFS;
--

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
