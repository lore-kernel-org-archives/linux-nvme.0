Return-Path: <SRS0=D68J=FL=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF208C433FE
	for <linux-nvme@archiver.kernel.org>; Mon,  7 Dec 2020 08:06:25 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0EB1522582
	for <linux-nvme@archiver.kernel.org>; Mon,  7 Dec 2020 08:06:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0EB1522582
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=kuwwXpjGGO/lcpTp4F9wRg7ZHQQvLsXt0ECYnaZyWKc=; b=bdsE7pIl+cfs9vIaDdSTqMlAX
	0WkBGOrT5/3ywK4yv8iz8y1Ol+2jG52eRzREwZhcu8FpfBXOmVgLg4jjsrqpKfsQ51dYlcVoOHnPp
	vvB5vtmC9rQGDF8rT8dMtgRY8WGlGUz9jTSFl6Y60Gp/Xzu/HKXUOVnG5z8ec6U3QaF3x6NMuTtBg
	2DL/VBXMYlJPXFnn6gecfx0X0OUSVXQNi5W2pLC3Oxw5ZVnEQdsTzNE+JiWAcJiZY93/Xee0olHBB
	MNzGUBcTWDp5Z+SoOos0GhC5yi3XgGFX8X13NIvS6vkZ2VHT4D+t9lFcsY+kfUx4kVbSGoBbjetIy
	8xrx+xmRA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kmBXG-0008Ja-BH; Mon, 07 Dec 2020 08:06:18 +0000
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kmBXA-0008Is-Dz
 for linux-nvme@lists.infradead.org; Mon, 07 Dec 2020 08:06:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1607328372; x=1638864372;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=XfunKQuEfnbz1M9htA1SVM60iu3VW5sLEclvPeaDMnA=;
 b=MoLRVyZki7VCziW5LI4nvboBpL9z6HmQxmfrEOdOog4iCGmB7oqnpdqg
 uk9JnI/+KJN0D4l8KB9oXZ1SeDob2jXMVp+pawvAyhRq1jnCksdYX8TzX
 lXjVqkP6x6vAK2MeKLwU4IW9bMfgY7LR3p1qEtLWcIgjZ3T5MeBzGvvKX
 8qViIj9RFcPWU1iF9ZktTsCiUE8w2qWGIK6jHUir7Gjqmjq5BfMLA61Qq
 MFprellHQagaNawnLXslenvQGCYOKUHhMIto7jD8Nn5hcM2kEM0w/Rj+4
 zBfEax3ePthLUF60PjFUdfdkQ99AjI/pDbzvoRufr+0loOwDO7owa1j9n A==;
IronPort-SDR: mvK4jsInf/pxGZS7mvvzJUO9Yxau29DVPTLXyZdch+Y95rXSym365DDAMeaqMY+UeH2uvUDg/b
 FswfAqAgXN0PhGke/jLmuA47uM3QmRv6KvpgV8NZYcvN85BCKlCDMVHnPwgsAQiaTFe2iKGMek
 fPEj4Pq1hd0VuNPiD3XeKmPMetG1k7YPOKq2fNQiOgROzUDE0dX+A3Rkn3MoESgg7w7ZvEDLXp
 LhYJimEJ7r3sloju8RBM8BG0sPTpEsx/DDcHoUK26bgnMOCSdd6VqGz0Yd3Hqm5RpVbQ9pGbD0
 pIA=
