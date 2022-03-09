Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 978B3C433F5
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Mar 2022 04:16:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7tou64Be/JMGFkeXmqf8aJN2sRjPa458StxiHiEWI0c=; b=dQyhP8v7UAYs13Oad5Nb1PYpHx
	FwkKTN+/wFfGBugqUODxHRrdi0xMzMhir/GYu0K3CSNr5W1e4slBGb2s4jP0xHVVXicKRmiOsdqla
	rQ/CSlOi4lAKhs7v4hSsthptJ/DwC0nO8WUiluxI4l7sr6kiIPR3Plv8BPRuUDq6CXf4sn3yOsTJ5
	FbO7uwo2EJKJ7yDPHqVfBuJxEvIjMY21vsvWF3lJTRVHi33n1ji8RXWUroa0uelwsEssLTlz8eWyH
	9d/9qfsf2AOxogi53ruXyERxIoPZs7TGOVvzhGW7TGYIXY2i54SM/UUlTbq1fcfe718BC+8kspgAO
	GdrmezYA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nRnkC-007GCU-UC; Wed, 09 Mar 2022 04:16:12 +0000
Received: from mail-bn1nam07on2080.outbound.protection.outlook.com
 ([40.107.212.80] helo=NAM02-BN1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nRnk9-007GB4-BH
 for linux-nvme@lists.infradead.org; Wed, 09 Mar 2022 04:16:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ivs+yh8toFGEm3BxX9rZ50ksJkNdPX2ZNPCluE4rMgK5zeeeiRRcQD57ujpwPqLsVEkuaKjZPeOVxsgQTM4ruAA0DvVFQyYn89uG+wz2cwRCO8SBD71O+KBBA0CJNwhgDhhEcXYinJtiuwtyO2Ufqiw4K2HWqBuTFy5XwaeRBUA0Z7kNo2DItNZNmLCUz+Eno/0ObyaheD8IgIbAFU2xTrqHLksn7i7j9N4DwceT3MGrYvYGWCL9rhbLHqWYhbe+ay4DgOSUwH4WrqNGZdwGK79SLVb5moav+NFtMXolEfJMPn4vwRjhQph3xvn+5ds/synTAaUte9ES4pOGvnsZEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7tou64Be/JMGFkeXmqf8aJN2sRjPa458StxiHiEWI0c=;
 b=ekWa5nW5UitDE2mp6P2bbDFtdRgO8DufIsWQCf6X2/1wpyQm/2Sl76+M0b9tmCBi+vNB630E5BvdENVTsKm2Rr1eFNKV6/Dg2nK7VSqyqiAqIvy0GnEnjOjnkrYh1CP7Kj4zT6j2McSKLCUS5gxYGLPuKX5iRD9/xTyM2odErSutLZq/PjHgp+UMJ1VPiQ5xexNbbHkfE71uh6ybTunEtLYNG+GoG2S3DJm1Vj3Z/bj+yc4nB7aX1U5S90LpsRmBKUoAGLi3yzqToi9ShhKsPMYBx5oZR6WbLqsIeuJ2ifH4wgmy7LelD/FI+4nlHAjnN0V9ya9ZMsZAwD5meiLTmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7tou64Be/JMGFkeXmqf8aJN2sRjPa458StxiHiEWI0c=;
 b=D5cVEyjD7QN9mqHWWy3nezbcFerJ2bgG2QVPWCvnsE8uppDDDCIqy+Yx86Zg3l5WX1ltLw7jY4yfcyO0CEse9wLMw1B5CPD38EYwlBWOSINZORawI2SR6Mm42x/VGGPSBdJt9unKOKjQN0ZsMEHvfjrLxZrtxOxRI0wlMcvulh5UnBLZn9YDGbsgD9tqVXoFdIrth3QLSWyyvHOG5atZykEOilE1Ub0mr0i3uXbMP/YQmS51QF8P5cOk1r/O9W5Vl+Ihh/8nRtlBOA81VVA7pX75SidtZhiCdHuN7matfd1kMYt7jSrT+7S1spc1g0MkOZPQfxwl2zMRKtGWo1woGw==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by MWHPR12MB1792.namprd12.prod.outlook.com (2603:10b6:300:114::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.27; Wed, 9 Mar
 2022 04:16:05 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::204b:bbcb:d388:64a2]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::204b:bbcb:d388:64a2%4]) with mapi id 15.20.5038.029; Wed, 9 Mar 2022
 04:15:23 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Jens Axboe <axboe@kernel.dk>
