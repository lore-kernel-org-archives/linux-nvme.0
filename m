Return-Path: <SRS0=DaCh=L5=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B29F1C07E95
	for <linux-nvme@archiver.kernel.org>; Mon,  5 Jul 2021 03:16:01 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D94861350
	for <linux-nvme@archiver.kernel.org>; Mon,  5 Jul 2021 03:16:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D94861350
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=jZULwhvSX+Kj5pJBbGdsToRuq9nUpMEO6QJAv2C4pKI=; b=PDTOqyxxsXxPyW
	4HcTkUIM7C9XOA6Tuexh8Ck8JCpqTJYXKtfnqixUmKm36zXuf+atVHLjVfLFtihDyiBWRLmvhVVJE
	hcnhWl30WOE5Ggh5Ef+JTxOA22ZbmUnYTEfLjGbsL91DfpktDc1+Oo2+r6Kw/1BSEl8HNV7YeXCtK
	vbtYH/RzXopS1QtFdW477muAJbl/pDj16CVhaqDtcksvsM1VLytuogmJ4q2bHXROYNH9YHPIRYSg3
	AdB+vTnSOULd4jYj90/Nr1hs6fVY813T7ogug7azwI+Nk0od4+P9UUoAukLwv7UiVPtdlP1akUvZc
	JGB8Ozh3M7p7qVdr3IWQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1m0F5K-007Yop-Ia; Mon, 05 Jul 2021 03:15:50 +0000
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1m0F5H-007YoT-9q
 for linux-nvme@lists.infradead.org; Mon, 05 Jul 2021 03:15:48 +0000
Received: by mail-pg1-x52b.google.com with SMTP id o18so16375724pgu.10
 for <linux-nvme@lists.infradead.org>; Sun, 04 Jul 2021 20:15:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=6s+xj5pDicrDTglfKTEG8C4jkoOmNHOo12KS/CIC/tU=;
 b=Mgvtv4XzaU+ur9pmegdN55FOu7x5OBmomeKABORiNW4rsmzDY5qsun8GJUWoHKEq1C
 j85Rk7JS/vCWL4XHWQnC7IF/3r/IfeuNR2lqeNCJPABy7D39/CVKZNd5f/k0pN1eeiiR
 DOod6XnFWN5f9bNjCHI4bcyoncqxOIpWJkddJjtkprKpZA2XFBOJfSupKGO7N05mglCV
 10B/d4jEHtRPN52QNLZxUErzJ6w3fopt3i8PzWK+dZqtCwGmxpuu6ap1T8Y7+45Qv0lG
 q9x3mSRhQpuxGEl4U19FNWnsiG9xSz9ghjTOicTtprTbZUJ1KQ7o7aNSEjtjeTiUvJhs
 HEig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=6s+xj5pDicrDTglfKTEG8C4jkoOmNHOo12KS/CIC/tU=;
 b=JiV7dLuH/ubJokPFBsnKBsGe5hMov7FyhL+dbE7GlYceQSI+1mlVLaXlqSCNyMjnaH
 h0GkROwQRjpvgKgkUqjbtR9rdojirKpsezJu8Xg98Xo9sYvpj14D5ekB/RmR/EXwcLUb
 eHAydvT6Whinl/iYMJFKsfDBDHWVGUhh0LTFEGcfoH2jXR8FNshOWo7cPdPOd6WStd7j
 CXyXS+qJsmGmI43WSCblIQIw02wyAgyQFMkV8pURrbOEZctIQnRk5xVloo6Bqu09PWOj
 uSF+xakrx3IajilUlB3b6zTqZYh+LsLJjgRMyDxeI6sha2lgXTF7awwaqBhRnb6iCv3v
 arPw==
X-Gm-Message-State: AOAM530W+OEoXtL+cp1hgZk50MbwoyKbQL3FNIZt050n/8xQU+GWndqv
 s6dbGh0V6mxI/7x17XTnLys=
X-Google-Smtp-Source: ABdhPJyDOWzFOBunoDapSoNxVGZjHypPFcD7eTFV/j0aC3oSIfTHIkFfZueDczqfD+vNdEu4UkmYVQ==
X-Received: by 2002:a63:5cb:: with SMTP id 194mr13155478pgf.146.1625454945648; 
 Sun, 04 Jul 2021 20:15:45 -0700 (PDT)
Received: from houpudeMacBook-Pro.local.net ([61.120.150.70])
 by smtp.gmail.com with ESMTPSA id 136sm11455570pfa.158.2021.07.04.20.15.42
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 04 Jul 2021 20:15:45 -0700 (PDT)
From: Hou Pu <houpu.main@gmail.com>
To: sagi@grimberg.me,
	hch@lst.de,
	chaitanya.kulkarni@wdc.com
Cc: linux-nvme@lists.infradead.org,
	houpu.main@gmail.com,
	maxg@mellanox.com
Subject: [PATCH 0/2] nvme: add set feature tracing support
Date: Mon,  5 Jul 2021 11:15:27 +0800
Message-Id: <20210705031529.36001-1-houpu.main@gmail.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210704_201547_397560_4B56FBBD 
X-CRM114-Status: UNSURE (   7.12  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Add set feature tracing support to host and controller side.
Also fix a style problem in nvmet_trace_admin_get_features.

Hou Pu (2):
  nvme: add set feature tracing support
  nvmet: add set feature tracing support

 drivers/nvme/host/trace.c   | 18 +++++++++++++++++-
 drivers/nvme/target/trace.c | 18 +++++++++++++++++-
 2 files changed, 34 insertions(+), 2 deletions(-)

-- 
2.28.0


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
