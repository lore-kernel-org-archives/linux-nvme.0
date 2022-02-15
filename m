Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FFAEC43217
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Feb 2022 17:03:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Abr0kLieqhnvdFg4WFILudTY5eM93PXHp3Qn3EpCmOg=; b=S12949JR20ysssY76UG6L3i82q
	kDLKoSJfiSROFed6QZOE91mQU/JxaNarvRv+NAS/6gZGrSoAc0wmyg/Y16nGMdvB5iDPnmNIT3CI2
	3s3WmntYkizbSTJC0Xie4x/4kE6ja6y6ktJBnmJQQIXCFNBJJkOcbEUktQWiBAq4bC/qnsCy2YYff
	VTsPk776WYC/gefkBycvYABNksJmsomwL9yhNBs78ItuoW8XMH5JzV7f2u5e0PcjCJxlEHBY+AGAW
	4Jp9zP/b5KpyiucWoFP/H6Wh4q9B5uUFLx/E4JtIqUAwFxag15TYNqXNNiIJifGgW7H5elJq7TqkC
	ukHe5LEg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nK1EZ-003ogd-Uc; Tue, 15 Feb 2022 17:03:23 +0000
Received: from mail-dm6nam10on20630.outbound.protection.outlook.com
 ([2a01:111:f400:7e88::630]
 helo=NAM10-DM6-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nK1EX-003ofT-OV
 for linux-nvme@lists.infradead.org; Tue, 15 Feb 2022 17:03:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mhVdfKc8WZImuJMev+koFfSchIky0Kh/4DDe50HyWB0OpvFP655FO3qdNhgZn3gvGrQlFVBkFU8L7bnGwd0bPv4Y4LIjaBMsnnM45yO2H5QQmKeQHAMaSiQlNgb3+6+7pd3WbBMy4YOhL216LgGOFttQVs7Iit2urrN8WOMv7qnuB6xAtHXbLno7bUHFGHG/Qx/oNwngsQwbFyCZ3LgbCZzPa7Vhx87+nDRv2b0aWIJs9JJbcbHTNLE7IMw0piLgzlcBrTtR4Y2QJwu8FRynrf0ndhoe7EV+trzvwxpYtfrtyDgOHG4s5+fKzTOcrdTnQLXnPzim5ykh7JP7PBn4dA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Abr0kLieqhnvdFg4WFILudTY5eM93PXHp3Qn3EpCmOg=;
 b=OpNz0UGrocvQ8JZZt91+dzyhawH7Tjgw4Q1VX57doqdaFKnbNPLtTv9nYLSFpHG0lXr/8mSnfhGomZ6Hg+Y+WxkSmRWxuj7feH2RrTL0/AOgIl5xNctiCDksPwFeLOIGHsm0UxtjvZF+P8fiSC+o+OrR3scklfYOWwQhSi20WtkTWR2XvAJiW4SRsTGJzQsZc3YVUUaEno4WVDPkwAh2s9+S5RGgqwQOXShWIma1olDZHr4WGY7PA/Sp24/nQeK7zhBOsMulUFdIDGBwcXGr09DsAOnAzUJwKfaDh/HuGQxnbcblRi4ejBUhx+tXJjRoLL4k04U+TMEkFP3rGYRC6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Abr0kLieqhnvdFg4WFILudTY5eM93PXHp3Qn3EpCmOg=;
 b=rAjeM7P+QfNFPLXiSkyVWzxugU26sWd6ZxwKQ2+WdzMuLrAkzn782NfyB7+B/ztB8RJwGb+NisRGIjxmMsOyPrUamF5B2PuME4M5FiAqzhOU/bQYxGLzDzFiMHMd1GE9BOpdJGymr1iHrXFuNj6xV8OQyED4ppMgMW0Vz5pwMWIz1IKSD9nP/SscIJJV5JFQdEjh6BFiQ27oKrsFq6VGfhf9WjWPvwZXRT7A5om5DwUTdFpPDDullv6e+TWZ1sqfBUvDxHJMRSujRabtO5RccO2yEVPbxiFQUfJVmsPM76jo57GFgZi8ixNkQwtZ2qMVJ0sc2mQvuyjaOB7Nu3j4Eg==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by BN8PR12MB3009.namprd12.prod.outlook.com (2603:10b6:408:42::32)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Tue, 15 Feb
 2022 17:03:17 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::846c:d3cd:5a30:c35]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::846c:d3cd:5a30:c35%5]) with mapi id 15.20.4975.017; Tue, 15 Feb 2022
 17:03:17 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Keith Busch <kbusch@kernel.org>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "hch@lst.de" <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>
