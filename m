Return-Path: <SRS0=BHMv=AO=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D68A3C433DF
	for <linux-nvme@archiver.kernel.org>; Fri,  3 Jul 2020 04:56:45 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 941992084C
	for <linux-nvme@archiver.kernel.org>; Fri,  3 Jul 2020 04:56:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ucZtfMmr";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="nPvKEWDJ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="a+XXW0uV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 941992084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=C8t/U7Jiis70ALJeLGCdGWnES25OhPtTxgPl4TYGsho=; b=ucZtfMmrk+dXobSMIkD2yNGUD
	TNkyF1mIzfc11nz7RKO5SqWjRdKAxi3W6keVlNQyqTcNQX9CtC8EU3L4XK17h7yczxnVpcPXA/dzc
	4P/DZzWUHRbu3qZN0vCg1WuqF0gx4qoxzRB48eFtoQ+z05w5vIcpNQ5FmBCg3+nxDnDltjVtMgtQ5
	cFGBomJSkyG45Ob+y9+jXgwYSnvu9YOJfL12pU5dGoQmkCNXAGJSpwmK9XuZPjg7RBIjO4LOk+ry9
	gFoNi4qzPsPTOGpfdXdRR1Jv62dJTLACh5KvgG1HRbzauCUM1D5bOLAb3dt2+HhowLx2kNEm48x/g
	zWOx61rSw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jrDke-0006NZ-18; Fri, 03 Jul 2020 04:56:40 +0000
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jrDka-0006Lh-C0
 for linux-nvme@lists.infradead.org; Fri, 03 Jul 2020 04:56:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1593752197; x=1625288197;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=ywvKJMBlaTIZNm+Ljdh8eW4baDkRqBHOSZFkdIQoztY=;
 b=nPvKEWDJTP+Oc8nNybsB4W2dEW48umDyYBFrANaxfwjvuObsfXoZ9hN9
 pvlDIr2AzVoa103TCN49uL1GtGPYRZE1d66NBB3IEXWJnaHOpFhX5iD+o
 dFXz292oGBto7mLdSwUAkk36NvSO1xlCOMMFquycXnGiS4G9khFQ7Wx14
 sSp0xnfK0t8KPP6LTjKApW57IZC7RuNUj3a/uaWgYdU+b9HtyB3aeblmr
 BrZvgSPNo7dHsxLeU1gs7RyoJ9xjFnqUabIRGEdgJiKCGp9Y9v+WtRLaM
 78LTZgtXw080TpGpbHtYjJ7bDkQxS737TXA4bUQmBvVdt9AAwBwMxF91O Q==;
IronPort-SDR: ano407McD//KZrd9gURjFVxGxyGJgF3K8iWvRkW3RSrSSom4szOGcUDmK5h8LPC9E7J7uBTIwe
 O6L6uLfv/Z5tnodipFGIjnSew+pA1QP8GcSA4u83rqht+4GDRdDggjx8Hn6Jy4RP01cEcx8qmU
 +b9S9XImnV9KhPEJEXnDdheiLDr5jKKXtdSvxchrSAEowE0N6cAIe6VIy/4rlHLrw9WNFSdRcu
 EM/bPnFaigKwuROS+w9kI9dGEYap90iO7E6BzA1e5gD1xXijqEVCh13Z5hueOWCAr4BgXqsSwa
 ef0=
