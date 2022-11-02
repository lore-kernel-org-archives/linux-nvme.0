Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26D2DC433FE
	for <linux-nvme@archiver.kernel.org>; Wed,  2 Nov 2022 05:50:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CRuVFqHZnQ1dmiMKtKrg9Ck1xhvYoAI3IzysU2/OUew=; b=LOxLZUcUu3q9QnbGa3+VtLDyIs
	7IdVGoYcI525nGo0o3WKy13BFKGXlviAELBdB5MX/Bb/QbfjLZND6RhAjy3wC/5tnjV3SztuWiE2o
	XSNlCSWac0n75hIUocheOEddjErwFye/quLq5CR4ggmJYePpHzmxB2BF5SwcZP+R+iTkl64843hQs
	rKqkrpfi7zxlEBuC3GBxeV2yZjrybvQuWQlDjfsCpo6mcFPcd+n9orGIlcGMl1fxj8vsofxNmmlFA
	CJFNM7RyC1XokG/D9dOj2CuO3TzlbaKydcvkAvI+yghc9L/20UM1RUZ6A6eE4a1As7He0BDAQnwzR
	XJWmJssw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oq6df-008LoG-MT; Wed, 02 Nov 2022 05:50:11 +0000
Received: from mail-bn1nam07on2045.outbound.protection.outlook.com ([40.107.212.45] helo=NAM02-BN1-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oq6db-008Lla-Rt
	for linux-nvme@lists.infradead.org; Wed, 02 Nov 2022 05:50:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RcBc+ogV00/40yJtIOTgWi92lPaRp4DDJha828meoGPURUccG6zE8OwmRCNcSjIYz2AiVeoqTkP3op+Ui2RZL6DXNFws4n1JirXwq1gb1/8jX5Z90OfWd/ttfB5b/ybghXgEvranZVKcgh6kIhBP4kuZsIb+67phwaqTaF9m/+C3UliNpCK929clkEzCtQfPd2RDyQHk+tzwuTMzxZZBjJ7fU0gSQh8+k+ZlNZyTC0Xd8BNiNooFUgRDBgccw2zLz3FLcZlrInt7MEgvGqlA0yDBwUs1QNKMu5SSf5UVbvGx+4CMNTKGtfAYwjXNOdgz6r9zdeeRSeVDk301M3Oi6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CRuVFqHZnQ1dmiMKtKrg9Ck1xhvYoAI3IzysU2/OUew=;
 b=KfFu1DzBMWkx2l8FDv+64hDlaKgNzj8CqaVFQGFy2d+fdGXoC8csgCVup4y4sYpnS++rZ92YiaLNGIlbJ1gVlZRa+70SUmRTqqksCra0vJmtP06P72hS5f72P/YPlHlw6Jddgjjrq2QOl5NXVubzPVE0un9XLC2rNjxIHS0HHgU5An54B9CVUv3JMvAUOTbo+F18OQkRlOU1gQOIUsLqxQLtM0DtHLG+dureaQjo/rujM7/nobKJGsnqHhydctCTdqIjTIPTIzGa0x/5rR46YrICsM0XDayH6B8AZEKdJcULhli+NrXl9CUF4lyUyNGjI1EHWWxO2FUwGrKeFXgAPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CRuVFqHZnQ1dmiMKtKrg9Ck1xhvYoAI3IzysU2/OUew=;
 b=ic2UmqeD7qrNOBYDKGzrUVKNphGmNg4OscKgOc/Svxn0gBxnfF+eEvbjg4ArPxfJ1C5azYUFY2xXRZcR0yGCnWY9isjor/HvTCZOqKIu9LhTXGyFe3rZpoTdR+qijYMs5pr3X5X0wp8rdxGXLuGXJqkU1VFIF0BeLyEFVd1dNOZxKMyKjlG4XrdhmtoaUzl98WCYx7cz0dl13uSWoYIV2sHXgEQF+cS/Uz6uoPlnjlPXjjSeol1ifQrtQVS11qQrfZJvVUKJjoCN1dk7rW6k1PwuBWXXZ/icW6HJyu5+LcDozi7sLTd2A5psR0wERsQdCmK5CI+7XRe/viVJyfBjxQ==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by DS7PR12MB6239.namprd12.prod.outlook.com (2603:10b6:8:95::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.21; Wed, 2 Nov
 2022 05:50:04 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::eaf1:9be8:d472:ea57]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::eaf1:9be8:d472:ea57%7]) with mapi id 15.20.5769.021; Wed, 2 Nov 2022
 05:50:04 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>, Keith Busch
	<kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>, Chao Leng
	<lengchao@huawei.com>
