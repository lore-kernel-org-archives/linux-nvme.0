Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D37DDCA0ED1
	for <linux-nvme@archiver.kernel.org>; Fri, 15 Aug 2025 05:02:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1ZqqyoHZZ7YsUEio5GgDxrA+je+1nNyUxeRlVhWKQvs=; b=1KUi7TeCB5vDydmPC3dUxyT3DP
	pNeYQNMSvTAbruiPy+i+XM3vrTApFskfO/QbnKuRz6ZpwfvMGk2ZoKN//fzqZj+eN+q/VAk7v3e/f
	4eInnr3A0Kovb9OiIwgu0ovPJfI8Ic9cTrQ+zfyk018qctirg6SblhwTX1kPHCti453q/jz/ljoJb
	0QbtUfH4C/iM2rrRT+RxN7G+c0WyUh5OrehOifzxzI8Jvh/zyhPefVRlL/Hn42fQlPloXPEJwRXQs
	NL3N6eET2gJEyMhEC1DIu9ZQ6fZCCytevY+hK8EglySx+eW3mXtWTHQTPKqX2Pvqp3cNscw8upyfR
	r5UZq/zw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ummaU-00000001SlY-0MSb;
	Fri, 15 Aug 2025 05:02:46 +0000
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ummaR-00000001Sjp-3bNa
	for linux-nvme@lists.infradead.org;
	Fri, 15 Aug 2025 05:02:44 +0000
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-24457f47000so14994755ad.0
        for <linux-nvme@lists.infradead.org>; Thu, 14 Aug 2025 22:02:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755234163; x=1755838963; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1ZqqyoHZZ7YsUEio5GgDxrA+je+1nNyUxeRlVhWKQvs=;
        b=gyik/XGMxk+dj44oLboHGp3nE2F1eEu+bh+bT9yyeheQbxu/WBQULIcUPadJ5O3qoh
         A26ejYvl5ZcEMhqECZqpE5oqToyVlMPLrd3yEaUGWqD+vI4Z0UGzp0dXeBJoVvJVIHmY
         xpFi6xKkBr8WjHmc3YBRtSXoXS14a9aKyUSQu+l2pkjwRxCIQ62vKjbUJKK5b0EYee2Z
         1sTzPZUPx/SCEZmgQXVm6HffXFgNxx9KRj6Hngt04JOczn0OivlbMFppdiZtQJcZlVUN
         L2yJGCAbGBjmkkVJI8gTnEMGEvBCX9l2sEh31c/J3F6vROEXtIY3oCZWLHAKZFtnAaMo
         eCvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755234163; x=1755838963;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1ZqqyoHZZ7YsUEio5GgDxrA+je+1nNyUxeRlVhWKQvs=;
        b=I0VOZZF+lx65StLZ/sOJ3WMJjgvqnFhLSyRJRbLWxNaRt6zrSHW0VZFHomGhE9TXYf
         1/FKBkpG5vTX/nWF7TUh8XVkuQlGGkiJ8BmCf9ECdLmKi1aWY7KO0CZSHwae6Uxke/TR
         w7USu7y36AvvIKl3wCmKR/2pNnrdVZMJ6T5FdgwS0BukoCTcuY29JvbJR3gFwxO3lmAU
         YHSjdeHPM40MhF2IGGmQX+MATtROpgS50jrqLAWoixkJaXbeiJ7XW1mFWYr4I1LqBNMB
         o8uxeZIVz5+SNST+1Aiph89riBlafg8mf/+9rdfmYEvSGgSkokoJhfRossMoqeP1mA5X
         WF+g==
X-Forwarded-Encrypted: i=1; AJvYcCVwNvr7AekKXt/32u3k2XzrFKS9R20MKNRwlSdbFy6wvqlB/c0LhnPkFcj9Nejd8cef868ysir/K9xz@lists.infradead.org
X-Gm-Message-State: AOJu0YyKQhMmpMJYkShcOtcaIEShVsnDdop9C3l0MKVi7DFHj9WSjL1j
	0aiv/FxMv94WayzUT4LG9vPzfoOw4UwU7L2KSNga0B9VsJDQtDIqsk75
