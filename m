Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A97C1606A330
	for <linux-nvme@archiver.kernel.org>; Fri, 13 Nov 2026 16:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=YHzo8inQ;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=e5uR8V4V
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=kLAcGg2VCpo8eOUcmFqEoR8opJZbxlMwwMLnuPqaB0s=; b=YHzo8inQJzYkhZ
	gxNz9Jz0EB6d3VxM/3nMJ3cCzqFV7HCubRF+QmP4/DpFcJvIwarzTrfiyUfzi2qYQ7r/+ppPdy8Lw
	L2KbwOo4midgvpHeXMnBWPuisY24QZBVEjM9igxKU/Ovoe07IwTKM5cF5+VwsKgbQh38hN30P5Hh2
	myImzzDnFTMBA3eCqhzU9hzLTC5ZZiIylVolnbsVRUGypraDZliDmTn88qA2328Bho7GH+C9d+b0V
	AnYZxpqqljHyjzPwxaDVGYW/HUl4xVJsMA/Ylc1GZMvB4RKwW3buQ/IiKZQvh+J41JogZ7TpFp0Ku
	8QD7FDPv71pnfINZAxJQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRuTt-0000000Df7c-1XwY;
	Fri, 13 Nov 2026 16:50:29 +0000
Received: from mail-dy1-x132f.google.com ([2607:f8b0:4864:20::132f])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRuTq-0000000Df5s-3Y5g
	for linux-nvme@lists.infradead.org;
	Fri, 13 Nov 2026 16:50:28 +0000
Received: by mail-dy1-x132f.google.com with SMTP id 5a478bee46e88-37986eb6fa2so2845975eec.0
        for <linux-nvme@lists.infradead.org>; Fri, 13 Nov 2026 08:50:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794588626; x=1795193426; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kLAcGg2VCpo8eOUcmFqEoR8opJZbxlMwwMLnuPqaB0s=;
        b=e5uR8V4V17kuTTEzBhbrWT70yZTKERlJTfd01+Wwo/FpRtwySj1aUeZ4oYYPC/mSHB
         +kLJxSk20bYDyXwCW5EJeZPtpHOlMkSTYp32Ebr1gvyKvay+HrafX7NlvITQNlnYUbI2
         awgwB/P4IGdyOl9FVhZnExzdryDGDFRDGORb4fW+f5VLUaSwo9JukShBNezHWZZpKyok
         ywsa7Fm4EUWBX6q1/AvrpH3J8LchEr7VmuPccn5EQskv0/CWsY95wwBwT/548Msa2mV3
         kK9XQRiuOZ5gY6gRlUnV/e4kGKTy611C5QTIrUYE+uDYYRp6gc8n4pZ1gMoYlLulcyS3
         qfig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794588626; x=1795193426;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=kLAcGg2VCpo8eOUcmFqEoR8opJZbxlMwwMLnuPqaB0s=;
        b=aAUglfS8LRflnhpnARzq9TdujrZzXTCXG5klB8TJxCNbAnx+2RLbFWYTxy6IxCLJyL
         kWZJ7iAhg+3x3zCKlD3WWsWU4qDYPAGnrhNAUg9Yzc25xmz9r4G3NDVTqnzJKQvQXnyT
         SKFRSRpCHXiEbMsnvow5YYuVRi8sw6C6h+MC38Ayhwlj5CAfGTK0l/7dGG1BA9KG+1X8
         VLsOly++qi62xcbqzHeB+qCwYMACt6rCcOs5EkO08adST9hIQjnIMBlDLQoOEj8qtcj6
         oKNC3IOwp+34bWnCuBE5J5MSzF/x9y59TGKB5luA0zN8Bwb0dkAGr/Hn42MqfOtS7/OB
         DG7Q==
X-Gm-Message-State: APuU4Z9/Dt2L5txmqkduEGEU936e0r8O05xpp6OvUVKlklmC0kcxcX0l
	fstbyFPMr8bjmASQI7YBH5x04sK03ocR8vRc6ISaVTKcXsnCe22om0i6SVOIWLDR
