Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 886BFC4332F
	for <linux-nvme@archiver.kernel.org>; Wed,  2 Nov 2022 05:47:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6zFK3km7zyekjSbTzRRKipTeFP0assnW5bWR0Y5OWmI=; b=117MnEot7V3wBF5GGh7gGl81Nz
	5leWziYTLsuo+jWd3tlyNBIRP5JCF+CEgu3vqhAYQxy2c4abm+OzFZqBKddN7HJT93JguJLvCKrcu
	7NoFhzw9eYeI1EchI5rN+sL0v2GknF65oEy2HwVan81vvi8b7extDai8HvSJ2Fv3RDMtqi+nKkQpz
	HFNlasWe1I2D1aWGdAUHFI15pqWPM5BgjrelmN1OcUjtF3Kg5jqi6qM+lEAwrJeVmD8kf6r3BFWMP
	dTd6zA9NYdrSrue9ggh4r45pAlCljtudUaLGfbOl8QApOEhk4eboVUgYt6e2zuAZlYbOP5KWOUjDj
	J+YeDeNA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oq6ap-008L2L-LR; Wed, 02 Nov 2022 05:47:15 +0000
Received: from mail-dm6nam11on2049.outbound.protection.outlook.com ([40.107.223.49] helo=NAM11-DM6-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oq6am-008L0x-H9
	for linux-nvme@lists.infradead.org; Wed, 02 Nov 2022 05:47:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TxbGVETSNthh0J0/Prerd4hDjIP3jdRH/YLEsFoIhVgmFUgKsx25ttIYdaX8EcnZ6wEsoe3jr4jTyt02eIA4c2jd65t0yuHHSYXiOwwnmRhx9sm1olRjsRAUJYbS8YdUFAHju6Nq3A7ISaUfyZcRFDOgD1OJmm1w4Qy2jkv8TFytRRAT5YZ9E3c3KE6+MHEioH2DL03JqNCGuoBq3OCpbAmQ6v74FgRuJIRVtePvHafoHm3yBR0FkQ3fGzoYc7UlodRy0+TayRF0OX0HuM1vULuFTGB3DhcsWGXVAaTvRUh1wJYPoFAuKlaRQRZReJuJvPLSD/0+Z1pyaBEjXl4I8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6zFK3km7zyekjSbTzRRKipTeFP0assnW5bWR0Y5OWmI=;
 b=Sd0Fi39oCSwd6cfVo1GxnkDVKh190He/1hsMUTiKWp0YKAUA+av48AC19ZNhbaQGsSXUj0lnqgviQ129HNk8L/q85Ed5OI03pEijE2soBnrFoGnYUKv3BEh5SS/J8RHeF1JHuBI/rt5/ApA3Ge0/+a2Vh1K/UxqAVCSc+Wr1bRNcJj1gWgSDvQ624D44Ywl6pgoSDLl9diOApc0njR3R9ugfZQfh4S/r7Nhunp2dw8eHfxlWM/FXXZ7Txw4n/Mc3Umqh8/1DkoMwVqIBrlEInw1q9TFgALFTWTWMH98mUOLnIswl8/AP1mWwxc56T96GNSXGcYtAtpgcB23GPm9U3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6zFK3km7zyekjSbTzRRKipTeFP0assnW5bWR0Y5OWmI=;
 b=Fp1zdaStxMW0TEX6gMLMg/ZN51dL8IUzYoHqJEeb13u8lIrYxMqr02LyezTqLodhNW0MroUoUy7uCzhlIDP6Yg6CEGJvx1w4NzkWyXOdu/jS9Bk7FIpaKrZlG5T+Ewx9RXy8igLWm1MZn+RQ6F3sBlS+PiPyo2cZ3vXXhHEp+Re/5C7mDxeOW8x37d5Ojk+Loe1HszSvDFLoEqzizujbSo3Y+kZh/2J08xEjKakB4rjGROd9hfQBVzdO/PZVEabhSlFuffEZ0oLAshuHonThpXwjop4/GUi7Yq7XX4TTiu+8+CNV4bK3TKPItxAfmVxXYpKaXaAqA5fnROObZgAzPA==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by DS7PR12MB6239.namprd12.prod.outlook.com (2603:10b6:8:95::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.21; Wed, 2 Nov
 2022 05:47:09 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::eaf1:9be8:d472:ea57]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::eaf1:9be8:d472:ea57%7]) with mapi id 15.20.5769.021; Wed, 2 Nov 2022
 05:47:09 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>, Keith Busch
	<kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>, Chao Leng
	<lengchao@huawei.com>
