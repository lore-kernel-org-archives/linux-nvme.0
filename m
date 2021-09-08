Return-Path: <SRS0=Nr0d=N6=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 553C8C433F5
	for <linux-nvme@archiver.kernel.org>; Wed,  8 Sep 2021 00:05:29 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0550E60E97
	for <linux-nvme@archiver.kernel.org>; Wed,  8 Sep 2021 00:05:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0550E60E97
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=xTlQ9LTem2vMLUh+BbVoNSMbPKDoO1tWT67YrmtD/jo=; b=1ElC3GA9zu7pSP
	ZeOIuU4cgy6HtIcFVI/52wrNt0IsQZNRbVZ0t1LeRZvUt+JpUQc2uXFZjEA1unuQpbBkRr7JY4NCt
	lIzBFPeXkYD3NuuXY2Y6NNoPsEZ2bcvpE3w7Q3x92La5LkycoKd1OJN6+Y/++Vr8e8dEXXqx3CU5e
	J4bR4qUNqBITm5+I/SAHb+a0/b7PMQM/1a3OxptabXYvfmO4kQKKh7Y1bKlqcomzI6w7/hY2o8jzK
	fqXX3at/XopSPC+P2G7rMdhOnJMyNQBu7LkCHfuRAAr0LTQ7s8sRvJ0X5DbQ/47db1Qw5Iw8s5WKP
	bWoEy5VA2N5PzegZDlbw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mNl5P-0053kY-9Z; Wed, 08 Sep 2021 00:05:07 +0000
Received: from mail-dm6nam11on2088.outbound.protection.outlook.com
 ([40.107.223.88] helo=NAM11-DM6-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mNl5M-0053jT-BN
 for linux-nvme@lists.infradead.org; Wed, 08 Sep 2021 00:05:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nx7ab4C5yLFUVUnwASrROnejCz3urRnr3/NXaPKZuaZOLlNOgs5fmRIhXQoB5YoOQDfoaoyw60VdleeL9nJQGyfARljrYyFlOIq/Lfn+8MCBrKli2DpE999mv6XCRdpcn0t6rWmJDokEif6USmpNhe+aobagueLtNIjjVOoMQ5INqHCJOhwvgS0hXFLByAgK2soa+ko/FtBti01bYDn6hYezx3TMkhfzlXrNlYvGbtjxxkmiSdvgZr2WAb6KnpkDXTJ0mSFngiYwUMN62KRChb+uPPwdV/XK/v7RnfeUoIgOAdSSjssEmp8k/Ob3NyA/3usAMKA81jnv0fmsSHWnKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=l33lyjtrdamq9yLgAAt5/Ra7SCOaKMAdYDYt3SbQ8V0=;
 b=QN64KvrZSZBRuQW6LDurkQzU47ze281ZzH8f6yQNyyoTAFKrFE5FiK6/Y9XDKTwS+tXRUPPXRjBLFkNsf8ndkXW7UkBZ7074i49ePdQgJGQV59FHA5rU0lYD4gzFmnkRDkzziZ/+0JVslIw2n0q0fOp6yhgzqPkEA2GKdrpNjVC9vwoUACkt+oJCpmUzZWYs2vfqb6FFgpL1CMkDrZLJcjpuF3F6wGRVI+xIk8q9195DuRdec4+rOaEtAdmDLMIpHp6oYhH2t16cnTABrDHf9nsR5DLKwM3fvNQQf+TXe1Kjhh3qK5vC9TDEOfQYJblcFGSiXqHpNnDpNdGwq+8slw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l33lyjtrdamq9yLgAAt5/Ra7SCOaKMAdYDYt3SbQ8V0=;
 b=fOMPDzRQS6cuthZpIHkcnJiq918C0rjil0TTyR/Re1UomNfYNxF0mSNj0IO2PVnKaZuwn1mktaLzrpbJSEDUBwLCq1UwcSOU/q03d8nS1e5kP3/bXrXeQzqBgbN6OBR+dK3jLdTmDruB26EeaYAi0rQ59ltPQO1l6XMz4k8z5kcwHRLr9RGz4mFg5/6uN9a5yllQpvUY727Aoo+lIhQFzhdfoxDLk9E/i6eblZpPki1NFN0wK3h6l5W0REEYe99vmjX+prgK/L/r3P7M/bU2K9rD3tlt4nuoRYMKD0ispU29UpnQOdPNsQaT+QThBszIRdMr97Ltb8Q0qCCf9+OUcg==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by MWHPR12MB1648.namprd12.prod.outlook.com (2603:10b6:301:11::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14; Wed, 8 Sep
 2021 00:05:01 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::498a:4620:df52:2e9f]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::498a:4620:df52:2e9f%5]) with mapi id 15.20.4478.025; Wed, 8 Sep 2021
 00:05:01 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Keith Busch <kbusch@kernel.org>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Chaitanya Kulkarni <chaitanyak@nvidia.com>
