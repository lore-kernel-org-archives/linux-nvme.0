Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2070EC77B78
	for <linux-nvme@archiver.kernel.org>; Thu,  4 May 2023 05:23:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3CFRfQeqxvdLxTO0HcRTRCUHmL615hww/BAKzUsK3Yc=; b=4Ku2j5zpIMgUYbLUNdDxpIeyGa
	CyrhaZ0+iZGtWi7WD0dOie5F/bH6Tm6EgfLm/S4+zlgcQgtE2Mv9j1sSCtzpbFXxgFJR7KlWSP4Pl
	YtiAFWrObGqFtLBqaIRnPbBlViuGk4AQjAp8YpD1D9oCd8p3rGrmwZUZ3itMPQR7S5ouCgbI6PY6i
	u6udvfDDKUVILfgMQPQS4XJHkC3GgNuw8grgCkgaBAoMFfJ6H/HAhOobtLnnAv9lDrtoCtXk/jDM+
	fnfAX5IEqKJWaJezmWNi0sGXoYI/skbPRPPkTXFjafsjo6munZeq2C3Ow5xIoW1OwawNzxPqaclq3
	2MM7n8Ow==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1puRRR-006dfh-0U;
	Thu, 04 May 2023 05:23:45 +0000
Received: from mail-mw2nam04on20600.outbound.protection.outlook.com ([2a01:111:f400:7e8c::600] helo=NAM04-MW2-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1puRRN-006df7-1q
	for linux-nvme@lists.infradead.org;
	Thu, 04 May 2023 05:23:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OXZ7YYRSeZ2CHBbR5YZDvtLiaijPq/0kzlWq5CqU5CZ6Zt1KIoMBryCq2xiFIhTdmL5pJYM0lILNibVTgRgPB2tbemspVSqwjETTNOUJbOdvxBFVkBIsYF3vOxHmrrUaScMvdmszoBzHSnOKuqCCne0ITCU6UoCHWWzEFappZr4FiF/8GI0ZdG6izH6AnGfGh1ldg1pxQkIAqopxRCPPuAvxWZ0whTTafMnsgOstt7SQByScGlPI4e0wFmBmvqurz66fT+9C3heYey3fX4GmhYZP6/fWjdn7jPTBnPaqK0KacTRw0lwIxtKh2RwDaHfSIHTcRx10s+Q71FrQuo4Hhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3CFRfQeqxvdLxTO0HcRTRCUHmL615hww/BAKzUsK3Yc=;
 b=njwzCydyTvOJ69l1Wul6CmWPYEofSy0HQk0ec32W2fYMhdduhsWZZlEsAVPcFEVYnfAChfr7tv9gyt6HczZBJUtdro9vrs3ihF/GK3M68p5GmM3kd4obYjJY3utD3d4aXB7Z+MM6Vuj68KoPwj5Q0rd3wOkt9rSRXbHxgPm63oi5Cnydg5Md/KwmYEAbwgtSqI0XwkKFWHnEm7XWoNUi1q5FyLmO1uFMeUj8GKBPb0qucCSkYZfEcAlHVlHtqt53OcLUw2nMCb5EwmcrjTlDaXqnwI1v8983vCp6vVfEXm68KZ2D4EOYsZ2lmEVnRlsZNAV6d5styNgVrF7HhPDN3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3CFRfQeqxvdLxTO0HcRTRCUHmL615hww/BAKzUsK3Yc=;
 b=ZJ/7X1wRfqzBvm/kL9HWJjMfeIZF+gRgelNewup1vriP6gHD3U3WfdSBo8y925dE5lt4N/+AtBUSvWvNEluwNj2V5ZmYF6P3aNeqnuPAsIjBAjqkpDWfR7NeDKsPRC49WCL1OgTIefMxjW9aFpbe6r6VIPTYJ/awBW/pbfPJ1JOVzDjk49uUkymp+Qyk6XDrOT3PyUzsqqgNJQ+NWCT+3EwkxN4c/wCEuUoR5DINisELu8GzqcPUdx9pkeX5hvYR7vpPmmiXDkEekwI7nrVKXTBzAfx9jG7hwdCdHJgMb/sTY+u5O8+6UeoXqovnts8KJtlujxUHPlT3/LLA+HgRwg==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by CY5PR12MB6275.namprd12.prod.outlook.com (2603:10b6:930:20::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.26; Thu, 4 May
 2023 05:23:37 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::6922:cae7:b3cc:4c2a]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::6922:cae7:b3cc:4c2a%6]) with mapi id 15.20.6363.022; Thu, 4 May 2023
 05:23:37 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Sagi Grimberg <sagi@grimberg.me>
