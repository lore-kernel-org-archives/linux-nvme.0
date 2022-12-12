Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46919C4332F
	for <linux-nvme@archiver.kernel.org>; Mon, 12 Dec 2022 20:01:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Cc:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uCclhDAsGKtbLIb/oD/excrMUpbCM6rmn7WyOWZoLzA=; b=S1Wr8SatU8bMzrwku6vgwzK4nR
	DY/5Mt3CxevEGqUOLQCTuQLZf9GyCt4py0NjKgYLC+ScIMZldXaktTaaEkCRxGuLEVAdtE+48M6bo
	g8jCZE9ICwIjCg94oG2Hp1cTT9hWt7k10W0kRKbZ/qYSir37frs6y8rbUpKtNiFj2lQ/VelmB+wRB
	29SL/i5smtN8uzrw3320tJVvtqU4YIvMm78md3exALCLCRSPJEein06YMJV8kCbt1sdDh8/NEX/KI
	+P4ZK0uRSIMc5HQ19Aeq3qjcnX1KrtY2WPt12XYTWTnzhz4/sWvz+ACPp5SCC0u0RxAUL+eDaORjl
	pAf5fPSA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p4oz4-0053Kd-D9; Mon, 12 Dec 2022 20:01:06 +0000
Received: from mail-dm6nam11on2059.outbound.protection.outlook.com ([40.107.223.59] helo=NAM11-DM6-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p4oyx-0053Dc-Dv
	for linux-nvme@lists.infradead.org; Mon, 12 Dec 2022 20:01:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kDPWa4l0eiMo1YR1aAAqXjm8GWHoArNYJxnMpdH7sLqVXGxBwVn+viTieEb/h9S9rCFJRG9eIUA8G+zRBkmY4Aad1yNs/EBndvqGao7ar/k6yBuRVLYfAjtLLfQrswCPHGNmlqrUGSbLuGysqI4l+zKjY3JElImwyNfXP7ziH6ifU6XEnxW/Ks+357CbYm58+h89Sy7MidZ0Ta4VCvuStq6Ym2qlegh+SkRBo9vrSVpesduOk/SwH8iuqfFjbhmPDkcm68QTIeD33CmGLuArU0b8HpKrTEpZbgFDG6bEIVQ6f3trVBOmndBs5onULardvuvBZ4+gKID1JDnoXxEaxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uCclhDAsGKtbLIb/oD/excrMUpbCM6rmn7WyOWZoLzA=;
 b=E+dexlUsGU2aErETPLDMEGVta4wlf6XdtpHnbJt5PcrV1PEUWX16cwdfjbioVAic+N5Krdjv19ze4Huz+WZQXG/NUK5VAMCe4W6GFNbRkDhvlM7i/JdmxQ90BoySAqXeoo8bigAv3apb1A/BZEjAbt6Lz0SOdhTJiHIZc+NbRtYHndCORRvL6p4Hh0pgYdsBz5PK14QoH1skLWNCMaMqkdCbbl8t8zYbvaecGuoUkTW00ezBWUDA6xxumqQiDrsQ6U9qsZjWoyLFoGcWpVeNkHx6qVVMmPH+2TLjElZqFZGzaRvE7DqOyFrVzumrHTwRN5RdND27p+PnXYJb1iHU3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uCclhDAsGKtbLIb/oD/excrMUpbCM6rmn7WyOWZoLzA=;
 b=eu3/NnnbPUmLd8TY3h/as3wGUK0PWEsu9HmNFfwT/1K41wPJ32YoynZuWK89l5A3TXHjZkWfsS9RYd3EqQdQB+yi064nbxRzSZhvLAJWyzKA1D7/Znd3L9pq8ED6gbzb6iRysHAB3YJSDgLgJzSHqnMS6jtQ0LAoak21mMzSc6/9hq9BTo4bphtQGCwgnm3DfLceKrzeVC9GhOxtnQbMQkmQWrb+bNuyuCeRyhBlcIwS5AhHTycy7A6ugTv1HO4kXSEVWrzigzTzZ3dzE2kJzsfENEuzrRQYcJcwPxx9AZM0aeWyXP54rnqadd+eA9nP0LSxgBCf2Qixg4nu7ZiCYA==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by DM6PR12MB4042.namprd12.prod.outlook.com (2603:10b6:5:215::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Mon, 12 Dec
 2022 20:00:51 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::b84c:b6e:dc0:8d7]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::b84c:b6e:dc0:8d7%2]) with mapi id 15.20.5880.018; Mon, 12 Dec 2022
 20:00:51 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: "amit.engel@dell.com" <amit.engel@dell.com>, "sagi@grimberg.me"
	<sagi@grimberg.me>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>
