Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C795C44506
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Jul 2026 00:39:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=btQxTIbdbYBYI6OzCtXqpS++/vw2I8O1W2QBjTyETBU=; b=SnF3BBSwNw/aSvvqzBeqfuhpMj
	7dE3dnfXatKyqXu+Bq+1CNyTLOm7KEeOJre4zHyGvC9AMB4kU7rjb3zcA4a9RUAxsdw6GHk0jM9lB
	P6SiBode5VMcMZWWOtYohcmbO0JfARZ2whlWhrE66BR9ATehcKasE4QH4AcILYoPhco/8OCT4nbfq
	3SYTh9h/nyKxokJN7eCpdzvxVsQxGFi5VRne0y0b5gsQOeDXN5nK8nuH2dfCirLvcrPd7xpO9kbaV
	jwSXkWk1+z87JSQxM1zB+/p/oB5ivQTk4i1wExNrcOBXtJT1lRx3TYSiG5xwz6gsz/3MQ7We/mU9x
	6kuyAHHA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wj4i2-00000007siG-3FFU;
	Mon, 13 Jul 2026 00:39:46 +0000
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wj4hy-00000007seq-2sID
	for linux-nvme@lists.infradead.org;
	Mon, 13 Jul 2026 00:39:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1783903182; x=1815439182;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8H/0mCTkJMkPzcYD4o3sbbf7LqUYAMx8I4+2cKQ7wTo=;
  b=IhYHjazcpPSepv9gS6GMYI8bE+MhsHH+wIfVGt+WSzcLkUDQ5QUYSk5D
   aLLTPhkgFVdBYBUtigiIYFURPR/sgEu8lfrlnvZDhZ4ZZqu+aZRpMSna0
   Yddb6JNc3IWGqHjGMfIpOc2qKfRHnKRg4DGd9Ws56thxqXzsJbI92DcPi
   TQROwYMGcAxj27E5XmdWZAIu8Ap2SNSSwo42te9SC1WgfjD/0nrT9Dwpy
   4rh6ayd+tr8jGzAOkps0Xh0dFUNmEtN4zhsFK4YJdM+N/6l+adRNhKtbw
   IjgvLzi6CHhx52p+t/9SQ217S3pUdtIoCog7uMQJ5UDy6v0V1RjHn+W3g
   A==;
X-CSE-ConnectionGUID: Cf8Sg45aS52bf+u32ad02Q==
X-CSE-MsgGUID: kNosbLM0TkOxlz6ouaqm4Q==
X-IronPort-AV: E=Sophos;i="6.25,154,1779120000"; 
   d="scan'208";a="150596181"
Received: from unknown (HELO uls-op-esad1-o.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 13 Jul 2026 08:39:40 +0800
X-CSE-ConnectionGUID: myunTwGBQ4yOadV541ppZA==
X-CSE-MsgGUID: eGhlQKUMRcakSa1IYJb2TQ==
IronPort-SDR: 6a5433ac_z4vm/ZsV223D09y5C1Q+hmU6flJrkVUvFuqe9RPQifZKOpN
 bzCwXa42AEPd0JMkSgJROeGpLdDNOXwS3MG4K9w==
Received: from uls-op-esai1-o.wdc.com ([10.248.3.45])
  by uls-op-esad1-o.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 12 Jul 2026 17:39:08 -0700
X-CSE-ConnectionGUID: 2UKQtayZR6O4DW4tGCr6wg==
X-CSE-MsgGUID: MT2XTl1YT8mPM4IUoCYjkw==
WDCIronportException: Internal
Received: from unknown (HELO shinmob.iptvf.jp) ([10.224.106.2])
  by uls-op-esai1-o.wdc.com with ESMTP; 12 Jul 2026 17:39:08 -0700
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Cc: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests 1/4] check: fix exit status code handling
Date: Mon, 13 Jul 2026 09:39:03 +0900
Message-ID: <20260713003906.21153-2-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260713003906.21153-1-shinichiro.kawasaki@wdc.com>
References: <20260713003906.21153-1-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260712_173942_731037_1E6FEB34 
X-CRM114-Status: GOOD (  12.72  )
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

Commit e50a5ff644f3 ("check: call _unload_module() after
fallback_device_cleanup()") added a _unload_module() call to
_check_and_call(). However, after this commit, _check_and_call() no
longer returns the exit status of _call_test(). Then, the check script
does not return non-zero exit status even when any test case fails. Fix
this by adding a local variable to keep the exit status of _call_test().

Fixes: e50a5ff644f3 ("check: call _unload_module() after fallback_device_cleanup()")
Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 check | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/check b/check
index bc2dde9..61524a5 100755
--- a/check
+++ b/check
@@ -701,7 +701,7 @@ _unload_modules() {
 }
 
 _check_and_call_test() {
-	local postfix
+	local postfix ret
 
 	if declare -fF requires >/dev/null; then
 		requires
@@ -710,7 +710,9 @@ _check_and_call_test() {
 	[[ -n $COND_DESC ]] && postfix=_${COND_DESC//[ =]/_}
 	RESULTS_DIR="$OUTPUT/nodev${postfix}"
 	_call_test test
+	ret=$?
 	_unload_modules
+	return $ret
 }
 
 _check_and_call_test_device() {
-- 
2.55.0


