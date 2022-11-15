Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4000BC433FE
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Nov 2022 15:36:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LnStTidwNYNfNvp8nX7bnpAteILA0lwlm2aVknUjFZA=; b=2vuXNS+l949CIbsrlc3yYkw2nt
	otm8I/3mD9YY0ao9EFZaTkhmduGdk5KJSZNK1xnDQ0adBKbHKwtg2HVfGFBzX53Oy93l+sUx1uvLY
	EwWVCfG2jCt4+K3YmzpjiAFcLTicUxW5axuJwisFBdiNZ1o6MqQNTYp4cN+hBc+9zIgvjh/N03W5n
	kjSE/9fA+VNhlK8ely+mYkkUO8u5l264HDCnHlKSjHVlEZbBGszkv8Ylnwcyc1HEwLcW46kp9qjc/
	8UWg3cfTbC/9Hz3FfvwkkPE9Z3Lyhy+pDbp6gUQbC7UqcD4Fe412/TxfQ9gH79uYxmMqoZNEUCA0i
	6jnVETPw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ouxz8-00CMaz-7E; Tue, 15 Nov 2022 15:36:26 +0000
Received: from mail-bn7nam10on20609.outbound.protection.outlook.com ([2a01:111:f400:7e8a::609] helo=NAM10-BN7-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ouxz5-00CMYj-Eq
	for linux-nvme@lists.infradead.org; Tue, 15 Nov 2022 15:36:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UxAJSlgZc1/CfyEZys7280iFG0gt+arOuaivnif35VX0VNN6IFxNDxgFZX3iL5MqqN3HCyMU2TIYYwcuAQL0TCE7FXIkL8iBzgB91SPzO1JZkI+PYYaiL6QyCe5jdOb+jeOgbbrl6KhP5T2KZ4G+eNTNcYcwUSY6202KygT9TmmmbP2+q7FES5j22Ryi//XoHD1mun1IYOr+hAbPSqpJYCqHe3uQtapjAkxS6DcXcPB/FuwIdyfsNxLF0gN3s1Tr8VRjgrB6UItOjMUNz554RDQX7NwMfBAO0XOH2VnWZnqx/8lU7DkR60rYTa374IEKkQn4ZWY+O70P9qQiDpVblw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LnStTidwNYNfNvp8nX7bnpAteILA0lwlm2aVknUjFZA=;
 b=dfPH1Kj7g9oWaKNS52tZ+bQIo1Vsjnb++dTJISxwZUGd5IIsP31+aCDiBHDolfFt2d/3SdqN8fasnMJU/X/rK9j6zRZmrpfxbGou1SfXHHT9r4XZLKfYG7XORvuAQm15qisczN/VpsZcLiTBvM+R3GoWpSn2UzA2Jxe4n4wL9nMvjAPNJpp4hP5HIRO5ZFsKUK7A3yd3iFOwHQAvNEVFDm/1CK6wCdBYbPXqP5SeVih9FGnnR/V7UOWeH68Ciig6d3X0HHTiVmFxDmwLLp9g7fxNChw1tyk3Yv9zUqviG23T44+DmcCMqc+Z8JMcqNiPVn4gBdlYSsIT5g50UnF16g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LnStTidwNYNfNvp8nX7bnpAteILA0lwlm2aVknUjFZA=;
 b=kr+tAFerjEaBG+9uv/iNo5Z8cv6Cz97WV1dK5+GmZPCJpvlQpdfDSdeLSWfJkNhS+j77DIobqhxWr7yXPeK7nk8hA3S2pQmKKBR89YZjeWBEyRHdb735NrMzYweLvDTl0FcxVbBFtl56DMkeXVRrFuWCYPzxJZhVinzqZv3xqopPcUboUFXBBLLvnoXETgb0gitTVZMvyvPcTC6Rd4OH8lNeI8TTZtJhBjaiJr91fMEzxyWykz+P0VsCjPgnB/WGbLJJSbj0g3DsdSgPmT+Mnw68K/HfKCrDcHs+ZNBqBvNnZVj71qmoIFZwpo5mgEAt2fA4NV1FkkTIw05AGVHRxA==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by CH2PR12MB4264.namprd12.prod.outlook.com (2603:10b6:610:a4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.18; Tue, 15 Nov
 2022 15:36:17 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::eaf1:9be8:d472:ea57]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::eaf1:9be8:d472:ea57%7]) with mapi id 15.20.5813.017; Tue, 15 Nov 2022
 15:36:17 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Christoph Hellwig <hch@lst.de>, "kbusch@kernel.org" <kbusch@kernel.org>,
	"sagi@grimberg.me" <sagi@grimberg.me>, "james.smart@broadcom.com"
	<james.smart@broadcom.com>, Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	"marcan@marcan.st" <marcan@marcan.st>, "sven@svenpeter.dev"
	<sven@svenpeter.dev>
