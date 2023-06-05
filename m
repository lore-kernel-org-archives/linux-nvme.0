Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4AC1C7EE24
	for <linux-nvme@archiver.kernel.org>; Mon,  5 Jun 2023 09:13:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EctUUaT0k475ZOvmjKlgxdpzcKhjtGsHf8ov/+h4VKI=; b=jqeZV/y76xRSAcGj7iBBoitANZ
	ts3yG0+uqw9EwvcqX/BcfxNCVkn+IJB6P5FdKGHl+XbQix9OjlBm16WSGqmRUqG32oxrri5uFVWVb
	cBoi9cMm4CW1NSFBEX0+hvTV4iqOclxWQVIsaKt1Q/GVnGKGnp27id5URc/CfkJsIKzFYYCIX8hha
	UqtLO+IUryXhI+ErVnpYS02uZ9NK9MGvYBxhs5PmwwIdDN8Qa2EmQID6hzLXqRIH3P6y7n7Glhoeq
	MtX1wboVbsEyUTTVRA7/YuZUPMjW/MkWk0xiVPb0byw7TYYnWcxN+K+hH2/Y42eGXZ1AML8LZ9uM1
	qJv2CT+w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q66HH-00EoCb-2M;
	Mon, 05 Jun 2023 09:13:27 +0000
Received: from mail-bn1nam02on2060c.outbound.protection.outlook.com ([2a01:111:f400:7eb2::60c] helo=NAM02-BN1-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q66HE-00EoBF-1a
	for linux-nvme@lists.infradead.org;
	Mon, 05 Jun 2023 09:13:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F5nTWCe50+rx8McChVXltCrFrJdIjH1fbC1+VWtcpeOkBkZdf0UlE46RZKIs+FxjIOc12awbWOGquChOuBKB4qaPPwc7knEifFqQ0ufaEspgTbbzY5DqGnCiNIG4ExFMnQewEmcE5urmH8/fHhfbpzK/psgL0L8dE5WGXvsGfR/9q23OJOqBEK+HP0keBzitfytlcyco4x6yF3CF5GW0/gabU9SysqZDvYA3LDP1+SXg9uV8xGhe154EEQsEOsMT96F9w/WH52rH4HwJ+9JkDIuDfgVcuRByo8Uuu2HFgvA8SUNvkK979zNy3v/hh/hyZHY1rpIXs4pCYNwjnU0a7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EctUUaT0k475ZOvmjKlgxdpzcKhjtGsHf8ov/+h4VKI=;
 b=GJo6jQTQQ3icsdai9D8hGiugy/6XrrTN0OcR/vZlAjes8UqPE09xJoegQtCvvKxmD5enCMcQNwkzsGwuFzNbeVWm1zLfvv6RaJUn/rVeOwHvIU3ncHnvQEQWd9kJqUT2ZjIoQhEBev14YEwFpJD4w30fcF4XWrbY/AD2/RrzsJKMeFzR1CJEQeN7ljVuQmh6uVRdmuer7T93W+zMCaFGCp4ndS2jTb0lY9Gtx/aD/+Q5NLLcN2/Q/E5plO8w3kBwDQ9KkvhQqYsZWIMYx2spCdYgYD4DHtthFP1oCdVe6IRnN9zG0A4fvK8+RjR5wFjfyldfQA3seL+zt40hFdYTgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EctUUaT0k475ZOvmjKlgxdpzcKhjtGsHf8ov/+h4VKI=;
 b=kQagtFTR0sVfe2Oz1cwBnJjhbY+c5DR+IynbagwbJ46cWbZGIkSY83f5KoU9WqUe97lPx9K4aCWeR0Ur+B0C6oWBITqmnpSieiGutNHqMl7qY1NOEY4264b6UtzB0l1daZafofWOxTGIPCXYmGnkrY6+Ip0Mkl5OvAecTvlici+mWLNwcE2Ih7DQG/60JYJpHCOtjbrAW6bJbNbNa6+FhFbPTQh2oxmcUrWC1SxxxHKMlOCsskchaPch77AyJCh3vH+MknMHWjpec7IIxJ4VnUPDFuhGvym2twNLK9IIr3BnjKrlJbhJUBs0h163c4XZAkE3XRQlFzUlbUkQ1tnZgQ==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by BL1PR12MB5804.namprd12.prod.outlook.com (2603:10b6:208:394::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Mon, 5 Jun
 2023 09:13:07 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::92c6:4b21:586d:dabc]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::92c6:4b21:586d:dabc%4]) with mapi id 15.20.6455.030; Mon, 5 Jun 2023
 09:13:07 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Max Gurtovoy <mgurtovoy@nvidia.com>, Chaitanya Kulkarni
	<chaitanyak@nvidia.com>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>
