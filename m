Return-Path: <SRS0=morU=AH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB7DBC433E0
	for <linux-nvme@archiver.kernel.org>; Fri, 26 Jun 2020 12:07:14 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8FF3F206A1
	for <linux-nvme@archiver.kernel.org>; Fri, 26 Jun 2020 12:07:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Wt/UDELa";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="ka5HV7Ba";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="MRoFJuDt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FF3F206A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=Nt66WVeprOrLP5GgHWYFDabFWwu/x6eyA4K8ZgmNWWg=; b=Wt/UDELaLT2n/5tPAqIjJ+o2l
	acwgkzueuyq2Pu2M3s4Gvhyr/Dr082qkGQWZjR2nTZiUC3MAmnH9Sp/FsCfH3Vg4QRrXdFF9pGMbY
	0tnN33LkG47W8SNog747Mf5iQjVZidSwjAd6b09QOnR8MuU9/vtTQwMT7TrzUkpJjrTQz3pHyznOm
	ecHut1Xkwm/s1vllBs6s3Y/Gs4z0rkCEjk2qlr97uHJL3LqILRAdn+GQ8FiiOB+wS7Hqpw8tvF7ly
	aSAV2D5NPnbnzvc2h5MG4kxXLxJkXysCfv7LU8yVnEUhwZ63zz77jcQ7SOX0rkGb5aRhvzc7KfJYn
	3aOd/YOoQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jon8E-0004f6-Hq; Fri, 26 Jun 2020 12:06:58 +0000
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jolqd-0003OM-90
 for linux-nvme@lists.infradead.org; Fri, 26 Jun 2020 10:44:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1593168284; x=1624704284;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=WtUCQLdCc0YoYIjCwpZBvx9WVU5egPmEdYqrZwLqeR4=;
 b=ka5HV7Ba+UdKxxvTQo73RoDOBcsnNI+A0irGTBQwHv9ZGgYqrQ9n8lLG
 wB4GgCodIlvUaOQNLD+6NdFdl4eAQTEwmNQH7OP9e/+PQQj7kWrXCBYVl
 uojo9r+YYcmBuDv2NO5Gm2r6PphftvQ0CD4Dd0GF+3SSKu2DDldb/C8GC
 qQLycOg5Qo+XkG/szEsfDapO25cJfviNr8cJTz3kcoLjvZW8WwYVwFnEJ
 PaTFruDmPhMPqa4cVKsDOYQId+brlwwVHnf6Ni8zN/ddqnXM3X4UnBCEv
 cffwT72Hk0TXA574YsDEzPWnkCK3uDTQdo0VoY3LNQNe8F3u3+kQghTzS Q==;
IronPort-SDR: YiWkyi/QHKBu54JWpccxdip3Vv5Ys7yPh38gcYSNLBtmSLhTp8D/Ai1+VKMY3kizFcvRFLwVIk
 FR47XtsoRs1vjaXHOe459DNphx++h6qoCcp2YhUXbK8ziiD9ucKEeS/oPFwPGjgapvGXs2Xi1Y
 3TrhA5GPwKVBh+mCNQcB/PkYiQn3r/+hn5iNUauGqvjw+bQSFB71dhsQz9PMkeq+DgrepvyzSs
 znaLUhukRQlURJ+O3Dasp6itOu97T0n2M4zrdrO2iJ+zogSSJX30mK6QJl+EkgluSdjXNIjc1P
 hQg=
