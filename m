Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 073E0E71D4F
	for <linux-nvme@archiver.kernel.org>; Thu,  5 Oct 2023 16:14:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=xBF/uFJVvJ7YTUEt6WwDwwpmUQaEEUWvnNqj8YdJfwI=; b=u2IsKLoYOtWOv5Hs/d1Y8whVKa
	E+nSyvDUj6Xoh6NoOL5lG+hv9oR4B8w8rXTIXEAspZE7ht4eaFXVuOme8Zw8cPefW5TWkFn9rOJwg
	2zzEAMkE3f1jQf5/6T9J08Yxx+gVcHEHrY2jAu425VjTaawE6Vyi6wtujErwob9+Kt9VIbyeX1Mlp
	IyTFlXhgthg51HAvlQnQ8SMZ7mfYdrIyUUy8PV0c64JPZjWHcP+6SgpemBN34qMwwUExVH6Niey6J
	lVkYVAYCQWltp3UJ4SZc6xu50eJLKjGB74FSIinJUYyGUbG9aDN+DNEetz3cmtqmM3JNxmyiX0UWT
	ej2qdr5A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qoQzV-0041rk-00;
	Thu, 05 Oct 2023 16:14:21 +0000
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qoQzQ-0041qt-1z
	for linux-nvme@lists.infradead.org;
	Thu, 05 Oct 2023 16:14:18 +0000
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1c62d61dc96so8371855ad.0
        for <linux-nvme@lists.infradead.org>; Thu, 05 Oct 2023 09:14:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696522455; x=1697127255; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xBF/uFJVvJ7YTUEt6WwDwwpmUQaEEUWvnNqj8YdJfwI=;
        b=cq10TdackUsk/UjeDPOdrqWD446+E7MsV+algW5bCO1ag/tNR5SIEnOR6Wl5GMd/Qz
         GxogfcztdYiy0SScg0XY7OsUPCdiVNOB81JSXXZcEsAUQsUHl7OZNaE2FyAZgxZ6fI8T
         OSgl61KRgP+qi4nQykDXN2eeNoxncfZBYgl4s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696522455; x=1697127255;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xBF/uFJVvJ7YTUEt6WwDwwpmUQaEEUWvnNqj8YdJfwI=;
        b=weciK+SpCSow43cXdS6iZmeTxB+erUkJRP93yhJU3Vqg5JVmYdqwprceuGG3JV+pgw
         tJHB8/04zSVrAMWOOSAcrKkcxdrhGfKWnw9LREN1SdifNTIburH+Bbpe2Gm/3+1uflS1
         Ou7RBUClpkpgQwO3l1yLi8MOrJizffvjW/M31Ebsv67SOjPtYmDgTuFBjkhg1vdCB7GG
         NuWdgWYu30uzk4LdBF+apTFJzD6D4Q5IIVf9AkzCMDJrByDOmlKHu4eFaVsrLCQU6o7v
         V2vFbjaqf7zzKSBPaBaTbyc8BFIXsyVoWQaEEeFa2A2I22yJCd+/3ezcDY2rj4ATf9+z
         +pGg==
X-Gm-Message-State: AOJu0YxoSPbftuVhrqFbNzLPJMvF30FtB5YonkfSKMA9S/dlvhRJyGC9
	tajwnHx827MjIaZmcot2F14NJw==
X-Google-Smtp-Source: AGHT+IGEiAWvdJBH7vw0BMgCGCiF3Mgfn0JsxTp7iLsTYooxV9aBdAbTG33uN0QT0rwuirwD86o/pA==
X-Received: by 2002:a17:903:110d:b0:1bb:d59d:8c57 with SMTP id n13-20020a170903110d00b001bbd59d8c57mr6223640plh.18.1696522455224;
        Thu, 05 Oct 2023 09:14:15 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id iw11-20020a170903044b00b001ab2b4105ddsm1908267plb.60.2023.10.05.09.14.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Oct 2023 09:14:14 -0700 (PDT)
