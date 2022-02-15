Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65B09C433F5
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Feb 2022 17:04:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IrH2zNc9KG4s8HCumZrX+WQGq0YwRlxR3DS0iCbszLA=; b=DEv4tMgPX+wa3aR/UPB34Xnj7+
	Z7WmUY6lo4n4sXi4snhYH20LR0I7Sn93UvaTlg6hlCiLHBnk/cay82BWs4kr+icBU5RqBTtPTT88N
	6CCDjagYWdV3i0q9VoROD9u/UXz2qTzesI7lEWWoSSj8ive83fego45EiJZREId7pa1LDZ/OrcA8i
	cLNwPpyUIgZLaEqIb+3oJKX8sPuh6BKh/VmhTp3TI5+0AHszP1H1yzzfw9taNMWwG3mu9MGl9g+Av
	hHn6JCu7XcIxWbI4umiklOJ6jLaEVMHV+nMW/95OCnXCPw2eLPYA8LC+S709OlxoeoTegJrjguxXg
	oulX6r6A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nK1Fc-003otW-Jf; Tue, 15 Feb 2022 17:04:28 +0000
Received: from mail-dm6nam08on2060c.outbound.protection.outlook.com
 ([2a01:111:f400:7e8b::60c]
 helo=NAM04-DM6-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nK1FY-003osO-Sn
 for linux-nvme@lists.infradead.org; Tue, 15 Feb 2022 17:04:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=anLyrrh6Qhf561NYFtyuiWmApncJnmN4+z4wLuq+wCzyB/h/GiyfGTQpjD4FkJBWzIS15vZ6HKxGyw8WkZYOpqRacCB4Fe0vKdQoB2RkbU3ycIgLiUBcp7/3hGO1qTypsB/mTDP0ybYRIcljg8q4nftdtjm9tKT6ErxmQeOvXxS3vPfEZIHYTLrtQo2f0QobBa4dIXpHmCTCf6h+NxEnXBIRs/AlLO3UepoZySFVCg1e91eYxkD1n2pduVQbJmckmlhRek7KT+pBmFN+KsBh2ifn3ilu1imLwebwr/TcNgSyeygWJg6WXc9wzM2lqdy6vaSB1n9Rz4LAmBEzKYXnPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IrH2zNc9KG4s8HCumZrX+WQGq0YwRlxR3DS0iCbszLA=;
 b=kB0c3j8RmZGWhjUMkJ69XJXClb3/ylQqVbqAgZP4RtoAQvk+UgGSbFDMeudisGJH0g9q21NXJTX1o4XzOWXqrchzh1N+UC6k71j/XzyV9EZPNyBNctnqo9uDvl6PROyCMN6aHqrKyD2gqQGGTKCgu0bp23jXbow6oytUoVu4U6cTjCeadN6goc9S78+KrYhlnCoLhYK2LF03FFZnfg5Qk4xK4KpFby0m9Amv/0OHF2OuWwO1/gjgYaSnsc7uAsQ+SPxKyZsThHm6jBED1Fftl8Kv3KrJBQCuiw2CW7t2n8o/rLWw0f5wXppWhrz1I/P2AvZTLhMpc56AxKGSYJtzQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IrH2zNc9KG4s8HCumZrX+WQGq0YwRlxR3DS0iCbszLA=;
 b=J9WQZdLk1vLl8PxJ+BSboixXI/cWsZv7BVoxxS0hOX1OBvDAvUsLXnVJK94AgwhIPMRk8Oe8Nn+NfSFSNsXVQxqGzjO0JAOgOl/c5pTIneS8L+/SdsGYEJ/UENkoPMZgZjzsMvZAJmUGk5vplzNNZXDRbXUYa+T8klVaxGGjI0jzFh4v1KQo4b9vy7kYJstRUgyf7l0LeAlhKbmIuGf3VO54mC/pMyYhgNl1B6z+AzFJeho/8oP5wwstecXZXl9dcqfWA6/J8a+JtMRK2JN+9mxMFon98ry7gD5/DcT3Fdu7WEOjQ98aLI+ZAq48ZssP3lufdw7xJIwmBiz5c3judg==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by BL1PR12MB5047.namprd12.prod.outlook.com (2603:10b6:208:31a::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.14; Tue, 15 Feb
 2022 17:04:20 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::846c:d3cd:5a30:c35]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::846c:d3cd:5a30:c35%5]) with mapi id 15.20.4975.017; Tue, 15 Feb 2022
 17:04:19 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Keith Busch <kbusch@kernel.org>
