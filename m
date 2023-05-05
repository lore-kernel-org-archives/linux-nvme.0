Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8261C77B75
	for <linux-nvme@archiver.kernel.org>; Fri,  5 May 2023 23:56:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=naZGpZcRs87QX9jZCRkSmpGRGc6wlqdwLE+X9mvrIdE=; b=4K4H/VRVqYVfnU8A5/w9Un1S0f
	COsIBIamI+vgLrIXQNiAp/aPlhcc6qNs9gEUBqu5NRHWIc2j1dagSo7o2L32jMqNOaKcSm9tm06WG
	BIHbfT0m7wGK01FH4bizG8G7+fgXpgGULnCCuVZF+xNJ30KreZTpdsDDajTSeyZc2b8hTyj/osN02
	5nHXr/42oASal4evOPTf8bRO5OOSg7KYB5b2bAgYam9cCZ7xj5J7ZAZFL5x5y/aIlrTvg0v7fAX8p
	woTac6IBWTRfbG8oXiiAa7YZb3KZgO7mchbtcOZHIsRleFeQITdQqu+VSGQG90QSp7zf4ucAYCFw7
	IsoSXbvw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pv5HV-00C7iB-15;
	Fri, 05 May 2023 23:56:09 +0000
Received: from mail-dm6nam11on20622.outbound.protection.outlook.com ([2a01:111:f400:7eaa::622] helo=NAM11-DM6-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pv5HS-00C7hN-1h
	for linux-nvme@lists.infradead.org;
	Fri, 05 May 2023 23:56:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RxIUi1K/5ZPh9+zMBJSRY3+cxaErgwt9GMEu8q0Bd8f9qh29c3zhAZIMOaYG7HFZQaTfL0pehQB+JrTvG9FgyMyHyd6BoOrxMeIvLTUeB/wxKW08W8TB6+dw+Dkkh8PukNR7b+ziVBanGRJm1Zfuq9SQN6AL+taKnMSKTJuldeub06wSUM5cIDnyxmZ9i+J+tnhEtafj7shNABE7dP1tfsSPELn9Zt3xxZGgR17qmbyXDWB4hPucoEd0wRqgno/kPh2gOINU+2Odc/ri7BwsPDgGBew7A59/wukVXgdIT/uCTKy/LSp+Isfndm1TzF31d8MZAL6ldwJPNGj1tvNSqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=naZGpZcRs87QX9jZCRkSmpGRGc6wlqdwLE+X9mvrIdE=;
 b=MK63DYHa8BC+ElncZ0ki/cldobRDNDGv9CIRInIPikmWeR3uQ20Kf6T90UDYapW37qvQwbIJ+MLTj3J3J9nVJQoGnGU4dCNq8B/2/mfqjVnwgukOLlF04NWQSma05uG6XVyTQ2g4L41b1+0r/CnYcn5A8JgLCBG/jkXmtGEtHAPuz1Cps83ZNW9u635buANHsPUz/qdvccHHcNIFaq30uzeH5qUMGKZq+6ewaAWJ8ThynEfjre9Tj6X7eoOMYkL7Im6xNeXtpdDrM1wzJYtj1T7ndzgSaIgQmqVyvPpK9H2GMR4whZUkJR9ntAXSzH/ECZtF4jq3Iou7DiEWST3o1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=naZGpZcRs87QX9jZCRkSmpGRGc6wlqdwLE+X9mvrIdE=;
 b=fEKZLt8skcGkiHRyh1O5kMGhOSOz8Lt3dNpva9DGVQoAQ3UvsOUla7Sf3nYtAu1fttdvnxE6S7ShVrJKJT9InCAb1l2xQ+nfYwHrbLSH+YL2LzY8EaTW4gkiQ3TnWppz7oGTLqkPOzVeg8eoI0Kts3KXqc0ODawebBL5bilnX1dotWKhOO3pR5rHhaxugQCxy1AmBqkdCSAc+hl24armuWmllqOMjcfdumtd7CwsRghsE9bjpJ7ZPWsRpYR7p3ZVydIig2Ie4aO0NsPzyoYKh0yK+9LW4PsFgtcTHWuQrFTBOJ8Z/1Dv1ZxWD7ANmrFgE91jwyRcLyHOrNUAoQYehQ==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by CY8PR12MB7585.namprd12.prod.outlook.com (2603:10b6:930:98::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.27; Fri, 5 May
 2023 23:56:01 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::7326:8083:5e17:2f90]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::7326:8083:5e17:2f90%4]) with mapi id 15.20.6363.027; Fri, 5 May 2023
 23:56:01 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: "alan.adamson@oracle.com" <alan.adamson@oracle.com>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	Christoph Hellwig <hch@lst.de>, "kbusch@kernel.org" <kbusch@kernel.org>, Sagi
 Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH V5 0/1] nvme: allow passthru cmd error logging
