Return-Path: <SRS0=/AMA=FT=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CFF3C4361B
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Dec 2020 01:11:26 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 241CD20857
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Dec 2020 01:11:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 241CD20857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=qeEIcxkArwuDNOT9WHPAli1r4al3b1xuTbcvvzzqXBk=; b=JQoxH+ntt9dpTfRPLOiPiNufJx
	KA7xHxVFNcWt/2ftCxupQwhmgx9EVXTTSyeytEAnPS8dK94VJ0OL2l2gFSCjlpJmiv4Qu52MZmmFs
	uQcROdXUfv0yz0r605CVKovg0i689zRK8Z5MJkHk7PZwQIeLaBak0YU/2aSUlRnEe3hw7Xro6RM8j
	pmnFwFhCbRxrV+1pK/+RbG9VbXWGsbfePUp2MCgTwqGdpQ4Y1h8KL3RGK+vsBDqNqy2tSu+mfUEUb
	3aaobjomV7LCO2YcPeoiXuWUSV5p5NM0rzkDsowUFyhRG/H8wOch+irXKqb1J8i05XBoyht4y4K0F
	J17wCilA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1koys2-0003z8-6e; Tue, 15 Dec 2020 01:11:18 +0000
Received: from mga02.intel.com ([134.134.136.20])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1koyrz-0003yM-8c
 for linux-nvme@lists.infradead.org; Tue, 15 Dec 2020 01:11:17 +0000
IronPort-SDR: s5YYBpwia5vOWW6+D6p5xxfRGdkSkw63SS95OlIAjxLWqwVzsb54EwNADvBc/Uo9C1pyv69eTp
 qbNEhx/2raew==
X-IronPort-AV: E=McAfee;i="6000,8403,9835"; a="161860726"
X-IronPort-AV: E=Sophos;i="5.78,420,1599548400"; d="scan'208";a="161860726"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Dec 2020 17:11:10 -0800
IronPort-SDR: anQV3/j/KS9OHII5Tvk04xqnRDxN0B7WbtcV56AHJrZi4L9Pp7UbPaGLRzwI6uPCTSiixuDz/7
 NuvEvEL/cffQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,420,1599548400"; d="scan'208";a="487422515"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
 by orsmga004.jf.intel.com with ESMTP; 14 Dec 2020 17:11:10 -0800
Received: from fmsmsx604.amr.corp.intel.com (10.18.126.84) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 14 Dec 2020 17:11:09 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Mon, 14 Dec 2020 17:11:09 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Mon, 14 Dec 2020 17:11:09 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kb42yBOW0KAQRYhnLywFa6/+yh1hLRcoQVR8SaJMZiV8udFQ3wcE7PBgZo9gziYDaUVBoS/uxqOPszTmK4JJK/lfgBIx3EjJEgftKAfFAVgVvXZC7J6rO4akfjhvhEXzXLUQYTospFywDjYavTmhUmxoxir7EmhA/QcIsLYcEjXQR2DaKj6bOPNnw5q54+fy7alS6NzGNaH3uuydrEFV2Eg6jQGcRJO2VZo5E9WxYoo7txiVMEG7dpKAAh9X4Y21Wr1FfXYdoo0fsfTr6h6Iw80+EF4yUiRKxpNg8HH79CjlKQHpg/5RUjultikLgGZPNW2nqC2LkZYnG2+T7GWqlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I/a/UcL1n/cmV7Od/QAxhOPJLT49kVr3J6f4guzsZTw=;
 b=k6Qmt84eOjIRy57vv3ePk11FBHjy3p8lOhgY+VqLQVshTabZNd5MYfaobPW1iYJCJTThzS7SFivDKj0UwXno+W3GvBQ+U8O/SfTIF8fbRtWAKlUDidS/q9uI+7TRMHIa41EA/wzVPtStHm2o/fMbS3A6H1LAYzdSBB2skSYGtDrxasJOrw35sdJE+TgVXsdDLKoDNNh63xe/czLFVSx0tR9F2cM90dX3HG4kz24Z4DbVYLFsirmVEQg+6RuTDd8FRJUxy7l34Z0F6ESWMm8Gk2Ujyg1gV+ie+/0f0xpUbMvV6dXnUzQAmNFYd1CmZfLM1Yec95zpD+FFq65LA8SKWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com; 
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I/a/UcL1n/cmV7Od/QAxhOPJLT49kVr3J6f4guzsZTw=;
 b=uqHdQKqG/0z25o9ZeDi1kiXUzYdp7i5XAAU70xNuJ/byx14kTxgrkkAnAFRPW3YwJps7HRt0fW5n+StHdKrixRquWpTRU7FuMKqu3LwArLJe0TGeUoPJiY2RLvj9zYJbAx6Cv7e/ccb5TiJ8vjAt4cBPTgdV8OhvmYtNbIYTI7Q=
