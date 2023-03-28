Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66FA4C76196
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Mar 2023 05:47:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6ysXl/fxsz+LBJH1vr/PKUVoWy+QSh16pgHyTZQxlWE=; b=WwIxJRAV1TGW4YVAMb/V30ezQ6
	opp6vQfYw3kSX7zV50zy6QIFNuCb2G9/kUNqhGGlS/JhuPq3mS2OaAnePPWrWN/vpeuHxRVbV+thy
	KVAp5WfgLlwlWn5j6vsTZV9Gkingsph++pFn/FJWaGwcB6k9DAQeGYzKcbN+RXDZb/fyCdXOWUZY6
	WtRxZnxDhTONlF/Rz86a9G2HS0ip9s4rXyIlaumZ0lzlMXqhFuK71EVNB2RWj2ITc60Ft3Ws8tn38
	+gY2oGZ3fp0zaPDHsNva1FtBlUdEBs4BnXHpodrvs2Ufk2aZrx66knRVrFHYGHy6wdtd71a3cqPyz
	hI6UHLnA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1ph2Am-00DDUj-0H;
	Tue, 28 Mar 2023 05:47:08 +0000
Received: from mail-co1nam11on2060e.outbound.protection.outlook.com ([2a01:111:f400:7eab::60e] helo=NAM11-CO1-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1ph2Aj-00DDTJ-0f
	for linux-nvme@lists.infradead.org;
	Tue, 28 Mar 2023 05:47:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f58ToFyyFijJ1wq7Ll3T2tn8ciQ8ZSLMk+C2laBiTG9aV1fzHGilTEL1nS3xq3pJqeF5OGHLqumyvhwexCtTU/b5nZU8Z5SY1ceHruhi9TilDH9yJS/AhjhcNeGm14D1I4ocBFvX4/+JZ0UZYeY4BURqP1SEUbyqgbWYnlvuN03OQJBeiv/ET9aqhEE61wB3fTmhv0Jd4OHtkhsM/ni9Dg1mO/w6sK9iewh3Gdhe4Kb8R5lwOWnAnYgbfVmddFitoLzd6ECQ5zoTAezYanfmKg1xTnVEryC5DwLCRNFonH1eYgjhpu8Wq87YmL2L9aEq23P1R9ijQUef1q3Fg28IDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6ysXl/fxsz+LBJH1vr/PKUVoWy+QSh16pgHyTZQxlWE=;
 b=XP709T2ayte6tSDc3JiPdyfyHhIjq7vsvDa+vmrgi3m0OChD02M1raIW0dsAW8opWZhjTM+tKaOZKKAYZfHgpHrEwKxvV3lTeyPZ0x+B0RfkqA7VZ4OCiHTTnqiQjQjIYPq3DNyvBRdr/oL0YUbpIvbA93njmDUYmJQFN7KY6rD4qhw+2iRPSAtzZTp6v+oloD/zpNpOpYQ6PWEsPLpNtVtUH/O39U8TcNsfwhA/Tm+N0jNQB1VTUtIMbkZ4ljHSExlI3qmUG6cCDzQB0m/KLWWfnxjsoNaVjU5C+f6cGGZPGEgxNg42xyNbLM1+tLmtvPTMHf31q4KB7St9J8w2xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6ysXl/fxsz+LBJH1vr/PKUVoWy+QSh16pgHyTZQxlWE=;
 b=MADdSlWg0Ypwqc1eQ8iWedJaFa+jED+0io/1mlsXpUreDXn1CyK/sCKYgOy49z8shRza8Z/xazIKtXZGLPfknOxboIcKeq5k872WYdSk0KFpI7S+QO/OOFWJcrdWwudvEwC4XZbyJI6cP2NxbmyVsddU2C+7XOMoj2chhr+zwcXlaBQnKWIpeh6vMmZL1ig7PzWzTekVYIT5S9oSFoP2VzIlTCOBhrDBiwBDJepBJfx7T5oX+dBcBvdn8lTuhmhuPX1IkzY1Ikex/ljPY+7hR00tNdroAMqTXx/zfMP+6+UiP4l+RYugcJkuQD3k+XMkZqGKF3HygPmaYXIZbVD8HQ==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by BN9PR12MB5241.namprd12.prod.outlook.com (2603:10b6:408:11e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.31; Tue, 28 Mar
 2023 05:46:57 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::9f90:cf3d:d640:a90b]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::9f90:cf3d:d640:a90b%4]) with mapi id 15.20.6222.030; Tue, 28 Mar 2023
 05:46:57 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Christoph Hellwig <hch@lst.de>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"kbusch@kernel.org" <kbusch@kernel.org>, Chaitanya Kulkarni
	<chaitanyak@nvidia.com>, "sagi@grimberg.me" <sagi@grimberg.me>,
	"hare@suse.de" <hare@suse.de>