CC: "asahi@lists.linux.dev" <asahi@lists.linux.dev>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH] nvme: rename the queue quiescing helpers
Thread-Topic: [PATCH] nvme: rename the queue quiescing helpers
Thread-Index: AQHY+NxflnnA9aNpXk2UG9Ok/nID6q5AHkiA
Date: Tue, 15 Nov 2022 15:36:17 +0000
Message-ID: <c5500d02-54b8-9f71-78c6-b9693a7caabf@nvidia.com>
References: <20221115102346.1641696-1-hch@lst.de>
In-Reply-To: <20221115102346.1641696-1-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|CH2PR12MB4264:EE_
x-ms-office365-filtering-correlation-id: af0c9fc9-dcf2-48b5-5188-08dac71f2338
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  qH6jS/1XTYfSh22CbDPv17KGDcN5uC9D79F7cYdb5t1uqNIYnq1Vzm9oQtRX5g9XxFj+WJRKST5ePBnJYjUbptTaCTxws2q5IPfhGJrlvE3cY0qh5XhtpaSJ5WtY+RnCmudK7Nk8kWncoyxMR21LnRyg61lMuKd+nAfcE+DSBWzXNZ57OWlDOqnUuiTN1keqWY8WZoj/o+Ck3Fvr3DewP7+V00wHTdfQYGAJT25x8CNZJWfcxmQ6DfNg7uXbcl1+yBXzj1ytrODFbLZpFSyam4UkCcgof/fHnJ4ojSrv0Q6R/M+8ONVANI1f4UqebRu5sEj4IpkC+ITpU8ptFhiS1uyOc3grk0KKPGyc3DDMLxbS0QGnHIx/kSZ8+JPerBNHW1HIYzbp7EsHbjV8il6u1mKD3ycNiOTpWYcak9Prx/H7e8IJHYarHg99qGzQAq0J+HCt69ZKEjVNGzv7uaNnwI2ClBKg/P8DOrN9bJQu9s3eZVLAR4vcvjgR+5FknN18E86zo+ZDqefYBfqnP0XPFMTac8xIPBog5ix+PsT8Tp5VJXrcf8k/Re05bs3+ktS2xPvQuOSiIyi4cDVQ0doUebf407KvBSs/95GvXja4vA4GDKIUUH5OoxcOxHqc4HzG9LWZWQG/2OicHPjhtmYrUbv2PfDcUwI5vy9SxHb3Mi1Wm9O8oT3Nb/4AS4LtDIYx3vR4pSRpWYrlW16veAhOaJYqQWWjUY14c3mW1/LJ86Pe0In3hiknf8ZCiCQFQ5MP2Npv9NvA3Sm0P69tgAgCvVGnBLH6yYDim+yuGxT1wU1XH++LCDkgQW/d1vfuTHtpv0nk3ofiFrMWtvvb5wvt4A==
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(366004)(39860400002)(136003)(346002)(376002)(451199015)(31686004)(38070700005)(8936002)(36756003)(6486002)(478600001)(83380400001)(5660300002)(71200400001)(54906003)(53546011)(110136005)(316002)(6506007)(66476007)(64756008)(66556008)(4326008)(66446008)(8676002)(122000001)(31696002)(6512007)(76116006)(91956017)(66946007)(86362001)(38100700002)(2906002)(41300700001)(2616005)(186003)(4744005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?utf-8?B?eEJRMkYrZlhaTjdra0VCMUFWdUNWUzNORUV1YitWOXhMTlZQM1AyRDY4STZ5?=
 =?utf-8?B?OGZZTmM3cUNUckUyQnJKbE5WZHBtWmlOSnJGekNRaCtaMm80LzFDeEkvdER2?=
 =?utf-8?B?cnBRSlRYT1dhYm9kZzdMRkhvcGxBSlhFd0xCYy9uWXlPNkRWdFZHMWhOaTBI?=
 =?utf-8?B?Y1VxTEwrbnp3N0FrOUtaOVRWbXVQZE9RaGVMTW1ySG9FMzEwbW9kekhOa3lX?=
 =?utf-8?B?S2JHTVRGK1RURkxibTFjV0NldmRDQTU2WDBRcGw3dGhVb3hwUFVlTCtTaTJC?=
 =?utf-8?B?SEdSaUJ5dzRiQ3E4emhJOW9lUTcwRmVWYnlndjA5S2FWWjhmaldaQ1VLSjZQ?=
 =?utf-8?B?Zmx1dUxWdnFnQjdBNzZvQ0JRNjBqVzJMU3pEMnloaVM5TlFUdkVLeFJCT1dS?=
 =?utf-8?B?azBoWkZXanhSY25keDhvVklBbU5lakcxaEd3UHd6akVBMm9lWElVR3JIdStj?=
 =?utf-8?B?MTBNR0JDREo0THJ2RlhwblY0eHo3SG5pRFp6TGh0TzBQT2U5eXB3QmxsSGpD?=
 =?utf-8?B?aGtvN0ZKbk5pcnJKdUZlc3pKcVM3QUZQRGNGNGJBUzI2ZzJHaFdMQWUwN3hr?=
 =?utf-8?B?TFZ2T2kzZ3U2RkNLRi8vS3I3dGFVNlJncEJNMmRSNFJrdk9VSE9UazJsK1k2?=
 =?utf-8?B?YldpeWZ1WTVPWHFwSzFjQmtYbWFhUUd3K0V2aUlIR2g1aTlxV1ZoOE9wcnRa?=
 =?utf-8?B?aGNlVG9IWEpCWjJraGIrVnZpVDdaNGZmMzlsaXowU1lFTzI4WHliaGVScUxN?=
 =?utf-8?B?V24xZUZ0Qy8ydWxsMWI4QVc3NkdYKzIrVUxzNXI1Vy94TnliWlAvYkZhakQ4?=
 =?utf-8?B?Qzcvc25NbHlwY2REZndaaFZvall1bmM3L2NJb2JQQTFIamFrK1NsVFQ2TVBU?=
 =?utf-8?B?ZXgramwweGFxU1lXNVYzWWVyVGhrME1jd2FDLzVhbnA5NlVFV1BKSGZoWVB0?=
 =?utf-8?B?NVpKU1RCMTlSWDVRRlJ1aHEvbjhwZGVGSEdCUTkyNzVVVkpuWkZvYTRuU3JZ?=
 =?utf-8?B?MEJpNXdyeTFpNmhmM3d0dEdDZXRVWERsQkRUREZMZUc2M041aHVzeFdZVnVj?=
 =?utf-8?B?WXpOMzZBUmUvMFlTZTdjMUxiYWMzbVBLVDhzcHBoVXlrdHhkbnpDcmxsc1dI?=
 =?utf-8?B?bFZUOEw4b3FXZWZJWWRuUXZXeEI4RFo0U1RORmlVMURwME8wUkdBMWUrd1Fz?=
 =?utf-8?B?R3pQRVIvc3A4SWNHcGFwb0RiWlNNK0s2MW5zekVjNHFNTTVHeGUxNVgveVVH?=
 =?utf-8?B?bkhibXFpb0hGcVJlVCtraE9qVkxQblVBWjdhVmlOY3V2VkNPamt3VE9WVWQz?=
 =?utf-8?B?MkFwamdtRC9kckdPSXZXOEZnemRUVWNLUktOaVRZSWRwZHQyTjdXdExNdzM5?=
 =?utf-8?B?VmpkQWdOWXAxRWtEbllObDYxQml1ZWtOSTY0eVhzUk13eDlxenRoUnVmVzhw?=
 =?utf-8?B?MEVoR1NnaUtSL0xMQUo3SG1uRVdyZEJUYkt2UkthaHVURExIWDdrRG83NllL?=
 =?utf-8?B?bFlMbjVMKzBHQWRWbDZNd0ZsNWltdDlIUGJGZDd0UUR2RzNGY291SjdyZEQw?=
 =?utf-8?B?U0t5T3hOdW9HUkJ1eFdFMFdUcWVDSUI4RGloQ3U1d2p4ci9xRUZFc2gvT1lV?=
 =?utf-8?B?aEFpdThWbVF6cHkwbjJMWlJYZXVLOERYWmhWZTFzSzR5Q1lYZzNYdm43ZEhH?=
 =?utf-8?B?ZUhJQXF6cEt0UHpIb1hpcWttVit6K0VrZ0FnYmkxaGlUSG5mKzVFQVlZZE1V?=
 =?utf-8?B?VTIrb0VXSlNjeGNGTDBoYmgyY2xxdG9xY0ZDb2oxdGJ5emJQY1loaFV1NzYw?=
 =?utf-8?B?RjRMM0FuYVJSZ2wya2RuTmVUdFNseGh2L2tjQWlRZU4zN3hEa0ovcWJvSlNv?=
 =?utf-8?B?L1o1Qytadll5ajlnenQvUnV5VzFxdVZBaVJtd0g5Nm05bnBSSXVRdStCTTl3?=
 =?utf-8?B?V2RLVTNuOWZsSXFUYWtsQytaclJyNWNGNjdOMURYZytIQnFSSFVHU3cvdDRr?=
 =?utf-8?B?dm5STkpyUTViOXVlNG44dlU0T09KZ2NnakhyTWZhVjhMSnRLR2dRRU9pbzdV?=
 =?utf-8?B?N2JncjlUMmpvaEpuNytpbVJtelFIUStydU1FRzk3R05RT2ZrNlNDUEpOK29Q?=
 =?utf-8?B?NitwTk8yb3crRGUwblRjMC9Td29IN3Bjb2RNR3ovZUc4QndrdUVHa0lKV01h?=
 =?utf-8?Q?cOV82vyyWsKYL6PlMTdgVssG5VsnaEH/jBUoQiGM61xh?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <881CA1DFDB2AF54085E645A2B1AB7D82@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af0c9fc9-dcf2-48b5-5188-08dac71f2338
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Nov 2022 15:36:17.4841
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bgp0rmPr+sQU/BThEoc4fBaD/50eVWy8Grfvcjebo+j8jqMRknc5svjPRCj4JSYnet8pOB/XzUes4N5CAdnH8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4264
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221115_073623_544042_DA7385E4 
X-CRM114-Status: GOOD (  13.86  )
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

T24gMTEvMTUvMjIgMDI6MjMsIENocmlzdG9waCBIZWxsd2lnIHdyb3RlOg0KPiBOYW1pbmcgdGhl
IG52bWUgaGVscGVycyB0aGF0IHdyYXAgdGhlIGJsb2NrIHF1aWVzY2UgZnVudGlvbmFsaXR5DQo+
IHN0YXJ0L3N0b3AgaXMgcmF0aGVyIGNvbmZ1c2luZy4gIFN3aXRjaCB0byB1c2luZyB0aGUgcXVp
ZXNjZSBuYW1pbmcNCj4gb2YgdGhlIGJsb2NrIGxheWVyIGluc3RlYWQuDQo+IA0KPiBTaWduZWQt
b2ZmLWJ5OiBDaHJpc3RvcGggSGVsbHdpZyA8aGNoQGxzdC5kZT4NCj4gLS0tDQo+ICAgZHJpdmVy
cy9udm1lL2hvc3QvYXBwbGUuYyAgfCAxMiArKysrKystLS0tLS0NCj4gICBkcml2ZXJzL252bWUv
aG9zdC9jb3JlLmMgICB8IDI0ICsrKysrKysrKysrKy0tLS0tLS0tLS0tLQ0KPiAgIGRyaXZlcnMv
bnZtZS9ob3N0L2ZjLmMgICAgIHwgMTYgKysrKysrKystLS0tLS0tLQ0KPiAgIGRyaXZlcnMvbnZt
ZS9ob3N0L252bWUuaCAgIHwgIDggKysrKy0tLS0NCj4gICBkcml2ZXJzL252bWUvaG9zdC9wY2ku
YyAgICB8IDE2ICsrKysrKysrLS0tLS0tLS0NCj4gICBkcml2ZXJzL252bWUvaG9zdC9yZG1hLmMg
ICB8IDI2ICsrKysrKysrKysrKystLS0tLS0tLS0tLS0tDQo+ICAgZHJpdmVycy9udm1lL2hvc3Qv
dGNwLmMgICAgfCAyOCArKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0tDQo+ICAgZHJpdmVycy9u
dm1lL3RhcmdldC9sb29wLmMgfCAgNiArKystLS0NCj4gICA4IGZpbGVzIGNoYW5nZWQsIDY4IGlu
c2VydGlvbnMoKyksIDY4IGRlbGV0aW9ucygtKQ0KPiANCg0KSXQgaXMgcmVhbGx5IGNvbmZ1c2lu
ZyB3aGVuIGRlYnVnZ2luZyB0aGUgaXNzdWVzIGZvciBmYWJyaWNzLA0KdGhhbmtzIGEgbG90Lg0K
DQpSZXZpZXdlZC1ieTogQ2hhaXRhbnlhIEt1bGthcm5pIDxrY2hAbnZpZGlhLmNvbT4NCg0KLWNr
DQoNCg==

