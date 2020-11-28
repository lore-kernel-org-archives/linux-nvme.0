Return-Path: <SRS0=7R1c=FC=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E559C3E8C5
	for <linux-nvme@archiver.kernel.org>; Sat, 28 Nov 2020 00:10:37 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D80F2223F
	for <linux-nvme@archiver.kernel.org>; Sat, 28 Nov 2020 00:10:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="OeDkZgsT";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="NQ6yZnPp";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="T8n7nBLX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D80F2223F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=bx3V0XyfhN34ZAaF3feffCpizH5zYN9ugRl95PJ9LOY=; b=OeDkZgsTGZ4sESCLGYoqInRDF
	lR4/qiA7H+ub7XWySRBps6JveZJJ/FdCVJCNS8BeprAvvRig0U2MBKdDOdY1e9yjhF6ezhehYn333
	tKPQxjLcp+AQ0y7xJkyu2VGXIlWSpVbUMFQgPD6Q9g/955cvDBJGoQx1FAF7EH+V2bFplwpLvmqsh
	tSYd/bhdY5PYXSFAagHZp+Fkbgq4DBf9uUumxWn83IshvjC/igCnLuDviRwiYJ76X5nLqUe/frPWd
	90rXGhlDLeiY0LkTqYXgEAqVqjiuDZq635ckDaoGBzrLxmGn2h3KdUjjTdPxxwP2RLCs2ocQPzT7v
	xtXVfzIfg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kinok-0005nA-AE; Sat, 28 Nov 2020 00:10:22 +0000
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kinoR-0005mZ-RN
 for linux-nvme@lists.infradead.org; Sat, 28 Nov 2020 00:10:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1606522203; x=1638058203;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=Nau03cvAANJ1GQsQQSr5RhqfErukP4WCAhPiDMwxnBU=;
 b=NQ6yZnPpM2FnQwVl3bUXG+sjVSjXqbYXs8sWsSWOQM5clvSuckJnWSUM
 bNListHxnGA33/eHcPRDprVCwwC7+gPPCMHz/XwO+w6mUqy4VUaavCMBA
 BAZt5hNiX+jGTmQlCzA9Hi+YXBH6PgmhAXqOiwo1BTJlyK2oP9csPtLph
 uv3MYg8Pe6D6Z9OdF1Xk6Yo9ET1WlcSTo2Rvm3Z9Rk/FL27HVKASYtPYZ
 V+ezLhoGQ/LX+3HRfhvlRsVnwEsg7RrZUv56AsbkqeMpbL6C/7W9Mccv6
 hLKESs/Ol3WxW9ffO/prB/ySvmrzQvPZU6oPhjCsCbfM9yArxT8RMh7Hw w==;
IronPort-SDR: DFxbxDXG3MGTx0pjiwIdWb/B8z5axrrfs3qosIbwwfSRvksfvpgqMyqSBtSWbL2PxddkhJCgKO
 mstsAsI+2OEgeNnR/+xtendwMARro1NzbKyWk5hYk07S0qQl/xq1QvFOGk0TxUDMZ2iWVRPQCB
 hWQ3KEsCN7Jdb4rhV4SJFNmtg+6XNmXlddQcRhdJBB/WaguLujX7eiIpTq9185cVWpk8cMkLw+
 mDBRJ9S+E0Szm6rWp5/QNcovhpjzoSlNc4Umg8rBpjZZSUAPwxYJx0ZC3pVVEXYfMyFQzLHWil
 NE0=
