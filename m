Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC487C43334
	for <linux-nvme@archiver.kernel.org>; Mon,  6 Jun 2022 00:51:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dmaZ78/2Cy675p8oDfub8zJsMrFJxkmnXned7LgNnko=; b=KUEgQgmrGXyN5jb9VQ3jyVEZC+
	aG8kUGB6HSBV6xuIc4s1wWahTcg3p2m6Y942OuAN6lzjLasjTJLpUt8RCTYOJ4Fof/tGWpU1+j84i
	i20tjz9QIC2/qB6kS3rf5mor9bO0q9GBabUyYEGcfj+lJZ7qht57KsiOEppzQLq9fqNul0fkTkQ6n
	NbOikhW7mzErVvYnF2HY3gAr22u/rxlZbpeisuh9uGYriqreQRnLjKx5GNb/CO1aCP/GiUkS/fuCv
	ag7yfHOmrpnu9erU1LHYk0oIOoevr/Do5X9Ne/srfa75U78qvpvgQciHU+ax2Pd19sG61umEdYJAi
	4LzW/0Ew==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ny0y7-00GP0T-E9; Mon, 06 Jun 2022 00:51:43 +0000
Received: from mail-bn8nam12on20619.outbound.protection.outlook.com ([2a01:111:f400:fe5b::619] helo=NAM12-BN8-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ny0y4-00GOzw-ML
	for linux-nvme@lists.infradead.org; Mon, 06 Jun 2022 00:51:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k6KK8XMlerT8WKgqm/WSVP+ZjFaP0GUzz8B4RHKPyuyTMWiEiQV4FyBVrh2ceIqwrbvoUuj/DhN6QdOsrreszgNlCM70L1jCBbOyk115HyQ5yxuLsqM4rqQJj/L+Siy7mlsI9Co0h+/vQR4kSOJDnQfkBBcGPhlsmpY78KlquQWePax9ft75iUSp7v9w9GXgiegLis9A71Kn6o7ehVI+3a1OI6ENfrtKxbhqit1t/fPfHgHVo2ja/DeujSS545pXWYyhrRM4HxmkbZhm5bo8oKbx8E5q0wQMCDiwX/Go/WDuFaBlFYLypNHTIjPN2BW73sH8hpY2TcsATejOp41ZUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dmaZ78/2Cy675p8oDfub8zJsMrFJxkmnXned7LgNnko=;
 b=hy+KBh1DJjq7xxe0tSEG9Y/Xt16RPIdlOAz2dyvfhH6OXJ29Fp8opALZZ70Fcmuac2YjdtODwcSSApu6sdHxbMgqgYBImxw0cK9pmw8apeJDJJY/TspgMVOTw0Xq2kULybYndUblTaIBunUztjneOKjtcKcXDVsc42hr9ZIUNLm3RxCPjgPN7ZDZoeVv+M/r44hzmvFPwCAUOvioWUE1iZjpfH2nPgxGld8Iq3sK8EjqtpJuCIe9F29Cj/XK4rLN0SKU+DH2NEfwnFkGV0IuzPEiKx2EdP6vdjrbhnljarNIZnjO+aSlCDRR29fP0IIWMTjmPG/ntTLB26MYgVJewg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dmaZ78/2Cy675p8oDfub8zJsMrFJxkmnXned7LgNnko=;
 b=paze2lHlVa957rruTEnRxE7yAuUElZ5LlFbd8ljZOm71CYKGCK8fshQgTkzoFnWXMET5ZxDVG0cwn4Stc2MlRBxE5Thlfv2663h3XnoZACDWMOxy+nqCRzC0UCLJ897Id74mqtpR5v7+zYGTQSzC24rPG97pk5oL07oGQBSMB4EdkQRFXRAlNsN2mCm3fvLYWA/uUThlzvVKJRv4ewL6L/fheN4gJgaULaFsyqwleAX4hSNn4i72dhJ5cAhvf7QwMf48jEdyVuOfk+EONAimnBNJ4LKdjJ87ljgxEED2PGCvh4SPxdpqVufvkLj5ttX13CBPUUZIGJ8E+hG/S4OV2g==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by CH2PR12MB5004.namprd12.prod.outlook.com (2603:10b6:610:62::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.13; Mon, 6 Jun
 2022 00:36:40 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::6dff:6121:50c:b72e]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::6dff:6121:50c:b72e%7]) with mapi id 15.20.5314.019; Mon, 6 Jun 2022
 00:36:40 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Hannes Reinecke <hare@suse.de>
