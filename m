Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73F94C7EE24
	for <linux-nvme@archiver.kernel.org>; Wed, 10 May 2023 08:16:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MESB3cIKCWTvDf7+v3JqGR3lCmgqNcZyDtuP9oM+jfM=; b=hTqWRpvjQ4k/ru6buSAPm1EmAM
	v+rKH37qC1izAjQ7pXc8fgNofhgYM82KSlxiA/7RWmBeUTWZGCzIBh6XEz/qw2D4nATnMmWSCgNjw
	z7uOcoDgCF+aQyjQk9T3h9c8w4vAA1VwzOiW76ZWF/YZXr04hlcctKat2AUIoOlFdIHOVb/u5LkGE
	R7i0HZ9S9PpfgeDiVeLSnYzMgXeYhK8i959cvOSoGbgCkzZJeEYvs4bzoc6RbLYCLkVOBwiUQZJAB
	9UXaFmUbOq7r7R/Ykdz3WnwVLSXQvgMfOXNl3YIEWxwzO6oQp2fIUMi3awnVxZIJBoT+XPCTuw6YL
	GT2CF//g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pwf0I-005Usg-0W;
	Wed, 10 May 2023 08:16:54 +0000
Received: from mail-mw2nam12on20620.outbound.protection.outlook.com ([2a01:111:f400:fe5a::620] helo=NAM12-MW2-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pwf0E-005UrJ-1i
	for linux-nvme@lists.infradead.org;
	Wed, 10 May 2023 08:16:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SMKoqME2sLsvnDMWFYUlQ8bfgSQLCz1yZ3YxYYvfGzK3KhnjZBHUmGGMTUfRunxGq7YhEC4x95nEPgNmB4ftWD61JCfrqg0+Qgo6eCO3jrUGKF0MZY9/zu3HWh0ixOtxIXJ9nesQDI46AXGQN51JdbJlwUwtNMkKQF1yLrZcG3deZA9XWe5zU1O4L79/K9bTOZlMuC4DR9qiJ6eCBxdUl/0F7U5rVoCZTwUHoyaiSf5FoS0AdSOMrfH8wPtKnOEef+zLb7lvGVcmJBAFkWPcULUFbQBlVv3jbeDEQ5uTVL1Hl91B3mTsiqcS0AsI+mh1XNH3tvfuVOSG1JUEF3jb8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MESB3cIKCWTvDf7+v3JqGR3lCmgqNcZyDtuP9oM+jfM=;
 b=jYwRGWEOC4Dlyrb+Fhcz+9QPz3FNkd+1TbtZpL1XDoEisG+zzd6xCCyAGrtQNn9ktR87PCWRUTg7/P4pYhf2dBhkgQatuHvAhzbOH0y3YJbbX8MLt30gd6/JYXeie2z12u1BStp/hjdqmLqHhyOsvzsmLrFLHkW1Y+zkvlVVwGDLX9cKvTbZ1GMVkzae9JtritWp3y+iqcF8A2YpB4W+tYgFlSH8CI8dMlIicJ/NQue25jtamRBP/93nIqq1mYU2bSOGGPzMmNdl9llVLfoQh9Vsn/HL4VC56P56hqLsDmT6BWhq49zIfb4ZsH5S9QVzOwQxkb9mNcCPNh/P0Pl0dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MESB3cIKCWTvDf7+v3JqGR3lCmgqNcZyDtuP9oM+jfM=;
 b=JzegrEvxEfbsQyRkquAG9f7nM2cUrVtcbrNfMNWmW0zb6etdUTZSqBXTqStO0+D7+8qcMMVMWPAUzj+nPHKRquXEqW6Iabh6RA2je3QcTLNoXG5OXyrd+GfmWecNr/8gYsEQP1cu8LM/OJSEmUgssf7R2Xu4vYdvnwcH/GKa8VTDVAdctqida3ppfdxc9yOtTVexCIX3LN8LhnVkefE0OG8jnnSgdcBRJfbJIUCDNH7UMbFizAyk5sjsRtrbrkLLrtlLA184vYUHKwMft51uqwc6TI/dj7O6GNYkoR+CnSk1+78jOZpkDR468npQDFk1fa01db/7ckRPp3ZmfHdjew==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by SA0PR12MB4526.namprd12.prod.outlook.com (2603:10b6:806:98::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.32; Wed, 10 May
 2023 08:16:46 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::7326:8083:5e17:2f90]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::7326:8083:5e17:2f90%4]) with mapi id 15.20.6363.032; Wed, 10 May 2023
 08:16:46 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Bart Van Assche <bvanassche@acm.org>, Christoph Hellwig <hch@lst.de>
