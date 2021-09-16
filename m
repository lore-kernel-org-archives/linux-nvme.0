Return-Path: <SRS0=Ydhk=OG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B357EC433F5
	for <linux-nvme@archiver.kernel.org>; Thu, 16 Sep 2021 16:58:06 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 75873610E9
	for <linux-nvme@archiver.kernel.org>; Thu, 16 Sep 2021 16:58:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 75873610E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:To:From:Reply-To:Cc:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=u01BAsVdKqhsFFjMtf73nTvFR4CohMGX7hUEkeokBsE=; b=AYVnb3dMf3J450
	Uaj5fui5oeIqomL1195V38K+sapHIQQL1ZI8id1rbP7gChiuB0rFEKZ8SpMYRX94BdyD0Mcm8MyvS
	GIW2naH8lDrxmPchvu7eiAoEK+EZZ1vup1AbzBQ4r62l43UduKK3/9e/CiL1KJzrA7T1fvNM4tk2o
	izfuBqdlE6X4L/LZnEu9iUlcul3yTH8eE7+KzgR/vhThL3jESvBDSWd/7NCo13cFLOzIRJGhKCD6f
	k8eh2Pu0RFuUX6OkZgGZ8P+SEbO4EeoozSRbS5JPfdzLZM2GYINzemBpsQ0S0v1nP3yqMQB/c9m91
	9ETwvVy4reVpCOfMPgQg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mQui2-00BnKl-JD; Thu, 16 Sep 2021 16:58:02 +0000
Received: from mail-dm3nam07on2078.outbound.protection.outlook.com
 ([40.107.95.78] helo=NAM02-DM3-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mQuhy-00BnJW-Vn
 for linux-nvme@lists.infradead.org; Thu, 16 Sep 2021 16:58:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ORNUXu7dVsO6F04ZMVjRsPebDqiQN8w92A+YsNAMSB538ATWnYEUAarEyyU5Z+pO0sjyZ81oTEVp4rig5/3v4TrPCT2+uPzZkeS5XQP4UVgkcLvAlHqNcVmWuItAP7IrBNGLrKuuJIdxqhY96OGFAy67st0NyLCYgMKsXztto/xL8jhC2Jig+17ATJPfK7asl4dZVG5QrS8hIxZDWWvbCbYnDwlWLam27UbpOlYPIKtHnFqjvZCNp/H9pLA5WC32oFzodLYvvafyTz3YLBrX+eu4tu90gcVZg9NHWwePkNZ4phXVX0GGxwp3hkr0XI04KmnU16IeqDVgu52VlrzbFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=jP1H49EB3jbLzwy+gak133G/TPf1Vi9ZD+eEEHcrTHk=;
 b=f/98D5hjOrcfB9OrBKDxwQ81v0+g1lLjqF4GhLf1+zkTrPifkpjbe8+v/AEQm6RaaUTlnJ4ywVkxOLODA/6WeyndiakUQDQRL4uzit+hNLdngQaVdZ8F+bxZMEOztfKj7ZCxBpsZHWW0rokx/Vx+ztcoKURgyKAr0NHBqmdwrn85char1T82XkmhVsET/zf0F5z31Uys/eLx+DiXwKU0dPq6U7zJ4pS/1KgXjY4RDRgunb9NLRliCaEcgOVq4YtzWycte+sqjwcuEupZaypBa8oxMooVMRvwH0av2CzY4QdVMClbw37OPkIQoH6Oi5fgEQAdKqtyPcLZTwxjWWEtwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jP1H49EB3jbLzwy+gak133G/TPf1Vi9ZD+eEEHcrTHk=;
 b=bEyCsLAZv5WgjuH1DnDXX4CX24XH9eEGAXIolijbqvE3C3hzMorNtAjFTeD+oVAIH9F236W7ZCM3uiuoTKtP2H0r9ADrI8s53jdblyCtOGoj1fJqjaf4hiAAu3X1qNYOxLHSFmD5ljM91AkMGlbW0pyfjhtcRiEk5NxqwsQ5ZfyYR/lblLhRRHneHTCZ2ataWDa5nWzoqI1lQXs4JbtcrIKJ67XnviLmkSEx7/NqQHBwQcU2qU5lY3uW5No88rduAiUAL4EWdPrIQECqWrbtCh0xIYdE+7w5+qHGdWiAVjd42pxgWO1T6goCDl6//myKfFivAjbFGjjYq315ldItyQ==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by MWHPR12MB1133.namprd12.prod.outlook.com (2603:10b6:300:d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.16; Thu, 16 Sep
 2021 16:57:55 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::498a:4620:df52:2e9f]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::498a:4620:df52:2e9f%5]) with mapi id 15.20.4523.016; Thu, 16 Sep 2021
 16:57:55 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH nvme-cli 1/2] add "State" entry
