Return-Path: <SRS0=SY4p=CG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01923C433E2
	for <linux-nvme@archiver.kernel.org>; Fri, 28 Aug 2020 04:56:55 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C542720848
	for <linux-nvme@archiver.kernel.org>; Fri, 28 Aug 2020 04:56:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="d9W50UTl";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="YT9xQKCC";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="zUlkmHin"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C542720848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=/xmqNAWWgcxjwNfWrphaBRB+OPiGUmz3MeRDjJzS3AE=; b=d9W50UTlV83RZLwKWM0+GwHxX
	rP+d6eDmSP8ZJLAwhtwEYPlczHfbX6e21f6OTBxlH0Vv5jPIuTQj2jk5zBrAnt5O7cimd8Co6NW64
	zWc5C8Epyi0XgppyvfO+nQzJOaolzHIeE9fK20XSXODZU5NN/tWH01StnQZ3nrZYacjYqsYDWMaPh
	5lNvfKEbYhiK1K7cDCrfks2FiCETuNJGjIrfQAhAeIRQfPfVnRK68kK1ShJIF0HPPvPAVLcGbiAJ5
	aYUOSsr9gA9nuE/w4UjGCnjH4VV8/YthMI6EA6zm/YCdLk5KjfxC8RivFU8OmdvO+U4M0FHFswKV5
	wcL9uo6LA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kBWRV-0001b0-IP; Fri, 28 Aug 2020 04:56:49 +0000
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kBWRQ-0001aE-Ng
 for linux-nvme@lists.infradead.org; Fri, 28 Aug 2020 04:56:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1598590605; x=1630126605;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=sk+poE7a1FWMlHSlEyKpf/j4DiwgAb2XFjDDd441Qnc=;
 b=YT9xQKCChbe9a447G2k3nPZSQsgOdWka3uRH/DP5AWlwGtNV72JNqhT1
 QXfgT0edATogILFUt0OneVjXipBLOCBj32LuMySb829T1s0vS1Csox7o/
 V422RK46Wrk0C5Jbj9qq/U+WoJqM7IMmZgv7+VpTjFPBie2dO4A/wEvC0
 rHpdIkfAnUC3whoNdfrLfzqd5RdCHUefa7WTZYn3oZ9i+AUqFU7yL+uuM
 bWPYkSdcBjB5yPr6SZebGKfOrV9XYYIojxJ7RuGFUfHNY0KqkWB8lUEln
 B2dyW4VjHbfDcfDnTuu5Sod3bPg3THwpR5XZwWZlitmZQnNo+DlTiAVtL w==;
IronPort-SDR: RMZFVTiG3OAMuu9GHLZtXSVfmUymgh5WWAFpHwxqV4et6knXy0yjw3HXHe4slrQhfkSZHs+guz
 UbT2sX3K+9ucyXwvBpYREbFgTKrambp8qYNHMSllDyNXo6KCa/EGmOqWNnbmiVuCfa0Fpx8ZNY
 ZkZN9m7pbnIs8DuIrcLMjvsYlQaIfqWAfhJ9vLrVk/CKJrxte0vqDkNAPf2X+ndnksCaLbe0bV
 d03SvfrCTzjnu9EiPLCoCnK/iBfHMTvfxnrH7LyDS2J1KJfkiZt1/bGJOUEkrabGdfyVI0GRub
 lNg=