CC: Ming Lei <ming.lei@redhat.com>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>
Subject: Re: [PATCH 09/14] nvme-apple: don't unquiesce the I/O queues in
 apple_nvme_reset_work
Thread-Topic: [PATCH 09/14] nvme-apple: don't unquiesce the I/O queues in
 apple_nvme_reset_work
Thread-Index: AQHY7gL8jTxRLAXh6k6Fv2+mh3co064rIRAA
Date: Wed, 2 Nov 2022 05:47:09 +0000
Message-ID: <c4956e13-8b9a-e908-ca8d-10d5550c8c7b@nvidia.com>
References: <20221101150050.3510-1-hch@lst.de>
 <20221101150050.3510-10-hch@lst.de>
In-Reply-To: <20221101150050.3510-10-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|DS7PR12MB6239:EE_
x-ms-office365-filtering-correlation-id: c20ad33d-3d55-4588-af5b-08dabc95ae8c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  n7mSmpIur2mP4j3qRjoLL7wjpYfIkAyB3cz7WyF9xCc02wAcx8WqkNpYlfda+5ArbADeErfY+1D/dG+k6j2TIMJ1YzjdY2ejfxtCQLsk7DQBjp6suZgpO0/Ir+Oz77XiSB5JwVNBsjjjdrA+6nWyFFdcBEYb1mOfSc44PxCYcP/q1G092rfDoxdW/eMxrBb1+jwre0pukHfVJ6t1tuBOQLOCd8+n4v/QUecZ/mLEcHhCBY3QSMlPHU6yXo3RqiUl9ohLAxVm437FfJt4X8pLINHD2hC/uBOISXHbUKfZI7KEubWHeXewYp662Na1T5JoEq7891Q5XavzC9Vxgzm3C1oGvyweQAg9/1lgdNC6cb2DTBvNjpiLw4mUh9+edNsZbJ4RSLjRSw9Qb5API6kcT6RCrRtym4DYReMBUB7fIVyZEXvizGxG4iO7rPbFGxGocsboIv1ucJ+vKKUh2XZkIhmbkxJ+oo/Vu8t3vb90QHMjQxfX31bZUjzYfKxvQQDZ3bV25gKbApGfedywJRZ9rDQcZMu40zg/8j6WRoRUq9J60p44w8qzy5xqRf5Q++oP+YE/qj/yVfEV86fyTHGqmIWJq/xGHqj44g4qbc4ry3IfrmKepmOyy6i9sSR+9Udy9T+HCNk+bDfbY/T7i0lky5LeyBPMaj7Zg8mjY6Z2Xbv2kA0kiTltJfBqojeaMxmTBsTAxMfrnahGs7pQHczEWIhKPEgzafAMnXjumEihIbDZ4pgq19zSKbEYHEBzxoAL2Uyaly0CnmWMkgGJoEKGZ2GmUizQTqysJc04gMSA4t3DWmN9JuE95ANEpSs1cfZSwK/6S1Ah4xZFt9TF+Zhxl5yBm9nqTKRXe6m8eAyqp10=
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(396003)(39860400002)(136003)(376002)(366004)(47660400002)(451199015)(316002)(110136005)(91956017)(76116006)(53546011)(31686004)(8936002)(54906003)(41300700001)(4326008)(8676002)(64756008)(6506007)(66476007)(66556008)(6512007)(66946007)(71200400001)(66446008)(6486002)(2906002)(186003)(5660300002)(478600001)(2616005)(86362001)(36756003)(31696002)(38070700005)(558084003)(122000001)(38100700002)(46800400005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?utf-8?B?VkhjVmtYODJITHp4QmdXN2VFckt3czYxNHh5TE5EUHk1aFB5ejJ1NnM2U2Rl?=
 =?utf-8?B?VVo0djc1L1RNTTlyMDZuSXdkT1NLZU1pSlZnZTlPK0x5YlBjdGdXbmtZNFY2?=
 =?utf-8?B?YU9lTCtqWVo3R3hmN25SQTNjQ1lzRHNBRFBxZFUwdEpUU2kwUmZxN1ZDY1NC?=
 =?utf-8?B?Q1dWVTNMejV2d2tCOTlWUldVdmNBS0gydCtyN1RzSWRraHc2OHdLZmNHTlg2?=
 =?utf-8?B?R2NMTnRJVDI3Q080b3NNOTQveVpDMVY1TTQyeWo4b2Z0SzRzVWdQQVI1NS9R?=
 =?utf-8?B?bnQ1clprYmhDRlloWnZrL25RamVubFViY3JWMjBBbjVUVWlsR3E2RlloS0pU?=
 =?utf-8?B?YUNBYTRBZjJXNXA5VVU4WDU1WUZxSmdhRC96UTdPWHhVS0E0YmZmb24yMlJT?=
 =?utf-8?B?VjBrVkhkSlc2NDVpV1BKQjFEeEg1UG9HWFVXbUxtbit5c0tIU2xMYVN4YkRW?=
 =?utf-8?B?eWZ5MHZORXl2eXE4U2c0VVM0aGFDa2l4UytQV0tZbGVQZzJzRTc1V1pFZVRx?=
 =?utf-8?B?M2NtbUdIOFFrdkNQZERNY09vT0xiekE2d3VTYVlYcnBraGpBRitZWlJjZjIv?=
 =?utf-8?B?aXFuRERvYmdwb0dOSzBwZEphUFV1cUdSMHVNVDJpb0lUQ1ZvZm1rWkhMcVBx?=
 =?utf-8?B?RTRIUUJKZ0ErRWI1cXJ3WXo3aXptNjV1U29FRVdzcEN6R1R6SzZ0NFhWY3U1?=
 =?utf-8?B?ZzJ4S3pnaEtjNXd3SThvbmJOQmttOGFwaVE3dW55QUc5anlpR1JGYjRGK09p?=
 =?utf-8?B?T0x4TGJKaW1nazNiS09xSkJCNzlLQisrcWJFTEtucTZBd2FEc2JoZEtySVlI?=
 =?utf-8?B?L2hOM3hGQk1VWEhTZVI1S1VCYjVqNkRSTjZOaVgrOGgyTTFQUXliZk9qbWlz?=
 =?utf-8?B?UXhyUTJDMHR3UEpBNmJNT096d1VHU09NMkFFbzVKWlZxaHJOWWJScjViVDN1?=
 =?utf-8?B?SzBSUE5NaUYreFFiT0Z6L3E2VWxLOHFQRlo1KzZQZXM0WjJsdDNpZkVQREt1?=
 =?utf-8?B?aDJnaTBMMjExOXRXeXgrZmJCMytLdEwyclhOWG1IbkI5bjNxWi9remtycGw2?=
 =?utf-8?B?SEdQaVBOdnN4ZzRCeW02NHRJOXh4cjBsNlVlNmJjVXZIQlF2aTBNbUZ5YXZ0?=
 =?utf-8?B?cXBTZzJjREI2Y3dIN1hSUXBFY0Z6VjcvckJTMnlOZkczT3RzQkhqTzI3aXFz?=
 =?utf-8?B?UUdCV3JWdzNpOG8rYXlNakVFN05CUHBLRlFXUUFqMDlUYnEvb1QzUXpDa2Zh?=
 =?utf-8?B?dHJIbVRTcW1obnR6ajR4UmVEZVg1Tzh3NTJMYlhKRjBSZzFpSWQ3V0MyNWNX?=
 =?utf-8?B?K1AxSm02K2lOQXFpY0lDcGtPWUhxYSsxY3c2UjZDL2NEWUltdy83Q0ZBajhh?=
 =?utf-8?B?Nngzb29XN1VyYitzWjVnVkJiMVpKcXFDaWRVNmdzZTdiTDNMS3lCUzVUYXQ3?=
 =?utf-8?B?TzdBcDRWNHFVVk1adzN6dFpDYVhDQm5DSS8xdTVrRFFmWGJWejFtSk1qZkZl?=
 =?utf-8?B?VVlKdU90ZW55VzNwMWdkSTZjRXd2M2xJQXpFaldUU3IyUktEK0liZVY0Q285?=
 =?utf-8?B?Um9uclBhY2pwVC9yZHNjamdLZWJHMnBVeTdPZnBwVmxsenhiNUFKbXl0K1Jk?=
 =?utf-8?B?QXE5dkhNd2VkRjREN0w0TDd3dVlhVHIwTk40QVRwTVJNeGNkZHJTdW82VUJu?=
 =?utf-8?B?SmZVZ0Z5ck8wNFYxNFhuV3NaNE5RM2dkRSs2L0ZXSDZvTEhFZmNpZWUvRER6?=
 =?utf-8?B?eG1MZlM3THRGN05ObVJ2amxIb0JtL09pT0hKNWNoV0FSV0EzYWorM0NPSU14?=
 =?utf-8?B?dTI4bXhvVmZqcE1UYmhaSEZXTW1jMUljNzBPd3ZRT2NEeDdRQm1vTXg3YVB6?=
 =?utf-8?B?QUdqUjI0TElsMldQS0Z4SzVob014b2ZQWENPUFFWcERjWUZzUFRIa1U4NHFP?=
 =?utf-8?B?WEtUY2JqMmpaaU02VnFIUjlYaEdpTDlnbHRhY2hEYkE2bzFaYXR2VXREemtq?=
 =?utf-8?B?QmN4Ni9CVEcvZHZjTDE2Zit3UVBXMmJ3dldRNnQxRi9GRldwVUJUV0tsK25u?=
 =?utf-8?B?WU92MXkrakZaYXpxelR2MlhNeFgwVFpoczdKUDdOT0FCdExiZURmbWRsMmpJ?=
 =?utf-8?B?aFRKNjlla3YxSW9MYkZGTDBKZUJmeUtRSDFkeXpuM05zVWdzaWxVWkpFNG5r?=
 =?utf-8?B?Q0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9E649ABE9188E84CAAD885854BEFDF06@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c20ad33d-3d55-4588-af5b-08dabc95ae8c
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2022 05:47:09.0794
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4i4/L4LwWHPPHU+DzF+pg5m1xsDggp8SXdX/MPwmU7q5UAuaKc/9/nyzYJoLF6KbfVMO7HtYQRUGUio5g+khgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6239
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221101_224712_595352_9FC7DD86 
X-CRM114-Status: GOOD (  10.95  )
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

T24gMTEvMS8yMiAwODowMCwgQ2hyaXN0b3BoIEhlbGx3aWcgd3JvdGU6DQo+IGFwcGxlX252bWVf
cmVzZXRfd29yayBzY2hlZHVsZXMgYXBwbGVfbnZtZV9yZW1vdmUsIHRvIGJlIGNhbGxlZCwgd2hp
Y2gNCj4gd2lsbCBjYWxsIGFwcGxlX252bWVfZGlzYWJsZSBhbmQgdW5xdWllc2NlIHRoZSBJL08g
cXVldWVzLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogQ2hyaXN0b3BoIEhlbGx3aWcgPGhjaEBsc3Qu
ZGU+DQo+IFJldmlld2VkLWJ5OiBTYWdpIEdyaW1iZXJnIDxzYWdpQGdyaW1iZXJnLm1lPg0KPiAt
LS0NClJldmlld2VkLWJ5OiBDaGFpdGFueWEgS3Vsa2FybmkgPGtjaEBudmlkaWEuY29tPg0KDQot
Y2sNCg==

