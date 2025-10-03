Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52411CAC5B0
	for <linux-nvme@archiver.kernel.org>; Fri,  3 Oct 2025 04:32:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jOV0qGYLCq+9ZQ//0z9A3z+3aG29/4P327MFfqw2xrc=; b=2AWA+yMB6iIP6irgg3QMsk48tm
	RfeltbDmmoNSIpH36k1ch5oT1f0Z2KfbPFpFbsl+k/VkNKXpFk0KPWM13qaymhNJ5GPbD7Trong+2
	DvecBvW7VGY99uPR4HR4RCNRp7RDpiVQRRddvGexNJiDmB/vuMkF9XxYN4x+VH6CFjPYCQQdUUvo6
	W0Ey0fSpORwDUTeqb2WQgPnwoVpJOEuwYpwqpGcPLzD9mkxFMz56QNAYcsf4zxbv/v/zGbBteZDcR
	mum1ftGhX2u2E7ozUbECeGsddTy1ZOY0phuzNfmhv+DDrgOqlHagTOTN+bAeKQu2LszXwEjYc+N4V
	LAFYuTKQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v4XT1-0000000BdvH-2Vc9;
	Fri, 03 Oct 2025 04:32:27 +0000
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v4XSz-0000000BdtW-1IYC
	for linux-nvme@lists.infradead.org;
	Fri, 03 Oct 2025 04:32:26 +0000
Received: by mail-pj1-x102c.google.com with SMTP id 98e67ed59e1d1-33067909400so1340219a91.2
        for <linux-nvme@lists.infradead.org>; Thu, 02 Oct 2025 21:32:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759465944; x=1760070744; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jOV0qGYLCq+9ZQ//0z9A3z+3aG29/4P327MFfqw2xrc=;
        b=bLyufyUz1CGvhTHmWtpLDUQntuf6RFacuabLMEfHv7QjjaIDJlxr5FJxDHJdCWKyPZ
         fe6H5hOn9tePh2Mmfir4JGJq8H7erifcHdgtGZA8LKr4Li/PeGniv0I0j6CRulDZjLf7
         TXOianVfxIiga2cE81ABlRRuqF+atVXzjC/LfcJ+9ouLOeJaL54VkKt7dTsGJNGBBRd9
         4eFG9MvmmQPdAcmb0NfC/+8iM974Tct841ZP3udJP0GAOPENS9NgTBSeC6bWdIZWKy6s
         3YEduD8RNllXUxWT2oJ4/kSxE0mXlMpuJHXHvjwCIYYhCixm59cKw75NuNSdkJBMODZ3
         J36w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759465944; x=1760070744;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jOV0qGYLCq+9ZQ//0z9A3z+3aG29/4P327MFfqw2xrc=;
        b=Mw0gYFMK6Q0hFgyk4hK82526lXFcANkMU2pTs0WtbpWTh1xpWEgpSwa2RFWAEL3CTy
         cDEqOKFxpLWqu3afeYBSimaAx8m1gznUbySLYpZfGuHFX6yCjftEDDxTZZmdn+UnjoHt
         exTeVSnTR+TiScMzj0lfaZm/efow89VyHiAUyW7MIavKgU1sZJ/2WIBRa+GBv0Ltcrue
         kiqmzOazvnouvaNbQD+tI6guahC0+5U4r+p8VmVAC1qzeBGzDgZf+MTv7KtMTEpmtCK0
         pm757VylZjGWKFvGDKNWuNMENEmCktTihE28xxMoIaNPiY0DQYEEDXv61YomLlQCwadk
         Qv6A==
X-Forwarded-Encrypted: i=1; AJvYcCU3lDkFKKOcq0T1QyFzpZhWWUZebn6fPYtcd2fkOt3XmFScOzMiSC/yEJ6C8FhCb/5SXBbYYpZ0VhNS@lists.infradead.org
X-Gm-Message-State: AOJu0YxXh9wnLVfrVNmz9+W1W6WAgbUgQv6MIflDgRnf1uIYjjNmCEpL
	k8JdSWniL0HWQ2+BDdypW7nzpxs7VxYCn7111dV0rAoqKQSV74gqAU1O
X-Gm-Gg: ASbGncsTpfe4X5b7ouL72rnuo9jZU0Kyn2bhXHIAeRHKfHZ87XOB43UBUsNucBkxMzc
	NmBsriE7nJW7G+Xbp6EUaXmbznG/5gwsXOMNzwKpMphjmn56lmCK13GJdbybNfknXcC3+vONARO
	+gtim/lt1z9OU7us60AnKdtLZD0gP+xN0S+loEUUEZ8OWs2IPxVQtJotz4ZFLUjKy7PJzM/DnD4
	IkubtJ64sOo8MCGftCXkpFv65ndWxYvh4sbpCNUkTiqJWR+5MT83woLw2BNrzSElARowHSKrYp+
	Kppekr++TYsakM7iQXgByTdlYw42M34H4D2tcgeSQ62QsZDD7T5gSLkS6nxcbvOJhmxaj+4+55F
	gD+0lk7T2FMA5I0UYd9iY3EGS6Wqd3d+tiTzcULXAdnJ+7foXqmea1Donl6bgEiI/w51dJf+us8
	RBfqKk4iDnd1J+brbRkZNLQMEWxyLT0K07YV4Nec+bHBUGDcYPXR35Hqn1zhGuKDo=
X-Google-Smtp-Source: AGHT+IGCDoUIKtDX/52HGaffkclK+hmjaIJ+Bue+zX3dUNN6Q+cAazG3rbJtO5YII+rQ/2wJMc8/6A==
X-Received: by 2002:a17:90b:1d92:b0:32e:389b:8762 with SMTP id 98e67ed59e1d1-339c264f452mr2016481a91.0.1759465944489;
        Thu, 02 Oct 2025 21:32:24 -0700 (PDT)
Received: from toolbx.alistair23.me (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net. [2403:580b:97e8:0:82ce:f179:8a79:69f4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-339a701c457sm6528233a91.23.2025.10.02.21.32.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 21:32:23 -0700 (PDT)
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
Subject: [PATCH v3 3/8] net/handshake: Ensure the request is destructed on completion
Date: Fri,  3 Oct 2025 14:31:34 +1000
Message-ID: <20251003043140.1341958-4-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251003043140.1341958-1-alistair.francis@wdc.com>
References: <20251003043140.1341958-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251002_213225_350467_C42B9A4F 
X-CRM114-Status: GOOD (  10.02  )
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

To avoid future handshake_req_hash_add() calls failing with EEXIST when
performing a KeyUpdate let's make sure the old request is destructed
as part of the completion.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
v3:
 - New patch

 net/handshake/request.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/handshake/request.c b/net/handshake/request.c
index 0d1c91c80478..194725a8aaca 100644
--- a/net/handshake/request.c
+++ b/net/handshake/request.c
@@ -311,6 +311,8 @@ void handshake_complete(struct handshake_req *req, unsigned int status,
 		/* Handshake request is no longer pending */
 		sock_put(sk);
 	}
+
+	handshake_sk_destruct_req(sk);
 }
 EXPORT_SYMBOL_IF_KUNIT(handshake_complete);
 
-- 
2.51.0


