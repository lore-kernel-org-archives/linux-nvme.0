Return-Path: <SRS0=rw3x=BR=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A6DBC433E0
	for <linux-nvme@archiver.kernel.org>; Fri,  7 Aug 2020 02:20:52 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4058F20855
	for <linux-nvme@archiver.kernel.org>; Fri,  7 Aug 2020 02:20:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="wKyGCzBj";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="MuxDKbZM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4058F20855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=3uFClo1cmEFwl3rby2Av/Cq5XlvX8RdL5pm/m/Ufohk=; b=wKyGCzBjwoxak7uLoYw7hfN/A4
	IL5lAGXCCjPNdLc872oOZim81AnqUX/Nxj/u4L/8GKNeQ/Btyej7zI9oImOUrjRCFhaQt+pOV8+sO
	906LGux2v36AXXe6mxqRLypLcCWh9/p6aJ2NNRqW0WhGk6tiPt2QLVS1bb+X7Oi9sJ6hUHi+H4CDg
	i4c/cUtpd5vmVOyul6D1WPaeI/9uSOCvyb8GMK+P5XtT5r8+qgyVUfJx5Nmfr2Kyv6oIWOmSGkB77
	gA/VrHL1OU8Zvd4lQ3QQpIhdrUDSYBALXkqC5Bji6rFMlmLdKZuZMR7awaRxIcB0Er/v6CoXa748F
	7ht32pBw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k3rzz-0007Sa-Nh; Fri, 07 Aug 2020 02:20:47 +0000
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k3rzw-0007Ra-5k
 for linux-nvme@lists.infradead.org; Fri, 07 Aug 2020 02:20:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1596766844; x=1628302844;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=V5a1fzHagfSMsVvj27p9tyI97R3c/u/v6N4YKCJj3JY=;
 b=MuxDKbZMDIPhc76vHAVwHWQqXCKDTbiRR/cw7pi/rgo9rZrZLWxY2raa
 IFf2hB7Z6wxr8aeXa4CJeDiiR9cCRfcm3xIp5RNBCT/ybnzwlKrxCp6JS
 vt8KLoxRnLollh3ZbHHMiKUTJ/UDnH/Sv6yZdc1ylZieUmBE2USP7nHLh
 J0VQaAuFQPem47xnrncdumhqPEmJ2znolXnZtXl3gcB9JQsQSNx/iklJN
 sYywpRmZkrwc+3OoaFi46wDH5iG2w6k0z2qytAUlOr1ffGGwXtSucwCcN
 NcycEik3xWgebwGi4BGwEKXPPlo8zwIUlgCEajxaA1hN2GGCQRVdh9jgz w==;
IronPort-SDR: ZajWTKzLcd3CdRkGtzAdUnTxMaDE3+adeBT8YT/dHLLc/kMyde6sataKdzxY0o+nCApRvjjUHx
 4jMQyu1+AkOtgvCsOdZZTM1mSbVuBNqADa/cmkYOnpNTy5dQtIjqKdUiswPe4yZADTZJ9QPgZJ
 ckOtMEw3hgUQRomvwR3fVoj5lJDDOwZxZ/ZzJBD0lI17U938UwArCGS/34jSIoTnUHQCvXAKl9
 VLhhMIGjE1ND1+6OiWJlfABk42jmbxakTFeg/h0iHiFiyD+/Lzzz2T44R/FlQc9ipfXe9uSQrR
 ykQ=
X-IronPort-AV: E=Sophos;i="5.75,443,1589212800"; d="scan'208";a="253717271"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 07 Aug 2020 10:20:40 +0800
IronPort-SDR: 5mwI6rrtnljVi0Dy6sxDWhidI82U1gkHIo5rPw0l9ivVkpJPyeFtsT5iUxBTgVmPHoBbz4k9Cy
 dnSaCD9dbS3g==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Aug 2020 19:08:38 -0700
IronPort-SDR: UEF+Izlh/jD8qZOoh0zJVwDboswROvulEXjn2eMOFRtPENadnrdCr5Tc3zD425JxeO878tExo6
 uTAnqanKyTVA==
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip02.wdc.com with ESMTP; 06 Aug 2020 19:20:40 -0700
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Subject: [PATVH V2 0/3] nvmet: passthru fixes
Date: Thu,  6 Aug 2020 19:20:29 -0700
Message-Id: <20200807022032.48873-1-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200806_222044_490702_D630D65B 
X-CRM114-Status: GOOD (  12.78  )
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
Cc: logang@deltatee.com, hch@lst.de,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>, sagi@grimberg.me
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
