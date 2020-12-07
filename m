Return-Path: <SRS0=D68J=FL=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 509A4C4361B
	for <linux-nvme@archiver.kernel.org>; Mon,  7 Dec 2020 09:01:50 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E4A2F2333D
	for <linux-nvme@archiver.kernel.org>; Mon,  7 Dec 2020 09:01:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4A2F2333D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=Hx8Tbgp48DbNz2Cyvg/h5rDlNqhbQcFu9k9Eur6I3iU=; b=TJ7ZdBKjFVej7FvcOGi6LKwKd
	FeCu593CT4hfoXfsukMO7BmgkzKiuOUGEgY9l1lco+FQWdPJXL55I75I4aEqG+HJtMM0OeGIw0K8p
	/TQbjHH9sR9xdcwtRzxOPha8OmoHBn59Oel3j0/cTOAq95GW5jY4wzD1WGm0G+/r1a8W6BxXJqC8b
	SCrxcSrgIFsldQkQyTVXqiP566V+6CuqHiCC61u4VYFJsd/UcqjkwWTYUyHzDbYm8a+GsR8nExc9+
	r2YySAHJIS6zv/bYzpxEF4zci0GAwJ6GrhfS+vZAQqe9Y8fYobBmEEurpo9k0d7CBFPiRkhNIb8st
	pNlmzw2qg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kmCOw-0006zs-2T; Mon, 07 Dec 2020 09:01:46 +0000
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kmCOt-0006zM-8x
 for linux-nvme@lists.infradead.org; Mon, 07 Dec 2020 09:01:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1607331703; x=1638867703;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=DSRspXuh8cb4SOxm29wlE6M5GTqBeNrNUYRWupzUSUs=;
 b=mhdypVvgcz77IaIEhpoQ2RvjV7NplyjKBxQTFUBslJFb4+gRS9wzK3Td
 3zvQQ7+Sp+ozRZWkKaZ5HDqBIh8r1Ml3NXyGCYMDE3k4wRb7MdRMNvKdA
 4pbxEjR4iA+wYKH2e6N/p1LBrEaHFWQ6ijlqIXhx1UNLz2mh4FwA64mgZ
 Cc972o7EdvU6G6E0Zrr921MR1HMOdt6OojIXdK6ARHHhzmQHG12CvPYjQ
 Hjl6w+i+xe65ke6vRawtxWC9th6iyOMqg9l0M8lmLkoqqdxTRD45W3lW4
 conRQx+acY6SXhSpkgs9lQ71TfjMhT6jdpTaJJ2IIpZ/MDSKP5kfH8bgz w==;
IronPort-SDR: u8o1RURKCvnM57JmVg6h6efxc8XJa67P9q4FAKsEEJFg2f/blNF2iFGfhAxE2yCamIf60Up+XL
 9QVpQgQ0XYiPnqYJDuGJ6/yLLWZzGQdBiNLM9/qg18Irng4D25CuTMSh9K3jrFArh8aoelKI4m
 7YsYmZMD6epPtQAaEWZCHErz6cMDinSo5FWMRnvkSI/yDwUf1A6+XQjBWiXIa/vP3ZbpUmGrTl
 YqpDA3ddyW7h5hD6q5fs8LPh+OKXTsYBfkZJFEeOdKLOFBiZ0tVuC1zr2E8lKdANfH+0miXgLK
 w6Y=
