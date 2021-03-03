Return-Path: <SRS0=PLgZ=IB=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67CA3C433DB
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Mar 2021 14:45:52 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E159E64EE1
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Mar 2021 14:45:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E159E64EE1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:CC:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=qPGR+hXh6AC05QPHQmnVs3qCuBPAiY3megTYM9GI4FA=; b=hF5/Uct87ZpieTIGaAeCFknSU
	tpCEwSBm4M018GtivGzIzqo6rqiRY6Wydn/udYhwTo/G5ZTunDVSHuHLMks4UYn9+0ouVmOKCfrIA
	Im+HT25NPgLYyNg7H4eWAkLVt5S9vjuh3aMfhPE4tCs7615TVaZlU6c6VaEOMWJBdt+00RBYC2chT
	8g2/TjVOmD9mwhuFMSfVu7VozU2IDwK/NMejsb2XmQlcPSWHUyT9mBdyo0YU4dwZn0Ze06bOU8LZ3
	KBYlnBtP551AzbvuJfM0NbZUqpRiSCavg4v0lrbWFfmwRnRf+0hSulodBsv4DjyJtfQurUymcN44L
	3KF+F804Q==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lHSks-005Cb2-DM; Wed, 03 Mar 2021 14:45:38 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lHSAw-0054CL-9F
 for linux-nvme@desiato.infradead.org; Wed, 03 Mar 2021 14:08:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=MIME-Version:Content-Transfer-Encoding:
 Content-Type:References:Message-ID:Date:Subject:CC:To:From:Sender:Reply-To:
 Content-ID:Content-Description:In-Reply-To;
 bh=NLlQJC5dLUFsKG8FEV3jIK91JbxOiIKZyUwm9A2D3XE=; b=bpqsklpyUKuxCxGtkC+oucoN0X
 qMn7eRm4I/uKe86MIhwMjFCeUbCVj9M2ONDv3wGqtJ/2UximFhwvEGhE2Wimsc+o2At56zKr3Z1sE
 AOvgoRGvYt+isRaBflmBvk5FCw87jQgoTEmOLblV1rOh+sQKaZ6iCvD79QAscqsOWmiCsgakiYKs1
 INjIKopBtz7XqNYqPhXfRR6gVrLeb63tfTQ4dwfn0QdPZ6IIxAcuijgLvL1J3lU9C9jPDAoA34o05
 dMeyHtAHIRLWNo1ee+/YWCWRxRl/VaPi9W8WUyTb8g5IFPNaqudoCsOmjnmfsQautRdmAoGNRvvb6
 3nHnSEvA==;
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
 by casper.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lHMJj-001kLO-TY
 for linux-nvme@lists.infradead.org; Wed, 03 Mar 2021 07:53:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1614757992; x=1646293992;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=LPdKwje1OJBtPzVj5Vvoa4x0DoKQGl2ckXgGKUNk0Iw=;
 b=EHID9ljYG+/BFugqltLC5UC6ry2291gUbzWOBeHYhxdCMoP/eQ94OARX
 fZVNjG8EqzZ18vZcjOArQu+HTAdv7SAdZl+5+bGmlLh/4YQ07Hx6/esIa
 1ziaFH41C2W8+8X/a4UQDNqAbnB4qxlVvNcBJ0b4/BaqA1bHgpYweu3mr
 wuTnHoC3TahBnOMJMqYqEm58QPuMc8paDCrxtGDMyweSQMoeRmwF3sfPg
 M9hS2ZYKhXjrT83uH4XXFk7lEcB6tg3uvCj2wUT7adLySKl0yGsCxToOj
 /zEQOVipjvhjygaZ5sVNBwz2ofk5/KA/52EcYaFqK77UcnkNoQdQIBMox Q==;
