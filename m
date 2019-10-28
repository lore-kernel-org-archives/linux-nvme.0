Return-Path: <SRS0=TJkX=YV=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1DA8CA9EA0
	for <linux-nvme@archiver.kernel.org>; Mon, 28 Oct 2019 07:33:03 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F5DE2086D
	for <linux-nvme@archiver.kernel.org>; Mon, 28 Oct 2019 07:33:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="P4Nhkkq4";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="AUFu/5jS";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="c34VtLgF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F5DE2086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date
	:Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=ln+Ngpf2FXX+w30bzequKPOsQ2Xq9BKFF5SqB3RTE5w=; b=P4Nhkkq4WBgPrs
	HlcF5utQKVzI87OXXVR57wqDWns31/c0ULeKbPpwPCEGIx0zCH64uD5cQo8L0kcSKPEMVHX8u+EXS
	PUtmn9ddd16nKPUpSRmJW14qvXO7Dt4H5VrYGzkjsCaiSyqBT/zjHDwYg0vE38/7YPPIhzUJyLVdn
	q8ywUdYeuZmiL8QRz7rrVF87ZejSJvMBVlPFfxd+VgTqDP8xuiAPPqxpNlsaPhhQn35Ye+gl98ROL
	3GP1FMiK7JmqYAo+jgVvqjb4inuBVr0hK42SZ3oYgseZNK0FUaBJ0ROwh3tdDq0sAYiltLsRvUL0o
	eDHjvvhh581WqxN4+d1w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iOzWE-0003x9-V0; Mon, 28 Oct 2019 07:32:50 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iOzWB-0003wm-Fd
 for linux-nvme@lists.infradead.org; Mon, 28 Oct 2019 07:32:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1572247993; x=1603783993;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=/TXEaHFllLsd3P4KwmoLk9LWdkWRCtoAGbQ9LnrQaYk=;
 b=AUFu/5jSLCMQfqcOofxywNunBgc5NAQMtr2TreWtAnCKl47iQ4TcScg0
 OijspE0xM8KwB0iODjKF187voi4FoUPBa2j0FCVv40bd1J1EYqdQNIkM/
 loXEBw1Ma3yFhWbwEj9U7jZoaNK1sMMIScW0uZkRnqC1iGE8MhZ4MYm/i
 OZjGWJ6p9PxPkCiuSz14MD1Z7J24Msq3oncbP2RtTlUlLvTM4uf1q0BiD
 1b7cTg9q+rzRXSPmubFl2Fe1xp8J3vni3SFszFvtcRIRmehmbBsUqAyLa
 CqJlD3hnO0Q4+Q8lPdKZPbexGOifM3pS5e3/gbfZ2OrT/HaAHBJ7ZVbrm w==;
IronPort-SDR: mPjyIJNVpbw6S2ucTr1Z3RdnS3399htx2Yj/SbQZJZwpuIs3pSm/WqgHd7G+++QkaDrFUaCEXx
 iMvMf+H2SKZGbNF78cqjHyWigCrWzY6+RDp5X50CbY2DaGW6e9R5C5qv5EeEG6VxixDqfeWu7Z
 qyfZaC7SN2vLmO1ktBXYPqDw4RRB7OP5vil2AplZ46ZUIP0ZHmK2rnWwnhoWo4XqLDW/+IfV2n
 Tk5afKyRQHHi93CeqW4t/Vv1nzMlpPSTYOltohNbBDCTDBDqU3QGtZJTyPyo3eyvrZAIXda40O
 BRU=
X-IronPort-AV: E=Sophos;i="5.68,239,1569254400"; d="scan'208";a="222613628"
Received: from mail-by2nam03lp2052.outbound.protection.outlook.com (HELO
 NAM03-BY2-obe.outbound.protection.outlook.com) ([104.47.42.52])
 by ob1.hgst.iphmx.com with ESMTP; 28 Oct 2019 15:33:13 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bPMGcA2vmLQXYmLhf2yJKT0H4gr7o7bEWPGQiPoD13LwTvo4m1gjZHahz5Jb9NP2hQezWaI6GKJ9wJTklFg0w4Z1mf/e3hAOjPiOc5yB45u3dUegIxsaARjqpCZY9H5m/PkMjiegAgkvZiowHHV5ORT07sWH8jwYSWY6vLA+Ip7v65+6XqL9JPJT65KHLvtFuNQtKn3IzfAJl6Nh/9d5FqnSe23qGpTJzOMtSLx3pEKEBkEzQdVgZnlIcp6HJ4+RuRYGc2VdwE4c2L8Zh63SosEyRcfTLQDEQndAK6/k1yrXb3QEUvByYRyLRCuUHrJMXc9JFiU8XSbzXBhzuO+Fmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GOGIVYfLhSSv1vWUw2ftK1jXtnNDpawD80LmNEulXN4=;
 b=WJJySNjXLGRmU15dP5UsRTWmXHB/ux3xdNROVQoIFeesuA3bTySguwRRiCLR2yO2u2lE2ZoWxE7sLPhLoeSKQI1GwhNpT2RS8fdNHrkIiSZaR/7kz6E0ekn3ewNZNZqrtusyKJBQFMsfUQzYLP637kpHL8XAdS3WM3ktzyC7yUbvk8Au4WabFCLb0z0XRSnKeXvNOvVe5zwetb7K3ITPHyp6wdy5yXHrsoB2WSwtTk60rre3HLCk9hkQtQ9oIGm4OFklbG7UDwrgPJb2tqFebzCqq7z3YgUyY4PVg3mo9kxuSRhPXCRvKmyua1ArbaYgAcH0YimfEZgGtSyxDvsQIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GOGIVYfLhSSv1vWUw2ftK1jXtnNDpawD80LmNEulXN4=;
 b=c34VtLgFTrmmLmeqP1JzLyYPnmcJVGXo5HFqx8ZLZNbXgUN+KMUKtipVQ+eDDzZDXUjYek6gMrpiQadrYJKB81pfd46liymq8UzwMndTrOugpVZfDtDOWQMJmQvExwJoQYr9nlFFUuGC9lHwKKrTtOA6SFBaV20sMXtISz5t7tM=
