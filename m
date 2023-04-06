Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4B46C76196
	for <linux-nvme@archiver.kernel.org>; Thu,  6 Apr 2023 04:24:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MIT359A0qL+eZ+FWBC5rKDQlsAbE1ZYU4YaCcTCgzew=; b=qalIGkH2U0CFkgiqxpiPtQErla
	bHuCvHIlfU5TldMnNpYxua6CVYJDFrgUXgJbLa2dWb15Fk7b5ofVbzRuGxqfnbemt57UB1d7jv9a3
	n6i5x506d+DRqINYx3kKjFAAi3Cv5ZZ61nDTqfPWG1+TGi418KDBFH7IH1Wg83RMA0LCPG9+IDRzG
	/fSvOiSIPvbQU3J7cMWK2rkyHAT/hT92fR6EsSaFS5E2gyx7wb0hJeHtBwzWt9OKrAzdnR9/lsAlj
	HW+0iVq0OkooFggpjzx86/Ok3CWkbMEY7JFklUCYW6wCPy3ndEu+0iqtYkZ7E1v4m09++qAHyFN0F
	XhWN9QyA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pkHAQ-006InW-36;
	Thu, 06 Apr 2023 04:24:10 +0000
Received: from mail-bn7nam10on20617.outbound.protection.outlook.com ([2a01:111:f400:7e8a::617] helo=NAM10-BN7-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pkHAO-006In5-1G
	for linux-nvme@lists.infradead.org;
	Thu, 06 Apr 2023 04:24:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EDZe9bAAC1YwULlnPmJSP2ONS7IvFn7CHX0hf9ANAYgq5QBAbFfeFujWW4g8r4bMttWSb4E5hl1edlW8+uuMKvYanL0quCTbIlT3E22Rluj7cMXjw2Rt0wwPbkWWPptkNexfBNwY7AYpmVj2bCDYvIMcgAn/7+7Zi/U/AmS5SE2GtE/rlKPoOiApolKcavVkkC4Pa6ZzSpqzQM4RAgHSHBjJYHUqmLZm9D+SWTjt/b5KsrRaOBK4lGs8of0KOvSydhhtycQDThyI19l3AVyHb1qt/LWFuCf7HU4yjfKrcKm8u1lT/HkbADLIuxjJq3sePM9k0Ia8GQBD/yN3kaLRfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MIT359A0qL+eZ+FWBC5rKDQlsAbE1ZYU4YaCcTCgzew=;
 b=D9V7XHffeheKFI7y4STklHvBcKqfpJGJWPBf9z5eFjXETCvjWQDGLDeplpatixPTYoQS/B4/sFdkCT1TGvhoeDqW08x4CNYXVmGoZMqD7oEcYTBGFYPJO6SWMhoET/pFezvGDLV9XfZOxqYuWqbT8iJts2DcZc4iAsauN9dnRdyj0q6AVDt43a16yYPmOvsjJMeVNzpxiLt3mmN/kfWKgvP7vtfxqZ64gtu4n4ndcLHjCtiveqhIVbqjVODN/OkZ5QEfSV6h6mNfnfnGxWmMnHIRE2GX1abdIHYpcbpSAci50Bsa/hu+ZbOIi0cMdRzPZOs6Krnhq0Ig5BRh/0IXTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MIT359A0qL+eZ+FWBC5rKDQlsAbE1ZYU4YaCcTCgzew=;
 b=gPfNFzN+CLWH94PVoBZ1CP/utjPu7C71zxUQTyIwfVqVwzoY+5FWugGbRf1AFAS6ubDHfYDu4Ma36PTa3P08TPCS9swHPqIUFrpBx6081+kMbQo+z6GpSsyxTHrjLIaXTe3omTRyjtea4FktMf/G6VBjii49OzxHmlxIX3jcJbilesDnDXRcjo7qR8Z+P3UatP+J44rWwfigi8mrtT8kL2tONHWJv8s26FyXl6Y0Y8IDmq7t0Uk/f9+ixlvvqe33ex2siIAan3hGDHwQQyDk4Alb9bGDkEw21jKNZ60iChe3+OEQ4DJPQRovi/g5H7Jsyv7lBaMlEezuZ7LAMBNx+g==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by SJ1PR12MB6314.namprd12.prod.outlook.com (2603:10b6:a03:457::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.30; Thu, 6 Apr
 2023 04:24:04 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::9f90:cf3d:d640:a90b]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::9f90:cf3d:d640:a90b%4]) with mapi id 15.20.6254.035; Thu, 6 Apr 2023
 04:24:03 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: "minwoo.im@samsung.com" <minwoo.im@samsung.com>, "alan.adamson@oracle.com"
	<alan.adamson@oracle.com>, Pankaj Raghav Partha Sarathy
	<p.raghav@samsung.com>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"kbusch@kernel.org" <kbusch@kernel.org>, "hch@lst.de" <hch@lst.de>,
	"sagi@grimberg.me" <sagi@grimberg.me>