Received: from BYAPR11MB2869.namprd11.prod.outlook.com (2603:10b6:a02:c0::15)
 by BYAPR11MB3013.namprd11.prod.outlook.com (2603:10b6:a03:8b::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.13; Tue, 15 Dec
 2020 01:11:08 +0000
Received: from BYAPR11MB2869.namprd11.prod.outlook.com
 ([fe80::b47b:94af:71b8:63c9]) by BYAPR11MB2869.namprd11.prod.outlook.com
 ([fe80::b47b:94af:71b8:63c9%5]) with mapi id 15.20.3654.025; Tue, 15 Dec 2020
 01:11:08 +0000
From: "Wunderlich, Mark" <mark.wunderlich@intel.com>
To: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: [RFC PATCH 0/2] nvmet-tcp: introduce idle poll option
Thread-Topic: [RFC PATCH 0/2] nvmet-tcp: introduce idle poll option
Thread-Index: AdbScj0Vb4b2xt6SSe+/1ioCxjs9IQ==
Date: Tue, 15 Dec 2020 01:11:08 +0000
Message-ID: <BYAPR11MB2869A106FF8E7D7FEAD30EF1E5C60@BYAPR11MB2869.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-reaction: no-action
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
authentication-results: lists.infradead.org; dkim=none (message not signed)
 header.d=none;lists.infradead.org; dmarc=none action=none
 header.from=intel.com;
x-originating-ip: [71.238.29.134]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 58d435fa-ad34-4729-0b0a-08d8a0964e02
x-ms-traffictypediagnostic: BYAPR11MB3013:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR11MB301368EBB3F38E9EFEE37D10E5C60@BYAPR11MB3013.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: A3FFtBh8UWu233AcDD1yUUxjMRbBgN90QJtFqMxTP+FJYY2wuq86dfXJhD5onPt320JBYCHvBiQIlM29q6CR4ED909AFT24o+dj1JApPuZlasJqm3C6UtQatdjf5kDE6sdQ5SNpOO2whXtKPI/IVwtXeDgXOeugxW+nHdC4Ent/vkIlQV+zYmD9gbr/I9DVaqZbVdhEhS9roSt0KtOGdH7Iu3niJatqGPfD1Hp1P9UHQtsozXPAqxGucqTE0x51nipjCJ3hGLjnXXc5gbSSU5teGREbo6/Iebe9Fz0ADhhgN7Euy83LcUUu2WKAC5htOq4U4VZZ2Kbz1ukH8gVglkg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR11MB2869.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(346002)(376002)(136003)(83380400001)(186003)(2906002)(6506007)(76116006)(55016002)(33656002)(107886003)(66946007)(64756008)(66476007)(52536014)(7696005)(54906003)(66446008)(5660300002)(26005)(71200400001)(4326008)(508600001)(66556008)(86362001)(8936002)(8676002)(6916009)(9686003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?OyY/BRHjAA2vKcTZ5YQjNam5tt+Zz7r6EWpgfxZNBESZ+Yv/9xKGu8Y6Lb?=
 =?iso-8859-1?Q?7pyKsl0+FuATL/5uRdzb22eJl3tHKhoJCQFTJrdkGuBYbrfcS6R9S3BILJ?=
 =?iso-8859-1?Q?u/ID7Ps0jWHkdkzuyUkHYIsRNsWJEyllQwD4M2/EIVrX8cgo3ooKFIZW1o?=
 =?iso-8859-1?Q?gqWIDy7sXm4T7wtOm+Qu9SoAU973gSWMgwdmX86WlWVympKJBAXQuXvQk0?=
 =?iso-8859-1?Q?/83speD8N2PUfsa3BEgc4u/Bts0ZKgjpg/AGyU86wnZ404rZ05tQ+jB74S?=
 =?iso-8859-1?Q?kj48kF4p3KjuQnYPjn8z+2aldLUta+BHmdU8282Y/v1CoLrTAXbeVNJDGG?=
 =?iso-8859-1?Q?8v+mrLgS1SZM07PisSHzchREQZQW7rGEhc6lFZwxHkvim0xcQMZiW6HMlM?=
 =?iso-8859-1?Q?tbDHgi3aHt8jlLgKkMftjl3MvUEIltVZbIptdamGDjKkBreHFV7ww+scem?=
 =?iso-8859-1?Q?s6wVjHnf5VWr1qrENZfSS2nGUMXhrw2sJp/Lj3tZHOz/QbXQKQjmOjBVFH?=
 =?iso-8859-1?Q?NRJW7qanbMP5XWmZTB1HSCdhgPaeG9rvZ3kg4QpP4svKvbANf3AkGwsrYx?=
 =?iso-8859-1?Q?L0HyHpB2upBl6qQS4gmpiiDL+kNEMYyXmAzqfweliZGq7KdZZ9sLHoOKbU?=
 =?iso-8859-1?Q?4lMP8cP435naaQKeoCO5bBT2Dgv2mLNwoRpb9P71ia+zFKpHP53IJ2k4Wf?=
 =?iso-8859-1?Q?QjcelmNjSm5rT2gLCMyD6G1gCbzYDv2cfz+mwPiAUVt5ojKY+P9Qym9q5a?=
 =?iso-8859-1?Q?tlQ1fiB4v+CKTI20Cqu5sDAF1YS/GLLQfKmqwK6rGTQLWcH2nmsV0DyeJ+?=
 =?iso-8859-1?Q?FEAabt7JYmWSqgR7ZuWbvf6/gNkqvBILeLPHUS3GM1unczB3lHPFkaXMM1?=
 =?iso-8859-1?Q?D6H9RvPm/Xin+zKdDf49PHL3QYf7U2/+sL6jDrpEr2lngjObGFf1WZuA7j?=
 =?iso-8859-1?Q?2NC5ceQbGYMAG7btNIfV7yfZgUcEQS3/rjWWzQaTPdixlhpCQLvXOV7rGO?=
 =?iso-8859-1?Q?pAaaMsWAwneYYSE0w=3D?=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB2869.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58d435fa-ad34-4729-0b0a-08d8a0964e02
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Dec 2020 01:11:08.5911 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: I6xok8wOK+ZoFwfz4jIFGFjTsfMH2Vk0F018yJYU7DpwjAcIFbHXj2I0fYfvAx8fz4zAGjVc7LVSihldq//uvyKHheI7hx5VNExhxDK/Tz0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3013
X-OriginatorOrg: intel.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201214_201115_592493_144C220C 
X-CRM114-Status: GOOD (  15.07  )
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
Cc: "Vasudevan, Anil" <anil.vasudevan@intel.com>,
 Sagi Grimberg <sagi@grimberg.me>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

This RFC 2 patch series was created as an alternative solution to the previ=
ous series I submitted back on 8/27/2020 [nvmet_tcp: introduce poll groups =
and polling optimizations], where only the first patch in that series was a=
ccepted.  This series is greatly simplified from that previous patch series=
 in that it does not explicitly create managed/tracked poll groups, with th=
e io_work() function processing of a single queue preserved.  This simplifi=
ed patch series relies on the accepted new queue context assignment to so_i=
ncoming_cpu to logically maintain shared processing of a logical group of q=
ueues on the same CPU core.

What this new patch pair provides is twofold. First, it introduces changes =
and a new nvmet-tcp module option 'idle_poll_period' that enables the kwork=
er for a given queue to persistently get re-queued until the queue is sense=
d as being 'idle'.  Idle being determined as being when there is no new req=
uests or pending backend device completions for the specified 'idle_poll_pe=
riod' length of time.  By allowing this type of persistent poll behavior it=
 is then possible to introduce the capability contained in the second patch=
 of the set, this being the ability to have the kworker directly poll a bac=
kend NVMe device for completions instead of waiting for the NVMe device to =
interrupt and push out completions.

The data below shows that this new polling option, and removing of NVMe dev=
ice interrupts, can have a benefit to performance.  But it is understood th=
at this change prototype has some drawbacks, one specifically being how the=
 nvmet-tcp module is being allowed to directly call the newly introduced bl=
ock layer poll once function which can be considered a layering violation. =
 But in it's current state the patch series at least is a means to open dis=
cussion towards the benefits of working towards enabling such a polling mod=
el.  Is it a sound concept, but best implemented in the nvme target core la=
yer instead?  Maybe moving away from using kworkers and having more dedicat=
ed core service tasks for logical queue groups?

The following test data was collected using the following config:
. FIO io_uring, using HIPRI option
. 4 FIO jobs, each directed at 3 NVMe device namespaces, each with 4 thread=
s pinned to isolated NUMA node CPU close to NIC for total of 16 active thre=
ad connections.
. 4K, random read I/O pattern
. Queue Depth 32, Batch size 8
. Initiator NIC HW queues set to 52 (number of local NUMA cores), HW queue =
affinity set to local NUMA cores.
. Target NIC HW queues set to 8 , HW queue affinity set to local NUMA cores.
. Initiator to Target connected using 1 default, 32 poll queues.
. When testing with 'idle_poll_period' enabled, to test polling NVMe device=
s, the target NVMe module loaded with module option to enable 16 poll queue=
s.
. Patches tested and developed on linux-nvme nvme-5.10 branch.
. All measured times in usecs unless otherwise noted.
. Fewer target HW queues vs. number of active connections to measure the im=
pact of virtual grouping of connection processing on shared target cores.

Baseline - patches not applied
IOPS(k)=A0 =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Avg Lat=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 99.99=A0=A0=A0=A0 99.90=A0=A0=A0=A0 99.00=
=A0=A0=A0=A0 Stdev=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
 Context Switch=A0 =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Tgt. CPU Util.
1910=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 252.92=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 685=A0=A0=A0=A0=A0=A0=A0 5=
78=A0=A0=A0=A0=A0=A0=A0 502=A0=A0=A0=A0=A0=A0=A0 98.45=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ~215K=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 801.37

Patches applied on target - module option 'idle_poll_period' not set.
2152=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 223.31=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 685=A0=A0=A0=A0=A0=A0=A0 6=
11=A0=A0=A0=A0=A0=A0=A0 424=A0=A0=A0=A0=A0=A0=A0 92.11=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ~120K=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 882.14

Patches applied on target - module option 'idle_poll_period' set to 750000 =
usecs. (NVMe module not enabling poll queues)
2227=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 216.65=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 627=A0=A0=A0=A0=A0=A0=A0 5=
53=A0=A0=A0=A0=A0=A0=A0 388=A0=A0=A0=A0=A0=A0=A0 69.48=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ~100-400=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 934.35

Patches applied on target - module option 'idle_poll_period' set to 750000 =
usecs. NVMe module loaded enabling 16 poll queues.
2779=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 168.60=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 545=A0=A0=A0=A0=A0=A0=A0 4=
74=A0=A0=A0=A0=A0=A0=A0 375=A0=A0=A0=A0=A0=A0=A0 53.24=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ~100-400=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 802

This data shows that adding the new idle poll option does not impact perfor=
mance when not used.  When used with the addition of direct NVMe device pol=
ling for completions, there is a nice performance benefit.
It was noted during testing that logical grouping of queues to cores on the=
 target can vary as a result of RSS which will or without this patch series=
 which can vary the performance achieved, but when using the patch set with=
 direct NVMe device polling then the logical queue grouping was more consis=
tent and performance varied less.

The patches included in this series:
1/2: nvmet-tcp: enable io_work() idle period tracking
2/2: nvmet_tcp: enable polling nvme for completions

Cheers --- Mark



_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