Subject: Re: [PATCH V2 8/8] nvme-core: fix nvme_submit_sync_cmd() args
Thread-Topic: [PATCH V2 8/8] nvme-core: fix nvme_submit_sync_cmd() args
Thread-Index: AQHZYHJC9roRT1BZIEqgVPcuH+K4Oa8PW7mAgABUzIA=
Date: Tue, 28 Mar 2023 05:46:57 +0000
Message-ID: <91275e05-392b-ad4d-a148-4469b4749662@nvidia.com>
References: <20230327060418.86655-1-kch@nvidia.com>
 <20230327060418.86655-9-kch@nvidia.com> <20230328004327.GC21054@lst.de>
In-Reply-To: <20230328004327.GC21054@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|BN9PR12MB5241:EE_
x-ms-office365-filtering-correlation-id: 82369384-c7b6-48ad-8da1-08db2f4fd7de
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  f8OyVOy+3xtZra3XFyL9LtMiC4fcKjdo7A4nxKfeJnSt/yC6usosKFCsIs7QJM6MZN/oYLZTOaZ2tNYtiBxybezYzswwRb4dubfBxXd6hT3x66LslK/AquqeACtodTloFHAzgTFyUEhtAkkR3m1KdUUo71D9V2VK2enbtUVZf81vMedlx+2PWgUlvnT/pZUirjRaI50Kwuks0kPiwA+DKQge4Hr4kjgctQHj6aKeN1gjvhebgsRvr1ncTQQLdNLgbSYDAWwJZuILtnpy9BgjWoZJctdDiX+evwLKVkHw/zhole+7fvRSeNfejLIPLQn97gUhtHmrfX4/GPGgUtZSCoBs/JIbiMo5ObsoeUixAKZEej/rowxc6PJHqUNdsUA0fVlFdVzs2cL9caJUs6wo5s/ix6xKA8NvxaTU33hEg1x+nGi0alSpOozggkASKtQUJd1SzJpEx+WRYZ/Ya0hykOr+KSK8obZaIVqvRSe1+1gRKAm+ijaQEQdAltsAQ/S3wYLP4NYujGyYjxNuDmNh6iv4Yu8JzgjHGgEvHDI31YkHOmsW+HK/cNkt004qb6g5aZRMRJXYceCVmnHcqn2tR+0UVME+tDs6BlVwkfSy9cW4cThaJwOD6oRxqGATl+Kmqtd9dLn2r5xDWAML7ULY09oA7b7S4CosxlCSoKFBDfCp2824LHIqctbIEaLy4KPb
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(396003)(39860400002)(366004)(346002)(451199021)(2906002)(31696002)(38070700005)(38100700002)(36756003)(86362001)(31686004)(478600001)(6486002)(53546011)(2616005)(83380400001)(71200400001)(8676002)(6512007)(6506007)(91956017)(54906003)(76116006)(4326008)(316002)(6916009)(66946007)(66446008)(66476007)(66556008)(64756008)(5660300002)(186003)(122000001)(8936002)(41300700001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?utf-8?B?VjVLY3dCSVorY1lkSjNuUE9UZERKU0k5QUFZWDRxY1owL0dCWndrNEt3TTE4?=
 =?utf-8?B?RjlRYnpvSjBHbFdSTzNLRXdsZTd5TFhzWjhNKzR3Z2dPSzYxekNjMmdMTDNR?=
 =?utf-8?B?WmtCMUFwUzFqUGJNRnVvM0grYUpIT1ZGamlWYXd4ZWRFSmNsV3dJK3RKWDVK?=
 =?utf-8?B?NkErc09QdmJYcENRdXpsQ2luempWaUNzeHRNTFJxSWFoT2wzSW92VzFGSHo2?=
 =?utf-8?B?NUczSDhnZmt2cFBTODJDVTlEVFl5MWgzL3NKM0dQWjlwSGF0MkpVeFBLOHRW?=
 =?utf-8?B?UENZcnk0OVFCOVp4T01DMytOeHU4TmtsOWdOK1BiNE1hODlNVnhHRk5hZkZJ?=
 =?utf-8?B?T1UrNVJ5L05pWnpYOUxyK1hpOHFnc3ZJQm9ENFNBVmxtUFlvNXZXcDdtK1ZB?=
 =?utf-8?B?Tmd0RWFmVWVFZUljbkY3UVRweFUzY2IrQXhLWnYzdHdTTGxqR290K3h3ZUs4?=
 =?utf-8?B?QjFNN09tdWIveFE1UitUWS95b0JKQkhSYWtjbS9qMzN2TFhKOGlMdWI5RjBw?=
 =?utf-8?B?UGNxaVBJQ296QnEyMHlNTGpuTWJZK09VeGJlbXFUS0d3d3NqMEJ4cFBwN2gr?=
 =?utf-8?B?Y0gza2xzNUNnZEF6aHlVZVEvK0UrczN2Z2FPcnEvZHVtYnJhM1dta1MrYjRM?=
 =?utf-8?B?b1AyQks0QXQ0eGN4ZzdROUpCNlIwS3JVZjA3NkdOcGhKdTFCc0JVWGtKcEpJ?=
 =?utf-8?B?MVo0Y0JjUkxNOUVDRHlxSVZWQ0U4WS9sY3lDMWc4Tkx2b3grK3dEZUZiMU5K?=
 =?utf-8?B?SUtJU2pGR1Y5TGlnMW5EemR6eDFhd2NGN011TjhYeGN4cGQvYjlUMTNtTXov?=
 =?utf-8?B?QUN5VGwzYTc5QXpCdC9MbTFIbHNOdHI5TmV5VURiSklwU2dLRXZPb2RoUlV4?=
 =?utf-8?B?Umh2Tk9zYnM4cHkvbXJJRUM0dGRCZ1dlaC9FYkVKM1h0bnJadVlQOHFua1Yx?=
 =?utf-8?B?WUU5VEtNSGlWbXIrbkx3cGg1MEozd3orNHpDM0pLbTFJL3hMM25la0twOGdS?=
 =?utf-8?B?TTVqVXNRaEJxTGFYM0g5V3JwSlk1K3F5VisyUEtzdFMvRHo0SEEwUkwwMk4w?=
 =?utf-8?B?MW52TDR5VDh5QlNtc0pJVDVseVBhZXB2cmpxQ0pydElQQkNaT2FJcnVNcnZD?=
 =?utf-8?B?SWZIWkJpb2pyRFpvTDNoQlR6VWdzTHFnQzhOdHRxYk51SndubCtYcmtHcHpq?=
 =?utf-8?B?SmhFN2FkWWZ3YVA4R21EY0JQK28rTGl1Tlo0YWFMblUxdEVLemFGNldZSjc0?=
 =?utf-8?B?cFlnZ2hRRzcyZ1A0VlZHNGRwRjR4ZzhUVmRCOTdUb2tsWlNDS2Z5bXBOYUd2?=
 =?utf-8?B?RW81VDl0RlNPVXpLbEVJbnRLREhsaDE4QU41Z24vTXZ6M2NPbkl2R2hJcWw0?=
 =?utf-8?B?VkdrblNUZytlenJ6N1ZsUXYzK1FBMjI1SEIvbHRmR21HWWx3QkVqZWZHOU1v?=
 =?utf-8?B?aTdRY2U5L0xNNThjdTlpTnc4aVNWOGl1ZFlXZ0p3dVFLazM0a3paaEJYay9T?=
 =?utf-8?B?MmVWOUJXeXZ6cmpIdVJtenZDUWhKc211cnoxZEU4U0drOWs5cXJEVzF6RCtB?=
 =?utf-8?B?ak9NcG5CSmwrU1kwcFdmL08weWVqTUYzRkE1SzRnL24zWSt3b2drSm9EcGR5?=
 =?utf-8?B?ZEIxUDB0ekUzVnIwVmJGS3Nmai9yZjM3QjhKNGlBWmlKQStJaDdzRWdVQ2Jm?=
 =?utf-8?B?MG00eGNzblcrb1hkd0tYbVhNaSt2Z1pMTUcrb2xTZmhFc2wvZ1ZkMXJGejFB?=
 =?utf-8?B?RHBTQ29xSWw0TC9qSG5CSWcrdE1UcmdDVmN1aFlBK1hZTmV3SGNvVVdyU1dE?=
 =?utf-8?B?VGNMaU9Fd0RDRmgrZ2w2Y2hZU1dmMHYrWEFBMFpHQlRIZTRrRVlMZm9TRzN6?=
 =?utf-8?B?V3M0QmlLTitFSStGck16SXVuc3I1VjRJU1hkWWw3aFJHa1VYdWdSR01SOGor?=
 =?utf-8?B?MldUejl5MWZQTisvSEYvNGF2ZU9sWUVQM3loMUFhVzgvWnBEa3FlZ3RjZ0g2?=
 =?utf-8?B?TS9SMktIRmo0VnFhcmM4WFd5OTM3M3dFUnk5NFY4bWVqb1VRcEJsQXp2ZWlz?=
 =?utf-8?B?Mmkwb3BVaE5TaElCcjIzQkVtTGZJakRwaGZ5WGc4cVVxeEVWS2g1NWNhUm1m?=
 =?utf-8?B?VFJ6R0J0a3BVTDlMYi8zejUzU3ZpVkVJWGRCTnk1azR2N0ZNMWdzd3NTMjN6?=
 =?utf-8?Q?ln8B214Yq26pxgtsFWTDBpO9HpPlK3AIU61Rsl7azC5H?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4BF475DE06135C4D9F1DAB5C667F4CC0@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82369384-c7b6-48ad-8da1-08db2f4fd7de
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Mar 2023 05:46:57.3516
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: w8tPuw3EUojbWvUbkUz33meOxX3vaTyO1enZXRcAxQ8eCvoky4vLDZJR7434ikgcHJXF365zilZ6nEZLM1+AGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5241
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230327_224705_245438_E6EC9BE9 
X-CRM114-Status: GOOD (  20.27  )
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

T24gMy8yNy8yMyAxNzo0MywgQ2hyaXN0b3BoIEhlbGx3aWcgd3JvdGU6DQo+IE9uIFN1biwgTWFy
IDI2LCAyMDIzIGF0IDExOjA0OjE4UE0gLTA3MDAsIENoYWl0YW55YSBLdWxrYXJuaSB3cm90ZToN
Cj4+IDQgZmlsZXMgY2hhbmdlZCwgMTEyIGluc2VydGlvbnMoKyksIDM4IGRlbGV0aW9ucygtKQ0K
PiBUaGlzOg0KPg0KPiAgIC0gYWRkcyBhIHNoaXQgdG9uIG9mIGNvZGUNCg0KYWdyZWUsIGJ1dCBp
dCBpcyBzaW1pbGFyIHdoYXQgd2UgZG8gZm9yIG52bWVfY29tbWFuZCBzdHJ1Y3R1cmUNCmFsbCBv
dmVyIGluIHRoZSBob3N0IHNpZGUgY29yZSBhbmQgZmFicmljcyBjb2RlIG5vdGhpbmcgbmV3IDot
DQpudm1lX2lkZW50aWZ5X25zX2Rlc2NzKCkNCm52bWVfaWRlbnRpZnlfbnMoKQ0KbnZtZV9uc19p
bmZvX2Zyb21faWRfY3NfaW5kZXAoKQ0KbnZtZV9pbml0X21zKCkNCm52bWVfZ2V0X2xvZygpDQpu
dm1lX2luaXRfbm9uX21kdHNfbGltaXRzKCkNCm52bWVfc2Nhbl9uc19saXN0KCkNCm52bWVfaWRl
bnRpZnlfY3RybCgpDQpudm1mX3JlZ19yZWFkMzIoKQ0KbnZtZl9yZWdfcmVhZDY0KCkNCm52bWZf
cmVnX3dyaXRlMzIoKQ0KbnZtZl9jb25uZWN0X2FkbWluX3F1ZXVlKCkNCm52bWZfY29ubmVjdF9p
b19xdWV1ZSgpDQoNCj4gICAtIG1ha2VzIGl0IGhhcmRlciB0byB1c2UgdGhlIGZ1bmN0aW9uDQoN
CndlIHBhc3MgbnZtZV9jb21tYW5kIHN0cnVjdCBzaW1pbGFyIHdheSB3aXRoIGluaXRpYWxpemlu
Zw0KaXRzIG1lbWJlcnMsIHRoaXMgcGF0Y2ggaXMgZG9pbmcgdGhlIHNhbWUgd2l0aG91dCBpbnZl
bnRpbmcNCmFueXRoaW5nIG5ldyBzaW1pbGFyIHRvIGJsb2NrIGxheWVyIGNvZGUgKG1lbnRpb25l
ZCBpbiBjb21taXQNCmxvZykgYW5kIGhvc3Qgc2lkZSBjb3JlL2ZhYnJpY3MgY29kZSBmb3IgdGhl
IG52bWVfY29tbWFuZA0KbWVudGlvbmVkIGFib3ZlLg0KDQo+ICAgLSBjcmVhdGVzIHRvbnMgb2Yg
Y2h1cm4NCj4NCj4gV2h5Pw0KDQppbiBnZW5lcmFsIHRoZXJlIGlzIGV2ZW4gb3Bwb3NpdGlvbiB0
byBoYXZlIDYgYXJncyB3aGVuIEkgc2VudCBvdXQNCmEgcGF0Y2gtc2VyaWVzIGZvciBfX252bWVf
c3VibWl0X3N5bmNfY21kKCkgaXQgaGFzIDghDQoNCmN1cnJlbnRseSBpdCBoYXMgbG9uZyBsaXN0
IG9mIGFyZ3VtZW50cyBhbmQgSSB0aGluayBwZW9wbGUgaGF2ZQ0KY29tcGxhaW5lZCBhYm91dCBp
dCBhbHJlYWR5IG9uIHRoZSBtYWlsaW5nIGxpc3QsIGlmIHNvbWVvbmUgd2FudHMNCnRvIGFkZCBt
b3JlIGFyZ3VtZW50KHMpIHdoYXQgaXMgdGhlIHJpZ2h0IHdheSBvZiBkb2luZyB0aGF0DQpzaW5j
ZSB0aGlzIHBhdGNoIGlzIG5vdCBhY2NlcHRhYmxlID8gcGxlYXNlIGV4cGxhaW4gLi4uDQoNCmlm
IHlvdSBzdGlsbCB0aGluayBrZWVwaW5nIGxvbmcgbGlzdCBvZiBhcmd1bWVudCBpcyBhIGJldHRl
ciB3YXkNCnRvIGdvIHRoZW4gZmVlbCBmcmVlIHRvIGRyb3AgdGhpcyBubyBiaWdneSAuLg0KDQot
Y2sNCg0KDQo=