IronPort-SDR: 0jL64WkUn4Sp646ZbUJR0obbamZQIcoO8MbDu7P8kq3+XihWABmWKQFpXCApk0Kqug6e3Yp1R7
 VdB1r7+/wcCSrSRc9cqqiPZzzmkJXTY69rkqq0IYIQ6dbryTXFXoeWCyujHRZjw+S+nqFjlJ7X
 bImoX0aMIIDVURq4KA2gbDjRO48UCs9m+E6H7GM8XxHNNycKauA9RDxX7lwthSoCMv3ONgv7PT
 CQu5AJQOfQCCz8z5s3EJmUgGW2HesrfNa+8x0+u37anl+jwTcVoxMtUZxsP+EeWwLHgYFPAdKk
 ruE=
X-IronPort-AV: E=Sophos;i="5.81,219,1610380800"; d="scan'208";a="162400658"
Received: from mail-co1nam11lp2175.outbound.protection.outlook.com (HELO
 NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.175])
 by ob1.hgst.iphmx.com with ESMTP; 03 Mar 2021 15:52:06 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X9eyENc3jTyR3RNyh9ETTRxRXI3KXM4HbLC9xdojEd+cXdwkUce3FpE16TieiAqo4l0AZJ9C8Qfo8dyu3hiarQkfFroGYEznhfHmmzXUgmJ30XxTDFQCY74bkiM0AnG4XwqRK/O+E+sTqnW3wVXMdn/5qFcEqiT8sBDL5DMKGXEpVLgNflRbxOoj/zanohaUAzGmEEOvPmsv6/WyXuBd2nYRZ2usY3oITnXU6/gTNbFZFzQow11p5oMfTyyAKKg4F586C+80cQ+uvXu4Slo3SGHZfnhLGaQuNCBthzkU0UZm71hK/WWKwhM3ssf+6Q5g/IQ2QWaCUCenm/3zJhFdzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NLlQJC5dLUFsKG8FEV3jIK91JbxOiIKZyUwm9A2D3XE=;
 b=GZW1MLDbore6ca8KP1bsArGhzBoABeXzfgBJvviVZVjHQC483OREAVyLUc3YK5J+GEY1FZg0nuWI+Qll6GPOkrFZwcIi/UVyEAyjfSdjAmE0Un2ZzUrKYRWU3daWwg3Nd+j9UsWH4c116qkMWlW+b0GHf3WzZejqQwQX87Yxry9m2OCuolQIYe15HoHDM7N/UttNEO91emwkKATx0Gc6/QG7kyNKg27WjXuadOpJ3SGFgwNI/WXbtNVkSrKiGJ+ts1p+JYRlZxcWLcwaSFvH+Gt9M1N3cmJHtm9gSmtbYCNyxa2ulcng69DP3rvHG7ugPQUScrPDRsV+TyqebQA0PA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NLlQJC5dLUFsKG8FEV3jIK91JbxOiIKZyUwm9A2D3XE=;
 b=DUhbUVt6+ShMGrQHtoB7eNI6CeLkCcMfWqsPQbtDbvha0qDYMOTghNKMJFz2HRtbVzxZPeFqwF6eM8daBooQemAHjrSZpOjUSmWR6kEv7duVlQli/+dWkWuwT8Be1rka4TALWyu++6mugY94o5DvGAXqXseeBumoGViLgYuQVow=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB5254.namprd04.prod.outlook.com (2603:10b6:a03:c2::26)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.28; Wed, 3 Mar
 2021 07:52:01 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::c897:a1f8:197a:706b]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::c897:a1f8:197a:706b%5]) with mapi id 15.20.3890.029; Wed, 3 Mar 2021
 07:52:01 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Kanchan Joshi <joshi.k@samsung.com>
CC: "axboe@kernel.dk" <axboe@kernel.dk>, "hch@lst.de" <hch@lst.de>,
 "kbusch@kernel.org" <kbusch@kernel.org>, "io-uring@vger.kernel.org"
 <io-uring@vger.kernel.org>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>, "anuj20.g@samsung.com"
 <anuj20.g@samsung.com>, "javier.gonz@samsung.com" <javier.gonz@samsung.com>
