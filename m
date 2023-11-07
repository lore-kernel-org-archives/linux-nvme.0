Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17E93C4167D
	for <linux-nvme@archiver.kernel.org>; Tue,  7 Nov 2023 10:25:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=A0EB8oUaIR4twEPyWFrm2gftg+BbVbAgg9EJRU2GRfk=; b=om+CdYtjDEjGj3+/Wpy1Gu5BR7
	CIDlGc6NTd/tpBpMA2htzWMIlxpRU4Bta/R2YRHqqffYT6HAq/fj8n6gNSkh9d2XOX9G6ruuvM6iT
	EvqKFjKEQOcHPiy+pnBXqLDHltecUeClcQj+aH17+r1j7EOK4edlj8XFAoGhFtXkq8aO8mjhRbz61
	esU6OlkdggURF1Gdwnkfibz/yJ+Cr3+jIuNKtWuk4WYWpWb6Mr4gaJ4naOlQzFcVmvYObxSyPezhA
	d5BXefLIlBi/QuKlRQB5tiYHIB+ni4wNVp5oX+VQcVMG98Yj6RffyWjmisGpGf2WXGDvCkCsXVOz1
	PxKc4ZBA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r0JH9-0012da-2M;
	Tue, 07 Nov 2023 10:25:39 +0000
Received: from mail-dm6nam12on2061c.outbound.protection.outlook.com ([2a01:111:f400:fe59::61c] helo=NAM12-DM6-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r0JH7-0012bm-1l
	for linux-nvme@lists.infradead.org;
	Tue, 07 Nov 2023 10:25:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xmk04qXzND5InZTVsmq11uvh7s64eWoADth9beCwFbbNw7uRGWxm6IrESiJUaMGZdIa4o/n1PQ8VZHctVs0LidECzPPfdHRZ+cGWhSEUTCB888xiBhnfK07TGwaIgY/5De+eMe6OEwCmwHcz3plLC2Z8a998xRqWBlicTmhew2arrbMgHZN68tQSsVoExsyYrXI6zBSVt/i+KV1mOX3KYs80WOT3lPHBEyyxMGV09mfDnERoiQhW/CW1T6tmqEUvw58a6aj84LgdQvWnIgfWm0qterJ/ox9fb1eP16ipeVO+RO1y+/r+65l0QWVhdpxyNJ7vTs237B/l82vIyauEPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A0EB8oUaIR4twEPyWFrm2gftg+BbVbAgg9EJRU2GRfk=;
 b=awq4z/OkmOEzMjg32CSKHpPr6AlamB8UXBwn3LrS4R9vGZBLQaSEf9a1uy622Hw8PUwQwT9z0dHFK2exq5YNFtbEXzfdzPeeurlQVs7knTNgmElUzPWvOKoxqGXS7cJLRHYgOvUlpYTG1Z1WfuTyT6HnRcxZYl/HXVsTSotU3+k9A1e7Gg8dCKciXepkUYvvfhrdRzDOQHgIVy1Y7LycCjzKVBbe7K2FDHUibB/2l0l/GDI5zo31CykNtEgPR3naMInAEuwpGQXqfkJsMOcsUJKd5ySbzigcWNVhqxbRCo/AwLHuXq/KS0xp65TZj0rIwUSt1FQuchgqpp1YcEla8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A0EB8oUaIR4twEPyWFrm2gftg+BbVbAgg9EJRU2GRfk=;
 b=swCHyevFD0DmZ2jZQSPHyuCLQghL9hcLWPRA8rtFGJVv8wXembmsnjkOO4J/18ZLVFIRNbDKVDgiZPyRJQoLD4xryG1R8k/YoNMUVgyWLsjNLq+JhFJ8FZac9l3HAwNJ9CsJeX8+EriWTtUGbFJp7G+ECLnzihGeMJHew2U5ViIP6zi0bIqpaGIhm0nWfPChV4I1HMAa6CDvIGTO3JfUcZElRG81UEAAshblmZs6aPP8y3SDhEiWe0NgPNvXllNduKj94RBz7TV+ThxdzBiYLKbd6WvRch1o+3ikYdPt1I8fb/tAeBuqwhJ88MR5YdMxhyiGP79mSFwHtyIcXQVnFw==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by DS7PR12MB5789.namprd12.prod.outlook.com (2603:10b6:8:74::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.29; Tue, 7 Nov
 2023 10:25:28 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::ccfe:928d:3fbc:8781]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::ccfe:928d:3fbc:8781%4]) with mapi id 15.20.6954.027; Tue, 7 Nov 2023
 10:25:22 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Christoph Hellwig <hch@infradead.org>, Wen Xiong <wenxiong@linux.ibm.com>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	Wenxiong <wenxiong@us.ibm.com>
