Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 550F7C5DF67
	for <linux-nvme@archiver.kernel.org>; Thu, 13 Aug 2026 15:01:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6bzYVrzwmgCxs1BAVE3pg33ZbHvutLaxuLFDziO3j5s=; b=QwXakzDCyt6wN33tOy6W+lFT4C
	TKbny7+kmO7X88ON+DnVJf3KeGHinke++3HpaGsohbIw5gc/mcUA5jFyRPOIWrLqa/js7wo3faqJ5
	AIgL1dqdBKKagiXDOZyh8zgYBSwhjXleMI66ll3GkHxWPcecvKnqseH5zDaCJW1P4BjKrn3WBZJIv
	CKyl8QKggeNlkxr8Ty8/z+lYqDtSykKZuEMct27RYBvr6N6colzk3QMRSkoSFRMJ3ESLXopZjhVAU
	br/zIynac2TByhSP1X6nW9hkDPPxWF1rlsda11Dm7rn22M2706+EPPnLTqsNB4h377J60atAMdJUb
	pHFkha1A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wuWvY-00000000tBl-2RRU;
	Thu, 13 Aug 2026 15:01:04 +0000
Received: from flow-b7-smtp.messagingengine.com ([202.12.124.142])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wtqf5-0000000EhLQ-14ja;
	Tue, 11 Aug 2026 17:53:17 +0000
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailflow.stl.internal (Postfix) with ESMTP id 20E4A130010C;
	Tue, 11 Aug 2026 13:53:13 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Tue, 11 Aug 2026 13:53:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jaseg.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1786470792;
	 x=1786477992; bh=6bzYVrzwmgCxs1BAVE3pg33ZbHvutLaxuLFDziO3j5s=; b=
	bcI27Xgefx7p/5EIJQwftgbpvO5xbhyQvUijxfe5lVDAqyY+fYJfIhKaWs1SId5h
	iCajUTbExspHQ0NmFeIilMuSmDj1HGY8R3StcexlvninnGRbjaIzKRPvh1pfWj0Y
	4N+v43B8Hpn+L7vL2mKr5VKeTR41GSmIMtmxCq6WwGMr5xLi7Kyu2heugjXYdzML
	Moi1BXAQnsWQ7nzy3kEEL+w/qgUSiBueMIBgolB5oKcjc+wZM+NsJdam3isuz/Fz
	LREjp4/GOAq0fFGYJI9yJQkU07vKIGOhe7p+vKrmrn+UgxdGRXPYiDjb5sGDQ6SU
	b8xitavmMV6Bgt7U36KW/A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1786470792; x=
	1786477992; bh=6bzYVrzwmgCxs1BAVE3pg33ZbHvutLaxuLFDziO3j5s=; b=P
	dCNW6xpi1mN3p3koEB0o3OQTpob2y8vaqd5Jw7xtCovcdCiiFZwJTw5E3zAAk8Pk
	t1gmBkV2YjUGRq5wy2UHjKxdGK9npQ3h5CkvPKLKkdOzhJgIVTdvW4cCoOb72P/Y
	StGUUPUW3gY2jl7tciu9f9af0n7PQhyVkzXTBx7FkZ5RnO9EBZUdtJC2kQY8qtsY
	fgmRH4ZE9CjDdXZ5jer4QGRzQuYNDLt5VVYEhK8jBr3zMJOPhQzX2mDyC8IFYeiB
	Wqgl3IsX/eyJofhyg2xCw5hl7Qz0fQWLhqaxOQLc/rBPCzyeuGLvEJkCiuuhJ8PR
	kMNy/jou2hvlE4s71xOKQ==
X-ME-Sender: <xms:iGF7aiu61NAIB8QebsQ52KHNn_nNMTrvOHWNEhpLSeEAs46b7sKxKw>
    <xme:iGF7agT11EMLhD5AFnZZF6M65yV05agW3GuHDyQNW3aDPSXh7ygFFv2k2Wh8Ypy_I
    VSAFRBIVlbxIyrTqqH_pPTNzv30Ow-XaSBZ0dcyBcVfTcY_Gd9e3g>
