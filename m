Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0545AC433EF
	for <linux-nvme@archiver.kernel.org>; Tue, 17 May 2022 23:02:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=P/kmAUpqYQryAWuL1RN2S2j1c3+d5kbyhjniFU8hWf8=; b=NRze6gdCr8jwGdNNKgLFJBgbOC
	RGrEcWB5xsvP7Id0Qn7fu/a98gPsLF8AFVhzWDIwZy9HE25mgUxeiKNLq+m8LnpW61/UD2pO1Mygy
	mGXanWGL/bkVAN3yyTjnhfDxsdxxJ9J8kiKIRuaSK3Lxig5aUloIXvYW6vBlN1mkBXdZnmHlKlIDF
	gPR+sKLmVaW1CdEf2i7TayvlsTEsUZftggzp7x7tEtu19I99aKtnxsahrFS8MRQsx3+GKkXaI5swY
	fRSB/MhX9nYPeq2K8epFAoz9zWNGjgGD06qxsnhtK+muIH5Xy7rKUgUH6OblxnFBFEQhHLIT8G6a9
	B2CjLxSA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nr6Cq-00GBeQ-Ry; Tue, 17 May 2022 23:02:20 +0000
Received: from mail-dm6nam11on2062c.outbound.protection.outlook.com
 ([2a01:111:f400:7eaa::62c]
 helo=NAM11-DM6-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nr6Cn-00GBdd-Fo
 for linux-nvme@lists.infradead.org; Tue, 17 May 2022 23:02:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UZ38HPfySO1YVmth+N/CLwmN/3oXoGJJd6xKEm+3EDOQ2vbSuZf3prPdrQ0Cl7Ha7CeilU0BdrG3r32r9EeEwz9zu1MNaKZvaH2MCceXvsUKTm81MR9F5g428SmiHjRG2hgG7/z6jsGhT3zzl+A2p36C/UxAL8oLuzMjxcC0ff6UJwXbGzprReCZwHyApKYPfnn156syT4UiOvHq6O+SuOZqAizxoD+he6gWv+6xZm0xoz+g76QFlbxAzAa8xOrO88IxU8W+c/1/Xf4Kf2cfVDxHMV5epS4hWzIdVuqFowGn7RUaKNxV289PF5JOSzpbtEjRLY+nAfeb4ZQzv2gS3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P/kmAUpqYQryAWuL1RN2S2j1c3+d5kbyhjniFU8hWf8=;
 b=ncZMYKiIt23iJpSvT73nl0pPegaGB+2LU74MJGVIdezpOan/IPd/UUCb/bSIxnrmqeTo1JeReqQiYdct/v1h3Jg9IO1Kw69+1eqfh8WxebWRgwdR5SXAF3JaFVssfASUeaRwsoQR4bP14b/5I/9qDv9AU2yYjNoFyEbbqrG4uivrr37xe4XMSQLbjAlL1rCuDivyn2iY7qaJzuKae2hr5mD/EYAzWD0lftdCIBaiDFALHt5pVULD39FCu83iy+1oJwJobaK1GHtHpIEGukF67mqL2bpfXNMnE91Y4vCmuZ41dzX0VaQ93hEfOPk4gxgozSr4ymsKFyez6NAKYNHUlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P/kmAUpqYQryAWuL1RN2S2j1c3+d5kbyhjniFU8hWf8=;
 b=rBNWBwMQnsHs8SYa8zzhhPR1/WpZ3NJXHfzaQc5paNJkcwJJZxjGQnChDrnCrKG9iaQoCVzD4MJmj4r2vpWqJq310zs2VhESzIIayqq4KWGb5a5Gi5fD/59YwgU8+gW1VESPZGnjAJ7hEM79U+b9Z29o8BXz9DmXDpsB+2bK0rMxqbFBFFh8UB0MSuyJ3va/yDU1323kyJoC3KDLVtKMjwvjOCT8AxpUHngApeJPkGCBObXKOWdiF5R15/UcL1FEKnh7bTUKF0mJLIT9G7CX7WJ9gAH7TIVa29HBsex6nhsv7kpA2OGlhD7AG8kSsJyAgH1AoYlXEFMakdeOW7AxDw==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by CY5PR12MB6202.namprd12.prod.outlook.com (2603:10b6:930:25::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.14; Tue, 17 May
 2022 23:02:13 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::4925:327b:5c15:b393]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::4925:327b:5c15:b393%3]) with mapi id 15.20.5250.018; Tue, 17 May 2022
 23:02:13 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Keith Busch <kbusch@kernel.org>
