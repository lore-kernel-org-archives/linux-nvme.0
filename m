Return-Path: <SRS0=tp6u=3D=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19536C33C9E
	for <linux-nvme@archiver.kernel.org>; Tue, 14 Jan 2020 16:04:45 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE59F222C3
	for <linux-nvme@archiver.kernel.org>; Tue, 14 Jan 2020 16:04:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="sP7InPJp";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="ef98cn0D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE59F222C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=EBv2p9o5HhhNBJEAJglF63jam39D+2xO00nUrSjqxmU=; b=sP7InPJpzQBWgS8Qgq1yWG64Q
	TZ82Mho36nfeAkYCjYERLSOFgdGnk4tTMqjYkHnJ+UE2E/R30fFCUs8jvIqDjuXLAF8W6tICEWtEg
	hg96tjtxvcI8kYYroOXHeJY8qbow3t4yAD21sYSfvSogO/IaA1enVnQmjI+AzJMjj0w8+XtzR3757
	ZNE9o0WD4cHz3ej6XbO3Muic7W/B5GnSErtCEhLdbam1ISYMlJ0/OV5xKny9jwkzI1T6BLI3vkM9+
	Ro3GfmwJ/+Rgetb7uStiGKAgA4779pwSjV3kWsUFlIN+bSLU7L/w2lwozGu8MkU0Zge5QT16ru25z
	zkcV61ULA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1irOgH-0003mJ-3g; Tue, 14 Jan 2020 16:04:37 +0000
Received: from mail-db5eur03on0609.outbound.protection.outlook.com
 ([2a01:111:f400:fe0a::609]
 helo=EUR03-DB5-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1irOgA-0003kz-Pl
 for linux-nvme@lists.infradead.org; Tue, 14 Jan 2020 16:04:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kE+AfsBWkGSoqLgGX8ecgCUWuA0EZVDLxuwkGN8wSdPH4PyKuhMcsIr2AaOzgCZY6/XVJscf8Q8echY5Tk4u/yBQIemTr2IZ5MlTbc6yeZmn558kD4p4NX6WaPvWdLkVFWd6BN3ouAToPIg7DhOfwd1GcDpV8ILFf6r5zad+Y6fJPMMChdkWykykrGPwNwNVLhksLcoVu9qRqH56SoBeyvV4A/wFX3QKT6YcF3/qG6Y8rv6833ih5PNhBRhMXDTpTnK3jFQGgBd/rzM9VfmF2Qij5ypnxUK2kSqfctkDVSOWfKeXj9NiBKK0JjDa20+RDszbeSrZwwIUmoaLHbIWmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mG4dcRYpvNI7uiJTi7wMLdNB+76G60VoOgGDwCBLRkQ=;
 b=N3j1hjGEztoPDkgIfZk3Dlh5Q3AbxJfmbWG3mMjZvlsiwh+1YrScTURSrEQPxV/LebfK4p8PvntQoIhjIWcRwMfUcNsYAxQxjJuge3fzsC22oekLWsNXQMcXQNyju6cw6UvK/oHCBC93DrmFSV89dxdhiS5HOGjvRokISrF+PWrtBjXR5oJHClyeupz3UrkkjhO0d4sO2pi0VvqeTnwRD0mTpttrlkzrelxyqUw/5oUBGAHStuNHqZWTzD7odn+vQJ3OGRo0Fw2lVh9+sw4V9WieXVXUetyp8kUV8H57NDK488dE3cABUkNW376YqLOO2eeOjyCA3675RxgNLijGKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 193.47.165.251) smtp.rcpttodomain=kernel.dk smtp.mailfrom=mellanox.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=mellanox.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mG4dcRYpvNI7uiJTi7wMLdNB+76G60VoOgGDwCBLRkQ=;
 b=ef98cn0DcNYysdHoYAk8fmXHKQ33dW1mMeyLcQRtRXHZmnJivgriNR0WkoxNmL9Zngqon8Be6S/hYok35zh3BXSrpwcBV5TwQELj7nFO+OKJnSi5EnjfXikBASxI6jpHcVMUibJYelQ6Dm+oC46pOwIDKpczjZUJkHiQKf73pXo=
