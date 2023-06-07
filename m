Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E378DC77B7A
	for <linux-nvme@archiver.kernel.org>; Wed,  7 Jun 2023 23:31:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IiBPsEad8GukXZ2/Km5IY8CAWvE5qmxdRtM+p33xi3c=; b=nBDdAOifqSmRc4bogv8K7xsI0p
	7WqvIBGFvk8ld1DBmzKATjiMv1DtLaSsAD9vKImgs1MxZSdgWunY2mY5D/n7OX90AdgLKYcigttbI
	OwVSJOwdKf7dr8+Hzmpc19OyulUkp2O+TljScgLNGaXDccpqQJgVxV5xbXS/lmEEjnWNx8VVKWmAD
	17fhK9J7lnBmHjcVgwAN7ocqxHt4gRK8emWrmjRI0oPS4crEcHjUp/WJUYbQwBKiQzYtDzca0yTT+
	S0S+a8hgxWt+FmJ2lVCE84QmAVgrTIIPgW5D2EROKjWMwSeqgCLaP/mNYAkp7JfhyeYx0QSSiobaO
	FbsAZOWw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q72cX-007WT8-26;
	Wed, 07 Jun 2023 23:31:17 +0000
Received: from mail-mw2nam10on20627.outbound.protection.outlook.com ([2a01:111:f400:7e89::627] helo=NAM10-MW2-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q72cU-007WSH-2K
	for linux-nvme@lists.infradead.org;
	Wed, 07 Jun 2023 23:31:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fgrLQ15kEh29Z7Zq5swLgmTMv2mB2Pb3NLZlZzDEY6l/hwBTKhrCR1s806xmgTRkddj/LITReMVMqOUGlgSGijLEujoL2K73ZVYGfJPbl8vllgjUM73d1VCyLZjSNA+hadk+TU+Uq4mozpxBWkgnlchTfzMk8T9pEkiakyp4+zMkZXq2jgDaa3Wa2dahiDUgsT5HXqhnm38qX06rzQw7AO6Y57CIYO6Z2JnLs7z30dHDMCJ7kfboTps4yYtOYwNCx6VxIqbPLTP3ccldP6I75ETAiP+O3un9LEgMSGFn1EfNvSJaN5Un7XmuSkPn2WIultP/J/JVGzQFvU6mgJX5OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IiBPsEad8GukXZ2/Km5IY8CAWvE5qmxdRtM+p33xi3c=;
 b=PZXuaWuLP5cwH6rFFCzZyaUkkeaf5IHeztMtVPN3kwi5jl0z33rkqCO6JIIjs4Q1ic2CXoku6ncI71b8JnjR1JfdTEl2kgRbLGl0Rdft+dKAZo3BoR/rrjNyPaq0NVObf8pBtLSQsU8bl2BYfQJ8alNzRa3vmtXHSgC1T3r2Gtx+e/f6WYiLQ9TLqhIWl0bGDiT/qtzUBM+XKpSU8oCFmJ05RE68FgtpRPJeQPvphmzDZe3itckuT8e0jt2HaAcdUsihn1VQr2VnxvZwWpv0ENCSeBex+0ivcchF6eUczvydWmVrRVaAdTIw+Kbux5Bv+XPbzQgFQPVqj7YCBEE8ZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IiBPsEad8GukXZ2/Km5IY8CAWvE5qmxdRtM+p33xi3c=;
 b=X7Y5QpsaL6d2IdrJlW27g9ko5LzZdgdflV8HuC6DQtwH3tKDoSefEZThf5ee5S1ClZqzZVU/qrllx1Jl/kv/EuiaIUnoH6c4TJ4dwmPP4RVEG0hCWlGxrupEtorCszhkhHLeO7b6QR8FNxd9OXJdPr7J99vWquCQ0TJM3I7K0kvu619BKJzIaOtmLok5G82Iq5PruJClQwHHeXRwOHv3uXqQ0WmWWkKoa8Gbm7s1IB/EtnFkd0rvaBAmgaX1dK47pubwm4G/RVBrcrc/tTkYMPRv8HbqS5W5OYMmKIoPVLxj+hzUrrSaHbRYT64Wl6T60MW+MULtZRnink4M9db6cg==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by DS0PR12MB8786.namprd12.prod.outlook.com (2603:10b6:8:149::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Wed, 7 Jun
 2023 23:31:02 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::92c6:4b21:586d:dabc]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::92c6:4b21:586d:dabc%4]) with mapi id 15.20.6455.037; Wed, 7 Jun 2023
 23:31:02 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: "Engel, Amit" <Amit.Engel@Dell.com>, Sagi Grimberg <sagi@grimberg.me>,
	Christoph Hellwig <hch@lst.de>, Chaitanya Kulkarni <chaitanyak@nvidia.com>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"kbusch@kernel.org" <kbusch@kernel.org>
