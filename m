Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AAA2C61DA4
	for <linux-nvme@archiver.kernel.org>; Mon,  6 Mar 2023 01:13:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:To:From:Reply-To:Cc:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=R+wqSp3SVmvSWZc/oA5vd3Girk0pFmucVmrK2R2LOLo=; b=D1q/JQ62aVKA5xxhrt83SU8Zau
	dyABcwAk/catXwcuR4tZyo54mP7QrfDHsFJBmPi9ow8VnkXINjeQvRUcU4cukUj3/d16SRpqOLx/v
	L2ae3gU2ncBLzaFH7a8Vaz1L+DbftqV+E3WqDxIk/wIHjg2AJe9XHsjVasfGoCr0LAHvYTRUEtYZx
	2q0oBxDJ25/IscZiO8hqbXEghRIKqASbVF9NdbVt2LgAkI8SoN/B0rTPNe9tnH+JaeFYGYK4hOq21
	Iql20/O9D1mZYneo1EV9chRJ3m8lA/5j1zHVrPqEbNVpTKWAC7+IYLmX5W6aWYQrYlFR+cOjbFe0b
	tkYpUUDg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pYzPt-00Au39-8G; Mon, 06 Mar 2023 01:13:29 +0000
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pYzPn-00Au1g-Me
	for linux-nvme@lists.infradead.org; Mon, 06 Mar 2023 01:13:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1678065203; x=1709601203;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=mHSUbxSn6wyY4vZNrBluWebj0iyESU7fDdbp4MheCNM=;
  b=nS0KhxM6/Urm+Q70p6ZTJuVsmAOLfGhEAu8hybVyS1B2n0C80JZVXfq0
   +w3xasnpOYrCbhxv7HlAqgcL0Mi3li+bler0NvWJonpn3bewlLiiRpeoU
   2yu2ibFchB1+HEQGlZSTYf+D7YD/Jl+SXo3HzMhpDpxfLPJm77s8HOZF0
   E7dqgrCQnbyyAjiURLoEsJTavnjlSsCQX4QW4IuMi5A64nvl7L1lZGRen
   aElnorWG1nnmLzFFBIbZoyZomBCCk3ZXDJo4wtlCrPtzbcHqVxtUwTS6P
   3gIY9ZqYUxiKzl4ssPIQG2g6W15bAwaYJalHCHXJF6XMH848ItWGnHA+5
   w==;
X-IronPort-AV: E=Sophos;i="5.98,236,1673884800"; 
   d="scan'208";a="224859677"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 06 Mar 2023 09:13:16 +0800
IronPort-SDR: QjlxqUE0RcjwNqA9JTwAoXaSP81uzgsDkZ57q53BO5xazJblEVsSNDcZ0bDLwsLWZLdtTdIEX7
 zPz5X4TdEulo1sraLdafhTlgvNAgNKXXk96Kj2S5oEVOvFC4E4HR7fd3ch/M8CuFmlEUcIgZdw
 7g8mtefXSAlSwR69EdvIERC1IUh4YXsfRCh4YE3jzOXMzDr8fIjtqZM6nHzM17XlUZs1y3Duf4
 eIR+nAz78Tiqfisa/CQyvlMTTuvicqWI3jgpUdhXiVKn4nfxyS+7LgLhQDSvIzNwoa/cRNW7B9
 /rQ=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 05 Mar 2023 16:29:58 -0800
IronPort-SDR: FZZ0qE5Qhbd19h7VsDCK81E7vwCdXVrVwWtLkyjFQj1qdF48IlDTKiLFi1R4ju5LnrcuEYThXK
 Qa0HEscawGuCi8O1MZo2w7y3ovOkHvNuZ8mmhKBI+U2VJAofD8RsNINbstBvf8qxfb/XRk+BuW
 gXsfCltj3mkcUQqkBluw9Hn2SQis0r/48V+1ZH0dl1cEXRDF/Xm8ilXMITgH7UfVx/J+Btl/rc
 arOTEVo4oeN6h0xcbRipisn/I7SeN7Tgjwr1zRzQhKRbo510qb+Y7IXlaobTAndNTLRuw/kM8V
 1gs=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 05 Mar 2023 17:13:17 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
	by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4PVLDX56Zcz1RwqL
	for <linux-nvme@lists.infradead.org>; Sun,  5 Mar 2023 17:13:16 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
	reason="pass (just generated, assumed good)"
	header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
	opensource.wdc.com; h=content-transfer-encoding:mime-version
	:x-mailer:message-id:date:subject:to:from; s=dkim; t=1678065196;
	 x=1680657197; bh=mHSUbxSn6wyY4vZNrBluWebj0iyESU7fDdbp4MheCNM=; b=
	jCex4NnE86d7p7ec0MndirUZ1q7b+PR4CJoXZZAE1PxSlXvFPD0eygFv5ITcT9ri
	E+ag7h0u84I4VakKglce0H7qbXTU/lb6P8FWgh2UWPiBTJkcqDDmtHF7wqtQpNO9
	feaPoLJQloq0zgs/mDe/vVYKfvqbX936BVIv7+xfzaPH8qkYhOJaOj40v0kH+VOe
	X9jOdhNN/NWbx0hGiiEySEQRJIbU3rHUIFF0GOTqq+VGcOryOWHejg4sE+Da/evv
	kWJCjZfJSjNrHL8NzWQkVYC6/ZCbh5gqYLIpZjqk7to03HV7+GKG7qjKICZUXJXc
	0SnCpC+uDlm+0/ZUz1D38g==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
	by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id VtpDmIesG8Dh for <linux-nvme@lists.infradead.org>;
	Sun,  5 Mar 2023 17:13:16 -0800 (PST)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
	by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4PVLDW3kgnz1RvLy;
	Sun,  5 Mar 2023 17:13:15 -0800 (PST)
From: Damien Le Moal <damien.lemoal@opensource.wdc.com>
To: linux-nvme@lists.infradead.org,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH v2] nvmet: Avoid potential UAF in nvmet_req_complete()
Date: Mon,  6 Mar 2023 10:13:13 +0900
Message-Id: <20230306011313.99870-1-damien.lemoal@opensource.wdc.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230305_171323_867872_F5ECC130 
X-CRM114-Status: GOOD (  15.92  )
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

An nvme target ->queue_response() operation implementation may free the
request passed as argument. Such implementation potentially could result
in a use after free of the request pointer when percpu_ref_put() is
called in nvmet_req_complete().

Avoid such problem by using a local variable to save the sq pointer
before calling __nvmet_req_complete(), thus avoiding dereferencing the
req pointer after that function call.

Fixes: a07b4970f464 ("nvmet: add a generic NVMe target")
Cc: stable@vger.kernel.org
Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
---

Changes from v1:
 * Added Fixes tag and cc stable

 drivers/nvme/target/core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index f66ed13d7c11..3935165048e7 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -756,8 +756,10 @@ static void __nvmet_req_complete(struct nvmet_req *r=
eq, u16 status)
=20
 void nvmet_req_complete(struct nvmet_req *req, u16 status)
 {
+	struct nvmet_sq *sq =3D req->sq;
+
 	__nvmet_req_complete(req, status);
-	percpu_ref_put(&req->sq->ref);
+	percpu_ref_put(&sq->ref);
 }
 EXPORT_SYMBOL_GPL(nvmet_req_complete);
=20
--=20
2.39.2


