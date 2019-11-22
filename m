Return-Path: <SRS0=ia7R=ZO=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAC5EC432C0
	for <linux-nvme@archiver.kernel.org>; Fri, 22 Nov 2019 21:58:55 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F58920704
	for <linux-nvme@archiver.kernel.org>; Fri, 22 Nov 2019 21:58:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="k8KSkdd8";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=fb.com header.i=@fb.com header.b="MW2+FVVH";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="EL7VQcHb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F58920704
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=TpiursKz3RtUioQvvwHyadBjcMdivLjZdt5gARjKfbo=; b=k8KSkdd8tgIptn
	+8ibkmha3XaJydmyDYyLm57ArcE6qXgQePLOGMwcFNZxRUVal1Qh+HFgbYFjdi+xZpbXI+aNfWp4M
	gb+1HjOw08PzUZDjvtgclu6PorGshyLlijeyg7lnpvRikFowX2Cs98PPOl8MrE4dcQQAu48HSkw5b
	GLdGI7oaxrCZoTu60KQbCrhbbuPDxrSblVx2j+nSNDDT5LItfFB4HoUhCNo8ppd9Y+GWfQ0RpT1jz
	TxrW4O0hBsLJ/r8Q9Byam2HmyutmLk2iazqwd/n4oU/I8IEmKz+mNse17W9MKKRdK3B4mq6sOVyfB
	Y7lwd3D7nRIEx7DEgVyw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iYGx2-000270-Ty; Fri, 22 Nov 2019 21:58:52 +0000
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]
 helo=mx0a-00082601.pphosted.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iYGwz-00025z-QD
 for linux-nvme@lists.infradead.org; Fri, 22 Nov 2019 21:58:51 +0000
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
 by m0001303.ppops.net (8.16.0.42/8.16.0.42) with SMTP id xAMLqr6E029924;
 Fri, 22 Nov 2019 13:58:39 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com;
 h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=0LHMsOr535I/qeWvuXOteh2+RjgRfiavqFTtQNRkU1o=;
 b=MW2+FVVH3k0g24Ea/B3/ZgA2dgnhcJ0KyH9bjcKuwwiATQ7nxWpDs/OqrfykP40V4w5O
 f4VPk0Mmc3JpdXRWCAQjKnjIGkR7fdapAWlOuYDKi4NW99yQxWMw/VODKyAkchsehgmn
 DFzBs851xsY+fD6S0wpHG5meJ0amj95v81E= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
 by m0001303.ppops.net with ESMTP id 2wdtbk8h4v-3
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
 Fri, 22 Nov 2019 13:58:38 -0800
Received: from prn-mbx02.TheFacebook.com (2620:10d:c081:6::16) by
 prn-hub01.TheFacebook.com (2620:10d:c081:35::125) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Fri, 22 Nov 2019 13:58:37 -0800
