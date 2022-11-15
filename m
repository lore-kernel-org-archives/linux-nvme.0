Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B8C5C433FE
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Nov 2022 03:52:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FrlB8Ql4W2yTJp1xcKdCnPVntcajwYOiqHxGogk4KAM=; b=1/nAWkH5QcbmchO1nJoZ4lo4Rl
	nmK9HF+I5u5w3kcHvC4f0ktOMBYEX0PccUtH1kMN7P38UAlYM5orB5C6EFDwhwq8UbtKUcNuvcwTW
	S7SUiVLnesMHbNNF+aYW1z6SzuqZrYF+jjoaDYWOKJhsMiFiZsaDh4TxKwMM9/n/XlMa/rtSQ4jja
	Byq8zehIXTFjSC5Cdb8+pnLMCa3iJEx1mD/cpHGurdx5GB6iMYS/Id6ltOKL8BBWZFc4rQQRRqYaw
	ERcGStjcxooAKT366dfsEVQyAlTh445go9DbMjxKll3OTzs+IMWbiiB4gPCnkZhXCbQkoUfe7POMP
	7CVxumNA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oumzk-007Inq-2d; Tue, 15 Nov 2022 03:52:20 +0000
Received: from mail-dm6nam10on2060d.outbound.protection.outlook.com ([2a01:111:f400:7e88::60d] helo=NAM10-DM6-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oumzi-007In8-5D
	for linux-nvme@lists.infradead.org; Tue, 15 Nov 2022 03:52:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LUnMmyi6yy8I172MtRUwAZW9L+Gx7gAFEmyzQqRZDkyy3TtSNUVxMP3QW75uysTO6Dxxra6PlZDf5yGeF1zbrgvZjnAu1yIUBrd5JojBAZ2y4dWufjOmCGtjUma90ulyMKnkHFJueK5aOwM5Dpl2x6dQT74MBS9aU0CtpJDPhbn2s9r/wbhwoen4dMSXhpZ7qpsqGAHNmdj1VBq+wSAqKV0HmIG8zIfMvq7+k1zMTptYRSvdb/dE5znU1NPLTqJ3m4wCA9nkzUCLTEtsflPLTAViNGAdouACggw71rmnTb/v4+JEfL67jB2gpvkTxxV2CS4a9wlrOEv2BgERsV3s6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FrlB8Ql4W2yTJp1xcKdCnPVntcajwYOiqHxGogk4KAM=;
 b=TzTS8lAFLL8wMCTKofgiRTJY1QI5HG+op+391TzMyPwOQS4HTDM48Q/kv8TG/GkaZhed8l9v7iyt8Sn5xEgD9xxap0oOV1pGHvI+3jmoYFK7U3Vb6jyO+CnfNWbyh5h8Ei3mPgEwkEt/tmRfxUm5QFDz8dsJrYs+UXaqqLQbnup1j7+0clSPoGkYlkFVsB95X9xrgVQUkhTsoArorbUXdayAnQ/18w8fhhe61hiK1R5fV42MYVc4kkmoLOAKHIzFSsHXqBNn5ClOoDfLfgN0v6wpiYHjozoSEGAJLMK9xRU2vQji2PniELdAQJ2AG51oneJPNAalPAlWmrqgSxgwnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FrlB8Ql4W2yTJp1xcKdCnPVntcajwYOiqHxGogk4KAM=;
 b=cvGj4b3+eenecwECPRnlWTBZiyJaVWlHtq25CRT1rEs+a9mBdn9+yy/DTwpSHxGdT99RZLRSZ972XChwK9Ulmwx+jInqQkIq+av9MdXvxOZzpmYZf7skgclBt3jZB/1k7F3BB+7QoxcB0Y6lwNQIol5XuCz76F3VVaxyj2buaGetI0Mhmx3upv5SQZenPcATQ96AoEGDlHtgpq+ga4j8HeIfAeyd/Z6sS75thGTP+s84WytvbW1Y+VCSs6IzNoI7xGOg7SpZSoj9gsxTHj8EIL6mADJsnIDSzhtSBDkj7lxtlOAX7RD0FfHY9hMdvpqBRQ6Pj6+NWbOl46CMOH/7tQ==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by DS7PR12MB6144.namprd12.prod.outlook.com (2603:10b6:8:98::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5791.27; Tue, 15 Nov 2022 03:52:14 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::eaf1:9be8:d472:ea57]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::eaf1:9be8:d472:ea57%7]) with mapi id 15.20.5813.017; Tue, 15 Nov 2022
 03:52:14 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Sagi Grimberg <sagi@grimberg.me>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>
