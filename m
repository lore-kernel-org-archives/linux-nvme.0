Return-Path: <SRS0=ghx+=G7=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04B26C433DB
	for <linux-nvme@archiver.kernel.org>; Thu, 28 Jan 2021 09:36:58 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A081661492
	for <linux-nvme@archiver.kernel.org>; Thu, 28 Jan 2021 09:36:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A081661492
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=lN2GcUwMtzYjEXxj93Hg96NEFga9tH+eA9bsRSI1J5g=; b=0iwW52brumntk8olbwZrq9hec
	Vvu3fuCN8SpRcgP5NdIR5tH6o1ADah1Mwt1rhbEPsCHCWmZDktj3HGssdgnq78I6bmHYsamUdP3Te
	PvdbVt3TnHpY2dbU4iYp3mbU9DlFS7VvLMT/qNF2SBzW5Zm4QpiWzlYoHMlJ37+y2Ys4BEmFtEiWH
	/M/4jPO4IwUVStnYs19RnyIJn1ndpeuWOjrN76eaj94ioYD4NRq3WO6sxMZsBuSxJi3rMOQJiwvNM
	ySFTMpFACJAIW7ofe5uch46RtDfdDs7+iqYwXf6DtyBupT7lfi1E3q7W/XQpeY7IRXZlE3HTZUR89
	pDjaB5Qbg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l53jR-0004LI-Cs; Thu, 28 Jan 2021 09:36:53 +0000
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l53jO-0004K5-JL
 for linux-nvme@lists.infradead.org; Thu, 28 Jan 2021 09:36:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1611826611; x=1643362611;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=7D0Vydf7x2ajNy6gouNJU0FRV0KV//UjJI4mF/RsmOQ=;
 b=ZMYnDrbGcdFLm1MRPmmpOLlsI+JI3k17MhGS00vhTIdIfRlWbjMu23oW
 +KJX8buo1SLiXblQtwVZpCDVqfna8rvQXa9Azeo2dDY5XVBkBNB3sGb4H
 rId0BTFv8I4oaTMI2SmKCQ2u/3Zu+l+aSczaTFNYV9x7K4OECDf4aWcU+
 wkZLoShZV61vB5sk2g0mddgGLWKjsMJZCXMyPqT+xlr1oyrp3ajeXx8P2
 Hasf3DGot2lduiQnltLfyP6bTepTq7MHWOMYK/RjZ1H8Lni4/18DjYvJH
 8TBNqfQdn0S2AmeTVMZjaP1VO8mzrWDhcFVgM0Qq7DyMjyaaabaLwhfNg A==;
IronPort-SDR: 70el3SmYvGq3EuP4L4nmfbMcUqm1TcC3wu5KaTj0C4WhDU9Av233SUTHvdxWcphjqVHp/fZBgu
 U3nOuzC0PN9TfLgTOkAH38q2Ykojrfxusf1k+g6h9vitrNZ5uzpSLEg353wJPVfYlzCPxxfHR0
 SCkxp+ptRKeZCZLan1o/4FxDV2+nx984msnmHTCxpLAeLx6YqD0FBqcPuyCA2zKFyjAb3h1MOR
 +zNwSxuSzpZgSKdm7HWd123TF1+TkSflrTktubmyeb4zq/BIRZDSh2fW+E+1wxRjPEL/KOAr2I
 sXU=
X-IronPort-AV: E=Sophos;i="5.79,382,1602518400"; d="scan'208";a="159706118"
Received: from mail-dm6nam12lp2171.outbound.protection.outlook.com (HELO
 NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.171])
 by ob1.hgst.iphmx.com with ESMTP; 28 Jan 2021 17:36:49 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i86qIk23QKY9ZH6HMKDiDAhfMoZ2I1SYAup7CMrhtYWDkUsyjTR6E4pusB+kf/Wpzy1r4pXq/QYpSXtVOV2rYUt3NyuAUsiJL7/QRZIf1Atxxv+kjo9NhJ0oP8hL1mjjCEO+MiU78u4BbJ1BYKglCiANgn2Gfn9Y1JpO2LH7EBhX+C130G0yvchIQ8TRyHlGKYX5lCLVCJ7FgHsKE6Y9I2yGUhQHWifcJdxftWiTOXHBJBYEJadYVwA5qidDArE1O41hLWSA/cwPmYN2Z7lIPl65p6epPxsR1n0ztTGpnYo4mKTQNC7J/2Gar6MFm6tD0NTRS8G+FBSKY3Nq95n3sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uzPLJZm3i3mhbidgIFuhmzcne5X5jc4h5tFCui3vaME=;
 b=aDtHjELRga7dQDIWJE9+4bEO3R/crZjKOnlZ747Zx80hrv2U8cSRb6s/m9Te4z+S0IlK6Jif4178jwpykt+P/lCKwkpGNLY0TDRzwReWw8+lzRp6+n5+JoB60VB8xhXrI4UkdcNT7sRWmEiyZV/wzH8rCKSev2i3WHjTpo7jlCNKF6TM+/+mYcc+hpEkvt7i/WyW8OsCGXG0fwvks3cLnl21Q6xa/AQVznmcI15pgmU70EHrewxknr48kmvVGZdZtoCVWyKXLRUxgx8vK0mEETAYNC87FBbt57ZlKV14y24oi+/mJaQf/vUVTWlCjo9FkrAeS8fKcHsttDJfLlBbCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uzPLJZm3i3mhbidgIFuhmzcne5X5jc4h5tFCui3vaME=;
 b=xdPSmzDv7YRG5hMZYIYAm2UNLbdwVVhDyf6Y4lZ/o63h7kNt3JdwV/oxE0h2wWtpvoc2QKQROEpb72FwhAGNhDpRRjRo4KYEztRw+iV2v0oTs2YiRC0XHXl5fJICK1X1tV87w7PuFZzXMRCVxa/a+ji6FjWVPt7QZVfqqh4C6HY=
