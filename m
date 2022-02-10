Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B279FC433EF
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Feb 2022 20:58:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FY0t1N3GL1RjhagsNomt4ORYMNqON34tduD0nfqpTng=; b=aCxB+DZKqVogMOOeV7j2vouH4f
	hUnNbbxQedRNNnvmQSJIiL9k/BZU8qZIkc4al5N9sj/qZ3o+5/SwjWs20VbYbm31F0XyZSa7XrslE
	eAeMxel++/Q3ibFEuylH7N2hGDllq4WMSlj9I0aDec9sP3s60GFHu9iwuXCz1HZHIbanQYv5m1Ctr
	H0ZnGa0JcC2Lru56Vjk1PvJXHRhJRrNNXXvApQMUzJCmLaiFvAODfg+JST7WSJHZRJx+vXOXscNws
	Rqh3GXKZmpeb+XTvTrWzrMQDDG08GKSFHIS6f9eahpkkt8P571PtjgdNmZ78BoABCqjbz4kCA7QTv
	IJqrBhUg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nIGWk-004vL3-0G; Thu, 10 Feb 2022 20:58:54 +0000
Received: from alexa-out.qualcomm.com ([129.46.98.28])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nIGWh-004vKM-7a
 for linux-nvme@lists.infradead.org; Thu, 10 Feb 2022 20:58:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
 t=1644526731; x=1676062731;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=FY0t1N3GL1RjhagsNomt4ORYMNqON34tduD0nfqpTng=;
 b=a5bT2V16CXcJmfobv1YJm4MgIcpMvpLzF1CenjYIBfD9Rj63mrOWe/zc
 OtdSQ+tg1ZWwXHpjJbkRFhJhYAqY8A3J86sg1w1fxKm6AMRsqDBZwMEPQ
 clbAtUXy1xxb+osyrDT/m7J3DkmZiLwF80sWftk6cCc9W38MIPJVRLWxL w=;
Received: from ironmsg09-lv.qualcomm.com ([10.47.202.153])
 by alexa-out.qualcomm.com with ESMTP; 10 Feb 2022 12:58:51 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
 by ironmsg09-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Feb 2022 12:58:21 -0800
Received: from nalasex01c.na.qualcomm.com (10.47.97.35) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Thu, 10 Feb 2022 12:58:20 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Thu, 10 Feb 2022 12:58:19 -0800
Received: from nalasex01a.na.qualcomm.com ([fe80::bc64:9e8c:e944:8704]) by
 nalasex01a.na.qualcomm.com ([fe80::bc64:9e8c:e944:8704%4]) with mapi id
 15.02.0922.019; Thu, 10 Feb 2022 12:58:19 -0800
From: "Nitin Rawat (QUIC)" <quic_nitirawa@quicinc.com>
To: "Nitin Rawat (QUIC)" <quic_nitirawa@quicinc.com>, Keith Busch
 <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>, Sagi Grimberg
 <sagi@grimberg.me>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>
CC: "Sajida Bhanu (Temp) (QUIC)" <quic_c_sbhanu@quicinc.com>
Subject: RE: [PATCH v3] nvme/pci: Add quick suspend quirk for Sc7280 Platform
Thread-Topic: [PATCH v3] nvme/pci: Add quick suspend quirk for Sc7280 Platform
Thread-Index: AQHYHsBOpLTvLkaTP0STBN0OK3zww6yNQ9UA
Date: Thu, 10 Feb 2022 20:58:19 +0000
Message-ID: <229a106182ae4572b3d9b250bfc53db5@quicinc.com>
References: <1644526408-10834-1-git-send-email-quic_nitirawa@quicinc.com>
In-Reply-To: <1644526408-10834-1-git-send-email-quic_nitirawa@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.216.37.205]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220210_125851_330887_80FD96F4 
X-CRM114-Status: GOOD (  12.26  )
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

Hi Keith,
My Bad..Uploaded wrong patch from my local. I have uploaded the tested patc=
h now.

Regards,
Nitin



-----Original Message-----
From: Nitin Rawat <quic_nitirawa@quicinc.com>=20
Sent: Friday, February 11, 2022 2:23 AM
To: Keith Busch <kbusch@kernel.org>; Jens Axboe <axboe@fb.com>; Sagi Grimbe=
rg <sagi@grimberg.me>; linux-nvme@lists.infradead.org; linux-kernel@vger.ke=
rnel.org
Cc: Nitin Rawat (QUIC) <quic_nitirawa@quicinc.com>; Sajida Bhanu (Temp) (QU=
IC) <quic_c_sbhanu@quicinc.com>
Subject: [PATCH v3] nvme/pci: Add quick suspend quirk for Sc7280 Platform

Enable quick suspend quirks for Sc7280 platform, where power to nvme device=
 is removed during suspend-resume process. This is done to avoid the failur=
e dring resume.

This enables simple suspend path for this platform.

Signed-off-by: Nitin Rawat <quic_nitirawa@quicinc.com>
Signed-off-by: Shaik Sajida Bhanu <quic_c_sbhanu@quicinc.com>
---

Change from v2-v3:
* changed if/else condition

---

 drivers/nvme/host/pci.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c index 6a99ed=
6..1dff749 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3034,6 +3034,15 @@ static unsigned long check_vendor_combination_bug(st=
ruct pci_dev *pdev)
 			return NVME_QUIRK_SIMPLE_SUSPEND;
 	}

+	if (of_machine_is_compatible("qcom,sc7280")) {
+		/*
+		 * Append quick suspend quirks for sc7280 platforms
+		 * so that simple suspend path is executed for this
+		 * platform to avoid any resume failure.
+		 */
+		return NVME_QUIRK_SIMPLE_SUSPEND;
+	}
+
 	return 0;
 }

--
2.7.4


