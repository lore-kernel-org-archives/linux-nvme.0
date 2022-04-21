Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9B9EC433EF
	for <linux-nvme@archiver.kernel.org>; Thu, 21 Apr 2022 22:05:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Cc:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2+U6pQRdDwDSblsse9vm1PpVJeP1gaU29Ag0Kmjwoc0=; b=voZfBMSofsVjkcSTgit0krF4+Q
	R+gPeLLt9gQJQadwbdTMH1HXMBl7VFNX78CemFfPwAJlP6QjpvlMq6BTVV/IU/SxAVMoTk7IaQwqn
	fE4jsyPfIVfTp3DoJBz4b4fNGgQA2hUmI1RTQy25UiOP0hw74KjwlC1XUxSSc8nwpOatd7D0WyvFR
	L1JJurko1flMu/563ze5i8QvJerJ13XXwRDjnlx+62CLDoRRCvyMrjvaDZqGhn/X50ycsHpO4/vFo
	5e9mS+oFgqqxDjrwqj48xtGOBy8Kc1rCW/TWkwIlJ7lVHL1LznWmfPoTJkFA+6H6fvBPYmN4P3XkC
	aVX+cmEw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nhevX-00F9Yq-MV; Thu, 21 Apr 2022 22:05:27 +0000
Received: from mail-mw2nam08on2062b.outbound.protection.outlook.com
 ([2a01:111:f400:7e8c::62b]
 helo=NAM04-MW2-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nhevU-00F9Xh-R4
 for linux-nvme@lists.infradead.org; Thu, 21 Apr 2022 22:05:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VS1J/e78wozL2yVkSmmtC/VKwF1PTU+pZxyfTZrTlCC2WgwKnTcQYo8EK/zQIBzNnhtl2E/Np6E5GYimMLwbXHXLzGfzkGBamF5xK8v1EeR7os2Nb1XhXS4EaVqVLI6Yf2R3HkgBWGsw0bLjRcTtmKK7w8mpJ9HYiJojjo4I8XS9vBe1z1iKIqf37KoHUQZ4bj3QjgqomeCyeP/ecvL9yejdc8RDO9YnOD1oz7DgbgfbWg7uvr2hfOwVq3C156NmYgt/iHokBOccNIOlL3YASVtAa0FYHXz+MY/jbqgxhsX7kymaUnJlSdNby3WBrh4JSMET0sm6qqmgTaYuc5IlKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2+U6pQRdDwDSblsse9vm1PpVJeP1gaU29Ag0Kmjwoc0=;
 b=X3qW7SHoIE7mPC6CUcT4LJXBKa6KG6UVrcmQBiz+2GiAKoIFIHAQjWS1RbxmTSwVcDHBYzZq9i2pUnw11XfLY/WjPqLljnZ14yZGp+3/XPaCP/1Ji4nt1Hrxl+mR0pQPI5E1mDdV3bsho8CAB0f5P6YF7PV6LC0MwZV53xZYuMm1vGnUK4c8TO3JcIBnQbbKX6X0nEdCk+d4EJX7FbgP07knMv1506ZfYAVdim1IvqrvYL8Kks3B09jIZ7Xt5SkmpIP9SdjdwKAl0KvkN5SMH55LmE0P6Hsq2b9cgqFpyrkvZf39QBFUYnzLiMA5ttUTea0M7TWNYdr3GyTfXTTE6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2+U6pQRdDwDSblsse9vm1PpVJeP1gaU29Ag0Kmjwoc0=;
 b=SeijrYexzzQxrdEBGHYlmobxS5GlwxYr8lmD1C2bpOLm/qJsdd67wGsoWi1bhUsAp9RwCPkXNMyqkRFTkvGeSXv9uvYVepP6BI9Bv0/O0vwh9MttKS326QKqI03MT2KsZON2t9EI58X+1IkDkMpyx0B+H3d6xzZVvFOUs4bM5GAbqov8L1BAgtj5MC7fquyoQF1bc8k1Yj7qMmJiDgLVEgM4uCeGkad61H8e3TIQ/+PK+k+3c/+PGkzj6bAYlC/8Rcj3i8tVQYCOPP/4CeQ4V7a80/VZXzaIA1tA8InQ+CxiUsniFuku20Zzm87F5KB2uIdrc+cfCkYuvXcV5u2NCw==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by DM5PR12MB1945.namprd12.prod.outlook.com (2603:10b6:3:10f::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Thu, 21 Apr
 2022 22:05:20 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::a90b:9df2:370c:e76b]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::a90b:9df2:370c:e76b%3]) with mapi id 15.20.5164.026; Thu, 21 Apr 2022
 22:05:20 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH] nvme: avoid NULL pointer dereference in admin queue
 initialization error path