From: Kees Cook <keescook@chromium.org>
To: James Smart <james.smart@broadcom.com>
Cc: Kees Cook <keescook@chromium.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org,
	"Gustavo A . R . Silva" <gustavoars@kernel.org>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Tom Rix <trix@redhat.com>,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH v2] nvmet-fc: Annotate struct nvmet_fc_tgt_queue with __counted_by
Date: Thu,  5 Oct 2023 09:14:12 -0700
Message-Id: <20231005161408.it.584-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1706; i=keescook@chromium.org;
 h=from:subject:message-id; bh=/lvW3aKbNdffAyIzlZf6gptKlwtHFiNZjl+aiSSruKE=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlHuDUOvSUL7xliWcJbrUDOxdv4EUfSnKX5nVYU
 HaIdxE+uD+JAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZR7g1AAKCRCJcvTf3G3A
 JiKOD/96Q3m/bw8VJQ0KeM2IuPUQ633i3udn5aE3jXFjW+0sbngxXC3XfZhjBPWqskqZeuFQt/7
 C79xRJkXdJad1LJ7YM24WaCnCt+fl97aXOTe9PxxPcb1AcG4vXEGxDvTbNYMLjs8FHj2xqM1YbW
 Dn8wFtBa0znQB2zkit7kGuGEK08HMpZWo9wau5NjzVRERVhH69QRP1XFBi/cyj9ipeOXNK2wsue
 3xBl9/iAexBwfkye17sBM7Tbb/63Vc2tK3VPlS823E7C7v/ZMLL5fRI71scSzDrEJPWlixjK6Uv
 Hwh8dFGSftd5OxMzHhdhZ7QgnCUhvY+q/+6fFjSVDfdYRQ2l3cvFoxxmPh/pKjzj2/CUXCmMCf4
 t01h2bm1zOWaYPqcNG1QcbkujeaIzZ5urnIPANLs7x4rtJ3atmjqBmsdVrtMIPR8jT+MSoWnYlh
 1vHZJeMPKspJrVFDFTUnI0N9CW5yE3ItLGWxYdWQ5g4gnMg1ZadPqj/m4zL3lGZ+mDeUD8cZaC7
 bLE1/1rvg/yhBuLIf/9b9fP2P0eobnoGNccZYVMn7Ca8IGMViNPrd0lV72V9U4mV4blRV2JXAjH
 Q2vFfDlimFZqEizGr9sC+SD368iX6rnr4xv8yXJOKnlr8wcYt20VBySEQfjg4aKu43PgU81/X9v
 guQwQ4r EcbVCq3g==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231005_091416_688585_81AABC9F 
X-CRM114-Status: GOOD (  14.58  )
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

Prepare for the coming implementation by GCC and Clang of the __counted_by
attribute. Flexible array members annotated with __counted_by can have
their accesses bounds-checked at run-time via CONFIG_UBSAN_BOUNDS (for
array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
functions).

As found with Coccinelle[1], add __counted_by for struct
nvmet_fc_tgt_queue. Additionally, since the element count member must
be set before accessing the annotated flexible array member, move its
initialization earlier.

Cc: James Smart <james.smart@broadcom.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org
Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
Link: https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci [1]
Signed-off-by: Kees Cook <keescook@chromium.org>
---
v1 https://lore.kernel.org/all/20231003232511.work.459-kees@kernel.org/
v2
 - move comment to line above (hch)
 - add reviewed-bys
---
 drivers/nvme/target/fc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
index 1ab6601fdd5c..bd59990b5250 100644
--- a/drivers/nvme/target/fc.c
+++ b/drivers/nvme/target/fc.c
@@ -146,7 +146,8 @@ struct nvmet_fc_tgt_queue {
 	struct workqueue_struct		*work_q;
 	struct kref			ref;
 	struct rcu_head			rcu;
-	struct nvmet_fc_fcp_iod		fod[];		/* array of fcp_iods */
+	/* array of fcp_iods */
+	struct nvmet_fc_fcp_iod		fod[] __counted_by(sqsize);
 } __aligned(sizeof(unsigned long long));
 
 struct nvmet_fc_hostport {
-- 
2.34.1


