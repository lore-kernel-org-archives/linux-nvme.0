Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CAE4C05027
	for <linux-nvme@archiver.kernel.org>; Tue, 14 Feb 2023 04:47:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/vW3vS865dW2y5enLTrCVx+KnjbTUBIvo0MNNsBc+qQ=; b=bJDWHnsCEDTIphYZyCghWd1yNb
	7A95tBZnrC5dL9t1ntT85zdaHHCig0Nz5bwBejMCcVAQu9CXnOy+M8PZwcEYcPLB8YZd4EKyff4Q+
	C97fA+3warbK4FwOiw+VHeSJ5lfz5MQdZlYoIkSB7ccX7y04brgsJg1qLraJ/GzFSNo6mKysVpQ76
	c5nK3aSCNTP8B8Yqfaf9OJ3P1bmWhD/bL+ZVDJdS7MXxf1FY5P8dAwshxB4PwrESDTD+aAMDYGuu4
	pFD2c0LYY0qrp9oNa8IV5etT5XXCTRSPouomZrc2lq1jPxV+L9DaVHfSjkCJEIUijjV976E1Oqe1h
	W3ydd2AA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pRnEO-00HRsJ-3B; Tue, 14 Feb 2023 04:47:52 +0000
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pRnEG-00HRpb-3M
	for linux-nvme@lists.infradead.org; Tue, 14 Feb 2023 04:47:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1676350064; x=1707886064;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=706ISowlsI7TcwwD4qz2Zdc7nmdg/lEhqhN+DAUvWrA=;
  b=RTwyjZIcSPYT8DZOsaYjR/C/n4lM1nHfT9JyVR/X9M4Se/Uotj6VdBnA
   L9XMn9HVd8UznPGkpJe3Nslc4V72vdSa+8eoSRUgIyp4azhsrnRNqQeAJ
   kzfML44/KRnfL0npQQc4F6GFg0qg2K3tjZZmum2cJceMmnKQKvkx+je4q
   Lyl46QCmlZVXVekB3q4I6wrH6cwsJVpha3vevAtkTM+hIjJagSoEP5Tpd
   YLYp2tTjbLy9CfliWNT6KKzEfZaGB9fI/rnGIDQAryzZwmVPINn+VgKaI
   qYGvRhwpoyJvNlKBc1z+mjJ65FSlQ9QHh2tKuHY8NfhQAYcF/YhjCxSPa
   g==;
X-IronPort-AV: E=Sophos;i="5.97,294,1669046400"; 
   d="scan'208";a="223261588"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 14 Feb 2023 12:47:42 +0800
IronPort-SDR: da3L1/XmLpfCridTjFmY81KVFNZNsB16d80+/62QaJ3298HJAPV0kV/wG6XTtgNE/NR1stxDOU
 pXiR+KSAerUUNh/ZA8X7DPnxLj2ZDE6aJ+r538fDFaUiiRo0bxq5LNovqrPKlDaoE57tbFDIUq
 M4z1FvFpj4aUnMstnD9/mcWxjT+mJCirgN6d0nYTN/jMUxsh5iT7az28b2NzXFLEmToAOmt1po
 bT7xtYTQXtaL/LUhMf6zF7nCWiFmFrgiHqSHT+JLAs4gZxtXFHfo1q+0r1yV54zdd/+MzTuUaN
 0X0=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 13 Feb 2023 20:04:51 -0800
IronPort-SDR: H+ZlCuRjtxKHnpkDbhXhDSD1LuwJJePMGcPYw/Ksbp9fgraA/BT2nlO7FBQHB9uc6W6//Z1kxJ
 YP7GExzpNdQ0Q/WpAD97c+mh6ISBYr2IXU/Hf+jwUUIEksvsCY+cLy7vGN96ymWf66DljcAVAm
 hOXAFVPFku1nfrMs4/yUeHT6o6W9oJ3amcxYG+/c7Ft1pOYjUMacIZ7M1cetvnsfW162UVMbwI
 u0xMRWzpp+Qx+4EyonycCGk90qPCd66Ku69497s9OZDhJ93ODzedPZcA7GBWPqGnum53m2Q1/7
 gWQ=
WDCIronportException: Internal
Received: from shindev.dhcp.fujisawa.hgst.com (HELO shindev.fujisawa.hgst.com) ([10.149.52.207])
  by uls-op-cesaip01.wdc.com with ESMTP; 13 Feb 2023 20:47:42 -0800
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	Kanchan Joshi <joshi.k@samsung.com>
Cc: Christoph Hellwig <hch@lst.de>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests v2 1/2] check, common/rc: support normal user privilege
Date: Tue, 14 Feb 2023 13:47:38 +0900
Message-Id: <20230214044739.1903364-2-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230214044739.1903364-1-shinichiro.kawasaki@wdc.com>
References: <20230214044739.1903364-1-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230213_204744_244309_4957AA20 
X-CRM114-Status: GOOD (  16.27  )
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

To run commands with normal user privilege, add a new config variable
NORMAL_USER and two helper functions _run_user and _require_normal_user.
The user name specified to NORMAL_USER is used to run the commands
specified to _run_user. The test cases which require NORMAL_USER shall
call _require_normal_user to ensure the NORMAL_USER is valid.

Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 Documentation/running-tests.md | 10 ++++++++++
 check                          |  1 +
 common/rc                      | 13 +++++++++++++
 3 files changed, 24 insertions(+)

diff --git a/Documentation/running-tests.md b/Documentation/running-tests.md
index 586be0b..3550f37 100644
--- a/Documentation/running-tests.md
+++ b/Documentation/running-tests.md
@@ -113,6 +113,16 @@ use_siw=1 ./check nvmeof-mp/
 use_siw=1 ./check srp/
 ```
 
+### Normal user
+
+To run test cases which require normal user privilege, prepare a user and
+specify it to the `NORMAL_USER` variable. The test cases are skipped unless a
+valid user is specified.
+
+```sh
+NORMAL_USER=blktests_user
+```
+
 ### Custom Setup
 
 The `config` file is really just a bash file that is sourced at the beginning
diff --git a/check b/check
index 34e96c4..8eaf5c6 100755
--- a/check
+++ b/check
@@ -799,6 +799,7 @@ fi
 
 : "${LOGGER_PROG:="$(type -P logger || echo true)"}"
 : "${RUN_ZONED_TESTS:=0}"
+: "${NORMAL_USER:=''}"
 
 # Sanity check options.
 if [[ $QUICK_RUN -ne 0 && ! "${TIMEOUT:-}" ]]; then
diff --git a/common/rc b/common/rc
index ef23ebe..af4c0b1 100644
--- a/common/rc
+++ b/common/rc
@@ -381,6 +381,14 @@ _require_test_dev_is_partition() {
 	return 0
 }
 
+_require_normal_user() {
+	if ! id "$NORMAL_USER" >/dev/null 2>&1; then
+		SKIP_REASONS+=("valid NORMAL_USER is not specfied")
+		return 1
+	fi
+	return 0
+}
+
 # Prints a space-separated list with the names of all I/O schedulers supported
 # by block device $1.
 _io_schedulers() {
@@ -409,3 +417,8 @@ _have_writeable_kmsg() {
 	fi
 	return 0
 }
+
+# Run the given command as NORMAL_USER
+_run_user() {
+	su "$NORMAL_USER" -c "$1"
+}
-- 
2.38.1


