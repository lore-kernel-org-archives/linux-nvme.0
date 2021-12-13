Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF87FC433F5
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Dec 2021 08:06:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lYxxbcBdpoaC7osHaoE7a5ktK/RgMlsapUiF398HmfI=; b=HMd3RO3pouTnfj/DGuwBv7Zk0q
	Gpw86YgfmxndUfcgFPaO1raAv9BTEq4lPb4aO00FExCKCqq6bW3nprihd3P3MCRo1n0yiWmewkNS7
	C4o3at8NagcEw7ut1ga0z2lZf/kNIROHRar4sIf2P1pNf1ez1+kmahIBAw0tFiXKHfef7DDmS7JJ0
	m5o8sW/XZqSE8Ft7gQf0UivqCraXlg0VPkszHAVVmkzJ+tDfp7/H5nw3hA7dvBmlJHXy6O56RjgJ7
	iLzccZbF96Da4TFdIaJ/1iO741Ln3d+DHtd7k3hVTxQH5Y9ZQcdP7c2GldWKC7g3/anaMZqmYuey9
	bMxTo7XQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mwgM3-008DuL-5K; Mon, 13 Dec 2021 08:06:39 +0000
Received: from mail-dm3nam07on2046.outbound.protection.outlook.com
 ([40.107.95.46] helo=NAM02-DM3-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mwgLz-008Dst-VI
 for linux-nvme@lists.infradead.org; Mon, 13 Dec 2021 08:06:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e0ERT4Xmezpu3WyrSV1QckKnhwmDwcTo9/IG86y/iPMl0rY3t0iqioClhpCXeu5ZxM2fNVW7/HDSn7IqzV3y6S8zGtL3lOUoSKke4huECbsiEVcgwjPDXDBlqsAVsa8N8C6lT1nCW2RokZAKyWCQ0uinIQy5WYEnQzX1lAnKLePiSx8cQmdZh4U8kt+b8rCNHc/xzMonXsPSlGahkWcbUGj5NKPVGZQmW9YleHYmjeR0+Ss/SwFXAspLU+M73SGekzvXMotFXvdCSxB8eZS58kKVbvOOMfkIPJmcyKMYUjlH4aR3MrvWz4L6FpdyqzAYh+jKcI9rXnDnW5WIRtgzyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lYxxbcBdpoaC7osHaoE7a5ktK/RgMlsapUiF398HmfI=;
 b=LLXKd3mbdu0+byaqMdZj4btfUj3dAoVSP5d4MKpTzbhdsjArjUMmjfsExtivt1odqjSE+jlN9l/tMeCw10YvkK3nvPQcCyRcHMmDLCtlgX/JYBXTI+uCUa6fanWCrtMFC5XXjV07SG31rhafoEYYEmrKr/lxU8aH83QLBQMdCXA6/aVIvAYK5DzdTnbS/oguYSJrCIeAkwVdql8NIjazhWuPxjd515BPqcyG/prGluqj9CT1YbIr904ey4hWr059X0cdFBC4JX8rEoFKUIdeV3Cq5IFniS/3zsx2/1dD4+qRhqHkxt+/5niyqVMPTzEws9ntzHxIIlim4IkRlKuqIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lYxxbcBdpoaC7osHaoE7a5ktK/RgMlsapUiF398HmfI=;
 b=s5pPBIzDjB91bEX84HqBvznEUC3gqqihx2Vi11ROBC5TjmyHp+ar80+PKQL1Uzih6R94n9Dc5jTEpyNOlbDSDiqsmPGUrHu4yFoS+DG49L9pSM1a0g9rSdeqDBJq2R5CWAl5XpfdiOCsyRSFughsxzIjsecg/1Sg2LjHk0E/SEokFU/7UUT58gHK6aeDhiSplTJYr3EfE4UaoH98UEfJraQPDf6L1uIrs0KVyNMHryxLP08+Z4jVFaZElSk4OiN/nmEna4XQ6jHdzAPKLiPI7nZwicXodNtOy8fKkwbTJIOHRmvaU8qWAr2bIPJ84FAigFTtyAEpMY6NeWjQkwCeCg==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by MWHPR1201MB0158.namprd12.prod.outlook.com (2603:10b6:301:56::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.11; Mon, 13 Dec
 2021 08:06:27 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::6df1:639d:74ea:d39e]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::6df1:639d:74ea:d39e%7]) with mapi id 15.20.4778.017; Mon, 13 Dec 2021
 08:06:27 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Hannes Reinecke <hare@suse.de>