Subject: Re: [PATCH] nvme: print disposition on err req completion
Thread-Topic: [PATCH] nvme: print disposition on err req completion
Thread-Index: AQHZl3nxIGXFMiRvlkSjjzKFj5CQhq9+yyWAgACprACAACEIgIAAa3EA
Date: Wed, 7 Jun 2023 23:31:01 +0000
Message-ID: <c96bb17a-3985-1490-c5de-e4018a5c4b25@nvidia.com>
References: <20230605064933.46933-1-kch@nvidia.com>
 <20230607050059.GA19879@lst.de>
 <a8f3f9eb-7267-219e-f6cc-f36c0ca56080@grimberg.me>
 <CO1PR19MB48853E8FB1D246D85EEC0DB4EE53A@CO1PR19MB4885.namprd19.prod.outlook.com>
In-Reply-To: <CO1PR19MB48853E8FB1D246D85EEC0DB4EE53A@CO1PR19MB4885.namprd19.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|DS0PR12MB8786:EE_
x-ms-office365-filtering-correlation-id: fae95b56-7926-43f1-35a2-08db67af418d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pW25TYyfSfzk5lOcwAfJisxO6dplDSBwztfieRWR8Hh8I+dOEYjjJB0Ov97X5pdrawIiqH2ntzA5+s6B6zDGctoqR4f6Lg0WJc2JEhse9u8qUc3SwANVHnd/P5GdqTu/0rPb8IydM6QjO7XxeVPbp6uxoCUofyzudEi0kYSHIQUgUcaF3yX1CMz3w0fpLXUCTVjGoJD3IVEtHBspBlMO4toimdVezUn1RwYzRc0K1l9CNTxYehlowNsIvuXqnLMVflwTClC/rg7YWYlqbnp9PU/Dm0BA0+wnGBEnfthIXfmbQ1oBkjaW/t60RHIuQVtNv3CIeg+7etJi2+fVoIdvGNdo4iPkJ6JXj1W0gGYE9RTKW1QblyNY9zg0r8llKiRhUsFqmmg6oD7SkdmrXY7U3ZoVYLzvjMRDKhokVNIgp7akM5Jb5lsbnJeR0VQNItjGSgfYNWsBcgM7XHfy7u+184XZo6P1dtznHW5b5AX+nWnYgtDYzXZGNwj1keMmt+M5uvgjK2+GcJA8neLfIvA/r3LLH/SQkFZSU0TyXb3quMHoskysy/tM8QR+sJDBQU9wIs4pxxAcoYnqyzlmG0xaUMHU+IxOLi+hRjjNhWtSOBJCgB6/ks4JVDTRv7lEVGx8XK7nfGQ5tzDUDlbzZqQ4yMD8UsdvaRG+V4JM7+oKL0xsEky3jCMGwWVTJbnt+u8m
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(366004)(136003)(346002)(376002)(451199021)(83380400001)(2906002)(2616005)(31696002)(36756003)(86362001)(38070700005)(122000001)(38100700002)(41300700001)(6486002)(316002)(5660300002)(8936002)(8676002)(110136005)(478600001)(54906003)(71200400001)(91956017)(66556008)(64756008)(66946007)(66446008)(76116006)(6506007)(31686004)(4326008)(53546011)(6512007)(66476007)(186003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eDMzQXZYeTZmZ0RJMUoxNUdWM3BnczVaRzFaVjd2Q0tmYU84MjBISnFTdnVy?=
 =?utf-8?B?RU1ndWhJYkdFa0dhakgrUktsUjRDTDVYQXBzSFY0TFF2eTZIdms1NWRUKzhM?=
 =?utf-8?B?U2YzaDNGSUdPS1JmeFJVMmxaa2syTUtnN3hEd3ZIYTBRbzRZc1JEOVdiTEVx?=
 =?utf-8?B?SGRYR0dQZW1HaVB6MlZxK1pwRGxEc3YwQ003OGFVcytPdmtSVWEybW9PTE9i?=
 =?utf-8?B?U084VFcxV2RhYzAxTitHbkpSVFpNQkFFeUZBSkNFRG9VV2VDeFFBSzdsVFZ0?=
 =?utf-8?B?ODVYYkhEM2ZZek1nWGtoUmJtU3JHdjA3NmhhbnhvaVhBanpPaHJSVklFSXRo?=
 =?utf-8?B?bThuQTRza2Z2dHpLRGhIeUNjRTE4VDJpRjJWS1NuWUdPcW95eERPeTdTU0Za?=
 =?utf-8?B?OFEyaGoya0lDQ2tqUnQvRmxOd1JwUUJiZGUybGluRm1BTkVaK21NT0k5ODdt?=
 =?utf-8?B?MXo3M2N2VDdGbEQ5ODl1ZEdzc1BwQks2THloRFVLalFhUWM2K0lrVHlqSkY1?=
 =?utf-8?B?bFFzRW5rbk9aUUFuUG81QmZuWXpMU0pyZmt6NG1HUUkyNGl5MlNlOVlzTVhE?=
 =?utf-8?B?bXJ6TnZKUFRMcjhNOGo3b3FCSU1wUVhCR3pNQTRCbUR3dG55ZGxNRlpENDRk?=
 =?utf-8?B?NVBTenlFSjF4VWpvWDJEM2pYMlBuYzh6cmNNaWt4Z3c4V1BOUUlqVm5ZL05h?=
 =?utf-8?B?eDEwSVpLRlR0dm1UWGhyU3R3OTZsMEozWi92SG8zQWl5cVhNUU43MWZxcnJN?=
 =?utf-8?B?V2Q1MkNialpqSU9NTytoQlJNbEE5STFDb2lMQm9Rc2tlNnhKQ1ZMN2huUFFP?=
 =?utf-8?B?ZDBSVmF0UWkzellXMWF3bDErVld1eFA1aG5MWXdBRmxJVkFXRzRMTG4rWjlS?=
 =?utf-8?B?SEdhWnZtRkhFQ2dGWGRaUmI3eTB5bDJkc3FqaGVXVFV2QU9YSDgxQ25SMS93?=
 =?utf-8?B?a0hSK3c3VW1YZVVjaTIyUXZLMXZPeUtIWDBxTXFUY3RtR2lBdXlzNWsxejZ5?=
 =?utf-8?B?dW9BRlFMQUZsVXV0YTBJSm1pWXlLbmhQNDU0TDJiVTdnWEQ3ckRVKzhSMVoy?=
 =?utf-8?B?QTVYMEhCeGFsTmdWdnBhbm1OUzErMStyT2V3NUFZLzVTWDFWdmNVMWZQazJY?=
 =?utf-8?B?OVR5UG9YRjBTdDFZOE9TUWlFbDdiaWhXRHhHL21yWVpYeFMvT05lSU9xRjdt?=
 =?utf-8?B?UzFXWTlhQk0yRFNLQW9zbXVPSGNoM0dtVlRIYjZ5cVdtTVdaYVVwSkw4Y1RJ?=
 =?utf-8?B?a0p3NXpuWnl5M0FOQjdwR1hnTXl4ZEtFZHFhVkQ5c29XTjJIUDR0SXNPMWV0?=
 =?utf-8?B?ZDJqd1hXMjRhS2R6MDlyWW9nNVRwSzEwendOcjAveXdIOGI4M1huejhTYVoz?=
 =?utf-8?B?SUpGY0krdUsvbjF2ZzZ4Z1dxeEszS2Q2NmRDZVFDQTIrZGhQb0ZLU2V1V08v?=
 =?utf-8?B?WSswS2lDZjljZlFUMDhqL1FPU2lmQmNLWUhmV0tIVG1IQkE0V0tvaVZiQWVO?=
 =?utf-8?B?bEd4YjVMRE1GUkdTc3Fob09hVG1ybFJrS2ZiaTVxQnlHMWVETFB3REdjNW5H?=
 =?utf-8?B?TEg2dzgzQVZ6TEUzOUNhS0ZDbkUwZi9CcWdMZjFJNlJ4bVRrcUV1M2Q1WkZO?=
 =?utf-8?B?UDFDUFlQMHlodnRmQ2VzOGZDV1BCVUJTY0Z4cXErdnFOeFcxcXVtUERlV0tK?=
 =?utf-8?B?dW9mUDNhK3ZRTDFsV3RMRFFhU0JWVlV3UmhYR3JMUW1sS3NaaGJOZUFiZnlD?=
 =?utf-8?B?N1ZrcklJK3BEU2J6N243RngvaVYwcG9FTys4NTZhZE43NmkwN3o1U2I0OXZx?=
 =?utf-8?B?WTNuSmdoK1lIcE9HY0FHZzVjeHJaSWdpNW9WOS91OTY5eEdxRHNtdktTTTU4?=
 =?utf-8?B?VHkvSy9VcnZaWFVXRXZheFpuRHJxZmZvWDFPWDV6ZnI5bmRNbmpLOGZwVTNu?=
 =?utf-8?B?a0pSNUFEcjh3TmtmQjQzVm5OMzVMMDZKSmNPMVYvWVpVaUlYeWlSRndWWGxu?=
 =?utf-8?B?NW91UUs3MmQ4MGhuOThjY1praCtpU203M2lQYkNORVBweUNNbGFWcS91ZVBE?=
 =?utf-8?B?REI1d0F5NEY0NHBZUDFLSjJoQVZxWkZGbGVYN1dpOFo3NXlsa3EwWmRiU0xJ?=
 =?utf-8?B?MHg1TlFGcUQzRFhFR2FvbmJnclJlNVZ6cWUyMEcwc1kvVVRrWkllRGdqUmRa?=
 =?utf-8?Q?5xlgyC3X0GytdLEv+s7NdmY0Cbx59vij8oH7Wihzp/9h?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3DD7D4F25DAD7442A4E2A0A843E4DCD6@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fae95b56-7926-43f1-35a2-08db67af418d
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jun 2023 23:31:01.9714
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vpuhQ6ZAuBS8MPtWBAACxNXZ3E/cmjdZBqCD3Gf40OQvqxdlpsKcMdz+v2nHy5Yaop4pqKpzLQW4rOpwVOb/KQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8786
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230607_163114_814138_A1612791 
X-CRM114-Status: GOOD (  17.99  )
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

T24gNi83LzIwMjMgMTA6MDYgQU0sIEVuZ2VsLCBBbWl0IHdyb3RlOg0KPiBUaGF04oCZcyBjb3Jy
ZWN0LCBteSBvcmlnaW5hbCBwcm9wb3NhbCB3YXMgdG8gaGF2ZSBhIGRlZGljYXRlZCB0cmFjZXBv
aW50IGZvcg0KPiBudm1lX2VuZF9yZXEvbnZtZV9yZXRyeV9yZXEvbnZtZV9mYWlsb3Zlcl9yZXEu
DQo+IA0KPiBCdXQsIGNrIHByb3Bvc2VkIGEgYml0IGRpZmZlcmVudCBhcHByb2FjaCBhbmQNCj4g
V2UgYWdyZWVkIHRvIGdvIHdpdGggb3B0aW9uYWxseSBwcmludGluZyBkaXNwb3NpdGlvbiB2YWx1
ZSBvbmx5DQo+IHdoZW4gZGlzcG9zaXRpb24gIT0gQ09NUExFVEUgaW4gdGhlIHRyYWNlX252bWVf
Y29tcGxldGVfcnEoKQ0KPiANCj4gVGhhbmtzLA0KPiBBbWl0DQo+IC0tLS0tT3JpZ2luYWwgTWVz
c2FnZS0tLS0tDQo+IEZyb206IFNhZ2kgR3JpbWJlcmcgPHNhZ2lAZ3JpbWJlcmcubWU+DQo+IFNl
bnQ6IFdlZG5lc2RheSwgNyBKdW5lIDIwMjMgMTg6MDgNCj4gVG86IENocmlzdG9waCBIZWxsd2ln
IDxoY2hAbHN0LmRlPjsgQ2hhaXRhbnlhIEt1bGthcm5pIDxrY2hAbnZpZGlhLmNvbT4NCj4gQ2M6
IGxpbnV4LW52bWVAbGlzdHMuaW5mcmFkZWFkLm9yZzsgRW5nZWwsIEFtaXQgPEFtaXQuRW5nZWxA
RGVsbC5jb20+OyBrYnVzY2hAa2VybmVsLm9yZw0KPiBTdWJqZWN0OiBSZTogW1BBVENIXSBudm1l
OiBwcmludCBkaXNwb3NpdGlvbiBvbiBlcnIgcmVxIGNvbXBsZXRpb24NCj4gDQo+IA0KPiBbRVhU
RVJOQUwgRU1BSUxdDQo+IA0KPiANCj4+PiBDdXJyZW50bHkgd2UgZG9uJ3QgcHJpbnQgZGlzcG9z
aXRpb24gaW4gdGhlIHJlcXVlc3QgY29tcGxldGlvbiBwYXRoDQo+Pj4gaW4gbnZtZV9jb21wbGV0
ZV9ycSgpIHRyYWNlcG9pbnQsIHNvIHdoZW4gcmVxdWVzdCBmYWlscyBpdCBpcyBub3QNCj4+PiBz
dHJhaWdodCBmb3J3YXJkIHRvIHVuZGVyc3RhbmQgdGhlIGRpcG9zaXRpb24gbWFraW5nIGl0IGhh
cmQgdG8gZGVidWcNCj4+PiB0aGUgcHJvYmxlbXMgaW4gdGhlIGZpZWxkLg0KPj4+DQo+Pj4gVXBk
YXRlIG52bWVfY29tcGxldGVfcnEoKSB0cmFjZXBvaW50IHRvIHByaW50IHRoZSBkaXNwb3NpdGlv
biB3aGVuDQo+Pj4gcmVxdWVzdCBmYWlscywgc2luY2UgZGlzcG9zaXRpb24gdmFsdWUgd2lsbCBh
bHdheXMgYmUgMCB3aGVuIHJlcXVlc3QNCj4+PiBzdGF0dXMgPSAwLg0KPj4NCj4+IEhtbSwgbm90
IHN1cmUgdGhpcyBpcyB0aGUgcmlnaHQgd2F5IHRvIGFwcHJvYWNoIGl0LiAgSSdkIHJhdGhlciBy
ZWRvDQo+PiBob3cgdGhlIHRyYWNlIHBvaW50cyB3b3JrIGJ5IGhhdmluZyBhIGNsYXNzIGFuZCB0
aGUgb25kaXZpZHVhbA0KPj4gdHJhY2Vwb2ludHMgaW4gbnZtZV9lbmRfcmVxL252bWVfcmV0cnlf
cmVxL252bWVfZmFpbG92ZXJfcmVxLg0KPiANCj4gOikNCj4gDQo+IFRoaXMgd2FzIHRoZSBvcmln
aW5hbCBwcm9wb3NhbCAocG9zdGVkIGFzIGEgcXVlc3Rpb24gdG8gdGhlIGxpc3QpLCBhbmQgSSBw
cm9wb3NlZCB0aGlzIGFwcHJvYWNoLiBZb3UgZG9uJ3QgbGlrZSBpdD8NCj4gDQo+IEkga2luZGEg
bGlrZSB0aGUgZXhwbGljaXQgZGlzcG9zaXRpb24gb3V0cHV0Lg0KDQpJIHRob3VnaHQgaXQgY291
bGQgc2F2ZSBhIGNvZGUgdG8gYWRkIGNsYXNzLg0KDQpJJ2xsIHNlbmQgVjIgd2l0aCBhYm92ZSBh
cHByb2FjaC4NCg0KLWNrDQoNCg0K

