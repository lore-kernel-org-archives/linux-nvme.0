Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7670C25B75
	for <linux-nvme@archiver.kernel.org>; Wed, 29 May 2024 21:42:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=2M9QOgGbjtRQ2V4o9qEqfP0dOe8D2N5JQ4/qGOABzAc=; b=waVKOW66JhDyUAeqe/XsfA1NSK
	OkRjD0LljDSlnKPIUj+OEfjcQKFaX8lPUtJ1Sx8isH1gsQrWMMIzZY28wf3fylclogLUqaf9+k1e8
	ApzWQuu5I7LntTYvuXIT08flfRXtv3PPr5z1CuNR2qutJ7+fq06rlr52sll9oRlbDVH7Iip087d/N
	8D3DtAbRymxrdIS+xxd6B3uFTXSwtZ7wD3j7VwC4haKgGetPhATXMCyJBF7q7jryYVpRHTq6SGRAD
	M62eTjjKnXJBvdbulSgcwvTXiW4qr+KHkcXvryiH6H0RhLWeMbVYaVHd27GkroYnWFAiQtohT4nBe
	WSHD007Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sCR4P-00000005cOY-1UpY;
	Wed, 29 May 2024 21:42:53 +0000
Received: from sin.source.kernel.org ([145.40.73.55])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sCR4M-00000005cNf-23sq
	for linux-nvme@lists.infradead.org;
	Wed, 29 May 2024 21:42:52 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id AC8B9CE1764;
	Wed, 29 May 2024 21:42:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17CFEC113CC;
	Wed, 29 May 2024 21:42:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717018966;
	bh=PrJQxMmS5LHKVU/EWMJ417PqE4hDeduiM64YoyvEzYM=;
	h=From:Date:Subject:To:Cc:From;
	b=G6I6i+uUfePjluSUN/8e6Tlzu/C0vl6O5qd6P1nt+HOjb8v6KRP7PurU55Bg2IUSY
	 gm+qeUTHt0YpsRQ/DTJ+fGjdurWISS5ENLQwvtGx7AqJNbUbfXl4ojg88AZA0ZulgQ
	 edW6/f2ZV+W14SixY1itbvPVNYyAxYs4M2iahlttRWpLpidOMqV5T5Mb2d4g0x2sJL
	 TdT0wtueFE1hCXZi0LvT/MUwupt0ridBSp1WHYVxGWsperil39z9bC733mKHjHg8R3
	 7sGAvmQmATGPGtEQHoKdkGrDNYp+vS1oLJfUoD23JT/r05vi0ibMuHMU7gvPPOxj47
	 DQJ4xwMikeQEw==
From: Nathan Chancellor <nathan@kernel.org>
Date: Wed, 29 May 2024 14:42:40 -0700
Subject: [PATCH] nvmet-fc: Remove __counted_by from
 nvmet_fc_tgt_queue.fod[]
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240529-drop-counted-by-fod-nvmet-fc-tgt-queue-v1-1-286adbc25943@kernel.org>
X-B4-Tracking: v=1; b=H4sIAE+hV2YC/x3NTQrCMBRF4a2UN/ZCDFbUrYgDzbupGZjU/BSld
 O8Gh9/knFUKc2CRy7BK5hJKSLFjvxvEPe9xIoJ2izX2YEZ7huY0w6UWKxWPL3xSxOXFCu9Qp4p
 3YyNGQ1XrT3o0lB6bM334/EfX27b9AGh/2qh4AAAA
To: James Smart <james.smart@broadcom.com>, Christoph Hellwig <hch@lst.de>, 
 Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>
Cc: Kees Cook <keescook@chromium.org>, 
 "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
 Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
 llvm@lists.linux.dev, patches@lists.linux.dev, stable@vger.kernel.org, 
 Nathan Chancellor <nathan@kernel.org>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2507; i=nathan@kernel.org;
 h=from:subject:message-id; bh=PrJQxMmS5LHKVU/EWMJ417PqE4hDeduiM64YoyvEzYM=;
 b=owGbwMvMwCUmm602sfCA1DTG02pJDGnhC0OVDR7cThJnS5CUrK/pXtt6dLv0nTVXKn9wb9iv7
 M5SbP66o5SFQYyLQVZMkaX6sepxQ8M5ZxlvnJoEM4eVCWQIAxenAEwkVojhf0IKxxuTGVNu9DPP
 khHSMrnLl/Lg9nEt/VDrn13qARELXjIy/FOR5TwVfOa2oYkan+uOKWXLHsun7N512PVL/OR2yTd
 t3AA=
X-Developer-Key: i=nathan@kernel.org; a=openpgp;
 fpr=2437CB76E544CB6AB3D9DFD399739260CB6CB716
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240529_144250_914252_B9B6FBAD 
X-CRM114-Status: GOOD (  17.11  )
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

Work for __counted_by on generic pointers in structures (not just
flexible array members) has started landing in Clang 19 (current tip of
tree). During the development of this feature, a restriction was added
to __counted_by to prevent the flexible array member's element type from
including a flexible array member itself such as:

  struct foo {
    int count;
    char buf[];
  };

  struct bar {
    int count;
    struct foo data[] __counted_by(count);
  };

because the size of data cannot be calculated with the standard array
size formula:

  sizeof(struct foo) * count

This restriction was downgraded to a warning but due to CONFIG_WERROR,
it can still break the build. The application of __counted_by on the fod
member of 'struct nvmet_fc_tgt_queue' triggers this restriction,
resulting in:

  drivers/nvme/target/fc.c:151:2: error: 'counted_by' should not be applied to an array with element of unknown size because 'struct nvmet_fc_fcp_iod' is a struct type with a flexible array member. This will be an error in a future compiler version [-Werror,-Wbounds-safety-counted-by-elt-type-unknown-size]
    151 |         struct nvmet_fc_fcp_iod         fod[] __counted_by(sqsize);
        |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  1 error generated.

Remove this use of __counted_by to fix the warning/error. However,
rather than remove it altogether, leave it commented, as it may be
possible to support this in future compiler releases.

Cc: stable@vger.kernel.org
Closes: https://github.com/ClangBuiltLinux/linux/issues/2027
Fixes: ccd3129aca28 ("nvmet-fc: Annotate struct nvmet_fc_tgt_queue with __counted_by")
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 drivers/nvme/target/fc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
index 337ee1cb09ae..381b4394731f 100644
--- a/drivers/nvme/target/fc.c
+++ b/drivers/nvme/target/fc.c
@@ -148,7 +148,7 @@ struct nvmet_fc_tgt_queue {
 	struct workqueue_struct		*work_q;
 	struct kref			ref;
 	/* array of fcp_iods */
-	struct nvmet_fc_fcp_iod		fod[] __counted_by(sqsize);
+	struct nvmet_fc_fcp_iod		fod[] /* __counted_by(sqsize) */;
 } __aligned(sizeof(unsigned long long));
 
 struct nvmet_fc_hostport {

---
base-commit: c758b77d4a0a0ed3a1292b3fd7a2aeccd1a169a4
change-id: 20240529-drop-counted-by-fod-nvmet-fc-tgt-queue-50edd2f8d60e

Best regards,
-- 
Nathan Chancellor <nathan@kernel.org>


