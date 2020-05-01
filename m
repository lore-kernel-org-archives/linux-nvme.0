Return-Path: <SRS0=VrRv=6P=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2B86C47253
	for <linux-nvme@archiver.kernel.org>; Fri,  1 May 2020 14:34:12 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 90A2B20708
	for <linux-nvme@archiver.kernel.org>; Fri,  1 May 2020 14:34:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="nPv1Eqd9";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="h7PDRv32"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90A2B20708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=txNcx3xNOqt5q32NZb0/3OyKTYNjqv4GboPBb3N3SS0=; b=nPv1Eqd9DkPvk7KGslDXF8InZ
	7kcS8L40SE79TwRSgkrxvQr+KsfLcKqk3fPFK36Swt88Q/2wjOSrF/YXtU3jSPb28A+fc3kSC8jxy
	3RIkcS4P2E6BEvLNoBVqF8w7NtLRb/3CkexMTTzdxtH+UEp1EzWOFodVM6sDoJbF5UXwj3zRig3Ns
	ULdiuS5kz0ydTV/3VYsB+6OyFjl35HYTcuFSQmTkJsH1dPeHT1iAwAde/mQPlBYt99ENN27+fz6VM
	SOuv42ZNtfRbdN1jYDXpYR6+CaRMLD3Mah1HLWtyG5GmVndPHazTDsiN6K77D0LK8Em5A97lEc/pf
	17E/k+0Gg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jUWjx-0003xM-Bc; Fri, 01 May 2020 14:34:09 +0000