X-IronPort-AV: E=Sophos;i="5.75,307,1589212800"; d="scan'208";a="142893387"
Received: from mail-bn8nam12lp2175.outbound.protection.outlook.com (HELO
 NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.175])
 by ob1.hgst.iphmx.com with ESMTP; 03 Jul 2020 12:56:33 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M1kHLleN5dh7ph5iRkr6MkmBUZDXgBgqIx0mDjX/KVFgy3D3syqANu4NXdwgnwX8BAJYvEQshp31QxDkeq1VFojSZP7UxRhmo7p8uEo/GXqiuzYOJU+ceH4xEZr5bIGAvEV4J5RVdxwo5AIflYRFnSljPiz6DPhgLcg6YbDUvIHfu5dwpUIuOCsd6mW+5dJQ8cJOtPKVtat8Z+njcpvIEJkk/x3lwgUOHvpbt2RAk2xtf6+ZbtSZBy2B8mtmA9Bi7P6nq1us5S0dQ09Mu/jsnR8yy3R+lhaG5QI7/zgL6IFxa63AjIPbpj/sOW4pSmu30CrAG8qtHdNePZ4Bm6HHqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4mdNtbUiwC9Yhmh/e0pgmoxhjYDXsi3haiRo32ldkTU=;
 b=AKKDZdX1UOw/4+f7cW824MCYRzdYrW3YEUuP9IId1D4+TwSnr2c+piGEebf+RVR0To6BRruA1JeFQ8KXB8nSEXgUM5DDBOOrYHbVbNg+oJCSM8WdgBc2d9QBF3sGNus/v+Zz6WzcF7FSKreha1jVTYObQJbyfTCUWfwn1HTfpyQv8rPGIERGUVKCs01fjH6EYJzgU0y1zJOTFjBA3010CkZRBmZvr2wiQ2jjJz4KbgeakaEpCm6if+HV1HojYEjFhRn0bDETMfmOaZ3thg6rMrLERnb7IXn7uR9QDWU+CNVSDl0Eeo7TCweFfbmIrBJJ03f0pK4Q/yj/PDMoTB5XmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4mdNtbUiwC9Yhmh/e0pgmoxhjYDXsi3haiRo32ldkTU=;
 b=a+XXW0uVfzxJjXy6Y94HBXzYQD6E8bb0ai0TgRn3J3d1VgghNcYefKsGWMIH5NFpBzs+ebWQqmTo86Bq4XpoBgxMY0xRIVt6nZ+5YjL7wT5/zNWwP6NVRXS4vMEO97+e/4OGbDfaocaan9QQmOVyhbwGOLtdYJnI6ldf/bcRk6c=
Received: from CY4PR04MB3751.namprd04.prod.outlook.com (2603:10b6:903:ec::14)
 by CY4PR0401MB3585.namprd04.prod.outlook.com (2603:10b6:910:8a::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.25; Fri, 3 Jul
 2020 04:56:31 +0000
Received: from CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::c593:f271:eebe:ac7]) by CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::c593:f271:eebe:ac7%9]) with mapi id 15.20.3153.022; Fri, 3 Jul 2020
 04:56:30 +0000
From: Damien Le Moal <Damien.LeMoal@wdc.com>
To: Niklas Cassel <Niklas.Cassel@wdc.com>
Subject: Re: [PATCH 1/2] block: add max_open_zones to blk-sysfs
Thread-Topic: [PATCH 1/2] block: add max_open_zones to blk-sysfs
Thread-Index: AQHWQ8jtlLWiiEumE0+QMSt8tXUnYw==
Date: Fri, 3 Jul 2020 04:56:30 +0000
Message-ID: <CY4PR04MB37519F9526D1A28797271BF6E76A0@CY4PR04MB3751.namprd04.prod.outlook.com>
References: <20200616102546.491961-1-niklas.cassel@wdc.com>
 <20200616102546.491961-2-niklas.cassel@wdc.com>
 <CY4PR04MB3751C2C03ACCA263541DA348E76F0@CY4PR04MB3751.namprd04.prod.outlook.com>
 <20200702123755.GA609677@localhost.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.182.57]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1a93abd7-8f1f-477f-049e-08d81f0d73bd
