Return-Path: <SRS0=9ZED=LE=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA6B0C48BCF
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Jun 2021 02:55:38 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B9646141D
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Jun 2021 02:55:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B9646141D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=Eh6zuxU1+3DfmYJlfXznJENJ5bj1E2h/UyIp2yyB/Ao=; b=VgfDMqjyhHBED4
	cL35Nkt2rCRlrY9Z2PkDworQSPmKZrFlZ0SiLZqWiXVHss/ymgltkyinp+o8EiyqrEUq5s7LSqfDw
	AG0iQ/t8o5UCV30EjhE4h6OMNZcaC+dVwzHXD47Wmn5zBcGPV3wT3fSjiF4CQ8kgBvFa0XBNRioPZ
	jh2pKS3IIq2XU/zq/7ZgtuM3ky28GJPJBROQXtPojHKECoaxg8Dd8BlmXWU9/ar9TydkjRnsnirTC
	YTFOwPYV2xZZnhHLZ3sEjW/7n5tVIg9kqDCDGkCHIwuSCmMY65YTEOCUNVOX4r1Vc8C5UxV/qX4v7
	VxP4ghO0DbjQ51auZfnQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lrAqh-00GZNS-Fw; Thu, 10 Jun 2021 02:55:15 +0000
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lrAqd-00GZM2-UP
 for linux-nvme@lists.infradead.org; Thu, 10 Jun 2021 02:55:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1623293712; x=1654829712;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=L6G9X6uTQPLuBnmduiqU6TVle4qO5mFdHVh1PQ3yI3I=;
 b=D5XEogaKj3TZkKy4qbXm48KOIKsCpCMvfYLKb7DpntGAIeeG8eYIAK21
 3+OGnRMJN4fE782SJmCsntFfHxhZwhnmBdimo/kF/TCa46czsmLOH65hk
 CDDQhs/w5jbhc6jvQnlMJx+mmb1vO2BblhaLbhUmRxxFlAV4OtfVEXlAZ
 WdgLHIxatmbmjD2xT+Op5o2TB4M93BIqSZVqDVkG5DSwZrtgHW3ThvR+a
 JrFII/MJ6d5gpGG4MloiMAlztsUTxLMu1yk54ECPkkfLjug9WqOhCHzXZ
 st2QGvzDgEaCy3RmnzupiS97YDGSRpzksmaN/R5uPJF0ginUgZFlnOVO7 A==;
IronPort-SDR: OvFxq+EHw5xJaEFGgG0tYKK+QPNW7+r8bsnm61XO7iNSX9bNGM6umoQJpfKTkaym7aYzqdo8z1
 4cXbxQV2KzDiI+O85eL6mzjls91zAg5cAIimPYrro6cy++RYsd3JYO5HVslyBcIIdS+2XR4WnI
 ZNMjHsDr80q9uQm/WM/mZpXvulqSR8HxyZH/zKMYIGoWA1zY4ADtBa7M6eTvG2/+2o+VQcK9BQ
 AzPbSduaJJIUXKOVP+JX0h8QgkOCJ+xbnr5mZA9UEICreZLPa1o4p96x6pIzKE9tK6RELygdkz
 G94=
X-IronPort-AV: E=Sophos;i="5.83,262,1616428800"; d="scan'208";a="171938566"
Received: from mail-dm6nam11lp2174.outbound.protection.outlook.com (HELO
 NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.174])
 by ob1.hgst.iphmx.com with ESMTP; 10 Jun 2021 10:55:10 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NsPDPlLok0GFO/Q8keDQa1WaPXpnGMhQATK/5EUIAUS5JWjdOOKIPSIMMe1prSi4WknxCrtYbs2KiJcYmSYrKuWKYEpk1wcKuLfpYO8FBi5Zr6nKtrmtUA0jwF9EaI3TIK0NKKhg1vHRMNAp3z5MrLKHiXcB/rKJMsSVco0ibB9PNVqO7XuqPENkNm+YzidDOgUoeJ1bk9H75fp6uIuoG7V2x8ME/9uHOgnECxbpS6/Dquu9Mgs1ZbUW/DQ6bSMIKZBMN/h520cPj8mSui9KczVWKggqJkejPlcqaBFvMnhFuPo+TUCe+YR94fbxqsOTNYnEJz8c7xUrWwr9DXvHVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s6ruk34XSkExi/1LWBxs+DpFgwZ5VL2B/E9gDlNW5gI=;
 b=fRltFphFADh49UJYUWHLoLbyt+aPHfnZ55O5p3oLPY7c2axSn6CQ8TmK9fDoqSHUXFQL2CYb3EYWqgmVagpo4jPwBEEpfSwCtsYbBw6B2KhUwery/Yp01ZpJ9+vGxwg5YvH5Gcn4CrwcQwcO7ZZqRonx3B7dn7XQ8zdS+PXF0/XG3h75ovUtXkWxR7r32LBug1BX5KCADhOVXpHZpzdyKuLdAocLhdMVvh187PeOsTd3OYLz1Jet3eO08lIa284Y4llkeaF0avJ76oz1EMGdH6DnWxuRoOZv8W+5WXl95SHLCPoiBM8UVTCYdLoLnSfmKAX5k+A9eBptWJY1LZCrBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s6ruk34XSkExi/1LWBxs+DpFgwZ5VL2B/E9gDlNW5gI=;
 b=y7W3v2IPX49ZHZ9kmMFSnZf1Rlrs9y7c1kfj9RuJOMEmaDh1bYK7QwUCRO3Y3ajqaL+RuBKf9ZZc8bVtD6bFcOutUOCRbXtlymaaBgASSfzkOclpLWwmw4hNjNwVwDDgNHQV1EuGfyyt2BtcSHuDmop+DmiGM82V42EYjT3HMNg=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB4758.namprd04.prod.outlook.com (2603:10b6:a03:11::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.26; Thu, 10 Jun
 2021 02:55:08 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::6873:3d64:8f9f:faf0]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::6873:3d64:8f9f:faf0%7]) with mapi id 15.20.4219.021; Thu, 10 Jun 2021
 02:55:08 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: "dwagner@suse.de" <dwagner@suse.de>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH] Revert "nvme: verify MNAN value if ANA is enabled"
