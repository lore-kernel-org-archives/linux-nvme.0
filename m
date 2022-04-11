Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8153DC433F5
	for <linux-nvme@archiver.kernel.org>; Mon, 11 Apr 2022 19:53:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=u54cF2v0S2BN8j/qpWEJaPRVxeXE8kwvOqqk2oahR0A=; b=uW3NiNNcfC6Bm9/yus7x7ffOct
	rU9oM7RzTVbDQrZnoHah/M6owp81G4QfzadCTlI7WgDPe3wNZQ+ClRn855F8h9M/yOS9B6PHaSrkg
	MhPguOUzlMS/3ZuAiMHQnPNEHYtqVT1AAABdfel/7cr8rBxm56w3mN3B69dKDHNHKE8+yA2ve6l8d
	MVmFAR/HV8MkZMjgiALAdaMpxT/PQkVMCThz6/6DH0h9pj1J9CYkDR+zw/LVJPZ/mduwNX3kmxf67
	fhs2zyaBHduDfVom8x+Hiwolw4vKL/24+hJ5KswP0zebUoceJh/ON8gjagGorlSdY1jDEV5/TjfOz
	CXS5MSTQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ne06B-00AN3l-Vk; Mon, 11 Apr 2022 19:53:20 +0000
Received: from mail-mw2nam12on20617.outbound.protection.outlook.com
 ([2a01:111:f400:fe5a::617]
 helo=NAM12-MW2-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ne069-00AN2v-8E
 for linux-nvme@lists.infradead.org; Mon, 11 Apr 2022 19:53:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h9jc1TEbr2xWgCkgXDD7Bn9gFyxG7D2pmYs0t81D6Zu5DybF+fBOffQQo1uWHFeam4AOaoVEthwsMGZnAOxOG8ZsgzEBdSJH8mC+YxTjY92NvKziFUwa/D5QvR4pOxr+omi4wMi0PkFera0fCCvs0FFfeVSYDMRjVj8hMwNzvf2eoniVqsqIgBqH9OWEGoCgQm8V1Wf6XM3KIUNnvHdG/X5rnNaHi9QV9EIZcdVnNr+vigE1sJSmJKEZPpV3sTBqX3hJhE5GsA4HWGLyiRdfsfX9FqcUF9+9tJoGU6iXf3kMla/8WElY3xthRuMUW1atUU5F7yCGjoqgs9Ehh+asqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u54cF2v0S2BN8j/qpWEJaPRVxeXE8kwvOqqk2oahR0A=;
 b=n9pBzBQ0eO8ZWU7M/FLXqeoD4/PdcN1NIiOfmL+q0KTG3fkGMW72jcnNaldgwyENl+CqdYfCmt46H/7gp96V663SEF4d1Oleo0c17rB5AjviQZ1AAIQdZF8l4/RsB1JCvB3bzhPYm4UvaiLsLBCiWqf+YCweuP2lZbcmfs5NO8f+DorLN35Ujrz+ldKWr8goDTAZmkdfsaQqwJKccME8J8gzI45hgSD0tKv518rpf9IrIOQTCH51zJbDvkywfBIQ/S5MGXfWPOPvzx9qlTzMM/7PAwO+kDL7wJTv2RiIHswQ+/V3xgLvNxSxPULDZFY6dGqsoiOgoQ/mkcFE4OTTRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u54cF2v0S2BN8j/qpWEJaPRVxeXE8kwvOqqk2oahR0A=;
 b=s+pzH6ihx1jliZrDM7XQtzGD/5v5JEo4VEsnvTw312t+Ls1N3acJlbWz2YCKHZ5uszmkZXjgInOlPpodla+TZtsIhyoQoVlW/WbxeqdheuXEwVHd3Eo7izpP/Whc1/4ftnNEo4nx1n1U5l53xWeDYWIM7b5AW0wYt+ycQmr7tJrQxILvBi2QblF2Ar1z2XgP7cA2BV25x1vHBN735Uf8rP9xkpydT4ZdHeJNu6sD5dQDh4JDyI0x1xl6tZeIodv9Y4XHBCBYNcQ1re4VL0iuFHzVoIBtGKWDmJVfWIxJjoLUnRA5GtFOhA77j7dek+Zbd4mGqAMsRtGkjzJC8WdyUA==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by BY5PR12MB5015.namprd12.prod.outlook.com (2603:10b6:a03:1db::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Mon, 11 Apr
 2022 19:53:11 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::a90b:9df2:370c:e76b]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::a90b:9df2:370c:e76b%3]) with mapi id 15.20.5144.029; Mon, 11 Apr 2022
 19:53:11 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Alan Adamson <alan.adamson@oracle.com>
CC: Sagi Grimberg <sagi@grimberg.me>, "hch@lst.de" <hch@lst.de>, Keith Busch
 <kbusch@kernel.org>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH] nvme-core: mark passthru requests RQF_QUIET flag
