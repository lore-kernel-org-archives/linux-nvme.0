Return-Path: <SRS0=Qo8g=CQ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 231A9C2BB84
	for <linux-nvme@archiver.kernel.org>; Mon,  7 Sep 2020 08:22:28 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B7D33208C7
	for <linux-nvme@archiver.kernel.org>; Mon,  7 Sep 2020 08:22:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="sQZsufzX";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Cm5QLrzz";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="CSMiCPpp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7D33208C7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=cy+D0QlGqEtd0znazHz8r2GWP9W245ZHewRGCZ0B0Gg=; b=sQZsufzXUpksxm1cuhlUFvLhA
	B0WFWd2qFcucIZOrJXDsaxk2b3vWU9+4maOehfKZXVrJUrzfTsogMpAI6xfPvF1FcuHts+kvIDacR
	i02MM4vQ/OwXGKsFOP9AMeqKJw1EoNhqHeG5/p8/tmoeMEd6/CTHqQ4IIgad0vWWi/+waHUexoCUO
	0T9vQ8J4LLgJx1tcLtDDhaoqBYnGZdK9GByZNt6m013iBo9GXi06buizOFntgtZcMgxYxM9TtXVvs
	bmuCkKgthG/jdGkNo5pItjBNeWbi26megac5lPP9zsAHBW/Mx5ARcEGi/M4EHvM/GB4Qh0je6JJGW
	6syHSgifA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kFCPu-0001fe-S0; Mon, 07 Sep 2020 08:22:22 +0000
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kFCPq-0001fC-Kq
 for linux-nvme@lists.infradead.org; Mon, 07 Sep 2020 08:22:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1599466938; x=1631002938;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=KF+76oE0BXMlvu+NlKuicfRFSQRPlUn13isTCPzIJuY=;
 b=Cm5QLrzzu8gJ+7itG9egMvsHENPW1YMDj4TkVF007YA6b2OJZFp9bc6a
 ZeR3IJ914lI9KlgYLSUSV9EKWChJvCp40O89OeVfbWknz3m1Ph6BSrCbW
 2Nyrw2SHDFg1xVHAAcvrVIpOVBvHxfwQnCfxZhTUri2H2BalQqLr0wxLJ
 zNGUEz4B82n118JMDPYKJqiV4QOa0SF2iUIhCF1dblaAlsV+Q0Z0Me8Z3
 R95slDLqKjXJw6UQ36Ocq8zgIQEONL69ZeQ0QBTYYRrgmdZxJBe91GX9B
 5OTF5gcnAdJvVLO+++yOAfWlB+cJdV46rAbOGirhpoWicV5+dK9/N2dzE Q==;
IronPort-SDR: zEPeSi3ORBoaH8TP8eDeWs1O0z/CkADapZSKD368kvjKjD199l3R/w0Sdnin62x9p2LTd4utJe
 PJ6lCOuMlTuifW7GEaNdER2MDBOab6VCL/pqzOKSQgO44NU30/OIah6xY0DZ+b8+Cu7lUk+EIa
 PkhJLGj9r1b3T4KYCStwMO4PJVrtmrwmEk8B7QFNydhD7/c+wZ4TWajQSB+7B6Mfc9faPBjga8
 PUu3Y/AQTC9/Rpggbi5CIV7WoM97lfRGeFJnfNlOTo2jrvtTm0HV3/QKREm50TwmW1H2XH/oCk
 qCw=