Subject: Re: [PATCH] nvme: remove nssa from struct nvme_ctrl
Thread-Topic: [PATCH] nvme: remove nssa from struct nvme_ctrl
Thread-Index: AQHYIoXgocEhShxKnkKjy1hThFgXH6yU1s6A
Date: Tue, 15 Feb 2022 17:03:17 +0000
Message-ID: <8e48a72e-8d52-2395-4889-6ec6a493c3d6@nvidia.com>
References: <20220215153719.1934484-1-kbusch@kernel.org>
In-Reply-To: <20220215153719.1934484-1-kbusch@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d2ff0bbf-ed4c-4cdf-bcb3-08d9f0a50fca
x-ms-traffictypediagnostic: BN8PR12MB3009:EE_
x-microsoft-antispam-prvs: <BN8PR12MB3009818845786A76E41A259DA3349@BN8PR12MB3009.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0mJrq0iKPglEQ4VwdZvnysSbiT9V9vyNxSySplx4uaTEinJ5tX/ca4g6rhelRI+kQ4xsbM6OXUsx9DLNytBCJqOEFzF7wvf70cn08qGyGup3kWdCzIbmArxrnbo3QFsM7GnxsM2CHGMSTyBZICrLIT/frJBrbNHjB8hRfPB6HwezuQn3IJg4s55B7l4L1cJjvhJ4hKSTfPn4iT83CbJ1ejG++S3IM87isvdUnHOgErfK1sBUl8q2tnYvYyGfGf0GFdx3JcsbC02FUom/MvBvTMWmbur5mHfJZbnz7Z+a6TC5rpMYLtZkdvI9PoJhcESovKZn2VVWlALbPhWWp4JT+sraMexzdIzFpWqrjiUPIamKtTt+KwN2xv01mxUb9XP7Dxrb4weEHomIhmQlmLu2rIVDb+kZ2LyOoXaZMlF8dbb1ufYAxFhT2zufN/MKP5lwixmsIKw1pKc3K+S78wmyh2wmuUG2UmpVpTdTbfHcjYsIAQtg0FUmtCbi5n6scDGFos4ftTNrSxGtfUPP5Eo9MBOHMepe4rUogL8TH7TkoDd0Lazj9YrrTlYQjLZ4CskrxRhznXvK2esy6hG+MHTBD//NBdpfINhvdN8e8kBm5XSNNezG131L+dyoyrvUzugiYE46JuoBpa1ayXGR9xjPE9S8H/osajCdS9UfOlTs/bR+vIVucgaXOMR/i6KqndYc3EgR94NS9zagOKicPYC6DnihdiyLG5MxO425FcW/fRyFD+qEAwUoJVyRVvIHRiQZ8Bi4GckQNLRlb/CFNv2Zbw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW2PR12MB4667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(2906002)(4744005)(6512007)(186003)(64756008)(2616005)(8676002)(66446008)(66476007)(66556008)(4326008)(54906003)(66946007)(86362001)(91956017)(31686004)(38070700005)(6916009)(31696002)(316002)(508600001)(5660300002)(8936002)(53546011)(36756003)(6486002)(6506007)(71200400001)(38100700002)(76116006)(122000001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?czcyT1UrcitRc1lvaUgzbUZ6MkZWTmdua1Vta0J3dUdadkl3V05GTzRVOXAx?=
 =?utf-8?B?cXlCcURRODVBczJSaGZoWkZsKzg2UGJqSEE0OExKSDRZK2I0aG13UHF4LzRK?=
 =?utf-8?B?eFpNRURUc0tuQ2ZmdW5TdWxsYzc1aGZsS3VCeXNVdE9oQlVHREhvRGVhNTVR?=
 =?utf-8?B?NmJSVkxDaE1hcDRLQk5SQ0VXMTRjRWlpQnpRL2o3UDE1N2hlenRMQTgrOEE2?=
 =?utf-8?B?bmRWL1BwWkhvb0UvK3JVQTFmRW13cEhJVjVFQ3NrYTlzZ0lqY01LdDRJa1Uv?=
 =?utf-8?B?ZThoSDIxN0UwMmdaajg3ZVExbXUvQ0pvN1lQdEpTeENXZXdzSU5jVVZudWNO?=
 =?utf-8?B?cGIvVnRwcjJHOStMOUN0b0ZqdWxpL3lKZjBaajdtbDlLbVJxeXNKVzdvejZt?=
 =?utf-8?B?b082MzdlSkNrdkljZGRxNWEvVGtqcDZzVG5HQmJlRVBWM0N1NzJqTDZQeHpP?=
 =?utf-8?B?emc4b25JWEgxVjB4dnZySXczQi9XL2NiSWcyaUVqTyt5ckhMM3ZQaDkrVndn?=
 =?utf-8?B?clJjOHVZOTVIRmZzUFVWNTZCWC9MVXhQTEp1KzJKSkFZa2NnK3ZlbnJqdkV2?=
 =?utf-8?B?RTFHU3JnQURZcitiUHBtOVpLSHhhTkJkdE9uMWxFSEhsZVhWT0l0bVRxNlNP?=
 =?utf-8?B?aEQ0MzdRQitZQWdQck16Y0xPTmphTVl0eGx2ZWVza0RucjFFOFduTDd5MlhJ?=
 =?utf-8?B?QmZNTnRmdk1SK1IwK3dKWEh2TzNmSUl2UHRqVjN3dW5XYlI4Vis0TWN0V0Mx?=
 =?utf-8?B?NHNiZHh5bDg2dXc4Qkxnb0F3WGFab1lPSStZRGYwMlplVzFWSXZNVFk0ZHRp?=
 =?utf-8?B?SG1YN0hJMFFDVXhSOFpuQ2I2a1BaQjdEYTZBOXZPUzFjdm1qb3l5OWZlU05x?=
 =?utf-8?B?WTMvQ3ZnZENtMWk3UWV6Y2Vmd0xHcElySXhWSGo5UEtlY0xZUjRrdTh5eE5X?=
 =?utf-8?B?U2ZxWk8wanNubnJTQ1BjSnVBRU1pcGlDU0VyUUloV0x4RU16WWJ4N0puRTE1?=
 =?utf-8?B?QXgvRFVuc0NjSFNSMlRxREFPVnZFSVJ0UUFGSTFwMWhoY1c0VG1PZC92RU95?=
 =?utf-8?B?Vm5FWml0QjZUV1hmaW5Wd3pPNFZ2UVRhaWNFblpqUU1rdFk4eVd3WWYwd2Jh?=
 =?utf-8?B?dzAzVjRnRmxZTElTRDFKZG44M0gvYThOUHQ0TjFWNHA1M1lxMVliWm5tSksw?=
 =?utf-8?B?bmNWaG5tQVV4ekdOOW9KVXZKdThYeTlmT0djcnZJQWE4aS9kczZVTGxObnNq?=
 =?utf-8?B?L2R0a1YzVHI2RnVaV0Z1SzVOc2hUZDFsWm05THM0cWFCVHd2TVYyMlA2Y21X?=
 =?utf-8?B?VVBURWJSSTRwS0wyRWp1QW01b2pRbUY2N1pqSjducWJ5S1BpOGYyditLVXhl?=
 =?utf-8?B?a2w3VHVtUkp4clNOTmxzWktvd1FvVHpoNmRtd0MzYXhOck9OMmtsajRYN09C?=
 =?utf-8?B?NHByaVM5UG1saTFYdDFVUHkyQzhrN1ZYVlhlOTR4MFpiRFFBRGl4UTZGTmVq?=
 =?utf-8?B?ck5xTStmY2lsd0FnU2RXTDR1eStXR1dmVWZnUWNJSllDL2t2UThyN0RlTnpY?=
 =?utf-8?B?UStTMm5UUDlYOVRMU0NOUmdKcGRObDhPNDNRbWlWZTQ5WGhQeVJZU2pqb29E?=
 =?utf-8?B?cWxmckhBVFlNY2I1cnM1NU1TUG0rdTQ2dE9rWm9LVkFjbjhWVjdZcUV1UzNU?=
 =?utf-8?B?S3Z6VWYzTUNCZnR0dDIveGc2TFRoRWo0MWFpVEJsRkJGUzQ1NXRoVWNQSGgr?=
 =?utf-8?B?alNCTFpGQUFYaEdKdC9YRFhlejBMdHlLNzZwM2xUYXR2dzNacWZ4MXVYYmRL?=
 =?utf-8?B?dkxGK2g1QWRHS3JnOEJrdmRuL05JR0drb2J6eCtIY0FPS3F6S3lyQkNvYzMw?=
 =?utf-8?B?MkVScW0vVjM0TGdlcW1meGlnalhoMHhtYlpXdFNMZWRUMGpvTE9yY1Zmc2Yz?=
 =?utf-8?B?R25MK0I4cHRRTk1iZG8rdk5CaDJpSS9KeGszWW52OVIxVVFuc1pzUG4rOXh5?=
 =?utf-8?B?dVF0SVZnSGxCU2loc3hrL3AwR0xtRjI0anZFeTc1R0FsOFd3L3FZOUlmSHBu?=
 =?utf-8?B?ZlE5Qkk0ZGwxU2swaG85dkc2NEdzSnhIQ0xBak9pdlZOUlE3UHdZam9nbnU0?=
 =?utf-8?B?cXZ0cHQrbkNBd2RFWDhQK2V6L25SK0pTdXpnUThKOXNEb0ZlUHJ6K1o1cDY2?=
 =?utf-8?B?MGUrdUVuU2ZWenhKZWg4T01jNzlaOU9Qa2h6R0hBcnp1YlN2aDhxa0dwWDNs?=
 =?utf-8?B?aEN6S0l3bXl3ZU11Z3dlYkZjeFZBPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B0F3ABA1299431488CB048E319201188@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2ff0bbf-ed4c-4cdf-bcb3-08d9f0a50fca
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Feb 2022 17:03:17.3600 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9i0CnMVlfVMEtKfmiz7LsKI/pfSL5lvVGZgQCjDrl6YX2epl5Y1WI10FyYSCa3hwlc6xlhG0cBCqWHVnbUKZHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3009
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220215_090321_818783_DDF1F04D 
X-CRM114-Status: GOOD (  10.94  )
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

