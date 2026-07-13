Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E89C7C44501
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Jul 2026 00:39:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=iSGm0GgVbn4Q7KS6IOiTxlp8Io7mGEbgXCuArZukN8Y=; b=BjdYl+FbNa4xViwkmnulqyZdoZ
	YfwRha9+3+VZLPkbYn8xfQt2SWNTt28TNo2H9PjCcee6h5K9HgiEHxImx3j8GBUOJ1V7abAqp6iSh
	OmfRKO6iaa8jXIIypkCh2sv7874nmBcWR8w5t7WjIgB1YM6U2Iizfv4vaFV64b2BxJBYMYqAN10IO
	KA1SUlRa4Uo9o+l9swP7EFMMH7ZAV4BtrQmo2Rb/J77abO1umeJU3oodkUab/ONCydub55NYxaFE+
	gKjL7OMoqd3hqQ6cGz7Djtc23/S1jY/9nozEq0ow3j6GZNwuOtYyicYMrcsHaH4B/2T6QYPNKMX1U
	CwLZ7Z2A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wj4i1-00000007shG-2hZ7;
	Mon, 13 Jul 2026 00:39:45 +0000
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wj4hy-00000007sfU-31BL
	for linux-nvme@lists.infradead.org;
	Mon, 13 Jul 2026 00:39:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1783903182; x=1815439182;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=iflCEb2XJy49OrBBeSRD6n31GmM6IEbT7U8yNg72vfw=;
  b=U88uR6Q94iR2vdJPE+EGN3ffQsOZYS+TiG36xDEX6/OdEi004hZSan/1
   R2BvaZlTR634wjVmshf3mneJAd+50O74TK7PnMpt7Qjtdni0SHt6rexCR
   fXN88emfJEmnVUtcYmWl7gjanUwmERsCQdiNkc2pjI3yOFrWIACHKylLd
   4W7lJCHQipvdoLnp/nLevlthIaGeFj/nQ1cbtbwpeucYgrwIUXuQHddVi
   AbekwMPDAqOFqEY6k21FMIWP9bD+sB/CDDsyxOTHIOAmeTF0L4CgutM7I
   jwTXNtb0iDCxifdpAUMWNk8cT5UMQAfV8ZTb5Pwc/v3K3YDposV9vob3Y
   Q==;
X-CSE-ConnectionGUID: LhCwwNRmSAmWD7oS67APfQ==
X-CSE-MsgGUID: kBT2NFsLRw6SkcpTYWj7qw==
X-IronPort-AV: E=Sophos;i="6.25,154,1779120000"; 
   d="scan'208";a="150596182"
Received: from unknown (HELO uls-op-esad1-o.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 13 Jul 2026 08:39:40 +0800
X-CSE-ConnectionGUID: 0G7Cw9CcTbO+Xu1MYA3rCQ==
X-CSE-MsgGUID: Rn7kheAqTveyPr6AWwwzNQ==
IronPort-SDR: 6a5433ad_vHlZMtXmKruP3fSJeSsvQGFi3o1Yfx34hU0gC/lGrrLMJgF
 1L+d5RScC/maeuNbG3l5hpUlooaV4YRrYsDoBKg==
Received: from uls-op-esai1-o.wdc.com ([10.248.3.45])
  by uls-op-esad1-o.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 12 Jul 2026 17:39:09 -0700
X-CSE-ConnectionGUID: p8qmfKSMRZGyFJ5+Nq3s2Q==
X-CSE-MsgGUID: 2T1IbVkXT2qV0bCBogOkTg==
WDCIronportException: Internal
Received: from unknown (HELO shinmob.iptvf.jp) ([10.224.106.2])
  by uls-op-esai1-o.wdc.com with ESMTP; 12 Jul 2026 17:39:09 -0700
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Cc: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests 2/4] nvme/rc: use _set_attr() in _create_nvmet_passthru()
Date: Mon, 13 Jul 2026 09:39:04 +0900
Message-ID: <20260713003906.21153-3-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260713003906.21153-1-shinichiro.kawasaki@wdc.com>
References: <20260713003906.21153-1-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260712_173942_768806_5EB5E900 
X-CRM114-Status: GOOD (  11.91  )
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

Commit 91316870b124 ("common/nvme, nvme/rc: use _set_attr() to trace
attribute writes") replaced sysfs/confgfs/debugfs attribute writes with
_set_attr() function call, but it missed to one place. Replace the
missed write.

Fixes: 91316870b124 ("common/nvme, nvme/rc: use _set_attr() to trace attribute writes")
Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 tests/nvme/rc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/nvme/rc b/tests/nvme/rc
index d6496b3..1d71811 100644
--- a/tests/nvme/rc
+++ b/tests/nvme/rc
@@ -225,7 +225,7 @@ _create_nvmet_passthru() {
 	mkdir -p "${subsys_path}"
 	_set_attr 0 "${subsys_path}/attr_allow_any_host"
 
-	_test_dev_nvme_ctrl > "${passthru_path}/device_path"
+	_set_attr "$(_test_dev_nvme_ctrl)" "${passthru_path}/device_path"
 	_set_attr 1 "${passthru_path}/enable"
 	if [[ -f "${passthru_path}/clear_ids" ]]; then
 		_set_attr 1 "${passthru_path}/clear_ids"
-- 
2.55.0


