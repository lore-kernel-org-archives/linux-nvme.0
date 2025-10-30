Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34A14CCF9E5
	for <linux-nvme@archiver.kernel.org>; Thu, 30 Oct 2025 03:51:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MN0fRpH/PCnIiX5ASSuQg4IoluSNnvJUR3iBGHC2JFI=; b=VTH5jJ1M+xYVZ3AFM6Y0w3aVJ3
	bQbMnIyiDE3iwFdj9Qg7Y4mdt8PHlbiK01QuGASxVQdcPZlgTLsbikZDnJZSvxh4MzRsEGu9jGMyQ
	h+Vi7K6bgIPwWjQ/V77uK14vvsT7jcuIypuKXRKkxWtZQ13TyRxfBLX8SjCbcfnrBT2QaRi+Sznat
	UFhnBZfXjokqxAR0mOLcK4vsc4zjftj5139N9Rik2dELcnjOLp2BJKyDvSN3C3gD86RuHonGItgap
	qmpb6wpCDDKZhocItxMaSkRNJT4lFrRFnzZW4XqMB0QueIzY5khnfcCNGoRMXAAA+a2Lq0cvhY57x
	t8Cc4FQw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vEJhJ-00000003QvV-1b5d;
	Thu, 30 Oct 2025 03:51:37 +0000
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vEJhH-00000003Quy-1y1U
	for linux-nvme@lists.infradead.org;
	Thu, 30 Oct 2025 03:51:36 +0000
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-294fe7c2e69so575915ad.0
        for <linux-nvme@lists.infradead.org>; Wed, 29 Oct 2025 20:51:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761796295; x=1762401095; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MN0fRpH/PCnIiX5ASSuQg4IoluSNnvJUR3iBGHC2JFI=;
        b=kFCeESoNXmvy/sDhOvG38DLwfAVVub4EFnop802KI/UV0Bp/NWLfbtkgKnfb1vczK5
         fzXMYEU2++GCcGrL/yxpCPhp370DTv0fh7xcAJZhHqrF8Bigv9EB0qMUePJa9kDVfqkk
         iryCJpMX+gYm747TveZibAKk/cFIoCn/rYBGJVS9CI/XNfj0T4RY/PhG7fMSZIi8m5li
         V4hzBrn2c/jxETZkMZuV3WR+ICtBCtwA3oIoT2odAbiHR0kZeE1Kg5kQ+ePvM6xD/wKX
         lfPv4TmckH5QCB5n4ryRwHtQSCDgpkchsMIV5VA4MpJZijj2WmlSGyTs8pE1/2zRZMs4
         P8XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761796295; x=1762401095;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MN0fRpH/PCnIiX5ASSuQg4IoluSNnvJUR3iBGHC2JFI=;
        b=HpY/86Gb+7QpTOVTS7MPjMI3xlTyHEhs/tfI76Mj2oDalLhbyMKenEK/ibH/mni7fr
         YJVpwINiSITzZQZbZiaGQ+XVWpIFWFUYGpPF/HSIU7Arq5qDcAp3i89jPoK73wvFxarH
         57CGN9qwCWeXcgn72d5kbg+uqpqjhP063mHDZfcZopuUd9zNknqQL8nY/5cVUK0zRWwn
         AoQ+c58He6yNWG8vry+K6YmalqNxXvf3/BSrZ/7ClWtyRl28xTfDc6FOEu7Wkhcm83PS
         U0h4kvpGTjptaClb/HYMHQtGeWzTfB62XFnKBD2BGbPu3JKk4y6TlQWE90JouaDi3Fhg
         W5Gg==
X-Forwarded-Encrypted: i=1; AJvYcCU73ETNIc5khHwjv7i7WK7nmhrzqJoLyqz9IJhBELejuANfIUq7QeANOsbw4fWfgka8QojVFfFqk87v@lists.infradead.org
X-Gm-Message-State: AOJu0YyvXCkzJwN3u7lxZacH7Czancyp2dO2/qs6chfLemWR66NUfW8D
	r4Q1lbGQpRwQjt/12Hx6SuwF7J7Y323/hNN2r/VSsHl76or3OW1Tmg1VEVMVzg==
