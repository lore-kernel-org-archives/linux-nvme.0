Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1631C433EF
	for <linux-nvme@archiver.kernel.org>; Tue, 14 Dec 2021 07:54:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=aWDRL7QpY4BYBFjZgMQ5niPZLw5bOWvXaM6KnpzAShA=; b=owMca4NOsenc1+W9cXOJ0bb0rZ
	HL7a4VMbQXnFPvfK1dXE9DEoWj9asr9hFpyr47RlY8B+/Ius+YCBhygyNma3ORDmfwf3E7EqR+krR
	FjDryb9OcKXKOG04eI6yPIjw0rKf+1c17FCdpe7aW8ttTw0Yt+X3kW8AwjqXOSTGSLLPaEqBy1y/h
	4SWawxCBbobEx+8qEZRUMv8nXw+262dmkqYcmWp7u46XJj15tMLzneH+nKhRXmK0061lpoKPH4sBf
	oefHHVqtReGoEx1HWKn+JV0fVNPSV6e6czY64Y1swfGJpAwXFzSn9D9fGvyLK/5IJzPCxLl32cZMP
	rNA69G6Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mx2dg-00CwNE-S3; Tue, 14 Dec 2021 07:54:20 +0000
Received: from mail-dm6nam11on2088.outbound.protection.outlook.com
 ([40.107.223.88] helo=NAM11-DM6-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mx2dc-00CwM5-M8
 for linux-nvme@lists.infradead.org; Tue, 14 Dec 2021 07:54:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=comk4zlrsXSrhXXBa/WltFWOKriEWF/GjSWlWI5eCKCyd5IIpM2FfIVf8ESqCPQ04i+lLRASVUXW0MIqUMEByFZCGsgUUJYnbwPQAxeZio2n9fwN1mwpmSxFV4PCT+/OAcx9ci4/j83eIhg2Ewvh328ksLrj3Fz8XrLmLbWiYei9DmPSmHH+2lydv9G5+adaXQL0Web0sYUy5d4U4DBOkPX7ysK2dXhWgpjGm78FUZF4uPhsDMvDOCLDy9RIb1qcsPMPqb7WVcI4B5pJhmFsHzQtBiGZNv3Z/fPZx0NIAQIMr+ixVCeulwDS6/KpQ1A4ihNvoYW7PCFvS0CAviSV0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aWDRL7QpY4BYBFjZgMQ5niPZLw5bOWvXaM6KnpzAShA=;
 b=S6Rz5S42VSTvlYFOuQ3alPfFS6uNisttYQywz7Ety4NksmjNU1orLu5wywxO7z0kGH+F5q2926GSdwYy6uvnGol5fwvzSaMBXHc4YYxWYp9Zlnr5NTQSJ/M7Vm0gGz/ssJFaqgFpuIlGxCxiy7eXFltuyjmXpLOLPRYjnf8fGU2u/Oa6Y9nEez0kl5C8/tfNEWXYS0NI4QvbzQsFr3PHevTt0RcOe84g61S/C6iL2f4XSNkxDZ0ZInZqZ1S3Cle0NWs5fkn8BKu/YS8qfyA9mNcdn/aBA7PdB1+K/krNNoOJzhBggNuSksLerlD6C3TCoLc9Sesc6ZboCNu5RrKUJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aWDRL7QpY4BYBFjZgMQ5niPZLw5bOWvXaM6KnpzAShA=;
 b=JgzO947JLIpZvGcoYj3lmgKmZknpopKeJQM5jBUG8Ck9xdYKmsCEXkokgA9Jwr/ZLXvJjERcPN9np1ckJOQ2/moiPmp5FDwJuAxz+WbeE5806URIl0sOhXxFcxsFV3mGrYhm/FYCDiM9z3Iey4CSqVNQa1Bbn++/huYwN5vjdFsrO6iN4Qu1TRu9iPbM3cx2uWXNbG+X/Uk5Xar07CULb0P8OdDpTesjpuY4j09c0HdEcfFpusWv73sp+esjJuZirG3Y/gHTyv24zY6C4TN6xZ1l5LjTgF9n/YYkfDVcKOYKOysaTrhwHc5D1KqfSJJfQRwl6js6r4RNhmBgN5dCZw==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by MWHPR1201MB0016.namprd12.prod.outlook.com (2603:10b6:300:e4::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.17; Tue, 14 Dec
 2021 07:54:13 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::6df1:639d:74ea:d39e]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::6df1:639d:74ea:d39e%7]) with mapi id 15.20.4778.018; Tue, 14 Dec 2021
 07:54:13 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Sagi Grimberg <sagi@grimberg.me>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "hch@lst.de" <hch@lst.de>, "kbusch@kernel.org" <kbusch@kernel.org>