X-IronPort-AV: E=Sophos;i="5.78,399,1599494400"; d="scan'208";a="155788668"
Received: from mail-bn8nam12lp2171.outbound.protection.outlook.com (HELO
 NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.171])
 by ob1.hgst.iphmx.com with ESMTP; 07 Dec 2020 16:06:08 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UVfy80NNW2LAVdulklRc08HicBo2cy1PUHbOE1+LDyA21Ii+kpQbcOzZgGkl4J4lQrmpgLM0bi9E1d6K0I7JUeVGl9nPyWudm+hjv6Hc8hDkQp4czPqSG43ZHOasiHc9xMhVIifZUdDyqkBplwoOzW1nistbe4JJlJOzHAs+eOho+B8W/sfKUzD8u/OzR7ojSxobwIRClathlEBCRYvh6qpUxMbDvgEnM63dIko6oD4IilhPHZsslAEcVDLDkcUVQbV47SuOWnaQYlxGrecCu+UCyMIon/9RUHz3ScfT1s3fNVlQEV0lDFee1jseFSgzxJKKbFY3uDZskwp1sfZxiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LtfVnTYLIwq5agTdYH/VBpHuV57MwlB6uNz511Y3IhE=;
 b=J8ew1T3UmL8qvvUZnwpZE2Ki9Yw4agGSFc2czvIqR8E5inxMSgyXnuqQe5UFGeyzfBq1kSPvQr8HfjbJcwTHP0yw5SEffu9BTisdYcsW1JlMYe82MJZMdSnl0I4YueJMUkmXMaEejmph89KlHMw4JopTdjKFXfEMcxBa5r0e7Op48cGW3EtGkuiBk8gsMyhKFIQibrp6y8Mq1IwXYlcCAEAPcec5lKFQPqYlesQ/ilyXsRhemOC2GQoaPTd/h0qPNXRzjGrZjeQA6w7GfYbwSdh/fEoWm4xJ8w4qQI2Yat4ddiYoSy8Ux6Cp7jvdWmANplfmVTugs4sc6ZwHuN3oxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LtfVnTYLIwq5agTdYH/VBpHuV57MwlB6uNz511Y3IhE=;
 b=NofsBBS4V3ILR5j47LqQ2ynuceJCPj2HX3xgpKDTmPi8JIlVCAA5t/Q45lITycqXtr2bFrAezSeSTOtfVXqFp+LtZmGLhKXy8A5hewiYcREDToD9xAUTCOJv6HpTnLL9BnPMLIpBcXk4+JSuTSqHhhBVY7IBM6nscsOPQiRng5k=
Received: from CH2PR04MB6522.namprd04.prod.outlook.com (2603:10b6:610:34::19)
 by CH2PR04MB6694.namprd04.prod.outlook.com (2603:10b6:610:94::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.21; Mon, 7 Dec
 2020 08:06:06 +0000
Received: from CH2PR04MB6522.namprd04.prod.outlook.com
 ([fe80::897c:a04b:4eb0:640a]) by CH2PR04MB6522.namprd04.prod.outlook.com
 ([fe80::897c:a04b:4eb0:640a%7]) with mapi id 15.20.3632.023; Mon, 7 Dec 2020
 08:06:05 +0000
From: Damien Le Moal <Damien.LeMoal@wdc.com>
To: "javier.gonz@samsung.com" <javier@javigon.com>, Keith Busch
 <kbusch@kernel.org>
Subject: Re: [RFC PATCH v2 0/2] add simple copy support
Thread-Topic: [RFC PATCH v2 0/2] add simple copy support
Thread-Index: AQHWyiztcinYLb1afkCNvyh+SmI/oQ==
Date: Mon, 7 Dec 2020 08:06:05 +0000
Message-ID: <CH2PR04MB6522623991D84D67B13DDF66E7CE0@CH2PR04MB6522.namprd04.prod.outlook.com>
References: <CGME20201204094719epcas5p23b3c41223897de3840f92ae3c229cda5@epcas5p2.samsung.com>
 <20201204094659.12732-1-selvakuma.s1@samsung.com>
 <CH2PR04MB6522F1188557C829285ED5E8E7F10@CH2PR04MB6522.namprd04.prod.outlook.com>
 <20201204144003.GA8868@redsun51.ssa.fujisawa.hgst.com>
 <20201207074616.mocdy6m5qgsn6yqg@mpHalley>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: javigon.com; dkim=none (message not signed)
 header.d=none;javigon.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.182.59]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 76bd347e-3298-4905-cb6d-08d89a86f2a1
