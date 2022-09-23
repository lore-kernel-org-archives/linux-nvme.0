Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12FB7C07E9D
	for <linux-nvme@archiver.kernel.org>; Fri, 23 Sep 2022 17:34:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OOaLh7+gzezgE56MIk9Fe12rgRJKcpFUlRtSCOYbxBw=; b=mprZIKs9pJOdwhdLbefOvtEwVq
	7b1Uoa+xhT/AfTQWb7Gmx80nMm96Lxe8T0s/3fwAOD8moyfuEJUp8JO6ZUdys1qiSFX1eaoIToBRU
	kGEX37iX1NAnXGxtjJ6EH5m5Lnigv4xY7pJ72s8ZL2hJcYTT43XnbNjwSCUxTCpFzmnbKpEptQh8d
	RTjQUj+N0RxDPLugbnimjRgD2KB0k0Jrv7JoqC1ipsOVEFM4BjHHrMlR4HnZwU9XLI/ZKB6Unnk00
	Di+/PQVp3n3VqxFcnWJygCZNsZsseXMej9wUkrpVZXPdOzCq0Abotq0Y4FEhe5hXzN7wrSRiDo1LZ
	4DQ9m44w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1obmZX-0059Nm-P9; Fri, 23 Sep 2022 17:34:43 +0000
Received: from mail-dm6nam10on2061.outbound.protection.outlook.com ([40.107.93.61] helo=NAM10-DM6-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1obmZV-0059MQ-MY
	for linux-nvme@lists.infradead.org; Fri, 23 Sep 2022 17:34:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F6Zm12qu6EsL/F8u01Bzz1iFS9MUqOa1U9Kc8roS4ON7TquHBz9S26JhjVlzC5AjF5BxwVvF7hTUCeBo1NAn8aiGfbAyCnLc0j4yr0NFeVCShF8dtvqlZsTrwsY1KtygJ095F7aCv3eObDeo/sxGIujiQ+mlUF7lG/FsXIC0EbsicKgGALP261U5RMznJB5g4v2vN6Xcq2UCSFswX7jWDbwUbDG97Dmnmq37IyInNwaTX/z6blfF5wTaSYrv997eo/OHPzXwbSfV8tN1v5o0AFOSIynKi+QmuDUo8FXskbdhIjCCXu+BEg1MHaWPpaVuNtgMT1gsVpXkLXzjPNW/bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OOaLh7+gzezgE56MIk9Fe12rgRJKcpFUlRtSCOYbxBw=;
 b=G953SLTrwK6RmrUwZb0ILd6v469BTkKlTgabCx6jZnAkyXtuuBxnXcSiQVBinFJsawBxWCMsKiVD5sXeKmzvtJPpNB7o9Z7nbIgLMw1AWYEfh4Rb7QI1rNF3NFf6nv2b4t3oSH15C0uJZRA55XVgmIPOVjTY4pynYt4nMv7CDDHVzNKv++B+N25bXlkWFA1VrYTjr3czti+iq5ki9dETjCz96a7OTOZK0Eho+yETPjEb9Y/NLfse6k2HrzRXyGURNQtT4Kg458QsW2KnRsU0OZF/B2+gYu/D+2iCibErUc9wZQ/CSVtIz62JDemh8YBCiVfXtGwTALYKzUfkP7XuVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OOaLh7+gzezgE56MIk9Fe12rgRJKcpFUlRtSCOYbxBw=;
 b=mlDWrnuDos/fIplJRPy3sehXJGIxR/sYB+1XJEU6xcPjEjY8+Q2fq9XjNetEXoYas7yveIiAFUr+Xk50r1KM4zuM8yp5hu40BwkHoNPoXcSkUCH7yJu5YYaFC/N5XIxIVWmC5AjzbAyNzX1GcgPKliGDG6sMUPHglPa5Gjgocik1hbfMI94XyT+alq7Z5v1s/+xuDB2gZgFPpoXClakfGlDTAQvzC+8uESeEqSs475RBoFawMYjNirJWS0rIJMTjJzJj5GQT8ezAMQ0QQeFCG6Bf2dGRLJdlCHYggRnIH4Z/Al2Kx98ENMTpIYsmQPADrySphoQd4uwTrm5iioX3gQ==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by DS0PR12MB7679.namprd12.prod.outlook.com (2603:10b6:8:134::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.16; Fri, 23 Sep
 2022 17:34:35 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::3d10:f869:d83:c266]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::3d10:f869:d83:c266%4]) with mapi id 15.20.5632.021; Fri, 23 Sep 2022
 17:34:35 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Yi Zhang <yi.zhang@redhat.com>
