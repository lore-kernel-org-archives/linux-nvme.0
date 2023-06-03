Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B73AFC77B7A
	for <linux-nvme@archiver.kernel.org>; Sat,  3 Jun 2023 00:46:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=fJtCq+Qr4Gj/cA5gwa5kjkL+XkCZVeCn9uwneB2sw2c=; b=NKn2sricjacyXbKAeyY2upwNDK
	ZiAx7R4Wz2w2LM9vHNY8UceNnaMexTsQqPtcH8wsbmtXcGStBExrH6d4BK82tsQKawzP/RTPk7+RI
	69a7vyezoE6jEJaY5Jx0L/Zu9fYYUY27A554e3YFgDZuSL80vNYGNbCDaKLeGQq3LdihMXJovMYUV
	rHf9H0IvSNa2bswL0IElizgoTIod3+tq08S8RDPTCxmOj6Y8/oVKTQHxralvEGpOjWmIyPJsFuV6N
	QFUSBcDvUQNs0ooFaYYIvsAKsMEBlvTLVkgjZVngBb/0oDsRlr2iS3PHKYAToj+PFCUyfeguYzAeB
	6Yq3G8CA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q5FPc-008JKE-0m;
	Sat, 03 Jun 2023 00:46:32 +0000
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q5FPZ-008JJN-0F
	for linux-nvme@lists.infradead.org;
	Sat, 03 Jun 2023 00:46:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1685753188; x=1717289188;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=mnXhvkSu7YtUpkcwZlpIz2Nl16u/rmfY17OgK7N9U60=;
  b=Kcpw8nR++BK2Nf0uKoaSJcccUKSnYCQhds523Q8xGjVKVi5HHGJw2iOJ
   GoWnQZ4dwR8aw8x+aodwCedDYU8cCMbWf5LLQzgmWJeKQQ7CW3hsJ8dVx
   wZi5kcUuigQ3ULFEl3JxxCEavLM3lDnYvUVoArciZRbSchFLqyyoBpD3E
   7wR5WRkGK0abiAzOtme3d/93qe68RvfTZTPIHqCxrSbg7h4a8AyJEILsh
   fLXtWLcFuNjdCvEN0dDcrJgCbVUraAGROgm1uO7KboUI4bHerI+zIoS0h
   s8BtZ/Z+uAqbV4PBmPCJAXyAYnXPtApfbcln1LsdxOKKY5bqsoM0v/QzA
   w==;
X-IronPort-AV: E=Sophos;i="6.00,214,1681142400"; 
   d="scan'208";a="344447891"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 03 Jun 2023 08:46:22 +0800
IronPort-SDR: CNvdeykPZ2mnBfbs6u2v8sVdM0qP3TArvI7AKXzK+ckCJ2Yc+C9aNi5Ud8bI/HOeuSMN2Xmcno
 ZO8SnZUuLIocKe4FePPqPqObBP8h7GZ3OvEL0O+TjKfu0e74hrF2tJu7lJiuXDZ1GuRw6U2dpx
 kUqpuPga7FzW7cDLHLFT8aDYon/GGwBOjo3cEF9DyOpPrvpS35hrUrZPOWLQheIRmVL6QMObu+
 c1yX/Jn1J5VuvdymoSCRF9KZ2UxLcxQtCo6QFP10Q4d0DXKh4A//OxNEvi1f+tQh0MTdCjNt2+
 KB4=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 02 Jun 2023 17:01:11 -0700
IronPort-SDR: G0ZCcpwbbnl16w4y5I9v3ESkhJrpI0qc46twDkhVx+q5g6JEuSaZbQzMrh0BUeQisJAMQKFhbK
 9FEzW0J7FQh/yLhRKsx1UQ2XxFFI19SyV5uIDF092as7aiXOeTGV3W0FTboyGCPH9wXUfZ8wCu
 rG0NWS0kQmOm3d60F5/5fsO0MuVCx2wq11Qz5ZRwD1oy6gHmDwOcbAWdIGeP9CpLCDoa65+TFi
 o27jSCpfIn0tVl7xm3pqEHqxKKVnkVRXE/sBCpyrYkQ5cInu1r934yzAlkcQ+y/Sl//LYj4JVq
 ZZ4=
WDCIronportException: Internal
Received: from shindev.dhcp.fujisawa.hgst.com (HELO shindev.fujisawa.hgst.com) ([10.149.53.55])
  by uls-op-cesaip01.wdc.com with ESMTP; 02 Jun 2023 17:46:21 -0700
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-rdma@vger.kernel.org,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>
Cc: linux-nvme@lists.infradead.org,
	Damien Le Moal <damien.lemoal@opensource.wdc.com>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH] RDMA/cma: prevent rdma id destroy during cma_iw_handler
Date: Sat,  3 Jun 2023 09:46:20 +0900
Message-Id: <20230603004620.906089-1-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230602_174629_124294_EDA2BC7E 
X-CRM114-Status: GOOD (  10.54  )
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

When rdma_destroy_id() and cma_iw_handler() race, struct rdma_id_private
*id_priv can be destroyed during cma_iw_handler call. This causes "BUG:
KASAN: slab-use-after-free" at mutex_lock() in cma_iw_handler().
To prevent the destroy of id_priv, keep its reference count by calling
cma_id_get() and cma_id_put() at start and end of cma_iw_handler().

Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: stable@vger.kernel.org
---
The BUG KASAN was observed with blktests at test cases nvme/030 or nvme/031,
using SIW transport [1]. To reproduce it, it is required to repeat the test
cases from 30 to 50 times on my test system.

[1] https://lore.kernel.org/linux-block/rsmmxrchy6voi5qhl4irss5sprna3f5owkqtvybxglcv2pnylm@xmrnpfu3tfpe/

 drivers/infiniband/core/cma.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
index 93a1c48d0c32..c5267d9bb184 100644
--- a/drivers/infiniband/core/cma.c
+++ b/drivers/infiniband/core/cma.c
@@ -2477,6 +2477,7 @@ static int cma_iw_handler(struct iw_cm_id *iw_id, struct iw_cm_event *iw_event)
 	struct sockaddr *laddr = (struct sockaddr *)&iw_event->local_addr;
 	struct sockaddr *raddr = (struct sockaddr *)&iw_event->remote_addr;
 
+	cma_id_get(id_priv);
 	mutex_lock(&id_priv->handler_mutex);
 	if (READ_ONCE(id_priv->state) != RDMA_CM_CONNECT)
 		goto out;
@@ -2524,12 +2525,14 @@ static int cma_iw_handler(struct iw_cm_id *iw_id, struct iw_cm_event *iw_event)
 	if (ret) {
 		/* Destroy the CM ID by returning a non-zero value. */
 		id_priv->cm_id.iw = NULL;
+		cma_id_put(id_priv);
 		destroy_id_handler_unlock(id_priv);
 		return ret;
 	}
 
 out:
 	mutex_unlock(&id_priv->handler_mutex);
+	cma_id_put(id_priv);
 	return ret;
 }
 
-- 
2.40.1


