Return-Path: <SRS0=5/PU=LF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2475DC4743D
	for <linux-nvme@archiver.kernel.org>; Fri, 11 Jun 2021 06:04:39 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D819E6023D
	for <linux-nvme@archiver.kernel.org>; Fri, 11 Jun 2021 06:04:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D819E6023D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=BM8om5vbpKw7u+f+73mo8E5szxDuIxRm6MgzvcyIyJw=; b=EJAcIKhyeTfZkX
	hIePeGudNvMSfhzx1ZVPhf7+b+eMuynBK7iDUBiK4UL431LbCn+98d0dDe3zaLdgI87SYvuXXbz2v
	/N/NFyeWRvH1rMxIeYvIZdEiyvjxnRUoc7Yh7OUlRKaXR5Sl5UGMq/LY4y+YiKIHxb6z5rfr9C9JX
	7O+BzMXygefwNwOnCGSUhep+nXcR8pG7ziX8OFLKJsis73WPr3o5G1w/1fg7N8jRFkycfpud8A/F3
	l5uit8zRBz6ZBHM4WmmCnE5RHmr67wWYuueuuNwVVyyd7NZbW09Ii45/Bl+SIhwgEN7FzEFDVGGsu
	HZHR36E41vJOSaS56x9g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lraH2-003kD7-6v; Fri, 11 Jun 2021 06:04:08 +0000
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lraGl-003kAv-Qn
 for linux-nvme@lists.infradead.org; Fri, 11 Jun 2021 06:03:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1623391431; x=1654927431;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=FBsumNmMXURuR5iwFjMS/dV4qCYXmJ6qcwKN9HSKUBE=;
 b=BPO+OxVG5c8bsmgaJ6tBQfpmeU/eQOHtWLQrpKdrbfCD1wljSA9Sg2in
 A7YtOUXt5Hu/tbXkt0pHktGe88wsxrGVgPVxLaN9/r78asGtrN3y5DXMx
 T0N5WwKKfWAV+WcC6f3JO5DYma/Xwrc9ZeXqwMyLiOB4u8tqc1/LpbJeh
 0J0l6b95bvH8KRZ8xDkLWfliG0P/KtxnZOPO7xKHG3uwxO3OgpFxKTBEG
 Vrsn82BoZqAfGnwBqxxGEjDNWIzdcM+cfg/wT3ynkpXfxDwThkkX2sgkW
 zEOc6w3SLt1y4QfQEezbJ8K7vL6+ZD1Z+SKmoDjlFFnPyxDOG7OeRsaV7 g==;
IronPort-SDR: AnyCrNkk0b2As/Vn54jAFhBaw1gSC2hivcotOQtGH2aPjaRmh9eNZVe73IoDcft6rl+C05uaTM
 TN3lDJecB7PYXwJ8Sv3BIkp6RTyqw1L5neMkQli0TVjApW3yKmbJPQTzERlKYA2vfcgcFsXE4i
 ynR2U5HuXdj3EZw6piF0oKOZJ18O5eRNJX1Yyb28MzAHpegDrqw6L4w+IAofw+PwB7zhJ25H5t
 UDf+GfHz/od4CnZvYKeUYjycIqOtzMqnp94tTWqZxADIIcH2cu90eeXalqameB67U+c2zg6Huk
 3G0=