Thread-Topic: [PATCH] nvme: avoid NULL pointer dereference in admin queue
 initialization error path
Thread-Index: AdhVqlZ3h7upkXT4TAG9KVUkeJ9NKgAB8dUAAAPEAGAAAnDpgAAAPICA
Date: Thu, 21 Apr 2022 22:05:20 +0000
Message-ID: <09df362d-057b-d725-3d30-8cd0cf4b8297@nvidia.com>
References: <DM4PR84MB1590F030A9AF89C6E0E62A38A0F49@DM4PR84MB1590.NAMPRD84.PROD.OUTLOOK.COM>
 <YmGp4g/V9zkyMWzz@kbusch-mbp.dhcp.thefacebook.com>
 <DM4PR84MB1590C311ABDB0895A1B4D16EA0F49@DM4PR84MB1590.NAMPRD84.PROD.OUTLOOK.COM>
 <8c0eeea7-1d9d-4464-53ef-143331e1faf7@nvidia.com>
In-Reply-To: <8c0eeea7-1d9d-4464-53ef-143331e1faf7@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8ee60d3c-9a2b-4dab-0e16-08da23e30691
x-ms-traffictypediagnostic: DM5PR12MB1945:EE_
x-microsoft-antispam-prvs: <DM5PR12MB19456D576D3AE204F200BCE9A3F49@DM5PR12MB1945.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: m2O9/h8WCiaBcHrt5w9fWx+bkgcoO5Qt1g/H/r/Ac3E6gUdAqsDyUzZX5GSwGiMCjerZKZeItpeKk3488e8kvVlQAdqOAJGUe/4hAj+U9I4Zj5c5uifL3NjfbRljdwDouW30o/x10zez8aYoD3XL2zENSBAB7ExCqXypy8SWTrs9sgDFYRVNiPnuEZK9SQPnquRRJKxiVjNDMar1q8Mp3liYYG44zhfvyYFquJDeHOwZWRIDRf5e/hzVxEGaea1VDzMsuVHLmk3QrrPg/hprCUe6lFJUtPJFXmaje8klq9Z/xhrVMxhcp0GArSGcPy21ZzVMcgQth2HAhd11uVWK9DXruDN6EFn+v8e4R+Z6VwDmhVWlflTFfLh2PuN9OZkCVSmvjOLZ3lAHJ+LjDonJXz4C3NTosXsdBF8i4X3e3hmgyrVpWF3bSmmjXUddrMaYdBDL6nI1t9E4v6VRHH01eCa5+wHvgOaWJVfle7LyH7BmHx3Rz0yG1w3vPFR+8TjtNSXxxiAQZ7axR68kvXzFgKFMa4F6Y6dYk82XUsoATCvmdX3x2LUvJQNFa+CC63EWDr2x9k27N3y7DX75mcZgsX2yY5xsEpeMAs0eAAg9KxcAdMHSXTfxnOsWOac34LharoF9FUoIFAlIKGPpjUHuJQuyO85DyOSrayjGZf6y9jT7RNCUZ2M+1vRG/Zc0v5DlFXMT1q5nb+5LQ01wPrrzW3QSyqKFbVjo/R41+j/JgiJiDjRG+KjFMZ3XEpV4WzGfjjM8AL2kLfibzq+G6Q0iQQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW2PR12MB4667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(53546011)(508600001)(186003)(66556008)(31686004)(76116006)(31696002)(66946007)(26005)(8676002)(83380400001)(316002)(5660300002)(36756003)(86362001)(6512007)(91956017)(122000001)(64756008)(2616005)(2906002)(66476007)(6506007)(38070700005)(71200400001)(8936002)(6486002)(38100700002)(66446008)(6916009)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZllZRE5WYUhhOUZpcm1OMmd1TmRNNVlTS3Y2OStvNm1xcWVZa1cwREdvMzFJ?=
 =?utf-8?B?am5xQnBqOUJaRFM5SFlYQlRHcmNKWnAzYnJUYU1YdHJtbUdNbHdIdEdMMWVD?=
 =?utf-8?B?MGlZODdQUW9PdzhjQkVzbTcyNVJMNjdjNEhWR0Y4R1g0YklEQTBBMWlsMHlU?=
 =?utf-8?B?OGZwN1pUNU1NeW1pUjBsM2NtbmxTQTFrbGRiZWVaN1J1Q24rV29lcEIvMEZD?=
 =?utf-8?B?Njk4M0RrMTMwWkZzb2ZRZnJiNXBWYlNySlplR2NXdFVVNHRtdlg4Zi9sZ3dX?=
 =?utf-8?B?VVdkY1kxQW4vTm05cElWaDlCSmdYSVFNK08rS2JGRHNoTlRjL0w2QzhqTjBK?=
 =?utf-8?B?aCtkL2U1NThVdTU2YXcvVlJTTFpyOEU3MVhTck40VWhnUmxoNVgyNnRZRzBi?=
 =?utf-8?B?RXMwOEs2NXJTN1IwYlVydlExa2NaNm9vWmdodkNybnFlNGRNWFlWNUZhcnNI?=
 =?utf-8?B?Ynl0LzVVNUNhS0FmU3dodE96b3dQRUk5VHFRenlPZEQvdlZ5NWpLVExuTkdT?=
 =?utf-8?B?ek9HMGpFU1p5VDhiZ2w2Q2hscWNtSFBITFQycnFkSStraVNjS2lJSW4vejlR?=
 =?utf-8?B?bWNLc1Q4Q0I5Nm9zVW9tUElOMzg4ZHIrcE9HanV2ZTYxTGttT2lUS1BzdHNN?=
 =?utf-8?B?N3h3L1A0Y3MyRHA0U3FIWndlNFdsdC9NYTNmTWZNMVFaVlRqZG13c240Sk5I?=
 =?utf-8?B?dENPSmIrWHBzdFphekZSZExUbTV5SDRQOThaeG5nWXI0RFY5SGQ1bnFQbzNm?=
 =?utf-8?B?QTVNV3dLZmFDK1RvbjEva3Irem9Tb1BOVS9DTWFkdEtyNkswU1piUWIwWGlZ?=
 =?utf-8?B?OW1uQzMyR3ozaEFMNDVEVkFRZ0tER1VrYnFNWjFkOHBVOHAvQTVyVi9iZy9O?=
 =?utf-8?B?OW5RdHZkNFQ4QUFGK0FGSTFCOXZvVDMvMDA3d2tXR2VyVFZwQ3k4bUlLSURn?=
 =?utf-8?B?Y1l3VHkxWXRjRm85R2FBSk1aTjVCUTBJeEJNdXZwVXBpb0ozZzh3QThZN1ZI?=
 =?utf-8?B?WjBmaEE1TVJOM0xLT3JrbXlKeEZYSjd2ZFZrTGh5Y2Y2TnVFa3Y4bjdYcDBh?=
 =?utf-8?B?dzFIdi9wcFUxRHF5YXJtREJ6aFo1VzRpZ1pnNXovNTVodXNRaHMzZGZqbVY4?=
 =?utf-8?B?dEF0T3ZFR094MkpmSDFNOUhmemZjWlhEZk1aOHpkZjA0RHFPc05GZXB5QzVI?=
 =?utf-8?B?elYvWm0xeWJ6cFcxbmVCTWlLakdXYkF0TFJZMng3NmlmNnpDMGQzOTZGRHhV?=
 =?utf-8?B?c1M3M0hTNTJiNzlydkJzSzdLdXA1Q090aXJIT0ZXTHpTRUhDamVtWFFUQU9n?=
 =?utf-8?B?bFFUNklDTk52UE9UbUErR3lXSFdpMWFDOUJZMTdqM1hubXdETEk0TFZYSGZE?=
 =?utf-8?B?TjZhS1Fxa3BSSFV3ZnJxR1E2RHZsT2htT2lZTXBxNnR6QUMybEVwcHVKWUFq?=
 =?utf-8?B?cFN4ak4vYi9jcFk1aU96elJOazArVlg1dVlEOVhIKzlacUFYSC9BSnBjNEN4?=
 =?utf-8?B?TlFZNnBMeWFDQThrbUxDMUZEblpHcWVKd3BKZld3WS91VnBtc2p2MkJ0aVBP?=
 =?utf-8?B?bHJ3ZFNsSm9GeUd6YzM0U1BIc082ZFAwbkYvVzJ2STRscHB2eFVBYmZyR2JM?=
 =?utf-8?B?bU44ZDB4SXVJRXF5SWVNYW5sWFZqZ2JjVHZWa2FQemhLYnphN2M4ZHUyMEFC?=
 =?utf-8?B?cU52UTM5RGFjalNtTldQbFRZNlFaOE50R0NKMEZUakk2REwwWUdOV0pxaEUx?=
 =?utf-8?B?VEtHOWxUdGRDR2JSelVNNG5mMUZySUVNZUtZYVozeE8wKzNDa3F0V3k1eW14?=
 =?utf-8?B?dVh4YS8vSElxdjE2aGY3M2ZHdmpoRWNhQWVMdHBCTUZYRkNBN25xZkxQQUNq?=
 =?utf-8?B?cnVVZVJHU293SjN3eGJhTTNrOHdFWi9sbVJDNTdHSTArdHZHNnZNWXhURTFm?=
 =?utf-8?B?K0FVcURhQ0g2eTlDSFRxdWV4cEswcStQMmU4c21IN0ZzTVdDN3FxWnVYcng4?=
 =?utf-8?B?dEd3QUorR2lWRGh1M1VuYXpCNzc1SzlDUXUvSWZ5cjU5ZExBcEpEK01paUNF?=
 =?utf-8?B?U3cyZXVxRVplY3FFYXNvWVpLNmFUZkJPQWFjRnRmTFFZTE96QStjbkx4d20z?=
 =?utf-8?B?UFFBVUN2ZDRkbFlhbkF4TzdDMnRtMzVadkF1L1UrUGc3YlBQcWY4NDBDRzdl?=
 =?utf-8?B?aUFPTS9WN2szOUxhSUxaY2Rnb1JYcnh4ODNNakpseXA0Q2c0dXlKSEg5a3pE?=
 =?utf-8?B?L0RldWw3WHNOS1pNdllRQTFNMm1GcTV2bFN0bHREL2RjbktuMXNIUStiQkVt?=
 =?utf-8?B?aVd0VE5UVEVMZU9JQjZWQmd6UlRPaE1lUGtndVlnTVAvcXFFM1VOZz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7D98E309A6CFBD4F9E55E3B639559962@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ee60d3c-9a2b-4dab-0e16-08da23e30691
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Apr 2022 22:05:20.0439 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CcNGhnnmVcqpUa0Po9ig8wyBuhifof2KVGsxAhSg1vHABGJyJ2dvA2XMfZtEeGN3wiv1L0AfYMga0wqiDGWzCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1945
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220421_150524_912475_9CEE3194 
X-CRM114-Status: GOOD (  11.74  )
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

