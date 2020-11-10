Return-Path: <SRS0=JPfP=EQ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5B0BC5517A
	for <linux-nvme@archiver.kernel.org>; Tue, 10 Nov 2020 02:24:25 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 32609206C0
	for <linux-nvme@archiver.kernel.org>; Tue, 10 Nov 2020 02:24:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ZQk0bnkv";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Uhh5vanO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32609206C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=e6PYkQ+XLrnxTbS7MeMPMi2Do4BQtLIADI2/aKf0z34=; b=ZQk0bnkvEUSvo592ONHn1Ufnq/
	4Mr52Wc2hJ52SKHVsRRH6kUsPKBl3NnPnXSYNkiRdkrC7Db2kzPIJVKH2LEOl6KIl8jlxOvv92ce6
	o4BID4wNX5HqDd4dGnFPbrPZzv+N63oeNi2ATCdsigamTCU/oqVcUkjCPP09Q/5UU2SZejNpMah0Q
	zk1x8+sBi0aAeHR27jWGlkveorUUK8bM1nr0MmEGvDFmiO1GRMgUwxnPqK1jA69AtpeVOjK6+T/Xa
	61yTeiWihoscBvd11YUioa0vEvM6kDtlo3UM01nhQRE5VFHgGgCryT1TBIrHMJr2Nj5eVgQJ/7jY/
	AifOOEIg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kcJKR-0005yd-2Z; Tue, 10 Nov 2020 02:24:15 +0000
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kcJKN-0005uC-OB
 for linux-nvme@lists.infradead.org; Tue, 10 Nov 2020 02:24:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1604975051; x=1636511051;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=PuBaw3stJbTbaX8/cdgDgYBitU4HyXXto5yoOVDwa2Y=;
 b=Uhh5vanOfybDS9wkctZhFyOoxt3pJlnX5Lx35yf6MFzoMtFMbHnKZ73B
 W+ANFIPW1TmOrrgltLgcu8rNFdVru7g2LAg98zJaZz3VYmEnUZ+kVzjIS
 bGFzkA5dqtQV40JERl4HfqVOOZkvD5VBT3BpuOjD+pGWy9f1NJ0Oh1cHk
 8FsrfxTrxnqBOtuRNYYfF8VhTXfWz659+NbCHspVNIX040wB+Pb9iB4EF
 /G3AHdTKokLJtl6V2u6N0xpucPnitRryuxiwx0wEm7p59QGJRh/UtcQId
 ZhKlZSid0Qhi4fYKuw+3WSGqZScn0azRrCTrjWCXzIv3F4e68j6WFODBG w==;
IronPort-SDR: TXVFMCx0qyKTVl5OmZUNLdac1g5rvRAHzacEWi5kbO7XwqsnjwE7M7dYruKhJW05nVsvggTI1o
 O7ACgoF2BEt8TLCDAH0vbEBOZnHPigd+tOSnHHkKDuuSc+1qu3LrUETsfhyPFZltLFoKKDgjHd
 5yaq8/m5csSesdKqqP8RlbjZaSILaIb4o6Xfi1O+oyfFgIgujM86wD8zH5d7939GOQQdG6jwdZ
 CVT0MiTLQaGjIzXM4TqBSV4d2kPpM68b4NC0Rt5wbFUlCbkgzzAQCOgOZaAj2zIw78HIJCCjE0
 zuw=
