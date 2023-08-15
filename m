Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36194C0015E
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Aug 2023 17:06:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Cc:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PErt45QV7mof5dppyxYz95IsalgSok48yYSJc/tRG4o=; b=vIbjLLzrioV5Nw5izbUqxoUSYK
	T44yKnVVtahoK/izj7q8vNaM3jL9LeV1jujFDIeQa1bPcF8i3QTmMgY95hlo8s9nUpuvvMpSObVDO
	eZO2gWz4EuBM6T4HM/PQKnKMca1SS6Nqeea9M1mpmIXfuvfXqHO+szTsgi9wWwq4kFcW8noOWw2/c
	kWEd4x3z38key0BvxCZpsuqinIupGlb4Nzfnc0QBwb3wgDb3Az4EHLPLBDeq0epsiOSMxFtfxeVZV
	s1tmS99EHPHievFwzOGoOxQf1ktXhbzIHl3AzdCXUKpAf6D9C/bmMNv6HOgBzemjG14oTGCG9zHJt
	PM1CEoRw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qVxUk-0022Sj-0c;
	Tue, 15 Aug 2023 17:06:14 +0000
Received: from mail-mw2nam12on2061b.outbound.protection.outlook.com ([2a01:111:f400:fe5a::61b] helo=NAM12-MW2-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qVxUi-0022SH-0U
	for linux-nvme@lists.infradead.org;
	Tue, 15 Aug 2023 17:06:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TJSxTRyy0YITOaSDsnJle3TRLlmq2yQIITVrnv4BeZmIyZ62Q0wlwyHGH0mAqqNzIj9j/YQ00XRHgRkNXzlWuCvYy5WHYwdAk+qxWph84igLlkQd2DGvu9f7m08vIAHam4w8K5xQaPE6FPGARtE8zzGRjJdJ+QvQkw7qxlf69+dCwmAgtHKPq/yWrYRnNPA/smptQ5/36IBEU2eai+ioNM2C0F+LlSdbb7T2TSoYXhZF/LLUVdbQa1F+CHAzaT1hwyJI2jtGFIVcbNALF6LmpzhZZspBRfdp2o+6vZwnOJbs9XlxOfe7NSvgJ8YGcJpG2uARWfQJwDl9iuyB6tdQEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PErt45QV7mof5dppyxYz95IsalgSok48yYSJc/tRG4o=;
 b=ewKFpGoLCy5wkm1lrUrjseBalvU7Sl9HDNIi/WaCXHR5YyxC0xOCehOZ4ReqQX8k/UD/8HiDyDZKLNjZuJ6+8NOEZ2M1oLRH/d1nptGmWHJfubist88ZRu0mYjNBiOI7HqmNnwJVhrj36IEZe8CfQpyLOjjigsLJoK4pbTQsBSjU5hqShOCPkZCu02EKEivTcAsYvLW1wb2z45Y7JdALD5WFLe/z8cnvDjN5HhzdiCOwCHP6uF7qbJVq90aSpTTUfUhxobOoLHxuCO9Ju/bemAE3JxliO3JkJSSsBK1RrpAzDriQosrAhF5tvOj8SmcIn2OanAZJz5yAF159GL/SLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PErt45QV7mof5dppyxYz95IsalgSok48yYSJc/tRG4o=;
 b=mUg13ApOUM8rfPhfdRV2Wm5+zUTmv/MeGFElZke6DG3S9htnpSWLV920HP1p1fTa1FTyzgKX2sBCA3iF3yuOvNmyr5Uad6wFBpuxnGDYe3Z+4dwn9YwZHSSRT1u0aLCKlL7uF07xTdaGOuXJka8tOnXwkKnWP3cRBAbI8reH2z/8+rXZM5OJK70FzHUiluZyd15mYmFNFP0okAZYYA57labl2c6ZV4wpBQRuF9P8kCkSDkP/PEVfPXZIUqjIMihhSDZGltkZvqFlRIxC/qo4rs74WoyOH8XuIAOUog1xiRAXdb3C7qTLl5qFULxfElh18wAO1A0ULBec8eDLoyufHQ==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by CH0PR12MB5139.namprd12.prod.outlook.com (2603:10b6:610:be::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Tue, 15 Aug
 2023 17:06:04 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::f55b:c44f:74a7:7056]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::f55b:c44f:74a7:7056%4]) with mapi id 15.20.6678.025; Tue, 15 Aug 2023
 17:06:04 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Ruan Jinjie <ruanjinjie@huawei.com>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>, Keith Busch <kbusch@kernel.org>, Jens Axboe
	<axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg
	<sagi@grimberg.me>