CC: Christoph Hellwig <hch@lst.de>, Keith Busch <keith.busch@wdc.com>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, Sagi
 Grimberg <sagi@grimberg.me>
Subject: Re: [PATCHv3 blktests 00/10] Testsuite for nvme in-band
 authentication
Thread-Topic: [PATCHv3 blktests 00/10] Testsuite for nvme in-band
 authentication
Thread-Index: AQHYeTgnXAsQVar7yE20C0k0u/hh+61BiIeA
Date: Mon, 6 Jun 2022 00:36:39 +0000
Message-ID: <5fc523e8-5f61-86cc-ff16-3c46080933ca@nvidia.com>
References: <20211123074940.113390-1-hare@suse.de>
 <a258bb78-4009-9f27-e178-bac596569b46@nvidia.com>
In-Reply-To: <a258bb78-4009-9f27-e178-bac596569b46@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5f17731f-b34b-4c7f-0151-08da47549f29
x-ms-traffictypediagnostic: CH2PR12MB5004:EE_
x-microsoft-antispam-prvs:  <CH2PR12MB5004B8ED9BD4DB6E56AD3F53A3A29@CH2PR12MB5004.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  ENRslQ37gRzePHzXl4YFCicE52/O2xF3VTsD8oy0qDqE2KllCy5j8DEz+czug8e4osh383zw4ia75TcdzC3++TJWgI8MImlhfW8X+O/vGuabykZWjKmSOWQCG6e6D67tZ4NZLMju/qK4b7TLHeZMXfT8pgbDya/IqiWf0rocs4Zk7m7I9jLiTr5PzUuGsl9ao6/gaeT2OBhSMLB8PvW6SijatB0XyCV0IYJ64+cgDXMXz7IPpPGCfh9jilwOEgjPOx8moDSh1/smUvw0GuSFLPN36UUu4HdGA7dIOej1jxnS/b4QaPSHvgQGMyf1nWNCNlCIS+BTIrhDGiG0xCyv7vZZav3woKSECQe+5gypRDo1T0tgDhpCdXbA05IkPz6rjdFoNPzjTsxf3eRbWudswKtDGoPGglZnu8qH1KqMf/xyBT+RQuxYDj1GJBxP426C/HsI4AFHKiMYDdbPHllVefTQuHlhe8AVpsV/TdbrzrGSuZZwN7oQQYiPVZDo6svlw3MgS81lxbOw7sYNx8anZ/7EFNVqDAJI5shdxeDmMrXk5wLP2VVYqcfOSqGK3FvGJUd3i3NXQWaiFczFylYYMAQxI4wwhyowca6fD6bk3l8wDNmy8xSgQX4QXKFNaraFANZbVEHoYEvNcOlrY3EUyxOb7mMurUlFCvba5qZSQNuMnneUD16ckfvKKI7xAZ4lFqf520I7ux1Ee3KigY6Gjjp8RTYNxdpiqOkTBIJytVKj1tQzYFux7sPv6/Z54PKpI5chiazUBAkORGPs0GKymQ==
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(38100700002)(2906002)(6916009)(122000001)(54906003)(53546011)(6506007)(6512007)(38070700005)(316002)(36756003)(83380400001)(86362001)(71200400001)(31696002)(2616005)(8676002)(4326008)(66476007)(66446008)(64756008)(91956017)(6486002)(66946007)(76116006)(31686004)(186003)(66556008)(5660300002)(508600001)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:  =?utf-8?B?OVZlUElSVWNlNUhDK0pVTEk1T3JXODNoWk1CMXlONy9YaENDRGRkdGx2ZUZx?=
 =?utf-8?B?c2lpMW5SNWZYYjJ1Z2pXMHNnWUFtR1pZSkV5RWRwZUhDd3ZiVEpWdDBqMGs3?=
 =?utf-8?B?c2lRTXJHa09SdkIzWFBmM2VFcGR1Qi9yWUh3bW1jeEVNelM3dGNiY3VBZWNM?=
 =?utf-8?B?WG41T2M3UTMxdnVITGNuQThRVjhiTFQ4VCtQVmFHOStCZWc2OW1kZUZBVVAw?=
 =?utf-8?B?bHRrMzFSd3VOMnZ2aGs1VVlGK1VVb1BaeVlJNFdiSGtQSm9FTCtqYXovYjBz?=
 =?utf-8?B?MFNEZWlsS2dnZzJ1amhtM2dUT3ZwK3VTYzZtSGIwMmJQS2VvZVM0MHBqR0h3?=
 =?utf-8?B?VWR1eHZCaDBocjB1ZXlKbHA2ZnFmSCtndmZ3dDFROUtBaXQrWFc0RGgxRFlt?=
 =?utf-8?B?akUvdnh3WjdWZnNRT001NXRyRzUydjZ1MzBGWUhLWERqeUovNVBPWWFnUko1?=
 =?utf-8?B?TWd2OHFjNG9OZkdkZ2NtczJZeDR6alAwYytndUlyUzdmS1NUTTd3UlVLbmZK?=
 =?utf-8?B?MHkvemNKOVcvOXVmVzFqM0ZiZmN0N2l1Zk9IdTIzMFh6T1RkQmp3RUtIcmJE?=
 =?utf-8?B?TnFCS3A1Zy8vTDAxN1ZOVlkreGVCcGREaVkxR0dIY0VjUWNMa1BpbW56ZXkv?=
 =?utf-8?B?T2tqbUhlYWtLKzQ0cHVxQkhFYktGREVKeENWekYrbGZPajhFc1Y5b0prZlR4?=
 =?utf-8?B?ak4xZ2RzdHhXTEhRdHRHTGR0Tm5hU0RxeWpsQ3pNV3BENUtGakgwMlVsNXlE?=
 =?utf-8?B?L0hBKzcyVUVBbGdCRzFYRnRtNEZqRk93TS9oc0lGdG1MRVFGMU95NXowWHc2?=
 =?utf-8?B?YTloZ0JMeXBaUVdEb2svNkRGRFVON2NRYmpxK2lvUGRDb01ZeXhzSTlWTmR3?=
 =?utf-8?B?M1V5S09qWFBYRUdkaFdyK0p0ZElBbUlBK0lLMTFWaXdpc0ZHU0doRC9iUnZH?=
 =?utf-8?B?OVZKTkRJdG81TzFhR1JhZUdXTmZVUS91eEd6WXF2MU9XODRSQ1cveVpwemdI?=
 =?utf-8?B?VERzVnNaUlFsYjhtQTlpQllvOXNFL0MxU2FOTmhMZXRlalhNWjdGdE56TERF?=
 =?utf-8?B?OU5XVjRzcUdSVm5VUW96S050M1poWjdwYzN5WjJDUVBjaVJ3UGFqTTVQem9J?=
 =?utf-8?B?ZnZzVlJLUkZSWk1HSjhvdXIyNjJ3eHUxaEQ0d0t4c3diR1B0bSsvQkYyNGM4?=
 =?utf-8?B?VVZEeGVOWDVMQlBOVHJXNVRUZDVLMWloRnZpSG9OZHUxbjZnV1ZaMEJodVoy?=
 =?utf-8?B?eFp2cnNaa0hnUTQrOUJjN1pOUHZNZTVIY21RNUtpWXFlQm1yRnlKOUd1Y1Fs?=
 =?utf-8?B?NzZySGRNMzY4ZXJLMEZuUk9WMjY0NVg1Kys4ZmtvZkNYNjhac3RBVUxtL0k3?=
 =?utf-8?B?WjI3NEZLUHFGS3NhNVRWMS8rNDkxS1hEMW1IRzB3N2UxekpmTktWNWdiR2pw?=
 =?utf-8?B?dG5YVHd6akxDaE0zS1NTUTZXRzRZM1ZZR1NHME5vYkhQOVBZcXVZekNQK2wx?=
 =?utf-8?B?VFQ0eThzVFp2RHh2UG53ZkVMMldYeDA5bnpDd2FVdUxxNHkrbFAxd2dTSC96?=
 =?utf-8?B?UTdDMW5Tby9QSXIvaEZDVEx2dFRnaFcyV2NJUG80VUt6M0ZXMEdqYktaNlBh?=
 =?utf-8?B?WU91Z3ZFT05uNlZKbzlGOEhHTmxzOGFzekhtQUhWSENGNlg5MmhkcnZWTlB0?=
 =?utf-8?B?ekxOakQwNWphM3ZxdnZDRS85REdNMmpFU0xuUjVuOVZ3bGRReTM0UEQ5YlBk?=
 =?utf-8?B?V2pHU3lqSklOT1MrTll0Yi9IVW1TbEVmaGd1VlBLRU4vbUpFdFcxZzZpQ0cx?=
 =?utf-8?B?ZkpMNzcwYyt3eTBiUkVxVW5UdFlvZG9oL1dERmR5OFdraW91TXJvbWU5UXJF?=
 =?utf-8?B?QTFBMklvVWN4UTVvaWtEdFZTT1Q0QjN5Y29nWVJOcVlWbERaV1pzNGJPNU1B?=
 =?utf-8?B?NUo3YTNvMlhPc0dSZmJUdm1QcjRxS09NU29NWEZPODUzTkgxeVg3eFhPcS9K?=
 =?utf-8?B?VXdNNklFN1I2V0kxOTluK21NdkRyN1dsYnY1d1piZnh5ZXg4V3BGeEU2RVV6?=
 =?utf-8?B?RHVqQk45UDR4SVdURnZTSmRMamxkVmkzeGE4Q1pvWlU2V0phbUo5ZU9JWVVS?=
 =?utf-8?B?OUsveHZrejhmdEdLZGNZT2k5RUN4N2NRZStNbHp3Ymc2OXNjT2pvUEpKL2hD?=
 =?utf-8?B?bW9kUThrdWlBbGU2TE9sTnptd0dRRnlwRFYrcU1FWWxmalJhd0xaa2ZPQjBW?=
 =?utf-8?B?S0hHMS9Vc1ZMU3pHYmdjeWJuYlQrR05CQ3hQTm1tL2NuenZlUHUzOEdiTVh2?=
 =?utf-8?B?TndraFE0SjAzSUJxTXc2ZHliQkFIQ05HZENSdmpSQ1ZhOTYrTVNyajJrM2NZ?=
 =?utf-8?Q?gmynNgdrffA4ukmydvb2KDSx70Cb5HlttLKOKFaQBcpNi?=
