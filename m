Return-Path: <SRS0=KTZ6=3S=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,URIBL_DBL_ABUSE_MALW,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 232F3C2D0DB
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Jan 2020 23:29:42 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E43BB206D5
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Jan 2020 23:29:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Jp+pqMMO";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="HRYW7ZjN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E43BB206D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=YQvRTQexTNWZVkQ7kS1rhjmIfkBXCBwd/IblOC/Bnys=; b=Jp+pqMMOisy1a4
	0nt++haCB/MC6i5tXdYlwRX5unUWNXhYxebA3Z+sf4ncXNwy9b6HYixhitH7Hmsws0H0XuIn4aB55
	YAyvtbqPehuAPa98vSp/7yLaCI8vlw3JcIHnCFu3WY38/oukAMz8qO8vAO9temsQyjabWlu1g1sLF
	iGHmB7jscQIUwgv+9iSak8Gc+xQeZfGfSZjxrYS3fn8V4HtXh2PnJTws4IhMF0niKNUsANHJG3J+2
	Vf2Fx2wnEmEGuJR0fRomGpT/2qd9v+bwY/WGwBIemZc36/NWdzrDRS3IxBi/0xVGgZCDNcSg4MMzk
	GPOtX0vojstNC2EfW33w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iwwm7-0002d2-Qy; Wed, 29 Jan 2020 23:29:35 +0000
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iwwm4-0002aI-Mb
 for linux-nvme@lists.infradead.org; Wed, 29 Jan 2020 23:29:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1580340573; x=1611876573;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=smzJ9aLrfZQAYLsAFApydMD2EtHWMA2/FV/r3qlGdVQ=;
 b=HRYW7ZjN1Mgu0HmFQ4BdcN2Hg8EYkAIRhxXA17vDRCB2c1k+tmU9+ngJ
 +GDAo6sr36Kv4ABAFZA25/oCshsSYzKR0whJZXWJBfqQ5N9WNBKP2eT7y
 sWJZ4nTpOvtDUhahNL9BPSX8iC/iFvvpXo8BDb1RYCDke4xLueLl5Xmhw
 hUd8iDlSY94v0CSpEz8TguoBITmV+lGEdJLZ+7gqzpuYPbszz97THk+XZ
 ocnNTWkGav7/OsDIKFEixnE52EHLtg7j9Dn1vI9h3I0hERlHkfdrVt+Y1
 ymPcZ72RNYtTiqZ2huiIKaz3qvkhV4YFDQKcTOrCaiqE0d2a88mRFQO9z w==;
IronPort-SDR: 9+m7cQPZLIKChpRCATMa9UzG5A28VAOJvJulTYLe7ZxgngLLl0Pi6/ck8fVPhJ6YHQJruNt2+k
 5lFKiFPidlkJRbV5sTNWqudTBTAkVD0OwT+rjYHu1RizBrkafoH1pl87hoLPx4CsGgvKLdFTEg
 H4BgKjqQwv+qYLeWtNefr1zN59/EnqYQ0AI2ivu1Km+NgAD1HNEr1A3b0lL8NpftaUbku/T2lS
 zGQLlt0youJTCVMiRM0p3v5vd/wcX0rwkZzLnUY115jzVNunVthSppTqHFgsZ9OpQRfR/OWU44
 C4Y=
X-IronPort-AV: E=Sophos;i="5.70,379,1574092800"; d="scan'208";a="130160257"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 30 Jan 2020 07:29:24 +0800
IronPort-SDR: 2jAzkTljErnGrpUQijcpN3+PC02F9IhtsC3nBcCBBZ7U2cUrI91DDRZT0Qfi+wj8d1ClZI27JS
 OyQq1CDewHnQ2AF8uyGe8mBEm/WRpHlJ/Rn+9qJKpbKKu+s9Tva9PjbS71qM6nsjcwtz0fGzO8
 1arGHdpGlSnllPI8Zz9NAG+KpBthqoFcXWZAfwoeq86F3IITeZeU5l74A4iPPvnYGVLYarJFVs
 kouvAHJtcjqWrYgeTwrId6Zlvy21ATMGVsb+iAk2gaOdgMf6gyHNdrChgMQuuuoE2m3i1caDef
 qEyEvJ8b0AQ571EU/z1Yyqsw
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Jan 2020 15:22:36 -0800
IronPort-SDR: liBZ+o5bt2p6wTYvaZcxXBghRE4XJlqf98IhZuF8dDoPxuEMVI0jeCl63SHUJySWZsOkPxT3XH
 7QjiaXBZd0nSazaK5yZ9JamH0N8zviNAzVkOQpQ8ZTMd6G9zaeTERnHZWQ7on8czrnn61gIIER
 AZhvyK7TdsC5hugdqRWQ1HNpURnqs0zWNMCgcsOag4jAXkZtBmyf/PYPLLVu5x+9DWezSnHmqg
 BD6qMpNZP6JelVSwJxP5nNy0Rc0H1/RWqq4K1zFCRzze9WDyUyCb5dwdHKRO5skdAYqV/i/UyU
 87Y=
