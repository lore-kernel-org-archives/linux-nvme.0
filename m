Return-Path: <SRS0=TJkX=YV=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E96DFCA9EA0
	for <linux-nvme@archiver.kernel.org>; Mon, 28 Oct 2019 07:26:38 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B9A0920862
	for <linux-nvme@archiver.kernel.org>; Mon, 28 Oct 2019 07:26:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="VOhtPD/l";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="QgDS5v3l";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="V7zWzAJT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9A0920862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date
	:Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=6w/UE6PBiTW6NRZHNOKg2a/rCk1TcuXSqGGLvAHp7+Y=; b=VOhtPD/loZ3a36
	n5Ow4ZDrs9MnTL6mUZjEMKS/8J9dAXUsFiAfUFMGQcisbKfdF+flzRw5gok3kNFnThgKFTxkXPUgP
	S5Dbbx8mwnvBSyfu2PqueBEHE1VjBACYcy7iXcPvwicUnsAoUjUp1BbDOw7rzbh5Rx+kwW8xoj1ps
	zj1GjGmdufbDmyTJfJVE86GHi0PM9SWLxC3zVoLFGRW2VUZB+ppqnkLOuEB2bPeXrAGbWI0FOvSVT
	nfrR4hJrr6unp2ZgdltJN5NocQPJYGZZGdRuIY8+8YkBGiXgYZAt7gp5OQh4cscPLsKd398mcwPQz
	lpTZbUQRMQb+ioFR2MIw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iOzQ0-0001en-Si; Mon, 28 Oct 2019 07:26:24 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iOzPo-0001TQ-DF
 for linux-nvme@lists.infradead.org; Mon, 28 Oct 2019 07:26:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1572247578; x=1603783578;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=maEddrN/UejOPUKhhzxlYeLERr2eIaywkTyveAOYOBE=;
 b=QgDS5v3lRSvd/V9S3H4Lb7suEtdhdvbYV0NywGb3bXnPPJrkpg22OM9i
 Nfi3tHQP+vJ390m+IOaBbPCP61wThlNDQom2TacgJ0gz5NOwTGe/s1f4j
 9Gnav5dDzydTJsSGGRo8LcwoyJ0DwDoZbW95Pdfpi4bSU0G3uYpksh0y+
 Y4Bvh3jwr03oJqgdQ5TfBn3prRcyWXGdTIKdya4UKkCnUej5vTupbjrK5
 Jv9ib0XAQEgwAiSgCRktMbDEh+FhwEUox9kd+GMjIgA8Afv4OrWtGg4vi
 8+Y+N8Q9BbfRAesxnul3Fu7KO3At1UI3SGqS3mkKPCn4ZpIfN/eiNVfMZ g==;
IronPort-SDR: XNtks2YTF4xCP+tkTMDM+1TDkIpkF+SQb39K4kVT0RghfF/9WRE6u4YfeC7/+XrkOAQaiDD6pd
 Smpso31F6NkUCVG9YJBmZx4CSU6Sqf+EarzI5oZiudjd0ixxG1NJHHmt0ADEqfeToXmvoN/T98
 KTsweVf8aShCwupV06I9yuFP0Jbfx/8a3UT3n7zi/8d+B4c23+sFssgdAF7+Kwu+fH4myWuDdt
 IFfSN3itsXDGcQAe+A+bfaVgKmRqxvROBMmxd4aMXlqgBDycRvqY5oRq5jtK4+JRyAAYKEpbf2
 asE=
X-IronPort-AV: E=Sophos;i="5.68,239,1569254400"; d="scan'208";a="222613322"
Received: from mail-co1nam05lp2052.outbound.protection.outlook.com (HELO
 NAM05-CO1-obe.outbound.protection.outlook.com) ([104.47.48.52])
 by ob1.hgst.iphmx.com with ESMTP; 28 Oct 2019 15:26:15 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EWBNtVrzMe79kQ748MXtRouG91i95cxfX5ntaoMKkrC3Zj0X33jLP1DZ4sIvXIRZl3DWKHE943U73k7vOpGTu50u+3i0qx8SVOVAVbpjPfjvNTikK36WLiUPwinsvfZkAtQ1/1lifv+fuI9tYdTV82clp112DTP7t4I9LCpR8yLgJa22qUxLOJ3Ig/TVI/1FneGjxfXTl7u6cc+P3lYDF5sFLG0XAl2r42iir0EitzMbLjJMQXGvlw3gtS4jrjDrfuHOVG/vQ7cA4RytYtcuXIqC0HR5LMEulDGxGG4K9bApipScxKovy32Of+YOxmHlCky3C/cf5WSoG/hmdFJVuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cph1mJG9KYGQvkWrcyO/E6YTAXNMp4LGftNh5JyDySw=;
 b=iTvVn1U1/n/E6wLVyGKrF1mCgsLKnO9wVa/699YVuTrqtJQKIlwIdwYE9AB0Mi/bvAqdaqOIZmvTMEPbSckDgUElhmPXoMoWTZO3qREAo+Bk21c2pyaVFCkW0eQdiBG8+Y9AZ756IzFpEwLOaLKNAmJ8CYLC57h8QovFsfO60UKqtoD0h0XMve2ahfogcqerGuUFBcnjVkmHwvNgvRYUhPMwe9vEwLtlZptq7jLzFC2JRG7K/axAQqCtKUA47CVdXmZeEW2erV3fYIcV+9P39ousJRDRnOCWAxbce+39dud4sDcq2ifKnCQENTDn6XGdU5iPBjKGv38M7u2Tyv7z3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cph1mJG9KYGQvkWrcyO/E6YTAXNMp4LGftNh5JyDySw=;
 b=V7zWzAJTc1U4PvqDPN3jPOkolWDx7ex4RWxh4rVvjnxBr1szQknstK1idCYPfc/m5LpnFCBZCuosrSwr8PZ5AjeF8q01CZRkkWLR/7Y81++udXe3eZXcvWxHCrC7UmXRlLTQkH5ZvHWbqEvyplV7UX/G+ek/OryGCqLniVzpZJk=
