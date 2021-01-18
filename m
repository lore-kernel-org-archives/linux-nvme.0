Return-Path: <SRS0=Iqha=GV=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E490C433E0
	for <linux-nvme@archiver.kernel.org>; Mon, 18 Jan 2021 04:36:15 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B526922475
	for <linux-nvme@archiver.kernel.org>; Mon, 18 Jan 2021 04:36:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B526922475
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe
	:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:From:Reply-To:Cc:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	bh=DV3buj/0GzWe5cHZ3dNVRlRD2Ks6zhVF5ZlLuGTsx5Q=; b=NlI2yAcWOLsqwRCv3aiP/+cnDO
	z50P24eN/+DAK+ivTWceyqL/8WXJlg1dldww95Y2+vXbE6SkVCXPkFrsTR5mgHpaEfCNwkavzESZC
	nyVjJ/dRTFNa9zG7ECA+Fe1ZR3u3ILs4cvnTz0C0xGcNLtv2nEzkOPhk64PZ6bZx0dZzu2QG8MR/l
	qPxqhgUN3O9GS08XGf+v5z9a4u7YRlhnu9TgBuQf+NQAivRmO+RJNnL1zIJwdPdY2eyUQxws/YpB3
	Vqk2ZJTg2WJdUaxXsWTS/rlUvnW/PWbRBekBRH7zURBRKwQFbGSM2QsQ3/lYQz9rWDAdjY+xgKUjx
	eF6wHR1Q==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l1MGv-0007RY-2u; Mon, 18 Jan 2021 04:36:09 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l1MGr-0007Qm-Jh
 for linux-nvme@lists.infradead.org; Mon, 18 Jan 2021 04:36:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1610944565; x=1642480565;
 h=from:to:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=2/ubtKJ3o8VhAxYKEJlMT8bS+gKnsz81bthUo5HEowo=;
 b=ayZpLlivUDuK6XTJJ370UVPSiALqQt7TyGJUBOl/Je4EuQX9Vb4zTpHB
 Krh7zo1NsVSfsrl1xEDT2c6+YwNvP7s6drgBMw+RvactoL3DT6wMDUatL
 rJbU0tIXXBGnC3XDS9II+b5CVugIG7thxpKOb9WefOSgFHHATkDmNikOi
 ym5yjA2w9i9M4KfILnKXlVyt4+COUFTNPcISpiYZhvnXtZUIi1P6Agzlx
 au8zr4jyylK5SneuRcoS2mMSQ50DpXDgFLhwHDXn7TFdRGzvSc+Bjrhce
 fzuLWMu4BepdNGc8o/TBXONxd+eSjVPRnsj4W0KmgK2wjEx4HjaZT3hWa g==;
IronPort-SDR: qvF0Ifk6fTAqgEErybVGQffm9R1ELecMCEyJU4+kAninbpRu55lMJs1hP/bt1UKPnmU8jkS1Ui
 QXUmzu+WzeefkyQ5FcDvL0OggUOqyaaXD0FOX62bZvU6Rz7px8Hsyeqg5n8z6d8/MyRwd+h8g5
 BMk5Ur4BTqZn1ncOn3lNwFzjftAmOFYU2hMqo8czmC+1L1hajo8Lsz3ab/rAoxFJz3VxE9Ct+G
 g8QiZOJNBywH1UuqZ65LVh5Z+rBBfiIOV+ZhzIi2K5E55FQmW9tDSNDP5U9OLrfWrGOxENUVqe
 SkY=
