Return-Path: <SRS0=wRjJ=FE=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B99F9C3E8C5
	for <linux-nvme@archiver.kernel.org>; Mon, 30 Nov 2020 00:16:28 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE35A20756
	for <linux-nvme@archiver.kernel.org>; Mon, 30 Nov 2020 00:16:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="2tEnMo5D";
	dkim=permerror (0-bit key) header.d=wdc.com header.i=@wdc.com header.b="k9a7XtPO";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="lgcy4dtm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE35A20756
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=8o8QtQhzmXMHrhOhMGPB7DwwJ/B6WobvCUFIU1cpfnM=; b=2tEnMo5DrOqJHTSSllRC3kZby
	M78NcPBxrjKwePT6EUd2k5ZpW7dXPW0js4BPL+NIV7UuN5oGgOeyNriBm3RMU3dyXhaVaA3MUxry8
	Wb7geuD7UfOp6waqq9F4CyPOe48pyuhQ9A0+ThzZj6GQ8l68uR58aXVCL9AuUm6ztIJhuQQ3CpAgq
	K1KsJCPSlOFbk7IId5CGdQRa4EgZRV1xVcxlvu10NqVwEHRZSSHsdVmSJ/v5sriebs4mbyB8Z7jhd
	GFSci0u01AqAR08Yk+t4+lve9u9MCfz0wo64hnx/RNUV9syP1swWndMHnuChpOEBp9OiMZoOAVTqs
	fyYlfTbVw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kjWra-0005N1-7e; Mon, 30 Nov 2020 00:16:18 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kjWrU-0005Mc-Uj
 for linux-nvme@lists.infradead.org; Mon, 30 Nov 2020 00:16:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1606696251; x=1638232251;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=PFDawk4NKl3yvCpxFyvWCCLVXgjqT58XZibRMdLYHcw=;
 b=k9a7XtPOOxwv41x0vKw7ERY937nisYl3jy77+TiJ3hsWWbSOXPNXDHMv
 ipfuH8qJTdLcyYfiog1u1pGG7otxjnS/F+pRtw6iJomMrMSx3KPF1G0bT
 ljNYdVu8U1bB7puqbciCOjh4MmJ5QzhPRWBKrvWVAz0ECcGoG85gLwGqK
 6wVzF1t/58TdhsJMAkHCdWt2ZAgUcL6Kx0EL6a+9GQC6G6r0M1TkHC21I
 LFKavLh9JdIBWnpdqK4hvxCx6I8rOTX7CkjHJDp5vjqWhz+ouACU5Zs7D
 mxzTu4DcUOT2VfXKl5aNb29F7o6sD5WT/3n0Y0T0cxZB0pjuvDQ3bGJ3T A==;
IronPort-SDR: 61DT+abtx2DH8z+ASwkgBuzraH0TJG5mtnAZJCwdUdqG4zEmgU/CKuegFasd2mMAgmCYz9n6tf
 JK0pM3dC1iz9kPLnrGodsIv1OXrHBheiXPIsJ/ssqwRs5xhVDJ8fOjekNJ2iKNyN8pPyz5be5X
 bQjgSUtCwy071am+t/FMQH8z+3B2wwTtKf6fFcXGF2Cu9ZKu/DGSy/glcaUpBkf3dKfipsxT3O
 DC8fcmRLfgS35AXF1PjBjCUnlFMXxIzOeCyBlHXXJ7UuoXOaTw0NysalQxX32kpb5CPC5+H0lF
 O/4=
