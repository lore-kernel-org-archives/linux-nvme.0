Return-Path: <SRS0=Uncj=4D=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F099C35242
	for <linux-nvme@archiver.kernel.org>; Sat, 15 Feb 2020 01:38:43 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F1CAF2073A
	for <linux-nvme@archiver.kernel.org>; Sat, 15 Feb 2020 01:38:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="s3L9a/RZ";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="JbY+lf0G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1CAF2073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=bphtYj3Mbk/ha91/hvPLoYneJFr/cAdYAxlpKNgmb8k=; b=s3L9a/RZzYNDW/
	1opUCpc85l2a+y9ZO7b84Q3BIFdHWtHX9Ocw6E2M/DwOnkva0j6DRmKKkECu0W/Y/Er8wVig4x0cu
	rYjDI3j4uJ3VQlOYGA875l4icGS3gwPqowZ1Ne+OL4hKn9eqLChQu3kFzCVu1P6mKAQdcmsPfheic
	NEXQvYbLe+YegEg7DmmycltK2y6/ObhOulsWcaz0NCUxKpEG3eUU3jtAnJX9k8Qe3lUPz9UhJswBf
	IkahRo8VWlBTPyryPokUrjIJ0Y0kke+dT0CDm+U1TJE95xsB+SmCyz611TQ94KNT56AqvgnsG0DBi
	RqUcG52H1L2r+ZCtzGsQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1j2mPn-0006bm-6S; Sat, 15 Feb 2020 01:38:39 +0000
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1j2mPj-0006az-Ec
 for linux-nvme@lists.infradead.org; Sat, 15 Feb 2020 01:38:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1581730715; x=1613266715;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=aNsmvkaH4ULgQFsXfejZzWVM/4puB/idKPxtDie+r7g=;
 b=JbY+lf0GkhiyaTma1FZCf8aDIJJ4WxoJRJg0roefJNBHn5nx1cUhOg5D
 +OM8GcwE8TBksCLHEW4IjGdK7S93k05XSImrSzrkxVqeST/mSBhrZgDbK
 OxRBaFTEWK/P0I6TSkJVxhiMmTkYN3lLwfaJCQwXuJAjpsef5QgGIW9FZ
 FkE6GXpguvmbA2fKLKZos1MqGlYkyyecBChfFPCHtEh8sZgqjhdftZntO
 b5+1X0Gwc9Dz2cVASmkVDcVeMNqT29EqEM7yA6EkT5HfGKq0OZcicN9e+
 DkHddTjCRztNFg+9P7CAVQft6QDIKMydWYqzxTmBndWbYrsRLt20lCCP0 g==;
IronPort-SDR: ufgam2ADPW2S1M+TuYR/DifWHtR404Lp55ty5JZB1dnVfbp4XPzVZN6PSmlLvTHnhTL6s72wmp
 AtXFW9Ac4SXX5kpG27I8/jrPjy6sCWrJNnBsvMPaEkemtr2J4xkAOk3y0FtlFuMhFU9zgE+Mzd
 wvVo4VKXxPUXdVHZpCggz+RpLI5U+YDDpzROg1KdJEo/GFkdn6tI+2ZrfpftsO051LUV1mrZ8V
 UGEsdeotbWP9/upmfuwCcUQQE1uhHUk7CxTjr15ZO3fjyTpGCPedPIpYw48bzgovGIxFn+OCgd
 liw=