X-ME-Received: <xmr:iGF7akXYpB3rU0N45TB6PYZ3KjSf6srOrSOHQ8UGMgZPkoWdu3TJh1OMv_BgLvXJSvNXpMzNvZy-OkghN-mligA>
X-ME-Proxy-Cause: dmFkZTEwrH8wfhgctv1ErvL0nhEWRZaXCL40jelDGtxObnm8dQ+WB7ldi7zgGP18fqrN+C
    7xne4qHVB4V9kXTny9F3UzpVvRvOC+vTRbUvHE754Z1otc2eFdFHJmjh2luxatp0pqWwYy
    sRKrXvmGl66/LIjfpMZjwK9kOj46ks+olR0W88tI3sOrJxqKyJcEI0DOFTt1YNjUFLRRyj
    iHYKN+FQnILJq0PWlXi8sHSJU6WpS6NMySRow97FBBcIDr2FI/M1huQ7BdiSPQY9tzBu/P
    Ctv1qfsiGpDZ4DjvEs5TfiMr3xHnr/zYsFyi6aFPQHrx/6AOsIqWNugJkcAhGMC9jATngj
    PsYwLs2afmtUbJFrF9pVWN/ueehFiV4iqe1vK7Uil7dEB1ZoerwVUPSf+EH5Er+YoOKMn/
    bl8akgMI1uL3WWLdOzwKvEEJwRmYYKXvrBGkbESTPvfFFYUjNLj4SGDvyCd1kqNFX3kqtz
    HlR88uWTDziuwE0rFpj3kW5HwsI0yC8CSB84yGGiXKoT+iw1+vCALkSh0ieOMAiE1KMSkA
    C5ZeiquXLwsgm9nTcBQDN+WxS55rWEeuX5UMsECC2BtGAzDPKGiqOR+SeFj/vPoUr01tpr
    TJycXnYh9lfAnJVuJ9hsWPPtO+MKT2bSAZijEeNf6g1jd2G/hPpvETrWGo2w
X-ME-Proxy: <xmx:iGF7aqmoHd9EB0RUBj17pcVXfhfHIJaf-UlkyIS3DNXuHOwiGDNhsA>
    <xmx:iGF7asqQV1HGfsugDyNjZYHYid5QT7JwFNxXPYrd831S0JYGeBVlFg>
    <xmx:iGF7auTnF4YVDh5J3S7Resvx1aOwzVkbQdWlnwWe7GkNkK-cQfmsWw>
    <xmx:iGF7ajUrXLAp1F4bYPYSwQmmiegSLeX3PuTRw13dpWvxVdrpvkvHrg>
    <xmx:iGF7aqYRQScPD_bnRrY2QFIIFIvUTzVpfvrHo3Cowapxz3v_CwJVz0er>
