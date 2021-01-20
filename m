Return-Path: <SRS0=qJQi=GX=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2968C433DB
	for <linux-nvme@archiver.kernel.org>; Wed, 20 Jan 2021 10:42:40 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6315B23332
	for <linux-nvme@archiver.kernel.org>; Wed, 20 Jan 2021 10:42:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6315B23332
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=tAbbp9aaivvJpL236lpsBKDt7/zTfk/rGCrKJyqgDf4=; b=gFhTCGU8DQdE1bhnfysHwiHGW
	jluRrIrSE/Lw1X8o8KAfrZVIAGIRpARPuj1BDWwQLZkAGKVPiw5Vn+MjHmt+usqzKESK2dcpol+iW
	0tXQLf2Td1n5BKW93T0Hhu3myDPUuzI0nAAqn8gPSztC7bjCNWMNKkEiDzfHTK6cNJNtgT0ZSc/R+
	++RNwZJtRgQY9XsoyKS2jcQHwXlXgEJM6/I9LsLYzPJxKuznyWV9ufB/KR7KgFzvxkJs93KeRw/sS
	MgyY7pcDfjfQgN8hb5FlIL8braUxRjc6Cp2JOH2IBaTM8yC2/RrBll34qtkUAOp6dKID1rA6lZotm
	Sfo669mbw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l2AwJ-0002F4-VR; Wed, 20 Jan 2021 10:42:16 +0000
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l2AwG-0002EN-Is
 for linux-nvme@lists.infradead.org; Wed, 20 Jan 2021 10:42:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1611139332; x=1642675332;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=0tX30MGzXGa9PvgnYyrr5/VKb0HDFxHdLg3YgQUPEYA=;
 b=YdHhZKAwg5rye3SfGgH9mEIo7Ztg0U/rfLiEN/QJ5pmjpCUxbUbHjELR
 G398galFqNbtn4pPB9rgWXAtqngMxGsgaKTu1HyG8tPxGOXdeyGDbTvC1
 drcCAYvizLZcC6k2RopZdXAEQ1J6NSTHukr3Y6oEU5VHDQKpDLCinnb4t
 UAAhIk/uPbnH5fsI2UZmIEm6w+udeD8/+J3KKUxEhAzndrn974V/umdc+
 b4ESjE8RFT8VWPwt4/lXqH+MXbYglMoRhq2LK3JP7F6X8F9o3lOct6RVJ
 m0Ht9IVD2S7C9cjHnrwCkTdrm3giYfZQQURfptG7znWN6GzP/oVXc74yX w==;
IronPort-SDR: 7KJGSTiAK3zaYXm0bXpw3RveEyaq3+hzE0BTMip7PmHHHQPXObkWgghb2xhXWaYOjFfFSV35eX
 gxbM9LuYyMbdZfiv8a1u0Hoonc44Rxx4Y3VBkvrs2mpYfclvp1bhlsswOjMS9d9wyyS62PNeVs
 Jfph+J/C9S5EaRvLyFAWBj67rAJ5XpglWUJKZpM1g1fKOSAOSd+TPJe8dQP8WnWP9X5avkMkOL
 V7WSsht7l8AR/dWO8b4bIeJUx7V/XH8sb079HU2QB517D2626EE58l6dLTTjAgSKh1m5jIhgCJ
 Z8M=