X-IronPort-AV: E=Sophos;i="5.77,465,1596470400"; d="scan'208";a="156720726"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 10 Nov 2020 10:24:08 +0800
IronPort-SDR: oFcUVxymZv3PNqVbgyDGdKgKznJRNl3QR52GqdwvG70KeiUcXyZKCocJvpGejgT2YJ0StOJl0J
 aUAluMo9Llt/B0fpJIMKHstu6Puw2p1r8agSZq8OnS2BNCt1baeSemDXmAfvDd2rtNGoWFP2Z7
 3eEbaiOgAmoYFx0xxamynLzmI3DdGxopgD9FN30Gu6CTn8zChatDcQvegrZdobAWqsVXBAg0kG
 7TmSICY6dvqbFvamVICvhABJlISKVg23rufSMi7x76J72i/oQRDkA8hPSMzENyCDcsXXvbahE8
 GTW0NC5KLbzuiBlTELN7ouqg
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Nov 2020 18:10:10 -0800
IronPort-SDR: OTIAnybxKDXy8FotM1TblXxalRopqTyeYcyk6tX3Hh7gWaPbnaZ/5TfPey4u+M4szFtWxCUuYs
 j/7yI+wp4O6gUuccMRiSjUxWXZDrnFuG6iQdW4vMAN3s5y/3Fkwy6C/LKdc8xvJ6KZgNZk6tSM
 kvvqWVvDplZffNJHoElb3YwlRRBt1r3FRYa4veYWLtZGNMUXmJUi6Nitkw2ljiGE6pRiDLWMQ/
 GZYU37abmDd3TOyb2cyBRETeuq+mnnsdutSA1zM2Qc2FKmqzsyAZFQ/5FhbzbEvkdkg9fXrFJO
 JPI=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip02.wdc.com with ESMTP; 09 Nov 2020 18:24:08 -0800
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org
Subject: [PATCH V4 0/6] nvmet: passthru improvements
Date: Mon,  9 Nov 2020 18:23:59 -0800
Message-Id: <20201110022405.6707-1-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201109_212411_933261_62225EEA 
X-CRM114-Status: GOOD (  12.40  )
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
Cc: axboe@kernel.dk, kbusch@kernel.org, sagi@grimberg.me,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>, hch@lst.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hi,

This patch series has several small trivial cleanups and few code
optimizations.

Due to conflicting nature of patches I've generated this series on the
top of timeout [1].

Regards,
Chaitanya

[1] http://lists.infradead.org/pipermail/linux-nvme/2020-November/020797.html

Changes from V3:-

1. Simplify nvme_alloc_request() and nvme_alloc_request_qid().
2. Add helpers which are used by request alloc functions.
3. Rebase and retest the code.
4. Only init bio_end_io for bio_alloc() case in passthru.
5. Add reviewed-by tags.

Changes from V2:-

1. Remove "nvme-core: annotate nvme_alloc_request()" patch and
   split the nvme_alloc_request() into nvme_alloc_request_qid_any()
   and nvme_alloc_request_qid() with addition of the prep patch for
   the same.
2. Remove the cleanup patches and trim down the series.
3. Remove the code for setting up the op_flags for passthru.  
4. Rebase and retest on the nvme-5.10.

Changes from V1:-

1. Remove the sg_cnt check and nvmet_passthru_sg_map() annotation.
2. Add annotations and performance numbers for newly added patch #1.
3. Move ctrl refcount and module refcount into nvme_dev_open() and
   nvme_dev_release(). Add prepration patch for the same.
4. Add reviewed-by tags.

Chaitanya Kulkarni (6):
  nvme-core: add req init helpers
  nvme-core: split nvme_alloc_request()
  nvmet: remove op_flags for passthru commands
  block: move blk_rq_bio_prep() to linux/blk-mq.h
  nvmet: use minimized version of blk_rq_append_bio
  nvmet: use inline bio for passthru fast path

 block/blk.h                    | 12 ------
 drivers/nvme/host/core.c       | 67 ++++++++++++++++++++++++----------
 drivers/nvme/host/lightnvm.c   |  5 +--
 drivers/nvme/host/nvme.h       |  2 +
 drivers/nvme/host/pci.c        |  4 +-
 drivers/nvme/target/nvmet.h    |  1 +
 drivers/nvme/target/passthru.c | 30 +++++++--------
 include/linux/blk-mq.h         | 12 ++++++
 8 files changed, 79 insertions(+), 54 deletions(-)

-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
