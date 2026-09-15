Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61E94C88E75
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Sep 2026 02:20:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=P2LCKAIdrSOn2UAx95wNV3vc+hcH1jPg+F2kzPFyeMw=; b=E3DZ5LXtlf8prtd2dvVTi9lB0r
	pIJmu/BpFcsTwTE2dSo+KYoDth49em0Xwvn1LYz1bzcBEa/qm439uZPCB1bJu+3K5zax+HymBjRs9
	xFA3NVLq4+VSVFtdnccCP9UnpALfIRr1YNdy/T/TGV2+/LtRY4OUt05Q8lDrTIjOxvRa8HCTPBJ+N
	NMdiJ1ndi0NfJ8/FC0fw4+QSjwMgp+WljbnM+g4idtGdOFde7s4zHI1PyABeAknm7e/KCtbQ3LOPp
	im/3mbn9UyvjkfAnQ6PdeFyClkz0uUfH7k/iL13MAd7QzcsgkVInNAmi8BVG9tkAENfaIli0Vz6lV
	Rw6k9T7Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x6ImJ-000000052lJ-48H3;
	Tue, 15 Sep 2026 02:20:11 +0000
Received: from mail-pj2-x11.google.com ([2607:f8b0:4864:39::11])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x6ImI-000000052jk-1bh4
	for linux-nvme@lists.infradead.org;
	Tue, 15 Sep 2026 02:20:11 +0000
Received: by mail-pj2-x11.google.com with SMTP id d9443c01a7336-2d747f01363so19668065ad.2
        for <linux-nvme@lists.infradead.org>; Mon, 14 Sep 2026 19:20:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789438809; x=1790043609; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=P2LCKAIdrSOn2UAx95wNV3vc+hcH1jPg+F2kzPFyeMw=;
        b=Ot4KcoFlXWseZriZy8rFsD7+w4dDCGYiq9eec73I5NxBlQrm2P/74Xb9KiWzy7tgzB
         NKBPlSMyhgPt1EIREpaai9RvywhAeI+ydjXk+Dpmwz8TcoPQIV8Cg9E2WLe+tJp1h/w+
         +103g879HOYhm/ExTFBhm4vxopZ/0rjOfrLmhDYAypyZm47mcRVc7AIpnZxc5jGb4UYB
         9m1ESUmOGrFp+S7GuJ4MtyguHe3CdkOM66gSde68qE6xLKhSUcNPue+OSP6mdnJATYmn
         KKaCoo0LVuaqHUwP1ViaO4Jwk4Cr4Gf6dAf+dbXLPqw/mHy+xDpxS0OcUja6VCADgt+U
         3dtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789438809; x=1790043609;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=P2LCKAIdrSOn2UAx95wNV3vc+hcH1jPg+F2kzPFyeMw=;
        b=QLVPd/gz1MFqcdUm/SSJPjJR2kaRVwq6IsLCgNC5DNVLMcCEKDlYy6aW5MzV1ErSrS
         aiOwkyoWBZEapMvieg7S/kA5lA8ijKmeOrHZjH+vYjq8DcD0QCb5ZlOGJL5XQZCwKtIL
         uNyV4gt/HLXq92sQmrLzoU/rVLNskaptlvS+Wm7q2JoVF1xTOhKHqbJo9OiioXOU/k67
         1345lssQSDIrG3mjw2KWILvEpV+Kn5O7V16crX6dehT0Mkyp1duEmPwgtYYN9WwZ8vmy
         cWBRYqyr+5Ac012XbVzh2l9Iaz//FegftgN8cbd8NJtoAf/IMfL+yS5JA4fmk2wc/xE1
         LMFA==
X-Gm-Message-State: AFuF++k7+vp8ikf3iYwhKSDCL/4f9r+a2goN0gfrFnEkHXM9KXj70AyD
	5U3qFba/i6iQzyOyAQl9GPLR5f0eD3yj38luMAtPt7iLNtwNrh/6zfT2witp/Q==