CC: Irvin Cote <irvincoteg@gmail.com>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>, Chaitanya Kulkarni
	<Chaitanya.Kulkarni@wdc.com>, Keith Busch <kbusch@kernel.org>, Christoph
 Hellwig <hch@lst.de>
Subject: Re: [PATCH] nvme: Fix memory leak in nvme_init_ctrl error path
Thread-Topic: [PATCH] nvme: Fix memory leak in nvme_init_ctrl error path
Thread-Index: AQHZfdFXdlfIMKDBbEyVCJAfcvh7La9JlYWA
Date: Thu, 4 May 2023 05:23:37 +0000
Message-ID: <581f5ee4-7adf-fea7-54cb-11a56e3f082c@nvidia.com>
References: <20230503150925.863308-1-sagi@grimberg.me>
In-Reply-To: <20230503150925.863308-1-sagi@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|CY5PR12MB6275:EE_
x-ms-office365-filtering-correlation-id: 16be2fe5-2a5a-4130-1702-08db4c5fb6cf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  EUFWhQcc6L9o56BQPU3uLT4KUW7/BMXwrTXb8rtG5W0Ncm1kc2I3wTqlYhaFp6k23cmCCiDwEJFI//DPSm9lc02iUQ3f8rPx0shlMrKZ26+JEa1hyJcG+HonNmPH8im6UNKFsxr4lh/RauBK6w4lLrBImXOq7nr9LgLHwlS4/5diVAkAhcrNrqueT9YP+xLIYIC4PvbuJpCdaoMOil+wbULbqKaqVWvEGoM+ElbgSNF/bjHitlpYBDuCbSDsJi53LgQumx6KYbJqIpsFC4h5E15ju9T4Ztk+Uuzkhk1s56oOSyy8HnIxFTzCvRHSYaRuN4vyN9FGDvZ31YpquUuqaKXfpLIx11eEWt23SL5ekIxJlvybI1k3p6DBCmyBLd40Y7qfZwxhKjihuRy4LfyQgm8jWTciaIM8XITOpNCqqvii/GeyKaZC4RCGmv9DeL8XKxXhC2/snRE5U0lcLMTAk610+DObQl1cg8fxFTPfVkiXQfTD9AUpcpczqv/jhbK93ZU/m7rKx5L4m2m9MylUwaVqtHn19LkbM98MRrA50bTAlUZzNdk1n8cO2aPqs0BqOA45SwsH2VlKTlZh0wbqDd6N+ndsvyoAsHd4gjnxkaDKWDVNPwAEz5lAEh+sARYrKjSIbOrx9i5jZZKL5AYx5boybjY4bcoNflsmRg832cqRcpz/xLZdLj3Lzx8JV+Au
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(376002)(346002)(396003)(136003)(39860400002)(451199021)(66446008)(66476007)(36756003)(4326008)(6916009)(66556008)(64756008)(76116006)(91956017)(83380400001)(66946007)(6512007)(6506007)(53546011)(186003)(2906002)(66899021)(31686004)(54906003)(478600001)(2616005)(38100700002)(8676002)(122000001)(8936002)(38070700005)(31696002)(86362001)(41300700001)(6486002)(71200400001)(5660300002)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?utf-8?B?K3FoeHZaU3VydmppTld4NU5jZXRKd0tLOVBPSjc2RFZFTFBNUHI1c0FuS1cx?=
 =?utf-8?B?WHFhV1FjdTNTRUU2YTZlckxYd0N5S0ZOVmpGLzRacWI3amFPblFWVS9ncHU2?=
 =?utf-8?B?RE4xNkcrT0Y5ak1pRk5Jc1pLTUNEMTZWSFp2MCtMeDRDWi9FSzZvQWpyQyta?=
 =?utf-8?B?UzlCdmRHSkpKeFFUNEVaRWRrT3g0T2t2cEZ5eFYzUjZiVFZUS0l0Z1FrSDdK?=
 =?utf-8?B?ek5XYmY5VzNBSjNmV3M5UkNRUWJicUw1SjdmSVhCUldWUDJEM3czYVFiWnRN?=
 =?utf-8?B?S0tzR1g0czZYeTQ4ZjIxUklqSDdGa05RQit1QXErcXpOaTNnMVVNeEpNS1h0?=
 =?utf-8?B?SDJVOEMrYyt5Ym5VdGJxMERXRE9WcW85Zkw3U0JFTXJvOVovaUNtcmhUSkh6?=
 =?utf-8?B?N0UrWWRGdlljamtQZkMrVFFCd0UzTGUxZWYxNUswRWhCZFBPczFCTldwR3RL?=
 =?utf-8?B?L0NMUjhFZHphOWphS3hncWNRaERwQzVXYlBKZkFHaisvK1Q0MkdMQVovL3ZC?=
 =?utf-8?B?RlE1VlVMbGlQemJ3aWNjYVJENkhVbmlhQ2owNCt2VjZXYWl6bGFEVTFwNFg3?=
 =?utf-8?B?NkNmZ3k4N0krUUNoWWQ0ekM0Q1dIeUFoRWJOcFNpcU5iSlp4cDdHbHE3dmZC?=
 =?utf-8?B?REJpbGtHWDNEUWd4YVJWcGtvVktWNzhlc3NabmI5a09qWkxWZkRFOTBQa0ha?=
 =?utf-8?B?aXVHeGQwS3FqYmUveGpLVDU0VTQ1QjNuWXZRK011TU1rZ09rWmxYSmVsdktn?=
 =?utf-8?B?WDU4d2JmcE14RWd1QmxCelEvUEZscWJtVCs3VVRSRGR3c2FCbW9KWmlKckFO?=
 =?utf-8?B?Rlh2ZWpHSWVQTTQ2RFp2RU9zd0FlY3dwTWVZU0dEb2F0emNjcnBZNDZMT3Bt?=
 =?utf-8?B?VWtiN0V3S0Q1VHNXWGFXZlp6T1FxM01XYnJjUldMSWl1dThHdDFOazJVYzVr?=
 =?utf-8?B?S1BjcDR6ei9CUGo0V25zUThjSW5RTXF0aWFIazd4NmFkTXY1bnlBWGIvNUpT?=
 =?utf-8?B?UXE1eXpUT1k4L0ZSZy9LdW1GMHNqOEFOZVZIY3hmMWtUNWFkY0V3QmhyUXA1?=
 =?utf-8?B?MGtER202ZW16QWo4bjdkajh5aDRhM3E1YUlIRzRRSjhLeENqb3haUGlLV25H?=
 =?utf-8?B?UmlYdmNzbGhGdU1mLy9nRldCQTh3QXNQcDYyZDZ3VlFOQitIeUlNOTk0ckpQ?=
 =?utf-8?B?SmFuQUVsVDFjemZBZWRjQnI5MDg2Mm1LQmMvU2c3U3grdFZXWkxmb1R0L0Y0?=
 =?utf-8?B?bTNoQUMwaHQxTWNVTjhXbnk0a3RMWUM4V01DMHhaSkhLSDlHa2tqUmIrTWFB?=
 =?utf-8?B?dWQzdERJKytLbFF0RUVFQzVpRUVPN3cxNVJGeDVqWG1PV3llcGlYS21KZDBB?=
 =?utf-8?B?OFplZkJmUmpoeXN3L1MyQ0lGVVJ1Qk5MSGFmRXM1YlZueC8xMmphVGtNb3Yw?=
 =?utf-8?B?ODNjYm01MXFxemNhL3hpd2QraFVQbjRKRFU2cXRpQmU1aWlrU0t3VG5PQ3hk?=
 =?utf-8?B?czJBOVJwNkhZN0haWWJEYXlpeW9DWnFQOXkyRkoxQmFvUzgwbTBIZlplNy8y?=
 =?utf-8?B?OS9GT2NsS3l2ekZMREdrSlFiNEV0N29sMWc1WmtQdTZVM3lFc3NrR1paUU5M?=
 =?utf-8?B?T0crYm1XRTcvVnlFMVVaOTV3QWdDTVhwRVhTNjFtQW81ZnBVaDJiSEw2c0FH?=
 =?utf-8?B?N0dMQUdTNXZod1dhbWxVdmVSejgza2c3dXQrZ2VRUUg4VjRiRjRiQjBDMWZW?=
 =?utf-8?B?b0pyTlNlaTdKTDNJOEp0L0NKd3NFVkNZbU1HRVpSc3VJbEdsS3lDVkY3RWw5?=
 =?utf-8?B?dmRYOU84c3htZEg4WnNxdnlycDZQbU5abjk1L3NYNm5CUXZoRXA5SmE0ajEz?=
 =?utf-8?B?UTRlYUFSeGpNeGRNZFNKQUtsd3ZZWWpUOTM5NFdjWk1DU051SFlSb2pWTndE?=
 =?utf-8?B?aUlkNlExeUhyckNtbTZvemtHcEVUYmVrNjZWYUdpTy9UZ3V6TUpVVkJpWGpZ?=
 =?utf-8?B?Y2VYNUJQbEx3dGIwTFlXSWxWQTEwQmQxb2Z6bFR4L1FWVStsSmZjN1F0alBy?=
 =?utf-8?B?Q05Rb2xCdjBxTmhwaFBicnkzZ3lYT3FaSkV6ZTdRaTFKQTNrekFKaEZoWjh1?=
 =?utf-8?B?VUtmc0Iyei9sU2NCS3JuMzhoYzNVZkFiTlpkVmNXL1dFQ2FMOWJJUURPU3c4?=
 =?utf-8?Q?qScxkiWgtaeIxy008Feooe3HTnurqc/x0ku23zKfY25L?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <956419E084CC5545BC4ABEF87772DF5F@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16be2fe5-2a5a-4130-1702-08db4c5fb6cf
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 May 2023 05:23:37.5288
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hpfKDCqhK0XFCdkhUL1No305hPKIPEy7hgc5wSMZ1uXLnPQHyoTkuVccDbRv7n/Z8QvSbulrBiE7u/Sgniwuag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6275
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230503_222341_615014_1E7D55F6 
X-CRM114-Status: GOOD (  19.88  )
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