CC: "sagi@grimberg.me" <sagi@grimberg.me>, "hch@lst.de" <hch@lst.de>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, Jiapeng
 Chong <jiapeng.chong@linux.alibaba.com>
Subject: Re: [PATCH] nvme: explicitly set non-error for directives
Thread-Topic: [PATCH] nvme: explicitly set non-error for directives
Thread-Index: AQHYIn1nH1NWmUCEUUGLNnwgKEHlV6yU1ymA
Date: Tue, 15 Feb 2022 17:04:19 +0000
Message-ID: <312922c0-e780-dc81-ae6a-ecdcc24378f4@nvidia.com>
References: <20220215150308.1902842-1-kbusch@kernel.org>
In-Reply-To: <20220215150308.1902842-1-kbusch@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d4638e45-077f-4cbc-e934-08d9f0a534eb
x-ms-traffictypediagnostic: BL1PR12MB5047:EE_
x-microsoft-antispam-prvs: <BL1PR12MB504781E757BAEE1E8360C726A3349@BL1PR12MB5047.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Oux9gbIylf+0G/RYQa0PYky7ft98r7QssbiK+khp+ZOEfcFpblTFyYXCfQO/Yo/wwBPtNvhcMyOLoFRQ5q35d//9BqLOFSRYdL8Jt/L34w5llYmSogfCwwevGV6Y9e6Kw8zjeo+52aUAH95paXum8v/cOqiM9ZZty6scFXOTx7mgR9ypHX27qY3I7H/h4xu565hkw8ibtC4KbEOTOx8cNjABwUZ+uFRU0Ib78cs/lLj6yShBXpbsfPzEL1WGWrNrUCL61URzeynu9tlEhPyIBiCC3ky6FlY/aPFSaJEi86mfd1kTUca/KCoKI8Z8FakQGqlDeQXb2SscewQzQtAddVME0y7DJg47bU9RE1hHYOQtoUSjL2Puq6WqKoY7+7AWMUO1AzNGG8XF7n4HOSR362qrS6l+CHwv+rdlTsz38jZ/FM+U03wN9UdfYziRcxzTD0T39N4obtNPqSZHnPYd7Ek2MQonSpyRK6PRrLIBwfGLHKwt+gYroyZ3GhyQfrRptGipqLx59gMCvC+qCQcayKVA8ZlbAd/4Gt4vR8r1On26H1b89kldmUhlN34m1cK6sgfhzqw0haLZGKhMPLCTnux2krUK9t6OSyugn7algqk3FimIDaTI5GErxTPN5z+S7JUg7DsqN4LddOTCcJi2kPkhb/+dF1CmzKZQyXPuFc+YoO7CGGsrI4JWR2PaKV41pn84QaSj0rvl8MJ08NbJsdh1q14Ec6Zg96kqWo0EuAEGi69zEzkoAHHDZP+P8A4iT8MBrFks8YWcousgLDW/7A==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW2PR12MB4667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(6512007)(6506007)(186003)(71200400001)(38100700002)(53546011)(66446008)(66476007)(66556008)(66946007)(2906002)(64756008)(2616005)(8936002)(4326008)(36756003)(4744005)(76116006)(31686004)(5660300002)(91956017)(8676002)(54906003)(508600001)(6916009)(316002)(6486002)(38070700005)(122000001)(86362001)(31696002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cnBhTU5pUDFZZTA0N2t2Tm5LSEhMckFZUTJBN0E4bU56UGxuYUNZUGZ5c2VS?=
 =?utf-8?B?L1NhTUFjTXkyUjMxTVFFT0N3V1JWbHRJZCtxWjNIaGN5VGNEZStsM29USGUr?=
 =?utf-8?B?MVF2Rkg5a2N2akZ2Wi92QTA2NzVQVHArbTV3SlVmWlhQZlUxbi8yUit4bkxF?=
 =?utf-8?B?dnNQTzNKcWplbmNMT2tEQlFJWEJMM0NZZi81eC9yM3I1U3BhRSs2ZU9yVHBx?=
 =?utf-8?B?cUY5QnB5bmU0RTFuL0YrNzJsZCsycWxMMkNsWmtOeDUyZ1NRd1RhUm56OGRY?=
 =?utf-8?B?eERRb2hZRnVNbnF2WlQvci9LZllPUEtxZ3NCZzBpbHV3ejJaNnBGM1VxcG1F?=
 =?utf-8?B?aVY3S3czS3owOVJZNU1jM3ZsYlY5ZGI3Tk94WDZMNkRsWDJ2bm8yZDZoTnYv?=
 =?utf-8?B?bFZkaWhOY2haM0JSWG4vMzZJcmVQRmJYL1l5UTR6ZzFSSWFVOVllZ3JBNU1F?=
 =?utf-8?B?QndVN0ZPKzBUVHFHekQxanhPbmZKVVAzemVseDZnUTIrLzlkUG5PUlUvT1hV?=
 =?utf-8?B?UmkwT1hCdE43MXBGS2xaOS9Fck11MVJKUWJJT2JKanlmcll5L0l0cTlSc3NQ?=
 =?utf-8?B?M2dMc2YxTmxpYnhMWEdTN2NJems3Uk4vNjJLSzlhaUhycHFCNzJxajlOVHZq?=
 =?utf-8?B?UTgzTEM0RmFwZWk4TWVnWFl0UWc5MGVoWGhVeTgxMHIxbk14M2wrWno5VXJ0?=
 =?utf-8?B?dlVZQUprQ0xNY3RISzM0YW83eTVrTmYvYkZpMDdDVkFiRGlHYUlUazJoNDl5?=
 =?utf-8?B?bzZZbElFVVMzRFR3cUdYWUdCL2xiU0QvV3pXTG9oQVo3Z1kzeHVVRk5MSzdq?=
 =?utf-8?B?OEVTeTNnNEZES1R1d3c1UmJ0dUxDQUQ3OTlhc1B5alBjVWFqR2NpK1hBVThU?=
 =?utf-8?B?ODFhVFZiMXhHQ1M1TVVjUWdKYmh5djBmODBHVWRpT205bHc2eFB3eDBsaE1D?=
 =?utf-8?B?OERMcFVGVjI5Yk9VV3hOVS9aTTdhTFQ3T0dpOXFqekVpaklVU2wvMkNOM0Va?=
 =?utf-8?B?a0NJNFcwa2g1dDJoOEc0OU5CQ3ZOWThINFRHN0JQRFF6MmovZjlYTHVmVU1Q?=
 =?utf-8?B?aE5qWDI3cUlXVGl2QTFkYkp6N2RGRXBpUlVPRFJQT1ljOUZDaksyc3FGSGNo?=
 =?utf-8?B?dWhwRUFNdmppc0Y0bG53emMvRS9Cb2kyQnpKbVVmQ21abzZYeWgrNEJPeVpz?=
 =?utf-8?B?NEdRM09IRXo1NlhvQ1ppSlkrTmJPSFpQUUpCMXZ0MSs0UlJNT0dzTkhUU3pP?=
 =?utf-8?B?MVFwYXRoODlzQXhVQU85SDQrdkJmWGFlM1lvaENzY09BYXBXSEI3bnc4bTE5?=
 =?utf-8?B?cFliMHdZbnFDK1ZMMi81TWx1OGpIU3owV0Fma1plaTQ2bjE1blJtbGxuRC9m?=
 =?utf-8?B?MEFob0ZWZHk1SitTQzMyR1ZjQjFvUkYza1FaVURCeGVybHhicVlKVnhxVys3?=
 =?utf-8?B?UnAzek1POUk1R3NDcDdkUjVLWXc2QW9pS01SY3BJd2VjSTdZUXUvOVB5NGFT?=
 =?utf-8?B?R3kvVGwzTklxbnU1cHB4SzdHRU9Xd2h0Sm82d3J0YlJySWhPU0I0citJN3R0?=
 =?utf-8?B?eDF4cHg0WUl0bDBLbjBzenRtcmZjTUY3cVZkQVR1Nld2dkpjeEM0N0I5MXl1?=
 =?utf-8?B?MEw0UlkwUENYeURNMDlrejUzd09RWnl5MEQzT3lUWG5rcVFlbU5WdHJCZTda?=
 =?utf-8?B?T1JUajFUV3kvek1zUGJQSGg2MThZOU14UEJYS2kxaGhPZ3luYnV4T2QwbFAy?=
 =?utf-8?B?MjNUL2sxL3BOK2IrUHUwaTAyd0lOaGozZVQ3em9TYWhqTjNQNDNKb2tlWEZE?=
 =?utf-8?B?U0N2TWhpUTIvYk1XdjJSWjhmL3lTUGtlVVhvUGNCMGVBTWhzOVZydURLSjRo?=
 =?utf-8?B?Tk5jQys1Rkg3V1JSekZCY1VVdmJRNTZ2ako0YUhVVkhoU0pvbE9RRjBJUk9k?=
 =?utf-8?B?cUR5OU9jd1YyUnBaOXdueTM4azU3WnJkbk1wbDBuVlBVamV0TENYTkhOK0x0?=
 =?utf-8?B?blp5YmVmdmZOY1g5ZFd5RnNUS2xHc01hTTg0aitIckw0emtqUDM2UjZER0ZI?=
 =?utf-8?B?OWFESmJnMHhhMVczOW9XZTdpK0VmMERJd1VHMEZRcFkvSkxvR3dxU3NVWUdz?=
 =?utf-8?B?c1ZQeldUTitOVThWSFFtNG9GMEFuTzNUMEYwQUFJbnVnQ1lyQlFvL0I3Z3hO?=
 =?utf-8?B?dnhmTGRmcTBKRlk5aitHVmVpTnU2dG5vWlNGQ1o2NkpVWXpFRFpTTzFqQjBw?=
 =?utf-8?B?VjFLYS92anplZjN4dnZNaUcyNHd3PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1EC8E80D9329064EB2EE42192B3CD3F3@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4638e45-077f-4cbc-e934-08d9f0a534eb
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Feb 2022 17:04:19.6844 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pI7ZotvfinrqsuEtR/0ngQJB7i3slzcEn26KuYeln50LYO/1YvL3H/BPBVRihfR7SBhqLTfvE0CgCYMc0CoeJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5047
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220215_090424_964348_A2FA1384 
X-CRM114-Status: GOOD (  11.89  )
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

