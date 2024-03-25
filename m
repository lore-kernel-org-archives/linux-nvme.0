Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BACAEC54E64
	for <linux-nvme@archiver.kernel.org>; Mon, 25 Mar 2024 15:45:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=OUFSLesx35nW0oOueg/eginuEtMK4Ilh5II9VhT0kH0=; b=rIhYztJQZNSK6dZv+O+vdPCnEt
	3/Sir/emRDT5wBb5Ns+PjA7+IiIB5drWnwt+9FmmIhsAzhzcIWVTo6bdQPOuEO+xFZr5kJ0RWOn9I
	K0xdr16HU5axlo8s1Y6t7x1iExEf2pjxJ5E/c2EK9CUzH1TT9yTnOCX4/KjBvxCgtrR241ujBi9iW
	rsJtBFScEGEk6VtrPADcIAtMGYVM8euk6rOpR5Qp8jJoaM1kKuv759N3ttyBFkjjdS2hfs5+RzvZJ
	9gZdeeNk66aynEzeDF3/1BwHY3BLjyCo12OfDpvhRe1ppCuAgKdQK/yimXXHGAZD8ojCwk7NcBi9e
	LWmM+kqw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1romVc-00000000ZR3-3zSX;
	Mon, 25 Mar 2024 15:45:12 +0000
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1romVa-00000000ZPs-2LSW
	for linux-nvme@lists.infradead.org;
	Mon, 25 Mar 2024 15:45:12 +0000
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-6e703e0e5deso3142945b3a.3
        for <linux-nvme@lists.infradead.org>; Mon, 25 Mar 2024 08:45:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711381508; x=1711986308; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OUFSLesx35nW0oOueg/eginuEtMK4Ilh5II9VhT0kH0=;
        b=dWCOTWibYjxp27Op2HUN6YqpFz5tiQ6HBT/NfQ/g8TdTUZAafVuEf/AdbIl9LJi85m
         Dc90W4Yqzw561Fwv30ONfZ+xcmdah5IUdD3RdrNaoQNfYy91po04rwSBvJRyhvxd84pF
         CqtS+36dC4QvNVu8L4M02FWPUbLgG03fkem10kkwMFOdmv/3ndJGf4CJ9TaJHJIuk1uP
         sqxqcZwTYl5v0fVCCmM4cpxijwNXD2pDvbjp7ueqCztXcWX7sMU2NiuPV++5HmT3QHHU
         GvPlWKL4lwq4kGycVLLUlkTHKw162adl9la91JtKkkzUKmOMD7ww48G6pMWVY9YnDe10
         uZJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711381508; x=1711986308;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OUFSLesx35nW0oOueg/eginuEtMK4Ilh5II9VhT0kH0=;
        b=u1rd/P6kBQYUuM8iOQReVaftvkZT8F6O76hzFsyOFdy3x5eCnfTCFIcSsnnhRlbbAL
         cw0JZPpwCowuS1IomYJOuwWAgm+9OVIhTE2K9X38gSq3+9cjKjtF3BKjHf1kTNbX8Bgx
         ZRdVX3/Qs23YJ2LIncm8SQp7I59Jyb/be8Xa7JHfyfCYY7Y74YnPtPG82rvv0aKehfsV
         NlZAGWCb8MvB+qfkVLk9Fb3t5hRkvw2teqM1lNLcoNFe8UxT/0s/wfrNcHsCqd3m1OsU
         h9vo7GPbyig73fOEd5SlECcrxEFGL/jg/jvBxs2ILKHWYpsXgByNO0SKRu5mFthXHwGZ
         A1gA==
X-Gm-Message-State: AOJu0YwBHAvPTHR/MxVPD6SK/tpAKdWqn29tPL4YWaMJNtZws++Z9FFv
	mPdPkYuoVzz1sXErH2Sjhh3vWMQJL/D26+uSE85FXGf+FeXSDay85w285NBD
X-Google-Smtp-Source: AGHT+IGLt5n3+SfugkO+FloErhJg7bt6PdyN3yAKpCH0RNaDb/ux1PxbTzw9509aoHqHs1BeaUh0mg==
X-Received: by 2002:a05:6a00:b84:b0:6ea:8e84:d806 with SMTP id g4-20020a056a000b8400b006ea8e84d806mr9267345pfj.16.1711381507986;
        Mon, 25 Mar 2024 08:45:07 -0700 (PDT)
Received: from tokunori-desktop.flets-east.jp ([240b:10:2720:5500:4d20:5e09:b35:7ed7])
        by smtp.gmail.com with ESMTPSA id m18-20020a62f212000000b006e6bcda8480sm4193652pfh.121.2024.03.25.08.45.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 08:45:07 -0700 (PDT)
From: Tokunori Ikegami <ikegami.t@gmail.com>
To: linux-nvme@lists.infradead.org
Cc: Tokunori Ikegami <ikegami.t@gmail.com>
Subject: [PATCH] nvme: initialize identify ns data to NULL
Date: Tue, 26 Mar 2024 00:45:03 +0900
Message-Id: <20240325154503.11510-1-ikegami.t@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240325_084510_622887_8A74B8E9 
X-CRM114-Status: GOOD (  13.54  )
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

Currently nvme_identify_ns() sets the data to NULL if failed.
Also the data is not freed if the function returned failure.
But correctly the data should be initialized to NULL.
So to make sure fix to initialize the data to NULL.

Signed-off-by: Tokunori Ikegami <ikegami.t@gmail.com>
---
 drivers/nvme/host/sysfs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
index 3c55f7edd181..4e996e10f46a 100644
--- a/drivers/nvme/host/sysfs.c
+++ b/drivers/nvme/host/sysfs.c
@@ -185,7 +185,7 @@ static DEVICE_ATTR_RO(metadata_bytes);
 
 static int ns_head_update_nuse(struct nvme_ns_head *head)
 {
-	struct nvme_id_ns *id;
+	struct nvme_id_ns *id = NULL;
 	struct nvme_ns *ns;
 	int srcu_idx, ret = -EWOULDBLOCK;
 
@@ -212,7 +212,7 @@ static int ns_head_update_nuse(struct nvme_ns_head *head)
 
 static int ns_update_nuse(struct nvme_ns *ns)
 {
-	struct nvme_id_ns *id;
+	struct nvme_id_ns *id = NULL;
 	int ret;
 
 	/* Avoid issuing commands too often by rate limiting the update. */
-- 
2.40.1