Received: from BYAPR04MB5749.namprd04.prod.outlook.com (20.179.57.21) by
 BYAPR04MB5942.namprd04.prod.outlook.com (20.179.59.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.20; Mon, 28 Oct 2019 07:26:09 +0000
Received: from BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::34a1:afd2:e5c1:77c7]) by BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::34a1:afd2:e5c1:77c7%6]) with mapi id 15.20.2387.023; Mon, 28 Oct 2019
 07:26:09 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Keith Busch <kbusch@kernel.org>, "hch@lst.de" <hch@lst.de>
Subject: Re: [PATCH] nvmet: introduce use_vfs ns-attr
Thread-Topic: [PATCH] nvmet: introduce use_vfs ns-attr
Thread-Index: AQHVid7kgFRDrsrFkkeJqDNfcuN3xQ==
Date: Mon, 28 Oct 2019 07:26:09 +0000
Message-ID: <BYAPR04MB5749B0AEC4864326D01EEC5D86660@BYAPR04MB5749.namprd04.prod.outlook.com>
References: <20191023201715.4236-1-chaitanya.kulkarni@wdc.com>
 <20191024020003.GA2148@redsun51.ssa.fujisawa.hgst.com>
 <FA6B6A9F-649B-4B58-99D0-2D09076E2482@onestopsystems.com>
 <20191025040540.GA19941@redsun51.ssa.fujisawa.hgst.com>
 <20191025042658.GB19941@redsun51.ssa.fujisawa.hgst.com>
 <109617B2-CC73-4CDE-B97A-FDDB12CD22BD@onestopsystems.com>
 <20191027150330.GA5843@lst.de>
 <20191028005517.GA6693@redsun51.ssa.fujisawa.hgst.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.44.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8816af8f-0659-4d25-4af4-08d75b781a81