X-IronPort-AV: E=Sophos;i="5.79,355,1602518400"; d="scan'208";a="157667810"
Received: from mail-bn8nam11lp2168.outbound.protection.outlook.com (HELO
 NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.168])
 by ob1.hgst.iphmx.com with ESMTP; 18 Jan 2021 12:36:02 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XlDzrNZXZmUlsz76Q98NQkwSAkfvSR0A8DoqGwJUyVTKABbeAva1Y1ynqIMTl3QN4cyiSYWqBHRgy9K5eEDT8nxtsRqlGuGYc/Dumrq0n7/GQjZRxjQZqQmW5AKs/eLVYJj1hF9VgFmJEi3ALW7N3OycMRa9CRUY0Z7pZCtkPwsEAJkIEhOFQhWaZjI/n9yo00bYTet3/eJqsGMbSBftMGY+7ofXaCheYJTPsNSbYu7XdGTOr1nfmUcXplpb2zxPT2C03s6trp/2fkp7ZxrXBD3c71y6xT9aI/9Tz97sjebchfDbnXQRVOW0TFYIF5mmEnt/uDFhs92a5I6q9VMBeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2/ubtKJ3o8VhAxYKEJlMT8bS+gKnsz81bthUo5HEowo=;
 b=b/vte7liAkdZxEIK5U/tZBnOtIWX5YBPlcFeEIkPSL2hmdv6STwkbN+E65fAmwu7blYxqb2+kVyzAAytc8DMWdaJW8Uy2+6jaZwzOPlH+bRPglk8j3o7qNqp15amMFo/Mfk0uXR38H8s9UZzm4FF+1zLINB7WP4++1ztNOUlPXA+E2WZbqTOGgjckXOo07pvs+2XNgMzt/8RYZsmsaGaN05cDHl4dZcbJg0TmQAifekK6X4ugJpxaKbjzU9kPoyvDp2jkxg93ua+s2buDOdezWgX+Ij+c6iyYfGWXo0VlGfXlxdjtWWMY3ofEEN/G+/NhYmabwDaq+EVsNoieTIN7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2/ubtKJ3o8VhAxYKEJlMT8bS+gKnsz81bthUo5HEowo=;
 b=dJqzSvXLO2yeoI73/OBZy+mRRsF39ZFIurTe2vx6haWUUbvfjGJKnUsUUJQVTJxdhw0MV8DQxOFYuI4f6TtkznwuOpRs3SxtQgaurgDXMy48s64xP/CsmFIlFK9sJLF6m/sWB5imrOmpvBnmSHFujDDHctT0lSSwa321CbeobVk=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB4133.namprd04.prod.outlook.com (2603:10b6:a02:fc::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.12; Mon, 18 Jan
 2021 04:36:01 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::716c:4e0c:c6d1:298a]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::716c:4e0c:c6d1:298a%6]) with mapi id 15.20.3742.012; Mon, 18 Jan 2021
 04:36:01 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: "chapman6235@comcast.net" <chapman6235@comcast.net>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: Problem with SPCC 256GB NVMe 1.3 drive - refcount_t: underflow;
 use-after-free.
Thread-Topic: Problem with SPCC 256GB NVMe 1.3 drive - refcount_t: underflow; 
 use-after-free.
Thread-Index: AQHW7QO5MtNnJXjl5ka4VClzrgzGFg==
Date: Mon, 18 Jan 2021 04:36:01 +0000
Message-ID: <BYAPR04MB49659C0F0F0E11D166B31E0586A40@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <f50bc59c-db11-bb44-55be-7b9db1119872@comcast.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: comcast.net; dkim=none (message not signed)
 header.d=none;comcast.net; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2600:1700:31ee:290:d1f8:30b3:e5ff:ad09]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 5f985fff-6a32-4f23-2158-08d8bb6a8eea
