Return-Path: <SRS0=DeHG=HD=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E53A6C433E0
	for <linux-nvme@archiver.kernel.org>; Mon,  1 Feb 2021 21:04:57 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7630564ECE
	for <linux-nvme@archiver.kernel.org>; Mon,  1 Feb 2021 21:04:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7630564ECE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=pwgAER/Njy0DbophQnKv3ZKojOKnzqMiQJyZaEnzGLM=; b=pwCOBMPY9QyJFL6WDVnTDKSsv
	vQ4EVZlDF8tRt07Ybu9tDnkLQZE/m6lZYJrBpmhMNkZ5z3XJUgZxDWu0UVjum2ouZCb6Ncamq7vMd
	U+rUppOe1IDFGQK35JdnEyUF9FBSnkJ7LeejlIPc3If9e5YJzwbyofWIFzmvFB0k0vkb0dbHwHxV8
	1dxnQ/TlApCvfhI34jcONTt3YDcUpuiHThrAPCpE5ggxiV8reNoESFFbjZtWRjjvmLG8LzB5OEfLk
	ZOAHZs4dcnX+o/w69pufowGMHjF01lGqJVDhRQjksWD/BS64LW8DU3Q2p0fb/bnmuYOQRiKZ/EGKy
	+XFkFFYew==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l6gNR-0001UW-3w; Mon, 01 Feb 2021 21:04:53 +0000
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l6gNO-0001Tz-39
 for linux-nvme@lists.infradead.org; Mon, 01 Feb 2021 21:04:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1612213489; x=1643749489;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=Rtbs7kf9QmxHAvhW7ig5IrkZlTt3vWMOkxTwW7Fx4aw=;
 b=MEKsdKPf4y+maNHQmheY5cJ8v6c1Z09pRN0PbOj/oex4wios1JJanDBH
 ylrAGmxNHrPox4L/odXavL6RojF2BHjkHVMLgUs2ebFrMuCAtL/SxpKTI
 zVKV+9AuxWx4EelW3lp6fTneM2dZhBVq11MDsTcJkUvNSUdFLottFQ0IO
 NVEbNOk4etDNk6yTkYo66mbhNRUiCx79Mxdrl9szLxz8izCPgaDEz01NX
 JSQ1eMDZqXdTpspZfDjYPc/X3Wkzuuo6qTz7c8vKGhZJCw9GwfSFEeejW
 6PP3w54556hYyECdQEIKub0iqaLjWi91t8Os8kuF6A7w+/e+eFDrf59vM A==;
IronPort-SDR: N74uTMlSN+Tl4mT8FboeUrd7mtSkhlGodBulVihcbns1ODf0bC9qERs/mL7kEdtzwJrJ8t5H6t
 PYV9Hl4x3lmcjWPA7VGJAqFYzYnLzU6Ap7xP+oCrkPNir5NnURNs7WOtNBXLoVOJRjILHe5KD4
 6WnD+iR96dAvM+96qwnSIu6iytNyOn/jjYLJ7CAH2mXrlw0pKL6Y8lsf6oLCCZrNobbC3T1n6R
 PLSOL3uHe02xSSYf8Of7dfMx+fchc7HBsIY5VKEsdPpfZfArn73m+Jfh2A2KZaoa+oNqjGddqE
 1/E=
