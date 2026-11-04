Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01875606A31B
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Nov 2026 06:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=B8KaqoMk;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=O57jyWwg
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=nxObPTj/uIUEGHfeQ9adXhEvppId2c7V0+NPSeSoNZI=; b=B8KaqoMkw90IkT
	8YXkHv4TenfL3C/4+LYI+rqw/w/w87MCMgweb5jEzcD2VNCbbQIczcac+zrodf04InnOZKpg9hKIY
	DYJ0JLlk4JcTPt7/D5vthMiXreRw4sOprHd4NT2YxT6k30dEhwCJjVMxlkjNd8bCmxJiADAi9qknT
	hv/9v7IBFaTFL3q/oTr4YdlFyHGJ6Q5WhxpY4s+IAiLXjLD8Vlq27rntvZJAwJcS0nbbgBqrdTbKb
	EdCiI1SdECsm5IVZ3jBhinGGgas+IKTTgg/+Lus7dTY6JDFtX7s6GCgWATexwCEd7OmkMA1HlwJcI
	L8SltF7mtRFGnB5uWlfw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOUWV-00000004Q7i-1MkP;
	Wed, 04 Nov 2026 06:31:03 +0000
Received: from mail-dl1-x122a.google.com ([2607:f8b0:4864:20::122a])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOUWM-00000004Q1y-30cr
	for linux-nvme@lists.infradead.org;
	Wed, 04 Nov 2026 06:31:02 +0000
Received: by mail-dl1-x122a.google.com with SMTP id a92af1059eb24-1b1ce85287aso363058c88.0
        for <linux-nvme@lists.infradead.org>; Tue, 03 Nov 2026 22:30:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793773854; x=1794378654; darn=lists.infradead.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nxObPTj/uIUEGHfeQ9adXhEvppId2c7V0+NPSeSoNZI=;
        b=O57jyWwgNNdPx0JA5Y1iuBwrIn/lGaXTLFCr4nBih79wXCbOUH2XrG5KgsecKdtMVj
         BPSpQSLysXHRlasof1oRAGAEIgAWR1mDzBRfBXLNcOuD2cQrpztJjE5mC62aGRhZaJGW
         K0383y+N4h/yKvVgbV+eClqzZiWLX/qd1t5EK5uQRntVWA+aUkF+V5l3rVTjk/5gVkuc
         fgNQKmISEDW+k8VmDo/YrKFe+5nxR5nd26C3WdQ8CwwIm548YCeUkf0Fwy8MYeVqOr8W
         snJgmaJSZYgnlBZKptEv390oz2Bb9zxQpR8dE3UiEej9wne32pKUS77uXWlE7UoRt0Hv
         B6MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793773854; x=1794378654;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nxObPTj/uIUEGHfeQ9adXhEvppId2c7V0+NPSeSoNZI=;
        b=C9cBNMLOjebL1eG9h1TgRtGJMeQmkCNzlonCE3YjPx2Nvp1ArD7U7Gn94SAHyLf6+L
         gS4zRbBJkmWsTEDdRrbtU6OrRP1bo/C4XrojeYPXX49tjNFcsmubx5lj3rMtn3CXJTP/
         f4imldBNEb7SRVdtlh0hXjCt04CjqsdmeTHl4Nr/wYp6M5kwzRNMLEKKMGjbBUdHZXEd
         vbij8Hb3SsfkWuzv5TnNT6AuLz2HIl749dyc6Y6AscxmCyNZf6Umd9WX1ckSxMliSc8F
         iPWU7w3c3y6u5d65YsHK3NXjlqRgDu7k2W6td1UzUUTiuFOauHHVw+KMx7YkOPy+ZHK7
         H+Tw==
X-Gm-Message-State: APuU4Z98MzSPRtdGPXt05JhVIyup1O+xVy+IzLyiyG3uy7e7t2v2NEnh
	N7chrMqNxTkgmeKaUlTvVawmcM4xjb+v78sDgNO+lFPgzwBROKuYcYyl
X-Gm-Gg: AYBFou2urOxNrKyGKEoCVXXvMlt0cDiUN6FgMG/G8GH7tw5m5zsN80/1plzCvpLSXHX
	3TB+eX6bbqutgcpirFQ9iBBDSZUyMrJoQIiaQQaxnrUr8oIurlK23ZWLAMVdIJvDGCAs8fnm15H
	1lJnkXnRePm2J1587MkivuahyKN/dh7+yGTX/o0Xd6CnhKbIIFGsYktFo7iyPfOg9jXHMz2TNEZ
	ZZjd8iPCwhD06ZxNoAnXii9V/rw5YjIGMDTYNVyz7ObB5VC3LR6RGYpLutNBqsvYtcGe2kXWI+q
	ioYQ0QIURDfdrqpTuE04AJGIe3RASBLeuWpgHouZ7B2ZPM9cx575XoBPTYLVw/FvjA0Qp41hApQ
	Run+3IP4XPF59ad9x7KLtx3sAjK0C+SQjAcQw0q+sqsMEKIhuwhkKhG4TEYphP/xMKj/Pj/FKOk
	jBiI1PLtLLjAOprq/1Zcu9ELgDW8YtkWcqRhBgSLrtmufwTI4FThzAkpo2MGzxoMIVCsL+3U6vf
	LzBBZQjUuaJjSXk72sdHZRaSRL/hwjgFwoy43bnVhhL5AgahF8Ks2KNvoSXilpT1utuhZJQiBGp
	1fOdXb6/dv8/CSsmKqhf3MXl