Thread-Topic: [PATCH V5 0/1] nvme: allow passthru cmd error logging
Thread-Index: AQHZaynj0FvmtPMRR0m2hZrgt4zZb68lPEoAgABY3gCABc28gIAhAIqAgAAgiIA=
Date: Fri, 5 May 2023 23:56:01 +0000
Message-ID: <6835206b-e28c-8ad8-b468-32b7d7208535@nvidia.com>
References: <20230409212538.18647-1-kch@nvidia.com>
 <0c50fbf6-4bc3-7289-2a39-072191c81dbe@oracle.com>
 <8a811508-f53c-bae5-fe32-da65101bdec2@nvidia.com>
 <551a5499-c4eb-0416-0d2f-9951817346ce@oracle.com>
 <c9ed84c9-58fd-37d1-138c-869726ccc7d6@oracle.com>
In-Reply-To: <c9ed84c9-58fd-37d1-138c-869726ccc7d6@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|CY8PR12MB7585:EE_
x-ms-office365-filtering-correlation-id: 98c49963-85ca-4ecf-33b0-08db4dc447b2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  ennzSukSl7FzaCAJ2bBfYccGnrT0nrlb54GAAAxT+zPSDekXCQW9jVyB/kuFBs5Jf/KCINJTLd7AVzRmDLyYFieyVsGiExYw5FUzH0V0FzqBX3ryGPtzEKLLS4VMw62om4TuNf4klfaNSSxYb+A53p2xHH0T2MvDPOtR7UKGY93kqf0POUE8pVjbY7s/d2gxZeHqWO1xhuEl1PXHUnHh14xRLAv77ET1eRUoCS6DPrlE2iXPToezfz86c56iQYY5d14lb/M7oy0yjo17t0qe/6MNdPuhJ+9Bsu99Xqw+piP1qYzSo+jEjTSh1k9cE0zfSVjoHUjiCbLcyxqukKUC1tnnCNWCAComp2M9UvIukPeeAB2FAgRVpTFQjPWJedkN7PVn9ujvrrW+bdzZgXRUa7mVNC2MMZxKLCnka0u+818gt/bawitCQTAoJhjk8NXxxZVeNbTVm6nX+Xlffm80Xiw03CsevxTl0iXJl8wg+Nqre7Luqcnok3XZ548b23LiUAnBmym16ay2f7Lt7E45oW6t7HaZXRz/T7ifJZeePcn6eJTVFQgkLIBo61SPsF2+/+KsLIpT8Fupir/bVDesRcjKwWYCCH+b7JxhNu+UWFiyGY9r8gAGO4EWElUoMxzdjjJ8r+PiPQz+Ts25AmWUtxLCm2AmkWF08PQk4zLYU30=
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(366004)(346002)(396003)(376002)(136003)(451199021)(8936002)(6512007)(6506007)(2616005)(53546011)(8676002)(66476007)(5660300002)(66946007)(54906003)(66556008)(41300700001)(64756008)(66446008)(316002)(91956017)(4326008)(76116006)(186003)(6486002)(6916009)(478600001)(71200400001)(122000001)(38100700002)(86362001)(31696002)(36756003)(38070700005)(2906002)(4744005)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?utf-8?B?V2VWMFhteGVjemtNU2VPZVRmdUNwUi9mNVo3UWcwWVpmemFGT2xpcWNMYjJs?=
 =?utf-8?B?cVdjR2huK2lacU5QcHNpdXJrM1ZhZStuRlh4RTd4b2dWS0RadUlyRGpjVnRo?=
 =?utf-8?B?Q3kzd0RCVDBwS0RxRzVGc2s1VmVYVFM3SDBzOTJtMWZHaWFSS1AyelBZSUww?=
 =?utf-8?B?QitPLzJmVTZ5WHVLdGh3cEdiZ012Rll2V3EvUkpaVllsR1RuTDM4UDRBNnM2?=
 =?utf-8?B?ZkVlSmFFSDVmVFBVRFVCL1ZjYXpFSGdZQzltclgzUFNBT1Vsb1JxbG44Y29h?=
 =?utf-8?B?ZmxEcHpRbWIvb0ZaV2FtQ3dlZkRyaUJGRkZNUFNIUldZMkhLdndEa1UzRWsv?=
 =?utf-8?B?Zzh3YU5JL3BaOFBvVVY3SGhIU0hpNzhpWU45L1VvZWFQczJUZUcwUXlKM3VE?=
 =?utf-8?B?VlFzYlpUVVRFU0NGWmFnL2tFaVZFVmxqZldheTVsYmNyUEpXczRwWlhIQUFG?=
 =?utf-8?B?RGVoYXgwb1VvK2FIajNDejNSQzRsb1g3aGFTME95T21ZdWtMTGRZQVhxY0h3?=
 =?utf-8?B?U2pHSllWZXBoQkRPazRnNi91UFFZczRSNU9meUdWN1pQNGpNOCtEb3ZNMmx0?=
 =?utf-8?B?TkRSM1ZQNG5OVThLTHZhbVV1bklhNkxGa3VPTUJSL0pvVGIrSlVMdFR6Um1Z?=
 =?utf-8?B?ZVJoYkprdktGM0NkemF3VzNhQ0UyeGIyclU0eUtzaUdyUy9jejlyMFRIc2V2?=
 =?utf-8?B?Snh2cC85RHc4Q0VPV2JPaGRLVDdDek5sZCsxUUtLVVZqZkZDbDNEYllxQzh1?=
 =?utf-8?B?ZzZIbDZrR2RQL0YzNUdTUGRxR0tORjhVYXlSbkJVM01INTVJRUovWUViUUt2?=
 =?utf-8?B?ZXJJeW93WENzSEVQQ2VLWjIrb0w0c1ZuKy9jMmpPNkxyZGhOYWRPWHVpRDNV?=
 =?utf-8?B?VjhUUlZ5cEhxMlVvNXhhUFNKb0R1VzhZK0pYQURiQloxa04rVHVzV1VOYnhq?=
 =?utf-8?B?SHhDYW5WVVFxcGZWMVVkeExjeFZJR1ExaVY1eXc3ZXUxRXZuTVNRZGRjRnhG?=
 =?utf-8?B?UEt0ajRCcVYzYXk5VmZtL0RXQ1VRZjA1N3FLNXE0UFl4MjM2c2VicUllSHRi?=
 =?utf-8?B?V3ppUkNYZjgySEdnZlFXMHh6K2F6bU5VZGhTcy9xTlhNRDZmbk5YbW95dXoy?=
 =?utf-8?B?ajE0V2FzYTBNbEFzQ3FOZXpJcldWQXZhS3FPM3V2cC8wS2g2UEpIb2pJM2gw?=
 =?utf-8?B?Q0NYSlBtUUovWFhHWWZ0RGxaVHN4aTBDS3JVUVhkZWQ5RFBzNkxFSklBWC90?=
 =?utf-8?B?alB0WUJ1L3JGSnRlMGFJcm9LSkhKMmdGUkIrTHdDckh2TmcrWU05Z2ZOOEdr?=
 =?utf-8?B?SC9INkYvcHpRQ0N4MzVIQlJiYkgvWE0rWXRpNnNhQWxaRU0yZjVtUG1OM3lu?=
 =?utf-8?B?NDNOdmVraGhSYkpBRWN4UU5FVjkzMk5kWENYa1hkVHBNd1hoeVlmRHpLc2t2?=
 =?utf-8?B?MkhreXlnejh6YWp0T3pmVG5MWTNQUWVOYzQ1L0F1Vit6WitTQ1cvSUpjcTFT?=
 =?utf-8?B?ME56ZklhNlM2SEM2dnhKaW9VNzlIdWF3U0JXaW5PZGMvcnEzaWJFRjYzNURY?=
 =?utf-8?B?SUF1Z1hBRWs5VURIbE15VG5kNWUrZVV0aXpkSVo4VDcza3ZFZVFmMFRvWTlu?=
 =?utf-8?B?RlQ1TEVXTW5aQy81eFBXTFdjSUVFdW5oQmQ2NVU3SGF4ak05UnVINFlVVkZs?=
 =?utf-8?B?TWxmN1I5bzYvKzRDbVBxNG04TnhJMlc3cDgzZkxnM1dFY1AzS1NUeDRXN1BG?=
 =?utf-8?B?aTNwKzBMUm0reExmQzlVNC9aSmRvMStVeW9DdzR0N2puOER2YXN6TXVmVUpJ?=
 =?utf-8?B?bTFqRlBqR2tFVEMvM0Jxd0U1dVEzODZUN0FEa0d1RFBXY0dIZ2Jzekp4Yk9v?=
 =?utf-8?B?RXExMXpaS2ZhbXFXdC9CVitWeURLenc2YXRSclB2WFJ6V1Q2ejFvbFpIRVFy?=
 =?utf-8?B?SUdSVFdQT3RRUmJXbENnclRlYTJxOVk3SGpBbU00M0NCQ0ZuU2F4SUN2QVFZ?=
 =?utf-8?B?U25rOGkwbU9kYzVwRGFvZ0RubkxyeHJSTFhzdUs1dzNqeGZrcHg1VXlkUm1I?=
 =?utf-8?B?QW9DS25uZFA5RzJOM3Z5YnFnMGlNQnZTa3pxUmhVV285TTdIdHNzSFRhTkow?=
 =?utf-8?B?aENDV28zV3JnNmJRWEZCTDR4eDVnd0VsYURzNjIxT2JhbVFvaXBEN0s2WW9N?=
 =?utf-8?Q?xQodS/PZkcfDO3P2Y5RYSdRqUH0ZydbkDC5fJ/EU0YBq?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B7173F8F702CE84EAAC007FCE79D2D02@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98c49963-85ca-4ecf-33b0-08db4dc447b2
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 May 2023 23:56:01.4297
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vgRnaYRng06joVZz/jfX6BhyW0L+Hy2UZ0lzSBNUUCBRodc6tdh+GUwmroj2RNL9y66i9/TdBIvSVrzQmvBBTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7585
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230505_165606_659362_13EBA774 
X-CRM114-Status: GOOD (  12.93  )
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