Subject: Re: [RFC 2/3] nvme: passthrough helper with callback
Thread-Topic: [RFC 2/3] nvme: passthrough helper with callback
Thread-Index: AQHXD/4EOPP4CH9isESsU82uWJlGPw==
Date: Wed, 3 Mar 2021 07:52:01 +0000
Message-ID: <BYAPR04MB496566944851825B251CA93686989@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20210302160734.99610-1-joshi.k@samsung.com>
 <CGME20210302161005epcas5p23f28fe21bab5a3e07b9b382dd2406fdc@epcas5p2.samsung.com>
 <20210302160734.99610-3-joshi.k@samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: samsung.com; dkim=none (message not signed)
 header.d=none;samsung.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a8465f80-c233-4f61-4d8d-08d8de193ae7
x-ms-traffictypediagnostic: BYAPR04MB5254:
x-microsoft-antispam-prvs: <BYAPR04MB52548E0E6713A9C145A7FF1786989@BYAPR04MB5254.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 80eEKVWaSFrV+kv1SLg7/kqfx3ozZ+uP2OfWOCXFz3VXqkDCGInTVnO9p4vEXeGKpveRYkLm93l7AYT4rzYHlymv/Ss+5Cv3jytwgx4Zy7L0eUVtJOiaUb9I2qKqhdC9qyIngxzxAAPTNTj8rAQbwHjUkFWNW8fBEFd0+VdZSzqxSSUerj/bDUOJsla59rNwsTH1LO4E2Ga/jzp5YWr5kwxF5Zb3DCtzP3KIOkWsHabShiXgZNC4LK1mh77/RZ3r+PDRNV8ktGLzJT9Wx7Xm5SFdVmEXur1bLcXOjLpyWhdBiYJZjL9a2EGt5NbU4XmSXbmvGWckiysX5Se6bvUNq0nd1TnraO+sdrzGiqmCUBDkI6CFdr3jJRllcavwsLCQFhT7X6ePRQTd1XwOaV7996ICO6yFSGjrUOYC3QBp5hu1Y8IWkBvsvXY3kDLbxQFMPCjE5GVuEzLdI+PM3N5oU6D+fZcXA4j4ofqc0taqAudRtSLkE9txYk6Z58VykXiqMHUZ7GD/mTVJkyTGRDUZrQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(396003)(136003)(376002)(39860400002)(346002)(66946007)(52536014)(54906003)(8676002)(55016002)(66446008)(4326008)(5660300002)(4744005)(64756008)(26005)(76116006)(6916009)(33656002)(316002)(478600001)(8936002)(91956017)(66556008)(66476007)(71200400001)(83380400001)(7696005)(6506007)(9686003)(186003)(2906002)(86362001)(53546011);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?ZbaKr2lX+m7k+xcb+peFp78oNZrPrBcMnxlkheUkNikvHgW4L94uYHomfydJ?=
 =?us-ascii?Q?Ec7MkJlVQpM56ZILrOiyLK8E7JL98oTSgFPoodsX2RJNYZMUiA1AG/bxCVzx?=
 =?us-ascii?Q?5vgnUNjwfuFqGC4WuY8DWjKbNjY++qzzJb0n5N8mu3Xd3MV05swLsC+fQUXg?=
 =?us-ascii?Q?fnXvZi/txHKUPLxltOZzoXOVOU0vGvq1r3CB42+W695IKuF0d0qzRcVUwqmj?=
 =?us-ascii?Q?H4qrVzwTzk3AWvaKnXPiOJOVPkUYOGV39eTzo3vSAJ/D9NjvjeVuFeKYxiik?=
 =?us-ascii?Q?5PCIsQsTpa8YM0dtah8gsIk7OOl04c4qrShTYDDo1dXwnjT4MEgUdzvyGuBA?=
 =?us-ascii?Q?R8u0x7BlXvj8dAx9dTrPFIVYFxkzv009Bq68PFqmTChU3QcFpYjMxkEm1toT?=
 =?us-ascii?Q?DI42tbk4H9gRvHgFByOnA5kHsP8o+sv3QSuub8SQy4evq+QJM+5A4hu+EBYX?=
 =?us-ascii?Q?bxLb4yCmyQ82dYi8WnLAYAxRmpZXJiQVUScXNr8yU0GTIYoMKBB3f0O9dSfH?=
 =?us-ascii?Q?+xMyEUVNOPbYlrEYE3FdNfT5Yl/NoFQMKHyJa8CITnXz4L0Dh1t8rFPenF6+?=
 =?us-ascii?Q?O+ER1BQzDS/s0pRZKElY0XbWranaSrehdHxBb0XBSZnRGSIhQCFyIgbPJc83?=
 =?us-ascii?Q?hEIPd65zaJ1X2CIAhPCYbZifP2z2sIKXSIC4NYiKVYSrDvc4LI4Cduv5eurY?=
 =?us-ascii?Q?oUB2S/4Y0yEVsR0JeMFjrVCF2KJ93VsPNSr+Y8nmDPejCmMWtvYwBxEAXiqc?=
 =?us-ascii?Q?1gwSebTwjSox+9zRuz+JKZ5wCwcF2cWHxGZU/VMFNikayxTu9U4kSWUZWPo/?=
 =?us-ascii?Q?3qwRQgLdGraUeFyyO8/4vhJyxju7Yg1O0o7kpfnRpQFIjztUhjMSVI26t8xa?=
 =?us-ascii?Q?C+Nne0SSkCDVH+bR+gs63QcjjYP/g1zGKbbAIcThOk9s6wshlkViulrXXlUn?=
 =?us-ascii?Q?8uMouu7M5AWEjIlqJbYvByfegVgCjomlDBaHfM5WlBT9PLZA0UOPUHOZX2fY?=
 =?us-ascii?Q?TRq39qL1KFRqvtk8smv2jdF87R7PVZrMVQruNvdPcZW57Iemp4E+VGIKXzmt?=
 =?us-ascii?Q?1MEmAIHuowLjgWsdESX6Xx/V0S+1xkQmCT4xKf75Sz013FUJAWPicHrRuXAr?=
 =?us-ascii?Q?WuDMYZpSfXquomkvHDBVNWMeFnyRL9BPeIznkUsfFTyJOq4rO8n4EsAncvqm?=
 =?us-ascii?Q?RuTF86nguZZxMcg6tSfa50l6CtiEgM2Jv24KHVAna5jI4L8GlaYGWABbyWP9?=
 =?us-ascii?Q?8gGZuYgRL8VJilGo4Cg5e7VE2f6VP3dKVCXqCP+AsmPgAKYgOPIKIl1BaE4l?=
 =?us-ascii?Q?/62kdxWZrJsI+BnMsnnlQuA/?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8465f80-c233-4f61-4d8d-08d8de193ae7
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2021 07:52:01.5531 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Pf2XWMN9ngjrqb53MO+BM1tpeu5yov7DD3hVSCPJXBzz8bt/2Yp3e/tsmCc9hKq6D+2bNICtFcc1hGKUELAM7EiUI/TirftRUYJOA2GopJg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5254
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210303_075313_851424_8B821612 
X-CRM114-Status: GOOD (  10.18  )
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

On 3/2/21 23:22, Kanchan Joshi wrote:
> -void nvme_execute_passthru_rq(struct request *rq)
> +void nvme_execute_passthru_rq_common(struct request *rq,
> +			rq_end_io_fn *done)
>  {
>  	struct nvme_command *cmd = nvme_req(rq)->cmd;
>  	struct nvme_ctrl *ctrl = nvme_req(rq)->ctrl;
> @@ -1135,9 +1136,17 @@ void nvme_execute_passthru_rq(struct request *rq)
>  	u32 effects;
>  
>  	effects = nvme_passthru_start(ctrl, ns, cmd->common.opcode);
> -	blk_execute_rq(disk, rq, 0);
> +	if (!done)
> +		blk_execute_rq(disk, rq, 0);
> +	else
> +		blk_execute_rq_nowait(disk, rq, 0, done);
>  	nvme_passthru_end(ctrl, effects);

This needs a detailed explanation in order to prove the correctness.



_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