CC: "hch@lst.de" <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, Chaitanya
 Kulkarni <chaitanyak@nvidia.com>
Subject: Re: [PATCH 0/3] nvmet: fix compilation warnings
Thread-Topic: [PATCH 0/3] nvmet: fix compilation warnings
Thread-Index: AQHYM0Bf13+F4D3YSkWaopRXPX/Ssay2I1UAgABOwAA=
Date: Wed, 9 Mar 2022 04:15:23 +0000
Message-ID: <4c24edbd-bf1c-8918-422f-b0d19e202398@nvidia.com>
References: <20220308230022.8863-1-kch@nvidia.com>
 <ec24258c-6e52-8ff0-2cd0-ac25de35bca8@kernel.dk>
In-Reply-To: <ec24258c-6e52-8ff0-2cd0-ac25de35bca8@kernel.dk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 875d9ae7-dcd9-4c42-652b-08da01836e82
x-ms-traffictypediagnostic: MWHPR12MB1792:EE_
x-microsoft-antispam-prvs: <MWHPR12MB179264FD06EFB3084A8B11A7A30A9@MWHPR12MB1792.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /fXeFcf8SwQC/lTjZGBVCcYqhZpGs0XhSjCpkwqpHQ48tIXwVUOlVy6RThGxaH63QHSdtKGlM0fKvOMPRlFnCWAdLUV444GQ+l74lznnNPuW1jJ3VVOBdIwrCPYF636DA4tlki1+kELOo4409uW0Sxhl3QfplZzejTzbsB2ixXubMF7ItujPyTQj5vjXcsoBkO1PHfIe6DwVLlPxxjkoh3snYwAJWYtOpiS11HW/pYbbTzd6J4KIX1UlNFlPTKVyGG0oYpXVJB4WfVkile+Ppxv8Cu+uo+7ByEIWktzCLgg7xeT4GHbQypbQwUrbpyH/01srfPppJ6lPN5GrAWMHWMWnClKVCnqwgYU1HtESNYrQVb62XrSwQb1m9rSW0dKrtsg7+z54HxErebycc/2fH83fHXI24YGDeKYDQXVYso8ckBtxW/1gqJSHsPhiWj9PxTryHjy+9+dp4hp0JmswBoslXOaxbDMGJ0J9ixvbgE4ordVRX9cpTxsgrNPPwUprpqsz/N50GYHnMSS6vXq1DbIQ+VBMtdt7u9Uu9jcCYVF4aPsu+LviiDIyvREnF1Kh56WFRLiTnDDApvwLwNmpTVJbxvVklyH8R0jsaeaAjucB99oSz5kWoyXymhNR5KyN1J/K0JjDEi+BYHyYcs5h7xAS7igUAryn+J0y+Fq+vYgsen880pkIyQfv+f9eB32mxu+5rc1uTBKs8Yv/oJNHlLbmTPSAwlY80nR7muT1i+mExBuBYj8Yp8lrsgsLe38gUFn2vyuKH/Lig1GFJjaiXA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW2PR12MB4667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(38100700002)(86362001)(38070700005)(54906003)(6916009)(316002)(26005)(8936002)(31696002)(5660300002)(4744005)(31686004)(186003)(83380400001)(107886003)(2616005)(36756003)(6512007)(91956017)(2906002)(6506007)(53546011)(66446008)(508600001)(71200400001)(122000001)(8676002)(64756008)(76116006)(66946007)(66556008)(66476007)(4326008)(6486002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SEtORmZMNFNYZ09qYzRudm5GUDJaSW5JY2VaS01heHhPRjc1VzB2WFo3UXZy?=
 =?utf-8?B?UnAzNjlSU3oxOWJMVkRFZVU3MW0rdno0eVpYS212b3ZWRlR0Z0ZKVVlRU01B?=
 =?utf-8?B?TDZIMjBCbkFMQnNiQkpTR3EwNzcyYkl3b3lkcnJVakV6NlMxZlRXOHNBUTVj?=
 =?utf-8?B?TWpZdDRJNHZCcFVpYXNrTXZoelBXdkg2S05xdmRTRlc2UXJwNkZtamFRSTBZ?=
 =?utf-8?B?QjFiUnpEc2ZjZzBRLzUyM3I0cW5oNGhIZjZnYkhDa2dlSGdHcGJKM0UxRjhx?=
 =?utf-8?B?S0Q1Y0xiVXh3QjNKTTY2TTUxaWtrejhvZDFhREVaMzk1QTJyUUFRUjNEYkM5?=
 =?utf-8?B?YU5hRUlwZ2lkSmNPNml4VDF2VlY1cDd5SjZnZU92T2t2akZUaDV6elczZ2Nw?=
 =?utf-8?B?MEhZSFU5RjkvR1dNL3g4cXNkQVk1aWdTVmNWbjVEemxzZ0d1cEt2Tkttam44?=
 =?utf-8?B?a0dtQm50NmNqdnFpTk1HQzNNZFd3NlVhU2JoeWozays3TjA1WmZkZVlMQUQ5?=
 =?utf-8?B?MVhmakh3YXpvaFhyMVR0TDAyRGpSM0ZGaWE0L2xnU0hLeVhSUlg1RWVWMjVn?=
 =?utf-8?B?dWVGN2tKVUNISVZZcEVOdStGZlZkdi9FU0x4MWxvdlZ1U0NUUnN6Tmk5d0dS?=
 =?utf-8?B?bWNCN1htWDducGRmcnlXdGVSSmJLSXJrbE9sdXdIeU14QWdjRkhYYS9ZUm5a?=
 =?utf-8?B?NGhDMGRKR0p4Tlh1bFZmbTRDejByb1NRbldra3lpM0N6TnJBWnRmUDA4ZFRV?=
 =?utf-8?B?YlBueWhOZnlWRGhRcXE1cTlMWlN6TWFxZUZhRDVJbjB0RnAza1cwTXd4eU1U?=
 =?utf-8?B?SjVSRjJlTWUxQXFiZE4yYkZMcFF1OWpncCtQT3kweWFmSndkSUcvVFpISUh6?=
 =?utf-8?B?TVJtazkxbzRpemVpMzBMNjBoQmlZeXUrbTZ3Ynp2TmlhWXJpbUpIeldQSkRO?=
 =?utf-8?B?WmVaZjBXMUxubmlDSklsSTl2VFFXbzRqR2gwbncyLzlPdG1DazBtdDZTaVlk?=
 =?utf-8?B?N1ZDQnBST3RFY2Z3a0dOVzlXK3ZRdmhIL1NXdmU1QWYvcDgrOVJ4Wkd5cVJY?=
 =?utf-8?B?cWIwM2luTGhoSEY3dHkrVjFrRzBRR1VkZERzV1lNVWo1TGJ3ZTRHSVE2RWJi?=
 =?utf-8?B?VEtraHp1eHg4ZEdIUkxHc2sxd09WMDhPWDg0bGdQWStib1RnMDgwdEFYY0Fi?=
 =?utf-8?B?a3daVUJ6ZmtZYktyNzd6cjlYQU90czdHOGMrVEk2RVdWRkp3bWlDemVzVTNh?=
 =?utf-8?B?aUxFV252cWh2aXlKdnM2L3pTd2dYNVZmTDFKQWpCMHUxVUcxemhBOUh2ZHJ5?=
 =?utf-8?B?Uk1BTmtGUitUWWlNb0V5QVdqeC9uZFRiUU5FeW1iYWVqN2d4a1BVc0ppUnhr?=
 =?utf-8?B?RW1RUEpFemluVU95S1Nwd3ZsUDR5L2IzZGN6aE5XTmRrTE1Ta2RnVVBSZUtp?=
 =?utf-8?B?Y2NhMGZNYi9rRVVIdmVQYUJPczMxN2VqVE9ZakdBamh3UkNxN0h5RTBDKzIw?=
 =?utf-8?B?RWYyL1VENGhnZEVrdFB3bytyYlhUYjNEcVNNRUhmMVhEMTd4eXBMdndac205?=
 =?utf-8?B?S0JUREkzZ0w4T0hCY1Z3WElmcTZGS1VPTGRkZG9DM0U2cW92UDFFTTFwQWZl?=
 =?utf-8?B?Y0VGUFB4czd4amdHZkZnb0l5UUdEUFJEL0N3TGdJNWk3SWVoNU56L0dab3Za?=
 =?utf-8?B?RTU5OVBXeGkvUjhtV2NOOXJsRTdOV1NSeE15SDN3NGowRW1jb05jQUhyL3RM?=
 =?utf-8?B?U29JL2hOTjQ3WitlYlgyUm9vYk9IK1RuWThlRUkwaEtTZGdGWW5BOElYUFFJ?=
 =?utf-8?B?OUlFRWV3Wmhwc05rTjVRT2JHK01Db0RwSUNFQXdVZmpGa2l1TUZhVVhJa05D?=
 =?utf-8?B?dUZvVi9kL0xURGtTTWU4YXF3V2FpajBjRmVPcCtVeU02QWFFVHUzV2Z6d0N4?=
 =?utf-8?B?TGNhdm5jZEFtNDUzZkY1NlF2S25wU3VlZHBUK2NuY3FRMXZxSXF1UlA2dE1r?=
 =?utf-8?B?Zy9IaWxPQjdoeGZwcGNDY1hxNWlGRTE2dDBtdDJaVm5EYmNKMkVEeXlRUzNi?=
 =?utf-8?B?bG16ZGpBZDkrUUtrc1hJUVMwSjNJdS9ndk05Y1I4UTk2VWlCMXlrYkhNUFZE?=
 =?utf-8?B?MVB3bkdLYTlYa2dlUU1LUFRBZUNPWkw4ODlhM0UxODBrc043WjJteHI4c2FH?=
 =?utf-8?B?ZWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <435C86EBAF6BD24AB156AAB45BCD20D6@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 875d9ae7-dcd9-4c42-652b-08da01836e82
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Mar 2022 04:15:23.1635 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gb3ncphPOM0LJ4aDtdyMvrwddUSX7UUSoCvFJv9suAJWPZDt4dlhBt7t3FhVcyMlCDFMhlhp4RRsJMMjyAxV0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1792
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220308_201609_486554_265228AB 
X-CRM114-Status: UNSURE (   9.31  )
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

T24gMy84LzIyIDE1OjMzLCBKZW5zIEF4Ym9lIHdyb3RlOg0KPiBPbiAzLzgvMjIgNDowMCBQTSwg
Q2hhaXRhbnlhIEt1bGthcm5pIHdyb3RlOg0KPj4gSGksDQo+Pg0KPj4gRml4ZXMgZm9yIGNvbXBp
bGF0aW9uIHdhcm5pbmcgZm9yIHRhcmdldC4NCj4+DQo+PiAtY2sNCj4+DQo+PiBDaGFpdGFueWEg
S3Vsa2FybmkgKDMpOg0KPj4gICAgbnZtZXQtZmM6IGZpeCBjb21waWxhdGlvbiB3YXJuaW5nIGZv
ciByZWdpc3Rlcg0KPj4gICAgbnZtZXQtZmM6IGZpeCBjb21waWxhdGlvbiB3YXJuaW5nIGZvciB1
bnJlZ2l0c2VyDQo+PiAgICBudm1ldC1yZG1hOiBmaXggY29tcGlsYXRpb24gd2FybmluZw0KPiAN
Cj4gTml0IC0gdGhlc2UgYXJlIGtlcm5lbGRvYyB3YXJuaW5ncywgdGhleSBhcmUgbm90IGNvbXBp
bGF0aW9uIHdhcm5pbmdzLiBJDQo+IHdvdWxkIHJld29yZCB0aG9zZSBjb21taXRzLg0KDQpPa2F5
IHdpbGwgc2VuZCBvdXQgdjIsIHRoYW5rcy4NCg0KLWNrDQoNCg0K