CC: Sagi Grimberg <sagi@grimberg.me>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>, "hch@lst.de" <hch@lst.de>,
 "james.smart@broadcom.com" <james.smart@broadcom.com>
Subject: Re: [PATCH] nvme: set non-mdts limits at I/O queue creation
Thread-Topic: [PATCH] nvme: set non-mdts limits at I/O queue creation
Thread-Index: AQHYabJt97Qh9I0ok0uE3+uQMdd9La0i1UWAgADV8wCAAADMgIAAAUmAgAAChACAAAEUgA==
Date: Tue, 17 May 2022 23:02:13 +0000
Message-ID: <230ad060-bc0b-f2aa-51f2-0672ec4bbddb@nvidia.com>
References: <20220517055312.50331-1-kch@nvidia.com>
 <dd46fded-d213-6956-8f0a-69a70e0107d5@grimberg.me>
 <955bc8aa-dc88-68a9-c656-51e52fe589f6@nvidia.com>
 <YoQlXXvNCQIRT3yc@kbusch-mbp.dhcp.thefacebook.com>
 <04b837d9-fbd1-ed80-9225-e452a95a1594@nvidia.com>
 <YoQojhSp3AuKCQW9@kbusch-mbp.dhcp.thefacebook.com>
In-Reply-To: <YoQojhSp3AuKCQW9@kbusch-mbp.dhcp.thefacebook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7e866421-e8de-4ca5-285a-08da385947cc
x-ms-traffictypediagnostic: CY5PR12MB6202:EE_
x-microsoft-antispam-prvs: <CY5PR12MB62029B8ADC114A75E0528418A3CE9@CY5PR12MB6202.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tAXj2zDQMB7phbjWusR1HFBDle2WMGy1Kv+hNnyzmAffEqm+wsm7wNVkq3+UGfa5F7JlNtu0qJLqld4T+F+DO1egSVXnH6vML1JfZE5zxhGcSL3VOqGWjLqXoQJ+rk/++bafKs+yhnII3qYUNITPRVzBv3ftiS18EEc3uD01dETwokO2ZfJyhRh/Fk4ts8TEUGV8Zv2zd8SeecZGpvx79Ln3ha9VoaIuPkIALQ3A5XD4g0VXuRlGo6Lo8KtB/a3tkPaJP7JerMTJctxn+ClgpDwHbpfHPBVAwmguMG7o3FLNDz/7PZ2Fn7Fc4wNxKZ7djVg3+vR4XPvwe6bIR8HBAxEIgn1vKcFjAE+YUccUnXj3yHrjQzokjirxX/6NRBCltDX8HZZQv8b7xc7RxPz7/BI2F/YNanFn8VfujtVm1OmogNRh/VmRnKtESwPR7lNsRr/XNu5klFww43Ex+qFlNW98lI5xoWmobS2NufgTWqE0YjrvSGmJpBAdePPxVWnE2jk2YcE2W65ZpFNmh1kICDZ6etc3YuPwGBi4CccRhP9aVc8zLjosWud1+InU2MxINn2j+wJhuGNFCA4TqEEBbWxK0LMBVU2Nwy6kZPM7eteAzRHbyfyuG4Xai9CAl0IED6nuoHbmVe6LGlaJ9Grwa5YsjhUxjRqsIlepyQay0hxHLyOEcorZpNJhNSB4Ixv0SSIeImguF8a/jAyp4l6OeQxU6apnz+O9BrtrUS2uflsY0zZzz6ZXX1e9CZQbOd1SGxXx8IvT46sYcJohwU5A9A==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW2PR12MB4667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(508600001)(66446008)(66476007)(66556008)(31696002)(86362001)(122000001)(76116006)(54906003)(4326008)(36756003)(8936002)(316002)(64756008)(8676002)(6916009)(91956017)(186003)(53546011)(6486002)(38100700002)(66946007)(83380400001)(2616005)(6512007)(6506007)(5660300002)(2906002)(71200400001)(38070700005)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UXgvRFRBdzJQeVZrdnRwNHdHK1JVUkhwd0NQajA3RHBBS3J4YStnZUpEMzRF?=
 =?utf-8?B?VkNhTEhvZnI1a05ZMDZ3MGNreDNXRGNCS0QwTEJqZ0lZWTgzTVBSdStWd0JU?=
 =?utf-8?B?L3NYT21FYUV2SklONmtaU3c3a29FbnMwbGx2bmJMVmRudnlDcHZvWlhSZ0Rs?=
 =?utf-8?B?eVZ3OHNjZnR3cjM4SkN2TDNPRG5zNnU4Uk9tYmJrcU5DdUpITDc3QmwyY0dN?=
 =?utf-8?B?dEZvLy9INXdweHVjYUdjY2RNZTNCSGpjN0NkN2hKNDZpWmJNZFpYb2QwL1g4?=
 =?utf-8?B?WVdOSkNRWVZpUjd0aldJRTM5aTgrU1ZUVWRSOXVSUUo4QUFkOHdBZTZsUy9s?=
 =?utf-8?B?WklNZ1EvSmdTeDQvVHF2TWU5Nmp1OFpERmNmbnRBOWgyd2M0MEhFZnlxWkgr?=
 =?utf-8?B?elNiY01BRSt5UDNzQVhKa3RlcHZnREhmU0JtcHRuU0E0a3NveG5lbHdJSkZj?=
 =?utf-8?B?WmJybHhDTWlpWHRWVGxIUnFWNklDeXk0SlF6N3ExY1RlZEtOc2hQUk41QWVj?=
 =?utf-8?B?aFFUMm04TzdSbDBiajl2dzN0ampXSStwd1hYWDBiWEtCdVFDQmkyaTY4V0d6?=
 =?utf-8?B?U2xqaVgvUUJPRk8zZXduanFNR2R4c1hQMXE2dmw2UWI0L0NEYUtmK0NPRXVS?=
 =?utf-8?B?U20wRlN2ZGVscmpwbkNNMHBIWjRmVDhjR3E0cGV1MTJieUdkeE1YZFFodzU2?=
 =?utf-8?B?WlNFN1JRYktuaU9jcHcyYmZkM1UyT2ZJdkZNN2NWSmh4eGxPQk5HSENMdnlK?=
 =?utf-8?B?S09QY1RscDJZK28xVWdnYjJ2aVYwSTNOcDJaT29TejRJbTJ6azZDQkxscmNG?=
 =?utf-8?B?aXhuelZVSjkxWHNrNjJ4cHpkcjl2Qm5Vdjh2MVQzUDJjR2dkOE9WZ1F6b2xC?=
 =?utf-8?B?TkVSaEw2NkEzOHdpSXZGVE9IbEJtcnpLRWwrUytPYitTRjNIUkZPayt2eE5V?=
 =?utf-8?B?R0x5NFZndFpWYlEzL1RJZ044WFY3a0JnV3oreXNWajBYVmpKNTFYNFBlUmds?=
 =?utf-8?B?WUpRbjRDbEhEZnZYZm91ZkRBbzZDQy9hU0hMTkdyaHJsWG1BOGp3SGpoZmg3?=
 =?utf-8?B?VmtLTGV6QU9yWWlKOW9qdjNwdFF3Q2RyN1FaUndQdWY1MENBUVd0SGgrZU56?=
 =?utf-8?B?K2NCN0wxb2RrMGMrWUJvU1EzT0lXbjBEOTB6VHQ0Y0VsL2J4M0FRcjFKcXYr?=
 =?utf-8?B?ZHo2akZMSU55OGpycit4Ti9PTHpSUVdBRDdCTWRXd0hjQnc1dzNqRVcxUTdZ?=
 =?utf-8?B?UzRCeVRML0RYSGlNbmhQZzlGZ1YrRTZub0dwMzlWTEt3TE1CYVBQSEVSd1BY?=
 =?utf-8?B?N2hBVkRZT2FPUjJCMTNZWFpXR3piQWVSaks0VWV4aG9pYzVlSk9UbjN6WC9R?=
 =?utf-8?B?WU9ta3RHM1NNUit3NXAxMVZKVm5XZ0tYc1BBWWMzOER4N1Y0ODduQmVCaUJp?=
 =?utf-8?B?UHhGeXJBSWJqU01hblA1MUJ0VWpEb0QzWnU2Uk5UcmhxdHdZTlhCQm5HcDEx?=
 =?utf-8?B?a3FaanNQSTNleXRXR3B0Y2p5YVR3UXZMRkRMWmJFMGtSdXVzTTN1Zm5CZXY2?=
 =?utf-8?B?RWVlTmI2eEZrakhlWjBRTHhDWjVNNDFNYWVLS1NjZ2dORDJGMjNjakdlRUdK?=
 =?utf-8?B?RURRVDRFOUswSWpZS09NWmQ5eXlOOVdIRE1sekJ6ait6U1I1c2tYZEZSUmdl?=
 =?utf-8?B?TTZ2SU5yWGV5dzY2bXJ1MnF6UXBSQXlwM0FDMTZuUTh3eXE2N0dwazE4NDJx?=
 =?utf-8?B?aWY2aTRUTno3RmFzL1B1Ym1naytRdUZWTWsvNEhpTTRqNHkzd0JkWkI3amJV?=
 =?utf-8?B?N1JRTjNUMWhJTGlXOS9sNkxxaUFrSHZEeWl5bXJ6VzVhNHJ1d0dtM0xURStC?=
 =?utf-8?B?RGNHTmJBcndzSkQwTEVOTjJ2dGxHa0lYUy9velA4eTBYZTRyVnVEQXBORVhI?=
 =?utf-8?B?UmZVTm5OREt0dFJjTk80WHJlRnBGdHRIbThjSlpaTzIrR3BmMUgyZVl3cEVB?=
 =?utf-8?B?MnYxdi8wS085SUpMNUhvb2VJaVZmUDdNOW8ySGlzNDkxZzZvZlZjcG1yT3I1?=
 =?utf-8?B?NFc1b3lCVXRIVmFQR3MrT0ptZFUzb1E1cFVZZHJkaGRjSnNwWWtSdUdLNmV1?=
 =?utf-8?B?d3o3WWhMV05GbnUvYWMxQ20zeE40SW82dk5QU2svUU5jVFRNR0hwTC9EakpK?=
 =?utf-8?B?NlFZUWU4emVEOFBCd1JNVmZWanpmY2JLcmplYzdvNisvWmROTXFnajFtTTZX?=
 =?utf-8?B?bmlTUFBjUWFpbmt0YWVHZ0lRcUtIWExRUnBqR1NOK2k2c3NySnlwUFpyVmhu?=
 =?utf-8?B?eFlPTHBhaFFxb2F6Nmx6VC9rQlJnMktCN3NQKzBLcnFjYk1NcFF5cGJjYmw5?=
 =?utf-8?Q?YJ/KqVefgVXoti9MPusBNWAe4Xm2DM6Gat+FzYCZl9n+G?=