T24gNC8yMS8yMiAxNDo1OCwgQ2hhaXRhbnlhIEt1bGthcm5pIHdyb3RlOg0KPiBPbiA0LzIxLzIy
IDEzOjU1LCBTbWl0aCwgS3lsZSBNaWxsZXIgKE5pbWJsZSBLZXJuZWwpIHdyb3RlOg0KPj4gSW4g
bnZtZV9hbGxvY19hZG1pbl90YWdzLCB0aGUgYWRtaW5fcSBjYW4gYmUgc2V0IHRvIGFuIGVycm9y
ICh0eXBpY2FsbHkNCj4+IC1FTk9NRU0pIGlmIHRoZSBibGtfbXFfaW5pdF9xdWV1ZSBjYWxsIGZh
aWxzIHRvIHNldCB1cCB0aGUgcXVldWUsIHdoaWNoIGlzDQo+PiBjaGVja2VkIGZvciBpbW1lZGlh
dGVseSBhZnRlciB0aGUgY2FsbC4gSG93ZXZlciwgd2hlbiB3ZSByZXR1cm4gdGhlIGVycm9yDQo+
PiB1cCB0aGUgc3RhY2sgdG8gbnZtZV9yZXNldF93b3JrIHRoZSBlcnJvciB0YWtlcyB1cyB0bw0K
Pj4gbnZtZV9yZW1vdmVfZGVhZF9jdHJsIC0+IG52bWVfZGV2X2Rpc2FibGUgLT4NCj4+IG52bWVf
c3VzcGVuZF9xdWV1ZSgmZGV2LT5xdWV1ZXNbMF0pLiBIZXJlLCB3ZSBvbmx5IGNoZWNrIHRoYXQg
dGhlIGFkbWluX3ENCj4+IGlzIG5vbi1OVUxMLCByYXRoZXIgdGhhbiBub3QgYW4gZXJyb3Igb3Ig
TlVMTCwgYW5kIGJlZ2luIHF1aWVzY2luZyBhIHF1ZXVlDQo+PiB0aGF0IG5ldmVyIGV4aXN0ZWQs
IGxlYWRpbmcgdG8gYmFkIC8gTlVMTCBwb2ludGVyIGRlcmVmZXJlbmNlLg0KPj4NCg0KYWxzbyBj
b25zaWRlciBmb2xsb3dpbmcgY29tbWl0IGxvZyA6LQ0KDQpJbiBudm1lX2FsbG9jX2FkbWluX3Rh
Z3MsIHRoZSBhZG1pbl9xIGNhbiBiZSBzZXQgdG8gYW4gZXJyb3IgKHR5cGljYWxseQ0KLUVOT01F
TSkgaWYgdGhlIGJsa19tcV9pbml0X3F1ZXVlIGNhbGwgZmFpbHMgdG8gc2V0IHVwIHRoZSBxdWV1
ZSwgd2hpY2gNCmlzIGNoZWNrZWQgaW1tZWRpYXRlbHkgYWZ0ZXIgdGhlIGNhbGwuIEhvd2V2ZXIs
IHdoZW4gd2UgcmV0dXJuIHRoZSBlcnJvcg0KbWVzc2FnZSB1cCB0aGUgc3RhY2ssIHRvIG52bWVf
cmVzZXRfd29yayB0aGUgZXJyb3IgdGFrZXMgdXMgdG8NCm52bWVfcmVtb3ZlX2RlYWRfY3RybCgp
DQogIG52bWVfZGV2X2Rpc2FibGUoKQ0KIMKgIG52bWVfc3VzcGVuZF9xdWV1ZSgmZGV2LT5xdWV1
ZXNbMF0pLg0KDQpIZXJlLCB3ZSBvbmx5IGNoZWNrIHRoYXQgdGhlIGFkbWluX3EgaXMgbm9uLU5V
TEwsIHJhdGhlciB0aGFuIG5vdA0KYW4gZXJyb3Igb3IgTlVMTCwgYW5kIGJlZ2luIHF1aWVzY2lu
ZyBhIHF1ZXVldGhhdCBuZXZlciBleGlzdGVkLCBsZWFkaW5nDQp0byBiYWQgLyBOVUxMIHBvaW50
ZXIgZGVyZWZlcmVuY2UuDQoNCg0KLWNrDQoNCg0K