X-IronPort-AV: E=Sophos;i="5.79,393,1602518400"; d="scan'208";a="269265388"
Received: from mail-bn7nam10lp2105.outbound.protection.outlook.com (HELO
 NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.105])
 by ob1.hgst.iphmx.com with ESMTP; 02 Feb 2021 05:04:45 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E1h8ybQhDQpE9ly0IFmxOpaFGqDq4erEZtJeFRZqchT0Tb+XxTvNzmTTR0U2NDjTS8a70ZC3ly2zrGwVI5hhDJg4IZsRh5H1uS3nfp4R7ivzsNH6vwjCs4rPUeilSsMAxzUdPsJOYCQ9cAeqF8m/2L7og47/lrzBlvIpDPEmXUFkrIKFFQ+lyRfewGsQDokMh2RJ1dDXfxq0o9rzgYSS0LjWDstN1kOLxnK+7ZW2zPs+6ygwD8JQUkY4OuFB2MSsMe8pKu50omrC9JnW8p/twRULMI3HO+SBupNFx2rMzDdeNsV5cbSz7iNcXlxdNikDV94jaUn/Vjeu06M9vpqsrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aXF4U4gdWp88t6aqAnajQl37JAyjSgRLDo4182zGq5s=;
 b=UXkahLAD+C8OMBgI4CajFdvW1ZwzHi/m/JZX5CI8KRunKg4Okn0YeQqXhULlQvN7VSxOKywsf51+TU0fYst2114Q/eV6kELALbuCGdlh9DJ+fM1Ch/vVZMy0j/pk2SlJSyW0ClsQhG+kUgSnS4LOlwKLaw0JVFyA+BfCSRhwkzgR9j/bfhBlK9GJYF4l8mJeI7MeAt8ycLLd+I6IjsCL7vTcZSf87FNC4bfA7MtmsDmUOGdO1CCFaBrV7w1QjF4TRSYAAAGPaBUDiI2/7NFFJTUPLY6koLvxYvYvYqmi8cW+Bdp6pZOMkLrraJN6ZSU6Q1U1s15tBzam3O+j6pABvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aXF4U4gdWp88t6aqAnajQl37JAyjSgRLDo4182zGq5s=;
 b=QaVC8IXav2iC79WXncQ+ppy7Qi+fbz4EoU4HpxFFbZAGTrzXFIjukCv3+ped6cVE9TTag03D7rL7BuZBr3TX5Ll4HpKoDFBlE3qEhxYTpeuvk2YoPejwjjmCoZg000KybMP1t0iZsz5n4ut//nKiprQYUlm0qaQZH8p8aOQlVi4=
Received: from BL0PR04MB6514.namprd04.prod.outlook.com (2603:10b6:208:1ca::23)
 by BL0PR04MB4770.namprd04.prod.outlook.com (2603:10b6:208:49::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.19; Mon, 1 Feb
 2021 21:04:44 +0000
Received: from BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::b880:19d5:c7fe:329d]) by BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::b880:19d5:c7fe:329d%8]) with mapi id 15.20.3805.024; Mon, 1 Feb 2021
 21:04:44 +0000
From: Damien Le Moal <Damien.LeMoal@wdc.com>
To: "hch@lst.de" <hch@lst.de>, Keith Busch <kbusch@kernel.org>
Subject: Re: Buffer I/O Errors from Zoned NVME devices
Thread-Topic: Buffer I/O Errors from Zoned NVME devices
Thread-Index: AQHW+MPTNr+XIxB49ki+CpEBgpIf0w==
Date: Mon, 1 Feb 2021 21:04:44 +0000
Message-ID: <BL0PR04MB65142D8FBF2B6BC88E32DCCEE7B69@BL0PR04MB6514.namprd04.prod.outlook.com>
References: <BYAPR04MB56561E48A54530BC7F6DCF30EAB69@BYAPR04MB5656.namprd04.prod.outlook.com>
 <20210201175306.GA2127465@dhcp-10-100-145-180.wdc.com>
 <20210201180257.GA14971@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:38be:e4f3:6636:91ce]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 96ec0b77-9a8c-497b-3376-08d8c6f50028