WDCIronportException: Internal
Received: from iouring.labspan.wdc.com (HELO iouring.sc.wdc.com)
 ([10.6.138.107])
 by uls-op-cesaip01.wdc.com with ESMTP; 29 Jan 2020 15:29:24 -0800
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: [PATCH 0/5 blktest] nvme: add cntlid and model testcases
Date: Wed, 29 Jan 2020 15:29:16 -0800
Message-Id: <20200129232921.11771-1-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200129_152932_777672_3201823B 
X-CRM114-Status: UNSURE (   8.47  )
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
Cc: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

This is a small patch-series which adds two new testcases for
setting up controller IDs and model from configfs.

Regards,
Chaitanya


Chaitanya Kulkarni (5):
  nvme: allow target subsys set cntlid min/max
  nvme: test target cntlid min cntlid max
  nvme: allow target subsys set model
  nvme: test target model attribute
  nvme: make new testcases backward compatible

 tests/nvme/033     | 61 ++++++++++++++++++++++++++++++++++++++++++++
 tests/nvme/033.out |  4 +++
 tests/nvme/034     | 63 ++++++++++++++++++++++++++++++++++++++++++++++
 tests/nvme/034.out |  3 +++
 tests/nvme/rc      | 24 ++++++++++++++++++
 5 files changed, 155 insertions(+)
 create mode 100755 tests/nvme/033
 create mode 100644 tests/nvme/033.out
 create mode 100755 tests/nvme/034
 create mode 100644 tests/nvme/034.out

Test Log :-

Without cntlid_min/max and model patches :-

nvme/002 (create many subsystems and test discovery)         [passed]
    runtime  15.246s  ...  15.053s