x-ms-traffictypediagnostic: CY4PR0401MB3585:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR0401MB35850DB4FFADBB27C1A0D002E76A0@CY4PR0401MB3585.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 045315E1EE
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Eg48BgDgvwScqr+M2Amlv83GPo16c5u9alcA6Atv/HT97d/soxLiNoWd2KsBrEpUNEo3zFcVRhoIjmRZgufg2saP5vOEyqhENOOz/kz4+fjTbeDYCe2riZUuJdryyF9+23ICHv59UBCMTvguvawGp+di7qGbLCB+8pmIpxzlk0JB7pZPgpzIn1pY+4qPtLrZwBvHRZNvWU79ZEROdCMg4qrixH0DGs4BCQ3dVWEvBqOft9hvXDMIzZ01IGh/TqxLb1hr7abGAoCIjcXNBOO7RCkIA7/xma4kSE3ZHXkdaXsAR99Q7C56hCgtYbeQ7nhyjvIrZu4MvGCr6uCLNLtFD7k9uDTShbyeJVd1p3IS3St0z8nPh8WETwqX9hYSgSb7Ky45Z+j+hRHcqKKqrjtOXQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR04MB3751.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(136003)(366004)(39860400002)(346002)(376002)(91956017)(66446008)(86362001)(5660300002)(966005)(6506007)(7696005)(83380400001)(6636002)(2906002)(53546011)(33656002)(4326008)(316002)(54906003)(6862004)(52536014)(478600001)(186003)(9686003)(66946007)(76116006)(8936002)(64756008)(66476007)(66556008)(71200400001)(8676002)(55016002)(7416002)(26005);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: WuPkD1+l+47whSJOe556ImU2K2lm37WlY0ZUL2cg3CP2E+ZhsE/DRITI5ZFf6DZUDvzNpjwMwWwyqTcgC4mDCEGsXEwlD8xydaS+TYO0NkpHtiAUI5DgEWNxQ++R4/PqIq6dS90oF9EqVAKySjqkY1z9eJgmPWuW/aV2xWLjJJen2LAZepXe4H27IYkPmAtXiv9BiA57AVjzEXOZGC1TuqzHkPzFFjXOqQ941Z2Ato2Aij7I1gYvFPuwyb/TfzBJyMDNPbQW7d/GgAxzJOCleB0Z7AEVGs8jzYzDquQdKA78jiQBv38hAhGNxJZbpU9NjXhhm7r+MF3RpXaA+d+ymKZN1NSZTV6jBnTk6RFLvIWDhohjKQkmyQcnKJUbfNLqAsNDSM4yASyCuqhtO7Z6/IKmFoy9/VSVjZmGZ6Tu8Ih/lojCX8562OOGFfw9XtkqiKiUb/i4rXjFXeEf21tc5LIdbI289PiK0nyoU2/FULeNp6rauMg7FABPYdJtYiqH
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR04MB3751.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a93abd7-8f1f-477f-049e-08d81f0d73bd
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jul 2020 04:56:30.8359 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4wdi2oI7Sgrnw4ELyS4rsFed9K68EVg4o72HyLPI7I+TXdFjgzrJeosfIZ8NHp3p2g5GA9kJ1b+3KPiCViZBpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR0401MB3585
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200703_005636_726121_17DE94C4 
X-CRM114-Status: GOOD (  19.43  )
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
Cc: Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>, "Martin K.
 Petersen" <martin.petersen@oracle.com>, Jonathan Corbet <corbet@lwn.net>,
 "James E.J. Bottomley" <jejb@linux.ibm.com>,
 "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
 Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 2020/07/02 21:37, Niklas Cassel wrote:
