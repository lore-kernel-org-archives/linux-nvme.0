Return-Path: <SRS0=jxE6=IY=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA14FC433C1
	for <linux-nvme@archiver.kernel.org>; Fri, 26 Mar 2021 19:48:38 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 98A55619C7
	for <linux-nvme@archiver.kernel.org>; Fri, 26 Mar 2021 19:48:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98A55619C7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=PiseT/L7TevlfZiQ7RY2KjE/+L1bh76NljJI2V5u+/I=; b=evW5hb2wkC0wWg7MQmhNQcSf9r
	O/tsCYNJvLSHdxcPDKmEd8ZOtKfhf/GFc4y4Cdby05+kl1aobcpccHhZyOo5xhh9AYBFAdrhNCzVL
	xXtSpRZYa/g5wvNHfy8J9pT5HiVYAbe8NN0MSbXQeBSKzP1VmIYMq0X68j9l4nmH7uvQQRvIziCtH
	//RsUrypKxuZm6RGXyIqheprqSf5hnvs+oUgZ5Uw/rgON1Y0skxTDOrML+nOGepztv/37KFSKF7py
	D+sD7FxQti+aK/14UhzqHzPDB6ENHvK5mmLk/szkVrGmSuebUWtNDcAsS+tUNgzscEi64YASc/uC8
	LClpL7pA==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lPsRR-004EsI-Ig; Fri, 26 Mar 2021 19:48:21 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lPsRN-004Erd-IZ
 for linux-nvme@lists.infradead.org; Fri, 26 Mar 2021 19:48:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1616788097; x=1648324097;
 h=from:to:cc:subject:date:message-id:
 content-transfer-encoding:mime-version;
 bh=0+8mRW49WolWGzYl6LhqyTkD9q6Dl+joeunG4E609Ww=;
 b=rS2jS2Q4EN6ID19yH1idkn6t68oSIGMxCzgugLPhg27TNZffdlw99GWX
 7aBkJlH5SkKIixEP4n1k6+3pL1b3aUAWLDdShpzMSw8cJNP5H9a6B7b5v
 7IWjCupWuaHvCWesL5Ff7GbgAn7mChwqY+TjOGu1WQSVUOn6Bnrh2UCk1
 5OQRwr074QT2iR49lXvzb3340g5K6+1y3npAnxyxvNzONOefBZ8WdCrnD
 Nk2OyW1X2V6ist5XNo106/isMrwIdcH8ZWsOfqpyY1WP2xEsY30RhTWLZ
 HOTJ1q1RQztNCiq/or1byoNdKDOyxsr/NdSewz5esBJ26ztl9nnhOfA0M A==;
IronPort-SDR: 8caU/OxqqPOFMogkPK0ibT2Ct+0NsnikYeh+OJEK6MIVHG8N/fRsYsHVBUfNh/ozQBZdDgpcx9
 QQVh22lgmK7hDo480OgWJPrsnjvvjT/Y1x5vSPH1BQWDShot6G3iYoU9wqAsLDbKUWm+G/3IU9
 /TMlHX7fo/Z/m5I6ZRReeYbcJnJ1o737P7RDtCmstlRasYLdH8/nhb3OX3zoAHR/S+/TbD4hIT
 bPYzDu3BBPczRmllyklAoPGDqVokOESW6TvCbHTG8iJEnZKLuUEwI2En1TNhuh3Qg17mRzUB0y
 FNE=
