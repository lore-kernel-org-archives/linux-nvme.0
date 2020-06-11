Return-Path: <SRS0=2FDT=7Y=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 246B6C433E0
	for <linux-nvme@archiver.kernel.org>; Thu, 11 Jun 2020 19:17:09 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E7009206A4
	for <linux-nvme@archiver.kernel.org>; Thu, 11 Jun 2020 19:17:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="NRl4bqib";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Kj4XRFrl";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="QXv77kfW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7009206A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date
	:Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=m518GMhnWulLTrfCrffkeY5xI5GlRfhUqrwNfyiEgtQ=; b=NRl4bqibTsj+7n
	1TbuAFenXtx1oE5yn25Bfcfo4Fn0FYDJHf0O8RsZBr+OQO0UydozJXHpNHLZ7NdejJhrgRqa1m5aZ
	R9vhtBFFFHqJycyVPr6+3TNP3tLJxUosnkQCVFoYptOeXcjGnhD6603RRYkPmYlfFvaKRiK7f4h4/
	j/eBO4svMgXCgVB43yMmNnTuT6WOjaaOrPIA291mbaptwTby/17TTbO29vtO24FbGl0Mg8VXmiCDP
	z6wQ0/R7NYkrmTPyC61yJGKPrIi5I4ozUbI4h5TixBN64bCVIIgRE9ZfsqgOktNvdy4u5pdX5RKUn
	4RxwV7TvWF9BOqQMF6Lg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jjShD-0006NP-Hb; Thu, 11 Jun 2020 19:17:03 +0000
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jjShA-0006N5-Hx
 for linux-nvme@lists.infradead.org; Thu, 11 Jun 2020 19:17:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1591903020; x=1623439020;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=Odm5JQ1qiXYUIgWtvDKK5lnYUTERJRlGVy2CEenyhSk=;
 b=Kj4XRFrlIMVHMofGNzfDBx8EZGekTGg6t/jDjL6z11vxePKfPQ2jN0cL
 xT3RPJyd5occUsTC6ZwVd2ZiWBA2foCsCvNLyUiY6AyWiYIdM72MHZQFq
 MFnjJMFM7bNPnjYdm4Cm94/hTYdKILL7CWOUe1O0KlX0NS3a0oAIHhfYE
 uKp3IeFygjbdJY7rMTxVOk+7GAne/XRNy54UoNNTD/hpcaRsrxKy2RIN0
 D+GPpOY6nILAIaB91iAToSmjXmhQiYRtI7bc1MDAf7PplVlr+SX4FqdTH
 3CX/0hS16DFRSIG3zchh0BSWcFth5DC+lPKqTgeLav5DW/s9mwdjzwtwI w==;
IronPort-SDR: PsbZ79/vWtTOXbbjBo61mRiPmZUMnqXNuM/Qc+w4P8Gu8myqKohjee6SNkWJi05SUwsWfPP2In
 nlEwdmGcf6O3epFZas+dnW5Dce8TIDy6uJ/KoHGWF7yhF6lxdSXkfo5iM81SLalq0U6e852stl
 2S0KacSxORAgcK+04R1QxnjhBoRuSq7WxVypBZKUJTvEcb3rqgo0Mig/SstsodapVvii8rxz/T
 gc1bN0mWuEHIhc7llVljsDpRvOdltsaRncXvnHzCnoNt3AbH6tTAXeT9dhZR9+8/L+BS4xQdk2
 1eg=
