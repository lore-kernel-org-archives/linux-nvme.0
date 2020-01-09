Return-Path: <SRS0=Ii44=26=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F7C8C282DD
	for <linux-nvme@archiver.kernel.org>; Thu,  9 Jan 2020 12:59:39 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E6B5A2077C
	for <linux-nvme@archiver.kernel.org>; Thu,  9 Jan 2020 12:59:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="QhgsqsyQ";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="FdFq/rku";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="OOa9ig4g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6B5A2077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date
	:Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=OS9pCo02usVtlfUeEqvJhUgOPDwstFLZyE7VmR9kh9U=; b=QhgsqsyQStjWJs
	aOnBnjeYZGjlbxRpAfr1W8RcEzXR9jVZKrn+jAK9jqGS5wua3p2jQ2j3d4Iwg3BB8HFj+DT6c60ih
	24JazQ4R68bSR2ELvOM0yaUnaghdf8qs0gTAX5A79XiqpbiV6TAA1B2SLjU7bgNddOTEG509ZyMoU
	GgSnIOluRIa/om7AxiUjJmVxTwvRrDMGAeZzTUM5qyiQHEAbW427U2eN64qGhlAV0G95tVrk6BRFW
	sCCNShUuNggCtX9qza3b6Xk9B077XGF1X0GFaQdyTiw6/EDAN2/2bg6UevWcUyVifJJLR9KyQs1Qu
	k0H3+7yufNSk505gt4BA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1ipXPN-0004QY-JI; Thu, 09 Jan 2020 12:59:29 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1ipXPK-0004PF-9L
 for linux-nvme@lists.infradead.org; Thu, 09 Jan 2020 12:59:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1578574766; x=1610110766;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=wf1Fg2sCoJ4Mlv3XgjiWmlGNpwmS7N7TM5jzYc9wLSk=;
 b=FdFq/rkumtggAMe3TXwU7JJ+9LU2UU+9WmGRsxE1WuiHxdIfOs1Q3rfe
 slFtPc46yuAuWN0E47SqI9mJ0wjIYOxxm0L1X/8Vvk0WNynUtVd+yjaMv
 LN/HAZ2+n10pe1igGutJydIIveYCyAZG6IODWg6aWLy0Iax8B6F/NXZV9
 NGUpbaQM7cSRfMrehCvg2G1lN6X5AK0oiPNsTP49l3jIEIq8BH61F0MTL
 bGvdi5xj/x/LMXA1fuyDBKMvhx9ivnRGOkfciH2IQGScYA/4lUflNMey+
 LLtBW1HVMh92km73RDvSW1ehbQGhIPn0L3RpCCWdCoMnbJgR86DJhNtMD g==;
IronPort-SDR: XQoapWDfRtD7g5b1MQth8iN1PEJhEspFZBbgdG/fGwOACn6hX3IyAmc5oRicPTyKSdRgq4NkUP
 WXQSfns7xNpQf4dzZIkBuM3We59RlvAk/Tq7qLmF5yXdCowQjDavo1N0jRkc06Qj2gbPL3i/Ox
 FqUKdC3kJpM82lcjVU9xffBRy9mbItil7/ybcF5g13j6pg86QPgY2mDHpvmm12glMej62tMKIc
 Qsp0+yNPHa+vprd4wxZseRFWwrdbMyFgxRwBnllClN1eRHgmVZ7yD8ERC9LVC3Ba0H1vO025Ie
 Clg=
