Return-Path: <SRS0=L2sc=BU=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E752CC433DF
	for <linux-nvme@archiver.kernel.org>; Mon, 10 Aug 2020 18:02:51 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ACF2B20791
	for <linux-nvme@archiver.kernel.org>; Mon, 10 Aug 2020 18:02:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Sgozxb2z";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="CrbnJSVY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACF2B20791
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=3eg54ZorRURb69gnVVe33tT3GH/II9sNSf1Y/Jq2NAI=; b=Sgozxb2zpCypfWXCbyHEHSnUa5
	W0a1bY1HVnpjbY4B2rmqPIyTubzYCjSUzrXSzXN3ydwWHTW6WjqFsOr5Jfy2oW41tjlEregeD6Mnk
	MuLFJiPSUzvARmNtqjyz1AftScxqS5s1vxfs+HhlIeJ5cwfIXX2QK1FgJGA0lxVRuUXSYnlyNVx9+
	uCBuEXmHtF5ctG5/0Jez6iSKDXpqJ1ElFtVYId0V1+7IzZvMdql/v6l4uuUTmnycd+QYI6LRWb+0/
	4YcnV9JqkUQS/vRLQhEw8zJnEnvl+j1bLscVVB5/WaeOk+1gkBQPZ3mY3SHHYocyuOi588sdqwBoT
	pqw7pVGQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k5C8B-000129-Sh; Mon, 10 Aug 2020 18:02:43 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k5C88-00010P-OV
 for linux-nvme@lists.infradead.org; Mon, 10 Aug 2020 18:02:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1597082561; x=1628618561;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=Akmx4Yij/15ZUjWLgyxUXhAnqBiex9wymr/nvo0QMMQ=;
 b=CrbnJSVYsppOvOs+7mr9sIEvgT0bOR+eQCOyZXQeTkRAl07zTwenX/0q
 VHFjfLDtGBtuOTUrN61rISqw7geuuZCaQIs9Qr0UZA+L9KaG3PYJLFlMs
 ycyqZFvsZzgyKV7aMjpDPGKT66FGINDEGFNGQtuUydkH6ugAf5k5ujJNn
 IDYgHRT//BQHZG+WN5qfFM/34qnYQ2AhtmWzuZQ9QWo1sUaX/u308makM
 SgaSadNv+BMUeRmDYpffWd/uNvVCa3X2fuFSuOTLFvPTbXoP+hDe1yKPx
 /bFc7UGDtdBlUPl4EdcdDRHda4q8uF8c5ElWgNjS3ag1AkVCRjv/e8ndZ Q==;
IronPort-SDR: WjaVaO+d8hPklqlB6MIIdlJHlV2CdTWmj84e1y5qrLfQ8oInmF2MU8s/bdr9Q04syL+qLsjeGF
 PdtDlCDvXmh1Kv/8I7wuhZCMezXy5poeBmk6+jk43zmaGQwMTiWbugGF0mdnRd7hcCul1yb+AA
 mqMgsKs5cdahTHaFngi3DHGhiOkoj9YewSjjR0gGJCeyK78Bi4yctnYq72glkhN2ojK7xdYzMM
 RLHPnwfXSlcDAKOIw/EnZL34+yskIK9TCWs9r8xbAAWR/R7jVE5qhAEV3vQuo846PhPI2ZogXf
 AYM=
X-IronPort-AV: E=Sophos;i="5.75,458,1589212800"; d="scan'208";a="144647697"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 11 Aug 2020 02:02:22 +0800
IronPort-SDR: kZkAgn0kyZ3kdytgAkEHPfzRvLO+HfbRSRJF6/04Zs1wNeg1jube1MZGDLGU6kFiBDhojiFzr7
 Mza/F5kWwYXQ==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Aug 2020 10:50:15 -0700
IronPort-SDR: IouEliMWc5n2bB5trxLqp1o97ZHufOoQx8jek1oFjQk1boZemaWKF8Vb9tqoQyvmQ4NuPJOiiZ
 YiIDZdEoxahA==
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip02.wdc.com with ESMTP; 10 Aug 2020 11:02:22 -0700
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Subject: [RESEND PATCH V2 0/3] nvmet: passthru fixes
Date: Mon, 10 Aug 2020 11:02:15 -0700
Message-Id: <20200810180218.5857-1-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200810_140241_017063_8DB69B09 
X-CRM114-Status: GOOD (  16.49  )
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
Cc: hch@lst.de, Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
 sagi@grimberg.me
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hi,

This is a small patch-series that fixes a bug in the passthru
submission path and makes the direct call to blk_mq_free_request().

First patch is prep patch to have labels for each action in the
nvnet_execute_passthru_cmd(), second patch fixes the actual oops, third
patch call blk_mq_free_request() directly.

When I pulled I did not found these patches in the repo.

I've regerated this series against branch nvme-5.9
commit b6cec06d19d9 ("nvme-loop: remove extra variable in create ctrl")
and applied it again to make sure git am is successful, please let me
know if you still find patch corruption issues.

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
