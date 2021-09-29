Return-Path: <SRS0=HFDN=OT=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0C4EC433EF
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Sep 2021 06:08:08 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 40C7F6124B
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Sep 2021 06:08:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 40C7F6124B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=LOLOCZeeHdNOj0OXRv6b6Q/+c5rvNRPqI7bDWQ5OLVM=; b=0GPU4jKutbvaeG
	n/DZ3g6uJ11ZeCXHYfyHQA4imX7JqWjFremDHMl8QSPB0HuzCbngf9wtCDrIVbMJJYp4BtiPoZoSB
	v3huHrBCEAJ+OnwzhY+N1jbswOQrQ2Bpp7XrrkOhe9M3zkn2E5Ibq7aKf1wiSgZng2s0XlzWmvJoJ
	7Cn1WVjz29V9zdvMDaoIA2j9FBo82vUtNWbWksZOH9V4LavqeeTniaeo2mdEyJqm1B4HL6/PtYfYz
	1BeGVwTGjvv3AEZgHeCWvrqkajqXpPTSlXFAPl7psTArhq+c3bbap27e4I6Dr7U7jOZyJtQWsQw3Y
	duzyIpXNgtVfLSGvSVdA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mVSkx-00A94i-47; Wed, 29 Sep 2021 06:07:51 +0000
Received: from mail-co1nam11on2060.outbound.protection.outlook.com
 ([40.107.220.60] helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mVSks-00A93P-6M
 for linux-nvme@lists.infradead.org; Wed, 29 Sep 2021 06:07:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rez+6WqF23KZ9l5lFOILaK7HYhw3oKdb3P1jEM/NkztIY94105pAuK8JRbAI+jRYe2Y0AjukUMm+hlhTSzqb22HlCultf3r+X1vQzobQGMPoe6u+oaRcQTQ2qSfPDuVBAvV6lgb3jriGIEQ4JQcg0RaXnivwY/f1/nWCnyYCmNRTq4SFsBWW9BpGxPjjZYgNMptgL0/cQcXtE++q4sOVsvEWCDcAXSvs9ONnSlyq6BV3nlbpkZ7xr4yaYGgKo98EwaAJHFIN99A7pI2O1Bxlc8/6RD2PubDz/WxRO/Wrhk5tJbovQT5f15mzJ7sH7PRQNYDdvM9FKKS01waoY6957Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=S2EiHwsf2kDGmIx8YLZj7GEVLRonHFmyQtUGpvHzs+g=;
 b=oIAQQVpLJMiVzg+kI/PN8LzVNku6FUIL82IHnTkyODu5kSfgvaCpqFFGbo5jXHsn8tp9a4cxyY+n49crhOJ04HB4qXrlSwoWp5gOaM+ZvuUdAwVVRpkT+wgYgtEtnAzdwFH2Lc78TwyqsO7YgVM0pTjHx9JJINCWF3fpN0r69wTsjcfXIaXXdc6ZiyEilZFa8dOqcOfAZ1MR6E80KV4fNGy26MaL9SbZvRAglIRBg32tTDTdJjcGJMsuX0KnLBY0MunbBRREvyLstBEHg+4zrHYlxawmz5IKZvevD9XpNcYcDFYifnRMEAWJta/vkGv3TFy9xN4sCTdUvXpOCK/NWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S2EiHwsf2kDGmIx8YLZj7GEVLRonHFmyQtUGpvHzs+g=;
 b=aGPJNKas+EXLs3Ul+v5T+vNxP1iO+RT6fDemc0/T/plu8zyeg8ou5NuXfNW9ApbSvZTBYqK4nihN63knWDvueIeeO0gqUAzneuzlE3e8zPzbw2A5N877jQjjLs2mTT1LhGYZecvApIY4vddoEEpLLAGUYopaFHC9zgOYKR8Rb3rCLH1uYuTYDLcl0d/UN+Xxo0gKuBGVsbCB/CLmrzMA8a+rzIeH+ukVqJsdw3YSD6cnFsjIBSF6J1tN9wkW3hsXydNQhQSCOr9YI/Ch8bcQemg7/gCiTPuJchhm9LoLNNh8qq1P9itQV+MqWqrd2yUIKNeOt8OIXR9dF99OlqoOjA==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by MWHPR12MB1822.namprd12.prod.outlook.com (2603:10b6:300:114::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.15; Wed, 29 Sep
 2021 06:07:38 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::3db1:105d:2524:524]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::3db1:105d:2524:524%7]) with mapi id 15.20.4566.014; Wed, 29 Sep 2021
 06:07:38 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Andrey Nikitin <nikitina@amazon.com>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>
