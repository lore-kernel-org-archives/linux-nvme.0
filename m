Return-Path: <SRS0=aHbv=JT=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1197EC433B4
	for <linux-nvme@archiver.kernel.org>; Thu, 22 Apr 2021 18:45:45 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B15861421
	for <linux-nvme@archiver.kernel.org>; Thu, 22 Apr 2021 18:45:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B15861421
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:CC:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=fFpVh9gRFM3/7FF5OyRvyUMUoTm3bSP6VMaWRcAjIRI=; b=E8whUkzFxuRjd2p7FyQaXLwm5
	WytA16q6hVzBSmL3RnIV1YYQsc2os1yHL1vyq5SEqPKUZezgATCb2Tggp0r0SnW7SOVWKcGW1NlqB
	u3JL+x1kyvM8lW26uc3j0hwIpGV4jIqAxHe4fWVWhGc2oWhdXnoF+d7jI40jBnrfLYvePL2Hr6uov
	1Pe97GI08E+2M/vNW35+za9iLKx90f8ZRWIbftQy4Q2lxkGHVVshAOH9VM/muGgdzV1F6bABZGlRw
	QOadO8BbnJQfWS3hGNrbWP0L/TfKPGSuuWcUAmMj5FQOc8U3XMReL85HfpXizfM8zRKVuUTvRGdgF
	IHeFm5LNQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lZeKP-00HGam-CI; Thu, 22 Apr 2021 18:45:29 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lZeKM-00HGad-Ui
 for linux-nvme@desiato.infradead.org; Thu, 22 Apr 2021 18:45:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=MIME-Version:
 Content-Transfer-Encoding:Content-Type:References:Message-ID:Date:Subject:CC:
 To:From:Sender:Reply-To:Content-ID:Content-Description:In-Reply-To;
 bh=ABOels6ZcPwUHvhxTZAU64i5+9jWuHRdLAdMSARORAk=; b=ALaEwMo+UfVtORGBIz9EWmAl29
 PI1myfw3z8jVuLiUhfzRDwgmAzSuWyrf2fr7U0khs+Ge1qyef55YFosY3FynetSTj8OiM7zqOcLwI
 SaNU1bRmm7mObOPZ0t0DLxhFEGiAM0bx9LwSPPRVZwHq8+Xm5qu7xjBbnW2Rm7Os60J8Tn2NytZrW
 G7qY/GPcaFf28wvLpUnhZczyqxCCzA0Y5CIRKWJYG4DaHP3xT4UFKeGma4qralcXe33EfgVVxThDO
 y90WG2rK53DRn3zvfRstQQf+LRN0W0ISoVIBs9ZaJb4HTtH52/Pp/GCj3XcEnV7SJFOpdm0eH4j82
 vMT9UdUw==;
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lZeKK-00DvUi-7s
 for linux-nvme@lists.infradead.org; Thu, 22 Apr 2021 18:45:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1619117124; x=1650653124;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=If+g358FJU25PVt4BQtb7RNERhZQ1T0NjzAcNYomQBo=;
 b=CkoNakBK4GqXo0RdZDN6ZdC6beqETm3sh+TSmHyNWvVAxXrjXHpqmudP
 HjqvICh1H6jjPJ7A6ehJYInplStXTMMb6qDD95elN+7jy7GyLNEnzJx+Q
 a0rD3PzGAnKbREJ9sKmZgSXnPoPdXzaFTT6GCdK1A/VyKlUQ/TkS014BI
 zwEGfnVEMYgI1Ln4dHcu8K2lNlQMuwQLmLuVfyms87MpudnAY+rzvEnkL
 JnuBTZpqRcmBuKiL8oZFDtGZInIIuZ7BMVUpxbhy8D6fN4MT/NEWU8aun
 4CBL3tiYPz7TwSnQtbDvsGrqYnJDjUgZRNPlb0+IyvQPYsu4tKzAR3it+ Q==;