Subject: Re: [RFC v3 1/1] nvme: add passthrough error logging opt-in
Thread-Topic: [RFC v3 1/1] nvme: add passthrough error logging opt-in
Thread-Index: AQHZZB73WmWax7v1+UqSWD0jbOudrK8ZQ6mAgAQR5oCAAF5kAIAAAwuA
Date: Thu, 6 Apr 2023 04:24:03 +0000
Message-ID: <e6c70d0d-5363-ea0a-6404-70b923ea082f@nvidia.com>
References: <3c11b233-82cc-0ab3-c099-1d6f43e4e1d5@oracle.com>
 <20230331221823.2806192-1-alan.adamson@oracle.com>
 <20230331221823.2806192-2-alan.adamson@oracle.com>
 <20230403082613.owr5wshccoy2uw4z@blixen>
 <CGME20230403083443eucas1p225993f889610c6c070dcb24e232aa526@epcms2p1>
 <20230406041310epcms2p1a4eb5e5201450bcf092cc1a38ae81a8b@epcms2p1>
In-Reply-To: <20230406041310epcms2p1a4eb5e5201450bcf092cc1a38ae81a8b@epcms2p1>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|SJ1PR12MB6314:EE_
x-ms-office365-filtering-correlation-id: f4f145ac-700d-40d7-62a1-08db3656c0f9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  MCr18gR5/8V8DBOlZI19W6ut18N1WrkTEbTpDx8DZLWrXoDacdUjPN28QllfL1KVwmuChpueC90j+xIzH6VoG56kLdbhWenJpD9AZmYfSlmEjL/Hinvf9Ee1/6CmCWNqY1kLbGKYGc2EgSF7363i08KFw4a32UCj3/LnawU5MSVQGK4sBS8ug3puH5+jAFzVmlSwXUSj81tUj6oKIKnaj58x6q+oFNfEjn8yr9RCWXgqvK47pp+V1WJc/QqywgRU4lcIVHp61varGuI+I7l5nM55jeJJZ/ZW78eiJv10F5OWahdWsWyKYlxjZB7Ja+lczTtPFj9pEahD2egW3isc6a/L54RuNXl3fVmwYhIR7tmbrxtuiyrSr+41F8SaMqz3fAGgfTR3Gxb7jLdbS+1SwsruPsZH08uJjANy7Z3BYqXR5lGAKvcdtNbJu0KjnJ4eotcbbwUcZT58iRc5WdReLfMlylAdTLKSDLsdV23lR4J+WP98FsXoGqVbPL1sH5pOnJm/aGn4UwWG/dV6TH9ry1sxZRdmFV7QuB8R2eWoF+/2cYEqMI1JHPPuHtEEQ/YOHl91Xhu5vFtSXDGLpWiHcHRkesIV/0PLcFeDFzgdNR+rGyDT4L3eMcLuUpMP0ZvSut334Ct0WwyexqgzwnFyqLwHU4rs3Xm4t+liEUsBEtbkSz301WkEbigGglEWbDwa
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(39860400002)(366004)(346002)(376002)(451199021)(6512007)(186003)(6506007)(38100700002)(8936002)(8676002)(31696002)(6486002)(478600001)(110136005)(316002)(54906003)(86362001)(76116006)(91956017)(66946007)(66556008)(66446008)(4326008)(66476007)(64756008)(71200400001)(36756003)(122000001)(41300700001)(2906002)(38070700005)(2616005)(5660300002)(31686004)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?utf-8?B?bnc2a0J0S1NrNStSRVhMeFlNNTVPV2tKRWNON0pjajVuOXRXRDNpUXh2SE96?=
 =?utf-8?B?MWxUMkh3UlFNWmxyOU1kQWwwcmRKMGtkV2xhTVRVWkN4dFR2aUFzWS90VzUy?=
 =?utf-8?B?QXFSZmxxVS9oczRKN0Z5SUloaWs3UE5kUzZWemlUd05NSEE0NkxWcVo3Mzcr?=
 =?utf-8?B?ci9rWDR3YzlTbFU1T3JJR2FMNmp5MEg1VjhKb3d3Mm1DYmFhNTdsV2NWYjBr?=
 =?utf-8?B?Um12NVM5MnlVVkNlcTZCYVZ6VVBDSkZSY09XZHVRN0gvTFBhVk1vWTBneXdN?=
 =?utf-8?B?dms2RUpZRnQ1UE5pSVo3aXV6U3dhRUUwQ3BuWnlaOXg4TlFncmlJOHgweWZp?=
 =?utf-8?B?c1VLY09hQ1dYbXplbTlva3dvdTZPMEgrUStHTE1JeURzN0FpWU1Db0FUbFR1?=
 =?utf-8?B?SktnVHpValhxK1RKcldNRWxwWHVuYjgyNGNQU1hRNS94K25rVXhndFNkWktG?=
 =?utf-8?B?YnI3S2NXOTlUSlBFVWNBelpEUGpFMmd5WkNkV24yYTFNc0RXL3M4WFZSTWkv?=
 =?utf-8?B?dFJsYXhNYXZ2eWRhZHUrVFVDRUZUL2JuKytCNHU0L2hOQTJQbjRqNWdNa1pl?=
 =?utf-8?B?U2ZjQ3c1NWUxTlYzNTluS3dacUhJRmtvWVNtaWdZeUxkZjQ1SnFTWWtKQUlT?=
 =?utf-8?B?L3BTb2xwQmhqbmxzMlhVVTRSOGRFdjM4KzA2SmM4SUtjQmI3TWQ0cDJuNW93?=
 =?utf-8?B?cFY3dSt3aFhSY0g4eHJCaE80RDJHTmVJK0t6RVVzMVc3SEFTUjg2NHcyU3Uy?=
 =?utf-8?B?TzhZeDk5KzZvdUx4NFM3TUpqanNEZlZNMnptNVpra0hadm9uWTFSeVRTNWc2?=
 =?utf-8?B?U1puUUpXeXlUelU2ZlBQNkdqdE91L1hKV3Z3ZmlBWm1Cbi8yVWI1c092VElQ?=
 =?utf-8?B?R092RTV1cnp5YXZKT0gwZXl6bmRZKy9TQ0VlV3BJZVk0VDZnaXFLQ3lLZkJL?=
 =?utf-8?B?SHplem44Yms5cE9CS092Q2RycnJpU3E4VTlaQ0JTVnhscUFzdXRMendjUkkx?=
 =?utf-8?B?ZkdwRVZ2S1N1UzAvZzNkcWFCWnk1K1RSN0RjeXZ3TjFPWE9pSVJneXFMRm16?=
 =?utf-8?B?MWF0TjZETDRpMTNabVBpQWVqaXVndS9TMVczY2FlRTVQa1RhWm81S055STBS?=
 =?utf-8?B?UWZhRDlIV3dDcm4zbytmV2M5KytjdUtMbmV2T1FsQ0g2dmNPektSZWJQZkJV?=
 =?utf-8?B?NEpGNHUzVUxpRGhVR09DWWFLSWg4S2JYRW9QSVBoMWl2S3AwN0FicUFOZHVL?=
 =?utf-8?B?ZEM2YXhxVkZVWmpMRmhGaVlZZkpqU2xFMFpVU1VsM3pVSTZMR0Y0b2F6WVNi?=
 =?utf-8?B?TkVjdWJtMTA1ZlBkRERsQ3BiYzBzcFBPRWNyeU5jcHk4SEM3N1ErSTRYeWJw?=
 =?utf-8?B?V2JqUDRnOVpCbG9YQW9vZG1xKzIyY2ZqODhBZUZnQjYzTHhQemM0STlaZVlJ?=
 =?utf-8?B?aVR4NmoxVDVJZG1HdmhNNFZMRVhObkU3aHY4UGZ6LzZtTW96ek9uSFFpQXZa?=
 =?utf-8?B?eWhFTm5TZm5iRzRyRGtxY1pGWkpleXo3a3VXRzRORXBFSHozRlY2SkF1cFJJ?=
 =?utf-8?B?QlQzY3o2UU1kdjZmc2xQUk00SXhxZVc0NlBZWXR2b0JYak15NUdFcWNIdE5w?=
 =?utf-8?B?VkQ1TDhCYVloanBpZkZscldvMXhDdmdVV0Z2S2FSSjJMdDdvWEhDYTdQNXQx?=
 =?utf-8?B?MytiNkRBVTh0RVZrdFhodmVjL0lWaUs3SDYzUTZQK1hQbDRwamxsekRkMFNr?=
 =?utf-8?B?QWViT1JDTEMzeDUyVWNXeGxOOVVKVm1NL1dsaG9UNXkzb2Q0TmhPOE8vVFhK?=
 =?utf-8?B?MWtKTGJHVnowekpBQjl1NVZtVGY4ZzBRQ3NEWm5zejJselpmY21Va3RKNkZP?=
 =?utf-8?B?d2J0OWJ1aENPWHg0Tzg3akJmdW5RaUhvdHI2ZzQyMlpGbFhjNXF6U2E4OSsr?=
 =?utf-8?B?ZDVGTkt5RXpsZmZ1UEhWUGU5NzNYOWJsMEttL21pV29KSkQxUURqcEpCS3VQ?=
 =?utf-8?B?dkdER0laOXg1MkRsRXQvRmVEbVNhOUV4azNBdHBLL0wvemFuQk1sMUdjdkI3?=
 =?utf-8?B?dDNlemRnZDVCQkhIZXIxdkxEZlNGVjRVS1FoSGR4elluSVBtQ1FPSkFYcmMv?=
 =?utf-8?B?Z1pvK1cyMDM3RXQ1TGUxL0FoYTdDeFZRSjloNVVWZHBUMTRyMDhQYkViN2VU?=
 =?utf-8?Q?FywQosFSnf/zyKibZKBaZK2jqTfjl7ww0/EnFzeR+MME?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <73F56C33D9E13245A184CACE92E40F02@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4f145ac-700d-40d7-62a1-08db3656c0f9
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Apr 2023 04:24:03.5362
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 86fpsBV7FnrFN9H0LgSAaUFjPOR3HW62GHZfqm5x/vnIUXvy85CslCnaDIvxiFnpYFhPAfF1LCaozXdQeasO+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6314
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230405_212408_455099_2DA70AA3 
X-CRM114-Status: GOOD (  10.59  )
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