Received: from BYAPR04MB5749.namprd04.prod.outlook.com (20.179.57.21) by
 BYAPR04MB5942.namprd04.prod.outlook.com (20.179.59.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.20; Mon, 28 Oct 2019 07:32:45 +0000
Received: from BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::34a1:afd2:e5c1:77c7]) by BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::34a1:afd2:e5c1:77c7%6]) with mapi id 15.20.2387.023; Mon, 28 Oct 2019
 07:32:45 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Keith Busch <kbusch@kernel.org>, "hch@lst.de" <hch@lst.de>
Subject: Re: [PATCH] nvmet: introduce use_vfs ns-attr
Thread-Topic: [PATCH] nvmet: introduce use_vfs ns-attr
Thread-Index: AQHVid7kgFRDrsrFkkeJqDNfcuN3xQ==
Date: Mon, 28 Oct 2019 07:32:45 +0000
Message-ID: <BYAPR04MB57491F5ED34EEE047D86C2D186660@BYAPR04MB5749.namprd04.prod.outlook.com>
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
x-ms-office365-filtering-correlation-id: 57628d43-3920-4b4f-acfd-08d75b790682
x-ms-traffictypediagnostic: BYAPR04MB5942:
x-microsoft-antispam-prvs: <BYAPR04MB5942C616471A7E5954317C7886660@BYAPR04MB5942.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1360;
x-forefront-prvs: 0204F0BDE2
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(136003)(39860400002)(376002)(396003)(346002)(366004)(189003)(199004)(55016002)(446003)(26005)(53546011)(6506007)(76176011)(102836004)(71200400001)(71190400001)(14444005)(7696005)(256004)(14454004)(186003)(476003)(486006)(2906002)(6116002)(86362001)(478600001)(52536014)(6246003)(66446008)(25786009)(3846002)(66476007)(64756008)(5660300002)(6436002)(66946007)(7736002)(66066001)(305945005)(74316002)(229853002)(9686003)(33656002)(2501003)(8676002)(81156014)(81166006)(99286004)(54906003)(110136005)(4326008)(76116006)(316002)(66556008)(8936002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:BYAPR04MB5942;
 H:BYAPR04MB5749.namprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +hrxFKJYX6KS02EY1N9UbQErBxLJ/J6pRXE2hpM8sazkyhcEcjoqaIu0UNtZnzSdPq9fw4n8Qa7qos/GO3n+/nlBUqzL96+xAFu3aYsv0YOPXd4LtM8RsHUm78kJQbY+6KbyRcP99WEYF3exLhfY8WR1geg8sWj62a6Op3vXfUQ8g5oThj5QaSdeDn5mDJtc1ZUqfQ+u5sYeunUR2TOK3CTnCHzrye3a1HZ6RQAEuX5v5lni6EadobVxO7l6MwEWm0dcRFMFYk4j/Ry6SRSagzn1yXMM/neUyVQ60FPVV7PgGLN9wqL9FGZotIOCfuFHoYbtIJQbOoWlRCU+idRcjARbyf4NdVsm69vlqYi0gfwFijJsO4DXcqW3tZWWtSpbdUa2kj3d671T9qgGq4mCj/K1EcQYsu6yvBS5GQ5oORcJ5FmPdO7Ch5EgAD1AiL2v
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57628d43-3920-4b4f-acfd-08d75b790682
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2019 07:32:45.2923 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BirOQgauyezUt2L27yeX8yykypRtX9yo0NoB9DFRIssJ4Uf0AxaugOmzktA9iPAkzN38YqnzmVQk7tC/rukAbxiMdrT1lp95dCFnTVa9VP4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5942
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191028_003247_558619_98FEAF68 
X-CRM114-Status: GOOD (  14.45  )
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

Just did a quick test with following patch on the top of
plug patch :-

[root@ioprio nvme]# git diff
diff --git a/drivers/nvme/target/io-cmd-bdev.c 
b/drivers/nvme/target/io-cmd-bdev.c
index ed1a8d0..07e4f8c 100644
--- a/drivers/nvme/target/io-cmd-bdev.c
+++ b/drivers/nvme/target/io-cmd-bdev.c
@@ -204,9 +204,9 @@ static void nvmet_bdev_execute_rw(struct nvmet_req *req)
                 sector += sg->length >> 9;
                 sg_cnt--;
         }
-       blk_finish_plug(&plug);

         submit_bio(bio);
+       blk_finish_plug(&plug);
  }

  static void nvmet_bdev_execute_flush(struct nvmet_req *req)

   write: IOPS=123k, BW=479MiB/s (502MB/s)(14.0GiB/30009msec)
   write: IOPS=123k, BW=480MiB/s (504MB/s)(14.1GiB/30002msec)
     slat (usec): min=8, max=8778, avg=13.29, stdev= 5.70
     slat (usec): min=8, max=315, avg=13.28, stdev= 3.38
     clat (usec): min=44, max=9790, avg=246.21, stdev=167.10
     clat (usec): min=27, max=10883, avg=245.59, stdev=164.19


Still need to look into the code to make sure above change make sense.

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