X-IronPort-AV: E=Sophos;i="5.75,282,1589212800"; d="scan'208";a="142347555"
Received: from mail-bl2nam02lp2058.outbound.protection.outlook.com (HELO
 NAM02-BL2-obe.outbound.protection.outlook.com) ([104.47.38.58])
 by ob1.hgst.iphmx.com with ESMTP; 26 Jun 2020 15:17:06 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R3rrzA/YKPLqXeOAB1mshVV+fKoJ46GN9C3lbYssG02OQ1iDU4CMjX02PVBshnIDOAvLrB4JwTQ5ueQt9sv4CwivJGRbs/TV0IEJgN3HGlVd8uUx/a6RRayHhgwqj+2BB7JKgYE9W1tLNAbrEvTu0bNk4GC5SM9T3kY97a9PyDlqalD98+PjgZ2rcjlLL+7N8cF2S7t6rI7vy9hEDJqgkOaxqUG/QNd8g6RAjMFoEFO7nXYhzKcUVawgZz+zZXqGxaRWztzhTrDB93PSBxoiHIFMKeorOV6RCk1rUnmct1ksKh8AVuuecCTpiZrvyXflo7ybenfgbGXCLBgTwoAHRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4C/ozukjZSsbfWeL8ovQYYN+y9TLTI+66BbEFhOzM9Q=;
 b=TYtzMHpQcBvsuiD0wykbgYACZgqFGnO8/kFJNX2QdBJu0itkhQsJfwK2F/r4zpYfPx9PkdtlWxiK1fRG3DMfDXPOLz4OVxR8L2tl7SstE0n+fSHuBAodPx4a+2J4VfZ+bT0RJKzobc1zT5/hivOWhGX6qO4aC9tLu54sP/VBRyjs2eTvCilCN3E9fBHsAEa6AyPeuXTUdJ5d8kgKiubQVO/44vq0zK8c4VSJEha21Ta1gpezbFUbk1Bsis1NX90j/Y7mOTcbvHXVD8H4CiU8ZMNrja6urUp7deRGdLlBlK1FzPhkhIlnqRPdonVJWBI3UFgsaFf3rmsT7/DwUzRq5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4C/ozukjZSsbfWeL8ovQYYN+y9TLTI+66BbEFhOzM9Q=;
 b=MRoFJuDtPjU5r+XhiFmkLaFJ4h5nYe9EoGQP0hywYZ0EG9PnshaJYkhtUkBR0XRZGEW2VQEAjIyhEEx+1jkB5eiazA2FF+6mk3vVhZIV0LA3F4o8WiBQbbBZEgEDNq0pKki41s/t8VUyz9xGr7rtyOu5V0ex6wefQSN8QintJs8=
Received: from CY4PR04MB3751.namprd04.prod.outlook.com (2603:10b6:903:ec::14)
 by CY4PR04MB1048.namprd04.prod.outlook.com (2603:10b6:910:54::26)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.20; Fri, 26 Jun
 2020 07:17:02 +0000
Received: from CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::c593:f271:eebe:ac7]) by CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::c593:f271:eebe:ac7%9]) with mapi id 15.20.3131.024; Fri, 26 Jun 2020
 07:17:02 +0000
From: Damien Le Moal <Damien.LeMoal@wdc.com>
To: =?iso-8859-1?Q?Javier_Gonz=E1lez?= <javier@javigon.com>
Subject: Re: [PATCH 3/6] block: add support for zone offline transition
Thread-Topic: [PATCH 3/6] block: add support for zone offline transition
Thread-Index: AQHWSutT3xCQHGem9k+D54mKrpOEQg==
Date: Fri, 26 Jun 2020 07:17:01 +0000
Message-ID: <CY4PR04MB3751D6B0FFCA3A8C0278A194E7930@CY4PR04MB3751.namprd04.prod.outlook.com>
References: <20200625122152.17359-1-javier@javigon.com>
 <20200625122152.17359-4-javier@javigon.com>
 <CY4PR04MB375111445246B570FAF4EE58E7930@CY4PR04MB3751.namprd04.prod.outlook.com>
 <20200626060858.uo56xe57l4tzepnc@mpHalley.localdomain>
 <CY4PR04MB37515EAB61CDB458DE5AFCA3E7930@CY4PR04MB3751.namprd04.prod.outlook.com>
 <20200626065822.6psy3tp6vqmjwppa@mpHalley.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: javigon.com; dkim=none (message not signed)
 header.d=none;javigon.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.182.57]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 97a7c9f3-243e-4a2b-6607-08d819a0ec2e
