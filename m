Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7401DC38A02
	for <linux-nvme@archiver.kernel.org>; Mon, 31 Oct 2022 06:56:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EJRruxnk1tx296cENd+Q+wOS+fdwAQiKUsd4rP/7lqM=; b=iU39kh31kTYJsV81PvnFfkvRWa
	6Xk9fg9xkp/1CWPp+Tn+c3iuQYHouFQMt6PL0+QuqhFCufn9BgTbcn+Ix3kaFDBObLu1wDungj4Pu
	GcUT0+XO+JTVI6bDRbGCuXSyqtb1XVtYHlHl5m9X174yPSUg8jl207YBjkzW6YFORsa+xHCpiFs27
	dDrr2hlUnasHPEJ5WxyyklEY6+X5J2pW9k6E0OYwOdp/gJjsXTePNlz+zO7TiM6MQMZQPyrOk0jbM
	t9OBsm5mjA8oPKozlaW+HEt082kUZcutgZctKZxDDQ1Q6d5RUwMuntVTQhui+Rjq107G5B1FV5mQ2
	CXAjn/2A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1opOiP-008sQ4-Gr; Mon, 31 Oct 2022 06:56:09 +0000
Received: from mail-dm6nam11on2047.outbound.protection.outlook.com ([40.107.223.47] helo=NAM11-DM6-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1opOiI-008sM8-Hg
	for linux-nvme@lists.infradead.org; Mon, 31 Oct 2022 06:56:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XEeqM//Vuo4SYIz9bsvORnvQkL37zFJVU4m92l8MVNVFLupEtxj50Nr0igJuyy+sBDLUH9eR2OGoLt0LZrXZmuNc/b5wn8U/aEdFL6j/1AlCAYiWOgxnBOoj7Fujths2QqZooOxVEu408fn3zrFNEeuAbWm/+g+5eM+Uv21Zvt+rb2Eva6v6j9A7ywCD1diuEbLuhA84AcWo5PMwlPzJ5bJqaEiwY4ZUQ0/SDo+NJn5Idr9cljUAlprvf0BRVPS2ff+XDtPIm3f4sHZ1HdMoYp43NgRyxxtV9RdN4HoIL1B6810toUCxGA0MYBrFCw1Gz8xjQNu0k2hGjYn40eavZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EJRruxnk1tx296cENd+Q+wOS+fdwAQiKUsd4rP/7lqM=;
 b=mlPPEa0hkIK0na+wTBUTpswE+HbWTPYzgg4JgmLTA3PCU344i/6fpKt4p6/dKeHGf4ta6+FpLz6POYSwOE3NKDgDo8KZhEw/v1ZJi++Jv0zkTLqeHhxyZlm5nV6frNp7VspImH4wo2HHZ4CLzpxDax+b1dlBVf25lsizrtuZWFliezndVlgS7f4B8CpHE+SwvjVNQG2IYQeHdyWaY1IAGp1/IMRmoVbGVtl2dMtJQfiKbiZRAD9UDegwgXXEO2CK3QDyL+2J1M2/jn2BcmLdERROdWCl9iFJTtzNN8KvJxMW/x1O+862Ozej/cdIuE+eRvK8IhZnXk9j6hJDAUWE/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EJRruxnk1tx296cENd+Q+wOS+fdwAQiKUsd4rP/7lqM=;
 b=PkK5/zalPSuXtRrh05eihqMJVPL/+gJRgDAiVEFXMvRGbIv7QCPgZ05R8GLV9leLUprd/syqCdx+6BN9iJnJWGRg5Y83A7D4FkaNe0A39+tuXR0k5lwNek+feOxSYvD5a7WONRhDXpnsRZmdkd+oG1FcHIpo6/vOeZHKIvkpUWkfdEWVxnBq2jlPZJKI9e+++6Y9e5pbVxPYhytTb+IT0xVpZL+UPKs7gRBY5I53K3IsnARDklb1GF4L9caZgDUO5YlPTk+y3tpj7vhPH/xZZj+y+Uo52Il9BKSY8Kf7DW069BY5QoFs1Yj1CGo2Ol1eRuT1mlODQj37XVMJZAWqcg==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by IA0PR12MB7776.namprd12.prod.outlook.com (2603:10b6:208:430::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.28; Mon, 31 Oct
 2022 06:55:56 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::eaf1:9be8:d472:ea57]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::eaf1:9be8:d472:ea57%7]) with mapi id 15.20.5769.019; Mon, 31 Oct 2022
 06:55:56 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Kanchan Joshi <joshi.k@samsung.com>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"hch@lst.de" <hch@lst.de>, "axboe@kernel.dk" <axboe@kernel.dk>,
	"sagi@grimberg.me" <sagi@grimberg.me>, "kbusch@kernel.org"
	<kbusch@kernel.org>, "gost.dev@samsung.com" <gost.dev@samsung.com>
