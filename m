Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7920CCFA1A
	for <linux-nvme@archiver.kernel.org>; Wed, 12 Nov 2025 04:28:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TfXE4RQsTo13oDtpS18/YqY50MP5ENyfIi78Z5opJm4=; b=eT1IXEj5sXNENBAO9Nii0sDMBA
	j5lIOeanvwkupISSesoRfpCmrsRzjLbycIttraI/5nhYWpfW1wzFllP3AwR9UfF3qdM1R1SXHLxim
	sXodSqNlt2DlwgHedADObPYOYqNphzTfNpagAEs5p9WoiR/OkhrgJLD5r4VmRaHOnEi3OwcvRvYiv
	MLsXJTlQeDZR2FDSZC6AJpD55ngq0cllC6ZSbOf2Kzw2yL7mbxTi5ggKOUiCM/2FwFaaJJGMbQu5D
	hSFkzDQbpCf3iYoX5sUdPKIco6nNRUKOQMnQP0Hu2rt5NDGCY5cF5FlscXQHbaTXhLZxuAl85ipKz
	TeRTi6/A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJ2Sz-000000086YY-0XRJ;
	Wed, 12 Nov 2025 04:28:21 +0000
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJ2Sx-000000086Xu-1Yt7
	for linux-nvme@lists.infradead.org;
	Wed, 12 Nov 2025 04:28:20 +0000
Received: by mail-pj1-x102c.google.com with SMTP id 98e67ed59e1d1-3418ad69672so290761a91.3
        for <linux-nvme@lists.infradead.org>; Tue, 11 Nov 2025 20:28:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762921698; x=1763526498; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TfXE4RQsTo13oDtpS18/YqY50MP5ENyfIi78Z5opJm4=;
        b=FRtQDdUZj0c+IyF/0xzoOOJw+1n0c6oK/nz1f1VHohqm6OyxsS5j8uGphLKQix3v5x
         832wzdjo1+Nhtd+jzsRF55MQea1SKKJgQYoWpf4wMmERukNIzPWw9isooknwQkPlxLvN
         ZXLdPzfNGBnOSOG8WD571sessQCNToPDGAl5vz/I/ke14ZtbD3OX9L2nY0eN98r9Y9O6
         fWuQGQ6P0Y3Z+53usWt/PFtWJR0fqZNPO6L+Cd2EotWqeC+MIpn7U0+wS3LS7qMQQ+yf
         2XFoJyzd+ch+bOZkxusPSaSbX3mYSIN9yh3n3dzPBPH1eH2L+QfRLS2oku/5gImvZIyT
         FRfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762921698; x=1763526498;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TfXE4RQsTo13oDtpS18/YqY50MP5ENyfIi78Z5opJm4=;
        b=Vot0QeFye8/1dHBNgiN6rjqc/ypxhQoT/CAQJicFdA7/stMf5e9ILHB3TlRZw2YdW1
         PbTp2tqcPjN82W6XmgmoIQs5bz/rhAk3sy8/5g1KONVMJ/lfmXtjg3JEQBuD5DwfuRYN
         y+PciSjXoBs51tjHFW1l4Z7n0B1hJIbcswoYr6htF27kOPWtY5VMl+fAUan1UvX0nRZO
         tqt7eaxnIDGxVUGjQpuhgq6jjusQFBho0/atFtGOD7bmdPr+8+7pgE8f9jA+1tiO3yaJ
         GjgzyHwCWRdovylboeSifH09ulH+SwbCtznlxfNsmEjTTG6kzMnBrqnc8IzBmYrhct3E
         WytA==
X-Forwarded-Encrypted: i=1; AJvYcCUm2kuU+i5ktC/Nvn/YgFYNapy72yQkEWHYW9OqDcSa/JV4rmJbK+8wXqpi53zjm6W1EU4VQG1M5mDK@lists.infradead.org
X-Gm-Message-State: AOJu0YyRaFQndDSO9H+xVZ2sSJsJdVMVGOBLNHdroM2TuROEJOkbo55o
	S6tD+YAXvGC5JDwwmnaOP5Qu97FdyN8lCWjxhdddjjOF19wLbs0sQTp8
