Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CAF8D43349
	for <linux-nvme@archiver.kernel.org>; Thu,  7 Nov 2024 11:14:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=t+8iLcaWT7enplLkCyYUwauFXi3KSUe3xb+VS5upg4s=; b=aHnjWDcgN9QvpeKwuxia1KPjx7
	xxdb+Oh5LuhZQmrsz/es0VCWoa7IcelgEJpScEfsefo41fDhwIBJL5HF95ENK6opS8t/c3W4ooopF
	F4N8tqZ7V92BDyfFzaeNwAhp3dasOOE0mPFOxcqyvy67LgTkdTOLKPoClJh5uWEwq9qU7zVt8/3Bd
	2Jtinc0KXMTL6zXC71FZ32eazZcEzeNgQOslDNF+rkH3Hf13GqnNL6DeySsyg8NvY+VV9oVjKrwa9
	jTvCh/mYuUafROBl52z/uwOynp0ygOhBFdDbkZ7fRe3gxeA9pEzsYky2Bsiq1P1LlblFefzblc4GK
	cuhMzJEA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t90Sj-00000006dxj-3YiH;
	Thu, 07 Nov 2024 11:14:05 +0000
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t90Se-00000006dsC-03Fq
	for linux-nvme@lists.infradead.org;
	Thu, 07 Nov 2024 11:14:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1730978039; x=1762514039;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=aBUehwE0nzu6RpAFToGw2k7LgSt06Ff6AygKARZlxX8=;
  b=lr72Qzd64vbuM7zwJT3EKkN6DnS/MqqSIEhxzRyfkKJ8S+mMOfiwm/Pq
   w54udNyYxmdVcfO0kjybjthIKOql64pqQ216dZ6owtVZxFMSpUnAaBCPn
   QiOUJN8gkeIzY/5Zxqd76oIg1wgu+S3YtIDszjbn4bYDZpSDsfDZQ1HAC
   d56V6HmK/Zo9c1awOM0AVO7XFTzOgOfmiTaWzUjd1/UU2pHJJtVH9w/vf
   K9xUTBrDK+ExgKpN2SZdlc7iJwqYYmmqOnpEPRMyE2Iw42Zpn56Mhpmf0
   g/++of7KolmMIZr5TmsdjOJimqFbM9xYGdUhs8Z3YTZfqsUVLqfJGal/4
   A==;
X-CSE-ConnectionGUID: 0kX32OR9T/Kr38q+B+T/4w==
X-CSE-MsgGUID: rQ6K/dsDQB6LDJa+/HN2pQ==
X-IronPort-AV: E=Sophos;i="6.11,265,1725292800"; 
   d="scan'208";a="30851679"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 07 Nov 2024 19:13:58 +0800
IronPort-SDR: 672c93bd_6xnB6GQl0j8qq1VhJmpSdKGGlmYCKE+B5MLCxAMTpMFO/xC
 iSmwC6Ujlroe+eYcqLKeO9b0rUDSQGHMfKijJWw==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 07 Nov 2024 02:17:34 -0800
WDCIronportException: Internal
Received: from unknown (HELO shindev.ssa.fujisawa.hgst.com) ([10.149.66.30])
  by uls-op-cesaip02.wdc.com with ESMTP; 07 Nov 2024 03:13:58 -0800
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-nvme@lists.infradead.org
Cc: Hannes Reinecke <hare@suse.de>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests 3/8] nvme/016: do not create namespace when setting up the target
Date: Thu,  7 Nov 2024 20:13:49 +0900
Message-ID: <20241107111354.80606-4-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241107111354.80606-1-shinichiro.kawasaki@wdc.com>
References: <20241107111354.80606-1-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241107_031400_149042_D6D418E3 
X-CRM114-Status: GOOD (  12.67  )
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

Simplify the testcase by not creating a namespace when setting up
the target and have to loop iterating over all namespaces.

Signed-off-by: Hannes Reinecke <hare@suse.de>
[Shin'ichiro: use for loop instead of seq per style guideline]
Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 tests/nvme/016 | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tests/nvme/016 b/tests/nvme/016
index e1f1db5..dd3cb44 100755
--- a/tests/nvme/016
+++ b/tests/nvme/016
@@ -23,16 +23,16 @@ test() {
 	_setup_nvmet
 
 	local port
-	local iterations="${NVME_NUM_ITER}"
+	local i iterations="${NVME_NUM_ITER}"
 	local loop_dev
 	local nsid
 
 	loop_dev="$(losetup -f)"
 	local genctr=1
 
-	_create_nvmet_subsystem --blkdev "${loop_dev}"
+	_create_nvmet_subsystem
 
-	for ((i = 2; i <= iterations; i++)); do
+	for ((i = 1; i <= iterations; i++)); do
 		nsid=$((def_nsid + i - 1))
 		_create_nvmet_ns --nsid "${nsid}" \
 				 --blkdev "${loop_dev}" > /dev/null
-- 
2.47.0