CC: Ming Lei <ming.lei@redhat.com>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH 12/14] blk-mq: pass a tagset to blk_mq_wait_quiesce_done
Thread-Topic: [PATCH 12/14] blk-mq: pass a tagset to blk_mq_wait_quiesce_done
Thread-Index: AQHY7gME/uYTJ5pRcEi3nDCJi8j8864rIeIA
Date: Wed, 2 Nov 2022 05:50:04 +0000
Message-ID: <3121799a-c63f-7c17-36d4-6121271d5203@nvidia.com>
References: <20221101150050.3510-1-hch@lst.de>
 <20221101150050.3510-13-hch@lst.de>
In-Reply-To: <20221101150050.3510-13-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|DS7PR12MB6239:EE_
x-ms-office365-filtering-correlation-id: ea1d3f36-051c-404f-7b4e-08dabc961753
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  ocMFmeSUlNAgWEAUzqstS8TSLiIo/mGzRtenipF+WWLsNBnzh0RhrkP4iRb25s0S8xuvjqKUd3+vWxyIZjgH247Ig2CIKXNrVFg/etyfGv4NRTC535yevQerj6UUSmxFXYfcEN3rDGYTT+eR3WuzwDtcRtDM2fP7OSLeCN11UJBkln4e0WGbEDgBI/iXEs0RSJwybNUNSkCCO55o3hKa7KTpEfwwQfgCT+5sDeaoixGiKgsdmo0pnho+7LR+eN/UHQ6MSQnhXi/vdCLRIVjKzBJ7++zSVRlGtkkERBxBSEid7msX87u2cakLC4g4VEv8OzSYEjHVVAkiFN/uEHvGGGUBwCUlKx6r1eUYfrUiDhiglv0EASxfg7YrA4uKb8mRKCJWVx+w4jtd6i85v94iFqG80DsIPmnMOkPb3ucJcO+XHo/HYr9/nhPMBqlrB/EFms0wJsGAMnyePR8V3gRQ5TccnBsRu4vwmxlnacSiwpQ6YiZI65LDKbkeeRgcQT7MmdWt7+R4de6gNajivGeiVMaou22vryHTIYU7g+SBOteL3IeiSAHE8eCS2AqtxVJ0pFVBYs7K310TwefCvv8wz5t4y+yGAwjfOuzBDmL3opTOVRB+Ql0s8rgOL9jrq59HwB83YxfpdcWvdodoDXke08LpDOLs2mz4D9KMq8OD8Eo5eOYKRZtbUDB+k3BpgqHX7Snh0IDCVd/ZYfgNmb/aKlZxq+abfhx0rmYzP1blQ8Mn1YtKWNJbAXgaELeY6sunlRJQ3RuaoLEaa4mnFVJR16vBPwg6kvvFOIORjuFjzXttGuubgBq7mvxV4uVygiF27vG6p3uFgzvOoMAPF2Q8FA==
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(396003)(39860400002)(136003)(376002)(366004)(451199015)(316002)(110136005)(91956017)(76116006)(53546011)(31686004)(8936002)(54906003)(41300700001)(4326008)(8676002)(64756008)(6506007)(66476007)(66556008)(6512007)(66946007)(71200400001)(66446008)(6486002)(2906002)(186003)(5660300002)(478600001)(4744005)(2616005)(86362001)(36756003)(31696002)(38070700005)(83380400001)(122000001)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?utf-8?B?NjJkV3JkVk1DdUtHKzNIUEJEcGFpdzVHN0lKcitUZ2VHYndMYjhUR3BhWjdN?=
 =?utf-8?B?ZEk2Tm1tTUxzZ0ZaRERwSmFCdXhxekx0aU9WbHpHV2ZvNCtOaFZoMlZXQmRR?=
 =?utf-8?B?cGUreFAybkk3TW9YT0x6YndtSjBBSGNnUEdjM0lTYWQ4RHd0OUI0V2I0N1Jr?=
 =?utf-8?B?K3dpaEVHUXdqQ1VUOEV3ZkR5eDA3NERBRlZvY1dJdFdDVEsvY2M0V2Jqb0Yw?=
 =?utf-8?B?WWNEa0JEbGRZb2RIL1VLMXdvd3htb2RkR1ZkTUpycUxzZUE3dWVIOUlpelVM?=
 =?utf-8?B?dVVkT3NJMnE0MjZmMDljbUFNdHplZTRaY1g0WkllYlpQMDZkRXNFSFNUakZX?=
 =?utf-8?B?MmVXTlZpZHVEeXZrZWVkdk1VMkh1L2lESmpZNzFLRmUxUEEvdGFyMkdkc2pX?=
 =?utf-8?B?MzlVQ0g4RzFHcTJRbVZtYXgvT1V1Vy9yMXBvb1BWbDhiU01QU3BRNzRjMEVh?=
 =?utf-8?B?LzNUNFk1Y0Uyd05LOGFpd2p0K1Y4alMvakRlbVJGZnVxUzNKcmRySVpmMkky?=
 =?utf-8?B?WDgreUFnSmpEMkFYMVNRQjVOcGhDMFM5dTVhK09rbjl1cUkzMmpaSmpiOHJw?=
 =?utf-8?B?V2pmY1RSL1I1cWhuRmY4L0h2NFB6WTJ5aDZnZEdTL2R2NzhOYWdic08rYW9L?=
 =?utf-8?B?TWRxbGkvaTVLL0VHNnBzVTdVVHpSNGVndXJ4dVlhNVVscCtOSHJEVGhydVE0?=
 =?utf-8?B?QWFraXg2WFl4US9JRU81N2RNRVVmY0NuNEpXaUdhcXVXREpUMHlNbmRlZC9K?=
 =?utf-8?B?NXo5SzhRNXp6Z25qUjdYY003dldHR0JGUE1TbTRaQURoaFF6QVNKcXRVTlBv?=
 =?utf-8?B?VmliU1BSWmUrRCtra3JrVU5kajI0OUQ5VTNndE4vc3lnbk5NQ2VLQWYxbGUy?=
 =?utf-8?B?WmVLR3hzZXdhZitGUW5JbGFrd0Q2NmpRb2o5TXkzUVl0OTIvU1NyTFgvYmdN?=
 =?utf-8?B?c3V6LzJ2V0ZkYWdsRW5qWUZuNTFBakx5NXk2VTlCYmRIaEhVVTlUbktLSUxZ?=
 =?utf-8?B?R09yS0loMXkwMUtCSW1TT0l5M1ZhdHZQV3hvdlMvQXA0VXM4N2M2SVFiNndx?=
 =?utf-8?B?RExLWW1HRHRkQjNkODE4UGtlSDZsdk5hWjZRckZLeDlBdTRhVHIzMkpXWHJ3?=
 =?utf-8?B?ZjhpSTBnNDJ2RXBWVGo1aUxDRlRSbC8rdjJuVFZIdFJqYk5yZG12RXNIcURa?=
 =?utf-8?B?bkxvanM3eHQxNmFQVkUwRjNRRnJwT2c0Qkcva0xiVERiQk9WQUJoVzFQbEg2?=
 =?utf-8?B?Ly9aNDR2MDR2YW5WWk5vdEtyS0VYbEtLVFRPRkZScjg1SlY4c3I1eVpYTEt0?=
 =?utf-8?B?aGE3OUw5NmRqTEl5U0NFejR0TGpnT3FVUGVSbU9ndUg0VHRpSmZlbWJic0w2?=
 =?utf-8?B?UzFGbkhxUkFZbGVwREowL3VyZGFpSVpncUxVQklSOEtwbXJyQWNWV3RXNmcy?=
 =?utf-8?B?dkFGMVl6cC83NGVmdXE0bDN1QmdibjJXRjhPQUh2MUFpNnQ0aGM4Nkh0SVFZ?=
 =?utf-8?B?T3pUalZVVVg3eWhUK1hGMitOWHFJQnJRTm81eERSdGZrbzZUemJaUWlBMm14?=
 =?utf-8?B?QW9uYlJ0SDhTMDVKZnRHWHpPWlp2SEZOclFuVWZkVXNpWUlSeVUwRDErZFRF?=
 =?utf-8?B?dE1MNDlzZllVSTZGKzRKQVBDZnA0UHgrdU80S3ZTM0ZjTklqTWNhSjJDemZ3?=
 =?utf-8?B?VTh6KzN1aFNaN0hETXdoVDJ2S0hMU3RxZ2QrMXFHazJoUDgyM2JvcHpuOUJR?=
 =?utf-8?B?VndqUDQ2aU5pMUVIcURycDlFVkkzc0VmT1dGNEJSdjQ4dm1PL2xrOVZQRU5h?=
 =?utf-8?B?OXN5N3VIQVp2ZnlkODA1aklOeU4wZFR0MTl3Y0l5T2Q4Rmd4bDFzNytKM0ti?=
 =?utf-8?B?ZjUzWHkwTldlYVhibW1qNkVPYnJDejMrTlRUSm1VbkdYb2RFaFlCK0V5bndF?=
 =?utf-8?B?eXB0RlpVRUtYREdVMHNkR21kUzQvVHVQMXh5UzRLdTBFSDNyUWtxZ0xFL1BS?=
 =?utf-8?B?SlVnYTUvSUQzMHp1Zk9XTUhUYnlkZHVTNGZNcTNLdFYvaFhoaWFFYi9lWjd1?=
 =?utf-8?B?VWlweFhjYnh0TE5JQm1JbEtBNFhrcTRMZHV4K3drbGtndlFUQnFTOFFBaVpq?=
 =?utf-8?B?RXVVUjZ5ZVpxMHZSRlF2eDN2KzN0LzRRb1RqMG5aTEdkazhsNVZnZUo5Y3VR?=
 =?utf-8?B?dlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2D9FCC47F8C8AB4183029FF573BB3C4B@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea1d3f36-051c-404f-7b4e-08dabc961753
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2022 05:50:04.8497
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Gp237FPNruUhDQIUrfnFFs5wSVKP1tp6BHzG3q3hQN7zkS2ai9Ac/TMcDNet1gd2yY75Jo2Es/3Qv7Rs9RvXFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6239
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221101_225007_929370_E54D95B3 
X-CRM114-Status: GOOD (  12.24  )
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