X-IronPort-AV: E=Sophos;i="5.78,379,1599494400"; d="scan'208";a="257439293"
Received: from mail-mw2nam10lp2101.outbound.protection.outlook.com (HELO
 NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.101])
 by ob1.hgst.iphmx.com with ESMTP; 30 Nov 2020 08:30:45 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oBzcSo6WVo2ydnUxxUKO3h32g32kP3MpPX39EjtUNO5NgXiDPVTMTQmRRAYOVh1z1gH1L25/zD8tFIJvTwY7273c8QqstLhZ1Z54IY4ESXHWg0vNuUKm+1+d9aZdjPliL70PNNbubH6TW5gr0x2hRDH//3BoMS7gg1SD0vqb/8aVE0gk1VcallUun3902vaiYZHNL+SV6a5TesE4e6Rxp9XMwAzbt8Tvbl636aWLNzH7+m1iA+088lErB5BFxdR7DAzzEDWrLZQq+V0HZh4ngMlzrNOBfX/88rdd0ndOVQWJhgkQjct+6fauzprFyAhNMaw5G9bFhzu79oNyXwB2Cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ERmdf8XEpAsuDQY5QCFjCmUdtlqp4hL/wNAXZcHlPY8=;
 b=Jm3E6LOZVhMXH3CRH/7ENQMRw541AouWyjFaEMvBSAidtVTsKLzw/9yINwYQM+nvfHS+X8QHRx6zGBuFwwrc/o4t5W6AClEucEqaHdyazwmW2aFcdr6q2wySdE8x6muYOGpjIhAgRTir/Ju/d9C/y0WXK7kELxA6q+lOQV6lCZ+NQB6tTvYoddxzD6kvxeKkwtv/66gM1iPhUUPbI9zRgKOuXYAj1i6Gu4uHMMq/nf1kYPufA1FwwBvZNTbl1OYd2Sro4XdWOIC+kw2cTneX7TjcIB98YMRt3iJzT/IGdwZOOeFcyrzm/X1cC27633j3AxOtCGTfiuZUzFQSu/+FlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ERmdf8XEpAsuDQY5QCFjCmUdtlqp4hL/wNAXZcHlPY8=;
 b=lgcy4dtmDVfnnkQt0+531DfGNwqvt5sJqKRusKNHlRG7V8Jvlj7lqmTtvcg3dW7KPyBLUVWbxZdKeufpIdGU2ptMtmtmfHaaiGowYKJx0ITRdYextfGK2FIU3skXbKFeWQwEgUwira4MR7vEDIemp2jyMghelLzb4bPQgSMU2GI=
Received: from CH2PR04MB6522.namprd04.prod.outlook.com (2603:10b6:610:34::19)
 by CH2PR04MB6949.namprd04.prod.outlook.com (2603:10b6:610:97::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.21; Mon, 30 Nov
 2020 00:16:07 +0000
Received: from CH2PR04MB6522.namprd04.prod.outlook.com
 ([fe80::897c:a04b:4eb0:640a]) by CH2PR04MB6522.namprd04.prod.outlook.com
 ([fe80::897c:a04b:4eb0:640a%7]) with mapi id 15.20.3589.022; Mon, 30 Nov 2020
 00:16:07 +0000
From: Damien Le Moal <Damien.LeMoal@wdc.com>
To: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH 2/9] nvmet: add ZNS support for bdev-ns
Thread-Topic: [PATCH 2/9] nvmet: add ZNS support for bdev-ns
Thread-Index: AQHWw53W//+mWSEaQk2ZMnl01vomXw==
Date: Mon, 30 Nov 2020 00:16:07 +0000
Message-ID: <CH2PR04MB652222058A8091A81BF3F4B9E7F50@CH2PR04MB6522.namprd04.prod.outlook.com>
References: <20201126024043.3392-1-chaitanya.kulkarni@wdc.com>
 <20201126024043.3392-3-chaitanya.kulkarni@wdc.com>
 <CH2PR04MB6522298714A02E18D356081CE7F90@CH2PR04MB6522.namprd04.prod.outlook.com>
 <BYAPR04MB49652ACED79DDFA79DF00C7E86F70@BYAPR04MB4965.namprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:3811:272:f33b:9d56]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b41d13a8-1342-45b6-9f46-08d894c52200