X-IronPort-AV: E=Sophos;i="5.73,500,1583164800"; d="scan'208";a="139762664"
Received: from mail-bn8nam12lp2177.outbound.protection.outlook.com (HELO
 NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.177])
 by ob1.hgst.iphmx.com with ESMTP; 12 Jun 2020 03:16:55 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TJkSXXFyjd0GV4ceJD9llC4beZS+4pNz3Sf731s917itEmgTEGIHAdHIFD8w6UMDC6MrPkStLabgufOAWVR1MO1IarJMa354mvh2PtxqOf45oVSs0otix1Gq9tYqRLhzJlZQNVrkCNl2AS0IoXk42T3QW6j2AVO7WJ9RWtnEslAy7sbo1nyMEWCvSvS1hDf9llkp1puy6V5gX2rmPCF4NASX/o9o5ZR7VoPYt88+eCVc2hrJESI9pz9EZdz8EavHsfIXLvgoIrNLTx/UfGDyaePo2zVnO3dxeaCu6NT7TMMyaSvTt1SwZU9Nt7vmCKvub9n+vMSuApggCRM91cE6mQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OF5m86lqJidWkx6lwKGLassGs9bB/NswwePJmGYVNUM=;
 b=oRpPgV4Vo/VFZAW3JdOXnYKQi5y/Lv3VWuOtSEXhRUh4r8OHQ760yo94fO+E7E8zu2oJXRuzkGWuRdVah+63W2yYzmiIK7h6NrXAhDInxuN/MUNkmSHM45lv5mvIc0Y4mJfwD9/pqmx7YR+5kgTn+XoISnsBQwKhv4q8YOPoO4/TjaWOzTcN9C3K2EsTcEapkK+ajNXcS9SU7K0+l/diosNiRb1FTnGFYK2NPfFErxs2YPCRIMNXCZJt18V9oW7z0Xuobx/X/EC5rdDelo+7of7b32MWMq9xaEkSTpMz4HBt+cpl/2dU+QKPcA7k3UJXlLxvs3vCjLHb05qF1Ou7EQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OF5m86lqJidWkx6lwKGLassGs9bB/NswwePJmGYVNUM=;
 b=QXv77kfWcXgt98AVjJDpBaElL5boaWcRCSgGbdhRn3kDGX01lUYQDtngyXO+PeYbPmLHarzWKihxN+s7wq/pwjmha2WIYPdeQ9U3ofQefQixi/NTaanyVIpPY1x2fd2x1uT71Z/2w8cET8oKJYK7kHOmbQTurrg/FFuCde53oig=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB3861.namprd04.prod.outlook.com (2603:10b6:a02:ac::33)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18; Thu, 11 Jun
 2020 19:16:54 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::4d72:27c:c075:c5e6]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::4d72:27c:c075:c5e6%7]) with mapi id 15.20.3066.023; Thu, 11 Jun 2020
 19:16:54 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Logan Gunthorpe <logang@deltatee.com>
Subject: Re: [PATCH v13 0/9] nvmet: add target passthru commands support
Thread-Topic: [PATCH v13 0/9] nvmet: add target passthru commands support
Thread-Index: AQHWKhRsU0RUeVdtwkqjNhBWhX0tSw==
Date: Thu, 11 Jun 2020 19:16:53 +0000
Message-ID: <BYAPR04MB4965CEDB8E3AE4B7F4C527AF86800@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20200514172253.6445-1-logang@deltatee.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: deltatee.com; dkim=none (message not signed)
 header.d=none;deltatee.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 58e1a248-9d32-4f93-168b-08d80e3c0063