x-ms-exchange-antispam-messagedata-1: ppQ5j8ogVOVHyg==
Content-Type: text/plain; charset="utf-8"
Content-ID: <7DFAF951E0A95342BC823B933DBA2E75@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f17731f-b34b-4c7f-0151-08da47549f29
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jun 2022 00:36:39.8811
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nse/Nd3r8GK9yAbvUuJKR7fw6nHbhTBHMmyLqmJAsMqkwoSqXhdY3nMlwu0u4McTYO8CAN2rMQJf3QE64lEj2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB5004
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220605_175140_767363_80B5329B 
X-CRM114-Status: GOOD (  14.23  )
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

T24gNi81LzIyIDE2OjU4LCBDaGFpdGFueWEgS3Vsa2Fybmkgd3JvdGU6DQo+IE9uIDExLzIyLzIx
IDIzOjQ5LCBIYW5uZXMgUmVpbmVja2Ugd3JvdGU6DQo+PiBIaSBhbGwsDQo+Pg0KPj4gc29tZSBw
ZW9wbGUgKEhpIFNhZ2khKSBoYXZlIGNvbXBsYWluZWQgdGhhdCBudm1lIGluLWJhbmQgYXV0aGVu
dGljYXRpb24NCj4+IHByb3ZpZGUgZmFyIHRvbyBtYW55IGNvbmZpZ3VyYXRpb24gb3B0aW9ucyB0
byB0ZXN0IGl0IHdpdGggc29tZSBlYXN5DQo+PiBjb21tYW5kcy4gU28gaGVyZSdzIGEgdGVzdCBz
dWl0ZSBmb3IgdGVzdGluZyAobW9zdCBvZikgdGhlIHZhcmlvdXMNCj4+IGNvbmZpZ3VyYXRpb24g
b3B0aW9ucyBhbmQgZmVhdHVyZXMuDQo+Pg0KPiANCj4gSW4tQmFuZCBhdXRoZW50aWNhdGlvbiBi
bGt0ZXN0cyBhcmUgZmFpbGluZyBvbiB5b3VyIGN1cnJlbnQNCj4gdmVyc2lvbiA6LQ0KPiANCg0K
VGVzdGNhc2VzIGFyZSBhbHNvIGZhaWxpbmcgZm9yIFRDUCA6LQ0KDQojIG52bWVfdHJ0eXBlPXRj
cCAuL2NoZWNrIG52bWUvMDQzDQpudm1lLzA0MyAoVGVzdCByZS1hdXRoZW50aWNhdGlvbikgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgW2ZhaWxlZF0NCiAgICAgcnVudGltZSAgNi4wNDJzICAu
Li4gIDUuNzYwcw0KICAgICAtLS0gdGVzdHMvbnZtZS8wNDMub3V0CTIwMjItMDYtMDEgMTI6MzA6
NDUuMDg5MDU5NDI4IC0wNzAwDQogICAgICsrKyAvbW50L2RhdGEvYmxrdGVzdHMvcmVzdWx0cy9u
b2Rldi9udm1lLzA0My5vdXQuYmFkCTIwMjItMDYtMDUgDQoxNzozMjoyMS4xNzc4NzExNTkgLTA3
MDANCiAgICAgQEAgLTEsNCArMSw1IEBADQogICAgICBSdW5uaW5nIG52bWUvMDQzDQogICAgICt0
ZXN0cy9udm1lL3JjOiBsaW5lIDI2OTogcHJpbnRmOiB3cml0ZSBlcnJvcjogSW52YWxpZCBhcmd1
bWVudA0KICAgICAgUmUtYXV0aGVudGljYXRlIHdpdGggb3JpZ2luYWwgaG9zdCBrZXkNCiAgICAg
IFJlbmV3IGhvc3Qga2V5IG9uIHRoZSBjb250cm9sbGVyDQogICAgICBSZS1hdXRoZW50aWNhdGUg
d2l0aCBuZXcgaG9zdCBrZXkNCmJsa3Rlc3RzIChtYXN0ZXIpICMgZm9yIGkgaW4gMzkgNDAgNDEg
NDIgNDM7IGRvIG52bWVfdHJ0eXBlPXRjcCAuL2NoZWNrIA0KbnZtZS8wJHtpfTsgZG9uZQ0KbnZt
ZS8wMzkgKENyZWF0ZSBhdXRoZW50aWNhdGVkIGNvbm5lY3Rpb25zKSAgICAgICAgICAgICAgICAg
IFtmYWlsZWRdDQogICAgIHJ1bnRpbWUgIDEuNjQ2cyAgLi4uICAxLjM1MHMNCiAgICAgLS0tIHRl
c3RzL252bWUvMDM5Lm91dAkyMDIyLTA2LTAxIDEyOjMwOjM0LjU1NjgwNzM5NiAtMDcwMA0KICAg
ICArKysgL21udC9kYXRhL2Jsa3Rlc3RzL3Jlc3VsdHMvbm9kZXYvbnZtZS8wMzkub3V0LmJhZAky
MDIyLTA2LTA1IA0KMTc6MzI6NTEuMzQzNTQxNjA3IC0wNzAwDQogICAgIEBAIC0xLDYgKzEsNyBA
QA0KICAgICAgUnVubmluZyBudm1lLzAzOQ0KICAgICArdGVzdHMvbnZtZS9yYzogbGluZSAyNjk6
IHByaW50Zjogd3JpdGUgZXJyb3I6IEludmFsaWQgYXJndW1lbnQNCiAgICAgIFRlc3QgdW5hdXRo
ZW50aWNhdGVkIGNvbm5lY3Rpb24NCiAgICAgLW5vIGNvbnRyb2xsZXIgZm91bmQNCiAgICAgK25v
IGNvbnRyb2xsZXIgZm91bmQ6IGZhaWxlZCB0byB3cml0ZSB0byBudm1lLWZhYnJpY3MgZGV2aWNl
DQogICAgICBOUU46YmxrdGVzdHMtc3Vic3lzdGVtLTEgZGlzY29ubmVjdGVkIDAgY29udHJvbGxl
cihzKQ0KICAgICAgVGVzdCBhdXRoZW50aWNhdGVkIGNvbm5lY3Rpb24NCiAgICAgLi4uDQogICAg
IChSdW4gJ2RpZmYgLXUgdGVzdHMvbnZtZS8wMzkub3V0IA0KL21udC9kYXRhL2Jsa3Rlc3RzL3Jl
c3VsdHMvbm9kZXYvbnZtZS8wMzkub3V0LmJhZCcgdG8gc2VlIHRoZSBlbnRpcmUgZGlmZikNCm52
bWUvMDQwIChUZXN0IGRoY2hhcCBrZXkgdHlwZXMgZm9yIGF1dGhlbnRpY2F0ZWQgY29ubmVjdGlv
bnMpIFtmYWlsZWRdDQogICAgIHJ1bnRpbWUgIDExLjE5NHMgIC4uLiAgOS4wOTFzDQogICAgIC0t
LSB0ZXN0cy9udm1lLzA0MC5vdXQJMjAyMi0wNi0wMSAxMjozMDozNi42ODE4NTgyNDggLTA3MDAN
CiAgICAgKysrIC9tbnQvZGF0YS9ibGt0ZXN0cy9yZXN1bHRzL25vZGV2L252bWUvMDQwLm91dC5i
YWQJMjAyMi0wNi0wNSANCjE3OjMzOjAwLjU3MDc0NjY4NCAtMDcwMA0KICAgICBAQCAtMSw0ICsx
LDUgQEANCiAgICAgIFJ1bm5pbmcgbnZtZS8wNDANCiAgICAgK3Rlc3RzL252bWUvcmM6IGxpbmUg
MjY5OiBwcmludGY6IHdyaXRlIGVycm9yOiBJbnZhbGlkIGFyZ3VtZW50DQogICAgICBUZXN0aW5n
IGhtYWMgMA0KICAgICAgTlFOOmJsa3Rlc3RzLXN1YnN5c3RlbS0xIGRpc2Nvbm5lY3RlZCAxIGNv
bnRyb2xsZXIocykNCiAgICAgIFRlc3RpbmcgaG1hYyAxDQpudm1lLzA0MSAoVGVzdCBoYXNoIGFu
ZCBESCBncm91cCB2YXJpYXRpb25zIGZvciBhdXRoZW50aWNhdGVkIA0KY29ubmVjdGlvbnMpIFtm
YWlsZWRdDQogICAgIHJ1bnRpbWUgIDE0Ljc4MnMgIC4uLiAgOC41NDFzDQogICAgIC0tLSB0ZXN0
cy9udm1lLzA0MS5vdXQJMjAyMi0wNi0wMSAxMjozMDozOS4wNjU5MTUyOTggLTA3MDANCiAgICAg
KysrIC9tbnQvZGF0YS9ibGt0ZXN0cy9yZXN1bHRzL25vZGV2L252bWUvMDQxLm91dC5iYWQJMjAy
Mi0wNi0wNSANCjE3OjMzOjA5LjI0MTkzOTQwNiAtMDcwMA0KICAgICBAQCAtMSw0ICsxLDUgQEAN
CiAgICAgIFJ1bm5pbmcgbnZtZS8wNDENCiAgICAgK3Rlc3RzL252bWUvcmM6IGxpbmUgMjY5OiBw
cmludGY6IHdyaXRlIGVycm9yOiBJbnZhbGlkIGFyZ3VtZW50DQogICAgICBUZXN0aW5nIGhhc2gg
aG1hYyhzaGEyNTYpDQogICAgICBOUU46YmxrdGVzdHMtc3Vic3lzdGVtLTEgZGlzY29ubmVjdGVk
IDEgY29udHJvbGxlcihzKQ0KICAgICAgVGVzdGluZyBoYXNoIGhtYWMoc2hhMzg0KQ0KbnZtZS8w
NDIgKFRlc3QgYmktZGlyZWN0aW9uYWwgYXV0aGVudGljYXRpb24pDQoNCg0KDQp3aXRoIHRydHlw
ZV90Y3AgT09QcyBpcyBvYnNlcnZlZCA6LQ0KDQpSSVA6IDAwMTA6YmxrX21xX2FsbG9jX3JlcXVl
c3RfaGN0eCsweDUyLzB4MTgwDQpDb2RlOiAyNCAxMCA0OCA4OSA2YyAyNCAwOCBmMyA0OCBhYiA4
OSA1NCAyNCAxMCA4OSA3NCAyNCAxOCBjNyA0NCAyNCAyMCANCjAxIDAwIDAwIDAwIGY2IGMyIDAz
IDBmIDg0IGY4IDAwIDAwIDAwIDQ4IGM3IGMwIGZiIGZmIGZmIGZmIDwzOT4gNWQgNTggDQo3NyAx
YiA0OCA4YiA1NCAyNCA0MCA2NSA0OCAyYiAxNCAyNSAyOCAwMCAwMCAwMCAwZiA4NSAwYg0KUlNQ
OiAwMDE4OmZmZmZjOTAwMDI2YjNkMjAgRUZMQUdTOiAwMDAxMDIwNg0KUkFYOiBmZmZmZmZmZmZm
ZmZmZmZiIFJCWDogMDAwMDAwMDAwMDAwMDAwMCBSQ1g6IDAwMDAwMDAwMDAwMDAwMDANClJEWDog
MDAwMDAwMDAwMDAwMDAwMyBSU0k6IDAwMDAwMDAwMDAwMDAwMjMgUkRJOiBmZmZmYzkwMDAyNmIz
ZDYwDQpSQlA6IDAwMDAwMDAwMDAwMDAwMDAgUjA4OiAwMDAwMDAwMDAwMDAwMDAzIFIwOTogMDAw
MDAwMDAwMDAwMDAwMA0KUjEwOiBmZmZmYzkwMDAyNmIzZGUwIFIxMTogMDAwMDAwMDAwMDAwMDAx
OCBSMTI6IDAwMDAwMDAwMDAwMDAwMDANClIxMzogZmZmZjg4ODExZTA0YTAwMCBSMTQ6IDAwMDAw
MDAwMDAwMDAwMDAgUjE1OiAwMDAwMDAwMDAwMDAwMDQ4DQogIF9fbnZtZV9zdWJtaXRfc3luY19j
bWQrMHg2Yi8weDFhMCBbbnZtZV9jb3JlXQ0KICBudm1lX2F1dGhfc3VibWl0KzB4OTAvMHhkMCBb
bnZtZV9jb3JlXQ0KICBfX252bWVfYXV0aF93b3JrKzB4YWUvMHhkNTggW252bWVfY29yZV0NCiAg
PyB0cnlfdG9fd2FrZV91cCsweDk0LzB4NTYwDQogIHByb2Nlc3Nfb25lX3dvcmsrMHgxYWYvMHgz
ODANCiAgd29ya2VyX3RocmVhZCsweDUwLzB4M2EwDQogID8gcmVzY3Vlcl90aHJlYWQrMHgzOTAv
MHgzOTANCiAga3RocmVhZCsweGU3LzB4MTEwDQogID8ga3RocmVhZF9jb21wbGV0ZV9hbmRfZXhp
dCsweDIwLzB4MjANCiAgcmV0X2Zyb21fZm9yaysweDIyLzB4MzANCiAgPC9UQVNLPg0KWzQwXWtk
Yj4NCg0KDQpJZiB5b3UgaGF2ZSBub3QgdGVzdGVkIHRoZSBjb2RlIG9uIFJETUEgcGxlYXNlIHRl
c3QgaXQgYXMgSSdtIHN0aWxsDQpmaWd1cmluZyBvdXQgdGhlIHNldHVwLg0KDQotY2sNCg0KDQo=