T24gMTEvMS8yMiAwODowMCwgQ2hyaXN0b3BoIEhlbGx3aWcgd3JvdGU6DQo+IE5vdGhpbmcgaW4g
YmxrX21xX3dhaXRfcXVpZXNjZV9kb25lIG5lZWRzIHRoZSByZXF1ZXN0X3F1ZXVlIG5vdywgc28g
anVzdA0KPiBwYXNzIHRoZSB0YWdzZXQsIGFuZCBtb3ZlIHRoZSBub24tbXEgY2hlY2sgaW50byB0
aGUgb25seSBjYWxsZXIgdGhhdA0KPiBuZWVkcyBpdC4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IENo
cmlzdG9waCBIZWxsd2lnIDxoY2hAbHN0LmRlPg0KPiBSZXZpZXdlZC1ieTogS2VpdGggQnVzY2gg
PGtidXNjaEBrZXJuZWwub3JnPg0KPiBSZXZpZXdlZC1ieTogU2FnaSBHcmltYmVyZyA8c2FnaUBn
cmltYmVyZy5tZT4NCj4gUmV2aWV3ZWQtYnk6IENoYW8gTGVuZyA8bGVuZ2NoYW9AaHVhd2VpLmNv
bT4NCj4gUmV2aWV3ZWQtYnk6IEhhbm5lcyBSZWluZWNrZSA8aGFyZUBzdXNlLmRlPg0KPiAtLS0N
Cg0KUmV2aWV3ZWQtYnk6IENoYWl0YW55YSBLdWxrYXJuaSA8a2NoQG52aWRpYS5jb20+DQoNCi1j
aw0KDQoNCg==