X-IronPort-AV: E=Sophos;i="5.81,281,1610380800"; d="scan'208";a="163107518"
Received: from mail-co1nam11lp2175.outbound.protection.outlook.com (HELO
 NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.175])
 by ob1.hgst.iphmx.com with ESMTP; 27 Mar 2021 03:48:02 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ijsWb1FTo8+8P67O4Is30U2ViBKvi9cAo9Ys/pvDTZAeMCLplzcUPpx4SBAtOC3ChEHc6u1ZsA/ByAf/Y0kmA/0Ta9fu40UPKDV+bnNeeeu1UTwBivxI9+YK+0uuyMZEQxXxv5Q8sDiF7jMXOfBohT3MhTUZkvpnJW6necN2zsxNx/r5LNzjkkDcGbx3oubS7k7NRsVrb7dorvOBUXhPYOfaUjegNtQhjKkJzbetRy/o/bC+4rrl1WuCfZc281WDQKfDZY3VFRZuhyAD13SWK7uu1DbSgjes7jq2lF6ixH0KG/NJbvhnht3jFnEuINJAcrw87ftjKYFfdoFaXPFncQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C3o639Xu96LDto0HpIvHUoNkQLuIGc9iG/MOa5fpRG8=;
 b=YAJfTklAK+dBhgPGNfxyN/B9S6TITTpR2j0noh4KcghGQFjiTZ+pyC1jspWAa/MjX1+3pciX3zOxsftb2wNdZygSfekzsFyKd6V22UNJoMhZac4PzQgU7MtUU0/JL/lg+spVTdexFrfFFHhAQQ7lTP7hHquYBcl2tI+/5Z77lya5C7QpjBXb3/yXaABympuOcHCf++2b1rmykoJQgwk2YGfIgiyNv8KiAy5lBI3g2fYv77jUbZNS+66sf+PShFOKu5lPWSGku5Tv/wu1luuTolItM+B8HRehUnjLH95Iy1PfOiZZCFINsTEN1BYto0ZHPG/HTPQswKaJjnOOxaxoeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C3o639Xu96LDto0HpIvHUoNkQLuIGc9iG/MOa5fpRG8=;
 b=PHQ/UsbeSDk9ibuENSEqCuJqkG1frLLywbSFBtWmAGyLnPGTwTpDyjv7EnO6pk3WGWs5DoDH+w2JYb6vkBjhNsz0DeMUfH7/XhW/XW32w0o1qAthd4KmvnqicYyzOckI/q52rAvtCHDXtf5ixfKzQcw5jvmgmEK40ExyTSB44gs=
Received: from DM5PR04MB0684.namprd04.prod.outlook.com (2603:10b6:3:f3::20) by
 DM6PR04MB4745.namprd04.prod.outlook.com (2603:10b6:5:24::29) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3977.29; Fri, 26 Mar 2021 19:48:01 +0000
Received: from DM5PR04MB0684.namprd04.prod.outlook.com
 ([fe80::f0ed:1983:98c8:3046]) by DM5PR04MB0684.namprd04.prod.outlook.com
 ([fe80::f0ed:1983:98c8:3046%12]) with mapi id 15.20.3955.027; Fri, 26 Mar
 2021 19:48:01 +0000
From: Niklas Cassel <Niklas.Cassel@wdc.com>
To: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>, Christoph
 Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
CC: "minwoo.im.dev@gmail.com" <minwoo.im.dev@gmail.com>, "javier@javigon.com"
 <javier@javigon.com>, Niklas Cassel <Niklas.Cassel@wdc.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] nvme: disallow passthru cmd from targeting a nsid != nsid
 of the block dev
Thread-Topic: [PATCH v2] nvme: disallow passthru cmd from targeting a nsid !=
 nsid of the block dev