CC: Keith Busch <kbusch@kernel.org>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>, Sagi Grimberg <sagi@grimberg.me>, Max
 Gurtovoy <mgurtovoy@nvidia.com>, Hannes Reinecke <hare@suse.de>, Shin'ichiro
 Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: Re: [PATCH] nvmet-rdma: Suppress a class of lockdep complaints
Thread-Topic: [PATCH] nvmet-rdma: Suppress a class of lockdep complaints
Thread-Index: AQHZgn4uMaBwPKci/EiNCaFkqegDQa9TKoiA
Date: Wed, 10 May 2023 08:16:46 +0000
Message-ID: <18498b01-ed2a-33b7-d2b9-5e40cea43520@nvidia.com>
References: <20230509135615.2061227-1-bvanassche@acm.org>
In-Reply-To: <20230509135615.2061227-1-bvanassche@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|SA0PR12MB4526:EE_
x-ms-office365-filtering-correlation-id: 27260fc8-75ea-485b-915f-08db512ee56a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  YBfgel+1W1ptO53ovuAP+kpYMp7cXyklAbx7iIgKQzrIVNXIbweDoJ9WtISac2tHzRUYDHdEE5LuN7gFMZUaPiewwSgZqNr4MoMnT6hZTEkfH1aCwmcW2PMkFNFL5qpPfwU2e8EvF+g4p3lx5NqMftejEKgoluU/kHfUohtn6aav5pPNgGWuKLNySHGShyJ9qNZHJZ9uintlwrQsbD+Olpyl8nczOTxE62mUP06OHsJPVPhs8jZ2onwahpvjDcRPPIYRYF50kyObVBeInyejHAkVcq3jEfhG32zthd/FwTBWJ93Pp1OBM/Dy2x94cTjdklV16jcg/mE7PERwaF6TW5VTS3DQ6NautE1sUcDpZA3cmZ6uRruCG5tSehS8gT/Q0PWpHbpRzi5TB+x7BIXZbaj0xeM4LR/cxo+vXlte2JIeqg9FASfYkd0CU8Qc5vsWddLoqWAj+R/1AZ8yEPOoaN6tjuqx2P3iv74f6q9/qONffxA6OEZTrUgttE2SdipuMKINfe2o1hkqBsj4lbkYOxCHIS7tMECCMmzd4eq2rGSVpmMoFfb83AQRDOfetwz/LCmiLTckwJvDLgQ0iC/Ke17egKZYNW1BOpE6I+Q1hVfJB+DemeyeL/L8F1/oNLImfJFzaCx8Xis9aV1BSx5SXOjt9inVUN7hl0rT9YlyGoWg81HJc7qEHnHjabGSgdunY8MdpZbp1f1a34G7qjaPU/yMCkNnGfzqEkR2AIP9siQ=
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(366004)(376002)(39860400002)(346002)(136003)(451199021)(6506007)(6512007)(53546011)(6486002)(966005)(83380400001)(36756003)(2616005)(38100700002)(122000001)(86362001)(31696002)(38070700005)(186003)(76116006)(54906003)(110136005)(316002)(8676002)(8936002)(41300700001)(71200400001)(478600001)(91956017)(4326008)(5660300002)(66476007)(66446008)(66556008)(66946007)(64756008)(31686004)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?utf-8?B?TUpIR3J2cVVDWnpndGEvem9OTnRGcmdVRWFmUStEVG45OWhhR0E4MjVSaHJ3?=
 =?utf-8?B?ZU83ZllPOHZwaWhCTWdUQ3hrMWcyMERKK2tiZG9CQzNGZnNxR1U4WTd6UWZZ?=
 =?utf-8?B?MHZSS1RsVlVjQlE0Z2JoSW9kbzMvZk9wZVliR1pTUTF0NVFpUGU2VmlBRDVp?=
 =?utf-8?B?QWRlREFVeVF5NzhZeVZpNE9MeTBWUWUwWnExNWV1eW9JSGZLdFYxUmpaNlNu?=
 =?utf-8?B?amE4RUFRZXk4L0lNbXhlNTFqdDBGSWZLZUhtVkRBeXNiVG4zTnhhT01BMDNE?=
 =?utf-8?B?b2N0dVNtRCsrU2tjYWc2QjA3OURhUEFoUE10UlRobHIxWjlLRnNTK0dhNk0y?=
 =?utf-8?B?SzVCcEU4c2daZVNRelI1ZlhKY29SNVZIbVIwWGZUL3Z2bzZnbkJVcy9EMjI3?=
 =?utf-8?B?cTRESjdIR3lyZjdweGhyZTAzWnNSMXFNdkcvQU9xbHRCZVB4SVZDSGJQeGRK?=
 =?utf-8?B?enpZbDdlZVZIMzRSQVhrOWNkdkdBNlpQNHlEUjVSVUppbU8reWZlSWtjM1Na?=
 =?utf-8?B?QjdEOE41TDlvRGM0N1BBaEM5T0FhRnFidDVPamlhUEZaK3NTTTY2RnA4QWto?=
 =?utf-8?B?bUhBblZMK0Z6akNwM3JyUWduQXVSRGNSSXdyenlQRWQvVytERDUzTzBENHpj?=
 =?utf-8?B?bHc1c1VFb21TUjBLTEFhY1VxaHJpWU5aaTVDMXlIaHc4czZPT3c3UzVQY053?=
 =?utf-8?B?TklGK1RyNlRRRTBkQ2QyL2J6YlRxUlZ6RE1IUWpDaHY3L2xoaStnQk1OR3RL?=
 =?utf-8?B?OE9FV2VvQ3dNTG1BYjRRUlB1eHZ5S01uREpJa0RKUW1OUy9Gb2FSdUJnMlkr?=
 =?utf-8?B?Sm84U0tWQlpkc29HbkhHZXl0QmRlZFVmNFdDUlN5aGgzcHFHckVsdzlBci83?=
 =?utf-8?B?NEgya0l3VWJkMlRtOWQ2RDFkRDg1NWZWS0dJZGNJc2FQcHQ0OGpjdWp5S2Zz?=
 =?utf-8?B?MVQ3UkFrNys1UzNYcUZOL3pvR0hzL2p2K3FwRkE2TFpwUzFYV3RhQVMyTW5C?=
 =?utf-8?B?MTc3YnZseCttNitrTU9WSGpWQjkxaUs2VGNwVi80NGRJVVlrWlpTa055aDZR?=
 =?utf-8?B?b1FUSWlicDQzZWRqcjVlK1pjOStqSTdNeXRRZllqeFNtbVQ3ajlZMkQwYXlT?=
 =?utf-8?B?UnpBT0ZQanloSS91eXVDdnJ2V2ZRTEZKMmk3WXhURVB4OCt3Q1ZEN2tzTjlr?=
 =?utf-8?B?Y2pQZG1sMzJpVDl1WDlGOWJ4VjUzU3hxOWdjZlZLUGxuZzQxZTREcDhoaFJ3?=
 =?utf-8?B?NU9oUjUvZXZvQlA4RnFUMnV3Zk5VM242SW0vOFpGNVpOSlVmN05kVU1NQ3Np?=
 =?utf-8?B?anExb1R2R0ZVWEpqWlM3czBvaUVNSGFrMXkrV3czdEN1OUNpS2x1SWJMbTRi?=
 =?utf-8?B?c01aNlRHekpIZkgrK0RNdW9ZTG5BT2dDa3lWcE1sS2tqRVQ2SG5DRWVNV1Na?=
 =?utf-8?B?UTJPRUhlUTAyU3FBSWFyczFrUHdrdVM2K1lySUR3N21oakQxVXBsMHE0VXE4?=
 =?utf-8?B?Q20xOEllVXF5dzd5Ni9rc2diTHp3MkZrOFkvaXFDdG1qT3c5TDBMTzE1aE13?=
 =?utf-8?B?ZXNaSnBEZDRYdWFBU01lRUZ4OXpGckUrcHo2RzR4YzR5V0Q5YWo5UWlQcGxC?=
 =?utf-8?B?blBxdEtUWHAyOUhnTGt2V2lkN21vMzFuaCtaalZKbFF4NUxRbmtQb2FIb3RF?=
 =?utf-8?B?VUNIbVlBNUV6bTlMTVNOYTYrYUlHSlhicEppVEgveHBnVDd0Y1ZLTytTb3RR?=
 =?utf-8?B?SFRPYSttQ2Z0YXMvU3VmaXk0RFhpdEZSN0lOM3ZRV3RzNzVhUDVTSnM4SXVN?=
 =?utf-8?B?eXZZaXRxNnFnbUl1a3VrNUloV2NqK2RDc2d4TlR2N0tBY29kTHc4djRaNDA3?=
 =?utf-8?B?alRuZFZHanNGZFR3REJqd3lDSGZvMFpHTmYxYVVUNHB4OGQ2YmlqRmF3UUtx?=
 =?utf-8?B?S3NXVnA3VzZxd0RKVndPdkxraGJhY1k4YndCaW9DRmJCUzJWU2x5RmxnS2RH?=
 =?utf-8?B?Z2JVQVNud1FlSkQxS29SOUFiZEwvVlJBbWhra2V6MFNnbzd3bWZPbnNUemU4?=
 =?utf-8?B?ZmF1cFVkbVlqSko1STBvQXNOZDBjc3FOYk15aWUvVmpSdG1rMW0wK3ZJamw0?=
 =?utf-8?B?QWt6aWVIN1lBa1FOK1NKU3JadHlFT0JMU0R4VlFjN05UUGNINDBiSDJNZVNK?=
 =?utf-8?Q?imn/jCi1mXuURuejfWLUt5WCJiWc4v+v2wJrnXfYLJ6a?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <56D0407CC4247144A3364A5C865C4FBB@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27260fc8-75ea-485b-915f-08db512ee56a
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 May 2023 08:16:46.1953
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fj9W8U6yXu6nMvvFgX+ez12QMrqAiwhm6MeH4k/fC2YUoeZuoYBoMj43IAtkT3H4iTR9IOrhOTyhbs9ztXlMfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4526
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230510_011650_613261_7E4BB999 
X-CRM114-Status: GOOD (  15.59  )
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