X-IronPort-AV: E=Sophos;i="5.76,362,1592841600"; d="scan'208";a="150365721"
Received: from mail-mw2nam10lp2101.outbound.protection.outlook.com (HELO
 NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.101])
 by ob1.hgst.iphmx.com with ESMTP; 28 Aug 2020 12:56:43 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X9dG8fmoRj0WvL+OYOIdQ4IVGAk3t3eoM0rbszbyXF0qW/B12+2vzqrNLhjXiQz5iFXLDBe5xDZrDF+SPyE1qi7Bi6jA3WlmUd8VKNBHAmZDO59RiFO1MZVN2vf4b9KqnRLKKrOHetQ9tEsZpwrj//yJ3ecbAyGbSkp5bA9oVdTsICWISGpfYzMV8NlELGbi3MCVI7wa5Ve31THKdu+Kp6ZVcGksIl4L3wf50JtAVPCrEdzRYtk9KL1UvpqsGeqX1UmNz7/KqkuTi5BxuNJPIMCldGXOXhLUpYCpEtyOs+39g1f10dI3iJe9HGCsZqe9zWKfQ58RoehI01yxmQux2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GWwvluiDAhf4PwgJ7YcpMcEo6lztIAh47S1onbQ7Jv4=;
 b=lTcuEZWnOQzDvxnZSvhiBIGyHTuv+KvFyfrLrdaI72inrT9vB9RxCXYnCtuPzr0rpU/EKwgb9abDehCStFwCpShYgHRcrVanfWK5we84svfyUW5EiYejD1Zy6Jlg6HzBidZFKcw1oVxwirRHTr6O136ZBObWgJFyCp+gWal8uLBRqn7COZ4T28YIr+ntvbkV5aCKIEEyQaFQfXd4p6WdWR0dAy8P5yfxMNMZ2l4U0PxjLdiUugkAQAU2F9tcb/Mq/lPfxosmbCWTjF5/BkEtiQBAq+K5z/PkSY5bv+hBmMG8qJi0myRn2gzduObafQXpUfV8J1j1gsvxMOMs7BYpxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GWwvluiDAhf4PwgJ7YcpMcEo6lztIAh47S1onbQ7Jv4=;
 b=zUlkmHinugkglzPMlYWLOaDYS/WO5PzFkqow6CLwo+SPrU4dGF+9LuTDGfmXmXScFNEZVrFuq/qhsGKv7yJevh9yYrYC3eGG2Bo3h47ekIpP6j87XShMpkFlCWQG+oqWdG7jJuNwTf8L9vEgHq60rRPnD2b+SjRmfvusFzhe7yU=
Received: from CY4PR04MB3751.namprd04.prod.outlook.com (2603:10b6:903:ec::14)
 by CY4PR04MB0727.namprd04.prod.outlook.com (2603:10b6:903:e5::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.26; Fri, 28 Aug
 2020 04:56:41 +0000
Received: from CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::7d15:9936:4b3b:f8a2]) by CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::7d15:9936:4b3b:f8a2%12]) with mapi id 15.20.3305.032; Fri, 28 Aug
 2020 04:56:41 +0000
From: Damien Le Moal <Damien.LeMoal@wdc.com>
To: Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv2] nvme: only use power of two io boundaries
Thread-Topic: [PATCHv2] nvme: only use power of two io boundaries
Thread-Index: AQHWfIew8sPeVGuOyUGnBvqGhC5QdQ==
Date: Fri, 28 Aug 2020 04:56:40 +0000
Message-ID: <CY4PR04MB37517BF8B9B4F20B77CD579CE7520@CY4PR04MB3751.namprd04.prod.outlook.com>
References: <20200827152824.2784396-1-kbusch@kernel.org>
 <CY4PR04MB375186A80BD4AA911119C13DE7520@CY4PR04MB3751.namprd04.prod.outlook.com>
 <20200828041645.GB2784469@dhcp-10-100-145-180.wdl.wdc.com>
 <CY4PR04MB3751CF0BBED62F4EF6BF36FFE7520@CY4PR04MB3751.namprd04.prod.outlook.com>
 <20200828044435.GA2825639@dhcp-10-100-145-180.wdl.wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:1cf:fa0c:32f2:7362]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 85604c84-f752-46e0-2bee-08d84b0ec0e3