CC: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <keith.busch@wdc.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, Martin
 Belanger <martin.belanger@dell.com>, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCHv2] nvme: print out valid arguments when reading from
 /dev/nvme-fabrics
Thread-Topic: [PATCHv2] nvme: print out valid arguments when reading from
 /dev/nvme-fabrics
Thread-Index: AQHX63JqEKcF6ORjXEKKwrrLgmPDsKwwGcEA
Date: Mon, 13 Dec 2021 08:06:27 +0000
Message-ID: <6ba69fc7-d2cf-664d-5289-89ff932b1539@nvidia.com>
References: <20211207135549.100950-1-hare@suse.de>
In-Reply-To: <20211207135549.100950-1-hare@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 36c88f9b-0a8b-4796-2c01-08d9be0f768a
x-ms-traffictypediagnostic: MWHPR1201MB0158:EE_
x-microsoft-antispam-prvs: <MWHPR1201MB0158447F291BF04BC864D8D0A3749@MWHPR1201MB0158.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:751;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YLCxiDKSYNdN0Hu6VpIKiboRJpjq4CsAW7kdwwKkAa7WbI7BVpwtkH8OUA4aQW98hIPKAEeNpV+0PJD+W4Z186he/iGwo5KLeiffw372Umdcava3j1jylXj+P+W6vU4MCBA7v++rYnhYE0Yh08QK8T6Jps50Tsfh/V3W+2L5xQgXlH0kCOtiSNcOzEuSFJid0Vh4g/qyhUpVHLTMF7SvcdJ7ya81+QnRzi0Ar7OUcxYXtD6Yl/lKYbartcUbGqeId/isjlzX+Jn8NP59rnboCmuJAuH2s3kwR9+WKuAcuFmW3+FBQY4qiIoz7caYexEukC81fU5XwHkfsmYfPfQN+6R5qpw7KeU0hG9zJWMwmAzcbEUqgFHi2/RM2dnwV/lbbIpzrhsB4nDP09Spe1y+hls6gTwUbFHkQv/d4OzhC4AXIOQrE0rAZLT3JQx8sMvPlH7ms5ooGuLIa0oiKU2tegpvJLurQSzKqE/3qj0vrDcjFcaOfU8ddlSxwve93OeEadaGmpiZQL39lGf++9WXpNSqsc74yDsEIZ7LHQM/hOzT6q072AqK3Ui7M51dFkhZfUy8N2sHQoT5CBTOrcpMp96luPUOf9Aw9b13h3AvxgIbLMaDINvAdMjWJmJCpBmROMrwctsuKrJrWvYbwO+IDY6hHyneqIJW7MZgwrODONziMxm1h5XeiGp4isYmItwiRxrYYpYNbFrH0NrYL1X9SUba8guKz46N90aFeZszOZxFAYxpDwFtTMXyuJ6STT08wsxDmGZjnyrO7Fkc4DSPcw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW2PR12MB4667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(8936002)(5660300002)(8676002)(122000001)(71200400001)(2616005)(38100700002)(36756003)(186003)(38070700005)(86362001)(54906003)(31696002)(66556008)(66446008)(66476007)(64756008)(6512007)(6916009)(316002)(6506007)(83380400001)(53546011)(66946007)(4326008)(31686004)(2906002)(76116006)(91956017)(6486002)(508600001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MDF4QVpYZ1UvQnUxWTJ6OUM5Uk5SbzlLTzFuQ2kxZWVxamY1bmtyU0NOV0k3?=
 =?utf-8?B?eTJWeGtiZmNxMTlBQ1ZUYXo5MlFvRUxJZ1pwT0Q4RmVoN040TUVYVkk0Tzly?=
 =?utf-8?B?NXJUOW9rbUdmNnhVdysvUHowQnpETTVyME9yeGExQjMvKzU0OW41VWh4VkVL?=
 =?utf-8?B?VnMrcUtMYW9Ec1gxZitLS0o2WncrQS9TcTBBVnFnaUpLVUpHYWFHTHIrek5E?=
 =?utf-8?B?MEdUdTBXS1hXTGJRcUNJNXN5VWZPYTgrQTRzb2tXcUlya0N5dFpmeGJEUGlR?=
 =?utf-8?B?SUVVaDE2TkVvdGtIQkRqQWw1ZjVqUFZrQkVIZk9QNXd2WTlhR2YwdEpCa01v?=
 =?utf-8?B?UE1tNUswVkp2V1Eveit3OStsQm4yRW5QTlNKRWt5Y1dNWWpKbE8xVXRrZEdx?=
 =?utf-8?B?UG5IZEFsU1FkL3Foc0E3QzJmU2tDQ3FhbWkzeTJOQ0NGWjRkVTlGVW9GM2Zo?=
 =?utf-8?B?SngyZkRReTFRYjd2SXZUODdyb3hEbk4zU0FFcEtGV1cybE5PejNzMzBuSGFQ?=
 =?utf-8?B?YWUvRloyL0wzMVFyVk1HVFZqYitEdkZQdmhzQ2JYOW1LbjVPQkIreXpGM3pL?=
 =?utf-8?B?VllTTCtPbE9DdDBYL2ppVHhlVC9YeGlDOWFieHJQS0s0dnZjTmpXRTNqVlps?=
 =?utf-8?B?MFY2Z0VWQ1lZbS9jK0docHZwcksvVG1xZDNlM254MkdrdTl6bDZDL1R0MFd5?=
 =?utf-8?B?M3REaTlhRzdRcUFsU29ZTmJ5bGpzNHpLMFVQUG1EZHhXNmVCTG4wU1pJUXNo?=
 =?utf-8?B?clpsVTg2TUZRTjRYc2NmYUYxUGNtYlJDTkZqWjdqd0xWWDA0RVAveSs2VW5r?=
 =?utf-8?B?cG1uODVoMXRSdGtjR2thN1ZzTlMvMVVVVlNwKzYvdGdjWHRWWlg0enVKbFR1?=
 =?utf-8?B?M0ZTU2tEZ2xTWnpWUmxMZE9HakNtSUhER3lieGVjZDFzd2FtYWYzYmZKRDZF?=
 =?utf-8?B?ekl5ZTRTQXBEazhwcGRRbkJKT1FEdkU3eE5EN1c4c25COHRXZUxBdGhha3JM?=
 =?utf-8?B?NHZzb252NE5ueHRSUG80UHp1QzBubjA1NlZqb3RUQTZEcmV1TFZVL2FyMUta?=
 =?utf-8?B?UEdvL2tiUGU4RWJQV0xsMms5RVZXRzNPdFdoUzdNQkZ2NEZUUTBIWURHSE9u?=
 =?utf-8?B?SnR4L0RLSk8vZnEvNVp5R1RFdmR5UlBWelRLVjZKZ1dzSUZjZHJuUlpZTHRX?=
 =?utf-8?B?OXlLQllBYS9UMkpqaUdkc0JocERwRlpyT3I5MERBTnBFc2Q5QnJmVENTMEc1?=
 =?utf-8?B?eGsxRVRSYmI5MGNaam9qSVF3N1JsT0ZEbjJCa2tYZmRtUkIwbjU2TGdZZFRQ?=
 =?utf-8?B?UkV5V3JSVHQyc1JReENma3FYUVIvM04wODRFN1NRbWZIalVaWG96Ry9HN01q?=
 =?utf-8?B?R016ZXNXek1uMXllZHNNK2hYdnRjdnBhZGg4SzQ2Z2thUm1INW9wTll1YjQ5?=
 =?utf-8?B?aWxMMTVQdk9pcFNDVFRjOTZzbGo3UERFMWZkbzRPeW16RXkzWFRvMThqQisy?=
 =?utf-8?B?UUlmL0dsTU5GUmE2YmFpOStFVEw2UjdRZGRxdm1mNDU0c0Z3RWt5WWVoeGxP?=
 =?utf-8?B?b1drckRmMCt0Ykt3QUNtdTFyQ2JNMDgvR2NiNFQ1V0VsSUNCYXdNcllYTW9O?=
 =?utf-8?B?bHZYSWRnTjYvRmEwZllvdVJFYXZYTk9jODNPY1pBdGFkM1J1SGdrQmZjL0tz?=
 =?utf-8?B?L1R6bVF4NE1aY3ZmeHUwQklKYzlGRlU5NDRESTR5eUhLNWNpNjZBbjIzNm80?=
 =?utf-8?B?SUlGcVdVa1hVN3JOMU5zWk4xaWtxcW1iNlY5b0RoQU56OWxFVlV2WGFSRjc0?=
 =?utf-8?B?Q0kvODFKRlI1UUJ4NEs5TXVodTdxQXVXNS9sOE1lSGpyRlQzbnZ3Tk5paVg1?=
 =?utf-8?B?eC9qdUJqR1hYMmVNZ0hSNGhxTG40SEVDb1ErUlluTXd1bEFtaG1NRjU2M2pE?=
 =?utf-8?B?N0c4YnVOTVhoM2RVRWhCakg0QXpObWU1RXpXR2Z6WEN0a2x6NXJSNGxxRURS?=
 =?utf-8?B?Unh1c2I2UjdKMUM1T1U0SUJxank5ZVZNdkFyYjVkYStPNjNFNEJDZmV4R0tt?=
 =?utf-8?B?T0d3ZXU0YTdqL0hMdW5kY2lzQ2FqWnVlbjlpTzlVQU11YkxLR2pJWGxFVmMr?=
 =?utf-8?B?UGtDZEtMSmRRd25RMjJjZTZZa3hmeTlkZlNmdnNTQkNGdkJXTHlOTFJtRTdU?=
 =?utf-8?Q?si1YNAEk3ZvIPejWHwH3/o1L/y9YgaZQRxBEpYdXH1tX?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0CECA85B3F9E204E8B808DFD4F46C9E1@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36c88f9b-0a8b-4796-2c01-08d9be0f768a
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2021 08:06:27.1030 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: y/Iyl1CDqbLtUHmcE+F6qCmtxJXw71eGU8qNmgyoJ0twz3J4tOGIr9cosIdJew1ePa4jGL+kQLcrW88giYYEdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0158
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211213_000636_039894_AF9BF8D0 
X-CRM114-Status: GOOD (  22.78  )
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

T24gMTIvNy8yMSA1OjU1IEFNLCBIYW5uZXMgUmVpbmVja2Ugd3JvdGU6DQo+IEN1cnJlbnRseSBh
cHBsaWNhdGlvbnMgaGF2ZSBhIGhhcmQgdGltZSBmaWd1cmluZyBvdXQgd2hpY2gNCj4gbnZtZS1v
dmVyLWZhYnJpY3MgYXJndW1lbnRzIGFyZSBzdXBwb3J0ZWQgZm9yIGFueSBnaXZlbiBrZXJuZWw7
DQo+IHRoZSBpb2N0bCB3aWxsIHJldHVybiBhbiBlcnJvciBjb2RlIG9uIGZhaWx1cmUsIGFuZCB0
aGUgYXBwbGljYXRpb24NCj4gaGFzIHRvIGd1ZXNzIHdoZXRoZXIgdGhpcyB3YXMgZHVlIHRvIGFu
IGludmFsaWQgYXJndW1lbnQgb3IgZHVlDQo+IHRvIGEgY29ubmVjdGlvbiBvciBjb250cm9sbGVy
IGVycm9yLg0KPiBXaXRoIHRoaXMgcGF0Y2ggYXBwbGljYXRpb25zIGNhbiByZWFkIGEgbGlzdCBv
ZiBzdXBwb3J0ZWQNCj4gYXJndW1lbnRzIGJ5IHNpbXBseSByZWFkaW5nIGZyb20gL2Rldi9udm1l
LWZhYnJpY3MsIGFsbG93aW5nDQo+IHRoZW0gdG8gdmFsaWRhdGUgdGhlIGNvbm5lY3Rpb24gc3Ry
aW5nLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogSGFubmVzIFJlaW5lY2tlIDxoYXJlQHN1c2UuZGU+
DQo+IC0tLQ0KPiAgIGRyaXZlcnMvbnZtZS9ob3N0L2ZhYnJpY3MuYyB8IDIyICsrKysrKysrKysr
KysrKysrKysrKy0NCj4gICAxIGZpbGUgY2hhbmdlZCwgMjEgaW5zZXJ0aW9ucygrKSwgMSBkZWxl
dGlvbigtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbnZtZS9ob3N0L2ZhYnJpY3MuYyBi
L2RyaXZlcnMvbnZtZS9ob3N0L2ZhYnJpY3MuYw0KPiBpbmRleCAyODJkNTQxMTdlMGEuLjdhZTA0
MWUyYjNmYiAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9udm1lL2hvc3QvZmFicmljcy5jDQo+ICsr
KyBiL2RyaXZlcnMvbnZtZS9ob3N0L2ZhYnJpY3MuYw0KPiBAQCAtMTA2OSw2ICsxMDY5LDI2IEBA
IHN0YXRpYyBzc2l6ZV90IG52bWZfZGV2X3dyaXRlKHN0cnVjdCBmaWxlICpmaWxlLCBjb25zdCBj
aGFyIF9fdXNlciAqdWJ1ZiwNCj4gICAJcmV0dXJuIHJldCA/IHJldCA6IGNvdW50Ow0KPiAgIH0N
Cj4gICANCj4gK3N0YXRpYyB2b2lkIF9fbnZtZl9jb25jYXRfb3B0X3Rva2VucyhzdHJ1Y3Qgc2Vx
X2ZpbGUgKnNlcV9maWxlKQ0KPiArew0KPiArCWNvbnN0IHN0cnVjdCBtYXRjaF90b2tlbiAqdG9r
Ow0KPiArCWludCBpZHg7DQo+ICsNCj4gKwkvKg0KPiArCSAqIEFkZCBkdW1teSBlbnRyaWVzIGZv
ciBpbnN0YW5jZSBhbmQgY250bGlkIHRvDQo+ICsJICogc2lnbmFsIGFuIGludmFsaWQvbm9uLWV4
aXN0aW5nIGNvbnRyb2xsZXINCj4gKwkgKi8NCj4gKwlzZXFfcHV0cyhzZXFfZmlsZSwgImluc3Rh
bmNlPS0xLGNudGxpZD0tMSIpOw0KPiArCWZvciAoaWR4ID0gMDsgaWR4IDwgQVJSQVlfU0laRShv
cHRfdG9rZW5zKTsgaWR4KyspIHsNCj4gKwkJdG9rID0gJm9wdF90b2tlbnNbaWR4XTsNCj4gKwkJ
aWYgKHRvay0+dG9rZW4gPT0gTlZNRl9PUFRfRVJSKQ0KPiArCQkJY29udGludWU7DQo+ICsJCXNl
cV9wdXRzKHNlcV9maWxlLCAiLCIpOw0KDQpDYW4gd2UgdXNlICJcbiIgaW5zdGVhZCBvZiAiLCIg
Pw0Kd2l0aCB0aGF0IGNoYW5nZSBpdCBsb29rcyA6LQ0KDQppbnN0YW5jZT0tMSxjbnRsaWQ9LTEN
CnRyYW5zcG9ydD0lcw0KdHJhZGRyPSVzDQp0cnN2Y2lkPSVzDQpucW49JXMNCnF1ZXVlX3NpemU9
JWQNCm5yX2lvX3F1ZXVlcz0lZA0KcmVjb25uZWN0X2RlbGF5PSVkDQpjdHJsX2xvc3NfdG1vPSVk
DQprZWVwX2FsaXZlX3Rtbz0lZA0KaG9zdG5xbj0lcw0KaG9zdF90cmFkZHI9JXMNCmhvc3RfaWZh
Y2U9JXMNCmhvc3RpZD0lcw0KZHVwbGljYXRlX2Nvbm5lY3QNCmRpc2FibGVfc3FmbG93DQpoZHJf
ZGlnZXN0DQpkYXRhX2RpZ2VzdA0KbnJfd3JpdGVfcXVldWVzPSVkDQpucl9wb2xsX3F1ZXVlcz0l
ZA0KdG9zPSVkDQpmYXN0X2lvX2ZhaWxfdG1vPSVkDQpkaXNjb3ZlcnkNCg0K