X-IronPort-AV: E=Sophos;i="5.70,442,1574092800"; d="scan'208";a="129907005"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 15 Feb 2020 09:38:32 +0800
IronPort-SDR: q5WiJbN9qZJUZlFJDTDeajodbp/vPSWrwJuP9sCzDEcwF9TcsE1pdxUUExCczaEWp2EUyJ5D1S
 vVoSlPnduZua8XbIUMTAE7+/JPuDoTzeAAXck0oiEwRW5eeQpvudLJxSPpb5QNvXCWrwYu49o9
 9lOyP+zbvebbHxmGMihoiO7HPNIYQ2H7KOvpALKgBER3PRFHP198TewDQZ96wagePhlcQKoreg
 milvxLTESTCAg7lTpykcYCF2H//D2wZ75CunudiB4ApN4WUBzhABJoW6Y4N7dbI3VnlVmGP8Pq
 8hksVrcg2KiBYHYNEZHJLCjZ
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Feb 2020 17:31:17 -0800
IronPort-SDR: mXXkIDZ3lJFYANe+amb8ctB+mL/we5+Tfq9lkGy7gt06t4kQ1JOok4j/pEZcYJ71a6Jg6Bleu4
 Nc6pGJ56wnGo4gBkA2z8SXd/D1elvNpZwYqfowxvrNFEHniDppGXsBxspymEBDosAAkp5STU66
 iCNAfmue1hVRPlpDbfvdk1x9cTOJ/uz2KFOqOsJBSWeSKsvp0eknl9MRP4NplWEdI4kJ0jMrIF
 s3bB/MBt5eb5XA8VKq/iq40eyR4ZXduXN+498vlF6dnufcYA4AisMVukZb8qbVdE48Lz2K4vZ/
 p6c=
WDCIronportException: Internal
Received: from iouring.labspan.wdc.com (HELO iouring.sc.wdc.com)
 ([10.6.138.107])
 by uls-op-cesaip01.wdc.com with ESMTP; 14 Feb 2020 17:38:32 -0800
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: osandov@fb.com
Subject: [PATCH blktests V2 0/3] nvme: add cntlid and model testcases
Date: Fri, 14 Feb 2020 17:38:28 -0800
Message-Id: <20200215013831.6715-1-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200214_173835_543177_760BE1DA 
X-CRM114-Status: UNSURE (   8.65  )
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
Cc: linux-block@vger.kernel.org,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
 linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hi Omar,

This is a small patch-series which adds two new testcases for
setting up controller IDs and model from configfs.

I've tested these testcases with and without newly added attribute.
If they still fail on your system, I'll creata a new vm and test it
on nvme-5.5 branch.

Regards,
Chaitanya

Changes from V1:-

1. Reorg series into three patches.
2. Fix shellcheck warnings (and shellcheck on my machine :P)
3. Fix test description.
4. For model related testcases declare global variable model and use 
        nvme list | grep "${nvmedev}n1" | grep -o "$model"
   instead of 
        nvme list | grep ${nvmedev}n1 | grep -q test~model.

Chaitanya Kulkarni (3):
  nvme: allow target to set cntlid min/max & model
  nvme: test target cntlid min cntlid max
  nvme: test target model attribute

 tests/nvme/033     | 61 +++++++++++++++++++++++++++++++++++++++++++
 tests/nvme/033.out |  4 +++
 tests/nvme/034     | 64 ++++++++++++++++++++++++++++++++++++++++++++++
 tests/nvme/034.out |  3 +++
 tests/nvme/rc      | 25 ++++++++++++++++++
 5 files changed, 157 insertions(+)
 create mode 100755 tests/nvme/033
 create mode 100644 tests/nvme/033.out
 create mode 100755 tests/nvme/034
 create mode 100644 tests/nvme/034.out

 Here is the test result with and without cntlid and model attributes :-
Shellcheck :-
# /bin/shellcheck -x tests/nvme/rc tests/nvme/033 tests/nvme/034 
# echo $?
0
# for i in 033 034; do ./check tests/nvme/${i} ; done 
nvme/033 (Test NVMeOF target cntlid[min|max] attributes)     [not run]
    attr_cntlid_[min|max] not found
nvme/034 (Test NVMeOF target model attribute)                [not run]
    attr_model not found

# for i in 033 034; do ./check tests/nvme/${i} ; done 
nvme/033 (Test NVMeOF target cntlid[min|max] attributes)     [passed]
    runtime  1.706s  ...  1.513s
nvme/034 (Test NVMeOF target model attribute)                [passed]
    runtime  1.672s  ...  1.510s

-- 
2.22.1


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
