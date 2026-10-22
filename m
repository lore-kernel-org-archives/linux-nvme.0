Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DDEB606A319
	for <linux-nvme@archiver.kernel.org>; Thu, 22 Oct 2026 07:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=J0OZn6qR;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=HD/U/NWk;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=HhH9kvRY
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=MiRA/Sd3582R8jqkdeZLtvV26orjjHzxbVU5TB7AnAM=; b=J0OZn6qR9xzP8hO6j6+OhpbWwk
	8zeFYNLj4fU+YTsvCPImWI1MfXxP527PeDEz6O47G4h2XBHtSV6dtTaYBmpeNQwf0zCQCMN0G45qd
	I9asTBTig0rkngZ+fq+MgDH9YAG7RQiBiocBK4Dx0ar9JY/z05L6qDBXGQT1XLqPi4Icz2YpBqvrB
	RvfFrbmstBkPbcSHgZOly4qCHtzNJKJu3wQr+r95mE9wEYK9/YI32waNmVRXkXNtNq90Dcj9dl2aZ
	IN2A8pxUfeSK6WWIl0qy63gUh3zTVPJbXuAbHtZ3RaZWrOlHFWcOVUtxwhdtg9DF/65VT3og/74MY
	ftIbvl2Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xJn5V-0000000DYOj-2mdL;
	Thu, 22 Oct 2026 07:19:45 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xJn5T-0000000DYM8-22ge
	for linux-nvme@bombadil.infradead.org;
	Thu, 22 Oct 2026 07:19:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=MiRA/Sd3582R8jqkdeZLtvV26orjjHzxbVU5TB7AnAM=; b=HD/U/NWkAozVpX9fqk1wa55QEH
	/M5o0ZTI4Z0CofPPQq0fUAIAKBvaPm1BODT2t7zUVn6CDKgRkhaALRqG72L53YtG6A81Bi+3e/yu/
	Xpn7GdYT544GOLbl2OoogbJRqPscaq1gDCvlCRFs2n8Ugqf9KN3pb9drZ7JeVCNbHNkPye062ja0M
	V4UEmgLD/boM5hce9u5gsubemoAvc1h1f2ayRurwqXnGPxi+dD6Pl06mhRjAk0ku2pYNHv478gqdb
	H2k0yuG2rtlX4vV3jX0y9sfpeinhoWlrb0I0DGDGCU1eHTCfuKb8iE704ICRhZ/amf0yp+lTAMaah
	252pO4Dw==;
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
	by desiato.infradead.org with esmtps (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xJn5Q-00000006XwH-1yUJ
	for linux-nvme@lists.infradead.org;
	Thu, 22 Oct 2026 07:19:42 +0000
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-4a1f403aca0so9367355e9.3
        for <linux-nvme@lists.infradead.org>; Thu, 22 Oct 2026 00:19:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792653579; x=1793258379; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=MiRA/Sd3582R8jqkdeZLtvV26orjjHzxbVU5TB7AnAM=;
        b=HhH9kvRYLwU22y3bSVCRCo6qYdXyn98cP730IB5JVnf1KTzN/+d46hA5X1Fmxy8LVK
         qXpx0z/6YAwOlFW/tRfkMNdyIgpciPk6nx63yboFVVPqCWtcDyo03IC1hyFAHdjYmIHu
         47RBKnGiucpbWlv1KTM4nLy6kskC+AJnWlolMQXXy7krMqGQlWEtPOFq851HSAKTGJVC
         IuHo5ejF9xupSPyVvecGOC2WRJIJaeqeGfQL7C+w8KsZgTx7NZocxPyx9eWdag0lDpjz
         w9RKtxypHV1cTaSMwiz2t9uSg7UNzo5pf+g4NYZnH5u+kDaqBQmS69JYJHjbQ1EKgmEm
         vRjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792653579; x=1793258379;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MiRA/Sd3582R8jqkdeZLtvV26orjjHzxbVU5TB7AnAM=;
        b=BQgL7/nHhFzk4HEfXVX7RNhv9uYM0lw+qXRHwxYtUZSyrGz4I7T3VSnjJAFBqJuLxn
         l+kH3QoBGTH2Z9GOR2l+6DDDPwrGfSdKYcDHMYrI+Mp+hHI/yBqb75/sxefdpkwzgT6H
         3EE7PZ0MGL/jUtWBXN48dC3TtKn9RVfR6yTPUaZ1pXHHIyKYfMK55FOY50+KeZzVbUWv
         9eZVpd2aNgXa6UfjB0Mc++YpRJFxRKX10gEoXbUZwhp7APLIDtBOZnQXk+BgEoxVSk6+
         t0ZDLlPDTE71LGiFqj0oU+rSeidroXYRgFGez9qzjzQxlklVmlA749nB9Y2ly5bnVnOF
         MqCA==
X-Forwarded-Encrypted: i=1; AKwUvBy4GhIwxDozSixTEFWGijVATUaGxKTaLOG0HNnRSJPNmWL1KwHmNe9pbmVh7tSC3XTsa11eIE2rBPSO@lists.infradead.org
X-Gm-Message-State: AFq9FYIYt3GcBZl3f+qPZWx9Ktl00+h3ywJ42ZViQgCTdtK9ApE+rBL+
	s/jNvm23laaTzzPVS5oda7s6NNnkvX53QINecIQ0IMwjN6nCp4CtBGWg
X-Gm-Gg: AYBFou2rtJlwJAAsUr2PWA5yPvQtqMza5aemFqOKxvpI9RaS//zWgTQnhrbMQCpFYdZ
	9cBL5A6MulIHwE7eXwIdXjrQ2R4/RzyyHDvnexORiWMb+5D8mipk8X2FaQUZQMnd9XO0uYVAaOO
	c717So3ITHIQgd4LpVWfimhpuaGtuRFwTa++7JoxB0t/XdDM808akze1KtU6RpugHn9SJJcE5lE
	j2RbfO6TQVvCDoCfb7dhuW5llHh6WWEp0OUj0sDHbZmdgSjmBV6NxtVmFM19NaNFGZXgThbkmRD
	WROuwkX2udj6vDIDDi3ePz7SGE+w2DTfxg0grKDrW7U2nLEdc4agPmScsoGPSBFMWzp90hWPK3Z
	wG55ZosKsHg//K2DRadjShaE2ARjVNZWIp1TWMj6ITUUS649Li6qE3uX5pf18wxfDNBqfqOE66t
	Ty6G4tg7CfhAz30gXD2tOYploRqDTIKqXr/tHYl7XAwf6Y3FHJs2hA082XLaTug+hL314mo2klX
	pEkXgSo1e5qwDwfpnQ72qpYXI7TXvib49wAZnIIT7bn6vctjvm4JTFT5MAdNGuXcdEQ5SSfKm5O
	6vuqR5He037dg3xPkg==
X-Received: by 2002:a05:600c:b90:b0:4a1:d307:b526 with SMTP id 5b1f17b1804b1-4a1fd72a9ffmr88188875e9.0.1792653578527;
        Thu, 22 Oct 2026 00:19:38 -0700 (PDT)
Received: from localhost.localdomain ([2a06:c701:4778:c500:2fac:694b:933a:abb0])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e258427cesm10698338f8f.52.2026.10.22.00.19.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 00:19:37 -0700 (PDT)
From: Avi Weiss <thnkslprpt@gmail.com>
To: Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org
Cc: Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH] nvme-tcp: wait for in-flight TLS handshake callback
Date: Thu, 22 Oct 2026 10:19:34 +0300
Message-ID: <20261022071934.3818224-1-thnkslprpt@gmail.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261022_081940_699872_28AEB6D6 
X-CRM114-Status: GOOD (  14.08  )
X-Spam-Score: 2.0 (++)
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
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,FROM_LOCAL_NOVOWEL,HEADER_FROM_DIFFERENT_DOMAINS,
	HK_RANDOM_FROM,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

