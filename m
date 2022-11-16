Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10C9BC4332F
	for <linux-nvme@archiver.kernel.org>; Wed, 16 Nov 2022 18:38:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zR0fYwP9i5elUQw+rRHgfML1xxuJW27rA0sILpuX/a4=; b=RwZJyDA+lsmDwV/obtWiE6XXuO
	VMdL7ABZBaWzwXM/OZekO2Pe5r6y79QElvF215zU5+MXjARoGPdEv1cqcnrjNfkwOgU5rCEpd2+ec
	odX3jNFLCutJkVKqvIlLSWN7mL63CfHSU+EYzYdUJeNfDFwlFCb0Fft8/nn/yye6nfsNZJCn7JkNn
	mvCLwJzpeH1zLLCNSjUWwiNajp1sRVGNGaW0jvbMXK+ynA6d4RumKscEMZXso70iMhyVKW09KT2/k
	YI/wbknGkzbeXqGLkQGBVA0GzlkLU5Xuj8gPwQsdQTB/EpKtQA8yljk8XhdMrZ5r5tU51yWMF35JI
	09EHzLFw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ovNJD-0077iY-LY; Wed, 16 Nov 2022 18:38:51 +0000
Received: from mail-bn8nam12on2062e.outbound.protection.outlook.com ([2a01:111:f400:fe5b::62e] helo=NAM12-BN8-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ovNJA-0077gb-Rq
	for linux-nvme@lists.infradead.org; Wed, 16 Nov 2022 18:38:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ToTRux6VjkWUE7CBCnZLvfexbfBSUa89XH32Qv+xLyMT1BVAf4YP0lHPN0szTO5B3kzTvxKA9n8yVrcCTUu32D9rLLVOC7/BsTYskp4uUUlAtEecQRG53df2LpPDTedTcAldLhuoU7lb6zYOWdwAFtOLYu1wkEuCCVOcmFdGC1bNJr9khxmISOIE7pJGrighGzXbaPFfhkCpXZQyxf77WNlJi4cN0LucgzzFfItNRgO+Y5UTfvaMN5Ot2vaES1mSVjUmXT1WumUkx5wzh0xoYc/pvZoZxEraXRsUhewibGGTxV2U0AzwSG/57enCD0vz4yxai6ozBVfgPeHVoqU/RQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zR0fYwP9i5elUQw+rRHgfML1xxuJW27rA0sILpuX/a4=;
 b=QlZFDgueXCfvvfjg7pUSckOHdIXwE9JffGJZH458RK6mpKIwcTmWDPJkkMpBB1U6ySA6EvERLiB9r0lQlt52VKUy28m1SjqNIdIp0sWXkS92yOIsJ2hgr9stsV1juS5kMMlVCQlbxLYH+X3PZvZ6zbWLKFCfaodyTWwA1hET+0gHoaOR6aR2x6OaoRrnPidxUYhN91V+u8K+2J7Q/hn7nZB1uMVctmcSvudu5dmlICuEHVTG587IRWznvXnxFEVSjSnj0Z0D1c8hq0rTloL0du9ZjvD2dlMbxjo0KUbcHtzKGqZZGnYgeZhGK9bTNDHEngTZJ5txNLw/TNDkMKuNLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zR0fYwP9i5elUQw+rRHgfML1xxuJW27rA0sILpuX/a4=;
 b=juBqNDbZOV7yn6NyQXqvhV/VKTohFEzqa8ZYYJITi+JvCCbCUyuNfCJmw1788avXTlw4VvwbJMhdNQIzU7jiI8UrcEEaekZTPR6MDnGGMa2QzzN4dTi5SCN2gY1U/NuR3vVECW0fekuAI/zMNuU7BIABe8Zcyy7ZnZ47x1Mr47JgZkus2cLTzuUARUkOyAMqbBJMEf/yjI35Mo6ppKVujGl2PVXDo2fKBxWwdPNJIizA1pKRcwKH0AGWUVh+HieH+fNVEFmV658SpF/nPGCNHva1swK/SUG9F3Y+0pty7r28jL8Bc1lnrX6gMzyXEfTcyqh2HbdLPGdffn1hxlmHRA==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by DM4PR12MB7767.namprd12.prod.outlook.com (2603:10b6:8:100::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.18; Wed, 16 Nov
 2022 18:38:43 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::eaf1:9be8:d472:ea57]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::eaf1:9be8:d472:ea57%7]) with mapi id 15.20.5813.017; Wed, 16 Nov 2022
 18:38:43 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Chao Leng <lengchao@huawei.com>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH] nvme: don't call blk_mq_{,un}quiesce_tagset when
 ctrl->tagset is NULL
