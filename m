Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2124CC4332F
	for <linux-nvme@archiver.kernel.org>; Fri, 11 Nov 2022 01:38:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=aF/EptEn9Fe31H1WtyCEfupVZNLcYCJBU1U6x9H5NmU=; b=0UV75NtMWsqSYeik8f+DVvKTtE
	gwudXuD488Da/o4P8JZGCREP7KkOAcjrz+VzVhzG0owFSVVa9wCOjayzc5kfbd0bfmu76UaVEIJJz
	GEphwrKADFBOzaQxjhhChfUE6BN01jzwtaS568qRdK0zy5fbdf/nhtMMYLI/RtwvAPMR6oAdrHSDJ
	/Z7TTIBPLPqzJK+xIE9G14/I4lrwBbM7or8e66HeJPlGmfTjP2VBpnpIP6CcVB0II+IaUFaT9R0gg
	AQQi0Mv0sae1qAeYLmDRfifPu5oszifn0353EoTkkA8GTSwiayn83HiQXMIORfCKH1WLF39nzxzB4
	BH2vR4WQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1otIzb-00BoZ4-J1; Fri, 11 Nov 2022 01:38:03 +0000
Received: from mail-dm6nam12on2064.outbound.protection.outlook.com ([40.107.243.64] helo=NAM12-DM6-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1otIzY-00BoTJ-Fn
	for linux-nvme@lists.infradead.org; Fri, 11 Nov 2022 01:38:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oXcCNLKWqPMpJi7XiSa3BfCMoH9EAFamnA3IH6qt6xrtqTxBhoP21U5YLG13uRntVVrdwzv8MMsaFkvIQ9m4pleZqMOEIZtCxjwvKMs7KSlCfd5wAC1MHLj/Qp92CrMWLoZmOTwOd8tafeQa19uDNTDrkyAWz5Ptv1cUz9hmjYZk1GEUE56NUeod59/RQuRGqQj8v/nl1VW4ohx5YKhqiH5QxbM7yZYCyK3LQ74Lat2mG8u7lmsC/axQBUpu7C/c11Wn+lf2XufA9jEJYdXrJPzSjjbNbv+bTCREAtD5CJiixeCU8cwCtczy+NB8CPefJr2DsYT3JYcFtijbfB4iPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aF/EptEn9Fe31H1WtyCEfupVZNLcYCJBU1U6x9H5NmU=;
 b=DNSl4pQ2z9dqh8AGWcjEJyzAKPwzu2D8cfpBZTiWQGvYdrmQq8swnHavsrllU4D4A1Uky2pRAZ8zVkrEufSoy0FMqVEd5jUgy0qLkUyjptKp0ZkErELQNUFGcnGW7Xac1S2Ied5+XOI651+Pah8CRrlPsrcQNYE8O5yr6YsUD3bNEX4nlYcjkIh0VJzoAm193b8bjrnfmJLyq547nQU41xIskkVx/WV712sYAp6Jls0w6N+uOitl+WJ2vKdPC1dMJK7wBWwfvK4JIvIP0tV1aVS5FBVflz6GHcNO889BnPsRiDmm5O37jlzNlsAMnBZrtI30yqz6m/f/WMjItvZpIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aF/EptEn9Fe31H1WtyCEfupVZNLcYCJBU1U6x9H5NmU=;
 b=gm7KYmemNCmLFvu+gqCAdFjjl+7u1gMzGZ7dK7vKs3WXDBBd568M2LyHGL5MnRJsW3Py2H+Br5HCLHyYRaXpiomIMRsCXFErJcO7qoTGDJ6HVzi+h/H92BTl06/3LGQaW1+AXh5Shbsuf35WqAz/SeF4V2qHg4Ca1/EdUvdmFsA1kIdfT+FskmoWYQP/Dr7KQycysxOt+xnre64qsjp3CBreOahM6Oy60QM48xecTAau/kc03J5wo4yoCGLxKHCPFCJjgH2YiuV9EgnAhkamzWJlx5S5rg/fd0+y796v3dCbZN+8YQp8KImfeSHAh61JXz4lMZn0ivLPHr7vF9dgtg==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by MW4PR12MB5628.namprd12.prod.outlook.com (2603:10b6:303:185::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.26; Fri, 11 Nov
 2022 01:37:55 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::eaf1:9be8:d472:ea57]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::eaf1:9be8:d472:ea57%7]) with mapi id 15.20.5813.013; Fri, 11 Nov 2022
 01:37:55 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: "linan (AK)" <linan122@huawei.com>, "kbusch@fb.com" <kbusch@fb.com>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"yi.zhang@huawei.com" <yi.zhang@huawei.com>, "chengzhihao1@huawei.com"
	<chengzhihao1@huawei.com>