x-ms-exchange-antispam-messagedata-1: NnG/50A1ndrEbw==
Content-Type: text/plain; charset="utf-8"
Content-ID: <A7EAE7D619B1F448BBB190A538415C78@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e866421-e8de-4ca5-285a-08da385947cc
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 May 2022 23:02:13.3840 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NxTuXSa6VKytv3mDhaZe4WLNMNjOm8PMJ1fmwPuSiq08Mb7V2s1LUg7BlY2YvCCJpXgvyqk1VyyeaL7MimRIag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6202
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220517_160217_567976_77AEBC3B 
X-CRM114-Status: GOOD (  15.00  )
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

T24gNS8xNy8yMiAxNTo1OCwgS2VpdGggQnVzY2ggd3JvdGU6DQo+IE9uIFR1ZSwgTWF5IDE3LCAy
MDIyIGF0IDEwOjQ5OjIxUE0gKzAwMDAsIENoYWl0YW55YSBLdWxrYXJuaSB3cm90ZToNCj4+IE9u
IDUvMTcvMjIgMTU6NDQsIEtlaXRoIEJ1c2NoIHdyb3RlOg0KPj4+IE9uIFR1ZSwgTWF5IDE3LCAy
MDIyIGF0IDEwOjQxOjU0UE0gKzAwMDAsIENoYWl0YW55YSBLdWxrYXJuaSB3cm90ZToNCj4+Pj4g
QWxzbywgdGhpcyBwYXRjaCBncm91cHMgcmVhZGluZyBjdHJsIG5vbi1tZHRzIGxpbWl0cyByaWdo
dCBiZWZvcmUgSS9PDQo+Pj4+IHF1ZXVlIGFsbG9jYXRpb24gZm9yIGVhY2ggdHJhbnNwb3J0LCBz
aW5jZSB0aGVzZSBsaW1pdHMgYXJlIG9ubHkNCj4+Pj4gdXNlZCBmb3IgSS9PIHF1ZXVlIGFsbG9j
YXRpb24uDQo+Pj4NCj4+PiBNYXliZSBqdXN0IGNoZWNrIHRoYXQgJ2N0cmwtPmNudHJsdHlwZSA9
PSBOVk1FX0NUUkxfSU8nIGluc3RlYWQ/DQo+Pg0KPj4gSSBkaWQgdGhhdCBpbml0aWFsbHksIGJ1
dCBpZiBJIHJlbWVtYmVyIGNvcnJlY3RseSB2ZXJzaW9ucyBwcmlvciB0bw0KPj4gMS40IGRvbid0
IG5lY2Vzc2FyaWx5IHJlcG9ydCBhIHZhbGlkIGN0cmwgdHlwZS4NCj4gDQo+IEkgZ3Vlc3Mgd2Ug
Y291bGQgYXNzdW1lIElPIGNvbnRyb2xsZXIgaWYgPCAxLjQgc2luY2UgdGhvc2UgYXJlIHRoZSBv
bmx5IHR5cGUNCj4gdGhhdCBjb3VsZCBoYXZlIGV4aXN0ZWQuDQo+IA0KPiBPdGhlcndpc2UsIEkg
cmVhbGx5IGRvbid0IGxpa2UgaGF2aW5nIHRoaXMgYWxsIGJlIHRyYW5zcG9ydCBzcGVjaWZpYy4g
SXQgc291bmRzDQo+IGxpa2UgdXBkYXRpbmcgdGhlIG5vbl9tZHRzIGxpbWl0cyBjb3VsZCBzYWZl
bHkgYmUgZG9uZSBpbiBzY2FuX3dvcmsgc2luY2UgaXQNCj4gcmVxdWlyZXMgYW4gSU8gdGFnc2V0
Lg0KDQpFdmVuIGJldHRlciB0byBkbyBpdCBpbiBudm1lX3NjYW5fd29yaywgbGV0IG1lIHJlYWQg
dGhlIGNvZGUgYWdhaW4gYW5kDQpzZW5kIG91dCBWMiBhcyBudm1lX3NjYW5fd29yayBpcyBhIGNv
bW1vbiBwb2ludCBmb3IgYWxsIHRoZSB0cmFuc3BvcnRzLg0KDQotY2sNCg0KDQo=