When nvme_tcp_start_tls() times out or is interrupted,
tls_handshake_cancel() can return false after handshake_complete()
marks the request completed, but before nvme_tcp_tls_done()
finishes. Error cleanup can then release the queue while the
callback still accesses it.

Wait for queue->tls_complete when cancellation loses, before
continuing cleanup. Preserve the original timeout or signal error.

This follows the cancellation/completion synchronization used
in SunRPC for:
- commit d00e32f84ca1 ("sunrpc: wait for in-flight TLS handshake
  callback when cancel loses race")
- commit a89dd5974588 ("SUNRPC: wait for in-flight client TLS
  handshake callback")

Fixes: be8e82caa685 ("nvme-tcp: enable TLS handshake upcall")
Signed-off-by: Avi Weiss <thnkslprpt@gmail.com>
---
 drivers/nvme/host/tcp.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 7eec983c0ead..26a626abef7b 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -1816,7 +1816,8 @@ static int nvme_tcp_start_tls(struct nvme_ctrl *nctrl,
 		dev_err(nctrl->device,
 			"queue %d: TLS handshake failed, error %d\n",
 			qid, ret);
-		tls_handshake_cancel(queue->sock->sk);
+		if (!tls_handshake_cancel(queue->sock->sk))
+			wait_for_completion(&queue->tls_complete);
 	} else {
 		if (queue->tls_err) {
 			dev_err(nctrl->device,

base-commit: 7be4bc52fd9e0e55dc9a2e0232b89427d2c4b614
-- 
2.43.0