Subject: Re: question about CVE-2022-3169
Thread-Topic: question about CVE-2022-3169
Thread-Index: AQHY9O6rZANph6fMUUyz+P0iRAHcqq448pIA
Date: Fri, 11 Nov 2022 01:37:55 +0000
Message-ID: <b583ecf6-950f-b681-054d-3a4ebaee7e73@nvidia.com>
References: <144969fe-3764-d5eb-587a-79c4fd195076@huawei.com>
In-Reply-To: <144969fe-3764-d5eb-587a-79c4fd195076@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|MW4PR12MB5628:EE_
x-ms-office365-filtering-correlation-id: 5fe1d5ec-14f1-4b1c-2d69-08dac3855b4b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  nn8Qr+GZ2XUzyFdxIEb7b99+8b9quBYwBSm9bFegqw+ASwKgwzW5kJm90X1Z0pdCsQJWMgPZJ5WzDp+d3QBv//cbRu26il57TGu2ACAIGdEdDbw0W2CN+3iws574cNuB5H2isb7VBMKQWa8wOVYMIgPWmuz4RaFg8P2ll+me+g9OOAlGNZ5XB2vUdBEIp8enVYX2kJShObM2YolNAaOrXMOu+zhuCj4sEaalkLU1Wwm3rrNELGkCJtbkLg4ZwHwWtegUp0yz2b9+JPq9EAY1nTYvEKkwYXKkOdcKjcT37c+GfySA+vOG+XGrjNUOWCYWUoyWh3EvGYENtrT7jrCBofLEO55JoGICj0kFkF/ZFf3lBIH2RxcDcHgBXryJUnPBCIcBYg9HEshyryBsFfovOLXuCcEP1tXWzeYUFtGIe1Bi9mvLRW6e/BqrP1njIgI6OgvLF5lb/fn1UWv8S7klSNTSZoClk/5DzDyrFLbrPg3cTY9CBlHDLs7BKUdGWoEW8fu1Zsp6lrXVjs2MCLBVieDDonoQXvfO6Qz8zpzRW0N7l8AZEhEAHkMLaKPKH9D7ip6AueLGMHQvj8ss/0ySeXdDemNw/dxzHFPltz0wGez5XluRa36+nmt7htH2TNVJlepSsDrW6QxYeoD4HwzRZXMHAQ+jlgbg836mJsJRlUFXN1n55PSBgvvC5i5Y5MPZVHeceg5s968d1ogKKzFnnbOJyH747aljnsS5YGOcswcxjxhzeJX6R7fdUkL/KzgL4a5UbKOin6f1RyljEQUj7ZLsNX7MXu+qkdoTUwgr9zLXcAVBwCa1FuBQJ+CzjnAb+dH9RIIo+Ajk09uDZ8DdOQ==
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(346002)(376002)(366004)(39860400002)(136003)(451199015)(2616005)(83380400001)(38100700002)(53546011)(186003)(2906002)(6512007)(122000001)(5660300002)(26005)(4744005)(6506007)(8936002)(64756008)(71200400001)(41300700001)(6486002)(316002)(8676002)(478600001)(66446008)(66476007)(66556008)(54906003)(4326008)(91956017)(110136005)(66946007)(76116006)(36756003)(86362001)(38070700005)(31696002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?utf-8?B?aWNDaWpPZWdvZ2U5VHpZRjVtYVo3c1hqQTRFU0ZZSXpmQjdLOHEzTkZENVNz?=
 =?utf-8?B?VnVFTkNxUHYrV2gvQXlKckNhZndWMWpJQkl6bnJTcGRaUVNSb0VMVEFLdkN3?=
 =?utf-8?B?dmJWYUxUVTRlZUUxakt4TlBMbXdnaVA5d01hL0FaNTZ0VlJtR25DWUVVU2ZC?=
 =?utf-8?B?NmZ6czBoYllIK25GZ3QvdnFDWmkzcnBpQkJ0eHpSSmxaSFdRTVZ5UjJYWXYr?=
 =?utf-8?B?ZG9CalhJU2NRdk9EMk9CdFBvem9oQVFXdmx5cWdJUC9CL0kwSkdtNDZxTWxQ?=
 =?utf-8?B?ZDBUL09TTTkxRkw0VzBPOXY1YS9rVGthTkNwaFJJTlhwRDYweEIyUFFUdmp4?=
 =?utf-8?B?MTZTT3NmR2lQMDVWMkZrRUNLMkNnYVpsVWR5MUVaRU1ieGNhZkdKUzg3YUlj?=
 =?utf-8?B?QnlJcU1MSE1Xejloa2h5N2RDWWZGSXh4Uk96eU0yWFdVNFVqVG5jdW9oU1Rp?=
 =?utf-8?B?UERWNi9TZUg1TWZiR0YxWEVRejBCWUtvSEljSHF5a01kMEFlb01SZS9NdTBi?=
 =?utf-8?B?UUx5S0N6OWNLU0RqT1F4RGhCTW1weFZRWEFJSzJWS2g3aFRmbXZUazdOUVhu?=
 =?utf-8?B?c0FjTW5PM3Q1dGJoWi9Ha2JmLzJXRHN6N3lBVDI3Tk94QU5VdVQ1TEFid1Jo?=
 =?utf-8?B?UllGQ2ZIMGRiei9YdGZTL0x3Y21LNDNmVEtTRlFhbjNaUDgrQXJUK0V3ZGZ5?=
 =?utf-8?B?c2NTT2UxemxudWRhWlM1bDdsYVZpZ083a2V0ditnciswbGdjVkdoT3pGNUhh?=
 =?utf-8?B?cmVrdEpTTnBRY05qN0dBTlkydVFMNTYwVnl5dVg4Mi95Nm5lTm53d1UxeW45?=
 =?utf-8?B?dlZCRVJlNkQ2SDhTZHJXTEJEREwzZStSdWF0Uy92eVExT1hRbWw0UisyN01U?=
 =?utf-8?B?dmVEUis0S00yczdBeFRGZWJnSHJ0WmlwaDB1bFZaRk5wUVlyRTBxK2FqSWQw?=
 =?utf-8?B?ZElpbVBtRXo2emtaWkU5NGhVQUs2UHRFN2lDOXVpekFMWjk3MFlXYUtGNUls?=
 =?utf-8?B?dFRDb25KOU4zNHJoNDczbHY3OERKZHk5TThMaldCcVczQm0zTFI3VnVsNkNS?=
 =?utf-8?B?QVFvQnMzK3dveG1XU3RDc1lJYjVDUEdQcW15R1k4MklQbTJzS2lRbEdJZU1G?=
 =?utf-8?B?N2cyQkdBaWx6SXloQlZKVm5KNkFwc3UvWG5hWjFWMzJsY1dZZjZpTm8wakx6?=
 =?utf-8?B?TTFrYytCM2JKK3QwMW5TU0ZPOWwwTUJmMldVQ3N2ZFp0U3VkRkRDZ21XTHha?=
 =?utf-8?B?RGlFOHdpanpSOXl5Tm1vdVlqWlluTnpyRDc1cERmRk01Q3ZJVWRiVWF4SFE1?=
 =?utf-8?B?WUpvYlNOK1N6RmhZTGwwZHloT1lEQzZqaWYrYVV2MzZCVWhMaDlTN2lSMkdD?=
 =?utf-8?B?S2VVNzg1Q3k4ZkI0TC9yVytnTlFNTWdZQlUxd2VEZm1MRGxPQVI0S25mUlEr?=
 =?utf-8?B?OXc2YlU1WG5wSjVydE1KSXd1RGwyeXNtSFNBMVpyaE1PQzFKdXArdndDODlD?=
 =?utf-8?B?djVNSGd4N01QS2VMZkRSOTB5R2pYellQdm5KWDVKSm85NVc4RDJHTDYvTklF?=
 =?utf-8?B?d3lxS1RURk1kalNqRXNMN0lCdVU5elFVdHZiZkVsQVZJb08yN0t4K0M4bjI1?=
 =?utf-8?B?ZC9aS212Z2tNL1RHc2ZTL1Z2ZUo2V1hPL1VSdm9DUXJ6NXIyb21Qa0Rsd2dQ?=
 =?utf-8?B?MDFjMW5VdVBBNnZNbmlxT3JrKzExVE56bWoraGtYY1JsVTBVaUQveWZLSlFU?=
 =?utf-8?B?YnpacGFFK3RrS092OTlrVnI4UUVXZTJzSDJpcEF1TXZabjAzNWRVajZOQWdL?=
 =?utf-8?B?V2ZWY2FONFJ5UjZBWDJ5Qm1WY0pTdVdCdlRrNUEzeHJ1S0JEQUFHWklETkVv?=
 =?utf-8?B?ZXBYUGtJWktTWFNvVldsY0tpODZ3ZHlVNXUvYUVySnJFMHhBK1RPVHh4aW5h?=
 =?utf-8?B?SGJpeG1ac2VWMGxqT3lxeVlETS8wWHh4QU5XYVF1K3c5YmhSZUpXTmRscW8v?=
 =?utf-8?B?Mlp0YnlHYnZhNW5zQVdBeEgzL0J4WTF3eU1xNW9MZTJSMUgrZmRNd01CSXM4?=
 =?utf-8?B?T25FcmxyUmI5cjNldmVqT2Qzcmc4N0FWZ2V1Uk1JNmpEVTZjZFRITllzZFE4?=
 =?utf-8?Q?Tzf6KXUhVl+d2YfEt9cWgwSPw?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <75611868B71DF345A05749AE72872E02@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fe1d5ec-14f1-4b1c-2d69-08dac3855b4b
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2022 01:37:55.5754
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wPRFPF7/3/O833PTq0tIrSAnmeUOjX7MTFmt0a5rLCXVpmRd02s00hE3i/90r8XLQ5cxPx3iVdr/jHnhLoQgjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5628
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221110_173800_759781_29A27237 
X-CRM114-Status: GOOD (  13.20  )
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

TGlhbiwNCg0KT24gMTEvMTAvMjIgMDI6MjMsIGxpbmFuIChBSykgd3JvdGU6DQo+IEhpLA0KPiAx
ZTg2NmFmZDRiY2QoIm52bWU6IGVuc3VyZSBzdWJzeXN0ZW0gcmVzZXQgaXMgc2luZ2xlIHRocmVh
ZGVkIikNCj4gZml4ZWQgQ1ZFLTIwMjItMzE2OS4NCj4gDQo+IElJVUMsIEVSUk9SIHBhdGggSSBn
b3QgaW4gdGhpcyBDVkU6DQo+ICDCoMKgwqDCoMKgwqDCoMKgwqDCoCBDUFUxwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgQ1BVMg0K
PiBudm1lX2Rldl9pb2N0bMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCBudm1lX2Rldl9pb2N0bA0KPiAgwqAgbnZtZV9yZXNldF9jdHJsX3N5bmPC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgbnZtZV9yZXNldF9zdWJz
eXN0ZW0NCj4gIMKgwqDCoMKgwqAgcmVzZXRfd29yaw0KPiAgwqDCoMKgwqDCoMKgwqAgbnZtZV9y
ZXNldF93b3JrDQo+ICDCoMKgwqDCoMKgwqDCoMKgwqAgbnZtZV9zZXR1cF9pb19xdWV1ZXMNCj4g
IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgbnZtZV9yZW1hcF9iYXIoZGV2LCBzaXplKQ0KPiAgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaWYgKHNpemUgPD0gZGV2LT5iYXJfbWFwcGVkX3NpemUp
DQo+ICDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuIDA7DQo+ICDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCBpb3VubWFwDQo+ICDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgcmVnX3dyaXRlMzLCoMKgIC8vZXJyb3INCj4gIMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIGlvcmVtYXANCj4gDQo+IEluIG52bWVfcmVtYXBfYmFyKCksIHRoZSBwcmVtaXNlIG9m
IGlvcmVtYXAgaXMgInNpemUgPiANCj4gZGV2LT5iYXJfbWFwcGVkX3NpemUiLg0KPiAgwqAgc2l6
ZSA9IE5WTUVfUkVHX0RCUyArICgobnJfaW9fcXVldWVzICsgMSkgKiA4ICogZGV2LT5kYl9zdHJp
ZGUpOw0KPiAgwqDCoMKgIDEpbnJfaW9fcXVldWUgPSBkZXYtPm5yX2FsbG9jYXRlZF9xdWV1ZXMg
LSAxLCBPbmVjZSBzZXQgdG8NCj4gIm52bWVfbWF4X2lvX3F1ZXVlcyhkZXYpICsgMSIgZHVyaW5n
IHByb2JlIHRpbWUsIGl0IGNvdWxkIG5vdCBjaGFuZ2UuDQo+ICDCoMKgwqAgMilkYl9zdHJpZGUg
aXMgZG9vcmJlbGwgc3RyaWRlLCBpdCBkaWRuJ3QgY2hhbmdlIGR1cmluZyBteSB0ZXN0DQo+IFRo
ZXJlZm9yZSwgSSBjYW50IGZpbmQgYSB3YXkgdG8gbWFrZSBpb3VubWFwIGhhcHBlbi4NCj4gDQo+
IENvdWxkIHlvdSB0ZWxsIG1lIGhvdyB5b3UgdHJpZ2dlciB0aGUgRVJST1I/DQo+IA0KPiBUaGFu
a3MsDQo+IE5hbi4NCj4gDQoNCkRvIHlvdSBoYXZlIGEgc2NyaXB0IHRvIHJlcHJvZHVjZSB0aGlz
ID8NCg0KLWNrDQoNCg==

