Return-Path: <SRS0=Ydhk=OG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F996C433F5
	for <linux-nvme@archiver.kernel.org>; Thu, 16 Sep 2021 17:02:31 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A65C60EE4
	for <linux-nvme@archiver.kernel.org>; Thu, 16 Sep 2021 17:02:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1A65C60EE4
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Q+ZA/4R2CrJOMGqK8/L5dccpQxlvKjfLpwnRFG8BpIE=; b=Tlv51nBsaHx7Kb
	5fSlNLd1hVbDwJGtHRI3ovQjxzLjS49AGheE7NbDCofHITU+DE+HUt8h3N4fmFJDIJnziSEclceZM
	BT5daATbOZM6vA1XFEyePnT21h4k3AbAQNLvJlWXBrYi32MBmpe+3vj9kzGRl/saWZ4vyHQpNxKSF
	/0aZ4On/uIgZvP5HJiYGPkhZIgMuWNCExAIEum0+Zr7x71BvQrzRW+I7rEAaHcgS6+qTTkVp77Fdl
	7eKk4KPdqqF5zTns4Pn5CYNLAuI1MkGDqkkm7qWyKBxkiShooD0LQWXR5HxNYJnEo2vkVqjNigLoe
	L23c2pX1bjM160Ovm+3g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mQumK-00BoPc-4k; Thu, 16 Sep 2021 17:02:28 +0000
Received: from mail-dm6nam10on2065.outbound.protection.outlook.com
 ([40.107.93.65] helo=NAM10-DM6-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mQumG-00BoOH-VC
 for linux-nvme@lists.infradead.org; Thu, 16 Sep 2021 17:02:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lqOm2XIWYduVNFLkm/VyTz+tPWDYXTNqDNVY3Q6Em2UF5cI5HYs7FjsQIJVzwNCuVALSdPgPcfGgSEbW6ibrHr+nM9DTLfdM/KJjKjPXpa6vyie2/P6lfqJDh3D21zg+YWZBkI2Cp4lzp37A7dgf3GOE5xDQLn6EG9RfAhuA2NVNYhokoUgR87yW/JBI9EkbuD0EVk58pJ5dDIoByC+Wg9SWIXgLaNI4fsxIMrPK5iUwToi2Y4EyAzMdRs6XBoEIDwqES7Auq5OiXAb8mxE5fqaI1pCucllhOQyV6NUyUd/dmDqzxM03dqHsl2b1T7ayx2VtsIcS2JGOlpOddWWNww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=NktXzgTHwyX6G3mRE6QygPgCH1JGbw8bb4PMU9xQExM=;
 b=exdeeHdicxp4fxImbANM0rRFdS5l7WHyfyvZgjovmHWOucWmeRf4umGZ8F82CtYLwmNXD5SdDV1GpA0NyyE3zciLu0ElL0//h2D9AVbuv7lzVPS3sWidJ2+0SiLb7APrGc6t6H/ggmDfqOAThMIjx7ccDikC3Tolq4IlTh5VK5C7L+d+DQ8Dfv6yPxI8c+tLDoJybMNKSj8X17BzaBrm51y5qVYNPI4HfnAxCeECN61QlpLkU6iWFrFyGOoZpgljyAgywCH0IWJTLNLuj4GlktQyKjv+8KAZWj/1gFpyKbF9YHqQgW08CjdXWy1Kvh0w9KXDbLykTYSxYs9gQCwEKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NktXzgTHwyX6G3mRE6QygPgCH1JGbw8bb4PMU9xQExM=;
 b=Nm692NqrorUXq/c92MGYEQLPOSrKUWK0JhvtbR1uG0zp7NIZUw8eVJBFxVdxAYXawbPX2Dm3o0aY7B2GOt62cJAZpaYxD7bf2wco77M3JcV4TyVKYIkeA6piW7Cx9vcDtp5XJ1QnbgKkseE4xQl0UD/yvPbj/NZofoDzg4uar+307a2qiIryWyIteoEvicfU1BqNG5jV9S3xRlG74m27bUXSe8zGGKbA90MmW2My8kr8zk6DzWKuUM6ZMixvP1p3h6lKdUlmrJVr8oGMNqZRJI1LcWAMaG5yLJDCdstEoGLrJ1nIIVsQ3PvYsfvWqQeJMvhmYUj1U8MU5Rbv2Gya4Q==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by MW3PR12MB4540.namprd12.prod.outlook.com (2603:10b6:303:52::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14; Thu, 16 Sep
 2021 17:02:22 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::498a:4620:df52:2e9f]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::498a:4620:df52:2e9f%5]) with mapi id 15.20.4523.016; Thu, 16 Sep 2021
 17:02:22 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
CC: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <keith.busch@wdc.com>,
 Herbert Xu <herbert@gondor.apana.org.au>, "David S . Miller"
 <davem@davemloft.net>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>, "linux-crypto@vger.kernel.org"
 <linux-crypto@vger.kernel.org>
