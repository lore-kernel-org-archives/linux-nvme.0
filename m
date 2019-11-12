Return-Path: <SRS0=/X2o=ZE=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F0CBC43331
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Nov 2019 21:20:42 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D287620659
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Nov 2019 21:20:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="oMyLzVQg";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="LdpsCzal"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D287620659
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=5YBk8Ng1cTN+6asbz4n8zbux1g3uSYcVUAzoQS7sJaw=; b=oMyLzVQgW3ohp4
	FgdZuzWDpbPCx149qdB224rkNdbfINu8LFVLZzaxaYGo2lkXXHTDd4QtiOPiMEiRucWbKuD2QRas/
	JySjcCq3p7hDPHVW+Dv0i3GtbLlaiN5GFWFthIjvMm5xwkcKVs1dRerTjq2Q6FMI3HPuaYtYRJun3
	1I9y/l2i4z9NAGqWXFdq3pcx210usahHBmlbc+mXywU/NfPu75LlyFVY0/+QzYm2hOeomFpPAp3kh
	lsUdqHLZrWP+S65aPezXZsYNZ2u/mp655L0DGGHxvATfI5EprQPHW1/G2YuEdC6aQW66N30rUQQT2
	Vbv6gv8xlDBqcUdKgT9g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iUdaZ-0000rC-Oi; Tue, 12 Nov 2019 21:20:39 +0000
