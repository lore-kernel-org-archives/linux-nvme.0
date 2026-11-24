Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F065606A321
	for <linux-nvme@archiver.kernel.org>; Tue, 24 Nov 2026 05:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=O8a60W1G;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=hEYXqell
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=y1ORfnaHlhDzsZHEXRHBjlwI4ywfEuWtgyCrCwNJ9FI=; b=O8a60W1G4kwrM5bZ+B0RV0Jn+M
	PNpXBliUzoemibMsVnAb8ls18UfAntq03H0e+U7H2ujh0NB35qodyicHRp3wNv/UlhsGbtzzWsYM9
	6YzsD3LFeQ7+P+D5tuOWI27gaofxSM41OQHuI0JChgsxcfQWNlntmim12KbHExLPOHOnH44ohajIt
	kR2d0y/hbz2ZV/OjZVT3uQRenE8smxwoQKQbR3/smYHyH7dhKdIqDBvaUBEomuxq0o4MIDJVEutyy
	bz5xT9reSv8vw0pqtHdfJ09ZfIaAndXRo8yoB7KUJVsucyPhP4gXzcYqi/Flcw7RKN7SNTy2e169+
	o931OUoA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xVio1-00000005adI-0jud;
	Tue, 24 Nov 2026 05:11:01 +0000
Received: from mail-ot1-x347.google.com ([2607:f8b0:4864:20::347])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xVint-00000005ab5-0G9h
	for linux-nvme@lists.infradead.org;
	Tue, 24 Nov 2026 05:10:56 +0000
Received: by mail-ot1-x347.google.com with SMTP id 46e09a7af769-862a5ad18d0so4823768a34.3
        for <linux-nvme@lists.infradead.org>; Mon, 23 Nov 2026 21:10:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795497048; x=1796101848; darn=lists.infradead.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=y1ORfnaHlhDzsZHEXRHBjlwI4ywfEuWtgyCrCwNJ9FI=;
        b=hEYXqellsv5eOyAFXzn9P0txwHJ1Efckj7m5pBGxOFf6LP/TGQyiO8ogF8vPBb/pBX
         tvYYFatEcTmYb5cSYnT8zK9SaI5y9w57t5yw/APlfpFfAuuU39WWrPDvrZNWRVWm9HBv
         Vvf0mmtoqPHNNECkqEbhiBjpkrGOc95qXcKnE9yenWecKXT7oGtJAe6+qsgiNZm1wnzU
         Ufa9m7SdhZl6IfXkzlOu1082inhtSY4kA70IsxIUvutt6U0HeJaKACtVt6xzv9Gfyd2b
         ReYl7cchPOQbobENtZrQgPxP3sF8PZxkdFop3Pff9WicgAGCgcjsiSSuubBezrg54bgO
         JFWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795497048; x=1796101848;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=y1ORfnaHlhDzsZHEXRHBjlwI4ywfEuWtgyCrCwNJ9FI=;
        b=QxjxVufhSpXl5LCIgKUYP+t6Lo9+LSrQkNelncWlWISmn+u8Hfup/j+nL/nj3c69Ko
         bGRVQ+tLZpolOtJPh0MrgBEG2PX8O7shdWdcxvWWtqFZa6uUZG5irf33idhDLD4TyHVP
         4XS9oBTwGcyuFRyMdjmZWENbPkU5qUgbbXXwLDBdzVTjlZzOQqlgF6WmlivGaWG9Al7n
         vUXrcuOAgV57cSQGpAz0ZT/apJu867yXwQ+gql9GzAogs83RUWRuvwUiFbyPp3zqpYTi
         +mfNxaSRH+hFfW7YJlc3jOxcEBfRlDjG+Nr9f4T8lPIPcr1sfU7GDPJpA2fDLeIO3zQS
         WHoA==
X-Forwarded-Encrypted: i=1; AL+hErEdiNKvA29oMrEO2QWRg3Y+zbJmi/llkVjZxr8RD0gzCmcB5pk+HCzqK6hMhg280XKaEXNJpkMME0+b@lists.infradead.org
X-Gm-Message-State: APuU4Z/6Ho0HE6RzCtmukOeH5362oGcPn+eDDw/DKZDKQI6BHtWGz+OS
	Ixp2R2HqL/dp82e2AmXsd7Wnm3ewqsXf2NW63UT+gk1nkXNHDUbl6QuivtkFev1ID3LOWY9C+2j
	AESs4e7M1RztLuqhKNrlHRKkIZTSfiQ==
X-Received: from oixr26-n2.prod.google.com ([2002:a05:6809:29a:20b0:521:880:fa1e])
 (user=zhenwenliang job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6808:150d:b0:50a:6fcf:d287 with SMTP id 5614622812f47-57a0a71ae3cmr14668369b6e.37.1795497047592;
 Mon, 23 Nov 2026 21:10:47 -0800 (PST)
Date: Tue, 24 Nov 2026 05:10:40 +0000
In-Reply-To: <20261124051041.3099796-1-zhenwenliang@google.com>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261124051041.3099796-1-zhenwenliang@google.com>
X-Mailer: git-send-email 2.56.1.809.ga0b61035b5-goog
Message-ID: <20261124051041.3099796-2-zhenwenliang@google.com>
Subject: [PATCH v2 1/2] nvme-tcp: avoid overflow in the R2T length check
From: Zhenwen Liang <zhenwenliang@google.com>
To: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, 
	Sagi Grimberg <sagi@grimberg.me>
Cc: Shao Mingyin <shao.mingyin@zte.com.cn>, linux-nvme@lists.infradead.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261123_211055_145339_6C5842B0 
X-CRM114-Status: GOOD (  15.79  )
X-Spam-Score: -9.5 (---------)
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
X-Spam-Status: No, score=-26.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

nvme_tcp_handle_r2t() checks the R2T length with

	if (unlikely(req->data_sent + r2t_length > req->data_len))

data_sent is a size_t, which is 32 bits wide on 32-bit architectures,
and r2t_length comes from the controller. A large r2t_length can make
the sum wrap around and pass the check. Compare against the remaining
length instead; data_sent never exceeds data_len, so the subtraction
cannot underflow.

The same check was already in the original driver (on pdu_len, then
filled from the R2T); commit 1d3ef9c3a39e ("nvme-tcp: validate R2T PDU
in nvme_tcp_handle_r2t()") moved it to r2t_length.

Reported by the Sashiko review bot on v1 of "nvme-tcp: set up R2T data
transfer in the send path". The patch and this description were
written with AI assistance and reviewed by a human. Build-tested only
(32-bit not tested).

Fixes: 3f2304f8c6d6 ("nvme-tcp: add NVMe over TCP host driver")
Cc: stable@vger.kernel.org
Signed-off-by: Zhenwen Liang <zhenwenliang@google.com>
---
 drivers/nvme/host/tcp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 62a594b8ab9b..4fa4b0199dee 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -847,7 +847,7 @@ static int nvme_tcp_handle_r2t(struct nvme_tcp_queue *queue,
 		return -EPROTO;
 	}
 
-	if (unlikely(req->data_sent + r2t_length > req->data_len)) {
+	if (unlikely(r2t_length > req->data_len - req->data_sent)) {
 		dev_err(queue->ctrl->ctrl.device,
 			"req %d r2t len %u exceeded data len %u (%zu sent)\n",
 			rq->tag, r2t_length, req->data_len, req->data_sent);
-- 
2.56.1.809.ga0b61035b5-goog


