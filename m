Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5896DC433FE
	for <linux-nvme@archiver.kernel.org>; Sun, 16 Oct 2022 05:10:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HlVYZcQy2ryjaKRID57GYK/8VTd+9JsRRrjB9HNzgf8=; b=loOWhoEfAwAZYy/+NSVuXwbSwp
	C8+SB0lpreY+OrGP1WxKdgeEJT+a8/QeWh9fF2AU6UwmHi6cXr0eesxM585h5YvvsetAHMNB/86Fl
	Huxyw3H/x/+EQb12+E1vudN1HFXFjDtzadWUlzPkG04NuNPCVNC35GxAxxZmbsGXMCQQJq2/PojRF
	1HzxGx9LVF6jcT5AZVvTBrBDu3R8y50sgBge2+tWy94L0GZps7FgQp3pHeB6BHpdib4wj9Org85Sw
	KgOJZFHFO11v01Yq6M5ukvTE6qFU0q2ADc8VJIkNDvAlHTehY7WpM7XcXELKB1QkNylxlFUniIAH3
	M7nsKKIg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ojvuR-000aFf-Rc; Sun, 16 Oct 2022 05:09:59 +0000
Received: from mail-bn8nam11on2041.outbound.protection.outlook.com ([40.107.236.41] helo=NAM11-BN8-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ojvuL-000aEE-Ac
	for linux-nvme@lists.infradead.org; Sun, 16 Oct 2022 05:09:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c0NmpmesitB3VNEx1JTKU6dnKSQMcDz8iMf/HkMUjl3VTRIZnDB/X09eTSuA3CrwmpuGifox70/sSnuNPld/Nu0P3zb8NN5j+jI+dNHtPWhx8Dw7ulxmWaz1sCaBpKM795jd6Bh3dweVrR+GElJfUqh/aau95hMmkj52QBr1gvlcrN9ci/deOXAGS+VdKUK3L8k8qpiIEMJKc28nTwlcrMsqApMesA4uErRN3z3joPU7QX6r2GlamwId5nTg8cOQdzYW/sOJgM+M2fhkKcc8izV+DQfnhFPtnSTzacb0nTyRgBLdgRdLIPEY9EIKEN75X3YV0IAdv9vOrxOn/6Umwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HlVYZcQy2ryjaKRID57GYK/8VTd+9JsRRrjB9HNzgf8=;
 b=U7T4wJPUCpY21KGsLP45a7r//lUz58aMBaUyhWLPQ5zv+4kKzYsMX5huZ2i8MckbhHs5srzMDFOFFhedETS4msQg1qFx3W7pW4Zq/Zh9cUCUF1RevBuV4mW8IcvGF6AdsYiS0aDu6bGVh5Urd1psJAimCDHMrGI6nFYkpuNB5/vodUNJkpYFD/Zxzdp6pQqOWh26mUYzU1Pq0Lne2/Y3TFV4QhJOhbFAyW082gWWzkFuecFWz37H2PaYgCf0Qqi6T3ef35tbqsCPMQBRPwoLHoAFKKfrw/kFI5aWijEbVlBayUMRIdtW4x2yvVWd0DOkAlSjufgO0rMK+rZdBPcaaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HlVYZcQy2ryjaKRID57GYK/8VTd+9JsRRrjB9HNzgf8=;
 b=MnlLxHUQCYkUtLZekcENsD/3ZDpLa10Z63AQkQMJZci2v56ooMkBTRYtZRizMHTh+C8ge9lMIUqiPOF9SJD7+GFIi6nu1xKXgcEIPvx3fwAXvsxzyUbgIJsQuMAaVt0z4HXPn7h73SKrswFZDsVojFNFx6Ii2Hv3W8iipRddb/Whh8enNbFhTns0KtCpc6AVqNVKvkaQ+yU4RW9rtyNZBMhMicyYzJgACh4c+BtdCvI6g04rUrDcxscJlkbWImgLmSqxm8vxfvsgHjAn5VpUsJGOnQ26bzj9KXzlGFdepq24k9hRqfLPToJpa0g24nPVUSKJgx0i9kbLd8ohL/qA7A==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by CY8PR12MB7610.namprd12.prod.outlook.com (2603:10b6:930:9a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.29; Sun, 16 Oct
 2022 05:09:47 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::1402:a17a:71c1:25a3]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::1402:a17a:71c1:25a3%7]) with mapi id 15.20.5723.032; Sun, 16 Oct 2022
 05:09:47 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Dan Carpenter <dan.carpenter@oracle.com>, Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>
