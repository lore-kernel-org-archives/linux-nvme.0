Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17EB3C04A95
	for <linux-nvme@archiver.kernel.org>; Fri, 23 Sep 2022 17:35:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=u5m1KpiihjCwevf+ybCpYq9ORfW+jTcC4Mt5ZfTQ1z0=; b=HEu/dZqDTK0TMAKdxEhwlfiStQ
	OpBzgau8H4iMAFa6v/vY3JIwmnIKzZBbnfxvcVR/p5+xVGliQJtNzg17zY+csDuAj9VYa9d5JbWn8
	Eo3bJmbkh/nDOEgBAtMmdbFwJ4eEy2VmxiYCv7eoWIe7zfJxUmT+hdFT87t+gkMcYD1wBpVAa7dPv
	Ht1i/xvBrf9pS8oUtHZFCpCvWbwnayUtThCw1Rq5YIDXi43V9oqaCjwUOCz5qkDJfFZmBwbRj6uqf
	UGNRToadolQvJAJZOPupGDltH15GuNfxyi7H1dd4STVRp4qhtMlcoHto34lzpVv+Vv4Dsj1AE0ffC
	WaWvgirQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1obmaL-0059US-NM; Fri, 23 Sep 2022 17:35:33 +0000
Received: from mail-bn7nam10on2071.outbound.protection.outlook.com ([40.107.92.71] helo=NAM10-BN7-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1obmaK-0059Tf-42
	for linux-nvme@lists.infradead.org; Fri, 23 Sep 2022 17:35:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Km7VOuv82pXmCWL28PXDnlPDNQDOD5EMDaxNNjyzHEEJi/eqMQWTNOLmcIuYJA+RxZQmKxw3sjx/DjO72sE5tHJlkV6OF10HrKpNJ4SrmP0YoX+GI7PsDWnGviskmhRvgu8462JqPJthDO/jvZUNQnHj+lFhgIujDC2i+b00sz2lip1znY3np/XaunhX+fFTooUHlXgAxFOsQX+GaA6ZzrjdmeX/vYUq0W1hOnyf5cZZrCa2f/PAywgbhJRm8AgsDIOLvKy1CQSulmwMrZylTSxzBCCTcFnWUxfk85JgNWkSW5Lyz6xcTIGYz2OK5Y1qAB/SZEh979ZVC9jIgWEmWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u5m1KpiihjCwevf+ybCpYq9ORfW+jTcC4Mt5ZfTQ1z0=;
 b=oFoDkoSPfRtebVj943NpZeRoLLaCwCGr0UAcRmuYVtNv26iL7Q89L2FihCZK9xScZVT3XXNIc34CtwvOeU8HbXLABH92SQPAgNnFNQBj1iY34Tc+tmVj0ObiJzM/yzag5O6Kn/Bq3h/OeWnb1eUQAO00UHDj6IV9zuG8On/0yyWnrjiZyeS1HfKz8s1AbpC5PUIPYrXE5+p6yI1Wkpv0LenV/kWplU4enn0urjsj2Dlv3BeTlyxGl967uOrvWRsPhrBe5rDOE8/C++3e6zxkKO7hBUJaj0nxpRh17Ky/zfePHi0hfxcGiLzKQnlReTuKeS+bwfSEPKgkIZ8o2tgJQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u5m1KpiihjCwevf+ybCpYq9ORfW+jTcC4Mt5ZfTQ1z0=;
 b=bffgGAzGKdNy4ZH1V4tVfPDFvSXQOLdWsrwUKx/MBbYVan7TniMqimrE2VvZeMiWxL9WcRuJm8/aGBeVBd42U/LiuyPCrsgjUqtB0rcXbQolmeugMJ5rw/OEGLM5E9XU9QyefVFY4lrz3cI/szUTRaOCXEwMP1d/8rKMO0AAHn8kxb6J8Nu+o7b/6rIm48voSEzuER30rsxGmPE9fu3tke9VT5KITzBCEu1JYgOMBYeveWg1uUQ5PfYxofYFnU7g4XWsDit1N4ohRm0zlGsemWQxuWAtIcr2CfcCjxryNCFJYyEqzIaZbJ6HiKGJ69PevfXfkz6uQIKpGuWxw8+ONA==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by PH8PR12MB6723.namprd12.prod.outlook.com (2603:10b6:510:1ce::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.16; Fri, 23 Sep
 2022 17:35:27 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::3d10:f869:d83:c266]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::3d10:f869:d83:c266%4]) with mapi id 15.20.5632.021; Fri, 23 Sep 2022
 17:35:27 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Christoph Hellwig <hch@lst.de>, "hare@suse.de" <hare@suse.de>,
	"sagi@grimberg.me" <sagi@grimberg.me>, Chaitanya Kulkarni
	<chaitanyak@nvidia.com>, "kbusch@kernel.org" <kbusch@kernel.org>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH] nvme-auth: add a MAINTAINERS entry
