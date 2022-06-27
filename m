Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 654F8C43334
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Jun 2022 23:38:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=u7LoCEekQsvNwarJbpPP4eAlR+YrLSdf8macBoO7qE8=; b=mhA7mVVFvMTtEBTa96UhetElHe
	dMDpCtSg5LN8rWmKdJgRJTxpjthwptLxFTaj2Itk19sxT9r08ob4CfgTj384heTEmShWviFjzhGlD
	wngHUOhWA5mOGt3ykoKeWffRkNVuMN5tFruBvfZrrjs7MMGKB/j6UOaDTS9jLtDcD9dYXpNPiwrwI
	CtSWG0MqcbsTRzlzhXGjIqrNJ9UO3cGJLMHLQ4VSqJTol+uVkBZ95R8zlCI+HrvTqY2HUxgUH9JBh
	l2lF0mHjEQSSrRcZyoxnJhStuHT1TvZ/gjXXI08VhjgcRuk64UxtuuzqCi7FpqqQ/Zjh261MOVQHP
	fUFZaz+w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o5yJG-003Izl-UX; Mon, 27 Jun 2022 23:38:26 +0000
Received: from mail-dm6nam11on2055.outbound.protection.outlook.com ([40.107.223.55] helo=NAM11-DM6-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o5yJD-003Iyv-L2
	for linux-nvme@lists.infradead.org; Mon, 27 Jun 2022 23:38:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PQ02UgOb5kXYn+YWqhOAc+cXzTXNxOFy1TS+e9bm8JmoF+byTRballIjTcSCuvbnEr7dlwCOzB4nJLQLQW53Is79F9HrnBeWDoVOxZR4H+QTpIcVl+kyR6kYj5+YxnlQHX8/y/yU8D9Sw3cms0ChsL1GuO4WeXKWHh3ollVYbbLaAeqqy35KjwxcSr0rVNzFMAhbHGlG/Sja85xEKZmeDIDauQxc1rlR2U7HMM1SJ1/J9h5NUNVIxfXadr/2WplXUFlzkJRLeJZ4XdXAH8GXe6AQbAD3lCQAHg8O1AkZnSPHBWXeg+PGDLydjl6q8sRl5xWZMprLpNMlkJTH0TAgRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u7LoCEekQsvNwarJbpPP4eAlR+YrLSdf8macBoO7qE8=;
 b=NZt1Hr83s763noDNIeYpuWaNz35D8ewrKOx+73wmH0ldjBX5hXEQvTc4oTeLCa7C481F5MkFZm0DyHKJ9QdUvEyM/f/pzwVTMhGWUP5IkB8F+jEdrTuTlyioJQdBFjxW6BPbH/eO7aITlSFAi21APFrtah2GVum0wetbPFO0DdUL2WKL/n+/f4/b0ufVU8ktKKbLZfZD4rg+fMzn9At/inuOsf9EHlKiue+ISUS46rqOwg3Va7penrY9fSP2qxpf6Kn7Lk/Rj3VB4vhOqdptaJGD92aipWHiY3Bte3ugRhwsaVsa6jL8tzRYEa5KvVA6XcEcyCI4DZS6Uv4qu92igg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u7LoCEekQsvNwarJbpPP4eAlR+YrLSdf8macBoO7qE8=;
 b=dXVF7gGW0gBOyVxjM/E4SzjAEbOsvpuxl24FHxkr8gr+0qZxoRQ/BDLs91QwAS4Nz/MIJeBrTmA0sKh5SivkVFGxIuMquf5Y0f80TjlZgr+6zPk9uPBdz1RM+wZjRliOHcrhJclE6tcRC68S+g4GGcvb/tLyzIY0M8WaN3j1zwAnEzMx/N6qyXLoXeRiRpc4HLL/rDO3/DG//QEKSOkhD4y0Hm93tqINxKC7xNECq+bQ8JlT5Dkf7sa3n2QHAbFAydXgmyYHwrgZ/qrOyvXFjRUUDLGbAsulpG0d2lpfymu7Y4+SLHlDW9jq7nJT5heYmtBHfIgzH3DC2pHP68e5uA==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by CH2PR12MB3959.namprd12.prod.outlook.com (2603:10b6:610:28::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.15; Mon, 27 Jun
 2022 23:38:19 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::240b:5f1b:9900:d214]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::240b:5f1b:9900:d214%7]) with mapi id 15.20.5373.018; Mon, 27 Jun 2022
 23:38:18 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Sagi Grimberg <sagi@grimberg.me>, Shinichiro Kawasaki
	<shinichiro.kawasaki@wdc.com>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>, Hannes Reinecke
	<hare@suse.de>, Christoph Hellwig <hch@lst.de>, Keith Busch
	<kbusch@kernel.org>