X-IronPort-AV: E=Sophos;i="5.69,413,1571673600"; d="scan'208";a="127777408"
Received: from mail-bn8nam11lp2174.outbound.protection.outlook.com (HELO
 NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.174])
 by ob1.hgst.iphmx.com with ESMTP; 09 Jan 2020 20:59:21 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fNrf4yBhqMqn+tLmVo5syHXZNbn8TTHkbQSzX5uDZMsbq7WfT1rZ0ENFD0a0WIywfJrvnoJaN6pzzH1SX9mEZoDmFvUK7E1R/KrtXrBXziiouy4L1MS+k1Xu0Czv6kga2D6nsH1PvKdd2m//W6RcomgwWjBdZ0VpSQPvfKG7o6pooPLED1YZhAZ7DviZi42lP2BNqySHidELzagoe3qCV0PfsJukMnE1yM91VGyHNwV9yDWkgV7oCaWok0Lyq6MVuwH5arT8wpoZkexRZohNNm3SgENxH6Ex3D4E+d8oQn1dlZ8SIuFfdq+z2iz58i57xOhBkEd2A/N9FvSjxGPpUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cDl0w8nt+ChFpGd/dTvZFcsVVUFi2d7Plw7MCQ4qPB4=;
 b=E2Wx994gFoyZ3+cLjUiT2fF8M10V34GeX2Izajz6ewaMMombFoTxShQkSec2V7+rVOn+hKDhy11S7xXPxM3VFfWZkAxbfHW4eniGS3CY51PnaAaZpPDjcx7kbQ0n/eTW6wESB3+DlWRjwcpAajq8wvHxxKZXTkOMUxrjgZgqo6VRkeSUBgN+DWMBo6IlPXHUzFeH4A+LCzNQtnp7fHvCZRD3tl2ReguSCROndrNZzKOtUaUk/a1ENm3FYRskCI+VgCJkNZm6rCLngHwYNejmAiOBRiUz3I0Z5P1b4dJT4Ek76CwMW5bQI9PH02FX3PCLTv/5m40q1SjXLaBvZgapjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cDl0w8nt+ChFpGd/dTvZFcsVVUFi2d7Plw7MCQ4qPB4=;
 b=OOa9ig4gpY5dpBO5XemYdfUcvuntxlGD+ICNqZZ8BqFp7rLnSHn8iI3DfcLOTOkJvEqP6kJ1wMpRB2TUh0HNXJlaqXi6CE4pnPJ7rGoM04w8dNdYz4se+StzRnOGLXbxa3SJi0b+4iqNW95PDZKqgaFgkVGrHEKqL2uY0eUR55I=
Received: from BYAPR04MB5816.namprd04.prod.outlook.com (20.179.59.16) by
 BYAPR04MB4150.namprd04.prod.outlook.com (20.176.250.156) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.9; Thu, 9 Jan 2020 12:59:19 +0000
Received: from BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::cd8e:d1de:e661:a61]) by BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::cd8e:d1de:e661:a61%5]) with mapi id 15.20.2602.018; Thu, 9 Jan 2020
 12:59:18 +0000
From: Damien Le Moal <Damien.LeMoal@wdc.com>
To: Hans Holmberg <hans@owltronix.com>, Chaitanya Kulkarni
 <Chaitanya.Kulkarni@wdc.com>
Subject: Re: [LSF/MM/BFP ATTEND] [LSF/MM/BFP TOPIC] Storage: add blktrace
 extension support
Thread-Topic: [LSF/MM/BFP ATTEND] [LSF/MM/BFP TOPIC] Storage: add blktrace
 extension support
Thread-Index: AQHVr+qGZa1SvOsf40W81LFPPtqF+Q==
Date: Thu, 9 Jan 2020 12:59:18 +0000
Message-ID: <BYAPR04MB58163E5A9D64C7367BFCEDC7E7390@BYAPR04MB5816.namprd04.prod.outlook.com>
References: <BYAPR04MB5749B4DC50C43EE845A04612865A0@BYAPR04MB5749.namprd04.prod.outlook.com>
 <BYAPR04MB5749EDD9E5928E769413B38086520@BYAPR04MB5749.namprd04.prod.outlook.com>
 <CANr-nt0=C+1v=1MU6eNhX0-X4CEvc7D2UEF02oRMNHraQ1FRow@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Damien.LeMoal@wdc.com; 