Received: from AM3PR05CA0123.eurprd05.prod.outlook.com (2603:10a6:207:2::25)
 by AM6PR05MB5878.eurprd05.prod.outlook.com (2603:10a6:20b:a6::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2623.13; Tue, 14 Jan
 2020 16:04:24 +0000
Received: from AM5EUR03FT004.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e08::209) by AM3PR05CA0123.outlook.office365.com
 (2603:10a6:207:2::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.18 via Frontend
 Transport; Tue, 14 Jan 2020 16:04:24 +0000
Authentication-Results: spf=pass (sender IP is 193.47.165.251)
 smtp.mailfrom=mellanox.com; kernel.dk; dkim=none (message not signed)
 header.d=none;kernel.dk; dmarc=pass action=none header.from=mellanox.com;
Received-SPF: Pass (protection.outlook.com: domain of mellanox.com designates
 193.47.165.251 as permitted sender)
 receiver=protection.outlook.com; 
 client-ip=193.47.165.251; helo=mtlcas13.mtl.com;
Received: from mtlcas13.mtl.com (193.47.165.251) by
 AM5EUR03FT004.mail.protection.outlook.com (10.152.16.163) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2602.11 via Frontend Transport; Tue, 14 Jan 2020 16:04:24 +0000
Received: from MTLCAS13.mtl.com (10.0.8.78) by mtlcas13.mtl.com (10.0.8.78)
 with Microsoft SMTP Server (TLS) id 15.0.1178.4; Tue, 14 Jan 2020 18:04:22
 +0200
Received: from MTLCAS01.mtl.com (10.0.8.71) by MTLCAS13.mtl.com (10.0.8.78)
 with Microsoft SMTP Server (TLS) id 15.0.1178.4 via Frontend Transport; Tue,
 14 Jan 2020 18:04:22 +0200
Received: from [10.223.0.100] (10.223.0.100) by MTLCAS01.mtl.com (10.0.8.71)
 with Microsoft SMTP Server (TLS) id 14.3.468.0; Tue, 14 Jan 2020 18:04:20
 +0200
Subject: Re: [PATCH 01/15] nvme: Introduce namespace features flag
To: Keith Busch <kbusch@kernel.org>
References: <20200106133736.123038-1-maxg@mellanox.com>
 <20200106133736.123038-3-maxg@mellanox.com> <yq1imllz5l4.fsf@oracle.com>
 <87553ee2-74f4-8eb9-dd07-552f2637dab8@mellanox.com>
 <20200109162625.GB1032473@chuupie.wdl.wdc.com>
 <84cdf570-4fee-3396-ca4b-762cf3af6815@mellanox.com>
 <20200113203135.GB23750@redsun51.ssa.fujisawa.hgst.com>
From: Max Gurtovoy <maxg@mellanox.com>
Message-ID: <2a237612-2114-ec1a-9cc8-91c0464591ad@mellanox.com>
Date: Tue, 14 Jan 2020 18:04:20 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200113203135.GB23750@redsun51.ssa.fujisawa.hgst.com>
Content-Language: en-US
X-Originating-IP: [10.223.0.100]
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:193.47.165.251; IPV:; CTRY:IL; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(189003)(199004)(36756003)(2906002)(336012)(31686004)(107886003)(81166006)(26005)(81156014)(16526019)(53546011)(86362001)(186003)(8676002)(4326008)(2616005)(8936002)(36906005)(6916009)(356004)(31696002)(70206006)(498600001)(54906003)(70586007)(16576012)(5660300002)(3940600001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:AM6PR05MB5878; H:mtlcas13.mtl.com; FPR:;
 SPF:Pass; LANG:en; PTR:InfoDomainNonexistent; MX:1; A:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fdc3a4c8-78fb-43a7-3702-08d7990b6c98
X-MS-TrafficTypeDiagnostic: AM6PR05MB5878:
X-Microsoft-Antispam-PRVS: <AM6PR05MB58784AE18B396E5DE52D0C57B6340@AM6PR05MB5878.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-Forefront-PRVS: 028256169F
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jaD/cs6xtUPGkmqaqm0SLl0gGSlqnvAWK4y1yec75M9H2HMyNVj36T7XQedCBKww3SOxlEVUBpEqSv3F9p7DGtndOnUZU5bhhnS2SP7iOlMHOngWzlaG6ys1lEwqzkP9gc7lVXz+yhdSMZEm7DyrSIDVOEhMukj66ttcc+rUf7nw/KYxSuFeH1LeeTwm9NzNDoMwoduKEyTOkfccEVvOFmZ62MbS8s6ecCMGLTkFaWIuHmmLuTbpBFrsTUscaGJSl9s+WfYAHW7Y10lThZ+N0cf1LOC8cqKHEu/KMPzL8K+jMD1NxUMqIyH9odIsEh+xvnq3boS6bsaTFtQ989cZDkqN1aPmOTV0mSniaNAbLmPbjzewuuaxd6p28EQPKqG2lUmc7oOEp0TrYD8yD+2FnUksiBuAic9UYt41jq2um/Fw0Oo/+Fq4xhNlR/wXMwazp34cze6eV44ClgBzQQUgo+vsvLrOGj47E5BwfbUfiV5TZ52iRTcMF6tCUcu7IJVS
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2020 16:04:24.0077 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fdc3a4c8-78fb-43a7-3702-08d7990b6c98
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a652971c-7d2e-4d9b-a6a4-d149256f461b; Ip=[193.47.165.251];
 Helo=[mtlcas13.mtl.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR05MB5878
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200114_080430_838694_9B0D6A7B 
X-CRM114-Status: GOOD (  12.25  )
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
Cc: axboe@kernel.dk, sagi@grimberg.me,
 "Martin K. Petersen" <martin.petersen@oracle.com>, shlomin@mellanox.com,
 israelr@mellanox.com, vladimirk@mellanox.com, linux-nvme@lists.infradead.org,
 idanb@mellanox.com, oren@mellanox.com, hch@lst.de
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


On 1/13/2020 10:31 PM, Keith Busch wrote:
> On Sun, Jan 12, 2020 at 11:40:31AM +0200, Max Gurtovoy wrote:
>> On 1/9/2020 6:26 PM, Keith Busch wrote:
>>> On Thu, Jan 09, 2020 at 12:38:05PM +0200, Max Gurtovoy wrote:
>>>> On 1/9/2020 5:11 AM, Martin K. Petersen wrote:
>>>>> Max,
>>>>>
>>>>>> +#define NVME_NS_DIX_SUPPORTED	(1 << 1)
>>>>>> +#define NVME_NS_DIF_SUPPORTED	(1 << 2)
>>>>> Not so keen on the DIF/DIX terminology in this context.
>>>> Martin,
>>>>
>>>> how about:
>>>>
>>>> +#define NVME_NS_PI_HOST_SUPPORTED (1 << 1)
>>>> +#define NVME_NS_PI_CTRL_SUPPORTED (1 << 2)
>>> Well, I was trying to say earlier that nvme supports formats with metadata
>>> that's not used for protection information. The metadata, whether separate
>>> or interleaved, can be used for some proprietary non-pi related feature.
>> so how about:
>>
>> +#define NVME_NS_MD_HOST_SUPPORTED (1 << 1)
>> +#define NVME_NS_MD_CTRL_SUPPORTED (1 << 2)
> You're using these to report the in-memory format of the meta-data,
> right? These are either Extended or Separate from the block data, so
> I think the names should convey that. Something like the following
> maybe:
>   
>    #define NVME_NS_MD_SEP_SUPPORTED (1 << 1)
>    #define NVME_NS_MD_EXT_SUPPORTED (1 << 2)

No, we're setting it to know if we have host MD (aka DIX, memory-domain) 
and if we have ctrl MD (aka DIF, ctrl-domain).

for the MD format we use:

#define NVME_NS_EXT_LBAS	(1 << 0)

>   
>> We didn't change any logic for metadata support for non-PI format.
>>
>>> The nvme driver only leverages "blk-integrity" to facilitate allocating
>>> and managing the metdata payloads even when not used for integrity. It
>>> might make sense to give that block component a more generic name than
>>> "integrity".
>> Yup that True, But this patchset is already big enough by itself.
>>
>> We can do block layer refactoring in different series..
> Absolutely, didn't mean to imply you take that on. :)
>
> I was just trying to emphasize the current name doesn't always describe how
> that component is used.

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
