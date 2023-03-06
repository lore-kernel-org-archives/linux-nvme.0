Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71FC8C61DA4
	for <linux-nvme@archiver.kernel.org>; Mon,  6 Mar 2023 05:04:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Cc:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mt9SclS3pwwNmfpHOZZEzay9ZuI+U7jGN0V/KZuTFrA=; b=KePt5JpnkB7RQfciCbo8asFgkd
	bcf7S+ecVNjecrKpGiEU/PSs4oM9uXww7eueYmGUa0FCEZECeBNBFJT+9zifmUH+8Gdcqm6E4HbKv
	YQgRkES+ue92Y2Xsxm+5nAGpptdqzabWeqf9nft9rKXGj5nKbiMeyefwbc5a6dVf6IBkE75xjzL6c
	jhEyxPEFrtBr3fcAr6dIU+IITpSMrh1w6h0i9ITzjcXnDhgohsvChupw7cNqYWvCEWZTCY6QHhGY1
	Zorse1t9mUSnspzAslYdSBJhOGZJ8hOBEM3H4q1WbjuaTr+jkfGYi5ISPOdMSEBQHiivqFmvkljCU
	H+mWezgg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pZ31N-00BLaJ-W9; Mon, 06 Mar 2023 05:04:26 +0000
Received: from mail-dm6nam04on2062b.outbound.protection.outlook.com ([2a01:111:f400:7e8b::62b] helo=NAM04-DM6-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pZ31L-00BLYy-JW
	for linux-nvme@lists.infradead.org; Mon, 06 Mar 2023 05:04:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VZmJ+PPF0W+Nlm5ncv5PF5jDbcQJEVxxOhgHVSJV3iX5UzvL6vMuEbaVkRdh0sqVjlg+s7Mv2W+wuUMeTMFG2Cnfy9t2vk6BYnGw2cpzScq4yHqLApYBBo/7tmUKlpNF12hL+o/L7ds7+GFaeXYylrPTVDgdiQunufZb6OyOCkB/0X+grUCJdws8sNmUsvSWM0nbMqNE7e9jmxcxkExz5ge6m79xWN92XGNbGHocA7WixOI5ol/ypk/vc45EPE0JdPQkEHrNlPchOAhWyBkUifZ5IlI4r+UbpRTXN4qbzpDASo45ZLJIgi8vd5fSY5Z5odppWnSvYmRMyh2bh5LBSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mt9SclS3pwwNmfpHOZZEzay9ZuI+U7jGN0V/KZuTFrA=;
 b=johTRzog0NrMTkU60uLmAOuQoW5PDERBZQHvjL89x8yyZv4JTp7SogtV8zIouVglYZW/2lsCSuvZMHa6ZTG8UZP0wzO1XSo6sEX/QV2ITvwsjimYIJy9XCf2szQWkXzxhJ5cfianNL58Zk3CDiprGQSXRlqKOwncyRTY4AtvbQtxusNH1Gjrk4YzoWMKZXKemcvT9/STyu9Mk4Ldp7WIuFXq6PpagB0jhv9NE0s469ZaPqywZgGuxNh8kOPY7/dePQ2465ElxruStoB/rJ5QZI+PVgJaJsydMzhwVOpBiHePHTwSHjKhc/EwPBz0NpWZtjLc15/45pquuzx8aSL8pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mt9SclS3pwwNmfpHOZZEzay9ZuI+U7jGN0V/KZuTFrA=;
 b=f++qg8MYxf5tYu7gSeewh5cv4ANOKc7ssijUInyFC52FL3/4iWbklhxU50J+BUfkwRSxiKhGa37eOLQtwsQYiSnyleAHfxxOCnFFKmJJ5vlnV0v9QTsm8pZbbqjmpEniWGYysbP/fLeTbTogO7rZsZCpPAtvBHyXuvMEge1Rei2Je0+Lm5rgEc9wMIKwzeozSrenT9vZAtfCi5hXaU3u1d7fetMc+SKDcHTgYdTTtqHWJVNRxtwi1hIZEhh8pGJdkUrFpRjN3TdhU3IKlIJOmcj6eZzd2c7M2psf+a0tCI+w9tNFAEaHKp8MkL2dNSa2rwvuCl6IWVTM/B3VH/jAig==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by PH7PR12MB7453.namprd12.prod.outlook.com (2603:10b6:510:20a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.23; Mon, 6 Mar
 2023 05:04:20 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::4aaa:495:78b4:1d7c]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::4aaa:495:78b4:1d7c%3]) with mapi id 15.20.6156.025; Mon, 6 Mar 2023
 05:04:20 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Damien Le Moal <damien.lemoal@opensource.wdc.com>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, Christoph
 Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni
	<chaitanyak@nvidia.com>
