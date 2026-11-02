Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51B18606A329
	for <linux-nvme@archiver.kernel.org>; Mon,  2 Nov 2026 06:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=dopvthTj;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MH+hDoZm
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=yvkaHxUFeoQ+jmjBqSWlq1SPU8ga5OsgviDcj2uQ4Lk=; b=dopvthTj9C/1sS
	59IZtgIy2T1QCNZhhCfnS8O0WdfyfIJm49X+yvcdOoEdx/jK+piDqbVImU61+Baxej9eAD9IjdC0d
	efi9u92Tp+A1q9gXHTrTqFIJQwV29ULYyNB0TfD/qD3xIr9tJMmC/3dJLKp2H65fD3uRL1gB+hHPS
	fEvJoBPUl2id7topJyt4dbzL3Ma6wlGwmx4EvEEI6lyvAKz/rvtD++HhY4KliVcNxhm5Wv+Oa6Arl
	QkP3NuBFsNNuh6uEdcTDWe9vMi85wpbOfK+Q9WXiIjOA8PYQSiOrjVU6nx/W/X/+xl/XOzKtLYWZT
	Vs3BH6GctCRjuPzJvlVA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xNlJg-0000000FdEz-030W;
	Mon, 02 Nov 2026 06:14:48 +0000
Received: from mail-dl1-x1230.google.com ([2607:f8b0:4864:20::1230])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xNlJd-0000000FdDn-3GHN
	for linux-nvme@lists.infradead.org;
	Mon, 02 Nov 2026 06:14:46 +0000
Received: by mail-dl1-x1230.google.com with SMTP id a92af1059eb24-1931ff67a29so4701306c88.1
        for <linux-nvme@lists.infradead.org>; Sun, 01 Nov 2026 22:14:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793600085; x=1794204885; darn=lists.infradead.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yvkaHxUFeoQ+jmjBqSWlq1SPU8ga5OsgviDcj2uQ4Lk=;
        b=MH+hDoZmwnHuoeilnBrCJDgxp+1jipHPHQmIzRO1jRS1+JEuRSsAFdGuoAp82dBRLV
         h/WxCsOLqSjb5uxEVeXugjAWwjsEHEUHoc+sakxXw1JArlOiYUz2b7XZkNIUSup/cpIU
         Va/i0qQWNj/nJ2fSjFruvhTol5sYIw4LINi5mJ4Ixtvhu5J3mi7Aloxzag38HlrfjvmC
         miqp2BG1ll1eGmiEzNdEKbgCJuEjhIUHSplImzzqTypte934gsK0BsfMQt0ygLnhHa1Q
         355BX+uPz1krmfpnrKG9vWMAJdYdHPoBDx4H1BNyn1sy9m5ZqhO5UsxGKL+x8w0Bs//r
         LfGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793600085; x=1794204885;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yvkaHxUFeoQ+jmjBqSWlq1SPU8ga5OsgviDcj2uQ4Lk=;
        b=WHPxXmXR23pM99RhJcJPQWTNzMjTEzDtK9tWS9pZWsVTui+3yQprfhv91Yw52Npayx
         t+bhFnNOn468EPmYPsrBeKcnWq3cmz4tppcX4ozJ5cl9cx7MdRh3eHpJYNOxeC8ZUpRc
         l0VI3oEaC6pZOKT3Klh5fzOzM6EfhgA+4k79Em439jLJ/5oid3yt/+L4HQaBmKJVYfOV
         mg09h+SzKpjN0x8+7u+elKr/QAwwt3oF5tCvGhmBJ/AcZcVqpoKkQhrzwlGKE8oeKNN/
         8Xf9aX8pht1cipRzuyeKd/7sgdTe35eCixxzUMRTpABcZgoPrqS/dprU022b1UiP0D36
         Ca1A==
X-Gm-Message-State: AFq9FYKQ3dLxZd9ydqNKfiJpRB0AW5hMPDnJTwNWOqgf1j9sVul3/oOT
	MObprx7XCsiJCQ7dKjnpjjX1jhowt+Dm5IyeA8vwQBu5aiNlv0//I/kCObo0jhUAL+Q=