X-IronPort-AV: E=Sophos;i="5.78,399,1599494400"; d="scan'208";a="159043316"
Received: from mail-cys01nam02lp2056.outbound.protection.outlook.com (HELO
 NAM02-CY1-obe.outbound.protection.outlook.com) ([104.47.37.56])
 by ob1.hgst.iphmx.com with ESMTP; 07 Dec 2020 17:01:39 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gfgKjNYMhZsI26xg5DXchXjtJZBVu+EjB0Jf1x1XXABfLIIGgGZpNbbcQqOnfJl+78Oaw14ijD+sbTgjnu7plX7DAQrK7KXR97SsSMPzv2noybfF8CxQY0mKBSWEk5hpwuAcSWqInuKsGMCBnqU2SLwi70CaqF7ZnqrmttW43LtXwEFhA6JHTJy50p1tJlzdcSfcC8oYF3EMsxOmBkV8t2Pl36CipeEuI6GWcEC7gRp4qvIr8yWuqS39ZnfUqRptVahDO6Jor+ffOApMtd4YiFfvgfk0p0j5oyqg6C5VhVMh0Qf9SYSr4ZqLB9BXVju2v3iYfK5fk56/TUPLe8W/Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vekY2g2y7NYg5r0B1heVBQEk7jinAwk2kaD0TJS1F94=;
 b=HdTKisWMiPRrCJ9HJiWE2DX+4YoYHsRgVfRt+P8ofvMr4tLp/MYNIunyFxkHF9+7eofxEuoMrYY1o1HBaRg5GNo3qI+Rs9Lbjvy+wGF2QqzV3Udz4r/9M0739PgEu/eoVoNwzBg5QlOs7r/S1EpQEmrmIng7Nc6gu19pvaFmQjywoSCqkuXwfm+yKyZ/nqgUDhFkRG7nwYfndqfTso28SsE3x7OlG0UHEGJQr8LzFN2Bda1CBNkx4Ir44MxqRnuM9PspGDrhpA/qJCYUyOVLlz/bPd/xjSbSiSLxQnYe+cY1kzWZFd5kcqAcP1jf2MHe3wS3LLcF0N9Dt3XuH2f5yA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vekY2g2y7NYg5r0B1heVBQEk7jinAwk2kaD0TJS1F94=;
 b=veXEgamdQlTsjKahKJAraG3AwKhOox6tJ3SibG5US8q1VTHEK6/hRao00fMllbUIFJ+YaYTQun+gupqTu6dfUIqFZuyK9a7B/LuK+gNJNhS54z+LbsuBxLsMaQ1bf/K+0JPFzg1jsxUESqzu/34AZ67ig2InXLwBY9/1COi6UG8=
Received: from CH2PR04MB6522.namprd04.prod.outlook.com (2603:10b6:610:34::19)
 by CH2PR04MB6569.namprd04.prod.outlook.com (2603:10b6:610:6d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.19; Mon, 7 Dec
 2020 09:01:39 +0000
Received: from CH2PR04MB6522.namprd04.prod.outlook.com
 ([fe80::897c:a04b:4eb0:640a]) by CH2PR04MB6522.namprd04.prod.outlook.com
 ([fe80::897c:a04b:4eb0:640a%7]) with mapi id 15.20.3632.023; Mon, 7 Dec 2020
 09:01:39 +0000
From: Damien Le Moal <Damien.LeMoal@wdc.com>
To: "javier.gonz@samsung.com" <javier@javigon.com>
Subject: Re: [RFC PATCH v2 0/2] add simple copy support
Thread-Topic: [RFC PATCH v2 0/2] add simple copy support
Thread-Index: AQHWyiztcinYLb1afkCNvyh+SmI/oQ==
Date: Mon, 7 Dec 2020 09:01:39 +0000
Message-ID: <CH2PR04MB6522EF7D29164CE0150B26DFE7CE0@CH2PR04MB6522.namprd04.prod.outlook.com>
References: <CGME20201204094719epcas5p23b3c41223897de3840f92ae3c229cda5@epcas5p2.samsung.com>
 <20201204094659.12732-1-selvakuma.s1@samsung.com>
 <CH2PR04MB6522F1188557C829285ED5E8E7F10@CH2PR04MB6522.namprd04.prod.outlook.com>
 <20201204144003.GA8868@redsun51.ssa.fujisawa.hgst.com>
 <20201207074616.mocdy6m5qgsn6yqg@mpHalley>
 <CH2PR04MB6522623991D84D67B13DDF66E7CE0@CH2PR04MB6522.namprd04.prod.outlook.com>
 <20201207081631.usapwn5jj35c5633@mpHalley>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: javigon.com; dkim=none (message not signed)
 header.d=none;javigon.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.182.59]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 08c68f0d-74e6-4332-bd72-08d89a8eb55a