Thread-Index: AQHXInjtbxc2KiPgZUagFD+bTVpMlQ==
Date: Fri, 26 Mar 2021 19:48:00 +0000
Message-ID: <20210326194749.396599-1-Niklas.Cassel@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.30.2
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [85.226.244.4]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: be99b6bf-c702-4136-51e7-08d8f0901049
x-ms-traffictypediagnostic: DM6PR04MB4745:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR04MB4745E03A9E2A3084F90DEFC6F2619@DM6PR04MB4745.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:619;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: l2TA/Q7y7xLUecJzw5o5mMSbuV2lQQUVWkdMF8mkJYUnwUNTTezWKbrvzbvpkwRc1Er7bm2bf49rcl6qh/Rp/npdwaXehSVPl4RcVBApw14CPdZ411n5KzOdxO+uDfkLQtvQM1c5l/KEWdbY/wqqlJPI+vyAuaeGhiboMtcCiw36uTCcEjL+AgQw69dRrOxsAa33bqOgaNUU7j9VeVdoGykpxEO06mpU6lMeQUn1dpR1TbvoVnAbN1Kn2KjFpTBsRwjXTiZ6LUnqoGFjU9Fu2LEbRr+vi9sSjxfYZ7C9lTafYefvLvQXwf5Rkxd6Ip+TPXnAKmget+y9l9CBUHvdtEd9GIDAkZn/XM0OwzejWU41PrO1l+CGLvCeCyjXBFMQfmw2ioVeaN31UMKdPGf8kraVW7CQ0X9YuJK2CDlCMWq9OmhL2oNFiQpfBd/P0I8oPOx4dkJuiWajGcWgzYb02oSs2KrsFudxCYBVr1Nq2UZlwgDhpPIYg+G7IdW02zWJvyU5e3O5Md3DVqtzm9BYbkte/q7ZHGnE5rGLJJJuVzsAJDrZycR1j3WImBvRmfW4FN2K+AJE6rrY5EBGIeH9BU4GbHztKWr1wkVIiHrZI+RvO0nEhuFfJ5Y2XEKKFiuKieqpULNOygDwbOoxdIlRJu9Yp9cRJTWSyOefOSHI4Hk=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR04MB0684.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(376002)(39860400002)(396003)(366004)(346002)(6512007)(66476007)(66446008)(66556008)(64756008)(91956017)(76116006)(66946007)(1076003)(2616005)(54906003)(26005)(83380400001)(478600001)(71200400001)(186003)(8676002)(110136005)(5660300002)(8936002)(36756003)(316002)(6506007)(2906002)(86362001)(6486002)(38100700001)(4326008);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?6BA5YoyqW9Htvg0i1EKYpkUtMfOsSue+QA/a101POSmiguogHHq5Y3EtTA?=
 =?iso-8859-1?Q?yNR6uQm/kLvG6qpmgZc8LsN6QZkIqcyjDGke49TGSQPaWAnQwhh4theORo?=
 =?iso-8859-1?Q?Xw2vKwSsnvHdpHEjh7uxGu0CFenynMROpsnDbYV6I/L8r2vUz2Vy6clDpf?=
 =?iso-8859-1?Q?ynvtR4TmtvRe+LVR6ia680oPK0jCta2eLHbggfE+DPeyOIl87/rFH8HaL9?=
 =?iso-8859-1?Q?r7LvCXcS7i3KpjDQFKOY6zGTeAqk/4dObBfCAIyVW//EkgtUNYXyjLVNx7?=
 =?iso-8859-1?Q?g0DDNuA5CoOYFY9DSBH+nnSJAmx4oMJteEL9y9UU6tQQ0oe4ASXjGtEGYI?=
 =?iso-8859-1?Q?Q2u39oPbi10i1AxDXs667fB0akQwiAA64VyLusPLIo4+rNDS16/zgZtTnb?=
 =?iso-8859-1?Q?jFd3G26e33hRDSdtlr2hRe2eYh+UZIuQaIFE4dGAt02Dx9ALn/Dh4RqNel?=
 =?iso-8859-1?Q?lrpmO9DQQ/T4yWLLqORZhc2C+Yr5GT3iwKw1Z29wAxDutSDxJRsrO6C5EA?=
 =?iso-8859-1?Q?O3ZhG1fMrMF//jkDCmjLz4pGvv42QeZ9RVM85C0SQ7MCr9Ur3vxbInWlMe?=
 =?iso-8859-1?Q?WvBc5mtqis+crOPTEomGFYcwuKk2ZBGgiUxUN+jNFkC4D8UCL1l/uvB/zP?=
 =?iso-8859-1?Q?KIaHHVP13nFwHsi+bss03jn+R1fIcYik55UBzxZVHXvHbl+Sd7CtAmHdOm?=
 =?iso-8859-1?Q?kes2no9ba49vQ9+SKKOOe/jPvEYtZ23roXlBwyc/hkBYAj/QVSi2ACYCMn?=
 =?iso-8859-1?Q?fEuF29vPqV8ePDF6kXYSUAkvWu2csWD1O5xXRXOGH/br9281uekdZ1ux2C?=
 =?iso-8859-1?Q?FkXC9JL9UiIeg+bXKgT6xp6A1QjGS8+/qp73rfkvuN0mD590Zz1D9uYgMc?=
 =?iso-8859-1?Q?tDWcmjJ7L2h098fFWA9EFSXskGPXxtJumW0Cv79/I+pz2XIhpsJ2aofbpM?=
 =?iso-8859-1?Q?dRLS+XS5FPom5GpMEi6Zp7xvxhJ8MXTEfp2vKvFdv+DW/xTsDTsrvDO3SM?=
 =?iso-8859-1?Q?Qbepg9C27djCRKhGw/O/a5lEeW+YKB+b7T7JsJJUXhswZunVDfM67SdnEl?=
 =?iso-8859-1?Q?36Qdiu9IgSwgomsbnl1M2f6xxo2tDEOpm0XuWpSbDwR2R9ozo7MQy2DZqD?=
 =?iso-8859-1?Q?SbqSBMnOY9/sp63gxv1FEoM7pgzGYm8m/Aoc5H1G7rmhw/6y5LPIHiS4m0?=
 =?iso-8859-1?Q?T2LAskFb+nMrRpgW//3lr7xEMjZrnH1OQiayPlE7PjBwGQ5lSAv/QBxfBz?=
 =?iso-8859-1?Q?JGJsJeVcoOkOf+ghNkdi+hA48qeWn9SHZxS/QAB/o3dpfzoLjBcroHQ22v?=
 =?iso-8859-1?Q?An1gX/3HcRMqaNt2+sOxmXXt4XxtVfbi0Ba7/L2Lw631q+jLs1qdjnsI99?=
 =?iso-8859-1?Q?Md8BNAd0pW?=
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR04MB0684.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be99b6bf-c702-4136-51e7-08d8f0901049
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Mar 2021 19:48:01.0363 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wmx1ZwFyJpcd/zoTI+j/0chFAYJOZXJ/bmZSORnkRI8qbHhNR/AduB3h3073qzreGPauEKbipQtlCZU+ZjzERA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB4745
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210326_194818_169216_52BBF5CA 
X-CRM114-Status: GOOD (  14.53  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

From: Niklas Cassel <niklas.cassel@wdc.com>

When a passthru command targets a specific namespace, the ns parameter to
nvme_user_cmd()/nvme_user_cmd64() is set. However, there is currently no
validation that the nsid specified in the passthru command targets the
namespace/nsid represented by the block device that the ioctl was
performed on.

Add a check that validates that the nsid in the passthru command matches
that of the supplied namespace.

Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>
---
Changes since v1:
-Added error print.

 drivers/nvme/host/core.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index f13eb4ded95f..a50352ea3f7b 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1599,6 +1599,12 @@ static int nvme_user_cmd(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 		return -EFAULT;
 	if (cmd.flags)
 		return -EINVAL;
+	if (ns && cmd.nsid != ns->head->ns_id) {
+		dev_err(ctrl->device,
+			"%s: nsid (%u) in cmd does not match nsid (%u) of namespace\n",
+			current->comm, cmd.nsid, ns->head->ns_id);
+		return -EINVAL;
+	}
 
 	memset(&c, 0, sizeof(c));
 	c.common.opcode = cmd.opcode;
@@ -1643,6 +1649,12 @@ static int nvme_user_cmd64(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 		return -EFAULT;
 	if (cmd.flags)
 		return -EINVAL;
+	if (ns && cmd.nsid != ns->head->ns_id) {
+		dev_err(ctrl->device,
+			"%s: nsid (%u) in cmd does not match nsid (%u) of namespace\n",
+			current->comm, cmd.nsid, ns->head->ns_id);
+		return -EINVAL;
+	}
 
 	memset(&c, 0, sizeof(c));
 	c.common.opcode = cmd.opcode;
-- 
2.30.2

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
