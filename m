Return-Path: <SRS0=tyJo=4G=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ED4BC34031
	for <linux-nvme@archiver.kernel.org>; Tue, 18 Feb 2020 21:44:05 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F7BB206E2
	for <linux-nvme@archiver.kernel.org>; Tue, 18 Feb 2020 21:44:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="b23LCgOD";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="JAXRhbDx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F7BB206E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=TwyNXV/tzbin2O7f3JvszsV4kJwVD5DtA+HuID8PmDs=; b=b23LCgODXftWeL
	MAZwxlpHlx+xu4g/DnYex9T7xpKWhytQerRJQRl+z6xNmZhPH0APMFDw+nIZbXqNtqju71tp8EaWy
	8UJ5LE8CoYiyg9/AvLaW4pZ1lQV0itR3U2KXR9JXUZr0p7BoouUd4Oa7kpMzS+90n0YOF4zkWAvCu
	d1EjPtwuX4R4Bi7edjfjSq4ZOLzKIuit4fjJ/45kkNoCR8OdPJRxz4GjVOk5hjBP9xscnoe7DztLs
	vrVp6UwUsXyBQWCo5AsQzm8ph3szAM+/eZhBsdLHCxDcuYOuN2u0fIt63Gl+2WriPnMykpADj9UUS
	8X0b/wwgHHdSJq0rhCgg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1j4Aev-0005Ep-MI; Tue, 18 Feb 2020 21:44:01 +0000
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1j4Ael-00054b-UT
 for linux-nvme@lists.infradead.org; Tue, 18 Feb 2020 21:43:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1582062232; x=1613598232;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=K2VbdB51okANtg0cnPnu9LORb/UQUUqsuZZ4Tw4t4c4=;
 b=JAXRhbDx6GJt7NqGT4XlO3qrWL6NgR7A+3ImJmxgZUZ0qrT7or+LsbNC
 I3Njw5CzqL6Cu3y2UpNDF3kZTwT/7nTfwI/ax6Ya8Hok607TaX9hSa14O
 nwlREYuHONUyITNGZG9M/B1v9r/+q0rqADPINqVCz9cIpJf5fEQmS4QXT
 9N6Uhl/L83gk38rEx67ekrb/TmF8P6VN/aCkUaDrMrSu/OBGENZnuogR7
 KkRMH7vMbYDH+HLKSgbxT5K0RQR2AdA1S41KPZc7ivZWSH49JeFevYsa6
 c0kiMi0tYNoFkhZIJ+vUrE/QSw7qDWXeHfrNwAWuKEnSO6rrWc1Zlje1S Q==;
IronPort-SDR: 8nzOwdS8zGMYKRibj/ZX926tJeKcjGTuJSOXHyIv+hzt4XOyzNNoxuE8wwrVtbEUKxDNW7fDj8
 1y5YW19SzNA85HqauEX3KhdQ3VdFcEDltzW43UfmnKDU5negWbaBX0Bpgd7JsnbdDeMKIOcEUL
 slUqJdqHML5x2yVWE5A8enN5RMRfSWV3gokimCd0dOeUcdiPpiabOlqdYsNW2lnp5NI1Sx2uwn
 5EaekQqGKVjbl7vbcI27E8urqlpHNJFh8Mk9Zr8WDzTv93/IYjQ2b0UucdIy4c94UKMJcljpCX
 c+k=
