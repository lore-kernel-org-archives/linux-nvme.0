Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0DAAC4345F
	for <linux-nvme@archiver.kernel.org>; Tue, 16 Apr 2024 10:32:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bP192UOsasbt13N2+0/OHR+gggSJWA1P78VFa7WZyIE=; b=t+xwZQqXsXauORIRRXuyjtOBjP
	ogzcSKS/p5AFYFZXi0p52KJvvB8KnjWnhX3b2rStpSuNdgeINF9WangSyHm55uN/BAYKTLVVhv0R3
	X5y82bBC7nFvNjdU4RDaPuSY2Vw+82fpGumz7SDEjz9W+R1wQ2tOoVQcnL4BMCNXiHNcmVATEAbdc
	o96P8JoU8v1W/Teltp1nZB7AgfPtZ8Bea/05oPb3xU8MWXJSTmi7I/8O0dAYTJsgmpLDtcdUColG5
	CU2cX8fzSFwKNVDBIkoxeuYN6ZlKVZR90gexSu/on772HRByIIyrwmwCeUgEi2HSsap04Or8Uc+HZ
	6tm0nkxw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rwg7B-0000000Bnty-3aQ6;
	Tue, 16 Apr 2024 10:32:37 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rwg6p-0000000BnZ7-1xZ3
	for linux-nvme@lists.infradead.org;
	Tue, 16 Apr 2024 10:32:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1713263535; x=1744799535;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PK8HMoLK5lKrHF0QhzaiuDc58LfZxl3I3zaL5rrdk/8=;
  b=j0+K734TsKe+xO4zXCxZ2qTEpb403IOMWWU4Ca2BgqsYHe9pfJJm36Mc
   wc5PMTkUGX81a+qZfynCz1xjO/xSGzMtUWURo38rMTWCCpu+o05Dduqdc
   gR0fiDGm7zhzmyO7j1nJ5MCImbi/h47pZ/fCvGGiI5TUUqhQh2nP1RdVP
   y9sF1W7jitfA2wUyEZ5RPxAhs/ZusJKh8foe63joZgMO4bbRFZL9TDAx2
   rsC804vHQLvZFRtUtnUyAyY4M/ObzKfowiYaSYx9mdu4ugrWcx2sdz9r5
   AdbdR2XfdvgT8D8AJb+FAHsqsiscxwFxxVYB6B/RVaIGqtvSOC24m5jxk
   Q==;
X-CSE-ConnectionGUID: mYO8kq4ySo62ED9+X3Xo4w==
X-CSE-MsgGUID: vq091PQSQ6q6vvmbjmJbZA==
X-IronPort-AV: E=Sophos;i="6.07,205,1708358400"; 
   d="scan'208";a="14796905"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 16 Apr 2024 18:32:14 +0800
IronPort-SDR: Yi6iVLc9kHTaCQFvL1+8MbhKIJYYs3kacfKR9V70UFRkknRX2cUXULVEL9dxtGxAwf0NzlvTRs
 iMuZjeD8egfw==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Apr 2024 02:34:53 -0700
IronPort-SDR: NI9R/y1ONCsU82sincs6OnWmVgMiRXG5IMvnQKIxNffG6Qah2Kbp9ZjxQLZfkHspYa7h3vc6Pw
 KFFo9yyCDEj11iXQn/C8tEUGJuTjjXAEh67LmXICXuZsOwuy3BHknE0XVQZqwAn4ZkVbobihKN
 eAIBmNb31eCHvTeL2A03+ftjWBudC2qh8O2kzBxJv0STnIG6iKUxRGqXZLLRovnuNw0BExjVeY
 gJIL3JZdxusamzJivowezRrR1sVxUpqcaj95azqJcjR9IxfXqdk8owMbd6sftRClYA3zcdptgy
 7s8=
WDCIronportException: Internal
Received: from unknown (HELO shindev.ssa.fujisawa.hgst.com) ([10.149.66.30])
  by uls-op-cesaip02.wdc.com with ESMTP; 16 Apr 2024 03:32:14 -0700
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org
Cc: linux-nvme@lists.infradead.org,
	Daniel Wagner <dwagern@suse.de>,
	Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH blktests v2 06/11] nvme/rc: add blkdev type environment variable
Date: Tue, 16 Apr 2024 19:32:02 +0900
Message-ID: <20240416103207.2754778-7-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240416103207.2754778-1-shinichiro.kawasaki@wdc.com>
References: <20240416103207.2754778-1-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240416_033215_683051_C6BAEF9B 
X-CRM114-Status: GOOD (  10.65  )
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
Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 tests/nvme/rc | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tests/nvme/rc b/tests/nvme/rc
index 34ecdde..d44a1c1 100644
--- a/tests/nvme/rc
+++ b/tests/nvme/rc
@@ -20,6 +20,7 @@ export def_subsysnqn="blktests-subsystem-1"
 export def_subsys_uuid="91fdba0d-f87b-4c25-b80f-db7be1418b9e"
 nvme_img_size=${nvme_img_size:-"1G"}
 nvme_num_iter=${nvme_num_iter:-"1000"}
+nvmet_blkdev_type=${nvmet_blkdev_type:-"device"}
 
 # Check consistency of NVMET_TRTYPES and nvme_trtype configurations.
 # If neither is configured, set the default value.
@@ -857,7 +858,7 @@ _find_nvme_passthru_loop_dev() {
 }
 
 _nvmet_target_setup() {
-	local blkdev_type="device"
+	local blkdev_type="${nvmet_blkdev_type}"
 	local blkdev
 	local ctrlkey=""
 	local hostkey=""
-- 
2.44.0