Subject: Re: [PATCH 2/2] nvme: identify-namespace without CAP_SYS_ADMIN
Thread-Topic: [PATCH 2/2] nvme: identify-namespace without CAP_SYS_ADMIN
Thread-Index: AQHY5FPEjF7f8Ycm4kOhtN5yj61s2K4oIvwA
Date: Mon, 31 Oct 2022 06:55:56 +0000
Message-ID: <737c7d72-ff5e-1f0e-304c-24bbb23f30a1@nvidia.com>
References: <20221020070205.57366-1-joshi.k@samsung.com>
 <CGME20221020071346epcas5p4c3b8da5e60f94947ad570cbd151eb38d@epcas5p4.samsung.com>
 <20221020070205.57366-3-joshi.k@samsung.com>
In-Reply-To: <20221020070205.57366-3-joshi.k@samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|IA0PR12MB7776:EE_
x-ms-office365-filtering-correlation-id: 36ad6a23-ac54-4078-1afb-08dabb0cf5b0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  ljMBzY6rY1FxWoDYwJsCuXvfDpj4hJX4bvK+4IgflgnvrN3lIv1P/aHhCeRQdYgV4QKb9rkVknktvBU9HkQBandw7qLORYMSZUunNgWscpoNDAX6Gvwzwm+NDsQ2BvxikxRVoADPi8m0X9GugcPWoqipEgKYaw3esfGsxr3o6JTn505nhHDH1ZqLYuluNs3eLPH85DIqnhfvS4r7qrgRX4IfxDsP6ZW5UNkXsq86pzGWtinVq3AzKjac4bc8VcTRCY/mLwbXnoBqrj3YCYKZsiOovIJyZnDQfPxEz+HNeZ0siEThx5wShn3KyFuZRz6T7bGOLrbHjzlM+J/RIN5P6ZvBI+UAMM+Qo2Ww3nhUbioxGTywnF6Cc9lxRjl4jwVNtR1eJeUAHuP51NB3nPOChQV/9ZduiQiS2MHQyExWIHJGW4EItoJsrQy2E5qrjFhLVoDIJ27rCy3zqxtDaY9fhcaG/93hjeNFbQJuZTRDYlO+x1WkyLNemQB2RKeKmQFC9Uh3hnjh5iVnI9geeskUbq9lEspKp0mqdDigDltV/FfNQwrQkoY82Phnj5Ra2gQ1gER+wLk5IL/OIhGLHQ4jo7odpz3rGq8XYy/5jt7FhKCKAnu4bWkQOfxwNJ4igVFqYHyDSjCW4f/+CCinFDtGB4oPPgN9ZXISG2rGh7MAGss2oCd79/VQGzk2t/6lg7VW5X8QbtAsnxnWYOpIbcgT5mCiUAut8LsuHDDzYCJkDSTHeX7zoUvPr0QEIOqJIWdpXUaZvKXx17L7tyF4EtQu78tfrij6wvCMoMWyUH+OtqaJQO5nMz+fg9jfvTZMelpUaq6RrQVJaNejFTxvKPuBgQ==
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(376002)(396003)(366004)(136003)(39860400002)(451199015)(66899015)(31686004)(2906002)(36756003)(122000001)(64756008)(66556008)(66476007)(76116006)(38100700002)(8676002)(53546011)(66446008)(6512007)(4326008)(71200400001)(86362001)(6506007)(38070700005)(6916009)(316002)(91956017)(54906003)(8936002)(5660300002)(41300700001)(186003)(6486002)(66946007)(2616005)(83380400001)(478600001)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?utf-8?B?bGhMQU1hbnZhUUlCbzdhSGdzV2QrVERwM0h1cjRCNHdXdkJFVEcyRldiYXhs?=
 =?utf-8?B?dzVNTGN6dlVLRktNOTJtUUk2ZXp2NzV6cFd6ajJZUzBCK3FBUGtkamFlTUpK?=
 =?utf-8?B?bWtxWWJ2QUtQcEI1N1ZGWU1aRHNkY1ZSRTlIMGtmY3Vma0hrR293OEVoSzlj?=
 =?utf-8?B?eHlvcTNhTENwMVRTdHl5anZ2OXpJYzg5ck40VnEreSttNWRrYjJHeVdCNnBS?=
 =?utf-8?B?bWtRelRPa0xqMENwK0g5NlFhU1dENUw1WXZDZ3c0bUdCTlRHMDljeFRzNlo4?=
 =?utf-8?B?WmxtVmpjSHVvc1MydVpYaDNNTXh0OHFBK1UxbXhmVDdZcUVPNjN4UmJmV0VM?=
 =?utf-8?B?U3dkWFJHT1EwYS80d0k3Vm1ETG1NL2ZPZ2xOek5oeVRSY2NJKzZNVGRLMDV4?=
 =?utf-8?B?ZmdJMTdKSkVzNmt4bVAwSW54Z1JjOFhEdE5UdGJQdHNOVDFLN2dKUW1qNi9k?=
 =?utf-8?B?UHhwclE3UlZnSzlJcDVJdy9EbGd6bCtVVFRFQnZmUzg5T09Kc0F5TFUyU0Za?=
 =?utf-8?B?eWJ4UHl2WU9saFJqRkFySit4eG9Dc2p3T2FjWWpGRzQ4Wm43dXVaK05nRWo1?=
 =?utf-8?B?NjNzbVdzcENubHM4NjRLZEUrZmJQSHhCL2FWTjNWQ0ZIK2dMZTBzWnkvcWQ2?=
 =?utf-8?B?cUMrRUJSUER3SWdVclVZQWhRZUNVUXUzOEdDVFZveTIxV0NOV1lHaS90aTcy?=
 =?utf-8?B?NlRNenovd3VwcHZ2RWZ4bXNaVmpxSkoxblN6UEhwNjVFeDlQL0pJN0o4RWY2?=
 =?utf-8?B?WnpISzlOL0VNNFNkd3NBT0tNNS9iblVNd2xpNzNnMEc1TENuN3VLN3hTdnZM?=
 =?utf-8?B?VHNXVmg2M1N2UG1NMzM5VEhITVNLYzFjNTZ5M0MvRi9UT1U5UGo2Tmo4Q2Ri?=
 =?utf-8?B?dzVJWlN4d0NXd0pFMGRmais1RG9oais1OWhlOTJEVTdzVWw3ZlJFS3ZYdVVL?=
 =?utf-8?B?Y3BmQUhVT3lGSGllclRnazdiMmd2dHpHa2hIS1hscmw2VTdVWjU3RzhOWklT?=
 =?utf-8?B?NHFsR0V2K2FLL1kvQ244aWJ2VktXU3FjMzZYd2pscUdIa2xITGhKRkx2VlV0?=
 =?utf-8?B?QkdkVnhGZjFBUjdhUzlJWllPTGQ5bnlQMmgwMkVIaXkyM1pObWNzSkpWV1J5?=
 =?utf-8?B?c0ZCb1o3Y2tHK0kyZ2hJbTZ3T1UzSVBnVGoxTUZ6RXptODFpMjZGOXNwRXB3?=
 =?utf-8?B?cU9tMU5VcGtDcUFCSFNtNjQ1YlRNb2JMck85TUtXWUZnbnRZaVJzZzBxZEZK?=
 =?utf-8?B?NXJvT2xmc0Y0MmswQmNtbm81MmVrZFRaWkVjWURTaEgyMFVubWdjYkRHaDFt?=
 =?utf-8?B?L1RJVFJtL3pEZzdVYm5PdnBHaTgyTnNGd3h0R2N4b1JDNVd0YzY3VWR2amhN?=
 =?utf-8?B?Q29JbTNsTVRGT1cwM3psMGFnQ2FnWnRGNDhyOFFaZ3VHZ3JibE9uV05oRXRC?=
 =?utf-8?B?MG5YWjhXYVphMElacUtRSkVyeXl0Y21nOHR4N0t4aVprVHMrZDJuRW96OE1q?=
 =?utf-8?B?cUcyK3RMT2JyYkpScEJTdDNOcWtWZExwWU55b2laM1dlMkdlWFQ4SkpDeVdJ?=
 =?utf-8?B?TFpwQ2dCTUs1SjV2TEFqUlhhMVNXVXRnWjhnUmNBMVlyWW1qREtxVlFKV0ox?=
 =?utf-8?B?NiswL1Jkc1BCNzVYU095Z3l1cVJHYXN4QzlybnVMTktQS3dtV3BpM3k4M0hH?=
 =?utf-8?B?RXp5SjZCRzhQUWVuL2ZwSWtvMVNJMHhWQkRjQk9iWnZhN3RUaUVackxncjc0?=
 =?utf-8?B?cHJJMzh5bDRCcWJQMDJ0VkFhbzVRUENoYnVyUU83VnlldEF2UURaYWIrVGdr?=
 =?utf-8?B?SVI2OER6K2o0N3Q5YnlyMjVhczNUTEUrY25UMEsxNDhkVDZIc1NISXZjVVhn?=
 =?utf-8?B?NlkrelNBK3NEeFpXektjVklxTEdqbGdJUldlMjFWemlsdVBHVGQxS1lrZjJx?=
 =?utf-8?B?OHl0UjBWMWZNbG5TM3FWZUxwc3Nta2c5dUpUTkZDK2FpTVB4ZW52VlBFWU51?=
 =?utf-8?B?L1NCaWlXdVRRUnFMdVVWYk9Qdkw4c3IwVFY4MFhtQUxKSnNBeC9SSFo4dDZl?=
 =?utf-8?B?ck5YWHdvWWZ2NlRQZkx0WmYvcC9mb3Bta2tpZ0ZRUE5rWTBKQitucHl0RGVn?=
 =?utf-8?B?TGFBU0UxS0JYck54ajdDM1Y3OFhHUFpXNnlmT0V5QkpxK05nL3RhQmJqM2hv?=
 =?utf-8?B?dkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <155CDEF86C30B541B00DA5A45F27767A@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36ad6a23-ac54-4078-1afb-08dabb0cf5b0
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Oct 2022 06:55:56.1682
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: amlfg2YtrKbKjDjm3PFCXTE/11cg4fw6HY7JKTZbMO7F+c0VtfDP56l6DsEslm/9zzDTXiyCUk9Mj5P3/z10wQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7776
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221030_235602_855135_BE221F35 
X-CRM114-Status: GOOD (  17.67  )
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