Subject: Re: [PATCH v2] nvme: add optional ipv6 test flavor
Thread-Topic: [PATCH v2] nvme: add optional ipv6 test flavor
Thread-Index: AQHYihmjcdx6wdvYkkitSDIjLV76qa1j6cEA
Date: Mon, 27 Jun 2022 23:38:18 +0000
Message-ID: <ae94f902-da17-4de7-70d3-68b47a44fcb0@nvidia.com>
References: <20220627113200.121100-1-sagi@grimberg.me>
In-Reply-To: <20220627113200.121100-1-sagi@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 08758945-a9d7-4ea9-1fd2-08da58961d5e
x-ms-traffictypediagnostic: CH2PR12MB3959:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  bNe/eOqcYw/747CcWpux+LAAdauRz+QAyFDLnqYGGx7164KSUUFqRVFhYM3qVpihsM5+it5y3PJ2SJZIB+DLabyaem4xLr8TqnKKKfGfbSqm0dBMNhk9cwHJemxESo2mZ8fAYNNWvBcOWBAjt5ebKzeT/v52OEBOy9K0eXDtP6WU0uqGbTKKyr0uWst5iHP3ctcu5nGkBzEGAlw4mqhc5l+gSv0X3oO+JPTuaUTlUQOqxaS0YgbhW6Ph5Iai18BiwBQYByeRNDbVW0/Brrg4JcCfQKLSVBrQFqNdfA7rIkE/m9TXgMGqrsuDCTLy4OhborqxJa0pr8hDIDxd0UmLFR8shyihi9Ic8IN3rMR7WiQCUifZfewGFU3ofU3DjIwbobheCqOh80eF8n7PltJwsdXzpZGYg3DHwX5PodLoKv7m82ziHLGGvtOJHkhUWd5SzJIsFgKZrBbMAIuxcLpXfpeunvkz4s/eNfiNcOcu86z49jzUWC7ammznuShcCXtHs8VReEGNOKmjyoR9DjeiwMaR3IbtHPY5Ur+byGabbsVFrNNBBZv6n2kJTIJgDI/gtY9zzPIb3aIE/R2ZVhT53dZcuQKVCd1qe6k1banEIGCWLOif6PInRzVcRuG/qrlol97N1K9a9IJOv+yVkES+hBCiXe1DzI1mN+/h81V0kuvWac/4RraqwJ5QFuO6WJ48bS8LQS/FimCCNpjSklin6R2OuyByp4Hvp2VwfhV0Zf28uWf1C9st5vMD7g1+V9sg5DHgNaG+q/9UMg8BHGcIRX9vfdMsi4nd7vf+IJMRbTGlVIdbtJoeng4NpnA7hCYUgJJpgJDaX1A6OaOSqT/Mo5mkoG+z6MgiOmwltb9ofWY=
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(346002)(366004)(136003)(376002)(396003)(8936002)(6506007)(66946007)(4326008)(8676002)(6486002)(478600001)(110136005)(54906003)(66476007)(31696002)(2906002)(38100700002)(86362001)(558084003)(38070700005)(122000001)(53546011)(41300700001)(66446008)(76116006)(91956017)(6512007)(2616005)(71200400001)(5660300002)(186003)(36756003)(31686004)(64756008)(316002)(66556008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?utf-8?B?VFZIKzNZdVdrQXhicXFuV0daSjhGK1k3VzhkWUJqODhsQmNWREV0eS9QUWth?=
 =?utf-8?B?TW5jZlpuYXJrMDBCZThieWZFcmNqYnhQMGo1NGpiWFBBSWhSRGdGbkhPWVZl?=
 =?utf-8?B?dXh4V1pIZGMyNlQ5MThoNEpjbGwyNTZFdzIyTk00RGtDOTlsUFBhb0ZqdWg5?=
 =?utf-8?B?V3F0NGNoVlRjVUtzYi9TSndkS3NNb2hkZC8veGZ3Ykw0N1U4YVBqZWJwU1Bm?=
 =?utf-8?B?azQ1YWlhbktocEM3K0xBZkI5b0k3RTQvKzVTMmZCTXhseXd1VU9uSmFnTVMw?=
 =?utf-8?B?Unljb3RBLy80ZDBJZVg2cWZmSHlqUjVjQys4ZndnUmNPR1d4YUZkOTRrMDcy?=
 =?utf-8?B?VjZmUVR5SmRpNWhkNCswSjFNZ1dzS3BvQnZaekk0UlIzSDVnZDVOUjVyMjZh?=
 =?utf-8?B?Wk1PTFViTGl4MVkwaFlsSHkzQkFWd3QyM0d1T0Q1SDl5OG1sUDRMZ3YxRHJY?=
 =?utf-8?B?N28xWWRDVmpKNkZzem4vbHhiWnNieEFFZ29hVkNvamgwWEhSWm1lOVlld3lz?=
 =?utf-8?B?UHJiUFRtK0FmNWhsQ0d0bWxnZTBjMlJYNDVvQ01LcTk1Umg4dVRqMUJIYXhH?=
 =?utf-8?B?UndKWCtEYmlEeVdDaEZQNnM4d2s0eHRXbjdRM3dIbU1WL1l3M21uYlNxTDVI?=
 =?utf-8?B?dUhIbTZ1SzFlMkUwV1AxbG1WaE9jZXZGUWZ1VXFIUDYyeGZWVHZKQzlLZ0xV?=
 =?utf-8?B?T0VLcFdmdEF0K0FHZVdCMUZzcXQ5ZHdEdFZDeFNnR3p3YjFnZ0xuUGVkNlB2?=
 =?utf-8?B?RTZsaDcxOG5pWHllTFk1Y250QnFGRnJJSmQyT0dmWUxTbFFzVkJ5RHU5M2xT?=
 =?utf-8?B?SEQ4NFk0eTRHY3llSHZ5UHVqTGhhTC8xWGZSUm5ZVm1USW9OczBRV0JBNnZV?=
 =?utf-8?B?cXJwWTFSRWE5L21hRWpFcjB0MUZtMmIvZnBzS3RMMU9TcytXek04eGdNaGRR?=
 =?utf-8?B?Z1J5czkvR0U2TWdNRW1BT1V2d3FGSzZJcXRoQU4wM3dGNklnMUF2SVg4MUxR?=
 =?utf-8?B?TUZGa0FNUHhZUytNazJLZlZsblUvZGN1TGZpTlNJbi9vMG1lelBubFppWlQ2?=
 =?utf-8?B?TjJac0RNN01mQ1lUd0c4d1VPTnhXb082ZkRhZW1KdEgzdHkxblh2dnFyS2xB?=
 =?utf-8?B?dEJqZDRKQWtkd1hSb0hDblFSeTJSWHRYeGtNUzdBNTh2VUM2ZTczZVVWY0Jz?=
 =?utf-8?B?UG5rUlNPRjgvcS9EZGp0bk1ZMUxvSDVPNFhwWTNGMUtxclVRMGZXUXN6SEla?=
 =?utf-8?B?TUhFNDdSZGl6cFAzeUdkdndyd2xteFA3QWYrY2RhaVB3elFxYmlEY05Rc2ZR?=
 =?utf-8?B?YTlkZ2RZYkExZTU3RCtVaEh5cisxMXNic1RqenZUQXRyS0lIWFpNYmQzdDhV?=
 =?utf-8?B?aSt2R2R5T1ZVenB0dVFGOXZsUko4V05TV0VoRkFCQlZaS2FZa2NYMHl6Unpm?=
 =?utf-8?B?VkhqNEEwTWJsRExSV3FoNFA0OFp6bVp5NHdKdHZaZWhTbUVDN1NadmhGRWpQ?=
 =?utf-8?B?TEFoaUJGRDF2OGV2QjQyM3JKRHp5NjJPbk5IRk9UT0JHOVBZek5vZjVUcWxV?=
 =?utf-8?B?WjdOa3dpSU92WWt3cm1xZnUrOHFITkZnOEwwdlFMQUl5UnVaR2JWakZLdlpo?=
 =?utf-8?B?cWVtVnVyUm5lNTBXVjBvekl2a3o5eGl1RGVpSWxMSk9rMjZBZ0tFNGJJUW5F?=
 =?utf-8?B?aUx4NmduYi9OWXMwSEh0UFppbUhEQ1VET2dOWm9XWi81a0NTVTBXRGQ4QjR5?=
 =?utf-8?B?UHVIK0ptaDJiMkRrQVZKamJHTlpON3JDTGI1eXZoTEV6dkliOUt4YTdKQzhZ?=
 =?utf-8?B?NjZ6Uy9JY3NOdkF6dm93S3RPekp2cWNKRmk5bVY0Q2d2M0Y3S1VuMDZtUUJI?=
 =?utf-8?B?QnpQTGVoczRoT3g0SU1YdW5NQWdaVW1wb0FCZThnUmV4bDhLZVNIL08zMnNO?=
 =?utf-8?B?eU9VWGE2YXQwNTNac25tenZIWThrTFZWdTNmS1QwdGs1L0dQU3VhQy9EZWxB?=
 =?utf-8?B?dUMwU2VOZ0JMWThURXJBV29NQ2hFZmZMZHgwU25QalY2MWZFN0dGN2swbWEv?=
 =?utf-8?B?Q0RSaWZKSHY4NU13WTVleERUeHVEVDRCdmUxSEFmcm1tRndoeEZaQjZGYWlx?=
 =?utf-8?B?VkhLWGErZ292TVk2U2gzQ2xUNFRJenVCUUVubkVnaGhIRWFLZVNPMjZ3bmFH?=
 =?utf-8?Q?t4XmnShMrVdt7OYaBRQ8DovseebIW81fPHfdqrN+MwEm?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DEEEE7E195A59D4396DB8F94A75CF5E5@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08758945-a9d7-4ea9-1fd2-08da58961d5e
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jun 2022 23:38:18.7236
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5Wvd2PrRJkSGr8vSQd7nc5BW1XA65LyuWjEuEPBUnSfA0bKYJYtFMclrUFPjhSKewgI9mWt2scGU0xCkMb+IhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3959
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220627_163823_954291_7F394295 
X-CRM114-Status: UNSURE (   9.19  )
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

T24gNi8yNy8yMiAwNDozMiwgU2FnaSBHcmltYmVyZyB3cm90ZToNCj4gQWxsb3cgU2V0dGluZyBu
dm1lX2FkcmZhbT1baXB2NHxpcHY2XSBhbmQgcnVubmluZyB0ZXN0cyBvbiBlaXRoZXINCj4gYWRk
cmVzcyBmYW1pbHkuIElnbm9yZWQgZm9yIG5vbiBJUCB0cmFuc3BvcnRzLg0KPiANCj4gU2lnbmVk
LW9mZi1ieTogU2FnaSBHcmltYmVyZyA8c2FnaUBncmltYmVyZy5tZT4NCj4gLS0tDQoNCg0KdGhh
bmtzIGZvciBkb2luZywgdGhpcyBsb29rcyBnb29kLg0KDQpSZXZpZXdlZC1ieTogQ2hhaXRhbnlh
IEt1bGthcm5pIDxrY2hAbnZpZGlhLmNvbT4NCg0KLWNrDQoNCg0K