Received: from BL0PR04MB6514.namprd04.prod.outlook.com (2603:10b6:208:1ca::23)
 by MN2PR04MB7038.namprd04.prod.outlook.com (2603:10b6:208:1e6::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.16; Thu, 28 Jan
 2021 09:36:47 +0000
Received: from BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::b880:19d5:c7fe:329d]) by BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::b880:19d5:c7fe:329d%7]) with mapi id 15.20.3784.017; Thu, 28 Jan 2021
 09:36:47 +0000
From: Damien Le Moal <Damien.LeMoal@wdc.com>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v4 8/8] sd_zbc: clear zone resources for non-zoned case
Thread-Topic: [PATCH v4 8/8] sd_zbc: clear zone resources for non-zoned case
Thread-Index: AQHW9TFKJGYilwYisE6/4O0JGnL8cQ==
Date: Thu, 28 Jan 2021 09:36:47 +0000
Message-ID: <BL0PR04MB6514062937FF5BE302A27C8FE7BA9@BL0PR04MB6514.namprd04.prod.outlook.com>
References: <20210128044733.503606-1-damien.lemoal@wdc.com>
 <20210128044733.503606-9-damien.lemoal@wdc.com>
 <20210128092406.GA2607@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:47a:7b5a:7dfa:1b1e]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ec1c0f5d-df73-4995-1b3d-08d8c3703bc3