Feedback-ID: i60a14417:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 11 Aug 2026 13:53:06 -0400 (EDT)
From: =?utf-8?q?Jan_Sebastian_G=C3=B6tte?= <linux@jaseg.de>
Date: Tue, 11 Aug 2026 19:52:50 +0200
Subject: [PATCH v2 01/13] kexec: add CRASH_WIPE_SECRETS to wipe secrets
 before kdump
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260811-crash-zeroize-rework-v2-1-9561d13c2340@jaseg.de>
References: <20260811-crash-zeroize-rework-v2-0-9561d13c2340@jaseg.de>
In-Reply-To: <20260811-crash-zeroize-rework-v2-0-9561d13c2340@jaseg.de>
To: Andrew Morton <akpm@linux-foundation.org>,
  Baoquan He <baoquan.he@linux.dev>, Mike Rapoport <rppt@kernel.org>,
  Pasha Tatashin <pasha.tatashin@soleen.com>,
  Pratyush Yadav <pratyush@kernel.org>,
 Dave Young <ruirui.yang@linux.dev>,
  Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>,  David Howells <dhowells@redhat.com>,
 Jarkko Sakkinen <jarkko@kernel.org>,  Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>,
  Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
  "Serge E. Hallyn" <serge@hallyn.com>, Lukas Wunner <lukas@wunner.de>,
  Ignat Korchagin <ignat@linux.win>,
 Herbert Xu <herbert@gondor.apana.org.au>,
  "David S. Miller" <davem@davemloft.net>,
 Keith Busch <kbusch@kernel.org>,  Jens Axboe <axboe@kernel.dk>,
 Christoph Hellwig <hch@lst.de>,  Sagi Grimberg <sagi@grimberg.me>,
 Trond Myklebust <trondmy@kernel.org>,  Anna Schumaker <anna@kernel.org>,
 Mimi Zohar <zohar@linux.ibm.com>,
  James Bottomley <James.Bottomley@HansenPartnership.com>,
  Marc Dionne <marc.dionne@auristor.com>,
 Eric Dumazet <edumazet@google.com>,  Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,  Simon Horman <horms@kernel.org>,
 Eric Biggers <ebiggers@kernel.org>,  "Theodore Y. Ts'o" <tytso@mit.edu>,
 Jaegeuk Kim <jaegeuk@kernel.org>,
  Alexander Viro <viro@zeniv.linux.org.uk>,
  Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
  Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>,
  Mikulas Patocka <mpatocka@redhat.com>,
  Benjamin Marzinski <bmarzins@redhat.com>
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org, 
 keyrings@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-security-module@vger.kernel.org, linux-crypto@vger.kernel.org, 
 linux-nvme@lists.infradead.org, linux-nfs@vger.kernel.org, 
 linux-integrity@vger.kernel.org, linux-afs@lists.infradead.org, 
 netdev@vger.kernel.org, linux-fscrypt@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, dm-devel@lists.linux.dev, 
 =?utf-8?q?Jan_Sebastian_G=C3=B6tte?= <linux@jaseg.de>
X-Mailer: b4 0.15.2
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260811_105315_341512_382FEEDB 
X-CRM114-Status: GOOD (  18.83  )
X-Mailman-Approved-At: Thu, 13 Aug 2026 08:01:01 -0700
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

When kdump is used to capture system memory after a panic(), any secret
keys currently in RAM end up in the dump. Add an opt-in atomic notifier
chain, crash_wipe_secrets_notifier_list, invoked late into
__crash_kexec(). Subsystems holding secrets can register a callback to
wipe them.

Callbacks are run after machine_crash_shutdown() has already stopped the
other CPUs and disabled preemption. Callbacks must not wait on locks,
which will never be released.

This is a best-effort, defence-in-depth measure, not a guarantee.
Secrets in flight on the stack, in registers, in DMA buffers, or in
other places in memory are out of scope.

Signed-off-by: Jan Sebastian Götte <linux@jaseg.de>
---
 include/linux/crash_core.h | 16 ++++++++++++++++
 kernel/Kconfig.kexec       | 16 ++++++++++++++++
 kernel/crash_core.c        | 29 +++++++++++++++++++++++++++++
 3 files changed, 61 insertions(+)

diff --git a/include/linux/crash_core.h b/include/linux/crash_core.h
index bc087124cd78..4230463f3faa 100644
--- a/include/linux/crash_core.h
+++ b/include/linux/crash_core.h
@@ -5,6 +5,7 @@
 #include <linux/linkage.h>
 #include <linux/elfcore.h>
 #include <linux/elf.h>
+#include <linux/notifier.h>
 
 struct kimage;
 
@@ -34,6 +35,21 @@ static inline void arch_kexec_protect_crashkres(void) { }
 static inline void arch_kexec_unprotect_crashkres(void) { }
 #endif
 