Received: from mail-dm3nam05on0709.outbound.protection.outlook.com
 ([2a01:111:f400:fe51::709]
 helo=NAM05-DM3-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iUdaR-0000qi-2T
 for linux-nvme@lists.infradead.org; Tue, 12 Nov 2019 21:20:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KjCugAjE5DA/49l2Y3NOzTuU3czUgLkSu62gyBkjkOrRmExwCbt4rRvyJymg6v0IwiUY70RN8DTbj4qx1EmR6/ANKUOw7DnfQNuoA/sQ7Xx7UYWPqGvRPEnDInK9B8eNamVj4aNU/ZQvRqXpFNwT1nJG0THo8vRQ38cXr53251bS7BAfRSowfypXicZYqMhY95Mx5c91gKGpvkPH57PD+yDzsQo1L0IYWbVqyCm99l9RYbAWJfLYGqJFeRMYCE41/RkdiGTVJqUXPY+7Lx62ggMlBRLYEbCiPPbvGWgh7epnsaDL1py907IUlP4cRkvSAUkxMrzHwUax8I0KRryXwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oBot/PQOI/u19tbAPFWjMPgcsX6KJ4p3eV8gqp/j3FU=;
 b=ArpfaGmF9479VeiFIloduuVNYgRBDKSqMTdQFSWVyDw0Q4zVyW/0/FUBHIJ2F6vo8c8KoB3q1NF6/N9er+KRvJ2d3QsVEmPvoAGw6PW8KqMVNaEbIllXRI53sog2DJGmV6+W/Ko+zhaoRgOE00PmyrwqaC+3O5J2IE5RYopHUXLrHq3Rrnva21VpNd583C2s2oRlkGCm6iqMPp89POBDWMVPWMMdlWcNT06vNVThY7zPbAc4aiR+y75CI6HKhD1ds3tVCKzuiuykNXxyxhQ/YwJfYnO72WDstQuVgzEdsCiBbTpKCTMCV6jeIqMpC3VpOMGJK+SKLB9JwblCj4v/OA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oBot/PQOI/u19tbAPFWjMPgcsX6KJ4p3eV8gqp/j3FU=;
 b=LdpsCzalELUejQiRwIcDeheA2+55vC8FRkft+mEBfpa9ywjqNKW84aSsbUB+edZda/FZl0YUQIZQ2KxcFGRoE9KMMiCZTZgip3dr9fNZHUd86cntaOqLF6iWoQkwS1xYoQ4qa+SUMwMOzsyV6Q3vrm/31uVdsWnnYXLPDKp0XwY=
Received: from CY4PR21MB0741.namprd21.prod.outlook.com (10.173.189.7) by
 CY4PR21MB0854.namprd21.prod.outlook.com (10.173.192.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.18; Tue, 12 Nov 2019 21:20:27 +0000
Received: from CY4PR21MB0741.namprd21.prod.outlook.com
 ([fe80::8c0d:e8a3:4fb7:e083]) by CY4PR21MB0741.namprd21.prod.outlook.com
 ([fe80::8c0d:e8a3:4fb7:e083%9]) with mapi id 15.20.2451.018; Tue, 12 Nov 2019
 21:20:27 +0000
From: Long Li <longli@microsoft.com>
To: Ming Lei <ming.lei@redhat.com>
Subject: RE: [PATCH 2/2] nvme-pci: poll IO after batch submission for
 multi-mapping queue
Thread-Topic: [PATCH 2/2] nvme-pci: poll IO after batch submission for
 multi-mapping queue
Thread-Index: AQHVlehiYcB/lSKxl0SzyAz+DwfVW6eGdeMAgAAtylCAADVHAIABOLmg
Date: Tue, 12 Nov 2019 21:20:27 +0000
Message-ID: <CY4PR21MB0741BB1F48C64613BF6E45F6CE770@CY4PR21MB0741.namprd21.prod.outlook.com>
References: <20191108035508.26395-1-ming.lei@redhat.com>
 <20191108035508.26395-3-ming.lei@redhat.com> <20191111204446.GA26028@lst.de>
 <CY4PR21MB0741004E62F9C50B8EF7DA9ECE770@CY4PR21MB0741.namprd21.prod.outlook.com>
 <20191112023920.GD15079@ming.t460p>
In-Reply-To: <20191112023920.GD15079@ming.t460p>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=longli@microsoft.com; 
x-originating-ip: [2001:4898:80e8:f:eddf:db5c:c6fe:798]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b8cd9b6b-9e78-4187-f75b-08d767b6238d
x-ms-traffictypediagnostic: CY4PR21MB0854:
x-microsoft-antispam-prvs: <CY4PR21MB0854FDF59372F4C6ED3BE0B2CE770@CY4PR21MB0854.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 021975AE46
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(39860400002)(376002)(396003)(136003)(366004)(346002)(199004)(189003)(64756008)(7696005)(71200400001)(5660300002)(71190400001)(9686003)(446003)(11346002)(102836004)(6436002)(6506007)(229853002)(256004)(55016002)(14444005)(46003)(6916009)(52536014)(76116006)(6116002)(66556008)(66946007)(2906002)(33656002)(66476007)(76176011)(6246003)(66446008)(8990500004)(74316002)(99286004)(10090500001)(86362001)(8676002)(186003)(81166006)(81156014)(7736002)(8936002)(305945005)(14454004)(476003)(10290500003)(25786009)(478600001)(486006)(4326008)(22452003)(316002)(54906003);
 DIR:OUT; SFP:1102; SCL:1; SRVR:CY4PR21MB0854;
 H:CY4PR21MB0741.namprd21.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hk1Y+hyLEmRaCAjx+/KWVMi8olwL4MmceGn3GvlITrz8OiwMICDHCP62OIg23D0oTibrqQI+0OzAnX5tSHI3bKGFwibHUEpXGrHBM1+JEcsJnvqurtn8EGU6GmFztebFtOfykoOutzEQytcaBPddTQVh6DK2RMR1HqRS2Xm9BD+BTYYV8p7AmLI6uA0v9KUdIAMJEUIowmXOe9R6vZ6CSQvsS4rxeKxSY7BfAgdhUH73mEKUIOCgkHV217VpiKWZRnfSN4CD/iqNRAS/39seOCQvHmMQfjvrY2xRC68mdX9gcM6pyYjuKjPopASSEhTMRNZtEtVCifULlMrlJd1OOxsznGgOeuQ2G4NnKLOF9Cz98qWdtS02vZsfpn8KotQ2/EFDu8n3/cKmVahkVPG0DhU+6DXbPADRsOkfHHbELtLRyIb3QSwCsxbyZTnu+LUu
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8cd9b6b-9e78-4187-f75b-08d767b6238d
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Nov 2019 21:20:27.3050 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: F8GDUluSEHqR+wJawU1y0E75pC1/O+D+5fq6psbdSUaNzJOSWHEaeHXpjB8H2FKNHVjGJrU5+R3BTof6Xt9S/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0854
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191112_132036_041767_44ADEF1F 
X-CRM114-Status: GOOD (  13.37  )
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
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
 Christoph Hellwig <hch@lst.de>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Sagi Grimberg <sagi@grimberg.me>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

>Subject: Re: [PATCH 2/2] nvme-pci: poll IO after batch submission for multi-
>mapping queue
>
>On Tue, Nov 12, 2019 at 12:33:50AM +0000, Long Li wrote:
>> >From: Christoph Hellwig <hch@lst.de>
>> >Sent: Monday, November 11, 2019 12:45 PM
>> >To: Ming Lei <ming.lei@redhat.com>
>> >Cc: linux-nvme@lists.infradead.org; Keith Busch <kbusch@kernel.org>;
>> >Jens Axboe <axboe@fb.com>; Christoph Hellwig <hch@lst.de>; Sagi
>> >Grimberg <sagi@grimberg.me>; Long Li <longli@microsoft.com>
>> >Subject: Re: [PATCH 2/2] nvme-pci: poll IO after batch submission for
>> >multi- mapping queue
>> >
>> >On Fri, Nov 08, 2019 at 11:55:08AM +0800, Ming Lei wrote:
>> >> f9dde187fa92("nvme-pci: remove cq check after submission") removes
>> >> cq check after submission, this change actually causes performance
>> >> regression on some NVMe drive in which single nvmeq handles
>> >> requests originated from more than one blk-mq sw queues(call it
>> >> multi-mapping queue).
>> >
>> >> Follows test result done on Azure L80sv2 guest with NVMe drive(
>> >> Microsoft Corporation Device b111). This guest has 80 CPUs and 10
>> >> numa nodes, and each NVMe drive supports 8 hw queues.
>> >
>> >Have you actually seen this on a real nvme drive as well?
>> >
>> >Note that it is kinda silly to limit queues like that in VMs, so I
>> >really don't think we should optimize the driver for this particular case.
>>
>> I tested on an Azure L80s_v2 VM with newer Samsung P983 NVMe SSD
>(with 32 hardware queues). Tests also showed soft lockup when 32 queues
>are shared by 80 CPUs.
>>
>
>BTW, do you see if this simple change makes a difference?

Yes, I can confirm the patch fixed lockup on this VM configuration.  There is also no performance regression.

>
>> The issue will likely show up if the number of NVMe hardware queues is
>> less than the number of CPUs. I think this may be a likely
>> configuration on a very large system. (e.g. the largest VM on Azure
>> has 416 cores)
>>
>
>'the number of NVMe hardware queues' above should be the number of
>single NVMe drive.
>I believe 32 hw queues is common, also poll queues may take several from
>the total 32.
>When interrupt handling on single CPU core can't catch up with NVMe's IO
>handling, soft lockup could be triggered. Of course, there are lot kinds of
>supported processors by Linux.
>
>Also when (nr_nvme_drives * nr_nvme_hw_queues) > nr_cpu_cores, one
>same CPU can be assigned to handle more than 1 nvme IO queue interrupt
>from different NVMe drive, the situation becomes worse.
>
>
>Thanks,
>Ming


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