Thread-Topic: [PATCH] nvme-core: mark passthru requests RQF_QUIET flag
Thread-Index: AQHYSdUmD3brgDUei0iedZF8Ixk0L6zjGb6AgAAClgCAAAWlAIAAT2MAgAC0PoCAADK+AIAAiyCAgAAG0ACAAAbxAIAAA+AAgABTl4CAAO3fAIAAghkAgARYhICAABa1gA==
Date: Mon, 11 Apr 2022 19:53:11 +0000
Message-ID: <b704f75b-31ea-a699-8d7c-458113e6585e@nvidia.com>
References: <20220406164109.30449-1-kch@nvidia.com>
 <Yk3FT78uVW+9rRV5@kbusch-mbp.dhcp.thefacebook.com>
 <21a3a237-5f3b-a608-2d79-e0a5fdcc0d88@nvidia.com>
 <Yk3MNrI3YfjvbRqZ@kbusch-mbp.dhcp.thefacebook.com>
 <92C8BCED-6845-46D4-BCD0-78E790A5F86E@oracle.com>
 <20220407085113.GB19062@lst.de>
 <64ff1e92-6c6c-da38-8753-0e6098394622@grimberg.me>
 <4386789d-6722-add8-5b42-f605e48e894b@nvidia.com>
 <650E6456-BCAC-47DA-B50E-4321E98AC9AC@oracle.com>
 <b793928e-f127-8155-b124-642614afbb85@nvidia.com>
 <C8570F84-276F-42D0-9914-4440FAF64B5C@oracle.com>
 <752d1875-1680-8f8d-7330-d5e8771c7e7a@nvidia.com>
 <884816D4-96AC-4489-859E-2C52972D7FBE@oracle.com>
 <8b21d015-73ea-6b47-d54d-7fdeaa12bc60@nvidia.com>
 <E3D31C43-E685-4FD0-9750-167B67C5F72A@oracle.com>
