Return-Path: <SRS0=W+Vz=CJ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EFA4C433E6
	for <linux-nvme@archiver.kernel.org>; Mon, 31 Aug 2020 22:27:23 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 39337207EA
	for <linux-nvme@archiver.kernel.org>; Mon, 31 Aug 2020 22:27:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="UxTU0ZAv";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="gkYrxQU7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39337207EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=g0hTkmjK79e7An7gZ9uZ0Gv+6h1c3Dk95HQ00xD8Rgk=; b=UxTU0ZAvZ2aRujJJ6MjB+TXSfC
	3Qff9AWM14sgnSbSWcPg+0O3m7FNJJ4RwwVN/t4eBJo0zu65d9QS1j6C2jQnjyI6LzJ/9uCUVbqw+
	JMj5oX7Cy7Q+dg/BaDeh7zDy8ianqr74gsKD6lWbqxKO1Bd6v9iWvCC2gj/WNsCdsWOod+uJ3uVDs
	PTU3N9GsYrpYHOG0PLE+aU61CuLwV/X3tZTF3lSJ0tIKy0Hc289P/4ZvCS/7g6qfIA5nxFp5ZBOSX
	ZR0KA9M1IFYlYdy9sXswSDRWDV+e3vqHdVz4WJh4DLrnnc5QAABwVVBQzUDzQS7OkMSxCdGPqu4nO
	JYy2nuhQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kCsGn-0005Q9-9z; Mon, 31 Aug 2020 22:27:21 +0000
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kCsGk-0005Oz-J0
 for linux-nvme@lists.infradead.org; Mon, 31 Aug 2020 22:27:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1598912839; x=1630448839;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=/FaNW8P1OP6OD4G/iVYIQDZE1TA+ecNLj87OIt0iL3Q=;
 b=gkYrxQU7Fhw045Y7pXUfggHff1tAF3RGuLA4VDe3I2dwJuiKXsf/i2gm
 2do16cxTZ8FYufrtNyhNBc1mY74pyFidSt2eyw8HBNuLfzbl0azbVhGOb
 DpoqPoAXymLzC/GFlUsSms5pfQrOe+3KIFXj2Uu4rollYOElXs7dMHkCl
 C9CfjJkCEq2nqk/WQvPv+8mkKuqUjN44QRjN6Lq4NXpZmljnxds8+puB8
 s4dd/EyabRCHbfcA4acEEuRcL6Fo1io0lxge0wcFg3hpR/KBKEcRUnar/
 2C6nFvXaEmJWLxEyE+Y0bMs7+mPf56CbyFxS4DfyQw9+p9pTb0U7Ph7y6 g==;
IronPort-SDR: Plexc1n+CNHEy7UNm3oXvc9dM73JlQ9hixpWmY2ZMk3k0VwWGcxCWNqeiBqcjKv1WwcTArtspn
 PC/GKmJ1IYBtaNdcI2g/cI25NLxqbxg9rglD8KtCRo6t4fKrAtt1oOAAT2wgo0sS0egsIrlNEi
 HG+u3vwTZ3QX0fysOlwU8mR9RTiYcZEJq5DOcf1cnOvPaMVoHLq31cBepTRkKrccja+teOAehQ
 MaSDUmXb/J5yVYcY/FcNCIr7WYLaPE0jha1aIMXltzIsw5UiQfr4KWFmdNRpKpaIAh9IpvyC6J
 jkg=
X-IronPort-AV: E=Sophos;i="5.76,376,1592841600"; d="scan'208";a="150600845"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 01 Sep 2020 06:27:17 +0800
IronPort-SDR: xymCd5PW260SLi22K1Nu/Ua0CUgl4n//qNX7/CjVcuJNTzzp0RKR67/t34kJM7Ll6OdHtzwq7M
 Yw+cK7IsVEww==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Aug 2020 15:14:44 -0700
IronPort-SDR: /PcO5szSxdDbckqef0GJq8EE1sAh79VKebLOn15Jl35elK4PhjMwwo2BiGAZahSRN5hpk6QOt+
 Xz8iguVSvumA==
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip02.wdc.com with ESMTP; 31 Aug 2020 15:27:16 -0700
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH V2 00/12] nvmet: passthru fixes and improvements
Date: Mon, 31 Aug 2020 15:26:55 -0700
Message-Id: <20200831222707.35611-1-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200831_182718_830511_D2C5D531 
X-CRM114-Status: GOOD (  11.05  )
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
Cc: kbusch@kernel.org, logang@deltatee.com, hch@lst.de,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>, sagi@grimberg.me
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hi,

This patch series has several small trivial fixes and few code
optimizations.

Regards,
Chaitanya

Changes from V1: -

1. Remove the sg_cnt check and nvmet_passthru_sg_map() annotation.
2. Add annotations and performance numbers for newly added patch #1.
3. Move ctrl refcount and module refcount into nvme_dev_open() and
   nvme_dev_release(). Add prepration patch for the same.
4. Add reviewed-by tags.

Chaitanya Kulkarni (12):
  nvme-core: annotate nvme_alloc_request()
  nvmet: for pt I/O commands use likely for ns check
  nvmet: use consistent type with id->nlbaf
  nvmet: use consistent type for op_flag
  nvmet: use unlikely for uncommon commands
  nvmet: remove op_flags for write commands
  nvmet: decouple nvme_ctrl_get_by_path()
  nvmet: move get/put ctrl into dev open/release
  nvmet: fix nvme module ref count Oops
  block: move blk_rq_bio_prep() to linux/blk-mq.h
  nvmet: use minimized version of blk_rq_append_bio
  nvmet: use inline bio for passthru fast path

 block/blk.h                    | 12 -------
 drivers/nvme/host/core.c       | 31 ++++++++++------
 drivers/nvme/host/nvme.h       |  2 +-
 drivers/nvme/target/nvmet.h    |  2 ++
 drivers/nvme/target/passthru.c | 64 +++++++++++++++++++++-------------
 include/linux/blk-mq.h         | 12 +++++++
 6 files changed, 76 insertions(+), 47 deletions(-)

-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