Subject: Re: Saw I/O errors while delete/create/attach a namespace on nvme
 device.
Thread-Topic: Saw I/O errors while delete/create/attach a namespace on nvme
 device.
Thread-Index: AQHaETCHjxO/cJJwokGzfIBBYOwSybBujk8AgAAYvQA=
Date: Tue, 7 Nov 2023 10:25:22 +0000
Message-ID: <299987e5-ffb8-461c-9228-cad7e17cc542@nvidia.com>
References: <ee222a8c6574d754d7e6355591e1a06a@linux.ibm.com>
 <ZUn70pL+YV0adqd0@infradead.org>
In-Reply-To: <ZUn70pL+YV0adqd0@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|DS7PR12MB5789:EE_
x-ms-office365-filtering-correlation-id: 90cb1e1d-0378-48e1-cd31-08dbdf7bd98f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4przhLLxqstl+NrPqM9Y73dzkfrFzB++gc4iNJwn6D/u6Aod8q1moNnuJ1R/JQ2R6wW7A43YsEOC649mpIbXwMCcG9GdBW9cXMGaBXJnfsGF8PjqCbXOqYsgppn3tzHUSVsHKgufTc2AEkM6TfyLLGNMsvoDzDUI/cNBRMxkbHBAR5VgW97uvl8l/g24yR74es/KtJGmtFGoxnmKCR/88A5YBfSeW76Xnv1BYMKADqJZfp5nBuL+ql8yHhjfFVLQRgz89ZKJ2+InPMcXIQ4pQLT8RRovgE9Vkbq9ZHvTxN+fWXJoJOtSRagi/DtKaVVkas9tNL7Tg/PSJYHRjDUbeUUhBxgFDU/6RPmTZ9AFMH043zCDs3Pa9fUHWmKBlhx+dfyS3eHlDZ6OPkJX50xJr9oMiOhE+S08AwD9hcGfd0r4GxU5StPqOlL8Tr33MbPeKVZP81VDFjtZj3vKNIuyLJCI8gsxXPWQdSlebkHoY5HUZD8rThCdKDlkEKAKOnACaevFErPonEpgDJ+UtUugyuR1OMPsFfInsOWOtLmzLRRmbGDY7q8VWA8UTFkMYKQs+JZ4b6aWiIwby+How0YC3BRwi6xwVkPi4+P+vf7hM7uoZqTKBSJxQNF6YRxBn4er3NDCagAtsdk2VErqvtyt1IcZM02hjBdauOQ3qSkhntsPlGIlZ86XG/sKsBIqcyHl0AoZYRCf8keQGKjt2u3leg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(39860400002)(376002)(346002)(366004)(230922051799003)(186009)(64100799003)(1800799009)(451199024)(31686004)(38070700009)(36756003)(83380400001)(53546011)(8676002)(6512007)(6486002)(8936002)(4326008)(6506007)(71200400001)(2616005)(26005)(478600001)(66556008)(66946007)(110136005)(76116006)(54906003)(64756008)(91956017)(66446008)(66476007)(316002)(86362001)(31696002)(38100700002)(2906002)(41300700001)(5660300002)(122000001)(21314003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eEVIQWVmUTVQZXRQY20rVitUV3JVWTdmUG9KcWVXWUJweEhvdnlqaEJsUHZF?=
 =?utf-8?B?V3ZBTWRIY1R5ZjZsd1E5NjVTendoSEY5dGdXeC9VTGwveGdFVDg5T0tlbmhO?=
 =?utf-8?B?N0E5cGtrQ2tuT1VUWElEbC8rM0xCSzQ0c2xSaE15TWVrQXhDcjRiV09yaW5F?=
 =?utf-8?B?Njg2S3g0OGNHMFFxZWQzMGZFb2NYT1VBaGw3UDJrZE5GVnExN28rU1RjWktK?=
 =?utf-8?B?NklVNUxmMGI4ZUptWlRQZW5OZUtXd2FIOUpXL1FmaDNIVkVDVDI0dWRvSWps?=
 =?utf-8?B?THVWQk1mUTFWWDVrR011cFMyVFJoRUQ5NVRDbkZZOHdacTZqNzhGOVJhN2JG?=
 =?utf-8?B?Y1FMSUVSaGhkY1MvRVYzOVFzdThteVFNOFgxZlZtN1M4anYvb2NtaUVyZ2d3?=
 =?utf-8?B?T2lkOTVML2xtNjgzb1l3QkRpTlp2eVBhM011OGpQQks4Uk0xQXVQSzRmOUxX?=
 =?utf-8?B?N1RmVVgyeHF0Um1ia2J6SE9Eb3Iva2ZjMG8xcGxpMFhUZllVSlZ0Qnp3WTQ3?=
 =?utf-8?B?ajN1WjhhaGJVTlRzN0tTSkRLLzlTejJja1E0ZEpjYjZBVy91dkNORTY0cFpK?=
 =?utf-8?B?b3RLOUY4b1l5VWh3YnBEUnR2ang3Mm11eG4xZFR5K2hqaGc4Y3k5Zk1lRys1?=
 =?utf-8?B?TWFPTTBBWnBQN3l0cU1qSWhTbGtkRzBwY09va2kxbll3ZTBVSFV0SkF3N3JM?=
 =?utf-8?B?ZCtWVDZaYUd3a0t2TUtHMjJHRTQ3N0NJNmd1c0V0S0k5dlUvUkd4Skg2SUZC?=
 =?utf-8?B?blFKSHB0ekM1K2o5cUxER3NlOU9PTjVBVDFXSi9USzN3cHpDYkJrQVF4aVln?=
 =?utf-8?B?WHlZUkNnRVZZc2xOUmw3a3RKbm8yWXJnbnQ3dEN5aDhLWHBadnY1bWRpeVpR?=
 =?utf-8?B?U1JNb3Y0UWdxeFlHemQ5MzBHK3J1TWxZRVhpWHhlaU1KaTc1NnBBSUVmVWpQ?=
 =?utf-8?B?alhhQWlxZi9INHB3ZDlQZncrWXRONTJUWDhUVUQyZGx1emNiNVJhWk1uT3BI?=
 =?utf-8?B?bCthLy9oeVgvSlJPVW82azJLK3hDUTlHYUR0REtOKzJhNHhmaTZCY2doVnk3?=
 =?utf-8?B?cCtsejBLVnZnYjdUMHpsSmZqcnY4d1d5WUd3M1ExYzhxRXZrcUxhWHRhRXhT?=
 =?utf-8?B?ODVQYW9SM3NhK1NZNnBsaHFOZW5HRlZmOEMyR2tRR2owSUduNlNCZDVLUFYv?=
 =?utf-8?B?ZEl3eG1kZG1lVXluYVhsTVVocll2RmJLSGNWYTB4NUVnSUppTUNRdlhQc1Rw?=
 =?utf-8?B?RW5EV3B3VDRPVTA3WkVSRXpEOXNQa0lRQXpDaGIrUmZ0Z000YXNNdk8xbkd0?=
 =?utf-8?B?UDUrcDN2cTc5YkovWC9tVmUrOFdtbWVHRkUrdURlNmIzdE5nb2FsNzc5Rk1V?=
 =?utf-8?B?ZnV3THFzb0VmWFFBcUpCd0VvS3FSZXJ4cXcraU1NZmFsQUx2bXUra1FWQTQ3?=
 =?utf-8?B?ZkVQZldJZnB1YU5zNCtCZGNhZ1NwNnc2bzJ2UEFtSWN4TTJaZFVDMTZTVzIy?=
 =?utf-8?B?dmxSVG5kK2t0RU91bW50Tmw0Y2lseWRaZ2RWcHVOOU5vWFJrWVYyMlpHYjVX?=
 =?utf-8?B?Z1dZNGZHUTU4LysxUURDZHNNYjFJYWxRNzFxRUFoTEFBYTQ0SVh0VVBEZUdx?=
 =?utf-8?B?MVJrR1VCYUZkQzRqZ0dYa0p2dUtzekV3ZXRjc04xZTYvNys5OGJOWElScHYw?=
 =?utf-8?B?SDV0bHIvc2FvY1RsWE9ZMEFyZGJmRVFqTXI0YTQydEp2K1MxZnRqSGVmNWRB?=
 =?utf-8?B?bkEya1BuVHRmSDFUbkdCQXpmSVZWZ0RSMnZKeXFFTS94TUtFbGd5QVNjMC9Z?=
 =?utf-8?B?bEJJN3lhRTltUyt3alVsZ3RhWHlzekN4cWZ2YkJtS0VNR1hmK0NTcUIveU5i?=
 =?utf-8?B?bHM0MUxMWVFISCtpZjJhZzBFcUdET1hFUmNidWlaTkJnQ1E2dlcwSHV0alc1?=
 =?utf-8?B?YTlSWmdPSEVyYlU2V2V5Q1h4ZW1YOU1YZnpoOGtsMThhdnI1RHVuUUdTbWZ5?=
 =?utf-8?B?cUFKK1VEbXJpbEJVYVhpM3lFQjRFMlVTR0wzdEpxdnF1dWxwZUNIOUQybm5E?=
 =?utf-8?B?MzdBTWc4bjNnYStpbjZwbjlBbFFoL3luWlJjMnplRS9xMDJ6L1RYd1pIT01I?=
 =?utf-8?Q?iGEAoyf7YfjuMMg5ZaJQAfS4+?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <97FD7A8C594FC344A23E2EDEADE1B8BA@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90cb1e1d-0378-48e1-cd31-08dbdf7bd98f
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2023 10:25:22.6550
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: g2mv7hUKGrnNBu9Yi8MylgCRmjuX8FaXOg5NkoLuHDDQifMdjTHVVfKI+xOz/EvQ6rlp9vV3H0rAv6aXXDgB3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5789
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231107_022537_587630_E8A5A99B 
X-CRM114-Status: GOOD (  18.85  )
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

T24gMTEvNy8yMyAwMDo1NiwgQ2hyaXN0b3BoIEhlbGx3aWcgd3JvdGU6DQo+IE9uIE1vbiwgTm92
IDA2LCAyMDIzIGF0IDEwOjEwOjMzUE0gLTA2MDAsIFdlbiBYaW9uZyB3cm90ZToNCj4+IEhpIEFs
bCwNCj4+DQo+PiBJIGFtIHdvcmtpbmcgb24gbmV3IG52bWUgZGV2aWNlIGFuZCBmb3VuZCB0aGlz
OiBuZ3VpZCBpcyBjaGFuZ2VkIHdoaWxlDQo+PiBkZWxldGUvY3JlYXRlL2F0dGFjaCBhIG5hbWVz
cGFjZSwgd2Ugc2F3IHNvbWUgZXJyb3IgbWVzc2FnZXMgaW4gbGludXggbG9nLg0KPj4NCj4+IFNo
b3VsZCB3ZSBzZWUgdGhlc2UgZXJyb3JzIG1lc3NhZ2VzIHNpbmNlIHJlY3JlYXRpbmcgbmFtZXNw
YWNlcyBvciBhcmUgdGhlcmUNCj4+IHNvbWUgaXNzdWVzIGluIGVycm9yIHBhdGg/DQo+IFdoYXQg
ZXhhY3RseSBhcmUgeW91IGRvaW5nPyAgVG8gdGhlIExpbnV4IGhvc3QgY29kZSB0aGlzIGxvb2tz
IGxpa2UgdGhlDQo+IE5HVUlEIGNoYW5nZWQgZm9yIGFuIGV4aXN0aW5nIG5hbWVzcGFjZS4gIEFy
ZSB5b3UgZGVsZXRpbmcgYW5kDQo+IHJlY3JlYXRpbmcgbnNpZDEgcmFwaWRseSBhbmQgdGhlIGNv
bnRyb2xsZXIgaXMgYXNzaWduaW5nIGEgZGlmZmVyZW50DQo+IG5ndWlkPw0KPg0KPg0KDQpleGFj
dGx5ICJpZGVudGlmaWVycyBjaGFuZ2VkIGZvciBuc2lkIFhYWCIgY29tZXMgZnJvbSBudm1lX3Zh
bGlkYXRlX25zKCkNCmFuZCB0aGUgb25seSBjYWxsZXIgaXMgbnZtZV9zY2FuX25zKCkgd2hlcmUg
bnMgaXMgcHJlc2VudCwgc28gc2NhbiBucw0KZm91bmQgdGhlIG5hbWVzcGFjZSBhbmQgbnZtZV9u
c19pZHNfZWFxdWFsKCkgcmV0dXJuZWQgYW4gZXJyb3IgaGVuY2UgMm5kIA0KcHJpbnQNCm1lc3Nh
Z2UsIGJ1dCBhcyBzYWlkIGVhcmxpZXIgd2UgcmVhbGx5IG5lZWQgdG8gc2VlIHRoZSBleGFjdCBz
dGVwcyAuLi4NCg0KVG8gY2hlY2sgZXhhY3RseSB3aGljaCBpZCBpcyBwcm9ibGVtYXRpYyBzb21l
dGhpbmcgbGlrZSBpbiBbMV0gY2FuIGJlDQp1c2VkLCB0b3RhbGx5IHVudGVzdGVkIC4uLg0KDQot
Y2sNCg0KWzFdDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL252bWUvaG9zdC9jb3JlLmMgYi9kcml2
ZXJzL252bWUvaG9zdC9jb3JlLmMNCmluZGV4IDc1YTFiNThhN2E0My4uODQ2NTFjOTIyNTQ4IDEw
MDY0NA0KLS0tIGEvZHJpdmVycy9udm1lL2hvc3QvY29yZS5jDQorKysgYi9kcml2ZXJzL252bWUv
aG9zdC9jb3JlLmMNCkBAIC0xNzQ5LDEwICsxNzQ5LDIzIEBAIHN0YXRpYyB2b2lkIG52bWVfY29u
ZmlnX2Rpc2NhcmQoc3RydWN0IGdlbmRpc2sgDQoqZGlzaywgc3RydWN0IG52bWVfbnMgKm5zKQ0K
DQogwqBzdGF0aWMgYm9vbCBudm1lX25zX2lkc19lcXVhbChzdHJ1Y3QgbnZtZV9uc19pZHMgKmEs
IHN0cnVjdCANCm52bWVfbnNfaWRzICpiKQ0KIMKgew0KLcKgwqDCoMKgwqDCoCByZXR1cm4gdXVp
ZF9lcXVhbCgmYS0+dXVpZCwgJmItPnV1aWQpICYmDQotwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCBtZW1jbXAoJmEtPm5ndWlkLCAmYi0+bmd1aWQsIHNpemVvZihhLT5uZ3VpZCkpID09IDAg
JiYNCi3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIG1lbWNtcCgmYS0+ZXVpNjQsICZiLT5l
dWk2NCwgc2l6ZW9mKGEtPmV1aTY0KSkgPT0gMCAmJg0KLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgYS0+Y3NpID09IGItPmNzaTsNCivCoMKgwqDCoMKgwqAgaWYgKHV1aWRfZXF1YWwoJmEt
PnV1aWQsICZiLT51dWlkKSA9PSBmYWxzZSkgew0KK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgcHJfaW5mbygidXVpZCBtaXNtYXRjaFxuIik7DQorwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCByZXR1cm4gZmFsc2U7DQorwqDCoMKgwqDCoMKgIH0NCivCoMKgwqDCoMKgwqAgaWYgKG1l
bWNtcCgmYS0+bmd1aWQsICZiLT5uZ3VpZCwgc2l6ZW9mKGEtPm5ndWlkKSkgIT0gMCkgew0KK8Kg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcHJfaW5mbygibmd1aWQgbWlzbWF0Y2hcbiIpOw0K
K8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuIGZhbHNlOw0KK8KgwqDCoMKgwqDC
oCB9DQorwqDCoMKgwqDCoMKgIGlmIChtZW1jbXAoJmEtPmV1aTY0LCAmYi0+ZXVpNjQsIHNpemVv
ZihhLT5ldWk2NCkpICE9IDApIHsNCivCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHByX2lu
Zm8oImV1aWQ2NCBtaXNtYWF0Y2hcbiIpOw0KK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
cmV0dXJuIGZhbHNlOw0KK8KgwqDCoMKgwqDCoCB9DQorwqDCoMKgwqDCoMKgIGlmIChhLT5jc2kg
IT0gYi0+Y3NpKSB7DQorwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBwcl9pbmZvKCJjc2kg
bWlzbWF0Y2hcbiIpOw0KK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuIGZhbHNl
Ow0KK8KgwqDCoMKgwqDCoCB9DQorwqDCoMKgwqDCoMKgIHJldHVybiB0cnVlOw0KIMKgfQ0KDQog
wqBzdGF0aWMgaW50IG52bWVfaW5pdF9tcyhzdHJ1Y3QgbnZtZV9ucyAqbnMsIHN0cnVjdCBudm1l
X2lkX25zICppZCkNCg0KDQo=

