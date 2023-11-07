Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1383DC4332F
	for <linux-nvme@archiver.kernel.org>; Tue,  7 Nov 2023 17:49:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NVpRWZooEOI7K1GuHprzQ8e8INUW3c5k9GGKyVtPwr0=; b=q3Gl8EXkRQUsDnchpKRLr2z4GL
	T1fBT8F+P4CQeFLoqmUw002MotFphSwsln++6xbQZL6dS0gxzRj5N6WDE0eauejGowKDdSm7CQQHo
	oGDkAL+ghmh+whOMnXUPN0ZYtE+CaGQIqa3i8+JVCZXN2xXVV4FwKULuW5AaepIXNXPjhZG+AaZus
	/36HCvp+UGp1/CUPePaCcSIth34J8AMH8vjcC74J7+PFhQ5kVBbPMYytwmBAtI4/0BupekfPuPJ3I
	9AdlRBi+/Dtq75pP9aGfbYoqFapcxwWpdBZ0m1xlBqKZX3L6TsNE0HLVmU2CpbU5DyXuSGAwvScK3
	inHmtsqw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r0QD2-0027rb-0U;
	Tue, 07 Nov 2023 17:49:52 +0000
Received: from ams.source.kernel.org ([2604:1380:4601:e00::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r0QCz-0027qp-14
	for linux-nvme@lists.infradead.org;
	Tue, 07 Nov 2023 17:49:51 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by ams.source.kernel.org (Postfix) with ESMTP id F1E61B81696;
	Tue,  7 Nov 2023 17:49:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFAA8C433C8;
	Tue,  7 Nov 2023 17:49:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699379387;
	bh=CPTLOH6oyzCvUylIqO9VoOFDSI6uBIh9po4SdgWz58s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XyfSOzSBGpjtqpQ5tTfY7Kwf4jWNKOCdFpR69ZV97TGTGyzARG+iymZyk3EGi5JLg
	 XDjDTQ949voXTKIfOdF4aLOOoAxon5di7EL8zmZEW3D3b8qysqF6Kk9w1zY74ClVjP
	 FRB1zjegTk/WBa+3041yLj5Ff76nAXDE6slVpmjvo8CnHX1Uy/XueiE3ojDOJ4LTCT
	 H7XBXL7VaNkbZ972ZFYVVcKBbgqCRG4l+uGL0JmiEIFLk68Shd3E9d27XD+AVfcAZo
	 Sax0s6TW0l5SlKFbQiTax4eD9vH7go1dVeKdBXhLUxW3vqNN+PzUmawWbb5h1ayM8M
	 nzKODjFAWwW+A==
Date: Tue, 7 Nov 2023 10:49:44 -0700
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Hannes Reinecke <hare@suse.de>, Arnd Bergmann <arnd@arndb.de>,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 2/2] nvme: keyring: fix conditional compilation
Message-ID: <ZUp4uHjLM04numYz@kbusch-mbp.dhcp.thefacebook.com>
References: <b138c4c5-9b49-4338-a79a-2f77a13381e8@app.fastmail.com>
 <d497429d-a1a2-4bf4-a958-3865294d9f2e@suse.de>
 <20231027052118.GB7885@lst.de>
 <78d1b4e3-4bce-4cbb-8ebe-8eb3f0fe9930@suse.de>
 <468cd6c9-c541-47ea-a2bc-f6cd09155351@app.fastmail.com>
 <20231027083003.GA17042@lst.de>
 <9bd4e078-b206-48b8-b94b-bc411317bb3d@suse.de>
 <20231027085644.GA19366@lst.de>
 <cdf931ad-626b-4efa-bc74-f4566b88e404@suse.de>
 <20231027092150.GA21039@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231027092150.GA21039@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231107_094949_635173_E12CCFBB 
X-CRM114-Status: GOOD (  18.13  )
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

On Fri, Oct 27, 2023 at 11:21:50AM +0200, Christoph Hellwig wrote:
> On Fri, Oct 27, 2023 at 11:08:23AM +0200, Hannes Reinecke wrote:
> > obj-$(CONFIG_MOD1)	+= mod1.o mod-common.o
> > obj-$(CONFIG_MOD2)	+= mod2.o mod-common.o
> >
> > and mod-common contains a 'module_init()' and a 'module_exit()' function, 
> > what happens if I load mod2 after mod1?
> 
> mod-common is already loaded and won't be loaded again.
> 
> > And what happens if I unload mod2, but keep mod1?
> 
> mod-common doesn't become available for unloading until all
> modules using it are unloaded first.

Looks like this works, atop patch 1:

---
diff --git a/drivers/nvme/common/keyring.c b/drivers/nvme/common/keyring.c
index 46d7a537dbc2e..c35b3a287a910 100644
--- a/drivers/nvme/common/keyring.c
+++ b/drivers/nvme/common/keyring.c
@@ -151,7 +151,7 @@ key_serial_t nvme_tls_psk_default(struct key *keyring,
 }
 EXPORT_SYMBOL_GPL(nvme_tls_psk_default);
 
-int nvme_keyring_init(void)
+static int __init nvme_keyring_init(void)
 {
 	int err;
 
@@ -171,14 +171,14 @@ int nvme_keyring_init(void)
 	}
 	return 0;
 }
-EXPORT_SYMBOL_GPL(nvme_keyring_init);
 
-void nvme_keyring_exit(void)
+static void __exit nvme_keyring_exit(void)
 {
 	unregister_key_type(&nvme_tls_psk_key_type);
 	key_revoke(nvme_keyring);
 	key_put(nvme_keyring);
 }
-EXPORT_SYMBOL_GPL(nvme_keyring_exit);
 
 MODULE_LICENSE("GPL v2");
