Return-Path: <SRS0=73dC=AL=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7143FC433E0
	for <linux-nvme@archiver.kernel.org>; Tue, 30 Jun 2020 02:17:40 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 304182078B
	for <linux-nvme@archiver.kernel.org>; Tue, 30 Jun 2020 02:17:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="RR/omZWB";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="k4w4KLo/";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="r7oBKRXC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 304182078B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=OmlGTz6zDFeiDp5RnOttKyb+AX9g2rUfohwzRjGPfUo=; b=RR/omZWB5J6gbNoEkEuLTJA6a
	/27sv9cFn2eiWWhlkXm7CgFpZX2ojHlbqJl7rZMn3C91T0jp4o1R8EPGvPydf7OTir124c9qWC7or
	DkICLTbbOcSaCTRiJsbBUEh4HpInHGXDW+OE8pDEHOw/vJA+Ms2XP83OfYKuUUKVAegKM3iJfkWqp
	3D5jCkLBcmeQPJ9aQyRt+RUhZZS5DvW6dt+VD4GTf9GV37vFAduQkMAWwWXWBp5PSkReRg7yCoI8W
	kzV075DX4pA0+aV2sSSS67uizqKh3gk3JK00GfphlHSiE/YEi9xdstIeRQELjEtw9mrUUMvztJVpi
	tTETXQ91Q==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jq5q4-0000wW-Kj; Tue, 30 Jun 2020 02:17:36 +0000
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jq5q1-0000vv-Pb
 for linux-nvme@lists.infradead.org; Tue, 30 Jun 2020 02:17:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1593483454; x=1625019454;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=qQy6BsmzxHpiBSC3/+rlBRsH2Bbm74Pxi3v73AJacKY=;
 b=k4w4KLo/uCKNiWG5cV4CqYrSwC69zXRBWevjyQ/RKiipJza8llxfqGBm
 QpEgxSmwhC/wx01Xg3lgZf3Bo8ZgeG8rQVem9dPrt+5wRphw0JGt5TEub
 mUEuU3LQsXzhxd9UEmxugt75YUAQorgeemK2N2H0Dc+S4CpExjDL1pzce
 8LcpECC2VFFPR1biCIO0XtsStqdU3DoDAKU0Qr0ZotS+yEbiMxNV8PALs
 LvsjFm+oZR4AP5fHZK5zWxUbEo3YoXfJMwE/8cogwoEgLWMab/ShV1IuA
 ReDnGg+FMQ0ySieMi+CpwdCHnKHXzyZG9ua/NH9qjpXnWP/rTKRXEnPOa w==;
IronPort-SDR: Bekc53BuuaZoqiza1RWAOxY9AwyE3F9eXCXVLr/rINe18GrGNyBNqt3argWlYmFspFQmK6W/q1
 x/3FmiDDY4V/J4vGJOD84CqZAJqxAOW6Fs1zs+iogp2If9KLWIaU108nG3kESeNTCOQ7T65Jil
 E7cy8XBjVnXXli4haII3FwK9CLhv9tQenyOT82QAITNMkYlsNdXrn5PA+A6sfewR6Nx4EC7xr6
 +bqj4T1sDj0gfmgbLjzbHjFdL2nahVQ8UxlU905hxGGD4qOZ5Gxhl/ljlizI/hkEJ6rlRYka/x
 /64=
