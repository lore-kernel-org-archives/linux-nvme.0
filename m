Return-Path: <SRS0=tyJo=4G=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AB6FC34031
	for <linux-nvme@archiver.kernel.org>; Tue, 18 Feb 2020 21:44:19 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2838D206E2
	for <linux-nvme@archiver.kernel.org>; Tue, 18 Feb 2020 21:44:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="MxoenLYq";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="SJYd3MYG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2838D206E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=t52KzDMGUnEMw2wAk4bRIf2GAZ4PsvE5afBL0DibxIQ=; b=MxoenLYqiDJ9Y4
	6j4nYng8GvCSLS9NjQrKCSPJfdO4Siy6mBJJIBImakStXky9tDEIlXEmHdZm1SSTrnxPPxfc/HUNW
	DlbwISKp6grO4V84t5LiaZK7Aw6E+uQFbFXll98bk2Dwn/sFUDYHQwwIwup7ti0suDsX1XDwdK99S
	LtAOigzpY5wlKdEJQE4VnD90TeGZr3p5j0cqv2q7iKG1vlUJYzN0DzV3v6h0tZ5ig8YPsdC7CJZHQ
	nAIxOpSzfgOBkz1vVt2Mm7aRUiPLEL2cZAQ4qlx1tH2eo26HyEuEPMFa/NCQO08scNso5Qs2nDN8x
	AKPcpOpL9Em/iaIe/eRg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1j4AfA-0005RN-Li; Tue, 18 Feb 2020 21:44:16 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1j4Aer-00059m-8u
 for linux-nvme@lists.infradead.org; Tue, 18 Feb 2020 21:44:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1582062255; x=1613598255;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=DtalJwoNrfub2RAraRono+7gT6Zn0+o+LgncpufGq38=;
 b=SJYd3MYG38m39W1KsXjbAq/TcXPiarmVSaiqXa8XqZRSf8lNemeUPCAo
 EaPbp/YfE2TOD83YYvzCyIk64SJBW5MVok57bS0Kzctyi8HSsn5RnHlA6
 c6UL2SAbCIoPgQM8QBgfxfVibmkdYG/nBHW6VQPcRjxw44RDlByZLalIl
 2bpaT3y+F22JpqUjjviJtv6UCG/8ivkUofrA53pih8RH0N3D6tY2DhrgM
 1Mr/BSf/i6w5N2wsJJ3KaAO6S98mVY+uHNyLBGJq2b2YtrOezkLlywKA4
 kORVsQC2P8gNUzONN8NA7cqelC9us4Es9UNjgVcZqYjPIPPj9Tw1U5OaH Q==;
IronPort-SDR: D3QJONGmN09eRNERYWZV4Ge06klzCDwxiBT+ePJI5HFYMuYviGkyf8JWZGGZ+nXNsZdhlHPg6Y
 eI8IKcS/YcnJUvq+LXMaVoI5F0/hFKfKgoNAkXxewfY8dQFwJ3C4sv+RLvPDJ1u3kSrmnMAPFb
 DihNFbZW1n49vWTVQVWZE9aisjb6SW1lZEw8USfroYK+rnxQd5oy0cx3kxj/8ZAsKKfZHoSN15
 Jm/7aq7S4ZPjbVcgjz43UDbdfbPypy2kwqWVyVKTGYgw8PvYaUU+STF/2SeZFT7U2P5Bj2e27H
 P9U=
