Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4FA6C61DA4
	for <linux-nvme@archiver.kernel.org>; Wed, 15 Mar 2023 22:49:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Wg3Wqzx5BhusRNwDH0777mC9h3hPuWLW7sAJRMXhrXM=; b=bfVobNI6IN7NhQOU7xIUDBL+93
	LdRiFxxF4vGRWF5etPst98h6CJh1gExS5WiRnhh9D6bPqLAGnI821f/cYiXjyZCaKcUhEMfE8Sedo
	MZIYnAQdpp9cSmf6AglpXZkuid/cvYG0IjwNyHvkc0gOki7/YLER+5Vd7dfX8ZbQd12QmPYzbEKfI
	n1nhLJE16O2nWmPlRrdxnVNGY9+ExbDARQpVCMvkRIFc3DrfdN3RpuRmdc0nq/iVhdnETdC/Ka0FY
	SHswtMgkcekWAlt5uHjd/nNzj0VtSurqzaPPHv8eD3GU8PSxafatZlYJnNlsUJEevYUTIMyXbT/zc
	eCyqRXBQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pcZvn-00Edsg-32;
	Wed, 15 Mar 2023 22:49:15 +0000
Received: from mail-dm6nam10on20603.outbound.protection.outlook.com ([2a01:111:f400:7e88::603] helo=NAM10-DM6-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pcZvl-00EdrZ-1K
	for linux-nvme@lists.infradead.org;
	Wed, 15 Mar 2023 22:49:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qb60qg9U0sUwJBBGOTtQhf9yptcIP23ZuOQfUpVzN1pRrz/DlL41cYNJGKkpdhvZP0oBkQCHqq5xEp6T1dGFrDUfGE0FAPpvUXSq+4DTJ3tmli4XzpGTBsIPo1ZftY/Mc1hZScVDggcICQlS2whDdwz49+aQWTjitSUCa0cICNILuzBjabMf8VnEsw5v8adRIcBeuOSSo2YEFLHKdakf6STOFh3KTaAovuAzZzGhayDkXRwJa/MJpmfqPLPbvO5ah2f0OlWcv1NC4kicURD0tlqWkWZ3fCdi3HwA2vrS17850Rms0mZUBiRBYbW8gK1wE2f1W+Fg+j7f0L5Oy2xqrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wg3Wqzx5BhusRNwDH0777mC9h3hPuWLW7sAJRMXhrXM=;
 b=gLTHTfw+ORDQUmX4/gGVECHx3jgHjQ+F9+Xbc5k3WYwI9TyFPryxFVHS4fsnNK6jLX5XfxgxQNJo8lIa/l24Yqw5k//Jpd5A/Capwgs5JqIKsUU0n0TkyXhK9jpR7aCNJ+n2mKU1T/+qs3bPS974YLz3HzpFaw5Zm9y8dqYLl7/GkoNhcJe2fmy0P5baYgCY4UlmyeEeAI36TyhSClJM86cnpHy2f5BD+9dV9r8X5x5LJoTrKW+Qmafh+RV+qw8U5tDbvRGZiqbB81c+pfT2pu5emzn2yITd8K6IWy/P6cxJax7nz5ECK2h/GZp9Zjx0EYY+2xGY0OIZhhOjwqPzSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wg3Wqzx5BhusRNwDH0777mC9h3hPuWLW7sAJRMXhrXM=;
 b=Ez54sv4joMfS2pTK6BIzMT6XYAup48YJCDdFbTyyO9UTSB/3F8xGlCQNwJRXVOEgJ/s8H1ezTqOywfsqcFtkG/H3c4gELdfga6D3x7qaMDeShFtyHd4mp3VoxdrUge0e3SWaiNxSDLhF/SU98U/8rzvJjFW6MdxilNmGnhneJMZ5hodtEUu6SdgBpN9V5jviDvlxza6Jr6Nc2AZ3PzzaC3cfvDafmwIlKrFKwJTf9TZXbU87kPfozKXt1YrrfcGgz7CvF/XRNxgs2H+Z4Ml36B6a/BYB2o7CFJvNEH557Y16QYgryu9ArlE4e4gOYUJzrfBbfmP8/hTgopwNy3WdFg==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by DS7PR12MB5861.namprd12.prod.outlook.com (2603:10b6:8:78::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.24; Wed, 15 Mar
 2023 22:49:10 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::4aaa:495:78b4:1d7c]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::4aaa:495:78b4:1d7c%3]) with mapi id 15.20.6178.029; Wed, 15 Mar 2023
 22:49:10 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: "Belanger, Martin" <Martin.Belanger@dell.com>, Keith Busch
	<kbusch@kernel.org>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: nvme-tcp: kernel NULL pointer dereference, address:
 0000000000000034