CC: Sagi Grimberg <sagi@grimberg.me>, "open list:NVM EXPRESS DRIVER"
	<linux-nvme@lists.infradead.org>
Subject: Re: [bug report] workqueue: WQ_MEM_RECLAIM
 nvmet-wq:nvmet_rdma_release_queue_work [nvmet_rdma] is flushing
 !WQ_MEM_RECLAIM events:nvmet_keep_alive_timer [nvmet]
Thread-Topic: [bug report] workqueue: WQ_MEM_RECLAIM
 nvmet-wq:nvmet_rdma_release_queue_work [nvmet_rdma] is flushing
 !WQ_MEM_RECLAIM events:nvmet_keep_alive_timer [nvmet]
Thread-Index: AQHYzx8LgJexvHHnyUynfTjUO11Df63tR0CA
Date: Fri, 23 Sep 2022 17:34:35 +0000
Message-ID: <a14ad6a8-0947-2a85-f7d0-168bcdf37cfd@nvidia.com>
References:  <CAHj4cs_5=0DGhe5W5oQ1OA+eBy64MX9gRpA8-3N8Qk3Wh-Dwzg@mail.gmail.com>
In-Reply-To:  <CAHj4cs_5=0DGhe5W5oQ1OA+eBy64MX9gRpA8-3N8Qk3Wh-Dwzg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|DS0PR12MB7679:EE_
x-ms-office365-filtering-correlation-id: 2ac5cb5f-2c74-4b39-231b-08da9d89e21a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  xYFgMcGzS4yaJYgMVTEHnQ61a6m69Mpf+Nf1HpKlbMDfljCuevDlZmmXmhP7GjD0zppJbrzn6B5UzjCFnps1mPX7Q7zBLEiI+q2v9Ei0SBFPluZBrD1P2OAfGLsxxr1ouW0IxFK70sGsE/4wj+cViw0wH5H5M2+hNxFEm3Zd7L7U1xjsYDWYH2gd7AfRELo3pBGf0NC4aOm27TVLwCZpkP4Yph9UhdCusedJzx6Tcj/HrBvzc2SmD4RNtjPHRPZilZSKWwLzOEz8cNFWfndqMLuZsog3EmHUJImtJ9gSY8Tny86pZFj9BkP6M1A3T/9bNnTKE/6COaaIh2hvWyogQnFjscdcgfIqJtDfOTTgoISEL45xp+1T+TlyBWWVl6lRc7jZ7o6A0km5PRoygphTWvIowRUhAixI9tcXIRNeylmE4ZBgQNqM6O/VcTlQaaGXDXzh0y5ZYToa2OPAQdvFfOlmzbO+Q1OumjJDlhrfvK4lsQJycvAIFouR2NDRkn41sr9/s5AeDL2RjcE57I3+pg79hcaUuWH2MYIkmTk8vkldClS9ZxIVJ3ZCi22YqEwVLV8YkyHgR1DXyfZzpEYvLOISl2fNtlZYD0M+wF9E4363R6UgEay71SGnizqoTPILRLkXL2fW7m/L2fxi0X/PJ2E674FJc+QAH4nkGL6eXV07a0fgNa1btYorH0F5ADXrwiJOHEuoBAYEMKuaBHk1psOxpvzLH9o+6g15L4Nj7zDvABOZRfF/1FW1iGGJzoXU/8Oa8sLSo5BxdHE34T+9Qf6ohDvWL7PSnpXlCzO7JzMCoLMkqYpbsu5OpCS/df+W/Peqz8jne61A/IT8QB3wIg==
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(396003)(39860400002)(366004)(136003)(451199015)(31696002)(6512007)(316002)(26005)(54906003)(2616005)(478600001)(71200400001)(41300700001)(6506007)(36756003)(86362001)(38100700002)(122000001)(6916009)(38070700005)(6486002)(83380400001)(186003)(5660300002)(2906002)(31686004)(66476007)(8676002)(91956017)(76116006)(8936002)(4326008)(66946007)(64756008)(66556008)(66446008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?utf-8?B?SjBEUmlUMkVGdFZ1OW5DbUtKUE83bU41M09sTVZ0QkhHVUg4VTFhVUwrWVFl?=
 =?utf-8?B?M00rbFp5aDlWS1NYaVEwWmNWdDZXb3ozc2VUc0E0Q1laYkJBQjVkYkR5dmFk?=
 =?utf-8?B?OWQ4eWhWSHRYY21UOEcyeDF3bVVhMDNWWWRBU3V0WGYyb3pMVnh2WjdIbDkr?=
 =?utf-8?B?UHkxTmNsRUdyV0xBa294TTJKQXFseVdOMEVrM0E1QWkxdUd2Tlo1M29Ea2Nj?=
 =?utf-8?B?WGdnUk82NTFhZGlqWUQrUWdKVTlHc1RqdmxudVo3Y2cxYThsQjQ2ZmR5dUMr?=
 =?utf-8?B?LzhVblQrdExpc2pRZEtqVFp4T2hOUWw1ZnJZNFJuOEI0emxwNDVIeDZIbFRy?=
 =?utf-8?B?bGprKytnS2d2anI0aW4rZkJlOVA2SnlZVk41b3prUitJNXMzdXhaRDJWVXFC?=
 =?utf-8?B?UE9SZFFRVHJpMzJYcmJiOGdnV2FwSlc4QVBjaVl0elJuMEJoS0pHTnFkbTE0?=
 =?utf-8?B?SnQxWFNOYWxQVUcyaFZVL3RQVFhxdWFVUEhBQ2lhaUVTUUg2dHpQSWZ6TTdw?=
 =?utf-8?B?bjh4UmhCMDZ0blVjQ1NpaENkMXlRN2N6NDNsRFNYb0VDcWozeDZzTVpOU0dD?=
 =?utf-8?B?ZUtaWENqYVNSUzJPWmo2RzBweHdNemJEeDVzUmZmUWFHVm9jVDNPVStTaCth?=
 =?utf-8?B?a3N5ZEEvcDNqUDNvN1pLRnpSa21TVml0NmtkU3BQOWVFMC9hSUgyZkxMc2Rn?=
 =?utf-8?B?ak0xdFdLVnNlMUFBbWhiRllQVlljVE0zek5IYjdnSjloWkp3V2Z0bmdpeTV2?=
 =?utf-8?B?bnFTak1tNmdhUDZPc0wydms2VG9aN0tIKzM4c3dka2srb1dxbXMzR05nR0NY?=
 =?utf-8?B?TmdOd0VoNzcvQXdhWEd4ZldQSHJRTlRoZi8xai9rZDVtS1g4VzByNW11WkZ0?=
 =?utf-8?B?WFNVMHBFRHRMdTdrOTV2aHpWbURPQ014Ukt5eFoxQk1EeUg5QUtjSlpteU5P?=
 =?utf-8?B?bDBvZFBjR0xOSGNFVWRMamhlaFN1NDdONUkraVJkTmd6ZTByT1JCWXM4SHRW?=
 =?utf-8?B?WDRLSStaSHA2VnFVMEFIQStrb2NiM1hYcDBNOEJTVEY3S3lreUlvS2w5LzRX?=
 =?utf-8?B?bDhDYlAvcXdyNkphL3VmSU9NZE52cEtiQmJhMkFlSCtnbFp4NnRZYzZRblV1?=
 =?utf-8?B?eTR3UmJsZi9FM2VQZzRIYzJ2L0ZVQmdsZ1A2VllrSkpPU1h5M0RLaTFZVnJL?=
 =?utf-8?B?dmZZRTJUWERFZDEvdzA4OWJOUjRrMVRsSFI4ekQzY2RVUTB5N0xSWHYybkNm?=
 =?utf-8?B?YVNDdmVmOXZRMmVRSDE2cis2MnlwMi9XYktHNlNDdFJOOTRiR1BTNzAxQkJp?=
 =?utf-8?B?cnVmdHFUSjlRYkRwOC9nMFpSTjY2RGZveHBKcVpMVm91eW4vaHpDYjB1VW90?=
 =?utf-8?B?UXRKTFZnWUdBVjVrY21uTzJPVWdWMmNjTDVGT3FXTkFEdjlkWk1OVWxWbFFF?=
 =?utf-8?B?T2pCQllycXRRMDQ1dTBtMk5HcGNNVUFtRjJlcmZLaVhvMWZjeDV6MjNyZTdp?=
 =?utf-8?B?M0x4R0FlcGs3OUp4a1B2empJYXV5Q3dWamRhVDllcHU4UVBXSGFJTXgwZlF3?=
 =?utf-8?B?MTFwTFBBSlRSbUpWcEdhSDdiZ0VQVDg2ME1yTzJuZlRLdFpVenZvNHFlUXdE?=
 =?utf-8?B?eFp4RXI5aXp6VGNLTThvOVRzK1pNWVBNRTJYNWxOMkhmNkFEYTdDME16WndN?=
 =?utf-8?B?V0ZVZzc1ekRLK0xmT2d6cHgySFB3V2EzRTl0U2NnMllOVmtEOFpQOUI5dVFJ?=
 =?utf-8?B?YU41bjBBSHpDMHRjZWtSNmtUYlU0bzM5YXVHalMxVHUxTXh6ZlY0VlBVeWZk?=
 =?utf-8?B?UlhmdXNkcmRCc0p2YW9USHNhT1hFTmJ6eFI0VVZLSEZCT2t3NFFjVkdNaTM0?=
 =?utf-8?B?MUlHdmd6VWFCVnBSSUR6UkljWXdSVTc3U1pWTHpBZHpMM2RlWms0eWV3TklU?=
 =?utf-8?B?Vkh3aUZXcmZrNEMyMjEwRmJKSW96aUdnaFlvYW9nNVlOK3d3NEp5amxEK1Np?=
 =?utf-8?B?WndBUDRXQzNkNGxhMzJ1b09sTmxVZjJVK3ZVSjJvOEYyRzJHbzNKZE42aW9B?=
 =?utf-8?B?OU9CRjUwVy9LaHdkV0ZpeEp2cnh4ZkJ0cG5yaEFtSnRMc0pFVTVHVXlXb2JP?=
 =?utf-8?Q?dBYexHa1tSFkPduh2lfS+zkgn?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CCF8097A3492114CB424F3AF0FF91C48@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ac5cb5f-2c74-4b39-231b-08da9d89e21a
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Sep 2022 17:34:35.5165
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gczJm5BAL7sbsnT/sU/WY43K9v7gbtnb8ot3iHHhG4bNddgGq8lRFv1wdKpTmXTAeuHU8TkuloQ9J1SgpDejoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7679
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220923_103441_763925_80E140FB 
X-CRM114-Status: GOOD (  12.77  )
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

VGhhbmtzIGZvciByZXBvcnRpbmcgdGhpcyBZaS4NCg0KPiBbICAzNTAuOTQ2MDUxXSBudm1lIG52
bWUwOiBtYXBwZWQgOC8wLzAgZGVmYXVsdC9yZWFkL3BvbGwgcXVldWVzLg0KPiBbICAzNTAuOTQ2
MDczXSBudm1ldF9yZG1hOm52bWV0X3JkbWFfY21faGFuZGxlcjogbnZtZXRfcmRtYToNCj4gZXN0
YWJsaXNoZWQgKDkpOiBzdGF0dXMgMCBpZCAwMDAwMDAwMDk2OWI5MTY3DQo+IFsgIDM1MC45NDYy
ODVdIG52bWV0Om52bWV0X2V4ZWN1dGVfaW9fY29ubmVjdDogbnZtZXQ6IGFkZGluZyBxdWV1ZSAx
IHRvIGN0cmwgMS4NCj4gWyAgMzUwLjk0NjMzN10gbnZtZXQ6bnZtZXRfZXhlY3V0ZV9pb19jb25u
ZWN0OiBudm1ldDogYWRkaW5nIHF1ZXVlIDIgdG8gY3RybCAxLg0KPiBbICAzNTAuOTQ2Mzc4XSBu
dm1ldDpudm1ldF9leGVjdXRlX2lvX2Nvbm5lY3Q6IG52bWV0OiBhZGRpbmcgcXVldWUgMyB0byBj
dHJsIDEuDQo+IFsgIDM1MC45NDY0MjddIG52bWV0Om52bWV0X2V4ZWN1dGVfaW9fY29ubmVjdDog
bnZtZXQ6IGFkZGluZyBxdWV1ZSA0IHRvIGN0cmwgMS4NCj4gWyAgMzUwLjk0NjQ3OV0gbnZtZXQ6
bnZtZXRfZXhlY3V0ZV9pb19jb25uZWN0OiBudm1ldDogYWRkaW5nIHF1ZXVlIDUgdG8gY3RybCAx
Lg0KPiBbICAzNTAuOTQ2NTQwXSBudm1ldDpudm1ldF9leGVjdXRlX2lvX2Nvbm5lY3Q6IG52bWV0
OiBhZGRpbmcgcXVldWUgNiB0byBjdHJsIDEuDQo+IFsgIDM1MC45NDY1OTVdIG52bWV0Om52bWV0
X2V4ZWN1dGVfaW9fY29ubmVjdDogbnZtZXQ6IGFkZGluZyBxdWV1ZSA3IHRvIGN0cmwgMS4NCj4g
WyAgMzUwLjk0NjY1MF0gbnZtZXQ6bnZtZXRfZXhlY3V0ZV9pb19jb25uZWN0OiBudm1ldDogYWRk
aW5nIHF1ZXVlIDggdG8gY3RybCAxLg0KPiBbICAzNTAuOTQ2NzA4XSBudm1lIG52bWUwOiBuZXcg
Y3RybDogTlFOICJudm1lLXRlc3QiLCBhZGRyIDEwLjAuMi4yMjI6Nzc3Nw0KPiBbICAzNTAuOTQ2
NzM5XSBudm1ldDpudm1ldF9yZXFfY25zX2Vycm9yX2NvbXBsZXRlOiBudm1ldDogdW5oYW5kbGVk
DQo+IGlkZW50aWZ5IGNucyA2IG9uIHFpZCAwDQoNCmFkbWluLWlkZW50aWZ5IHdpdGggY25zIGZh
aWxlZCBJIHdvbmRlciB3aHkgPw0KDQpoZW5jZSBpdCB0cmlnZ2VyZWQgZm9sbG93aW5nIHNlcXVl
bmNlIG9mIHRoZSBlcnJvcnMNCg0KPiBbICAzNTAuOTYwNDM4XSBkZXZpY2UtbWFwcGVyOiB0YWJs
ZTogMjUzOjA6IG11bHRpcGF0aDogZXJyb3IgZ2V0dGluZw0KPiBkZXZpY2UgKC1FQlVTWSkNCj4g
WyAgMzUwLjk2MDQ1Ml0gZGV2aWNlLW1hcHBlcjogaW9jdGw6IGVycm9yIGFkZGluZyB0YXJnZXQg
dG8gdGFibGUNCj4gWyAgMzUxLjA3NDM5Ml0gZGV2aWNlLW1hcHBlcjogdGFibGU6IDI1MzoxOiBt
dWx0aXBhdGg6IGVycm9yIGdldHRpbmcNCj4gZGV2aWNlICgtRUJVU1kpDQo+IFsgIDM1MS4wNzQ0
MDVdIGRldmljZS1tYXBwZXI6IGlvY3RsOiBlcnJvciBhZGRpbmcgdGFyZ2V0IHRvIHRhYmxlDQo+
IFsgIDM1NS42MzgwMzBdIG52bWUgbnZtZTA6IFJlbW92aW5nIGN0cmw6IE5RTiAibnZtZS10ZXN0
Ig0KPiBbICAzNTUuODI1Mjk3XSBudm1ldF9yZG1hOm52bWV0X3JkbWFfY21faGFuZGxlcjogbnZt
ZXRfcmRtYToNCj4gZGlzY29ubmVjdGVkICgxMCk6IHN0YXR1cyAwIGlkIDAwMDAwMDAwMGMyMjA1
NTUNCj4gWyAgMzU1LjgyNTMwNl0gbnZtZXRfcmRtYTpfX252bWV0X3JkbWFfcXVldWVfZGlzY29u
bmVjdDogbnZtZXRfcmRtYToNCj4gY21faWQ9IDAwMDAwMDAwMGMyMjA1NTUgcXVldWUtPnN0YXRl
PSAxDQo+IFsgIDM1NS44MjUzMTZdIG52bWV0X3JkbWE6bnZtZXRfcmRtYV9mcmVlX3F1ZXVlOiBu
dm1ldF9yZG1hOiBmcmVlaW5nIHF1ZXVlIDENCj4gWyAgMzU1LjgyNTM2MF0gbnZtZXRfcmRtYTpu
dm1ldF9yZG1hX2NtX2hhbmRsZXI6IG52bWV0X3JkbWE6DQo+IGRpc2Nvbm5lY3RlZCAoMTApOiBz
dGF0dXMgMCBpZCAwMDAwMDAwMGUxNjk5NjZlDQoNCg0KSXMgaXMgcG9zc2libGUgdG8gYmlzZWN0
IHRoaXMgWWkgPw0KDQotY2sNCg0K