IronPort-SDR: GSRtybZ9DLiCuHcNzj5EHCpQHD/tnYqh5Gf0+3Dlz8ckdBStYToFW0cXP2tNOhQ8cjsvsPj7Zo
 NAn7ie7jK3LXViOPbQvUqRvGpHVqi2FIaJAqM9OtnPlO8j0QSwtABkmvwGLu4Tn0juNRwz1ajr
 kFMPb7H47MVLhe1kcd+4aY8ROPIg2uy6zDWptxDU04NxlZSyX9zWazqD51HXuivW+w1hTMzwX/
 8NGAYeuXeq7BolRxNHcjxIvzOIKWQdNNDVH3XEwd00Gj8ch2i2AuA2AEVrEbXBnIqofcdVew18
 N9A=
X-IronPort-AV: E=Sophos;i="5.82,243,1613404800"; d="scan'208";a="165245741"
Received: from mail-co1nam11lp2174.outbound.protection.outlook.com (HELO
 NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.174])
 by ob1.hgst.iphmx.com with ESMTP; 23 Apr 2021 02:45:23 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mBSF5ryiSS9nX1O0KHVnAoqtrbc43Ps3pcaZlrLDj/p7NhWHiwf23CUcrEk45QUojPBG1XKrCaR6Xf5y7awdTg7sp57WtpFKEpMMLmMrJGTA1RVQNMePtwT6ZaIKXZLDIUYxOHgeLYpxzFhJ3Imvr2xQ2IoSH5PkWhCGNCkvgG9o3FkpXYTBqnehMI8t8HahK5c6CH2XZ1JAn7/L7tsv4wVdG1GoU1dBdAXrgzIvpxbGK0KoMdgM1FlPUNzqxpAwFqY+QN1bk951yBOMGAwnh8KnnWr9EQgwTxSRpnXvMkYa9u8Ida3cYnyzMWJsM5IsKp4uEoLpVhriysYbFRK5yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ABOels6ZcPwUHvhxTZAU64i5+9jWuHRdLAdMSARORAk=;
 b=mnT23a/UCEfvjNcJzFaOHf6pOgf7bvb10D9X0ltXIoNP2av07lTSrY575DUL9rLb6HPzRYtEDO1V6LF2YJ4zuUvauE5Ci/osqlJzpDbbFoyqW5MXU+ERsf9khv0xN/6MyhrT8USL6IVSBcWaFyFBEgoNlfuXZPA+d0kF/QTlThXCW5WT2O1N5kn5FRYoyO9K9wMrskLs35cRySsUmfazBjLfOnvCrsJM8clAhnmDHc/8vIcIhJOZhkCrjLl9Fhm45z6y6Rr/WdjSFEOSjg3muG5JpCNxtGnsnhs+34u92nv8F849AKPURIWU3BO2MFRKSp4sA6H+yx9jg1YEESKiNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ABOels6ZcPwUHvhxTZAU64i5+9jWuHRdLAdMSARORAk=;
 b=wijkQsmAlomAZr8EdJIPttWLy4Upg4As6zSuVlctnFbaU7BO5sxGVUYXRLudOQOt+gnvdQtJdc/fJNxtT+P279snf7wCj+NXEEZj4hr0nztf2Rjui3r3AEKafDJXw6UMfWKsSfnkrNzFsQ8UjCDcJ6ZSj4Wf2vKk2UVfKRIWYHQ=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB5030.namprd04.prod.outlook.com (2603:10b6:a03:47::28)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.21; Thu, 22 Apr
 2021 18:45:22 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::c897:a1f8:197a:706b]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::c897:a1f8:197a:706b%5]) with mapi id 15.20.4042.024; Thu, 22 Apr 2021
 18:45:22 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Kanchan Joshi <joshi.k@samsung.com>
CC: "hch@lst.de" <hch@lst.de>, "kbusch@kernel.org" <kbusch@kernel.org>,
 "axboe@kernel.dk" <axboe@kernel.dk>, "sagi@grimberg.me" <sagi@grimberg.me>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH v2 2/2] nvme: avoid memset for passthrough requests
