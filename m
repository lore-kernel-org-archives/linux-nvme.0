Return-Path: <SRS0=morU=AH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1FB8C433DF
	for <linux-nvme@archiver.kernel.org>; Fri, 26 Jun 2020 09:51:50 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 90E8B21531
	for <linux-nvme@archiver.kernel.org>; Fri, 26 Jun 2020 09:51:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="x9SJ6Jw0";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="lZlr+2Qh";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="ar/BQfI1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90E8B21531
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=NN0rJvEIyqD5UxzIln99VXMFb9H78mgy47eCKDAlpqU=; b=x9SJ6Jw0Q3xIKIfA5NaVev/El
	10o48WZs/HFHCbAqHIVf6nNkP4DEVcFPhqfC+xQfhQcX5gLpBrbKX6PzdSZDe08GDrahCSppi+bwG
	Uaf0sEyNorEDsVIvtmp9cE26YZ1ok+f4APenD7eN1Znis34ZSKBDy4sTXIAI7Bhj/tDZ9PK0OOyoi
	q7DKnIEPiJSlw/ycB8S5vb8H8MkR0bKe+MZJzVCsE2za1USM6XjlikkQx5/tILKFXPmEuEJ6AUaDI
	XhsEUkYorH3rtzjBr061NBj3Wnfl+yNrRKaxS7LTEy+SQHQaKE7fytA4kgJ/HpIws8ymQIGH6t/aE
	B7qUO3Y8A==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jol1O-0003Ff-2S; Fri, 26 Jun 2020 09:51:46 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jokXq-0005UR-QC
 for linux-nvme@lists.infradead.org; Fri, 26 Jun 2020 09:21:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1593163275; x=1624699275;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=UhkcfXJAjB1uCDx7CpV+tD4xYaIb/7aE0GU6iWYREmc=;
 b=lZlr+2Qhnqi+mqb7nxBobQtH1bHM6PwUCR/0Wzq7JfkvbDyyi5BSYN88
 +3LDbqa/qmEDd5gtedV4I4aBuzJIBa4I5Wj/oFV+mxvYanzWDPiudRKz+
 sQRsy9E8z4Kkzx4x2FBmVqidmh+vmkc35xLrxioIhbgCbtuH1tl+xbEEF
 HK4GT8hrLCl/F5q/RbFEeijFQ8O4gthcPyGgFhLuR0C554kbBherUHYNs
 42RKFetXqIZh+8Rja1X0WpPLEJ+bgBg7KbX8WerXo1qsnZtuFQzyeTVi8
 4JSia/4Ro+qfJMpDqyNeBG9XKN2Q1A6CVyyr77bR/63fLZB3zxSS9t9VC w==;
IronPort-SDR: 2CwLU7Ixzn5/nrMMHDPtpM2lYSTmni6lWC7N/4MeQjqr0z4grqRKrYAS9sNgAkfHOmycCoqXEx
 sEKWMp2GUfDpwSEdT1w/o6bUgNpKQDTC8drzLRYJoE4R9pij+2PjJ/LA6zvqp2RzadNkZNF310
 ft/m2YYOVTuA9WNpy+O5P+QZkzCQ7Lp0uSujNnTzm8HpyRD0LKcx54FGGnu93tM2Rbmqq1NLc2
 6swWsGcHAUitUoX5HVLkTv69k0fKbjrkaGlOm4m6+fPrxKVKL9NeDFk0Bh8g3ZCLaYdmB1+AXC
 uw4=
