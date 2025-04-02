Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FFC2C28B20
	for <linux-nvme@archiver.kernel.org>; Wed,  2 Apr 2025 07:31:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cyouVwPgqsVp2glQTn/V1NHXhL6sEgHWIGiXdVLlPxE=; b=C+vQZ0dI1bEvzdlAuPZkTYerqe
	6nuyJP5w5oG8jHEc128QFcsohloFWyvjdD9+IG5diuz5CpLpfA0VdFST3RqGm4Jxu6pauVSUUpVL6
	vRwnKym91zblCqrMNNAmTdYMV/5bgRhgr/5xL/d5qD+8Xs67/WtvUlv/1jeea2ie7KbV7cyLPJIov
	aH6Z3aC6lSFSat8p5Y3OduH6WRjl0SUeBqrByyIDQ++0gryJQdQO8R16ZCcaTLf7XVjS9idh3KqF+
	WRjN8TOlqgJUqNLBdvnLV1fG30o5Di7mvTcAKXp6+t48vsd2/cduV1cC/CrX18h+PTohy32fEVZ2W
	br9WtGLw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.1 #2 (Red Hat Linux))
	id 1tzsZ0-00000005NEQ-44ss;
	Wed, 02 Apr 2025 07:31:06 +0000
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
	by bombadil.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1tzsDq-00000005Jv8-21c7
	for linux-nvme@lists.infradead.org;
	Wed, 02 Apr 2025 07:09:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1743577754; x=1775113754;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=J6/Hu2MKW11tsgpsq1VkvyADxkqS13Ky70HS3L0WoQs=;
  b=P1nkUe06uhysUDHvPyYxKzvR+u7YrvEUxKE1h74ZealxZQ7DSvvJu9sX
   EnWaFhP/6eInfCLjFYIX5qHGZwCnAlwlNF2fq97uKzllSlWW12uqqygf+
   oO3p1YgALH8rjThCheOoauzHYEMV4GLS8z0TYk5iF7O+jWJFWhFsOmgj0
   Tfjc1HK9/lNHnXWkQzQISBABbH6gXCL6izzS8qMe6fRXvVboTWOlFu/G1
   Tmzr28mpr6JCjZjX7/zdK/ydtT05ivV4cbgnlO/pUIekhUMSIRNRTrHP1
   7zVUinJygqP53UN+IVlMvIwbAGCpH27JR3E91zzP4DPhM4nQnY0mSy7Ll
   g==;
X-CSE-ConnectionGUID: dBufG/6bSdyi4dGdfwheGQ==
X-CSE-MsgGUID: UUKp1h29R0GedWCbnnhtXQ==
X-IronPort-AV: E=Sophos;i="6.14,295,1736784000"; 
   d="scan'208";a="67793494"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 02 Apr 2025 15:09:14 +0800
IronPort-SDR: 67ecd4a3_nxOqjKwVLCzzztGoI7eqlmcXI3rv65DMQ0HbhYA/h+b+DoA
 29vECPCS1jBc5T4gUfjD3vf0dtXI9FqKPtEVR9A==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 01 Apr 2025 23:09:39 -0700
WDCIronportException: Internal
Received: from 5cg2075fn7.ad.shared (HELO shinmob.wdc.com) ([10.224.102.114])
  by uls-op-cesaip02.wdc.com with ESMTP; 02 Apr 2025 00:09:14 -0700
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Cc: Hannes Reinecke <hare@suse.de>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests 05/10] nvme/rc: introduce _have_libnvme_ver()
Date: Wed,  2 Apr 2025 16:09:01 +0900
Message-ID: <20250402070906.393160-6-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250402070906.393160-1-shinichiro.kawasaki@wdc.com>
References: <20250402070906.393160-1-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250402_000914_620547_FC3053E9 
X-CRM114-Status: GOOD (  12.06  )
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

A following patch is going to add a test case which depends on the
version of libnvme linked to nvme-cli. Introduce the helper function
_have_libnvme_ver() to check the version dependency.

Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 tests/nvme/rc | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/tests/nvme/rc b/tests/nvme/rc
index 9584610..e52437f 100644
--- a/tests/nvme/rc
+++ b/tests/nvme/rc
@@ -617,3 +617,16 @@ _have_systemd_tlshd_service() {
 		SKIP_REASONS+=("Install ktls-utils for tlshd")
 	fi
 }
+
+_have_libnvme_ver() {
+	local ver
+
+	_have_program nvme || return $?
+	ver="$(nvme --version | grep libnvme | cut --delimiter ' ' --fields 3 | sed 's/-.*//')"
+
+	if _compare_three_version_numbers "$ver" "$1" "$2" "$3"; then
+		SKIP_REASONS+=("libnvme version is older than ${1}.${2}.${3:-0}")
+		return 1
+	fi
+	return 0
+}
-- 
2.49.0