x-ms-traffictypediagnostic: BYAPR04MB3861:
x-microsoft-antispam-prvs: <BYAPR04MB38619E0D316404A2ADF3578786800@BYAPR04MB3861.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0431F981D8
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5m7AuniIZ/mF9GOkfy/gzamnFvwwzba8RsX0Lm/5bH2VFrV3kTFrH+0VI/9bqYc2qwFVDq2++6gJmn2golUFC1GoOEph/JT2NBIo1KbHQnYWroqJpoi+T2UAYqXBkmkDGLnAPu4bEMVIAKlPiRH86YFTlwZP+AJQxoPk9SMRXYmMY1NfLbU2nN1bfIAoySyFZwwCNqkMct1JVhJAy0Q4s4H5xHGFSfbuzsnsG0eMyAQgYxYfH+Jw7qsPxAKWlmKH5KdwCmA/RlKJPp1q6IGutVNRs1Hgze7fP3vgsWSPdEHyAm6s85pru2iDD2rvTw/M9HFeRv3QN1VpfXYi8y2sLJ7Vka5hO+dph9zH7G1OkK/SkVmjxI0h+FUtzs04sNGcQ4PvBTkHlJtyJw8Cv5XgMQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(346002)(376002)(39860400002)(136003)(366004)(66556008)(8676002)(55016002)(71200400001)(52536014)(86362001)(33656002)(76116006)(8936002)(5660300002)(2906002)(478600001)(4326008)(83380400001)(6506007)(966005)(64756008)(66476007)(7696005)(6916009)(316002)(186003)(66946007)(26005)(53546011)(9686003)(66446008)(54906003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: ib+3cmmfwTL8FFHzu660nWvNZ+YuiYp3tgWdx6n1cbjpq9F4WgSebEdoc5+rqtt15RuAU5SZ+j5DaI+6v8OIaGts5xymz+BLQ4tLd5ja+NZscEJ8NXD7C+Yml5s9vWnGJdJ/VBQFFS9xz+N7KWXRwDhoKmTjJGofr4tL53iRksQ5FEh7vvZgrbFYfeI5s8NO8m86xTq+ohk4lG/eZnqrsKI77OmmAwdMf7TpKPo45o3pKfp7n4TuD1edfescMms65gyJubHIEWp84LqdpfYIMbYWocq3PJOn+AezKPJSl4Hl1iG7Sbgl2Glu8ZZfvAnYBlDnaS4/ftJPp/T6BFK+8uZKHf9xP16VceF1cY80MoTsudbkA9NVm38cP7wm3GUH7sPT8WgEujRmijjOO+i0PojDF+h9V8PN6Iys8kafchch4a2IF29xJpkaebTNYD9soSvZSiIFnqJ2rdp6S9uaP3AwH7M6VhX5qMhgoT9ufS4=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58e1a248-9d32-4f93-168b-08d80e3c0063
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jun 2020 19:16:53.9336 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: q4hjPUjTqkG9UXwUwcwL0C9mUN8x6JBW0ZXwwa1hCmEZttQQUjypkpGOIBp0p4ia4AJQhepPMi/Jg9CRv3Gattnm3GidJZ9J/lKiNhjYezg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB3861
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200611_121700_706253_A147B220 
X-CRM114-Status: GOOD (  15.89  )
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
Cc: Sagi Grimberg <sagi@grimberg.me>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Stephen Bates <sbates@raithlin.com>, Jens Axboe <axboe@fb.com>,
 Keith Busch <kbusch@kernel.org>, Max Gurtovoy <maxg@mellanox.com>,
 Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 5/14/20 10:23 AM, Logan Gunthorpe wrote:
> This is v13 of the passthru patchset which is mostly a resend of v12
> with Sagi's reviewed-by tags collected.
> 
> Below, I'll reiterrate some points I made previously that haven't been
> responded to:
> 
> I don't think cloning the ctrl_id or the subsysnqn is a good idea.
> I sent an email trying to explain why here[1] but there was no response.
> In short, I think cloning the ctrl_id will break multipathing over
> fabrics and copying the subsysnqn only has the effect of breaking
> loopback; the user can always copy the underlying subsysnqn if it
> makes sense for their overall system.
> 
> I maintain overriding the CMIC bit in the ctrl id is necessary to
> allow multipath over fabrics even if the underlying device did
> not support multipath.
> 
> I also think the black list for admin commands is appropriate, and I
> added it based on Sagi's feedback[2]. There are plenty of commands that
> may be dangerous like firmware update and format NVM commands, and NS
> attach commands won't work out of the box because we don't copy the
> ctrl_id. It seems like there's more commands to be careful of than ones
> that are that are obviously acceptable. So, I think the prudent course
> is blacklisting by default until someone has a usecase and can show
> the command is safe seems and makes sense. For our present use cases,
> the identify, log page and vendor specific commands are all that we
> care about.
> 
> A git branch is available here and is based on v5.7-rc5:
> 
> https://github.com/sbates130272/linux-p2pmem  nvmet_passthru_v13
> 
> [1]https://lore.kernel.org/linux-block/247eca47-c3bc-6452-fb19-f7aa27b05a60@deltatee.com/
> [2]https://lore.kernel.org/linux-block/e4430207-7def-8776-0289-0d58689dc0cd@grimberg.me/
> 
> --
> 
> v13 Changes:
>    1. Rebased onto v5.7-rc5
>    2. Collected Sagi's Reviewed-by tags

Are you planning to send V14 based on nvme-5.9 branch ?

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