Received: from mail-eopbgr60074.outbound.protection.outlook.com ([40.107.6.74]
 helo=EUR04-DB3-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jUWju-0003wb-37
 for linux-nvme@lists.infradead.org; Fri, 01 May 2020 14:34:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oSw1CoIyi2JrmE+7gq8yze8k8wI9TK3qekH0WyBifAhN9vNn8sUZCacW3vxTrTm6pFw6ubI1B9OdKJhM5zSRgQWWguvhAo9Hz8kIbEg7dnJWy9igcBSB1zLcbq/a6bhhbNlmzDXk+k1uICdoR2HeBoRUN7f87fkAnBCQt0Ktbv0w6VtucWwEOLWeOsUnm9YqEtgJ7mxcD/Paz4DA9rmRPOL/0ER0vbLkp3nAi22/1hFLr5DgI6OIJ0XEujUfMVurH9ejBdzuS9oXDPF2NuFZwmc66pNdRFJ/fSqpubYNrXW2shP22342WyVBIlIQc9us4iS0/YPAdlZcl8qafBU2dA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8H6xb0vBLW1QYs5QlYRv49mSuAc5NKlthrZR3iHlpU0=;
 b=al+xg6B2wcLsnTiqpMCujaasTLJfuiEWpxy3eHmE29f7j4p82U09vYqSlsgbgq4uH9zTvHiz8I9tQFz+kvlJC2vc6UuBdFQu+VU+UurOt8LzFamiFvQoTz1DVyL9zAAqARAKzeTdr0y6J6eYkZT+bAiL93Ne584ofo1u1YGu84yJn76P40mYsbXgbBihiOmvqDoyMeTFMf6+kDf0UuJEGR2oOLDGsXk1t2V3+1BO5KIGq0zjcjj8McVIwGKhz62EXeiZayh0gb4AbUIBWh3UrJm3969a4D8DMjDIL9Z1uWunUEXiHeDDO4/tOw2AGtLSvgBoQDNHkd3Bk2PiDJwB9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8H6xb0vBLW1QYs5QlYRv49mSuAc5NKlthrZR3iHlpU0=;
 b=h7PDRv32wySSrQY6QcdrFvMw3+H4L8tVY1n6UVvw6N8u7pHdb/yQ6DSFfYvHIc+kwYx9j9iC/tg+yUQCqxTaFXbuMcx59uOyQzUcbAWkRdRuofA8IM/Lp6mOW7OIcjkQy1TT9zWogWNDs3Phh/8/iMmQpQn8u/R9ysVungbJ40k=
Authentication-Results: mellanox.com; dkim=none (message not signed)
 header.d=none;mellanox.com; dmarc=none action=none header.from=mellanox.com;
Received: from AM0PR05MB5810.eurprd05.prod.outlook.com (2603:10a6:208:11f::18)
 by AM0PR05MB6548.eurprd05.prod.outlook.com (2603:10a6:208:13c::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.22; Fri, 1 May
 2020 14:34:02 +0000
Received: from AM0PR05MB5810.eurprd05.prod.outlook.com
 ([fe80::408a:27c1:55f8:eed4]) by AM0PR05MB5810.eurprd05.prod.outlook.com
 ([fe80::408a:27c1:55f8:eed4%5]) with mapi id 15.20.2958.020; Fri, 1 May 2020
 14:34:02 +0000
Subject: Re: [PATCH 01/15] nvme: introduce namespace features flag
To: Christoph Hellwig <hch@lst.de>
References: <20200428131135.211521-1-maxg@mellanox.com>
 <20200428131135.211521-2-maxg@mellanox.com> <20200501142400.GF7197@lst.de>
From: Max Gurtovoy <maxg@mellanox.com>
Message-ID: <139de1e6-2a98-0055-ee69-87d0b98a07a6@mellanox.com>
Date: Fri, 1 May 2020 17:33:58 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
In-Reply-To: <20200501142400.GF7197@lst.de>
Content-Language: en-US
X-ClientProxiedBy: AM3PR05CA0138.eurprd05.prod.outlook.com
 (2603:10a6:207:3::16) To AM0PR05MB5810.eurprd05.prod.outlook.com
 (2603:10a6:208:11f::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.0.0.3] (89.139.203.251) by
 AM3PR05CA0138.eurprd05.prod.outlook.com (2603:10a6:207:3::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2958.20 via Frontend Transport; Fri, 1 May 2020 14:34:00 +0000
X-Originating-IP: [89.139.203.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 1708677a-fddf-4a99-b9eb-08d7eddcb14a
X-MS-TrafficTypeDiagnostic: AM0PR05MB6548:|AM0PR05MB6548:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR05MB6548D22697C4147BCDBAB8B5B6AB0@AM0PR05MB6548.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2512;
X-Forefront-PRVS: 0390DB4BDA
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM0PR05MB5810.eurprd05.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(366004)(396003)(376002)(39860400002)(346002)(478600001)(53546011)(186003)(16526019)(66946007)(66476007)(66556008)(6916009)(4326008)(6486002)(2616005)(956004)(16576012)(31696002)(2906002)(316002)(31686004)(86362001)(5660300002)(36756003)(52116002)(558084003)(8936002)(8676002)(107886003)(26005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HVRtQQe0NEUumms5FaJSy9MuD0//1bxh0/ngQu+r4j1ENuxfk7gh0a8fE28GaTA6cCWcaF/hIHzKBwvuOqz00zvJnKlklG5IJH1/LYI9ILivIOyhAW5EgikPPn02JVZOvDmOVQumjPSiEsRa0fiwZHoKiA4Lbn0VOozQ9tyt4+LIHNkDaxwNeffL+fZuTnytV9RO8m4QZHnw3Q9idw8xOwvI9HsUNaKX9tY9jxx4rzZqiMHNUwe4tNlQ01VU/1N7GJxiXthu9Piw6cScJj6w+T2vP/eBR8O+VzRC6duwNX99vbtu+axbk2krWDrbjJ36cdhMneA0vewJBvh2eEX6njKpq32UoWRQThRSqn2fFqQTjSINvTp+uIon1ctE0i9jLEpfV0g0tCvL2DtPZI2HWM4IOHHGX4ztAxkuyA77FS0BP7laRI6SbUtXfjmhLIX0
X-MS-Exchange-AntiSpam-MessageData: jsqfYcakRvUmAZEdHXqiu5o5y3XqF/bEmB2VKJPn7Z3geWlXY0f1G6KWEGLtiUyGFNOF4bejT0je+pJscbtTUofObp6kcMXSfDOg/Tu8OpsnRej09IQbYY31mN+G+0yzTUskKk7fT0uUgaFTm2LEojhdkxPSbHGrCP1iSfEtJfKYTBIWaEiBvILDED1ousxIDiULr8vSgRJQ3527u8K1Iwg+810B/GepmICakH1lW19cagZkb0KuuNblwWlhGgap7ENEhj9xGLpJsk5z5I27O0rNFxaDXPOrNdJIlwpffg+24+hMnz3THzxTv1UQsP8JvEJcJOEpAdBhRdkG8aK9GMnqaWCQOB+EK00Uyumxmmb/WJAuifjqLf9lQNK62hNoYudLzE6nnk2MEbwP2ZOhJWkNE9regbCmDV0LVmP/4QYbMfYcQJHeJFNFWWZBft3fzgs3AX/9DQTxabV2NLO+HkwwS5CFxXvm8/i33YJMGgKu7Dg6jL7QhcaC7BKkM97HzUOECa9nfjZEwX12aNsXS2IR3IwUnfder93R9tI5uy2G9zuBeJTJLb4Z75IDMGZDcyeoGRicrmr4R91u1o4qWr8uDg2NmO3J99ATEfLtlxUXm2UWpOuFEje5Cy8fVAAPM8lj5aidhQgx91CQhIYvcX1gIEPEhvpxvILBgbHaI6Wnw2crzo8ahmo7LGylkX08Pc3b/v75WSX1sFdww6keGfvVfOOXqxd4mLn2EMCHuyq5wVjfQQcJ3Tr8bvwaCh95TZuxTuP5CfQDxsIKNSmYQ5Mzgz9eIfp7z7fMMWEHljs=
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1708677a-fddf-4a99-b9eb-08d7eddcb14a
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2020 14:34:02.1725 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ipci85ytXn9r0G/99XKsAPfSgKW92G60FUNLJUouotZ47JGzUqozWuUaPA3UROfjJQLsUXqXNRh++hzgVOFHLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR05MB6548
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200501_073406_141959_26EEE49B 
X-CRM114-Status: UNSURE (   8.38  )
X-CRM114-Notice: Please train this message.
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
Cc: axboe@kernel.dk, jsmart2021@gmail.com, sagi@grimberg.me,
 martin.petersen@oracle.com, shlomin@mellanox.com, israelr@mellanox.com,
 vladimirk@mellanox.com, linux-nvme@lists.infradead.org, idanb@mellanox.com,
 oren@mellanox.com, kbusch@kernel.org, nitzanc@mellanox.com
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Ck9uIDUvMS8yMDIwIDU6MjQgUE0sIENocmlzdG9waCBIZWxsd2lnIHdyb3RlOgo+IFRoaXMgc2Vl
bXMgdG8gYnJlYWsgbGlnaHRudm06Cj4KPiBkcml2ZXJzL252bWUvaG9zdC9saWdodG52bS5jOiBJ
biBmdW5jdGlvbiDigJhudm1lX252bV9yZWdpc3RlcuKAmToKPiBkcml2ZXJzL252bWUvaG9zdC9s
aWdodG52bS5jOjk2NDoxNTogZXJyb3I6IOKAmHN0cnVjdCBudm1lX25z4oCZIGhhcyBubyBtZW1i
ZXIgbmFtZWQg4oCYZXh04oCZCj4gICAgOTY0IHwgIGdlby0+ZXh0ID0gbnMtPmV4dDsKPiAgICAg
ICAgfAoKSSdsbCBmaXggdGhhdCwgdGhhbmtzLgoKCl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fCmxpbnV4LW52bWUgbWFpbGluZyBsaXN0CmxpbnV4LW52bWVA
bGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xp
c3RpbmZvL2xpbnV4LW52bWUK