X-IronPort-AV: E=Sophos;i="5.79,360,1602518400"; d="scan'208";a="162326855"
Received: from mail-bn8nam11lp2170.outbound.protection.outlook.com (HELO
 NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.170])
 by ob1.hgst.iphmx.com with ESMTP; 20 Jan 2021 18:42:08 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aMqBlmxWh6DvHXhVY/6TJ0d1a6ctsPObgLSwLAAEYdQTac3E/t08oS2UQsKT9YLTSdmyRzlSnYoqn9G/QJ3JeYpCCr5QEgzsoVQ5HkCYQZXnCjyzvxvrZS3poRNxhd6NAsPh4vKNIwn+JZpbJ3ZRrU3xr5g6ziTdRdu4jcEiAMJswmySjoCPH4KO9B3fGnbz9c8mQOThBwkET9yRnF8lsikJT1QIPtohL1AJbVDrYaa5k0bhi7y67SJ2JZMq5ecZACbwmNrwf1wSaBTQWUURZ1ngayhlSZM3l2wlVPUWkgxI+nPnmpiP8T6rYCHk/akTZhbtQ+RYMIf/SUyn0uEdhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0tX30MGzXGa9PvgnYyrr5/VKb0HDFxHdLg3YgQUPEYA=;
 b=SFoiD594h4DEkaSOjv183zRHaNHFpRf8roFg3S8+JUU21L9i0pAMbQubu7tKwi+yBvMsVYg6IAA5dzbvYD24EVrf1uVP4+j25wSHcthHFzqoEgURKAh3dlUXmKIgZr1nXYRZQy9gn1So6UkBPHIiFodmb3Vmdi3+S30lvjgrhYX1W7y/41K3Ac0+Huqb18Gu3pycVUxAcHBaQ9DWlJXvdvELyhk/3mz29Iih7So2OH545vpwZP/jdWRobPDrP/3/jEE4OXfaOAmidP1Tl3HKdc5ySO2LMb9VvH96C0wNohcrwo4CQkMzSJhpYNund2+DWETNVAkGlL25tqlONg8I+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0tX30MGzXGa9PvgnYyrr5/VKb0HDFxHdLg3YgQUPEYA=;
 b=mjd+djC9sEuGn1a3TIbg49CsSaMIs+y77IGk2Wje39qwCC3B+LFtHKN1/pvWHIzOHSI3LPjGR/sqb9hevfmkmUzQnS6YroS+2+5fPykSp3KWzMltzOQ4eqCxYYSIRky0Xpzj+3U8ZEaWoH75M1QkIK/QDw7dK2QqRPzgCWG9kxM=
Received: from BL0PR04MB6514.namprd04.prod.outlook.com (2603:10b6:208:1ca::23)
 by BL0PR04MB4979.namprd04.prod.outlook.com (2603:10b6:208:5e::28)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.13; Wed, 20 Jan
 2021 10:42:05 +0000
Received: from BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::b880:19d5:c7fe:329d]) by BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::b880:19d5:c7fe:329d%8]) with mapi id 15.20.3763.014; Wed, 20 Jan 2021
 10:42:05 +0000
From: Damien Le Moal <Damien.LeMoal@wdc.com>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v2 0/2] block: add zone write granularity limit
Thread-Topic: [PATCH v2 0/2] block: add zone write granularity limit
Thread-Index: AQHW7nICpvFo3Xy5NEe3/fjBT56Dcg==
Date: Wed, 20 Jan 2021 10:42:05 +0000
Message-ID: <BL0PR04MB6514A8D408A7491BE9F1249DE7A20@BL0PR04MB6514.namprd04.prod.outlook.com>
References: <20210119131723.1637853-1-damien.lemoal@wdc.com>
 <20210120100738.GA25746@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:b0d5:1d20:2559:58ed]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 3ca32ae1-e735-4ceb-fb87-08d8bd30076a
