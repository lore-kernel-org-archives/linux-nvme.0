Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A897FC77B76
	for <linux-nvme@archiver.kernel.org>; Mon, 17 Apr 2023 22:56:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=l6D0feCu1d+yyKPh/6VbxhsIfXinTHZDHqHhB/yxab8=; b=gqpUxKhv5rch5WkOfWxp6XplRV
	owQpk5i9abpw5Ps5JzsLp/h8quzHPxOODL4skdynCutAAADOG7O9orKuwPGbEJOwLSob8U0wUXEp1
	Q6FiAUwg/ZD3h294fOqaXXJgnXwTMyhFnO4BlsJPnQusNgWT6ve0cDvUyRlgtmTJywCaCTfz/+vYk
	Lf79MyuCWcrGxkuBImRs7xPdYDDY+nTKJBO+KEpLkkYeCUdW4+YimK8pw1kq2iH2HcQZn1nBBA0aw
	7SXwchwEHK35m2ipHt/2S66n/PGBGhliNA03a2lcgFxSVzHcOcix1KEgfnnT2CJwJd/VXA/HNM2S4
	APZoMyAA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1poXlc-000Kq9-1X;
	Mon, 17 Apr 2023 22:56:12 +0000
Received: from mail-ua1-x962.google.com ([2607:f8b0:4864:20::962])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1poXlY-000KnW-0l
	for linux-nvme@lists.infradead.org;
	Mon, 17 Apr 2023 22:56:11 +0000
Received: by mail-ua1-x962.google.com with SMTP id y21so8847583ual.3
        for <linux-nvme@lists.infradead.org>; Mon, 17 Apr 2023 15:56:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1681772166; x=1684364166;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=l6D0feCu1d+yyKPh/6VbxhsIfXinTHZDHqHhB/yxab8=;
        b=ZK1epdEoEw6o9quBrTiukQwyhRDpGw8OB2cAiHIHH1izOOEDymlJM9XDB1hAp3f1kx
         +HYXeUntZcS152Bo9JyFX3tWSVfPKUmCg6rEgHf7pCZuRHuQI1jvJngJrT55edaD2SO/
         gDFvDlbkR3TdtrDiy8gTwZ+6ozj2gYWWrFAqe6OhSaMi79A3ea1ePyEH3f4Njxsw7aXH
         gMs796M5rZyN5I2ka3DQtiecNA0hYO2TGGqb8F93ne5rZ+iO/oitfQcgWAgBpW6T9gr1
         TaehoeLyp6v5JqAPY4ws1JBo8+OxUPR2GIRziw+zGPYQybxsKIEBUKVbeXcQJnNjvhTJ
         rYig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681772166; x=1684364166;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l6D0feCu1d+yyKPh/6VbxhsIfXinTHZDHqHhB/yxab8=;
        b=NDolAIZ5aRzDP1SZU63SCzvxwg5GOuItWQlms1T2XhiSLCRwJMfbcGf8WxYKQ26TpU
         tPnPxKvabxblX5K79m6Y9VDdJV+c+VuDhEW1pZqzEYJwEtWuZ/kg5KYC4kzydlnAlyrn
         w7N7haUOoDJ16iTdH6KPdFw6M84Fea3Qrjsj0SeZp/oZhsgDMnWfgLz2BDoZSbicmo7V
         3I65hfHUbJ9WwOVNqYVKyvvvmdYTV7dZsTuyqgu2LYO7T8bv1DFrjtXvhhY5GaMaafj/
         uDyPnzSVFyRJA8+rXV9I/A92Rqy8bRpamJbOMXE0yjkV2A2mCBDx62Cu5gdTs5uRQDdC
         YE4w==
X-Gm-Message-State: AAQBX9c3/ijALpF/bzMwazavjOAH0XH1XXQ7BRYuBW6YsYpu9mDf+2rd
	gAjBMmRMeyGguiuHdhjGnRDm5n4cPk2+VPROsPm52rQlSW3pognEAX3SYHugXbBExg==
X-Google-Smtp-Source: AKy350avyGI8mX+URJJzGwkSrbgNVYjfkg4eDbaNwDoN+JkxzjTvjEFLef+Fdx8KV0rWtucJGuQ3KrhIBKUb
X-Received: by 2002:a1f:c843:0:b0:401:87c8:4a7c with SMTP id y64-20020a1fc843000000b0040187c84a7cmr4309198vkf.14.1681772166767;
        Mon, 17 Apr 2023 15:56:06 -0700 (PDT)
Received: from c7-smtp.dev.purestorage.com ([2620:125:9007:320:7:32:106:0])
        by smtp-relay.gmail.com with ESMTPS id ay32-20020a056122182000b00431eccbd8d5sm5695033vkb.8.2023.04.17.15.56.06
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Apr 2023 15:56:06 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-ushankar.dev.purestorage.com (dev-ushankar.dev.purestorage.com [IPv6:2620:125:9007:640:7:70:36:0])
	by c7-smtp.dev.purestorage.com (Postfix) with ESMTP id 8A837220AB;
	Mon, 17 Apr 2023 16:56:05 -0600 (MDT)
Received: by dev-ushankar.dev.purestorage.com (Postfix, from userid 1557716368)
	id 7C7E3E47A66; Mon, 17 Apr 2023 16:56:05 -0600 (MDT)
From: Uday Shankar <ushankar@purestorage.com>
To: Costa Sapuntzakis <costa@purestorage.com>,
	Randy Jennings <randyj@purestorage.com>,
	Hannes Reinecke <hare@suse.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@fb.com>
Cc: Uday Shankar <ushankar@purestorage.com>,
	linux-nvme@lists.infradead.org
Subject: [PATCH 0/3] keepalive bugfixes
Date: Mon, 17 Apr 2023 16:55:55 -0600
Message-Id: <20230417225558.2890062-1-ushankar@purestorage.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230417_155608_443100_1EFA9BD0 
X-CRM114-Status: UNSURE (   9.11  )
X-CRM114-Notice: Please train this message.
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

While reviewing the Linux KATO implementation in an attempt to better
understand the current NVMe Keep Alive specification, we found a
few issues in the host implementation that could contribute to spurious
Keep Alive timeouts being detected by controllers.

Uday Shankar (3):
  nvme: double KA polling frequency to avoid KATO with TBKAS on
  nvme: check IO start time when deciding to defer KA
  nvme: improve handling of long keep alives

 drivers/nvme/host/core.c | 38 +++++++++++++++++++++++++++++++++++---
 drivers/nvme/host/nvme.h |  5 +++--
 2 files changed, 38 insertions(+), 5 deletions(-)

-- 
2.25.1


