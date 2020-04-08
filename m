Return-Path: <SRS0=zNed=5Y=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1272FC2D0EA
	for <linux-nvme@archiver.kernel.org>; Wed,  8 Apr 2020 15:13:11 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9FE002076D
	for <linux-nvme@archiver.kernel.org>; Wed,  8 Apr 2020 15:13:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="s6BAp82n";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="F1sHDgPI";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="ViPaR05T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FE002076D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date
	:Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=4s/Jkpi2MoRF3oPdfW2cpG0PEyiHp6ighSldsa7qcP0=; b=s6BAp82nFRRzBT
	BpooIgCYgJ/ULzUQBv+kSJY62WcspELcrfKaOxWuVJjya/1P3B3bzHjZ6wz5zq32aPaidBD5IdEz5
	irrMCASTKjLbE6smfvdyB2K5F4SrnrM66tdAY+3fQuw4+3KcwIHKAlsAHG20MUJ8vxN3sxRRQ83oY
	QnQzdrTPWJYBbaa9mCD0VxAKyoQ5IV7zcWdUPP8CL/DxrPswuK2l63uCsBhl586CbHwusDIATh9v4
	qgKm+8yjNg6ZgUiF40wxXN13XxzuJk+1EnJwwv0NuFfvPSxoZH2P/vSm/dkYk18trL95905VP1UjI
	MF36S5iPV2wAVPUh9HQQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jMCO2-0005ho-4S; Wed, 08 Apr 2020 15:13:06 +0000
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jMCNy-0005YF-U4
 for linux-nvme@lists.infradead.org; Wed, 08 Apr 2020 15:13:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1586358783; x=1617894783;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=/bFYSauDS1Z25Yz7+a9rcHs5FXSLPDZAT4qLRusOKVA=;
 b=F1sHDgPIRtYFF6kcIquTyeVbgvXiUqd1nDE6eLz4NYsuRgqbzZf2NYu7
 UNyiWoZ4qjXtTveLKyVwV1pipmtVloJzawdnAo3mLIjd/wFw2U6LfSCVR
 5s69dyBbnv+ORE1z9WZ5R0iNWcPdq0qZ4Fyal2lPpuN4HuDxEgPUk9LV/
 PNcSoAiLmu+HqaO6Drw47sCnncHV4A1MlJ0FlLM/BzhiW/B0EItNTxg9m
 Cz1ceKv4cEnelKQTkwM5r7mv1/Imqm+1rOdtaYxNJx1GarGvVk7LILoNj
 qI+qtCcItBO0n512fZxYiAt4YU948xoUlUItsn+sa2Lk1dkVXwvfpnFEk g==;
IronPort-SDR: g2f1g93nX3fzv636QI9lhpXEQ/oSaI0vTCtGW/uwyLlr2xLhP/oaditt4cdqQ3NOitY8zx+dUh
 21uaZ7LqZAgynu+4G1kKeWt0DmvJr79a2ZlkTsP+LubgJPUkJfDfnXJJ1hdT10W+mtwK1ASGYH
 TLqBpzsGCmAUBepDZgd+s3Hyn+WdTZrtF1YlES5M2/HJZgsh1f8mHeOFiOy8ko1inKNYpxiU2b
 3tcsFdL/2uylVh4YVzSlkLCq7Qj5ZqH7E579jij2TjZjRhv5l5lwCVbmgSNqLIsrrcbV6JOel0
 PsM=