Thread-Topic: [PATCH] nvme-auth: add a MAINTAINERS entry
Thread-Index: AQHYzk1j/OpsqwVUuUmJTarHsgyqEq3tSSGA
Date: Fri, 23 Sep 2022 17:35:27 +0000
Message-ID: <2921b18a-34fa-f176-e670-a82ace8c1a91@nvidia.com>
References: <20220922063429.1573089-1-hch@lst.de>
In-Reply-To: <20220922063429.1573089-1-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|PH8PR12MB6723:EE_
x-ms-office365-filtering-correlation-id: be10bdc4-b313-45a4-7667-08da9d8a0113
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  GicKoyiqIhPUAbIWguoWrd3JSpRkZYrP086e+owZC062JY3ZBn82MppLuh1nfXuqnO6Jed3zP8/2dklwzU7xETrCEItwMCbjSEETRHWQanP+OE3gHp8uSHLnHT74ZIYpGzi/JyfhHEDr0g6BsoWFipOHkQTYbLZxFfdgQU2QBLIM75ndf1YyVQC6Gl9/CNA2seM3d1bozTxnDrToewIzHx9FvGgkAnkcMJBLv6GsQA5iE3nCMIZ0cdhyyEWIQy8Ln1KvQsO+kz/mXnV99eY+HvOoptBanul2jGLBB75l8aOXPzCzT9kzhq8S94Ej3BPWGuFEtZNFrG3TqFdEg5E/Lz6g1QU/VdUa8gRKYIgkJFFQA6SUzUy5ALuz2gWzPOC5R/WKhG21LqmIKMeCW4xjVogH7yDfCtxLhTfuzzUBL5Z1jbN7i3MCsBYiA9i7HumE/OEqaXf4+OZKSplpa+PGzJ6JiAFI5k1Wlv6MrSoTBCfpuj9JvdO8icKnRZLzV/ceYwc8A0XztZud6dfaiefFYB9UOugHPMJf9ckuAsRzjjAsOUKkUkLBRKdZg+lQ3qRKhEhNz2EJK0fSybSa2UBIrtKD5FUdEv0b0mx732xKWrhelIik5JdUYUTGofBtKcQzWiZvb9LBAG6TDWBiVJcLZNFaNNCoA0qp1d0y8rpW0Q5nB3bxrvkSQA4OBHdL0b+8qDDo6FMq5zILB1cF631jYXgWoUoBXP6m2Hejj35kkISvFl1604ZbPtOXav8DwPIAJXlyeS1P2LrgomZFPUGoBi/rfKXlijQ3vggNdIZwmwpdRMYSFtD7W17KOZKWuiUlyzt40jn6cFCcyqGP9UL5oQ==
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(346002)(136003)(366004)(39860400002)(376002)(451199015)(66556008)(38070700005)(53546011)(122000001)(8676002)(38100700002)(110136005)(66476007)(4326008)(316002)(91956017)(66446008)(66946007)(76116006)(64756008)(6512007)(2616005)(558084003)(6506007)(5660300002)(36756003)(478600001)(186003)(86362001)(71200400001)(31696002)(26005)(6486002)(31686004)(41300700001)(2906002)(8936002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?utf-8?B?NXdnTUVhSW5aamUrSlRkSjRqZWVHc1hodk0zQjJqMjhrQzV0YVJWcjVjRDVB?=
 =?utf-8?B?YzYrM0FQZWFjNUJWcnNTSWxGdGIxcHZOajRncS9KTzI2d0NNYUN2Y2VYK2Rw?=
 =?utf-8?B?a2hmUDZ3QXFVaW84U1VBWm1PcndwS1ZwVTVqRXY2MnZrbHgwQkg1aCtjODhl?=
 =?utf-8?B?TUpwekhVSTdxc0k2a1U5WFF2VUhSNGRxdU9hNnBLTktWTE9FU3dTZDZSYU9S?=
 =?utf-8?B?dzJHdGthdjZqNlZUdVgxcmh3bTNyWERVaG5MWEZzbUVFdlVkL1c3OTJLL1RW?=
 =?utf-8?B?Zjd1UWo3OVZPdWdWWGdncEpoSWd1bStTSUdpc3hqdU1kb3Fxcm1qb3ZSZEhY?=
 =?utf-8?B?VWh6cWhiczduTHFFaHp0cXNpQzc1eWxzWDE0YWNpL1BjM0NpT0txNUx1b1dO?=
 =?utf-8?B?S3RHRG1NQWF5UHpRWCtEZ3N4aW44K3FYV0ZZQVozSUJKK3RnRG41T3ZVMjhh?=
 =?utf-8?B?SytiZmpidzF6VEZ0dVlLeFhGUlplSy8zMlVwRlltUEFjZUgvRG9yNjI2VmVF?=
 =?utf-8?B?b2wvS3R3bGk5SGd3RGZobjVuWTZXaE9PVE5OdWk3SndqZ3JyZ0sxS1RGaTQ3?=
 =?utf-8?B?V01MVVZxNE1YUEVpcmdNVGkxd1JWbUZSV2pJbjJOS2srdU1NaUI0d0I0MTlT?=
 =?utf-8?B?aEduTFMrZXhuK1ZNbU83VG4zQUxDQWtBY285dkhuaUhVN3k2bUVhNzBSVHFw?=
 =?utf-8?B?Y1V6dE9ObHNyVDVjMS85OVVGUTdvRkJTMTZqdFdCdjZ0UjZyL2psMWZMSFlU?=
 =?utf-8?B?S0V0aVZCZjZQaEJjTTZGNGNZR1BMdkVzM0RBWHZJdENndTF4OHN3WEd3VTh5?=
 =?utf-8?B?K25sVjVPb25ubnR1MlY4SHpYNVBCdlQ3UExKVzE0TmpHaXJVODlLNG4vVWh6?=
 =?utf-8?B?Q3g3OWRHUTNpMXNqVGw5R2JhVHVGQ0JzU0lsOW1MN3RMUTVyV3Nwb0pqVUdW?=
 =?utf-8?B?T2twSjdIejd4VlJvcVRKbVNwWDRtUGhWajgrQWZ4Qjk0cDFjb0w4d1BrblFj?=
 =?utf-8?B?bnppLzJEMVM0U3JlblpQNURoZFRlNEJtbzdHV2Y1V1NpbTBBaTlIN2h0d1Vk?=
 =?utf-8?B?bGJOTkFZN1Uva0lPYllCRDNqSjA3SXhJY3RQQ3BPUEMxbW80S1FDWVB6akY1?=
 =?utf-8?B?MFVqS1kva0ZKVEpjY215OXNrQlJvOEV3aU9kSmVLV1NCSEMrUkVLd3VzenFJ?=
 =?utf-8?B?bXhQdncvZ2w5aEJMd1o5dlZWUHlkWnpUOGVUK3dLZnVxQWoyeklnVmpiYUJr?=
 =?utf-8?B?ckU1U2JkVnRycDZXTnFlYnl0YmRFcWU3OWlSMHdrYkZoOHF0QkhCUlRqeEF1?=
 =?utf-8?B?dTFwYnd4SzRxWUFoV3VKcXVyNVM1WldXc3AwRmdJaU8xKzBQckVBb2xNMzlD?=
 =?utf-8?B?T2ZFL3BuUmcwYWJqM3pLM1dyRzFIVVV0ZFN2MEJ1LzZHWXZwc3FRQURleWtj?=
 =?utf-8?B?cU90QjJiUDMzTHRPd2J6ZVdjMklFZnNRdWI3cFN3eHExZTF3RHBWZEpLTjJE?=
 =?utf-8?B?RTdTMG5sR3d5RlFEUDNvR0crek5pY25WN2RtVXJweHRUaHBlQ2ZkOCtobUcw?=
 =?utf-8?B?ckkxb2VKMVc5SGVaa1kvT3ZjcWM2d0Q1U2NGQ2tLbzB6djMzN1o1VWlSTDR4?=
 =?utf-8?B?b2YrbnA5b1dTaWExU3l1R0VDSURFRnYxY1NSQU13V3FhMWxKbmVjNWoxOFFz?=
 =?utf-8?B?Z0prSkN2dlN1eUxVTW4rZEliL2VrTTdGbjNaRzlKYzhBcHZtclNLcXRENE1y?=
 =?utf-8?B?MFNoNkM2ZnV3cDF6UEFSMmZLRzN0Q0k0Q21TR21oeUYwcmRsL1BjN2pXTjBE?=
 =?utf-8?B?Q3JuRTNqbVB3Z2Z6bFNBdHBaemhXU0hmSk10Njl1bnRGanhERkpIUG9uWjJz?=
 =?utf-8?B?MTlxeHBkd25MR1JoZ2dST2J6YldIWnhJYTRwOE5wQVk5by9pVGtLZ2VSMTJk?=
 =?utf-8?B?K2xnZW5JaUlReE0zcnlhL2kwRjlMTzZvWXBNSWpOWHJpRi9pZE9kajYweGs5?=
 =?utf-8?B?UWdZRE12dm8xWTNMME5OZWdiWUdjYVZzSjhjbUlrT291M0RyQmRZRjFMczlJ?=
 =?utf-8?B?UWV6TGE0L0krSkpEZFJRY3pxNzY4cVJrT0ZWZ09KRndwNjRQbUxYMDd5eFg0?=
 =?utf-8?Q?NLgCQEwqCR/cKWHfC5TZuv3bd?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1A5AA4F22AA08A46BB4901E099C4207E@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be10bdc4-b313-45a4-7667-08da9d8a0113
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Sep 2022 17:35:27.5134
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 29Il/CRbStzKOjpy2URfkHA6DM8EdZp7/Z7BNzcIYq46kCGVIvRufaoPvgHzExSJIU+yvzXfmcZqeVIGXsxhLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6723
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220923_103532_179870_978D3ECA 
X-CRM114-Status: GOOD (  10.01  )
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

T24gOS8yMS8yMiAyMzozNCwgQ2hyaXN0b3BoIEhlbGx3aWcgd3JvdGU6DQo+IEFkZCBIYW5uZXMg
YXMgdGhlIG52bWUtYXV0aCBtYWludGFpbmVyLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogQ2hyaXN0
b3BoIEhlbGx3aWcgPGhjaEBsc3QuZGU+DQo+IC0tLQ0KDQpSZXZpZXdlZC1ieTogQ2hhaXRhbnlh
IEt1bGthcm5pIDxrY2hAbnZpZGlhLmNvbT4NCg0KLWNrDQoNCg0K