Subject: Re: [PATCH v2] nvmet: Avoid potential UAF in nvmet_req_complete()
Thread-Topic: [PATCH v2] nvmet: Avoid potential UAF in nvmet_req_complete()
Thread-Index: AQHZT8jW5rhATLzZS0GmkUcvyKRSTa7tMqgA
Date: Mon, 6 Mar 2023 05:04:19 +0000
Message-ID: <4456fa26-affa-aa28-9837-e14375a8c4fa@nvidia.com>
References: <20230306011313.99870-1-damien.lemoal@opensource.wdc.com>
In-Reply-To: <20230306011313.99870-1-damien.lemoal@opensource.wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|PH7PR12MB7453:EE_
x-ms-office365-filtering-correlation-id: 77d37629-c8db-4798-bdef-08db1e003e77
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  9PDjgb1lQE+sBNsqUjczVH/pjl/SBgnk/J9f73Jevlj4aVf+5OLr/aTYioZ42uhLpvy9vblMrxGANmbYe+GY9uYrPhK8Wd7T2Pu6KLxRj1QlAOF+Bnd7TawqT9qxf+su+32uqIK0dNWKV7LrtRHTVdKNxsPzPdvBa80rrvxHLM8HUoT5bbq4zhhqHBaly1iYYJUM3rMWkroyOxzQLFg0s5OA1W6zGC0bMq6ra9npMqIvEmUwvyFVfrhFzHH5U+yK0Ldmy0jBjoOlBxKCz0O1Pja6/oYWZbX2t3W+NpwAa7v+erPurONpHiHLe/8H31O+fYsi873qPOPitqNLrM4R/1J9eEu4aaRWY8xfDbJN3nx52lfpyHDb+lIedqvKG/HOCIEF6FjGRJjtwKyX1aPlW1aVSt7G8d+YPhSl5Qnb+DA9xW0eR9OspNQo7+3N9StVFZ7BaCOFy2T/tT/a8bRKiG7leO5zT75yeEAznN33JqiDsmZDNH5ZvsdckMFZair4SM5ykCv+Rr7m1zQmoboiRYObFKZG9YAmV4fipxr/n8VrvYomeGyhU46W/2JO2U0uTZktD85U1ID5HqOqHXt/XTltSWQUnycSsF7CCnYhGOvHjAMqe2B/MOGq1zWzGDshc5oG/ZEQxrkA0p6PV3EN8OF34dT0FtH9szgdVNvYfS+bioojeaLvcigPhR3vHHMyp9u3U8+WM57oGI4AAkDYg8Z/Dno4FGZuIEGggfK7wswUW/vp3MUW+3unBSLr9q2Tpfq/Xje1HWCpSACgso15iQ==
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(136003)(396003)(376002)(346002)(39860400002)(451199018)(186003)(122000001)(38100700002)(91956017)(38070700005)(8936002)(64756008)(41300700001)(66556008)(8676002)(66946007)(2906002)(4744005)(5660300002)(76116006)(71200400001)(478600001)(53546011)(2616005)(66476007)(6506007)(6512007)(6486002)(316002)(110136005)(36756003)(86362001)(31696002)(83380400001)(66446008)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?utf-8?B?ejluRmF1cnhncnByaFdTdWxTOVVrc0tHeHI4Q01VelpYdEd6enB1WTc0L0ts?=
 =?utf-8?B?alZvcHdNRExaQnlmVEl4U002YVE2ejZiODBHeXY4eDkwdmJrT2N2bENsdGdh?=
 =?utf-8?B?SzlCTC9WanhYa1BqK29TYWdDcG9PampKWU04QjJFK0FDRnQ5ek4wU3BrTXFz?=
 =?utf-8?B?L1RiTUlWSnVhaEZCY1E1WmNySXIrcUREVXhvUG90bkZibTJPU0FsdEp6WktN?=
 =?utf-8?B?SUNHM1NWQWhJU2xZVmRvdS94dDl5QjZCaGtKNkZaYllVdjJzaE1saUdEcGJw?=
 =?utf-8?B?M3RtVkxyb0VsUlZEcHpkVEw3SVByUUlGdlJqcTlGdXA5WFFHaWdORGxjTW9u?=
 =?utf-8?B?Y1cydkNTVjYzZ3hQblMzQlBIT1orZEFIVUZvc05jVFVvNG5RSEdqZzNxOHlL?=
 =?utf-8?B?OE5zT0NDL0ZYcGVhN2lZM1dKZHVmbUw0cng5Qmd3TDN2b1RVRE94SUlGc2pv?=
 =?utf-8?B?bFQ1M3IyQ2VBcG50dE5CcFB5b01zMFdUR0Fqai9JQWZuU0tNTExxU1ZFNzJ0?=
 =?utf-8?B?SExVL3didUJrZ0hkTDdqdjFOVllWU0QzV2FPV0hGdXhQL3RwZ29ZckcyQWlr?=
 =?utf-8?B?Nlk4UVlwdXc0UzRTbjYzN1VRL0lBRUo1V0luRUJhYmRtcHVLWEhyQWRjTm5W?=
 =?utf-8?B?V1poOGJqaGxXcVJ3eks0RUFTMFFzc2ZIb203aVZNb0duMy93dUlWOW9GVzNz?=
 =?utf-8?B?UnUzZnorclgzcXRFY1hwS2tEdDlQVDdJL3RTdS93ZVVoMEtWSFh4QjJoL0hn?=
 =?utf-8?B?b1FCKy9LQ21YL0V2bDVkaWljT3pkUlB6Tk0rdll4RlNrc1NQN3M2dzhUNzhW?=
 =?utf-8?B?RmQrVDhlV1k3VFRBd2VuOE9hYXg5OW1FLzlmRU1WM0dVN2pFNUhpK3lnNTMv?=
 =?utf-8?B?QjA1L041R0M2RWw1T28zNDRzL1ZKUkZCN1Bkcyt4YzhjVkJWV2lyRGJwKzNO?=
 =?utf-8?B?ZytNZTJEanpaMlFySjJPdCtzdUlUS24vWk1vUVowYjVkVGhLeWRPK2xFK2Z3?=
 =?utf-8?B?R2owQjdSM3VYREYxNG92YWZIek9VVXpObXdkZnhrN1RWZkxYalR6ZmtCb3Z6?=
 =?utf-8?B?cFlJUzh0UXdiV01LRGpBYVZaZGszRzBSS29nV3RobTZsZSt3TGhMYVptV3RN?=
 =?utf-8?B?bEt6MzcxdFN6SzQ2NTZVZXJpRC9QajhPZ0ZZc25BQWd2UlFNVUh3dFYweDR5?=
 =?utf-8?B?dkY1RDdxZDluY3Q0ditnY3didnZDaFNDamhYdVNHeFFXZVVSQVFKdlltY000?=
 =?utf-8?B?NGprMlgwSXowbXA0SVlKSTVsZjB0OEllZ3Q2RDc0VGxHb29aOXNEdFQwOGxr?=
 =?utf-8?B?K1VVRkxvWVErMmhERVROblZ6TW94SjFjTCtUMGJEUFNzNWMzTkJNSVl2K0xp?=
 =?utf-8?B?N3Jub1VTYzdjOUFRZnhJSUV5bGlhQVFQWGlmUktRby9uV0xtbjdLWHVVWWg0?=
 =?utf-8?B?K3R3ay9GN0JNRi9kb0Q3ZzlYdmRqbU1temY3WUVnNGFMUWpubHZ2NUFuRitK?=
 =?utf-8?B?ZGt0N2hIQm1NTHVYZXJrNUxVK29zakxTdnRFZ0k1YnU0eElzdnhSb1I5dWhq?=
 =?utf-8?B?M2g3VDlEUVlLTXR3aURZRG9BWG1vZTVwNk5rNFJ6aWZMQWVDbENQcm1STFdE?=
 =?utf-8?B?Qmp3eitZa2ZzbGdXL1IwS0I3TG9sTE5ZTTQvTXlPeVA1YlNLZUhVM0dSbklC?=
 =?utf-8?B?eVFNSWppd2tMS0NTWUhTQmVuWmNsUjZLWjdIbTU2eTk0dy9WOEtLSDRPYmto?=
 =?utf-8?B?TVgyNklhQmhMNm9uS1c5eENETXFtbVZZYkZ4NXlCVC9kaEhLOE5uMk4xZUZj?=
 =?utf-8?B?YXpyaEhBSnliOFJHbzM4NCsyQytqZzdDUEJCbVFLMWxvaVdCdllNUlNnWFdT?=
 =?utf-8?B?d21tSkI3VUVXNDJXU2REQURZTCtuU29RUnFqb3RhYnNGVXpYK2R6WitwV2Yx?=
 =?utf-8?B?UG0zKzUwY3lqY2dkMTc2Y3BkUDZjeUtMWE83Y3RlYjJvcjhGeXg0dEtHUFZt?=
 =?utf-8?B?eVdHSG9tWmpkZXpOY3B3a29xSlNXUUdXTGE5Z3Bid0M2NmhnRWJJam1kM3Vr?=
 =?utf-8?B?S1lYek9WQmR0MTUyOXhub1lVdFVNQWVxU3NLMzRuL0Q1bkFkTkQxUUR4c01v?=
 =?utf-8?B?SnFXSnRvUjcwTHgvZHgwaGp4NmtQamZ2UzUxRGV5VUFJM3F1QVl4cTNyQjRI?=
 =?utf-8?Q?+bOe+UZLGwqztY6yOsT2yhoOhHYdMYnHsLHktvjn44UE?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B479F07BC898D9459E086077A925FBCC@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77d37629-c8db-4798-bdef-08db1e003e77
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2023 05:04:19.9300
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 618o1HyLHv7cuB8So2V8VFPgze24dbzaZQJApQ+fHAmbv0jjdMD4OU5v/wWGETM9V8f5PVrv+JYMFAPENtTj5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7453
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230305_210423_663632_553E965D 
X-CRM114-Status: GOOD (  10.30  )
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