x-originating-ip: [60.117.181.124]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ee4d92b8-684c-40d0-ffc9-08d79503bd4d
x-ms-traffictypediagnostic: BYAPR04MB4150:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR04MB415015333536B5710D864283E7390@BYAPR04MB4150.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 02778BF158
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(376002)(366004)(346002)(396003)(136003)(39860400002)(78114003)(199004)(189003)(186003)(6506007)(54906003)(81156014)(76116006)(7696005)(26005)(64756008)(66556008)(66476007)(66946007)(6636002)(55016002)(9686003)(110136005)(316002)(2906002)(71200400001)(66446008)(53546011)(33656002)(5660300002)(7416002)(8676002)(966005)(4326008)(478600001)(91956017)(8936002)(86362001)(52536014)(81166006)(21314003);
 DIR:OUT; SFP:1102; SCL:1; SRVR:BYAPR04MB4150;
 H:BYAPR04MB5816.namprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qSga9BkaKJ3vk+4BBZBiadLh4BFuoI7mI3H4QDVsrR9iN0jQWSyRnf4qBeixc90pEBm/YHgkf8g2Nr7+JlBaEI84NluvW1+xhdGTI+LVxex38U0KNsb1ULyX1jyjeHRYjKX6Kv539kefM3zPJeWRQAc9g/bdvIKUI2q6ugprnba9pilrNP+W1nJcpj0Z+yDDjJv92WEhVeitqIrItRhafFS2YVhd97xUYGQbVogzFy3q4rUO+HzUXYZPzcVnqldc2egt4kowd+Lxx5MvMgZUhXOBL1Y6GoV9SFGyf86Fv6NRPYZpeyOuNI/mib5NM4+DmDnxBUO4Zn5Jl+OqM56U6Z4YJ4CCHGWT43LFm7CEvD2zjO6mXKplDlVAB5PG6tg93wOo6egBNVXYNUWs0dZp4DgFGS2809nmizovP6SkkxzhX3WB07R28tmNuTOWa/p+ujCKqVm9owmlPkjPNVrXXPMydcB8cxOlDH5EoEEzEINObs8gZGMDLL5y5/7118EEmwdsA9oYwTQuMtOLxT+yEFvq5VexJIa6gBiCK0JsHAbqPWHViE5zGClma9CAlsj+/SmtHixpuzYnJijrJjnw3Q==
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee4d92b8-684c-40d0-ffc9-08d79503bd4d
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jan 2020 12:59:18.8731 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lqk7HLIYvdtpBYc5lOkNbhHY0JqlzbkAI1yZJ52Kudwz/JK4uJMz4ov2sGeSUNusSu3ry7+M8Hcsl+aABDaxEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4150
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200109_045926_366718_E3151593 
X-CRM114-Status: GOOD (  16.11  )
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
Cc: "axboe@kernel.dk" <axboe@kernel.dk>, Ming Lei <ming.lei@redhat.com>,
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
 "lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>,
 Omar Sandoval <osandov@fb.com>, Matias Bjorling <Matias.Bjorling@wdc.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 2020/01/09 19:19, Hans Holmberg wrote:
> On Thu, Dec 19, 2019 at 6:50 AM Chaitanya Kulkarni
> <Chaitanya.Kulkarni@wdc.com> wrote:
>>
>> Adding Damien to this thread.
>> On 12/10/2019 10:17 PM, Chaitanya Kulkarni wrote:
>>> Hi,
>>>
>>> * Background:-
>>> -----------------------------------------------------------------------
>>>
>>> Linux Kernel Block layer now supports new Zone Management operations
>>> (REQ_OP_ZONE_[OPEN/CLOSE/FINISH] [1]).
>>>
>>> These operations are added mainly to support NVMe Zoned Namespces
>>> (ZNS) [2]. We are adding support for ZNS in Linux Kernel Block layer,
>>> user-space tools (sys-utils/nvme-cli), NVMe driver, File Systems,
>>> Device-mapper in order to support these devices in the field.
>>>
>>> Over the years Linux kernel block layer tracing infrastructure
>>> has proven to be not only extremely useful but essential for:-
>>>
>>> 1. Debugging the problems in the development of kernel block drivers.
>>> 2. Solving the issues at the customer sites.
>>> 3. Speeding up the development for the file system developers.
>>> 4. Finding the device-related issues on the fly without modifying
>>>      the kernel.
>>> 5. Building white box test-cases around the complex areas in the
>>>      linux-block layer.
>>>
>>> * Problem with block layer tracing infrastructure:-
>>> -----------------------------------------------------------------------
>>>
>>> If blktrace is such a great tool why we need this session for ?
>>>
>>> Existing blktrace infrastructure lacks the number of free bits that are
>>> available to track the new trace category. With the addition of new
>>> REQ_OP_ZONE_XXX we need more bits to expand the blktrace so that we can
>>> track more number of requests.
> 
> In addition to tracing the zone operations, it would be greatly
> beneficial to add tracing(and blktrace support) for the reported zone
> states.