x-ms-traffictypediagnostic: CY4PR04MB1048:
x-microsoft-antispam-prvs: <CY4PR04MB10484826FB0F99508C6FB081E7930@CY4PR04MB1048.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0446F0FCE1
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NF/c5i/MQ7AdOoKXlDP7M3KEY35FaNv3LogSz1b7bpbweZoIWi+GKhaQux85oX8AKgahFou7Yc5eTMAnG1NRB6Cft6gKqX2ZN2MhMkCayhIcwKfJLVKXJf3jRnr/IyHRGEePMyZReSjUdxliZL2iegfzT0mVKNeGvO48ApPFO+ngf9K7/brGNQEHll83NsuFIralmbcSmmuEyB80HBlxHd3ODyt+pjWosLWKJxQ04UDgC2LBS9avZa7GN4qlQXrl3eHPEXBTJB0m0T3GrhvQ2KLJD+rzN+rqHVv+wBUnN6/CgIewf1VIVAdolUV76WiF
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR04MB3751.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(39860400002)(366004)(396003)(346002)(376002)(5660300002)(66476007)(7416002)(8936002)(8676002)(66556008)(66946007)(64756008)(86362001)(7696005)(54906003)(66446008)(478600001)(52536014)(71200400001)(316002)(4326008)(76116006)(53546011)(91956017)(26005)(55016002)(33656002)(66574015)(83380400001)(186003)(2906002)(9686003)(6506007)(6916009);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: 3zwgFRsfr0Mz0pxQIzt+VTlfca5B7xlkJ4IMqgw9XC1yTkOs3GyjZEtwo8lk7DneY1PyqneuMYNEwp17bvVpAqGxWeEtMGjw+CPyxAWyZXErwXTN+rrMw8+gpcVq7H3Q5MlMqVLX+Fb38W/X+uYIilI6REB6ng58vPQlJTdgGa6q1PWiJrAcW6PRNauBFBviX76ki96ktWDVbj0J8XxmbpUroBJMJETaI+E+vU1aNHe85wrPjzZe1tlOFmCn2KWJHdrL3zCs0Sg3ZEvblr90fp+XhO69uRvBoMGtwaoKxEo/gLfk3WPC5KxkROKXZGrW5IbYumvbphRahIGoraRaV/bofKFSN8obAiObokq2QsY2IiIXePJQsL1QP7E+fAJVnhVwjCehaaX2UQYtNxbKDgxEuK/uENwPiyN0ZvJUVCiGT0GFvwsM4hWrhLe+UR4cxPbPqyr/ImKoUKXmsGMKhNJSbI9d4cdgGT2dfrr85DM+2hUYXKP5QQ7rIOnRZqTC
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR04MB3751.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97a7c9f3-243e-4a2b-6607-08d819a0ec2e
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jun 2020 07:17:01.9721 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 12huu60bAxjQngYPueakvaK75TIaWGoeWLtveCa2qe1H5i9K14R9tcdfsgXNYKhf/vKQ9NZxV86efPqvVzDMAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR04MB1048
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
Cc: "axboe@kernel.dk" <axboe@kernel.dk>,
 SelvaKumar S <selvakuma.s1@samsung.com>, "sagi@grimberg.me" <sagi@grimberg.me>,
 Kanchan Joshi <joshi.k@samsung.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Nitesh Shetty <nj.shetty@samsung.com>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "kbusch@kernel.org" <kbusch@kernel.org>, "hch@lst.de" <hch@lst.de>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 2020/06/26 15:58, Javier Gonz=E1lez wrote:
