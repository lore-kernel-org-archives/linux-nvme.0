Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE4B1C25B5C
	for <linux-nvme@archiver.kernel.org>; Sat,  4 May 2024 08:15:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dHQvo7xWAfOgwXk+kZ7N9O7ysK077NjI0KTcBoXyK88=; b=ppmOWwxbS8uMgVaZV5N38ldHHw
	hiFYdApvyhQLqrvNpHIsU2HK5/U2joOL01Q67HP9osMNSAJAQ7kn2M0Gy82oRiGHP/uf/mea4lnKF
	lg6W8c9mL14OggZMr6qqJ3wWZu/VR1qIW5Z+Q4bxx9S7b97OT8FYoh3fMWalRcv+2CLMUJORsT95I
	2XErnOV9ibOadlU1/z/Vo8TG6gbQbtl78NUM35e+yQtNHzYiaaXsY1TdoAq82utmvx/WRSsnb42O5
	sB90wlehe8nl68JQu7mfo+zbqSOlPQz1enBWdYNmBaGgSGZGyQ5B7/SOn9RhrxppfpeuWTLTvaijV
	gZCMvGXA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s3AYB-00000001Z6y-2SQO;
	Sat, 04 May 2024 08:15:19 +0000
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s3AXt-00000001YrU-3lBt
	for linux-nvme@lists.infradead.org;
	Sat, 04 May 2024 08:15:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1714810501; x=1746346501;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nqz9/msx15KbB+BgGwlvy/0PKz1/iD3nOvV9RFRZu68=;
  b=KSNzCeEe9VTrpPAwFIqHSRSABORze8kjZRUo2KU/aD6PjgZ5E9ixnXNG
   OTvjxXk0CNtzeG5zkMdflxkwkmSe2RosqP5URGgqHC8riSYfLgKvTZhjH
   ipmTxD0Vyjg6QUlv4VQrgfjfymphU7ylCzDP8v4qON9XT9qihqDnyQH5+
   AGsxpIwRtxbH2UeS+YygE+81AlYpTQlxf+It3TXBe/MoEBvvz+ini+FrH
   sTxOnSSB6wm+Fjt36lVsXNvuaG9BmXA02OHgMSg4cnmjFP24LVljNCohC
   C3Kqau/9GyA0ImIZApVVGZKJGg9FUEaanuoz19Rdsttmf2H1+qzo1xmc/
   g==;
X-CSE-ConnectionGUID: p+LR+Vv7RoCJNFCE9mgvfA==
X-CSE-MsgGUID: PJtPPoq/SY6jQGdfymzXHw==
X-IronPort-AV: E=Sophos;i="6.07,253,1708358400"; 
   d="scan'208";a="15540318"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 04 May 2024 16:15:01 +0800
IronPort-SDR: oZedhMYttcQT4oDoj4YJiC8fHQ2zXVpu2v0CyCkHLEUGai3c40DCtiYv47vbUgo2XnwKYwi3md
 EqQsrkqojwElS9nfyT0n+vW2LvyAw8G086C5ZHdEAkJLtW0YuGFmM/+gd7LE/+VnYkRzlBxOTu
 q/1K/SNqu9Dhz5U+7sL+xTtUe8VB1kqHviefzJyRw8U9kWM4ZTBJzDOLqzbV2kO0iFYQ+uzZGR
 QZJoRhiISJ8mPk4u1PzXovrLNISOpj+aG8+eYSamVB3bYdwQEGi+V4zDeONYs1T2RzPwKku3Fs
 oWg=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 May 2024 00:22:59 -0700
IronPort-SDR: e0d9yRP8e6xPux5jz6oc+Osm4Llx8Us6D1K4ZhCX1cEoEpcbVTT8D53OgijBAdVwNDo2nA9O7P
 Y+e/zlCp7EuS/ArYeJODVKl71N/2/AO7xZvXaf7MgrmIgWYEnhhXxD9jkisBEI1JHLded7mXU3
 OBR7uJZNiAz7Y+9w6DrKusYu7+TfgMVcDd2s+Op/56MO03JywwCXrC5MqfAjW1EIyCsj5ftdZm
 v9pt3nddhB2YptQieLrl/niyjRrm3Fy3VzHJGAnahtOXp6bsTgnE2OD/BCwWeln4sMsg2Sw1ZJ
 xgk=
WDCIronportException: Internal
Received: from unknown (HELO shinhome.flets-east.jp) ([10.225.163.38])
  by uls-op-cesaip01.wdc.com with ESMTP; 04 May 2024 01:15:00 -0700
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org
Cc: linux-nvme@lists.infradead.org,
	Daniel Wagner <dwagner@suse.de>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests v4 09/17] nvme/rc: add blkdev type environment variable
Date: Sat,  4 May 2024 17:14:40 +0900
Message-ID: <20240504081448.1107562-10-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240504081448.1107562-1-shinichiro.kawasaki@wdc.com>
References: <20240504081448.1107562-1-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240504_011502_043384_5A07CDCD 
X-CRM114-Status: GOOD (  11.81  )
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

From: Daniel Wagner <dwagner@suse.de>

Introduce nvmet_blkdev_type environment variable which allows to control
the target setup. This allows us to drop duplicate tests which just
differ how the target is setup.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
[Shin'ichiro: dropped description in Documentation/running-tests.md]
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
Acked-by: Nitesh Shetty <nj.shetty@samsung.com>
Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 tests/nvme/rc | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tests/nvme/rc b/tests/nvme/rc
index f35ed09..ec54609 100644
--- a/tests/nvme/rc
+++ b/tests/nvme/rc
@@ -21,6 +21,7 @@ export def_subsys_uuid="91fdba0d-f87b-4c25-b80f-db7be1418b9e"
 _check_conflict_and_set_default NVMET_TRTYPES nvme_trtype "loop"
 nvme_img_size=${nvme_img_size:-"1G"}
 nvme_num_iter=${nvme_num_iter:-"1000"}
+nvmet_blkdev_type=${nvmet_blkdev_type:-"device"}
 
 _NVMET_TRTYPES_is_valid() {
 	local type
@@ -855,7 +856,7 @@ _find_nvme_passthru_loop_dev() {
 }
 
 _nvmet_target_setup() {
-	local blkdev_type="device"
+	local blkdev_type="${nvmet_blkdev_type}"
 	local blkdev
 	local ctrlkey=""
 	local hostkey=""
-- 
2.44.0