X-IronPort-AV: E=Sophos;i="5.70,458,1574092800"; d="scan'208";a="232000802"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 19 Feb 2020 05:44:14 +0800
IronPort-SDR: Yz98uw6zntn632JZ57g00KuRS4iHItQih1eJ92/fpjLy1lbzIrMjYrkiL7UgkbRTt5JfU2E0B+
 kTl4lBaVHnMEZUmA2sUwoI14Z6Y7dId69gCHGliQX5ggmCiGv3vsWGL6rDMbVGiVSnI+qmNUFw
 EQpWal03sDZYiNZCIYjkQPOEuVEsXVXb5bIm9iTRlrKoD3+0iN+JkbZIx0/sBqMAWcD/12xeLK
 S1RmayMbSifd1HfaSwc+RciDk5sF8zlcv325sOzd7OTyU3EHCq8Q1A/ckhMvf0yHd6Hy/gmhyd
 pFUqVaGRBpbipcAdWReri7AF
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Feb 2020 13:36:35 -0800
IronPort-SDR: XbTReWnVlsr2quQtImxFXgp3mA1eo2BmzWxS+z+wrhdow+0qaeyKCWzwSWaTZeLmq3NVLYxtF4
 rqwTmdY/gK2MwECvPQFuWpN2PKECzWUCJ3Q+C+eLkTZVAmdoiCzaXdU5AaCD6iFUkL6CZyKXb3
 csQGXQA64itq5/sVFPnpoC/YLZ+zM+v06i6mm+FD73kM0AH6a/HaJiQEHEyDoxeqmB1KhWsObb
 QZst0CnkuKMJShkNg6AhEgO9C4coqrLVFUtfAi/ELAtYIoEa8y0XyhLGgkZZy8wgUSYxQwzil4
 Xfg=
WDCIronportException: Internal
Received: from iouring.labspan.wdc.com (HELO iouring.sc.wdc.com)
 ([10.6.138.107])
 by uls-op-cesaip01.wdc.com with ESMTP; 18 Feb 2020 13:43:55 -0800
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH 3/4] nvmet: add support for get-feat-timestamp cmd
Date: Tue, 18 Feb 2020 13:43:37 -0800
Message-Id: <20200218214338.25088-4-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200218214338.25088-1-chaitanya.kulkarni@wdc.com>
References: <20200218214338.25088-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200218_134357_411383_8C327F01 
X-CRM114-Status: GOOD (  11.83  )
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

This patch allows host to use get-features command to read the timestamp
value from target controller which is previously set.

We return the value set with a Set Features command for the current
value plus the elapsed time since being set. With that, we also set the
timestamp origin value to 001b (NVMExpress Revision 1.4 (Page 220)).

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/target/admin-cmd.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index ebb595480422..17411d70d4d4 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -815,6 +815,25 @@ void nvmet_get_feat_async_event(struct nvmet_req *req)
 	nvmet_set_result(req, READ_ONCE(req->sq->ctrl->aen_enabled));
 }
 
+static u16 nvmet_get_feat_ts(struct nvmet_req *req)
+{
+	__le64 timestamp;
+	u16 status;
+	u64 res;
+
+	res = req->sq->ctrl->ts +
+		(ktime_to_ms(ktime_get_real()) - req->sq->ctrl->local_ts);
+
+	/* NVMExpress Revision 1.4 (Page 220) Set Timestamp Origin -> 001b. */
+	res = (res & 0x0000FFFFFFFFFFFF) | (1ULL << 49);
+	timestamp = cpu_to_le64(res);
+	status = nvmet_copy_to_sgl(req, 0, &timestamp, sizeof(timestamp));
+	if (status)
+		goto out;
+out:
+	return status;
+}
+
 static void nvmet_execute_get_features(struct nvmet_req *req)
 {
 	struct nvmet_subsys *subsys = req->sq->ctrl->subsys;
@@ -874,6 +893,9 @@ static void nvmet_execute_get_features(struct nvmet_req *req)
 	case NVME_FEAT_WRITE_PROTECT:
 		status = nvmet_get_feat_write_protect(req);
 		break;
+	case NVME_FEAT_TIMESTAMP:
+		status = nvmet_get_feat_ts(req);
+		break;
 	default:
 		req->error_loc =
 			offsetof(struct nvme_common_command, cdw10);
-- 
2.22.1


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