T24gMy81LzIwMjMgNToxMyBQTSwgRGFtaWVuIExlIE1vYWwgd3JvdGU6DQo+IEFuIG52bWUgdGFy
Z2V0IC0+cXVldWVfcmVzcG9uc2UoKSBvcGVyYXRpb24gaW1wbGVtZW50YXRpb24gbWF5IGZyZWUg
dGhlDQo+IHJlcXVlc3QgcGFzc2VkIGFzIGFyZ3VtZW50LiBTdWNoIGltcGxlbWVudGF0aW9uIHBv
dGVudGlhbGx5IGNvdWxkIHJlc3VsdA0KPiBpbiBhIHVzZSBhZnRlciBmcmVlIG9mIHRoZSByZXF1
ZXN0IHBvaW50ZXIgd2hlbiBwZXJjcHVfcmVmX3B1dCgpIGlzDQo+IGNhbGxlZCBpbiBudm1ldF9y
ZXFfY29tcGxldGUoKS4NCj4gDQo+IEF2b2lkIHN1Y2ggcHJvYmxlbSBieSB1c2luZyBhIGxvY2Fs
IHZhcmlhYmxlIHRvIHNhdmUgdGhlIHNxIHBvaW50ZXINCj4gYmVmb3JlIGNhbGxpbmcgX19udm1l
dF9yZXFfY29tcGxldGUoKSwgdGh1cyBhdm9pZGluZyBkZXJlZmVyZW5jaW5nIHRoZQ0KPiByZXEg
cG9pbnRlciBhZnRlciB0aGF0IGZ1bmN0aW9uIGNhbGwuDQo+IA0KPiBGaXhlczogYTA3YjQ5NzBm
NDY0ICgibnZtZXQ6IGFkZCBhIGdlbmVyaWMgTlZNZSB0YXJnZXQiKQ0KPiBDYzogc3RhYmxlQHZn
ZXIua2VybmVsLm9yZw0KPiBTaWduZWQtb2ZmLWJ5OiBEYW1pZW4gTGUgTW9hbCA8ZGFtaWVuLmxl
bW9hbEBvcGVuc291cmNlLndkYy5jb20+DQo+IC0tLQ0KPiANCg0KTG9va3MgZ29vZC4NCg0KUmV2
aWV3ZWQtYnk6IENoYWl0YW55YSBLdWxrYXJuaSA8a2NoQG52aWRpYS5jb20+DQoNCi1jaw0KDQo=

