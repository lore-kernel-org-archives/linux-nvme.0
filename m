Return-Path: <SRS0=LBLG=7C=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0A31C433DF
	for <linux-nvme@archiver.kernel.org>; Wed, 20 May 2020 19:00:00 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A74DB207D8
	for <linux-nvme@archiver.kernel.org>; Wed, 20 May 2020 19:00:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="A4mwKuS2";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FmLGCDhx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A74DB207D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=kdrVQG6zdSmUnbIKQPxwGRLn75bK1hPo40az7fngbUY=; b=A4mwKuS2WRgA7b
	63YYyxAXurU6zjxt08/0JAf4pFTSfx/Y/vjQtSfmJJuqLdhDZtFFekrAF7lHi4OElH//1awmk6TwC
	sBuofol22mlhH+n7/N6Pm0E7sKwbt3TDKFWuh7JvOTxMZ6k0fhUp2BFkN/7QecOzA70ID3yHn9l1Z
	GXb4tX2IG1RUrVG/zus4opzCSqmyqe8sOLLR9BqnEDHtgaI9af7sc6gG+yMDsaBCBKAYdADWd+kYy
	LnxmlyVk2Q6IYwTOswo9Hs7u+WapB0b3AVMSWxVcgy1KTZehw6cJuwGmWr1n1hOGg8eeMzsNklb2r
	Bd9HBLc+N+zFm3Zb5mpQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jbTwY-0001uF-7b; Wed, 20 May 2020 18:59:54 +0000
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jbTwT-0001sa-3F
 for linux-nvme@lists.infradead.org; Wed, 20 May 2020 18:59:53 +0000
Received: by mail-wm1-x344.google.com with SMTP id n5so4028009wmd.0
 for <linux-nvme@lists.infradead.org>; Wed, 20 May 2020 11:59:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=QVRzIw5gK9X80Q4zCQi5+LrdGRNRTwpX/elN2U6ejEI=;
 b=FmLGCDhxguF6bNHD6SODLgUzmLA/p4Gxc1NL+iWJo1UYZ6AWYmzdLLGP6mxTMna3LY
 idHhxxQkZjdN/MoP8g18PATW8T8l+LGxGlvLCT4jSus2ggAn13syBKK5DfKyJhXrxmEY
 Nk7J7n2FDUtS5qpP7S4BF9Pas9PuxfT2IXKSqgmzoKDXtmk/yjxpC/t9YMeDdLGQFfj2
 38v/8KJQ1V9OrMa3BxYZ3KuzI0d9rUIV/P2U5Nw4XEe2tQZDVFKjC16x0U+63b5AR664
 wAVbo6z4OnTj8KqyIVef3iarDmEXOddSRe/pzSoohG3B4jewVwyB2b7l5Oh4RKjsvUsz
 Pmpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=QVRzIw5gK9X80Q4zCQi5+LrdGRNRTwpX/elN2U6ejEI=;
 b=ZlxhLwCla5Os8FjFqoE0G/jRVbMUB/XBF1EWfJAGW2vTqgj68UMkHGGC7S+a2SKDZw
 KeF/GEKIfhBvRsvT9IfGF0rslUPNsr9ka/TrKUQVyfFVKrfl4oHsxmpamDMqUCVGz7jz
 l/IoQIa58JpkdzKUiGJA1lPtDEtGka7kG0bqPU4JWoeDsTzOLq2mBja3GNrs6zHnGum9
 qa/OGIPiQZ0rsYPFf2GAH9hjT71DTzk6CxLssiBj4dMjIF+ADBgF6SLckZIF7wXvzrap
 nfqKBItiEr7wXjxaE/hTcbl3MVpyODFRdcy+134fzP2eJXvmjGSPuN/KkVlEcFytiOx6
 ncRQ==
X-Gm-Message-State: AOAM532UE/cZ3iMJJuIFcuhvGIqz7n8m3UVUVFKimFUsBPFADpUf1DXo
 DtEO8MI7q+ynwVJRh0VnjQns6gie
X-Google-Smtp-Source: ABdhPJydDZKgzAApy4kKFZ4WgRq2UFly1Ga7Z2UBJ/ii8/6KCYt0/YlY+CKGy/e2lXYNKaAnq9OkoA==
X-Received: by 2002:a7b:c8d4:: with SMTP id f20mr6008280wml.72.1590001182803; 
 Wed, 20 May 2020 11:59:42 -0700 (PDT)
Received: from localhost.localdomain.localdomain (ip68-5-85-189.oc.oc.cox.net.
 [68.5.85.189])
 by smtp.gmail.com with ESMTPSA id c19sm3896483wrb.89.2020.05.20.11.59.39
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 20 May 2020 11:59:42 -0700 (PDT)
From: James Smart <jsmart2021@gmail.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH 0/3] lpfc: Fix errors in LS receive refactoring
Date: Wed, 20 May 2020 11:59:26 -0700
Message-Id: <20200520185929.48779-1-jsmart2021@gmail.com>
X-Mailer: git-send-email 2.26.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200520_115949_155319_2E41A08D 
X-CRM114-Status: UNSURE (   9.17  )
X-CRM114-Notice: Please train this message.
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
Cc: axboe@kernel.dk, James Smart <jsmart2021@gmail.com>,
 martin.petersen@oracle.com, linux-scsi@vger.kernel.org, jejb@linux.ibm.com,
 kernel-janitors@vger.kernel.org, hch@infradead.org, paul.ely@broadcom.com,
 hare@suse.de, dan.carpenter@oracle.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

A prior patch set refactored lpfc to create common routines for NVME LS
handling for use by both the initiator and target paths.  The refactoring
introduced several errors spotted by additional testing and static checker
reporting.

This patch set corrects those errors.

The patches should enter via the nvme tree, as the lpfc modifications were
in support of nvme-fc transport api deltas merged via the nvme tree.

-- james


James Smart (3):
  lpfc: Fix pointer checks and comments in LS receive refactoring
  lpfc: fix axchg pointer reference after free and double frees
  lpfc: Fix return value in __lpfc_nvme_ls_abort

 drivers/scsi/lpfc/lpfc_nvme.c  |  2 +-
 drivers/scsi/lpfc/lpfc_nvmet.c | 29 ++++++++++++++++++-----------
 drivers/scsi/lpfc/lpfc_sli.c   | 10 ++++++----
 3 files changed, 25 insertions(+), 16 deletions(-)

-- 
2.26.1


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