> On Tue, Jun 30, 2020 at 01:49:41AM +0000, Damien Le Moal wrote:
>> On 2020/06/16 19:28, Niklas Cassel wrote:
>>> diff --git a/drivers/nvme/host/zns.c b/drivers/nvme/host/zns.c
>>> index c08f6281b614..af156529f3b6 100644
>>> --- a/drivers/nvme/host/zns.c
>>> +++ b/drivers/nvme/host/zns.c
>>> @@ -82,6 +82,7 @@ int nvme_update_zone_info(struct gendisk *disk, struct nvme_ns *ns,
>>>  
>>>  	q->limits.zoned = BLK_ZONED_HM;
>>>  	blk_queue_flag_set(QUEUE_FLAG_ZONE_RESETALL, q);
>>> +	blk_queue_max_open_zones(q, le32_to_cpu(id->mor) + 1);
>>>  free_data:
>>>  	kfree(id);
>>>  	return status;
>>> diff --git a/drivers/scsi/sd_zbc.c b/drivers/scsi/sd_zbc.c
>>> index 183a20720da9..aa3564139b40 100644
>>> --- a/drivers/scsi/sd_zbc.c
>>> +++ b/drivers/scsi/sd_zbc.c
>>> @@ -717,6 +717,10 @@ int sd_zbc_read_zones(struct scsi_disk *sdkp, unsigned char *buf)
>>>  	/* The drive satisfies the kernel restrictions: set it up */
>>>  	blk_queue_flag_set(QUEUE_FLAG_ZONE_RESETALL, q);
>>>  	blk_queue_required_elevator_features(q, ELEVATOR_F_ZBD_SEQ_WRITE);
>>> +	if (sdkp->zones_max_open == U32_MAX)
>>> +		blk_queue_max_open_zones(q, 0);
>>> +	else
>>> +		blk_queue_max_open_zones(q, sdkp->zones_max_open);
>>
>> This is correct only for host-managed drives. Host-aware models define the
>> "OPTIMAL NUMBER OF OPEN SEQUENTIAL WRITE PREFERRED ZONES" instead of a maximum
>> number of open sequential write required zones.
>>
>> Since the standard does not actually explicitly define what the value of the
>> maximum number of open sequential write required zones should be for a
>> host-aware drive, I would suggest to always have the max_open_zones value set to
>> 0 for host-aware disks.
> 
> Isn't this already the case?
> 
> At least according to the comments:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/scsi/sd_zbc.c?h=v5.8-rc3#n555
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/scsi/sd_zbc.c?h=v5.8-rc3#n561
> 
> We seem to set
> 
> sdkp->zones_max_open = 0;
> 
> for host-aware, and
> 
> sdkp->zones_max_open = get_unaligned_be32(&buf[16]);
> 
> for host-managed.
> 
> So the blk_queue_max_open_zones(q, sdkp->zones_max_open) call in
> sd_zbc_read_zones() should already export this new sysfs property
> as 0 for host-aware disks.

Oh, yes ! You are absolutely right. Forgot about that code :)
Please disregard this comment.

> 
> 
> Kind regards,
> Niklas
> 
>>
>>>  	nr_zones = round_up(sdkp->capacity, zone_blocks) >> ilog2(zone_blocks);
>>>  
>>>  	/* READ16/WRITE16 is mandatory for ZBC disks */
>>> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
>>> index 8fd900998b4e..2f332f00501d 100644
>>> --- a/include/linux/blkdev.h
>>> +++ b/include/linux/blkdev.h
>>> @@ -520,6 +520,7 @@ struct request_queue {
>>>  	unsigned int		nr_zones;
>>>  	unsigned long		*conv_zones_bitmap;
>>>  	unsigned long		*seq_zones_wlock;
>>> +	unsigned int		max_open_zones;
>>>  #endif /* CONFIG_BLK_DEV_ZONED */
>>>  
>>>  	/*
>>> @@ -729,6 +730,17 @@ static inline bool blk_queue_zone_is_seq(struct request_queue *q,
>>>  		return true;
>>>  	return !test_bit(blk_queue_zone_no(q, sector), q->conv_zones_bitmap);
>>>  }
>>> +
>>> +static inline void blk_queue_max_open_zones(struct request_queue *q,
>>> +		unsigned int max_open_zones)
>>> +{
>>> +	q->max_open_zones = max_open_zones;
>>> +}
>>> +
>>> +static inline unsigned int queue_max_open_zones(const struct request_queue *q)
>>> +{
>>> +	return q->max_open_zones;
>>> +}
>>>  #else /* CONFIG_BLK_DEV_ZONED */
>>>  static inline unsigned int blk_queue_nr_zones(struct request_queue *q)
>>>  {
>>> @@ -744,6 +756,14 @@ static inline unsigned int blk_queue_zone_no(struct request_queue *q,
>>>  {
>>>  	return 0;
>>>  }
>>> +static inline void blk_queue_max_open_zones(struct request_queue *q,
>>> +		unsigned int max_open_zones)
>>> +{
>>> +}
>>
>> Why is this one necessary ? For the !CONFIG_BLK_DEV_ZONED case, no driver should
>> ever call this function.
> 
> Will remove in v2.
> 


-- 
Damien Le Moal
Western Digital Research

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
