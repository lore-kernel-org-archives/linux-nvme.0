Return-Path: <SRS0=/X2o=ZE=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4E98C43331
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Nov 2019 23:44:43 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B646206A3
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Nov 2019 23:44:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Fb31uUNf";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=fb.com header.i=@fb.com header.b="Szii9p8H";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="PE5YJU/R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B646206A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=m3MupVRTf36ktsloLlokWSOGCznV10Bffl72kU6ottQ=; b=Fb31uUNfLB6d/l
	FQvkX5X585nSxqRGQvgR2Ve7AHPj/TV38N2os3Ljrx66OcDib9AnTaoRNhzwbajf0EhX3irWCLAJM
	CTQ+aPMMUW8447TuexnWEnMNCUHlVgPv8slMxICha49NqoNYULbxhEL5vzxHeEQt7UEprVYONRRvs
	RKuyeZjJCNuK/lI3brV1ltBerB17m16HeMXAp+ihYvjZDh9a16HXV7wCMD885jRn9nkwMWrWwd3F1
	5Rn4/7/EiE6C/fVRyrVwkk8bwMva8G316Old9JBackoXbuu/3jZvczaRL51Mwg1zcjTWsssEQD7ZG
	urC6rjfaBwa36c2jGSvg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iUfpx-0005jt-7B; Tue, 12 Nov 2019 23:44:41 +0000
Received: from mx0a-00082601.pphosted.com ([67.231.145.42])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iUfpu-0005jA-5K
 for linux-nvme@lists.infradead.org; Tue, 12 Nov 2019 23:44:39 +0000
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
 by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 xACNUFVD032060; Tue, 12 Nov 2019 15:44:28 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com;
 h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=Qy1rUZxyK5iHrbcohaYnkTOhYVEGKXg0Vn9g8DZQ7B0=;
 b=Szii9p8HZzTLdK/PtVsCm47lhJohvGy2nJsoymwZ0lcshQ/s9mg/olEyo8Y/kinJZbym
 hCO+nQWCOl7b0G5WIr2G00ROE6r5/LGnqn3tbzL7nycLXMJIZB43gVcEpHYKj0y7sr1Z
 HlTUDlG/34WhAvq197eWN2NoarFjXgeWiRM= 
Received: from maileast.thefacebook.com ([163.114.130.16])
 by mx0a-00082601.pphosted.com with ESMTP id 2w7prbn0ec-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
 Tue, 12 Nov 2019 15:44:27 -0800
Received: from ash-exhub203.TheFacebook.com (2620:10d:c0a8:83::5) by
 ash-exhub102.TheFacebook.com (2620:10d:c0a8:82::f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 12 Nov 2019 15:44:25 -0800
Received: from NAM01-SN1-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.102) with Microsoft SMTP
 Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Tue, 12 Nov 2019 15:44:25 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hv+8/5AeDNd1fhiYyDGrrGkoITVLOoTn5/GwmKLzhSPySE06bFZD2ui6I/emWSNgPjdG3y2fMgSW/5N2PsZ4MWx87logJe2HaAZzyuZyyShXwFIb/d2pVa2hmYXhXK8AMo2AW1zumkipYvGJ1r5y+a0mDUwuJrqH2uv8rGa//fMKegd0j7UyTRCpc4SWhM6mypp8LjLomWwW1s194sy4P3l5fTmNsj+aW+KjxQPZknRhy7458ZdK/fykYg5+ChhSsLAwsI4X+Kz4wE5KnbBBsJQHTMeZFccI4ceBahODCaviV0qGg3xKPhKmHbrJe3WYJQbeOoc/fyXtimpURCCFZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qy1rUZxyK5iHrbcohaYnkTOhYVEGKXg0Vn9g8DZQ7B0=;
 b=BG6bw7XpgqZuo8iAwz4Qf93DBFcPUP0K+yokYSOU5kpibNmuvj3a7zrX4E84+jM5YhMKYq9LCkmik5ClZtOWCgvafYUoTGWx80RSzQNmI+sQfQjzmmzhuhqpXpWl8VfZfm2N86F2UFRVBsAZPeiNG/pegyDtVkR65FoO7NVVyak1/QX2jrLg9Gonk8lWWM8PPA16/SDf3nIZZPwruJBDOnRwfIz/x7q3eamo22X6k3wx10nem57cDVjhP3nYu5TaMQpFbIHsu5mteDPEpn0Ibl+04ElwiL0bhjw3mi0cZPpGfsNJvafLHeEb33YSYfVUK0FL85HFjhJ5SyUrA3179g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qy1rUZxyK5iHrbcohaYnkTOhYVEGKXg0Vn9g8DZQ7B0=;
 b=PE5YJU/Rr/LwuBPt49rhEJ+r7MAzi06ohKob3v5tTxsFD4ussQQryzZ8wG2PGG+df3s/eP6cgng5arUtP8qPLT/W+vTHMFpL1SfXkJivHBuuodp2EAWi7MN4oAopTKrhO1IWVrfoSwQIJftOzCRA7V9zTHNKNr5jD7EAI97n9Dk=