Received: from prn-hub06.TheFacebook.com (2620:10d:c081:35::130) by
 prn-mbx02.TheFacebook.com (2620:10d:c081:6::16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Fri, 22 Nov 2019 13:58:37 -0800
Received: from NAM03-CO1-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Fri, 22 Nov 2019 13:58:37 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VuOoVJCnSCuF9vmxhXtiItr7eKJKL2ivUgcAbZ+pVWsA9KL8yLtFQQtHFF6Pw6Ca2VoD9opMrBmaFJJX/rhD7mEdx1gAwKeJF66jrzSwzejttY9k+38i0dlwpUqwjk7ZNxre9F1T4CDlpHgWdTdvCCWS4k9UV+i/g12ScGzMTf1WamUau3J2EdvaseezXcIzlG1/1egKqanp/wJp987wl1lKt1LJmYAS9UhPXcEEkWUpD6SazR3W/l9OU6ZSnk00Bgx4YJ7/0h9prisWDyQblrMh3GSsKsWqTayd8XeaTTxKR74cj9uwVgn7UNZEFXrKG4bU7/2kRJmOF935wrug5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0LHMsOr535I/qeWvuXOteh2+RjgRfiavqFTtQNRkU1o=;
 b=UFcOGxWZ1/NTVQx4CHF/yAv3eVTD+oqfGKdznFrdlq6EtexQYT6u/W36aTA2buN9hi8/KiHLEna1mPXhYc9VAI+bLx66PuwpR72VUKX9BDVbEy74wCNWOtsXO9LY+A+Gfm1XyfVvuK116ZRzogX3AmSEGVXui8j+/cIM34OgTxFUOiGIKeJ9D5D/KZaoQE3ZS9NexB2Mt3PxDHqhkdhcwtwCrtykfBeT+XHhCJvh8jaIJ74adw5wXsgJmcNGvk+sr3yFJkM06Ty8TrpcXoRonFN3iECRAzA1wMmjMv4IIU8I63GPCJUMxZvtNOYAO3z1xwMhABnfP6/DXopIzu1GFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0LHMsOr535I/qeWvuXOteh2+RjgRfiavqFTtQNRkU1o=;
 b=EL7VQcHbucP8dnVNTdxu8gaNkjSjUKoluWPMzenuzn9EDdRNRturMLyz0i63CjyD4fEFBPUcdAU8fq42fhINGlEdT9JaRRlSwMr87gMKOREjILvt/Z3R9rPhCBTRs03Ap8vBqs/YEgQPDr65sqm1N2nefmMwwv1+/Na+8mGd30M=
Received: from BYAPR15MB2790.namprd15.prod.outlook.com (20.179.158.31) by
 BYAPR15MB2407.namprd15.prod.outlook.com (52.135.198.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.28; Fri, 22 Nov 2019 21:58:36 +0000
Received: from BYAPR15MB2790.namprd15.prod.outlook.com
 ([fe80::1d32:6ae1:9e5d:d82a]) by BYAPR15MB2790.namprd15.prod.outlook.com
 ([fe80::1d32:6ae1:9e5d:d82a%6]) with mapi id 15.20.2474.018; Fri, 22 Nov 2019
 21:58:36 +0000
From: Jens Axboe <axboe@fb.com>
To: Ming Lei <ming.lei@redhat.com>
Subject: Re: [PATCH V3 0/2] nvme-pci: check CQ after batch submission for
 Microsoft device
Thread-Topic: [PATCH V3 0/2] nvme-pci: check CQ after batch submission for
 Microsoft device
Thread-Index: AQHVoRmOhHg+q4871ESK9S5CES20IqeW9F2AgAAHtICAAD1WgIAAgfIAgAACaoA=
Date: Fri, 22 Nov 2019 21:58:36 +0000
Message-ID: <9ef6c1da-99c5-14f8-edb7-af50c935ce76@fb.com>
References: <20191114025917.24634-1-ming.lei@redhat.com>
 <20191121031154.GJ24548@ming.t460p> <20191121061431.GA22886@lst.de>
 <20191121074643.GB4755@ming.t460p>
 <20191121154531.GB17852@redsun51.ssa.fujisawa.hgst.com>
 <20191122094457.GA23632@ming.t460p> <20191122095743.GA21087@lst.de>
 <20191122102517.GA30001@ming.t460p>
 <b5148303-f05d-71c8-787a-597958c1909c@fb.com>
 <20191122214954.GB8700@ming.t460p>
In-Reply-To: <20191122214954.GB8700@ming.t460p>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR02CA0042.namprd02.prod.outlook.com
 (2603:10b6:a03:54::19) To BYAPR15MB2790.namprd15.prod.outlook.com
 (2603:10b6:a03:15a::31)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [66.219.217.79]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ba200916-9444-4ad5-4983-08d76f971fbd
x-ms-traffictypediagnostic: BYAPR15MB2407:
x-microsoft-antispam-prvs: <BYAPR15MB2407F0E52A3A17C4C3E8A892C0490@BYAPR15MB2407.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 02296943FF
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(366004)(39860400002)(376002)(396003)(136003)(346002)(47530400004)(31014005)(189003)(199004)(229853002)(8676002)(54906003)(45080400002)(64756008)(186003)(31696002)(316002)(26005)(6486002)(102836004)(71190400001)(6512007)(14444005)(256004)(71200400001)(6916009)(4326008)(5660300002)(2616005)(6436002)(86362001)(6506007)(36756003)(11346002)(386003)(3846002)(99286004)(53546011)(14454004)(446003)(6246003)(31686004)(52230400001)(66446008)(66946007)(66476007)(66556008)(305945005)(66066001)(25786009)(81166006)(6116002)(52116002)(81156014)(76176011)(478600001)(2906002)(8936002)(7736002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:BYAPR15MB2407;
 H:BYAPR15MB2790.namprd15.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DDJCupsbc+nr098zWT95/spYmUO41fcG1KOq7JHZK6l+7a3tL2qwzhWbwAkVypSZbrVKPSzY9gm8LdTZbHBjynfOBcUArP+TL2hieik/fd6Xa1Z+eOG5CsVuDQaZccOAr+qgZb6y8V5DwGxzGZCzAjKS3rnMvvRknt6rMHI1fDCLoHdfk4TT76wxCLWwWDK38iR+O/syzGXonYzY3NINerJOsbaHYnniD5H5nJDRYt3idlW1SMI956WEBEs9XtFMnHHnwvGPhhnWFr1bZD0gnY5SKs0CrGPhX8GL6jEWPLt9hZVGeh8Pu5thbU5SKPMqAvdwXN1oV/C41DDs+sujiOTA676pA9gr8IGOTsKIFIR8WbKiJ9nUMYUlQbA1yTMvzECAxvtAKCGwBV2t8Wf5TXVA7siZ6/kk8JnT9mNfZvlCe1foYv8D3AwAE53ozb54
x-ms-exchange-transport-forked: True
Content-ID: <A4D0B837485BC94B8A2D0AB2F380AC11@namprd15.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: ba200916-9444-4ad5-4983-08d76f971fbd
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Nov 2019 21:58:36.1517 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dZIwLhsGbg+kTUWfAUjvggH6s4mz3S0pHjIZWQMHA5Ya9iqtsrdRDZdK1AQNg1l8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2407
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-22_05:2019-11-21,2019-11-22 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0
 bulkscore=0 phishscore=0
 lowpriorityscore=0 suspectscore=0 clxscore=1015 priorityscore=1501
 mlxlogscore=999 adultscore=0 spamscore=0 mlxscore=0 impostorscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1911220174
X-FB-Internal: deliver
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191122_135850_029934_0CEAB57A 
X-CRM114-Status: GOOD (  21.23  )
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
Cc: Sagi Grimberg <sagi@grimberg.me>, Long Li <longli@microsoft.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, Nadolski
 Edmund <edmund.nadolski@intel.com>, Keith Busch <kbusch@kernel.org>, Thomas
 Gleixner <tglx@linutronix.de>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 11/22/19 2:49 PM, Ming Lei wrote:
> On Fri, Nov 22, 2019 at 02:04:52PM +0000, Jens Axboe wrote:
>> On 11/22/19 3:25 AM, Ming Lei wrote:
>>>> as that will still overload the one cpu that the interrupt handler was
>>>> assigned to.  A dumb fix would be a cpu mask for the threaded interrupt
>>>
>>> Actually one CPU is fast enough to handle several drive's interrupt handling.
>>> Also there is per-queue depth limit, and the interrupt flood issue in network
>>> can't be serious on storage.
>>
>> This is true today, but it won't be true in the future. Lets aim for a
>> solution that's a little more future proof than just "enough today", if
>> we're going to make changes in this area.
> 
> That should be a new feature for future hardware, and we don't know any
> performance details, and it can be hard to prepare for it now. Maybe
> such hardware or case never comes:

Oh it'll surely come, and maybe sooner than you think. My point is that
using "one CPU is fast enough to handle several drive interrupts" is
very shortsighted, and probably not even true today.

> - storage device has queue depth, which limits the max in-flight requests
> to be handled in each queue's interrupt handler.

Only if new requests aren't also coming in and completing while you are
doing that work.
> 
> - Suppose such fast hardware comes, it isn't reasonable for them
> to support N:1 mapping(N is big).

Very true, in fact that's already pretty damn dumb today...

> - Also IRQ matrix has balanced interrupt handling loading already, that
> said most of times, one CPU is just responsible for handing one hw queue's
> interrupt. Even in Azure's case, 8 CPUs are mapped to one hw queue, but
> there is just several CPUs which is for responsible for at most 2 hw queues.
> 
> So could we focus on now and fix the regression first?

As far as I could tell from the other message, sounds like they both
have broken interrupt coalescing? Makes it harder to care, honestly...

But yes, I think we should do something about this. This really isn't a
new issue, if a core gets overloaded just doing completions from
interrupts, we should punt the work. NAPI has been doing that for ages,
and the block layer also used to have support it, but nobody used it.
Would be a great idea to make a blk-mq friendly version of that, with
the kinds of IOPS and latencies in mind that we see today and in the
coming years. I don't think hacking around this in the nvme driver is a
very good way to go about it.

-- 
Jens Axboe

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
