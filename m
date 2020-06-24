Return-Path: <SRS0=WpAz=AF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD84EC433DF
	for <linux-nvme@archiver.kernel.org>; Wed, 24 Jun 2020 22:45:12 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F08D2065D
	for <linux-nvme@archiver.kernel.org>; Wed, 24 Jun 2020 22:45:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="vAmejqBG";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="o8LNP4Ge";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="E0Avt7uG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F08D2065D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=Q+uY9YYk4z+Fg687R8VeFeO/QsqXZFrx9twgsbC0DMY=; b=vAmejqBGPc4gnVXnH7tBl2FSL
	D2tt4gVPGAFN7DVYPEKZZHgSAP/9SRraSsu+S4M3ecMy9Paay6XmsirmFxTeKK7A55qgM/sIqtbqa
	bnCjfA3Jfn4guq7DYWvUExyFbGGiWdDw1Utreb9cm/B6breDd0eqbELHZ2oHmxFIDBVmb++lYSBES
	U1XmrLkqawOhrSztAavRq4US7eP/7Xep8ODbF57iBSWvJVOq+J0Lw41dmkXTx2aROx2pWKv9m0AmC
	xOx8X9LFp5xURccJxLfzvVJy0lVv9PQom1hx/hbYn+PFHbSQWJHXOYNzPL1pEcvF9Hju9Uq5NPC6G
	9y1RC3lxQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1joE8j-00057m-LG; Wed, 24 Jun 2020 22:45:09 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1joE8g-00054y-Tj
 for linux-nvme@lists.infradead.org; Wed, 24 Jun 2020 22:45:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1593038707; x=1624574707;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=kR1zPCtvRTb8QwSRy3RVvMLbXTiVpAC8xFH9Gjvkdec=;
 b=o8LNP4GeObpmr5/agYqdZkPxTGK4yps65WV2sryZ+WH0PYTjX6G8KrRR
 JggBHxdp7JWliV/zC0e5SD3QYbfOzaCq2VStYUCBrMhmdaH+KOt6SQjBW
 L4J+aYm5+t1yTu0VysSmn/BOofyWq5aouxpCtwM9rZ7f3wlV5jgqvIBZc
 CPoVb2DUGBMgRjKjcAwZpkfIMAbXXiwunenSSjrGzpi86Z8ZTcm6+ONlv
 n5bbShtAO/iliN/jJ6UMsHub/8khBkQbYk76SrKlfzf1bze2rTJuDez40
 QIC6cbsAufWoG6eNQUhxZyQy++FpsSZDW6supwo1fbw+K1G/+MJA/5K3V w==;
IronPort-SDR: 74PQLI+uqz1xA0twDFY5nrzAQSFh8pJUpSNUYaLI6cuJFaneeG55E6nljBHR9vqsRx9ZT+jdX8
 uzbgplUjnEl1e2cXlwWtZ4L9OnsV4VSwY2wP8zYobDuAwfmNeSddwKPTZ6w4FlhxkofgYP/36e
 361Jzw5DcIQ83l2Nm/vNzN9mivm8uqvBfxDY6QeL3RmxOGGuefm0Ug/n0IssmqggBfXoQRJKA7
 /weN1UwQVueUkvz3FPq1WLzghC3gv3wXbMKFmlNMiIOLIUwgapsmPrRPxKmWsZoROGpIXLaqps
 Qx4=