T24gMTAvMjAvMjIgMDA6MDIsIEthbmNoYW4gSm9zaGkgd3JvdGU6DQo+IEFsbG93IGFsbCBpZGVu
dGlmeS1uYW1lc3BhY2UgdmFyaWFudHMgKENOUyAwMGgsIDA1aCBhbmQgMDhoKSB3aXRob3V0DQo+
IHJlcXVpcmluZyBDQVBfU1lTX0FETUlOLiBUaGUgaW5mb3JtYXRpb24gKHJldHJpZXZlZCB1c2lu
ZyBpZC1ucykgaXMNCj4gbmVlZGVkIHRvIGZvcm0gSU8gY29tbWFuZHMgZm9yIHBhc3N0aHJvdWdo
IGludGVyZmFjZS4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEthbmNoYW4gSm9zaGkgPGpvc2hpLmtA
c2Ftc3VuZy5jb20+DQo+IC0tLQ0KPiAgIGRyaXZlcnMvbnZtZS9ob3N0L2lvY3RsLmMgfCAxNCAr
KysrKysrKysrKystLQ0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAxMiBpbnNlcnRpb25zKCspLCAyIGRl
bGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbnZtZS9ob3N0L2lvY3RsLmMg
Yi9kcml2ZXJzL252bWUvaG9zdC9pb2N0bC5jDQo+IGluZGV4IDljNTgxYjFhODk1Ni4uOTI3M2Ri
MTQ3ODcyIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL252bWUvaG9zdC9pb2N0bC5jDQo+ICsrKyBi
L2RyaXZlcnMvbnZtZS9ob3N0L2lvY3RsLmMNCj4gQEAgLTE1LDkgKzE1LDE5IEBAIGJvb2wgbnZt
ZV9jbWRfYWxsb3dlZChzdHJ1Y3QgbnZtZV9ucyAqbnMsIHN0cnVjdCBudm1lX2NvbW1hbmQgKmMs
IGZtb2RlX3QgbW9kZSkNCj4gICAJaWYgKGNhcGFibGUoQ0FQX1NZU19BRE1JTikpDQo+ICAgCQly
ZXR1cm4gdHJ1ZTsNCj4gICANCj4gLQkvKiBhZG1pbiBjb21tYW5kcyBhcmUgbm90IGFsbG93ZWQg
Ki8NCj4gLQlpZiAoIW5zKQ0KPiArCS8qIHBvbGljeSBmb3IgYWRtaW4gY29tbWFuZHMgKi8NCg0K
YWJvdmUgY29tbWVudCBpcyBub3QgbmVlZGVkIGFzIGl0IGlzIGNsZWFyIGZyb20gdGhlIG9wY29k
ZSBiZWxvdw0KeW91IGFyZSBkZWFsaW5nIHdpdGggYWRtaW4gY29tbWFuZHMgb25seSB0aGF0IHRv
byBzcGVjaWZpYyBjbnMNCnZhbHVlcyAuLg0KDQo+ICsJaWYgKCFucykgew0KPiArCQlpZiAob3Bj
b2RlID09IG52bWVfYWRtaW5faWRlbnRpZnkpIHsNCj4gKwkJCXN3aXRjaCAoYy0+aWRlbnRpZnku
Y25zKSB7DQo+ICsJCQljYXNlIE5WTUVfSURfQ05TX05TOg0KPiArCQkJY2FzZSBOVk1FX0lEX0NO
U19DU19OUzoNCj4gKwkJCWNhc2UgTlZNRV9JRF9DTlNfTlNfQ1NfSU5ERVA6DQo+ICsJCQkJcmV0
dXJuIHRydWU7DQo+ICsJCQl9DQo+ICsJCX0NCj4gKwkJLyogb3RoZXIgYWRtaW4gY29tbWFuZHMg
YXJlIG5vdCBhbGxvd2VkICovDQoNCnNhbWUgaGVyZS4uDQoNCj4gICAJCXJldHVybiBmYWxzZTsN
Cg0KaWYgYW5kIHN3aWN0aCBhbmQgdHdvIHJldHVybnMgYXJlIGxvb2tpbmcgY29uZnVzaW5nLCBJ
J2QgdXNlDQpuZXN0ZWQgc3dpdGNoIGNhc2UgZGVmYXVsdCBoZXJlLi4NCg0KPiArCX0NCj4gICAN
Cj4gICAJLyogZXhjbHVkZSB2ZW5kb3Itc3BlY2lmaWMgaW8gYW5kIGZhYnJpY3MgY29tbWFuZHMg
Ki8NCj4gICAJaWYgKG9wY29kZSA+PSBudm1lX2NtZF92ZW5kb3Jfc3RhcnQgfHwgb3Bjb2RlID09
IG52bWVfZmFicmljc19jb21tYW5kKQ0KDQoNCi1jaw0KDQo=