X-IronPort-AV: E=Sophos;i="5.75,281,1589212800"; d="scan'208";a="141196190"
Received: from mail-bn8nam11lp2174.outbound.protection.outlook.com (HELO
 NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.174])
 by ob1.hgst.iphmx.com with ESMTP; 26 Jun 2020 09:14:34 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VMqUgBjnGY29Aidu1EaFyW6AYcO7+NvNGAARcEbawaVA1AHEOi1iJv2cVSL8/YvDpwE2P3nNPCn+/f5IXu+O5Qx1IIKiRJWHLtKFK8ZCz3rhiznmZxXAkyabKmhPRz3+sCnyGU1LrbMbsrtp/rmk5al9bzae2YsG5N89ILAEE5A2mY5c/dswrsul7w0AcJdU2eX2wp9FTqiQNv6Hof5isYvkzDC/iBNilSUlXoV4RyhKPYyhZgS8qu6bAPnCpOUQGE4mUkfNY762qVOjAgcDaA4J143+6Zh/VbCSxDLAjwVuM6wqjrQA6is8cjYXECW8TBByHz9oHJz0yqgJgnzKBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZX/Rov5Yniivb5Ca5b86G5bq/pKzYkDJXFdPJp/GtfI=;
 b=UWr2LfItbXuFXTt8bI06zXDVuQGGeM9vBUJTqO/+R8qrX2d3pqgJyoDUzm2kAQLUGlJ89RcmtjeSIp1Vnnq0Y0BEkKc2qBfz+dlFWh8d8On1H5zqxBEXYNMnopxd0M3VRb5Y2nTOxJLJiACc2q5ingvdkJwaF6no4U0G9/pBXFdsJhL08iJiak5CwKVZPiTSenakMHtFVLOZn0Yaymh67JwevpWU0zjWc57VrasFpvhnCECTHXcmiy0q6NS+nBoe95eXoVL7Cw3ElgzURAGX7VXIlQIeTkDngnxaNhA5ovKNI5xsKIuhhfLFkE7r8lAx49w+cTfNXRrkfdqMUlUOYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZX/Rov5Yniivb5Ca5b86G5bq/pKzYkDJXFdPJp/GtfI=;
 b=ar/BQfI13ZBftZ5+zUt/bLrP+ovIrA+dugTQbGFu3drDkQS5ImByZVjJeMATYcCB3vRqsraG85YEXS5A9aH71n7q99v4QFAFeRCSNRtJ651Ysk6Ff2UsTqbNTFmYGOS4P7oBADZqV+zTZBV28pxly5u63LCAWKItR/W7PtpSqQk=
Received: from CY4PR04MB3751.namprd04.prod.outlook.com (2603:10b6:903:ec::14)
 by CY4PR04MB0726.namprd04.prod.outlook.com (2603:10b6:903:e3::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.23; Fri, 26 Jun
 2020 01:14:31 +0000
Received: from CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::c593:f271:eebe:ac7]) by CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::c593:f271:eebe:ac7%9]) with mapi id 15.20.3131.024; Fri, 26 Jun 2020
 01:14:31 +0000
From: Damien Le Moal <Damien.LeMoal@wdc.com>
To: =?iso-8859-1?Q?Javier_Gonz=E1lez?= <javier@javigon.com>,
 =?iso-8859-1?Q?Matias_Bj=F8rling?= <mb@lightnvm.io>
Subject: Re: [PATCH 3/6] block: add support for zone offline transition
Thread-Topic: [PATCH 3/6] block: add support for zone offline transition
Thread-Index: AQHWSutT3xCQHGem9k+D54mKrpOEQg==
Date: Fri, 26 Jun 2020 01:14:30 +0000
Message-ID: <CY4PR04MB3751E7721E5D5E15065B0ED2E7930@CY4PR04MB3751.namprd04.prod.outlook.com>
References: <20200625122152.17359-1-javier@javigon.com>
 <20200625122152.17359-4-javier@javigon.com>
 <b3429226-16ae-df3c-38aa-50e3a8716e71@lightnvm.io>
 <20200625194835.5hojuvdwtjxtso2l@MacBook-Pro.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: javigon.com; dkim=none (message not signed)
 header.d=none;javigon.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.182.57]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 9ffcdf2f-b9c5-4c63-b5a9-08d8196e4792