x-ms-traffictypediagnostic: BL0PR04MB4770:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL0PR04MB4770537784667C92DB31CF75E7B69@BL0PR04MB4770.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8G4ccE9bSZCqvuPdk32GvQnjTeyLb1k+9jllxPDvvolHmTaezTokzlT7vw6q01bXNdg+Y+BxGGTkJ1HzldLl9FsawX7EMz3v1l5OSKHUj11C7ZooOOmwWsrHj0p4H07nd6a1KJpi5Nh0LdrLDIeRF2VDheLDlzWIJUy9tGDvLhLGBbAgHMN1h1LIAVHIfJgXa530xDnzl/LpNUMsVupW2q9gjrrXU/2Nh2JxDQpccZUzROyML7hwAItMGa0/S1vml0Q0XmXGZrVr0VgOjvy5owCnekNTVBanaYnrzGLLyg3HpvKsAAIBC6hNzPiNuefqcdTxjpUhOc4tsSHAj4YkIrv0vFEkUxyOlnalie3KTj9B5U/hHAMOy6ngraxXqNOI7n09rdRunhlzQo73p5FdtF5eiS9suwQvA6/lPoatrYGC/wMaHtlv7OZ4L9OjnTiaCbe8pJvXWE39WUQcL+UYIpNSjcSBozmlXWGEyGDGNQi7WeCzx3zpy4K+gT6prXnBtA3UQ04TIwNqGhX9i8l/0Q==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR04MB6514.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(366004)(39860400002)(376002)(346002)(396003)(52536014)(83380400001)(8676002)(7696005)(316002)(5660300002)(4326008)(186003)(2906002)(55016002)(478600001)(86362001)(71200400001)(8936002)(33656002)(9686003)(110136005)(54906003)(6506007)(53546011)(76116006)(66476007)(66946007)(66446008)(64756008)(66556008)(91956017);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?l6Ja99gIAYFenXy02f4j/mPI1yah8fn5Qm9oLgIpgsFfViS8x+PXxwO54j7+?=
 =?us-ascii?Q?GZLwb82u3vm1J8/a9AKlA/fMPfC6NtZOkV4bwaEJt4XURMi8Kg+dYSXStfqO?=
 =?us-ascii?Q?7gXes7vOgV16JDztkSPjuEi3fQqZSHJh7NlbNi0giC0SSdhqHEHJqQOusWEy?=
 =?us-ascii?Q?p0EX0gGpWcpHacDWwZ6V9NBmJxhnSGzyXN/HTpp3yJ0ZPDb7gp3pxTvIJgXp?=
 =?us-ascii?Q?1o48E1omUTWY97tyXtCwM5MnflQYm8uGwtI8RDGtAcLmxETvSSlyZo4ryDCj?=
 =?us-ascii?Q?rxkaOOgR4ScA26tyk2RcvdXhAA4z9zyimowIhGPTp4T26Ft6SxkM/d7nQwDj?=
 =?us-ascii?Q?e0aEmyZ9T2COcTOK6oux4LwKpt9MNbVIIlqwbjX3Pj+1qy3ncI0t2VKTZNtx?=
 =?us-ascii?Q?xDxvns8eIQBlCWCKvnfABCuWPgKnit4OZp64GFG8zrdcsaAcpzDwWm2qS5R2?=
 =?us-ascii?Q?UakzUCusQZz02XWeRUpvbQ915EeMAtlhX9pXhS7n1q4WKDNFqPHAXTS6ZQsi?=
 =?us-ascii?Q?P/D/27Xymym/e+DN5k95Q8mfTgI4cyvJgWmqpkvNaP4hNXlVrAHXosDhmpTZ?=
 =?us-ascii?Q?5+w4mStmjDlbnCGbpJicxFOXwvTsFByOixzSo6Di+1kGfTvocn8/KXoRkeLS?=
 =?us-ascii?Q?PZFepA9d0wJSjERrnp+SSdOxxsUa5yg0I2eZukg+FTq9uOx5IfFGzt2HAwQN?=
 =?us-ascii?Q?uIW/3QTErGwlSOcCyQ5/1MwBTqcBUcKyc80UsHStdlGnishoxWwafN4J2Ysv?=
 =?us-ascii?Q?BOmgYAhs5830jx2wgHjVrTlqhzCFRTbj5hS69s58g2ruooLu7k1idtnr/uuE?=
 =?us-ascii?Q?xZZ35ifyS3LHq3X9FeYAWJMbMdXEsb6JAy0MGdcn83lpC260B/P6qNAqvh+3?=
 =?us-ascii?Q?6j1f+m/AINFocdR6kAl89fGTzM6ZIWEjc9/9ljuXZx3qVPzt8ZTpMSjoWcFN?=
 =?us-ascii?Q?NiAXYWw7xJhYf8IhokHGDVy6IQ+Rzx6fh87WkDB4Mtw+oF3IiR1jJmjP5j0X?=
 =?us-ascii?Q?xd2pXiS3Jpar4PoeNMfu7KP49jfDmoUhMopyQJjY1xH5KGuZnbNqxLyzz1Y/?=
 =?us-ascii?Q?OyQNlvbyiQD56o75MnYdFHHnz2u+Tb3zifhkmudReZVdXEQZLrhS2OtOEyOJ?=
 =?us-ascii?Q?dJNaCg8vlCptqbwa6xahZYgtVf5geYRpwQ=3D=3D?=
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR04MB6514.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96ec0b77-9a8c-497b-3376-08d8c6f50028
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Feb 2021 21:04:44.4150 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SsCYMmI6t8htv4BSPVmCHf9EqJV53GpFbELTn+dP3LYNK/I653RRzAX4eErq3akfPt4hWKK6Pc5aqISo1ysjeg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR04MB4770
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210201_160450_432146_F1D1A871 
X-CRM114-Status: GOOD (  17.59  )
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
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Jeffrey Lien <Jeff.Lien@wdc.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 2021/02/02 3:03, hch@lst.de wrote:
> On Mon, Feb 01, 2021 at 09:53:06AM -0800, Keith Busch wrote:
>> On Mon, Feb 01, 2021 at 02:36:12PM +0000, Jeffrey Lien wrote:
>>> Christoph, Keith
>>> We're seeing a lot of these Buffer I/O errors with our zoned nvme devices.  One of the FW developers looked into it and had the following explanation:
>>> All these Reads are from the kernel during enumeration and for LBAs that are in last zone's hole hence expected to return boundary error which is getting logged by kernel.
>>>
>>> [65281.936988] Buffer I/O error on dev nvme1n2, logical block 3800039296, async page read
>>> [65281.937165] blk_update_request: I/O error, dev nvme1n2, sector 3800039297 op 0x0:(READ) flags 0x0 phys_seg 1 prio class 0
>>> [65281.937166] Buffer I/O error on dev nvme1n2, logical block 3800039297, async page read
>>> [65281.937335] blk_update_request: I/O error, dev nvme1n2, sector 3800039298 op 0x0:(READ) flags 0x0 phys_seg 1 prio class 0
>>> [65281.937336] Buffer I/O error on dev nvme1n2, logical block 3800039298, async page read
>>> [65281.937498] blk_update_request: I/O error, dev nvme1n2, sector 3800039299 op 0x0:(READ) flags 0x0 phys_seg 1 prio class 0
>>>
>>> Are you aware of this issue and if so, do you have any recommendations on how to avoid or resolve?  
>>
>> Is this from the partition scanning? We don't partition zoned devices,
>> so I think we can skip it. Does the following resolve the issue?
> 
> We already have special zoned device handling in the partitioning code.

Partitions are ignored and warning printed, but the partition table is still
being read...

> 
> But NVMe should make sure to never span a zone boundary as we set the
> chunk size to avoid that.
> 
> What kernel version is this?  Is CONFIG_BLK_DEV_ZONED enabled?

I had a very similar problem doing zonefs tests on Matias machine on a ZNS drive
last week. The problem was the firmware... An upgrade to the latest version
fixed the issue. Not sure what FW rev you are running here, but upgrading might
solve this.

> 


-- 
Damien Le Moal
Western Digital Research

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