Subject: Re: [PATCH 1/2] nvme: add nvme_opcode_str function for all nvme cmd
 types
Thread-Topic: [PATCH 1/2] nvme: add nvme_opcode_str function for all nvme cmd
 types
Thread-Index: AQHZDjXhgj53EJO0WUaM5JlUW78tUa5qrHEA
Date: Mon, 12 Dec 2022 20:00:51 +0000
Message-ID: <82451f44-56f6-4c30-ab93-aec446f02777@nvidia.com>
References: <1670855159-3182917-1-git-send-email-amit.engel@dell.com>
 <1670855159-3182917-2-git-send-email-amit.engel@dell.com>
In-Reply-To: <1670855159-3182917-2-git-send-email-amit.engel@dell.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|DM6PR12MB4042:EE_
x-ms-office365-filtering-correlation-id: bf70b9fa-4c54-4f11-2d34-08dadc7b91d5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  h2PCB/fgooKjuAHgXN/TDaEw3MErfKxxlZv/BuNM+YOBl4ZEySsELTsoYNLQW53MgKliIUAhOPf33BPvpurRpbRcV8zWf89Q8izc9B6MMciLSEcQ5+xU7c1hwOIzBYE7idiShoYp2YjH7IFqIMhVvqHiCh/ARR4ZD1AozVHbmpPRI7e59AbrpZPOxEFFmXIIV1aobfEUM1qdXDmdEwW40p+1xLwxF7yiEt+B7ZyP3biYwXwe4bJ5wU9vtfSZvyZUFDJWNUwpVBhKSn1ZSzy+igLC0DbOV2CPtgKq03S7Et2Z7oq2PSsWqHt+B3o167H944hroLVnOrQdvezBX6k8co/pmX1sPpzpd+MQ4tyHBA8tKof2W9pHzFNaUAUwEn3fw2ptrDvtdbjX9PxcwUmPEmgYO2hUMPiC96GZHUzcrFwzGVkX2F/GEHGLGaEMiyzUEeEN6q7gP82Q5GEq1maeLcDcD+pyapgkBdNcDEI9QSij/fjNG8kA+i30dFGFetCb32bQ39oHeGnv+qUcVIREncbDJAMmR07lAZmAHqcJ/jdHGcFSp7ZqLbXgCSgcHgnSZ2Tmr1TysTNDwDpbkcUdEXJcG97Y4Ljj1KE2VLA6f3rgLXyYmhk7KN/OXEPzaKDcePvaQfm8M43pURHT4STaPr8BNtjqwlIKBXiTfya07UW/29ExHFY9OClOewGAbDC/EsjxWgMrXZwwwSmsoPzLdGXHJN1EyADLsfLlD4TBYUqMeyRrp7YydweWVA9ioZm47eCdQnVBZU47HtyMbZZ+mg==
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(346002)(366004)(136003)(39860400002)(376002)(451199015)(71200400001)(478600001)(31686004)(6486002)(186003)(6506007)(53546011)(6512007)(38070700005)(66556008)(316002)(5660300002)(2906002)(558084003)(76116006)(36756003)(66446008)(64756008)(2616005)(110136005)(66476007)(8676002)(91956017)(66946007)(8936002)(83380400001)(122000001)(86362001)(31696002)(41300700001)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?utf-8?B?cmhTb1R0RVdpU1lRdDZQYys1eHdIa25IVmQxQUNYRVRRZHJtOHhZWlBpNk9q?=
 =?utf-8?B?ZWlCVzJFRjJUeWdpejA2RGhDQUgrVzRMb1JKbjQvNmhWd2R0c2FHY3psMGVo?=
 =?utf-8?B?ZDNZS0R0TGVKR0ZDQ3lqSFlKa04waFpHSEN2ZURGM0szRTN0K2p2cmZSbnRD?=
 =?utf-8?B?UHg1bEFzT0lTS000ZWVxV2k3dFZQNjhjdjN2OHMxbWhaSXpKaFhjbW9QRW83?=
 =?utf-8?B?dXk2Z3BHcGRoRWVxcVVwMWxQVS9CUitKaTk2VmdsL0lDUVhTd3VxRGdxM2FB?=
 =?utf-8?B?L2FTbVY4YlU3cTZ5OXhZZVRjTUVGN1FDWS8yT09xczdnMnFpQ1ZpSkdsUjVB?=
 =?utf-8?B?WDF0L2xOYms2SmlWTytTMTFVWTdkSFV0UkwxbWtOU3Z4eEJLY2ZLejl2eGsw?=
 =?utf-8?B?eVhWcno0d3R2MTN0cDRvakdKdUFML3pSWWpyTEtRQUJESDdLWkI2U3hnSUtQ?=
 =?utf-8?B?ekRUMWp3eGJjZFUxSEx5eHFndk53K3BqcG1ZNHljaEx4WFVrcnVzV0pHbzNa?=
 =?utf-8?B?T21lTVJvWDVZd0t3bE1CVU1CNG1ubS9kMjdlTzN5dEhDSGo4SW9TTko1K0M5?=
 =?utf-8?B?ekNJRkwxaEJGeGtjc0tGMytCcUxlNDlaam4veXBHZUFlbFk3VkgweXZVQjdW?=
 =?utf-8?B?VVYzR3M4VUN5cWkxOS9QQys4UWJBbUYzL1JBcFBDeXhDU2RWb1BIR3pBOW00?=
 =?utf-8?B?UnE0MU1tdGlGaTcwdzJsSzJRbGRKNjhPTitOZ3Q4WkRiUXpsTnlra01hclp0?=
 =?utf-8?B?QldISzJzbFgvVlRDVmIwbjQ2b3YrZlExVEdvN3Q1VzBWNDVQaFU3eWYrdFRW?=
 =?utf-8?B?ckFJczlTR1cySnJNTzYyUXhFRDBUQm4wVnRPTERsNDU4RXAzR0RqRnlOS0xj?=
 =?utf-8?B?MEE1RkFBY085L3F4SGo2Wlp5dVRzKzZ2ZjFxaThVWGg4L1dzM2k4UU9Ec0Ja?=
 =?utf-8?B?c2puSEZMS09scjd0aWk3dFNGNWVhRGkvQkYvMGpFQlFTS204dURxZ0pXdWQ2?=
 =?utf-8?B?VE1xek1WU0cyOWZ3SmZGcU1TZDhIb3MwL1V1M3BRMUdKTjRCUWFWQVpJVmx1?=
 =?utf-8?B?OUdMM3RyK05PZ2tFdzJMa1NVSjhTSnRtV0UyVUJPUDQrcXRqVDlPU25aUUtU?=
 =?utf-8?B?UnRIRlBQQVVaVFFkdnBwTGRDVWNoUm1nQWFpMDlsVlFWWjFFRVJMR0l5OHE5?=
 =?utf-8?B?c3BhOHVPZTlZb3VVYk10Y0NwejJkY25CdEQzcjdKNHdOZHY0dGVobnQvUmYx?=
 =?utf-8?B?QTZDWDMvTFkrYVRZZnh0VlA5djFEK3lyRTRxSWNlcTA3ekxvN2RBN2czbDNa?=
 =?utf-8?B?dGs1TnlLQ0NxeU13dXdYVHVoU0ZOcDcvUjJqVXFuM0ZhZSs3VnlXaUF2eUZt?=
 =?utf-8?B?cHErSjlzL0ZiV1NVWGVqd3k3TE9oa3MyVmlWVUpSQkFaVTlqSGJYSzNadFk0?=
 =?utf-8?B?emk5S2Y1TFRzVC9kdWVYWFVTWm1UTmRFUEg2M0FSajNpK3RBbytYYk8rYlVh?=
 =?utf-8?B?Y0ZXdUJaUi8ySmIwVytJS2ducmE1d1Vhc3BRc21vYnhLMXg3NEhUV05oYmZN?=
 =?utf-8?B?VFJUcE0yODFXK3R3ZjBkbDZGU0JPOEwwdldPeVJRYWlMWnZPWDlhN2gxM2k2?=
 =?utf-8?B?eU9jOTRFT0ZUUkt6MC9tVStqR0hKSEpHa2xxeE9QdlIzQ0tBczQwTTIrL1Bm?=
 =?utf-8?B?RmZLQTZrT2hCNnRLTTFJWTNMZC9td0ZrRzkxcmcwOUxSMHYrNituRktHZzFQ?=
 =?utf-8?B?V3NZS0JDTmM4ZFFwUXN2bW5sckp3N0pFb21wKzRyZURyK2ZXM3pubDgxcmhL?=
 =?utf-8?B?REpuR0hjTUhPWXl6ZjVLUUU2M2pTdU9aREowMkFhakljNEZBN1RES3FLY1dN?=
 =?utf-8?B?UFk2MERHT25Hekl0cURVSGNHblpaWWUrNzRTMmRDSUJsVzUzbktuL3BFQ3Nk?=
 =?utf-8?B?b2M5ZkhGa2VrRlpSdDl4MUovdGpnUVdXOTM5a2FsZERpVGROWmVrQ0ZvL2xH?=
 =?utf-8?B?ZkswM1ZuWU5hMlMrYmE2RFRkeW4rUnFac1JKM1dFb0tWNHFqZjd5NHZPSlhR?=
 =?utf-8?B?UHNYL00wZkIwMkJGZk9BRnA4MjJWMUpqLzhtOVNkUkNCNDhhNXF6K1p4Nitl?=
 =?utf-8?B?UElFZ2lsSi84Q3RDYmwvcHorcEZ2bUlYUUFwdTdoSkw0UEM1enlCSVBEWm9N?=
 =?utf-8?B?NGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <640C44AE3891E248A5C6C3978926AEB7@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf70b9fa-4c54-4f11-2d34-08dadc7b91d5
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Dec 2022 20:00:51.1945
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GFfReR6lI8JwCuNn0ZafM/7lfbapMqjy84g+Y6mLFYZvM1xaxbBYDaL+B0OavP53Zi1HtV1jwV/cj0Rnas9/rw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4042
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221212_120059_827867_BA93FB55 
X-CRM114-Status: UNSURE (   7.49  )
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

T24gMTIvMTIvMjIgMDY6MjUsIGFtaXQuZW5nZWxAZGVsbC5jb20gd3JvdGU6DQo+IEZyb206IEFt
aXQgRW5nZWwgPEFtaXQuRW5nZWxAZGVsbC5jb20+DQo+IA0KPiBudm1lX29wY29kZV9zdHIgd2ls
bCBoYW5kbGUgaW8vYWRtaW4vZmFicmljcyBvcHMNCj4gDQo+IFRoaXMgaW1wcm92ZXMgTlZNZSBl
cnJvcnMgbG9nZ2luZw0KPiANCj4gU2lnbmVkLW9mZi1ieTogQW1pdCBFbmdlbCA8QW1pdC5Fbmdl
bEBkZWxsLmNvbT4NCg0KZml4IHRoZSBjb21taXQgbG9nLi4uDQoNCi1jaw0KDQoNCg==

