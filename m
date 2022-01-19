Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6E86C433EF
	for <linux-nvme@archiver.kernel.org>; Wed, 19 Jan 2022 07:40:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=c+FY8bEqDJrtFJRs8tru5pztMyZmJgj2OSKx2KvkoE4=; b=jk6UHhNb0g9iOd/HJ6QAQom8NY
	uVsmyDWJUbUzYAQM1gcn9GaOPgw0RL++1gzZp7dRRjlTaKinncwI2UjI86Mn3X6MUAfxk3AZfSQBQ
	d8CHfKOQhF9De2dvwHY0dj1L+dSmZkXUeoWx4A1jDgU+vtfA+mUxSuVaoz9eCAIW/nM2H6BbS8kVM
	DhT55560J6WDAOLssuwOvOTw1pcQdZIqJa1ujn5SPQk1DHlspI7qV4oMSrDyiHVJi7Q572D/1teTg
	8z6g28L7h43nBak/546hKiA9ld/SakwLNxzqVJkcQtbEs8oAuTE9b/i721d0dza5UKW5LvcdLD00B
	c2eWuW1g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nA5Zi-004Col-Gw; Wed, 19 Jan 2022 07:40:10 +0000
Received: from mail-mw2nam08on2086.outbound.protection.outlook.com
 ([40.107.101.86] helo=NAM04-MW2-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nA5Zf-004Cna-GG
 for linux-nvme@lists.infradead.org; Wed, 19 Jan 2022 07:40:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n6rj07E7IUwdOtNl2rcAi6zSXqh+UtL4vtbA14YKFPPQagTyZjkv3AQ1U61rutl1p80x0xGG7kSV/tPnQnMKDSNYEaeUh7F6cCHXB394koFqlKrrQxd9wUxy4vgSUg4XcwH9r5YMXqpb05KShCyTDpPy+GQ3fkFH/H9D+ncMLDwPF3d/RVhqQvWA1q0229zUtWPGz6nDi6Js5dBkmkYV63HMxORudlAQnaqRo//ynsK2uK2qMA8zXzeXkGPddv37ANFsSHoF6G+yrm9/KLXqR69QzJc5u9tUpK61hxEfTPtyYpevP1syW7mHkBcgVvi75PIl5NouUsm66CULn0+XaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c+FY8bEqDJrtFJRs8tru5pztMyZmJgj2OSKx2KvkoE4=;
 b=Kbhrtsau03V25azPQ8HCUNWZtWtPZL+caQoSQBxaP/InkNI4c5oJU7VQQvDC8LfLW3J8fqFwZgNujBcMM7EAxo2P9FQELcABoBejO2GacTdhAyEcO+Lkh3y4wSMdUuG7TkHVEVAG6iwajCjVMqpoS5q4iih1rdaN5UJ60tHX1XowWOy8MJOhvM6V6Nnm1WN3bTVJgqgX/rZ7JMCXhj6NnJrE5GKx9DkZn+SVCYOMCNKEX6jPWUg0R+OhK/l3OlxfnvG1ZoO7kfLzgmyIo06b1pjmoLa2c6ahXFXr4fgTsHSNPQpvyUrQzJaFjoqVmf3O+msW0X8p5iZoqhLt+X2OQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c+FY8bEqDJrtFJRs8tru5pztMyZmJgj2OSKx2KvkoE4=;
 b=BxM5NhxCvN6G/NXioKGiDKswbuyyYECh5jbxaC82NT41cKjM7P+SKOsO1GBpg3itd6e36hy8JSVgnWYDW9e5C5oKS4x4Qw4I6BN6iHEFquVjnCyohUCmpKMvg+aaHOo/Dad9u0I48FwwxobW86hmJJMRP8lkYOKa0zj0q4jfGjoUrmAp+x+JyApZSCSGvJRLrXfQo+Itl0id1LGWPeDAbv2ILOdvnYkcRodN0G95E2I2q49Z1cyJwGf+AvuUEZZ4Stnd2jZB9hO5DKZWzedo0WzytJxB5SD2iiwmiIFDZZt/6OABmxmtqtIhoAdwX2YLPv7mSqq0U+efMrLHfMDphw==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by DM5PR12MB1292.namprd12.prod.outlook.com (2603:10b6:3:73::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4888.11; Wed, 19 Jan 2022 07:40:05 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::75e8:6970:bbc9:df6f]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::75e8:6970:bbc9:df6f%6]) with mapi id 15.20.4909.008; Wed, 19 Jan 2022
 07:40:05 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "hch@lst.de" <hch@lst.de>