In-Reply-To: <E3D31C43-E685-4FD0-9750-167B67C5F72A@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b23c7854-52df-4e35-f95d-08da1bf4e8d1
x-ms-traffictypediagnostic: BY5PR12MB5015:EE_
x-microsoft-antispam-prvs: <BY5PR12MB5015889DA1CC4C1C654DF595A3EA9@BY5PR12MB5015.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ePeBtaUpnLpnxLPW3NhVL+8VslJRHrPk2L7C9sDbY8kXFp8sfcvjMaz/abau9qrW+v55Y4R0v4skBkyMDz2rDZV07utBAJJ3I6GXLqXnlaV0PEW9ptjrzFEeAayTGHIhpC9rvPIlGonD6Fi20T93lkYYWzYWHxpudW9aI55KrVYNYR6UPdcA1IPmEaSA/6QvtWLB4VeU8DOvrInVZ/y0lgYRrVkHhwrPsh02PsHvjBfsyRGGnb4WLa30JbSfXRqdgWrREseUEq3pTvGm5wm7lsKh9UESzDapYTdpgPrItSDDw+y/mNAFJxOqXu6feM4dIvRje8hB8EICqVwzNjv4JHJOSrAA7zO1upqamvzbc02Idb8J4Q/MeTERfiHOfw9M2nuxaHYJYiz0IaS5bGgo1jBgXHjkIxj/Y3Iy8H6zNAQQ7VeCEHUA8Z0lUYVB62ld56qHCYP5T6nG2N/RhF6WrLydARCz/S3Td5TsUxDFzZyf8Vc1k2ZRn6xZYWDgPtIBkAv52sJNxOSe91cjhJmQoj31bfpqqT/IjZ1+m6byN9DMvzcBC23isUrKF8q1YkCGbxklG0wHqx1ZQhNEQK7bBAu+zbzjaUcgsJeot24Htsg8Hsv+/AXUwrFl9OgO7kCn3d+zKU+MtIsgafvsNI36w8AdmCoLdfi+Ao896vmDcyoao9zgQoDwlb9CysFbkbGLuJbB2MxmEYZNwY8iZ+HFWnWHPRf7kK+7Pqsi2HjmHtBXlhD7VnL9ubJ56v9oyg+K7rlSKSxi/FiqdksbD76leWyIYy/yqf6V1IgPAMvdl/Ko+YaZZZnuwt5MaubSt92mPSEb3gqwo9ppp/EuXW4+EY+13EIqS2Sdefz0/264+tI=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW2PR12MB4667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(83380400001)(36756003)(31686004)(2906002)(6506007)(2616005)(6512007)(6916009)(8936002)(86362001)(31696002)(4744005)(38100700002)(66556008)(71200400001)(6486002)(966005)(122000001)(508600001)(66476007)(64756008)(66446008)(186003)(8676002)(316002)(5660300002)(91956017)(38070700005)(76116006)(66946007)(4326008)(54906003)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UFUzbUNVQ2c1YXVnYVlINzFWbytUb3lORnpoZEJFRC9TUnA1RDF2QnJaU243?=
 =?utf-8?B?Z2JiQithU3ZYclRodFB0NVlUVlUrMzA5SDJNSnAxQXZTdm1EYTgrdGthOTVR?=
 =?utf-8?B?UDhhT1hoN1VwZC96Z2pTRHgvN2NnSEJkMUoyQU1NTVZjakFwbDRuOVRISnU3?=
 =?utf-8?B?a3ZRWmdQOWNXMFFrN1N5NjROeHpRR1p6dUFTL2dyczVWNldnbnc1bEVKdnpL?=
 =?utf-8?B?UlRJZnJvTnpZSDZCVWd5OHE0dmxYbUxSd1BQSERNYWtpaWtNSkFvZzZpUVNm?=
 =?utf-8?B?c2I3VzNaV1pBN082aFBkcHlCYzBJT2tVZmZ0SDN0dWREUXFCTHpkalcxQjFG?=
 =?utf-8?B?OUxzUmFKNXJLbkhCdjU5eG5WVDBaM3h5czhuRkVNS09IYkQzQWY3MjlncUcw?=
 =?utf-8?B?dUNlWWtOLzIycEN3SWxJbWQ2cDhlR2RzM2cyaklwV2M1RlZtbnlaZXgxcUZC?=
 =?utf-8?B?amxTejluc1dnTUJXNm1xMXh0aUt4MHJlN1RVeHorSk5ZOUFsWWxZSHlqVGd4?=
 =?utf-8?B?S0kzb0tuWXorclE3eHNoMjBmOFdsc2FGQ2duaXh3dWlVQk9NY0hKMGY2c1d2?=
 =?utf-8?B?dkF4elBxRHBURXhHZmU0dmY0M05QWExQMFIwZmpGWE9ZcGlFOUNiZW8zOFlC?=
 =?utf-8?B?dml0YTdGTklNVitROEdDTTczVXdaSFlXT3FlckVrSmY5RWU1U2NNejhEN2RL?=
 =?utf-8?B?S25XOEV6WnU1bXlidGgxNjRGVW9oUmJjUlBPV25hQmlTb0g1cTBUMEQ0anM1?=
 =?utf-8?B?Qk9TSGxlS0dtSU1Lczc3Nm1wcGlyaDgzVnJWTWhUMno5M2UyaE1KNGJLMm5m?=
 =?utf-8?B?dEp4RjF2ZWNIdVd2ZDlqdktiU3M5Umo1SGwxUXNuZDIyb1ovb0FlbnNpc215?=
 =?utf-8?B?N3NBRGJQS0tLN09TMWNtalM3Y3lsUjNQSzlRMWhBMmNHSTZBVlp0bWhiVWRK?=
 =?utf-8?B?UzkyM2I0MmVhTDVyenNnbStmdlFySnlKTlZCK1R2VmVmMGF5eFBJTysyYnor?=
 =?utf-8?B?djlmNGI5L1cvSHYweFNEZCtuWGpXN2Z1MFo1dHdRWXdQcUFPc3ZJakRuYi9p?=
 =?utf-8?B?N2x3eXEvOWFnSmoxRnlkZjZDUGRTQmRTTy93KzRPM0d4SFJJWGJIUmlnWHRN?=
 =?utf-8?B?V1V0Zy8zVnRlZkY3R3Zra0psZFd2V1RzTVVSQVFKQzBPSzhIdWIzd2J4c3o2?=
 =?utf-8?B?M2xpUHRJL1B5RFlVd3NkZ3p4bHEzUjlSZG11dGVtZWd1dmpRRVVReHJTRWti?=
 =?utf-8?B?aUdEbkZhclpBd2pFcmdoTlRBcll3WlFaYmYrOHdlenFHS3puZWljMHZLMTMr?=
 =?utf-8?B?ZmxxaG80Y1I4MVdzRHVFSUFyUTBMRjBkNWU3OUh3YkROeVRKdmRqTUp5anpK?=
 =?utf-8?B?ay9rZFB2dFJlTUlSWHRjNVZIRkh2aGNabTM0Z3NuUVlqQjVSNS9JNWd6WDJo?=
 =?utf-8?B?U3c1YSszcFc3RUNIdGhWekRsc0NvN1hqVzkyb2ZHUW51clFyQU1vZlNjWlpY?=
 =?utf-8?B?YURpRUM4UnV2UXZKUkJBaktJNkpUVTRHckNydDc1Z1RMMjM4RGU4a200NVRM?=
 =?utf-8?B?V0IwbWNMM1ZUemY2ZzNqMWJrNXBIRTlQYnRtNlU5Mk4zalAxaGRnOGI1bmtt?=
 =?utf-8?B?VGlJbGdmVHF2WHNYeHZCdGEzaEEyaXNaUEFnWTNpWmN6RlNYYmZoaXVQVnV1?=
 =?utf-8?B?czFmWlFWV0NaTGVRR3czK2JkVFlZaWgvT2NFT1dZRGVIUjFHU0F1M3hzdjVG?=
 =?utf-8?B?WlNNKzVBZWdnalQ1R2k2Y3A5Mmx3UW0wL21RcFVwejFZWTgzT0h5aHpnNlJy?=
 =?utf-8?B?Y1JHMDM0b3N0d1lLYWJFZCtGRFNHb3g1T2FENGYyRExkeXV4ck9ETFFNeW1F?=
 =?utf-8?B?OU1FRWZna0xGUzFhcDlOdXhmaDg1SDJBN25GODN5ZDRaSndCM0NrWStpRzJm?=
 =?utf-8?B?cnRpOFpNaWVQVEZXQ29pNkI3L094ME1qSHYzNElnUU8wQUdjb2N4K20rTWpP?=
 =?utf-8?B?VnozWnB4TGt2ZUpCWks5VnVjOXpBRkwxZDNGd0NMMWNJV1VGRXVUN3RIdDU2?=
 =?utf-8?B?K0FxNUJlY1NDMzNjQ3dwN2E4QUJIYkRiVDN2QmRzNkFGc2dOdjc4cHR1Tm5y?=
 =?utf-8?B?czdMMHcxY29JeDJNcFlBUmc5a1Awc1k0UnhVTEs4YWNCUXBoRS9XZFFmS3pJ?=
 =?utf-8?B?c1RTMUZnWVVxZ0cyYVh5QUI4UUZQKzJPbGNob1lNalQ2T1Q4Rm9KYmdYWHZ3?=
 =?utf-8?B?Wm1sWTRpeVE2TENER29KcVl3cExEb3VVRFFwY3d1Ky9CYVpTS05VTldrRWZF?=
 =?utf-8?B?K1ZTZm9DTUVMd3dMZmp3TzZZdlVMOFhzOU9KMnVWdTRuaUV2eFBwT041MENQ?=
 =?utf-8?Q?UVY1ibKiBZlWHyTfYMZZUrlWM/o33q0QKvKGGz+0xFWDS?=