X-Gm-Gg: ASbGncsgrDa0cN6tLuoM09o5QhrglcPeZOLb4+LmvmdoXCwtgescN0oOkVpT1sCF1ip
	aHBXFdjZvni/PN9nSi3CZKeOfwQiR6vZdq14Bum6q5meR1vcqwJ1jL2ha/Z96XWViZkcqrHGJYE
	+ysYZCZ6p4Mve44L2nbdDA/E7sjQr/QVKg8mBBY2UqKDPe7ja/jQ9YwpqeWJ8yCb3DBcye9JrJ0
	WF4ZUQ9CHT15uYvl2QxZbSEIPRLSwW/3cnLchWxwKujPyMhXs8/zWjQIB2cDuzh2jqn3nlfX5SP
	Hd/ZrTKkhEu5DeFSCCk3pEBbDyLEmtloaTAX65S2XDQ/YKNWqljguE6BxWa9V9VGSGHiNHI4YDb
	qZu8Q6Z53YcQaP5Yrk3xdN9IvjiLkdG8fYvxTqOTfc5GRF7VMiSEpF74NhHWRdM+cQU2+VpcRwK
	P37QkqN5G+GHZmV+kbXm6n0sQX2rfUvDTx6BB2oHprc29D8g1Qk+9hFEIUKKfr+Uqmss8iPqyoS
	Nv+x/IorA==
X-Google-Smtp-Source: AGHT+IFDmCt6OxS1lG5usvyxQO/ayx75zbEn+wDdcRO8migbMEW884MG+r2fTQz9vUZXdmTRBF86sg==
X-Received: by 2002:a17:903:2344:b0:24c:d0b3:3b20 with SMTP id d9443c01a7336-294ede8b3d5mr19471615ad.37.1761796294581;
        Wed, 29 Oct 2025 20:51:34 -0700 (PDT)
Received: from toolbx.alistair23.me (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net. [2403:580b:97e8:0:82ce:f179:8a79:69f4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498cf3381sm167953225ad.16.2025.10.29.20.51.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 20:51:34 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me,
	hare@suse.de,
	kch@nvidia.com,
	linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	alistair23@gmail.com,
	Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH 2/3] nvmet-tcp: Don't free SQ on authentication success
Date: Thu, 30 Oct 2025 13:51:13 +1000
Message-ID: <20251030035114.16840-3-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251030035114.16840-1-alistair.francis@wdc.com>
References: <20251030035114.16840-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251029_205135_512998_E3E5A8E8 
X-CRM114-Status: GOOD (  12.96  )
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

This patch ensures we don't free the TLS key on success as we might need
it again in the future.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 drivers/nvme/target/fabrics-cmd-auth.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/nvme/target/fabrics-cmd-auth.c b/drivers/nvme/target/fabrics-cmd-auth.c
index f71456a94b66..5cb857d21dfd 100644
--- a/drivers/nvme/target/fabrics-cmd-auth.c
+++ b/drivers/nvme/target/fabrics-cmd-auth.c
@@ -574,9 +574,7 @@ void nvmet_execute_auth_receive(struct nvmet_req *req)
 	status = nvmet_copy_to_sgl(req, 0, d, al);
 	kfree(d);
 done:
-	if (req->sq->dhchap_step == NVME_AUTH_DHCHAP_MESSAGE_SUCCESS2)
-		nvmet_auth_sq_free(req->sq);
-	else if (req->sq->dhchap_step == NVME_AUTH_DHCHAP_MESSAGE_FAILURE1) {
+	if (req->sq->dhchap_step == NVME_AUTH_DHCHAP_MESSAGE_FAILURE1) {
 		nvmet_auth_sq_free(req->sq);
 		nvmet_ctrl_fatal_error(ctrl);
 	}
-- 
2.51.0