Subject: Re: [PATCH 02/12] crypto: add crypto_has_kpp()
Thread-Topic: [PATCH 02/12] crypto: add crypto_has_kpp()
Thread-Index: AQHXpg+UF89+9Y6WWU25XL4w07O8bqum7RsA
Date: Thu, 16 Sep 2021 17:02:22 +0000
Message-ID: <880cee4a-3302-2b90-d4bc-e6c9fa555d21@nvidia.com>
References: <20210910064322.67705-1-hare@suse.de>
 <20210910064322.67705-3-hare@suse.de>
In-Reply-To: <20210910064322.67705-3-hare@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
authentication-results: suse.de; dkim=none (message not signed)
 header.d=none;suse.de; dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c23966d7-aa91-44db-8255-08d97933c055
x-ms-traffictypediagnostic: MW3PR12MB4540:
x-microsoft-antispam-prvs: <MW3PR12MB4540F2AE13FF0B61244AB8B4A3DC9@MW3PR12MB4540.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:431;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vYw72oW65LSHX0Z6cDHA+C6geehT8XczJeObmN03nmEHRH5L4M4S35VARuu/O3aR9VzahGK/krJlY2lCZHPuY4jgAbHO57VQL1cwR71mGz0k717gltiwgkXzHmWkefe1rMune95A4Tmz3dBwGQuLjj0Yzo1kiTLQcrSy14Ye6t0MPYAd1Z7tEwAm7DooRvNSXwv78l+Hy8oJY/+HTRWu7InkW9/fHJ7b8UggBzq74bkYo5q7RKusi+OzPNpy5rWzcEfRsR+Yonsbm0cjrfKO7p7yWKU/9E77NSRV7twTNdIhm6xX+JUX5p5WAI2isTF8Vo+hZcGwqIhaYq1RkaONRMA1XpCE5tL1BZCLkHvqxFhvr0jwxd4TJgwFLpcj0r9ev5tJR5EfqM8NNtsJvRDfJuea0NuXkqDdVSq8wzXD8hWuCpe14f7E4TLr2ImSme9+KtCnFSA7ZjW2sT84M16TzO71loQ2AKwJn1FQu6qDb2TDalRcmm7HP1DJXpTtZlupNI4ArO6S1OZxs0D/cFzEAqtPBOWR1JZVMp3rhJpaqJe48+1CZUfBk1tbB2byeHlvwmvz3Hd8Opk7WPdD3U2MyUBToTxFe7fUwyQ4b/kEBZf9NiEJsaA6+opAmgxseKE2nLb+FC5qlm0ogxqRoq7dU8ZP14xQHsm7Pn6UULJnTZaobQkTtQ6BHyXgPybhXjaDp8WENxgXbw5lJpaNftk/nySe58wz3Z4yM3uQkwl6p5BNDYhXguQcrPSmxmbGlWd7owUD3/yLCTYnHB1d3edxeQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW2PR12MB4667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(136003)(376002)(346002)(39860400002)(396003)(66476007)(66946007)(38100700002)(64756008)(2616005)(66556008)(316002)(6486002)(66446008)(122000001)(186003)(478600001)(31686004)(86362001)(36756003)(2906002)(71200400001)(31696002)(53546011)(6506007)(54906003)(110136005)(38070700005)(558084003)(8936002)(4326008)(8676002)(6512007)(5660300002)(76116006)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?K1krMEdPNFU5T2E5dHdjSjdMSi9TZDYvMXRzakVHL2tsa1ZkdnQ0c05HZWxF?=
 =?utf-8?B?SDMxTXNlc3NVRG9vWVYrMXBlMnhnMUxNRFp3UlVORy9hd2xpb1dwTmFQcXpP?=
 =?utf-8?B?NlozQ0dhL2dOc0JWc2R3c0dnY3lWUnRHTHZlM0xqbldtRDRCYjJ1d1VHYjRk?=
 =?utf-8?B?SEZKY3o4TWwrdmlqajBIanRla0ZTUURYUkIzWkRrdkg5KzkrY3h6OGV1NnpL?=
 =?utf-8?B?NDh0MlpVMTFqeFdCbWhNb2lYK2VHbERnZFZLMmNkdDc3MW5QbENPdnRISkk4?=
 =?utf-8?B?WHdYQWxDSUpKV0lpOHZjWEMzOE9haUhIVkNzQ2NuMmNtQnc2OEdwVHg3NEo3?=
 =?utf-8?B?V09nKzI3S1g4dUxHWkVMSGxSaHljYi9LL3JPTXQyUjZyb1BpVGRpVVFDVVFR?=
 =?utf-8?B?YlkyV3E0YjlEUTlqdTBtSXdXemdhdDU1WmpFSHc3Sm9mSjBtTDJxVU8vd212?=
 =?utf-8?B?dGQwWFVtSU9jRGRLcjhZckhWSjV5Tk9DVGJwQkxFOHpSRGc2NE9tdDErTjlK?=
 =?utf-8?B?bCtjV21YQnVKb1pUVnJMd0FSSXNNOVhCTW56ZHlSRXpSSUYxS3E0OGV5SnlG?=
 =?utf-8?B?RGNvdDV1ZjNqWktjMzRVZldLalVXNjBrSy8zeGQ3dURvR2o2NkJiVzhscGwz?=
 =?utf-8?B?cld1WnVPa3F6K2plVGhqMEphbnE2N2F1ckhoQUg1RmIvTm42Y0JDMnF2UnZQ?=
 =?utf-8?B?Vm9QMXhQQ1drbEJ0OFR3RGJtT25hamYwZk5QY3pieGtLRmxWMmd0M3pneEFF?=
 =?utf-8?B?RUtKMWN5anJ5c3o5bzNnRlFyYXluYzRGLyt0cjhSOXg4TGdOYXpTdzhPWTl5?=
 =?utf-8?B?aHdZNWFvMGU5ODNvNWliMkY5SEE5bkxrdGNuRzBCcnhWQkJIbjdYby9nVFBC?=
 =?utf-8?B?c2V1T3RSS2QrdjBLdW94bGJwV0ppZER1N0VWRnpkS0c3SzFtZWZRellRanQ0?=
 =?utf-8?B?Wmd1N3hRcFJlbCt3WnllSDRoMlJDNlh1NWdHMEMzaEZ3YVo4OGp0eHB2a0Nn?=
 =?utf-8?B?S1JoWGZBRmVQWVo4OEQvQWY2OUdIcDQremRFc2tndW5vLy9PSGdVUCtCOUQ0?=
 =?utf-8?B?T2hBV2wxY3BheElCK1RiRWJ4L1FZd0loa2RETVJOaFN0Y1JhaXlmbXRtMytH?=
 =?utf-8?B?UEVOOEdyaWZGSG8yK25HRHIvZUhJT05GeWcwek5RYmFWeURVRmR4enhyVmh6?=
 =?utf-8?B?WDBpK0ZKMjNFeXhaNEM0eEZXMC9FNDhOa0JGNzFldEtJd1FYYjdhR3VKdTJm?=
 =?utf-8?B?MUpjMzN4TUxGMy8vdkdSOEVpdTl6SzRPSWd2SXRIZzVMVEgxQlNQWWk3cFI4?=
 =?utf-8?B?V21JN1IwMlV4MktpVjBWVnVWNThzbEF2MTZXOWM2RzJERC9BWVh1TmRKZjky?=
 =?utf-8?B?Y01wbnoydDVlUmU2bWg5TFRWUysrMkRvR01mZk5UZHpkb1NmZVZJTXkxWXJ0?=
 =?utf-8?B?KzBDUVdBUnMvOTlFZis2VnBERkl3czlhNkNFdzZxMUZNQ296VEk3R3h4REtx?=
 =?utf-8?B?MlBhdTY1MC8rZjV3TDg4alJXS2toVE13QnFXaWczUDlFcHdqSkFDbWtaMlZr?=
 =?utf-8?B?dlM1Q3BLMm81bkFqRVJ0c1E5Y2ZTWjJqWEcxTGtVK0NlTGFsKy9vUm9WbkZR?=
 =?utf-8?B?SkFSZDFNT29OQ3Q5MjZtV0Q2RjVlWG5OVWNVbGxEMkRheHdhU2NHcnBmV1A5?=
 =?utf-8?B?QmdqTy9PbEo2aDFWMVg1ZTh1RHJmNXZySDlxalI1UkVtMHluQVpXdmhqaUFZ?=
 =?utf-8?B?dDB5aUlRRDg2ejAvRGJaSDNyNXdCbnhDM3JYWHBCQUVzcmh4TUNFSDdVbW9i?=
 =?utf-8?B?ajJ0SmlMYklya2ZRRnc3WEZBTktWaEVpdkFuT1lFbE1vN3ZDaUYwengzWm94?=
 =?utf-8?Q?SDTYnchOMNmhL?=
x-ms-exchange-transport-forked: True
Content-ID: <C2EC39C0DF150041AE789AD3C28EFA10@namprd12.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c23966d7-aa91-44db-8255-08d97933c055
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Sep 2021 17:02:22.6198 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jYrquHK316JIswerdzdLI5u6VuzqY69bX7pgoVhzlfTTbbxdM0Hd4YIIPrhG1x3NWAoDfYxWNH9IIFA0dLMqjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4540
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210916_100225_072750_E279893B 
X-CRM114-Status: UNSURE (   9.50  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 9/9/21 11:43 PM, Hannes Reinecke wrote:
> Add helper function to determine if a given key-agreement protocol primitive is supported.
> 
> Signed-off-by: Hannes Reinecke <hare@suse.de>
> ---
>

Looks good.

Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
