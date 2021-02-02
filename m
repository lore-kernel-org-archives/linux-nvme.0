Return-Path: <SRS0=QQ4x=HE=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26BB8C433E0
	for <linux-nvme@archiver.kernel.org>; Tue,  2 Feb 2021 15:06:41 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D11F064F63
	for <linux-nvme@archiver.kernel.org>; Tue,  2 Feb 2021 15:06:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D11F064F63
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:Message-ID:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=0IK2egVepqpzn5+z4NXe+kt9bA/wIJa8W1rRl5qjxFY=; b=Z/28jah0Uvx+Ti5kZ0i3A8Wm3
	T9mNEgIqnXqbZ7NqtKIZ1eRKWoWkEdE+8xiYK8ohaUgH3kB1NLG7ghadj58jqw+3P94H45TpbfLIf
	SieeHqR6UEfysrT3derIhCd5wNBlb7tRAoTYGeIPJwqs18aWHQp4U/KwzfC5js5Bcj6vJesOKEK9M
	g66lE5mkhcx5M657ZdZxVblOqcocXyEtMnYiZGCA3nLSMCVOba7SUlRCRP8naf0DGQf04rWCHjnvp
	t69YB0iiwXxFP9zQ8dWFvmmv96GDrQnX9oTdPGRHcE1mSGFJh6q+PYvykT/UUo69UJz29YnBIZLOX
	NsUS5hxYw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l6xGA-0005rV-MU; Tue, 02 Feb 2021 15:06:30 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l6xG7-0005qP-Og
 for linux-nvme@lists.infradead.org; Tue, 02 Feb 2021 15:06:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1612278818; x=1643814818;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=4UmiueRnvFztE4tkBaKHKizIQ8YSV3zuXkQHa0Ks2sU=;
 b=JfHYVRNtN4SCUOq884oVgAgWWz0SlRltOi4ihTDaUymYxFPKkk/f4V/K
 30yrskkQrQMpGFXCjcTxxcvKnzRgyJ1cKxAIz/eyA+rHisRmz8oFzEKeD
 WDQvI7K9ovg4u2sD+1TMVRUxgYLWi/vh0EIvR378A3Ln8RfOsVpU+DlxB
 3XjEfrU02cU6YQ3JLBJIbEsqc27qyNGH0WEr5zGMXi2S/kLsbgDXPRZgI
 Q6rKR3pbuKW1qT1Ip8vkGthQPrlWBnvhGwpGslVEmLIoRKJW9o1UwYN5M
 3/eWSkufilB9GLNuPbP7ykksmH1BRqLvDqS257+N8Bg3VIqouiQV48A7w A==;
IronPort-SDR: 5/83WMYAdq/mKBsrwqv0+EIpBnuhDZhibCRuuImr9xYkfFnqsdbkal5d15CvbhYbVez3YRBh4n
 epXAEUoR2KfJtMRDGzMZq2nKlCiff7q8aX7VbrEPffcr+ZoKChOHBSUfpStdPH5OhRi76ofN9d
 KQVPkFFEGKhEuqyDoq9fE38AlVGAbx4ceBdZhe3tihE9RHPHg5pRBWYFOZ74tVY3DhGBNgeqpW
 b201hTzhiSurQ8K9XyXw+S+YryCXn7Hy2dG6CCF9wOKW0TdUEQNexYV9u/BgHkC7UCUAbQRyK2
 jSU=