That would require a *lot* of data (e.g. super large capacity SMR
drives) and a lot of addition to the hot path tracking write commands
and all zone commands. Also massive modifications of the error path for
that tracking to be correct, and that would need report zones itself. I
am really not for this.

> I did something similar[5] for pblk and open channel chunk states, and
> that proved invaluable when figuring out whether the disk or pblk was
> broken.
> 
> In pblk the reported chunk state transitions are traced along with the
> expected zone transitions (based on io and management commands
> submitted).

pblk being a logically defined device, it likely has some form of
tracking of zone state, similarly to what dm-zoned does. So it may be
easier in that case. But for physical drives, the amount of code/changes
and the runtime overhead of this tracking would not be acceptable in my
opinion.

I have debugged enough buggy SMR drives to know that blktrace is a great
help as is. Drive level debug features (fw logs etc) combined with
blktrace as-is can easily do the same.

> 
> [5] https://www.lkml.org/lkml/2018/8/29/457
> 
> Thanks!
> Hans
> 
>>>
>>> * Current state of the work:-
>>> -----------------------------------------------------------------------
>>>
>>> RFC implementations [3] has been posted with the addition of new IOCTLs
>>> which is far from the production so that it can provide a basis to get
>>> the discussion started.
>>>
>>> This RFC implementation provides:-
>>> 1. Extended bits to track new trace categories.
>>> 2. Support for tracing per trace priorities.
>>> 3. Support for priority mask.
>>> 4. New IOCTLs so that user-space tools can setup the extensions.
>>> 5. Ability to track the integrity fields.
>>> 6. blktrace and blkparse implementation which supports the above
>>>      mentioned features.
>>>
>>> Bart and Martin has suggested changes which I've incorporated in the RFC
>>> revisions.
>>>
>>> * What we will discuss in the proposed session ?
>>> -----------------------------------------------------------------------
>>>
>>> I'd like to propose a session for Storage track to go over the following
>>> discussion points:-
>>>
>>> 1. What is the right approach to move this work forward?
>>> 2. What are the other information bits we need to add which will help
>>>      kernel community to speed up the development and improve tracing?
>>> 3. What are the other tracepoints we need to add in the block layer
>>>      to improve the tracing?
>>> 4. What are device driver callbacks tracing we can add in the block
>>>      layer?
>>> 5. Since polling is becoming popular what are the new tracepoints
>>>      we need to improve debugging ?
>>>
>>>
>>> * Required Participants:-
>>> -----------------------------------------------------------------------
>>>
>>> I'd like to invite block layer, device drivers and file system
>>> developers to:-
>>>
>>> 1. Share their opinion on the topic.
>>> 2. Share their experience and any other issues with blktrace
>>>      infrastructure.
>>> 3. Uncover additional details that are missing from this proposal.
>>>
>>> Regards,
>>> Chaitanya
>>>
>>> References :-
>>>
>>> [1] https://www.spinics.net/lists/linux-block/msg46043.html
>>> [2] https://nvmexpress.org/new-nvmetm-specification-defines-zoned-
>>> namespaces-zns-as-go-to-industry-technology/
>>> [3] https://www.spinics.net/lists/linux-btrace/msg01106.html
>>>       https://www.spinics.net/lists/linux-btrace/msg01002.html
>>>       https://www.spinics.net/lists/linux-btrace/msg01042.html
>>>       https://www.spinics.net/lists/linux-btrace/msg00880.html
>>>
>>
> 


-- 
Damien Le Moal
Western Digital Research

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