T24gMi8xNS8yMiAwNzozNywgS2VpdGggQnVzY2ggd3JvdGU6DQo+IFRoZSByZXBvcnRlZCBudW1i
ZXIgb2Ygc3RyZWFtcyBpcyBub3QgdXNlZCBvdXRzaWRlIHRoZSBmdW5jdGlvbiB0aGF0DQo+IGdl
dHMgaXQsIHNvIG5vIG5lZWQgdG8gc3Rhc2ggaXQgaW4gdGhlIGNvbnRyb2xsZXIgc3RydWN0dXJl
LiBVc2UgYSBsb2NhbA0KPiB2YXJpYWJsZSBpbnN0ZWFkLg0KPiANCj4gU2lnbmVkLW9mZi1ieTog
S2VpdGggQnVzY2ggPGtidXNjaEBrZXJuZWwub3JnPg0KPiAtLS0NCj4NCg0KTG9va3MgZ29vZCwg
Y2FuIHdlIG1ha2UgdGhpcyBmZWF0dXJlIGNvbmZpZ3VyYWJsZSBmcm9tIEtDb25maWcgPw0KDQpB
cmUgeW91IGFsc28gb2theSBpZiB3ZSBtb3ZlIGZlYXR1cmVzIGNvZGUgZnJvbSBjb3JlLmMgdG8g
aXRzDQpyZXNwZWN0aXZlIGZpbGVzLCBpdHMgZ2V0dGluZyByZWFsbHkgYmlnIGUuZy4gbWFpbmx5
IHByIGNvZGUsDQpzeXNmYSBjb2RlIGV0YyA/DQoNClJldmlld2VkLWJ5OiBDaGFpdGFueWEgS3Vs
a2FybmkgPGtjaEBudmlkaWEuY29tPg0KDQo=