Subject: Re: [PATCH 5/5] nvme-fabrics: set ret to -ENODEV for error case
Thread-Topic: [PATCH 5/5] nvme-fabrics: set ret to -ENODEV for error case
Thread-Index: AQHYB3zBc1UHYcUK4E+PBMYxx/+jVaxhJkUAgAXJTgCAAvxUAIAAFKoA
Date: Wed, 19 Jan 2022 07:40:05 +0000
Message-ID: <b9d23021-05c8-0f34-e1b4-86e6a81ea80c@nvidia.com>
References: <20220112062101.90102-1-chaitanyak@nvidia.com>
 <20220112062101.90102-6-chaitanyak@nvidia.com>
 <20220113162840.GE3230285@dhcp-10-100-145-180.wdc.com>
 <09ae3d37-d22a-af44-9ea8-5d6f95c70ede@nvidia.com>
 <e90fda23-5438-c250-b530-30590867217d@grimberg.me>
In-Reply-To: <e90fda23-5438-c250-b530-30590867217d@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4466446c-b415-41e9-f224-08d9db1ee8e5
x-ms-traffictypediagnostic: DM5PR12MB1292:EE_
x-microsoft-antispam-prvs: <DM5PR12MB12924C3BC4D165EA2542ED4AA3599@DM5PR12MB1292.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8uj/hT7/0zKHMg0kgPrNEdWNbHaCo59bpVz94I4+E5jHPvV6XJcHVnSau7TVn2ifPeHP13XZcOm/WXGZ5fKqH+5EipWHUL9UDi2F/b5nYDqx1PEri5LLyaHnDF+GE8ynfJlBVqDfH9d8wbta519VYmhfqxMx7P8J79GsXiRXKUelRUXjxLdcvdleIhJJe8sGyO/DrE1+xWju3+atplPPEvvMBzy+VAamu21LTT8DO1cUxxKij9OHqrZsnpMQfQkiRd22U8J4Dy/Yke5i+V9h6/6ldo2xgzYhhG6aWO0qrmouCgsHH/f+KC2fft2vAjgLXRQHTn+wuMSAXZmFQlHArhP9BZLi/xAmWP6wXMyxPYRypUW39z9Xjw7WyZRa77VPo8XaSzIUuGvnjz1cfZtyENePalFpOpCryCUdVTv4bHNBNtY2PcwC9PJ5+q/ga7LxQGQEbngu7Pm6v4vLZ6kCp0uWJlSEgZv+BsMW7QVpZF0m0IfX/rXuKb6+vsxbp6DpNvamwcpgKumWbtIqv4YRddhKx8Hh+nyIGwxVbjWGviFenk20izIJbgE2Cm6xw0+Kw/rgo5mkViKix2vz5Q1wKEYCiiSdTcIIfFz1BEDsAUQSrbzH1riwiUkWwUgX4TrNhBLWOOcjbiPXUnVqk9qyZpcrIKaUIar8SV/3t3B48H507xvk9GUeKe1k8O8i/fWcpCpjnW7nTJMtqhoGFx5NalI7uv+lPJSRfkJeG0ONSiQXp99/zEg4IQfNbEl4Ssdyf2ZBQXR0f/JQsy3KtC62lQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW2PR12MB4667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(2616005)(71200400001)(31686004)(66556008)(6506007)(66476007)(38100700002)(4744005)(4326008)(36756003)(5660300002)(6512007)(2906002)(66946007)(6486002)(186003)(316002)(508600001)(31696002)(8676002)(8936002)(38070700005)(54906003)(110136005)(26005)(76116006)(86362001)(83380400001)(122000001)(64756008)(66446008)(91956017)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OVJIL2FaTUJPNjZLL1ZncGhyZW91NFRsSEtQTVpSblpKK1V6R3ZTWGZMZVgr?=
 =?utf-8?B?TXhTaE1SMnd3L3lPYlpNTCtZVyttYTlhbitHbjBuK1hvcUl1NFk4NnpFQVlT?=
 =?utf-8?B?NDVrZ0Jwdm1LaldvSXNtSXNBOW1VSmMrUmFZZVhMSTlKeGFaWFVKcElISnBU?=
 =?utf-8?B?S25MTm9zQmJHalViSk9XY0tIVUxpaFdEb3JGZWpuM0R5eWVLT1VwRFo3N2xG?=
 =?utf-8?B?WWp1S1Z1U2pER25wL0sydDdUeDV0MXdTM2o0bHBPUS9EZ3hvNDAxbnQ1VkZR?=
 =?utf-8?B?eFNnVU54b2cvNnlmdk1IZ25Ud0VtbTd6NmR0UmNtZVdCS0hFdTRmVHVDb0FR?=
 =?utf-8?B?d0cyQTVuby9WT0o3VU1tUnBZT1Z6NjgyTExWQVo5bEp1OWY0aDZ3N0RlazM5?=
 =?utf-8?B?blFIQzVUakNRMzZSaFVPYk9sSW5hWFFMNTNWaWhIY2tCQ2J4NVRMOEJzMVY3?=
 =?utf-8?B?UWhVcVh1ZkFLMzMxczZDTWU2MkZIdVJxV2xkYU45RjA4Q2t4YTQ5NWFvQU53?=
 =?utf-8?B?UXFqbmxsVFdybW54QzJINndMcmJVVjlWb2w1eVhsZ2k2UC9PYXJxSSthZUF1?=
 =?utf-8?B?blE0STl0em9SZGlXdWRjeUQ4eTRQZ0N2eEdUOHVzZWpUUHlqRzRxMkdnSUJS?=
 =?utf-8?B?cUw5a1JvT3hBQ0NjSXJ5RVBKT01XRFQvaDFzWXpIaG1hRmFwdlJlYTh5U21Q?=
 =?utf-8?B?RjJWNnFOYVVkcFJMZVd5TXkyOGQ4dDE3WUNkNUZKMDhWd0Q5NWlRdWtWbTJk?=
 =?utf-8?B?OWtMYThyZi9hZmlvMFpsL0RFVTNHSDBMT3BySDQvSXlUYVlYTGY3cjc0RVJl?=
 =?utf-8?B?QXFxaG5lMDBUK1FrYjVTU3ZXZkJNNXNuN1crV0FlTHdvOExTRVAxWFI0SWVU?=
 =?utf-8?B?WlptWFRUSWsvdEQwRFYyR3ltbldiSmpZbS92NnVOQXJVZm1DUEt4Yk42ekxa?=
 =?utf-8?B?NXZvS0JvakZzdXY5UUUzSUZ5Tm5PTFI2Y2FqanFHcThUOUhxU2RLa3hUdUJn?=
 =?utf-8?B?RnhZdXg3ZG83cWl0NUViTll6aXl0akN0WmF5bnpOVlJDb2FFblRSZ1FJRzZZ?=
 =?utf-8?B?U1lQMkNzVlgwaWJPdXZ4SWJCQkxTc2JkcVAweFMxYkZualpWR3o3UjdOdUs0?=
 =?utf-8?B?eXhjVGNCeExqclVQRXZpZ3lDazVvRngwVEZaR0dBcW5rNnpSc0xSRkwya2Y0?=
 =?utf-8?B?emZZT1FpeHJDUndUWTlTbFRKem93VFRWLytWb2U2VW54T2l1ak8yT1JsTnBH?=
 =?utf-8?B?RWFtNkdRWnZQQm1WMmpQbDY5UVE3MDNNSGswQW11T2orbHFhUHZTbDVFL01Y?=
 =?utf-8?B?ZDZuM09iQTFKZHExc3pTNHc1anJoWFZMWFFjNTYybTI4T3UxanNRcytXVXo4?=
 =?utf-8?B?VGY2TXNWM01BaXhyckcxTFNrSlltd0lxNGM3QmpycHAxc1BnVlZtSGxob3BE?=
 =?utf-8?B?eEJvWURjS0FvZjRyMHNob1VjL2NISlJ1VTdOOXJoMVYrOGQyM0pyOUloK2wz?=
 =?utf-8?B?dHdRWE50WFBBa1FoamFlSDcxTkpmL0owMmh6bjBZMkhQcHVjZlZiR1FTYVVT?=
 =?utf-8?B?WnZsNlVFeDB3cEJTeXFid21uMXBVbkNkNTFJazdjMnlBejV6V1RyMTI0eW1R?=
 =?utf-8?B?Y2F5OUFjT3ovdUtVNm1uSWluQnZmM1JUZ1owNnVwNmJrNW1QTmhGUGpLbkRM?=
 =?utf-8?B?em1kbnMrR01DOHVVSUdzNUFJQi9EWVVlVzBOU2RDZkIzc3ZIK3hlNnJGQk1w?=
 =?utf-8?B?dVFDODdmd2E2dlFzaGxWNlhnVlM0RnI2TE9nTHNSSjFPVUlWVkhsdHRLYWw3?=
 =?utf-8?B?MGZSdGVJQTd0MWdad050eU0yVmxjWENaYnljb1RsZElTZUxsbkVOVXZPMFBX?=
 =?utf-8?B?ai9IODcwdDhpeVdxOHBCYXRUTi9velZDS2RKYTR2OXBlcEJMSDhIN3dVL1Vq?=
 =?utf-8?B?NU9MQWtFVVM5NkpRZ1FSVVk1cVQvNzAyYmIwVlc1aWljTjk1eEY1UHVYTlBF?=
 =?utf-8?B?c0pDQ3RHZ3F2clUvdkVIRHRwTU5MeURtQnJFWWg4MVlyem54M2NoVXR5M1Ru?=
 =?utf-8?B?Ym5Ga1RJNTcrRUdWLzA2bnhhcFdXSFVna1lUSlpYZmJsazA1aHlJS3RjUHF5?=
 =?utf-8?B?cmd6S0JnTXhvNEZ5TTRDeUFPbHB5WGNGRnUxZ3BxQzJJM0t0dmo0RVNuUWdD?=
 =?utf-8?B?Tmc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <43D7E94C7BE01E4C93892701DDD75474@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4466446c-b415-41e9-f224-08d9db1ee8e5
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jan 2022 07:40:05.0959 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xmauoyir6TrrKPKPmDG9GGUKRDyKBYpns4qSmGI7loAnJYyhDrNrT/xdj+q5x2d7I3mEJtYbrZNQjNFI9AEjrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1292
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220118_234007_574592_BA8813A8 
X-CRM114-Status: GOOD (  14.65  )
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

