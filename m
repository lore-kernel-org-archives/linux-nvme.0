Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06A35F8E49B
	for <linux-nvme@archiver.kernel.org>; Fri, 17 Apr 2026 00:48:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4e764nZ1zj7blXpuN+ewxQc6AWfbbhaFsma2TXyWpHk=; b=bExKn7gBNyN+oh1XLWepCnMlHY
	nc+RT+bFuZHvC88VSKLRjiiZi2fdp5fGj2g+W05wI/E7MmdVcd33eRwQNPkyJdYd3RiYQCNi/zuOT
	QrhqiHX0ejmPkJ68ZL9TRtfLNH5KNdNG8ed3qo7vc7EyG/ZJvY/m2Etjsjz1/+mawJKNgO/7/plLL
	cyi9ZaTIjl/9fli75FKaBI4PVQBQF6Ypafn/clZ2DrambpPAN1PLGQ5zM4muQEf7IJ1H6oHnKcCXA
	dkMvFg+lEKXakGOw34RMenxsQ9DNqlda3TjDybRw5fWCrc4nA3Zo2/8KQHLwJleYC3VG8Ri4UZeO3
	whR0mXeA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wDXNs-00000003F9s-1GaN;
	Fri, 17 Apr 2026 00:48:36 +0000
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wDXNo-00000003F90-34og
	for linux-nvme@lists.infradead.org;
	Fri, 17 Apr 2026 00:48:33 +0000
Received: by mail-pj1-x1030.google.com with SMTP id 98e67ed59e1d1-3590042fa8eso104599a91.1
        for <linux-nvme@lists.infradead.org>; Thu, 16 Apr 2026 17:48:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776386912; x=1776991712; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4e764nZ1zj7blXpuN+ewxQc6AWfbbhaFsma2TXyWpHk=;
        b=P5Syz8c9PrGewDTqtQwW3lU6k0wQmXuxMtTEZtASzG8LjB42QqR3j+sGH7lvl02jfj
         BvS0WlfXPXRz1AOsqJ0wEOuzrSrfNkdOMN+6PBZMOejgb1nj7KpzqenOmprVBuKLIZdo
         /W+VdzxNLVtaymo/Jdqnjmd7GNNQZTvLQ0msinIjzsHckmwSUgdU+5rD8Es95HXmI01B
         NWjRNOTFlV+OumzvQLRCwwvTZ+1/ynLOjHwHjbmMmAx7z8sDIqaRtpMdixdowxULL3px
         gyVtzB8WbGV3Dm1oLRnIfPpkqKer2tQVH03WwnPrgETlXbvCTljwb591heKkQ6hsXXFg
         WfKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776386912; x=1776991712;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4e764nZ1zj7blXpuN+ewxQc6AWfbbhaFsma2TXyWpHk=;
        b=qCYAG03pP4hCCmoOmhNsE54iP9dEsA6FRgk5P8eYrpWeTGJEjzLYcRaqTzBN6dzX9V
         RhEbWr5llm/kaor+t5erMR3YvLm6pvHgD364SUWrM5sIgcLICRjCgHbastckLZuhkHDy
         TH52HBqyvFwVZhgXc13Y7+N00xv4ckvxbtVtg7ULGv9gM4JfCjOdYhM2L5MPUgsbcim6
         iHFgqjKK4okzjCiL32SGhcHyUopi6WAALppTE2d/q/OoT9QjTRopVs8v4YcXGH4X64dn
         G6MBY069jiDuie+q9zFsFDuwxmV/TGXTYRn6NI16OIFZ2KShkgGVxkx952CXIXZw2uXY
         WuCg==
X-Forwarded-Encrypted: i=1; AFNElJ/fZEphjKOMRi5vL3PPHddMjjeWZ28vwgN1XIlDhQN/mCHfjcqhTlEiy+pO0Li6kK8ni8fB3fzVa1bk@lists.infradead.org
X-Gm-Message-State: AOJu0YxSzJOg/lfeD7tedrtN8FlC8Iy6eKNOMnTGR/0EOI9MtdUFFJpm
	S2yVjc1vES4WvuVjX8PJF4wK5gtDZAkW5xlmuAHL+mr7zc4CF3MRJoo6