X-IronPort-AV: E=Sophos;i="5.75,296,1589212800"; d="scan'208";a="145556204"
Received: from mail-bn8nam12lp2173.outbound.protection.outlook.com (HELO
 NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.173])
 by ob1.hgst.iphmx.com with ESMTP; 30 Jun 2020 10:17:30 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DdvrpgEZgUbVeK5ajVGraEOGcwnvrSgkCiX+KlggIAbXSNxJgqJmMIiU7is92Amo189ls+S3Ay2HET1si7UG7Wc1bmzEf81uOJ5s40rpwxn6xNiTvwTayRRys/AaIHuWMw9J6Ll+Z0q00egxpU2Yq7Ox22QreOj0bCZpo0OsG6BbfmvviwOrAji4amc++0P2tg9vGjCj/4qebL+nbjLTbFBRHY0z7cuPBYmFzOgbqGuOXiIgXT4kW5S0xa+JBIb9PCF6YPbdhh+MU/R7c7EJPYf84h0esvphu04AF6FrVxbURSxMRSHCJBDLUYVLCagIr/9WneZEKfvlz1qm15fpjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HPf5TterA0xKCq7OFJvncAJZ1pt/7XqBpDd/5TdKgIM=;
 b=F9KIGt+brbtrlAIAg5z3SGfMCN0tb+9QCZVxYhq6IILQsu59hxH3gUUnPLq3EcAMrBDYzZ7iRt4CG2Qgg6WkvvUj4f+BRCsh4BXNlSi8l7Ul0bsCKNgnHqRobIQbz4cZW0OY0LEsXS5Huis0S5jGvMQebSxHQ+XLc9F70ue5P6qFZiH9svLBFTRX3K2Vv09w5Eyd1E+oZLqpMv64uErKw/QEibo2JMwfVGdhyCTPvjr3R845Ms3GwORswu3Ld3G0FWHCKKOlJgxOtUcOm0b3QyvyziNaJI8WrThJKxf47MDZxr4wtwJcnWGo12E957QWdJbbehqULJK8cActMlV34Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HPf5TterA0xKCq7OFJvncAJZ1pt/7XqBpDd/5TdKgIM=;
 b=r7oBKRXC/SziRhuke+V4t7hJUhBaVFYQgcMTsWdglUBy5xBiscRz/oeiAgdMAzl49Mfd1fbNNx+OptHu3lAc0MTw1Xh1+sOZ3gcYSqtvrtkfa44x73w95d0kMqHFVQ549jS8VakuKdOM0G7/w4tYlqKBkaB1hKXnds0vchnTyEw=
Received: from CY4PR04MB3751.namprd04.prod.outlook.com (2603:10b6:903:ec::14)
 by CY4PR04MB1032.namprd04.prod.outlook.com (2603:10b6:910:50::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.23; Tue, 30 Jun
 2020 02:17:28 +0000
Received: from CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::c593:f271:eebe:ac7]) by CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::c593:f271:eebe:ac7%9]) with mapi id 15.20.3131.024; Tue, 30 Jun 2020
 02:17:28 +0000
From: Damien Le Moal <Damien.LeMoal@wdc.com>
To: Niklas Cassel <Niklas.Cassel@wdc.com>, Jonathan Corbet <corbet@lwn.net>,
 Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>, Christoph
 Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, "James E.J.
 Bottomley" <jejb@linux.ibm.com>, "Martin K. Petersen"
 <martin.petersen@oracle.com>
Subject: Re: [PATCH 1/2] block: add max_open_zones to blk-sysfs
Thread-Topic: [PATCH 1/2] block: add max_open_zones to blk-sysfs
Thread-Index: AQHWQ8jtlLWiiEumE0+QMSt8tXUnYw==
Date: Tue, 30 Jun 2020 02:17:28 +0000
Message-ID: <CY4PR04MB375135B0E421C421EBAD3C06E76F0@CY4PR04MB3751.namprd04.prod.outlook.com>
References: <20200616102546.491961-1-niklas.cassel@wdc.com>
 <20200616102546.491961-2-niklas.cassel@wdc.com>
 <CY4PR04MB3751C2C03ACCA263541DA348E76F0@CY4PR04MB3751.namprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.47.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 32c6fa78-8a8c-4ecf-86eb-08d81c9bbccb