X-IronPort-AV: E=Sophos;i="5.76,401,1592841600"; d="scan'208";a="147948021"
Received: from mail-cys01nam02lp2055.outbound.protection.outlook.com (HELO
 NAM02-CY1-obe.outbound.protection.outlook.com) ([104.47.37.55])
 by ob1.hgst.iphmx.com with ESMTP; 07 Sep 2020 16:22:15 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hj1PZD2LBp/M7Jhb798pKNFR0t2H2Olsg544sN4qDSIadOh3K6MvXzEVOcfzQpzBf8ESMsjEpp7fyE2D+4TvSceufgXB9ACEAREww7wLINTsoiKuva5BPUh320wNfNUiaz60pNjD48gU3Qv6V+pqEoL84+hvu3prKim/cu7h5AhoRdxTNHERdxBViFjP1nhBxV0i5K+wmzVVYrIN/OGnIUNsDDxQap/8ovB8+lBJS20FFkD3ye0Fc1WqRgOyY75+XY7oSGjRl1GzglOCJNWRZSUee00CS0a09xJ9jGXKQs3vJ04LpCOm3SN5bU2d86t+C3bYlFfJKxqsdJyy4A41xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KF+76oE0BXMlvu+NlKuicfRFSQRPlUn13isTCPzIJuY=;
 b=dozkJG0rZC2hcyNiRL+bVGfofk7JOsOmDKRoNVGKqKv+9+gySBm3TdqISGMDqXwSFR8CFnCAparO3pZmzBJrHOEO8iAaxRdH0FYFI2/oOA1N18qQ7gkqRoxhJa5WmHrjmam/Rz3POwT5nRV+OtrRkfsFLPMCZjWulaBNsPo2814J+lgdUohN/o6rrFdX8I7dJjCqhoxETBWU7NDK/Q2d4XqBrU8vVLh34uZFO/64cQSWAJ++hfrru+uIA7vECio0cylsMy+QzQiocJSvoftCR8WJhwhhL2HNfRIMGysM3nHMHhlsvM9G6jAfSwtcxRjfJkq4yp1kJ2UpvDEfdi1LjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KF+76oE0BXMlvu+NlKuicfRFSQRPlUn13isTCPzIJuY=;
 b=CSMiCPpp70cljJmcGTIVXEukCNXsLH6dsGbOsW6yYlVN7D0EQTjHDHO4dhnjhoTynpHgblLa5Pgv5Kz/MXh9dO5CtYtD09HfqxtrjI5+IIlyUWp4MgoPMN0fSt++0DyaJ0GksRJRTsy1PMTeQMB4N7RTdBtcgmDQWiF6NsgdMg4=
Received: from CY4PR04MB3751.namprd04.prod.outlook.com (2603:10b6:903:ec::14)
 by CY4PR04MB3752.namprd04.prod.outlook.com (2603:10b6:903:e5::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.15; Mon, 7 Sep
 2020 08:22:13 +0000
Received: from CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::9124:2453:fe9c:9a7]) by CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::9124:2453:fe9c:9a7%12]) with mapi id 15.20.3348.019; Mon, 7 Sep 2020
 08:22:13 +0000
From: Damien Le Moal <Damien.LeMoal@wdc.com>
To: Kanchan Joshi <joshiiitr@gmail.com>
Subject: Re: [PATCH 1/2] nvme: set io-scheduler requirement for ZNS
Thread-Topic: [PATCH 1/2] nvme: set io-scheduler requirement for ZNS
Thread-Index: AQHWdSEIMmCxi6h3l0CfpdyAr+vLMA==
Date: Mon, 7 Sep 2020 08:22:13 +0000
Message-ID: <CY4PR04MB375151ABDF83FE0A9804C3EDE7280@CY4PR04MB3751.namprd04.prod.outlook.com>
References: <20200818052936.10995-1-joshi.k@samsung.com>
 <CGME20200818053252epcas5p4ee61d64bba5f6a131105e40330984f5e@epcas5p4.samsung.com>
 <20200818052936.10995-2-joshi.k@samsung.com> <20200818071141.GA2544@lst.de>
 <CA+1E3rJg0QOX4YgwWJf8Sm=6C-un4TsRX00E31fbFFPT9LYhXg@mail.gmail.com>
 <CY4PR04MB375148979AA403CF47EADE0BE75D0@CY4PR04MB3751.namprd04.prod.outlook.com>
 <CA+1E3r+C2KQENu=fO_+FZoUEvqZrAQcxziwSGt=FVidv85KQxA@mail.gmail.com>
 <CY4PR04MB3751B077D152A80B19236C20E75D0@CY4PR04MB3751.namprd04.prod.outlook.com>
 <CA+1E3r+0+jThD2KEu-d4rB=C4xL3Bb+cD=jUDbsGGBKR_GMpfQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:2cd0:86fe:82f2:c566]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: fe9018ae-b6c1-4035-5d80-08d853071fe5
