Return-Path: <SRS0=w6YM=OR=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D94CC433F5
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Sep 2021 19:19:16 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2DA7060F94
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Sep 2021 19:19:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2DA7060F94
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:To:From:Reply-To:Cc:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=BCjREdNKXXciXYn2x+SPAuZrbOHZ2gytpeLL06fdbwk=; b=k1uFGoqnwLMt69
	1pE8dyEC9Q3ENvPaD11TTpxLOfyVZAfCNHH/NWoqnBmzx4ZskrUI4hAjLhGHCHTB7+SqlUrMmPy3c
	d2awbNk4PzPC7pKriNWqgL6/nE+b45rboZ9OYIsAIeNGXGvv8DZIgiMM5AHqBONEoj5Uyt+cHyUNY
	rJXZL79Vqem5z9iO1aBqnhUobd9C6ck2ASwifkPMG3iGXTpP4Q+K4lX2p+pB0HtRs6uI7MJKBobOF
	PwE/lz1aOPvLNUuT10hJQ8zPCvIWTgagCmrhXBEACOVSFbc6Rj1XypL8O8o0N5Qs/P9zK9FrrCPf6
	1qUiW2x98sYd0kzYRaZA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mUw8P-003xkg-7p; Mon, 27 Sep 2021 19:17:53 +0000
Received: from mail-bn7nam10on2045.outbound.protection.outlook.com
 ([40.107.92.45] helo=NAM10-BN7-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mUw8L-003xha-LG
 for linux-nvme@lists.infradead.org; Mon, 27 Sep 2021 19:17:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rk8gUFPd40MAqxh8gHsVaMX4PcXM82GRJBfkRk0uBv8cGTKcPtlb2IUveVDC7lLhrMrlz8Cao/SRJW1lexQyYceA+vTgZnGnrUJLWyd5UZklM4bC8BOxuTro7ojSoaJEEgOsOo7qKXDTvAU2vHI87BU9lM6NAUMULgO/xd8mgfEXDdUQGAmGI41Xfi9/hSIfv6e65q4kom3SuD6tJZW/hB3blYb9pvH39pFu2OE/3VcG5OttUnh6C7EIjYqFsS4UNDyAA2QMvcSMHlO/abRmetgZ4+zMjlGVrNxMR56S+j0QuDuR8Qru605mMYApLgOZIpcN+AwKv2qbDtYpRpO6QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=uRLRFxWUDqtHbQKmpB0WdUevNISUQmyB6BFSTaf1+Jc=;
 b=GMtCMz4GzVrd7yrsHZ7kTjvtrFPfz8WNevsq7aypj6sRWFWy7KrvFqCAz74XnaWj0D6e5ZQuQXCO4/YVcmT11kvsTD1KOs1xeWjjtjNAbih2+6kgtw/nT3gUVzh1z8MUK5pc/yysfHj8vaSZ+yzjEhYmKPHZV+GFXYLTUPMCtAiyntAfIbZqMpgLF3XDe058j8RFmwSPm2zAlxqdg46tIOPbSiyKXGzDdRJGEj49SkyhbhA/GACZzkqkEQRjyPisv6NT09ZYoA8M9PdnUa4NnfdwJh0t6zopn/oRDvzmvtw4RoSoU/o/cF4pxUoghKT+lg4Zn4feqlcNeyvqjJBAtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uRLRFxWUDqtHbQKmpB0WdUevNISUQmyB6BFSTaf1+Jc=;
 b=cEaTY/QJIXtAixdR4BcsaH2spyK3oVVemnt977I++RD5YiNqlmRutyfuJktcHOXEGHd/pCdvh22G7xmkhpWG6MZ2IA79sCdHrGSChP/fsT8d7c4sBYf0G6Nf+2CpnLX7PL2eQrsRCQ8zY4xm922GkRTVfvyFzYgdLcAjSyE4pt6Qkky/0exRA0DU8IHjV8zb1c8GQSsHqp8Zqpch7n8FOd5CPllM4Q3lDjaa3PqNJ0KnMUnc+/Uwj/eJh8tH/l1aV71eAs6JFq/vEKWey8+8bmSJPNdwocvOssX0lbPpbsXL4tQaDO4QV8cWV6Owh+d1y2uJoh1hOFu+eH68/C4FBA==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by MW3PR12MB4539.namprd12.prod.outlook.com (2603:10b6:303:59::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.14; Mon, 27 Sep
 2021 19:17:45 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::498a:4620:df52:2e9f]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::498a:4620:df52:2e9f%5]) with mapi id 15.20.4544.021; Mon, 27 Sep 2021
 19:17:45 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Max Gurtovoy <mgurtovoy@nvidia.com>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>, "hch@lst.de" <hch@lst.de>,
 "kbusch@kernel.org" <kbusch@kernel.org>, "sagi@grimberg.me"
 <sagi@grimberg.me>