Thread-Topic: nvme-tcp: kernel NULL pointer dereference, address:
 0000000000000034
Thread-Index: AdlXZV3LgjsZJGHIQ4uZAsfmw1ybfwABGvWAAAA+U6AACWYNAA==
Date: Wed, 15 Mar 2023 22:49:10 +0000
Message-ID: <3a478a20-8cca-0397-2cf8-8d6e9841e5d8@nvidia.com>
References:  <SJ0PR19MB4544EF06560DC1D2B9D1BD09F2BF9@SJ0PR19MB4544.namprd19.prod.outlook.com>
 <ZBIKscSKCBQmfW1l@kbusch-mbp.dhcp.thefacebook.com>
 <SJ0PR19MB45449E47262DA497633941F9F2BF9@SJ0PR19MB4544.namprd19.prod.outlook.com>
In-Reply-To:  <SJ0PR19MB45449E47262DA497633941F9F2BF9@SJ0PR19MB4544.namprd19.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|DS7PR12MB5861:EE_
x-ms-office365-filtering-correlation-id: d2aa89ab-e4ac-4d2c-630c-08db25a77df1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  XelXXb7OJs3gZwMARS0lV0tC0YBJAyViQWFSKBegId0/iIBqT2u/91ewO/DKxuQVoiBCTw+c8WRf92IQ+utPrqwICBthQSgr3TFHXf77s7GFCi3gqZZ7W0qhvnMhqXOVyuzSsJQqy+sHkAFM83aLi8q9YtuCvnkeghOFm57MY2lUiqMWGmGcbaG7vGusjLps5jdR6XlZJ/8BhJVugniFnHtr6dcHA+KKf8/9WpJfctaETSkxPdnCTnyzubo/JyqSQh44fNdUpkft3NfpqNERcGLxaFl4xjy/XWWRKm0b1mBCiOIQZy2BaJ4B7rR/VczwiU2JqDhpNFHfNe3R9SDSmtuoSFNDFQHSLLTIkx37QVE2YtyQrybfNclQkI4X3Cx6++88ea+rP0LINIaKT8Fz6nIHVsyxbGs5VnaqzI5Osh3InNmy5B5xHiiPtJnkCoxlR1HFCstNOM1YatqNos/AQ9O7eF/MSIvy4ds+keIrGj4qM5cvT3nFRW9FtmSFhk+ipsbDaNTKx0WHo/OwK6Lkq1rJcvlYnjgMT6xuAAQFmjOImFg3Js/KiSQtapqIDJRugzWRT7+eQj0KUSSj+fnpC1+cqeo/joY+3aHw9U6odS3z3XMJ4LCj1sgUzGQwLFnCoFNR+UBhMaqBAxKbQox/9IUUrUQMCx+Y4TZGwSuzIAJ1Gt+jBMTP2A6edV+0oI1LBa1N7b8Uyw/nofgX1TmPzFaAQ0aerd9pFbzymhG/5n5d/Kes/ACYY+RjpiD+5uQHpxSsdsyRqPVRMwl8oHuIJw==
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(376002)(396003)(366004)(346002)(39860400002)(451199018)(2906002)(31686004)(122000001)(41300700001)(36756003)(5660300002)(4744005)(66946007)(64756008)(38070700005)(66556008)(86362001)(8676002)(38100700002)(31696002)(4326008)(91956017)(66446008)(71200400001)(8936002)(316002)(110136005)(76116006)(186003)(478600001)(6506007)(2616005)(66476007)(6486002)(6512007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?utf-8?B?bFNVSy8vdWk5VUZrNEtBMGtzTW5Denh6SUpyczI0dWhSMUR0NzFhQ0ozTE5J?=
 =?utf-8?B?UjR0QW1WYXByMWdXWVZPczJSLzBjcWt0UXVCd2tnbUFHZ0Q3c3lMTFpyME5S?=
 =?utf-8?B?SWJFRElyTjRNZTZhVzNLOHVHMnJQQUZjOTA2UjdpWEw4L3FYVXR6MXdzZ01I?=
 =?utf-8?B?aW9jTG9TMDRHcDg1WmNKMXZpVmVFc0NYRHdJMDlyUWM3bDV5VmE2WmtPZFJN?=
 =?utf-8?B?VDdod3NCMnhoeE9GT2cyNHdPUHNzVnNnOHRKaHdqemNLNDVDbUR2dG9XMm42?=
 =?utf-8?B?YWRXN1drQmJESU5mNVRGZmdQdzJIY3c0d0Z4Ry9jeFdjbzZXS1AxMWtMZUZQ?=
 =?utf-8?B?N2dOZ2JsUXJzTENHNFh3bWFTdVRaeVZ5RDZlZngzaFNMaW9GYXFPWkRwSGVm?=
 =?utf-8?B?Sjh6cy82d1JmWkhTamdCV2ZMZVg2Y0FlNHAwZHBFb3hGY24rbkVRVUtZQm9L?=
 =?utf-8?B?Q01NOXBjdGtRMi9pQ0NrMTlFWGorV0tJL0tJbmg3VkduUnBnQmxaZlUzL0Ju?=
 =?utf-8?B?TDBhdWV1bWs5Um92MlJGc0hPOFd2YitTVmVNWVJreVNOTnlYN200Vk9NSGJF?=
 =?utf-8?B?REpCSFA0M2NBT1BKd2RmMHJZN3p4SG9OdlJjdSs4VXF6SDRYa3BhUW56VXBk?=
 =?utf-8?B?bm5XeTV0UXVQRjV0bnZYNzdNUmtheS9LN3c2Vnc3UTNNWVIwWHR4ekMwdVMz?=
 =?utf-8?B?a3hvTFdOZVVXQSszNUYramx0d1hpRk9aMEc0QTN1OGlrKzFaMUkvcGhNTkFq?=
 =?utf-8?B?MHRJR3VpR2VSVzNzbHVMS1M1ZVBYNUt6RDdMSENIQjJDemFvSnFyRVZnUWFL?=
 =?utf-8?B?ZkVJZUMwZXBoZHVlZ01jUHpvcVNYVXd2cHFuMUNzTVJiNWRFSGl0Qk9PQnN1?=
 =?utf-8?B?aGZBRE5MQkNUZG5IcGpJdzIxT0dyS2JwN21vSkgwa1Zna1F2UDdqeHRZbllu?=
 =?utf-8?B?RjhTN0tHdURCNkxFTTFuNWFRQUFoY1NQaFVOV0M1R1l3alVjcGZyV2lKQkNw?=
 =?utf-8?B?VkpJMGpIYjR4QzFvZUJrWW5RQm1tb3VjWlp2OUpJRlFiajlyc3IrS0RoaTZB?=
 =?utf-8?B?VUtWZWgwek1FZ1dWOGV1V01LWTMrdXBERmRkTjBGckFBQWc0V3JOMVZOdnFX?=
 =?utf-8?B?QkIvdDNiblkwOGhZZ0cwK2NjZ21NNFYvSEQrbmtxa3owMVFpZ3c3K1c1Rk44?=
 =?utf-8?B?cks0SUJEUzcxNkgvMUxZZTRFSHNLTTJHME9PWGZQSVFLdzVTd2VSTXhlWGkr?=
 =?utf-8?B?aXF1c3pOZXV2czZ3N0wrNi9hQi9XcXExTFJuaXdZU05FOFVVSjlucUJaZzBS?=
 =?utf-8?B?L3NyT3RNdWF6S2pxZWFXNTNwbzArREVYSUdnU1dxMmV5Uk1yUTJpUXdjRmpT?=
 =?utf-8?B?L0tlTDJXb2dpTVJlU0FjR1dUV3c3TXRmM0cva0N4emladkp0TGI3Sm9PRVo5?=
 =?utf-8?B?TUxmQzVTTlZKdExVQzdua3JFcU1ORGxOMzM1WWpGQzRXWUpOU2llYUpmNzBs?=
 =?utf-8?B?UFRvM2M0V2FESXBCcU14cS9tZmxjcCszZGowSThsc25keS85ZmNXKy9PR0FZ?=
 =?utf-8?B?UkUvTVdOYXRtRWI0V2FibnVVN2R1VmFNaUVIY2hSaERjMGg1RHBQVE1MSmNK?=
 =?utf-8?B?c3hqWExxOTg3L0xHMDZ6ZEpjU0FxcWllOGx4a2I0L2V0RUM3RTdCOGZzSUpW?=
 =?utf-8?B?clRUWlB2UjM3Z1p0aWJUQXA5WFFuRVpoRDZ2SkZ4YVZmNkY0YWJQb1cvcExq?=
 =?utf-8?B?allvT1U3Z0tWd2ZBSE1WSEFwQk04KzlpcTJLSWhSWjZTTEZRQk9HeitWOVdY?=
 =?utf-8?B?dWZjblI1WjRleURrcG80U3B5eWptYXJjdjlPL1ZqMVU0LzR2S0RMWWlWbWZV?=
 =?utf-8?B?VmNtZG1hOUhkc3JMbVFSTFh5THY2MVRsc1JuKzhSZStrMkw3bnRTOGdjb0Mx?=
 =?utf-8?B?UlU5eHJtZDBleisyK3V2c2MyM3NqZGQrZ0lkTVlPVTNvNUMxYzNsWEhWUkE4?=
 =?utf-8?B?SVVRcUl6aFA1NUM4TDJDcDNrQy93ajhtTzZJdmdDeXhpMHBSK2VDUitldk9K?=
 =?utf-8?B?VHFBY25UK1ZaZGVKalorTUgrZHJocmxyd1B1cVdsdWd5bXlHMG8vRXBJZHp3?=
 =?utf-8?B?UFBjZVFQMHc1bFk1Um9HbGFFVHdyMkI3enp5MWZJb2grMW1hM1llb3R3Qm5G?=
 =?utf-8?Q?KYzG8Iu5AStJmna4seKUgzBbdkqtQYVdsnCnZRYs8Naj?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B3B1B7B92F5DA042AB0B57FDDC584E03@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2aa89ab-e4ac-4d2c-630c-08db25a77df1
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2023 22:49:10.5638
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /NR39frUrYlrIgaqUwqdI+X4xsK6S26Jmdwz598Zg7yZo+CDFEKJRcmi28Am/w6mfco/DHjGjOLU/KtAE4No1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5861
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230315_154913_648747_71CBD6F0 
X-CRM114-Status: GOOD (  14.20  )
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

DQo+PiBOZXZlciBzZWVuIGFueW9uZSB0cnkgdG8gdXNlIHBvbGwgcXVldWVzIHdpdGggbnZtZSB0
Y3AgYmVmb3JlLiBJdCBkb2Vzbid0IGxvb2sNCj4+IGxpa2UgdGhhdCB3b3VsZCB3b3JrIGZvciBh
IGNvbm5lY3QgY29tbWFuZCBzaW5jZSB0aGVyZSdzIG5vIGJkZXYgYXQgdGhpcyBwb2ludCwNCj4+
IGFuZCBwb2xsaW5nIG5lZWRzIGEgYmRldi4NCj4gVGhhbmtzIGZvciBwb2ludGluZyBtZSBpbiB0
aGUgcmlnaHQgZGlyZWN0aW9uLg0KPiBJIHdyb3RlIGEgdGVzdCBwcm9ncmFtIHRoYXQgZXhlcmNp
c2VzIGFsbCB0aGUgZGlmZmVyZW50IG9wdGlvbnMgYXZhaWxhYmxlLg0KPiBUaGUgY3Jhc2ggd2Vu
dCBhd2F5IG9uY2UgSSByZW1vdmVkICJuci1wb2xsLXF1ZXVlcz00Ii4NCj4gQnV0IHRoaXMgYmVn
cyB0aGUgcXVlc3Rpb246IHNob3VsZCBhIHVzZXItc3BhY2UgcHJvZ3JhbSBiZSBnaXZlbiB0aGUg
YWJpbGl0eQ0KPiB0byBjcmFzaCB0aGUga2VybmVsIGJ5IHNpbXBseSBwcm92aWRpbmcgdGhlIHdy
b25nIChvciB3ZWlyZCkgYXJndW1lbnRzPw0KPg0KPg0KDQpDYW4geW91IHBsZWFzZSBzdWJtaXQg
YSBibGt0ZXN0cyBmb3IgdGhlIG52bWUgY2F0ZWdvcnkgPw0KdGhhdCB3YXkgaXQgd2lsbCBnZXQg
ZXhlcmNpc2VkIGJ5IGV2ZXJ5b25lIG9uIHRoZSBtYWlsaW5nIGxpc3QgPw0KDQotY2sNCg0KDQo=