DQo+Pj4gcGFzc3Rocm91Z2hfbG9nZ2luZyBpcyBhIGJpdCBtaXNsZWFkaW5nIGFzIGl0IGRvZXNu
J3QgaW5kaWNhdGUgaXQgaXMNCj4+PiBnb2luZyB0byBsb2cgb25seSBwYXNzdGhyb3VnaCBlcnJv
cnMuIGBwYXNzdGhyb3VnaF9lcnJvcl9sb2dnaW5nYCBpcyBhIGJpdA0KPj4+IHZlcmJvc2UgYnV0
IGl0IGlzIG1vcmUgYXB0IGZvciB3aGF0IHRoaXMgc3lzZnMgZW50cnkgaXMgZG9pbmcuIE1heWJl
DQo+Pj4gYW4gYWJicmV2aWF0aW9uIGZvciBwYXNzdGhyb3VnaF9lcnJvcl9sb2dnaW5nPw0KPj4g
U2luY2Ugd2UgYXJlIGxvb2tpbmcgYXQgb25seSBvcHRpbmcgaW4gdG8gcGFzc3Rocm91Z2ggYWRt
aW4gY29tbWFuZHMsDQo+PiBob3cgYWJvdXQgd2UgY2FsbCBpdDoNCj4+DQo+PiAvc3lzL2NsYXNz
L252bWUvbnZtZTAvcHRfYWRtaW5fZXJyb3JfbG9nZ2luZw0KPiBJIHdvdWxkIG1ha2UgYHBhc3N0
aHJvdWdoYCBzaG9ydCB0byBgcGFzc3RodWAgYXMgaXQgbG9va3MgbGlrZSB3ZSBkb24ndCB1c2UN
Cj4gYHB0YCBhcyBhIHNob3J0IGZvciBwYXNzdGhyb3VnaCBpbiBkcml2ZXJzL252bWUvW2hvc3R8
dGFyZ2V0XS4NCj4NCg0KcmlnaHQgaXQncyAicGFzc3RocnUiIG5vdCAicGFzc3RodSIsIHNlZSA6
LQ0KDQovc3lzL2tlcm5lbC9jb25maWcvbnZtZXQvc3Vic3lzdGVtcy90ZXN0cw0K4pSc4pSA4pSA
IGFsbG93ZWRfaG9zdHMNCuKUnOKUgOKUgCBhdHRyX2FsbG93X2FueV9ob3N0DQrilJzilIDilIAg
YXR0cl9jbnRsaWRfbWF4DQrilJzilIDilIAgYXR0cl9jbnRsaWRfbWluDQrilJzilIDilIAgYXR0
cl9maXJtd2FyZQ0K4pSc4pSA4pSAIGF0dHJfaWVlZV9vdWkNCuKUnOKUgOKUgCBhdHRyX21vZGVs
DQrilJzilIDilIAgYXR0cl9waV9lbmFibGUNCuKUnOKUgOKUgCBhdHRyX3FpZF9tYXgNCuKUnOKU
gOKUgCBhdHRyX3NlcmlhbA0K4pSc4pSA4pSAIGF0dHJfdmVyc2lvbg0K4pSc4pSA4pSAIG5hbWVz
cGFjZXMNCuKUlOKUgOKUgCBwYXNzdGhydQ0KIMKgwqDCoCDilJzilIDilIAgYWRtaW5fdGltZW91
dA0KIMKgwqDCoCDilJzilIDilIAgY2xlYXJfaWRzDQogwqDCoMKgIOKUnOKUgOKUgCBkZXZpY2Vf
cGF0aA0KIMKgwqDCoCDilJzilIDilIAgZW5hYmxlDQogwqDCoMKgIOKUlOKUgOKUgCBpb190aW1l
b3V0DQoNCg0KcGFzc3RocnVfYWRtaW5fZXJyX2xvZ2dpbmcgc2hvdWxkIHRvIHRoZSB0cmljayAu
Li4NCg0KLWNrDQoNCg0K