x-ms-traffictypediagnostic: CH2PR04MB6949:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH2PR04MB6949E3610DB7FAF93D9EB9A4E7F50@CH2PR04MB6949.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zBMvBQcxoyrxMdYq7LysBl8GJDdzL5jUZBmZJmmNMw/7UdmDZOnGPqZQl21N64J0siHohhmz2CICGDpk+oZfYOjFC/fBZnSaJdTTYOmOYakFndBcGRcMNXAU6YOsEtgrj2EZTnvKuQle7X51w0eWxro6gyGgQQ7EPXRn8Hr2GGAH9+zHxL7meIh9jntTq2NJKIm9hQkif279pG0q/+WpyzY0WOlP1MeU+nS5o6FE8ev7oJ8uAgwSUn7qcXcfdS9JHfzVEr9QPX1ZeRPbiQOMQKeed0c7x6uLKRk+mrkiWSmAZNhIZMTWUBtN4zeO2vgRG44ACmVqGrv2aX6L1wP6Pg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR04MB6522.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(39860400002)(136003)(346002)(396003)(366004)(33656002)(6506007)(53546011)(54906003)(186003)(4326008)(76116006)(91956017)(110136005)(9686003)(316002)(86362001)(2906002)(30864003)(7696005)(8676002)(8936002)(55016002)(71200400001)(66946007)(478600001)(66476007)(5660300002)(66446008)(66556008)(83380400001)(64756008)(52536014);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?jBBLdzFP3sel5qmDBQTzgN6vzWiRCKJN6l+NkwnlXALG+owlns1gi0/1r+S/?=
 =?us-ascii?Q?lDsMa8RIXwuTPKUlBq/B5ZzeSJ1CuosIBXn7THTqnUagPri8vCYrKROcPsdo?=
 =?us-ascii?Q?qIt+IfIIkV456uZhW/VgD1gOT91wuf47SWAzxLJJsABgW29O3w6KRyJlH+0X?=
 =?us-ascii?Q?7lCVksqykVdi7IeKhT2Y9WH7cTZoURAFsUMbETTL+MgLuXiWWPhS62BDtF89?=
 =?us-ascii?Q?V7vD8WIzoD5VP4ef8NEIITTYh3pwTuPAeEWmYhu/fH0f2E6gNe5Z95iLtQT0?=
 =?us-ascii?Q?0BdmYLQDDeANLXXeRWZQpFKyHtvTjX9bHmDsaLyhijMduL4fKOl0u9dpU6vS?=
 =?us-ascii?Q?jEVEHCfcVveV6jnvp9wXuU8BO6fLtdb+68ZR4BQajjwQlb6QUoc4daqIOGpU?=
 =?us-ascii?Q?/vzFndaWXe2iDEb1/cF3mJpPfaimH1Nh12lcvRiM/HnyYhYUA9lgYYRkbtTD?=
 =?us-ascii?Q?vjz1YxeSYQQoS10psAwEXxGt9OJzwbiABsr2QP0iRISA/g6QiQWEJVElys45?=
 =?us-ascii?Q?3k9b+2ke/R3UCDns11s6usCKNRQE/Tdm/RMQqlaBVHBiai/BJoMqs72Orlb7?=
 =?us-ascii?Q?Lo75kqynPyJTZF+X6ondZce986CgGZ7dnAVrc94BGoT5PoslXxAjwOi4UBcf?=
 =?us-ascii?Q?mag5MhKUAkpBfZG+GoQTbCnFOGj+1xpd77H8GDD38Kq5UrH2oHRHFgxd0lgO?=
 =?us-ascii?Q?DzjkH0WOyMZWMGOUsBglZULc951me1PC10MkEclHS5BuMTyrp8ipuBzi79V0?=
 =?us-ascii?Q?cBW2To8RJJYuzqAq+AxiL3ocaUccHCv00RTUky1269w2HAfjDlQuj0kfShLM?=
 =?us-ascii?Q?JtJ5dPhROxvVB6TvZBw/+Ypo6LTHAFQq9JzKlten7eBrAL9C81RTICOo997E?=
 =?us-ascii?Q?hb2Ykz/CePQESoptDRT93MqiibDxToDaBb1LXEgtkL/Oemhqv/x7tLi3QN12?=
 =?us-ascii?Q?+HLt2HyxE31CDsssljCHo2EMaaGZzt+PVBp6tYcbq3vYGyCSj/uieLxPoQti?=
 =?us-ascii?Q?xuPRZPj/OTmZiwAbd3EAAEDHtRG68ulN517fTiKy7UrieMRALG73oYlQeiO/?=
 =?us-ascii?Q?nvnakjxY?=
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR04MB6522.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b41d13a8-1342-45b6-9f46-08d894c52200
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Nov 2020 00:16:07.2162 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AwkI7qUJPoVrv4X35/p7zv8PsinUKFuivckGJ1fzSSP0mOAJT47dmZXqeQ/0M00nqLdh08p7b+D66iwkPjhgYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR04MB6949
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201129_191613_386808_183D9779 
X-CRM114-Status: GOOD (  24.24  )
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

