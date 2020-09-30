Return-Path: <SRS0=B4mB=DH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28D22C4741F
	for <linux-nvme@archiver.kernel.org>; Wed, 30 Sep 2020 23:25:18 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9895C206F4
	for <linux-nvme@archiver.kernel.org>; Wed, 30 Sep 2020 23:25:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="jxnl/VhY";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="hPlI+JvE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9895C206F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=lkY7Wq6ZX7vQ03/HZcxZVN0TGQHCqoqTUvOG7oZklw8=; b=jxnl/VhY1QfF8KnnDjzi2TNqUy
	3CcIvxXfxyE7FK/ogVoAsdSyXvlh8BMEzFbY9wqwi9SNRwQOBinAvNAm/mxOd1BTSXZW3ltAj5a9s
	90DNg94WeTSs/ZXFD2CNVSXazyhP9a0rhLZyC0PWpX0H+l2ZhHWVoF8gR7rVbuY7EdKlcjvuO50Fa
	gIvVYlTFfQPeWPqiyPzdoS+MjYhv6+G60Dv5nG8otbMT2rAo1QNObkrJ2iic3/bk0c9MXpiiEHs3J
	ksfodJ14IzCROXNTIBIAkMbBiH4eyidmA0UEN0VIgN3TNKf2u+JKib3XuIWGVZGacUo6Ii97PvHZH
	x6+Ve4SA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kNlTC-0006Z6-NX; Wed, 30 Sep 2020 23:25:10 +0000
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kNlT8-0006Yh-O2
 for linux-nvme@lists.infradead.org; Wed, 30 Sep 2020 23:25:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1601508306; x=1633044306;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=jySPtPnrnYMznydBS86y06ghptOyb1QOExfNRZFxVZk=;
 b=hPlI+JvEDM311t2gRYORM4GZtPBU6MuzlvRFQRHJ/6Bu4M8+1DDkMATA
 bwktC9ix9C1zOLrWNzYyf1a1h36Bhx25JpGwU96c0zWYgDcE0SrjcKMy8
 ECiK1zCbs4IpoKL8/SKFVG19rmbUOxz9VQkL81KPzRudqYfCzvZWd6lq2
 k1UeOR9E5zsQlhurj2n4nQVItLVfmXcoKULnDoGp/7nQfu2AiHCXZwLRU
 AjQcn/BC1amui1FmB3GtjCpEJcrQjwbpO4lRsc9/2wcovxMP4+R0ExoUQ
 86RM4+Yg0LIXER7D4tMN+IVd74jZ8Yjzf209GLWdQ/+6hriOvxkjARU6x g==;
IronPort-SDR: IVSATpsKdJ9dt30Jc4Vm9xpDCDEbCUnufTRI3h7B64k+Ayp83xlED8GbxvLnYKd6rjIoOU3qWz
 2UYI1sAvtgtoNQaHzpNPtS8sE6izZptJonE8cSuS600pv6gTy20fOCLXTvLNgxYE8ZQ2Pnt30e
 TUMtlNs+ED8Je+6T1T2J1bBo+X5m3TxWZOCnSrmLgr2mz0qWt8tLjQvBGwJmsP1t6uf4PYSgbC
 TK5kypED0+LJbwOSUdcIR9u9+/0fIgrBOQh3K+Gr6bD/fKLRrxaAEymEaCnouqKyrOQa55r170
 6Cs=
X-IronPort-AV: E=Sophos;i="5.77,322,1596470400"; d="scan'208";a="148616614"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 01 Oct 2020 07:25:03 +0800
IronPort-SDR: jM4zV2OdaZZvMH9Y7cBR+rxOcrbvlYaNZ7kKxBFaQYL8t0lp22IPM/wvtxOy71Ku/ix/QIsE1o
 ETKAykt17fww==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Sep 2020 16:11:55 -0700
IronPort-SDR: 4luG+9sMcrkk+IcVKYOUdzCM38MdcjAup0h9i5/F87XJzI/TkekebRAR9kPkf27+Ch/cDHHj6x
 6y9SqZaJRD4g==
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip02.wdc.com with ESMTP; 30 Sep 2020 16:25:03 -0700
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH 0/2] nvme-core: increamental cleanup
Date: Wed, 30 Sep 2020 16:24:45 -0700
Message-Id: <20200930232447.20677-1-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200930_192506_920146_96436604 
X-CRM114-Status: UNSURE (   9.63  )
X-CRM114-Notice: Please train this message.
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

This is an increamental cleanup which was discussed during review of
"refactor the nvme scanning and validation code " [1]. This fixes minor
nits in nvme_validate_ns() and nvme_set_queue_limits().

Regards,
Chaitanya

[1] http://lists.infradead.org/pipermail/linux-nvme/2020-September/019886.html

Chaitanya Kulkarni (2):
  nvme-core: remove extra variable
  nvme-core: remove extra condition for vwc

 drivers/nvme/host/core.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