x-ms-traffictypediagnostic: CY4PR04MB1032:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR04MB10328CB3778F25695BED2BBAE76F0@CY4PR04MB1032.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0450A714CB
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: //u+AGoqWn4r/0txNg2HiPZ9P+U6YV8tZUJdPMTO7sKGnReVO7gY9CVhYef70FmcxrhlBxbgGxNkApGmH1pRrZTG2c7IVuw3l2SYFKI4xVGsvCXM4VtZDi4RAa6aVbawdqN4+1IOqF/TnCAkN3r/ChGnjDC9WO0dmMxodCXaTmzjLR+71TG/N23e8CkTREvF2SLONEsZ0TMJ0mJh6+ctYg5ULHlG5aLsdi0Qlc/BJU65sAyYgjYTvfpwH+KhBzKBEc4lYnaj/iyiTnAOVVUBPGEHNsBYdS+wA3NCFZsZirgaOVLYn12OL3FOA9GY4fUJbHiUpJSvoDXPbELVoeoiCQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR04MB3751.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39860400002)(136003)(396003)(376002)(346002)(366004)(4326008)(2906002)(8676002)(54906003)(71200400001)(110136005)(316002)(8936002)(5660300002)(478600001)(83380400001)(7416002)(186003)(6506007)(53546011)(33656002)(9686003)(52536014)(26005)(7696005)(76116006)(66446008)(64756008)(66556008)(66476007)(91956017)(55016002)(66946007)(86362001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: KQsI6L3FEarlL39CaJf2VCp0dvdyIU8LCg0a0IcPhOyePwGOQZMP0EuoxmKVjUGOiaziJ1mkh5D3XJx0u+hhsW4/+wkV9uw4A0d8QE3fbYbhvd0UBj82KWgYsfKPX2ygr5WNWeDQ2HYXDD1H9bZJNrh9fCBOrZIhwf3VESr6Jue3kjOJnmOK0IbuOXUOfp6pcAzKSbO20jVts81fJqpGbEw8eW39WI2U7DAogz4Ss5STDGwDkEEyESr93PtZDzSy90oBgw5g3jP4Dirz7N+tTtqpcdBbThqcOAjeO2opTLx3LYeTVh2SjxQZPZiorbxM2hSXoSG+fxPIPl+F3foJPhhhNFx64YpEGiC5TllOSh5YvTAsN+ewbmJEglyec25VouM2mc6T+hKET2lbJR0A5DbR6KJyB7Vbwi06rgSwD+hvCEursgcLFhnlUeU31CWyTDUSN8TQ15PL6VS/8qpIY6VVYK6kZPGn5yGqm8w+Tec=
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR04MB3751.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32c6fa78-8a8c-4ecf-86eb-08d81c9bbccb
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jun 2020 02:17:28.5468 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: suJGY+u8SS0pZ6HoW2lowzZ3nmlfdhhdavNt1p494bqnXcY8R+ZdG3inrmDeN88togLT4vJOkPUE6Pnx3xtbjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR04MB1032
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
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 2020/06/30 10:49, Damien Le Moal wrote:
> On 2020/06/16 19:28, Niklas Cassel wrote:
>> Add a new max_open_zones definition in the sysfs documentation.
>> This definition will be common for all devices utilizing the zoned block
>> device support in the kernel.
>>
>> Export max open zones according to this new definition for NVMe Zoned
>> Namespace devices, ZAC ATA devices (which are treated as SCSI devices by
>> the kernel), and ZBC SCSI devices.
>>
>> Add the new max_open_zones struct member to the request_queue, rather
> 
> Add the new max_open_zones member to struct request_queue...
> 
>> than as a queue limit, since this property cannot be split across stacking
>> drivers.
> 
> But device-mapper target device have a request queue too and it looks like your
> patch is not setting any value, using the default 0 for dm-linear and dm-flakey.
> Attaching the new attribute directly to the request queue rather than adding it
> as part of the queue limits seems odd. Even if DM case is left unsupported
> (using the default 0 = no limit), it may be cleaner to add the field as part of
> the limit struct.
> 
> Adding the field as a device attribute rather than a queue limit, similarly to
> the device maximum queue depth would be another option. In such case, including
> the field directly as part of the request queue makes more sense.

Thinking more about this one, struct request_queue has nr_zones field, which is
not a queue limit but still exported as a queue attribute. Device mapper
exposing a zoned drive target do set this field manually. So I guess the same
approach is valid for max_open_zones (and max_active_zones). So OK, disregard
this comment.

