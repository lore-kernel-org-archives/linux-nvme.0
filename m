Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0D88D74978
	for <linux-nvme@archiver.kernel.org>; Wed, 30 Oct 2024 06:51:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zV2tvcpP7yPA2J7LaT7CPcyhLUlwFJWl61qu3+p1GnU=; b=3Gi0rg8XhAIaA17cVqLUNZsxuN
	zIJ+MdGyNwYlt+2uNoSTi8h7Qj7CY8TI6GXfiBfACr+Be6Df7Lyhn1Dzi2I9H9Mc6G+Lk8nExSU+9
	wDpdE3v8EvlgIcKM7csr06OGzJsRR3zGMSChO6Q1/4SN9BOVHVcqlEsBfji+UQSKBX3QCEMGGShDq
	xg9PXSFqvI7T84d1UPsiNA/OfVQasuge0q8oTf1XYdyonuTwaVMSC47yc01RzHgO1AKPyovyN0NiA
	oVjaShtCDTFatXpWw2dZGD0/sZUs6zK1/5afZEIBEdXh09gqbN/bGuFuCAWqUDfgxaCRM7zhI1BFv
	LvH+wj8A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t62Ye-0000000H2CM-2v1z;
	Wed, 30 Oct 2024 06:51:56 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t62Yb-0000000H2Ac-1ygM
	for linux-nvme@lists.infradead.org;
	Wed, 30 Oct 2024 06:51:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1730271113; x=1761807113;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RJmFizQK2UsA/EtNxQGOLq7zi7UbXDKZa1CTXb0Km9M=;
  b=dZK5joyJjExcSwJbER1QKakruU5eaeoFbQQhwn5Vmay92lQcgtpKR31U
   cfUQiwPH/MfprigIbD0q24v4zWXOSl60mot9gdkhjVCYH91smvXSdy2bw
   VS+a8u94CUWEFwKIsT+zagVYNvg8bMfuVghQ4bH+Uce5qBzrG9/xompm1
   eISLKNEldGNvja1l3CsRGKTsK9ylD3EZBBUQ3iWKKDndbXRekGInelN10
   z7YPz6pIU+4SD+WSNFFY3fLIPdTNXyHylREyCmk3bxh/hdiaT7ZG3FPky
   mPSxRjf8cqHhqQHQJSDOQhdNvItv/QzildPjluNXAIR1Go3wYrRqRrAuM
   w==;
X-CSE-ConnectionGUID: OQu44eDuQFKWC4WnRUDZPA==
X-CSE-MsgGUID: GtiZOQMOTiKGMDCBj6qFhQ==
X-IronPort-AV: E=Sophos;i="6.11,244,1725292800"; 
   d="scan'208";a="31314331"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 30 Oct 2024 14:51:51 +0800
IronPort-SDR: 6721ca59_XIrlmW6LMFfPYx0hpY1t7nNeFmklU4UWwFzQXeFckIQlceG
 8KwzWOMjMBm9JQtzjxLdCO89OZeJp66Djd37+eQ==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Oct 2024 22:55:37 -0700
WDCIronportException: Internal
Received: from unknown (HELO shindev.ssa.fujisawa.hgst.com) ([10.149.66.30])
  by uls-op-cesaip02.wdc.com with ESMTP; 29 Oct 2024 23:51:52 -0700
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-nvme@lists.infradead.org
Cc: Hannes Reinecke <hare@suse.de>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests v2 01/13] nvme/038: use nvme_trtype instead of hardcoding
Date: Wed, 30 Oct 2024 15:51:37 +0900
Message-ID: <20241030065149.2297405-2-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241030065149.2297405-1-shinichiro.kawasaki@wdc.com>
References: <20241030065149.2297405-1-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241029_235153_550546_5EEF3303 
X-CRM114-Status: GOOD (  11.84  )
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

There is no reason why loop is required, so switch to the default
transport type.

Signed-off-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Daniel Wagner <dwagner@suse.de>
Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 tests/nvme/038 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/nvme/038 b/tests/nvme/038
index 8435415..497cc88 100755
--- a/tests/nvme/038
+++ b/tests/nvme/038
@@ -33,7 +33,7 @@ test() {
 	mkdir -p "${subsys_path}"
 	rmdir "${subsys_path}"
 
-	port=$(_create_nvmet_port loop)
+	port="$(_create_nvmet_port "${nvme_trtype}")"
 	_remove_nvmet_port "${port}"
 
 	echo "Test complete"
-- 
2.45.2