CC: Jens Axboe <axboe@fb.com>, Sagi Grimberg <sagi@grimberg.me>, Chaitanya
 Kulkarni <chaitanyak@nvidia.com>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>, "kernel-janitors@vger.kernel.org"
	<kernel-janitors@vger.kernel.org>
Subject: Re: [PATCH] nvme: fix error pointer dereference in error handling
Thread-Topic: [PATCH] nvme: fix error pointer dereference in error handling
Thread-Index: AQHY4G/efyJvLtwVq0S90ancsrytLK4QeiQA
Date: Sun, 16 Oct 2022 05:09:47 +0000
Message-ID: <6108ed58-a7e1-4fcc-495e-b03faa615158@nvidia.com>
References: <Y0pulP9Xj/mQINCh@kili>
In-Reply-To: <Y0pulP9Xj/mQINCh@kili>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|CY8PR12MB7610:EE_
x-ms-office365-filtering-correlation-id: 7454776d-8ab4-41dd-cd7d-08daaf34a558
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  zRxeoSyxEkOqc1w42zIzAsxuk6uj5kzspHiG1QcniC7wiKg04R9/0mgmlwimQXa8EuPDBVTAn8SwBGe9laWgP7mJbFpXiMZXGrfMCP7ecW6jV85lB8JaJkChqNh8Fbn/Iv5qqjD5WI8C0WEu9a+yR2I70rh86RfunLlP77pZw7Dm9E2wkFn5NnfTme3Cp2QHe+/aVlh7SE2w+s04G0bMiqb36t9GO9d9wasMrDveD37/MC7HYB6uUNMz/vGqsfRJJH0up5ZVhGdqgONAXHOw/rR3r3EUihCyoYDEoIO6IVjOdqXXbVCVzWugM87KQQzqvg4vxlSTML+/uU6nsrmWpTP3slBhNzoRffeX1v0yGv8013LX6WBAxu23VH9FFv1J89Exn2kR+ifyPJEbAiUg0dIw4YVk1HfQau/dAaGQ/2eJwewA9Pw6orJhlPvB1iw3aHU9CyUXSXU1Z+8iMIzzXfmCeK6qT/Rap4hcFybsHcp5/d9vodqbA9mvd1CH8/+LhZSO4fr5OGwcXM1T6FugW5xSTZjvSI+C8BRSFnw1bcwq1YG3onS7Zi4rFDN6cmK5HV+/qSSPyYtxg8wM+VS7GvZnRumKBMniBl9SLIHeuN8Y9KkLPWVDMSugW7bLnZrRBuw0s7uVJKRmAggm8Pw0sUBWtkhEUh5ObBVO22B+pdnttYVzVspJWQ775t8Rl+vVZLIzw7cI1atgYwWrY7TuVFrgKuj7DhzYjzcjnUVRuC14qm+QcPUvvb1LLOswCHpTbI+yYGNrI9V5y7C+relF2GWoi/7Tm7XW0RndCAT5u6DT1v4HbJKxkupFMjwWn5PPIqFMCc3//s2GiFUE/RfV9Q==
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(136003)(346002)(39860400002)(366004)(396003)(451199015)(66946007)(4744005)(31686004)(83380400001)(316002)(66556008)(71200400001)(66446008)(64756008)(66476007)(91956017)(4326008)(76116006)(8676002)(6512007)(186003)(8936002)(54906003)(5660300002)(110136005)(6486002)(38100700002)(478600001)(31696002)(36756003)(53546011)(38070700005)(86362001)(41300700001)(6506007)(2616005)(2906002)(122000001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?utf-8?B?cTF0K2ZrREZVT0V6NE9XaFZsOEZ3a1Jic0dsNVVJb0hHeFhwZW9Pa0JCYWY1?=
 =?utf-8?B?VDZrd1RxY210WW5vaTFFTGtSWG5UQmRoUGNpbWkrZUtsWUk1cUM4SUR5b0NB?=
 =?utf-8?B?dWZ3ZnQ4VjB4ZUZYREJBai9BM1ZIQkQ4UktieTJZc25HNkFVZWMrU3B0S0VV?=
 =?utf-8?B?U2lHWlJhQktqd0tDcTFPcXorRmR1NkVwMzJRckQ1bCs4anBqTHVZRFdKWUpY?=
 =?utf-8?B?TDVtdHlKRmpZZlFjVG5YV2pzQ0hvN0xMTW9mWXVXUFNvVEJHU2FyeFVEaHk5?=
 =?utf-8?B?TXNwdjFZbEVjTmNoMFNhejdjZmpOaHRJQ0l5cHMzanJyVjkrcnZQTXBNN0Vt?=
 =?utf-8?B?ZFQxNU4yRS9ENHQxajFobzZ3dTJjcGIxVHpDeThveDhvNlJUYnMyQkRlK2U0?=
 =?utf-8?B?aU1kaXpjM0FZM2w1UDZMR0dwWXVDVG40U00zOENQbWdaQU92a2xPRXJkdjJq?=
 =?utf-8?B?SytjM3ZUMnQ5NVEzMzFPbHpKQVdwTStBUkFEMnBDWEUyek0xS1BodUcvdThS?=
 =?utf-8?B?dmdkZ25oZlloZk1EVWc5NmpkS1BvQ2tGdENXczFqdyswZGxLWWlNNnVsTHM4?=
 =?utf-8?B?ZFVqNUxySFlleXIzazJwenMxR1pYQ0JXd0J5TURKU0RNa2lHTHlKZitKRzBH?=
 =?utf-8?B?ZmxheHVQaUpxOWRDelR3dDFkc29zQW5kS2NVaXBiUjRlZnZjeEF2T1VGWlVp?=
 =?utf-8?B?YXViaWJ0dFkvZGxyNHB5ZmQramN2ZlJjNUJYMUdNK2VlNlI5eDUzY0VCa0x2?=
 =?utf-8?B?c0xtNS90ZnRIbkRiZERzY3F1SDYyS0pyTGNpbzhYM0xiNk16UWVxSFI5M1RC?=
 =?utf-8?B?emNDcTRxaUxpOUpwZEtBelFBb3lITmd4VndOSElSN1ZobWxHU3Z2bEhMSktn?=
 =?utf-8?B?aEdISjdVbU4zejd2a1hkZ0dXVitGVHFEQktvZmhadlVlWFAwWDZLOHM2di93?=
 =?utf-8?B?MHd5Rm5OR3MybGc4MG9PL3hkenBySCtFK3JyaTBnejN1cDdidHdNaHBNUDVT?=
 =?utf-8?B?MWNpMnhFSFZYK09CaU9PTUp5Ri9SSHRiTjJ2cHZwT251Q25WK1BkcVdISktL?=
 =?utf-8?B?Y3MxUXdDR1h6cDhrQVZtcU9KekRQcDJvS0txQkF3anlLWEFyTG5KeVpmOUVw?=
 =?utf-8?B?QjFpS3Jsb3BxTUZvb1JnM1BmMjVhNHVXTWhRWWZtcG1rWE4wamV6ck1BSHhL?=
 =?utf-8?B?VktmQnNIN1E1ek1pVmdHc2hxWDA3NVJnNmo4d1g1NE1sbTN1Zjg2cDl5ZUsz?=
 =?utf-8?B?ckZZenpJNTFXL0ZDbG1GdUdvS1dCY1Vad1R4MmNzVjJ1SGRuWlJYaTgrSVlW?=
 =?utf-8?B?ZStadFdNbFpreFJBUEZYR1VNQzJpM01UbDNQY2JRWXdNZFBGRHI5UytwYkdQ?=
 =?utf-8?B?QmVGVGk2SVJFbWZGd1RNTDdhY0JjeGNick5iV2xsK3V1YXlRZlZkR3NyUStu?=
 =?utf-8?B?ZHBhWjlhTGExTXdib21nMWtGaHdEMFE2ZDd1VGU1MXNra3UwVmFwc1FjM3Zo?=
 =?utf-8?B?RXRYMTBhY3k5dW9HZjdaV1c5U1NmczYyNEFPYmh3emxKMW4xU1dBUkZVK3A3?=
 =?utf-8?B?dlRTbGNNU043aFZNV2JLOEIxMndoQmxiMHg3aVV2Y2s4L1VsVTJmZWxTd3VR?=
 =?utf-8?B?cEEzR1FzK0FwcW9ZNHlka3Q3ZE5NSks2bXhQSUl3R29VOXMxOEpkWlU2UEpQ?=
 =?utf-8?B?eGNVcitnVE05MXY0WnV6WUFpUTBEc0ZoTGR5T3RWcGRRTTV0Q1BaNC9sNzhx?=
 =?utf-8?B?U3dLQ2FncG9QRTc5TGo0RHBibFBsVjFnSGZtQUgzU01YNXF0SjFVOGZmTTZv?=
 =?utf-8?B?TnlvQjh1NzViemNKdGdKMWtMQnJmZTRNWHZKeXJZMlNVTEZreGxENU8xV0p3?=
 =?utf-8?B?Nkl2T1FPblpzOEo2MERoc2pVV1Vpak95NkdhRGhPSnJDbGFydjJ1RWJLMHVh?=
 =?utf-8?B?aXJSempkcnM3OEIvRnhtWG5RdHNneXRpNkczUzNZWlUwNXZuZ09jdUlIc0JI?=
 =?utf-8?B?ZmU4dVpFN1hNRWgvQVc0R09IazVHQ0l6dXBLVmhjanpHTitBRllnZ0c5RzNa?=
 =?utf-8?B?aFU2RHV4VlV0VE1PZjdIbktFMTQ1djNvM1pEQldnUGtLMHlTcGFmQlNaS05N?=
 =?utf-8?B?NFpMZFI0MWw5S2pIV0ZCLzNoNTJGYjRVZnUxMmJreEpEZHhPOTlJa05rWS81?=
 =?utf-8?Q?bGl4ETlscr9C5LrDctIoiUnoqNsesDa4JqtdTL13ARm8?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4DEEC171EC78F54D98F89DA458108D0B@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7454776d-8ab4-41dd-cd7d-08daaf34a558
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Oct 2022 05:09:47.3254
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pnPzsFhuV5eYkC0JyjB8i0sGOyw77xL2bE09yY+kHcESWkqA5nmxc74KgaNq2v5Jm4wyoSEzMUT6yf9eysy+7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7610
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221015_220953_617630_D344BF11 
X-CRM114-Status: UNSURE (   9.65  )
X-CRM114-Notice: Please train this message.
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

T24gMTAvMTUvMjIgMDE6MjUsIERhbiBDYXJwZW50ZXIgd3JvdGU6DQo+IFRoZXJlIGlzIHR5cG8g
aGVyZSBzbyBpdCByZWxlYXNlcyB0aGUgd3JvbmcgdmFyaWFibGUuICAiY3RybC0+YWRtaW5fcSIN
Cj4gd2FzIGludGVuZGVkIGluc3RlYWQgb2YgImN0cmwtPmZhYnJpY3NfcSIuDQo+IA0KPiBGaXhl
czogZmU2MGU4YzUzNDExICgibnZtZTogYWRkIGNvbW1vbiBoZWxwZXJzIHRvIGFsbG9jYXRlIGFu
ZCBmcmVlIHRhZ3NldHMiKQ0KPiBTaWduZWQtb2ZmLWJ5OiBEYW4gQ2FycGVudGVyIDxkYW4uY2Fy
cGVudGVyQG9yYWNsZS5jb20+DQoNCkxvb2tzIGdvb2QuDQoNClJldmlld2VkLWJ5OiBDaGFpdGFu
eWEgS3Vsa2FybmkgPGtjaEBudmlkaWEuY29tPg0KDQotY2sNCg0K