x-ms-exchange-antispam-messagedata-1: JeBuO9wYyedg0Q==
Content-Type: text/plain; charset="utf-8"
Content-ID: <D4AB150AE5026D408FAEBC2C326A8B3E@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b23c7854-52df-4e35-f95d-08da1bf4e8d1
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Apr 2022 19:53:11.7766 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WnyszmrS2nldD7HXbwBQMPoNxj3OaXMfegTbbdk4a+CYl75qY6BxNTyuHmEDaWLUrA5/e2p/MyG0tac5FuSQSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB5015
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220411_125317_338343_649EDD49 
X-CRM114-Status: GOOD (  11.48  )
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

DQo+PiBJIHdhcyBhYmxlIHRvIHByb2R1Y2Ugc2FtZSBhZG1pbi1wYXNzdGhydSBlcnJvciBtZXNz
YWdlcyB3aXRoIG15IHBhdGNoLg0KPj4gU2VlIGJlbG93IGRldGFpbGVkIGV4ZWN1dGlvbiB3aXRo
IHRoZSBzY3JpcHQgYW5kIHRoZSBsb2csIGNhbiB5b3UgcGxlYXNlDQo+PiB0ZWxsIG1lIHdoYXQg
aXMgbWlzc2luZyA/DQo+IA0KPiBJIHJlYXBwbGllZCB5b3VyIHBhdGNoIGFuZCByZXJhbiBteSB0
ZXN0IGFuZCBhbGwgbG9va3MgZ29vZC4gIEkgbXVzdCBvZiBhcHBsaWVkIHRoZQ0KPiBpbmNvcnJl
Y3QgcGF0Y2ggbGFzdCB3ZWVrLg0KPiANCg0KVGhhdCdzIHdoYXQgSSB0aG91Z2h0LCBpdCB3aWxs
IGJlIGdyZWF0IGlmIHlvdSBjYW4gc2VuZCB0ZXN0ZWQgYnkgdGFnDQp0aGlzIHNvIHdlIGNhbiBz
ZW5kIG91dCBsYXRlciB0aGlzIHdlZWsgOi0NCg0KaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcv
cGlwZXJtYWlsL2xpbnV4LW52bWUvMjAyMi1BcHJpbC8wMzEzNDkuaHRtbA0KDQoNCj4gQWxhbg0K
PiANCj4gDQoNCg==