x-ms-traffictypediagnostic: BYAPR04MB5942:
x-microsoft-antispam-prvs: <BYAPR04MB5942F2A13A69004AFC88E2F486660@BYAPR04MB5942.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1824;
x-forefront-prvs: 0204F0BDE2
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(136003)(39860400002)(376002)(396003)(346002)(366004)(189003)(199004)(55016002)(446003)(26005)(53546011)(6506007)(76176011)(102836004)(71200400001)(71190400001)(14444005)(7696005)(256004)(14454004)(186003)(476003)(486006)(2906002)(6116002)(86362001)(478600001)(52536014)(6246003)(66446008)(25786009)(3846002)(66476007)(64756008)(5660300002)(6436002)(66946007)(7736002)(66066001)(305945005)(74316002)(229853002)(9686003)(33656002)(2501003)(8676002)(81156014)(81166006)(99286004)(54906003)(110136005)(4326008)(76116006)(316002)(66556008)(8936002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:BYAPR04MB5942;
 H:BYAPR04MB5749.namprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zE7lUX4TtDJp3O1Vnu5kEA4J7nF2Q34kGIswLS4fMQispN7ul4iEfJOwEIJyMFHepbuUQTmlunowhPfqtinbI9HRayBBwFDfFXWibVTtJRLo1yUgDgxpGLcflvpjNHwGPr25E9wg5Jh1DNt46FTN+0Z2S0tag9MXzOqXEHCdaJk4CWgdhaPpWxapaIP4PMDGbSPC6yLiFnrXNjj57QUQ6mk4buLnpNfqV8Jv155ozECZTxX9ap0v0zzn4ExGpxQySH2ZyjebYiTf+F0NpTk0c8gOqbTirG2DTzNs8/P0cXw8WEpYi9LBVoOgaph0KDH4mFTkv9CQ8/ctu/3TNu8pXmrrmfaDCQi52a39DVPtjfMJ9cdLNuhF4Ui9UOpUh+g5QeIuVve//dlAtpuB2YfNGfFKVsM6N3exCQ3SZRu5uGcOPkyOIcx82y6psqRpXT7t
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8816af8f-0659-4d25-4af4-08d75b781a81
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2019 07:26:09.3269 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ko8t63n3vHqMySZkX51XdAfTjZbRngCV8MP8qJAk0bk7Yeyu7aXy+emMOh0+eh82G8fb44rd2NcbAOMC+656H8ucqb+S6Z2soZ80F+nCD4E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5942
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191028_002612_591503_B2349AD3 
X-CRM114-Status: GOOD (  14.03  )
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
Cc: Mark Ruijter <MRuijter@onestopsystems.com>, Hannes Reinecke <hare@suse.com>,
 "sagi@grimberg.me" <sagi@grimberg.me>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

I've collected the performance numbers with this patch and without
following patch:-

1. With Plugging patch:-
   write: IOPS=43.6k, BW=170MiB/s (179MB/s)(5112MiB/30002msec)
   write: IOPS=42.8k, BW=167MiB/s (175MB/s)(5014MiB/30002msec)

2. Without this patch :-
   write: IOPS=41.5k, BW=162MiB/s (170MB/s)(4861MiB/30003msec)
   write: IOPS=41.1k, BW=160MiB/s (168MB/s)(4813MiB/30002msec)
   cpu          : usr=0.49%, sys=3.66%, ctx=1244502, majf=0, minf=559
   cpu          : usr=0.53%, sys=3.63%, ctx=1232208, majf=0, minf=581
   slat (usec): min=8, max=437, avg=15.63, stdev= 9.92
   slat (usec): min=8, max=389, avg=15.77, stdev=10.00
   clat (usec): min=56, max=1472, avg=754.31, stdev=172.63
   clat (usec): min=55, max=2405, avg=761.82, stdev=153.19

3. With use_vfs patch where use_vfs=1:-
   write: IOPS=114k, BW=445MiB/s (466MB/s)(13.0GiB/30007msec)
   write: IOPS=114k, BW=445MiB/s (466MB/s)(13.0GiB/30024msec)
   cpu          : usr=1.31%, sys=8.67%, ctx=3415138, majf=0, minf=527
   cpu          : usr=1.28%, sys=8.70%, ctx=3418737, majf=0, minf=570
   slat (usec): min=8, max=6450, avg=13.68, stdev= 8.35
   slat (usec): min=8, max=22847, avg=13.65, stdev=12.77
   clat (usec): min=62, max=6633, avg=265.98, stdev=124.55
   clat (usec): min=69, max=1900, avg=265.70, stdev=125.61

 From above data it shows that there is a big difference in clat fio
numbers in #2 and #3 (#1 is close to #2 so didn't report it,
where CPU, slat is approximately same.

Regards,
Chaitanya

On 10/27/19 5:55 PM, Keith Busch wrote:
> On Sun, Oct 27, 2019 at 04:03:30PM +0100, hch@lst.de wrote:
>> ---
>>   drivers/nvme/target/io-cmd-bdev.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/drivers/nvme/target/io-cmd-bdev.c b/drivers/nvme/target/io-cmd-bdev.c
>> index 04a9cd2a2604..ed1a8d0ab30e 100644
>> --- a/drivers/nvme/target/io-cmd-bdev.c
>> +++ b/drivers/nvme/target/io-cmd-bdev.c
>> @@ -147,6 +147,7 @@ static void nvmet_bdev_execute_rw(struct nvmet_req *req)
>>   	int sg_cnt = req->sg_cnt;
>>   	struct bio *bio;
>>   	struct scatterlist *sg;
>> +	struct blk_plug plug;
>>   	sector_t sector;
>>   	int op, op_flags = 0, i;
>>   
>> @@ -185,6 +186,7 @@ static void nvmet_bdev_execute_rw(struct nvmet_req *req)
>>   	bio->bi_end_io = nvmet_bio_done;
>>   	bio_set_op_attrs(bio, op, op_flags);
>>   
>> +	blk_start_plug(&plug);
>>   	for_each_sg(req->sg, sg, req->sg_cnt, i) {
>>   		while (bio_add_page(bio, sg_page(sg), sg->length, sg->offset)
>>   				!= sg->length) {
>> @@ -202,6 +204,7 @@ static void nvmet_bdev_execute_rw(struct nvmet_req *req)
>>   		sector += sg->length >> 9;
>>   		sg_cnt--;
>>   	}
>> +	blk_finish_plug(&plug);
>>   
>>   	submit_bio(bio);
>>   }
> 
> The blk_finish_plug() should be after the last submit_bio().
> 
> I looked at plugging too since that is a difference between the
> submit_bio and write_iter paths, but I thought we needed to plug the
> entire IO queue drain. Otherwise this random 4k write workload should
> plug a single request, which doesn't sound like it would change anything.
> 
> Using the block plug for the entire IO queue drain requires quite a bit
> larger change, though. Also, I saw a similar performance difference with
> a ramdisk back-end, which doesn't use plugs.
> 


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