X-IronPort-AV: E=Sophos;i="5.72,359,1580745600"; d="scan'208";a="136328045"
Received: from mail-bn8nam12lp2173.outbound.protection.outlook.com (HELO
 NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.173])
 by ob1.hgst.iphmx.com with ESMTP; 08 Apr 2020 23:12:47 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bHcSlQ5JU3bjb6CGCnFcsmgN+RJ84WwGFiOHukOhs62IZmo3KKLh2J+u7NCYnsZNSIdAp3kUj/uL3HxjrDcd4m+bVhHd70OQ0uNHBnfxj4S3cYvusV/zDPQmrTMiADOZ21zIUyOOD1PTnQh885nH8XpbI4ulzAqhyreZud9V5uhUjTqrqpdzOVsX0iAyGsqmiKE2IuiwmCKYHKjRzqQBRdIy9/s1mE2yavACj+cG9oRG6sBBg4edfGb7n7mwnLXDGIqZTJ/3gRkes8gSDLwjlPtFX3RNRKqdDLu6h+a//SQU6mOucQvdk9eZiL27PiFGDdsks1Ygb1s6YldoOva2/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/bFYSauDS1Z25Yz7+a9rcHs5FXSLPDZAT4qLRusOKVA=;
 b=OW4abK3oUZKI317fUhrbh8CwH+PkBitf6W538XiYmp8VGl0uZW2Nmg1dD+uGXdQYDpzDekoxyzSu6t43uVTutqyQccpD4jIW+BXTEKEtt4Am1vfAeKuot4rrq9P/d1wB94qExWqRPN5lYvw6tki/9FuypVqBlNGdoY4tESf9jqrOKgX7uRK6NYFG8e148axkx6aGF1Ck6eZemF4FwBE3KW+hQqGWNXFMKuEL/I9dmsJV/9NwOgJ6rTyGUJ1uTTFzPqyP/RQVqJ6EU8tPFSGQuOWPUWIQnJsPRZterkxxrftRqQ+1XBVVzSyrronv53cBxVneIfEndZG6IcC64EQJRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/bFYSauDS1Z25Yz7+a9rcHs5FXSLPDZAT4qLRusOKVA=;
 b=ViPaR05TEtyrYFn4dTXfhRWJ3KbhNNCnEW9evWC44Wffx/IATt1C0TxZO1AKYIUArZuc7Ndqp+z0ygNav7ze+SGtB7TzfadDE0YHDRYvgdj3lBuGn0OesGb0o83UQ4ugf0YIlfPIhTW6UrCxDQyitW/9d90YukPCaCjq+NHDEss=
Received: from SN6PR04MB4973.namprd04.prod.outlook.com (2603:10b6:805:91::30)
 by SN6PR04MB4701.namprd04.prod.outlook.com (2603:10b6:805:a3::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.15; Wed, 8 Apr
 2020 15:12:46 +0000
Received: from SN6PR04MB4973.namprd04.prod.outlook.com
 ([fe80::b0f4:a811:73dd:6c4e]) by SN6PR04MB4973.namprd04.prod.outlook.com
 ([fe80::b0f4:a811:73dd:6c4e%5]) with mapi id 15.20.2878.018; Wed, 8 Apr 2020
 15:12:45 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Sagi Grimberg <sagi@grimberg.me>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>, "hch@lst.de" <hch@lst.de>
Subject: Re: [PATCH V2 2/2] nvmet: add per ns thread to generate AEN
Thread-Topic: [PATCH V2 2/2] nvmet: add per ns thread to generate AEN
Thread-Index: AQHWDVyGx1h1rDwyCECcI/Bh3Diljg==
Date: Wed, 8 Apr 2020 15:12:45 +0000
Message-ID: <SN6PR04MB4973EEEE55016BAB488C180A86C00@SN6PR04MB4973.namprd04.prod.outlook.com>
References: <20200408041633.20632-1-chaitanya.kulkarni@wdc.com>
 <20200408041633.20632-3-chaitanya.kulkarni@wdc.com>
 <5e54afaa-7de5-a89e-5740-88df15c52bba@grimberg.me>
 <SN6PR04MB4973BC935AE3BFD4CE874D9B86C00@SN6PR04MB4973.namprd04.prod.outlook.com>
 <f3f226be-0bda-5d5d-69b3-a0f3478ce51e@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c2719f0b-090c-40bb-f148-08d7dbcf4b04
x-ms-traffictypediagnostic: SN6PR04MB4701:
x-microsoft-antispam-prvs: <SN6PR04MB4701003005A1BCC2824DE7DF86C00@SN6PR04MB4701.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0367A50BB1
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR04MB4973.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10019020)(4636009)(39860400002)(346002)(136003)(396003)(366004)(376002)(71200400001)(186003)(5660300002)(91956017)(4326008)(33656002)(55016002)(66946007)(8936002)(8676002)(81166007)(9686003)(316002)(76116006)(478600001)(52536014)(66476007)(2906002)(64756008)(66556008)(81156014)(53546011)(86362001)(7696005)(66446008)(6506007)(110136005)(26005);
 DIR:OUT; SFP:1102; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rQeE06y0ub7CKrCdutcI+wawZ9D8zVeuYCNzH+o3r8uKQyS4U8/Ra/vLxcIF52t9/OnbiUUYzPP4eg+swBAxnNw+PdbGQ52cB3gRHF9/sq98lH4iqtayr69HHjQFh6Xx3CchFr3Ciy1+w4W2QWEHtUX8lf80J6ls1JuJng0JVHeguKdaJCjICg/yF+PYmYH+z3QkZTlviCZ+YA1Rr2J6PCcEbWIiGhiB+iAHlLYkmoWNH0zBjI+uierUmmjNpKwTf0gfjyk8NHzsaaWgBXTLnrn24NyKuIU6TjD38OlPfTQSiNhXlgo7TPqLMzfysHlGrp5JTRi/iAmVEvUfrLicELblrvMSTBXj/SBEsGSjUYsFU8XFOdtozVpiRfiHkGIT86wBro733oCVqrJs5Oq6LUbOdn1uoW56E7FolPhL3aRBRQC9MrhE8JN6Ob+lTv5D
