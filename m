Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA218C32771
	for <linux-nvme@archiver.kernel.org>; Mon, 26 Sep 2022 22:30:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3RIZjl+fq+bqDGE2jLt4Ln28fqg+5tWtSPujZUfoDH0=; b=KJPT0N++toQTLce/Yu+PEbEMbv
	nQ8IB4RU4b5gPH+G8G3e9kZo3GAzOgtde/QSSvjpvj260bt90BhrckkskvilyidOvvnyGc+DulELv
	wbnMtlAbp/Lu5rBkf68bEG8PG+v464nKa9HmmYPCvnaU/gPwjDZsFkCr7FJC7BpE3ikO1MXv8ONjg
	SwfCYuQZ37lpO50G8pyYF9+ScxNm1lzXo4OG1sOPkzAZt59NtQuwT8lud8PYmZ8lxZGId4FpksEw+
	4fSBpqZc31Nt11bjtm5dVLDBc8oFzZNlXzKYU1wsM/XnO6fHvRNwCFxQ/0x9vgEFg0cp0jESdTUV1
	LlFCGW9A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ocwcI-007BIv-7G; Mon, 26 Sep 2022 22:30:22 +0000
Received: from mail-dm6nam12on2082.outbound.protection.outlook.com ([40.107.243.82] helo=NAM12-DM6-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ocwcF-007BHt-0H
	for linux-nvme@lists.infradead.org; Mon, 26 Sep 2022 22:30:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SzyOi+f/U80kieE0dnJZms/pfFXHq3jTK0sRWXmU01EIlyVCzD18Eaxyh72C6KpL//fV/VPZIEE+vPDkk5c2X7RV90njYSE1A0svUZzAD5SIqLg+um0NElloHbon/Ivjc2ApmPju9dr3av6qkCTdPRqEfqzcSWE7jNO128UlpTtaapKXiFpmsVgqhkhusASUEmpTx0wBp/J6iC/hNrmNFuO++7YBEsbwgzCiM/PYiz88J7oBywH3kRWOsniuA+spZqm8u9ckOhR7hT67qeQEkTtu8OFWuOvvd9hhHK8pW4AiO+UqTegOuswudomYyS5F5iJfEeeTJV2uFBxFrE8NgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3RIZjl+fq+bqDGE2jLt4Ln28fqg+5tWtSPujZUfoDH0=;
 b=lnhtxNqzDCpUJHTvSOP4dgby5fyg0b/xnMg+Ooz/Z5urwDHggVDafwoJk00Mco6/LercIhb8tPrOiCmdopFK7LsfZRgy3m6PPGiQRc32gE6vlL8TWClZAuDLPs6WsqRAxcdz6IQgmWSUaUQpLqMtCBqFjJOmBCMAZn/wlZIrmzX3qZO9sUSECrNj/zUR5FPQfyFh2MlLcGvgZf7JtxnRzqRZGXkN4nnjCJQXqbYgiILsu8QrAFVf0AmexlDcvEB844gha1GyW9FqywdmAga+oenRU644s+/cBuhX8FkLw09ByEu6+t54ed9FO/SFB49ksSLMQM5JWgod3c5uMgjLaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3RIZjl+fq+bqDGE2jLt4Ln28fqg+5tWtSPujZUfoDH0=;
 b=e6O9tXgLIPOSa1aSVghxn/DyhSNp8qr4WvRiU5YkNm97QM9qwKGJICsLMJb+DRTyWhK8qw2EvjguX0xz0CBdtI3VCuKOko2GDr5XyliECrcIh+wwEQ41YL3DRnKVmEJURgA8XP/wzgkJI9FZKhIpnqlZ32f4q2Hge9cbd18fmz2hy7fOTYuhIPlwYU2MdXw4Hy8UlnzQ0Wi5yT1wt76ojYeRBUUI633nqAKh6s3sINvZqGvQd/w4Lenr2X4UJhakTZzGV/EdRGLEmD8lOcey80JSAV8VFVa5Wm7YWUkBJJVe7WeQ4KG+sxLv16dmEj8q82stWL6T5m8JcIL3RMdfVw==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by MW5PR12MB5623.namprd12.prod.outlook.com (2603:10b6:303:199::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.25; Mon, 26 Sep
 2022 22:30:15 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::3d10:f869:d83:c266]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::3d10:f869:d83:c266%4]) with mapi id 15.20.5654.025; Mon, 26 Sep 2022
 22:30:15 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Kanchan Joshi <joshi.k@samsung.com>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"hch@lst.de" <hch@lst.de>, "axboe@kernel.dk" <axboe@kernel.dk>,
	"kbusch@kernel.org" <kbusch@kernel.org>, "gost.dev@samsung.com"
	<gost.dev@samsung.com>, "sagi@grimberg.me" <sagi@grimberg.me>
