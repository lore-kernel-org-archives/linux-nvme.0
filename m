Return-Path: <SRS0=XnCc=GP=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3076C433DB
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Jan 2021 21:14:38 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3EFC323117
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Jan 2021 21:14:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EFC323117
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=TvPQzFublWwj/04zi2PNzqj8lUgBzznJrjF++Enb7D0=; b=sCXikCKAx6Z7yhQSJhFp3XX/pY
	Nqo+2aDovGPKZBCpNDkzPCfUXj13HnmTdSVo98JZXqvtUpQjMw7jdfIr+YiR1o96fA1gD/UZPiuls
	muoJVqE6TiZS0FJBnjIV7JDa7Uje+/5DvfRzeT55AsOv5658za2iMuNzch4UrIWJ0FzzIVoTkjILd
	wJducpNTYqEd1JbB/2nNjgdUn5jTCKAWAsz84T+odYJDsU9smcJx5kqLBCdOljj1bpez3zO0749ut
	VaUzrE0HmpFb4pLWSdkO6mhV972qzbfWYxdEN8m4FgwJQB0KHb45sX25DTbbucwUk9VvNog1lR6fd
	Kh/lRLDQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kzQzc-0004wp-Uu; Tue, 12 Jan 2021 21:14:21 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kzQzX-0004uU-PA
 for linux-nvme@lists.infradead.org; Tue, 12 Jan 2021 21:14:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1610487236; x=1642023236;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=pTFHHP6Zw8a9EfrHf76n+TOUELeKvVrssC5/HkNCKR0=;
 b=WgEnO8YWZIhOxXAXKK2crOTLOHiTmfOSqhG6sq7IGX7fpaEYCqYLnEqf
 7SpPpX6/VpNK3+mZGFSFhbby5dALgTLcR0bzrf88sJwFKoQz/DOG9FRUr
 UPJi0AhmTWk6MlvDIL60Ub4MJ0QExH2IaVtvHy75JbaJ7lfKDnYXUMsUf
 nhRaP03GpKbZRYiJ5b9wGi+9yqOFiYytnqjA7Rz9amCrhSTTsVTveozxO
 L4/i26xZqvjjKba8xUWed8IEJVDxitvmRD8wNhf8Kgjuo+Yc9YE2GwOpE
 QTX45Akhifhh6XsbGHjlRsC1AQUz5xPBef+XRSUgAoRRFA16Zw38bdEyV Q==;
IronPort-SDR: 5l6SLhreLY2rkCIg/AUj56h1C2jlk8foacWeFIAb5qmBCTFQyiaw/NAooPdz+QHYCaNySozLOk
 ykGb6Hqn4DRyxtzq3+f0B7VBA+cB2lvHN2jHxxNuRS7Ux0oVOb5otjdHdfQaFye/ATsG/2nWuH
 rgd9Og9VINP1hN/A7MJ6ataw9cyGd6ZhpaDDBVt3PVv6tJm8IFrh/A/UU5qVVBNOE681RBRCV3
 dZjGSmLu9emUwr2GQ6GrQ/pbxs21sIm7Ue+OkW+rCn5hkLCG+wja+MVBLBjSY02Y22izZMNQcS
 dYk=
X-IronPort-AV: E=Sophos;i="5.79,342,1602518400"; d="scan'208";a="261177452"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 13 Jan 2021 05:33:52 +0800
IronPort-SDR: W1K1GfWphDlCtpQDgHWOBvO4yLvo8FHiVrsBh7KEZA3ipj61NA5jdCBESIOmqSpi9mrjQOzajc
 P2Tb++n2wbQYEYPZ1E9sS3N/7jLhdaxPjRKurysdu3w3iwVBCWOikmtgwl+XjmSuZnHC6V/sOl
 47k+ZY92SZ4F68tcesP+aPDPCDUJk3+e97LrPM2jdMGgJZ0KgFnvGDsAPJMmiQSR9+eWwoCwwv
 Wzt0Drhl1SEr+EUaee5Wkq0bg20caw8skM0T5fTY7KSds/g8zr9VMcCtCZ37WngYtZ6euhPiif
 yS3Djz3VkdNtMrl6Feo24lda
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Jan 2021 12:57:05 -0800
IronPort-SDR: fQERmBxBg9vWypyCwGBh19MMqiU0BzaaBPvuklRL7zHp6iQR4oI5OoPpp53FIseuAiTFMZCZBz
 rmAhXlIxzIzySdySakjcZHviU921nE3OL2pcZijJIotY02r3v4y+nQQvxF2FFz4NAmQqgoP24V
 ux7p4zbjVr8r/ISffJogLEFfad0NHnOCImVRv0IsYYJryujIq1LXhU+icvCtnu/Qiqw0yLT5wZ
 cRa23t4/sIgIDFdNfjPIKyR6RqpFJee6zItaHc8VzzJHVkOXvoEV8TC/+BzYLQAS+zdeJTTyAO
 T0w=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip01.wdc.com with ESMTP; 12 Jan 2021 13:14:13 -0800
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Subject: [V3 0/4] nvmet: admin-cmd related cleanups and a fix  
Date: Tue, 12 Jan 2021 13:14:06 -0800
Message-Id: <20210112211410.24742-1-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210112_161416_067403_C5A1CB2B 
X-CRM114-Status: GOOD (  12.01  )
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

