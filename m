Return-Path: <SRS0=77Bv=24=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E37AEC282DD
	for <linux-nvme@archiver.kernel.org>; Tue,  7 Jan 2020 18:15:21 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E278214D8
	for <linux-nvme@archiver.kernel.org>; Tue,  7 Jan 2020 18:15:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Ucr+mQY0";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="TZxj0pUv";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="OuRxqlmq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E278214D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=InZ8xNIWJEJfN5ynimMacedxwiQCkkYVggfZGTF19TU=; b=Ucr+mQY0KMhDGj
	fsAjQUyoKuoMQ0LOvob7NJjLHIaeDUGYG8pzXhrhTaetbKuVNC1RtNdGmqr95Z6fFy7zx122ysX1N
	HhL9hRlnOmvdpsGC48Ist0B7PkLxvOXa8KRh8+E27g7G0Wu+WHwMYRBybJLz0MBb9QHtlkCaJjDaA
	Zh2R+dYJkfcSmvjuSXBpzVyXuUCWXEWHvaFAZcRYa6n9cM44ieQZlZ98LQOtwLXFW7xJAcdQJ3HWz
	Q2JYlr74HppmmBeao2ANEC1951jMEh57cXvQFfX98o5gyxFoegZi4U4U5G5qeacJ6Vcv6JhxB+W3I
	wL0bqmsNn7vo3xJGRasQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iotNt-0003TP-Dm; Tue, 07 Jan 2020 18:15:17 +0000
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iotN5-0001PC-7n
 for linux-nvme@lists.infradead.org; Tue, 07 Jan 2020 18:14:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1578420867; x=1609956867;
 h=from:to:cc:subject:date:message-id:
 content-transfer-encoding:mime-version;
 bh=j2tN6+V1pVxcaWER8t6KvObGStMa9m3VVcoDZo3HOsU=;
 b=TZxj0pUvJJaSsxDdfFm+T7QpW8MA7cDTFoMtvUwSJMH5OU5ILhAKr9eU
 VskBKCsS1q9T4Ui14zUROpvd7zCv1XXBVWefD5L0xLuZptgcc/S3fDflU
 xm02iizWfkcNTzH1qWYVHdFrYT8Ex8UrMmKniLvCSZU8eSfKCh5kIjRie
 eJKo5XlJTYQ87DNo/LCS8AFXZR5GwSv6GgpgV/qiM8b+WE0K/NBRDI5VB
 0neDcZoxbvrdTwB8/2nw9oKtr2iO5foFRSPuQgRivewOUq1xqTae1Prqc
 yuwftvsIoGgL23tRFdldCS6nMDwwBJaSlMQ9UiItsoN2xP4lBVAaky8G9 g==;
IronPort-SDR: 6NqzSdyPZEDLBekS4PclRh/hvz7Yn5TRJ9wx2TvAoohFquK5SK/fFi+2EoXrGWcq0hzL1IU28F
 vpgp/qSezSGp8ayjOJYlDwNFSEd5T1Qj8B+81mK1IXYWrPlT06oFyip1tiDBD6Yy+oQkVtdePZ
 m3W6vCd/6c/uYhAgzlBj/BYUFhBZeEiQ3/Lto+lHF9IH2Yo3BjwCjyXIywz1efaTO8SNmYrmUU
 kpSlXQ8VjdOXaNSZBiwQBycJ4+sXqQFSQ42gH+rI+8LWaw2jLf6T94VBDmf9O8MfAAlpI4HjrK
 kA4=