T24gNS85LzIzIDA2OjU2LCBCYXJ0IFZhbiBBc3NjaGUgd3JvdGU6DQo+IFdhaXRpbmcgaW4gbnZt
ZXRfcmRtYV9xdWV1ZV9jb25uZWN0KCkgZm9yIHByZXZpb3VzIHRlYXJkb3ducyB0byBjb21wbGV0
ZQ0KPiAoZmx1c2hfd29ya3F1ZXVlKG52bWV0X3dxKSkgY29uZnVzZXMgbG9ja2RlcC4gQ2xlYXIg
dXAgdGhpcyBjb25mdXNpb24gYnkNCj4gYnkgdXNpbmcgZHluYW1pYyBsb2NrZGVwIGtleXMgaW5z
dGVhZCBvZiBzdGF0aWMgbG9ja2RlcCBrZXlzIGZvcg0KPiBxdWV1ZS0+cmVsZWFzZV93b3JrLg0K
Pg0KPiBTZWUgYWxzbyB0aGUgZm9sbG93aW5nIHJlcG9ydCBieSBTaGluaWNoaXJvOg0KPiBodHRw
czovL2xvcmUua2VybmVsLm9yZy9hbGwvcnNtbXhyY2h5NnZvaTVxaGw0aXJzczVzcHJuYTNmNW93
a3F0dnlieGdsY3YycG55bG1AeG1ybnBmdTN0ZnBlLw0KPg0KPiBUaGlzIHBhdGNoIGF2b2lkcyB0
aGF0IGxvY2tkZXAgcmVwb3J0cyB0aGUgZm9sbG93aW5nOg0KPg0KPiA9PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0NCj4gV0FSTklORzogcG9zc2li
bGUgY2lyY3VsYXIgbG9ja2luZyBkZXBlbmRlbmN5IGRldGVjdGVkDQo+IDQuMTkuMC1kYmcrICMx
IE5vdCB0YWludGVkDQo+IC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLQ0KPiBrd29ya2VyL3UxMjowLzcgaXMgdHJ5aW5nIHRvIGFjcXVpcmUgbG9j
azoNCj4gMDAwMDAwMDBjMDNhOTFkMSAoJmlkX3ByaXYtPmhhbmRsZXJfbXV0ZXgpeysuKy59LCBh
dDogcmRtYV9kZXN0cm95X2lkKzB4NmYvMHg0NDAgW3JkbWFfY21dDQo+DQo+IGJ1dCB0YXNrIGlz
IGFscmVhZHkgaG9sZGluZyBsb2NrOg0KPiAod29ya19jb21wbGV0aW9uKSgmcXVldWUtPnJlbGVh
c2Vfd29yaykpeysuKy59LCBhdDogcHJvY2Vzc19vbmVfd29yaysweDNjOS8weDlmMA0KPiB3aGlj
aCBsb2NrIGFscmVhZHkgZGVwZW5kcyBvbiB0aGUgbmV3IGxvY2suDQo+DQo+IHRoZSBleGlzdGlu
ZyBkZXBlbmRlbmN5IGNoYWluIChpbiByZXZlcnNlIG9yZGVyKSBpczoNCj4gLT4gIzMgKCh3b3Jr
X2NvbXBsZXRpb24pKCZxdWV1ZS0+cmVsZWFzZV93b3JrKSl7Ky4rLn06DQo+ICAgICAgICAgcHJv
Y2Vzc19vbmVfd29yaysweDQ0Ny8weDlmMA0KPiAgICAgICAgIHdvcmtlcl90aHJlYWQrMHg2My8w
eDVhMA0KPiAgICAgICAgIGt0aHJlYWQrMHgxY2YvMHgxZjANCj4gICAgICAgICByZXRfZnJvbV9m
b3JrKzB4MjQvMHgzMA0KPiAtPiAjMiAoKHdxX2NvbXBsZXRpb24pIm52bWV0LXJkbWEtZGVsZXRl
LXdxIil7Ky4rLn06DQo+ICAgICAgICAgZmx1c2hfd29ya3F1ZXVlKzB4ZjMvMHg5NzANCj4gICAg
ICAgICBudm1ldF9yZG1hX2NtX2hhbmRsZXIrMHgxMzIwLzB4MTcwZiBbbnZtZXRfcmRtYV0NCj4g
ICAgICAgICBjbWFfaWJfcmVxX2hhbmRsZXIrMHg3MmYvMHhmOTAgW3JkbWFfY21dDQo+ICAgICAg
ICAgY21fcHJvY2Vzc193b3JrKzB4MmUvMHgxMTAgW2liX2NtXQ0KPiAgICAgICAgIGNtX3dvcmtf
aGFuZGxlcisweDQzMWUvMHg1MGJhIFtpYl9jbV0NCj4gICAgICAgICBwcm9jZXNzX29uZV93b3Jr
KzB4NDgxLzB4OWYwDQo+ICAgICAgICAgd29ya2VyX3RocmVhZCsweDYzLzB4NWEwDQo+ICAgICAg
ICAga3RocmVhZCsweDFjZi8weDFmMA0KPiAgICAgICAgIHJldF9mcm9tX2ZvcmsrMHgyNC8weDMw
DQo+IC0+ICMxICgmaWRfcHJpdi0+aGFuZGxlcl9tdXRleC8xKXsrLisufToNCj4gICAgICAgICBf
X211dGV4X2xvY2srMHhmZS8weGJlMA0KPiAgICAgICAgIG11dGV4X2xvY2tfbmVzdGVkKzB4MWIv
MHgyMA0KPiAgICAgICAgIGNtYV9pYl9yZXFfaGFuZGxlcisweDZhYS8weGY5MCBbcmRtYV9jbV0N
Cj4gICAgICAgICBjbV9wcm9jZXNzX3dvcmsrMHgyZS8weDExMCBbaWJfY21dDQo+ICAgICAgICAg
Y21fd29ya19oYW5kbGVyKzB4NDMxZS8weDUwYmEgW2liX2NtXQ0KPiAgICAgICAgIHByb2Nlc3Nf
b25lX3dvcmsrMHg0ODEvMHg5ZjANCj4gICAgICAgICB3b3JrZXJfdGhyZWFkKzB4NjMvMHg1YTAN
Cj4gICAgICAgICBrdGhyZWFkKzB4MWNmLzB4MWYwDQo+ICAgICAgICAgcmV0X2Zyb21fZm9yaysw
eDI0LzB4MzANCj4gLT4gIzAgKCZpZF9wcml2LT5oYW5kbGVyX211dGV4KXsrLisufToNCj4gICAg
ICAgICBsb2NrX2FjcXVpcmUrMHhjNS8weDIwMA0KPiAgICAgICAgIF9fbXV0ZXhfbG9jaysweGZl
LzB4YmUwDQo+ICAgICAgICAgbXV0ZXhfbG9ja19uZXN0ZWQrMHgxYi8weDIwDQo+ICAgICAgICAg
cmRtYV9kZXN0cm95X2lkKzB4NmYvMHg0NDAgW3JkbWFfY21dDQo+ICAgICAgICAgbnZtZXRfcmRt
YV9yZWxlYXNlX3F1ZXVlX3dvcmsrMHg4ZS8weDFiMCBbbnZtZXRfcmRtYV0NCj4gICAgICAgICBw
cm9jZXNzX29uZV93b3JrKzB4NDgxLzB4OWYwDQo+ICAgICAgICAgd29ya2VyX3RocmVhZCsweDYz
LzB4NWEwDQo+ICAgICAgICAga3RocmVhZCsweDFjZi8weDFmMA0KPiAgICAgICAgIHJldF9mcm9t
X2ZvcmsrMHgyNC8weDMwDQo+IG90aGVyIGluZm8gdGhhdCBtaWdodCBoZWxwIHVzIGRlYnVnIHRo
aXM6DQo+IENoYWluIGV4aXN0cyBvZjoNCj4gICAgJmlkX3ByaXYtPmhhbmRsZXJfbXV0ZXggLS0+
ICh3cV9jb21wbGV0aW9uKSJudm1ldC1yZG1hLWRlbGV0ZS13cSIgLS0+ICh3b3JrX2NvbXBsZXRp
b24pKCZxdWV1ZS0+cmVsZWFzZV93b3JrKQ0KPg0KPiBQb3NzaWJsZSB1bnNhZmUgbG9ja2luZyBz
Y2VuYXJpbzoNCj4NCj4gICAgICAgICBDUFUwICAgICAgICAgICAgICAgICAgICBDUFUxDQo+ICAg
ICAgICAgLS0tLSAgICAgICAgICAgICAgICAgICAgLS0tLQ0KPiAgICBsb2NrKCh3b3JrX2NvbXBs
ZXRpb24pKCZxdWV1ZS0+cmVsZWFzZV93b3JrKSk7DQo+ICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgbG9jaygod3FfY29tcGxldGlvbikibnZtZXQtcmRtYS1kZWxldGUtd3EiKTsNCj4g
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBsb2NrKCh3b3JrX2NvbXBsZXRpb24pKCZx
dWV1ZS0+cmVsZWFzZV93b3JrKSk7DQo+ICAgIGxvY2soJmlkX3ByaXYtPmhhbmRsZXJfbXV0ZXgp
Ow0KPg0KPiAgICoqKiBERUFETE9DSyAqKioNCj4NCj4gMiBsb2NrcyBoZWxkIGJ5IGt3b3JrZXIv
dTEyOjAvNzoNCj4gICAjMDogMDAwMDAwMDAyNzIxMzRmMiAoKHdxX2NvbXBsZXRpb24pIm52bWV0
LXJkbWEtZGVsZXRlLXdxIil7Ky4rLn0sIGF0OiBwcm9jZXNzX29uZV93b3JrKzB4M2M5LzB4OWYw
DQo+ICAgIzE6IDAwMDAwMDAwOTA1MzFmY2QgKCh3b3JrX2NvbXBsZXRpb24pKCZxdWV1ZS0+cmVs
ZWFzZV93b3JrKSl7Ky4rLn0sIGF0OiBwcm9jZXNzX29uZV93b3JrKzB4M2M5LzB4OWYwDQo+DQo+
ICAgICAgICAgICAgICAgICBzdGFjayBiYWNrdHJhY2U6DQo+IENQVTogMSBQSUQ6IDcgQ29tbTog
a3dvcmtlci91MTI6MCBOb3QgdGFpbnRlZCA0LjE5LjAtZGJnKyAjMQ0KPiBIYXJkd2FyZSBuYW1l
OiBRRU1VIFN0YW5kYXJkIFBDIChpNDQwRlggKyBQSUlYLCAxOTk2KSwgQklPUyAxLjEwLjItMSAw
NC8wMS8yMDE0DQo+IFdvcmtxdWV1ZTogbnZtZXQtcmRtYS1kZWxldGUtd3EgbnZtZXRfcmRtYV9y
ZWxlYXNlX3F1ZXVlX3dvcmsgW252bWV0X3JkbWFdDQo+IENhbGwgVHJhY2U6DQo+ICAgZHVtcF9z
dGFjaysweDg2LzB4YzUNCj4gICBwcmludF9jaXJjdWxhcl9idWcuaXNyYS4zMisweDIwYS8weDIx
OA0KPiAgIF9fbG9ja19hY3F1aXJlKzB4MWM2OC8weDFjZjANCj4gICBsb2NrX2FjcXVpcmUrMHhj
NS8weDIwMA0KPiAgIF9fbXV0ZXhfbG9jaysweGZlLzB4YmUwDQo+ICAgbXV0ZXhfbG9ja19uZXN0
ZWQrMHgxYi8weDIwDQo+ICAgcmRtYV9kZXN0cm95X2lkKzB4NmYvMHg0NDAgW3JkbWFfY21dDQo+
ICAgbnZtZXRfcmRtYV9yZWxlYXNlX3F1ZXVlX3dvcmsrMHg4ZS8weDFiMCBbbnZtZXRfcmRtYV0N
Cj4gICBwcm9jZXNzX29uZV93b3JrKzB4NDgxLzB4OWYwDQo+ICAgd29ya2VyX3RocmVhZCsweDYz
LzB4NWEwDQo+ICAga3RocmVhZCsweDFjZi8weDFmMA0KPiAgIHJldF9mcm9tX2ZvcmsrMHgyNC8w
eDMwDQo+DQo+IENjOiBTYWdpIEdyaW1iZXJnIDxzYWdpQGdyaW1iZXJnLm1lPg0KPiBDYzogTWF4
IEd1cnRvdm95IDxtYXhnQG1lbGxhbm94LmNvbT4NCj4gQ2M6IEhhbm5lcyBSZWluZWNrZSA8aGFy
ZUBzdXNlLmRlPg0KPiBDYzogU2hpbidpY2hpcm8gS2F3YXNha2kgPHNoaW5pY2hpcm8ua2F3YXNh
a2lAd2RjLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogQmFydCBWYW4gQXNzY2hlIDxidmFuYXNzY2hl
QGFjbS5vcmc+DQo+IC0tLQ0KPiAgIA0KDQptdWNoIG5lZWRlZCBmaXggdG8gc3RvcCB0aGVzZSBy
ZXBlYXRlZCByZXBvcnRzIHRvIHNhdmUgZXZlcnlvbmUncyB0aW1lIC4uDQoNClJldmlld2VkLWJ5
OiBDaGFpdGFueWEgS3Vsa2FybmkgPGtjaEBudmlkaWEuY29tPg0KDQotY2sNCg0KDQo=