x-ms-traffictypediagnostic: CH2PR04MB6569:
x-microsoft-antispam-prvs: <CH2PR04MB65697B02E8B8D4C3B85657F5E7CE0@CH2PR04MB6569.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: peBA6eDIgJlTbRB2tBsNan7xxzana0B9OldQlQF2zEgMpnyhxY4P5Ixas4U4E8jrR4oyd49Sk85eahmXLDNEN58s0EZm0BfEle0PvY0P9Fae034HGvChSm/oSBnqS56rI5xn76SNIzB0gdXpsjdCnZdoWu0vc6j1sC/da/2z2ZUt6cBfmLX8Qqb6/zu5joY4l6xzJQi98vabPhXvP2UX4kz9OkEmLCkJVF8rQYuWEHmTYFU63QK6ORTL2T6db0CnOrsqZiUdH2eLlohvXywB0ZEFRksbUlDecSkR1d0GCDwkJPAkZvMlcH4eCH9eGaWwVhLl8U3kHp6/ExiUgqRZU0R331kmQpmb1FFh0vdLyPiUbNlat94+MVYOMqhF7iNRYhM0v0eV7roPGFHYYBa58VOTje2Kp5LegQ/Q+xsI/F1s1ogdPVYxBm4wOq7oB27+Iq5MS40AejrnlzQ+5EvV56ka9vPltmPNSIBOHb5Zq2CliM446tSk9dXdX+NLdUJz
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR04MB6522.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(136003)(346002)(366004)(376002)(39860400002)(8676002)(91956017)(2906002)(5660300002)(76116006)(66556008)(66946007)(6916009)(66476007)(478600001)(64756008)(66446008)(966005)(52536014)(4326008)(86362001)(7416002)(316002)(186003)(26005)(54906003)(8936002)(53546011)(55016002)(6506007)(33656002)(7696005)(83380400001)(9686003)(71200400001)(491001)(15398625002)(43620500001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?dOeY0KKxM8V+PasC0sz8heGMBEpZGrfAvuPJvLzqeoASR5HeJTbjnkZh1+wR?=
 =?us-ascii?Q?Ceel1Ihwck2G2VvFyekOLjKkxfc6+8Rog3oG3KrcrcJbXre+oyeh861hYQM/?=
 =?us-ascii?Q?EYdxYt5b0q0Vtx+vzHzysjf+jiu52xa5ecvamhVRKkp+MNfLcNQpeqUhxliP?=
 =?us-ascii?Q?IJLwdFCvTCKn19GKdIe+szoUrBBRgo42jLIdqGQBm5Dh1NXIqL6oidCWJ+/1?=
 =?us-ascii?Q?wxaq4py8IQDEBNehAxA6n4uzXaf941dteDRDNj/1QO+cjotM9I6TgqihIymG?=
 =?us-ascii?Q?yu1uYG839u1BMXnsLVkcB0bF6D5JtbiEP5f7gzCakuxadgZsu6Do5mukMIFM?=
 =?us-ascii?Q?l9YmjflRGMh2OkG5zueak/mFbMItbbEnJo/JFjc8kwSmbH0rNmkiPpYhRHj7?=
 =?us-ascii?Q?5p4uZaq8Jy2lU02EXWaQNqf03wqKM46k4qWbyQ0dEya79JIsREB5GvuAthNQ?=
 =?us-ascii?Q?+xl1vRCf7TkL+jFrzbK5eNyg4XPpJetu7mgbfvGiacXYpQrgLAf4BM9XowqR?=
 =?us-ascii?Q?oUOrZe5ktjG3L7qgX7O7dTUN7tCrm4qN4BZZDM/q/UDMJxYFZ9wAo/CbkZ/h?=
 =?us-ascii?Q?FnySOw90HLK1t9k8Fk6UCmhinlPklY6jVdgAKnyQYS9VEw36zXwRnMGbmtQv?=
 =?us-ascii?Q?srmxLYN9upYJbCsE7smBZL843fSGTms1D2E+ve80/XwsoGNPbchRZbkb4pcH?=
 =?us-ascii?Q?rcUpdw859iAF7Ja1m0IEjUcWAdlLgGZHzcHwjqSJMmQ70Wz2KbQI0QEuvVt2?=
 =?us-ascii?Q?X2TLdPmt2bs3PE30Eq9qpBhEJd2/9m0VOzi/8JPucAVh2PSjdTacxc2ktDSk?=
 =?us-ascii?Q?u6bKqU6d8g6c39Ggg9q2RCPhN0dfgTBXtwxAmsgqL4EGhLnyc181fe2ox6D0?=
 =?us-ascii?Q?TUis4/B0ae5rRl/fNz4Q4tCD0QqVy91S7a9B6EvEzOkATT155vBpjZ6/T/C/?=
 =?us-ascii?Q?VjZQV3s7nIvssMsOoVHbz4mIQGLYX8hgbrYRCcgzrWV6DyYXlh8frcP8xVuq?=
 =?us-ascii?Q?30IY?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR04MB6522.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08c68f0d-74e6-4332-bd72-08d89a8eb55a
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Dec 2020 09:01:39.0605 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vMuLSxANjL2M2HwoEZfSEX2cCCetKSkmvxl7JlvhRK/IpVdIy6ofQgrxUdhUJIwhTE4N/n2Fa6lVhl5GQezeYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR04MB6569
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201207_040143_587020_D12402BF 
X-CRM114-Status: GOOD (  25.27  )
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
 "joshi.k@samsung.com" <joshi.k@samsung.com>,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 Keith Busch <kbusch@kernel.org>, "hch@lst.de" <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 2020/12/07 17:16, javier.gonz@samsung.com wrote:
> On 07.12.2020 08:06, Damien Le Moal wrote:
>> On 2020/12/07 16:46, javier.gonz@samsung.com wrote:
>>> On 04.12.2020 23:40, Keith Busch wrote:
>>>> On Fri, Dec 04, 2020 at 11:25:12AM +0000, Damien Le Moal wrote:
>>>>> On 2020/12/04 20:02, SelvaKumar S wrote:
>>>>>> This patchset tries to add support for TP4065a ("Simple Copy Command"),
>>>>>> v2020.05.04 ("Ratified")
>>>>>>
>>>>>> The Specification can be found in following link.
>>>>>> https://nvmexpress.org/wp-content/uploads/NVM-Express-1.4-Ratified-TPs-1.zip
>>>>>>
>>>>>> This is an RFC. Looking forward for any feedbacks or other alternate
>>>>>> designs for plumbing simple copy to IO stack.
>>>>>>
>>>>>> Simple copy command is a copy offloading operation and is  used to copy
>>>>>> multiple contiguous ranges (source_ranges) of LBA's to a single destination
>>>>>> LBA within the device reducing traffic between host and device.
>>>>>>
>>>>>> This implementation accepts destination, no of sources and arrays of
>>>>>> source ranges from application and attach it as payload to the bio and
>>>>>> submits to the device.
>>>>>>
>>>>>> Following limits are added to queue limits and are exposed in sysfs
>>>>>> to userspace
>>>>>> 	- *max_copy_sectors* limits the sum of all source_range length
>>>>>> 	- *max_copy_nr_ranges* limits the number of source ranges
>>>>>> 	- *max_copy_range_sectors* limit the maximum number of sectors
>>>>>> 		that can constitute a single source range.
>>>>>
>>>>> Same comment as before. I think this is a good start, but for this to be really
>>>>> useful to users and kernel components alike, this really needs copy emulation
>>>>> for drives that do not have a native copy feature, similarly to what write zeros
>>>>> handling for instance: if the drive does not have a copy command (simple copy
>>>>> for NVMe or XCOPY for scsi), then the block layer should issue read/write
>>>>> commands to seamlessly execute the copy. Otherwise, this will only serve a small
>>>>> niche for users and will not be optimal for FS and DM drivers that could be
>>>>> simplified with a generic block layer copy functionality.
>>>>>
>>>>> This is my 10 cents though, others may differ about this.
>>>>
>>>> Yes, I agree that copy emulation support should be included with the
>>>> hardware enabled solution.
>>>
>>> Keith, Damien,
>>>
>>> Can we do the block layer emulation with this patchset and then work in
>>> follow-up patchses on (i) the FS interface with F2FS as a first user and
>>> (ii) other HW accelerations such as XCOPY?
>>
>> The initial patchset supporting NVMe simple copy and emulation copy, all under
>> an API that probably will be similar that of dm-kcopyd will cover all block
>> devices. Other hardware native support for copy functions such as scsi extended
>> copy can be added later under the hood without any API changes (or minimal changes).
> 
> Sounds good. That we can do. We will add a new patch for this.
> 
>>
>> I am not sure what you mean by "FS interface for F2FS": the block layer API for
>> this copy functionality will be what F2FS (and other FSes) will call. That is
>> the interface, no ?
> 
> Essentially yes.. I mean adding the F2FS logic and potentially some
> helpers to the block layer to aid GC.

GC is very much special to each FS. SO I do not think adding helpers to the
block layer will have value. We should stick to a pure block copy API for that
layer.

> 
>>
>>> For XCOPY, I believe we need to have a separate discussion as much works
>>> is already done that we should align to.
>>
>> I think Martin (added to this thread) and others have looked into it but I do
>> not think that anything made it into the kernel yet.
> 
> Exactly. Looking at some of the code posted through time and recalling
> the discussions at LSF/MM, seems like there are a number of things we
> are not addressing here that could be incorporated down the road, such
> as dedicated syscalls / extensions, multi namespace / device support,
> etc.

dm-kcopyd interface supports copy between multiple devices. That of course would
not enable NVMe simple copy use, but that makes the interface generic enough so
that we should not have any problem with other hardware copy functions.

>>
> 


-- 
Damien Le Moal
Western Digital Research

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