x-ms-traffictypediagnostic: BL0PR04MB4979:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL0PR04MB4979CD05F2035A02B31C6374E7A20@BL0PR04MB4979.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Pv0EWX2SQA4b4nr34ZL9H3jwS0JK3OGK2SXN6DqRVXq87FNxW2oZlKHsGwAZ9ca6pWRE2alzy7RIGsQFgtIKpdCqktqGX/WQI2Dd7zQJhd5FTBs4IC+ni9YZ6F/oJdc5CAOjj9JgnXVRrTD/c0SGmFm/UBkS4wlbakjv2E+YGL4zK1M9TBA2/WQNK2oYoVn8fjsmpzGu4cfHPSPzLeP0Z24lrQbO2tYEC2LaW7hXIMtTn93jZObexgPztXW3AwYe9gNQL2/c4IYvltB6GyR1I2wSBKJ3/7M7euoJBSa/giLELMlsnRMIAZfbqMRZXPL9FahdeXSTbCSX8m6TkpT0ONdMQ8gAQKzss8LvcCtxorv2gBDE9liyFBZAygE2/V/1
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR04MB6514.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(346002)(396003)(39860400002)(136003)(366004)(6916009)(33656002)(53546011)(52536014)(2906002)(6506007)(71200400001)(64756008)(4326008)(86362001)(66446008)(9686003)(8676002)(8936002)(76116006)(66476007)(7696005)(91956017)(66556008)(54906003)(186003)(66946007)(478600001)(4744005)(316002)(5660300002)(83380400001)(55016002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?fu9ynlGgStLoorPw78v9sGQ5MdScH/dh/MFscCQ0IpAHlLr567Xyw0h5j1YP?=
 =?us-ascii?Q?m4O54oxHaCi2jJVlq93fstHNhCJkfOLqHwLFEiiIUEro1Cu+GUJnV4Vok8cA?=
 =?us-ascii?Q?DHtLoWWr7WkCUEeTptLmorWaov5EbYr3liCaMjSTK5spN5ISK0PiZkA5ZV/H?=
 =?us-ascii?Q?P/ZQgn+9JWOvGBhGmwgJ/7DbF+udR49AH5NzAsgQRj5xYORscns1Xkys4Umg?=
 =?us-ascii?Q?WPVTcy6x+TKFgbnsiewWkwOx2e3UAnPGpzOYVBttOC7csUeqSg57jGEqpsYu?=
 =?us-ascii?Q?5z0BujWYZP/ZFCEFdetuhwl7tXCt3g+pYxWVk0yaCO1+ckj0frcATJXVNM9C?=
 =?us-ascii?Q?wAnaWsU4gXSEXdwuP6lBkYq4nqH68r6MeayFsDq+chgQdJMzK9HsJNaJL3pW?=
 =?us-ascii?Q?A0xfzhpEHr4/JjeYKCQsBhyERYT+i8ahMa5EjNWyIRWr8myEvDwryw0yaHpy?=
 =?us-ascii?Q?oSEdSLppJHGY0JDAQB3tZg0STh+pkZqxFaVAujvaubgP0iYrT9FR2Euu5QjY?=
 =?us-ascii?Q?3S9Fewq80ND0j9VBbOfzKF4ZYDf3IepPsPj+drsjBJbVacKjkDCZf30IUEOt?=
 =?us-ascii?Q?zGQtarMG5KfLVr8TUN88XGKysbOc1e8RRlufPEudC8zfZJFzBOtTPMBQSLme?=
 =?us-ascii?Q?jZ2dwJ6V0B6na9ToItVHWyBD2XDUerRAKcP44kEzqhqwAqe02XviL+y556bE?=
 =?us-ascii?Q?EdlXZN6rulNj8zW9ISy39As9fT6JwkvsgPx6AZUuKf3GFYOyEUfUI3fx2yny?=
 =?us-ascii?Q?5fI71hyHd0pYFxAhFCetGmnETBKlnx6oBDaI+hBZ8aHCmobuTvgqnIgerP9j?=
 =?us-ascii?Q?HGFKhY48e4fQiUKdL9aPmUkB7iexaDEsDlrZS461i5aQj+umHcynC7rrA0QI?=
 =?us-ascii?Q?/kMQH0b3kX1oU5dcstoBRBvoA3V0+WGoLrJEqJe4LxcvqLQKHrdXGV4gOOSB?=
 =?us-ascii?Q?iv+20T63OOE7Sa9+71EQY4Ql9xIre/qcSZPYloHeL1T0nofx3mUnWcxJ2+sm?=
 =?us-ascii?Q?EX/kqCL6LQ3+2oMUE8clCHqFNHk3xkxxwRxX9VtTZDi2iZa4KQlnm8mtqZ8P?=
 =?us-ascii?Q?KpMCkgsvyexzI8jEcCdxZ8XnvLW3b1Qf7uAz4gx/0dT0RascLP8hQYaJVJfE?=
 =?us-ascii?Q?6PZYqS4WZyTUInZANHWhWntcTNOPpT8yKw=3D=3D?=
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR04MB6514.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ca32ae1-e735-4ceb-fb87-08d8bd30076a
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jan 2021 10:42:05.2610 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BuoOhCxBNjwGrWMNntmVhGummyH1xSNsAbYfLEKy5JeeRXxhYbsOqD3dZDGcPZKJiuHoO3jUQ8fh9QQRYphMBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR04MB4979
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210120_054212_938978_796908BA 
X-CRM114-Status: GOOD (  13.62  )
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
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <Keith.Busch@wdc.com>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, "Martin K .
 Petersen" <martin.petersen@oracle.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 2021/01/20 19:07, Christoph Hellwig wrote:
> Shouldn't zonefs (in addition to the pending btrfs and nvmet patches)
> start using this new value instead pf the physical block size?
> 

Yes for zonefs. I will add one patch to this series for that.
For nvmet patches, I will let Chaitanya handle that.
For on-going btrfs, I think we can cover that with btrfs-progs (check in mkfs)
for now and add a patch as a fix in 5.12 to check the FS block size on zoned
devices, if the series is accepted. Patching now would cause the btrfs tree to
not build.


-- 
Damien Le Moal
Western Digital Research

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