X-Gm-Gg: AYBFou1m/i2V8TlUVeMTQfrsTn9nU8GK4HIAPTpMmNgbuAxPXcYmI3Iwlt3rASs1uh9
	q/Hzf3R7RPslWB3KFOzkwLU2a6IB8wbPtPEU9C7GO2rueBv6B1tDzaGw36ZetxXGHRLgFW33Wh5
	f92yipnfeAZUxzx1X4Gat/EypGx898X7om6gS392vUCbtc9E7j5bP2QFQs45synfVNasKGxtRXp
	IKXr2Q5yv3jh3X2oQ5D6HnfIz+4/II7cQDTgLolBbql+RF30v5OePQXkR2XJO/pfQ0fRBcdBnSR
	5BHboDfJkGrzb0Uy1wJbRkTMIh+tkVx4L+Xxa3SQzpFIWo7bhKrmztekk5CewW7VqIMeHxMdivO
	6DliuqFQoFSQs+tEfNxoJKbtLHnuYROy4Ur+TKSk9mxC6mVnxvdccP8InR2rW4LPLqfsw/vx/NA
	V2jttfRcUt4tGb2xwxl/0F7JSBRezJGkoKFGOt1UOJSZyADWYLK6q++zsdVy1FCcnQPlVq4FjA4
	9IkdatocHDIo9ohjt1l4MtiwRcsdU7kcpccovoSHWfXEH5zcOOpZuDNJG5TPMFjQZKzBqLQfCpE
	m/YaMxad1wi7wpzRxlWpUvad/w==
X-Received: by 2002:a05:701b:260c:b0:1ac:9ecb:acee with SMTP id a92af1059eb24-1ac9ecbb353mr11878942c88.39.1793600084805;
        Sun, 01 Nov 2026 22:14:44 -0800 (PST)
Received: from [127.0.1.1] ([23.254.208.9])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1ac19c6b969sm30288043c88.14.2026.11.01.22.14.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 22:14:44 -0800 (PST)
From: Qiliang Yuan <odys.yuan@gmail.com>
Date: Mon, 02 Nov 2026 01:14:36 -0500
Subject: [PATCH 1/2] nvme: remove namespaces in parallel
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261102-bug-nvme-remove-ns-async-v1-1-61780fee111c@gmail.com>
References: <20261102-bug-nvme-remove-ns-async-v1-0-61780fee111c@gmail.com>
In-Reply-To: <20261102-bug-nvme-remove-ns-async-v1-0-61780fee111c@gmail.com>
To: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-block@vger.kernel.org, Ming Lei <tom.leiming@gmail.com>, 
 Nilay Shroff <nilay@linux.ibm.com>, 
 Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>, 
 Stuart Hayes <stuart.w.hayes@gmail.com>, Qiliang Yuan <odys.yuan@gmail.com>
X-Mailer: b4 0.13.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261101_221445_821103_E4F78F15 
X-CRM114-Status: GOOD (  15.55  )
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

nvme_remove_namespaces() removes the namespaces of a controller one
after another. Each removal waits for RCU grace periods in
del_gendisk() for the namespace and for its multipath head, about
20 ms in all.

Deleting a controller, such as disconnecting from a fabrics target,
thus takes time proportional to its namespace count, over a second for
64 namespaces. Scanning had the same problem until commit 4e893ca81170
("nvme_core: scan namespaces asynchronously") made it add namespaces
in parallel.

Remove the namespaces through an async domain the same way, and wait
for all of them before returning.

Disconnect time from a target on the same host, over tcp to 127.0.0.1
and over nvme-loop, with 4 I/O queues, median of 3 runs on each of two
boots per kernel:

  namespaces  transport  before              after
           8  tcp         170 /  171 ms        85 /   91 ms
          32  tcp         628 /  628 ms       294 /  293 ms
          64  tcp        1201 / 1308 ms       533 /  550 ms
          64  loop       1988 / 1913 ms      1283 / 1200 ms

Signed-off-by: Qiliang Yuan <odys.yuan@gmail.com>
---
 drivers/nvme/host/core.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index a7a4d09644c13..18948c2ba218d 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4716,6 +4716,11 @@ static void nvme_scan_work(struct work_struct *work)
 #endif
 }
 
+static void nvme_ns_remove_async(void *data, async_cookie_t cookie)
+{
+	nvme_ns_remove(data);
+}
+
 /*
  * This function iterates the namespace list unlocked to allow recovery from
  * controller failure. It is up to the caller to ensure the namespace list is
@@ -4725,6 +4730,7 @@ void nvme_remove_namespaces(struct nvme_ctrl *ctrl)
 {
 	struct nvme_ns *ns, *next;
 	LIST_HEAD(ns_list);
+	ASYNC_DOMAIN(domain);
 
 	/*
 	 * make sure to requeue I/O to all namespaces as these
@@ -4759,8 +4765,13 @@ void nvme_remove_namespaces(struct nvme_ctrl *ctrl)
 	mutex_unlock(&ctrl->namespaces_lock);
 	synchronize_srcu(&ctrl->srcu);
 
+	/*
+	 * Remove the namespaces in parallel, as each removal waits for several
+	 * RCU grace periods.
+	 */
 	list_for_each_entry_safe(ns, next, &ns_list, list)
-		nvme_ns_remove(ns);
+		async_schedule_domain(nvme_ns_remove_async, ns, &domain);
+	async_synchronize_full_domain(&domain);
 }
 EXPORT_SYMBOL_GPL(nvme_remove_namespaces);
 

-- 
2.43.0