Subject: Re: [PATCH 1/2] nvmet: use macro definition for setting nmic value
Thread-Topic: [PATCH 1/2] nvmet: use macro definition for setting nmic value
Thread-Index: AQHXsGRHO+duS/b8YUSATGSpiJ4AwKu4R+kA
Date: Mon, 27 Sep 2021 19:17:45 +0000
Message-ID: <114365e0-bd64-6507-4b4f-c7815a2a0fa0@nvidia.com>
References: <20210923101744.4204-1-mgurtovoy@nvidia.com>
In-Reply-To: <20210923101744.4204-1-mgurtovoy@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
authentication-results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 00b8cbb8-ec91-4345-68be-08d981eb7c4e
x-ms-traffictypediagnostic: MW3PR12MB4539:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MW3PR12MB4539060D0D6DA79763BE1657A3A79@MW3PR12MB4539.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:287;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Eg/Zmg67i9X7Ow92NisaVu4kciKk/mnB8THtIf8Y6Ie3Spa6z+4PSa3gL+MQPZ0NPJozlFrJ5NMTZOUJyuY0QQ0IKX5yR9wEoFfDXjXkgQR9z/tNg16G4rPAZzfjKX6JRooYP3RtBiUe5FXKxMtqFNFo6L05wnk5H1Fqsmf7Jq/Ahx5eoOqkBwA9Q+EHsN+rf4UbhB1AEI8L2rsudoj09PT+7l/adyr/LgHm7YMo4zVN1e85HbPYMLMTmYoE9E7pqPa/eyVsqTHHe0t114rGuuqqFIB5ho798xNAkC6uxgyolNZe5/udkV6+AMFCCKQr5J5QcQZ4GOh4e/vuu1F4kSN+MrBh8CCqrBSW6HDSZSO5WPald9apqMtM9DVaqJQZdepFa9bBGfPVLCCquNE2DzHIpM2lmIgJtrjJH1TMwc7faL+IlF49QKDSnfLBts05LwtFgIejPrebw2g57pMNOiHMsZykK33noQgM5miPqkdv0fDrI/J1wJhs4wx58L8llALRE/6SSMlXuAyIeXD3dvvocHXUYPXi+NK5v/ic37LRCxuZq6MEfRWvWvT39XKf98dfQ0Rwa0jSNp7R8djuiW2h33C2pqMC3eS9aCtg1YfxgEFyBcPvVVer8MLzv7LqS5JLcFnu6+crKSoWIdE3D5VA+lUI/+kQuXzFYUUuvpv5jRfskPQrNxWMok9jhpHP83nEE/a03TK5tHun9jwnpXjeP3DYo483o3WACEhQAU7hK89rZoLmJ7dV9I0Gjg5qgO4MU0K9PGDcHGeHMrZDFA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW2PR12MB4667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(316002)(8676002)(76116006)(31696002)(6512007)(91956017)(36756003)(6506007)(122000001)(6486002)(110136005)(186003)(53546011)(38100700002)(31686004)(2616005)(5660300002)(66476007)(66556008)(38070700005)(8936002)(71200400001)(558084003)(2906002)(64756008)(66446008)(26005)(86362001)(508600001)(66946007)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?K2RNSW1QNkxrbGtXSXF4bnRFVjMxYk5pMDB3dHEwZVZvNHhnNEJUUDZpRnE2?=
 =?utf-8?B?YlZFbksxdndnU1pqbUZ4anhpRkx2ZFMwdVFjbEVCbXJHVXJxWXAzWnJRQW1I?=
 =?utf-8?B?T1B1UTBQc1ovTmVhaWNHY005WVdySjZDeXZ6RHhCTVJmMjl1OEJJTjFHS3hH?=
 =?utf-8?B?KzBnQ1pMa1pOdFhqYUV1TURoL2J6WU96QkdJQ2pvV01uZkVPK1VLaThKalV3?=
 =?utf-8?B?YUlpRC9JVFRzMm9YSDF3MzVtSWZqeWU2QnpPRCtlSWcrWHZNeFE4QXd0Rmpt?=
 =?utf-8?B?dkJCcjMxZUVaS2kwbDNTT2ZCSGFMamUxRU1LRWlJN3lTMFRNSGNseWZMTWp5?=
 =?utf-8?B?SC9nSVZobHR0NGU4eDFydWdwMVZxN0hOSTlLOXpmVnhKYjhyZEh3OFc3OGdM?=
 =?utf-8?B?aG5qTTNETHNuaE11WEdjMmwzdlNybGJkYlZZWTVEbGphTHZnTC8vMzU2SDVX?=
 =?utf-8?B?YWgwcFlQYUh4Y2dVUEh0ZlNpNWVsS01tNHprMkIxbnNOaXZrWG12VXpvVHU3?=
 =?utf-8?B?SmtROEoyOWZkZnMwbWZ2NUpMekxPK1IwZ1NQcys2SDNuL2V3TENrWTcyaUhN?=
 =?utf-8?B?UXRFcXV3RGFoaHNqRm5FN0UzNE9Kc3BUWGhWaTNqcEFFQlFxc2FockdnTXJr?=
 =?utf-8?B?UnJLS1VrUVpMVjhIOTR1ajc0VzdqSFpwMndOWDRQN0FPTnZjTzZreGN6a2tS?=
 =?utf-8?B?bVA0U0c2NU9rV05EU2VkZW5lUTZtSmFvNEEvOGxtaGlQaktaY2EraFZFaXlo?=
 =?utf-8?B?MU5CRHRtVkphUDduM2pSWkJWTDVGbnFyZ2svQzYyb0hNZmg1MzZQQStGYzM5?=
 =?utf-8?B?dWV4dkJWc2RhSllYZWo2Z3ZEOGtiMWdYRGZJVldqMXpQQXZMY3IySEVwaGVF?=
 =?utf-8?B?bnZmSVorUnVCVkdabWIrMHdTN0JjWmw2bHc4WjNMY1VhSGZoR3pMcHpXekF0?=
 =?utf-8?B?bDVCbkhKb0wvZXZhejR0aHVjamwrV2JINmtDVi9acDdhQmFFdDM5Vm40UTNo?=
 =?utf-8?B?UnAvalVhQloxcFkxTHBxQkxTN1FZWk5vYTA2b00yeXVJdFVJbnM2bDZDZW1T?=
 =?utf-8?B?MkIwY3J5Z1BpNURlUnRFTEpSMlNnRS94cTFob1dldGJlTUZPUkdsTks4YlFR?=
 =?utf-8?B?WHBsOEtVM1E5cTdLOE9RZ2pvREVwdG1MLytJMGM1NmpGZkVoZy96emp5Mmdn?=
 =?utf-8?B?ajUrTlNQSXhQZ29jNjZUQTlsdUVVNkZiNnVteGVLOHVHVXJ6a3BIcnE4WExr?=
 =?utf-8?B?LzV2VWVvUTVDZCtVRGpPRVl4c1JzbTZuMnlJUGNyM0FWOEErMCs5dWhLS05M?=
 =?utf-8?B?bGN3UHJzMEMvUjRsNlNHcS8ydUpIRkRJbnhkZEpUdHZEK1VJU2NsUVMrTW5u?=
 =?utf-8?B?d1JXYWFkZlJhbkE0cXM3SUdVZnR6WWlIVFlETFZLRTRQMmp6K1FQVVNkd0xy?=
 =?utf-8?B?R1V5L0ViYXdlZ0h3OVBMRVl4U09kbGV6NC8zZE8wYTNTK3JOemVpTlZWUUFr?=
 =?utf-8?B?cnk2TTdmdTRkelRTc3pOcXB5cFdsVjVXbFMvZVZ0SWRCTmxYNlZEcnZqdlNQ?=
 =?utf-8?B?c1Q2MmVJbk83U3hvMUNlUld3eTZZMVBTM2dJQndEUWF4b0dMaWhZQzl6TXZS?=
 =?utf-8?B?RDVjUTJlUFl6SHp1SUlzKy9MVENCU2IzU0xjZkpvY3IxM2NMbmVmbHc5UkJE?=
 =?utf-8?B?VUJKeUdjSW03RnowcTdSRU9jVVpWT0NNVjU2OWlab2M5aHVlOEJNVEhlUHBH?=
 =?utf-8?Q?QBsXtOd5RMMM4Z9JJOj1ZDbdSM7meSK7DHcUphB?=
Content-ID: <9F2C17A73F3F44448C85405DE0FC505B@namprd12.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00b8cbb8-ec91-4345-68be-08d981eb7c4e
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Sep 2021 19:17:45.1467 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Sv2MzA561y8nsQKSGV/BDWHWpP7l+i4X/UTBjHVlR3pQU3vf4u/z1YYwjnqMCJWU8ye7JUOvlrWAlpCOlOckFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4539
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210927_121749_737774_3F0ABD75 
X-CRM114-Status: UNSURE (   8.92  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 9/23/21 3:17 AM, Max Gurtovoy wrote:
> This makes the code more readable.
> 
> Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
> ---

Looks good.

Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