Thread-Topic: [PATCH v2 2/2] nvme: avoid memset for passthrough requests
Thread-Index: AQHXN3GYdCtgtZrzI0KgTNPNft2VDw==
Date: Thu, 22 Apr 2021 18:45:21 +0000
Message-ID: <BYAPR04MB496535AE19BDE81222C0E0D186469@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20210422115427.63636-1-joshi.k@samsung.com>
 <CGME20210422115548epcas5p319a909cbe43a627aa4a5ad5490fa810e@epcas5p3.samsung.com>
 <20210422115427.63636-3-joshi.k@samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: samsung.com; dkim=none (message not signed)
 header.d=none;samsung.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f763dea0-6afc-461e-624e-08d905bec8c7
x-ms-traffictypediagnostic: BYAPR04MB5030:
x-microsoft-antispam-prvs: <BYAPR04MB50303E1BE191B644E6BAE06B86469@BYAPR04MB5030.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:2958;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VFhAFDWto2ucLn4QE9GU0OnID2jY9Z37a4jqel1bzjKXWMENKjKkcLIANgMcNtBgt5J3ejE7rl6e/WBIS4/ljLDDqOqDif6LtHaTWn8RQV/nDxqVWFfSE1gP/vXckLcw+lg0uKrEsBk1J2z6PbZTfeSVe86SpOmFMGQL9qb4qgXzUjHetRSeXX3LGg7z3F2DtRIgVIgp2bsZfsltIZ0+XpbP0IIgAW7K1ystjguz2Uxs44yGBV71CBZ3/ietp5e7YhZGynnwOjcKtNaPcZIE3bXFWDs1n02C8DiWgLsv4P0xxpuYcNDPVycvFplTjcU338yrq84/kC/tTr63Bu/HNC9K7PJH8k74YZAWNkh0VBVc32h7k01oK+5iGOafgwUh5tmvAkZgY6d3LX/FrOSs1sq8p4StKF8ecjFEsWoIyEDL3b1sKsKowL9HhvGkenGOh8p3zJ9BBCqU3tjXSX+L4xS7dmxIpU9uKaTwsi0ilRTJ2bFPUqlgf9ns3KPxCNCDXqLFUiwWQckSVIJMm+E4wq73/ruHdUzU41Sgk0VGe6VkzM/YyWlH99M0x+xCGMyqb//FTmTGxsiqHL597s0zSaPX1lGDTEl+FMG8MS4LCkE=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(346002)(376002)(136003)(39860400002)(396003)(52536014)(6916009)(33656002)(66446008)(8936002)(558084003)(86362001)(7696005)(316002)(5660300002)(9686003)(55016002)(76116006)(71200400001)(66946007)(64756008)(66556008)(66476007)(38100700002)(186003)(8676002)(4326008)(6506007)(2906002)(478600001)(53546011)(122000001)(54906003)(26005);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?XyU4Wzgk44mOVEhpw2zRB5u0KWSLHeUQrjkfLBiSdzAm4Bmu9nHx4wmhTpEK?=
 =?us-ascii?Q?PhvMKkf5mzoPpnu5CEz8OrnlDxJ3ljuH+atVi3a1Z8nJdd2pBuyfo4Y3sTYl?=
 =?us-ascii?Q?suHZN4XrDvH5nrqmrBDtgo/ormL0MTKdLyt9o2ZseZ0dWr0bb6EufyVeIRQz?=
 =?us-ascii?Q?lZdPGIJwi/oIMvZxw/WZsX+zsailMIzzXJqpL2LuNGSp5GeTvtfmIO5/inh3?=
 =?us-ascii?Q?qWsJ3+7RuRA8UlghIBJtNrFSvKabz9E7aGBcxUi/CIGytimknHuTECP1d+Sh?=
 =?us-ascii?Q?Rlv4ZkngRkt/LaHWFVIVjtPuFLuIV6+0VZ7ov9rkwPcBxC523u3IohJ68mK4?=
 =?us-ascii?Q?OMZisymbt7gclVcy1GlIi74qsKP6MzdUw8SBFFJwIn+zl67A+71VOLW8DJrc?=
 =?us-ascii?Q?2VFghCuz4OJ3KbH1R28M0VzCxm/EvFQkv/Fp6rQoX3+mnOmwiIrZ1cguJIFN?=
 =?us-ascii?Q?VrBRnCub2F//vYy9MmZDvN0caWYSyYawJR79Y+bDoANRG6JJNzAAqTqgacax?=
 =?us-ascii?Q?xWHaBo3FdUiERPaFCHUm45FAEA/s8xHdjUV6IPCxYhZMTetQF0jf/y2lxRyg?=
 =?us-ascii?Q?AFPJPlGKqdWIRJPrzXLR1KY6GJJMBBYp+J4VLIHgYNIkLlhbTdVDIiA8rKzf?=
 =?us-ascii?Q?TVcKF2T4eLhmIYdTJzVrb+gkFTqZKhbVMXHS6eYoVOQirY7ZZ2YAAWEBd7LT?=
 =?us-ascii?Q?8xaipqAsLr3626yWILHHoiGv9COZsLz0FUY5d2IJjBDF5OHrupl750sd30VE?=
 =?us-ascii?Q?CW91TWiO5/67/gCs3/aGsYyHhIcH2/l/kxrquqC4wiaNiLe0s6/Ptx/Wkyxd?=
 =?us-ascii?Q?B7u2G8l+6kjyBAWl4HCh5kOWlbdswAzCSkZrHxK3zaLxa9+cemV/R78HGrdB?=
 =?us-ascii?Q?oV/HC/O3fyIAWvqhxvxhBbYrr51hstDmtKnxMRmu1pFSk2P43IHXXpjoj7Ev?=
 =?us-ascii?Q?f1QD31JVyFsBGHPzO5WNNppfZRJFi+v1BBQi3pddHvVuhhlzmyN8omoaeonU?=
 =?us-ascii?Q?+0QTnkUiadGx+dmK/BcbQ2taAuAdfIqMiAcMDwTBBgFVgU/Kka/g6PJD6a1w?=
 =?us-ascii?Q?pWNHXeZ4rgtTfFX8uV6lxD1bhfzpGWjYv62uKK3vsQFhnSL0fZufADMBu4EQ?=
 =?us-ascii?Q?itOk2pBXdNa+qAWSA1otMt+qyzCf8QbLQjd4cgyKjcTO48IK5gxvh80+im9s?=
 =?us-ascii?Q?GYBOefJ5Tg3wOoT8XNdcRvUux38ljkx5wPmau/OQcBjRqQ0tG/zwd/8emKpT?=
 =?us-ascii?Q?7azN9hfFJnBRMA7Vz9zWgJpuZNipU9fqcA2ISE02CQMOYSTkpR0lKjlTXC7i?=
 =?us-ascii?Q?X6mtdyZpgyudIu7PphY1gyTe?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f763dea0-6afc-461e-624e-08d905bec8c7
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Apr 2021 18:45:21.8351 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3SFSWD/k1/lFKU9uXGSPFW+VnI+fjFS/J+gQBU1AArOq3/iKR4Trq1lfJKRp7UbsxfHA/6JbArZ+bTD3O/YdTiOpdno0sgxT5/k7z1Fjemw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5030
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210422_114524_367768_CDDC4FC5 
X-CRM114-Status: UNSURE (   9.50  )
X-CRM114-Notice: Please train this message.
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

On 4/22/21 05:18, Kanchan Joshi wrote:
> +		memset(cmd, 0, sizeof(struct nvme_command));

The original code uses following :-

-	memset(cmd, 0, sizeof(*cmd));


Let's not change that.



_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