T24gNS81LzIzIDE0OjU5LCBhbGFuLmFkYW1zb25Ab3JhY2xlLmNvbSB3cm90ZToNCj4NCj4+Pj4+
IEluIG52bWVfZW5kX3JlcSgpXyB3ZSBvbmx5IGxvZyBlcnJvcnMgd2hpY2ggYXJlIGZvciBub24t
cGFzc3RocnUNCj4+Pj4+IGNvbW1hbmRzLiBBZGQgYSBoZWxwZXIgZnVuY3Rpb24gbnZtZV9sb2df
ZXJyX3Bhc3N0aHJ1KCkgd2hpY2ggDQo+Pj4+PiBhbGxvd3MgdXMNCj4+Pj4+IHRvIGxvZyBlcnJv
ciBmb3IgcGFzc3RocnUgY29tbWFuZHMgYnkgZGVjb2RpbmcgY2R3MTAtY2R3MTUgdmFsdWVzIG9m
DQo+Pj4+PiBudm1lIGNvbW1hbmQuDQo+Pj4+IENLLA0KPj4+Pg0KPj4+PiBUaGFua3MgZm9yIGRv
aW5nIHRoaXMuIExvb2tzIGdvb2QuwqAgSSd2ZSB0ZXN0ZWQgaXQgaW4gbXkgZW52aXJvbm1lbnQu
DQo+Pj4+DQo+Pj4+IEFsYW4NCj4+Pj4NCj4+Pj4NCj4+PiBUaGFua3MgZm9yIGhhdmluZyBhIGxv
b2ssIGxldCdzIHdhaXQgZm9yIG90aGVycyB0byBoYXZlIGNvbW1lbnRzLg0KPj4+DQo+Pj4gLWNr
DQo+Pg0KPj4gSSdsbCBiZSBvbiB2YWNhdGlvbiBuZXh0IHdlZWsgc28gd2Ugd2lsbCBtb3ZlIGZv
cndhcmQgd2l0aCB0aGUgcGF0Y2ggDQo+PiB3aGVuIEkgZ2V0IGJhY2sgb24gNC8yNC4NCj4NCj4g
SSdtIGJhY2sgZnJvbSB2YWNhdGlvbi7CoCBXZSBjYW4gY29udGludWUgd2l0aCB0aGUgcmV2aWV3
Lg0KPg0KPg0KPiBUaGFua3MsDQo+DQo+IEFsYW4NCj4NCg0Kc2luY2UgeW91J3ZlIHRlc3RlZCBW
NSBpbiB5b3VyIGVudmlyb25tZW50LCBJIHRoaW5rIHdlIGNhbiBwaWNrIHRoaXMgdXAgDQpiZWZv
cmUNCm5leHQgUFIgaWYgdGhlcmUgaXMgbm8gbWFqb3Igb2JqZWN0aW9uIC4uLg0KDQotY2sNCg0K
DQo=