Thread-Topic: [PATCH] nvme: don't call blk_mq_{,un}quiesce_tagset when
 ctrl->tagset is NULL
Thread-Index: AQHY+Yz83wVCLSn+wkKnxZbLxZjG4a5BLaGAgAC0k4A=
Date: Wed, 16 Nov 2022 18:38:43 +0000
Message-ID: <7c424282-b6b0-56a2-b608-8b4ba6251c14@nvidia.com>
References: <20221116072711.1903536-1-hch@lst.de>
 <e3aabd5a-d20b-f317-1791-1af16066cf87@huawei.com>
In-Reply-To: <e3aabd5a-d20b-f317-1791-1af16066cf87@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|DM4PR12MB7767:EE_
x-ms-office365-filtering-correlation-id: 6d14b419-443c-4199-30d9-08dac801ca0b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  0WsR1rBJ0FYo/g3zrUZJIHYxsgCoKZGn6RiC7OcUSqa0AUikNh2CwU3c7QVqG7NlSLPj9Ine2UnSyc6EqwHLQZZmh4xSUbPN9yOxFsHlnr/536Nm2OkDqNpeqkldvWV6G+hooN3x7mARRzNJQurcp0R5/iDlEg4JMyvoW4TRQ8EyBOHt3vaOsQytofM59frQ0kzYa4JxxDZyuBzk90liDtt4zNK9o9TNwaSJzca579SO7VbuLCEFTuHg9JKON9dLEgcdI367WO75WTmxN6zY+XJmY9wDrG+3I5RQACG+kutVtuK0jaHB1W5AIQd1OSSP10sjJq4qYJch4fYe3YJBOV+yh56OwWG0fgesO4zhGNaa7UNupBgTgEaU0DE4LpDOO0vUIF2OUyzFii7CUEBgUzE1o/xfoi2z4zEd1AIvT3fXq/kwl32zlvz9TC4aZQX0TeelTScEvkg3vH7CEB2cGOZIogfP0RNNCwrIu7BxvU6dmm5US0hS3O+goxNxQvkuldYzmS0RAHoesbQpldQoV497T99B1tPxdxsdNDm2a1DQD/rrA1gE3bapvTimXbQTb6AdE6/Tu3tUIi1FUs8k2mBpK0KJgJWvPHJ4UYqoF2YnzFTRU1SftA71AIlbePZMIzEomUQfvMCWbc2wSpJZP0qju6M0kiza75Cae0UiphnsDLa2bHYMkP3pCzdoKfXxZZC9fRXLZnGzIDA/3DQO9E+w6gwwQ4vzEEcdSRTbN/5KmKI2+E8elw01J+zDAc0C6bg1uGseQcEh2M9phBc+w1D5cpgCiHKTkxOcYGSxXrBlcpyaxSiBRD2nsVUJFLo11mokAKsVakJnXduBavut5A==
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(346002)(376002)(39860400002)(136003)(366004)(451199015)(478600001)(38070700005)(36756003)(86362001)(6486002)(2616005)(186003)(122000001)(6512007)(6506007)(53546011)(558084003)(71200400001)(31696002)(38100700002)(66946007)(316002)(66556008)(76116006)(66476007)(6916009)(5660300002)(2906002)(66446008)(64756008)(8676002)(91956017)(4326008)(8936002)(41300700001)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?utf-8?B?WC90TFpSMkpCU1RpUFMrU2djRlEvSWdXdGNESHpqWjJjSDN5eUpZNEZYSUQx?=
 =?utf-8?B?R2pKL3FQY2xJcXhUcy9KR3dFNEhpZ3BxUkRiWWx2SDVrckdOdXR4MzJYeDVP?=
 =?utf-8?B?NXFjcGZtem5DZWhwd3BBRXM3Nm1IbDg3TkNqdEVlSE1Jb0haNWxkNWE3V2Zy?=
 =?utf-8?B?WFVGbVNFNjRCVDhpVUZnT0Y3aUdJdEtwZXVrNEpOSldPWXhZdFZGdGl1aU5Y?=
 =?utf-8?B?TUxKMC9Ydm9FdkpjUHNobnRXbm01WmhCRnNqMExoVzkvakJ3K1I4T0FyZlpY?=
 =?utf-8?B?R09JQW51cTA2aTF0ZjFQQWxxUXhGSHJhNE9uSmQvL2x0blIxcFV0bVlpRy9W?=
 =?utf-8?B?U1BRdkxPK0hzTXAvZ2RDYkFoa0dQVHNybGJqZHdhWjF6dlpoNXdFNThJL2M3?=
 =?utf-8?B?S0JONzVLbGZQUkRaTHk1bEd2dVJ5em02MnVaNHBFTWdkU0lSTFdvTFR0S3RP?=
 =?utf-8?B?YlQxWFdyalZTNERQNHpmN1V5TjBNeTdGWTZ0ODBkOTRJdDBrR09WSzRYTlR6?=
 =?utf-8?B?ZEtuWXNuRUNiV0FvS1doRytWNTVudGFKb2gwT3pUaEtFaWQ3blJTSGVCV0Jj?=
 =?utf-8?B?dWNud09JaDRkZytXQ0hxWTJXSzdNSXlmL3RZTUsvM1NiMGJrVXRScDBSMk5P?=
 =?utf-8?B?UkFtNC9mQ3VTNXllUEk5bmxpNkE1QVFpY3A0OFBjaHhkR2g3TXZtZWE1dHZu?=
 =?utf-8?B?M1lFaWsyT3VzSk1DNWQwd2IrcC9MQTgzQ1JUMlBFdlJVUGh6d25jWHlEUkgv?=
 =?utf-8?B?VHA2RXVob0xuSEN1N3l0Vzlvd0FMdFdocis2RUxHejZwbGh3L3JaaHdGK2Nx?=
 =?utf-8?B?aUg2ck9tRzFRUFZBNnBOUDB4UFoyMDZHZng3K09QRXI1OHpmbmhHOHAvNjdC?=
 =?utf-8?B?WC9hWXJpVWVKWXN0SnVkNUtLUDRUc1piVHFmbXU0dklkWHY3cGQraHlydjRo?=
 =?utf-8?B?YlNHVk1kUHZTeWJYa0R1TTNrL2pWdXVMaDd4OXlNWGlEeDVUUzVFS2FOMXFF?=
 =?utf-8?B?STFFdlZVRWlXdFMwQnFwVzdBbUVzU016UDV4TjRxdWFIQk5sUnBCbGJJWVNH?=
 =?utf-8?B?Z1h6bk9tMGhPTEdGd01tNDlENi9iN1IvNU82TmQ0Y3lWQlV1MlZoV21UdFlx?=
 =?utf-8?B?aVdZbmhSTUt1M2JGQ1d0eGMrQnd6QVBMcHdnRkNFZ0ZZYmhaSnBpNE9SYnpm?=
 =?utf-8?B?REhsdys4S2FISElVTG1NdU5TZWZjUDRTeWJEQVBoMWM1eWZMSkUrTVQ0Vmtv?=
 =?utf-8?B?M1V6TnhhVUsvYk53bFZiUDYydURpcFlvTktYTDdqK09zblIxN0RYM1dUZVRk?=
 =?utf-8?B?SDRBOEpsbmdlbWJESittYkEyeURIekw0UWdwU0RocEkvUWE0N3hGNE8rMXdj?=
 =?utf-8?B?NXlsd2FubUNBWnJlSmhwSGp2Wk9Hb3dJcDV3UjU4TFB5cUs2ejNuYVZkcUw5?=
 =?utf-8?B?d3VSd2tDVkEwS0hQSmtRRkd2dkhTdGQ1eURBTDRmUkQvaWJySGhlb3krMWgz?=
 =?utf-8?B?UnNrQjBFam5TRUh3dHBMYmZ3aCtUTyt0SGlEQXhWQWlmQ2ZFa2toR1hUN1lo?=
 =?utf-8?B?OUpkeng2ZkV3SXhlajQxN1p4L0RTZnpqTGZvTDVuV2QwakJiSTY3d3pFYjVZ?=
 =?utf-8?B?b3lEdHpsTHNmVm10bERiSlRyenl1aDBWcFZzTllvQ2huYVlrd05nejJtOVRq?=
 =?utf-8?B?dWM0a2Zma3Z3SDU2eFBNR2VNTFZUWFd0aFlhUWR0cE5JUThhVURLb2R1OUxk?=
 =?utf-8?B?UFNEZXI5MDI3VVhkTjNBNTN5SklkaklXSU1IN1hyTVNNMUNkWWlzQloxUzkz?=
 =?utf-8?B?bXV2dDJMU1hsSkFsR1FwakhRQVZwRU03WmRhaU16U1RzYmZRZ25lQ1RjRVR1?=
 =?utf-8?B?dm1LaU1sRzBmbUdmUjFPK2cxZk1lK2taR0hqb3VHU004eGpTS0NZdURpN3h6?=
 =?utf-8?B?bmtzQWNlb01FNm5aTG12ZFllTzdaeGdUcmtFaENOWDVwbXpwc1Ewa05XWlgw?=
 =?utf-8?B?ZndlSGZnVHZwdUZ2MmVCTHRBYWxDODlnb1ZlOVJsY1lUK0VWamVQaWVBeS9W?=
 =?utf-8?B?UDhjM1ZEcGtad1lPTElsSC9DVXo3UUpFYzdZNW16N3Z2TmY3ZXFqNHRyamhq?=
 =?utf-8?B?ditQN001UFRjc1pIbVJ5OHhCalc1empDZjF2SXczMXZxRFg2ekMzMk5HZU1n?=
 =?utf-8?Q?IqtdLx2CtSVhFArUy1/g7lUHHPkJw7LSoPqpQwEEDLHP?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B0F5E319E674544690AF302BA9A349BB@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d14b419-443c-4199-30d9-08dac801ca0b
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Nov 2022 18:38:43.6443
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IgeXFDAuJOs1SKNMkZH8obiUmuT2/4BBPA7adKOOF03PeR4PbRa0JDGMkkWWL6RSLwuSvxa9fLNvRqaalZFBqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7767
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221116_103848_919684_E0F7D689 
X-CRM114-Status: UNSURE (   7.70  )
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

Q2hhbywNCg0KT24gMTEvMTUvMjIgMjM6NTIsIENoYW8gTGVuZyB3cm90ZToNCj4gUmV2aWV3ZWQt
Ynk6IENoYW8gTGVuZyA8bGVuZ2NoYW9AaHVhd2VpLmNvbT4NCj4gDQo+IE9uIDIwMjIvMTEvMTYg
MTU6MjcsIENocmlzdG9waCBIZWxsd2lnIHdyb3RlOg0KPj4gVGhlIE5WTWUgZHJpdmVycyBzdXBw
b3J0IGEgbW9kZSB3aGVyZSBubyB0YWdzZXQgaXMgYWxsb2NhdGVkIGZvciB0aGUgSS9PDQoNClBs
ZWFzZSBhdm9pZCB0b3AgcG9zdGluZy4NCg0KLWNrDQoNCg==