Thread-Topic: [PATCH] Revert "nvme: verify MNAN value if ANA is enabled"
Thread-Index: AQHXXaK3o1g8yliZMUm7tWfZRJ//BA==
Date: Thu, 10 Jun 2021 02:55:08 +0000
Message-ID: <BYAPR04MB49655A9B821FEE29D7A89E3986359@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20210610024539.28875-1-chaitanya.kulkarni@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.de; dkim=none (message not signed)
 header.d=none;suse.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 307c2b2b-0e7b-4272-2641-08d92bbb2899
x-ms-traffictypediagnostic: BYAPR04MB4758:
x-microsoft-antispam-prvs: <BYAPR04MB4758129A1E033B73B742490B86359@BYAPR04MB4758.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PMuwBKqukdhMPB/LhI4llMMGj6Hrm2Ih/GLCzTgR62bP59riGalkTv1CwWDgwwKF6fG4JtNgfb7zD/PgxJCPbhq1PAfdcIOaB3WCE/vR9tzwRc5qVecjPPGzqSSisZGfNfUmAnoU4ZGOyKoOQH93lg2mbcX6eL7tAB5PnSYrx6/DfF5cuNRXySD8AnK7C2Dad3beBU4SRKodTI/Hm0c5CUOSMgPJSALJjhQ/ktVJEyD4FINKYjAoZ6rEBxiHJrEssw3fetsVtOj8xDw1j60HNqLC9khUnvZ8+bPFf7SwrFHdutY4KI9KPJG/GIj4W4ytfsY1GmnAxioV2yx21XJbjlaU3l8gTZCETF6WCULkS3yGHEXpPCsmbH2gjToNWKPcuGaJxDOPlGUC7CNy9n/oiDeUCyRIj/SqD9ZaT9paopq4stxNU+mci9HKp4fSxPhdgC3FsvBRIUyTCC9ys/2HNWJtBa3jbag7gJhIy0FrxuHFPocK8gvx9gWWY94IAGZoFSl1g1rkxKWTAtfx8Zr6BRhDNA0j2FbtyYLuWonp0fp+QXBAGEzlhI8jeMzVSFOX5ccoRpGUP/8H9VsmXDxaHiCDKjSIwqNSa4iXFUwxI6s=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(136003)(346002)(366004)(39860400002)(376002)(66476007)(55016002)(66946007)(6916009)(8676002)(316002)(9686003)(66556008)(71200400001)(26005)(7696005)(76116006)(52536014)(64756008)(2906002)(86362001)(33656002)(122000001)(478600001)(83380400001)(38100700002)(4326008)(53546011)(5660300002)(186003)(6506007)(66446008)(8936002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?EaptSWoBLiiGvLPICNQmiBMAZx3aTMtcjcZj3yta6mpJ4VHBscPMb91qyQ8u?=
 =?us-ascii?Q?HW/PKsSQlqHprFR64JWXJFw1gv+afI/aywfkMjFBgW09nPtbjXzjE83qWVjN?=
 =?us-ascii?Q?BzXd5OtRJoQ3jXsC608UMtrr7cQuQoQF+bQaKSGhp45ID8ki8xnkFgLfHiFL?=
 =?us-ascii?Q?GzjjR1FSE9gs5eWptE35t1NU19WhoyfLeKolpZ2DMcU0u1LrhFLzACBFYLVi?=
 =?us-ascii?Q?GIkcFut3kF4+0PeUILsHOFpNTHAoVwiWrwikDOIIUk0TVNWKd/ATamF6MzL2?=
 =?us-ascii?Q?6iCaHTUsSZc39IMmfl9QTbJBFEKH1+YqBlBvbhsqa/K1dyVFXPLrWzm4FBbu?=
 =?us-ascii?Q?qkUbPfOLuuyVO/J6i8DGijkECyn96OPCiElWBLzIgWUnrRMckC1qnjiYN1sR?=
 =?us-ascii?Q?O/g+sI+mrg91EKemAv2mW1wMlkUthSTWX3bZ2nfiIf6de9XNqReWGk4nOpTD?=
 =?us-ascii?Q?aJQlQ6MjXP6cdtQ5pUW2VhyXchf9SCQBx6hulonQk91lqGanl25QL4JPDDZW?=
 =?us-ascii?Q?vQKAhhvgC/Ah4LgtbK++ekqgKNGhGO5lv26GY6nX4nAIJJQK4wMti7Q4P5TF?=
 =?us-ascii?Q?ANn7PKuJHoThvUGv4QMNtUwFSOtldVMdJzqO5ZWZ+caPDFKN1pqcMVwIeoe/?=
 =?us-ascii?Q?7FeMGGYPs4fOJCMzf7WOJIPQrE7E7QeeaFPzxBGgE2hiJrFkpXuPHzOwLRfl?=
 =?us-ascii?Q?IPKq7BD47MS49JqDWmrM0pm0irM/TXzOBYZ6EH3hAQJZys+HuqVtUK2yw9wY?=
 =?us-ascii?Q?vN7mDn8d/pW1pNPx71ERdHUOmo52nuMoPBatw0UpKNQjsc2fDwzUB+kM9OOc?=
 =?us-ascii?Q?N1W1uHmG7bmHNv4gyxlFndwZC715QUgkFoDztYkCUiPWfqVWiIbwB3rhiSsB?=
 =?us-ascii?Q?fNcxeQDZctCkY8GFKxVPKfuy47dvnNat/QYUX/n22xLZc1kInmbmSOoTBsmA?=
 =?us-ascii?Q?rKF8h+lYDT8SN7fLhoKdm5HU7ySCFh+GUV6z1yGh/gY1Ah059czaCWDL7Bap?=
 =?us-ascii?Q?G+i8NB2ASbBuAJhhS3r5tfVGf2DEaEXs4S5787cf/PEB0PijWP55Z+SltYxg?=
 =?us-ascii?Q?g2b8J66WUFtTG5vv4OrlIdVg0SCxN474V6AyTse/nHe6bdBh6tdzg7GfkI+D?=
 =?us-ascii?Q?jA+RRoaSMElfD8WFu8sCfrPNc5YEOFge+AZRMYwwWnxc8XdKzdks5UvPnVc7?=
 =?us-ascii?Q?S34ZAk+/KzUAiTu4g5LugLI+EYKOKdAaY2vCkbacCXk8jb/5J+J3llxqqNxl?=
 =?us-ascii?Q?aR0EyZHuLcg1A6d8k9U2nsitbrLyD9+jQz3exoexIuqvdRe6dWJ73YIr7M1Y?=
 =?us-ascii?Q?mqcCRCHeeFhnvegoCHd2NVON?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 307c2b2b-0e7b-4272-2641-08d92bbb2899
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jun 2021 02:55:08.7710 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jJtOkpC9orfmzABYUIafO6d5hUwvyt1nghtmZ7e2MBPDJbL72uMnBUlQqDKGVkQJbSWLeXnIv2YjADDHovJGlK4ir84v9dk5HRYmERA8BMM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4758
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210609_195512_146051_4C8E7301 
X-CRM114-Status: GOOD (  13.91  )
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

Daniel,

On 6/9/21 19:45, Chaitanya Kulkarni wrote:
> This reverts commit 8872c159c7a83daf633768cee7a7ef7154010341. This is
> needed to move forward with the blktests for now, without this patch
> all the testcases result in the error :-
>
> [ 3502.072798] nvme nvme1: Invalid MNAN value 1024
>
> Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>

Thinking about the code again I think following should work :-

diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 23573fe3fc7d..4277f1554bd5 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -813,7 +813,7 @@ int nvme_mpath_init_identify(struct nvme_ctrl *ctrl,
struct nvme_id_ctrl *id)
            !(ctrl->subsys->cmic & NVME_CTRL_CMIC_ANA))
                return 0;
 
-       if (!ctrl->max_namespaces ||
+       if (ctrl->max_namespaces &&
            ctrl->max_namespaces > le32_to_cpu(id->nn)) {
                dev_err(ctrl->device,
                        "Invalid MNAN value %u\n", ctrl->max_namespaces);
diff --git a/drivers/nvme/target/admin-cmd.c
b/drivers/nvme/target/admin-cmd.c
index cd60a8184d04..a8ec377bb68d 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -394,7 +394,7 @@ static void nvmet_execute_identify_ctrl(struct
nvmet_req *req)
        id->maxcmd = cpu_to_le16(NVMET_MAX_CMD);
 
        id->nn = cpu_to_le32(ctrl->subsys->max_nsid);
-       id->mnan = cpu_to_le32(NVMET_MAX_NAMESPACES);
+       id->mnan = cpu_to_le32(ctrl->subsys->max_nsid);
        id->oncs = cpu_to_le16(NVME_CTRL_ONCS_DSM |
                        NVME_CTRL_ONCS_WRITE_ZEROES);
 

If it does, then we can drop the this revert and I'll send above 2 fixes.

Daniel, can you please confirm ?



_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
