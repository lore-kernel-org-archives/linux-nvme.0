Return-Path: <SRS0=Uncj=4D=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1979CC35242
	for <linux-nvme@archiver.kernel.org>; Sat, 15 Feb 2020 01:39:02 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E21F62073A
	for <linux-nvme@archiver.kernel.org>; Sat, 15 Feb 2020 01:39:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="GuESsUNx";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="DT0slcyu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E21F62073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=oqpToKn2tY6AZBeb210L0jJjjCBPMBeAImCgNJOEvBA=; b=GuESsUNxFCWU5S
	782WmbuYLJrYmdaIBAu+ffRhwk3JFWaXMVUGTSC4OPBNRxZfWwhogTIpD8etcJQdPfPMQTWI2/uQH
	8aieoBzXNWI204u2ao6sXsAKZLsi6u7tEWdoyoA+THNV/D3S/TrbHhQ1T8Kv2fe4MqDTP3AcW43pj
	Df5ipeck1jvxI9q4Jks2I57QlJEINlgGG6abI42RqK4ofjEJLU5sGhcm1076qv/TEr0Ofi1891DIt
	62OUmVRp4w3vAgsCyAKfJu1H7ffSHO9Nx864vVR2eaDUEJVSI9LogwIgSKukTPak1NlAMPZLC3ACL
	crdp8mophyjnw/t/YExA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1j2mQ7-0006oF-Ls; Sat, 15 Feb 2020 01:38:59 +0000
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1j2mPz-0006mi-P6
 for linux-nvme@lists.infradead.org; Sat, 15 Feb 2020 01:38:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1581730731; x=1613266731;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=E3wcwlsDYokBPz5VBPG3aTzLh2M8vjJRSpWvvi5K6ic=;
 b=DT0slcyumRdb94v8TLCqspojdq3wHilPwYHcEO7dcLY+HA6LvqlV37AX
 kAi8l2c8uLouhtUbFz/7RasPJTWL1yyfCVNf6TK18UnSE6ja5aVW2eBPu
 biW/gippCojWAnFV3ysZApg3itwnooJ8dm4b7l8kLzAI0bRHDuO+cmVxg
 cTgzGGtVWJxkvjiFPlXJITkBTbxw1NmtqqJOwhpBheol6Y1a5dAT/ZXOu
 Q0AAWiHAHUQ9J6RIzmNYKlU7v727ZUT/4C6fffgpuK4IERMi+93I35Yzm
 ib+gI6dD8WdWgO61wCZcNfg/jneLXS3npNOXz6DWAbC4X5/qLkABkgavA g==;
IronPort-SDR: A+dl8bZNihOPVWn3aKhApDpbtRn9dZoo23jRsvYkRthOJRiJ9HwRWeYhjrfRvyOampVvXMT4KW
 1BAZmiRBIRwPWu/8k91/ApRcQgG8OFCB5XOY4NJPUdj5EJYmFUZ9GnRnUSS9O1SD6Zrba5wgdB
 fIQ5njfAj8p5gC8SwhUuU3cM3OyFPnplNVxJMtV28Yb+m4XxbWYtPVlSrBcb66nu72jLqTCst3
 Z9PqIOxlV/s/wwvg02lOvHG9UMOLzmAGEzoUjArPecsjlE8ZPPzxF6QKO1bPPzAiB+0hvBqFeO
 zX4=
X-IronPort-AV: E=Sophos;i="5.70,442,1574092800"; d="scan'208";a="129907008"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 15 Feb 2020 09:38:36 +0800
IronPort-SDR: Tmo+hsOeuQlsWAxzyfidRbCwvZWqG/bgiQy3mAyHcbFluUYbn1hd6ttIJpKigVbmvOXLjQNQjL
 XNeVF5LpAMBUwPmpmExLhWyFHp5qHadNLeYf1IbR525YbnEj82zMSpy/+260ejMwpBFO6XroTc
 J9mNTri1TVLNgv/OogLbkiZc+CS3XAC26gB7i6X4T0uUmaMFr79VCCeBYuRTyV/T4JNsaiayuj
 2SNa+QetiM4TXD4xDOrGPWiSjcc9AGnqhxV9/YXYUJJJmL6nB2b45ORYie35sVGlNq+S+rvpoo
 vkWmOvVwpw48MdAL/IaNtQJV
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Feb 2020 17:31:21 -0800
IronPort-SDR: ioUc+pR+lGn0rilxm0izv8W1ipguQiGrJp66P2+lZCghs3D3rxw3yHJdW9FjvLKSvrJQfRTJH3
 W/wj6cMOVsOB/AK8bzk/tXR6LUxxdJpFLV2g7C55Y9jX45SCpZs/PY0+5p49RgJjMhDPXnq1j4
 guYAAmWKWb11ScUP7Rl2tLAlZ0rG3lFK0LOxNV7zjbu2nDZQ28Ve4Rnp+GOBICGvVh28azFxnY
 z/pMqP0W9WKVSZjYgryEPeBW6EQeswyJPT0+5rEr0yLdTvzN+p5mLIhtCdvmEifQDf6YYQGiWS
 l5E=
WDCIronportException: Internal
Received: from iouring.labspan.wdc.com (HELO iouring.sc.wdc.com)
 ([10.6.138.107])
 by uls-op-cesaip01.wdc.com with ESMTP; 14 Feb 2020 17:38:36 -0800
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: osandov@fb.com
Subject: [PATCH blktests V2 1/3] nvme: allow target to set cntlid min/max &
 model
Date: Fri, 14 Feb 2020 17:38:29 -0800
Message-Id: <20200215013831.6715-2-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200215013831.6715-1-chaitanya.kulkarni@wdc.com>
References: <20200215013831.6715-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200214_173851_919314_F3DC1AD1 
X-CRM114-Status: UNSURE (   8.55  )
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

This patch updates helper function create_nvmet_subsystem() to handle
newly introduced model, cntlid_min and cntlid_max attributes.
Also, this adds SKIP reason when attributes are not found in the
configfs.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 tests/nvme/rc | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/tests/nvme/rc b/tests/nvme/rc
index 40f0413..e4b57cb 100644
--- a/tests/nvme/rc
+++ b/tests/nvme/rc
@@ -121,11 +121,36 @@ _create_nvmet_subsystem() {
 	local nvmet_subsystem="$1"
 	local blkdev="$2"
 	local uuid=$3
+	local cntlid_min=$4
+	local cntlid_max=$5
+	local model=$6
 	local cfs_path="${NVMET_CFS}/subsystems/${nvmet_subsystem}"
 
 	mkdir -p "${cfs_path}"
 	echo 1 > "${cfs_path}/attr_allow_any_host"
+
+	if [ $# -eq 5 ]; then
+		if [ -f "${cfs_path}"/attr_cntlid_min ]; then
+			echo "${cntlid_min}" > "${cfs_path}"/attr_cntlid_min
+			echo "${cntlid_max}" > "${cfs_path}"/attr_cntlid_max
+		else
+			SKIP_REASON="attr_cntlid_[min|max] not found"
+			rmdir "${cfs_path}"
+			return 1
+		fi
+	fi
+	if [ $# -eq 6 ]; then
+		if [ -f "${cfs_path}"/attr_model ]; then
+			echo "${model}" > "${cfs_path}"/attr_model
+		else
+			SKIP_REASON="attr_model not found"
+			rmdir "${cfs_path}"
+			return 1
+		fi
+	fi
 	_create_nvmet_ns "${nvmet_subsystem}" "1" "${blkdev}" "${uuid}"
+
+	return 0
 }
 
 _remove_nvmet_ns() {
-- 
2.22.1


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