CC: "kbusch@kernel.org" <kbusch@kernel.org>, "hch@lst.de" <hch@lst.de>,
	"sagi@grimberg.me" <sagi@grimberg.me>
Subject: Re: [PATCH] nvme-fabrics: open code __nvmf_host_find()
Thread-Topic: [PATCH] nvme-fabrics: open code __nvmf_host_find()
Thread-Index: AQHZlR4txVfYHBTKOkOMP6/o0z83oK95zqaAgAIi/gA=
Date: Mon, 5 Jun 2023 09:13:06 +0000
Message-ID: <4b0ddae0-bc01-34ad-9ab4-4d63e262ae3f@nvidia.com>
References: <20230602064742.56298-1-kch@nvidia.com>
 <f03639ad-18b7-a051-c83c-7bca5ef1ec0b@nvidia.com>
In-Reply-To: <f03639ad-18b7-a051-c83c-7bca5ef1ec0b@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|BL1PR12MB5804:EE_
x-ms-office365-filtering-correlation-id: 16c1b564-fb62-4288-e84e-08db65a51338
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PuI1aktfni5eX6s885WfludgbVfvX5qSIG9bfVf5IF/ZC9PA/yqKy/qZuahwZhlrRO0A5FK8vFvel17OsTHW6GVq8hRSAwjxBjdICWGFp1o0XHaxRSKPG/vyIYqCV2YuUOGexG+RYkoU+pG3fi20VXCyz37j5GzyXk9bQ/n1bZylehL9k9m+fw5JUaluMMb8FY/7ri5OU5t/A7Z8uds4CEi7g3mKt/Hpmqa8nbick/m4UU1BNkDsT61TkeGVV9ZlqTO8/wbLNk8tYBfmZQIXx2YdrNmrx8TCBLMph1N38k5vvGzfzcmPsWcrZQ7wql9NDF5lEpOtIbsfWwW7YZz6UoQgSjcnN7cJmtRs2HUVdVM2kaNiVB3gruvqWXg7QD0lvFEgWeQ2l1+b07ean8K9MJ9OPlfv1aHZD6YdnVRAVi73NPzxagSyZiO0kEiSB7V9ftRhHXP5RdoiWJDYTAgO/9mOsiY6YmWSS3Yu9noj+oF7noYzpLJM7+r/dPCbQLSouAXOMetP4OKcWviYwbEPw0e+bSc2GBONvSUgPpw+usGeNB+E8JtbuLIUZcWiWGWoTQDWMp+BcMal6HGA9wEPzE9w4JGaZ329eIpkdKc/oKFnLidzIYWqQIrV3TWi6SCkRXS+0KLqB2r67LG02R4ewPlLFeiUTF47/HN+oW4KUKMlrEji+bKMaqIGVJ5n6Am1
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(366004)(396003)(346002)(376002)(39860400002)(451199021)(53546011)(6512007)(6506007)(26005)(36756003)(83380400001)(31696002)(86362001)(38070700005)(122000001)(38100700002)(186003)(2616005)(41300700001)(54906003)(110136005)(2906002)(478600001)(76116006)(66946007)(91956017)(66476007)(66556008)(66446008)(64756008)(4326008)(8936002)(8676002)(316002)(31686004)(5660300002)(6486002)(71200400001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZXVkZ0VqZy9DbWdkN015bUlWTlc2VGI1WXk3NUNBUlFSUzZscU1DQ3F3RUNp?=
 =?utf-8?B?S2xiWFBoTWoycEluR2dLQkNtVUhVUHpvSXF3SW5hQk1rNVFscENsSVF5QXc0?=
 =?utf-8?B?Q0FSb1U3Zmlvbmk0bkF3TS9Ia0NCZnJ2ZnczczNDR2QxWVBVemJnUC9Zek9k?=
 =?utf-8?B?bmE5Kys1dU5ZZ09jTE9sc1YvTXI1enhzZ0dielk5MlFET0pHbC9jQ2I5dm0x?=
 =?utf-8?B?R2sxR3Q0SHZPN0NXWjNSWVFaQ2RVWkhHKzdFNXhZWlVza0xNeHJTdTJsOHpJ?=
 =?utf-8?B?bHJ6dFNMV2NYUWdSbEp6SkhLdmVzODZacy9EK1BRd1VGRnl0T1hJV1Jza3ow?=
 =?utf-8?B?TlVhbXR4QnhTaGFHZnZMQUtiSUVJL29QV1R6cm1VZmszMy9CSVlLazBIUGlp?=
 =?utf-8?B?OVdDUnRnUkhTZ1VBY0R2MkluLytSZi91a3NxcXA5alFBczRkdzJuVUE1VUw4?=
 =?utf-8?B?U2ZWSGtncmczaEh5aGZGbGNYaTFFS2NaMFpMRUFYczhxeVRZZW04ZGtkWjE0?=
 =?utf-8?B?OWdVc3V2MWhaaXBrVjV0Ynh3ZmZQWHB0cVpxakJDampsZGZjY2FTSmtubXE4?=
 =?utf-8?B?ZzRoQ0VYRXMvZFNONTNTMGlBdVMvaHRDb1BMdXAvMEhDSmRaNmlTVVFXZUQw?=
 =?utf-8?B?MmZ5TEh0YmZRYVBNSGhXUE5yZkVOMHVYMFNVNWZXOGQzZ2VwMHlvZldRbTIr?=
 =?utf-8?B?anhwdG5vOTlxTnhFVWF5VWpwV1JZbWd4TkIzUDZ0aldRb3hQc1dxWWdSbmxG?=
 =?utf-8?B?VkNYM0dHQ0FhTW9kNlVod0duREN6WkJRMWxJbzJVaDRPeTZ1U0NmTExENWY1?=
 =?utf-8?B?Q2E3K011UStQV3RwVVJmUEUzVVdXb3lrVlZXUzg1YW5TMFdlNE45RVdmZ3ZQ?=
 =?utf-8?B?aXhGbzZJMFlaZlZLWEpXNGt0QzZxU3pFZGpTQkdabXU0MnBzeVFlTjJXb1U3?=
 =?utf-8?B?eFNzSnAvZVIyaDdLcWRnMktMWWRPMlE4U2VKai9sRkpHdXpQSWxOQTgvZWZp?=
 =?utf-8?B?VUk0eHFqV1Y0TytwSGdsTG56bStEUWZONlNSUW0wKzFiTERrbkZmd1l4cUFj?=
 =?utf-8?B?VnVmMllEbzhyWlZIcHEzZUtkNkdIK1loalBXamZpSitBd3dPSnBtTklJQzl1?=
 =?utf-8?B?R2F0SjJuTXJodG9MSk83cGVPbzdrWCtQbDVhSmxKZG4yWS9iYkJKWlFOSUVa?=
 =?utf-8?B?TG55OFdWbjduTHAydnZpTzgzMTFKMk1FZFdlWjhkZUlHZjFhR3VMcmlWdFUx?=
 =?utf-8?B?VG51MW5FdDBBTkR3cmVuYnZVQ0VuNCt2MEFISlJzTEE4SmZvdmxhVmVvdGZE?=
 =?utf-8?B?SzZOeGJTTkNaeVl5OTdiU3JYTTJOWGV6Uk5mQ3k3cXpPOXY3WEpSaEc3TnFS?=
 =?utf-8?B?NkdUQ1l4Ry90YmJsQ3lSZmdoeG14b1hnV2duZDkyNU1zL0lYNi8vUGtmb1VU?=
 =?utf-8?B?NnJnRUVlTytpMlVrQkJlV3kwMCtZdWw0TmFhb2FXSDBkMEhVNzArUGFCbEFr?=
 =?utf-8?B?WlNsU0d4WUlLaFhqcFZJdldJWEc1bjJHRjNidVI3SU5hMFp2aWFHL2xGZmVI?=
 =?utf-8?B?VUdscldFQmpTWXZqVnVsd3FXTjJiYmt2RUdYVWphZm5rSE1ZM3d1QklMSVI0?=
 =?utf-8?B?M2NyM1FnTytzRXRRQmpaYXZoTys3SDVQWS9rU0tuUDNxWUdEZmVMcmtSbGZL?=
 =?utf-8?B?UFh5QjlCTFphOEQ4NkZ6aGVmRm1qRjlWWkZqajg3OTZKZFhlT1FpbFp3NFVG?=
 =?utf-8?B?ZGtzRDE5V1g2enNTUVBwUlhOckllNkp4U0JNZlJ6dG92ck1YSER0YWtjR0U2?=
 =?utf-8?B?aERWamlneFdLQURVYlB4Umg5UXM4VjQrQlcyTE4xQml6b1BBV0VIcmxpb0Y3?=
 =?utf-8?B?a0dISmxMMFhxc0NaSEJseDY5dHFSb2g1clpTL0FVOVZGRSswWC9hajZzNzhh?=
 =?utf-8?B?WUxZTWpPLyszb0h2Zk8wenFHb1Qra2xiNE5YZUd0N3puT3YrWk5tUDU1THVG?=
 =?utf-8?B?a3hUSW9JN2dPdFdRWjg5UUptamJwb1lGYzhBOGFMc1crZGhKMEdISzhwOGlm?=
 =?utf-8?B?Y1l0Z28zeE9QOWJ0dnpQU0FxbUt5THFjUGo1OU0xcWFFMUc3NUxIdkRSMm5R?=
 =?utf-8?Q?l8/a6D9g+5lDA+G1jM1dnrRzY?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DEEB75AAE3D681489A9038BEA332B1F6@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16c1b564-fb62-4288-e84e-08db65a51338
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jun 2023 09:13:06.9463
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0TlrveXNTjVuiMVD873YUK3MXdq87SFn4erK0tX2b8+D+O5lmWnAQVjWfT1+sfqnnLIorZ65OHWPb2HDbXieew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5804
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230605_021324_543781_455025B4 
X-CRM114-Status: GOOD (  19.38  )
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

T24gNi8zLzIzIDE3OjM1LCBNYXggR3VydG92b3kgd3JvdGU6DQo+IEhpLA0KPg0KPiBPbiAwMi8w
Ni8yMDIzIDk6NDcsIENoYWl0YW55YSBLdWxrYXJuaSB3cm90ZToNCj4+IFRoZXJlIGlzIG5vIHBv
aW50IGluIG1haW50YWluaW5nIGEgc2VwYXJhdGUgZnVuY2l0b24gX19udm1mX2hvc3RfZmluZCgp
DQo+DQo+IHR5cG8gKmZ1bmN0aW9uDQo+DQo+PiB0aGF0IGhhcyBvbmx5IG9uZSBjYWxsZXIgbnZt
Zl9ob3N0X2FkZCgpIGVzcGVjaWFsbHkgd2hlbiBjYWxsZXIgYW5kDQo+PiBjYWxsZWUgYm90aCBh
cmUgc21hbGwgZW5vdWdoIHRvIG1lcmdlLg0KPj4NCj4+IER1ZSB0byB0aGlzIHdlIGFyZSBhY3R1
YWxseSByZXBlYXRpbmcgdGhlIGVycm9yIGhhbmRsaW5nIGNvZGUgaW4gYm90aA0KPj4gY2FsbGVl
IGFuZCBjYWxsZXIgZm9yIG5vIHJlYXNvbiB0aGF0IGNhbiBiZSBhdm9pZGVkLCBidXQgaW5zdGVh
ZCB3ZSBoYXZlDQo+PiB0byByZWFkIGJvdGggZnVuY3Rpb24gdG8gZXN0YWJsaXNoIHRoZSBjb3Jy
ZWN0bmVzcyBhbG9uZyB3aXRoIGFkZGl0aW9uYWwNCj4+IGxvY2tkZXAgd2FybmluZyBjaGVjayBk
dWUgdG8gaW52b2x2ZWQgbG9ja2luZy4NCj4+DQo+PiBKdXN0IG9wZW4gY29kZSBfX252bWZfaG9z
dF9maW5kKCkgaW4gbnZtZV9ob3N0X2FsbG9jKCkgd2l0aCBhcHByb3ByaWF0ZQ0KPj4gY29tbWVu
dCB0aGF0IHJlbW92ZXMgcmVwZWF0ZWQgZXJyb3IgY2hlY2tzIGluIHRoZSBjYWxsZWUvY2FsbGVy
IGFuZA0KPj4gbG9ja2RlcCBjaGVjayB0aGF0IGlzIG5lZWRlZCBmb3IgdGhlIG52bWZfaG9zdHNf
bXV0ZXggaW52b2x2ZW1lbnQsDQo+PiBkaWZmc3RhdHMgOi0NCj4NCj4gVGhlIGFib3ZlIDIgc2Vu
dGVuY2VzIGFyZSByZWR1bmRhbnQgSU1PLg0KPiBUaGVyZSBpcyBubyBlcnJvciBoYW5kbGluZyBp
biB0aGUgY2FsbGVlIHNvIGl0IGNhbid0IGJlIHJlcGVhdGVkLiBXZSANCj4ganVzdCByZXR1cm4g
ZXJyb3IgaW4gdGhlIGNhbGxlZS4NCg0KYW5kIHRoYXQgaXMgZXJyb3IgaGFuZGxpbmcsIHdpdGhv
dXQgZXJyb3IgY29uZGl0aW9ucyB3ZSB3b3VsZA0Kb25seSByZXR1cm5pbmcgZWl0aGVyIHZhbGlk
IGhvc3QgKHRoYXQgaXMgbm9uIE5VTEwpIG9yIE5VTEwgaW4NCmFic2VuY2Ugb2YgaG9zdCBpbiB0
aGUgbGlzdC4gVGhhdCAtRUlOVkFMIHJldHVybiBpcyB0aGUgcmVhc29uDQp3ZSBuZWVkIHNlcGFy
YXRlIGNoZWNrIHdpdGggSVNfRVJSIGluIHRoZSBjYWxsZXIgLi4uDQoNCi3CoMKgwqAgaWYgKElT
X0VSUihob3N0KSkgew0KLcKgwqDCoMKgwqDCoMKgIGdvdG8gb3V0X3VubG9jazsNCi3CoMKgwqAg
fSBlbHNlIGlmIChob3N0KSB7DQotwqDCoMKgwqDCoMKgwqAga3JlZl9nZXQoJmhvc3QtPnJlZik7
DQotwqDCoMKgwqDCoMKgwqAgZ290byBvdXRfdW5sb2NrOw0KDQo+IFRoZSBmaXJzdCBzZW50ZW5j
ZSBpcyBnb29kIGVub3VnaCB0byBqdXN0aWZ5IHRoaXMgcGF0Y2guDQo+DQo+IExldHMgaGF2ZSBp
bnN0ZWFkOg0KPg0KPiAiTWVyZ2UgaXRzIGNvZGUgd2l0aCB0aGUgb25seSBjYWxsZXIgbnZtZl9o
b3N0X2FkZCgpIHNpbmNlIGJvdGggYXJlIA0KPiBzbWFsbCBlbm91Z2guDQo+IFRoZSBsb2NrZGVw
IGNoZWNrIGluIF9fbnZtZl9ob3N0X2ZpbmQoKSBhZnRlciB0aGUgbWVyZ2UgYmVjb21lcyANCj4g
cmVkdW5kYW50IHNvIHdlIGNhbiByZW1vdmUgaXQgdG9vLiINCj4NCj4NCg0KSSBkb24ndCB1bmRl
cnN0YW5kIHdoYXQgeW91IGFyZSBzYXlpbmcsIHByb3ZpZGUgYSBjb21wbGV0ZSBjb21taXQNCmxv
ZyB0aGF0IGNhbiBiZSBhcHBsaWVkIHZlcmJhdGltIHRvIHRoaXMgcGF0Y2guDQoNCi1jaw0KDQoN
Cg==