x-ms-traffictypediagnostic: CY4PR04MB0726:
x-microsoft-antispam-prvs: <CY4PR04MB072662A5073BD8EBAEDC08FCE7930@CY4PR04MB0726.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0446F0FCE1
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9SUs4eGm45AGQXtk+bCgei8iiZyxSR9wNL8nFG/0qML1wUAgAfFwitxNfLUlhbdPP0gdQcnscL0BdODKmCVaeSFCJseBKXUXfz2fItD3OcmDgi9JVisUUb+5qTUVc5tJRlBoToPiYHGL3VjFERvGGh3wcbQbzEsnF5vkCA5iqonXEEs8m9IaQPOYriwdL0tbls60rw6JTNZ+qA0uHtrHtFVuYUpDgFbsZ1BIU7Cyw6iz/gVMcRLLGkIzboNpTQf17XvOXa+nardQM1xqqi05xOBWQM7fOP0YM32FMCCAU86bXCIOfvH/o86vn2GXlS43
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR04MB3751.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(366004)(376002)(136003)(346002)(39860400002)(53546011)(52536014)(33656002)(83380400001)(54906003)(110136005)(71200400001)(316002)(478600001)(66446008)(8936002)(66946007)(26005)(86362001)(64756008)(7416002)(66556008)(9686003)(6506007)(5660300002)(8676002)(186003)(66476007)(91956017)(7696005)(66574015)(76116006)(4326008)(2906002)(55016002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: ZUSzMntiBVwnTfg4TKD3xcxoFTKxkNKyHI3jCwTUdqDDdkvQRW9XUvehyJ87Uzr9K8vZBu6P39b0K7S0kkuXnUSm3RX8iQ2ltqTc8Gsof/y/1hdXxAVpg+h69pQ/gorpkNjnGZydy2iTeW53cZSr4jw67oZEFKqX5b+9n02U+ZLVAe0/TZOm4iCtVQMHeQ+9u1rDQw8QK+4jbFhuNEU1ZwbvSuOQ15QjgqVpZpG5EiGlRRnpG6xdesst3jTPHRAADBGlGT/djKcTFJrQD8S8QGzibMZ84mtjR2ldPcn6D4/VCgD6gV3mQuFfaFvY5BsaaMg2LcsAl2YaNdEAn/z+jVLoJKwCsnz/yk32lkkL1mKpd8bNUPJhM8SymEl0fU/WSVR0EoWF1SnS90LzIuFPApTAOGnkrV0FZJx+tZfgFAldr8besrhyQQCUA5Kl6D6UXZHRcCICWTavS5xNsDMlSchXbDdxCSUuOeLa20LQ9RXM3sgCk7IHqInUCkkn8J3A
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ffcdf2f-b9c5-4c63-b5a9-08d8196e4792
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jun 2020 01:14:30.9100 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oBH9RG24flRytJYFEaMC83t2x40Pk79mcnNiFdKGOjNA5STkz9ShE2q2d8NAeKhwIlfji3G+yt8Ti8CBEG+m8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR04MB0726
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

On 2020/06/26 4:48, Javier Gonz=E1lez wrote:
> On 25.06.2020 16:12, Matias Bj=F8rling wrote:
>> On 25/06/2020 14.21, Javier Gonz=E1lez wrote:
>>> From: Javier Gonz=E1lez <javier.gonz@samsung.com>
>>>
>>> Add support for offline transition on the zoned block device using the
>>> new zone management IOCTL
>>>
>>> Signed-off-by: Javier Gonz=E1lez <javier.gonz@samsung.com>
>>> Signed-off-by: SelvaKumar S <selvakuma.s1@samsung.com>
>>> Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
>>> Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>
>>> ---
>>>  block/blk-core.c              | 2 ++
>>>  block/blk-zoned.c             | 3 +++
>>>  drivers/nvme/host/core.c      | 3 +++
>>>  include/linux/blk_types.h     | 3 +++
>>>  include/linux/blkdev.h        | 1 -
>>>  include/uapi/linux/blkzoned.h | 1 +
>>>  6 files changed, 12 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/block/blk-core.c b/block/blk-core.c
>>> index 03252af8c82c..589cbdacc5ec 100644
>>> --- a/block/blk-core.c
>>> +++ b/block/blk-core.c
>>> @@ -140,6 +140,7 @@ static const char *const blk_op_name[] =3D {
>>>  	REQ_OP_NAME(ZONE_CLOSE),
>>>  	REQ_OP_NAME(ZONE_FINISH),
>>>  	REQ_OP_NAME(ZONE_APPEND),
>>> +	REQ_OP_NAME(ZONE_OFFLINE),
>>>  	REQ_OP_NAME(WRITE_SAME),
>>>  	REQ_OP_NAME(WRITE_ZEROES),
>>>  	REQ_OP_NAME(SCSI_IN),
>>> @@ -1030,6 +1031,7 @@ generic_make_request_checks(struct bio *bio)
>>>  	case REQ_OP_ZONE_OPEN:
>>>  	case REQ_OP_ZONE_CLOSE:
>>>  	case REQ_OP_ZONE_FINISH:
>>> +	case REQ_OP_ZONE_OFFLINE:
>>>  		if (!blk_queue_is_zoned(q))
>>>  			goto not_supported;
>>>  		break;
>>> diff --git a/block/blk-zoned.c b/block/blk-zoned.c
>>> index 29194388a1bb..704fc15813d1 100644
>>> --- a/block/blk-zoned.c
>>> +++ b/block/blk-zoned.c
>>> @@ -416,6 +416,9 @@ int blkdev_zone_mgmt_ioctl(struct block_device *bde=
v, fmode_t mode,
>>>  	case BLK_ZONE_MGMT_RESET:
>>>  		op =3D REQ_OP_ZONE_RESET;
>>>  		break;
>>> +	case BLK_ZONE_MGMT_OFFLINE:
>>> +		op =3D REQ_OP_ZONE_OFFLINE;
>>> +		break;
>>>  	default:
>>>  		return -ENOTTY;
>>>  	}
>>> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
>>> index f1215523792b..5b95c81d2a2d 100644
>>> --- a/drivers/nvme/host/core.c
>>> +++ b/drivers/nvme/host/core.c
>>> @@ -776,6 +776,9 @@ blk_status_t nvme_setup_cmd(struct nvme_ns *ns, str=
uct request *req,
>>>  	case REQ_OP_ZONE_FINISH:
>>>  		ret =3D nvme_setup_zone_mgmt_send(ns, req, cmd, NVME_ZONE_FINISH);
>>>  		break;
>>> +	case REQ_OP_ZONE_OFFLINE:
>>> +		ret =3D nvme_setup_zone_mgmt_send(ns, req, cmd, NVME_ZONE_OFFLINE);
>>> +		break;
>>>  	case REQ_OP_WRITE_ZEROES:
>>>  		ret =3D nvme_setup_write_zeroes(ns, req, cmd);
>>>  		break;
>>> diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
>>> index 16b57fb2b99c..b3921263c3dd 100644
>>> --- a/include/linux/blk_types.h
>>> +++ b/include/linux/blk_types.h
>>> @@ -316,6 +316,8 @@ enum req_opf {
>>>  	REQ_OP_ZONE_FINISH	=3D 12,
>>>  	/* write data at the current zone write pointer */
>>>  	REQ_OP_ZONE_APPEND	=3D 13,
>>> +	/* Transition a zone to offline */
>>> +	REQ_OP_ZONE_OFFLINE	=3D 14,
>>>  	/* SCSI passthrough using struct scsi_request */
>>>  	REQ_OP_SCSI_IN		=3D 32,
>>> @@ -456,6 +458,7 @@ static inline bool op_is_zone_mgmt(enum req_opf op)
>>>  	case REQ_OP_ZONE_OPEN:
>>>  	case REQ_OP_ZONE_CLOSE:
>>>  	case REQ_OP_ZONE_FINISH:
>>> +	case REQ_OP_ZONE_OFFLINE:
>>>  		return true;
>>>  	default:
>>>  		return false;
>>> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
>>> index bd8521f94dc4..8308d8a3720b 100644
>>> --- a/include/linux/blkdev.h
>>> +++ b/include/linux/blkdev.h
>>> @@ -372,7 +372,6 @@ extern int blkdev_zone_ops_ioctl(struct block_devic=
e *bdev, fmode_t mode,
>>>  				  unsigned int cmd, unsigned long arg);
>>>  extern int blkdev_zone_mgmt_ioctl(struct block_device *bdev, fmode_t m=
ode,
>>>  				  unsigned int cmd, unsigned long arg);
>>> -
>>>  #else /* CONFIG_BLK_DEV_ZONED */
>>>  static inline unsigned int blkdev_nr_zones(struct gendisk *disk)
>>> diff --git a/include/uapi/linux/blkzoned.h b/include/uapi/linux/blkzone=
d.h
>>> index a8c89fe58f97..d0978ee10fc7 100644
>>> --- a/include/uapi/linux/blkzoned.h
>>> +++ b/include/uapi/linux/blkzoned.h
>>> @@ -155,6 +155,7 @@ enum blk_zone_action {
>>>  	BLK_ZONE_MGMT_FINISH	=3D 0x2,
>>>  	BLK_ZONE_MGMT_OPEN	=3D 0x3,
>>>  	BLK_ZONE_MGMT_RESET	=3D 0x4,
>>> +	BLK_ZONE_MGMT_OFFLINE	=3D 0x5,
>>>  };
>>>  /**
>>
>> I am not sure this makes sense to expose through the kernel zone api. =

>> One of the goals of the kernel zone API is to be a layer that provides =

>> an unified zone model across SMR HDDs and ZNS SSDs. The offline zone =

>> operation, as defined in the ZNS specification, does not have an =

>> equivalent in SMR HDDs (ZAC/ZBC).
>>
>> This is different from the Zone Capacity change, where the zone =

>> capacity simply was zone size for SMR HDDs. Making it easy to support. =

>> That is not the same for ZAC/ZBC, that does not offer the offline =

>> operation to transition zones in read only state to offline state.
> =

> I agree that an unified interface is desirable. However, the truth is
> that ZAC/ZBC are different, and will differ more and more and time goes
> by. We can deal with the differences at the driver level or with checks
> at the API level, but limiting ZNS with ZAC/ZBC is a hard constraint.

As long as you keep ZNS namespace report itself as being "host-managed" like
ZBC/ZAC disks, we need the consistency and common interface. If you break t=
hat,
the meaning of the zoned model queue attribute disappears and an applicatio=
n or
in-kernel user cannot rely on this model anymore to know how the drive will=
 behave.

> Note too that I chose to only support this particular transition on the
> new management IOCTL to avoid confusion for existing ZAC/ZBC users.
> =

> It would be good to clarify what is the plan for kernel APIs moving
> forward, as I believe there is a general desire to support new ZNS
> features, which will not necessarily be replicated in SMR drives.

What the drive is supposed to support and its behavior is determined by the
zoned model. ZNS standard was written so that most things have an equivalent
with ZBC/ZAC, e.g. the zone state machine is nearly identical. Differences =
are
either emulated (e.g. zone append scsi emulation), or not supported (e.g. z=
one
capacity change) so that the kernel follows the same pattern and maintains a
coherent behavior between device protocols for the host-managed model.

Think of a file system, or any other in-kernel user. If they have to change
their code based on the device type (NVMe vs SCSI), then the zoned block de=
vice
interface is broken. Right now, that is not the case, everything works equa=
lly
well on ZNS and SCSI, modulo the need by a user for conventional zones that=
 ZNS
do not define. But that is still consistent with the host-managed model sin=
ce
conventional zones are optional.

For this particular patch, there is currently no in-kernel user, and it is =
not
clear how this will be useful to applications. At least please clarify this=
. And
most likely, similarly to discard etc operations that are optional, having a
sysfs attribute and in-kernel API indicating if the drive supports offlining
zones will be needed. Otherwise, the caller will have to play with error co=
des
to understand if the drive does not support the command or if it is support=
ed
but the command failed. Not nice. Better to know before issuing the command.


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