x-ms-traffictypediagnostic: CH2PR04MB6694:
x-microsoft-antispam-prvs: <CH2PR04MB669495C2C3D577D631673DF3E7CE0@CH2PR04MB6694.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5zH3Ynjr+czMhRBdBchz6p4Qs9Qs+N30HrxzegnTPpiZ42UpeX471eh7pSUQCuKR2lSQX4h8LfdapunJep89aLSfea88dAVwGoG4BPBVfHs/GPU/etflJLWAPpcROvxQSWv/E5xYGgkURuIQomtRH0mQKxhk+IL8CchlncolIZW5Lc6b1pfWh71TAUcHe5nXIER1wL4AbrH80GU4WrUjXtRalIsNWW4BQsHWOKSstDreRx06yJfKVgqdjmh0a2hIPaiW/hivYq5COmHQBNtl1hytgDG1dX/y/TLhk/rr4Ee8h1PXI55nZihElMeuqFgccDSAJrI7xhShXMUk/695bvFkOtwNe5JXGQj0+BQKfHhlMdVwA9j4nC2hgPOSmn8evx6+g5G1Rk+d2voM+9vXefCW0RDM6ZC+tsakhnB4eIGMYsaK0bZNyUSOp3BU2D0eFf4IXaxG7ps2Slb2CM8WT6fr7bsl6XTy5LQM+vU51zItIDtmz9b7LmTkS6Iyor9t
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR04MB6522.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(136003)(346002)(396003)(39860400002)(376002)(66946007)(110136005)(83380400001)(54906003)(9686003)(186003)(478600001)(5660300002)(8676002)(91956017)(86362001)(76116006)(64756008)(66556008)(4326008)(966005)(66446008)(66476007)(26005)(316002)(53546011)(55016002)(71200400001)(7696005)(7416002)(6506007)(33656002)(52536014)(2906002)(8936002)(491001)(15398625002)(43620500001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?BCn/18Zbt6rBEGJcc/9l/w4rFQspPUVDs70ejB2GsEHAGGCsJsVOPlvEWGsf?=
 =?us-ascii?Q?5kyuxqH2yIAFj3qOPptgvMxySWM4fGJDgUWMCKYBY604MNkn7ta3Gi9MrWVQ?=
 =?us-ascii?Q?eNJIEohcbo6ATi3JAwbqj5Q9rRxP7ruYNi1+2i9EQPGfprz+uotO3OmCjNQB?=
 =?us-ascii?Q?Oxgnx8YPvoMJ7dZK1yiP7/8ztCsBAEL/E6go1/dhfEM6STFwaZG7uUPhzv6y?=
 =?us-ascii?Q?/XQuUHI+Nc7Xnveb3jdahJrJkYVMMimVlz4YzDbnLJsackIgAFVzHNg2zoCL?=
 =?us-ascii?Q?5gF3NPaEMJWbCtGLHv04BnCzk0QsVVJqYgkkDzX/HBorQQFlJG4nMcEPZnB8?=
 =?us-ascii?Q?4Rxz6OAJHtj3ArmHGFITtpygOKKuUpxxVjUWoP8/nUkt539h5NToviXbqXxI?=
 =?us-ascii?Q?9NMgM+68qWiyx2yKZjnczX3diGhcIG24+kBXME19odCdMBxD96zJfu9Z6lCG?=
 =?us-ascii?Q?xiiLTYnNMEp2UDJa/fJE31k6f/isxcvvUpdHnHs8ezbYTkUXxPUF+WQF8vFi?=
 =?us-ascii?Q?cfKwFq8ZVuZ2fwFJxd23ffxEehywo8ddMQjLc4W9ooJYhL7dpI4t9CN0qhfn?=
 =?us-ascii?Q?qfNFvyk/Nmtxi1sh53QdbJr6D8961tqkwjOLx4NSHj2HPGgBSTUwK4UkC5bJ?=
 =?us-ascii?Q?LM6ACIEgdinyoocUmwiRGK9/tqmNx1/rGM4amEuLkDfF+qFNphlArfpKrm6V?=
 =?us-ascii?Q?PLTozWLCMkDe3XkMVV5IMgeUmRUBBi5OBplyaGr2EcPlFLphe/LYj/R2ckeZ?=
 =?us-ascii?Q?ElyXFFZWjp9VxPBF/KEq41PJrTWDrlyLxL70YLrepn7rMJrAnHNrfJdwHNK7?=
 =?us-ascii?Q?9iFIwunYdJ+habBtQDUGco8rznVRzkhdAWXZT07Pd/7F53AzyaLofnt6sStJ?=
 =?us-ascii?Q?E+AyQyczKVUtd+ZvCrMOWfJIA4sbFJnRFvg/RiaihruiXBjr8XSO36lsKptJ?=
 =?us-ascii?Q?cKeozNhfOM4Tw4IjKI+SES7sDLCyVBEXUiOP/xnquMc8kIZGmvjvSee9N3Jf?=
 =?us-ascii?Q?MGfF?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR04MB6522.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76bd347e-3298-4905-cb6d-08d89a86f2a1
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Dec 2020 08:06:05.9043 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: A5IUVNQ/HnqbjP4MDXB1YLIn4EUiOSKBOdhFv92OgNdaybcB5yo/UQ8cdxSyt/HBl7gMW52ezKWqcRqhrP28QQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR04MB6694
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201207_030612_596796_5C37C0D7 
X-CRM114-Status: GOOD (  21.01  )
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
 SelvaKumar S <selvakuma.s1@samsung.com>, "sagi@grimberg.me" <sagi@grimberg.me>,
 "snitzer@redhat.com" <snitzer@redhat.com>,
 "selvajove@gmail.com" <selvajove@gmail.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "nj.shetty@samsung.com" <nj.shetty@samsung.com>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "dm-devel@redhat.com" <dm-devel@redhat.com>,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 "joshi.k@samsung.com" <joshi.k@samsung.com>, "hch@lst.de" <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 2020/12/07 16:46, javier.gonz@samsung.com wrote:
> On 04.12.2020 23:40, Keith Busch wrote:
>> On Fri, Dec 04, 2020 at 11:25:12AM +0000, Damien Le Moal wrote:
>>> On 2020/12/04 20:02, SelvaKumar S wrote:
>>>> This patchset tries to add support for TP4065a ("Simple Copy Command"),
>>>> v2020.05.04 ("Ratified")
>>>>
>>>> The Specification can be found in following link.
>>>> https://nvmexpress.org/wp-content/uploads/NVM-Express-1.4-Ratified-TPs-1.zip
>>>>
>>>> This is an RFC. Looking forward for any feedbacks or other alternate
>>>> designs for plumbing simple copy to IO stack.
>>>>
>>>> Simple copy command is a copy offloading operation and is  used to copy
>>>> multiple contiguous ranges (source_ranges) of LBA's to a single destination
>>>> LBA within the device reducing traffic between host and device.
>>>>
>>>> This implementation accepts destination, no of sources and arrays of
>>>> source ranges from application and attach it as payload to the bio and
>>>> submits to the device.
>>>>
>>>> Following limits are added to queue limits and are exposed in sysfs
>>>> to userspace
>>>> 	- *max_copy_sectors* limits the sum of all source_range length
>>>> 	- *max_copy_nr_ranges* limits the number of source ranges
>>>> 	- *max_copy_range_sectors* limit the maximum number of sectors
>>>> 		that can constitute a single source range.
>>>
>>> Same comment as before. I think this is a good start, but for this to be really
>>> useful to users and kernel components alike, this really needs copy emulation
>>> for drives that do not have a native copy feature, similarly to what write zeros
>>> handling for instance: if the drive does not have a copy command (simple copy
>>> for NVMe or XCOPY for scsi), then the block layer should issue read/write
>>> commands to seamlessly execute the copy. Otherwise, this will only serve a small
>>> niche for users and will not be optimal for FS and DM drivers that could be
>>> simplified with a generic block layer copy functionality.
>>>
>>> This is my 10 cents though, others may differ about this.
>>
>> Yes, I agree that copy emulation support should be included with the
>> hardware enabled solution.
> 
> Keith, Damien,
> 
> Can we do the block layer emulation with this patchset and then work in
> follow-up patchses on (i) the FS interface with F2FS as a first user and
> (ii) other HW accelerations such as XCOPY?

The initial patchset supporting NVMe simple copy and emulation copy, all under
an API that probably will be similar that of dm-kcopyd will cover all block
devices. Other hardware native support for copy functions such as scsi extended
copy can be added later under the hood without any API changes (or minimal changes).

I am not sure what you mean by "FS interface for F2FS": the block layer API for
this copy functionality will be what F2FS (and other FSes) will call. That is
the interface, no ?

> For XCOPY, I believe we need to have a separate discussion as much works
> is already done that we should align to.

I think Martin (added to this thread) and others have looked into it but I do
not think that anything made it into the kernel yet.


-- 
Damien Le Moal
Western Digital Research

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
