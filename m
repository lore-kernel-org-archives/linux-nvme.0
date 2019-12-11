Return-Path: <SRS0=peCB=2B=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64185C43603
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Dec 2019 06:16:47 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F326208C3
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Dec 2019 06:16:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="j494+y8j";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="PBB4Zalt";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="dB6BCVZE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F326208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=U4+frq3IkKlSn8CY//VWxRhCr9hpL9Mfp+VVrXoNT9k=; b=j494+y8j5DZqNT
	9mjMEKN7FMz06DHA+jFPNZAU1ye9geS58Kutcm69jbhDCfccv2KQxS3R5bs81hnJJ25SZhgjlCklv
	Ct7U3sHaCtEEZLgh21UlwM34kvMGYykrChEziTJRY1BTqIzSD8VLW8rtH3S5EqODZ5Mh++hivrpSd
	gD4QMz8XVJQ4rBER7Z2PcQgZMkcYbF4QtfOI+WVW2q3TsBrXLD+SZ8KJ6zq8XndUwa2A8fVLCrgrK
	C9CUcmT3TeLTWIdGBYtaHMOUsZSTZzJeyYXWVIWvBmxSeXa30ac8Po0N8kdN8MWMEsPoiZ3KiQr0i
	YjjDAdRJN1t4OA3IIydQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1ievId-0000mp-HB; Wed, 11 Dec 2019 06:16:39 +0000
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1ievIa-0000mR-GO
 for linux-nvme@lists.infradead.org; Wed, 11 Dec 2019 06:16:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1576044996; x=1607580996;
 h=from:to:cc:subject:date:message-id:
 content-transfer-encoding:mime-version;
 bh=wKrKs4Fth6/z7XFVwrltfSTgFcadUHn/ome+7YOJHIc=;
 b=PBB4ZalttUpF83be4pgRVgznnm2sOPkYg7tVoaOj0eLo7pggxaaLyi27
 9wl354EhroP9o+QXs7nGKLOMU6fZqiPQvQDUZOPOPp7PbtrUsXRPwjxCi
 YY1AmletbhGq4SYl/APk16bD8G5lf1hvnzTrUXG5a09GRkM/VHP4L7SrD
 QmqWY57DuaJ0+E7K3t8VUV3ZdQTWTruz6QyZ71KonrAubisedFfKN83ap
 ldkzU7QuD7fEuYyEzfxGk0EpAeovK7OpY+WFJRr/1M8p/FmJYIXi9yBzv
 FRUD4mI1zbt+H2KRUgz8TBI3uIaQpCJs25Q/Y5SRpDbwCHye8A4gZeaYn w==;
IronPort-SDR: TRk11DTviKUKVUeYCXqNc6aCA0MqYZpXyPv6AZpK4I5MVyxnVQtTfkDHcpiHfwpw8uI7ZnpIru
 zHExT22uBdfR/c5uiJkkdXxDjW8eHqEWO1IeGrigeYgBNORDKAi+gEaSNqjW9EX7ESzNi2J2CG
 Pahtc2zTe2PslwOwk0PCEVOSkKpSAWmUfqAt+LeiS8PAylOIZtxGDezw53cRhp7fd0rHdrkLoS
 9LP4f8tbS+FB7vtIeTMk6t2P7ffQ+3BHYvsmFcNXjJQ4NMtrAhw6sggEdODdnFexC0E5HAkivq
 H34=