+module_init(nvme_keyring_init);
+module_exit(nvme_keyring_exit);
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 75a1b58a7a436..683b694afdead 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4737,16 +4737,11 @@ static int __init nvme_core_init(void)
 		result = PTR_ERR(nvme_ns_chr_class);
 		goto unregister_generic_ns;
 	}
-	result = nvme_keyring_init();
-	if (result)
-		goto destroy_ns_chr;
 	result = nvme_init_auth();
 	if (result)
-		goto keyring_exit;
+		goto destroy_ns_chr;
 	return 0;
 
-keyring_exit:
-	nvme_keyring_exit();
 destroy_ns_chr:
 	class_destroy(nvme_ns_chr_class);
 unregister_generic_ns:
@@ -4770,7 +4765,6 @@ static int __init nvme_core_init(void)
 static void __exit nvme_core_exit(void)
 {
 	nvme_exit_auth();
-	nvme_keyring_exit();
 	class_destroy(nvme_ns_chr_class);
 	class_destroy(nvme_subsys_class);
 	class_destroy(nvme_class);
diff --git a/include/linux/nvme-keyring.h b/include/linux/nvme-keyring.h
index 4efea9dd967c1..f4f6634e85846 100644
--- a/include/linux/nvme-keyring.h
+++ b/include/linux/nvme-keyring.h
diff --git a/drivers/nvme/common/keyring.c b/drivers/nvme/common/keyring.c
index 46d7a537dbc2e..c35b3a287a910 100644
--- a/drivers/nvme/common/keyring.c
+++ b/drivers/nvme/common/keyring.c
@@ -151,7 +151,7 @@ key_serial_t nvme_tls_psk_default(struct key *keyring,
 }
 EXPORT_SYMBOL_GPL(nvme_tls_psk_default);
 
-int nvme_keyring_init(void)
+static int __init nvme_keyring_init(void)
 {
 	int err;
 
@@ -171,14 +171,14 @@ int nvme_keyring_init(void)
 	}
 	return 0;
 }
-EXPORT_SYMBOL_GPL(nvme_keyring_init);
 
-void nvme_keyring_exit(void)
+static void __exit nvme_keyring_exit(void)
 {
 	unregister_key_type(&nvme_tls_psk_key_type);
 	key_revoke(nvme_keyring);
 	key_put(nvme_keyring);
 }
-EXPORT_SYMBOL_GPL(nvme_keyring_exit);
 
 MODULE_LICENSE("GPL v2");
+module_init(nvme_keyring_init);
+module_exit(nvme_keyring_exit);
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 75a1b58a7a436..683b694afdead 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4737,16 +4737,11 @@ static int __init nvme_core_init(void)
 		result = PTR_ERR(nvme_ns_chr_class);
 		goto unregister_generic_ns;
 	}
-	result = nvme_keyring_init();
-	if (result)
-		goto destroy_ns_chr;
 	result = nvme_init_auth();
 	if (result)
-		goto keyring_exit;
+		goto destroy_ns_chr;
 	return 0;
 
-keyring_exit:
-	nvme_keyring_exit();
 destroy_ns_chr:
 	class_destroy(nvme_ns_chr_class);
 unregister_generic_ns:
@@ -4770,7 +4765,6 @@ static int __init nvme_core_init(void)
 static void __exit nvme_core_exit(void)
 {
 	nvme_exit_auth();
-	nvme_keyring_exit();
 	class_destroy(nvme_ns_chr_class);
 	class_destroy(nvme_subsys_class);
 	class_destroy(nvme_class);
diff --git a/include/linux/nvme-keyring.h b/include/linux/nvme-keyring.h
index 4efea9dd967c1..f4f6634e85846 100644
--- a/include/linux/nvme-keyring.h
+++ b/include/linux/nvme-keyring.h
@@ -6,14 +6,12 @@
 #ifndef _NVME_KEYRING_H
 #define _NVME_KEYRING_H
 
-#ifdef CONFIG_NVME_KEYRING
+#if IS_ENABLED(CONFIG_NVME_KEYRING)
 
 key_serial_t nvme_tls_psk_default(struct key *keyring,
 		const char *hostnqn, const char *subnqn);
 
 key_serial_t nvme_keyring_id(void);
-int nvme_keyring_init(void);
-void nvme_keyring_exit(void);
 
 #else
 
@@ -26,11 +24,6 @@ static inline key_serial_t nvme_keyring_id(void)
 {
 	return 0;
 }
-static inline int nvme_keyring_init(void)
-{
-	return 0;
-}
-static inline void nvme_keyring_exit(void) {}
 
 #endif /* !CONFIG_NVME_KEYRING */
 #endif /* _NVME_KEYRING_H */
@@ -6,14 +6,12 @@
 #ifndef _NVME_KEYRING_H
 #define _NVME_KEYRING_H
 
-#ifdef CONFIG_NVME_KEYRING
+#if IS_ENABLED(CONFIG_NVME_KEYRING)
 
 key_serial_t nvme_tls_psk_default(struct key *keyring,
 		const char *hostnqn, const char *subnqn);
 
 key_serial_t nvme_keyring_id(void);
-int nvme_keyring_init(void);
-void nvme_keyring_exit(void);
 
 #else
 
@@ -26,11 +24,6 @@ static inline key_serial_t nvme_keyring_id(void)
 {
 	return 0;
 }
-static inline int nvme_keyring_init(void)
-{
-	return 0;
-}
-static inline void nvme_keyring_exit(void) {}
 
 #endif /* !CONFIG_NVME_KEYRING */
 #endif /* _NVME_KEYRING_H */
--