On 2020/11/28 9:09, Chaitanya Kulkarni wrote:
> On 11/26/20 00:36, Damien Le Moal wrote:
>> On 2020/11/26 11:42, Chaitanya Kulkarni wrote:
>>> Add zns-bdev-config, id-ctrl, id-ns, zns-cmd-effects, zone-mgmt-send,
>>> zone-mgmt-recv and zone-append handlers for NVMeOF target to enable ZNS
>>> support for bdev.
>>>
>>> Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
>>> ---
>>>  drivers/nvme/target/Makefile      |   2 +
>>>  drivers/nvme/target/admin-cmd.c   |   4 +-
>>>  drivers/nvme/target/io-cmd-file.c |   2 +-
>>>  drivers/nvme/target/nvmet.h       |  18 ++
>>>  drivers/nvme/target/zns.c         | 390 ++++++++++++++++++++++++++++++
>>>  5 files changed, 413 insertions(+), 3 deletions(-)
>>>  create mode 100644 drivers/nvme/target/zns.c
>>>
>>> diff --git a/drivers/nvme/target/Makefile b/drivers/nvme/target/Makefile
>>> index ebf91fc4c72e..bc147ff2df5d 100644
>>> --- a/drivers/nvme/target/Makefile
>>> +++ b/drivers/nvme/target/Makefile
>>> @@ -12,6 +12,8 @@ obj-$(CONFIG_NVME_TARGET_TCP)		+= nvmet-tcp.o
>>>  nvmet-y		+= core.o configfs.o admin-cmd.o fabrics-cmd.o \
>>>  			discovery.o io-cmd-file.o io-cmd-bdev.o
>>>  nvmet-$(CONFIG_NVME_TARGET_PASSTHRU)	+= passthru.o
>>> +nvmet-$(CONFIG_BLK_DEV_ZONED)		+= zns.o
>>> +
>>>  nvme-loop-y	+= loop.o
>>>  nvmet-rdma-y	+= rdma.o
>>>  nvmet-fc-y	+= fc.o
>>> diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
>>> index dca34489a1dc..509fd8dcca0c 100644
>>> --- a/drivers/nvme/target/admin-cmd.c
>>> +++ b/drivers/nvme/target/admin-cmd.c
>>> @@ -579,8 +579,8 @@ static void nvmet_execute_identify_nslist(struct nvmet_req *req)
>>>  	nvmet_req_complete(req, status);
>>>  }
>>>  
>>> -static u16 nvmet_copy_ns_identifier(struct nvmet_req *req, u8 type, u8 len,
>>> -				    void *id, off_t *off)
>>> +u16 nvmet_copy_ns_identifier(struct nvmet_req *req, u8 type, u8 len,
>>> +			     void *id, off_t *off)
>>>  {
>>>  	struct nvme_ns_id_desc desc = {
>>>  		.nidt = type,
>>> diff --git a/drivers/nvme/target/io-cmd-file.c b/drivers/nvme/target/io-cmd-file.c
>>> index 0abbefd9925e..2bd10960fa50 100644
>>> --- a/drivers/nvme/target/io-cmd-file.c
>>> +++ b/drivers/nvme/target/io-cmd-file.c
>>> @@ -89,7 +89,7 @@ int nvmet_file_ns_enable(struct nvmet_ns *ns)
>>>  	return ret;
>>>  }
>>>  
>>> -static void nvmet_file_init_bvec(struct bio_vec *bv, struct scatterlist *sg)
>>> +void nvmet_file_init_bvec(struct bio_vec *bv, struct scatterlist *sg)
>>>  {
>>>  	bv->bv_page = sg_page(sg);
>>>  	bv->bv_offset = sg->offset;
>>> diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
>>> index 592763732065..0542ba672a31 100644
>>> --- a/drivers/nvme/target/nvmet.h
>>> +++ b/drivers/nvme/target/nvmet.h
>>> @@ -81,6 +81,9 @@ struct nvmet_ns {
>>>  	struct pci_dev		*p2p_dev;
>>>  	int			pi_type;
>>>  	int			metadata_size;
>>> +#ifdef CONFIG_BLK_DEV_ZONED
>>> +	struct nvme_id_ns_zns	id_zns;
>>> +#endif
>>>  };
>>>  
>>>  static inline struct nvmet_ns *to_nvmet_ns(struct config_item *item)
>>> @@ -251,6 +254,10 @@ struct nvmet_subsys {
>>>  	unsigned int		admin_timeout;
>>>  	unsigned int		io_timeout;
>>>  #endif /* CONFIG_NVME_TARGET_PASSTHRU */
>>> +
>>> +#ifdef CONFIG_BLK_DEV_ZONED
>>> +	struct nvme_id_ctrl_zns	id_ctrl_zns;
>>> +#endif
>>>  };
>>>  
>>>  static inline struct nvmet_subsys *to_subsys(struct config_item *item)
>>> @@ -603,4 +610,15 @@ static inline bool nvmet_ns_has_pi(struct nvmet_ns *ns)
>>>  	return ns->pi_type && ns->metadata_size == sizeof(struct t10_pi_tuple);
>>>  }
>>>  
>>> +void nvmet_execute_identify_cns_cs_ctrl(struct nvmet_req *req);
>>> +void nvmet_execute_identify_cns_cs_ns(struct nvmet_req *req);
>>> +u16 nvmet_process_zns_cis(struct nvmet_req *req, off_t *off);
>>> +bool nvmet_bdev_zns_config(struct nvmet_ns *ns);
>>> +void nvmet_bdev_execute_zone_mgmt_recv(struct nvmet_req *req);
>>> +void nvmet_bdev_execute_zone_mgmt_send(struct nvmet_req *req);
>>> +void nvmet_bdev_execute_zone_append(struct nvmet_req *req);
>>> +void nvmet_zns_add_cmd_effects(struct nvme_effects_log *log);
>>> +u16 nvmet_copy_ns_identifier(struct nvmet_req *req, u8 type, u8 len,
>>> +			     void *id, off_t *off);
>>> +void nvmet_file_init_bvec(struct bio_vec *bv, struct scatterlist *sg);
>>>  #endif /* _NVMET_H */
>>> diff --git a/drivers/nvme/target/zns.c b/drivers/nvme/target/zns.c
>>> new file mode 100644
>>> index 000000000000..8ea6641a55e3
>>> --- /dev/null
>>> +++ b/drivers/nvme/target/zns.c
>>> @@ -0,0 +1,390 @@
>>> +// SPDX-License-Identifier: GPL-2.0
>>> +/*
>>> + * NVMe ZNS-ZBD command implementation.
>>> + * Copyright (c) 2020-2021 HGST, a Western Digital Company.
>>> + */
>>> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
>>> +#include <linux/uio.h>
>>> +#include <linux/nvme.h>
>>> +#include <linux/blkdev.h>
>>> +#include <linux/module.h>
>>> +#include "nvmet.h"
>>> +
>>> +#ifdef CONFIG_BLK_DEV_ZONED
>> This file is compiled only if CONFIG_BLK_DEV_ZONED is defined, so what is the
>> point of this ? The stubs for the !CONFIG_BLK_DEV_ZONED case should go into the
>> header file, no ?
> 
> Actually the conditional compilation of zns.c with CONFIG_BLK_DEV_ZONED
> 
> needs to be removed in the Makefile. I'm against putting these empty
> stubs in the
> 
> makefile when CONFIG_BLK_DEV_ZONED is not true, as there are several files
> 
> transport, discovery, file/passthru backend etc in the nvme/target/*.c
> which will add
> 
> empty stubs which has nothing to do with zoned bdev backend.

Each file will not need to add empty stubs if these stubs are in a common
header. And empty stubs are compiled away so I do not see the problem. Having
such empty stubs in a header file under an #ifdef is I think a fairly standard
coding style in the kernel. The block layer zone code and scsi SMR code is coded
like that.

> 
> i.e. for Makefile it should be :-
> 
> diff --git a/drivers/nvme/target/Makefile b/drivers/nvme/target/Makefile
> index ebf91fc4c72e..c67276a25363 100644
> --- a/drivers/nvme/target/Makefile
> +++ b/drivers/nvme/target/Makefile
> @@ -10,7 +10,7 @@ obj-$(CONFIG_NVME_TARGET_FCLOOP)      += nvme-fcloop.o
>  obj-$(CONFIG_NVME_TARGET_TCP)          += nvmet-tcp.o
>  
>  nvmet-y                += core.o configfs.o admin-cmd.o fabrics-cmd.o \
> -                       discovery.o io-cmd-file.o io-cmd-bdev.o
> +                       zns,o discovery.o io-cmd-file.o io-cmd-bdev.o
>  nvmet-$(CONFIG_NVME_TARGET_PASSTHRU)   += passthru.o
>  nvme-loop-y    += loop.o
>  nvmet-rdma-y   += rdma.o

The NS scan and test for support of ZNS could go in discovery.c, and compiled
unconditionally exactly like the host nvme driver does. Everything else (ZNS
commands execution) can go into zns.c and that file compiled conditionally, with
empty stubs in zns.h or any other appropriate header file. I think that make
things clean and easy to understand, and avoid the big #ifdef in the C code.
Just my opinion here. You are the maintainer, so your call...

>>> +
>>> +static u16 nvmet_bdev_zns_checks(struct nvmet_req *req)
>>> +{
>>> +	u16 status = 0;
>>> +
>>> +	if (!bdev_is_zoned(req->ns->bdev)) {
>>> +		status = NVME_SC_INVALID_NS | NVME_SC_DNR;
>>> +		goto out;
>> Why not return status directly here ? Same for the other cases below.
> I prefer centralize returns with goto, which follows the similar code.

Sure, but for such a simple function, this looks rather strange and in my
opinion uselessly complicates the code.

>>> +	}
>>> +
>>> +	if (req->cmd->zmr.zra != NVME_ZRA_ZONE_REPORT) {
>>> +		status = NVME_SC_INVALID_FIELD;
>>> +		goto out;
>>> +	}
>>> +
>>> +	if (req->cmd->zmr.zrasf != NVME_ZRASF_ZONE_REPORT_ALL) {
>>> +		status = NVME_SC_INVALID_FIELD;
>>> +		goto out;
>>> +	}
>>> +
>>> +	if (req->cmd->zmr.pr != NVME_REPORT_ZONE_PARTIAL)
>>> +		status = NVME_SC_INVALID_FIELD;
>>> +out:
>>> +	return status;
>>> +}

[...]
>>> +void nvmet_execute_identify_cns_cs_ns(struct nvmet_req *req)
>>> +{
>>> +	struct nvme_id_ns_zns *id_zns;
>>> +	u16 status = 0;
>>> +	u64 zsze;
>>> +
>>> +	if (le32_to_cpu(req->cmd->identify.nsid) == NVME_NSID_ALL) {
>>> +		req->error_loc = offsetof(struct nvme_identify, nsid);
>>> +		status = NVME_SC_INVALID_NS | NVME_SC_DNR;
>>> +		goto out;
>>> +	}
>>> +
>>> +	id_zns = kzalloc(sizeof(*id_zns), GFP_KERNEL);
>>> +	if (!id_zns) {
>>> +		status = NVME_SC_INTERNAL;
>>> +		goto out;
>>> +	}
>>> +
>>> +	req->ns = nvmet_find_namespace(req->sq->ctrl, req->cmd->identify.nsid);
>>> +	if (!req->ns) {
>>> +		status = NVME_SC_INTERNAL;
>>> +		goto done;
>> That will result in nvmet_copy_to_sgl() being executed. Is that OK ?
>> Shouldn't you do only the kfree(id_zns) and complete with an error here ?
> Call to nvmet_copy_to_sgl() zeroout the values if any when we return the
> 
> buffer in case of error. I don't see any problem with zeroing out buffer in
> 
> case of error. Can you please explain why we shouldn't do that ?

I cannot explain anything. I was merely pointing out what the code was doing and
if that was intentional. If there are no problems, then fine.

> 
>>> +	}
>>> +
>>> +	if (!bdev_is_zoned(nvmet_bdev(req))) {
>>> +		req->error_loc = offsetof(struct nvme_identify, nsid);
>>> +		status = NVME_SC_INVALID_NS | NVME_SC_DNR;
>>> +		goto done;
>> Same comment.
> See above reply.
>>> +	}
>>> +
>>> +	nvmet_ns_revalidate(req->ns);
>>> +	zsze = (bdev_zone_sectors(nvmet_bdev(req)) << 9) >>
>>> +					req->ns->blksize_shift;
>>> +	id_zns->lbafe[0].zsze = cpu_to_le64(zsze);
>>> +	id_zns->mor = cpu_to_le32(bdev_max_open_zones(nvmet_bdev(req)));
>>> +	id_zns->mar = cpu_to_le32(bdev_max_active_zones(nvmet_bdev(req)));
>>> +
>>> +done:
>>> +	status = nvmet_copy_to_sgl(req, 0, id_zns, sizeof(*id_zns));
>>> +	kfree(id_zns);
>>> +out:
>>> +	nvmet_req_complete(req, status);
>>> +}
>>> +
>>> +void nvmet_bdev_execute_zone_mgmt_recv(struct nvmet_req *req)
>>> +{
>>> +	struct request_queue *q = nvmet_bdev(req)->bd_disk->queue;
>>> +	struct nvme_zone_mgmt_recv_cmd *zmr = &req->cmd->zmr;
>>> +	unsigned int nz = blk_queue_nr_zones(q);
>>> +	u64 bufsize = (zmr->numd << 2) + 1;
>>> +	struct nvme_zone_report *rz;
>>> +	struct blk_zone *zones;
>>> +	int reported_zones;
>>> +	sector_t sect;
>>> +	u64 desc_size;
>>> +	u16 status;
>>> +	int i;
>>> +
>>> +	desc_size = nvmet_zones_to_descsize(blk_queue_nr_zones(q));
>>> +	status = nvmet_bdev_zns_checks(req);
>>> +	if (status)
>>> +		goto out;
>>> +
>>> +	zones = kvcalloc(blkdev_nr_zones(nvmet_bdev(req)->bd_disk),
>>> +			      sizeof(struct blk_zone), GFP_KERNEL);
>> This is not super nice: a large disk will have an enormous number of zones
>> (75000+ for largest SMR HDD today). But you actually do not need more zones
>> descs than what fits in req buffer.
> Call to nvmet_copy_to_sgl() nicely fail and return error.

That is not my point. The point is that this code will do an allocation for
75,000 x 64B = 4.8MB even if a single zone report is being requested. That is
not acceptable. This needs optimization: allocate only as many zone descriptors
as is requested.

>>> +	if (!zones) {
>>> +		status = NVME_SC_INTERNAL;
>>> +		goto out;
>>> +	}
>>> +
>>> +	rz = __vmalloc(bufsize, GFP_KERNEL | __GFP_NORETRY);
>>> +	if (!rz) {
>>> +		status = NVME_SC_INTERNAL;
>>> +		goto out_free_zones;
>>> +	}
>>> +
>>> +	sect = nvmet_lba_to_sect(req->ns, le64_to_cpu(req->cmd->zmr.slba));
>>> +
>>> +	for (nz = blk_queue_nr_zones(q); desc_size >= bufsize; nz--)
>>> +		desc_size = nvmet_zones_to_descsize(nz);
>>> +
>>> +	reported_zones = blkdev_report_zones(nvmet_bdev(req), sect, nz,
>>> +					     nvmet_bdev_report_zone_cb,
>>> +					     zones);
>>> +	if (reported_zones < 0) {
>>> +		status = NVME_SC_INTERNAL;
>>> +		goto out_free_report_zones;
>>> +	}
>>> +
>>> +	rz->nr_zones = cpu_to_le64(reported_zones);
>>> +	for (i = 0; i < reported_zones; i++)
>>> +		nvmet_get_zone_desc(req->ns, &zones[i], &rz->entries[i]);
>> This can be done directly in the report zones cb. That will avoid looping twice
>> over the reported zones.
> Okay, I'll try and remove this loop.
>>> +
>>> +	status = nvmet_copy_to_sgl(req, 0, rz, bufsize);
>>> +
>>> +out_free_report_zones:
>>> +	kvfree(rz);
>>> +out_free_zones:
>>> +	kvfree(zones);
>>> +out:
>>> +	nvmet_req_complete(req, status);
>>> +}
>>> +
>>> +void nvmet_bdev_execute_zone_mgmt_send(struct nvmet_req *req)
>>> +{
>>> +	sector_t nr_sect = bdev_zone_sectors(nvmet_bdev(req));
>>> +	struct nvme_zone_mgmt_send_cmd *c = &req->cmd->zms;
>>> +	u16 status = NVME_SC_SUCCESS;
>>> +	enum req_opf op;
>>> +	sector_t sect;
>>> +	int ret;
>>> +
>>> +	sect = nvmet_lba_to_sect(req->ns, le64_to_cpu(req->cmd->zms.slba));
>>> +
>>> +	switch (c->zsa) {
>>> +	case NVME_ZONE_OPEN:
>>> +		op = REQ_OP_ZONE_OPEN;
>>> +		break;
>>> +	case NVME_ZONE_CLOSE:
>>> +		op = REQ_OP_ZONE_CLOSE;
>>> +		break;
>>> +	case NVME_ZONE_FINISH:
>>> +		op = REQ_OP_ZONE_FINISH;
>>> +		break;
>>> +	case NVME_ZONE_RESET:
>>> +		if (c->select_all)
>>> +			nr_sect = get_capacity(nvmet_bdev(req)->bd_disk);
>>> +		op = REQ_OP_ZONE_RESET;
>>> +		break;
>>> +	default:
>>> +		status = NVME_SC_INVALID_FIELD;
>>> +		break;
>> You needa goto here or blkdev_zone_mgmt() will be called.
>>
> True.
>>> +	}
>>> +
>>> +	ret = blkdev_zone_mgmt(nvmet_bdev(req), op, sect, nr_sect, GFP_KERNEL);
>>> +	if (ret)
>>> +		status = NVME_SC_INTERNAL;
>>> +
>>> +	nvmet_req_complete(req, status);
>>> +}
>>> +
>>> +void nvmet_bdev_execute_zone_append(struct nvmet_req *req)
>>> +{
>>> +	unsigned long bv_cnt = min(req->sg_cnt, BIO_MAX_PAGES);
>>> +	int op = REQ_OP_ZONE_APPEND | REQ_SYNC | REQ_IDLE;
>>> +	u64 slba = le64_to_cpu(req->cmd->rw.slba);
>>> +	sector_t sect = nvmet_lba_to_sect(req->ns, slba);
>>> +	u16 status = NVME_SC_SUCCESS;
>>> +	int sg_cnt = req->sg_cnt;
>>> +	struct scatterlist *sg;
>>> +	size_t mapped_data_len;
>>> +	struct iov_iter from;
>>> +	struct bio_vec *bvec;
>>> +	size_t mapped_cnt;
>>> +	size_t io_len = 0;
>>> +	struct bio *bio;
>>> +	int ret;
>>> +
>>> +	if (!nvmet_check_transfer_len(req, nvmet_rw_data_len(req)))
>>> +		return;
>> No request completion ?
> See nvmet_check_transfer_len().
>>> +
>>> +	if (!req->sg_cnt) {
>>> +		nvmet_req_complete(req, 0);
>>> +		return;
>>> +	}
>>> +
>>> +	bvec = kmalloc_array(bv_cnt, sizeof(*bvec), GFP_KERNEL);
>>> +	if (!bvec) {
>>> +		status = NVME_SC_INTERNAL;
>>> +		goto out;
>>> +	}
>>> +
>>> +	while (sg_cnt) {
>>> +		mapped_data_len = 0;
>>> +		for_each_sg(req->sg, sg, req->sg_cnt, mapped_cnt) {
>>> +			nvmet_file_init_bvec(bvec, sg);
>>> +			mapped_data_len += bvec[mapped_cnt].bv_len;
>>> +			sg_cnt--;
>>> +			if (mapped_cnt == bv_cnt)
>>> +				break;
>>> +		}
>>> +		iov_iter_bvec(&from, WRITE, bvec, mapped_cnt, mapped_data_len);
>>> +
>>> +		bio = bio_alloc(GFP_KERNEL, bv_cnt);
>>> +		bio_set_dev(bio, nvmet_bdev(req));
>>> +		bio->bi_iter.bi_sector = sect;
>>> +		bio->bi_opf = op;
>>> +
>>> +		ret =  __bio_iov_append_get_pages(bio, &from);
>>> +		if (unlikely(ret)) {
>>> +			status = NVME_SC_INTERNAL;
>>> +			bio_io_error(bio);
>>> +			kfree(bvec);
>>> +			goto out;
>>> +		}
>>> +
>>> +		ret = submit_bio_wait(bio);
>>> +		bio_put(bio);
>>> +		if (ret < 0) {
>>> +			status = NVME_SC_INTERNAL;
>>> +			break;
>>> +		}
>>> +
>>> +		io_len += mapped_data_len;
>>> +	}
>> This loop is equivalent to splitting a zone append. That must not be done as
>> that can lead to totally unpredictable ordering of the chunks. What if another
>> thread is doing zone append to the same zone at the same time ?
>>
> We can add something like per-zone bit locking here to prevent that,
> multiple
> 
> threads. With zasl value derived from max_zone_append_sector (as
> mentioned in
> 
> my reply ideally we shouldn't get the data len more than what we can
> handle if I'm
> 
> not missing something.

No way: a locking mechanism will negate the benefits of zone append vs regular
writes. So NACK on that. As you say, since you advertized the max zone append
sectors, you should not be getting a request larger than that limit. If you do,
fail the request immediately instead of trying to split the zone append command.

> 
>>> +
>>> +	sect += (io_len >> 9);
>>> +	req->cqe->result.u64 = le64_to_cpu(nvmet_sect_to_lba(req->ns, sect));
>>> +	kfree(bvec);
>>> +
>>> +out:
>>> +	nvmet_req_complete(req, status);
>>> +}
>>> +
>>> +#else  /* CONFIG_BLK_DEV_ZONED */
>>> +static void nvmet_execute_identify_cns_cs_ctrl(struct nvmet_req *req)
>>> +{
>>> +}
>>> +static void nvmet_execute_identify_cns_cs_ns(struct nvmet_req *req)
>>> +{
>>> +}
>>> +u16 nvmet_process_zns_cis(struct nvmet_req *req, off_t *off)
>>> +{
>>> +	return 0;
>>> +}
>>> +static bool nvmet_bdev_zns_config(struct nvmet_ns *ns)
>>> +{
>>> +	return false;
>>> +}
>>> +void nvmet_bdev_execute_zone_mgmt_recv(struct nvmet_req *req)
>>> +{
>>> +}
>>> +void nvmet_bdev_execute_zone_mgmt_send(struct nvmet_req *req)
>>> +{
>>> +}
>>> +void nvmet_bdev_execute_zone_append(struct nvmet_req *req)
>>> +{
>>> +}
>>> +void nvmet_zns_add_cmd_effects(struct nvme_effects_log *log)
>>> +{
>>> +}
>> These should go in the header file. And put the brackets on the same line.
>>
> As I explained earlier this bloats the header file with empty stubs and
> 
> adds functions in the traget transport code from nvmet.h which has
> 
> nothing to do with the backend. Regarding the {} style I don't see braces
> 
> on the same line for the empty stubs so keeping it consistent what is in
> 
> the repo.

As I said above, I am not a fan of this style... At the very least, please
remove the static stubs as that likely will generate a cdefined but not used
compiler warning.

> 
>>> +#endif /* CONFIG_BLK_DEV_ZONED */
>>>
> 


-- 
Damien Le Moal
Western Digital Research

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