X-IronPort-AV: E=Sophos;i="5.79,395,1602518400"; d="scan'208";a="263008801"
Received: from mail-dm6nam10lp2108.outbound.protection.outlook.com (HELO
 NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.108])
 by ob1.hgst.iphmx.com with ESMTP; 02 Feb 2021 23:13:33 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a80h8iyso8vgkXVQU3fxx9vVULQZmeExvWbMQ46CeWPr8K77RnDLFYF5Xbq61Y5TXtK/JOwHdUrC/GnSC05QZQEUXKvvlmUz1jYeAKZVjmh4be2Qfy7eyF+sJDa5Iphq5XzGdpJslsbpGUrBJophvSBtJruNncxz0uJmvDYGJqNDJmqa23B5MqDEg3NpKHmLf9szC+CXaNuB2aJxrt8n6VKuaJ3w0L+EL2woD9IVCU1pX8DVovhMuunlycp8jfyPvl1w70Du6YywLoU3bWLwcMlfSF/z2xWNZionmz+b4T4T2EC01qoe3Qn4JpBNEPMTBWqzRvktTXEmCt4TbFsSWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BeCkoiWiJeKDZGlnCw1tpVNIiEsUlRVuuvk4KIjYICM=;
 b=GilnS95lJp4+W387w8EIvm2jSa4rCeFrTFLWerSwlQF1qaI1JTqg51nASCzFkpAUxjTQXkOW3LK3GYw5nSlILvAEdTGm9PCYpjHy2+6xWBOquLbaeE1ylYs/oCrlthR06u5/Y9sIxrzDhxPY8jmDOG9UIGgePXSNuBApgo1vYK1PrnTT3++FtHoBGOYn6qFZCL5G7HG+xqjxNO8tCJe+h+tdUDy07ExxqEVLqdj1bTB5mn8z6AoK/PjW1lIoSDkycZx+uf0S5auEmaC3IvOcnIM+GO5EVWQuw28WDMatvE9ibQ7FsXNOaX8WJxO/sLSWDE/lmX2pi6+EYsCypjaw9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BeCkoiWiJeKDZGlnCw1tpVNIiEsUlRVuuvk4KIjYICM=;
 b=OMWn5LQVq7gBoRve/QhWHnpsPjJI0c41c4in6YJwi+X717vnmKOGRXEvpTGd/aydKNvld9waMdopIM0E7MMURIjRfwpXG+i2kN/qKVzXrHGhXQN49a4J7F2LrU0yeAFe33WT6/zA5XJioOkUlXIGtqgCcCf8tDXW+oSV5VanVww=
