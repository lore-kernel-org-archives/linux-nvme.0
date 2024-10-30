Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3BA8D74978
	for <linux-nvme@archiver.kernel.org>; Wed, 30 Oct 2024 06:52:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0Nri9t/+OZd/GxUqByQeUvAQ/9YOkJawyIzHLv8DdEc=; b=hQ367JSQxTXwpjlUR2EGHfS0il
	a0wSDH3gFYdpRIqjOwtEKW6VgCit2doxU5LQs2n/3g1ozbU+8Shvuuv1S5gbsch+Bdn/hw6l8RClJ
	s9EUkGdu3NRvEhBQ0RfKd73vWSTVZqJf6sTnwOf3/l80lpsZjPsOWFZJgtPC0zKXteR3OiN0tZDaW
	zZWE1eYfoRGiYC4OhL+/fEcSAtV3t0AX4F0DTjxcdKWlNX/XAone9Yhgd2QALe7QCoz+JNRXbkIsi
	7U5MXlY8pzqDSZFW6dKxpcQyBtYdlD76mFt0mareX1HvxHkobcpSLXes+7je8iHpVvVzx8Erv6yYJ
	F9R4/rxw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t62Ys-0000000H2M5-2FrE;
	Wed, 30 Oct 2024 06:52:10 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t62Yf-0000000H2AZ-10km
	for linux-nvme@lists.infradead.org;
	Wed, 30 Oct 2024 06:51:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1730271117; x=1761807117;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=eJOj0sgZkQW0YGyCYxGBWUhHUNU5aZHHi7mOQKR23uw=;
  b=XK8jItvRdkAEK1zSgFAljtLkIHWof9hXHIYENBvIRIWeVquiYE+TdNi2
   s4XtAUtdxaWijKeqbEmqS16LUDJelG/Fe3+MUpUu2EruQHHMaSPF/rPni
   0kLzIPeAB6bp+cw6cK/8W4jdGf9p8h/QAna2dHiIm10YCS8vS3xqUBKN2
   w3DbiImfo5ZO7RXKGj6tnrAIr9gI9ec7aN+s5RU/MPuSohF5Bszbeb/Om
   E5oNOzqsDEiRNau/SdmZb0H25dCtrBXTUtzFeN6Q/h3lTQWrODoRiMywX
   fgaaO38KtAWliCLKtaZ6U8mV0Mr6/pUzQ11cc7huYsQHVWpuVKkRCDsHQ
   Q==;
X-CSE-ConnectionGUID: CiN+T1kiSsSUmIpBocFG2A==
X-CSE-MsgGUID: ouB4+mztSVOtKIt2GfWYRw==
X-IronPort-AV: E=Sophos;i="6.11,244,1725292800"; 
   d="scan'208";a="31314343"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 30 Oct 2024 14:51:57 +0800
IronPort-SDR: 6721ca5e_dPyzWyJ06Pxaf2114DanFWXvL+xgRid1SWyTVhXOZYeTIbn
 QkFmjqo+94J7KFUjbdR4xXD4U1lw5kC+Y33kY1g==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Oct 2024 22:55:43 -0700
WDCIronportException: Internal
Received: from unknown (HELO shindev.ssa.fujisawa.hgst.com) ([10.149.66.30])
  by uls-op-cesaip02.wdc.com with ESMTP; 29 Oct 2024 23:51:57 -0700
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-nvme@lists.infradead.org
Cc: Hannes Reinecke <hare@suse.de>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests v2 07/13] nvme: return error from _find_nvme_ns()
Date: Wed, 30 Oct 2024 15:51:43 +0900
Message-ID: <20241030065149.2297405-8-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241030065149.2297405-1-shinichiro.kawasaki@wdc.com>
References: <20241030065149.2297405-1-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241029_235157_348985_C47C956C 
X-CRM114-Status: GOOD (  10.97  )
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

From: Hannes Reinecke <hare@suse.de>

When _find_nvme_ns() fails it should return a non-zero statue to allow for
the error to be propagated to the caller.

Signed-off-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Daniel Wagner <dwagner@suse.de>
Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 common/nvme | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/common/nvme b/common/nvme
index 2ef9fd8..5d2e38e 100644
--- a/common/nvme
+++ b/common/nvme
@@ -694,8 +694,10 @@ _find_nvme_dev() {
 		subsysnqn="$(cat "/sys/class/nvme/${dev}/subsysnqn" 2>/dev/null)"
 		if [[ "$subsysnqn" == "$subsys" ]]; then
 			echo "$dev"
+			return 0
 		fi
 	done
+	return 1
 }
 
 _find_nvme_ns() {
@@ -712,8 +714,10 @@ _find_nvme_ns() {
 		uuid=$(cat "${ns}/uuid")
 		if [[ "${subsys_uuid}" == "${uuid}" ]]; then
 			basename "${ns}"
+			return 0
 		fi
 	done
+	return 1
 }
 
 _nvmet_target_cleanup() {
-- 
2.45.2


