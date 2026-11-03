Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EC49606A329
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Nov 2026 06:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=w0GovCB5;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vx62f5Fi
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Unsubscribe-Post:List-Owner;
	bh=iFbLP8rEml3d1ZY+239sLeSasqkGxTGMtsL3D+TgbaY=; b=w0GovCB52X13FXmTIbMSKYUZH2
	83DkBvMxmzvJFc34Jn1vM4NYkl43wkO5A84FE2wCZlqRr129Pv7lZVkMULdoUO6+U0DuL4/HP++5P
	pmcrsLrP5cKSxI164aPEjpRMUQNTnkJZ0ki6n3drebuAEVGxTqZrKfKUqL/NDTtuidy1rzMHhAqJy
	Wm9zIWteQgH+nb+xVSudV4sqIw/1oIXO9HNiYop/eZy3ljx4Nm4I9NcoZ9RzO+ydQ3DmhwmBg5fWE
	+ojfXnMIvzWiX1IwYoj2DHncMSsjglxuz/KHT7PTSe/TasmJKgm7vkfZETpPJ7tCKbtUwcjN9GPIV
	+9aQBetA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xO80C-00000001FEb-0vLR;
	Tue, 03 Nov 2026 06:28:12 +0000
Received: from mail-dy1-x1329.google.com ([2607:f8b0:4864:20::1329])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xO809-00000001FEA-0XRA
	for linux-nvme@lists.infradead.org;
	Tue, 03 Nov 2026 06:28:10 +0000
Received: by mail-dy1-x1329.google.com with SMTP id 5a478bee46e88-35b2c599f43so6671175eec.0
        for <linux-nvme@lists.infradead.org>; Mon, 02 Nov 2026 22:28:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793687288; x=1794292088; darn=lists.infradead.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=iFbLP8rEml3d1ZY+239sLeSasqkGxTGMtsL3D+TgbaY=;
        b=vx62f5FiiU+Fs1LMswMEzy0p3nySvENFXF6Ld5tSYcEdtUdhsZvbSfvnnZpWeS+7z2
         r3uD7Nc4lP2UAkkKbKdD6ZFzeED876PHNZTF2LYr5FNkoTP8uv+Dsx9xJwum/fGO5SXl
         b1kZvU17nBXnoOan3TYaJVvOHerkeikmvVgRMufnGQKzxDOGuM7I1PLYVVam6DMDlp2+
         Bws76Wgj1DD99wwt97hUtSEryA2jt3zvEcq6huo82erBCIjT0gIZvdmSNYpH1KZMeF4H
         WNWmjrWRI1OrHRBSsXaCxdfsDDXyASOynyMypoVbxUhohxFodIbWkRlqx/g21VSw8hlK
         yC0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793687288; x=1794292088;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=iFbLP8rEml3d1ZY+239sLeSasqkGxTGMtsL3D+TgbaY=;
        b=H9rKeICIogT0WfF6glqt2PWwsmsSjLy/UJgrmbawNML/RpZlmh+PWg/Y2wCOS0o2dN
         aM1+e1vBS1PKDeTDoi1HXB+PKT0C37ETE791/ufitNWSK0hndl6bu9fnSmCO/oeccQ9L
         wJH6k1NjaROWajm6GB4HgrL3AuuDMk7JLz9TG/Vzs0p8SC4jMFupb9XNboVd3BPpvj/X
         P8OpI8p/c46/7qRBRkJQzltF25xR9UQYNQTk7JPkHppBIHweLnG7lSef8edNKsiCbClV
         BM7+x4p0e2O49vh84Ny7+DJkQAzc2GmuTNr6KJC5bW/kf6c1yNuLrH7eiItMBly7K+Oq
         un8g==
X-Gm-Message-State: APuU4Z8MTExz+vq1b82VpLE+zTRSK3ftFVS0GWqkZgwWXINTzgsMI5Ho
	If+hazfG/pVVFcawBAm02oy86G77WSZm3u7yoijWyhY8NOoR/aGlezYqM3vBt7COmIA=