X-IronPort-AV: E=Sophos;i="5.83,265,1616428800"; d="scan'208";a="170827041"
Received: from mail-mw2nam08lp2172.outbound.protection.outlook.com (HELO
 NAM04-MW2-obe.outbound.protection.outlook.com) ([104.47.73.172])
 by ob1.hgst.iphmx.com with ESMTP; 11 Jun 2021 14:03:48 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E9u8cwNSxMxGc9bavVKSBwLBxDtqiw35bs6os4ZvZt551opqMrkuB0b+8WAEJbLTCaPddtM9Or/JjITmctJLrwp/nb9Qt6ndpA/AD0iJGjVPcchelI683IgSQLglHcs1k+6+x25If1esLgoZCAoCvLatdC70baQ7SBJKgfyyGyBPgEx1F/iXSkjo03y4/U0ygel7RptkMmYvU8xbTiZWvhSG4+6UQJ68vZ8lSJGdiaPlznUtUdN13S2SpfdRy7KBp9jpDFG6UDY/fGssSTiKB+dQLAfwCCPqRRBwcpty45Zk0ush16qO8UNH6GOO5xdrCM1foa/dKyt/V65CviSByQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hK9sGq/kA5Bj8toVnB4cBm8voJUhRPR3b6MonrpYc1c=;
 b=O8qkrxQSO+evErNE/QHXZ/dumCVhitLX83OubxkwKYqsm0sUodofiRar6rXKPObG31uQg9u8JgXCwXHO1iO1PVX5Vqc/IWFGM70ofF9l05G0SEReTFiLXdIeryeMGmsaK2PuVx25aDf352pTexRxA7nCsycffCi0HrdCYCixClKm1z5WlqRN4nUIZIYjaXqkoyoIbsWBEhpTFsntqKLqBpGrKy4PKM6Hev2IYuO9MrI4WjVdOHWAchKNyWIAJgeOHW+AV0pgI/fRG7Ocr/LHJfHJcr9rB9r93NOq/Eml5GSkV+3hwXPMc6YuEkq3LbQTYi5dcUWgr6b4gUwMUX9caA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hK9sGq/kA5Bj8toVnB4cBm8voJUhRPR3b6MonrpYc1c=;
 b=CMx2UySDZjlMn1wYPadPCS5HJfKfP84FecMkdN6eWZnACnSxc7vpE5E1ea7GXxkqxd24/q7sQZdvLn9/6an6gD4XK6zC3QpRl4s/k32MfSR2B8na4y4/+XSLPX2iniQo+CLl2soeImGgsP+8sgZch+uEyscKWNv6sVa/J0nUwNY=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB4229.namprd04.prod.outlook.com (2603:10b6:a02:f5::30)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.27; Fri, 11 Jun
 2021 06:03:47 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::6873:3d64:8f9f:faf0]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::6873:3d64:8f9f:faf0%7]) with mapi id 15.20.4219.021; Fri, 11 Jun 2021
 06:03:47 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "dm-devel@redhat.com" <dm-devel@redhat.com>,
 "lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>
