Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D0A1C433FE
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Dec 2021 22:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9fw8pNv/Sp2odqZMbt76zo0iOMFt5JC3LgGpQY8ekNc=; b=kPjem0y3ndHovA4VrkF5G3V2lp
	LiffZnYd1oJZ4ssWDpuUJ8ZJZ4dS0atRKG0z/w3wq1Pfs/lR9+Mecrc5mr5PqoHRNTwqjMaZCaILk
	SuOPqWf7ywwc8Co3Sd3SjLIKoZxvIwzJEWoUKG68SOgnzJ/1QIthI7qc0LCaBZrgiAhiowdJkWc8z
	6uyNT0oIuQOKHwXxckmk5Kkzs7h5BQ8gvJl4XV/k3+k0hgLFZRRUc4bFOM0xnWqHiX+89mRtXfzNY
	+2F2976DExtGtVvwf5xbc3Ewvgy4WjN0Uv804Lw6oAigVW2e6IUzQICuRti6DAjEe7TqvqwJZAETS
	ALKJxJDg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mwu9B-00BraJ-2x; Mon, 13 Dec 2021 22:50:17 +0000
Received: from mail-mw2nam10on2070.outbound.protection.outlook.com
 ([40.107.94.70] helo=NAM10-MW2-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mwu3K-00Bpde-Rx
 for linux-nvme@lists.infradead.org; Mon, 13 Dec 2021 22:44:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YWW4pIklx3qp0aPvmbBDK14YnroAXUZQKOc0ljh93UMbhBu/SYTJw02TqgkMfHU/oNEqaXgTLazjeY/yIdoqzV1U0uMocJW05llsK2fCvfgecGFprp8lZiud705ZYqliJAxxl5TocRvFfbrX82MUUOtWjIMeE2pTR/QcMamKqMXx85HFxRjFCPlYsZjxlfzQCxbsM+S5xpg1VYkaz579wq8kEG0e8MjZL3n4kla1M4CMeb9OWWqy9yI06ksfWzlQot7wBjenH+EMYmjJfoNujrj0sSKC9a3shyA7NJtIUPRSnHJHw1KTtrk1Pju8K2LZm1ookPyZwQQMeE/WEcXHhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9fw8pNv/Sp2odqZMbt76zo0iOMFt5JC3LgGpQY8ekNc=;
 b=ZAcdByNunAO2EH1+JsUVO3Yw6vQRogRDHoSr9F8rf4ELZ53+zyBbe3uduXvA7zc0bGtYP/FOt0EBFVno/Pv750FElvCogDQErE0wYiqoVoQGSfSS69W9nerqJqkDpt9ef3rnycLNc1oX5aWq8cfYGI5f6MVuuMtbOcBS6Fbh0oJaXWt6bsxaknZnP0T0ld7vMeTeDva2ZLSw/0AzRl4yxs/2FKX8jFxOZv91nm9/b3zpOGf4CdE58yrMtdj9Cj5g6AuD6T10vnuMyZDXPzn6yYz6Xsrh9UFADCIYqQ8mKK6S0B8D4j0cpOkIQRGzZAcxfgsYTQjT2ISNft+Ma9G/hA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9fw8pNv/Sp2odqZMbt76zo0iOMFt5JC3LgGpQY8ekNc=;
 b=SQnnpTKy1j5dAQD1TjmNTgJj3Ex8/6NdU8qPOHVDH3g7lhct9gNbKnbV3ZeUwH0PvHnKKW2aaQIe/N+xJjZsA1o8FESeDFyl2RSsV8V4MwuM5baSn9VeugILt2xjevnQ2ZmsPQvTcltKLLkegmJGf0bJT04GZMLtRuBhreFTJ+7JiF+v939x2gFuQudPw3T9ORFyZl84ZKkZohNYJyxgDpeGjFa+cJx6BzHsRdWFkbGF/7Yf/ZOyUy6PrHa/MfMQJfb/w3pydBis9Igaa979eo/rG5pZevCQL0k8qIiGhPPbe6jGPcUtSGfYvG6SSdeOe+dB36J0Kdv+gGDia7ZCKQ==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by MW2PR12MB2505.namprd12.prod.outlook.com (2603:10b6:907:4::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.17; Mon, 13 Dec
 2021 22:44:11 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::6df1:639d:74ea:d39e]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::6df1:639d:74ea:d39e%7]) with mapi id 15.20.4778.017; Mon, 13 Dec 2021
 22:44:11 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Hannes Reinecke <hare@suse.de>, Sagi Grimberg <sagi@grimberg.me>
