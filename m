Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 039DFC433F5
	for <linux-nvme@archiver.kernel.org>; Wed, 23 Mar 2022 07:13:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LRNwIfewu1/Ld/75IhXBXJYE1PhXNp3EQqTcQRjDrIU=; b=l4RZ7vDOB75hcTUB9o5tO2G39n
	LxnmTR1o3zyuTnn59VeGUe/jCQCISrbJ3YaIF+ftvaWVM51z8yYQWLzFL3d/kcCeY6bTUUW0oWAtP
	RJmTFCEa0x+56+NNMPgeWmN0RrX7yzWegr8FoNQZUUn4DjW+UVv3xmRPFhQ5JkXeBHwdp5oS5Qh+e
	VuItZ7Z/zXrl2xdhWJl7OtwpvzqRwd0MmQb27o7eo3pb/UbEsMuyU3wu0LbekLJM7Gl7jDeI1nqZ1
	QMR7AdGCKGcIiJj0z59ql+q93EWuFczJH3PAbZYN5L4M/QdjCkU2kVHspf84yx8G7uVvGwNU43UmQ
	w1L3CAHw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nWvBs-00Cvl3-M5; Wed, 23 Mar 2022 07:13:56 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nWvBM-00Cvax-Ea
 for linux-nvme@lists.infradead.org; Wed, 23 Mar 2022 07:13:27 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id 40CEC210F7;
 Wed, 23 Mar 2022 07:13:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1648019602; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LRNwIfewu1/Ld/75IhXBXJYE1PhXNp3EQqTcQRjDrIU=;
 b=az6DPew0eQrBkyc/76vAkj9+lX5pIgWX/Rw68/O5iQV2dktRlTWWLRRf4/fiGIcd5ZU1Bd
 EsqyWyYCeW7WsE/O/0QasMnxK7numy8L0A30DjrF3NqIf6meLMjrByZpgZhdzfvqRdMvL0
 LnHXzq9GmZ9ku12oPzY15p9DK41wYQI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1648019602;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LRNwIfewu1/Ld/75IhXBXJYE1PhXNp3EQqTcQRjDrIU=;
 b=5tHP93cukGN6udiU0dlGoIVBGfebsCP8L/nVoykiXUwhLLDlHkBGlKa57E4kXw/MWGSqJX
 VDrfMXY7PxzMJsAQ==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
 by relay2.suse.de (Postfix) with ESMTP id 1104BA3B89;
 Wed, 23 Mar 2022 07:13:21 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
 id 35A7A519387D; Wed, 23 Mar 2022 08:13:21 +0100 (CET)
From: Hannes Reinecke <hare@suse.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <keith.busch@wdc.com>,
 linux-nvme@lists.infradead.org, Hannes Reinecke <hare@suse.de>,
 Chaitanya Kulkarni <kch@nvidia.com>,
 Himanshu Madhani <himanshu.madhani@oracle.com>
Subject: [PATCH 02/11] crypto: add crypto_has_kpp()
Date: Wed, 23 Mar 2022 08:12:54 +0100
Message-Id: <20220323071303.14671-3-hare@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20220323071303.14671-1-hare@suse.de>
References: <20220323071303.14671-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220323_001324_829501_7A57CAA7 
X-CRM114-Status: GOOD (  10.81  )
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

Add helper function to determine if a given key-agreement protocol
primitive is supported.

Signed-off-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
Reviewed-by: Himanshu Madhani <himanshu.madhani@oracle.com>
---
 crypto/kpp.c         | 6 ++++++
 include/crypto/kpp.h | 2 ++
 2 files changed, 8 insertions(+)

diff --git a/crypto/kpp.c b/crypto/kpp.c
index 7aa6ba4b60a4..678e871ce418 100644
--- a/crypto/kpp.c
+++ b/crypto/kpp.c
@@ -104,6 +104,12 @@ int crypto_grab_kpp(struct crypto_kpp_spawn *spawn,
 }
 EXPORT_SYMBOL_GPL(crypto_grab_kpp);
 
+int crypto_has_kpp(const char *alg_name, u32 type, u32 mask)
+{
+	return crypto_type_has_alg(alg_name, &crypto_kpp_type, type, mask);
+}
+EXPORT_SYMBOL_GPL(crypto_has_kpp);
+
 static void kpp_prepare_alg(struct kpp_alg *alg)
 {
 	struct crypto_alg *base = &alg->base;
diff --git a/include/crypto/kpp.h b/include/crypto/kpp.h
index cccceadc164b..24d01e9877c1 100644
--- a/include/crypto/kpp.h
+++ b/include/crypto/kpp.h
@@ -104,6 +104,8 @@ struct kpp_alg {
  */
 struct crypto_kpp *crypto_alloc_kpp(const char *alg_name, u32 type, u32 mask);
 
+int crypto_has_kpp(const char *alg_name, u32 type, u32 mask);
+
 static inline struct crypto_tfm *crypto_kpp_tfm(struct crypto_kpp *tfm)
 {
 	return &tfm->base;
-- 
2.29.2