T24gNS8zLzIzIDA4OjA5LCBTYWdpIEdyaW1iZXJnIHdyb3RlOg0KPiBudm1lX2luaXRfY3RybCBt
YXkgZmFpbCBiZWZvcmUgY3JlYXRpbmcgdGhlIG1pc2MgZGV2aWNlIG9yIGFmdGVyIGNyZWF0aW5n
DQo+IHRoZSBtaXNjIGRldmljZS4NCj4NCj4gSWYgd2UgZmFpbCBiZWZvcmUgY3JlYXRpbmcgdGhl
IG1pc2MgZGV2aWNlLCB3ZSBqdXN0IG5lZWQgdG8gZGVhbGxvY2F0ZSB3aGF0DQo+IHdhcyBhbGxv
Y2F0ZWQgYmVmb3JlIGFuZCByZXR1cm4gKGFzIHVzdWFsbHkgZG9uZSkuDQo+DQo+IElmIHdlIGZh
aWwgYWZ0ZXIgd2UgY3JlYXRlIHRoZSBtaXNjIGRldmljZSwgd2UgbXVzdCBwdXQNCj4gdGhlIGZp
bmFsIHJlZmVyZW5jZSBvbiB0aGUgZGV2aWNlIGluIG9yZGVyIHRvIG1ha2Ugc3VyZSB0aGF0IGlu
dGVybmFsDQo+IGRldmljZSByZXNvdXJjZXMgYXJlIGNsZWFuZWQgdXAuDQo+DQo+IFRoZSBkZXZp
Y2UgcmVsZWFzZSBhbHNvIHRyaWdnZXJzIG52bWVfZnJlZV9jdHJsIG1ldGhvZCBzbyB3ZSBuZWVk
IHRvIG1ha2UNCj4gc3VyZSB0byBpZGVudGlmeSB0aGF0IHdlIGZhaWxlZCBkdXJpbmcgdGhlIGlu
aXRpYWxpemF0aW9uIGl0c2VsZiBhbmQgc2tpcA0KPiBjbGVhbmluZyBiZWNhdXNlIG52bWVfaW5p
dF9jdHJsIGVycm9yIHBhdGggY2xlYW5lZCB1cCBvbiBpdHMgb3duICh3ZSBkbw0KPiB0aGF0IGJ5
IG1hcmtpbmcgdGhlIGN0cmwtPmluc3RhbmNlIHRvIFVOSU5JVElBTElaRUQpLg0KPg0KPiBXZSBh
bHNvIGRyb3AgdGhlIGV4cGxpY2l0IGRldl9uYW1lIGRlYWxsb2NhdGlvbiBiZWNhdXNlIGl0IGlz
IGZyZWVkIGluDQo+IHRoZSBkZXZpY2UgcmVsZWFzZSBzZXF1ZW5jZS4NCj4NCj4gVGhpcyBhZGRy
ZXNzZXMgYSBtZW1vcnkgbGVhayB0cmlnZ2VyZWQgYnkgYmxrdGVzdHMgbnZtZS8wNDQgd2hpY2gg
aGFwcGVucw0KPiB0byBmYWlsIGV4YWN0bHkgYWZ0ZXIgbWlzYyBkZXZpY2UgaW5pdGlhbGl6YXRp
b246DQo+IC0tDQo+IHVucmVmZXJlbmNlZCBvYmplY3QgMHhmZmZmOTU2NzhhNTRjZDAwIChzaXpl
IDI1Nik6DQo+ICAgIGNvbW0gIm52bWUiLCBwaWQgMTk0MSwgamlmZmllcyA0Mjk0NzYxNTk0IChh
Z2UgMTAuMDEwcykNCj4gICAgaGV4IGR1bXAgKGZpcnN0IDMyIGJ5dGVzKToNCj4gICAgICAwMCAw
MCAwMCAwMCAwMCAwMCAwMCAwMCAwOCBjZCA1NCA4YSA2NyA5NSBmZiBmZiAgLi4uLi4uLi4uLlQu
Zy4uLg0KPiAgICAgIDA4IGNkIDU0IDhhIDY3IDk1IGZmIGZmIGUwIGI1IDdiIDhiIGZmIGZmIGZm
IGZmICAuLlQuZy4uLi4uey4uLi4uDQo+ICAgIGJhY2t0cmFjZToNCj4gICAgICBbPGZmZmZmZmZm
OGIzNDkyMDU+XSBrbWFsbG9jX3RyYWNlKzB4MjUvMHg5MA0KPiAgICAgIFs8ZmZmZmZmZmY4Yjdj
MDQ2Mz5dIGRldmljZV9hZGQrMHgzMDMvMHg2OTANCj4gICAgICBbPGZmZmZmZmZmOGI0MTAzYzQ+
XSBjZGV2X2RldmljZV9hZGQrMHg0NC8weDkwDQo+ICAgICAgWzxmZmZmZmZmZmMwZGUxYzQyPl0g
MHhmZmZmZmZmZmMwZGUxYzQyDQo+ICAgICAgWzxmZmZmZmZmZmMwZDc4OGIzPl0gMHhmZmZmZmZm
ZmMwZDc4OGIzDQo+ICAgICAgWzxmZmZmZmZmZmMwZDhjNjZkPl0gMHhmZmZmZmZmZmMwZDhjNjZk
DQo+ICAgICAgWzxmZmZmZmZmZmMwZDhjODMxPl0gMHhmZmZmZmZmZmMwZDhjODMxDQo+ICAgICAg
WzxmZmZmZmZmZjhiNDBhOGIyPl0gdmZzX3dyaXRlKzB4YzIvMHgzYzANCj4gICAgICBbPGZmZmZm
ZmZmOGI0MGFlZmY+XSBrc3lzX3dyaXRlKzB4NWYvMHhlMA0KPiAgICAgIFs8ZmZmZmZmZmY4YmMw
ZWI1OD5dIGRvX3N5c2NhbGxfNjQrMHgzOC8weDkwDQo+ICAgICAgWzxmZmZmZmZmZjhiZTAwMGFh
Pl0gZW50cnlfU1lTQ0FMTF82NF9hZnRlcl9od2ZyYW1lKzB4NzIvMHhkYw0KPiAtLQ0KPg0KPiBS
ZXBvcnRlZC1ieTogSXJ2aW4gQ290ZSA8aXJ2aW5jb3RlZ0BnbWFpbC5jb20+DQo+IFNpZ25lZC1v
ZmYtYnk6IFNhZ2kgR3JpbWJlcmcgPHNhZ2lAZ3JpbWJlcmcubWU+DQo+IC0tLQ0KPiAgIA0KDQpJ
IHRyeSB0byBhcHBseSB0aGlzIHBhdGNoIG9uIGxpbnV4LW52bWUgbnZtZS02LjQgaXQgaXMgbm90
IGFwcGx5aW5nLA0Kd2hpY2ggdHJlZSBJIHNob3VsZCB1c2UgZm9yIHRoaXMgdG8gdGVzdCBpdCA/
DQoNCm52bWUgKG52bWUtNi40KSAjIGdpdCBhcHBseSBpbml0LWN0cmwtZml4LnBhdGNoDQplcnJv
cjogcGF0Y2ggZmFpbGVkOiBkcml2ZXJzL252bWUvaG9zdC9jb3JlLmM6NTEzNw0KZXJyb3I6IGRy
aXZlcnMvbnZtZS9ob3N0L2NvcmUuYzogcGF0Y2ggZG9lcyBub3QgYXBwbHkNCg0KLWNrDQoNCg0K