X-IronPort-AV: E=Sophos;i="5.69,301,1571673600"; d="scan'208";a="232612405"
Received: from mail-bn8nam12lp2176.outbound.protection.outlook.com (HELO
 NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.176])
 by ob1.hgst.iphmx.com with ESMTP; 11 Dec 2019 14:16:32 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iH076ko/hl+QLTg85syzEVpe6oxJmZqyVgxcVGQ//ncz6X1dEqHloWt7n45OhQs03Q3FEgy1Pe8LUhGlXcO8bq9cU7PzS1k8jBdB2pYLQl9/yy0eXLqKMf8AB2tWwt29dQxWAmH+JrOuSpQ+viN/JCrGO4olBawmB/q55LOLEuLsm/oBQn/b60XIAIkyZmdu3JRIPu9Ri8TXq961isq6oVUlchC7WFmVESWz2fJwB1FYZ29XgCtd0ShwgFJFAx6p3Xsjs1qr4gqvL+E9F6YIQ6V1osacZWRqL7dvj4pCoiQje6pEPGJIAbG62R24YFQtQSYizU9tCptcTsy2BRYpxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5oAeDD/L0QXcCKoeafAvIYqBW/ibXXcwGxdJT2kQA98=;
 b=MC1WUYCxJB2hjAEmkE08/qmjBqM0nQ389gvWGFcL1bNvw8MWifnPaJnvvP1cHlRE2+t6bMZl+LuHNWgMIl1m+BCUUT5F7q6ujKYAL6Uh7Zlzu+5LN6dnh426ki3fyFO7XIdVA9ID4eHrWFQsKw+pXdgMiNhKa1ZN7x4Vl6C+22z0WD7uTzylXqeRLcE8GgQ2JK+1bLp5rmDUZFj1ntGOSkn5kgWe8VATpEY/FIFM3cpfxmtdmC/5yO01DTjRo9ZRyI7mGdR39iGQghPF9LtiMdc1UprtGamoe3tc6DZ+lUmTK8cIvuwY4+Aw01H3xj85lqjL/rOVF9pbGRnZ1oZ4gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5oAeDD/L0QXcCKoeafAvIYqBW/ibXXcwGxdJT2kQA98=;
 b=dB6BCVZEXvycpOlR3LQ6hsqVwa04jwKFKmWdFVQjyXxMSL/86cIT4I/MTe0eST8i9zevZF9uMCDJ0nOpdacU84W7EP6woa963v5CbpFuJUwg5FjOsTIJDJaoNhHFCpsH6ImmFJymC4uCF2ehY2swn5d+cmo3KsSTkt+ZsXxRWhU=
Received: from BYAPR04MB5749.namprd04.prod.outlook.com (20.179.57.21) by
 BYAPR04MB6232.namprd04.prod.outlook.com (20.178.232.207) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.15; Wed, 11 Dec 2019 06:16:29 +0000
Received: from BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::c3e:e0b4:872:e851]) by BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::c3e:e0b4:872:e851%7]) with mapi id 15.20.2516.018; Wed, 11 Dec 2019
 06:16:29 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: "lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>
Subject: [LSF/MM/BFP ATTEND] [LSF/MM/BFP TOPIC] Storage: add blktrace
 extension support
Thread-Topic: [LSF/MM/BFP ATTEND] [LSF/MM/BFP TOPIC] Storage: add blktrace
 extension support
Thread-Index: AQHVr+qGZa1SvOsf40W81LFPPtqF+Q==
Date: Wed, 11 Dec 2019 06:16:29 +0000
Message-ID: <BYAPR04MB5749B4DC50C43EE845A04612865A0@BYAPR04MB5749.namprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8b4ea572-9091-42b9-709e-08d77e01a944
x-ms-traffictypediagnostic: BYAPR04MB6232:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR04MB6232E5FDAC18FAED4AA2FE58865A0@BYAPR04MB6232.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 024847EE92
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(136003)(39860400002)(366004)(376002)(346002)(396003)(199004)(189003)(78114003)(71200400001)(186003)(26005)(52536014)(5660300002)(7696005)(6506007)(4326008)(966005)(86362001)(316002)(478600001)(2906002)(54906003)(81166006)(9686003)(8936002)(8676002)(81156014)(7416002)(6916009)(66946007)(64756008)(66446008)(66476007)(33656002)(76116006)(55016002)(66556008)(21314003);
 DIR:OUT; SFP:1102; SCL:1; SRVR:BYAPR04MB6232;
 H:BYAPR04MB5749.namprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jitJ1K7ITxNBu9+GmPVPzwWBsyV9o8I1dykswJhMK7/YOziHaJL5RDIX8hZx9ZDKAPtwvPOUWJXET4KcWIl+n9Vzajj9yYqEe6jr5FyyiVFyirP+D5vtq2jaGFmNiz/B1NoQpl1XBwI0K8hruTDrIwtbTd8k6BHyz0QjHkJYT3Mz5EkftVfBj9Yvw+1y5sC+3UbIF1kZ5P54BNSqxDiQViEL6iOzL0BwRRalt8b8k3Vx7M8itLCPdlZA1wIUn6OoTmVdjszBYDuxLUv/Tlbd8YDDrtXPQh81eJnZIiM9M6hue9dnljE/QL2aYNrLCuZ7NP1LHe1ss7qC48nz+s82ZzSpvCnvDgMtBOTtTI1mMNoiAC2kRiTyIv6VY0hIu6lDcTSbuDx5fdq8EoD4HfwOAS5OyfB0yhFkY/KrwTdMfymtxdxxdFD5e9OYpDKIKbKzLZFE6bH3pahWlOJuIXvWdqOWtC4ioHKA2j8miimVpIDCYF8RLlVh6PcmmwFRTP09VJw9MadIbVPeq6oU2wVFGEcNeNMxqS7GhZ8L1Nr3+gFfJt8cLtviwYxMo0DYDfYG
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b4ea572-9091-42b9-709e-08d77e01a944
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Dec 2019 06:16:29.4347 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7Mtgm4EzbLIE2WEMlfCWpKPYXQLWrPYboSw3VXb/hBNtdz8NGvcuoSlGXoD21MslNdCfrk/Y1NUtNaQvzSJ5OMx1dq1mL+VI7JWGTkJ/xjg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB6232
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191210_221636_640092_F0207D9B 
X-CRM114-Status: GOOD (  10.72  )
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
 "linux-btrace@vger.kernel.org" <linux-btrace@vger.kernel.org>,
 "Theodore Y. Ts'o" <tytso@mit.edu>, Bart Van Assche <bvanassche@acm.org>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Christoph Hellwig <hch@lst.de>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
 Hannes Reinecke <hare@suse.de>, Johannes Thumshirn <jthumshirn@suse.de>,
 Keith Busch <kbusch@kernel.org>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 Ming Lei <ming.lei@redhat.com>, Omar Sandoval <osandov@fb.com>,
 Matias Bjorling <Matias.Bjorling@wdc.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hi,