CC: "benh@kernel.crashing.org" <benh@kernel.crashing.org>,
 "davebuch@amazon.com" <davebuch@amazon.com>
Subject: Re: [RFC PATCH 0/3] nvme sq associations
Thread-Topic: [RFC PATCH 0/3] nvme sq associations
Thread-Index: AQHXsYi3YssyOX/yjkO10Cjw+mUOdau6jYoA
Date: Wed, 29 Sep 2021 06:07:38 +0000
Message-ID: <5f65579c-0eb4-cf23-4237-e23f52ccd63f@nvidia.com>
References: <20210924210809.14536-1-nikitina@amazon.com>
In-Reply-To: <20210924210809.14536-1-nikitina@amazon.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
authentication-results: amazon.com; dkim=none (message not signed)
 header.d=none;amazon.com; dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a91146bc-aab3-499a-c85d-08d9830f7095
x-ms-traffictypediagnostic: MWHPR12MB1822:
x-microsoft-antispam-prvs: <MWHPR12MB1822712FDE4CFCF761BF0C92A3A99@MWHPR12MB1822.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5Q8cejwMOXClaMrj/Iqf9Zp7f5KpwIieQrxCDK1dvL+HjzzY8lf7pZBps1G/Ww1q4Y66B62eh4OwEOOMZ6cP4CzHbTM2ZgpQurrRIy7BOsxOQ8AWod8xZdGaZYiGGf+7gBKZh7VBbNuFkPMaG+VOi4tsoyMm0YjtS4TzhxgfoKPQzjC6pscYANk1gp9HsgBgT5K4PP3cKM/RjiUd2c9EFAaB9LSVE6dOJ30bmlOsX3VZlbkkWEgL/zEnqRXa3SN3z2ThONnVDFf7jj4s9/h9sa3SbYIpa3Sk/UU2dFPMiqrJBoyX5DwzvNuxVxGjA1nY/t12Ny2gGs3JqbZ2A7V5xUvxhzX/KO0ksfURYWq68zMDWChwpJiRb3u/hcE2S+OsEZjsOxFWDnTbp44iET1ZwAMSRJpxgXAgkEqXjflHNYIjJFnpUo8Bov8gQS5Psty2b73oWr/qsdnYGneuTuWOFAQXtB6tQX8ye0N1cmc+mmDHhpfcYzQGbT6ZsLm6T5fyEMKz17ZpOH3fZkVAJX+kzLVKhvjjJagEBjfd8YTPw4hS1/mkhxBOt4AHpIR+9jP3fuWgLrc9CSREYlP99dOHbtc3FkH1QBtfmvtgHU5HVTwv1rMCXfqcEMfa/+sAvQATw1ib4AgEF1pKpppuZMepUc5UGGKfgow542q5b10RNDhtyk0onKQ6pKa/n3O+e1FcSDXs2wxeHaATapp6Xrh2W0dOuUeJ30aHch6XhrvxAwiBRwI3Nd5kzk+3U/4NuJDV4kpc6lIpytzdUE79sGNQ8A==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW2PR12MB4667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(6506007)(71200400001)(2616005)(38070700005)(4326008)(2906002)(31696002)(316002)(5660300002)(38100700002)(31686004)(110136005)(54906003)(36756003)(83380400001)(122000001)(53546011)(186003)(64756008)(66476007)(76116006)(91956017)(66946007)(86362001)(6486002)(6512007)(66446008)(66556008)(8936002)(508600001)(8676002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WXFncTFmTWFlV0N6VEFReUhaZk4zVnFiZ3JuODdCQVU3eHc2KzJCTWNsZGdz?=
 =?utf-8?B?ajJ5YTdyaDA2VE9Wckl0b0xFTzZ3OGlydnYrRFpMYnR4Wkh6V0RnM1dVaHFI?=
 =?utf-8?B?cEM1cTBMbWhoMnhJN2ZuZFdHbUlaRjJjNU9GdUt2YktZQ0hpajFhb2o4b3gv?=
 =?utf-8?B?Vm5TUmtBTkwyUkdocWJOODhxeTVrdXMvKzlpSlJ0Rk0yOHFrTldWbjNlMnU0?=
 =?utf-8?B?NUh3WVlwMm1OUkRNa2ZMcXp5STFBeWw3RDNVRW04ekpwM2U5aDZrNnU1WnU3?=
 =?utf-8?B?ODFNYzgwUFBZeWdiVWFnUkZSejJzbmV1YzhEd2c0bjEyYmd5a3Y2RXUzUSti?=
 =?utf-8?B?UjZaaFo5MnhzRkhscW0vODFJazZqbXZ3ZWpUeTBBUnNMZVBZN0VqcldVTSsz?=
 =?utf-8?B?MVF3bDdlRDVhVU8wM2xtU2tHYVpuK3JuZTh0SUp4OHREQzU2bmtGMDJjQ09s?=
 =?utf-8?B?WVdBWjBGVkFlelFlMTVNS2JsWTBRUmVCTzhHSWEvZ3BraFp2L0xib1dFUXlJ?=
 =?utf-8?B?M1lUUm5zeHE5dURxT1puRW1DMUVRRkg4OW1SOFZmYUlNWm1hQ2UwRUZFeEFM?=
 =?utf-8?B?RjkwSkVKUUJaVlBTK01GRkZDeHNaWXpWeENmZVgyU3pTTHF0d3MzWXJqRDBt?=
 =?utf-8?B?ZDUxR3UrdzVSckNJZ1lic1VmT280YzNKOUJXVW1neVdLeEdwc1JMbkJ6MU5h?=
 =?utf-8?B?Q1NCK3RySlhoa1NZUlBXcDVKRE9XekNVVFpvU093UW9lZVNXenlpQVJwcUJK?=
 =?utf-8?B?YU5STVc3L29CVzVYTlpPVHEzVmhZK1EybFpiL2hqczdYd3l4emdaelpLdER0?=
 =?utf-8?B?bjd3MHM3TGZUYWx6Q252aFV6Q1dMdEtBbmNZWjRaOHlIazdYR2NKUmNTZEd0?=
 =?utf-8?B?VzdIcVJwSWQ0R3lDaWRUSWs0QTQ4M0VFMnArN3BzZTNqeUp1NndWOWJsNGNL?=
 =?utf-8?B?UmF2bnVtaWdVMm82TWFXRkRUS2dnVHZhRXRLSGdjYXp5SzAveXMrNGFHRGtK?=
 =?utf-8?B?VU1ZUXRZNE5BTzgyQ2JoSFJMeXBPMGNkNCs1a2cvYU02SDNEQnQ0dUdqTVdw?=
 =?utf-8?B?KzA4YlZpNFFNNkZrWEIxSVVHcHJVVmVickZ1ZnQ3Z1hGazFFUTlLRUVrek0x?=
 =?utf-8?B?bzNJd3RvWnFSeCtDdWpLc0QvdUozSnh5bi9YWldFcHJ0M290RmROVDBZZk9Y?=
 =?utf-8?B?S3BWYi9KZkRXbmZDYWFHY3IvK1B6U2xObzcvbVVyQlBibVlNVHJxNVRvSlZi?=
 =?utf-8?B?R1g4dEZCRURhYzROeS9IMWd4d2pNU3lXYjAyek1WN1ZzTTBsaGtveSt0K29J?=
 =?utf-8?B?VHoxRFRUYiszMkl2WHJETnZVOTQvMVJUWG1qUHBQMXdJZGJmQk8vS2luRkJ1?=
 =?utf-8?B?MkhaRWhDLzNwbUlmTUtxdTR4bFJBc3dCNUdmVXRHK3ZndVp1NjZyVWdPWkFG?=
 =?utf-8?B?bjJQQVdYYmR4T0V4WThMTDVPTGdVUUQ5VFBJYXgxTU9JTWJyekdKTldZV1J2?=
 =?utf-8?B?Vmkxd2RwY0ZOK1V1SjFJS1RkN0h0MkZ6M0ZZKytIL3ZuSlA0R2R3V2hSVHov?=
 =?utf-8?B?QmxoYTNoWXU3c1NvdlkzZ2JCUWh2ZW9IWVRhS1BzNzVDQ0QxSjFvdFpWOW1n?=
 =?utf-8?B?SmlpSkRKeGh3N053WE1rTkF4UTNIVGNSRWJXSmN5SSs2a21UZUxmYk5DR0Fz?=
 =?utf-8?B?cUpTdjdtWUl2T2hzUlBiL3U2YjNTTlh3UW83Q21aRSt2bXorY1VtbkthRDRP?=
 =?utf-8?B?VWxTTXRJM0pGZGNhUkE1eEVDcDFUZ1dZclRtdHRwb0FuU3luTlRxNzFBRFow?=
 =?utf-8?B?SHZXQndPRDdQckF5MG1lQT09?=
x-ms-exchange-transport-forked: True
Content-ID: <684F36CCA8BFC940AD6AE2D9B0C9AD76@namprd12.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a91146bc-aab3-499a-c85d-08d9830f7095
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Sep 2021 06:07:38.5088 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wZ4vwSZUNAq/EujV7l5HPqJhyVSF962frZoDS8b1Ni2PHSYD7U/24l089RQjFevMgu245B5XdafIBN5GzM75nw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1822
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210928_230746_317753_8CAA0B14 
X-CRM114-Status: GOOD (  10.60  )
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gOS8yNC8yMSAyOjA4IFBNLCBBbmRyZXkgTmlraXRpbiB3cm90ZToNCj4gVGhlIE5WTWUgc3Bl
Y2lmaWNhdGlvbiBhbGxvd3MgZm9yIG5hbWVzcGFjZXMgd2l0aCBkaWZmZXJlbnQgcGVyZm9ybWFu
Y2UNCj4gY2hhcmFjdGVyaXN0aWNzLCBhcyB3ZWxsIGFzIGFsbG93aW5nIElPcyBzdWJtaXNzaW9u
cyB0byBhbnkgbmFtZXNwYWNlIHZpYQ0KPiBhbnkgbm9uLWVtcHR5IHN1Ym1pc3Npb24gcXVldWUu
IEhvd2V2ZXIsIHNoYXJpbmcgcXVldWUgcmVzb3VyY2VzIGJldHdlZW4NCj4gbmFtZXNwYWNlcyB3
aXRoIGRpZmZlcmVudCBwZXJmb3JtYW5jZSBjaGFyYWN0ZXJpc3RpY3MgY2FuIGNhdXNlIHVuZGVz
aXJlZA0KPiBiZWhhdmlvciAoZS5nLiBoZWFkLW9mLWxpbmUtYmxvY2tpbmcgZm9yIElPcyB0aGF0
IHRhcmdldCBhIGhpZ2gtcGVyZm9ybWFuY2UNCj4gbmFtZXNwYWNlIGJlaGluZCBJT3MgdGhhdCB0
YXJnZXQgYSBsb3cgcGVyZm9ybWFuY2UgbmFtZXNwYWNlIHZpYSB0aGUgc2FtZQ0KPiBxdWV1ZSku
IEluIGFkZGl0aW9uLCB0aGUgbGFjayBvZiBoYXJkd2FyZSBxdWV1ZSBpc29sYXRpb24gc3VwcG9y
dCBjYW4gY2F1c2UNCj4g4oCcbm9pc3kgbmVpZ2hib3LigJ0gdHlwZSBwcm9ibGVtcyBmb3IgYXBw
bGljYXRpb25zIGlzc3VpbmcgSU9zIHRvIGRpZmZlcmVudA0KPiBuYW1lc3BhY2VzIG9mIHRoZSBz
YW1lIGNvbnRyb2xsZXIuIFRoaXMgcHJvYmxlbSBtYXkgYmUgZXNwZWNpYWxseSBwcm9ub3VuY2Vk
DQo+IGluIG11bHRpLXRlbmFudCBlbnZpcm9ubWVudHMgc3VjaCBhcyB0aGUgb25lcyBwcm92aWRl
ZCBieSBjbG91ZCBzZXJ2aWNlcy4NCj4gDQoNCkZvciBSRkMgc3VjaCBhcyB0aGlzIHlvdSBuZWVk
IHRvIHByb3ZpZGUgYSBxdWFudGl0YXRpdmUgZGF0YSBmb3IgDQpkaWZmZXJlbnQgdXNlY2FzZXMg
Zm9yIHRhcmdldGVkIChlLmcuIG5vaXN5IG5laWdoYm9yIHByb2JsZW0pIGFuZCBub24NCnRhcmdl
dGVkIHdvcmtsb2FkcyAoZS5nLiBzdGFuZGFyZCBmaW8gcGVyZikgYW5kIGFsc28gdGhlIHBlcmZv
cm1hbmNlIA0KaW1wYWN0IG9mIHRoaXMgY2hhbmdlIG9uIHRoZSB0aGUgaG90IHBhdGguDQoNCg0K
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXgtbnZt
ZSBtYWlsaW5nIGxpc3QKTGludXgtbnZtZUBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0
cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtbnZtZQo=