X-IronPort-AV: E=Sophos;i="5.69,406,1571673600"; d="scan'208";a="234671188"
Received: from mail-bl2nam02lp2056.outbound.protection.outlook.com (HELO
 NAM02-BL2-obe.outbound.protection.outlook.com) ([104.47.38.56])
 by ob1.hgst.iphmx.com with ESMTP; 08 Jan 2020 02:14:18 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TNLVkqx2l2BLai+1l5Qh3uQOlhXIqvN5zbho10zBhGfMlkTVB7NUIa5D8LCainIZ7tQtatYxDSYFpFy6UWE5hHyb1NGV3TmYMCLxtIMneQU0GH+um2+AyrPZIH4d/jYCbaAeGyz43yBrnOt82YLnsWAUl4dHY6+SWI0PbNfqKp0IOmWvIeRZl8vbhAihDzOOOrAUOtNFZiF+V7iPIO3WKu/HD0wMYMGQZeBps2gWgnazuloVB5p8SOTKJt0MrRdAUpapkIGC/pEWQ2kCrcsZjOXZ3CTtincv50X1+QqcJzg0jGpg2ndoIsJPoWTe1St+BpJTHEjEcZ5b673VKQdFag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mm+UKAdhfdscAtLxwHrWPWYX+y7j7grRWRWz+3jKFEY=;
 b=JPWFrFlkO1agLrX/rtUdnIEA8ruNcc5i0W8350xt3xRskWXBxCZyzF6Uk+GWE+NLV3BS8fqGFrMjgCk0zS1dKyKP22GkKDoUbJKGM7udt4RPiyQCigbgELK2KtceCnYxpRnlFACu2icKxY7G+tWRAnIRks1tjMGCugxdTitWIoLh3AMto6Kv9Sv9hCdImIqZyt865NYzedyKDdrUkYNK6MkEK417Q1YBJ4ozcR14OJMhSZiB/EX0QJzCE0H0a8A8BJlcEWCjsbw0Kj3Hd0eoPvQ8ckJDoTwSR48dZ/+V9AZhDYl/psGSOa1E2h1mhJPFlnWieAIJZHlF6z1pknFwMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mm+UKAdhfdscAtLxwHrWPWYX+y7j7grRWRWz+3jKFEY=;
 b=OuRxqlmqL+bKIFRGQB1txxoKewoUGRDUGdhmQ75o1H92ThDCjJ32jCvDlWvHmEBUPOx+uiNKOFcKZB9hj821eknEqv9gbD03XUVPyJ5/61gZkqcQ0Nuey/Y2y/YJqQ7XTtLQ5LYXnYMYkvCAN8DoDi88AvEVCr2y4xaZ3U+KXWw=
Received: from BYAPR04MB5749.namprd04.prod.outlook.com (20.179.57.21) by
 BYAPR04MB4470.namprd04.prod.outlook.com (52.135.237.79) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2602.15; Tue, 7 Jan 2020 18:14:17 +0000
Received: from BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::a8ea:4ba9:cb57:e90f]) by BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::a8ea:4ba9:cb57:e90f%5]) with mapi id 15.20.2602.016; Tue, 7 Jan 2020
 18:14:17 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "dm-devel@redhat.com" <dm-devel@redhat.com>,
 "lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>