Subject: Re: [PATCH] fabrics: fix return value of hostnqn_read_file()
Thread-Topic: [PATCH] fabrics: fix return value of hostnqn_read_file()
Thread-Index: AQHXoroqEKkt/S4cx0+c5U33VfQsgquZGWIAgAArfgA=
Date: Wed, 8 Sep 2021 00:05:01 +0000
Message-ID: <45d66255-4ba4-b25a-72db-3ab99df0021f@nvidia.com>
References: <20210906005719.296481-1-chaitanyak@nvidia.com>
 <20210907212920.GC591280@dhcp-10-100-145-180.wdc.com>
In-Reply-To: <20210907212920.GC591280@dhcp-10-100-145-180.wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3953be3f-1e51-4ccd-4ac0-08d9725c4daf
x-ms-traffictypediagnostic: MWHPR12MB1648:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR12MB1648F921DEB0BE0606F40C78A3D49@MWHPR12MB1648.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gb4LYGDjPLQMvPm/2q0whFwmHn0503aN4XOBWKNA+MTIe1gfOz0mzxmWZqEi9RGlNmactPD/KYYxzNmdO6RosPBTXfNYWkqkuOCClkgWBsKFeY0iDQ3X4eyTIMTgXM/QNV+27jdyPsMuuOAd1bLSpfVns0KhRty0D4ZBT2RmL5KmwR4LTG/B2filNIZzDvbqfEdSflQG+Sq1XHvhJ6f2GhFbq8NjwjzUxJkw1+yw5YIYJWpIu6O6ouVzs7oCHw4e2r5m8L5x9+0Q8Amc2cOGJaw72FG3ZdH/xJZjLtUniG9n6OpibR8aSRdQ2jUzT4BeGdvUNsstZuWWvGOXlDhuAzdXNIeHCckkYVBrijEdhk05eGgTESneq77R5H4ZsAonNUSJiQNobwjsiIUWmuTSNA0+perTMHPJ8pr95NKEP0Y6tOgXrRu1GGwNemfyB2FbkmYKyUuJrGSOpAwgZDOCXzmTl7P3tz1R7vtY6hqXvbddGXg8RBVto0Rl7uAsJ5E6eQeeBr/UxamNyAIMgiX7WtIJeM38OSK/9T/YZT8lCji/jVAZWvdw6stH/jgJjsqScOODvNFUoB/zsYEByrX1fatjepG3W5HuvD05JsFJCrPP9hJdp+1p6bhzIqO6D1bcMlfybVL7b/WOzmRvtuqMcCWfRxN3f+VYFLHc5rdUISgNf5dbu72xlqS8Q7RK03Vca0e0MIcBJTdMO+ptk5Hsk5Wcp5HW7MoaU/k4s0JoAngqR4D1Kkc8tEd/pHI7VYLqmugsT+0egcg6qdgOlGq/zw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW2PR12MB4667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(376002)(346002)(366004)(396003)(136003)(6486002)(66556008)(66946007)(64756008)(66446008)(478600001)(6506007)(8676002)(66476007)(8936002)(5660300002)(186003)(76116006)(91956017)(6512007)(83380400001)(53546011)(4326008)(71200400001)(107886003)(6916009)(2906002)(316002)(36756003)(86362001)(4744005)(2616005)(54906003)(31696002)(31686004)(38100700002)(122000001)(38070700005)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UHlzVjEzR1ZGQkhmQVVqWVhaUnRScnd2QlpkRS9xaWdyYW1xQXZIRHVrTi9r?=
 =?utf-8?B?NjNpMlZHMTNsL0Vtby80K2Nxc3VHUVdLdkxLVUUzSDJoOUw4ek5VWVJhS0Rp?=
 =?utf-8?B?U0d5anJUbkVCVGY2NlJWWjc0QUFTTUthQ0RMdXdxbWtJYXdkTzdERCsxWjky?=
 =?utf-8?B?emVtandWRCtyc3pCSUtDaXJwRDkrdm00cGtpL1JIUC9DR2VJY3dEcStHenZY?=
 =?utf-8?B?MThES2hKaHMvZkZjaE1RejRxekp4UzgzMHByZDFHMEFxMlFRMUZ4cGExVkxK?=
 =?utf-8?B?TDJMb1haUUZjSHlDR09aYTJRK1kwR2JzTWlBa1RWVGMzN0JBdXVCd2U0NmZs?=
 =?utf-8?B?ZjNxTVg2YkcxQVp5RXFZSXFnRVVPdWhGbHVlNDlKZGRNdVc1aWxWRlRMWjRO?=
 =?utf-8?B?aXF2ZWZLZzhqQ2lMN0k1RDlKSHptNFR0TUxoZjJUNVROYlJFcDRmb2FnZVAx?=
 =?utf-8?B?MFZFSEJmK1JGOUw4YlMzYWFobXVTbSt3ZWM0cVlUd2VHa0FTVjBiY2VHZFZL?=
 =?utf-8?B?YldrL3loM3NUM2NqWXBUa2Q1c0RZbTZzdXFPS0ZiVXd4dGtNSlRzYlFieS9T?=
 =?utf-8?B?ZmhkbkxJQ24yZWVQOWk3bG9zb2lUYjBqZSszdmdZaDhoRUxuOHZRT0xOdWNX?=
 =?utf-8?B?SEJqaFk0cEpuSU1ySzZVNmlka09oR2dUZFJmMk9vRE14TXZJNk9GbkZKc0JG?=
 =?utf-8?B?SnA2c1gzNlFGcE1hN1h0M09nUldrOXQwKy9qYllpaXR4VGQ0RUE5OHl4Y0Vr?=
 =?utf-8?B?ZzBxcDI0SVJJeTdLcmtYTGpLREMzYmhBTzIwUm1ad096ZkJQdG54ZVo2QXRu?=
 =?utf-8?B?Ykw1SzRkQ1JRbTBDQ2xaVS9wc242eGlYOVpyRkZ6R3lyWTFOd2pRdk5GTGNp?=
 =?utf-8?B?OE9QNmRNdUs5MitQL1hDTFM0ZWpOcHkwdzVvVGxJQlJDbm9ncTJ2bVBuNVhP?=
 =?utf-8?B?UmQxZVhFSnpwdEFEb083VW1QbGtodVJiNk5DRWpHWEszZ1ZQUkF4aUdoZDFk?=
 =?utf-8?B?M1RoeFhhT3EwOVA1a012c0NBN1NoMjM0bjh4SXFNM1FwRkdrNCt6SlM5V3V1?=
 =?utf-8?B?SzZRYXFmK2pYcGx3T2tUM3pkRDF3VTZmSXJhbTR0Z1dyY29HTXJzYTR6MU12?=
 =?utf-8?B?dTZvYnFrS3dhSzBHY1hIaVNIbXJicjFYM05KR3lJTEFaR0lKSWNvZkpsaU5X?=
 =?utf-8?B?V2lFTWNHbVJGdkMrT1Ixd1lpakt4cElBVFFkNWU1dlByZkdsd1dlRElDRUh5?=
 =?utf-8?B?VXl2a0VPL0hDYlQ1RjlYWm1jbitiek1wUEVESStlNTlZMWpGQytQaFNrT08x?=
 =?utf-8?B?ZkNqM2FJVXo2T1VBOHpnS1F0ZGFsMjJCU2NoS0tZaW1qcjV6WXQ1TmZPVXVz?=
 =?utf-8?B?ZkdoR1pXdUNoeEZQejRzdit0R2tUc2pVc3Y4OW5lUXhvMFFCL2ZiOXZlZyt6?=
 =?utf-8?B?d3hGcXBNR05vMnVWc3Voa0hYZ0s3OGpCbGptcC9TdTM2QUs1d21PRlJGd1lR?=
 =?utf-8?B?dDh3dGE3QW9RYTRKVSsxWTRwNmhYbWt5VEVvVHlYS2JkN2xKcmxDTEN6YzMr?=
 =?utf-8?B?Y3R4WXFlT3RMWFZBNEUxZDE3MVlDWlJwWmFaa2dTNGZ1U0trOWs0TVV1a3F6?=
 =?utf-8?B?a1FlZTFEamVlYmF2YklDd09FKzNYVG42WEEwL0FnM0pNNDdmTEp2NWFROEdy?=
 =?utf-8?B?WExiNEQ1d2RwWE1CUXhsVDJEeGFWNnB4L3ljbHM2b1hYMUpXZHJiaUl4azhL?=
 =?utf-8?B?U3ZJUWJUZHdtM1g4SkJRTkhWMzA5UVdkQ3FNRzdPS2NzYi9qZFU2a1RIeGFl?=
 =?utf-8?B?UXQzWUlWbXdldEgvQkZ3R1ZEQm13WTJNYVFXSFBYOWFQWWRRazZNQ0JpR2Yv?=
 =?utf-8?Q?N43CnsUAh7WC9?=
Content-ID: <291956375B62CD4BA0E89EB328B65D20@namprd12.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3953be3f-1e51-4ccd-4ac0-08d9725c4daf
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Sep 2021 00:05:01.1569 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +ZjG6QrMLVjCQdgj2kBg5iiWYUz3T3a4fWACkczxiWqD1Ar1+hx0FG7ZNb0PTGpO26tIUKTr0BaB7RloXjU2Gw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1648
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210907_170504_577749_786071B1 
X-CRM114-Status: GOOD (  14.63  )
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

On 9/7/21 2:29 PM, Keith Busch wrote:
> External email: Use caution opening links or attachments
> 
> 
> On Sun, Sep 05, 2021 at 05:57:19PM -0700, Chaitanya Kulkarni wrote:
>> @@ -855,7 +855,7 @@ static char *hostnqn_read_file(void)
>>
>>   out:
>>        fclose(f);
>> -     return ret;
>> +     return strcmp(ret, "") == 0 ? NULL : ret;
>>   }
> 
> But if the 'goto out' label is used, you are calling strcmp() with a
> NULL pointer.
> 
> And if "ret" is an emptry string, I think you still need to free() it
> here since it is not being returned anymore.
> 

Let me resend a new patch as this patch is wrong.


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