Thread-Topic: [PATCH nvme-cli 1/2] add "State" entry
Thread-Index: AQHXqjX+qLkOu6lJ9kOR5FhfD1ibv6um45CA
Date: Thu, 16 Sep 2021 16:57:55 +0000
Message-ID: <74cf36c7-9e18-2b81-08ba-cc4223f3b133@nvidia.com>
References: <20210915132912.3004-1-chengjike.cheng@huawei.com>
 <20210915132912.3004-2-chengjike.cheng@huawei.com>
In-Reply-To: <20210915132912.3004-2-chengjike.cheng@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
authentication-results: lists.infradead.org; dkim=none (message not signed)
 header.d=none;lists.infradead.org; dmarc=none action=none
 header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fcf4395b-39f1-4751-5d4a-08d979332105
x-ms-traffictypediagnostic: MWHPR12MB1133:
x-microsoft-antispam-prvs: <MWHPR12MB1133E5127C161C13A4AC9880A3DC9@MWHPR12MB1133.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:270;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: klT3YTijxv8HcaHiFNErALDioZZVCxYDsQBt5Dj7Ghc/0ZH+LdJXUt8u3Ex7U7lJWOyzZXcl/I0NeyUP/MCSY+pS/vRe8LjKQmufmJ4utZeKAjJrn8FKKe2V4IZDZe7aXAJou+U8QfdxFPLRC8Ghhcx3MLIiCm+Cw6UkUsGQ/SCvN9kXnkw9fuwuHVTmpcPjPYXRzTW/cXOUQWDcN6PYgd2ZU3HjGZj5vdBOVaf04fzPOYNW0GYRUV6F4vqLDNBXTwnY+vEP1ds5dQysFjCxVDjDS+8yo2L4ED87u2/TqP+mS4uc9dXmqLcV5LHSdIxxMu4z9TsBXw9YjbN01J2J+js2mGBNbAUPi7op19Lh/UUurz+arUx+bVzRB74PkNVciKNAOGtrHvnjxH12vjpCDnXg7tS+CBz4TOx1WaQHYoBPnHk6a0scGgSJPGxJlCu8Q8qqknPmhYjVpSnijbW7Eg9SsmytnGfYRJqdBCDtHN3ZDDOtBUmkVfnwryheoSp68R43MVxA0bJJM2t/PgDgeWi2oIAy1FBOwNJyTg1qtx9jUQPBVj4Un/7IRF9vctikVCu3LWiup5j0mR4nB+0KWJG+eyrCbDuuf0JzVeesaO5hOnU5bEtoBJBCQsjsdrQMbU8rpnW+tJuCitYfUeSFYxCbnzqOlOyf5pHusftVoS08fB4cwpyQdCF26mb+LyC9UZbQJk9kAm4vaExSJKuUveI+ZAhtPD5MRFagNIb2sxzwqs4oJf5YheVpZ5ZLK6vFBcC5T6fCUMqJGoqJQ4f1Ow==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW2PR12MB4667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(6916009)(71200400001)(316002)(76116006)(66946007)(66476007)(66556008)(6486002)(5660300002)(64756008)(66446008)(6512007)(8676002)(8936002)(53546011)(6506007)(186003)(2906002)(36756003)(83380400001)(122000001)(38100700002)(86362001)(4744005)(2616005)(508600001)(31686004)(38070700005)(31696002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aDVoN3Zrb1o1K2lUK0d5SVRGcUxGOGVRY2wwRE5ldEZFSlliM0RqcjZ2aWVC?=
 =?utf-8?B?dkZKWm83NGJhMlp3NlJ0QmxrMnk1M2oyZmQ4RmZiMzdBNmg2OU1LcWJGWWNx?=
 =?utf-8?B?eTNhZ1J0SEtuOTBaUkpsNWt0VFJjTTYybXdtYk5HTHhFZHA5SVdLNlB4Qm9n?=
 =?utf-8?B?dGkzYkdtdXN1RkRCdHlhMGt3S1MvWS9MRWE2YXZaSkNwWkdmRFRTNDRsbENh?=
 =?utf-8?B?Nm9RZDFKWE5kRTErR0c0ekhTWDhtUWUwU1kvNlg2Rlp4QUJpY3UrNjZ2Tnha?=
 =?utf-8?B?ejdBblVMWUNBNlh1SzRvdk94bmppZFhWSXdMWXMwWWN1UEtid1p5T2U0MjZU?=
 =?utf-8?B?RXNObUE1QS9nL0d1TEZodnpoeTB6NUduN1B6QzJnU2gwZkdMQ1pRbGpHODN3?=
 =?utf-8?B?aHd6YjU3ZEJuRDJFSkNWdllFWEZic1pxZW45Y1hYY3pXeFNRa2JpbXpVSjA0?=
 =?utf-8?B?V0ZPeFdLQ3kweEExZmVCUS9paEtzeVZVdWZ6emJXUlpEZWhMV3BvTUVnUDJU?=
 =?utf-8?B?ZkhFTE90bGR1K2NxMU94WlZZNXRSNVVqQnJ2TU5PcnJaTjZ2ZHh2bjcrYjZn?=
 =?utf-8?B?bjlpT2h6SWNBaHc4NTFFRXVYVGI3N1h4U1pDeHBQcFZiQWVqKzhvVGMrWkps?=
 =?utf-8?B?UWUwa01yU0RHa3A0MFJoVnhsNnN0bUhReDVuNUdSR1krRWkvLzZLOWRGYmdI?=
 =?utf-8?B?VWlNdFg2ZVY2NUN5Umh1OHI4S2RiVFY2Sy8wc093QU1xYjAvWnJwV3RFTVJD?=
 =?utf-8?B?L0VONzd0dDJDSzJMVkQyTDd1aDZnSGhzOWx6aGVLeEthZnkwYkgwSWVVbVJu?=
 =?utf-8?B?Ym5HUmpLOVJWdkkzY2NzZGw4b2tNTk9iR2RGa1IzOFhmMXV6bk9pNkE1bWZx?=
 =?utf-8?B?SDdFbit2STJMcTFqRzJaeENJeVN4bGpDZjdHUjRVL3lxK0hqUWVVMktLV0pT?=
 =?utf-8?B?bEVXRVhYcGxkVmYwQ1FKdkFvcHJKM2MycWs3Q1ZCN0hOZzBQUWhONkJaYTU3?=
 =?utf-8?B?a3ZnNy80SEZkRjhxU3VlRVJxSjRZeXNjdDRlYS8rN0RPaFBFazVGN2ZuNldT?=
 =?utf-8?B?OXNGV2VrZ1Q5RmFnWUFrc0FvN3BuNmhENmRDRU0rM2JtYXIvN2Fmd2laNUcv?=
 =?utf-8?B?QkQzcFNMNFFhUWpwWnd4a0xuUUdpZUNCK1lPWmQvUll3K2tlQVNBc2tMN0lx?=
 =?utf-8?B?ZGYyRWg0bmlETVRDUGdYdjRkZ2s4ZXQrN2hMYkxxM3RtTmNQdisyTXlJSHRX?=
 =?utf-8?B?cUF4OEwwN0VJV0tib0Q1NDFIb3hiWmZDSzRjSGdUTXBTYmJ4WnZBTVp4SmdM?=
 =?utf-8?B?ZVFQcFFGL1JYVG4zbnFpSWRra0lkSDZ3WnBWaUM1ZkpkeFZmYU1oL2ZQdm1F?=
 =?utf-8?B?MlJQbitLMlZycHJrTVRiT2VUZTR1elU5Sm9hU09meTJ5RThsT3daMmliVGhC?=
 =?utf-8?B?STVuUExSNTZTRnFoa2hLU0ZpeGpUOTJQcWQ4T0FKb0Rjbi8vNU1Ka2Z4VFhW?=
 =?utf-8?B?akVxVnJ6WUtnZ0R2c3dyYkp1K3NyQXNvWCtVcjFGUW5JQTYxdXhVS3RieG05?=
 =?utf-8?B?S3kwWWtlWGRWS1FnaFV1OVFLRzJoUHlqaGF2QThYSVV0QTJiN3Z2dTlRNnhU?=
 =?utf-8?B?anpSMzRKZDJQV0JzZFNZa3pSZ0FSblJRMEVHRXllK09hUW14eXdQWjFzUEhz?=
 =?utf-8?B?b3hlR2RsaW9vY1lKWjl3U0Q0RkorbVk3RE1USHZDWCtCYnQ5Vk9KUUFMaVdi?=
 =?utf-8?B?Ykx3aVU0MmRQZmFhZ25mVUpBcVhRWVR5QWJhMUZEVXhtYWR4bVQyd2xKL0lB?=
 =?utf-8?B?OFkvc1BlQ2wwOUZVL1VWT1RvaGpJWmVzL2pST0ZFL3pZekdLcHRCZGVCeXNz?=
 =?utf-8?Q?rjb384g+W7d11?=
x-ms-exchange-transport-forked: True
Content-ID: <3C72247ABA04BA408BA5F8423FF85B6D@namprd12.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fcf4395b-39f1-4751-5d4a-08d979332105
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Sep 2021 16:57:55.3408 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 54+wUhH0qdZozoKhLnl73H8cwouxLeCjaQApRdERANHlVbqdqvRCktw0HMvuBrVN5WT4xleGk3lH/iYcZaBaQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1133
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210916_095759_083197_C79CE9FF 
X-CRM114-Status: GOOD (  17.31  )
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

On 9/15/21 6:29 AM, chengjike wrote:
> From: chengjike <jiangtao62@huawei.com>
> 
> Add "State" entry in nvme-print.c
> 
> Signed-off-by: chengjike <chengjike.cheng@huawei.com>
> ---
>   nvme-print.c | 15 +++++++++------
>   1 file changed, 9 insertions(+), 6 deletions(-)
> 
> diff --git a/nvme-print.c b/nvme-print.c
> index d321ec0..f2b12c0 100644
> --- a/nvme-print.c
> +++ b/nvme-print.c
> @@ -5647,10 +5647,10 @@ static void nvme_show_list_item(nvme_ns_t n)
>   	snprintf(format, sizeof(format), "%3.0f %2sB + %2d B", (double)lba,
>   		l_suffix, nvme_ns_get_meta_size(n));
>   
> -	printf("%-21s %-20s %-40s %-9d %-26s %-16s %-8s\n",
> +	printf("%-21s %-20s %-40s %-9d %-26s %-16s %-8s %-8s\n",
>   		nvme_ns_get_name(n), nvme_ns_get_serial(n),
>   		nvme_ns_get_model(n), nvme_ns_get_nsid(n), usage, format,
> -		nvme_ns_get_firmware(n));
> +		nvme_ns_get_firmware(n), nvme_ns_get_state(n));
>   }
>   


Where is the definition of the nvme_ns_get_state() ? I didn't find in
this patch, and your commit log is not helpful at all for the reviewers.


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