Subject: [LSF/MM/BFP ATTEND] [LSF/MM/BFP TOPIC] Storage: Copy Offload
Thread-Topic: [LSF/MM/BFP ATTEND] [LSF/MM/BFP TOPIC] Storage: Copy Offload
Thread-Index: AQHVxYZFlOEpmvYia0KWnm3aEM0giQ==
Date: Tue, 7 Jan 2020 18:14:17 +0000
Message-ID: <BYAPR04MB5749820C322B40C7DBBBCA02863F0@BYAPR04MB5749.namprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e26e0278-6748-4345-c3ec-08d7939d6903
x-ms-traffictypediagnostic: BYAPR04MB4470:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR04MB4470E21158188BE326CB46FE863F0@BYAPR04MB4470.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 027578BB13
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(376002)(346002)(396003)(39860400002)(136003)(366004)(189003)(199004)(53754006)(33656002)(2906002)(4326008)(478600001)(55016002)(9686003)(186003)(66476007)(7696005)(66446008)(66946007)(66556008)(6506007)(76116006)(64756008)(54906003)(316002)(110136005)(26005)(8676002)(66574012)(8936002)(81156014)(71200400001)(7416002)(81166006)(966005)(5660300002)(86362001)(52536014)(15398625002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:BYAPR04MB4470;
 H:BYAPR04MB5749.namprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kDiD37JNy1JZmPtUS/37Sot6KGO73Hr4rc05OR1VzDSubpJwBFTBrLy2vPoeuGAMUDb4oy5pRobKRBOlvIJHO3PDlOIaUwFDwBRNDwx6E0rHT77ih8YhfWSca8Ew3nJTXYnRtK2HCwvL8uucm4+J9kOYyPtrNZM8e/yHIDa+91/8cA3n2zKOWAKEzoVydKcOFy+C+d2McSr5/Vb7EG7fpwg0Zf4tggfjt0NAoZ2S75ZmPYrhVNnFs2sWnu8e3Dzn6Xjb8vHKwkQ78uEg4mnajXZ8DaDq9kqf3T6sx7H4muj+ig1W/2ObezykOBLiMCW22m9oYGQl4Cwq+QqsdX3GqBi62qzuW7z6iW1ri8ZlfEN6CslbzPwJ11T6GI44O3M3IxNg6JTwd4V6uxskDZiK5UFra0oPZXZK5Xzdp9bTpnBBqkI4XDjMoe2/uKqB/fRbfk2KPJb4L6AfrkuqJH5geTlZphIyKCyN9CoaxrhFtdYYxe6Q1rDArZ49Mh/1O6twzdsCNl1D3CYPR311WIJF6nPdXpFWRTg1XsOe1YmojErl1R9aq7dzI0uqlsuInACjt6upEoY3J1kWn4Y7WbpUNVmbmALqJdbqzHuQai2FUlE=
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e26e0278-6748-4345-c3ec-08d7939d6903
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jan 2020 18:14:17.5528 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uV11/h+HQVGH+b5DmUGntMKLo6BW2Q3YISL02PtEEeMRyp5pY6axhwkDnCH4dH8iJ4f4lPAG5T0mZXteMpMAYj8MU3qAbjzdfNp/Y0hhgoE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4470
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200107_101427_314048_A1F560A8 
X-CRM114-Status: GOOD (  12.95  )
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
 "msnitzer@redhat.com" <msnitzer@redhat.com>,
 "bvanassche@acm.org" <bvanassche@acm.org>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Matias Bjorling <Matias.Bjorling@wdc.com>, Stephen Bates <sbates@raithlin.com>,
 "roland@purestorage.com" <roland@purestorage.com>,
 "mpatocka@redhat.com" <mpatocka@redhat.com>, "hare@suse.de" <hare@suse.de>,
 Keith Busch <kbusch@kernel.org>, "rwheeler@redhat.com" <rwheeler@redhat.com>,
 Christoph Hellwig <hch@lst.de>,
 "frederick.knight@netapp.com" <frederick.knight@netapp.com>,
 "zach.brown@ni.com" <zach.brown@ni.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hi all,

* Background :-
-----------------------------------------------------------------------

Copy offload is a feature that allows file-systems or storage devices
to be instructed to copy files/logical blocks without requiring
involvement of the local CPU.

With reference to the RISC-V summit keynote [1] single threaded
performance is limiting due to Denard scaling and multi-threaded
performance is slowing down due Moore's law limitations. With the rise
of SNIA Computation Technical Storage Working Group (TWG) [2],
offloading computations to the device or over the fabrics is becoming
popular as there are several solutions available [2]. One of the common
operation which is popular in the kernel and is not merged yet is Copy
offload over the fabrics or on to the device.

* Problem :-
-----------------------------------------------------------------------

The original work which is done by Martin is present here [3]. The
latest work which is posted by Mikulas [4] is not merged yet. These two
approaches are totally different from each other. Several storage
vendors discourage mixing copy offload requests with regular READ/WRITE
I/O. Also, the fact that the operation fails if a copy request ever
needs to be split as it traverses the stack it has the unfortunate
side-effect of preventing copy offload from working in pretty much
every common deployment configuration out there.

* Current state of the work :-
-----------------------------------------------------------------------

With [3] being hard to handle arbitrary DM/MD stacking without
splitting the command in two, one for copying IN and one for copying
OUT. Which is then demonstrated by the [4] why [3] it is not a suitable
candidate. Also, with [4] there is an unresolved problem with the
two-command approach about how to handle changes to the DM layout
between an IN and OUT operations.

* Why Linux Kernel Storage System needs Copy Offload support now ?
-----------------------------------------------------------------------

With the rise of the SNIA Computational Storage TWG and solutions [2],
existing SCSI XCopy support in the protocol, recent advancement in the
Linux Kernel File System for Zoned devices (Zonefs [5]), Peer to Peer
DMA support in the Linux Kernel mainly for NVMe devices [7] and
eventually NVMe Devices and subsystem (NVMe PCIe/NVMeOF) will benefit
from Copy offload operation.

With this background we have significant number of use-cases which are
strong candidates waiting for outstanding Linux Kernel Block Layer Copy
Offload support, so that Linux Kernel Storage subsystem can to address
previously mentioned problems [1] and allow efficient offloading of the
data related operations. (Such as move/copy etc.)

For reference following is the list of the use-cases/candidates waiting
for Copy Offload support :-

1. SCSI-attached storage arrays.
2. Stacking drivers supporting XCopy DM/MD.
3. Computational Storage solutions.
7. File systems :- Local, NFS and Zonefs.
4. Block devices :- Distributed, local, and Zoned devices.
5. Peer to Peer DMA support solutions.
6. Potentially NVMe subsystem both NVMe PCIe and NVMeOF.

* What we will discuss in the proposed session ?
-----------------------------------------------------------------------

I'd like to propose a session to go over this topic to understand :-

1. What are the blockers for Copy Offload implementation ?
2. Discussion about having a file system interface.
3. Discussion about having right system call for user-space.
4. What is the right way to move this work forward ?
5. How can we help to contribute and move this work forward ?

* Required Participants :-
-----------------------------------------------------------------------

I'd like to invite block layer, device drivers and file system
developers to:-

1. Share their opinion on the topic.
2. Share their experience and any other issues with [4].
3. Uncover additional details that are missing from this proposal.

Required attendees :-

Martin K. Petersen
Jens Axboe
Christoph Hellwig
Bart Van Assche
Stephen Bates
Zach Brown
Roland Dreier
Ric Wheeler
Trond Myklebust
Mike Snitzer
Keith Busch
Sagi Grimberg
Hannes Reinecke
Frederick Knight
Mikulas Patocka
Matias Bj=F8rling

[1]https://content.riscv.org/wp-content/uploads/2018/12/A-New-Golden-Age-fo=
r-Computer-Architecture-History-Challenges-and-Opportunities-David-Patterso=
n-.pdf
[2] https://www.snia.org/computational
https://www.napatech.com/support/resources/solution-descriptions/napatech-s=
martnic-solution-for-hardware-offload/
      https://www.eideticom.com/products.html
https://www.xilinx.com/applications/data-center/computational-storage.html
[3] git://git.kernel.org/pub/scm/linux/kernel/git/mkp/linux.git xcopy
[4] https://www.spinics.net/lists/linux-block/msg00599.html
[5] https://lwn.net/Articles/793585/
[6] https://nvmexpress.org/new-nvmetm-specification-defines-zoned-
namespaces-zns-as-go-to-industry-technology/
[7] https://github.com/sbates130272/linux-p2pmem
[8] https://kernel.dk/io_uring.pdf

Regards,
Chaitanya

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
