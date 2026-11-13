Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BF44606AFE6
	for <linux-nvme@archiver.kernel.org>; Fri, 13 Nov 2026 16:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=xDC3YrBH;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UNvwGFVA
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=Sj+PtzYdnjGYfbb6t2H2MVysDxpCLFt7LwmF5pgMPGk=; b=xDC3YrBHDGAKWK
	qPvlH20wV9XpAScqcy3s7AHLsQos7jFrzWvJFnDQvibjA47DPHJSL6ePtbu+iI9u9zXqMo/1ER5gA
	Ntj+YIbklVbDGWaVkIFvXKs1CTbsnOxRAHOSITSgx2uizP8ttBlJOyIZVtr9ny1e4yOcWm5qXIbFo
	Hd7MAPvwqxajsOb4hOGjrehIS1CMwSqn0JJgdVvLwWKHCyCnumU+NFY6cShWwhx3eO5AZ2FW1t9Fm
	J4Q+cdUpvslu/vYJHfxRRyG9Vgjt+skFWsCIjvnqs1M1Yub1RKqj7cLxSBE6QBz7cocidbVrzoLxs
	bshmy55k2uJ1gi/O+bmw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRuTr-0000000Df6W-3jMV;
	Fri, 13 Nov 2026 16:50:28 +0000
Received: from mail-dy1-x1334.google.com ([2607:f8b0:4864:20::1334])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRuTp-0000000Df4Z-0nz4
	for linux-nvme@lists.infradead.org;
	Fri, 13 Nov 2026 16:50:26 +0000
Received: by mail-dy1-x1334.google.com with SMTP id 5a478bee46e88-33fb4680717so3413455eec.1
        for <linux-nvme@lists.infradead.org>; Fri, 13 Nov 2026 08:50:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794588624; x=1795193424; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Sj+PtzYdnjGYfbb6t2H2MVysDxpCLFt7LwmF5pgMPGk=;
        b=UNvwGFVAhx2A++SHtx+t1BlWwNUlryUBDsff7visDo1XtsK2CyUVHtthmgdbcNJTkr
         xajHNivPMxKw4rfe3msE+6HtwMO8Rxrm8LboBMzRJbcQYztiyIHZV+OOIbG8LF1uo9qY
         JjP3AG3IWeHSwJ9AfWzqRkRWHHJf5vZMVZvVyiMcrKmwxGMRAM53D0rxbQFU9HJ4yJGI
         OPpyIfoVInwhdd2DXdU1xT5/x7VcEAGcYJRl90WWlyNzEfkLXYu2VExtp5Eqstg9rf3l
         ECRXU5sLIJH44xrBiMG3poK9gHWH6CF2bd63gJZtaJsXi6/IFhGCxcg0ffdCw8uJos3+
         TLZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794588624; x=1795193424;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Sj+PtzYdnjGYfbb6t2H2MVysDxpCLFt7LwmF5pgMPGk=;
        b=h4d4c1kh/7lX32x5P7N/lAmJbWVELMwDlhfEng4g7iJN9YnK/Lx+S5CNFaKMb1BBod
         JpVdfdazAlyQWFXNKVa0tSlL0VPU9TVJz9Hh60SOfeTf591BgGK4RvYLMSzprECw4RzU
         l1fTE2up4n5N0bAh2joSKeLeIcVxuywCDjcrYOm6lhObl235h7jjTwn5yRKARr1Ydx9n
         zXe5HaxZjTEOeEZmnKQIYzCCdzctHnnLM84NuIhuCA429Gkw5lU0kjvd4t645+Y3MC3L
         /jJSJ8L3D+UlAL8buEcR8R4Ompk5SN/Y6ONg1WBzWgHDfoY1txjcBMMkECEP333xeeiV
         DhcA==
X-Gm-Message-State: APuU4Z/MZBdaJ4KvmUpb/hyKk2oiGfW3fKEaz3wNW+zFZurNaOG7Z26i
	fOVJSSWzheGT5ij5sxLFHgKtdYT1MN9ZUYqSVP0mQHgzQsWEBA/S/yMPX+V1dxaj