x-ms-traffictypediagnostic: CY4PR04MB3752:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR04MB37521AF21D333EF769F12901E7280@CY4PR04MB3752.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8Ophps+gFwyiGj/E//u/Qk+6vYT3SfN7Z52+OaFKuJf0fNza80fwMiaqaPOKnshTJoNTfHtBh/fO69UeLPdaeSQV/94MvwXYs/04WONLn7rCkYPmOoQvOvyLzYlnZc/sIikWuAeBUwwwZNJZdQaViXhQ+aoJSWVTtBrIJFe6KDycemhyDv0DOyEbFIoMVQRSpZaQZnNQTr3fq2MoNilvvPpQJRJCOJM8/sqe0gCygN2abB+c48lZ4cZPUBUAJmP2Rr232ue6ssUvWQtwnnul45H9aCmPPAwgwqVBAvpFa7o/tVFn2w68uWmgIH9YO8aPKGuYaGPQawDIeJoUMsP1aQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR04MB3751.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(39860400002)(366004)(346002)(136003)(396003)(478600001)(8676002)(66476007)(66556008)(76116006)(66946007)(2906002)(64756008)(186003)(66446008)(55016002)(52536014)(316002)(71200400001)(54906003)(4326008)(7416002)(8936002)(9686003)(7696005)(33656002)(53546011)(91956017)(83380400001)(6506007)(5660300002)(86362001)(6916009);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: NhLtQNRuxJD21pZm2c50704z5LVBxiKj2/3vvc3w2aX1/pKWoR7K0udB/sk/MFIz6qhc6FK/VxgT6n0hhPJdBomG1pH9aauSxYIubIdjiKZaXXSLqfd6BvNa5ZrHh+T7J959e4DmSKkgDRLWLMNz9vVK4rTU97lsI1AYuX4f9qLUZ5tlBToYBFt+S5L0AkA6wDRrrQ40Rx31uRYKxe/vVgIknTiMZ3J0A6rup8LDq88m7ItNKsLkLUmIZ6GJzFTMJSOLp1cKObOxpTVuy+M+aLp4r/PmvZxXR3XcnaiVUSadjeZObkH7fw5omtN4pi+yY/j2fAS7D4SSAgHINWCSpE6z7jjvaLMPSVllRjL4+rdAEUAfW7ENXQDvspI6lBxeT2u88ER0GGQhnTOz6b47XQY6E+X1PTHhE+XchcpvGPLB/2u8bVE4KiSoBU/Bb+NpB+aVvNKJg2lIN/ZqrU5lxD6qfluEtBNdYE3hMbfIRB0KTNqOvkIvQuIW17EY5cTDLH3rdGfc9mzxhe3ROF7aRCv52UNyg7vJYG3hGut8AxtDv7JvbZUu83BY6yP4iVaavxUAQ2dZ9FZM/8qXXkdMbNMKIleIw6Sxq7hEGwFVmGBMvL1tRpxb/agmjPL9NnFdKLBMAThhqtm6RSO6ObX8X92/xau9TaGgY0o1XZ86mIe2eKLbe5RyZAvr99jdp8bdvYDZZMqbmNje/2luacn0kA==
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR04MB3751.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe9018ae-b6c1-4035-5d80-08d853071fe5
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2020 08:22:13.6052 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: i9XckTy+wrPV+C/3LY47OwWjWNI/t6qiSsUTZyYLxI22PI3WLxk0s8AhpLxTjtq66decI5gax600z4k6lVALfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR04MB3752
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200907_042218_800789_2EA29B28 
X-CRM114-Status: GOOD (  17.89  )
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
Cc: Jens Axboe <axboe@kernel.dk>, Selvakumar S <selvakuma.s1@samsung.com>,
 "sagi@grimberg.me" <sagi@grimberg.me>, Kanchan Joshi <joshi.k@samsung.com>,
 Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Nitesh Shetty <nj.shetty@samsung.com>, Keith Busch <kbusch@kernel.org>,
 Javier Gonzalez <javier.gonz@samsung.com>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 2020/09/07 16:01, Kanchan Joshi wrote:
>> Even for SMR, the user is free to set the elevator to none, which disables zone
>> write locking. Issuing writes correctly then becomes the responsibility of the
>> application. This can be useful for settings that for instance use NCQ I/O
>> priorities, which give better results when "none" is used.
> 
> Was it not a problem that even if the application is sending writes
> correctly, scheduler may not preserve the order.
> And even when none is being used, re-queue can happen which may lead
> to different ordering.

"Issuing writes correctly" means doing small writes, one per zone at most. In
that case, it does not matter if the block layer reorders writes. Per zone, they
will still be sequential.

>> As far as I know, zoned drives are always used in tightly controlled
>> environments. Problems like "does not know what other applications would be
>> doing" are non-existent. Setting up the drive correctly for the use case at hand
>> is a sysadmin/server setup problem, based on *the* application (singular)
>> requirements.
> 
> Fine.
> But what about the null-block-zone which sets MQ-deadline but does not
> actually use write-lock to avoid race among multiple appends on a
> zone.
> Does that deserve a fix?

In nullblk, commands are executed under a spinlock. So there is no concurrency
problem. The spinlock serializes the execution of all commands. null_blk zone
append emulation thus does not need to take the scheduler level zone write lock
like scsi does.



-- 
Damien Le Moal
Western Digital Research

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