X-Gm-Gg: AeBDiesYA4lesiLnqU//FXVpHs05FnqUwBD7HVtPFwWkw4v1pfeHo66Q+dQJ7LGlkZ4
	6P1J79TQl7NlwL91OtRibuo7Lv6dFI6QfMWiS3Jxze5PS4WEFZnoPSYcKQ5e6PXQ6iI4W2t4NdR
	aJlrUlRKZEghMcFMx/YQjRuyv6ItQmMGhm5lcOTfHJQsciH6f16i3xQIVNXKzB7eKWHVC59T+e/
	oZmF86DGslpElQ2GRmfnhEzb16W7UnpCcQLoEB1D3Zl5oJdpJhMsFGt2kBlyet0tw3qxiovuLku
	poR2U57ABjptEJSKOhaXSoJhEiWNjWayMJJIOFoA8rNzNiYphX+SWc4rfXf0vS418j3SfQdifkJ
	eSkE4Fj4zySbG66+BK3OCfZNfpubBX2KFei0Ksod1nJbHGbTO9RHPbOpdGStm3MYZX+I9KUutZz
	fPW2eRri+1tocdEAyS1aqdBeA+kgodB0Gn+rSi4wKGhNDxObmY2ep9w1n5f5U8YQw=
X-Received: by 2002:a17:90b:3811:b0:35f:c729:de9f with SMTP id 98e67ed59e1d1-361404c2053mr579573a91.27.1776386911739;
        Thu, 16 Apr 2026 17:48:31 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:6209:4521:6813:45b7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b5fab3c067sm1057345ad.76.2026.04.16.17.48.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2026 17:48:31 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: hare@suse.de,
	hch@lst.de,
	sagi@grimberg.me,
	kch@nvidia.com,
	kbusch@kernel.org,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	yi.zhang@redhat.com,
	mlombard@arkamax.eu,
	linux-block@vger.kernel.org
Cc: alistair23@gmail.com,
	shinichiro.kawasaki@wdc.com,
	Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH 2/2] nvmet-tcp: Don't clear tls_key when freeing sq
Date: Fri, 17 Apr 2026 10:48:09 +1000
Message-ID: <20260417004809.2894745-2-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260417004809.2894745-1-alistair.francis@wdc.com>
References: <20260417004809.2894745-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260416_174832_779576_480E5FE2 
X-CRM114-Status: GOOD (  12.28  )
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

Curently after the host sends a REPLACETLSPSK we free the TLS keys as
part of calling nvmet_auth_sq_free() on success. This means when the
host sends a follow up REPLACETLSPSK we return CONCAT_MISMATCH as the
check for !nvmet_queue_tls_keyid(req->sq) fails.

A previous attempt to fix this involed not calling nvmet_auth_sq_free()
on successful connections, but that results in memory leaks. Instead we
should not clear `tls_key` in nvmet_auth_sq_free(), as that was
incorrectly wiping the tls keys which are used for the session.

This patch ensures we correctly free the ephemeral session key on
connection, yet we don't free the TLS key unless closing the connection.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 drivers/nvme/target/auth.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/nvme/target/auth.c b/drivers/nvme/target/auth.c
index f032855b21477..1899e9719b12a 100644
--- a/drivers/nvme/target/auth.c
+++ b/drivers/nvme/target/auth.c
@@ -229,9 +229,7 @@ u8 nvmet_setup_auth(struct nvmet_ctrl *ctrl, struct nvmet_sq *sq, bool reset)
 void nvmet_auth_sq_free(struct nvmet_sq *sq)
 {
 	cancel_delayed_work(&sq->auth_expired_work);
-#ifdef CONFIG_NVME_TARGET_TCP_TLS
-	sq->tls_key = NULL;
-#endif
+
 	kfree(sq->dhchap_c1);
 	sq->dhchap_c1 = NULL;
 	kfree(sq->dhchap_c2);
-- 
2.53.0


