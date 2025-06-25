Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B78DBC7EE32
	for <linux-nvme@archiver.kernel.org>; Wed, 25 Jun 2025 20:37:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Ii7F3KTd50OP4ELYVVkfKIFESVbr68GqYZUwUTPpVR4=; b=LHdXl5U6nzgtaSNH+xh9lk9Zrd
	vaq/Ucj/yagvwy9fFM99xs9q77FOo9Wkpu2hm9zjjJMe1Xx0Tm5A0ajo1br5bgNHNtPDkx8lne2xY
	czVS67d51KJgVU6gi0xlHLIkoRrHlX9uFkzqRzm6hIhR5nW3FMPeQeldEa4Ltn14TRXWToSHiNdFN
	4jjuryc0Pjl2m4Lijnjqs1or3lEL784Aqqta6pygfk0KVS64HDfeKCKHpNNzZg0FP0Hfhvx8N/SOz
	NsQb9UMw4AgYsXSUzLUWsyT4DKhlnEddzvcUhakEDYoG+UJTYP8RbzCe5ckbR4SZE38M8Qu8+RnuY
	vBVJwi+A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uUWrr-00000009tE0-0WxR;
	Wed, 25 Jun 2025 20:37:15 +0000
Received: from mail-oi1-x231.google.com ([2607:f8b0:4864:20::231])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uUWaM-00000009p7b-3Wya
	for linux-nvme@lists.infradead.org;
	Wed, 25 Jun 2025 20:19:15 +0000
Received: by mail-oi1-x231.google.com with SMTP id 5614622812f47-407a6c6a6d4so126656b6e.1
        for <linux-nvme@lists.infradead.org>; Wed, 25 Jun 2025 13:19:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750882750; x=1751487550; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ii7F3KTd50OP4ELYVVkfKIFESVbr68GqYZUwUTPpVR4=;
        b=Kyz4T7Hyotsxm87oSiN1rJsQn9bvRlRAFeE/olDXd9ow1CH+uSCipEnf1YttYg9u/Q
         m+qXuMqTsNPHN3vD0iQTpkHyexJbGT5pkseWJgJbagVD979qX+XmpOWaNK4vKUx8h/Sf
         3NW3YcnTZ33RpSpktsiUTqWfsawXHzZxJQjDJuI1cgV/lm94r4X+ncOLW4qy+0cGhIl8
         feL/6eo0fRwshW5Rpkv+djoRHgga3nvkqTbqhO9QswjhDvT7ZryUunoGlby4CnJoQG3O
         MwM8y8aQbzKj5Yh2PmoGoMm0uMEw3/if3FALw6BF/cKgax9dT0MDMH7yCmv6dW/6BHiW
         j+ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750882750; x=1751487550;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ii7F3KTd50OP4ELYVVkfKIFESVbr68GqYZUwUTPpVR4=;
        b=nueCIJjkEoCB5zCqkBV35PThaqQhw42T3W3534lGYaq215gY5LHTIRHILV4Q/qHHiQ
         L0EMltTr36oksc6610R5bYCiaarsMKpSRwZhqfiM5C7qnoASk6YmvcsM85T5i4jPhq8d
         U2vo7ejonjcR8S6FKnBhdkX92ogpgTSXbJWdsZMjeGZ0GpYd3gl1eOcWsYvdw2FZhTQa
         A4nrDEypfTWwSFIjZ6kT6rSDsFTFdpGRCyRtOuePFjkqsOPVjsd64+uKJWR+MDTEsvTr
         zW4BMD4ZnblQBCWHVVTO8fxrRqY1UtP556SP1mDb9I/sKdFftCZ4KCvVMtEVjY1gG0l/
         293g==
X-Forwarded-Encrypted: i=1; AJvYcCXiSkzqVJbB2Y/IfJeeDSW71eL8pyLfFPEAGTjkzu0l5ufYlD4fwIMWzU89ObNpZu62dewGkl6LIMsH@lists.infradead.org
X-Gm-Message-State: AOJu0YyJlPAk/FUA+N5XaUgv17m8VqmwZsTA/j+3hxzZUgAEe47a5bdm
	mgu7aSqsXz6ImzGh7Mtdr74/4BTfGTa6iFey9NOHgT6Y1oPuESL3ZZ7l
X-Gm-Gg: ASbGncuCD40WAbS73Z5jJ54lJIR+7jA7yNUA1v5CPCuHqsA0t7n9Iy9IDgVw7Gzh7mu
	TWsHjgNyYRakErvfkvWJQ3doNS4DKm+vTG4OQrKTfLgldY+nFBRxKVW9dRv0FoEQY+qu3va4ZRq
	aA00ucNqqIHBjRmFJcMBNDGgJgeTiuqrps+9Hk/u+deetLfkevlAVjmdys14R4YvgAxd92O4d/M
	PvMCCIZxWkNgabUYNT3S4+UwY9AgwC2WWiSoYcTjGxPd1I6Rmd3ppEwN72dOyznpmAePWI0/ayA
	hMKUVbIMBlG5l/66bEFJbsJ3gnrVodGaEGcDQ0omytcup57UWHj7x4NAKkRv8Qd+ZIQW5db1Fpt
	O76DJaRQ=
