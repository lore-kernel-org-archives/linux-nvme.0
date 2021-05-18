Return-Path: <SRS0=ZIaN=KN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88368C433B4
	for <linux-nvme@archiver.kernel.org>; Tue, 18 May 2021 05:06:30 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E2AA161108
	for <linux-nvme@archiver.kernel.org>; Tue, 18 May 2021 05:06:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2AA161108
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=Jdr5qzuZkQVkAvjFeEywv15DBmQOLRWLffV1Ep5wWUc=; b=TRkn+uKSzXyErooqWa4/BKNnUX
	e+0kTdE1xfhu1vuhG2MDgF8ayrrE7ByyXKnvtOYiw8zPN73QZIrbwUR9fhr9iHLgUBwxmcpEUrA/0
	ccWC3UEhIlIwgCKSkSN7D4a5M1rhoZx5QN0hh8AybvKYXsr2Alb5K8uPUdETNCwGDv7ZzlYaxZ/vH
	AS3r+RACjbMLvdjNKI5Uh1MrjAayFG3+SZyupBO5HBea7kaK/J9r/MrRoacEHYRTe+HDrpL/HOUXz
	0uyABappprjA38CyS1YV5dBJDKYzm/k/jB6tgkSbq7kNElaH4CadPptSfLdt3SO1UB6dsbvhNkg0F
	GpzWHT+w==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lirvl-00GyHj-BR; Tue, 18 May 2021 05:06:09 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lirvi-00GyHM-FF
 for linux-nvme@desiato.infradead.org; Tue, 18 May 2021 05:06:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:In-Reply-To:References;
 bh=i+ymyNg69547MqlVxbFMvYBczkaHPnurhADvNg2E44w=; b=RrVkCsCm43nCo6nlBErcIdooqT
 RURlyPBF3SEbug7AsT2ciSUnkxUym5nChX7tcD5ntInF4ZNWIs8pHtXCaKZUW+1kSrwE645KmVMjY
 jFLrmcKfWV5mYeIy70ob0IpNT7lO31Q6tyZWFnytYGG8XazmqreHbDU4jV2keMj+l68keCIauwOqi
 08w3ywH8NueDOSUky/pS7Viz7tmLv57NxtIco+hrOApHL5QSLBypTS/YseYtOhKLDWHxMRUv7P21F
 eZK/S1UES5+SH4o6x0bRFaAYzaqqDW42omsyuTk02gEHcNm9F3KU7PutEjk3kK+y/OosqnReErT1O
 gP1ZrVVg==;
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lirve-00EJas-Rh
 for linux-nvme@lists.infradead.org; Tue, 18 May 2021 05:06:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1621314410; x=1652850410;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=sFOqYw6FKRFzLwOb96f+9+lwhgKCwrjoBbR+eiGfDo8=;
 b=QIPLEMmFHvVycKMdtQF3yOP4+evNFoz3m1VhN16h80I/muPdvg/uWmIV
 y2sH9QNrwnM5SfH1gf3H8auSCDmpYqoI1gr74+khO9YO08FySXZ7k+0iX
 Jn3pB3YbJhY1m/hn5Oatw8pbMS+nRtjoTjw/9bkqLyNTARnsWbmq19A2Z
 6kZxHzQZLJ+MruuiP6Q0U96imU9MiJhlyOtuQr4kQYtKlpc7yxYjhru+B
 rbpiLPXucBY0IF9kplOJmmIYIBJYvecKyHLnvGJpW1OEy7ts+eZujQZvP
 Rw0NKFV3W/JAgYPHuNiOiWp73s3R1gO9WXL0o0y9dJsykN1dXVmBAofQR g==;
IronPort-SDR: RpqIPI4iBCZQtpU5SZRLmg20kl1nk1G7ZuAYfn8+BjvE/0SSxSlw8HLtdF4U42t7atQX+ULA6Y
 miohkZRcSOZ/pujcF+7ZQ95WAI2zgqGkxnwBnVwGyYrhxQk7alasTsjRJKd33k1utzlOESeUiu
 XDKLUS2LUYLhNPsLagWRlmTB6HqdLAl1ONHZ22JKSMl5eMVDkWQYTwvF7HoxafMGHb/ez8yc3O
 vEKvZUZeFvY6ci2CdpNMw819EtXWg46Z4QmLZxtQugpFbVDd1dfwFWsHnpX7tmCZCl5ZTEm8ab
 grI=