Subject: Re: [PATCH -next] nvme: switch to use kmemdup_nul() helper
Thread-Topic: [PATCH -next] nvme: switch to use kmemdup_nul() helper
Thread-Index: AQHZz1cZzzfrGlVb2UGEsh7LdoMuRK/rlt4A
Date: Tue, 15 Aug 2023 17:06:04 +0000
Message-ID: <d20a2ab1-9064-5eb3-bfa5-0dbc1a27b8ba@nvidia.com>
References: <20230815085927.1155834-1-ruanjinjie@huawei.com>
In-Reply-To: <20230815085927.1155834-1-ruanjinjie@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|CH0PR12MB5139:EE_
x-ms-office365-filtering-correlation-id: b09db927-5c79-4aec-4267-08db9db1e8a8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AxunHZxJgzjsuxqWBmuxYs7s3Q8u2tU4uYt9IcpsByQfuI58aP/Mcx8ydaZ/gxwLVq09LgJT6bVmv+mr7f0cU4Qz3eCw0t2ycKgaT1QcQXIa7uFCL/J5y2YiM1rQZ5JjNgtqzSAHPsDGPukE/24cVeJPqTGQayX8UDOZiO0gsu7UuyBhT44nWGs4Q4qu9sneuJbA7LY3KwpwTCchnWy2xTYF9sdhvTUrBlEnNSt6Vch3RZkMu9yS0+UAQ/rZ5WI+IJTkAOXwoICj9oKMlJu+qyRumi0BExM7lx8ONdTvQ63x/F7kPgFSND8/O0GpVuUu4mnx8eja2gNCQGE6qxnRsjOGUy2aREcuIV5DeCKFQKX8fNRD2SSz9qqRwLGXlzkqXx/e4aLWnXqaMGWDSneYPHE8BNrjnDWaSwYVvZjRBjV70Tm9Jx+6b9ofPTgsrT6uezqvh6+0aX2cP5hyFhH2LwHBrX3qGncxSdf87OuyKq7OMvIM1REitKn9qwhvtYXGwvXEQrYlZRipf2MUb2FdbHNYObOq2+jd3eKVKun1Y3/aAdhJJZDiidydjoN0hFA21F7VgNU0thHG3/SDrAnxVo8bdwfGiDu9TasmhPqfcw0KDW6/XtZwbigJZg8Yx/xSfxCGON7pytqoaUkUnYChXAa5V+auxWtcNBF10ucZ6ohSHAGMN+skTk+5uEzflKDm
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(136003)(376002)(39860400002)(346002)(1800799009)(186009)(451199024)(36756003)(110136005)(76116006)(91956017)(66446008)(66476007)(66946007)(31696002)(41300700001)(64756008)(86362001)(558084003)(66556008)(8676002)(6512007)(6486002)(53546011)(8936002)(26005)(6506007)(5660300002)(2616005)(71200400001)(2906002)(31686004)(38070700005)(478600001)(316002)(38100700002)(122000001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WWdhclVDcXMvZ1g3blg2VnB1amJXbnkyU0xBNzk0Tzk3U3NDd2M2azFieG1L?=
 =?utf-8?B?c3ByRmdWRDI3ZjNCYXdPeThrWHVHTW8vam5KSHVONG5ORi9kTVhUTGpJQnd5?=
 =?utf-8?B?ZldWS0RxQTBNekJVMUlna08vMGhDWVhqb0RnNitkODMxTllQR3BvaUJEanZi?=
 =?utf-8?B?QnduQ2VrT3RMeXU1RHhPWThxeTdRNVZLK1lyVnBoaFFkRDNLdGppUFZnY0hW?=
 =?utf-8?B?VG5IRVlPMDc1c0JDWTJoUXMyN2Y4N2NUSEsxc01pa05QWS9KN3Q3NGxMS0hU?=
 =?utf-8?B?Zi9iazhUR2ZBa0dpNWoxb2JGenVsa2xGTUJZVmI3V05scGtVc3RPY3VWM0t1?=
 =?utf-8?B?SCt5Qjk2V1IvaWZkTzJaQnVXNzhWREE2MlIxeGtkUnZmaHZFMkE0QXFGYTE4?=
 =?utf-8?B?bEh5ZTEyb2czRjJVWmVWSmdNeFM1cHRmZDd3bGFBWk9oWEZoc2pyUVE3K09O?=
 =?utf-8?B?MHNvQ0Vqb2VsRnJxUDVtNnJoeWhsRHJlNmd3cGhFMmgvb1E0UUQ3WWFqaktS?=
 =?utf-8?B?aG8vMlR2S3lmTGU0dkVzMUJ4aE1hWk8xMzVwVEhjNjdEMkg4S2gyL2FtM2x4?=
 =?utf-8?B?QUpaWUprYnFEL0h1cThBMHJzeGNYMDQ1MStQZmVhVmU1YWNPM3h6akxURUtG?=
 =?utf-8?B?aVZScnhXSU1iaFZHcFg1RGVRSmNMT2F1cVV2clJOcmRlT0NVK05BaFlsZ0Yv?=
 =?utf-8?B?dzVQNFhvcjdxWU1sQVFsb3BVMDVmWTYwNlFjTHZOR2xJYmhWclJ3Y3BvZGlp?=
 =?utf-8?B?Nkw5K3hXQlJRd1JnRnFmTTVJQmZwRkhzOElFODlUeDlRTmN2UktQMjYxaExO?=
 =?utf-8?B?V3pTQjZ4RW82YUhpUmRITjBOa3Z5NWJFL0l4UVl5S3creFV6K3daazlkVXF5?=
 =?utf-8?B?WkhFN2hOWU82emtyblpRWkFWMjE0c2pYY0VleGd6b3R5SXhQQmxwRGZINmNx?=
 =?utf-8?B?dW5jZk5vVEZ6dFdHU0MyVWI2UkpqdEpvdnRlQlNHVjdqaEljT2hmblArUzh5?=
 =?utf-8?B?UEdJTnlxS1lZVHBXM0lURzBjbUo3b3RjVFlOc1oyVkc4RDQ4QU0vOWRmWUVy?=
 =?utf-8?B?TysxQ0RnakZpMmdXL1c4RzRoeEhBNkx5dTdEYjJrT0ZkTFhpclN5anZwRUFZ?=
 =?utf-8?B?ZW1GNHJNVyt4enU5S0p2ZnBvVDNkWWxuV25hQXJ3N0RlR2ZCZW5lQXRZRENm?=
 =?utf-8?B?bUVoV2VoSEZuRGFJQUJIZGg4VlVpbVN6Mmd5RWZvb1J5N3ZvL2dWaDNIYlZp?=
 =?utf-8?B?bXBnaHBRMmlqYWlIaE1TcFZhcjNhYnk3eU9nU1NlL3F5SFZRZEdVd0lWTDFR?=
 =?utf-8?B?WU41WWJ2cU9rZzFNR250OTV4R0daSzIwZHNsMDg3V0Rkc0ZCalVGMWFla21Y?=
 =?utf-8?B?anBhT3l6NllHTVh4c2xIWGVJOGgxODlraytjQTNWNTJyaEpJeXk4bkpBdVpp?=
 =?utf-8?B?YzFBWnNoNlN4WDlsTGNkZlExT21jZlp0QjBsREp0MFMwQ3c4aTNrOW5tdm9s?=
 =?utf-8?B?WXAvWFhGbS9mdXhLQldTczVwYlRjaEluc2tDRzZRK3l0dk9GZ2l5WGJDMFZO?=
 =?utf-8?B?bllEdWVmZUpoV1R2azl0N2VpWlZWNXkxdjBSbm9UUGR5ZnJnazhZdVo2VG5m?=
 =?utf-8?B?cE1ZS1E2V0h1TGNKMWlIUEJob2ZldjRWQzFBaVhoSXA1TG9rTHVvSFd4Ymdl?=
 =?utf-8?B?K1o2a29VOW1oejJmeStMaE9OSlFTVFdYN3Nna2JoYzhzVnNROVE4M0hjV2c2?=
 =?utf-8?B?S2Q2LzRsdC9jNFdsOVNGSVBsRVRVeVVjaGgraTN5SUQzMEJvZEpyVWIxNW9L?=
 =?utf-8?B?ZHpEemljYnZSaXl3NncwSEVFb0dxNktvbG1rRWd0R2QzUXBBOFh0TTQzZmU5?=
 =?utf-8?B?UHFJM2tKWkNOLzlWSitVQWdsam9XRnNuaDhFOFo1a1g2ZnlheFRvR2JuMFI0?=
 =?utf-8?B?alFmakIwS0d2a0k1VmRSMjRMcE5zNE5PZFkyTGZ5QjVoYS9lcWVBMjhpM291?=
 =?utf-8?B?eWEvckFtckVXbGZ5VDhEUW4vVzZEWXJJWTN4YW95R2s5TktQOHFCUWRlalFi?=
 =?utf-8?B?TVBQOCs3NWhOZmJzdVdXdTliZS9FMEphWUFCQ2ZaZm5ibzE5VDBjL29OT1Yv?=
 =?utf-8?Q?eX3OTvQPwVuhq7u92cS3ArMF3?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <22C4F39779F1444DA21B65B7F3AA1024@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b09db927-5c79-4aec-4267-08db9db1e8a8
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Aug 2023 17:06:04.0686
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NiKsalYRBEeeBNVy1cWF90XAEsVJ3EUD3UBYP5IPWrwRBg9/72fg5qnMcQYqDangZE/g4024taqiUbGQXcoO+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5139
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230815_100612_213708_399EAECA 
X-CRM114-Status: UNSURE (   9.59  )
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

T24gOC8xNS8yMDIzIDE6NTkgQU0sIFJ1YW4gSmluamllIHdyb3RlOg0KPiBVc2Uga21lbWR1cF9u
dWwoKSBoZWxwZXIgaW5zdGVhZCBvZiBvcGVuLWNvZGluZyB0bw0KPiBzaW1wbGlmeSB0aGUgY29k
ZS4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFJ1YW4gSmluamllIDxydWFuamluamllQGh1YXdlaS5j
b20+DQo+IC0tLQ0KDQpJbnRlcmVzdGluZywgbG9va3MgZ29vZCB0byBtZS4NCg0KUmV2aWV3ZWQt
Ynk6IENoYWl0YW55YSBLdWxrYXJuaSA8a2NoQG52aWRpYS5jb20+DQoNCi1jaw0KDQoNCg==