nvme/003 (test if we're sending keep-alives to a discovery controller) [passed]
    runtime  10.057s  ...  10.063s
./check: no group or test named nvme/0004
nvme/005 (reset local loopback target)                       [not run]
    nvme_core module does not have parameter multipath
nvme/006 (create an NVMeOF target with a block device-backed ns) [passed]
    runtime  0.057s  ...  0.065s
nvme/007 (create an NVMeOF target with a file-backed ns)     [passed]
    runtime  0.036s  ...  0.038s
nvme/008 (create an NVMeOF host with a block device-backed ns) [passed]
    runtime  1.233s  ...  1.240s
nvme/009 (create an NVMeOF host with a file-backed ns)       [passed]
    runtime  1.203s  ...  1.208s
nvme/014 (flush a NVMeOF block device-backed ns)             [passed]
    runtime  14.572s  ...  16.051s
nvme/015 (unit test for NVMe flush for file backed ns)       [passed]
    runtime  13.584s  ...  13.948s
nvme/016 (create/delete many NVMeOF block device-backed ns and test discovery) [passed]
    runtime  9.877s  ...  10.750s
nvme/017 (create/delete many file-ns and test discovery)     [passed]
    runtime  18.902s  ...  15.584s
nvme/019 (test NVMe DSM Discard command on NVMeOF block-device ns) [passed]
    runtime  1.217s  ...  1.237s
nvme/020 (test NVMe DSM Discard command on NVMeOF file-backed ns) [passed]
    runtime  1.204s  ...  1.193s
nvme/021 (test NVMe list command on NVMeOF file-backed ns)   [passed]
    runtime  1.204s  ...  1.195s
nvme/022 (test NVMe reset command on NVMeOF file-backed ns)  [passed]
    runtime    ...  1.334s
nvme/023 (test NVMe smart-log command on NVMeOF block-device ns) [passed]
    runtime  1.218s  ...  1.231s
nvme/024 (test NVMe smart-log command on NVMeOF file-backed ns) [passed]
    runtime  1.207s  ...  1.196s
nvme/025 (test NVMe effects-log command on NVMeOF file-backed ns) [passed]
    runtime  1.191s  ...  1.195s
nvme/026 (test NVMe ns-descs command on NVMeOF file-backed ns) [passed]
    runtime  1.192s  ...  1.196s
nvme/027 (test NVMe ns-rescan command on NVMeOF file-backed ns) [passed]
    runtime  1.211s  ...  1.191s
nvme/028 (test NVMe list-subsys command on NVMeOF file-backed ns) [passed]
    runtime  1.204s  ...  1.211s
nvme/033 (Test NVMeOF target cntlid[min|max] attributes)     [not run]
    attr_cntlid_[min|max] not found
nvme/034 (Test NVMeOF target model attribute)                [not run]
    attr_cntlid_model not found

With cntlid_min/max and model patches :-

nvme/002 (create many subsystems and test discovery)         [passed]
    runtime  15.053s  ...  11.918s
nvme/003 (test if we're sending keep-alives to a discovery controller) [passed]
    runtime  10.063s  ...  10.058s
./check: no group or test named nvme/0004
nvme/005 (reset local loopback target)                       [not run]
    nvme_core module does not have parameter multipath
nvme/006 (create an NVMeOF target with a block device-backed ns) [passed]
    runtime  0.065s  ...  0.065s
nvme/007 (create an NVMeOF target with a file-backed ns)     [passed]
    runtime  0.038s  ...  0.036s
nvme/008 (create an NVMeOF host with a block device-backed ns) [passed]
    runtime  1.240s  ...  1.239s
nvme/009 (create an NVMeOF host with a file-backed ns)       [passed]
    runtime  1.208s  ...  1.207s
nvme/014 (flush a NVMeOF block device-backed ns)             [passed]
    runtime  16.051s  ...  15.345s
nvme/015 (unit test for NVMe flush for file backed ns)       [passed]
    runtime  13.948s  ...  13.977s
nvme/016 (create/delete many NVMeOF block device-backed ns and test discovery) [passed]
    runtime  10.750s  ...  9.698s
nvme/017 (create/delete many file-ns and test discovery)     [passed]
    runtime  15.584s  ...  15.514s
nvme/019 (test NVMe DSM Discard command on NVMeOF block-device ns) [passed]
    runtime  1.237s  ...  1.232s
nvme/020 (test NVMe DSM Discard command on NVMeOF file-backed ns) [passed]
    runtime  1.193s  ...  1.192s
nvme/021 (test NVMe list command on NVMeOF file-backed ns)   [passed]
    runtime  1.195s  ...  1.195s
nvme/022 (test NVMe reset command on NVMeOF file-backed ns)  [passed]
    runtime  1.334s  ...  1.340s
nvme/023 (test NVMe smart-log command on NVMeOF block-device ns) [passed]
    runtime  1.231s  ...  1.218s
nvme/024 (test NVMe smart-log command on NVMeOF file-backed ns) [passed]
    runtime  1.196s  ...  1.205s
nvme/025 (test NVMe effects-log command on NVMeOF file-backed ns) [passed]
    runtime  1.195s  ...  1.191s
nvme/026 (test NVMe ns-descs command on NVMeOF file-backed ns) [passed]
    runtime  1.196s  ...  1.186s
nvme/027 (test NVMe ns-rescan command on NVMeOF file-backed ns) [passed]
    runtime  1.191s  ...  1.192s
nvme/028 (test NVMe list-subsys command on NVMeOF file-backed ns) [passed]
    runtime  1.211s  ...  1.187s
nvme/033 (Test NVMeOF target cntlid[min|max] attributes)     [passed]
    runtime  1.213s  ...  1.200s
nvme/034 (Test NVMeOF target model attribute)                [passed]
    runtime  1.223s  ...  1.204s


-- 
2.22.1


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