* Background:-
-----------------------------------------------------------------------

Linux Kernel Block layer now supports new Zone Management operations
(REQ_OP_ZONE_[OPEN/CLOSE/FINISH] [1]).

These operations are added mainly to support NVMe Zoned Namespces
(ZNS) [2]. We are adding support for ZNS in Linux Kernel Block layer,
user-space tools (sys-utils/nvme-cli), NVMe driver, File Systems,
Device-mapper in order to support these devices in the field.

Over the years Linux kernel block layer tracing infrastructure
has proven to be not only extremely useful but essential for:-

1. Debugging the problems in the development of kernel block drivers.
2. Solving the issues at the customer sites.
3. Speeding up the development for the file system developers.
4. Finding the device-related issues on the fly without modifying
    the kernel.
5. Building white box test-cases around the complex areas in the
    linux-block layer.

* Problem with block layer tracing infrastructure:-
-----------------------------------------------------------------------

If blktrace is such a great tool why we need this session for ?

Existing blktrace infrastructure lacks the number of free bits that are
available to track the new trace category. With the addition of new
REQ_OP_ZONE_XXX we need more bits to expand the blktrace so that we can
track more number of requests.

* Current state of the work:-
-----------------------------------------------------------------------

RFC implementations [3] has been posted with the addition of new IOCTLs
which is far from the production so that it can provide a basis to get
the discussion started.

This RFC implementation provides:-
1. Extended bits to track new trace categories.
2. Support for tracing per trace priorities.
3. Support for priority mask.
4. New IOCTLs so that user-space tools can setup the extensions.
5. Ability to track the integrity fields.
6. blktrace and blkparse implementation which supports the above
    mentioned features.

Bart and Martin has suggested changes which I've incorporated in the RFC 
revisions.

* What we will discuss in the proposed session ?
-----------------------------------------------------------------------

I'd like to propose a session for Storage track to go over the following
discussion points:-

1. What is the right approach to move this work forward?
2. What are the other information bits we need to add which will help
    kernel community to speed up the development and improve tracing?
3. What are the other tracepoints we need to add in the block layer
    to improve the tracing?
4. What are device driver callbacks tracing we can add in the block
    layer?
5. Since polling is becoming popular what are the new tracepoints
    we need to improve debugging ?
 

* Required Participants:-
-----------------------------------------------------------------------

I'd like to invite block layer, device drivers and file system
developers to:-

1. Share their opinion on the topic.
2. Share their experience and any other issues with blktrace
    infrastructure.
3. Uncover additional details that are missing from this proposal.

Regards,
Chaitanya

References :-

[1] https://www.spinics.net/lists/linux-block/msg46043.html
[2] https://nvmexpress.org/new-nvmetm-specification-defines-zoned-
namespaces-zns-as-go-to-industry-technology/
[3] https://www.spinics.net/lists/linux-btrace/msg01106.html
     https://www.spinics.net/lists/linux-btrace/msg01002.html
     https://www.spinics.net/lists/linux-btrace/msg01042.html
     https://www.spinics.net/lists/linux-btrace/msg00880.html

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