x-ms-traffictypediagnostic: MN2PR04MB7038:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR04MB7038C1876C532EA58EC68C1AE7BA9@MN2PR04MB7038.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AOTiba4i+GOtzNhv9sD/VYTUtEBigA6xqcXdVgYOYe4jygqAlwiFIgaa6unr/ao9sAVVsrSfsV9fcXBJvWOpK6QJ35hvI5UzeAI1kz593ajDTpDh4LpsK0IbxGeOJhyu+meNMpZCThG6BsdkxqKNO1Ba9MW4kpWTfGtERckiz102I5SjCg8TuqWqrBpSNsduoQXHzJqLBdPu1FBFhMaervcAbn5LXXtqn0UVgolgBN9zbzQRxUgubze4S3mNzcyJgbCJf+u8UvavgrnuFvh6yArQ3OuuBCPhtouwQXLFN9f0QOTgZjJM485sR2GptNSpb2z0QulXyhaVYcyRcjnsYp+0TMNNuLsxdvLbUNuyus4TUxYfbeDYMgiSj9YLhg9Le8dNP+rFNW/eZKOP8MXglFvqo7I1TwB8FlZ3KOMI+bzXRoslpLsgNIXVbtj7zKIFvWk50O4ZgZA7bBoz8gg1reaUOnkBFIhPK2KeA129EsSXxB5cLpXO4eEOv3wkIFrcUxialaqx93vWH6ZyiLh01A==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR04MB6514.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(346002)(376002)(366004)(136003)(396003)(478600001)(86362001)(64756008)(71200400001)(91956017)(2906002)(55016002)(6916009)(6506007)(53546011)(8676002)(7696005)(9686003)(54906003)(66946007)(4326008)(8936002)(316002)(186003)(52536014)(83380400001)(66446008)(5660300002)(66556008)(66476007)(33656002)(76116006);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?s5H/cRI4TqUbx7QTfbY9UmRK04mEtKdS5Ka+zmEMx8BUKajc5ulTEM5bJ2Nk?=
 =?us-ascii?Q?sJTnO49mdPmn+WR7icT5vkNyrBzr7qcYMIDZQgDUwyKXcBrH70VOGN32/UfR?=
 =?us-ascii?Q?ALCPQ9VizGix8K/aH833Sdy8RLlCP+1W7WPEqnDXSHyvNbjVw5gMtS1rgvec?=
 =?us-ascii?Q?u8ASXM65J+J80vu9GJXmCW1bB7W/RRSExmKa6WFr3Qi6wTcgrU+LiT8Pku6M?=
 =?us-ascii?Q?Kra3DmUwOwuP9SvhYXRkPpgiPSbqnvy39nbh2FMbhrgkCRP3m4zfJET9A3bb?=
 =?us-ascii?Q?QfZjXhXFW81Dx806kMezUfq/BAqiVWS7zyEft7qZ76wFKL+sYknzimL8jRnH?=
 =?us-ascii?Q?21S1F05JBZz3gP/jE/4kTAhIZH+64KFVqZl4GEJ45JXdkOGxCrjAMMHYP2OZ?=
 =?us-ascii?Q?W9spzbGoSI6YdczBcsuh9BoxXAtxv8ZyJ8Yg52ZbweIaOwHJQcpu7aMhPkxY?=
 =?us-ascii?Q?pHDLkA/Y8kYx8nkLXBwpI0W8nrAVvoGteNgR5Zww9mlyeNBA6gt3NQYsJ4rk?=
 =?us-ascii?Q?1vdd4aycFFG+cChrugnFrLQXQKfwvo4HuKUF5LUBsefbuULq03FIHaeLrUo3?=
 =?us-ascii?Q?16Am5jzNba0FrjFvy8fjrr5mTNFykMGRzglT+/YaLM/Hc7eBYhbrtGjXby6+?=
 =?us-ascii?Q?35NbbhNm/r5y/4U6vqH4cQJTUza4iyK7eQEe1SZ+ELVc8TDY4QYJ0RAvE8Tl?=
 =?us-ascii?Q?8RqOhfX2n9q4bXMgBLNy1G1//XUpAeUC8YWEJuKsyqYfn2O6UUiBReCH91AH?=
 =?us-ascii?Q?wqtjg2Y2QixDtguPvKdCxiw9CpieUSA3FKRCqKAXDGrsDfnBPP03RHwKT9Qx?=
 =?us-ascii?Q?xca78N3DKpB7or3XqBWQ/Ly42rbUE4qa8JKBdTnhnSzvZDqWThpTFL17g4m7?=
 =?us-ascii?Q?CeVgIofHPdxBqcrLLK5GJfISMyFim8ijzByRDjXmfjlpEFto6oZ1D2G2cdhd?=
 =?us-ascii?Q?Hsd8oz+Wp30E2ghIpc816sDimCxMoEJESCnaPtNAaTO/apMBxKqUgJgkWul2?=
 =?us-ascii?Q?2dduJCqEVC0kgNbNn3aB44+0DN3OW3L7n/Sj1L1RGDRIkR+Fxkv7zoRMcDej?=
 =?us-ascii?Q?tKEnvPSlcaeftal6oKsX7MO7V947rMLnDqlMlhyd5QMQ71tfT0j4of/zO5Zc?=
 =?us-ascii?Q?yIEc/OjN4MGP8++N7A0+D10bp3o+VgylvA=3D=3D?=
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR04MB6514.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec1c0f5d-df73-4995-1b3d-08d8c3703bc3
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jan 2021 09:36:47.7986 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OsYnBH5obtG7gTTGmeM6JJmQaLVCBDAvYgXtzoXImBWzhA9ZKNkDtWPwUnaQOVnAyjsGmosKWI3gqq86rvH9nA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB7038
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210128_043650_977061_AFE4494A 
X-CRM114-Status: GOOD (  19.67  )
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
Cc: Jens Axboe <axboe@kernel.dk>,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 Keith Busch <Keith.Busch@wdc.com>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 2021/01/28 18:24, Christoph Hellwig wrote:
> On Thu, Jan 28, 2021 at 01:47:33PM +0900, Damien Le Moal wrote:
>> For host-aware ZBC disk, setting the device zoned model to BLK_ZONED_HA
>> using blk_queue_set_zoned() in sd_read_block_characteristics() may
>> result in the block device effective zoned model to be "none"
>> (BLK_ZONED_NONE) if partitions are present on the device. In this case,
>> sd_zbc_read_zones() should not setup the zone related queue limits for
>> the disk so that the device limits and configuration is consistent with
>> a regular disk and resources not uselessly allocated (e.g. the zone
>> write pointer tracking array for zone append emulation).
>>
>> Furthermore, if the disk zoned model changes at run time due to the
>> creation of a partition by the user, the zone related resources can be
>> released.
>>
>> Fix both problems by introducing the function sd_zbc_clear_zone_info()
>> to reset the scsi disk zone information and free resources and by
>> returning early in sd_zbc_read_zones() for a block device that has a
>> zoned model equal to BLK_ZONED_NONE.
> 
> So creating the partition doesn't even call into the driver, which
> means we'll leak the info for now.  But I guess the next revalidate
> will simply clean it up, so it is not a major issue.

Exactly. But the leak is only for the sd level resources now.
blk_queue_set_zoned() cleans up everything else.
The super annoying thing is that deleting all partitions leaves that disk in
regular mode instead of returning it to zoned mode. Need to wait for a
revalidate or for a manual rescan for that to happen. I wonder if we should not
trigger a revalidate, always, to avoid that the user sees the device type
suddenly changing long after the partitions were deleted...
Adding such revalidate for partition creation would solve the "leak" problem (or
rather the lack of cleaning) too.

> 
> Looks good:
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> 


-- 
Damien Le Moal
Western Digital Research

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