Received: from BYAPR15MB2790.namprd15.prod.outlook.com (20.179.158.31) by
 BYAPR15MB3333.namprd15.prod.outlook.com (20.179.58.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.25; Tue, 12 Nov 2019 23:44:24 +0000
Received: from BYAPR15MB2790.namprd15.prod.outlook.com
 ([fe80::f0cb:41c3:86ac:fbcc]) by BYAPR15MB2790.namprd15.prod.outlook.com
 ([fe80::f0cb:41c3:86ac:fbcc%6]) with mapi id 15.20.2430.027; Tue, 12 Nov 2019
 23:44:24 +0000
From: Jens Axboe <axboe@fb.com>
To: Sagi Grimberg <sagi@grimberg.me>, Ming Lei <ming.lei@redhat.com>
Subject: Re: [PATCH 2/2] nvme-pci: poll IO after batch submission for
 multi-mapping queue
Thread-Topic: [PATCH 2/2] nvme-pci: poll IO after batch submission for
 multi-mapping queue
Thread-Index: AQHVlehpiNFhvX8Ey0W5o13U5lHLc6eGyYoAgACJpYCAAIANAIAAZymA
Date: Tue, 12 Nov 2019 23:44:24 +0000
Message-ID: <6c7e2faf-6f2b-2b43-00af-512334f2a49a@fb.com>
References: <20191108035508.26395-1-ming.lei@redhat.com>
 <20191108035508.26395-3-ming.lei@redhat.com>
 <82fb330e-a507-999a-69f3-947f13bbaae1@grimberg.me>
 <20191112095649.GE15079@ming.t460p>
 <4664ca6f-2ebb-c69c-5b7f-226a86394adf@grimberg.me>
In-Reply-To: <4664ca6f-2ebb-c69c-5b7f-226a86394adf@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BY5PR03CA0025.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::35) To BYAPR15MB2790.namprd15.prod.outlook.com
 (2603:10b6:a03:15a::31)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [66.219.217.79]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a9bc74f6-7206-441c-43db-08d767ca3f58
x-ms-traffictypediagnostic: BYAPR15MB3333:
x-microsoft-antispam-prvs: <BYAPR15MB3333FC5E39D2B899DC463D1CC0770@BYAPR15MB3333.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 021975AE46
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(366004)(189003)(199004)(186003)(229853002)(99286004)(71200400001)(86362001)(6436002)(11346002)(8936002)(476003)(8676002)(498600001)(31696002)(71190400001)(81156014)(81166006)(31686004)(446003)(256004)(486006)(2616005)(4744005)(6486002)(52116002)(110136005)(54906003)(5660300002)(6506007)(386003)(102836004)(53546011)(26005)(76176011)(2906002)(66446008)(7736002)(6512007)(305945005)(14454004)(6246003)(64756008)(25786009)(66946007)(3846002)(66066001)(4326008)(36756003)(66556008)(66476007)(6116002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:BYAPR15MB3333;
 H:BYAPR15MB2790.namprd15.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: x6nGbJZGX/MAb0Cg7CS7Xid+LsVMrrubEjGL/2YhPZKIzbaKU19a19M8qb9GhtUmipJJMQ0FVmlnkXQrYlT2T2yAyds5lRbV9ZjLNf1p5ad4tyHaJy4nP3Ifr+PaBoz/oqsO74v+BpSnnPvbiMOGqz4CCDb/7jZQdKRk4OY4imo/LPhSX2d63UWAyo6nsMTwzpkKlNg+G0O9Gi8adc+fnVhRAOw3SXh2IAgmL3lIW3Hly0cj/vkDBq2h/Y8jMeiTupuiAn6p+ztECINTbdCyciSnbDRKrRMc4lmFdLVB97l6UNVmZ7+U236dQ7XghrY4fTe1d2d6nqi63gG56lCr+TvfMjB7AB/fDdarsZroKCY+7ec0j574k7ieKTdbkkdA6AJSvPqbobYf5457JZKZJrdzJWnFGBgkGVitR8nP1C8dyNIl8Io8maWpyzS8z19o
x-ms-exchange-transport-forked: True
Content-ID: <DAA85C9A93F2294B93BFBBA547617549@namprd15.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: a9bc74f6-7206-441c-43db-08d767ca3f58
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Nov 2019 23:44:24.2267 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: L61KFRd4qdxe+umg0DZ8t5SCV6x4XEdMG+7PpRxEWGmNfLUvnFz4y+jDIitGs0Xl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3333
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-12_09:2019-11-11,2019-11-12 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0
 bulkscore=0
 priorityscore=1501 malwarescore=0 mlxlogscore=923 adultscore=0 mlxscore=0
 impostorscore=0 spamscore=0 lowpriorityscore=0 clxscore=1011 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1911120201
X-FB-Internal: deliver
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191112_154438_207175_496586EA 
X-CRM114-Status: GOOD (  14.89  )
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
Cc: Keith Busch <kbusch@kernel.org>, Long Li <longli@microsoft.com>,
 Christoph Hellwig <hch@lst.de>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 11/12/19 9:35 AM, Sagi Grimberg wrote:
>>> The correct place that should optimize the polling is aio/io_uring and
>>> not the driver locally IMO. Adding blk_poll to aio_getevents like
>>> io_uring would be a lot better I think..
>>
>> This poll is actually one-shot poll, and I shouldn't call it poll, and
>> it should have been called as 'check cq'.
>>
>> I believe it has been tried for supporting aio poll before, seems not
>> successful.
> 
> Is there a fundamental reason why it can work for io_uring and cannot
> work for aio?

I did that work (called it aio-ring), you need at least a new system
call to support setting up an aio io_context to do polling. Since we now
have better alternatives, it'd be a waste of time to try and support it
with aio.

-- 
Jens Axboe

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
