Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DA16606A323
	for <linux-nvme@archiver.kernel.org>; Fri, 13 Nov 2026 10:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=rH3/KEJL;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=F73yf1Ip
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=U67oYIS34ncr6Cdj0o3cQt8clTjmojCkrlxGa62ECQo=; b=rH3/KEJLZAf6wf
	c0rQt88R+HqJaoaVDQgq8j451ealhlWJhBybIa6OLZCB3FCXbcwuhTInvWLjOXIsXxNPAIygpwx5x
	8FI3QC8pHIUJg9RM/fg+posl+6xlWNwBEHSK5eFNvcNB0tOYCOk4WW/GyUnmNb26IFLctux1eV6v1
	v7Himp+YXxHr538O/A93KgWXdn3lClkXNDtI8dYQSyJmmgEw07ohRXERBC8mrjJhdjdqY4e12caua
	+XaEERbDaigmNEZxifW3qcf4InJRFMpY2IGX2RnmLsLERhR6pkBTJYxd6Sovib3tAPTB1TKcAycaC
	a+/eGNtFdodQAh3MyUtw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRoEZ-0000000CJEv-0jVf;
	Fri, 13 Nov 2026 10:10:15 +0000
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRoEX-0000000CJE5-0hPw
	for linux-nvme@lists.infradead.org;
	Fri, 13 Nov 2026 10:10:14 +0000
Received: by mail-pj1-x102a.google.com with SMTP id 98e67ed59e1d1-3ae691283ecso364820a91.0
        for <linux-nvme@lists.infradead.org>; Fri, 13 Nov 2026 02:10:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794564612; x=1795169412; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=U67oYIS34ncr6Cdj0o3cQt8clTjmojCkrlxGa62ECQo=;
        b=F73yf1IpXbnlKsirPoRjtrZi9V0zS0w+NJvKWIxXHISHKna2GaGT6RI5G6nyANVEjp
         0xu/fj+YMd6iIt/1EtB27q29LGYGTgIZlNd4l0BHaUuKAVGMQkzw//YSFlUIxGwo+/PP
         nBxUwm3xq2qRw7gnRuYiy9wqaFgB992j/WloLbnPIjff18gVA1xZ2I9jhmUHDbyVIHnR
         WEuD3T/WLZDiyXT+x8GBzvfk6LIfC1AnGWd4xHbS9qV33z5rd2tpD22KiahUdPSJ4S53
         DjxKNNVd2tRit25vPWStFqL2DiE5eJYYOHFoVkVQW67aIc5quwk8Deh4yITTSsfCOZH4
         sotA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794564612; x=1795169412;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=U67oYIS34ncr6Cdj0o3cQt8clTjmojCkrlxGa62ECQo=;
        b=vY6FZWPvxIYVKZr93ipfaKQL9cjR4q+aGP+8Gat8zwKENn2YvHkzN+z7TcBP0nX8W3
         V2RuwP4S10rAD2Nonz84RYLQY3AANlEgmNDSHwkCtdcMv0PGs48uLJ6mmly87q1H37pX
         nNO3C4UMs82ke6uNK/WvkBuyI4n87pLm249zj54PEXAirHeZiQ9mThFBnvCU4GiEJMGg
         Ad7b8ho0Z8r9BmA8eXxRwUtxWfyPnlzt/33Z8Cs7dZpkMSi+Z5tBEozLRi/DmCCYCEFF
         dJIfgfAqNQwxZ1NCz4YgmjIUI3B39VmVd8yJBXrsBefVK/qi9Cj5mrqMcxFwFeeD3vtN
         ZKrg==
X-Gm-Message-State: APuU4Z+leW666h/2d6CqbE6V1Bkvd0QvCp2lQ6Wqorv5woNTOrDRAj7h
	3rvDXw5pEpCrBwZNtHX0UnhKdRY1tf9AlKA5mRue3sMC1lSchAa+/1g8VfNVptew
X-Gm-Gg: AYBFou2Zx4QHxetC3lIOwp5GKjMs4IWSeCqIMAzC0k1GbQTOcWnM0EpdgFTLaZ3pSNW
	LdCOr/hWZV2ONepYopj6UqpFyJ59RurHNb7JGNoDgFaDn13We+Ccz3L61RF3Gzaxh4K3DDyacf3
	jwo++nly9BYFlu+yLuXqiMh0dzUeSJBHx9BcRBm0GnBPKjv7GjCt0x/ZQHKZvIBV8DOpuBcQI5F
	eNr0aZ8XhHb9QjavHpdwig9rlNylEMHhAZBX7WVpUCGDiYTYH8ERgLx4qEw7Iz9wBv+wZYGjp2/
	++nGwi9sAIcwrqWNEq8CQfr/cu+k5x5G9DMXJxUN69WQ6mBr5IJ7llo0ITgc11kkTE09C+bb3+A
	D31uuEzh0hAbyscOxgpulfDFQGgN6HGpt5Wjg1j0BqLgZFrG0Ci0tu+wdymDWNdxf6mR6EDAA3U
	h2r/0n1KkIYeorKGBGGh8xit52+aH7yN7D5833Yzda7ouC+lXIvmAXZXSFHFt1KUM2eFHXqYSGZ
	A7iBAkkRVZjKPi367ZItwFfZtIF4jzzq4/GzMCBc3lYdm982AtGT/EoROcD+ujgegF5MEqfoZmt
	UYhQYunPVBPkqI3FuBI8CYWX+hz+uQ==
X-Received: by 2002:a17:90b:5483:b0:3aa:412f:b0a7 with SMTP id 98e67ed59e1d1-3b1b087e1c4mr1102963a91.5.1794564612182;
        Fri, 13 Nov 2026 02:10:12 -0800 (PST)
Received: from Ubuntu.netapp.com ([136.226.244.207])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b1aec3af2dsm3826016a91.9.2026.11.13.02.10.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 02:10:11 -0800 (PST)
From: Martin George <martinus.gpy@gmail.com>
X-Google-Original-From: Martin George <marting@netapp.com>
To: linux-nvme@lists.infradead.org,
	hch@lst.de
Cc: kbusch@kernel.org,
	sagi@grimberg.me
Subject: [PATCH 1/2] nvme-fabrics: bound reconnect_delay to avoid timer overflow
Date: Fri, 13 Nov 2026 15:39:50 +0530
Message-ID: <20261113100951.17577-2-marting@netapp.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261113100951.17577-1-marting@netapp.com>
References: <20261113100951.17577-1-marting@netapp.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261113_021013_217322_67F7E140 
X-CRM114-Status: GOOD (  13.07  )
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


