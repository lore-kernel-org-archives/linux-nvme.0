Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 380BEC6FD1F
	for <linux-nvme@archiver.kernel.org>; Tue, 14 Mar 2023 06:20:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:To:From:Reply-To:Cc:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=PIb9T5M2FKvsgFlaZCY/p/vS0u6Ddq0f4RmGJMnB+C4=; b=3bLJFwfFYrqhmR19sg2SfNv02e
	+tClui2xEhtqbLPJe2PrT1Hx265W0652nEfJ/Q5mmAXZVhXUZ8p66VLbCYQx6IcQo+ZpucOop4oaQ
	YTwD+saG4GY5Uw58P60WyGErxRB9G2oRCbD2Lubms684BWMpxtHtKbvICyr0pfTOlDNIPVaDPptga
	+u1HBzM+g2wbSd+5qODnP3Q5Z/hSbnzDduLacXLqvQhHNSyFvbP41xwpuGJ1pVaNa41wguzU3Ip7d
	Rph95mJngimmC85zuFrzlNI7+ElNI7Hn0c8wYYt2+S+3jATg4kOMrJSkhgyVIeyhpF8EV5lzM4bv6
	YxS0uZgg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pby1d-009B4P-I2; Tue, 14 Mar 2023 06:20:45 +0000
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pby1a-009B3f-CP
	for linux-nvme@lists.infradead.org; Tue, 14 Mar 2023 06:20:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1678774842; x=1710310842;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=im43GQHZr3PT1ukGXzRFhFU/FD6QaIVx9hRaU1MkB/c=;
  b=FzJ+/Xz12Ny1EJOEGHy6jOH5Emv1Hp3Ry0nlrfSkjuvFUA7FTVHpWngj
   LnKuhjIfPmALbaHHU5YX9YFLZheeCy1SJR89IVDlOAPok3bSMtmYBDQYb
   ZLDhveXMPxsLhU2q+pv/07vzk8fvun6O3r5n9B4wWLq0tk2pwZfcWoRFc
   aItjfh1ILpV8IEJqOh0Vg+CCQk9m13PaGYekW6ROjy1WC8MHQnK/O65te
   FoP3udV/D5sJB9QkHpMH5V6dClIbXfegqKGMHTzhdjHjS2EW6f4qz/K0Z
   l0vmTzx9lqDBZMW4HBT8BzHG895En82RSQbN3XYqYSJPuMegj/IOxOzwK
   Q==;
X-IronPort-AV: E=Sophos;i="5.98,259,1673884800"; 
   d="scan'208";a="225575251"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 14 Mar 2023 14:20:39 +0800
IronPort-SDR: 1rjDGp+cppgAsfdfM6uWmd7oxr3rxG//6f1CXW7nZMx8fzf7kS72xExQp4kEENWabGG5KkCLtn
 fK9bp9wMzhU3T/S9ST2PBxIEv9flWMe6P04IVxj2WmCAIVn7vHbD8KQC9MPSjNBb/RYqmJ/ZtN
 SRGMtMEWTE80GTwIdxihl1h4ArXMPI8TX36ERQxdtpKJFiymujQjEqCl/OgtBV9Ox6xC8fQg+S
 EPYDTyXoII0+KmlE1wIPtX6Jw1WlyiGuoquyn4bDHPF9Qkrqd5njyiMj6Gbs/jnp1o16O/QwrM
 QtI=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 13 Mar 2023 22:37:07 -0700