Received: from BYAPR04MB5656.namprd04.prod.outlook.com (2603:10b6:a03:10b::31)
 by BYAPR04MB5061.namprd04.prod.outlook.com (2603:10b6:a03:52::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.17; Tue, 2 Feb
 2021 15:06:23 +0000
Received: from BYAPR04MB5656.namprd04.prod.outlook.com
 ([fe80::e0b3:5bbf:9ef1:ca21]) by BYAPR04MB5656.namprd04.prod.outlook.com
 ([fe80::e0b3:5bbf:9ef1:ca21%3]) with mapi id 15.20.3805.028; Tue, 2 Feb 2021
 15:06:23 +0000
From: Jeffrey Lien <Jeff.Lien@wdc.com>
To: Damien Le Moal <Damien.LeMoal@wdc.com>, "hch@lst.de" <hch@lst.de>, Keith
 Busch <kbusch@kernel.org>
Subject: RE: Buffer I/O Errors from Zoned NVME devices
Thread-Topic: Buffer I/O Errors from Zoned NVME devices
Thread-Index: Adb4pjHrgmuLFbHxQCmk7MJnaI/frQAzcSCg
Date: Tue, 2 Feb 2021 15:06:22 +0000
Message-ID: <BYAPR04MB5656F20169A935B9100ADC1DEAB59@BYAPR04MB5656.namprd04.prod.outlook.com>
References: <BYAPR04MB56561E48A54530BC7F6DCF30EAB69@BYAPR04MB5656.namprd04.prod.outlook.com>
 <20210201175306.GA2127465@dhcp-10-100-145-180.wdc.com>
 <20210201180257.GA14971@lst.de>
 <BL0PR04MB65142D8FBF2B6BC88E32DCCEE7B69@BL0PR04MB6514.namprd04.prod.outlook.com>
In-Reply-To: <BL0PR04MB65142D8FBF2B6BC88E32DCCEE7B69@BL0PR04MB6514.namprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.48.94.121]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2dd09f9c-c937-4838-51f5-08d8c78c1ac6
x-ms-traffictypediagnostic: BYAPR04MB5061:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR04MB506115C1E936E69E9A17AFCDEAB59@BYAPR04MB5061.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dpNWrwAwSmY6166J4pyo2fLxLPHLVJtgI3lK0NnRGLMaN6BKZT/60p52ic/Bcss4tTt43tVyli9lkKavGEEWi/S/yqEcIwPA5MvSkEUJF6HzpKAfZ2ZTgNBjLdpUcoeANYMDF+7lsPUj/CXwqe2ETBrOi2ymuAp84Eex4uW4egVKgK1vvdShZI2wxErVkGXDCn5Ql0/mf7OBE+NdqEGeXmDkSeagvuoYnBu7CiDtWjohuTGX6idTNRcmFlSDUZNG2Zu0U4gxe2+vnYrEIDyrejqHLYweeJAB0sD82t/In8qQhokfUJoFwga+DMS0TtYi/ZCmavuF/igsz8ZI2MTd3aFEGPXhqklOHVL9k9NZvNLyfXpehRCPAYUJImSc0P7AAU5W6kttR0+TjZjEU13OvrQlyn3gdpdU/gkXwEZE7cEkj5To53et4lDlhYp4lo/mIo02QNoiVJqlvvU7OM3mU1uo9NeZV/meiI7s8HgZ/RrQQn5Qw7952d7p1FPuEOg/YYasnfKMpeoYBqP1SL9Mzw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB5656.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(366004)(136003)(376002)(39860400002)(396003)(66556008)(9686003)(55016002)(478600001)(64756008)(66476007)(66446008)(2906002)(33656002)(8936002)(86362001)(5660300002)(4326008)(316002)(76116006)(52536014)(6506007)(83380400001)(7696005)(186003)(26005)(110136005)(71200400001)(66946007)(53546011)(8676002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?i8VqzC6JyFVmbea5TzbuQOOQzl0jg9wR9Y9DCeXawxqjZCKAMBH3Q8CKCw0e?=
 =?us-ascii?Q?OiNIWDIM2FqUwdPbGwmd+nwMAN2Rv/gB7Cu6CLueiDqJIKvUtGzYTuZTQ7Uo?=
 =?us-ascii?Q?66YSJpOLp9YhGPUD7BZzqLZ0oREfcygLCw3GIDMLa2Mzd5CxkatHAhybXrQs?=
 =?us-ascii?Q?X1Zo4QgPc3xCbkrwMfr3lpMcE6kCba28GCurHPABKrYK0XW8a6q0LwVX+7Db?=
 =?us-ascii?Q?WH7B2IWqqKYABWNoRHGAta2s5okXSYLJWlF0FAbsJozZKguclCKBvEShTC92?=
 =?us-ascii?Q?+8p3Y/8x/DxXBGnN9jDFixvB6nJ5ORQNCFcHBbl+Zt3jZMPww8OsahgiC1+o?=
 =?us-ascii?Q?gRkpRZ/+ZfJNwv8gqAeOZ1GonVR7hd6ZEWEWUXbXFrtl4Mi1RLmVYuuLHATz?=
 =?us-ascii?Q?SXv7b98mxRwILLfIPAHvL4TW/icKr293TR6DOd3zWQQiaR7jt4qpC9MrUXtz?=
 =?us-ascii?Q?5IMOVYyzV59TXxyT6eBp8YJRHmas0TPmAvGEyNE3keQkqYyri8iNsywEDWDc?=
 =?us-ascii?Q?LoTWTNvZeXNcJ65wATIYUbHnwElc14K6ZpWnng/eZK9cCuvPcdwZvCC0FO4R?=
 =?us-ascii?Q?1jOelaw3bWj+VDL2pJ5ZH+1f6NFQGzGTInM7282i9UfqRyFoa24ag2OkRyjm?=
 =?us-ascii?Q?c360kle4QQ3uucwVbPjoiykAhSbYuteLdY4OI5GxX2yIaaNE1us+zY5eAueg?=
 =?us-ascii?Q?/hS3ghFNP0Wv3+HtcMYfEOQaH0/4NZr8SS0UhRojP3JAVDjnjDRMybogejYT?=
 =?us-ascii?Q?VMm0E6tBD2pI0Zd9xVk0hT6aVm5rRHAz5ddEywTInbhSbsZkYT+BSGjcQnue?=
 =?us-ascii?Q?QlDJC1sSrHm92NlIp2095xIoauBMhH9UeVR1Sy+9FzL4iwFm77fncsvXVeTE?=
 =?us-ascii?Q?7yyrtNzQ0CaymllHIgDQes0gAWkngn+WQPL/Eo6g6MG7miAoiukpaLTGRpba?=
 =?us-ascii?Q?S1w4I7CPAuuRU7vC7/4KEhg79+nmG9KUgh5T3hnqKRD83VXixsqfKRuHOu8W?=
 =?us-ascii?Q?kvg3W5hQxUSjYBbdFJKAMMxHOtAprEmxx8l5h8yzVukOWyMJ7jql1xtYiqiT?=
 =?us-ascii?Q?L3o8h3WB?=
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB5656.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2dd09f9c-c937-4838-51f5-08d8c78c1ac6
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2021 15:06:23.0209 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jv89UsDAJUGbdNG0jnzWg2ityZaLpvUFMRmosP/Md/cT6PXp6Ym36bb5Pbg2dgYqJ4ZJN85RTtTbXxrjRRgFPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5061
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210202_100628_108845_AB08BD44 
X-CRM114-Status: GOOD (  20.47  )
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
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Keith, Christoph, Damien,
This errors are happening on both the 5.9 and 5.10.7 kernels.  CONFIG_BLK_DEV_ZONED is set to y in the .config file.   

I will try the patch to disable partition scanning that Keith suggested.  I'll also get the latest FW loaded and see if that resolves the issue.  

-----Original Message-----
From: Damien Le Moal <Damien.LeMoal@wdc.com> 
Sent: Monday, February 1, 2021 3:05 PM
To: hch@lst.de; Keith Busch <kbusch@kernel.org>
Cc: Jeffrey Lien <Jeff.Lien@wdc.com>; linux-nvme@lists.infradead.org
Subject: Re: Buffer I/O Errors from Zoned NVME devices

On 2021/02/02 3:03, hch@lst.de wrote:
> On Mon, Feb 01, 2021 at 09:53:06AM -0800, Keith Busch wrote:
>> On Mon, Feb 01, 2021 at 02:36:12PM +0000, Jeffrey Lien wrote:
>>> Christoph, Keith
>>> We're seeing a lot of these Buffer I/O errors with our zoned nvme devices.  One of the FW developers looked into it and had the following explanation:
>>> All these Reads are from the kernel during enumeration and for LBAs that are in last zone's hole hence expected to return boundary error which is getting logged by kernel.
>>>
>>> [65281.936988] Buffer I/O error on dev nvme1n2, logical block 
>>> 3800039296, async page read [65281.937165] blk_update_request: I/O 
>>> error, dev nvme1n2, sector 3800039297 op 0x0:(READ) flags 0x0 
>>> phys_seg 1 prio class 0 [65281.937166] Buffer I/O error on dev 
>>> nvme1n2, logical block 3800039297, async page read [65281.937335] 
>>> blk_update_request: I/O error, dev nvme1n2, sector 3800039298 op 
>>> 0x0:(READ) flags 0x0 phys_seg 1 prio class 0 [65281.937336] Buffer 
>>> I/O error on dev nvme1n2, logical block 3800039298, async page read 
>>> [65281.937498] blk_update_request: I/O error, dev nvme1n2, sector 
>>> 3800039299 op 0x0:(READ) flags 0x0 phys_seg 1 prio class 0
>>>
>>> Are you aware of this issue and if so, do you have any recommendations on how to avoid or resolve?  
>>
>> Is this from the partition scanning? We don't partition zoned 
>> devices, so I think we can skip it. Does the following resolve the issue?
> 
> We already have special zoned device handling in the partitioning code.

Partitions are ignored and warning printed, but the partition table is still being read...

> 
> But NVMe should make sure to never span a zone boundary as we set the 
> chunk size to avoid that.
> 
> What kernel version is this?  Is CONFIG_BLK_DEV_ZONED enabled?

I had a very similar problem doing zonefs tests on Matias machine on a ZNS drive last week. The problem was the firmware... An upgrade to the latest version fixed the issue. Not sure what FW rev you are running here, but upgrading might solve this.

> 


--
Damien Le Moal
Western Digital Research

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