CC: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>, Hannes
 Reinecke <hare@suse.de>, Chaitanya Kulkarni <chaitanyak@nvidia.com>
Subject: Re: [PATCH v2 02/20] nvme-auth: rename authentication work elements
Thread-Topic: [PATCH v2 02/20] nvme-auth: rename authentication work elements
Thread-Index: AQHY91KlVC4t+hunvUChxEUTSrql8a4/XKYA
Date: Tue, 15 Nov 2022 03:52:14 +0000
Message-ID: <10eef630-ecab-7197-76be-8a28bd201ce6@nvidia.com>
References: <20221113112424.1049834-1-sagi@grimberg.me>
 <20221113112424.1049834-3-sagi@grimberg.me>
In-Reply-To: <20221113112424.1049834-3-sagi@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|DS7PR12MB6144:EE_
x-ms-office365-filtering-correlation-id: 94e753cb-1ed2-4e88-a02d-08dac6bcc871
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  1gT36ekW00CJK+N675K97+p+/wwJWHr6C7ypEaspiZ2iiqMDApjqsV683DVSS5XaigdRW1BtWQrh2MPYlkMuQ8RiypYUFgtjybGeD8CgO360icybu/oWGYhQo4mFAUBSmfZA1uDEQmzEHVdMBQ8hzGi0QHhTUWKid4pfnrONDLRLWX5/SIECuGHLJHMhL33p1dByDrBucQkJfeWP0bC92P4Oy+TaQMu3Q9ta8PXFRc/YXfe2ItaIeZ4pbJ561b0gtZvw40JOVVlgyK4MezwHZR8p24T2/l3ujmVdKDjPGDlWI8N2vpA5ttINlrNguC9Tzbv0Go9ms1Q/3AAq1UqgKucPQhmG+LosAhmg3uUhsWRKej7nPZg+M+7Z+b0Err+Qnj5sIDfcM2npRIqLjaIGVqQ5o5+ljGSm34BYC9/BHzyaxw+Umxex8Bwk8bCxeRXzYaSQdVOe9Ut5omGnKA6gWeyknjmAYS5IDimgPnBzsSATio2DdN0rqUCfocNnZ5dJXnYPFEokhU+I1C+82PNvZcPizUtkb2weHCiD7AggqsAKAfFpNHlarOu0GwPjBwPis3en0/M32XPw8xUj4vf3AMjQBJHYymVQjkZ1k2xb+tMp2aifHfrT717ZrDwPF/Owe18DDxNgviSEkpQ01lGHDtZ3bbS2oxpBmNpb5a5WNTRzNjpv9qHrNN3KE691jLqHMp/tQ2KO3oeCN79VzjVpCi8lm2hou8DcDfo1chOy5I1CwoD5W34V6XgvEnArHceZl8lLgyYNXMIClHKGj3DM8N/74pW6EP4/ndbNgFjzzQ4BW5srKiuxwbfGPTQQcYpS
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(396003)(366004)(136003)(39860400002)(376002)(451199015)(186003)(2906002)(2616005)(5660300002)(41300700001)(86362001)(38070700005)(31696002)(558084003)(8936002)(38100700002)(122000001)(36756003)(71200400001)(316002)(110136005)(6486002)(76116006)(4326008)(54906003)(66556008)(66946007)(107886003)(91956017)(31686004)(66446008)(6512007)(478600001)(66476007)(6506007)(64756008)(8676002)(53546011)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?utf-8?B?YWdHMk05TitUdjM3MThheFliY1QvZ3k2bGdTZnd5MlRPeVBRNTZlUmF0N2ZZ?=
 =?utf-8?B?OVNRWUUvS24wNUFMMFJLaDJpM3VVTkRaR2Q0Ny9XUzZwc2JwS21vcUdlRlE3?=
 =?utf-8?B?WjhEN0NDK2d3MmN1NldRWCt0YWFLdU15UGZvM01aakFWeURiSWdLTy94OTky?=
 =?utf-8?B?THhoQUF1NlBQOHhVOG9yd1lzTDNDUDUyTVB4RWNYaDVBN1paSjBldmpmaXBR?=
 =?utf-8?B?OVdXTXpiZUJ4enRyMTU3S3o2b3RRUHYrNFdWWk9wU3pCT3JOR2Y4WDNhTmtC?=
 =?utf-8?B?WU9BVmJvVE1YUFJITXptOURQbnhhTjF2ZFpJU0JkQ3ZDSWJxMHJ4Ni8zUUVL?=
 =?utf-8?B?RW9rTm1Lei85Z0xvVUhXdmx2bzcrQUVuZmNIVW9vZ09ZS3lmajgyQXZPMWh1?=
 =?utf-8?B?c2NjSEtoUWJVRTRobHpqZHkyWjh0eUNETHloQVpSayt4aUI4SE1HdUU5MW5L?=
 =?utf-8?B?NDlIYWhIeVhIRjJNZThVbExMME1UR3pTQWt4KzlmaUpZWkVjTGFqMlNTMm1K?=
 =?utf-8?B?RmcwL0paUWlrTERiT0VaZ0ZhNzU4YkFtNlZ6cmtqRXplM2l0bkM5dUM1OW1k?=
 =?utf-8?B?eTlyYnNMb1g3ZDlrQkh1djljS2tVcnNmUEVRYkRtU21EQ3YxTHZ1M0s3SFlU?=
 =?utf-8?B?cERGYmlmUi9wOU9NTk1MQ3dKMllOYmlDdjVWdkgzaEJCRzFkMkVMZVJ0TmVL?=
 =?utf-8?B?ZlV0alIxOVZ6OWVGOENyQ2c0TVNLcCtJNmx1S2hlaVVVZnNGNHRwaTF3SkNM?=
 =?utf-8?B?ZHFUOERTT3ZKdnVqaytmeGZxS0h2SVRBTTBtVjc0cS84cDl2ajJpMDU0eno1?=
 =?utf-8?B?WSs0TldVcHQrSlpmbWRaZDJOK1RVcVZRa2h1d3J3TjlzVHpFNXdXREdmSVJE?=
 =?utf-8?B?QzMrcEZKOFlxelErQWd6bklQNFBDRjVCazc2bklGOGtQbW9Dd1ZFTHZrM1hO?=
 =?utf-8?B?QUZvMFdCWWhiZDlFSFFrU0VSWFVsVEVacGVWL2E3VWhoU2VlNVRITzBQMmxv?=
 =?utf-8?B?aDgyWithaVEwbEJLMmVRMk1lYU9qUVF5WWpSb3RWTGUycExWanVrYjYvN1R4?=
 =?utf-8?B?ZDRJblZpbE4wcUhsaWJxdWhMYzJsVUxCRlpBdnpmUC9WeUJ6Yy9JcUdwa0lt?=
 =?utf-8?B?WnNRaVAvb3RpeEU0alVZS1VqVXZsV3lnTUYrdzVZRjFJUVhZb2J0VVdHc25i?=
 =?utf-8?B?Z3M3cG1QSHBkVFFaaG1GVTd3Y2gxL0ZGNXZ2c092R2dTVnhCTDBqVFhuWUV4?=
 =?utf-8?B?cCsxaExkRzNGUzljQ1RYcUd1aUtHYzJta3JoR1FUVjl2Q01pT1o5MGloY2dQ?=
 =?utf-8?B?Ly8rSVdQTDFiN0hsNnlhOGVrdGVZN3ExeGlXbTRYZzc3ZTNLQ0t4S1dnK3F3?=
 =?utf-8?B?bWRIdlNzaEJXUlA2ZitZbTRWSE1aWXNkQWhKODF2T2J2OWdmaElPenR6aW16?=
 =?utf-8?B?eDY0S28wZU9OMnMvWjZMUkQxank4VzVTZ3VIenFzbDgwODRzUmJBUjBYbm53?=
 =?utf-8?B?a2h2QVdER2JQTWNxa1pFNkhWZkNYMW5PdGYySDhQWFNFWktSVm1KR1Z4Yk40?=
 =?utf-8?B?em5GS3FLTFhCUlRiRjNFejZlL2wvSXZXRnNSbHU0WVNSR3hyamNiMGRKWVZM?=
 =?utf-8?B?bjlXb3EvVlNHNC9hSnhuc0p4WDJ0OWgvSHhTT3pDTzd4T29LaTNWU3NmQWFr?=
 =?utf-8?B?Q3ZrNERKOFVIV29kY3VINVdHUFViRzZuZVVyWkpRQUNOaHgvaytsckl2VzlH?=
 =?utf-8?B?cXRzN1d1Z3diblZUd05JVFFZL3dMdXlDTENEY29FMFBjY200VUxGdGpIQ1Bu?=
 =?utf-8?B?QlJqR2RzNkdWSXJ2YmtuQ1Jzbkt4a3ZvRG9rMHB2TStNcGpNZVZUeUhYclJU?=
 =?utf-8?B?bjFyRkE1MDFadlJ4Y0ZqU0FqYzB2bGJtZVpaV0FJRmdkSnd5eDljcVR5bXJ6?=
 =?utf-8?B?YmdLUkg4eHJXU0dHdnlZRk55c2ZDcFBEbUZ5WlZNQ2JZZHhEZjgxbjcyT1RT?=
 =?utf-8?B?OEh0VHhKV3hZKzZrVFhCOFR6OCt0ak96NmRaNXZNdDZiSG5BWnViUGVZUmJa?=
 =?utf-8?B?dG1IWTZvVWV4ZVJnd2wyT3ZOa2RzOUNEeWtqTXdaYXZsOEFJcTUvMXRWdHRX?=
 =?utf-8?B?L0ZLQmQyYWhJRGFvYlRFVXVuTDlFczFGWnZkT3ZhQkVzVFVtN2lpeGw1aWtm?=
 =?utf-8?Q?bmV12j5F+BekNLh7eJ1H2PYqhbc8VpFihxrkSMVXWNr3?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4435A90BA5F5474187D854D2870E14D0@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94e753cb-1ed2-4e88-a02d-08dac6bcc871
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Nov 2022 03:52:14.4762
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4HJXcwYd2dNjzPpFk9XApR+hkL4/slgLuKCziEBuUXGIsBzFenhvLfbG3Tn0AbswQPthERJg13yPYtXbtCsO5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6144
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221114_195218_220837_881A6AE8 
X-CRM114-Status: UNSURE (   9.45  )
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

T24gMTEvMTMvMjIgMDM6MjQsIFNhZ2kgR3JpbWJlcmcgd3JvdGU6DQo+IFVzZSBudm1lX2N0cmxf
YXV0aF93b3JrIGFuZCBudm1lX3F1ZXVlX2F1dGhfd29yayBmb3IgYmV0dGVyDQo+IHJlYWRhYmls
aXR5Lg0KPiANCj4gU2lnbmVkLW9mZi1ieTogU2FnaSBHcmltYmVyZyA8c2FnaUBncmltYmVyZy5t
ZT4NCg0KTG9va3MgZ29vZC4NCg0KUmV2aWV3ZWQtYnk6IENoYWl0YW55YSBLdWxrYXJuaSA8a2No
QG52aWRpYS5jb20+DQoNCi1jaw0KDQo=