Subject: Re: [PATCH for-next 2/2] nvme: Make CAP_SYS_ADMIN fine-granular
Thread-Topic: [PATCH for-next 2/2] nvme: Make CAP_SYS_ADMIN fine-granular
Thread-Index: AQHY0bl+kORLcsPXhUyd6aNkPcrmeK3yS6QA
Date: Mon, 26 Sep 2022 22:30:14 +0000
Message-ID: <d47c3ad1-d654-1500-b20d-adf6b7522677@nvidia.com>
References: <20220926145430.81658-1-joshi.k@samsung.com>
 <CGME20220926150442epcas5p2d2258d9799e47a49523d36b1a852dc9c@epcas5p2.samsung.com>
 <20220926145430.81658-3-joshi.k@samsung.com>
In-Reply-To: <20220926145430.81658-3-joshi.k@samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|MW5PR12MB5623:EE_
x-ms-office365-filtering-correlation-id: 79461e92-2b54-4a8c-a041-08daa00eaedc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  ZZy9I0VkVZzsm0qW5lXRjsOQbSWApNKZrHykPL5uDbXHCyJQh72VRBAJGJQNrAuH5No0vxCqpAANTy9OUNrizt+8L42BlDu3ek57jm5U0JqtyeEQ5uSUu+Kzu+mE/aJYP0UJGO63DlU/RD97ijJviFvZd5ixB92/x+I2FyQvK5HAtnTQeMy7Oal2AtKQHd3B2zbBLW66384N7gal/PKBV6O9gn2K+BJIH4pDdvFzrQO15U9vIRd1d7z397cwzVC4E7eHfsUMeYRutuAfmYVul5OX/nM4MdRpipSyEoAGTpOGxIBFLYbfMsVJF9zO295xLa1THSPN7fhRZWImxBHuzwUrh54EMFmII0cj89zjPiw1SGvCE31Qv+wtJZaoSrj8Ft2/WIgE8Z9js759mKPwPRCM17uSZHgO0qVcQaROC/yZmjHvDiVr1zZrl/P0iu1jnmuLXiJ2ZDfFD1sI14QGnkEHALMZ4fzQ5ZALmTbq4Utvpsptg/+QjKX6khYl99NAsfDZatAoyfXjMvAv2T9OHEKnwXOvS8lrXSYQ7DtsWuPz37iwm2TyJHFFnmuRSballfhyjNDOfBx+qfgAT9+HICjtS3l/JYQe2Z+7s11QAEeShHUvgqPu7IYt1KK/8CrOt+oFiJA/lFqPYGnXG34zchQVyFV2nj34be5rdLueOYM7L+8vVbS6MKp//c5AKxmuvF1U4kOFajDrLm/8/Dogbme2QgZ0iO123o45LlAPBhYr0zFvq7oyNxkuUqTJBpQG5ydu5ia5wjhh06nnoCgSKfVMA2Gt5FeJq3Ciqjkv+8/j2iNZ3/KRsXscSYxrbcI6ZNA2kfrZH7CX4UktfNndj4m5jxidxZvrYy4H3oW9OSg=
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(39860400002)(376002)(366004)(346002)(136003)(451199015)(122000001)(38100700002)(66476007)(91956017)(76116006)(66946007)(66556008)(64756008)(8676002)(66446008)(86362001)(6916009)(316002)(2906002)(54906003)(5660300002)(31686004)(4326008)(41300700001)(8936002)(186003)(36756003)(2616005)(6506007)(6512007)(38070700005)(53546011)(83380400001)(6486002)(31696002)(71200400001)(478600001)(21314003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?utf-8?B?MURvZ1hKTm5reExtdllsRXJacVBZN1c0cDgvMlZSZmh1RVI1bnNhNFl0RDV5?=
 =?utf-8?B?MkF5ejdiRm9SZmpiS0tjVzZldWJ6MlVETncxTjVzUXRxTkc3b1NTNFNOdVJY?=
 =?utf-8?B?M3pHQzhCblNnTllqcnY0Z1pva050eFVRRnRLT29NRFo0WkNFUDRlc00wYUdR?=
 =?utf-8?B?bUduRXdZQWU1c1JZUlNVZXRObXpnSVExRXVoNzFML2RZaTlEalVCVStyVHMv?=
 =?utf-8?B?eXJGdlh0WUdVMW54cWtUaURmUk9NQ0s1eWhPWTZRckZWRkR0MEh3Q2o2Nllp?=
 =?utf-8?B?YjNhS0hSQmxGSXkvanFIdXhPeXJWL0JCQzRqRjlpTWVnRXJFajBVcllFa05N?=
 =?utf-8?B?QjJEZjdETm5CeVpsaVp2a0hWc09FTG5saTBHbXAwMlpWdmxqbmRhdnVPS1FB?=
 =?utf-8?B?ZTZvU241NVppT1RMNFhLYnpCM1U1NlZYQzM3RGM3aHdwc0dUczN3NUNvTHZr?=
 =?utf-8?B?Vm8xWUw0enpTdmE5SktPL2o0QVBXVUFlTDFhbHZpZFNEUkxwMzdjcmYxWVZL?=
 =?utf-8?B?bnZOT2E2Vkxya0FmRGhxVm9FZG9FYzhuZHgwYUtVdmt4c054WWkvdmRJYWl0?=
 =?utf-8?B?TVdoSGJtTVBTSndlazhJWXlDZ0xTSFlDOW5hNnZTaVMyUW1ZWFN2UzcrTG1R?=
 =?utf-8?B?VUJRMEMvNGlOSmszakVCb3d6cWtkeU9IVHdidmk1UTI5SW83M3pwTGVLay9m?=
 =?utf-8?B?b0lHTXErdVVUMkxHckJ5SHdIVWVHZ3ZIckdSUmRXZ0ZWUzJvUXQ1QW9JUEhV?=
 =?utf-8?B?R1hMQTF2MndMMHhMVU5ZQkFENzRxWm5HeHUzOE1YWjNiOWVXMVFyTm9FUXFS?=
 =?utf-8?B?dVM5a0dLZ2U3emgwZ0JRNjh0YU5HVWd2MzcvRy9RU3FVMUJUMDRyNUpBWTFL?=
 =?utf-8?B?NzBMT05ZMWw0aVN3OEYwWm5tUG5EUjlNTklkYmxHcitmMTBWeTcvUTh0NktZ?=
 =?utf-8?B?SnFqOW43RmNYckVJZXBJV002cjMwVHd1VHE5WHpkdWFJRjhFSlpqQlNQbmFU?=
 =?utf-8?B?NGRScHRaMTNUMmZkektRaGpxTnNlSEFUTzlvNWl6aGhQSGVHdkx1dUtrdUox?=
 =?utf-8?B?dXhBV0tQcDNzUVR5a1czL2x1cXZnL1lqTGxPWmRTNUk4NkM0T3VnMEJKR09B?=
 =?utf-8?B?TXpmSlZSY2EvK0lDM0F3MGtaWXJJbUIyTmlqNVVQV0xQLzNsdDlObzhTN1ZR?=
 =?utf-8?B?QVlPTDdQY1ljZzVBQVZ2SkErbFFKbEVvNW1CSVNzQUNpd2xmdFVlb2o4aHNz?=
 =?utf-8?B?bXdDenBLVmVPcnRyVVZFRDF3RkJmOWZ4bFIwWklPZnRZSEtSK1F0UksvMlRN?=
 =?utf-8?B?ZU9EY2JkK0k2Sis1ckJ0c3duM1dBN1dXbTlTRzJ2MjJPc3d1ZUdaUFlzK1hF?=
 =?utf-8?B?SXJxRmgzMWEwSWVvbVE1QlVRSDE2L3plcEZjemU1aEw3UnhEQUE1eFdGaEJ6?=
 =?utf-8?B?SnR1NENGN0dxdC9PLy9UcnhrZEovQS9qL3ZHVWFSWUZIcnNsbnFJSzROM2N3?=
 =?utf-8?B?N1JENDVMQzFtOElyaFE1dzhMSGU1cGlKRjY2bytoaDFaVm9Ja0ZhRjZrRG9Z?=
 =?utf-8?B?UGR4Zy9hclhwbk04LzE1N0VjMWlDblJtU0VEN0dBcDFqU1lzZC9QQmQ0TjdK?=
 =?utf-8?B?ZTN2VktiMVJQKzExbzczdG0vSkJCbmlrYjBJSVNhUlY0NVhMVit5Umg0RXJz?=
 =?utf-8?B?Qkl0RWdjcVVLaGtYM3hhbjBJVE9aci9sQVJvd3FFWVRWdHhERG5pdVQ1QTYv?=
 =?utf-8?B?NnA3Z3MxRk81aHZHYzhlUzhYdWljRVhCZnROVUl4RE42V0pCcDhCM3hMTVhs?=
 =?utf-8?B?UkdMR0p5MEhPbVU0bDBSNEtxV1Y4Wk9oVmoxWmxzV1ZxSGZqSmUvbFkxN3l2?=
 =?utf-8?B?OEVtekhZYjM3QVU3dkV0SVJGNS9JKzlTT3BGbnFjT0lrdjArWUNrcmN6TnpW?=
 =?utf-8?B?MzJQbE4wZjRsZEpWaG5mOWhmclpVMFV1RzNaYk8zdW1Pb0pkd2dNQm1tUjU2?=
 =?utf-8?B?UnFzaVlzTmQwY1dIeXh6d1pWeDV3WVIrT081VnZCcy96NjVVaFVuWU00NUYw?=
 =?utf-8?B?NE9XYXY5SzRxVitTSFR5SDcxUmJiZFJBR2tjVVRpcUhYekl6OVNZZTlMblVB?=
 =?utf-8?B?RVZHamRMdk5FNFRGbHNqQVZmbUprODBuNGtCWUZQU0tGVmd5eGxIYUdoQVpR?=
 =?utf-8?B?Ync9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <366F0670EB322C45B8EE000CF3C03BF6@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79461e92-2b54-4a8c-a041-08daa00eaedc
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Sep 2022 22:30:14.9402
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: k3BBoEiYIDxgNgWRnBhSnmuADoJrdbqkF8DNGUsCUnX95NPn++BpK39JzIl3462rTBaUpGnJprrDqegtO0fxMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5623
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220926_153019_087133_14F825A4 
X-CRM114-Status: GOOD (  19.80  )
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

T24gOS8yNi8yMiAwNzo1NCwgS2FuY2hhbiBKb3NoaSB3cm90ZToNCj4gQ2hhbmdlIGFsbCB0aGUg
Y2FsbGVycyBvZiBDQVBfU1lTX0FETUlOIHRvIGdvIHRocm91Z2ggbnZtZV9jbWRfYWxsb3dlZA0K
PiBmb3IgYW55IGRlY2lzaW9uIG1ha2luZy4NCj4gU2luY2UgZmlsZSBvcGVuIG1vZGUgaXMgdGFr
ZW4gaW50byBjb25zaWRlcmF0aW9uIGZvciBhbnkNCj4gYXBwcm92YWwvZGVuaWFsLCBjaGFuZ2Ug
YXQgdmFyaW91cyBwbGFjZXMgdG8ga2VlcCBmaWxlLW1vZGUgaW5mb3JtYXRpb24NCj4gaGFuZHku
DQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBLYW5jaGFuIEpvc2hpIDxqb3NoaS5rQHNhbXN1bmcuY29t
Pg0KPiAtLS0NCj4gICBkcml2ZXJzL252bWUvaG9zdC9pb2N0bC5jIHwgNzAgKysrKysrKysrKysr
KysrKysrKysrLS0tLS0tLS0tLS0tLS0tLS0tDQo+ICAgMSBmaWxlIGNoYW5nZWQsIDM4IGluc2Vy
dGlvbnMoKyksIDMyIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbnZt
ZS9ob3N0L2lvY3RsLmMgYi9kcml2ZXJzL252bWUvaG9zdC9pb2N0bC5jDQo+IGluZGV4IDZjYTY0
NzdkZDg5OS4uNGU1M2EwMWU3MDJkIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL252bWUvaG9zdC9p
b2N0bC5jDQo+ICsrKyBiL2RyaXZlcnMvbnZtZS9ob3N0L2lvY3RsLmMNCj4gQEAgLTI1OSw3ICsy
NTksNyBAQCBzdGF0aWMgYm9vbCBudm1lX3ZhbGlkYXRlX3Bhc3N0aHJ1X25zaWQoc3RydWN0IG52
bWVfY3RybCAqY3RybCwNCj4gICB9DQo+ICAgDQo+ICAgc3RhdGljIGludCBudm1lX3VzZXJfY21k
KHN0cnVjdCBudm1lX2N0cmwgKmN0cmwsIHN0cnVjdCBudm1lX25zICpucywNCj4gLQkJCXN0cnVj
dCBudm1lX3Bhc3N0aHJ1X2NtZCBfX3VzZXIgKnVjbWQpDQo+ICsJCQlzdHJ1Y3QgbnZtZV9wYXNz
dGhydV9jbWQgX191c2VyICp1Y21kLCBmbW9kZV90IG1vZGUpDQo+ICAgew0KPiAgIAlzdHJ1Y3Qg
bnZtZV9wYXNzdGhydV9jbWQgY21kOw0KPiAgIAlzdHJ1Y3QgbnZtZV9jb21tYW5kIGM7DQo+IEBA
IC0yNjcsMTAgKzI2NywxMCBAQCBzdGF0aWMgaW50IG52bWVfdXNlcl9jbWQoc3RydWN0IG52bWVf
Y3RybCAqY3RybCwgc3RydWN0IG52bWVfbnMgKm5zLA0KPiAgIAl1NjQgcmVzdWx0Ow0KPiAgIAlp
bnQgc3RhdHVzOw0KPiAgIA0KPiAtCWlmICghY2FwYWJsZShDQVBfU1lTX0FETUlOKSkNCj4gLQkJ
cmV0dXJuIC1FQUNDRVM7DQo+ICAgCWlmIChjb3B5X2Zyb21fdXNlcigmY21kLCB1Y21kLCBzaXpl
b2YoY21kKSkpDQo+ICAgCQlyZXR1cm4gLUVGQVVMVDsNCj4gKwlpZiAoIW52bWVfY21kX2FsbG93
ZWQobnMsIGNtZC5vcGNvZGUsIG1vZGUpKQ0KPiArCQlyZXR1cm4gLUVBQ0NFUzsNCg0KeW91IGFy
ZSBjaGFuaW5nIHRoZSBvcmRlciBvZiB0aGUgY2hlY2sgQ0FQX1NZU19BRE1JTiwgdW5sZXNzIHRo
ZXJlIGlzIGENCnNwZWNpZmljIHJlYXNvbiBmb3IgaXQgKHRoYXQgaXMgbm90IGxpc3RlZCBpbiB0
aGUgY29tbWl0IGxvZykgbW92ZQ0KbnZtZV9jbWRfYWxsb3dlZCgpIHdoZXJlIENBUF9TWVNfQURN
SU4gaXMgdG8gcmV0YWluIHRoZSBvcmlnaW5hbA0KYmVoYXZpb3VyIHdoaWNoIHNlZW1zIHJpZ2h0
IHNpbmNlIHlvdSBhcmUgYXZvaWRpbmcga2VybmVsIGNvcHkgaW4gY2FzZQ0KY21kcyBhcmUgbm90
IGFsbG93ZWQuDQoNCj4gICAJaWYgKGNtZC5mbGFncykNCj4gICAJCXJldHVybiAtRUlOVkFMOw0K
PiAgIAlpZiAoIW52bWVfdmFsaWRhdGVfcGFzc3RocnVfbnNpZChjdHJsLCBucywgY21kLm5zaWQp
KQ0KPiBAQCAtMzA2LDE3ICszMDYsMTggQEAgc3RhdGljIGludCBudm1lX3VzZXJfY21kKHN0cnVj
dCBudm1lX2N0cmwgKmN0cmwsIHN0cnVjdCBudm1lX25zICpucywNCj4gICB9DQo+ICAgDQo+ICAg
c3RhdGljIGludCBudm1lX3VzZXJfY21kNjQoc3RydWN0IG52bWVfY3RybCAqY3RybCwgc3RydWN0
IG52bWVfbnMgKm5zLA0KPiAtCQkJc3RydWN0IG52bWVfcGFzc3RocnVfY21kNjQgX191c2VyICp1
Y21kLCBib29sIHZlYykNCj4gKwkJCXN0cnVjdCBudm1lX3Bhc3N0aHJ1X2NtZDY0IF9fdXNlciAq
dWNtZCwgYm9vbCB2ZWMsDQo+ICsJCQlmbW9kZV90IG1vZGUpDQo+ICAgew0KPiAgIAlzdHJ1Y3Qg
bnZtZV9wYXNzdGhydV9jbWQ2NCBjbWQ7DQo+ICAgCXN0cnVjdCBudm1lX2NvbW1hbmQgYzsNCj4g
ICAJdW5zaWduZWQgdGltZW91dCA9IDA7DQo+ICAgCWludCBzdGF0dXM7DQo+ICAgDQo+IC0JaWYg
KCFjYXBhYmxlKENBUF9TWVNfQURNSU4pKQ0KPiAtCQlyZXR1cm4gLUVBQ0NFUzsNCj4gICAJaWYg
KGNvcHlfZnJvbV91c2VyKCZjbWQsIHVjbWQsIHNpemVvZihjbWQpKSkNCj4gICAJCXJldHVybiAt
RUZBVUxUOw0KPiArCWlmICghbnZtZV9jbWRfYWxsb3dlZChucywgY21kLm9wY29kZSwgbW9kZSkp
DQo+ICsJCXJldHVybiAtRUFDQ0VTOw0KDQpzYW1lIGFzIGFib3ZlLg0KDQo+ICAgCWlmIChjbWQu
ZmxhZ3MpDQo+ICAgCQlyZXR1cm4gLUVJTlZBTDsNCj4gICAJaWYgKCFudm1lX3ZhbGlkYXRlX3Bh
c3N0aHJ1X25zaWQoY3RybCwgbnMsIGNtZC5uc2lkKSkNCj4gQEAgLTQzOCwxNCArNDM5LDE0IEBA
IHN0YXRpYyBpbnQgbnZtZV91cmluZ19jbWRfaW8oc3RydWN0IG52bWVfY3RybCAqY3RybCwgc3Ry
dWN0IG52bWVfbnMgKm5zLA0KPiAgIAlibGtfbXFfcmVxX2ZsYWdzX3QgYmxrX2ZsYWdzID0gMDsN
Cj4gICAJdm9pZCAqbWV0YSA9IE5VTEw7DQo+ICAgDQo+IC0JaWYgKCFjYXBhYmxlKENBUF9TWVNf
QURNSU4pKQ0KPiAtCQlyZXR1cm4gLUVBQ0NFUzsNCj4gLQ0KPiAgIAljLmNvbW1vbi5vcGNvZGUg
PSBSRUFEX09OQ0UoY21kLT5vcGNvZGUpOw0KPiAgIAljLmNvbW1vbi5mbGFncyA9IFJFQURfT05D
RShjbWQtPmZsYWdzKTsNCj4gICAJaWYgKGMuY29tbW9uLmZsYWdzKQ0KPiAgIAkJcmV0dXJuIC1F
SU5WQUw7DQo+ICAgDQo+ICsJaWYgKCFudm1lX2NtZF9hbGxvd2VkKG5zLCBjLmNvbW1vbi5vcGNv
ZGUsIGlvdWNtZC0+ZmlsZS0+Zl9tb2RlKSkNCj4gKwkJcmV0dXJuIC1FQUNDRVM7DQo+ICsNCg0K
c2FtZSBhcyBhYm92ZSwgd2h5IGluaXRpYWxpemUgYy5jb21tb24ueHh4IGlmIGNtZCBpcyBub3Qg
YWxsb3dlZC4NCg0KPiAgIAljLmNvbW1vbi5jb21tYW5kX2lkID0gMDsNCj4gICAJYy5jb21tb24u
bnNpZCA9IGNwdV90b19sZTMyKGNtZC0+bnNpZCk7DQo+ICAgCWlmICghbnZtZV92YWxpZGF0ZV9w
YXNzdGhydV9uc2lkKGN0cmwsIG5zLCBsZTMyX3RvX2NwdShjLmNvbW1vbi5uc2lkKSkpDQo+IEBA
IC01MTcsMTMgKzUxOCwxMyBAQCBzdGF0aWMgYm9vbCBpc19jdHJsX2lvY3RsKHVuc2lnbmVkIGlu
dCBjbWQpDQo+ICAgfQ0KPiAgIA0KDQotY2sNCg0KDQoNCg0K