+#ifdef CONFIG_CRASH_WIPE_SECRETS
+int crash_wipe_secrets_register(struct notifier_block *nb);
+int crash_wipe_secrets_unregister(struct notifier_block *nb);
+#else
+static inline int crash_wipe_secrets_register(struct notifier_block *nb)
+{
+	return 0;
+}
+
+static inline int crash_wipe_secrets_unregister(struct notifier_block *nb)
+{
+	return 0;
+}
+#endif
+
 #ifndef arch_crash_handle_hotplug_event
 static inline void arch_crash_handle_hotplug_event(struct kimage *image, void *arg) { }
 #endif
diff --git a/kernel/Kconfig.kexec b/kernel/Kconfig.kexec
index 15632358bcf7..1d2d273145df 100644
--- a/kernel/Kconfig.kexec
+++ b/kernel/Kconfig.kexec
@@ -179,4 +179,20 @@ config CRASH_MAX_MEMORY_RANGES
 	  the computation behind the value provided through the
 	  /sys/kernel/crash_elfcorehdr_size attribute.
 
+config CRASH_WIPE_SECRETS
+	bool "Wipe secrets before kdump"
+	depends on CRASH_DUMP
+	help
+	  Wipe secrets (e.g. kernel keyring and memfd_secret pages) on crash or
+	  panic. This is a best effort, defense-in-depth feature: If the panic
+	  happens at a really bad time, or if copies of the secrets are present
+	  in places like on the stack, in I/O buffers, or in userspace memory
+	  not allocated through memfd_secret, they may still be leaked.
+
+	  Note that enabling this feature carries some risk of crashing the
+	  system during the wipe process if the kernel was already unstable
+	  when the panic happened.
+
+	  If unsure, say N.
+
 endmenu
diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index 2b36aa9fade0..95f5c0415e60 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -23,6 +23,7 @@
 #include <linux/objtool.h>
 #include <linux/delay.h>
 #include <linux/panic.h>
+#include <linux/timekeeping.h>
 
 #include <asm/page.h>
 #include <asm/sections.h>
@@ -33,6 +34,33 @@
 /* Per cpu memory for storing cpu states in case of system crash. */
 note_buf_t __percpu *crash_notes;
 
+#ifdef CONFIG_CRASH_WIPE_SECRETS
+ATOMIC_NOTIFIER_HEAD(crash_wipe_secrets_notifier_list);
+
+int crash_wipe_secrets_register(struct notifier_block *nb)
+{
+	return atomic_notifier_chain_register(
+			&crash_wipe_secrets_notifier_list, nb);
+}
+EXPORT_SYMBOL_GPL(crash_wipe_secrets_register);
+
+int crash_wipe_secrets_unregister(struct notifier_block *nb)
+{
+	return atomic_notifier_chain_unregister(
+			&crash_wipe_secrets_notifier_list, nb);
+}
+EXPORT_SYMBOL_GPL(crash_wipe_secrets_unregister);
+
+static void crash_wipe_secrets(void)
+{
+	pr_info("Wiping sensitive secrets...\n");
+	atomic_notifier_call_chain(&crash_wipe_secrets_notifier_list, 0, NULL);
+	pr_info("Done wiping secrets.\n");
+}
+#else
+static inline void crash_wipe_secrets(void) { }
+#endif /* CONFIG_CRASH_WIPE_SECRETS */
+
 /* time to wait for possible DMA to finish before starting the kdump kernel
  * when a CMA reservation is used
  */
@@ -142,6 +170,7 @@ void __noclone __crash_kexec(struct pt_regs *regs)
 			crash_save_vmcoreinfo();
 			machine_crash_shutdown(&fixed_regs);
 			crash_cma_clear_pending_dma();
+			crash_wipe_secrets();
 			machine_kexec(kexec_crash_image);
 		}
 		kexec_unlock();

-- 
2.53.0