DQo+Pj4gSSBtaXNzZWQgdGhlIGRpc2N1c3Npb24gb24gdGhpcy4gRG9lc24ndCB0aGUgX19udm1m
X2NvbmNhdF9vcHRfdG9rZW5zKCkNCj4+PiBhbHJlYWR5IHJldHVybiBwYXJhbWV0ZXJzIHRoYXQg
aW5kaWNhdGUgdG8gdGhlIGNhbGxlciB0aGF0IG5vIGNvbnRyb2xsZXINCj4+PiB3YXMgZm91bmQ/
DQo+Pj4NCj4+DQo+PiBUaGUgZnVuY3Rpb24gSSBmb3VuZCBpbiB0aGUgcmVwbyByZXR1cm5zIG5v
dGhpbmcsIGlzIHRoYXQgdGhlIG9uZSB5b3UNCj4+IGFyZSByZWZlcnJpbmcgdG8gPw0KPj4NCj4+
IHN0YXRpYyB2b2lkIF9fbnZtZl9jb25jYXRfb3B0X3Rva2VucyhzdHJ1Y3Qgc2VxX2ZpbGUgKnNl
cV9maWxlKQ0KPiANCj4gVGhpcyBpcyB0aGUgcGF0aCB0aGF0IEhhbm5lcyBhZGRlZCBmb3IgdXNl
cnNwYWNlIHRvIGRldGVjdCBrZXJuZWwNCj4gY2FwYWJpbGl0aWVzLiBTbyBwcm9iYWJseSBpdHMg
bm90IGFwcHJvcHJpYXRlIHRvIHJldHVybiBhbiBlcnJvcg0KPiBoZXJlLCBidXQgcmF0aGVyIHRh
a2UgY2FyZSBvZiB0aGUgb3JpZ2luYWwgd2FybmluZyBpbnN0ZWFkLg0KDQpXaGVuIEkgbG9vayBh
dCB0aGUgY29kZSBpdCBsb29rcyB1bmNvbnZlbnRpb25hbCB0byBub3QgcmV0dXJuDQplcnJvciB3
aGVuIGNvbnRyb2xsZXIgbm90IGZvdW5kIGNhc2UsIHdoeSBpcyBpdCBub3QgYXBwcm9wcmlhdGUN
CnRvIHJldHVybiBlcnJvciBjYW4geW91IHBsZWFzZSBleHBsYWluID8NCg0KQ2FuIHdlIGFkZCBh
IG1lYW5pbmdmdWwgY29tbWVudCB0byBhdm9pZCBmdXR1cmUgc3VjaCBwYXRjaGVzLg0KDQo=