x-ms-traffictypediagnostic: CY4PR04MB0727:
x-microsoft-antispam-prvs: <CY4PR04MB07273ED3A6153FF187D35011E7520@CY4PR04MB0727.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:66;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0wYqmEzv15ZVvSPBreTroTMrBetNQoXSrIHY6yQ4td4IGuhV9erO7PLaepwGmrawEOABEyJzSBFbblcAcoePdmm/DSJ0yvJj2GxTxFQRcw3uKOf/3VYR4a+5JAS4/eqAKGCVCqt7qFffYJwwiUUZKlyPeD8vjhf9shMgUXwGvn0OjWPpOrkx0GSDQ5GrT4ltIz6CT/rQzF+Hmfl4sPuO5wz0FtwmbU30ktrw2tRwKdOlRa75T66iJ9+dqYAZKXbbqZkvLowLym27J7vMJbjvvjci+p7OAkfmOzpON35K4Gc2turEgeXLrf1/H5Xx6P0x
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR04MB3751.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(396003)(136003)(366004)(346002)(376002)(33656002)(66476007)(66946007)(91956017)(66556008)(76116006)(66446008)(64756008)(83380400001)(53546011)(7696005)(6506007)(478600001)(186003)(2906002)(54906003)(8676002)(6916009)(86362001)(8936002)(55016002)(5660300002)(9686003)(316002)(52536014)(4326008)(71200400001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: DpxAKSuzLYRbZc9NJZMtW7exxiSSMI0ABez62zBU+R0jlHdsasVFxn5UaZ9ZnIAJWg1PlyCzKbuTbkxqIxZArgaXgbdK9td/fyIG5oE7pj2pp8fj6EAuXmWO/xR/3C1wC849VDeeYlAK8qf7d6kHPvBUDc0JchiaxxIcoIX0dGQv9ZHNFitl7gvKJxhDqV+EtqIo69G+M2eCMoEEPIoRHlFsH4LrRYNIsGbA+0pueIU3LHIY9i1EYaarIO2EcFC+oOJgsE5yO3Gf5S0fUJ4mGs3tjHqd4/beuhyPO0aIcTXLfr5KP033f7qKg0yYlGi1GZ7mOJBhaCPCkTDun0vr+WcJPalwsNjLt6+ZFA9mq5VD+sHI3UAZh6oiPtd7iqJ+nmGImqA6uV300abDR14kJ7JPj6XsrwpVYfMu13wNq+UysD+FOjX/zLjadS1K4ZmZIR0RxvOLeG5EcQHHUmFK6mR4mQD39M54b+FQg/M5bC9+n1c9d06+iMUyWiJEQuarJJcdHUhsb1LGzBMZCPqU4BO2x7Xbr0MMAjD/8lXxcfWCuT1XzysZ/DCeYwmlUBDYo3bp9D+7m6YqQX4i5cfy3KhzSXlSItBBH7uryKFIup3HDTZDt78SEd60iUXq9KU++niudyCO7JrKNocFxmkKi3VNpalaj0/i/VLVp04irAWqSUlanGctsqS/mPrUciqV4Y1A1iUHrrwDYw7I11p7Dw==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR04MB3751.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85604c84-f752-46e0-2bee-08d84b0ec0e3
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2020 04:56:40.9714 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: I9g2ZO4xFdFYIvi8ZyWgJ5x9gV4ScdTbJ+g5bHIxMrH8ncTgwrbj7Y17tNVHr2JIntBoiqB6rUZO5XowPNm4JQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR04MB0727
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200828_005645_069764_69B09E5B 
X-CRM114-Status: GOOD (  13.66  )
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
Cc: "sagi@grimberg.me" <sagi@grimberg.me>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "hch@lst.de" <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 2020/08/28 13:44, Keith Busch wrote:
> On Fri, Aug 28, 2020 at 04:30:02AM +0000, Damien Le Moal wrote:
>> On 2020/08/28 13:16, Keith Busch wrote:
>>> As long as zone sizes reuse the queue's chunk_sectors, the zone size
>>> needs to take precedence since it's more than just a hint compared to
>>> NOIOB. If people complain about the warning, that may indicate we ought
>>> to find a way to get around overloading the chunk_sectors queue limit,
>>> but I suspect ZNS drives won't report an iob value.
>>
>> Understood. But for ZNS, since the zone size would take precedence over iob for
>> chunk sectors, wouldn't it make sense to have the entire code block under a
>> if (!blk_queue_is_zoned(ns->queue)) ? Something like this:
>>
>> 	if (!blk_queue_is_zoned(ns->queue)) {
>> 		if (is_power_of_2(iob))
>> 			blk_queue_chunk_sectors(ns->queue, iob);
>> 		else if (iob && !(disk->flags & GENHD_FL_UP))
>> 			dev_warn(ctrl->device,
>> 				"namespace:%u has unused io boundary:%u\n",
>> 				ns->head->ns_id, iob);
>> 	}
> 
> Oh, I see. I think we should have the warning for ZNS too, though, just
> to get an indication that devices really want this kind of
> consideration.

I see. The use of chunk_sectors for both the zone size and iob renders iob
impossible to satisfy. So indeed it makes sense to get the warning. Thanks !

-- 
Damien Le Moal
Western Digital Research

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
