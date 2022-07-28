Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C164C04A68
	for <linux-nvme@archiver.kernel.org>; Thu, 28 Jul 2022 23:14:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/23XqasVbRtW2wdcUbr2nObMRxc6dD4WsEP7TEBIFNc=; b=GtuGbG7gIrTqr45QX/i9uzENzl
	JBdszsKrz/9SqTlZgA0o1EHrlhED1oYL9FXI6QMkvIo3wWABnZADIWReZRHX/ytac3UcqNZSVyXTw
	zSYC6aGRDvIT3h9t0M4pS5cRbe9Zqbb77gk6zc/Oz7ch6ZJEeuoWtTiFh9yPDJ+M+N4HTfnpxT5zN
	a7CJ6rGGX8QDjyvnpJ2rJwUmrkuE9A5ZOtXePLHZCqzohdrvvPGjIwpRzJoX0+AjAU4m0npU1ipD4
	0IopxPCBc3DWo+O3qRmkbmyMx3U80YvgUvDfUTPD4JXQ/lHsNmzDV2w7b6CqYPonRE33jt+tlPwc6
	hJznd+Qw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oHChh-00Fgqa-WC; Thu, 28 Jul 2022 23:14:06 +0000
Received: from mail-dm6nam10on2063.outbound.protection.outlook.com ([40.107.93.63] helo=NAM10-DM6-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oHChf-00FgqB-SS
	for linux-nvme@lists.infradead.org; Thu, 28 Jul 2022 23:14:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ELMXZJ23cBL/yPzizVDVRW+EcAFhOcstcGEK5R5mKR1Ip9kKLBbNE/lY4e4SeGxKDY2EtSU6PWNQY4cQkpTn19oStQutNrGJGhgPXH8zH2n/xKcIIkFgmowz3hsZm+cjBBDXjbcskSDQKq1pD8hmDDN7bZgzaIg8z3/Pp/lBcZoPgScE1Qoaw6/dcNOHgg+UpV/r7PhVFIM+AMAAGM+tAJSmyhsSscL9L/nPTXM+pIXHRXdAwsQfo00FPjU5wiXZkWlIS3Nihuf2Ci3FIyrbWWUZQGO6bT5y+ZRvyeKrJqWmMWzL0WuX4bUDxqQ24hs5POBMXCaGn0O79ISDe3sJCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/23XqasVbRtW2wdcUbr2nObMRxc6dD4WsEP7TEBIFNc=;
 b=XnVvo1EtVKyO7vA1DJzLXdKHKQbQXNox1uom2NjF+HtuflUcNata6yaiZI4u2a8xk+snZ71L7LABug6JZa11C99GcbL6OxiieKKkIjuew5ScPe5hj1rZCRLS2A08XerAARX6KzbR2vvOalx5KUSQ7ZrFi0t0i3jgVPEo/fcNXEtu6Qe4pIB1Rs5AvmMMcf0k+NFv6vHoSsMEdVM5n1rL5D6XMMitQLkCFSzuUXyYia1QzcpTbIMWOC6gxl12zZ9l6pGGvGLTITTQF3CPtgOY7lw4RcoKCY8iwQOmkccAtzpZpX+bCe8Hq7s0uY1lfQHP1a18ih4+nSHhwyRcYmxGIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/23XqasVbRtW2wdcUbr2nObMRxc6dD4WsEP7TEBIFNc=;
 b=OH76iQFExZ7M9GFoL0uBeEh5vwoFQ5JuFoJODEelLhqOYV28wbA4LgthC7C4v0ZmsdOQGjb7v5elTnSVW6QZ58bLLH7SJqwoiEefwJCpvFbplWgs1aIlUNaOJT3rOA3KIaAZm5iPH6U7f2RFYb8SF4srpZJfBj+lcIcGB0cw15BlY8IWhAVxp33Ke5SM6By/kX52++hK+snsmAyqL2Tsb+1zSVrpRWB+97I7LKqhWQGKINneHIQeyRxnDcbqon/AUOnESxEYsnyMHit9WUpA/QVS8gdXKyVoGky//cBrbfy9BzByJ6Y7jxO5BCapBYHGZvxzGkrMSnLEhXWefC0vBw==
Received: from BL0PR12MB4659.namprd12.prod.outlook.com (2603:10b6:207:1d::33)
 by MWHPR1201MB0062.namprd12.prod.outlook.com (2603:10b6:301:54::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.20; Thu, 28 Jul
 2022 23:14:00 +0000
Received: from BL0PR12MB4659.namprd12.prod.outlook.com
 ([fe80::21eb:6424:fbf6:a189]) by BL0PR12MB4659.namprd12.prod.outlook.com
 ([fe80::21eb:6424:fbf6:a189%6]) with mapi id 15.20.5458.024; Thu, 28 Jul 2022
 23:13:59 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Keith Busch <kbusch@fb.com>
CC: "hch@lst.de" <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, Keith
 Busch <kbusch@kernel.org>
Subject: Re: [PATCH 2/5] nvme-pci: iod's 'aborted' is a bool
Thread-Topic: [PATCH 2/5] nvme-pci: iod's 'aborted' is a bool
Thread-Index: AQHYos8+2F1N/lIaN0q4dXxEiPkeg62UadCA
Date: Thu, 28 Jul 2022 23:13:59 +0000
Message-ID: <f902430f-9d0c-292d-3f14-605af69b3763@nvidia.com>
References: <20220728221152.538648-1-kbusch@fb.com>
 <20220728221152.538648-3-kbusch@fb.com>
In-Reply-To: <20220728221152.538648-3-kbusch@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: de5bc21c-e760-4455-8e47-08da70eedaa0
x-ms-traffictypediagnostic: MWHPR1201MB0062:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  VYUQLU5JWjyPPdNTAW9GJrRS3X60YsrQHG35fYS8k/zAuQE4+oSZfC+Z34PXuDlVSDcD6IczIqE0YJ0hdYlrSRFgUVLP/F6g4aLzSdsjqHFiWN6jnl2MZpMvdYp/rLSitnODLzz/UgwFZ24ZyhvfOLe8uLYusACW6LF/i7Sz3U+orcc7XDgG0T7j1X0Jq4dLnWm0wkVtYAv8VUS9lPLSrB+cLV3iygO24CX25h1aa8CYKGuyIhfYYIN7ae2zAzIlTlM62F591gVw8o5jQL6OTp2VSZOsCNgYlljx7bz2fe//X37Ry0F4mYvOZWLg5BINMuBnvSzG2xBoLkWhMg9Wiu3rbgShnvdDjbaRkO3n6n4d9zvfPRD5Ncv0X2bE9KfZFCq0STXiAFMJ0ZoM5f0Eg0QILfrjDs0lFiyB9O8FDlEuHwxOVszJVO1rkJY5KgHtO5y6RVEd8enVBywsZSAUnfoQR7F8l/Trn4IRx9oFWB/FR45kpXsUgYFFprPv/EnCjS27GuwOJM87zoXrfqJun6WSYsvhkfcabJIkPviPgOOy+85Ig7a7HOpDtA6975Ks/qb5+Ze5wT0YpI2VUe4krthwSSEERMNZOO7ecE+kH0XgWVQrkjumLNUb7p7i6mVrfqtYUeOAehqxF+8zOJFOP06uuBoB+42IiG+g+jnGStiOAb/TyBlAZZsnUzJp+PozFDjFtaXfQ4o5k18jPo0pNEH9scU/346EIe2E8jgE7Mu8sDdyYFTCExAotu9dSIfERjXomr9j0KB5/Dr2VkJe1032Vk8751vXTJhQwb0+2cdzV7xt+8Hb3vMIbyiFDJLYGHh2MYbQ/ySuskD5SG5GL1PYojPQAwJGClHBWaFOFNUp9eTojNixgf9SGfzDoQKg
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB4659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(39860400002)(396003)(366004)(376002)(136003)(53546011)(31686004)(478600001)(6486002)(31696002)(86362001)(71200400001)(122000001)(558084003)(38070700005)(6506007)(36756003)(66476007)(6512007)(8936002)(41300700001)(54906003)(64756008)(6916009)(316002)(2616005)(66946007)(38100700002)(5660300002)(8676002)(186003)(66556008)(76116006)(66446008)(4326008)(91956017)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?utf-8?B?ZGlkU3p3VlBOVElDSllYa29hemZLMlBsUzdLYkJVQzdnMVduSjR0ZVVMNUVa?=
 =?utf-8?B?bHlENjh5TXhLeU1pcVhmZXkvYjEzRjY2ejlqQmU4OVRNWjBldkpIV3FhMDhE?=
 =?utf-8?B?bjNmWEl0Q09NNVlUZmUwbFpaVmx0QXVzL2w1ODJ3UlBDWmpXWlVpR0JUMHdr?=
 =?utf-8?B?S1RtZWdkN0NkSEFLQnhjYzNPTXNtdjJKYURwZGlJbkF0Mm5aaHVMYW1Hb0NW?=
 =?utf-8?B?dmliL3Q4SzlncW9FRE1mek1xdU9QR1hqZk5MZGZZZXJZSHBSRDA3WllCemFI?=
 =?utf-8?B?cENITG1meFJMTlpsSjgrV1NuZDQreUdLVW9ObnZrc3FsNTlyZE05MEZCQm9o?=
 =?utf-8?B?SlByM3JPSFFpOHl2WWcvWEpIcERIREh1VjNRNXhOdElrTURaR3BvOFpiaS9L?=
 =?utf-8?B?Nm12cFp4clNxRXhxYUxBcFEzbzNtdXJwV2d5U2l2UU5zRGpka1hSb3QzRWJN?=
 =?utf-8?B?RTB2QTVGdWg5UFNDUFF0RnJvVlFicTZMdFFMRjEyOGExUXNxcllFRkJGc3l1?=
 =?utf-8?B?Zk1DeElLN3dCVVhHWDNrdUFmdjVvMER5c2hkSlpjNmFXcFM5R3hBTWhuOVps?=
 =?utf-8?B?SnY0RUdtZHFnWWRhYmxoM0xCT2ROSncxVkh2dG8zWCsxZlkvQThpRlZ0WEE2?=
 =?utf-8?B?TWJnMzJocmtBb1VPenp0SlIxQ1VXa254SmlzNmRKL0x0TXhhVlBLQXV6VWNs?=
 =?utf-8?B?OUhqQ1ZKL2pJKzFKRlRxbVdGQzd0dzFVLzR1MG1yZTNBVmdueWdjRTRFaDRT?=
 =?utf-8?B?dGNwR2JJWTl6bGtJa2paNCtIdEV4cWcvd2x6S1dXUFRtVmdFTXlGUkQ3bHJL?=
 =?utf-8?B?bDZXSE54dzRlYVkzT1BteE5IZVBNUnVLS2xySDZRcWFoUjJSb3EydnZ5V3FN?=
 =?utf-8?B?TzJrcTg4d2RHRndJOTlNdXBlMGJLQ2RYMTNtYnhYWXZvZGRrQXpOL1VQb0Jy?=
 =?utf-8?B?UmJ6UVdTNXJpTlJiWnJja0JhNmhvcDZYWVZackNOajdmUFJwZjNxQzdWdG5E?=
 =?utf-8?B?cWJXYi85RTZwNTJmdDNpbSs0NlM1aTQrYzZlWWlUNGdmMVpwekNCa2g3Um83?=
 =?utf-8?B?UldKUU54VE15QWNab1VuNU05YTBOcWZKOC9ocEhxejRXaG5YMFg3NFNGQmpP?=
 =?utf-8?B?cWxOdC94Y01rVjc3OGYzZXRpKzQ3NTlGcktDMlhRZVVQVTdTc3QxaTJpZVlU?=
 =?utf-8?B?dUsxcHM2ZUhpVUtmcWNFemlDY3IvU3ppbkxGaVkwZjh0eWprMmRGUGc3aTE4?=
 =?utf-8?B?ZzhEMEIzSTQ0ai9oNzB2WFNVTy96SjFGQ29nVWVNQndWaEcwb2pxVytZY1hM?=
 =?utf-8?B?RnNlME1sUDl6cGtEZGxYNG5BTnIxQVRYYnk4RUxsMWJXc1grSVNCNE9GVlhT?=
 =?utf-8?B?SUxGZXhBNGpaaVRQOU5OZ0h1bkhiWko4dHh4SExBcGJkS0xQcUdiamVEdEQy?=
 =?utf-8?B?elhIZFJVaXNEWnFtRldzZUdHZ3VlUDlKOGh5YnhnZUtNYm9taVJOeWZaRHVx?=
 =?utf-8?B?U2ZQTzZWR0M3cHhHbzdzU3YycWVzeHFyOURzcVc1OEtmNklKejJ0R1p2N0NM?=
 =?utf-8?B?K25FWFl4R3Mvb1BsSEdUSXYydGgvOW1pMmVBWXFtbjZZNnlCelltSlBDUDZE?=
 =?utf-8?B?MU1OTDhhY2xscG1CRGZJSGJ1S2JhdzV0eTViN0FKYnZ4VGpyVnhOZ1JMZXVa?=
 =?utf-8?B?aFJEVDlWcldXSFAwWC84OVgvNEZLWERRUUJReFZrTHFaVWFiTXhGempjUUhv?=
 =?utf-8?B?eUpKdUlRMXhqeU8zSmlZeXY0NFdHcWhxakNjVW94VklKM29QVFhwRjhIY2RM?=
 =?utf-8?B?Y2QrQm5xeGcxTTV1L0pxdEkwM1hLdlY0TE96VnM1KzlJdzVWUDJNQWY5SXM4?=
 =?utf-8?B?UjRNM1VVY1BJSDRRMk5UYWwvaFJzYTk4S2ZORVZsTndXOFFwcG9STDg2Y3lV?=
 =?utf-8?B?NnlUS1ZGUFkzMW50RktRZCtJQ25sTjQyelo1MFE0MnlLYlFFd1NSOGYvckhp?=
 =?utf-8?B?MnBYMmllSHFIanJoZWh5ZDBiM21uZDZFcjAyREVnNHdIclZOVStrOFNVWmdS?=
 =?utf-8?B?QXV2cjBaWUY3YmtRT1pYWkRkVW5KRXRmdDVPcFl3L1d3dVVGSXowKzRCdW9O?=
 =?utf-8?B?RmZuY3hjNkVDTStkbEtjZkdXeUpCbG4zSExmT1R0MU1kbWxWODBLOW8xRllG?=
 =?utf-8?Q?V7v3uLcVLdHoIKe1MCCdrJoHrtLQDcZD0OxVd88QuV2V?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <564BCE920DCE324683A81CB3ED7DC070@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de5bc21c-e760-4455-8e47-08da70eedaa0
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jul 2022 23:13:59.8672
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +2iuixeXi1gE/LksAPrj+lp7QOiT98SnVNaYWXrmYtzhmsNt2rKlVE9PqI5gQx+xDIbbohcTdQGHwUhZKWMb4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0062
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220728_161403_962356_82AB9759 
X-CRM114-Status: UNSURE (   9.74  )
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

T24gNy8yOC8yMiAxNToxMSwgS2VpdGggQnVzY2ggd3JvdGU6DQo+IEZyb206IEtlaXRoIEJ1c2No
IDxrYnVzY2hAa2VybmVsLm9yZz4NCj4gDQo+IEl0J3Mgb25seSB0cnVlIG9yIGZhbHNlLCBzbyBt
YWtlIHRoaXMgYSBib29sIHRvIHJlZmxlY3QgdGhhdCBhbmQgc2F2ZQ0KPiBzb21lIHNwYWNlIGlu
IG52bWVfaW9kLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogS2VpdGggQnVzY2ggPGtidXNjaEBrZXJu
ZWwub3JnPg0KPiAtLS0NCg0KTG9va3MgZ29vZC4NCg0KUmV2aWV3ZWQtYnk6IENoYWl0YW55YSBL
dWxrYXJuaSA8a2NoQG52aWRpYS5jb20+DQoNCi1jaw0KDQoNCg==