X-Gm-Gg: AYBFou1WWen/0Fnzer3GKsaKRCSajhyM+i9y065g+qwTQo45ZuNsVg6cOZQjg5dAHk+
	GLSTtAD0ahk3hpna/4FineIl7pdbbOiVt1BtCDcy8LOUX73YpGXwwG8rNdpBJOOndFKRFWEJ67m
	OUdmetrAEDo2nRdfToSf6cQ9LLyhKmjII/UYNIBbFLNlST/HsF8tGvFCquq0s6VUjxhedVGThPa
	pYVtPUQtlp6GzB3KhZ8J40te6+yTI2hW33MxaiF4UPxqJOeF+DFfs4V62kAzqTwMM4Eoo7MzYcv
	uMnNUYGf0TTtiVhMS2n1jz0FuCcEifXfWESMPisD4LOgAc4QIWAWkMNVzXyXP0MJUZfD1DRS8NN
	lEeB12bqZu1xViqOhGAKF+QbFWXJoQG9csFH6Gj1FU+YBUKeV2sTTOJ8+uve13lbwA8yY6zkoyA
	d2wf5WjTnV5DdwQiaUWIxggsQHfshNwbJcjf6SbNIN1nT6vWVstktJKssNPv2KKNUA54xD7rEBM
	+I9LY4rKHOGMmZGB/9cIIB0eMN0ae+4eKkZkJLZfcfhNsM53QXuZHR3Dj+g2DWzLh+OQ/OoCDKd
	y3ceP8CcADczgbuRTvEb7lt5hSn26A==
X-Received: by 2002:a05:693c:414c:10b0:369:9062:c392 with SMTP id 5a478bee46e88-379680cf511mr3005715eec.37.1794588622688;
        Fri, 13 Nov 2026 08:50:22 -0800 (PST)
Received: from Ubuntu.netapp.com ([136.226.242.199])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-37955822d58sm8284403eec.10.2026.11.13.08.50.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 08:50:21 -0800 (PST)
From: Martin George <martinus.gpy@gmail.com>
X-Google-Original-From: Martin George <marting@netapp.com>
To: linux-nvme@lists.infradead.org
Cc: hch@lst.de,
	kbusch@kernel.org,
	sagi@grimberg.me,
	loberman@redhat.com
Subject: [PATCH v2 1/3] nvme-fabrics: bound reconnect_delay to avoid overflow
Date: Fri, 13 Nov 2026 22:20:00 +0530
Message-ID: <20261113165002.12536-2-marting@netapp.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261113165002.12536-1-marting@netapp.com>
References: <20261113165002.12536-1-marting@netapp.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261113_085025_254011_CF0B5075 
X-CRM114-Status: GOOD (  13.46  )
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

reconnect_delay is accepted up to INT_MAX, but every consumer computes
"reconnect_delay * HZ" in 32-bit (nvme-tcp, nvme-rdma, nvme-fc), so a
large value wraps into a short, bogus reconnect interval.

Reject values above INT_MAX / HZ in both the option parser and the
sysfs store.

Signed-off-by: Martin George <marting@netapp.com>
Reviewed-by: Laurence Oberman <loberman@redhat.com>
---
 drivers/nvme/host/fabrics.c | 2 +-
 drivers/nvme/host/sysfs.c   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index c262538523fb..25029978b978 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -893,7 +893,7 @@ static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
 				ret = -EINVAL;
 				goto out;
 			}
-			if (token <= 0) {
+			if (token <= 0 || token > INT_MAX / HZ) {
 				pr_err("Invalid reconnect_delay %d\n", token);
 				ret = -EINVAL;
 				goto out;
diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
index 9672ca3f74d2..8876d8db5401 100644
--- a/drivers/nvme/host/sysfs.c
+++ b/drivers/nvme/host/sysfs.c
@@ -632,7 +632,7 @@ static ssize_t nvme_ctrl_reconnect_delay_store(struct device *dev,
 	if (err)
 		return err;
 
-	if (!v || v > INT_MAX)
+	if (!v || v > INT_MAX / HZ)
 		return -EINVAL;
 
 	ctrl->opts->reconnect_delay = v;
-- 
2.53.0