X-Gm-Gg: ASbGncsrFyPjK7eMciy3WpE2bG68np2pocmbJ0P4vg/TffLCID4mDX5OUcDHBO/EVYK
	0ENadrctjLkWEvymzwOYrGy0+6m5LaxijQmmdLuHBiLiiBMIiAAVkbyTGuYTwsbRkA4rLq3qI0s
	wFUYXxsrje/M7VKeyrWrN69/f8zJoxqPKE9QEP1gUiKxLqaZJ5m7iKiUj0DmG1Mtk/eqSP8XSNB
	zh2ObWPy3fAQk2SF2Bs82q4EmAN/AwkVGGx3oMsfj4Nr79JC1w7lPhUjWBEn4afqFXLMS+O7kOF
	y7iZzrKu4cs7/PcdS4RRvRGc9ARZcVMRUh8MsdhcPqDafFl65i7ASpIHrC/gUjTJICp8zODJSmv
	cbqB7YCg6iEBW8Fy7OcGv7rUmYEiFPyPYZK1J+aIgZ7/El5lSzlZ5dyN4XlcuRDCZcZUBVQoCNe
	iSZDUgcLvfWZidCQ0v+t/37phICK7Knao5VGSq8DJwmjrK30OrAZLikzIaV2dTLIi1e0j/CvCcc
	c6UcZhU0Q==
X-Google-Smtp-Source: AGHT+IGasMEo2f3YSuRreEs/8zog7GQY45X0or6PmRJCkVtaVHjxXqWGnHYHC3SejrjGvw9vVcyiWQ==
X-Received: by 2002:a17:90a:fc50:b0:343:a631:28a8 with SMTP id 98e67ed59e1d1-343dded5123mr2073086a91.37.1762921698484;
        Tue, 11 Nov 2025 20:28:18 -0800 (PST)
Received: from toolbx.alistair23.me (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net. [2403:580b:97e8:0:82ce:f179:8a79:69f4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-343e06fbc0dsm854681a91.2.2025.11.11.20.28.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 20:28:18 -0800 (PST)
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
	hare@suse.de,
	alistair23@gmail.com,
	Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v5 2/6] net/handshake: Define handshake_sk_destruct_req
Date: Wed, 12 Nov 2025 14:27:16 +1000
Message-ID: <20251112042720.3695972-3-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251112042720.3695972-1-alistair.francis@wdc.com>
References: <20251112042720.3695972-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251111_202819_416862_8ED293D9 
X-CRM114-Status: GOOD (  10.40  )
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

Define a `handshake_sk_destruct_req()` function to allow the destruction
of the handshake req.

This is required to avoid hash conflicts when handshake_req_hash_add()
is called as part of submitting the KeyUpdate request.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
---
v5:
 - No change
v4:
 - No change
v3:
 - New patch

 net/handshake/request.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/net/handshake/request.c b/net/handshake/request.c
index 274d2c89b6b2..0d1c91c80478 100644
--- a/net/handshake/request.c
+++ b/net/handshake/request.c
@@ -98,6 +98,22 @@ static void handshake_sk_destruct(struct sock *sk)
 		sk_destruct(sk);
 }
 
+/**
+ * handshake_sk_destruct_req - destroy an existing request
+ * @sk: socket on which there is an existing request
+ */
+static void handshake_sk_destruct_req(struct sock *sk)
+{
+	struct handshake_req *req;
+
+	req = handshake_req_hash_lookup(sk);
+	if (!req)
+		return;
+
+	trace_handshake_destruct(sock_net(sk), req, sk);
+	handshake_req_destroy(req);
+}
+
 /**
  * handshake_req_alloc - Allocate a handshake request
  * @proto: security protocol
-- 
2.51.1