There are three functions where local variable ns is used instead of
using req->ns which leads to duplicate nvmet_put_namespace() calls.
We can just use req->ns and not the local variable to avoid duplicate
calls. First three patches fix that.

The first patch sets the right error status code when namespace is not
found in nvmet_execute_identify_ns().

I've tested this series with nvme blktests, all the testcases are
passing.

-ck

Changes from V2:-

1. Rebase and retest on the latest nvme-5.11.
2. Add ns status error patch at the front of the series.

Changes from V1:-

1. Rebase and retest on the latest nvme-5.11.

Chaitanya Kulkarni (4):
  nvmet: set right status on error in id-ns handler
  nvmet: remove extra variable in smart log nsid
  nvmet: remove extra variable in id-desclist
  nvmet: remove extra variable in identify ns

 drivers/nvme/target/admin-cmd.c | 74 ++++++++++++++++-----------------
 1 file changed, 36 insertions(+), 38 deletions(-)

# !./check
./check tests/nvme
nvme/002 (create many subsystems and test discovery)         [passed]
    runtime    ...  27.806s
nvme/003 (test if we're sending keep-alives to a discovery controller) [passed]
    runtime  10.143s  ...  10.136s
nvme/004 (test nvme and nvmet UUID NS descriptors)           [passed]
    runtime  1.697s  ...  1.730s
nvme/005 (reset local loopback target)                       [not run]
    nvme_core module does not have parameter multipath
nvme/006 (create an NVMeOF target with a block device-backed ns) [passed]
    runtime  0.115s  ...  0.113s
nvme/007 (create an NVMeOF target with a file-backed ns)     [passed]
    runtime  0.072s  ...  0.074s
nvme/008 (create an NVMeOF host with a block device-backed ns) [passed]
    runtime  1.740s  ...  1.720s
nvme/009 (create an NVMeOF host with a file-backed ns)       [passed]
    runtime  1.671s  ...  1.683s
nvme/010 (run data verification fio job on NVMeOF block device-backed ns) [passed]
    runtime  19.842s  ...  25.213s
nvme/011 (run data verification fio job on NVMeOF file-backed ns) [passed]
    runtime  232.526s  ...  257.846s
nvme/012 (run mkfs and data verification fio job on NVMeOF block device-backed ns) [passed]
    runtime  46.703s  ...  47.453s
nvme/013 (run mkfs and data verification fio job on NVMeOF file-backed ns) [passed]
    runtime  284.149s  ...  249.408s
nvme/014 (flush a NVMeOF block device-backed ns)             [passed]
    runtime  21.989s  ...  22.446s
nvme/015 (unit test for NVMe flush for file backed ns)       [passed]
    runtime  19.330s  ...  18.614s
nvme/016 (create/delete many NVMeOF block device-backed ns and test discovery) [passed]
    runtime  16.634s  ...  16.945s
nvme/017 (create/delete many file-ns and test discovery)     [passed]
    runtime  16.120s  ...  17.179s
nvme/018 (unit test NVMe-oF out of range access on a file backend) [passed]
    runtime  1.665s  ...  1.676s
nvme/019 (test NVMe DSM Discard command on NVMeOF block-device ns) [passed]
    runtime  1.692s  ...  1.701s
nvme/020 (test NVMe DSM Discard command on NVMeOF file-backed ns) [passed]
    runtime  1.655s  ...  1.662s
nvme/021 (test NVMe list command on NVMeOF file-backed ns)   [passed]
    runtime  1.648s  ...  1.666s
nvme/022 (test NVMe reset command on NVMeOF file-backed ns)  [passed]
    runtime  2.086s  ...  2.099s
nvme/023 (test NVMe smart-log command on NVMeOF block-device ns) [passed]
    runtime  1.683s  ...  1.699s
nvme/024 (test NVMe smart-log command on NVMeOF file-backed ns) [passed]
    runtime  1.653s  ...  1.659s
nvme/025 (test NVMe effects-log command on NVMeOF file-backed ns) [passed]
    runtime  1.653s  ...  1.649s
nvme/026 (test NVMe ns-descs command on NVMeOF file-backed ns) [passed]
    runtime  1.663s  ...  1.658s
nvme/027 (test NVMe ns-rescan command on NVMeOF file-backed ns) [passed]
    runtime  1.661s  ...  1.665s
nvme/028 (test NVMe list-subsys command on NVMeOF file-backed ns) [passed]
    runtime  1.659s  ...  1.663s
nvme/029 (test userspace IO via nvme-cli read/write interface) [passed]
    runtime  2.009s  ...  2.025s
nvme/030 (ensure the discovery generation counter is updated appropriately) [passed]
    runtime  0.316s  ...  0.317s
nvme/031 (test deletion of NVMeOF controllers immediately after setup) [passed]
    runtime  5.608s  ...  5.559s
nvme/038 (test deletion of NVMeOF subsystem without enabling) [passed]
    runtime  0.045s  ...  0.046s

-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