IronPort-SDR: KJHwBe42akLXP0oWfy24oamsfSgvFd3/tuc2ppcyG50UwsrZOCOddGKm0fFJlAfyuTfLItFv/k
 ug6uUfQsm/GcSHwZe4Doc0MFYcrkAwWokh/YpJ6zFu/v2KxI0Uoqzm6W48sXnv0RdQR9WTM8rB
 9vnSBq7mHsblEiwMCcIrPQSHcmiIpgZTN1IxmeKFP4/gnJSLAAS8+ceh+BEO6SvSNnWSHQ7v+I
 ybM34JylsJNF7Vhc2aNWWlzTAKzrUtdGgfi9hntuQxnn5pf9JQdrIPnyzbBkSEXv/tiyqweOXG
 4sY=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 13 Mar 2023 23:20:39 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
	by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4PbNgW3KF5z1RtVq
	for <linux-nvme@lists.infradead.org>; Mon, 13 Mar 2023 23:20:39 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
	reason="pass (just generated, assumed good)"
	header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
	opensource.wdc.com; h=content-transfer-encoding:mime-version
	:x-mailer:message-id:date:subject:to:from; s=dkim; t=1678774839;
	 x=1681366840; bh=im43GQHZr3PT1ukGXzRFhFU/FD6QaIVx9hRaU1MkB/c=; b=
	TNuf+HzgyVY3N9euZXjuW375+nbGT+dlxkfjkLvD7oejGXi15rk80og89k+GSMa7
	q9z8NaNQF2lYEX/oLqN4kBpbcorsgtkvdeYyDs3cBofgSMlbwYJHbmGO0ZZwLn1W
	sFAbfFF0D2Io3V5+uUr8+kQVyFHFA4DsMgTpTkZHx6vOH9K0QKzbTM0fXf+RMQS3
	/MBrgZvriAYTe/pjSDS1XFd5cpXw5lHaPQ8iGl4gxiWv7FspxNXmPUXrgha/myN6
	U4+3VNuV+Q8izsg1yuPKoChu9QdZfgfaTu7MWMlBUnSMpwBWvO3is7AOZ/NVVt9V
	qYRUdUxttlm6Rk9Sb3G1fw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
	by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id nNHZrp6dgQ5Z for <linux-nvme@lists.infradead.org>;
	Mon, 13 Mar 2023 23:20:39 -0700 (PDT)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
	by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4PbNgV1vBTz1RtVm;
	Mon, 13 Mar 2023 23:20:38 -0700 (PDT)
From: Damien Le Moal <damien.lemoal@opensource.wdc.com>
To: linux-nvme@lists.infradead.org,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH] nvmet: Fix error handling in nvmet_execute_identify_cns_cs_ns()
Date: Tue, 14 Mar 2023 15:20:36 +0900
Message-Id: <20230314062036.25939-1-damien.lemoal@opensource.wdc.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230313_232042_527663_3C5025D3 
X-CRM114-Status: GOOD (  19.76  )
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

Nvme specifications state that:

If the I/O Command Set associated with the namespace identified by the
NSID field does not support the Identify Namespace data structure
specified by the CSI field, the controller shall abort the command with
a status code of Invalid Field in Command.

In other words, if nvmet_execute_identify_cns_cs_ns() is called for a
target with a block device that is not zoned, we should not return any
data and set the status to NVME_SC_INVALID_FIELD.

While at it, it is also better to revalidate the ns block devie *before*
checking if the block device is zoned, to ensure that
nvmet_execute_identify_cns_cs_ns() operates against updated device
characteristics.

Fixes: aaf2e048af27 ("nvmet: add ZBD over ZNS backend support")
Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
---
 drivers/nvme/target/zns.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/nvme/target/zns.c b/drivers/nvme/target/zns.c
index 7e4292d88016..77ef0a86ff61 100644
--- a/drivers/nvme/target/zns.c
+++ b/drivers/nvme/target/zns.c
@@ -97,7 +97,7 @@ void nvmet_execute_identify_cns_cs_ctrl(struct nvmet_re=
q *req)
=20
 void nvmet_execute_identify_cns_cs_ns(struct nvmet_req *req)
 {
-	struct nvme_id_ns_zns *id_zns;
+	struct nvme_id_ns_zns *id_zns =3D NULL;
 	u64 zsze;
 	u16 status;
 	u32 mar, mor;
@@ -118,16 +118,18 @@ void nvmet_execute_identify_cns_cs_ns(struct nvmet_=
req *req)
 	if (status)
 		goto done;
=20
-	if (!bdev_is_zoned(req->ns->bdev)) {
-		req->error_loc =3D offsetof(struct nvme_identify, nsid);
-		goto done;
-	}
-
 	if (nvmet_ns_revalidate(req->ns)) {
 		mutex_lock(&req->ns->subsys->lock);
 		nvmet_ns_changed(req->ns->subsys, req->ns->nsid);
 		mutex_unlock(&req->ns->subsys->lock);
 	}
+
+	if (!bdev_is_zoned(req->ns->bdev)) {
+		status =3D NVME_SC_INVALID_FIELD | NVME_SC_DNR;
+		req->error_loc =3D offsetof(struct nvme_identify, nsid);
+		goto out;
+	}
+
 	zsze =3D (bdev_zone_sectors(req->ns->bdev) << 9) >>
 					req->ns->blksize_shift;
 	id_zns->lbafe[0].zsze =3D cpu_to_le64(zsze);
@@ -148,8 +150,8 @@ void nvmet_execute_identify_cns_cs_ns(struct nvmet_re=
q *req)
=20
 done:
 	status =3D nvmet_copy_to_sgl(req, 0, id_zns, sizeof(*id_zns));
-	kfree(id_zns);
 out:
+	kfree(id_zns);
 	nvmet_req_complete(req, status);
 }
=20
--=20
2.39.2