X-Gm-Gg: AYBFou1LZliMZ2g1pWmespBE/wmbe5Q0DBEOWmPecL+tgUak6slDiOOtNldYJe4FQFE
	6jisxRT+I4BwGtMqqpaN3EInFh0uv5U9H0wNTLjyYYFm1IrSO29wrYPM0WMD6Lqb/VZihQhvKxf
	N/xVEK/fYOkmqY/Tq9y7/7zd+7TacG30CA3f/F8evnIdsuM9tyYcktd6dQwp6MwbesUNfw4FWb4
	XSYS3VmiNQuE8L7bfLY/cst+2JfSpY5s3cjzWdF5WeA0eRNd3YKh4a3mSjVMU17QhRsC4h1fyIy
	PRaI0boTEpOFU1rUTBzi4HGLlKcy7/WP+9bQm6xPAJZJgxB1beDgWrveqRTPVPlJ7lIFWDbB9M6
	bO2rtHmx4TZDN7EjrGrWzJxuLC/JT32L/w3AmOAZTUwd1eeJAnN0/2LtKPAEqQPsQqKmqwQoGtT
	UAYpUvJbTQApx2Q9hIFPllN/Z+LmDRmPEhFIwEDkvTxVDehd7c8qe88eoGWjCFZM+cz7QP5hY88
	BVazj7+bFXcrXsbhCqKsIkfT4cGZZ26v0TD2XlN8bFh8b9T8ovTkmBSK//RJTlCpYb0eEFwmdFY
	GCRfdKLiGt4ZfokjhknWj8S87lUcZXEDVYMo8gsAsrXfLg==
X-Received: by 2002:a05:693c:42c6:b0:369:d793:328d with SMTP id 5a478bee46e88-36a4242f5cemr20252427eec.31.1793687287991;
        Mon, 02 Nov 2026 22:28:07 -0800 (PST)
Received: from [127.0.1.1] ([23.254.208.9])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a428fa380sm40577000eec.12.2026.11.02.22.28.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 22:28:07 -0800 (PST)
From: Qiliang Yuan <odys.yuan@gmail.com>
Date: Tue, 03 Nov 2026 01:28:02 -0500
Subject: [PATCH v2] nvme: remove namespaces in parallel
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261103-bug-nvme-remove-ns-async-v2-1-44e43766e44a@gmail.com>
X-B4-Tracking: v=1; b=H4sIAPF+6WoC/42NQQ6CMBBFr0Jm7ZhOF2BceQ/DYiwDTGJb02IjI
 dzdyglcvpf89zfIklQyXJsNkhTNGkMFe2rAzRwmQR0qgzW2JTIWH+8JQ/GCSXwsgiEj5zU4dML
 MJAO33EGdv5KM+jnS977yrHmJaT2eCv3sH9FCaLCl7mJGESJyt8mzPs8ueuj3ff8CijixCMAAA
 AA=
To: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-block@vger.kernel.org, Hannes Reinecke <hare@kernel.org>, 
 Ming Lei <tom.leiming@gmail.com>, Nilay Shroff <nilay@linux.ibm.com>, 
 Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>, 
 Stuart Hayes <stuart.w.hayes@gmail.com>, Qiliang Yuan <odys.yuan@gmail.com>
X-Mailer: b4 0.13.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261102_222809_178362_223416C8 
X-CRM114-Status: GOOD (  16.68  )
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
for all of them before returning. Each removal still waits about
20 ms, but the waits now overlap: a grace period is system-wide, so
removals that wait at the same time are released by the same grace
periods instead of each needing its own.

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
V1 -> V2:
- Explain why removing the namespaces in parallel saves time
- Drop patch 2 until the elevator switch locking change settles:
  https://lore.kernel.org/r/20261031044141.5569-1-laveeshb@laveeshbansal.com

v1: https://lore.kernel.org/r/20261102-bug-nvme-remove-ns-async-v1-0-61780fee111c@gmail.com
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
 

---
base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
change-id: 20261102-bug-nvme-remove-ns-async-ceaaa1eda6a7

Best regards,
-- 
Qiliang Yuan <odys.yuan@gmail.com>


