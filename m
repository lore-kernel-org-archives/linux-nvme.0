Return-Path: <SRS0=rw3x=BR=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D163C433DF
	for <linux-nvme@archiver.kernel.org>; Fri,  7 Aug 2020 19:30:45 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 01008214F1
	for <linux-nvme@archiver.kernel.org>; Fri,  7 Aug 2020 19:30:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="XqIv6LLr";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Or5f+AX/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01008214F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=3uFClo1cmEFwl3rby2Av/Cq5XlvX8RdL5pm/m/Ufohk=; b=XqIv6LLrctCRs5brxzrc0s+dG2
	6Dawqf0VHuUpSneIkN46lKAFTJT9Ff37z8VRsncA6EfqNdD3I1oLhcOt6dJ0Cp69jh6EfYdwtBjEx
	vR6qgUBPL0cLNPkqOghDjOPyC/XO3cjNSP5EHMFW0Imcw/fd22TdBJ1XRnnWNQlKda24s0FjUPL5v
	SswHwOjnEDwC/V0VHsMgpuK4j1PyYmAM3PypjbG702zOM0hG7OdI5mPSkAJUujukbhCJ1lAcPAfUU
	wGu2ZX45MkSUvJGkXgw0VZdK2m3ciA7nFZMa/87Ksfmlbqzmbpskj6TZrXGDuLfmTA9iAgFupxqZv
	MRg29yzw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k484b-0004Qn-Cu; Fri, 07 Aug 2020 19:30:37 +0000
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k484T-0004Pa-S0
 for linux-nvme@lists.infradead.org; Fri, 07 Aug 2020 19:30:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1596828629; x=1628364629;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=V5a1fzHagfSMsVvj27p9tyI97R3c/u/v6N4YKCJj3JY=;
 b=Or5f+AX/7YvKoPxuAR3Mzw3EbHTAJqDaEKfVPq7/+R6WyNsTlEFYdd/j
 3DmI18Y5BPVWpjzJaJ+wXki2urAaQW4ArAsIc8EuKauRMb/vaSW8VFyNd
 j3/xighqz/IytU6mX7jWzvLLo+VFRRiRbXAXVaRKDmyLYqISMiV1YSl8H
 o6I3GUObc7fm4Bn/kfpJ/jmb080epsd/u0m4bRG8tMgwt7osE0l8OIXJg
 z43yVfMG32vfReC2eiIpyoI7fh1lA5q4AfRpJ2UjjyuonWF/NyVW8ZVTP
 8YrdipbFy33a51zfUKAK1qBq87tAVUKXc07aEli6jwbhRgZ60RhUAFPQm Q==;
IronPort-SDR: yttVJoD1wpIgRfQ3Tesol2fUpWMbU9b11JL9jFMwdOntiH55blX5b58VtTioRjO/EOMyGR12cJ
 eZcUF1bAkgnhpS5//+1VziEryqMLC2+cmgQkBt7TzXps9Vkh4jQ2WReVa3lsdBTywQV30Uq7/+
 sfeG9IpgTOD9A0eHFroBNVFAbCjkjNMFZSrtfFm9D2CA7nRljKZjVvzRF05jBAxfl/RgN+4INh
 7UYtQpEZyQJ4YzdLaqc7Ya3Uo+MlcVXOTnZ5bep0tvppDbj6iUl0tkeXR0UyMubWws/BoTEDBf
 av8=
X-IronPort-AV: E=Sophos;i="5.75,446,1589212800"; d="scan'208";a="144423140"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 08 Aug 2020 03:30:28 +0800
IronPort-SDR: Lbap5JhIWPZfybEYpR/PqL9rRjpPWjk4kmc5T2x0zEPLNnbfqcuk79BjxAtqOoFg3mmh8MVzsl
 jbcGYTOOREzQ==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Aug 2020 12:18:25 -0700
IronPort-SDR: /kN2E0wH8+aGCwBxtC+h+0+dpW8rxEumSVSFCxHDgckXcQXbZebDlzLuPvbuWq+N/VfUjrdwlE
 MHeGHsFVgvuw==
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip02.wdc.com with ESMTP; 07 Aug 2020 12:30:28 -0700
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Subject: [PATVH V2 0/3] nvmet: passthru fixes
Date: Fri,  7 Aug 2020 12:30:23 -0700
Message-Id: <20200807193026.9129-1-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200807_153030_115782_2C001E90 
X-CRM114-Status: GOOD (  12.75  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: hch@lst.dew, sagi@grimberg.me,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hi,

This is a small patch-series that fixes a bug in the passthru
submission path and makes the direct call to blk_mq_free_request().

First patch is prep patch to have labels for each action in the
nvnet_execute_passthru_cmd(), second patch fixes the actual oops,
third patch call blk_mq_free_request() directly.

Regards,
Chaitanya

* Changes from V1:-
-------------------

1. Don't use fail_XXX and be consistent with out_XXX_action as
   most of the target code labels.
2. Add a out_put_ns label as a prep patch to have proper error
   path handling for each action in passthru cmd setup.
3. Add a out_put_req label for blk_put_request() call and move this
   call to first in the error handling code path. Along with the
   reported but this also fixes potential Oops if nvme_find_get_ns()
   fails in the original code.
4. Add reviewers tag for the blk_mq_free_request() patch.

Chaitanya Kulkarni (3):
  nvmet: add ns tear down label for pt-cmd handling
  nvmet: fix oops in pt cmd execution
  nvmet: call blk_mq_free_request() directly

 drivers/nvme/target/passthru.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