X-Gm-Gg: AYBFou2Iz3KzQg8K5CEN3BT0LBTh6jcCBgWIvjdCoxnPr9gcCiEkSVCbRmgBa4sbTe3
	rCyjZQVBxi4rt4JGIpboxCI+PDHQwhuvvYzdjSru9JUaK4IOjLgCNJsofSHfvHo/U9MwZ2SbfPJ
	Z51JBudrGYHES06HecEWEIaLJrBsB8i2GlFpnYE4LfG5bftcLMDQmDIw9KucHaPGxv11OmUdC/m
	ftT6HPBjw+oclAwf3hLuh+NXSFVLFmX9fclQN/XCv28W4oPX/+nFkOfO2OYNQlyURin063CycTz
	ys+HGKolnAll6NRrRLfvu0ou/1XAFoImBoJ6192H7PUoX9sqp6mIuyRjUyZgeoNGaf15XQmMBd7
	oniT7LvazO9RPKSQ15RUzuu7g1XUyEFX+0sSz3UAaFk1udAM6rgkrUWen33G1j0T4toofFMdYSb
	RVxH131bRUbjlTk7Ol3JdkE8GToLhoubTLek/LNxLjyk1SHlxYM25dOxa61jiqjUFbX7IazR4P0
	d+xKIPVvH8tTI711bBRyx3wXqm1xmIi/Jpc6jpNS1QXOsPQXScjxMPxuN3/pT86o9u1yAdvpoFc
	D7V5f14UXc7Kd7GNgQK+1BIuCkP33Wk=
X-Received: by 2002:a05:7300:478e:b0:378:314:402d with SMTP id 5a478bee46e88-3796666e0bamr4156888eec.14.1794588625465;
        Fri, 13 Nov 2026 08:50:25 -0800 (PST)
Received: from Ubuntu.netapp.com ([136.226.242.199])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-37955822d58sm8284403eec.10.2026.11.13.08.50.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 08:50:25 -0800 (PST)
From: Martin George <martinus.gpy@gmail.com>
X-Google-Original-From: Martin George <marting@netapp.com>
To: linux-nvme@lists.infradead.org
Cc: hch@lst.de,
	kbusch@kernel.org,
	sagi@grimberg.me,
	loberman@redhat.com
Subject: [PATCH v2 2/3] nvme-fabrics: bound keep_alive_tmo to avoid overflow
Date: Fri, 13 Nov 2026 22:20:01 +0530
Message-ID: <20261113165002.12536-3-marting@netapp.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261113165002.12536-1-marting@netapp.com>
References: <20261113165002.12536-1-marting@netapp.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261113_085026_903039_4C554F15 
X-CRM114-Status: GOOD (  13.08  )
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

keep_alive_tmo (kato) is only checked for being negative, yet it is sent
to the controller as "kato * 1000" ms and used as "kato * HZ" jiffies for
the keep-alive timer; a large value overflows both.

Reject values above INT_MAX / 1000 so the millisecond form "kato * 1000"
stays within 32 bits. kato is unsigned, so the "kato * HZ" jiffies form
cannot wrap even on architectures where HZ exceeds 1000 (e.g. alpha).
This mirrors the target, which caps kato via NVMET_MAX_KATO.

Signed-off-by: Martin George <marting@netapp.com>
Reviewed-by: Laurence Oberman <loberman@redhat.com>
---
 drivers/nvme/host/fabrics.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index 25029978b978..b4ca0f9fd703 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -837,7 +837,7 @@ static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
 				goto out;
 			}
 
-			if (token < 0) {
+			if (token < 0 || token > INT_MAX / 1000) {
 				pr_err("Invalid keep_alive_tmo %d\n", token);
 				ret = -EINVAL;
 				goto out;
-- 
2.53.0