X-IronPort-AV: E=Sophos;i="5.82,309,1613404800"; d="scan'208";a="272473138"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 18 May 2021 13:06:43 +0800
IronPort-SDR: TyKw8WrQy5v4knvtKO0+PawbCKXIGCR50RugFSlNBnMbqhpdHfx8pvihcQsjDRrGRSOqehcSvG
 eYGfQ14V8BIcf0AZkDEpUI+5y+SE5OQMBE2iV1ifAQxLz5twmzDHBujxjFs9RZdZGAVANmxfow
 Lph0cuJVQQyhQ0jmEuxCfz+RyVIboDzdSZI1sYHtLFXLvwWdRxzydBVgEHT8T5+15/1JKL+yUh
 n++/EHhUgWe2N8IVXVcgjGqF0hW3BmwAXEFDYJH3P7MhVgva14f+zEESbiLQ7Fh2s22NTtxSjd
 9kOZ4LccQBTEBvCZznAHSnMx
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 May 2021 21:45:38 -0700
IronPort-SDR: KKiMlNsqUneluB8rruFISSOvrMaEsfzD2YxoFWON3EVSp4ArAp6mwh9IFx3vE0nlagvqGdTUqM
 8mxXo+eRO5NCH1YNJG3kpnvWFG8B7VohQgtKVeBEOKJkaOUGMbGDDjKgK9nLPj1/28krI8p/H1
 3AN6RvJUFHWAZ5MO5WMlh4UzeUsPyd53bxLfRMD7vLJytyardvFIf7jSSFJioBTfO2+Uf/cL6Y
 qzHDkDWpi7VwwHptVWEwTF7nszxbjhTOQCa6NmraE7yTbpE9oQt2/gfGpqO5j5DCDvAqjYTOFv
 MxQ=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip01.wdc.com with ESMTP; 17 May 2021 22:05:58 -0700
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH 0/4] nvme: nidt and ns-desc related clanup
Date: Mon, 17 May 2021 22:05:53 -0700
Message-Id: <20210518050557.14961-1-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1.dirty
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210517_220603_002911_567A741B 
X-CRM114-Status: GOOD (  12.49  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hi,

This is a small patch-series tries to minimize the number of the macro
identifiers. 

In the current code we maintain NVME_NIDT_XXX identifire values and the
their length NVME_NIDT_XXX_LEN separately which has 1:1 mapping. This
adds founr extra macros and open coding of such macros in the host and
the target.

With this open coding in future we will have to maintain one extra macro
representing length for each new NIDT identifire that we will add.

I did the light testing on this with nvme-loop [1].

-ck

Chaitanya Kulkarni (4):
  nvme: calculate data offset once for ns-desc
  nvme-core: add a helper to get the len from nid
  nvmet: use nvme_nidt_len() helper for id-desc
  nvme-core: remove the NVME_NIDT_XXX_LEN macros

 drivers/nvme/host/core.c        | 25 +++++++++++++------------
 drivers/nvme/target/admin-cmd.c |  8 +++++---
 include/linux/nvme.h            | 21 ++++++++++++++++-----
 3 files changed, 34 insertions(+), 20 deletions(-)

# nvme list  | tr -s ' ' ' ' | grep -v '-'
Node SN Model Namespace Usage Format FW Rev 
/dev/nvme0n1 foo QEMU NVMe Ctrl 1 1.07 GB / 1.07 GB 512 B + 0 B 1.0 
/dev/nvme1n1 e3a9ed423c786510 Linux 1 2.15 GB / 2.15 GB 4 KiB + 0 B 5.12.0nv
# cat /sys/kernel/config/nvmet/subsystems/z/namespaces/1/device_nguid 
11111111-2222-3333-4444-000000000000
# cat /sys/kernel/config/nvmet/subsystems/z/namespaces/1/device_uuid 
aeed37e9-39b3-48cc-bc9d-1c799fa56df7
# nvme ns-descs /dev/nvme1n1 
NVME Namespace Identification Descriptors NS 1:
uuid    : aeed37e9-39b3-48cc-bc9d-1c799fa56df7
nguid   : 11111111222233334444000000000000

-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