CC: Christoph Hellwig <hch@lst.de>, Keith Busch <keith.busch@wdc.com>, Omar
 Sandoval <osandov@fb.com>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH 02/10] nvme/rc: clear allowed_hosts subdirectory
Thread-Topic: [PATCH 02/10] nvme/rc: clear allowed_hosts subdirectory
Thread-Index: AQHX4D84X5H7O651402W9+5pWcGJ26wxJWWA
Date: Mon, 13 Dec 2021 22:44:11 +0000
Message-ID: <40e6c086-a944-5122-2fe9-ba735c712694@nvidia.com>
References: <20211123074940.113390-1-hare@suse.de>
 <20211123074940.113390-3-hare@suse.de>
In-Reply-To: <20211123074940.113390-3-hare@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8dfe9e33-d3e7-498b-4ece-08d9be8a14fd
x-ms-traffictypediagnostic: MW2PR12MB2505:EE_
x-microsoft-antispam-prvs: <MW2PR12MB25056540E84E803D4EFB164EA3749@MW2PR12MB2505.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:854;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Oqs1SnHnhMb9/9/S+BKpp4A0jsRgcmjSc5NBZa6O7zF7fBMdvBilQtSEKAMFIufGmI9DIlu/eneeDOCamKb8pOFsI0O2QB+qbH5xQkvtbwtKjthEZuhjJ+Ho2z5uiLSQx/o5BAqQPtnJNbSFoxtZca9SGA7p9Eaqpf6ci7NPrOSZmijTDAm3IW+nT+rbQl5pJ/lejtbaiydzFFnUedSFu+FQEY7CqzVmwHthVU3az5iZFCiy6VPo7YThEObG8+su0j0LnmDGS18PsgyvUHdEp1CcVECcWSHvaStpGBoMvJwGKcPH0s1RSnq+BRJ2glTAtz+Nr/Oz9rYLVAX0OimFlyTF3hsK3ei9QajO+6wx9ysSbGx8yjWplQdf/KxfYrt/OnENXQW4OwJ9R4sC6Q7bRhSJRWst20dqPgi/Qne3aihE1f03umsQ0Mk3YyJ7dHbiLng6vhs/wCJWXy7XL6fh1D8YZfIO/kdvEVTiwxVv707Olpe5OhALg31jzEcPiXKG/NqJBcrU+wd94enxwgalrDnfw2cPMLi+xHLpJaXz7uJcd3q9Y7prw/6botN6DXaFanASM8zwg9pXZJXzSUVfLdvH8CRWUC7561JRQnJ1RMGxGhDDoVLiulhYvkqMpl6/OtMeCTQvPZFUWyhw2sCUh2yRWDlq+OWbCmFPEmec/8iwxCUgEJRecqSatTpaebXi4tlJIiIGndY1T4dPki75WRobiKSnODXk8dNJ+pBD8ZytxnnkvpVPC637HvEsjvM3jpmAs7Xa4t/3+32IE+NaUQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW2PR12MB4667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(31696002)(6512007)(110136005)(316002)(38100700002)(8936002)(53546011)(8676002)(6506007)(64756008)(2906002)(36756003)(54906003)(86362001)(558084003)(66946007)(66446008)(71200400001)(31686004)(6486002)(38070700005)(5660300002)(91956017)(66476007)(4326008)(186003)(66556008)(122000001)(76116006)(2616005)(508600001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eklpVCt2MVN2T2hSS1MzbHdBYnNJeVBuSS9NZzNYOXM3VGdFaFZnQzFGK3Fa?=
 =?utf-8?B?Q0VXZlJzL0dmeDhlS1FiT3c5VkNUaEVpVElOZUlnbWU5S3hhZ2R1enM4bVVi?=
 =?utf-8?B?c1BPMVl3d2RGeXVib2daK2g4d3FHSTVOUk9hTm1GRzE5OVRwVWRDcEVQREFX?=
 =?utf-8?B?NVlpbmQ2REN2T1hqbWFpOUZkZTM2V2lPQWZpbHJYTytmQ2FLQ01tRHNZUzRB?=
 =?utf-8?B?Ri95Uk94SkhtbVJ4UHBlN2VQZEV1Z08rS2kxR2YzYmlXb280a0tJSmNlNXdK?=
 =?utf-8?B?UjNQTzB0ZFhWZjdHVXZwditDUzMvZVFUZGM2UnFwcTJjWW9mMkVwTnBpaDND?=
 =?utf-8?B?aDJzYlJoV2xLSVRURnZONE1PQW94ZVZqVEMyeWh5NFZRbXNneUNUejdWQ1Rm?=
 =?utf-8?B?eTBLWTF3eURVWHVoUDFVUVNJVmRtWnhkQ0RvSDBFY0E4ZStIYUdCeUYzZzhp?=
 =?utf-8?B?d2ZibXVUWi9xWGhYRmlvNkFiaTNHa2hacTFZUVVLQnp1QUZUWS9nZEJFUTdS?=
 =?utf-8?B?NHZqVjlIVmFkelh5b0dNQmFvditjdGk4R1lQQk1rYWxPWktYWjRTWk1lb1N0?=
 =?utf-8?B?N0IydXkwRTNxVm50NUhuZVpCRzNLNHdKS2tpZGE1UmhXRksrRnc1TVFNQml0?=
 =?utf-8?B?K3h5K1I0eGsvb3EyQUVxbkIzRHJSZ2hBWkE2dkhmVVhoQS9UVk9RZWRUMFBj?=
 =?utf-8?B?SlVKR1VZNWQxeXdUZEVwSVdLVTc4RlMxdThqMEtaMmhJK3JOSlZzMEpHOUJP?=
 =?utf-8?B?QjZpVkdsaVF5RzFTd0lOUzJpNDlzdnp6SGJZKzZWR1pleVhGYVhHSkpxTncv?=
 =?utf-8?B?TUE0TjJrK1pPVzcvZm5ma1dJUjV1cDVLenExbG4xVXp3a0FEUWwva2VpeUpH?=
 =?utf-8?B?SldqUlA0U0tXaWUrYmFaS29ndXpCZjlFRXJ4WGJyZzNnWGpiemtGRWdZaUJz?=
 =?utf-8?B?VDIyNnFjY21YeVpRUTd1RDRLckhoYUhEVDhqQk1ZUDVPZDVJQTlKSW5kQU96?=
 =?utf-8?B?WFN1Z1ZydnluNE1ZMGdCYko1NDcyaDRSQ0p4ek50d25mbWh3U3c2MzFkOFZm?=
 =?utf-8?B?Yzd3bTM2NUtrb2JiZldjaEQvb0VQTzR5SktaY2FnalhFa1I0YXFodVhZR2dn?=
 =?utf-8?B?Q3lYR3kxWWFaWW0vTExUUUVENmNWMVduUm9RbW50c2NWSUowNkVqczZncm5l?=
 =?utf-8?B?YzQ4b0ZVZzZnWFZaZlQrNENFM3RrWllta1RjQzFrS0NsUUl1VWMxWjl0VlZ3?=
 =?utf-8?B?a3hYSktQUzArVkdFR0N4WnNzZ1hvOFROZGVCRllHNjQwUjE5Q09TZllRYXBO?=
 =?utf-8?B?aks1REJyUWlXdkwvSTZrRkJEeDZZTVVyQkVRYkRkWmdkejhTZnlVK2JQOVZT?=
 =?utf-8?B?M0RkODJTUGtmNTc0Vlo4aHpBOWxLb2p1aDVCZ3JKUml6OVMyZjFQbEorN2Ns?=
 =?utf-8?B?NnFlQzVQMGJscks0OE9HT1ZXdjNMUmdYcENHbjNxbWQrYWxHTUNNN01mdlo5?=
 =?utf-8?B?MEsrMHlnQzJNdU9UemZYK0FWR1I2bVptcjVnTS9vSHZHSkw1eURtSnQrQU01?=
 =?utf-8?B?OVljUlQrMW9oSGRJTnFBeUdLQnF4S0cyNjhPMkR1Q1A2TXdEaUlQb041UWtK?=
 =?utf-8?B?ZTh5RHpWQ1lzazVZY2R3ejQ1cUQ4RXVqTmJaLzFsYWFHdEM0RkJQaXJMT2Zr?=
 =?utf-8?B?eUY5TDRseHVkaUREc1MxQU1WT0g4MGcxV1cwcGt1SXNPenl4VXBpMTBxNllj?=
 =?utf-8?B?VXZ6STltc1JMUFh2elplUHFPeFdlTmZPNHZPOXJGYm55bGVPSW5uTjJkcWJt?=
 =?utf-8?B?M2hrMDZublp6KzB4WWJJRnFKMjFabHRQQWdYamg4VmxzNExMendSMzB0UmJF?=
 =?utf-8?B?VE9QYUJaMjNsQkE3ZUR3V0ppL1dzYWtzcU1NUTRRb0daSitZTG4ycmptQS9F?=
 =?utf-8?B?T01vcmxtckI0aUxhY3ZRdHEyNWIrcDZWNTdHNzV4cmIxNTkra1dNYXJqN2sr?=
 =?utf-8?B?R3Y3aTlKWjZXUk9oR21oUVNwUmJzSldGT3JleFZRYnFOVVNveEY2TmtUOGNo?=
 =?utf-8?B?SFhabHIrdTQwQVAyanh1V01sb3FycllmTGRMcGhTdHU4ZTNhNklBQlpYeDda?=
 =?utf-8?B?Y1l5Y0hQcHRNUjIrNExVZmdnN2ViMHM4VFJteTFnczdxak80dTY5ZWpiZHlR?=
 =?utf-8?Q?COmiOkMx562pwsRxtHGJgryI4VSktmtEUdubJNS86Hyd?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6558ED1CFA8D3049B2761016DC25C4D7@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8dfe9e33-d3e7-498b-4ece-08d9be8a14fd
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2021 22:44:11.5485 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gvlBzTL9DnLOYI9JcNCIzjziddYXaezrB/mNi5EJmIxvoUuFXvotc6nigRRayyLXHgurkDuqZ8nTzqs0qODKKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2505
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211213_144414_950329_365F39CE 
X-CRM114-Status: UNSURE (   9.62  )
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

T24gMTEvMjIvMjEgMTE6NDkgUE0sIEhhbm5lcyBSZWluZWNrZSB3cm90ZToNCj4gV2hlbiByZW1v
dmluZyBhIHN1YnN5c3RlbSB3ZSBuZWVkIHRvIGNsZWFyIG91dCB0aGUgYWxsb3dlZF9ob3N0cw0K
PiBzdWJkaXJlY3RvcnksIG90aGVyd2lzZSByZW1vdmFsIHdpbGwgZmFpbC4NCj4gDQo+IFNpZ25l
ZC1vZmYtYnk6IEhhbm5lcyBSZWluZWNrZSA8aGFyZUBzdXNlLmRlPg0KPiBSZXZpZXdlZC1ieTog
U2FnaSBHcmltYmVyZyA8c2FnaUBncmltYmVyZy5tZT4NCj4gLS0tDQoNCkxvb2tzIGdvb2QuDQoN
ClJldmlld2VkLWJ5OiBDaGFpdGFueWEgS3Vsa2FybmkgPGtjaEBudmlkaWEuY29tPg0KDQoNCg0K