x-ms-traffictypediagnostic: BYAPR04MB4133:
x-microsoft-antispam-prvs: <BYAPR04MB4133A471C5ABEBD6BB34D9DF86A40@BYAPR04MB4133.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /bqyi3SbHhq8UV5XoKncMNYvOAaOMQ1ro+Qwl2Ktr6b2tgJBod5B7EA75jF7x+HLx9vxcX5t46obkF7ornhrAp7oQBfjhpCpzOV3tRc5KwGBlugjj6WaZLOkM/1aMUYSlxhV/pazveEjk+nZxNLkdH0gaUfiaV2uytPjwSx6RTDVcms/rYW94ZuHDVXhrbuang9uFW78OIHfJPifdD7Py718FpUO3ZY2wF+f4IM8mE1tLvIHNxg1C3aMw5mlMebgCGqunzRMZkW7Mq+to6Z/NBgygN0FsF3PnAERxeLGLEQ41uBr+UW+iVo/YhfecO7H+b1OOIeQElIabiR9tWmjzSEgAKzG7zU9wTQ06QyJThGZQ+1Ocyul2MldC6t/bQ2p2/GgboYIIGaZ9KLd8nQrlc70cBAmY32R7Wqi+2huip/bLQYUQhjTffCoHiYVnGJ2zLnHNiipi7FhO2pLl/Dq4WGNGoYGvRIHPnx9DOgaqNBVddEDFUiIO8si8GB0lqcPLeJpstdxr3SxJWJpputuiA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(136003)(39860400002)(346002)(376002)(366004)(478600001)(66946007)(7696005)(71200400001)(8936002)(2906002)(186003)(76116006)(6506007)(33656002)(83380400001)(5660300002)(86362001)(53546011)(110136005)(316002)(55016002)(66446008)(9686003)(8676002)(64756008)(66476007)(52536014)(66556008);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?iO0sxaP6OAep38bAfwGPOqg/3ay/O0wxm/4tJntMyrZt27IeVgtoSR7LKo4j?=
 =?us-ascii?Q?vN9SusZ+dmEnKmGUanct11w7KehpviPvAXRyb4nDia3IarMww8DYV+cGAbk3?=
 =?us-ascii?Q?YlgpNHFfThwnH6mrTpN8G8N/X7D1ZtxfLQ9oehzqfhe30EL8uAfRHUVpsrGT?=
 =?us-ascii?Q?ss/ODJY49dxN51gYoMzbPmhIhND6gfQJsYKkIx0goTT+YNU9LFpFH6EgPCaf?=
 =?us-ascii?Q?+mmgi290HPBdvji3kMEf7YniRemLuIOf8oBh3SzouR+JtXjkQyUhGmUuApXo?=
 =?us-ascii?Q?EHTU+1R/VVxUsRdBCz1b20uRhB3a0x3/cy43cfexs9RgSYDFi+RfCvfrsGVt?=
 =?us-ascii?Q?msG09gIEaNXGCpIA7l1xH3wzV+YXHePRF8vAACfBqVLuTyoi+xm5TQ8EXebU?=
 =?us-ascii?Q?DQfp1t4nApWXLa3Dujsun/GXaoJ4yHUHwBSKV3RI1/pn1mAFd55E7GgQ7WOA?=
 =?us-ascii?Q?wJ5sYx0YogxJU79w2FmW4h/is++6DhvgEu9OMEmfP0mZmMTpJT56kXZ5N3Pj?=
 =?us-ascii?Q?mnV4QizLtHswPQ39ipj2bQvJS8enB3qWeXRNAFR+ov3TA2xkslHx+/dcZ0Xd?=
 =?us-ascii?Q?3uoAUUheYLu0iXJQlsb+pJzLbeAsV09Pi6IkfRiIo+zV8fQCGBgQjDRmjyyL?=
 =?us-ascii?Q?GIMA0jmbS/Y5HLJ/yVq+3UYcCIVhN760/9h8WktTGXzB3UkLCRQL/RN2dFOd?=
 =?us-ascii?Q?1m7o6nvpLfuoto+aI2iRnuAKqrRRzKNlq4i3cJAdPQe8+OG+dR8JXXbmCDkN?=
 =?us-ascii?Q?zD+CZAnzndo/egi0y50W4pjXHY5sZTX4MJfFVOF8UToS2b6gZVN6dAPHkhaN?=
 =?us-ascii?Q?knTsjXkN89wxvQdu/XNMHFumvG28NCpxEhgRTzL/ZoNuLW+uhFFQJDkF2Rlr?=
 =?us-ascii?Q?1tambVKKiNx80FEXtW3IAha05kLxQLn3lZolWU3m7uWX42bVJcxpL0JljVeG?=
 =?us-ascii?Q?O7lbo4ATPfNEIGi6if1QNLq5MQ9NW+9g75qntBg3v590jnJ8+ainDsdLoYSw?=
 =?us-ascii?Q?9t9ZTHmVf3A0ZjUVEzKELfnEVHsLWgcISTJxph2U1jxs03kR3Q0OUYs9ZQfY?=
 =?us-ascii?Q?z1ewZvmr?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f985fff-6a32-4f23-2158-08d8bb6a8eea
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jan 2021 04:36:01.0842 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1e4g6vFqVHmL4kpKv+ICoBrkDRFWqT/wG5xQRgu/ddXq3PKR88JC9K3vca/FtrUoGoaD555qIRg4w1t96RmNfekzSPdUUalPimqp7o4n0xI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4133
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210117_233605_965700_F5BF47A8 
X-CRM114-Status: GOOD (  11.66  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 1/17/21 11:05 AM, Bradley Chapman wrote:
> [ 2836.554298] nvme nvme1: I/O 415 QID 3 timeout, disable controller
> [ 2836.672064] blk_update_request: I/O error, dev nvme1n1, sector 16350 
> op 0x9:(WRITE_ZEROES) flags 0x0 phys_seg 0 prio class 0
> [ 2836.672072] blk_update_request: I/O error, dev nvme1n1, sector 16093 
> op 0x9:(WRITE_ZEROES) flags 0x0 phys_seg 0 prio class 0
> [ 2836.672074] blk_update_request: I/O error, dev nvme1n1, sector 15836 
> op 0x9:(WRITE_ZEROES) flags 0x0 phys_seg 0 prio class 0
> [ 2836.672076] blk_update_request: I/O error, dev nvme1n1, sector 15579 
> op 0x9:(WRITE_ZEROES) flags 0x0 phys_seg 0 prio class 0
> [ 2836.672078] blk_update_request: I/O error, dev nvme1n1, sector 15322 
> op 0x9:(WRITE_ZEROES) flags 0x0 phys_seg 0 prio class 0
> [ 2836.672080] blk_update_request: I/O error, dev nvme1n1, sector 15065 
> op 0x9:(WRITE_ZEROES) flags 0x0 phys_seg 0 prio class 0
> [ 2836.672082] blk_update_request: I/O error, dev nvme1n1, sector 14808 
> op 0x9:(WRITE_ZEROES) flags 0x0 phys_seg 0 prio class 0
> [ 2836.672083] blk_update_request: I/O error, dev nvme1n1, sector 14551 
> op 0x9:(WRITE_ZEROES) flags 0x0 phys_seg 0 prio class 0
> [ 2836.672085] blk_update_request: I/O error, dev nvme1n1, sector 14294 
> op 0x9:(WRITE_ZEROES) flags 0x0 phys_seg 0 prio class 0
> [ 2836.672087] blk_update_request: I/O error, dev nvme1n1, sector 14037 
> op 0x9:(WRITE_ZEROES) flags 0x0 phys_seg 0 prio class 0
> [ 2836.672121] nvme nvme1: failed to mark controller live state
> [ 2836.672123] nvme nvme1: Removing after probe failure status: -19
> [ 2836.689016] Aborting journal on device dm-0-8.
> [ 2836.689024] Buffer I/O error on dev dm-0, logical block 25198592, 
> lost sync page write
> [ 2836.689027] JBD2: Error -5 detected when updating journal superblock 
> for dm-0-8.
Without the knowledge of fs mount/format command I can only suspect that
super
block zeroing issued with write-zeroes request is translated into
REQ_OP_WRITE_ZEROES which controller is not able to process resulting in
the error. This analysis maybe wrong.

Can you please share following details :-

nvme id-ns /dev/nvme0n1 -H (we are interested in oncs part here)

Also for above device what is the value for the queue block write-zeroes

parameter that is present in the
/sys/block/<nvmeXnY>/queue/write_zeroes_max_bytes ?

You can also try blkdiscard -z 0 -l 1024 /dev/<nvmeXnY> to see if the
problem is with
write zeroes.

Also can you please also try the latest nvme tree branch nvme-5.11 ?


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