X-Received: by 2002:a05:701b:455a:10b0:1b2:42ae:94fb with SMTP id a92af1059eb24-1b242ae963dmr4316991c88.37.1793773853561;
        Tue, 03 Nov 2026 22:30:53 -0800 (PST)
Received: from [127.0.1.1] ([23.254.208.9])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b245c65194sm4454290c88.19.2026.11.03.22.30.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 22:30:53 -0800 (PST)
From: Qiliang Yuan <odys.yuan@gmail.com>
Date: Wed, 04 Nov 2026 01:30:39 -0500
Subject: [PATCH v2 1/2] srcu: Add list_splice_init_srcu()
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261104-bug-nvme-remove-ns-srcu-v2-1-feb64ecb96ca@gmail.com>
References: <20261104-bug-nvme-remove-ns-srcu-v2-0-feb64ecb96ca@gmail.com>
In-Reply-To: <20261104-bug-nvme-remove-ns-srcu-v2-0-feb64ecb96ca@gmail.com>
To: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
 Lai Jiangshan <jiangshanlai@gmail.com>, 
 "Paul E. McKenney" <paulmck@kernel.org>, 
 Josh Triplett <josh@joshtriplett.org>, 
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
 rcu@vger.kernel.org, Qiliang Yuan <odys.yuan@gmail.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.13.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261103_223054_783004_A660254C 
X-CRM114-Status: GOOD (  19.11  )
X-Spam-Score: -2.1 (--)
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

list_splice_init_rcu() makes a list look empty to new readers, waits for
the current ones with the given sync function, and only then links the
entries into the new list. The sync function takes no argument, so it
can wait for RCU readers but not for the readers of an srcu_struct.

Passing synchronize_rcu() for a list read under SRCU still builds, but
leaves SRCU readers on the entries while the last one's next pointer is
moved onto the new list head. nvme_remove_namespaces() does this today.

Add list_splice_init_srcu(), which waits for the readers of the given
srcu_struct instead.

Cc: stable@vger.kernel.org
Suggested-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Qiliang Yuan <odys.yuan@gmail.com>
---
 include/linux/srcu.h | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/include/linux/srcu.h b/include/linux/srcu.h
index 1a8a465a5650d..d4dcaeb83e2b6 100644
--- a/include/linux/srcu.h
+++ b/include/linux/srcu.h
@@ -18,6 +18,7 @@
 
 #include <linux/mutex.h>
 #include <linux/rcupdate.h>
+#include <linux/rculist.h>
 #include <linux/workqueue.h>
 #include <linux/rcu_segcblist.h>
 
@@ -118,6 +119,41 @@ void cleanup_srcu_struct(struct srcu_struct *ssp);
 void synchronize_srcu(struct srcu_struct *ssp);
 void synchronize_srcu_atomic(struct srcu_struct *ssp);
 
+/**
+ * list_splice_init_srcu - splice an SRCU-protected list into an existing list
+ * @list:	the SRCU-protected list to splice
+ * @head:	the place in the existing list to splice the first list into
+ * @ssp:	the srcu_struct that readers of @list use
+ *
+ * Like list_splice_init_rcu(), but wait for the SRCU readers of @list
+ * instead of RCU ones, so that none of them can follow a next pointer
+ * onto @head.
+ *
+ * Note that this function blocks, and that the caller must prevent any
+ * other updates to @list.
+ */
+static inline void list_splice_init_srcu(struct list_head *list,
+					 struct list_head *head,
+					 struct srcu_struct *ssp)
+{
+	struct list_head *first = list->next;
+	struct list_head *last = list->prev;
+	struct list_head *next = head->next;
+
+	if (list_empty(list))
+		return;
+
+	INIT_LIST_HEAD_RCU(list);
+	synchronize_srcu(ssp);
+	ASSERT_EXCLUSIVE_ACCESS(*first);
+	ASSERT_EXCLUSIVE_ACCESS(*last);
+
+	last->next = next;
+	rcu_assign_pointer(list_next_rcu(head), first);
+	first->prev = head;
+	next->prev = last;
+}
+
 #define SRCU_GET_STATE_COMPLETED 0x1
 
 /**

-- 
2.43.0


