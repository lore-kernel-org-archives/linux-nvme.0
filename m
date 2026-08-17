Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A325C5B572
	for <linux-nvme@archiver.kernel.org>; Mon, 17 Aug 2026 14:46:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=iqQl6zpWZry5xJncB+GH2wKBqPvzNQ/izktKUmUmdvI=; b=tzc84capi+gjpyvFfcU9goJEHp
	zijH9MgK4qBFD0yKSfHOzusrfT4obDciH6bHm4ASWYYeFgvqNcUXgDbwEpBMehl5c4L/H1QXZNOhT
	J9Fm8Sst+800+9M9uIBKijsU/nmjTm/YXMGVp++W4Z5F/44FDp7RRp6BBz3XpxYw+s+O0GTBsn0ZI
	kvUeABxzTwB/ZUmWKR7T9ra7ld484SpigdWlxPD7GiFTX3T3yOK/gajrQceOc3GFALWZ3XJ8+MqxV
	RXljUBzn+XO9MVfCyu/wzP1ZaTBmOSljhW889wdZH6+lZf6pFsBUROp/HYfm0a/EdM0DCEn+Vm+UK
	57oow/Yg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wvybw-00000006LGz-31li;
	Mon, 17 Aug 2026 14:46:48 +0000
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wvybt-00000006LG2-0NM3
	for linux-nvme@lists.infradead.org;
	Mon, 17 Aug 2026 14:46:46 +0000
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67HEhggG988991;
	Mon, 17 Aug 2026 14:46:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=iqQl6zpWZry5xJncB+GH2wKBqPvzNQ/izktKUmUmdvI=; b=
	QssbXNtquwAl40U6miEOoq7QIjoCXvwCUtY7vhM1j23UThRp8brgBzC5uC2s8L/m
	tzlbc3bovb7dJEhJXKb+FmAgjubVKrA5hgfItXrmUJioyDl9UGulmNNq4LFOv2mO
	MnxFxAlFktoPuGSH9OQHLgMhvS8LTNqPAwVxh5FMUa8vJSKEk/Pn1XpYYUmTDpaw
	KSM4+6U30vdQtV/8tuU6pfmkKxRXqcgkgB7F6V0QH80r2gDfBQ8hr2kDjzj/umwp
	4e88lIURm7FWjBnT9M5apwrYOhW/lIoWjp8B83ltWMhhnPgnzZoii2au62gEAOpk
	jEY1XOHv6+MioYW0zsAhLQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4g2g07jdjp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 17 Aug 2026 14:46:30 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 67HEdwOO023570;
	Mon, 17 Aug 2026 14:46:30 GMT
Received: from bn8pr05cu002.outbound.protection.outlook.com (mail-eastus2azon11011025.outbound.protection.outlook.com [52.101.57.25])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4g2ejbr0re-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 17 Aug 2026 14:46:29 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uuZdsDfN51GZ/PY9AYY2FGHdHW6zAYVCZ2gHWCWpE/wV/vZ0OPE2fcd2xHEDbS8KznxWkJXiI+GJ+xUgGRcczSPyV1VsGZEEEKMLbVjUuI0uqWc3DRr4JtQDJy7UdKQJDz8R0S8RJXsRPPvZySmqBj3BuRYk0bfnsMxH/3hz/jq8mi+nFVllf2NTWHfTtUVF5KW5Ai3dnN9HdcB6x2Q20wSSqzRbcDfMHlzBj2rEFe9CjM8JPqykv27OLu+JGy6cMO8g6s7qf5HMdDYmqTEEnxl/Kt0tiri3/XSuMTkHL0lFEe6cOhO8Ibx5ChGD8Wa9EHrsVQhfcZpCWK9EtNxr3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iqQl6zpWZry5xJncB+GH2wKBqPvzNQ/izktKUmUmdvI=;
 b=K8tP/mAUfCJs4KTIiixZnuEiOsyQmxif40XumFUnL/XFENCMp+y8TE3pG5518wFcpI/n9WJEAlIG2TM+03BYiC4xDvP5YzVrvJOJmKJ/3DCY/WoWQfSbLuYc/j9AWjyMeyG642UfyR+Nf33nINpcMFUkRWn9VY//WrpHBIe+d9EK8xbNGFJX7jpBxDE+68ksn9jazYFA4euXzXoqOvHLS1zFjXrT1lmhoZoj6NkG3M3zvGK3/Psbr3Vil44so1aQzXMgAv+dQsr0vCo9tP64V+bujFVZZPasVFA9z+4HFApqEiGl9qm5cvAdDEjnizqb//voElivFCAr+epIE0eIAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iqQl6zpWZry5xJncB+GH2wKBqPvzNQ/izktKUmUmdvI=;
 b=AKeoUVygBOjEIwt9j+xF8DJusXNB4gXTtmSAHjdsBAGrBEE2gKJznj3q+jRzb6yxIP33fJRRUO60+3oApGJvwhRpzz5+88UpP23HEmKSFuNhEFquELQOy61AFo0NEtCxfOWsy6Vzt7p6NUKVONrKiTD58bDMRlWGSIzNGjhQ+vE=