X-IronPort-AV: E=Sophos;i="5.75,276,1589212800"; d="scan'208";a="141083698"
Received: from mail-dm6nam10lp2106.outbound.protection.outlook.com (HELO
 NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.106])
 by ob1.hgst.iphmx.com with ESMTP; 25 Jun 2020 06:45:04 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gY+XQ45Hg62+HfK1ysy9is925KGVdwvQG/c3gMrM06Drg19LvJ0rQwBZsRUbAof4Kd2AQQLc3qVejANZ257ux6mcND8K0nitw3CSNGXt0OQJS71pqzAlp4ZzPLNyS3qNNBy1O1Je6zpiqKHnVrpysCLr6y7oHrl1Vwaim9DqngnwKal0FBwhaHiGBjDfmA4MebyCoGSF6No7uDdAz8OPsI8Zfg+UqSoQtcwy7bl0qggspklwfQBcE9lRHE2z75pgRPfoCZu1kY2uPTsa5nR5+SfiY9Wyo6ReB/f0hjP55ikKyiInNudpHmcnxNSZA2jPE4+7AZTi9sqQMTHnimi5FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V7Vv79/MNCgxDNDUWoUZZfSGk6/yKOjKVwNM85htwdM=;
 b=bZb36d9fj7Un3/9Rmv5ZFUJw+ANh012Xnv7NA+tqQg+E9XXW4DW2e6sWQo0aMCNO52AlHCjLeOOTtCubxSX4GMEUDThwr4g0BTNf5U3m/w5r/8qz1mDC/AJi6B+GAWJn2Hq+lu2Og4RAmkjJBd4tkkDFy+n/JdoFvf9pc5VfbgOYSk+E9QaoTjuR9KT/BmjYkw/NuPT16MiNkMYj24eM+IE72xedif3xILD5jGm4Sk2W80CJWWn4Voj6dTHPIFfgqN+SJ70+L9qDJQWTeZLyZm59w8cYZivOffP9HYGOBETwPt9xCKM/QRooWQJ/HL3oFrtXiVd2y6X6vF0YK/L0FQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V7Vv79/MNCgxDNDUWoUZZfSGk6/yKOjKVwNM85htwdM=;
 b=E0Avt7uGBTBW68pun5R1JmyF0SCeaoShvbYCeYFxzP4qwlc20QPcaVnORKN0KXXgaHblfv/hc4i7dI1BNIqoBhubpI7HEnGPeslOlNskRtLvf9AKhDCXFIaw7u/KaVzPrrKRxQ2qWULWat1RXBaLB+cjUCZw6hLgdgWs3drXong=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB5688.namprd04.prod.outlook.com (2603:10b6:a03:104::33)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22; Wed, 24 Jun
 2020 22:45:02 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::4d72:27c:c075:c5e6]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::4d72:27c:c075:c5e6%7]) with mapi id 15.20.3131.020; Wed, 24 Jun 2020
 22:45:02 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH RFC] block: blktrace framework cleanup
Thread-Topic: [PATCH RFC] block: blktrace framework cleanup
Thread-Index: AQHWSdd4UnyRRkLaf0OG0GWCqlwTUQ==
Date: Wed, 24 Jun 2020 22:45:02 +0000
Message-ID: <BYAPR04MB49653212CE32249C65C0A7F486950@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20200624032752.4177-1-chaitanya.kulkarni@wdc.com>
 <20200624064820.GA17964@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2da5678c-a5a1-4c07-896a-08d818903bbc