X-Google-Smtp-Source: AGHT+IGEZJwCIISdIXRvS1gnBkGMKpKYrYU/Oz1NxYRz4ecK56zRfo/tvDDixdQKK2GCSXYcSwb2ng==
X-Received: by 2002:a05:6808:2001:b0:408:e68d:975a with SMTP id 5614622812f47-40b05a11227mr3693289b6e.39.1750882749745;
        Wed, 25 Jun 2025 13:19:09 -0700 (PDT)
Received: from localhost.localdomain ([143.166.81.254])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-40ac6d22c23sm2319188b6e.42.2025.06.25.13.19.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 13:19:09 -0700 (PDT)
From: Stuart Hayes <stuart.w.hayes@gmail.com>
To: linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Martin Belanger <Martin.Belanger@dell.com>,
	Oliver O'Halloran <oohall@gmail.com>,
	Daniel Wagner <dwagner@suse.de>,
	Keith Busch <kbusch@kernel.org>,
	Lukas Wunner <lukas@wunner.de>,
	David Jeffery <djeffery@redhat.com>,
	Jeremy Allison <jallison@ciq.com>,
	Jens Axboe <axboe@fb.com>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org,
	Nathan Chancellor <nathan@kernel.org>,
	Jan Kiszka <jan.kiszka@seimens.com>,
	Bert Karwatzki <spasswolf@web.de>
Cc: Stuart Hayes <stuart.w.hayes@gmail.com>
Subject: [PATCH v10 1/5] kernel/async: streamline cookie synchronization
Date: Wed, 25 Jun 2025 15:18:49 -0500
Message-Id: <20250625201853.84062-2-stuart.w.hayes@gmail.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20250625201853.84062-1-stuart.w.hayes@gmail.com>
References: <20250625201853.84062-1-stuart.w.hayes@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250625_131910_885443_F9268FD2 
X-CRM114-Status: GOOD (  16.20  )
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

From: David Jeffery <djeffery@redhat.com>

To prevent a thundering herd effect, implement a custom wake function for
the async shubsystem which will only wake waiters which have all their
dependencies completed.

The async subsystem currently wakes all waiters on async_done when an async
task completes. When there are many tasks trying to synchronize on differnt
async values, this can create a thundering herd problem when an async task
wakes up all waiters, most of whom go back to waiting after causing
lock contention and wasting CPU.

Signed-off-by: David Jeffery <djeffery@redhat.com>
Signed-off-by: Stuart Hayes <stuart.w.hayes@gmail.com>
---
 kernel/async.c | 42 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 41 insertions(+), 1 deletion(-)

diff --git a/kernel/async.c b/kernel/async.c
index 4c3e6a44595f..ae327f29bac9 100644
--- a/kernel/async.c
+++ b/kernel/async.c
@@ -76,6 +76,12 @@ struct async_entry {
 	struct async_domain	*domain;
 };
 
+struct async_wait_entry {
+	wait_queue_entry_t wait;
+	async_cookie_t cookie;
+	struct async_domain *domain;
+};
+
 static DECLARE_WAIT_QUEUE_HEAD(async_done);
 
 static atomic_t entry_count;
@@ -298,6 +304,24 @@ void async_synchronize_full_domain(struct async_domain *domain)
 }
 EXPORT_SYMBOL_GPL(async_synchronize_full_domain);
 
+/**
+ * async_domain_wake_function - wait function for cooking synchronization
+ *
+ * Custom wait function for async_synchronize_cookie_domain to check cookie
+ * value.  This prevents waking up waiting threads unnecessarily.
+ */
+static int async_domain_wake_function(struct wait_queue_entry *wait,
+				      unsigned int mode, int sync, void *key)
+{
+	struct async_wait_entry *await =
+		container_of(wait, struct async_wait_entry, wait);
+
+	if (lowest_in_progress(await->domain) < await->cookie)
+		return 0;
+
+	return autoremove_wake_function(wait, mode, sync, key);
+}
+
 /**
  * async_synchronize_cookie_domain - synchronize asynchronous function calls within a certain domain with cookie checkpointing
  * @cookie: async_cookie_t to use as checkpoint
@@ -310,11 +334,27 @@ EXPORT_SYMBOL_GPL(async_synchronize_full_domain);
 void async_synchronize_cookie_domain(async_cookie_t cookie, struct async_domain *domain)
 {
 	ktime_t starttime;
+	struct async_wait_entry await = {
+		.cookie = cookie,
+		.domain = domain,
+		.wait = {
+			.func = async_domain_wake_function,
+			.private = current,
+			.flags = 0,
+			.entry = LIST_HEAD_INIT(await.wait.entry),
+		}};
 
 	pr_debug("async_waiting @ %i\n", task_pid_nr(current));
 	starttime = ktime_get();
 
-	wait_event(async_done, lowest_in_progress(domain) >= cookie);
+	for (;;) {
+		prepare_to_wait(&async_done, &await.wait, TASK_UNINTERRUPTIBLE);
+
+		if (lowest_in_progress(domain) >= cookie)
+			break;
+		schedule();
+	}
+	finish_wait(&async_done, &await.wait);
 
 	pr_debug("async_continuing @ %i after %lli usec\n", task_pid_nr(current),
 		 microseconds_since(starttime));
-- 
2.39.3