T24gMi8xNS8yMiAwNzowMywgS2VpdGggQnVzY2ggd3JvdGU6DQo+IFN0cmVhbSBkaXJlY3RpdmVz
IGlzIGFuIG9wdGlvbmFsIGZlYXR1cmUuIEl0IGlzIG5vdCBhbiBlcnJvciBpZiBhDQo+IGNvbnRy
b2xsZXIgZG9lc24ndCBzdXBwb3J0IGFzIG1hbnkgYXMgdGhlIGtlcm5lbCBjYW4gb3B0aW9uYWxs
eSB1c2UuDQo+IEV4cGxpY2l0bHkgc2V0IHRoZSBub24tZXJyb3IgcmV0dXJuIHZhbHVlIG9uIHRo
aXMgY29uZGl0aW9uIHdpdGggYQ0KPiBjb21tZW50IGV4cGxhaW5pbmcgd2h5Lg0KPiANCj4gTm90
ZSwgdGhlIHJldHVybiB2YWx1ZSB3YXMgYWxyZWFkeSAwIGluIHRoaXMgY29uZGl0aW9uLCBzbyB0
aGUgc2V0dGluZw0KPiBpcyByZWR1bmRhbnQuIFRoaXMgcGF0Y2ggc2hvdWxkIGp1c3Qgc2lsZW5j
ZSBib3RzIHRoYXQgZmFsc2VseSBiZWxpZXZlDQo+IHRoZSBjb25kaXRpb24gY29udGFpbnMgYW4g
ZXJyb3Igb21pc3Npb24uDQo+IA0KPiBDYzogSmlhcGVuZyBDaG9uZyA8amlhcGVuZy5jaG9uZ0Bs
aW51eC5hbGliYWJhLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogS2VpdGggQnVzY2ggPGtidXNjaEBr
ZXJuZWwub3JnPg0KPiAtLS0NCg0KTG9va3MgZ29vZC4NCg0KUmV2aWV3ZWQtYnk6IENoYWl0YW55
YSBLdWxrYXJuaSA8a2NoQG52aWRpYS5jb20+DQoNCg0K

