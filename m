Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95857C61DC6
	for <linux-nvme@archiver.kernel.org>; Fri, 28 Aug 2026 08:27:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=iB8sFr9oXNS8vMudei/AQbqeBIj7gdLa8Z+LDBqSItI=; b=pRelCQ0hdKA2LIAJbT7fZOIXUA
	fuwf9nEG/RO+7np7nhtPIiHVfJq7MmwvWQYTGLUMTGQE4f2AIU7Sn18GaZbMv4bJELq63V2zbNhwQ
	vgxfea/+zDTknB9REjfiFEf23we1pa7x0GV5ojRHkOukZynzzQ70P1I/USMWeG43IL6P2F0IqMnqr
	lIs5o2nBVwbf+TqTNEXY9J+7xTdWlOeMotJLuvktTuJ8kw8fdwlUfmZY4f/xPYOdhJyeQgMIz3AhZ
	alJWk6D28V3Q4qCZBnxLnDlb8nHp//n+T2B6KQCRuLSb6B89oYqjjWLasn7hGD+LG3mPMERtoGrRT
	ruGZoxig==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wzrwA-00000005K3z-1bKu;
	Fri, 28 Aug 2026 08:27:46 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wzrw8-00000005K3e-1xnG
	for linux-nvme@lists.infradead.org;
	Fri, 28 Aug 2026 08:27:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1787905668; x=1819441668;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=D3Oj0C08VUfUSusSfHmqAfxIcLoD0+h9XAxWMxwtGy8=;
  b=X5imppYBRFEYvJuVut0I1cVVLDeqFYZlLiQXQ3T4Legx4lHOyeMOYUXx
   fxw+fMKruB2DFrkVU+iyi3mEYk96355ySjFP65NP092wMK1GZsSn533e3
   t++QyCgh2BekuAgGJNJimbSvugilXNnPmuC2HzXFk3rAsu3kTqleC+/0i
   4OVJOFpXL2eeg+4ib7oxEzElkKCBbZkgyZyg9IShuKul7X2sg8zB7dm6R
   BKyz9/r0wl3mzD65fUkQ1JZmz91/RBWyMF6RWNsR1g8T15/uYcbE5ekAm
   RUQosxlVDLgDL5KKCP2izh0VmOj1A80DoxQp7ccGchvZ3r4tUCnqNzEmh
   A==;
X-CSE-ConnectionGUID: txGzO8LlSfa1hcd6Fk5fZQ==
X-CSE-MsgGUID: 0OX6/JlMQ7aO6/TS62PE5A==
X-IronPort-AV: E=Sophos;i="6.25,248,1779120000"; 
   d="scan'208";a="153491446"
Received: from unknown (HELO uls-op-esad1-o.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 28 Aug 2026 16:27:47 +0800
X-CSE-ConnectionGUID: PQY72C+LQjmqazBoqRYtzg==
X-CSE-MsgGUID: nAgIlXgQTYyjFSb8wBniCw==
IronPort-SDR: 6a91466a_FlxPjzk3kMzptx6hBTwezx2vdORe72WjN3zUw0OWD4Iehtk
 /fRoGVp9TAatt9XgLrFYlcWt8pyMncniFRr9Djw==
Received: from uls-op-esai3-o.wdc.com ([10.248.3.41])
  by uls-op-esad1-o.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 28 Aug 2026 01:27:22 -0700
X-CSE-ConnectionGUID: +e37ZBb4Qayiso+aPSEI7w==
X-CSE-MsgGUID: 9HxVegiETziQkQVAVfPa1A==
WDCIronportException: Internal
Received: from unknown (HELO shindev.ssa.fujisawa.hgst.com) ([10.149.67.30])
  by uls-op-esai3-o.wdc.com with ESMTP; 28 Aug 2026 01:27:21 -0700
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-nvme@lists.infradead.org
Cc: Daniel Wagner <dwagner@suse.de>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests] common/nvme: do not truncate FULL file at nvme disconnect
Date: Fri, 28 Aug 2026 17:27:21 +0900
Message-ID: <20260828082721.2828731-1-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260828_012744_525894_9DCD96B6 
X-CRM114-Status: GOOD (  11.56  )
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

Commit df7cf50409ce ("nvme: rely on nvme-cli status code") reworked the
nvme-cli command error handling. As part of that change, the 'nvme
disconnect' commands in _nvme_disconnect_ctrl() and
_nvme_disconnect_subsys() were made to record their output in the FULL
file using the '&>' redirect operator. However, '&>' truncates the file
and so overwrites its existing content, wiping out the logs that each
test case had already left in the FULL file.

Use the '&>>' operator instead, which appends the command output while
preserving the existing FULL file content.

Fixes: df7cf50409ce ("nvme: rely on nvme-cli status code")
Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 common/nvme | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/common/nvme b/common/nvme
index f399937..a11401c 100644
--- a/common/nvme
+++ b/common/nvme
@@ -354,7 +354,7 @@ _nvme_disconnect_ctrl() {
 	if [[ -d "${ctrl_dir}" ]]; then
 		local ret
 
-		nvme disconnect --device "${ctrl}" &> "${FULL}"
+		nvme disconnect --device "${ctrl}" &>> "${FULL}"
 		ret=$?
 		if [[ ${ret} -ne 0 ]]; then
 			echo "FAIL: nvme disconnect returned error code: ${ret}"
@@ -638,7 +638,7 @@ _nvme_disconnect_subsys() {
 		esac
 	done
 
-	nvme disconnect --nqn "${subsysnqn}" &> "${FULL}"
+	nvme disconnect --nqn "${subsysnqn}" &>> "${FULL}"
 	ret=$?
 	if [[ ${ret} -ne 0 ]]; then
 		echo "FAIL: nvme disconnect returned error code: ${ret}"
-- 
2.54.0