X-IronPort-AV: E=Sophos;i="5.78,376,1599494400"; d="scan'208";a="153616516"
Received: from mail-mw2nam12lp2046.outbound.protection.outlook.com (HELO
 NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.46])
 by ob1.hgst.iphmx.com with ESMTP; 28 Nov 2020 08:09:59 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NrUcYCwx2CIM8rNMhYi6+SDS/DZUELyFgDdZ/Px5I61xwtU045woEOx93N8BsU1XO+F26vQzQOwvN392BV4AGrDGCR1DwnYCtDyF2QSvUN9ACMOfj/DE4pB2NuTrAAt+7LBnQe8kYQZ5Mv+k5RA8EzLZlvNI/Drvxi+4KpJ7bXa3XqVrgA8e9wpXAYAVJnRsLfACO8ctd0hvj16etTmluUPG/6ZraXuTKO63vTa67oTzAjEW2uVjMVw3+GFNJppmem5mmvsBchWb3TAEGNyIi7aiUv0tcH3CjAIq4qp0ew1+tM+z+0IkTo2OS9jO6XrslCcNoaGj3i+IAO9edfBIRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=39hFq/zLVu8MKQ2p1DrxbSIUN9mA/Ndcq04dVo5ZY7Y=;
 b=FIKZigQxNv5jiJJLwBZ+DmpX1aeP8lh0jgTcTGBgDxOiBAbHoakVpa1GigYdxt3+WxjfeAD+Xt4WvnLa0cTh/5q2qqCuSZb7TiMIXju7yE08a3ytYiR4/VH+C2JvkqLR4Mb0g/a7AwUtawzdnVt+fu6RMPA4Iw38vFxInQ2scRcoyKaojKtjD1qEuiPi49VY9W687w4gEsvb64FYQydsNCrEnptE6fxG2+vszkVvmWNVFrk3qZ/W7FcQ5hPQmyWCsP8KtviYzWhECy2aaf1rOc3H+JEEJwMi3dse8bF1wXRVSvoRSU3W3EimSBPBCsqllNHzf4AsjtdlGQSal89wpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=39hFq/zLVu8MKQ2p1DrxbSIUN9mA/Ndcq04dVo5ZY7Y=;
 b=T8n7nBLXrksfP1g1e/JSDlN6zgIsQZ0cq9SPV4PTbopOxPS93xEaksL+b8AnRBtj9d6ZuIuBRgCWd1HghA6Z/Kh5FfWmF6y2/NEWD7KFkEXOmS6pbZ96VR1AOhJkI9BjY0rpLlFwXxIjjP2jKFk/oKMlQxV5piO4ZsXXix1yO7Y=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB6024.namprd04.prod.outlook.com (2603:10b6:a03:e8::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.20; Sat, 28 Nov
 2020 00:09:57 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::99ae:ab95:7c27:99e4]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::99ae:ab95:7c27:99e4%7]) with mapi id 15.20.3589.032; Sat, 28 Nov 2020
 00:09:57 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Damien Le Moal <Damien.LeMoal@wdc.com>, "linux-block@vger.kernel.org"
 <linux-block@vger.kernel.org>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH 2/9] nvmet: add ZNS support for bdev-ns
Thread-Topic: [PATCH 2/9] nvmet: add ZNS support for bdev-ns
Thread-Index: AQHWw52duufaENKY4kqG/18TG9QkOg==
Date: Sat, 28 Nov 2020 00:09:57 +0000
Message-ID: <BYAPR04MB49652ACED79DDFA79DF00C7E86F70@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20201126024043.3392-1-chaitanya.kulkarni@wdc.com>
 <20201126024043.3392-3-chaitanya.kulkarni@wdc.com>
 <CH2PR04MB6522298714A02E18D356081CE7F90@CH2PR04MB6522.namprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1dbe8f5f-8cf2-4d2f-450d-08d89331f0b8