X-IronPort-AV: E=Sophos;i="5.70,458,1574092800"; d="scan'208";a="131570917"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 19 Feb 2020 05:43:51 +0800
IronPort-SDR: qhIqz8Qix3+9Mu2o1GVjiCm1if9g6Cy6+0Axub4PbS7zeeYNl0gP8vRtX7caPRXtlaYMfDvyNF
 vcZmzFVvyXpp0rtjRBOm1VHe2GvsnNUA6DFAx6ruj6BQ4Iai4DzOb0JIET6KVPH7xvUGCCOIqv
 pz9qjBI3eaByMggCHiio3EMBnGYmVr0sHZ1TpOLHW43Qo9y/NdSGNrb0gqW5SU5EknXVdAOTns
 h0kyC+X+/urKuJj6X8+ReLb6kaROaPxzPNvd+iE/WseracqGtGi/Rzp986mwoJx8RVDURwQCmq
 GzwsrlxFr14vIuHPrPBefsxb
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Feb 2020 13:36:29 -0800
IronPort-SDR: hphGJAt/yQpC1ESwVb/0TfIaLO9SPshrlmMfRjk67J9m/dPm+cZi1rPaqBKNafragNkyVkC8yn
 OdOewaKOIe2lW2E6xKfG220JLKag9y4dwHTapKj5w8/kvvqBOdud2Hov4NigyZ095BuyE+++CX
 45yyq4WjzPuIphGjbbJHNOPd7rFiCj7uXabE0ALxDSK6mWv29QZIoHJbT7rHH81uhVSshcLatG
 wLJiHpVhALiizNA2up3+d5kcIGFdFBAR27GKOYNkJMwmH4BC/p6eF11CEczC0IW/Vvt3bd77vb
 dFc=
WDCIronportException: Internal
Received: from iouring.labspan.wdc.com (HELO iouring.sc.wdc.com)
 ([10.6.138.107])
 by uls-op-cesaip01.wdc.com with ESMTP; 18 Feb 2020 13:43:50 -0800
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH 2/4] nvmet: add support for set-feat-timestamp cmd
Date: Tue, 18 Feb 2020 13:43:36 -0800
Message-Id: <20200218214338.25088-3-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200218214338.25088-1-chaitanya.kulkarni@wdc.com>
References: <20200218214338.25088-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200218_134352_073890_406A37BC 
X-CRM114-Status: GOOD (  12.77  )
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
Cc: kbusch@kernel.org, hch@lst.de,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>, sagi@grimberg.me
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

This patch allows host to use set-feature command to set the timestamp
value in the target controller.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/target/admin-cmd.c | 20 ++++++++++++++++++++
 drivers/nvme/target/nvmet.h     |  3 +++
 2 files changed, 23 insertions(+)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index f6374cd5e938..ebb595480422 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -29,6 +29,8 @@ static u32 nvmet_feat_data_len(struct nvmet_req *req, u32 cdw10)
 	switch (cdw10 & 0xff) {
 	case NVME_FEAT_HOST_ID:
 		return sizeof(req->sq->ctrl->hostid);
+	case NVME_FEAT_TIMESTAMP:
+		return sizeof(req->sq->ctrl->ts);
 	default:
 		return 0;
 	}
@@ -729,6 +731,21 @@ u16 nvmet_set_feat_async_event(struct nvmet_req *req, u32 mask)
 	return 0;
 }
 
+static u16 nvmet_set_feat_ts(struct nvmet_req *req)
+{
+	u16 status;
+	__le64 ts;
+
+	status = nvmet_copy_from_sgl(req, 0, &ts, sizeof(ts));
+	if (status)
+		goto out;
+
+	req->sq->ctrl->ts = le64_to_cpu(ts);
+	req->sq->ctrl->local_ts = ktime_to_ms(ktime_get_real());
+out:
+	return status;
+}
+
 static void nvmet_execute_set_features(struct nvmet_req *req)
 {
 	struct nvmet_subsys *subsys = req->sq->ctrl->subsys;
@@ -755,6 +772,9 @@ static void nvmet_execute_set_features(struct nvmet_req *req)
 	case NVME_FEAT_WRITE_PROTECT:
 		status = nvmet_set_feat_write_protect(req);
 		break;
+	case NVME_FEAT_TIMESTAMP:
+		status = nvmet_set_feat_ts(req);
+		break;
 	default:
 		req->error_loc = offsetof(struct nvme_common_command, cdw10);
 		status = NVME_SC_INVALID_FIELD | NVME_SC_DNR;
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 42ba2ddd9e96..a3ecc269ebb9 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -173,6 +173,9 @@ struct nvmet_ctrl {
 	u16			cntlid;
 	u32			kato;
 
+	u64			ts;
+	u64			local_ts;
+
 	struct nvmet_port	*port;
 
 	u32			aen_enabled;
-- 
2.22.1


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