X-Gm-Gg: AYBFou3zEopBmk/KPVCCdLtTsXU4uJuwVhIkrYUhpWuAVM80fTz2LY5V2ect8rtJskv
	z6ra53nYB6pnKJuiUUJZPK+Ai24yOtfsAYkCcAmVVhucl4v4iGW0HfUZwqdLP0UVooquW89CJ8Q
	xQl9gYUDIBHEsZhvh+ckOaH+6v0p0PgsZgXy/oizOPiUOz5xLzYIXudbQXD5lNCtFQZ09eZLWNi
	YpFrAgtimNRoIKkbqS/CjZIV3gI90PG8q3ZjHwa4r8WXjYCQo4QpJKgW0doVNiF+Dp9TAI1xz/K
	2njIhNMFN/HTu1oHs9yjcLr+Dx2Pu5arAYEcH6Idk1psBjpdKIODcB13SS69O0hk+0fs92/Uf62
	NymX+0HZIAkRn6N4NYFNjvfCil4NfqT4hl7fRi/MelBU+OVmlPGVfgeI9EA5Lbzs55QL2i4zgT7
	EIXEGZYA74z8oIsbDkpXTQMEQz6NO6Kddb68XPX4fTQTI0fzC6RgRbaQfPuZ5H1aEzZfJ/C6pDi
	HIAjBnETC2rkB9zT1sn7Q==
X-Received: by 2002:a17:903:f86:b0:2d1:134:b86e with SMTP id d9443c01a7336-2dd6c5cc385mr103906155ad.2.1789438808551;
        Mon, 14 Sep 2026 19:20:08 -0700 (PDT)
Received: from ancienth-X870E-Nova-WiFi ([125.186.72.2])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2dd2ce9ce0asm59236715ad.27.2026.09.14.19.20.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 19:20:07 -0700 (PDT)
From: Daehyeon Ko <4ncienth@gmail.com>
To: kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] nvme-multipath: fix underflow in ANA log bounds checks
Date: Tue, 15 Sep 2026 11:19:56 +0900
Message-ID: <20260915021956.3142320-1-4ncienth@gmail.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260914_192010_449756_AEA75011 
X-CRM114-Status: GOOD (  15.54  )
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

The number of ANA groups advertised through Identify Controller sizes the
ANA log buffer. The ANA log header and group descriptors independently
supply the number of groups and namespace IDs to parse.

Both bounds checks subtract an untrusted object size from ana_log_size
before comparing the current offset. If the object is larger than the
buffer, the size_t subtraction underflows and lets the parser read beyond
ana_log_buf.

Check the current offset before the first subtraction and compare each
object size with the remaining buffer instead. This rejects inconsistent
ANA data before dereferencing a truncated group descriptor or walking an
oversized namespace ID array.

Fixes: 0d0b660f214d ("nvme: add ANA support")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Daehyeon Ko <4ncienth@gmail.com>
---
Affected versions: v4.19-rc1 through current mainline 587858367581.

Triggering conditions:
- CONFIG_NVME_MULTIPATH=y and the controller advertises ANA support.
- Identify Controller sizes a 52-byte ANA log with MNAN=1 and
  NANAGRPID=1.
- The returned ANA log has NGRPS=1 and NNSIDS=16.

An nvme-loop target returning the values above reproduced the host-side
KASAN read on 3/3 fresh v7.2 boots.  The first report was:

  BUG: KASAN: slab-out-of-bounds in nvme_update_ana_state+0x2eb/0x360
  Read of size 4
  Workqueue: nvme-wq nvme_ana_work
  nvme_update_ana_state
  nvme_parse_ana_log
  nvme_read_ana_log
  nvme_ana_work

KASAN identified the access as zero bytes beyond the allocated 52-byte
region and traced the allocation to nvme_mpath_init_identify().  With this
fix, the same target response produced no KASAN report on 3/3 fresh boots
and was rejected with -EINVAL at the corrected check.  The changed object
also builds warning-free with W=1 and an x86_64 allmodconfig.  Reproducer
source is available privately on request and is intentionally not included
in this public mail.

 drivers/nvme/host/multipath.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 75dbb58286a3..29d447a5d0de 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -845,7 +845,8 @@ static int nvme_parse_ana_log(struct nvme_ctrl *ctrl, void *data,
 		u32 nr_nsids;
 		size_t nsid_buf_size;
 
-		if (WARN_ON_ONCE(offset > ctrl->ana_log_size - sizeof(*desc)))
+		if (WARN_ON_ONCE(offset > ctrl->ana_log_size ||
+				 sizeof(*desc) > ctrl->ana_log_size - offset))
 			return -EINVAL;
 
 		nr_nsids = le32_to_cpu(desc->nnsids);
@@ -861,7 +862,7 @@ static int nvme_parse_ana_log(struct nvme_ctrl *ctrl, void *data,
 			return -EINVAL;
 
 		offset += sizeof(*desc);
-		if (WARN_ON_ONCE(offset > ctrl->ana_log_size - nsid_buf_size))
+		if (WARN_ON_ONCE(nsid_buf_size > ctrl->ana_log_size - offset))
 			return -EINVAL;
 
 		error = cb(ctrl, desc, data);

base-commit: 587858367581b9c55c3690f4e63382ad622719d4