x-ms-traffictypediagnostic: BYAPR04MB6024:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR04MB6024AA82F3669F8BA7EF575B86F70@BYAPR04MB6024.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fVRFjBpQTe0qidtbsJWXMarYTl0z77rIr1VJv4R/vp6g2FomjXDz/9pE2LvCb+lRcyl3Th4TMKte12kPW/StSRpmQdy0ZDugVZZzlwvfJp3av5smlXS3XwTNWyymzRxygoVY6D/xt175UogIe8AfUqFsDTjpJqB5gpbtRSSeSaCxs/IyuoOYRlpzafVKMsb26+CO2wYh3Od6D7JvUIzj2QF/fSEbRKdG0t4hijDrXTfDktNZtvEhcD1cYwSzOKnmcp7bfA5tMSFoF/ImzcGtJdZN650wjD0BDw9koLkjqXSaSM2NabNsBXRoH4UxoMNCyeka7De2th4JKjWgE5i5pg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(366004)(39860400002)(376002)(136003)(396003)(5660300002)(52536014)(7696005)(9686003)(8936002)(4326008)(30864003)(55016002)(86362001)(6506007)(53546011)(316002)(110136005)(478600001)(83380400001)(26005)(33656002)(71200400001)(2906002)(66946007)(8676002)(66556008)(66446008)(186003)(64756008)(76116006)(66476007)(54906003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?vBrG3oLQgpwAvSo3DGFw42qMQAnPhVLJJS+4xiyCD4JlreJrInWj903alSxb?=
 =?us-ascii?Q?CeOTOhbnw858zH1vHpqYBbGowHdgjlLXIj2VK/Vc3htvUqtlWDxzQI6pFBYy?=
 =?us-ascii?Q?cc3P0RGf8C2qKhvJE3i0i47maI2fPrE/AArJr7HBDky6F48OOySuNqiUQAGh?=
 =?us-ascii?Q?kpAudZquc0Hbe6SboYMLLGsUW4d0sG2tgv4tJs074e4AQAywXeG75PebA/4w?=
 =?us-ascii?Q?xG+AJvolQuiUfdBXr5n1sCxMbl/qghrHAhK+xP+kxTRgdleP2zt1s+tjSDv4?=
 =?us-ascii?Q?dUwudYXq+sF2yxFDwxuAZ7yRs3mkUTVJ+o6LGjiKFIst6qDTIA2Yhhj6bsZ4?=
 =?us-ascii?Q?2ApnRPZRR7YFzI+wEwcdLWIub15uwnz+fT9vIZj1ybqAmTqc2hCb2HBuk4aQ?=
 =?us-ascii?Q?Rgtgs2nXEJ7+MZbAgCoZUR4wwZRM7G9RjQt+ehqWhsbUOYcTeADCblTR9Hm8?=
 =?us-ascii?Q?5lhrV/uGNAZBYWB1I3NjyAH627NTou7TPXGAOPPB4jrTy+3bJMeEwdBYx26y?=
 =?us-ascii?Q?B5B7nnv8bB7++ICzviQ4669J++Ties4vZVPAyLdQ1EpVjV3UCF9F64RBUjvo?=
 =?us-ascii?Q?O0W7Oz2L07ZWOKfDYvKJkmYLJdsaqB8meVivhJlaoApnYjiO6FOqdAl/V3Bp?=
 =?us-ascii?Q?QatxDw5VriD0arOxA6XQULOFgiZfhd+Jjdhnld72LXO2jfxLrGcvwBBU0Lc9?=
 =?us-ascii?Q?AbI4PnjGWvVQY3hPSxEUlwXf8aLUs91hPOA4lXQ0NDGQjEW7tx/koq95LGxT?=
 =?us-ascii?Q?YmTdNVbcvpW/+cH5q24IaJB/SjAZkjYv66K4vXScINkDXI4qSeSh/GDexgZ5?=
 =?us-ascii?Q?gU/uLFjbJg03Nu35dt3F+CgoCcnZu/CkqqcVAzskTK5ERc+9KjEuFBayZqND?=
 =?us-ascii?Q?qQkuWAVCesHIvhuv9/vgqNAgh1NWHeFejOdD31uXbwPkk4tTrfX22OL0nddq?=
 =?us-ascii?Q?psOXV0DRhMahYpIoKgoeifbLUYn/bVn/JPaxA4uXt+dHrr1fL01+oyA1Fkzi?=
 =?us-ascii?Q?gyQO?=
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1dbe8f5f-8cf2-4d2f-450d-08d89331f0b8
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Nov 2020 00:09:57.3044 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9UaYG7F5j0OTr2eplhyvp9iR3Y8s3y3LLfIPkJ00Bes25VJE4ojDszC+5/Weq/dnPMu/kswsfJKZ2OLwibzIzn+OqA1C15HJ/5Xf+qjTAfE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB6024
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201127_191004_298134_2982A1D8 
X-CRM114-Status: GOOD (  19.68  )
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
Cc: "sagi@grimberg.me" <sagi@grimberg.me>, "hch@lst.de" <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 11/26/20 00:36, Damien Le Moal wrote:
> On 2020/11/26 11:42, Chaitanya Kulkarni wrote:
>> Add zns-bdev-config, id-ctrl, id-ns, zns-cmd-effects, zone-mgmt-send,
>> zone-mgmt-recv and zone-append handlers for NVMeOF target to enable ZNS
>> support for bdev.
>>
>> Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
>> ---
>>  drivers/nvme/target/Makefile      |   2 +
>>  drivers/nvme/target/admin-cmd.c   |   4 +-
>>  drivers/nvme/target/io-cmd-file.c |   2 +-
>>  drivers/nvme/target/nvmet.h       |  18 ++
>>  drivers/nvme/target/zns.c         | 390 ++++++++++++++++++++++++++++++
>>  5 files changed, 413 insertions(+), 3 deletions(-)
>>  create mode 100644 drivers/nvme/target/zns.c
>>
>> diff --git a/drivers/nvme/target/Makefile b/drivers/nvme/target/Makefile
>> index ebf91fc4c72e..bc147ff2df5d 100644
>> --- a/drivers/nvme/target/Makefile
>> +++ b/drivers/nvme/target/Makefile
>> @@ -12,6 +12,8 @@ obj-$(CONFIG_NVME_TARGET_TCP)		+= nvmet-tcp.o
>>  nvmet-y		+= core.o configfs.o admin-cmd.o fabrics-cmd.o \
>>  			discovery.o io-cmd-file.o io-cmd-bdev.o
>>  nvmet-$(CONFIG_NVME_TARGET_PASSTHRU)	+= passthru.o
>> +nvmet-$(CONFIG_BLK_DEV_ZONED)		+= zns.o
>> +
>>  nvme-loop-y	+= loop.o
>>  nvmet-rdma-y	+= rdma.o
>>  nvmet-fc-y	+= fc.o
>> diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
>> index dca34489a1dc..509fd8dcca0c 100644
>> --- a/drivers/nvme/target/admin-cmd.c
>> +++ b/drivers/nvme/target/admin-cmd.c
>> @@ -579,8 +579,8 @@ static void nvmet_execute_identify_nslist(struct nvmet_req *req)
>>  	nvmet_req_complete(req, status);
>>  }
>>  
>> -static u16 nvmet_copy_ns_identifier(struct nvmet_req *req, u8 type, u8 len,
>> -				    void *id, off_t *off)
>> +u16 nvmet_copy_ns_identifier(struct nvmet_req *req, u8 type, u8 len,
>> +			     void *id, off_t *off)
>>  {
>>  	struct nvme_ns_id_desc desc = {
>>  		.nidt = type,
>> diff --git a/drivers/nvme/target/io-cmd-file.c b/drivers/nvme/target/io-cmd-file.c
>> index 0abbefd9925e..2bd10960fa50 100644
>> --- a/drivers/nvme/target/io-cmd-file.c
>> +++ b/drivers/nvme/target/io-cmd-file.c
>> @@ -89,7 +89,7 @@ int nvmet_file_ns_enable(struct nvmet_ns *ns)
>>  	return ret;
>>  }
>>  
>> -static void nvmet_file_init_bvec(struct bio_vec *bv, struct scatterlist *sg)
>> +void nvmet_file_init_bvec(struct bio_vec *bv, struct scatterlist *sg)
>>  {
>>  	bv->bv_page = sg_page(sg);
>>  	bv->bv_offset = sg->offset;
>> diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
>> index 592763732065..0542ba672a31 100644
>> --- a/drivers/nvme/target/nvmet.h
>> +++ b/drivers/nvme/target/nvmet.h
>> @@ -81,6 +81,9 @@ struct nvmet_ns {
>>  	struct pci_dev		*p2p_dev;
>>  	int			pi_type;
>>  	int			metadata_size;
>> +#ifdef CONFIG_BLK_DEV_ZONED
>> +	struct nvme_id_ns_zns	id_zns;
>> +#endif
>>  };
>>  
>>  static inline struct nvmet_ns *to_nvmet_ns(struct config_item *item)
>> @@ -251,6 +254,10 @@ struct nvmet_subsys {
>>  	unsigned int		admin_timeout;
>>  	unsigned int		io_timeout;
>>  #endif /* CONFIG_NVME_TARGET_PASSTHRU */
>> +
>> +#ifdef CONFIG_BLK_DEV_ZONED
>> +	struct nvme_id_ctrl_zns	id_ctrl_zns;
>> +#endif
>>  };
>>  
>>  static inline struct nvmet_subsys *to_subsys(struct config_item *item)
>> @@ -603,4 +610,15 @@ static inline bool nvmet_ns_has_pi(struct nvmet_ns *ns)
>>  	return ns->pi_type && ns->metadata_size == sizeof(struct t10_pi_tuple);
>>  }
>>  
>> +void nvmet_execute_identify_cns_cs_ctrl(struct nvmet_req *req);
>> +void nvmet_execute_identify_cns_cs_ns(struct nvmet_req *req);
>> +u16 nvmet_process_zns_cis(struct nvmet_req *req, off_t *off);
>> +bool nvmet_bdev_zns_config(struct nvmet_ns *ns);
>> +void nvmet_bdev_execute_zone_mgmt_recv(struct nvmet_req *req);
>> +void nvmet_bdev_execute_zone_mgmt_send(struct nvmet_req *req);
>> +void nvmet_bdev_execute_zone_append(struct nvmet_req *req);
>> +void nvmet_zns_add_cmd_effects(struct nvme_effects_log *log);
>> +u16 nvmet_copy_ns_identifier(struct nvmet_req *req, u8 type, u8 len,
>> +			     void *id, off_t *off);
>> +void nvmet_file_init_bvec(struct bio_vec *bv, struct scatterlist *sg);
>>  #endif /* _NVMET_H */
>> diff --git a/drivers/nvme/target/zns.c b/drivers/nvme/target/zns.c
>> new file mode 100644
>> index 000000000000..8ea6641a55e3
>> --- /dev/null
>> +++ b/drivers/nvme/target/zns.c
>> @@ -0,0 +1,390 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * NVMe ZNS-ZBD command implementation.
>> + * Copyright (c) 2020-2021 HGST, a Western Digital Company.
>> + */
>> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
>> +#include <linux/uio.h>
>> +#include <linux/nvme.h>
>> +#include <linux/blkdev.h>
>> +#include <linux/module.h>
>> +#include "nvmet.h"
>> +
>> +#ifdef CONFIG_BLK_DEV_ZONED
> This file is compiled only if CONFIG_BLK_DEV_ZONED is defined, so what is the
> point of this ? The stubs for the !CONFIG_BLK_DEV_ZONED case should go into the
> header file, no ?

Actually the conditional compilation of zns.c with CONFIG_BLK_DEV_ZONED

needs to be removed in the Makefile. I'm against putting these empty
stubs in the

makefile when CONFIG_BLK_DEV_ZONED is not true, as there are several files

transport, discovery, file/passthru backend etc in the nvme/target/*.c
which will add

empty stubs which has nothing to do with zoned bdev backend.

i.e. for Makefile it should be :-

diff --git a/drivers/nvme/target/Makefile b/drivers/nvme/target/Makefile
index ebf91fc4c72e..c67276a25363 100644
--- a/drivers/nvme/target/Makefile
+++ b/drivers/nvme/target/Makefile
@@ -10,7 +10,7 @@ obj-$(CONFIG_NVME_TARGET_FCLOOP)      += nvme-fcloop.o
 obj-$(CONFIG_NVME_TARGET_TCP)          += nvmet-tcp.o
 
 nvmet-y                += core.o configfs.o admin-cmd.o fabrics-cmd.o \
-                       discovery.o io-cmd-file.o io-cmd-bdev.o
+                       zns,o discovery.o io-cmd-file.o io-cmd-bdev.o
 nvmet-$(CONFIG_NVME_TARGET_PASSTHRU)   += passthru.o
 nvme-loop-y    += loop.o
 nvmet-rdma-y   += rdma.o

>> +
>> +static u16 nvmet_bdev_zns_checks(struct nvmet_req *req)
>> +{
>> +	u16 status = 0;
>> +
>> +	if (!bdev_is_zoned(req->ns->bdev)) {
>> +		status = NVME_SC_INVALID_NS | NVME_SC_DNR;
>> +		goto out;
> Why not return status directly here ? Same for the other cases below.
I prefer centralize returns with goto, which follows the similar code.
>> +	}
>> +
>> +	if (req->cmd->zmr.zra != NVME_ZRA_ZONE_REPORT) {
>> +		status = NVME_SC_INVALID_FIELD;
>> +		goto out;
>> +	}
>> +
>> +	if (req->cmd->zmr.zrasf != NVME_ZRASF_ZONE_REPORT_ALL) {
>> +		status = NVME_SC_INVALID_FIELD;
>> +		goto out;
>> +	}
>> +
>> +	if (req->cmd->zmr.pr != NVME_REPORT_ZONE_PARTIAL)
>> +		status = NVME_SC_INVALID_FIELD;
>> +out:
>> +	return status;
>> +}
>> +
>> +static struct block_device *nvmet_bdev(struct nvmet_req *req)
>> +{
>> +	return req->ns->bdev;
>> +}
>> +
>> +static u64 nvmet_zones_to_descsize(unsigned int nr_zones)
>> +{
>> +	return sizeof(struct nvme_zone_report) +
>> +		(sizeof(struct nvme_zone_descriptor) * nr_zones);
>> +}
> These could be declared as inline.
>
Okay.
>> +
>> +static inline u64 nvmet_sect_to_lba(struct nvmet_ns *ns, sector_t sect)
>> +{
>> +	return sect >> (ns->blksize_shift - SECTOR_SHIFT);
>> +}
>> +
>> +static inline sector_t nvmet_lba_to_sect(struct nvmet_ns *ns, __le64 lba)
>> +{
>> +	return le64_to_cpu(lba) << (ns->blksize_shift - SECTOR_SHIFT);
>> +}
>> +
>> +/*
>> + *  ZNS related command implementation and helprs.
> s/helprs/helpers
Okay.
>
>> + */
>> +
>> +u16 nvmet_process_zns_cis(struct nvmet_req *req, off_t *off)
>> +{
>> +	u16 nvme_cis_zns = NVME_CSI_ZNS;
>> +
>> +	if (bdev_is_zoned(nvmet_bdev(req))) {
>> +		return nvmet_copy_ns_identifier(req, NVME_NIDT_CSI,
>> +						 NVME_NIDT_CSI_LEN,
>> +						 &nvme_cis_zns, off);
>> +	}
> No need for the curly brackets.
Okay.
>> +
>> +	return NVME_SC_SUCCESS;
>> +}
>> +
>> +void nvmet_zns_add_cmd_effects(struct nvme_effects_log *log)
>> +{
>> +	log->iocs[nvme_cmd_zone_append]		= cpu_to_le32(1 << 0);
>> +	log->iocs[nvme_cmd_zone_mgmt_send]	= cpu_to_le32(1 << 0);
>> +	log->iocs[nvme_cmd_zone_mgmt_recv]	= cpu_to_le32(1 << 0);
>> +}
>> +
>> +bool nvmet_bdev_zns_config(struct nvmet_ns *ns)
>> +{
>> +	if (ns->bdev->bd_disk->queue->conv_zones_bitmap) {
>> +		pr_err("block device with conventional zones not supported.");
> pr_err("block devices with conventional zones are not supported.");
>
> With SMR drives, the last zone of the disk can be smaller than the other zones.
> That needs to be checked too as that is not allowed by ZNS. Drives with a last
> smaller runt zone cannot be allowed.
Okay.
>> +		return false;
>> +	}
>> +	/*
>> +	 * SMR drives will results in error if writes are not aligned to the
>> +	 * physical block size just override.
>> +	 */
> 	/*
> 	 * For ZBC and ZAC devices, writes into sequential zones must be aligned
> 	 * to the device physical block size. So use this value as the logical
> 	 * block size to avoid errors.
> 	 */
Okay.
>> +	ns->blksize_shift = blksize_bits(bdev_physical_block_size(ns->bdev));
>> +	return true;
>> +}
>> +
>> +static int nvmet_bdev_report_zone_cb(struct blk_zone *zone, unsigned int idx,
>> +				     void *data)
>> +{
>> +	struct blk_zone *zones = data;
>> +
>> +	memcpy(&zones[idx], zone, sizeof(struct blk_zone));
>> +
>> +	return 0;
>> +}
>> +
>> +static void nvmet_get_zone_desc(struct nvmet_ns *ns, struct blk_zone *z,
>> +				struct nvme_zone_descriptor *rz)
>> +{
>> +	rz->zcap = cpu_to_le64(nvmet_sect_to_lba(ns, z->capacity));
>> +	rz->zslba = cpu_to_le64(nvmet_sect_to_lba(ns, z->start));
>> +	rz->wp = cpu_to_le64(nvmet_sect_to_lba(ns, z->wp));
>> +	rz->za = z->reset ? 1 << 2 : 0;
>> +	rz->zt = z->type;
>> +	rz->zs = z->cond << 4;
>> +}
>> +
>> +/*
>> + * ZNS related Admin and I/O command handlers.
>> + */
>> +void nvmet_execute_identify_cns_cs_ctrl(struct nvmet_req *req)
>> +{
>> +	struct nvme_id_ctrl_zns *id;
>> +	u16 status = 0;
>> +
>> +	id = kzalloc(sizeof(*id), GFP_KERNEL);
>> +	if (!id) {
>> +		status = NVME_SC_INTERNAL;
>> +		goto out;
>> +	}
>> +
>> +	/*
>> +	 * Even though this function sets Zone Append Size Limit to 0,
>> +	 * the 0 value here indicates that the maximum data transfer size for
>> +	 * the Zone Append command is indicated by the ctrl
>> +	 * Maximum Data Transfer Size (MDTS).
> But the target drive may have different values for max zone append sectors and
> max_hw_sectors/max_sectors. So I think this needs finer handling.
I think we can getaway with the

min(mdts, min(max_zone_append_sectors/max_hw_sectors), let me see.

>> +	 */
>> +	id->zasl = 0;
>> +
>> +	status = nvmet_copy_to_sgl(req, 0, id, sizeof(*id));
>> +
>> +	kfree(id);
>> +out:
>> +	nvmet_req_complete(req, status);
>> +}
>> +
>> +void nvmet_execute_identify_cns_cs_ns(struct nvmet_req *req)
>> +{
>> +	struct nvme_id_ns_zns *id_zns;
>> +	u16 status = 0;
>> +	u64 zsze;
>> +
>> +	if (le32_to_cpu(req->cmd->identify.nsid) == NVME_NSID_ALL) {
>> +		req->error_loc = offsetof(struct nvme_identify, nsid);
>> +		status = NVME_SC_INVALID_NS | NVME_SC_DNR;
>> +		goto out;
>> +	}
>> +
>> +	id_zns = kzalloc(sizeof(*id_zns), GFP_KERNEL);
>> +	if (!id_zns) {
>> +		status = NVME_SC_INTERNAL;
>> +		goto out;
>> +	}
>> +
>> +	req->ns = nvmet_find_namespace(req->sq->ctrl, req->cmd->identify.nsid);
>> +	if (!req->ns) {
>> +		status = NVME_SC_INTERNAL;
>> +		goto done;
> That will result in nvmet_copy_to_sgl() being executed. Is that OK ?
> Shouldn't you do only the kfree(id_zns) and complete with an error here ?
Call to nvmet_copy_to_sgl() zeroout the values if any when we return the

buffer in case of error. I don't see any problem with zeroing out buffer in

case of error. Can you please explain why we shouldn't do that ?

>> +	}
>> +
>> +	if (!bdev_is_zoned(nvmet_bdev(req))) {
>> +		req->error_loc = offsetof(struct nvme_identify, nsid);
>> +		status = NVME_SC_INVALID_NS | NVME_SC_DNR;
>> +		goto done;
> Same comment.
See above reply.
>> +	}
>> +
>> +	nvmet_ns_revalidate(req->ns);
>> +	zsze = (bdev_zone_sectors(nvmet_bdev(req)) << 9) >>
>> +					req->ns->blksize_shift;
>> +	id_zns->lbafe[0].zsze = cpu_to_le64(zsze);
>> +	id_zns->mor = cpu_to_le32(bdev_max_open_zones(nvmet_bdev(req)));
>> +	id_zns->mar = cpu_to_le32(bdev_max_active_zones(nvmet_bdev(req)));
>> +
>> +done:
>> +	status = nvmet_copy_to_sgl(req, 0, id_zns, sizeof(*id_zns));
>> +	kfree(id_zns);
>> +out:
>> +	nvmet_req_complete(req, status);
>> +}
>> +
>> +void nvmet_bdev_execute_zone_mgmt_recv(struct nvmet_req *req)
>> +{
>> +	struct request_queue *q = nvmet_bdev(req)->bd_disk->queue;
>> +	struct nvme_zone_mgmt_recv_cmd *zmr = &req->cmd->zmr;
>> +	unsigned int nz = blk_queue_nr_zones(q);
>> +	u64 bufsize = (zmr->numd << 2) + 1;
>> +	struct nvme_zone_report *rz;
>> +	struct blk_zone *zones;
>> +	int reported_zones;
>> +	sector_t sect;
>> +	u64 desc_size;
>> +	u16 status;
>> +	int i;
>> +
>> +	desc_size = nvmet_zones_to_descsize(blk_queue_nr_zones(q));
>> +	status = nvmet_bdev_zns_checks(req);
>> +	if (status)
>> +		goto out;
>> +
>> +	zones = kvcalloc(blkdev_nr_zones(nvmet_bdev(req)->bd_disk),
>> +			      sizeof(struct blk_zone), GFP_KERNEL);
> This is not super nice: a large disk will have an enormous number of zones
> (75000+ for largest SMR HDD today). But you actually do not need more zones
> descs than what fits in req buffer.
Call to nvmet_copy_to_sgl() nicely fail and return error.
>> +	if (!zones) {
>> +		status = NVME_SC_INTERNAL;
>> +		goto out;
>> +	}
>> +
>> +	rz = __vmalloc(bufsize, GFP_KERNEL | __GFP_NORETRY);
>> +	if (!rz) {
>> +		status = NVME_SC_INTERNAL;
>> +		goto out_free_zones;
>> +	}
>> +
>> +	sect = nvmet_lba_to_sect(req->ns, le64_to_cpu(req->cmd->zmr.slba));
>> +
>> +	for (nz = blk_queue_nr_zones(q); desc_size >= bufsize; nz--)
>> +		desc_size = nvmet_zones_to_descsize(nz);
>> +
>> +	reported_zones = blkdev_report_zones(nvmet_bdev(req), sect, nz,
>> +					     nvmet_bdev_report_zone_cb,
>> +					     zones);
>> +	if (reported_zones < 0) {
>> +		status = NVME_SC_INTERNAL;
>> +		goto out_free_report_zones;
>> +	}
>> +
>> +	rz->nr_zones = cpu_to_le64(reported_zones);
>> +	for (i = 0; i < reported_zones; i++)
>> +		nvmet_get_zone_desc(req->ns, &zones[i], &rz->entries[i]);
> This can be done directly in the report zones cb. That will avoid looping twice
> over the reported zones.
Okay, I'll try and remove this loop.
>> +
>> +	status = nvmet_copy_to_sgl(req, 0, rz, bufsize);
>> +
>> +out_free_report_zones:
>> +	kvfree(rz);
>> +out_free_zones:
>> +	kvfree(zones);
>> +out:
>> +	nvmet_req_complete(req, status);
>> +}
>> +
>> +void nvmet_bdev_execute_zone_mgmt_send(struct nvmet_req *req)
>> +{
>> +	sector_t nr_sect = bdev_zone_sectors(nvmet_bdev(req));
>> +	struct nvme_zone_mgmt_send_cmd *c = &req->cmd->zms;
>> +	u16 status = NVME_SC_SUCCESS;
>> +	enum req_opf op;
>> +	sector_t sect;
>> +	int ret;
>> +
>> +	sect = nvmet_lba_to_sect(req->ns, le64_to_cpu(req->cmd->zms.slba));
>> +
>> +	switch (c->zsa) {
>> +	case NVME_ZONE_OPEN:
>> +		op = REQ_OP_ZONE_OPEN;
>> +		break;
>> +	case NVME_ZONE_CLOSE:
>> +		op = REQ_OP_ZONE_CLOSE;
>> +		break;
>> +	case NVME_ZONE_FINISH:
>> +		op = REQ_OP_ZONE_FINISH;
>> +		break;
>> +	case NVME_ZONE_RESET:
>> +		if (c->select_all)
>> +			nr_sect = get_capacity(nvmet_bdev(req)->bd_disk);
>> +		op = REQ_OP_ZONE_RESET;
>> +		break;
>> +	default:
>> +		status = NVME_SC_INVALID_FIELD;
>> +		break;
> You needa goto here or blkdev_zone_mgmt() will be called.
>
True.
>> +	}
>> +
>> +	ret = blkdev_zone_mgmt(nvmet_bdev(req), op, sect, nr_sect, GFP_KERNEL);
>> +	if (ret)
>> +		status = NVME_SC_INTERNAL;
>> +
>> +	nvmet_req_complete(req, status);
>> +}
>> +
>> +void nvmet_bdev_execute_zone_append(struct nvmet_req *req)
>> +{
>> +	unsigned long bv_cnt = min(req->sg_cnt, BIO_MAX_PAGES);
>> +	int op = REQ_OP_ZONE_APPEND | REQ_SYNC | REQ_IDLE;
>> +	u64 slba = le64_to_cpu(req->cmd->rw.slba);
>> +	sector_t sect = nvmet_lba_to_sect(req->ns, slba);
>> +	u16 status = NVME_SC_SUCCESS;
>> +	int sg_cnt = req->sg_cnt;
>> +	struct scatterlist *sg;
>> +	size_t mapped_data_len;
>> +	struct iov_iter from;
>> +	struct bio_vec *bvec;
>> +	size_t mapped_cnt;
>> +	size_t io_len = 0;
>> +	struct bio *bio;
>> +	int ret;
>> +
>> +	if (!nvmet_check_transfer_len(req, nvmet_rw_data_len(req)))
>> +		return;
> No request completion ?
See nvmet_check_transfer_len().
>> +
>> +	if (!req->sg_cnt) {
>> +		nvmet_req_complete(req, 0);
>> +		return;
>> +	}
>> +
>> +	bvec = kmalloc_array(bv_cnt, sizeof(*bvec), GFP_KERNEL);
>> +	if (!bvec) {
>> +		status = NVME_SC_INTERNAL;
>> +		goto out;
>> +	}
>> +
>> +	while (sg_cnt) {
>> +		mapped_data_len = 0;
>> +		for_each_sg(req->sg, sg, req->sg_cnt, mapped_cnt) {
>> +			nvmet_file_init_bvec(bvec, sg);
>> +			mapped_data_len += bvec[mapped_cnt].bv_len;
>> +			sg_cnt--;
>> +			if (mapped_cnt == bv_cnt)
>> +				break;
>> +		}
>> +		iov_iter_bvec(&from, WRITE, bvec, mapped_cnt, mapped_data_len);
>> +
>> +		bio = bio_alloc(GFP_KERNEL, bv_cnt);
>> +		bio_set_dev(bio, nvmet_bdev(req));
>> +		bio->bi_iter.bi_sector = sect;
>> +		bio->bi_opf = op;
>> +
>> +		ret =  __bio_iov_append_get_pages(bio, &from);
>> +		if (unlikely(ret)) {
>> +			status = NVME_SC_INTERNAL;
>> +			bio_io_error(bio);
>> +			kfree(bvec);
>> +			goto out;
>> +		}
>> +
>> +		ret = submit_bio_wait(bio);
>> +		bio_put(bio);
>> +		if (ret < 0) {
>> +			status = NVME_SC_INTERNAL;
>> +			break;
>> +		}
>> +
>> +		io_len += mapped_data_len;
>> +	}
> This loop is equivalent to splitting a zone append. That must not be done as
> that can lead to totally unpredictable ordering of the chunks. What if another
> thread is doing zone append to the same zone at the same time ?
>
We can add something like per-zone bit locking here to prevent that,
multiple

threads. With zasl value derived from max_zone_append_sector (as
mentioned in

my reply ideally we shouldn't get the data len more than what we can
handle if I'm

not missing something.

>> +
>> +	sect += (io_len >> 9);
>> +	req->cqe->result.u64 = le64_to_cpu(nvmet_sect_to_lba(req->ns, sect));
>> +	kfree(bvec);
>> +
>> +out:
>> +	nvmet_req_complete(req, status);
>> +}
>> +
>> +#else  /* CONFIG_BLK_DEV_ZONED */
>> +static void nvmet_execute_identify_cns_cs_ctrl(struct nvmet_req *req)
>> +{
>> +}
>> +static void nvmet_execute_identify_cns_cs_ns(struct nvmet_req *req)
>> +{
>> +}
>> +u16 nvmet_process_zns_cis(struct nvmet_req *req, off_t *off)
>> +{
>> +	return 0;
>> +}
>> +static bool nvmet_bdev_zns_config(struct nvmet_ns *ns)
>> +{
>> +	return false;
>> +}
>> +void nvmet_bdev_execute_zone_mgmt_recv(struct nvmet_req *req)
>> +{
>> +}
>> +void nvmet_bdev_execute_zone_mgmt_send(struct nvmet_req *req)
>> +{
>> +}
>> +void nvmet_bdev_execute_zone_append(struct nvmet_req *req)
>> +{
>> +}
>> +void nvmet_zns_add_cmd_effects(struct nvme_effects_log *log)
>> +{
>> +}
> These should go in the header file. And put the brackets on the same line.
>
As I explained earlier this bloats the header file with empty stubs and

adds functions in the traget transport code from nvmet.h which has

nothing to do with the backend. Regarding the {} style I don't see braces

on the same line for the empty stubs so keeping it consistent what is in

the repo.

>> +#endif /* CONFIG_BLK_DEV_ZONED */
>>

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