Received: from DM4PR10MB6229.namprd10.prod.outlook.com (2603:10b6:8:8c::12) by
 DS0PR10MB7512.namprd10.prod.outlook.com (2603:10b6:8:165::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.17; Mon, 17 Aug 2026 14:46:25 +0000
Received: from DM4PR10MB6229.namprd10.prod.outlook.com
 ([fe80::867:63e7:13fa:fa7d]) by DM4PR10MB6229.namprd10.prod.outlook.com
 ([fe80::867:63e7:13fa:fa7d%6]) with mapi id 15.21.0315.016; Mon, 17 Aug 2026
 14:46:25 +0000
Message-ID: <b6c5b34a-b693-43cd-a6aa-1db28fb2ae5f@oracle.com>
Date: Mon, 17 Aug 2026 15:46:20 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme: add missing SRCU grace period in error path
To: Tristan Madani <tristmd@gmail.com>, Keith Busch <kbusch@kernel.org>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, Caleb Sander <csander@purestorage.com>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, Tristan Madani <tristan@talencesecurity.com>
References: <20260815001427.3148050-1-tristmd@gmail.com>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20260815001427.3148050-1-tristmd@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0108.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:191::23) To DM4PR10MB6229.namprd10.prod.outlook.com
 (2603:10b6:8:8c::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB6229:EE_|DS0PR10MB7512:EE_
X-MS-Office365-Filtering-Correlation-Id: 703cfe27-c435-430e-c53e-08defc6e4fc7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|23010399003|1800799024|7416014|376014|10067099003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: TcrmOh1IMVyksuf+A0ec0pf8mnsdYBJNomlZQidYu5kVpqPelzocmfVu7pO0MIS4E3SFvl3Pc36YcBj/4QIBSvwDUw20d1T5qdCIRU7J/oinnLR4dvHmc30u4VOf5q6fjY33UodZGDikzhLU0FCBmbn3H/8XkPhmYdmu36WC/M94mEusI1MXJB926aYg4XUjJjJTCxmptsW26w7Q28hgJYMZ+i8lFJqa/NvcaD+mCL21ren+Wsy5nommU5xuoHVUsP178ZZFRRhxRWG7nHCXPKM04azsnwM7PauSTX2Q9BMPj6vLrYRyNG/3J6puITKAcusZOJ964RT5R4dKZ4dQ48muedJO0cvt7SNfcAPAi1mqIu79lMB+1avRVXfdC8oUs3GKne4NY1kjZOlKcr00gERM/PvFYMsZwsNb1ASd69J5UjuTgAiBf+kuTYYgVqGVhWs/AbYdZ3bb0iIWcgH/x+NtiYLvMYpICDIDx5baoyFbLS/yh1K5IjaEG0ULq4M9n8jjbwZyTdRMtPz/0Co7lq1gkgdT4bvBNiRDn3A7TGAU8AXcKYMFObmyRRu241GEERYxyAXUFJwCnvTc68wchxhHzP1J/lvEOFigme4odo1Q9CnuiFgP5JojK1U3RMeMwrzIQcqtfFqEUuVYuwCBl+XSQ5vtNJFL5w0x37dWA+Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB6229.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(7416014)(376014)(10067099003)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WFJqbWlKUXRFTmhtVk5od1N1TlBOdkNDNjU0VDZtQlY4RzErT2FGaFdGMThK?=
 =?utf-8?B?MzVUNEhxeDVWTVoyQ1htck5pVFBhaGV3aXFMNCtYdmxmSlpVZnh1Z3d0TW15?=
 =?utf-8?B?Y2t3dGdtL1NPMUU2NWZERDAvY0FUeUI3a1ZLRzEzM29LeE5qdjlQQ0hCN2F6?=
 =?utf-8?B?NWt0TkZ3QlpDNG9xcmlpYk9aS2hhcy9tTGlvdEJhR0tHTUZTTllzWGRKRTB1?=
 =?utf-8?B?NVMzakJ5akZKM3d0ZEVxV1gvNFFtNHcrbmlEbGI2UEtYTUNoYTJGM2JCMFMv?=
 =?utf-8?B?NSs5QUtyeUwwV0pyZmtWUHkzWUxrMVdzeUZ0eUEyWTQ0aEFUeGh3N0F0VTJQ?=
 =?utf-8?B?cHdXVEpJOWtzWnN0RHdpZi9wVDdxbW5jT2tLL1NpZ0xPdGlINTJDSVYvb2JE?=
 =?utf-8?B?NXVZTVRIOFBsWTEwR3Y1MCtpeUpDTW5LVTA4NS9pOTJETDNhWXFoYjMxL1dM?=
 =?utf-8?B?UHYxdnVDU0lmb1hDYUtTazZXODZVNUZsVzRNbWF4eW4yWUFEbXMrQTlpLzZK?=
 =?utf-8?B?amZScjdqS2pnR0F3WVEwcm4rZzJ4Z0czQ0lJZmhMR3lrMGVIZ0lQZFFvaG4v?=
 =?utf-8?B?UEtaNEoycGd1Z1pYRFJoaHMyc1MxdEY4d1RKY2tVRlJZY09JdFFaZCtwcnRQ?=
 =?utf-8?B?ODFBV1U4cmVsakk1NVErSUFnQ3U3aXJSS2pDN3AwWnNGNW9YVG5kV29zcGtM?=
 =?utf-8?B?SURCcUc4WVQ0QkVkOFZlV0VWS0ZPcElTRnFqclNGQjgyVWZXU3NUSjFhSzhn?=
 =?utf-8?B?NndJT2s3SWpwYjBZZVRkR25TRElEWFdOQTkvNTJNS09RZ2VaWlB4cU5sRzd1?=
 =?utf-8?B?LzAvdkZVQXNRTkw2WlNBUUg0emxUOXpZTUhQczlDYXVLa0F0Z0hXTXNJT0ZT?=
 =?utf-8?B?dGlBL3FDbEYyNXZTVUpTNThVOTB2bnM1ZlNUTlZWeS95WHY0TldLazcrMStF?=
 =?utf-8?B?SUFtRDAzNHczUVBPZ0RiODJzMFNTblRPdUZaL2pDcnVwT2Vrckd5c2dIMDFD?=
 =?utf-8?B?dGJoaEFyM0p0L1gxNEY1NnhjVkgwcVNOSDdMRHZqQk9YV0hpamtrRzVaSUU0?=
 =?utf-8?B?eXloM3VXdVpzNXdIYWRUaDM5S2FwMThFd0RweDVEaVlMcXBsalNvSHVSSWx0?=
 =?utf-8?B?OElqb1BhbVZqUGZ0V1ZPTjhINzV6U1F3azVyaDU4cDRLWVJLYUpFdnlCTFRp?=
 =?utf-8?B?MHBQYjcwMnRkK3V4MGZuR04vc3Q3ckJUdTMzY3hJeHorMTF4V1V3UEsrMVpy?=
 =?utf-8?B?QXc5Rm1PTU1xTzR0SWgrQUc1K2pSTWlObDRXRXE4TnU3SEtvMkdLd21mR29h?=
 =?utf-8?B?U2xjeUZZRHlXL2tteFZjb0F2VXVPWDVQVnJrODk3N0hSSjRrQzhYaS9kRUQz?=
 =?utf-8?B?ajFTZXNKdzF2bFlLWUZMQ2hweU4xNklzS0t3cFc2YURGZWZBWWhwcWVHV2Iv?=
 =?utf-8?B?NkIwYnFuclNISGhITno5TWlKNlpHdExzWCtKL3VGc2FYbzBjeVNCcTg3YTJh?=
 =?utf-8?B?bWNadmozMEhFZ1I5OXhLdXdWcHdDWDR0MWtIVFBQeEI1M1MrcFlBM3c5QW12?=
 =?utf-8?B?L2dUL2Vnc2dIWDZCRWNmV1VHTmhWVlZGMndWQ1hXZGZOa3p2dk5nd3k2YjJv?=
 =?utf-8?B?OVlYS1N0QmN1M1N2OUtERHlMVUFoOXhNcEFnK2VmWmc3TWR5SnZndkdXZjI0?=
 =?utf-8?B?dmdkYnlBbW9QSVYrTGgrTWRSZlg1WnVyNHpnblRBZGZJMzFSdHdiTnBpSWxi?=
 =?utf-8?B?ZFNDV0x6aUJITFVBWDlja01PQWhGZGhJcDZZVFpNc09pVEdRTjQ2TThGTmN3?=
 =?utf-8?B?N1kxR2hsTnl0eFdNRXMvbnBWdk9zSzVRREE4UXRvVnlPaUJreXdPVWtmMjV3?=
 =?utf-8?B?OFNYVWV3Y2VkUHlJUGZNem1icWdhak9hNGo0L3YxWUJZeEFVYkZmS1g2UjlH?=
 =?utf-8?B?RFZ6NlYrSk8rUTd6WFI3U3lseUMvSy9Wb0JwWTNKcjBIVU5RUERhQ1BmZzhF?=
 =?utf-8?B?aFArQnNYYmpuVTYvcWtUa3dia2VnMzgvYUVabTZGVnNrRGl0TXgreE1kTTZU?=
 =?utf-8?B?VXFoOFRyZ0FFWktuOE5vbVV0cFZqWk1QTDhEaHp1NStEYk9iOXdOV2xXdTFh?=
 =?utf-8?B?UXUwVTdmTng2YnZkMXNTS1dUVWtQZHV2YnZFdnhBbDBFc0RSNUdVRHI3TmFo?=
 =?utf-8?B?aVpTdnRUUDRCYk1laTlLK3BFVit6MWVCbEJWR0FDNVVSakZFbkg4UXRkckpO?=
 =?utf-8?B?U2hmMmh0UW5uWWZ1VjYxdGQwK1RPR3YwM0N5WHBKMzZuTUdPODhuSHgxUEFN?=
 =?utf-8?B?RjBUZ1lVY090bFhGN3oxZ0N5R3VleTdMei83cmorR0N5OHBpN0YyQT09?=
X-Exchange-RoutingPolicyChecked: jMnDj6U+m8mLq+xQ4DAubU2UOkujOrPUQTpI39Qeaiv/B0y8vpdVw6OUb5/xIfWszjo7JZAD2R8K0pXmvp9SGB1zjwiTpH09BDJ13EFb9Kn7GCndVCHtv3/wsmivDWxhgL02QbaLS+7WEPtajBGAo2deo3Ke4mL9/FF7D4GMZw/9zGxy6Z3RTaOeT4C2Q8Cjkg2tjYvEDzTQhLkALYXMJZC4YaDvZTjHWoDwxjhriqUBkPNWNhj5ccF1Rj0MJTLLlgSLGmNMXSloA9payhoIiug9KFpzj8xAZmQoGG1x5wkOozyS+thAIUjIJbBW9c1i8Fdb0A2mjoCQW8qgWBg9Lw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: D7fHfINeLguwSMhWXKreM7XvSZ/VSFfG2r7ac0TBdDIUSFMPGhAbzLimuwiVGDll5IixAI4nYfkQKBYYW6u4Ork4NXVZmk9iQKm9AHV1MPT2yk8Y8Ik/b0g5YGKNilNAlPeb4Kw6i9gc2kXypw+CGzrsI1S9reuHhpxLAmSrc8ihJziocutZWRTy6L1CYh897zKzcYdewxf7L8/Es063jM7pJ+jDjk+BDV9smB8CGLsEnzhgMU6dWTZDMLJH4akqDb81AlAcyBqrpQMI0wuxMoWECRtpxcYLKZM0ZILzoxmCFfDz04hn/6m9nHdyIQHTMPYxXRFUT00uH1hHdIOzM8MKj1GInJSh9qiOvG9DNgOjYtCtLybgbeXZs2sTHaKpZvVNJ39xdKIB24XAoRmgRLxh8WQfSebTKXk8RnnWzY/myCU6Y615xghNfOtFa3nHbL5T/4epQgaczhy+bCCO2rSE/NlHJhcobtUlqDMxpRU7HAagJNjXvqDksq5uO5EVM+SValkm/GxDLATKGHmS6MCbbgPOixLfznPaKObBa23VT8eX8WdhThkPNfuNkY8fKPVdgEQRN/06XPeE3RwPyK/kGoKEKq8IWXZP4gthgBI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 703cfe27-c435-430e-c53e-08defc6e4fc7
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB6229.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2026 14:46:25.1498
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LBZcgXxazDEl6orbVXJ6mA48xP4aqik77y5yGu9UlZX9dYI8vgbwUvw/zsVk1Q9fDoZJyTxdYwjp21kRIRpJ0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7512
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-17_01,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 lowpriorityscore=0 mlxscore=0 spamscore=0 suspectscore=0 bulkscore=0
 adultscore=0 malwarescore=0 mlxlogscore=999 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2606160000 definitions=main-2608170113
X-Proofpoint-GUID: VNjk3voHDmyZM5dZoI8M_GNTmvGTdiy1
X-Authority-Analysis: v=2.4 cv=Hu9G3UTS c=1 sm=1 tr=0 ts=6a831ec6 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Sv0fKeRqtYgA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=EIcjfB9IiI4px24ztqRk:22 a=yPCof4ZbAAAA:8
 a=7HAp8jRhqBNchYNQ2P8A:9 a=QEXdDO2ut3YA:10 a=6pWzAbgKvXYA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE3MDExMyBTYWx0ZWRfX1yLZyExmUXlY
 Cior8wX/cUsxu6fR8rDQPShzidQJtvjq8EnFdvIBzPwmrS+yhhYQEP+fTxaM1HzW1aMxBR5Mt8i
 83nGoTgCTLfFc11zEf5r7QI7HOCCWLa47jA1NOkdz3+SH9q1y29V
X-Proofpoint-ORIG-GUID: VNjk3voHDmyZM5dZoI8M_GNTmvGTdiy1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE3MDExMyBTYWx0ZWRfX97OjWMN9dbkJ
 1sHoHE3u+ce4YdP9ZOLuQjCPyZc9kn88pOAJ1U902FGd851lNnoSeyBW2Hb+9SZYQQ8Mr+ANXdq
 Ly24pTY6jXyBzgGDJ/zBqy4o0R1fBzulnHLXuXrPhsSf0JD7fjCWhv/8Yha0/TVJqtHyLjeCCdE
 BUBG3ag2jHhSKtkTtm23e3+p1VJN9iIceyE7sthqKcLiz5uFKd2fC48BD1xmEK/8AY0D+YQ4jI1
 YlXiIeNbRKsrUEYz0iTHf5x5iIWuNEIz/2tyjLz7NNP7FyLOZEPxS1ys65E4bbH1mQLB4Em2rCS
 nL5ZGwNh292y4Mvk6Ii5THZX3QjO9NOe4zx1QP8A6jEBlxPcF1fKv9hVyioZ5nGajANR7FpfIuL
 CfYjjqysOmSib6HoMvMzbyn4wfcxuhRVIy8Z41yHt283tREqKGf6AaNh+GENlFWOAeEM6k6BRZU
 1WLAekO3SOJHyO4xXRA==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260817_074645_142132_5CC380ED 
X-CRM114-Status: UNSURE (   7.98  )
X-CRM114-Notice: Please train this message.
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 15/08/2026 01:14, Tristan Madani wrote:

FWIW:

Reviewed-by: John Garry <john.g.garry@oracle.com>