The other comments I sent below remain though.

> 
>>
>> Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>
>> ---
>>  Documentation/block/queue-sysfs.rst |  7 +++++++
>>  block/blk-sysfs.c                   | 15 +++++++++++++++
>>  drivers/nvme/host/zns.c             |  1 +
>>  drivers/scsi/sd_zbc.c               |  4 ++++
>>  include/linux/blkdev.h              | 20 ++++++++++++++++++++
>>  5 files changed, 47 insertions(+)
>>
>> diff --git a/Documentation/block/queue-sysfs.rst b/Documentation/block/queue-sysfs.rst
>> index 6a8513af9201..f01cf8530ae4 100644
>> --- a/Documentation/block/queue-sysfs.rst
>> +++ b/Documentation/block/queue-sysfs.rst
>> @@ -117,6 +117,13 @@ Maximum number of elements in a DMA scatter/gather list with integrity
>>  data that will be submitted by the block layer core to the associated
>>  block driver.
>>  
>> +max_open_zones (RO)
>> +-------------------
>> +For zoned block devices (zoned attribute indicating "host-managed" or
>> +"host-aware"), the sum of zones belonging to any of the zone states:
>> +EXPLICIT OPEN or IMPLICIT OPEN, is limited by this value.
>> +If this value is 0, there is no limit.
>> +
>>  max_sectors_kb (RW)
>>  -------------------
>>  This is the maximum number of kilobytes that the block layer will allow
>> diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
>> index 02643e149d5e..fa42961e9678 100644
>> --- a/block/blk-sysfs.c
>> +++ b/block/blk-sysfs.c
>> @@ -305,6 +305,11 @@ static ssize_t queue_nr_zones_show(struct request_queue *q, char *page)
>>  	return queue_var_show(blk_queue_nr_zones(q), page);
>>  }
>>  
>> +static ssize_t queue_max_open_zones_show(struct request_queue *q, char *page)
>> +{
>> +	return queue_var_show(queue_max_open_zones(q), page);
>> +}
>> +
>>  static ssize_t queue_nomerges_show(struct request_queue *q, char *page)
>>  {
>>  	return queue_var_show((blk_queue_nomerges(q) << 1) |
>> @@ -667,6 +672,11 @@ static struct queue_sysfs_entry queue_nr_zones_entry = {
>>  	.show = queue_nr_zones_show,
>>  };
>>  
>> +static struct queue_sysfs_entry queue_max_open_zones_entry = {
>> +	.attr = {.name = "max_open_zones", .mode = 0444 },
>> +	.show = queue_max_open_zones_show,
>> +};
>> +
>>  static struct queue_sysfs_entry queue_nomerges_entry = {
>>  	.attr = {.name = "nomerges", .mode = 0644 },
>>  	.show = queue_nomerges_show,
>> @@ -765,6 +775,7 @@ static struct attribute *queue_attrs[] = {
>>  	&queue_nonrot_entry.attr,
>>  	&queue_zoned_entry.attr,
>>  	&queue_nr_zones_entry.attr,
>> +	&queue_max_open_zones_entry.attr,
>>  	&queue_nomerges_entry.attr,
>>  	&queue_rq_affinity_entry.attr,
>>  	&queue_iostats_entry.attr,
>> @@ -792,6 +803,10 @@ static umode_t queue_attr_visible(struct kobject *kobj, struct attribute *attr,
>>  		(!q->mq_ops || !q->mq_ops->timeout))
>>  			return 0;
>>  
>> +	if (attr == &queue_max_open_zones_entry.attr &&
>> +	    !blk_queue_is_zoned(q))
>> +		return 0;
>> +
>>  	return attr->mode;
>>  }
>>  
>> diff --git a/drivers/nvme/host/zns.c b/drivers/nvme/host/zns.c
>> index c08f6281b614..af156529f3b6 100644
>> --- a/drivers/nvme/host/zns.c
>> +++ b/drivers/nvme/host/zns.c
>> @@ -82,6 +82,7 @@ int nvme_update_zone_info(struct gendisk *disk, struct nvme_ns *ns,
>>  
>>  	q->limits.zoned = BLK_ZONED_HM;
>>  	blk_queue_flag_set(QUEUE_FLAG_ZONE_RESETALL, q);
>> +	blk_queue_max_open_zones(q, le32_to_cpu(id->mor) + 1);
>>  free_data:
>>  	kfree(id);
>>  	return status;
>> diff --git a/drivers/scsi/sd_zbc.c b/drivers/scsi/sd_zbc.c
>> index 183a20720da9..aa3564139b40 100644
>> --- a/drivers/scsi/sd_zbc.c
>> +++ b/drivers/scsi/sd_zbc.c
>> @@ -717,6 +717,10 @@ int sd_zbc_read_zones(struct scsi_disk *sdkp, unsigned char *buf)
>>  	/* The drive satisfies the kernel restrictions: set it up */
>>  	blk_queue_flag_set(QUEUE_FLAG_ZONE_RESETALL, q);
>>  	blk_queue_required_elevator_features(q, ELEVATOR_F_ZBD_SEQ_WRITE);
>> +	if (sdkp->zones_max_open == U32_MAX)
>> +		blk_queue_max_open_zones(q, 0);
>> +	else
>> +		blk_queue_max_open_zones(q, sdkp->zones_max_open);
> 
> This is correct only for host-managed drives. Host-aware models define the
> "OPTIMAL NUMBER OF OPEN SEQUENTIAL WRITE PREFERRED ZONES" instead of a maximum
> number of open sequential write required zones.
> 
> Since the standard does not actually explicitly define what the value of the
> maximum number of open sequential write required zones should be for a
> host-aware drive, I would suggest to always have the max_open_zones value set to
> 0 for host-aware disks.
> 
>>  	nr_zones = round_up(sdkp->capacity, zone_blocks) >> ilog2(zone_blocks);
>>  
>>  	/* READ16/WRITE16 is mandatory for ZBC disks */
>> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
>> index 8fd900998b4e..2f332f00501d 100644
>> --- a/include/linux/blkdev.h
>> +++ b/include/linux/blkdev.h
>> @@ -520,6 +520,7 @@ struct request_queue {
>>  	unsigned int		nr_zones;
>>  	unsigned long		*conv_zones_bitmap;
>>  	unsigned long		*seq_zones_wlock;
>> +	unsigned int		max_open_zones;
>>  #endif /* CONFIG_BLK_DEV_ZONED */
>>  
>>  	/*
>> @@ -729,6 +730,17 @@ static inline bool blk_queue_zone_is_seq(struct request_queue *q,
>>  		return true;
>>  	return !test_bit(blk_queue_zone_no(q, sector), q->conv_zones_bitmap);
>>  }
>> +
>> +static inline void blk_queue_max_open_zones(struct request_queue *q,
>> +		unsigned int max_open_zones)
>> +{
>> +	q->max_open_zones = max_open_zones;
>> +}
>> +
>> +static inline unsigned int queue_max_open_zones(const struct request_queue *q)
>> +{
>> +	return q->max_open_zones;
>> +}
>>  #else /* CONFIG_BLK_DEV_ZONED */
>>  static inline unsigned int blk_queue_nr_zones(struct request_queue *q)
>>  {
>> @@ -744,6 +756,14 @@ static inline unsigned int blk_queue_zone_no(struct request_queue *q,
>>  {
>>  	return 0;
>>  }
>> +static inline void blk_queue_max_open_zones(struct request_queue *q,
>> +		unsigned int max_open_zones)
>> +{
>> +}
> 
> Why is this one necessary ? For the !CONFIG_BLK_DEV_ZONED case, no driver should
> ever call this function.
> 
>> +static inline unsigned int queue_max_open_zones(const struct request_queue *q)
>> +{
>> +	return 0;
>> +}
>>  #endif /* CONFIG_BLK_DEV_ZONED */
>>  
>>  static inline bool rq_is_sync(struct request *rq)
>>
> 
> 


-- 
Damien Le Moal
Western Digital Research

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
