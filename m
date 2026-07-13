Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B6BCC44507
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Jul 2026 00:39:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=36vOZDALNAgY0RqVZNBYjWMe278u5F6nRXkzEDxG8SU=; b=y2KVqRbpOIzYFpEq9s8IroTyVf
	mXdS7IVgQCHLdmXm1RlA2xPKXfqH2xRY91mOWUJHHw9cGQrB/a6MHuFQihipd9ITMDgdM/C6gR+EK
	HBMSQ08UNkQtOtLMgE2N4dfckYulu0C6idnHNHMjLLdimqeYU2yxcBijBA1LuzSNwTn5ZfilDYfaq
	YWISki5E1P/vxVgFWgIosDLl6+v7jypgtiFG4qWybcpNwB9spIftv+ieJpdnEVpUH9q6V8LBip2hK
	LdNAwrODTIwr11oXLq4nfNBO5zJ+pTlPCRkHXs8a87iCJYLn08+RVo4IwKu1l398whhUsm/ncckjj
	NZIHTigw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wj4i5-00000007sjd-02pU;
	Mon, 13 Jul 2026 00:39:49 +0000
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wj4i0-00000007sfU-2Kye
	for linux-nvme@lists.infradead.org;
	Mon, 13 Jul 2026 00:39:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1783903184; x=1815439184;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=465hUMJgrZHFvP3qJLCLn0CTMsoJ+Cy8J28PgnG6nG0=;
  b=dQ+M0I6zgMVNVkNgV0LW6xFj+jEMkP3aLgL9NICqLh3f0wPFkdPX+NyP
   9aKgfbLaNBf9OKJ7jKMqA8u+MFInW/7g/tQViGAyjE4XpMJrCFoAvfC77
   +3sXF/t4KKmG7DBx7bOP2XVj3dsVpZ+zbdpppmrdvDIqb0ixf9V3xmNGX
   VxsHn2UsUuuokkNhPOwNTNJiBjoOOjBhh2Po16/v9iftLUCmI27Rpob75
   jZ0XVjp++4Vdw3EMRBWd4HlGm6u1P0h+wRwrAOb0h41NuOmyM+zOhax0s
   7EtwMPujJKGlkrK305xIpZaK+GcWm1vAaLfNxQAVdcRgPrn6bMGY3Oa/e
   g==;
X-CSE-ConnectionGUID: YA48l0H2Qvi+h2qDqeALQA==
X-CSE-MsgGUID: kKQ9kLuJSd2/b493IIcXsg==
X-IronPort-AV: E=Sophos;i="6.25,154,1779120000"; 
   d="scan'208";a="150596183"
Received: from unknown (HELO uls-op-esad1-o.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 13 Jul 2026 08:39:40 +0800
X-CSE-ConnectionGUID: NOiAYlXoRTKhPYVCtiW51A==
X-CSE-MsgGUID: W9HVkxPvTsmFTr3xra6sqg==
IronPort-SDR: 6a5433af_3MCMvbBxpj6Fj0IJBp8ld8SODwEYPbvjD9jIztPcCiSihVK
 UslCdZMTwE6QnkLQOO7hn2mo0lNH8EskMlZoIXw==
Received: from uls-op-esai1-o.wdc.com ([10.248.3.45])
  by uls-op-esad1-o.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 12 Jul 2026 17:39:11 -0700
X-CSE-ConnectionGUID: L6fFZhjyT96FOABL8sVn6w==
X-CSE-MsgGUID: K1ACUwcWSTWwi0xCMVDsDQ==
WDCIronportException: Internal
Received: from unknown (HELO shinmob.iptvf.jp) ([10.224.106.2])
  by uls-op-esai1-o.wdc.com with ESMTP; 12 Jul 2026 17:39:10 -0700
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Cc: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests 3/4] CONTRIBUTING: clarify that GPL-2.0 is not applicable
Date: Mon, 13 Jul 2026 09:39:05 +0900
Message-ID: <20260713003906.21153-4-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260713003906.21153-1-shinichiro.kawasaki@wdc.com>
References: <20260713003906.21153-1-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260712_173944_606613_C9D41A17 
X-CRM114-Status: GOOD (  10.79  )
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

Majority of the blktests code has GPL-3.0+, so the effective main
license is GPL-3.0+ (e.g., check, common/rc). However, GPL-2.0 and
GPL-3.0 are not compatible with each other [1]. Because the majority of
blktests is GPL-3.0+, blktests cannot contain GPL-2.0 files. All files
shall be GPL-3.0+ or GPL-2.0+. Document this requirement for
clarification.

[1] https://www.gnu.org/licenses/gpl-faq.html#v2v3Compatibility

Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 CONTRIBUTING.md | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/CONTRIBUTING.md b/CONTRIBUTING.md
index 4cfc868..375c4eb 100644
--- a/CONTRIBUTING.md
+++ b/CONTRIBUTING.md
@@ -16,3 +16,7 @@ as per the [Developer Certificate of Origin](https://developercertificate.org/).
 Please run `make check` before submitting a new test. This runs the
 [shellcheck](https://github.com/koalaman/shellcheck) static analysis tool and
 some other sanity checks.
+
+When you add new files, choose a license from GPL-3.0+ or GPL-2.0+. The main
+license of blktests is GPL-3.0+. GPL-3.0+ is recommended. GPL-2.0+ is allowed
+but GPL-2.0 cannot be applied.
-- 
2.55.0