X-Gm-Gg: ASbGncslkxBudoOiKx21wt2tGJCwXyL2ZVIjjYLm1d0t7XtVIVgKI6PRkgVu7nCJGF0
	LLvROcRHyYaMmbsi9QK3JbFF1Yr6tn2hS0JPk3cLM+xIzhWdBuEzfMUM2g5H3z2t085ZNFa99M0
	ai6z5WCokbcG999/7oAFhuYYyWV/A+iZtKHVZ3FXZbqjJep0NJJAqqQypFrrxXoAcSbRXYXALwe
	j1st1xKeBnbsXd3IaR8/EcEnNyj2XRh77RJ4lwgC0T95MAwbHOnLKvQBuT+nbZZapAXo5RLmxFm
	6miwW1HlyWlKe/yOnN51aafJnUXjvwCwff8/qIq8S3efiBT/FfiGWQVYiMpnNQ16j3vpkaJ33IX
	juhPrCHFE/GrMlZmLyi8ktkiWbuC6k6t+qYKF4qKKGIP7jvZ5bXujxTcr5zfuZlvGbqYd4yF1AL
	dqxBWhIs4GlhtGRCK7EfEVZds0D1s=
X-Google-Smtp-Source: AGHT+IG4eNpFbbY6CONpalTmgGqMktH1B9il2WlkRC8J04INCl901SG/4g+axvWD8CC3sg/+QQBV8g==
X-Received: by 2002:a17:903:1c7:b0:242:9bbc:3647 with SMTP id d9443c01a7336-2446d9e45ebmr10879945ad.57.1755234163041;
        Thu, 14 Aug 2025 22:02:43 -0700 (PDT)
Received: from toolbx.alistair23.me (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net. [2403:580b:97e8:0:82ce:f179:8a79:69f4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2446d53c6e1sm5128645ad.115.2025.08.14.22.02.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 22:02:42 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: chuck.lever@oracle.com,
	hare@kernel.org,
	kernel-tls-handshake@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-nfs@vger.kernel.org
Cc: kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me,
	kch@nvidia.com,
	alistair23@gmail.com,
	Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH 4/8] tls: Allow callers to clear errors
Date: Fri, 15 Aug 2025 15:02:06 +1000
Message-ID: <20250815050210.1518439-5-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250815050210.1518439-1-alistair.francis@wdc.com>
References: <20250815050210.1518439-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250814_220243_896137_0A1A3894 
X-CRM114-Status: UNSURE (   9.49  )
X-CRM114-Notice: Please train this message.
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

From: Alistair Francis <alistair.francis@wdc.com>

As part of supporting KeyUpdate we are going to pass errors up to the
callers of TLS to indaicate a KeyUpdate. Those layers will need to handle
the KeyUpdate and as part of that clear the error.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 include/net/tls.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/net/tls.h b/include/net/tls.h
index 857340338b69..7de960225da2 100644
--- a/include/net/tls.h
+++ b/include/net/tls.h
@@ -493,6 +493,13 @@ static inline bool tls_offload_tx_resync_pending(struct sock *sk)
 
 struct sk_buff *tls_encrypt_skb(struct sk_buff *skb);
 
+static inline void tls_clear_err(struct sock *sk)
+{
+	WRITE_ONCE(sk->sk_err, 0);
+	/* Paired with smp_rmb() in tcp_poll() */
+	smp_wmb();
+}
+
 #ifdef CONFIG_TLS_DEVICE
 void tls_device_sk_destruct(struct sock *sk);
 void tls_offload_tx_resync_request(struct sock *sk, u32 got_seq, u32 exp_seq);
-- 
2.50.1