Subject: Re: [PATCH 3/3] nvme: add KConfig options for debug features
Thread-Topic: [PATCH 3/3] nvme: add KConfig options for debug features
Thread-Index: AQHX7bg+0z2vwmZ6tkKVZ870DSJHNawumBKAgAF1qoCAAB4HgIABeF0A
Date: Tue, 14 Dec 2021 07:54:13 +0000
Message-ID: <8dfd8447-426b-21e5-c988-43877fc851dd@nvidia.com>
References: <20211210112116.9299-1-chaitanyak@nvidia.com>
 <20211210112116.9299-4-chaitanyak@nvidia.com>
 <c467d85d-77da-fdff-53e9-938a7bf01763@grimberg.me>
 <492750cf-b031-5709-0836-c28e475c29fd@nvidia.com>
 <6a1d326e-ce96-ef9e-f09d-7ebdc9ef6084@grimberg.me>
In-Reply-To: <6a1d326e-ce96-ef9e-f09d-7ebdc9ef6084@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3ec560ac-9284-48bb-d30a-08d9bed6eb71
x-ms-traffictypediagnostic: MWHPR1201MB0016:EE_
x-microsoft-antispam-prvs: <MWHPR1201MB0016B5938AF3F2559F9BB8EBA3759@MWHPR1201MB0016.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4303;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uKTnojFpWeKvKcQgBJpdphweTiCxBmafZBLE9vF/oFcX4/1FBTQiocU7mP20/BpmnQSpvouC/j/6gd1gF+DUca7nBAJsIOalnJi1PxDr3Z90DoM2KTOsMb6kMt+g5Tlb2wMGu6hS3835QI6SrKIcEZZCbvEpEAXZYLO17ba2a3prrf2iO7wVaFJU6UbTDJg+kxL65huaCxZ/FN49nGtl3w/tJhWxhCPdhZMBz7u+FNul0KvL2MjO5tpZ4Q35OvkdFFZOk5/V880AFTcbkoncXXOWXZ3eNOamoQtU6teZQQsTRJ42oL/jwhSS1d26R47rVtsxlfdWB7nWGKDKfSWNc1D+at9rrGH+YGKZaqmboERTuJKgPMRq7J1CspLfkIrA836hHk/9aT8GuxGetFWf9acf9pIBWUxqlXfq2KJrO5M+WnH1cpCr6o+ohvCIy/w+LcPjO5nLha0N2NavHW5NiOYRaSiUEM40bE8wqRhKzKrrfj7sbE5vvpQyZSKiKKT/Xs32WUA8PNd1xMdkT23sZUfg1AhKkV8m2C9PQRc8P/SolPyX0NdvUyJ2Uq9R3NX4N0Bs81z+f0kMppXpnSme7GCLCZcS30l6aWx6RoEqkywRKE1o37lZDpw9PqfqZxC8k2NOu1a7NzI0XqzTZo/k1IWI7py+RgX+4FfPxPmBk2mGWT1O1T70VLeIyn0TiGtaN01JeAfBZ5gNYDVpY+zdpN9cL47uDTq+1WXrqnb5ueOL92r79zKLGmwomHNU7yNsyQCVtPZ/DcDCDcNp+jZzGQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW2PR12MB4667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(38070700005)(508600001)(6486002)(8936002)(76116006)(38100700002)(66946007)(83380400001)(8676002)(91956017)(66476007)(186003)(122000001)(36756003)(66556008)(66446008)(64756008)(4326008)(86362001)(71200400001)(31686004)(2616005)(6512007)(5660300002)(31696002)(316002)(54906003)(6506007)(53546011)(6916009)(2906002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?V0NSL1N1aFJ0Smw0V2VHbWVtYm1TRk1ZTmNVTDkzTzU3Njd3ZEU1S0FWblNz?=
 =?utf-8?B?VC9EWk01K2l3Q01wY0ZMNmxvcXdEOTJoaHlQZ3lES2N0bGtpd0t6LzVkTXhu?=
 =?utf-8?B?ZzhnenovZndFMHBLSytUNUdOYVlqKzlHM2ZHeG0wOWtyL2ZEQ3dlbHJBZ2sy?=
 =?utf-8?B?Z1F3SlpPOTdoMWN3MTA5S2FnOWcycHZoYTI2Yi9hd3F0b1dIWVVWcEZiejB4?=
 =?utf-8?B?amNMZmFiVWpuaE91czZpZ3hGNC8rSGVTU2ZUSUxLVWI0V2dUY0dJWnVOVkxy?=
 =?utf-8?B?VlRrMkZCVFgyMUs4R1h4cmdoWU5kdVNubmUxTWs0dTZJdWt2akRhZUlrTWdt?=
 =?utf-8?B?OUdMcmRQdDFJRSsrWk56OFI2dWZxMXA0YXNmbkt6V3pZd3YxV2pXKzd4STNz?=
 =?utf-8?B?ZVZSKzU0NkJ6Z3FkdkdGNlhpMlZNY0VGM1c1Z1V3RmNxOGF1ZGEyZDlMZ040?=
 =?utf-8?B?Y2R0T0c2a0taOHZuTm5KcEk4TmVLdU16dFcvVmZBOUhQQTdyeUVHYTNmVmlm?=
 =?utf-8?B?bDh3SGw0MEw5T01qblo5ZFNwZ3ZDWnBxbEFYMG8wU0RxdUZHdnMzZ1NOSUdy?=
 =?utf-8?B?ZndxbkI0NkhGOFRtS0lDUVBCaWloblJxenRrd29xdzZvZnZqZGhtSW84U3Fa?=
 =?utf-8?B?cnRKQW80T05HczhZTjhVdldXTjhGcnRCejFFVDBBYTl2SHJ2aVZRazlWNEY2?=
 =?utf-8?B?N1p0RUhJNFhXallCajAwVVVrWmVDVU9UcjJnQ0lRU2FmWk5naW9BQlFsSis1?=
 =?utf-8?B?ckFWL2ZIbWlDQ1c3cHhZL0tQRlJ1MjM4Q1h3ejdwSHZ0NnZaWFMrbWtURWJJ?=
 =?utf-8?B?TjhhQmlYM2NYdGRZSm9lZFNYaFlhNFhPRzY2VkNMS1NjNVdCYndnUVlsdHA2?=
 =?utf-8?B?U0crdEh6ais1MmF0SW5mYmc5eC9nTTJ6Yko1WWczK2RIb1pSK3dsSDNPdnU0?=
 =?utf-8?B?SzVaZ2cwOE9ud1ZxNTJHS0Q1d3poN0IxNzk3ME5jeUJpY3lhZ2VBOG82aVpz?=
 =?utf-8?B?ZXBjM1czRjdiUzB4TDE3Y245b29abHhJc3VqTzFVRk95Qm1QZGYwbVFjWXhw?=
 =?utf-8?B?aUphUWx1aUhwejl4WDl3eWNTVlVqcEpsemFGSTlPcSs4UnVnZkp1dFNyRlFn?=
 =?utf-8?B?bVNGYzNGRlNqbmRMZzlhaHN0VEZGWkkybDEvSHBIWlNFTWFYb3dobHg3U1Nw?=
 =?utf-8?B?ZmZmRWlDR1pFZ2M3SzY2VHBTcHQ2ZElNdUIwUXNUTm1CNUsyYUZuS3dhTDlx?=
 =?utf-8?B?NGhjWlFHV2EwcjY0ZUdGTG92K211bDZkSTVFMDNIZlVTbWxVSFdUOWpIS3JY?=
 =?utf-8?B?UmxMSEJjYjQ4UXJvVmNuOENadEhRaWg3MDRIRFN1VzZJM1Vxc01BbS9aUEsy?=
 =?utf-8?B?VUl4WGFFOUlNS0crWGtKZkVSaVRzRHJyOVhzNE5DazlNQlU1c0JNOGdMTFE2?=
 =?utf-8?B?TlFleGRlYWYvdEZ0bldBV2dmNlpZNzA4aTVMZ3VzelgwODhmeVEvS1ZNMko3?=
 =?utf-8?B?SDZFY0tpY2RVUDBRSlh5M3BkdnJWNlg2cDdDbG9GbzVkOWZZU2RRQ3BVTUh4?=
 =?utf-8?B?dVdDdVFmUW1YdEhrNlBoSGY3MjQ0bCt5U2xzbDdKMzhsRWZMbXZVZk5OQytM?=
 =?utf-8?B?SWdsMytSQUpwMlpvODY1ajd6ZXBVVVkrelhTTUlHeDRHdDg2TVRMWklsbEtk?=
 =?utf-8?B?aW1aVGlCMnpGRk5CKzMxZGQwVEpSMEFaUFlkMm8wNHFveHJXeStxdEY3cldR?=
 =?utf-8?B?cGdtSHBXM1V4UlJrYWFUR0RQUUJHZUI3V0hJTGl0eXNaRzJEYVBwbWtDTi90?=
 =?utf-8?B?U2pCazE0WDhoaEVnYU9kWWZTem1oYzhUaFVCS0trbXpFalBJY3JSa2o1YWhr?=
 =?utf-8?B?OE5tOUJBRVJPSURSZVZ5ZHV0c0FVRGNQbXI4MXNGQS9TclhKY3FMSS9DUEo4?=
 =?utf-8?B?dmMvcXUwSFVVWE1WQ2NPQVJ6cnpRU0x0OHA2WDRBRzRtdzczajdrTHlBa1VO?=
 =?utf-8?B?V2lINHZBL0RPK1BxY3B1SkVHTnA0M2ZiRklBZHUxL1V2R0tjTU1SUUx6Nk9k?=
 =?utf-8?B?VXk2UEI5RENMUVhGeFRFQlFPMnNYMFdDKy92QjRPU3VXQncyRVkxNFFkczFr?=
 =?utf-8?B?bnhZZTJzOG1ERm5hVXNWdzQwOU1EWXFZeXp1VnAzd2l5NkpEbzMveXZJSTNl?=
 =?utf-8?Q?Dp2O3imvZ8m3Frgq5rSihKFJTB3dnC36YNpQeSKL7KNe?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E75CBD68138F824B9EE74CF0E23E398A@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ec560ac-9284-48bb-d30a-08d9bed6eb71
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Dec 2021 07:54:13.1490 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7YY2Qkuf2azZ7ZrVBeBzpalgdid4cRYCmFGSaYbroZHY9lXFvbPOPQmJRZG+NGa85eYlB/f6kQ6yk6mranhcAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0016
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211213_235416_803418_9478758B 
X-CRM114-Status: GOOD (  36.36  )
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

T24gMTIvMTMvMjEgMToyNyBBTSwgU2FnaSBHcmltYmVyZyB3cm90ZToNCj4gRXh0ZXJuYWwgZW1h
aWw6IFVzZSBjYXV0aW9uIG9wZW5pbmcgbGlua3Mgb3IgYXR0YWNobWVudHMNCj4gDQo+IA0KPj4+
PiBBZGQgS0NvbmZpZyBtZW51IG9wdGlvbiB0byBlbmFibGUgYW5kIGRpc2FibGUgZ2VuY291bnRl
ciBkZWJ1Zw0KPj4+PiBmZWF0dXJlIHRoYXQgdXNlcyBjb25maWcgTlZNRV9ERUJVR19VU0VfQ0lE
X0dFTkNUUi4NCj4+Pj4NCj4+Pj4gU2lnbmVkLW9mZi1ieTogQ2hhaXRhbnlhIEt1bGthcm5pIDxr
Y2hAbnZpZGlhLmNvbT4NCj4+Pj4gLS0tDQo+Pj4+IMKgwqAgZHJpdmVycy9udm1lL2hvc3QvS2Nv
bmZpZyB8IDEwICsrKysrKysrKysNCj4+Pj4gwqDCoCAxIGZpbGUgY2hhbmdlZCwgMTAgaW5zZXJ0
aW9ucygrKQ0KPj4+Pg0KPj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9udm1lL2hvc3QvS2NvbmZp
ZyBiL2RyaXZlcnMvbnZtZS9ob3N0L0tjb25maWcNCj4+Pj4gaW5kZXggZGMwNDUwY2EyM2EzLi5k
ZmEyNjA5YjcwMDYgMTAwNjQ0DQo+Pj4+IC0tLSBhL2RyaXZlcnMvbnZtZS9ob3N0L0tjb25maWcN
Cj4+Pj4gKysrIGIvZHJpdmVycy9udm1lL2hvc3QvS2NvbmZpZw0KPj4+PiBAQCAtMSw0ICsxLDE0
IEBADQo+Pj4+IMKgwqAgIyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMC1vbmx5DQo+
Pj4+ICttZW51ICJEZWJ1ZyAoRW5hYmxlIGRyaXZlciBkZWJ1ZyBmZWF0dXJlcykiDQo+Pj4+ICtj
b25maWcgTlZNRV9ERUJVR19VU0VfQ0lEX0dFTkNUUg0KPj4+PiArwqDCoMKgwqAgYm9vbCAiRW5h
YmxlIGNvbW1hbmQgSUQgZ2VuIGNvdW50ZXIgZm9yIHNwdXJpb3VzIHJlcXVlc3QNCj4+Pj4gY29t
cGxldGlvbiINCj4+Pj4gK8KgwqDCoMKgIGRlcGVuZHMgb24gTlZNRV9DT1JFDQo+Pj4+ICvCoMKg
wqDCoCBoZWxwDQo+Pj4+ICvCoMKgwqDCoMKgwqAgVGhlIE5WTSBFeHByZXNzIGRyaXZlciB3aWxs
IHVzZSBnZW5lcmF0aW9uIGNvdW50ZXINCj4+Pj4gK8KgwqDCoMKgwqDCoCB3aGVuIGNhbGN1bGF0
aW5nIHRoZSBjb21tYW5kIGlkLiBUaGlzIGlzIG5lZWRlZCB0byBkZWJ1ZyB0aGUNCj4+Pj4gK8Kg
wqDCoMKgwqDCoCBzcHVyaW91cyByZXF1ZXN0IGNvbXBsZXRpb25zIGNvbWluZyBmcm9tIGEgYnVn
Z3kgY29udHJvbGxlci4NCj4+Pg0KPj4+IFRoaXMgaXMgbm90IGp1c3QgdG8gZGVidWcgLSBpdCBp
cyBhbHNvIHRvIHByb3RlY3QgYWdhaW5zdCBzdWNoIGENCj4+PiBjb250cm9sbGVyLiBXaGF0IGlz
IHRoZSBwdXJwb3NlIG9mIHRoaXMgY29uZmlnIG9wdGlvbiBhbnl3YXlzPw0KPj4+IFRoZSBtYWlu
IGRpc3RyaWJ1dGlvbnMgd2lsbCAoYXMgdGhleSBzaG91bGQpIGVuYWJsZSBpdCBhbnl3YXlzLi4u
DQo+Pg0KPj4gSSBjYW4gcmV3cml0ZSB0aGUgdGV4dCBhbmQgcmVuYW1lIGl0IHRvICJkcml2ZXIg
ZmVhdHVyZXMiLg0KPiANCj4gSXQgaXMgbm90IGEgZmVhdHVyZS4NCg0KdGhhdCBpcyB3aGF0IEkg
dGhvdWdodCwgaGVuY2UgSSBrZXB0IGl0IHVuZGVyIGRlYnVnLg0KDQo+IA0KPj4gV2UgYXJlIHBy
b3RlY3RpbmcgYWdhaW5zdCBzdWNoIGEgY29udHJvbGxlciB3aGljaCBpcyBub3Qgc3RhYmxlDQo+
PiAoYnVnZ3kpLCBpLmUuIGl0IGlzIGRvaW5nIHRoaW5ncyB3aGljaCBpdCBzaG91bGRuJ3QgYmUN
Cj4+IGRvaW5nIGF0IHRoZSBmaXJzdCBwbGFjZS4NCj4gDQo+IFllcywgdGhpcyBpcyBleGFjdGx5
IHdoYXQgd2UgYXJlIGRvaW5nLg0KPiANCj4+IENvbnNpZGVyIGEgY2FzZSBpZiBjb250cm9sbGVy
IGlzIG5vdA0KPj4gYnVnZ3kgdGhlbiBpdCBhZGRzIGluc3RydWN0aW9ucyBpbiB0aGUgZmFzdCBw
YXRoIHdoaWNoIGFyZSBub3QNCj4+IG5lZWRlZCBhdCBhbGwuDQo+IA0KPiBXZSBrZWVwIHJlcGVh
dGluZyB0aGlzLCBpZiB0aGUgY29udHJvbGxlciBhc3N1bWVzIF9hbnl0aGluZ18gb24NCj4gdGhl
IGNvbW1hbmQgaWRlbnRpZmllciB0aGVuIGl0IF9pc18gYnVnZ3ksIHBlcmlvZC4NCj4gDQoNCkNv
bXBsZXRlbHkgYWdyZWUgb24gdGhpcy4NCg0KV2hhdCBJIG1lYW4gYnVnZ3kgaW4gdGhpcyBjb250
ZXh0IGlzIG5vdCByZWxhdGVkIHRvIGFzc3VtaW5nIGFueXRoaW5nDQp3aXRoIGNvbW1hbmQgaWRl
bnRpZmllciBwb3B1bGF0aW9uLCBpdCBtZWFudCBjb250cm9sbGVyIHRoYXQgaXMNCmNhdXNpbmcg
c3B1cmlvdXMgY29tcGxldGlvbnMgLT4gYnVnZ3kuIFRoZSBjb250cm9sbGVyIHRoYXQgaXMgbm90
DQphYmxlIHRvIHByb2Nlc3Mgbm9uLXNlcSBjb21tYW5kIGlkcyBhbmQgYXNzdW1lcyBhbnl0aGlu
ZyBpcyBvdXQgb2YNCnBpY3R1cmUgZm9yIHRoaXMgcGF0Y2gtc2VyaWVzIChmb3IgdGhhdCBudm1l
LWNsaSBza2lwIGFwcHJvYWNoIGlzDQpmaW5lKSwgc2VlIGJlbG93Lg0KDQo+IEFnYWluLCB0aGUg
ZmFjdCB0aGF0IHRoZSBjb250cm9sbGVyIGlzIGJ1Z2d5IGlzIHBlcmZlY3RseSBmaW5lDQo+IHJl
YWxseSwgdGhhdCdzIHdoeSB3ZSBoYXZlIHF1aXJrcy4NCj4gDQoNCkEgY29udHJvbGxlciB3aGlj
aCBpcyBzdWZmZXJpbmcgZnJvbSBzcHVyaW91cyBjb21wbGV0aW9ucyBuZWVkcw0KZ2VuY291bnRl
ciB0byBkZWJ1ZyB0aGUgaXNzdWUsIHVzaW5nIHF1aXJrIGFuZCBtYXNraW5nIGdlbmNvdW50ZXIN
CnNob3VsZCBiZSBhdm9pZGVkIGluIHRoaXMgY2FzZS4NCg0KPiBXaGF0IGhhcHBlbmVkIHRvIHlv
dXIgbnZtZS1jbGkgYXJndW1lbnQ/IHRoYXQgd291bGQgbWFrZSBpdA0KPiBzcGVjaWZpYyB0byB0
aGF0IGNvbnRyb2xsZXIuDQo+IA0KDQpUaGF0IGlzIGNvbXBsZXRlbHkgZGlmZmVyZW50IGlzc3Vl
LCB0aGUgbnZtZS1jbGkgYXJndW1lbnQgdHJpZXMNCnRvIGZpeCB0aGUgaXNzdWUgd2l0aCBhIGNv
bnRyb2xsZXIgdGhhdCBmYWlscyB0byBwcm9jZXNzDQpub24tc2VxdW50aWFsIGNvbW1hbmQtaWQg
c3VjaCBhcyBBcHBsZSBjdHJsIGFuZCBuZWVkcyBxdWlyay4NCg0KVGhpcyBwYXRoLXNlcmllcyBo
YXMgbm90aGluZyB0byBkbyB3aXRoIHRoYXQgaXNzdWUuDQpUaGlzIHBhdGNoLXNlcmllcyBpcyBv
bmx5IGZvY3VzZWQgb24ga2VlcGluZyB0aGUgZmFzdCBwYXRoIGxlYW4NCmFuZCBhbGxvd2luZyB1
c2VyKHMpIHRvIGNvbmZpZ3VyZSBnZW5jb3VudGVyIGluIHRoZSBlbnZpcm9ubWVudA0Kd2hlcmUg
Oi0NCg0KMS4gQ29udHJvbGxlciBpcyBzdGFibGUuDQoyLiBBYmxlIHRvIHByb2Nlc3MgdGhlIG5v
bi1zZXF1ZW50aWFsIGNvbW1hbmQgaWRzDQogICAgKGhlbmNlIG5vIHF1aXJrIG5lZWRlZCkgYW5k
IGRvZXMgbm90IGFzc3VtZSBhbnl0aGluZyBhYm91dCB0aGUNCiAgICBjb21tYW5kIGlkIHBvcHVs
YXRpb24gdW5saWtlIEFwcGxlIGNvbnRyb2xsZXIuDQozLiBEb2VzIG5vdCBzdWZmZXIgZnJvbSBz
cHVyaW91cyBjb21wbGV0aW9uIHByb2JsZW0uDQoNCkZvciB0aGlzIGNvbnRyb2xsZXIsIHVzZXIg
Y2FuIGRpc2FibGUgZ2VuY291bnRlciBhbmQga2VlcCB0aGUgZmFzdA0KcGF0aCBsZWFuLg0KDQo+
IFRoZSBob3N0IHNpZGUgY29zdCBpcyB2ZXJ5IGNoZWFwIGFzIHNob3duIGJlZm9yZS4NCj4gDQo+
PiBBIGNvbnRyb2xsZXIocykgdGhhdCBpcyB1c2VkIGluIHRoZSBwcm9kdWN0aW9uIGVudmlyb25t
ZW50IGdvZXMNCj4+IHRocm91Z2ggcXVhbGlmaWNhdGlvbiBwcm9jZXNzIGZyb20gdmVuZG9ycyBh
bmQgZnJvbSB0aGUgY29uc3VtZXJzDQo+PiB0byBtYWtlIHN1cmUgdGhleSBhcmUgc3RhYmxlLCBz
b21ldGhpbmcgbGlrZSBzcHVyaW91cyBjb21wbGV0aW9ucw0KPj4gZGV0ZWN0aW9uIGlzIGEgYmFz
aWMgcGFydCBvZiB0aGUgcXVhbGlmaWNhdGlvbiwNCj4gDQo+IEkgZG9uJ3QgdGhpbmsgdGhhdCBh
c3N1bWluZyB0aGF0IGEgcHJvZHVjdGlvbiBjb250cm9sbGVyIGRvZXMgbm90DQo+IGhhdmUgYW55
IGhpZGRlbiBidWdzIGlzIGEgZ3JlYXQgcHJhY3RpY2UsIGFuZCBjb250cm9sbGVycyBldm9sdmUg
ZHVyaW5nDQo+IHRoZWlyIHByb2R1Y3Rpb24gbGlmZXRpbWUuDQo+IA0KDQpUaGF0IGlzIHdoeSB3
ZSBzaG91bGQga2VlcCBpdCBjb25maWd1cmFibGUgYW5kIGxldCB1c2VyIGRlY2lkZS4NCg0KPj4g
aGVuY2Ugd2Ugc2hvdWxkDQo+PiBhbGxvdyB1c2VyIHRvIGNvbmZpZ3VyZSBnZW5jdHIgdGhhbiBm
b3JjaW5nIGFkZGl0aW9uYWwNCj4+IGluc3RydWN0aW9ucyBpbiB0aGUgZmFzdCBwYXRoIGFuZCBr
ZWVwIHRoaXMgcGF0dGVybiBmb3IgZnV0dXJlDQo+PiBzdWNoIGNhc2VzLg0KPiANCj4gSSBwZXJz
b25hbGx5IHRoaW5rIHRoYXQgZ2l2ZW4gdGhhdCB0aGUgd29yc3QtY2FzZSBvcHRpb24gZm9yIHN1
Y2gNCj4gYSBidWcgaXMgcG9zc2libGUgZGF0YS1jb3JydXB0aW9uIHRoZW4gd2Ugc2hvdWxkIG5v
dCBtYWtlIGl0IG9wdGlvbmFsLA0KPiBidXQgSSB3b24ndCBpbnNpc3Qgb24gaXQgaWYgb3RoZXJz
IHRoaW5rIG90aGVyd2lzZS4NCj4gDQoNCkV2ZW4gaWYgd2Uga2VlcCB0aGUgZ2VuY291dGVyIG9u
IHVuY29uZGl0aW9uYWxseSBvbmNlIHNwdXJpb3VzDQpjb21wbGV0aW9uIGlzIHBvc3RlZCwgY29u
dHJvbGxlciBpcyBhbHJlYWR5IGluIHRoZSBpbmNvbnNpc3RlbnQNCnN0YXRlLCB0aGVyZSBpcyBu
byBndWFyYW50ZWUgdGhhdCBkYXRhIHdpbGwgYmUgY29uc2lzdGVudC4gSW4NCmZhY3Qgd2hhdCB3
ZSBuZWVkIGlzIHNvbWUgd2F5IG9mIHNpZ25hbGluZyB1ZXZlbnQgb24gc3B1cmlvdXMNCmNvbXBs
ZXRpb24gc28gdGhhdCB1c2Vyc3BhY2UgY2FuIGdldCBub3RpZmljYXRpb24gb24gdGhlIHRvcA0K
b2YgeW91ciB3b3JrIHdpdGggZ2VuY291bnRlci4NCg0KPj4gTWF5YmUgSSBkaWRuJ3QgdW5kZXJz
dGFuZCwgY2FuIHlvdSBwbGVhc2UgZXhwbGFpbiB3aGF0IGFyZSB0aGUNCj4+IGJlbmVmaXRzIG9m
IGhhdmluZyBnZW4tY291bnRlciB3aGVyZSBjb250cm9sbGVyIGlzIHN0YWJsZT8NCj4gDQo+IFRo
ZSBiZW5lZml0IGlzIHRoYXQgdGhlIGhvc3QgY29kZSBkb2VzIG5vdCAiYXNzdW1lIiBhbnl0aGlu
Zw0KPiBhYm91dCB0aGUgY29udHJvbGxlci4NCj4gDQo+PiBJJ2xsIHdhaXQgdG8gc2VuZCBWMiBp
ZiB5b3UgY2FuIHN1Z2dlc3QgYW55IG90aGVyIHdheQ0KPj4gKHRoYW4ga2NvbmZpZyBzb21ldGhp
bmcgbGlrZSBtb2R1bGUgcGFyYW0sIEknbSBub3Qgc3VyZSkgc28gdXNlcg0KPj4gY2FuIGNvbmZp
Z3VyZSBnZW5jdHIgY2FsY3VsYXRpb25zLCBwbGVhc2UgbGV0IG1lIGtub3cuDQo+IA0KPiBBcyBJ
IHNhaWQsIHRoZSBudm1lLWNsaSBza2lwLWdlbmN0ciBhcmd1bWVudCBpcyBwZXJmZWN0bHkgdmFs
aWQgaW4gbXkNCj4gbWluZC4NCg0KVGhhdCBpcyBmb3IgdGhlIGJyb2tlbiBjb250cm9sbGVycyB3
aGljaCBhcmUgbm90IGFibGUgdG8gcHJvY2Vzcw0Kbm9uLXNlcSBjb21tYW5kIGlkIGdlbmVyYXRp
b24gbGlrZSBBcHBsZSwgdGhpcyBwYXRjaCBpcyBub3QgZm9yIHRoYXQuDQoNCg==