CC: "ckulkarnilinux@gmail.com" <ckulkarnilinux@gmail.com>
Subject: Re: [LSF/MM/BFP ATTEND] [LSF/MM/BFP TOPIC] Storage: Copy Offload
Thread-Topic: [LSF/MM/BFP ATTEND] [LSF/MM/BFP TOPIC] Storage: Copy Offload
Thread-Index: AQHXRfrE+mT6pvaiwEOWn89Dsv4XaA==
Date: Fri, 11 Jun 2021 06:03:47 +0000
Message-ID: <BYAPR04MB49650D374549472F6A47FE7786349@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <BYAPR04MB49652C4B75E38F3716F3C06386539@BYAPR04MB4965.namprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5be62dd3-01ed-489d-39ab-08d92c9ead3d
x-ms-traffictypediagnostic: BYAPR04MB4229:
x-microsoft-antispam-prvs: <BYAPR04MB4229D929AA78996921158FC186349@BYAPR04MB4229.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: coFKMFWtUO8nBQCW3TtlH9vC2oMac/dHchenVDmoaI2SbrxqOs2R5MMoTufwH7xcmAJO7V61enHKnUl9DJrF8xEENafquQPjIbjs7Kpe3v7tNSaGu58cSIllZTyNLf3gf70/L4jzkgWXKz9xiyB+F4Q9Rvwevs9w7ASfKRdjn760WWoY1zU2F33Nps8aG1+zkdvlYLxjhB89RS2zNM350NjYtr6BIwsdbkxvOVZIum7NkysjRt9gJxXPnLhsCPnH2GHw0JImNN2TTAlnJuTLWsL+hVt7Ezueo83Tznfph/F98sIcSSCOJcZH6+mga6IkYLun/mvoH14iDsYwvubsnBu/uqdSG4WLmLDyGCPkhQIg8C74LVLqKvVAJWLeFC+f8e1SESP+kjHmSpc7RD3NNIpEXGYQ4d50Jhiur6QXpCX25Tb8MpVECMFN8ovAbTzqsxb5Gfigb1ce+sFMv60kUGn96WvfT59ffDkgAxRVLRx5IBOFTH/QKfq0KTvNDsqZdjaRPl6V7ol84wxzZtq/XXj8n33U8WtIZ1t4weYaQ3xEf2YXd6TJhrTcthlRy//77d/j4/s2JEl9lNgZtaPcQkiumDcrBB1TRVN9TSQhytjQUGtpoa/yEpkTmpqY6iDJ7xQwfwzQvsJHJ0kQkJnfV5vTJfT/K2LEHg870uVacJEiyKxYMOAPpuYW87eclvnUn1M7zRn/4ap+spj4YJZSJHHZ7f0xUpuaQ8ydUFIdvT9/QzSw/t6M8udBDAF5nag7Kuuj/9twlu+XEbUzDL81pfSpHiBtfrRYXl/2FQDSYh7pinMfdxl/oAzdby31E3Gy
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(396003)(376002)(136003)(366004)(346002)(76116006)(9686003)(53546011)(86362001)(5660300002)(33656002)(4326008)(966005)(52536014)(6506007)(2906002)(66556008)(478600001)(83380400001)(55016002)(66946007)(64756008)(66476007)(110136005)(316002)(8676002)(71200400001)(122000001)(26005)(8936002)(7696005)(66446008)(38100700002)(186003)(15398625002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?3AlIT2PUDZ8GYva5dnGvCri1fBBCg0PVySMZdGJzotMdx8tHEPcaRuqudlAF?=
 =?us-ascii?Q?9cKB5CFG1U2dhdBn5GSWfzYE1WTDuzudBMSEhzxU1MFEhsWLvJVE72nz2ubB?=
 =?us-ascii?Q?cb8WexDIZIIwpa13wg3thS1MJ//2JrVAuVbdPLQnpe/WXw0aBYAAZ7IzbFIC?=
 =?us-ascii?Q?PldSolR1w2wNCMsNjtgZZBT5EqMbordOwLvYv9vGeNpb58q2/ZLSbgUSv+dJ?=
 =?us-ascii?Q?u1fNXGv0TMTd+QUgUIOkiJ2Z6AzNUZqRxo99M4zJt6T3901EfypvKocdblju?=
 =?us-ascii?Q?SqwLARcYKSub7cd5pAdLAOUNJxXJTC/5wIJUNp4LyKrfPlK6F5nsPal60eAn?=
 =?us-ascii?Q?Wh5uKTCbjW27j6SO1Om+i8vcZ+Ay7yg2D93YWJP1KzAW0XqgDVS8DOf5ijH3?=
 =?us-ascii?Q?fYMom61hmD9Z/ixKBZys88G2gFWWc/nECgfQGneM/p0tjTjbaVtTe5mOnWvn?=
 =?us-ascii?Q?rvwRf3Ocm9fiWw/VN97/Xdsvl1PRRf4EkAbLn3pGudxVfWa4QU9KlwsveJa4?=
 =?us-ascii?Q?CBG0wGO0qf/ZEa9Kr5AyP1UZSA2WL5TxQ6KnLL8rDJu31MkrejGEMfmqRaNF?=
 =?us-ascii?Q?BbcRn2Fd9DguC5SwpwI6iqtOyNpcO03L1G0nJlEJMlW1B7Rzkmyn8lJzSndD?=
 =?us-ascii?Q?Ah5TCmo9TF3Mr+XMg4ocTwwCA2iJQ4I3h1NOcHPsMWdI+B0avYtQA9kOGW/C?=
 =?us-ascii?Q?P038lxZLTToLxMUaH9JXw/yVmNnRAh9EKgW5IPxvMvNBdi7EoT2BdIrwEqBA?=
 =?us-ascii?Q?9w9CBaFbs484TpMrA3W2/r2KaN0oVbOq/hFVTEhL3rfwZShyAR7CudSqd0YE?=
 =?us-ascii?Q?0lxlYHipxfYkHOoiC7r/8Lb7pny5kGC39DO9aRiry78HkBvfTOACiSS/zPP4?=
 =?us-ascii?Q?2attSIW8VPZqJNUOsQ5cN+J67Mz9EW0hWTWlwuCoR0xJhpOZOJvUwHqMLbB0?=
 =?us-ascii?Q?SArZwejN9y8/mC710Wvr5Xz50b5a2OY2/UYvi+iRSQp8bOqrJ+AXlLXMieDP?=
 =?us-ascii?Q?GERgVGG/mD1Bm60DOET2/Lk6+ApG+P38e4fp0JS7VB+pzYX+62fYSbrrqA/M?=
 =?us-ascii?Q?zegyAc5W4+C60HQFLCXa+oQXulI5zvRt1EyPVnIZBpsHktRLobv8hUTnU3z7?=
 =?us-ascii?Q?g8PTE3pHy1eLTOmatcjobNEMynOF37ZLeZpXwSubHRoJ5PmW8Do+6XAihpEP?=
 =?us-ascii?Q?MusJchFfT2phYw6q063P4SgjHuB0+HJX3h1icASyqohzqgWwx73CbdoTkNfu?=
 =?us-ascii?Q?7unClvyvTEGIoTasI0lNNVZ+L3HXw7KXZ9jM9bHsOGDEqHRLamKO09Bsy2wc?=
 =?us-ascii?Q?NU5dPfIdX9IyQ4Rh38DFaPWz?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5be62dd3-01ed-489d-39ab-08d92c9ead3d
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jun 2021 06:03:47.0513 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: USzjgWd1zMIWMBe1lHc+K/WhrbG6rDhO8k9o8+i+2P9th0l4qPe+8W7e6X+JR4MS1pFA/+d7WdaNGQm5pexWX0RbqkG+OIUK1dWc7UWaKNE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4229
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210610_230351_993894_207E8935 
X-CRM114-Status: GOOD (  27.33  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 5/10/21 17:15, Chaitanya Kulkarni wrote:
> Hi,
>
> * Background :-
> -----------------------------------------------------------------------
>
> Copy offload is a feature that allows file-systems or storage devices
> to be instructed to copy files/logical blocks without requiring
> involvement of the local CPU.
>
> With reference to the RISC-V summit keynote [1] single threaded
> performance is limiting due to Denard scaling and multi-threaded
> performance is slowing down due Moore's law limitations. With the rise
> of SNIA Computation Technical Storage Working Group (TWG) [2],
> offloading computations to the device or over the fabrics is becoming
> popular as there are several solutions available [2]. One of the common
> operation which is popular in the kernel and is not merged yet is Copy
> offload over the fabrics or on to the device.
>
> * Problem :-
> -----------------------------------------------------------------------
>
> The original work which is done by Martin is present here [3]. The
> latest work which is posted by Mikulas [4] is not merged yet. These two
> approaches are totally different from each other. Several storage
> vendors discourage mixing copy offload requests with regular READ/WRITE
> I/O. Also, the fact that the operation fails if a copy request ever
> needs to be split as it traverses the stack it has the unfortunate
> side-effect of preventing copy offload from working in pretty much
> every common deployment configuration out there.
>
> * Current state of the work :-
> -----------------------------------------------------------------------
>
> With [3] being hard to handle arbitrary DM/MD stacking without
> splitting the command in two, one for copying IN and one for copying
> OUT. Which is then demonstrated by the [4] why [3] it is not a suitable
> candidate. Also, with [4] there is an unresolved problem with the
> two-command approach about how to handle changes to the DM layout
> between an IN and OUT operations.
>
> * Why Linux Kernel Storage System needs Copy Offload support now ?
> -----------------------------------------------------------------------
>
> With the rise of the SNIA Computational Storage TWG and solutions [2],
> existing SCSI XCopy support in the protocol, recent advancement in the
> Linux Kernel File System for Zoned devices (Zonefs [5]), Peer to Peer
> DMA support in the Linux Kernel mainly for NVMe devices [7] and
> eventually NVMe Devices and subsystem (NVMe PCIe/NVMeOF) will benefit
> from Copy offload operation.
>
> With this background we have significant number of use-cases which are
> strong candidates waiting for outstanding Linux Kernel Block Layer Copy
> Offload support, so that Linux Kernel Storage subsystem can to address
> previously mentioned problems [1] and allow efficient offloading of the
> data related operations. (Such as move/copy etc.)
>
> For reference following is the list of the use-cases/candidates waiting
> for Copy Offload support :-
>
> 1. SCSI-attached storage arrays.
> 2. Stacking drivers supporting XCopy DM/MD.
> 3. Computational Storage solutions.
> 7. File systems :- Local, NFS and Zonefs.
> 4. Block devices :- Distributed, local, and Zoned devices.
> 5. Peer to Peer DMA support solutions.
> 6. Potentially NVMe subsystem both NVMe PCIe and NVMeOF.
>
> * What we will discuss in the proposed session ?
> -----------------------------------------------------------------------
>
> I'd like to propose a session to go over this topic to understand :-
>
> 1. What are the blockers for Copy Offload implementation ?
> 2. Discussion about having a file system interface.
> 3. Discussion about having right system call for user-space.
> 4. What is the right way to move this work forward ?
> 5. How can we help to contribute and move this work forward ?
>
> * Required Participants :-
> -----------------------------------------------------------------------
>
> I'd like to invite file system, block layer, and device drivers
> developers to:-
>
> 1. Share their opinion on the topic.
> 2. Share their experience and any other issues with [4].
> 3. Uncover additional details that are missing from this proposal.
>
> Required attendees :-
>
> Martin K. Petersen
> Jens Axboe
> Christoph Hellwig
> Bart Van Assche
> Zach Brown
> Roland Dreier
> Ric Wheeler
> Trond Myklebust
> Mike Snitzer
> Keith Busch
> Sagi Grimberg
> Hannes Reinecke
> Frederick Knight
> Mikulas Patocka
> Keith Busch
>
> Regards,
> Chaitanya
>
> [1]https://content.riscv.org/wp-content/uploads/2018/12/A-New-Golden-Age-for-Computer-Architecture-History-Challenges-and-Opportunities-David-Patterson-.pdf
> [2] https://www.snia.org/computational
> https://www.napatech.com/support/resources/solution-descriptions/napatech-smartnic-solution-for-hardware-offload/
>       https://www.eideticom.com/products.html
> https://www.xilinx.com/applications/data-center/computational-storage.html
> [3] git://git.kernel.org/pub/scm/linux/kernel/git/mkp/linux.git xcopy
> [4] https://www.spinics.net/lists/linux-block/msg00599.html
> [5] https://lwn.net/Articles/793585/
> [6] https://nvmexpress.org/new-nvmetm-specification-defines-zoned-
> namespaces-zns-as-go-to-industry-technology/
> [7] https://github.com/sbates130272/linux-p2pmem
> [8] https://kernel.dk/io_uring.pdf
>
>

Mail server is dropping emails from the mailing list, adding personal
email address.



_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