> On 26.06.2020 06:42, Damien Le Moal wrote:
>> On 2020/06/26 15:09, Javier Gonz=E1lez wrote:
>>> On 26.06.2020 01:34, Damien Le Moal wrote:
>>>> On 2020/06/25 21:22, Javier Gonz=E1lez wrote:
>>>>> From: Javier Gonz=E1lez <javier.gonz@samsung.com>
>>>>>
>>>>> Add support for offline transition on the zoned block device using the
>>>>> new zone management IOCTL
>>>>>
>>>>> Signed-off-by: Javier Gonz=E1lez <javier.gonz@samsung.com>
>>>>> Signed-off-by: SelvaKumar S <selvakuma.s1@samsung.com>
>>>>> Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
>>>>> Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>
>>>>> ---
>>>>>  block/blk-core.c              | 2 ++
>>>>>  block/blk-zoned.c             | 3 +++
>>>>>  drivers/nvme/host/core.c      | 3 +++
>>>>>  include/linux/blk_types.h     | 3 +++
>>>>>  include/linux/blkdev.h        | 1 -
>>>>>  include/uapi/linux/blkzoned.h | 1 +
>>>>>  6 files changed, 12 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/block/blk-core.c b/block/blk-core.c
>>>>> index 03252af8c82c..589cbdacc5ec 100644
>>>>> --- a/block/blk-core.c
>>>>> +++ b/block/blk-core.c
>>>>> @@ -140,6 +140,7 @@ static const char *const blk_op_name[] =3D {
>>>>>  	REQ_OP_NAME(ZONE_CLOSE),
>>>>>  	REQ_OP_NAME(ZONE_FINISH),
>>>>>  	REQ_OP_NAME(ZONE_APPEND),
>>>>> +	REQ_OP_NAME(ZONE_OFFLINE),
>>>>>  	REQ_OP_NAME(WRITE_SAME),
>>>>>  	REQ_OP_NAME(WRITE_ZEROES),
>>>>>  	REQ_OP_NAME(SCSI_IN),
>>>>> @@ -1030,6 +1031,7 @@ generic_make_request_checks(struct bio *bio)
>>>>>  	case REQ_OP_ZONE_OPEN:
>>>>>  	case REQ_OP_ZONE_CLOSE:
>>>>>  	case REQ_OP_ZONE_FINISH:
>>>>> +	case REQ_OP_ZONE_OFFLINE:
>>>>>  		if (!blk_queue_is_zoned(q))
>>>>>  			goto not_supported;
>>>>>  		break;
>>>>> diff --git a/block/blk-zoned.c b/block/blk-zoned.c
>>>>> index 29194388a1bb..704fc15813d1 100644
>>>>> --- a/block/blk-zoned.c
>>>>> +++ b/block/blk-zoned.c
>>>>> @@ -416,6 +416,9 @@ int blkdev_zone_mgmt_ioctl(struct block_device *b=
dev, fmode_t mode,
>>>>>  	case BLK_ZONE_MGMT_RESET:
>>>>>  		op =3D REQ_OP_ZONE_RESET;
>>>>>  		break;
>>>>> +	case BLK_ZONE_MGMT_OFFLINE:
>>>>> +		op =3D REQ_OP_ZONE_OFFLINE;
>>>>> +		break;
>>>>>  	default:
>>>>>  		return -ENOTTY;
>>>>>  	}
>>>>> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
>>>>> index f1215523792b..5b95c81d2a2d 100644
>>>>> --- a/drivers/nvme/host/core.c
>>>>> +++ b/drivers/nvme/host/core.c
>>>>> @@ -776,6 +776,9 @@ blk_status_t nvme_setup_cmd(struct nvme_ns *ns, s=
truct request *req,
>>>>>  	case REQ_OP_ZONE_FINISH:
>>>>>  		ret =3D nvme_setup_zone_mgmt_send(ns, req, cmd, NVME_ZONE_FINISH);
>>>>>  		break;
>>>>> +	case REQ_OP_ZONE_OFFLINE:
>>>>> +		ret =3D nvme_setup_zone_mgmt_send(ns, req, cmd, NVME_ZONE_OFFLINE);
>>>>> +		break;
>>>>>  	case REQ_OP_WRITE_ZEROES:
>>>>>  		ret =3D nvme_setup_write_zeroes(ns, req, cmd);
>>>>>  		break;
>>>>> diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
>>>>> index 16b57fb2b99c..b3921263c3dd 100644
>>>>> --- a/include/linux/blk_types.h
>>>>> +++ b/include/linux/blk_types.h
>>>>> @@ -316,6 +316,8 @@ enum req_opf {
>>>>>  	REQ_OP_ZONE_FINISH	=3D 12,
>>>>>  	/* write data at the current zone write pointer */
>>>>>  	REQ_OP_ZONE_APPEND	=3D 13,
>>>>> +	/* Transition a zone to offline */
>>>>> +	REQ_OP_ZONE_OFFLINE	=3D 14,
>>>>>
>>>>>  	/* SCSI passthrough using struct scsi_request */
>>>>>  	REQ_OP_SCSI_IN		=3D 32,
>>>>> @@ -456,6 +458,7 @@ static inline bool op_is_zone_mgmt(enum req_opf o=
p)
>>>>>  	case REQ_OP_ZONE_OPEN:
>>>>>  	case REQ_OP_ZONE_CLOSE:
>>>>>  	case REQ_OP_ZONE_FINISH:
>>>>> +	case REQ_OP_ZONE_OFFLINE:
>>>>>  		return true;
>>>>>  	default:
>>>>>  		return false;
>>>>> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
>>>>> index bd8521f94dc4..8308d8a3720b 100644
>>>>> --- a/include/linux/blkdev.h
>>>>> +++ b/include/linux/blkdev.h
>>>>> @@ -372,7 +372,6 @@ extern int blkdev_zone_ops_ioctl(struct block_dev=
ice *bdev, fmode_t mode,
>>>>>  				  unsigned int cmd, unsigned long arg);
>>>>>  extern int blkdev_zone_mgmt_ioctl(struct block_device *bdev, fmode_t=
 mode,
>>>>>  				  unsigned int cmd, unsigned long arg);
>>>>> -
>>>>>  #else /* CONFIG_BLK_DEV_ZONED */
>>>>>
>>>>>  static inline unsigned int blkdev_nr_zones(struct gendisk *disk)
>>>>> diff --git a/include/uapi/linux/blkzoned.h b/include/uapi/linux/blkzo=
ned.h
>>>>> index a8c89fe58f97..d0978ee10fc7 100644
>>>>> --- a/include/uapi/linux/blkzoned.h
>>>>> +++ b/include/uapi/linux/blkzoned.h
>>>>> @@ -155,6 +155,7 @@ enum blk_zone_action {
>>>>>  	BLK_ZONE_MGMT_FINISH	=3D 0x2,
>>>>>  	BLK_ZONE_MGMT_OPEN	=3D 0x3,
>>>>>  	BLK_ZONE_MGMT_RESET	=3D 0x4,
>>>>> +	BLK_ZONE_MGMT_OFFLINE	=3D 0x5,
>>>>>  };
>>>>>
>>>>>  /**
>>>>>
>>>>
>>>> As mentioned in previous email, the usefulness of this is dubious. Ple=
ase
>>>> elaborate in the commit message. Sure NVMe ZNS defines this and we can=
 support
>>>> it. But without a good use case, what is the point ?
>>>
>>> Use case is to transition zones in read-only state to offline when we
>>> are done moving valid data. It is easier to explicitly managing zones
>>> that are not usable by having all under the offline state.
>>
>> Then adding a simple BLKZONEOFFLINE ioctl, similar to open, close, finis=
h and
>> reset, would be enough. No need for all the new zone management ioctl wi=
th flags
>> plumbing.
> =

> Ok. We can add that then.
> =

> Note that zone management is not motivated by this use case at all, but
> it made sense to implement it here instead of as a new BLKZONEOFFLINE
> IOCTL as ZAC/ZBC users will not be able to use it either way.

Sure, that is fine. We could actually add that to sd_zbc.c since we have zo=
ne
tracking there. A read-only zone can be reported as offline to sync-up with=
 zns.
The value of it is dubious though as most applications will treat read-only=
 and
offline zones the same way: as unusable. That is what zonefs does.

> =

>>
>>>
>>>>
>>>> scsi SD driver will return BLK_STS_NOTSUPP if this offlining is sent t=
o a
>>>> ZBC/ZAC drive. Not nice. Having a sysfs attribute "max_offline_zone_se=
ctors" or
>>>> the like to indicate support by the device or not would be nicer.
>>>
>>> We can do that.
>>>
>>>>
>>>> Does offling ALL zones make any sense ? Because this patch does not pr=
event the
>>>> use of the REQ_ZONE_ALL flags introduced in patch 2. Probably not a go=
od idea to
>>>> allow offlining all zones, no ?
>>>
>>> AFAIK the transition to offline is only valid when coming from a
>>> read-only state. I did think of adding a check, but I can see that other
>>> transitions go directly to the driver and then the device, so I decided
>>> to follow the same model. If you think it is better, we can add the
>>> check.
>>
>> My point was that the REQ_ZONE_ALL flag would make no sense for offlinin=
g zones
>> but this patch does not have anything checking that. There is no point in
>> sending a command that is known to be incorrect to the drive...
> =

> I will add some extra checks then to fail early. I assume these should
> be in the NVMe driver as it is NVMe-specific, right?

If it is a simple BLKZONEOFFLINE ioctl, it can be processed exactly like op=
en,
close and finish, using blkdev_zone_mgmt(). Calling that one for a range of
sectors of more than one zone will likely not make any sense most of the ti=
me,
but that is allowed for all other ops, so I guess you can keep it as is for
offline too. blkdev_zone_mgmt() will actually not need any change. You will=
 only
need to wire the ioctl path and update op_is_zone_mgmt(). That's it. Simple=
 that
way.

> =

> Javier
> =



-- =

Damien Le Moal
Western Digital Research

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