x-ms-traffictypediagnostic: BYAPR04MB5688:
x-microsoft-antispam-prvs: <BYAPR04MB5688F1049F95C98C268A176A86950@BYAPR04MB5688.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0444EB1997
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: j+4MxcY8WnjKsKUmBlapaUWawqEinfy/gEFO/vNGPDPwD/kP7uu14AqUgbWYf2eX31WSRDF/EO+6+7uKn0pjGWX8LhR+0x92EgWlborF8GUtsi7A4oaN0MCE8Ql4H1wfhPUrnTodW1B5LDkUPh8YxzVzKwS13C85bMDLKq/3I/ErLL8txTEBAJiKwlsZdI6mQ/hU619q2gHsqWmQzNZc7JeNyv5X4Wk3Vva4ANCI1UZbc4iKuLjjfrtlegt9ofM4vMOQhe3/byglQSqFv5+eOqeVZ/mQu6ED0ioRmdeEmapEuElrK75C72PFNuQNeCLyzQ4+SDwg1qi0r8akcSD7aw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(396003)(39860400002)(346002)(366004)(376002)(52536014)(6506007)(53546011)(6916009)(186003)(86362001)(76116006)(5660300002)(66946007)(83380400001)(26005)(7416002)(66476007)(66556008)(2906002)(33656002)(64756008)(478600001)(66446008)(4326008)(8936002)(8676002)(9686003)(54906003)(55016002)(7696005)(71200400001)(316002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: xRH6Hl8/x2ZZfWilyMV6N26FwonUzrqzknUQKEb3Roqkv7brqIg05UlRFM+Aqq8WSECPQJz00mbEBBEq8ZEDMvX0m42WlqgEIRgvmQ5mTT3MNrOa/DEoo2kcY8LrPdRCswFsMoZsoKYXv3gW/4noY7dhqNLodxGHpx/bN1+MRCcqoNWKvoRPaPICZbMxtBG8TPxf1H8HEn4XuZeDu5C6uddcghlTn3kLjHE6z4VZuOGuq1YolmCPcyowiC2+cmm4h0hidOTtZwlkWYFv8xHZPcP8KYzJmUcQ2t+xEgVkic3/Ew6SEC1uOshqTemDUEFy5MUqPHevbI+7SHQYkuY58frr/2bJXIgHvcIXN9YOir4U+oSmezCxozPCtRLC9ycxyEdNdgRwFcaOJnJudihbcTEl0GX4ola+HVZjA9gPl4eHRBpJjZ9fe4rXTNgb3BWs3lseHhaoyN5nrO3lWHZJDd4usYGiT3NvBp+980PrjHA=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2da5678c-a5a1-4c07-896a-08d818903bbc
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2020 22:45:02.7545 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tTyo8GSALl26+0AKJVSJs4rKDBoz9rSaWieJTbPZS39R8+uKq/9ivDr1ObZk+HasXQP/YByN3KaH9i9zwiABF9nJBi2ZNzrAHZXP+4jrA+0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5688
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
 "snitzer@redhat.com" <snitzer@redhat.com>,
 "rdunlap@infradead.org" <rdunlap@infradead.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "dm-devel@redhat.com" <dm-devel@redhat.com>,
 "mingo@redhat.com" <mingo@redhat.com>,
 "rostedt@goodmis.org" <rostedt@goodmis.org>,
 "kbusch@kernel.org" <kbusch@kernel.org>, "agk@redhat.com" <agk@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 6/23/20 11:48 PM, Christoph Hellwig wrote:
> 
> 
> On Tue, Jun 23, 2020 at 08:27:52PM -0700, Chaitanya Kulkarni wrote:
>> There are many places where trace API accepts the struct request_queue*
>> parameter which can be derived from other function parameters.
>>
>> This patch removes the struct request queue parameter from the
>> blktrace framework and adjusts the tracepoints definition and usage
>> along with the tracing API itself.
> 
> Good idea, and I had a half-ready patch for this already as well.
> 
Well, I sent out the reply to your suggestion didn't get any response so 
I decided to send a patch, if you want we can merge it I'll keep you as 
an author for the right reasons.
> One issue, and two extra requests below:
> 
> 
>>   	if (bio->bi_disk && bio_flagged(bio, BIO_TRACE_COMPLETION)) {
>> -		trace_block_bio_complete(bio->bi_disk->queue, bio);
>> +		trace_block_bio_complete(bio);
> 
> This one can also be called for a different queue than
> bio->bi_disk->queue, so for this one particular tracepoint we'll need
> to keep the request_queue argument.
> 
Yes, we should.
>> diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
>> index fdcc2c1dd178..a3cade16ef80 100644
>> --- a/block/blk-mq-sched.c
>> +++ b/block/blk-mq-sched.c
>> @@ -409,7 +409,7 @@ EXPORT_SYMBOL_GPL(blk_mq_sched_try_insert_merge);
>>   
>>   void blk_mq_sched_request_inserted(struct request *rq)
>>   {
>> -	trace_block_rq_insert(rq->q, rq);
>> +	trace_block_rq_insert(rq);
>>   }
>>   EXPORT_SYMBOL_GPL(blk_mq_sched_request_inserted);
> 
> As a follow on patch we should also remove this function.
> 
Okay will make it is a 2nd patch.
>>   	}
>>   
>>   	spin_lock(&ctx->lock);
>> @@ -2111,7 +2111,7 @@ blk_qc_t blk_mq_make_request(struct request_queue *q, struct bio *bio)
>>   		goto queue_exit;
>>   	}
>>   
>> -	trace_block_getrq(q, bio, bio->bi_opf);
>> +	trace_block_getrq(bio, bio->bi_opf);
> 
> The second argument can be removed as well.  Maybe as another patch.
Okay I'll make it in a 3rd patch.
> 


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