x-ms-exchange-antispam-messagedata: LyTD7voqUy+RpmhTqwmuwvURwQgnJxxdMNRRCVt2Kn5VzcuP9uZWoM3RyADc+LQffwRWyp6Xe59pB0XYhaYyjK9UjnuJ4yWvU0WF2w6s1EcHZ/qEBH5Ku1yd/BXWIFYcxsoEGWTtnPw1rbfjg00TRQ==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2719f0b-090c-40bb-f148-08d7dbcf4b04
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2020 15:12:45.7394 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EorQU9MpIyd7SN7Lt/Zsi6n13vaP8Jj5hTkMqVibaZr9JagkFw8xye7glvqATf9a7nabEpj3wu5QJO6Ayix/gddniQOKfzmsyNjrot7EI7o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB4701
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200408_081303_143537_3A7FF479 
X-CRM114-Status: GOOD (  14.85  )
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
Cc: "ailiop@suse.com" <ailiop@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 04/07/2020 10:55 PM, Sagi Grimberg wrote:
>
>>> On 4/7/20 9:16 PM, Chaitanya Kulkarni wrote:
>>>> The change of size detection on the target should generate the AEN to
>>>> the host. Right now there is no mechanism that allows us to add
>>>> callbacks for the block and file backend so that we will get the
>>>> notification for change of the size for block device and file backend.
>>>> This patch adds a simple per namespace thread that checks for the size
>>>> change and generates AEN when needed.
>>> kthread? per ns?! I really don't think this is the way to go Chaitanya..
>>
>> I hacked it up quickly, may be we can use a global kthread which does period
>>
>> susbsys and ns scan, but AEN needs to be issued to the host either way.
>
> Seems like such an overkill to dedicate a full kthread for this...
>
> But maybe it won't be such a strange thing to dedicate a maintenance
> thread that would do stuff like this. My main issue with his is that it
> is polling which to me seems like a band-aid really...

It is, but having a lightweight maintenance thread is very simple way
to implement this for bdev and file without involving userspace or fancy
hacks.

What are your concerns about polling (as in sleep() and schedule()
calls wrt to the code)? Can you please elaborate ?

>
>>> I'd suggest to expose a revalidate configfs attribute and have nvmetcli
>>> install a udev rule that triggers a write to this attribute. Balbir
>>> already got the udev notification for disk resize (see
>>> set_capacity_revalidate_and_notify).
>>
>> Okay we can do that. So you are saying generate the AEN from configs
>> attribute.
>
> Yes.. that won't work for file backed namespaces though...
>

Isn't that defeats the purpose of having a file backend which provides
more flexibility to the user ?

I think we should at least try an implementation which has global
maintenance thread, measure the impact and then discard it before going
to userspace.

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
