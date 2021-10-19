Return-Path: <SRS0=W3/M=PH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09D91C433EF
	for <linux-nvme@archiver.kernel.org>; Tue, 19 Oct 2021 06:37:47 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D30E56008E
	for <linux-nvme@archiver.kernel.org>; Tue, 19 Oct 2021 06:37:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D30E56008E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Cc:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8FdvJZu8UnbTJYkS1e6FXJKDWHLX5vacOW4f5CSi/do=; b=h3/jyYp8kDolo3Ycdlywd3crWy
	fV8hS0ULFbc2UPV46aGZM/nt57NVbP8vxAh8qgpDixm8K3W9q5i5uOzhc/GY5K4H/5MOiLl6jqQ0C
	lo+VR92mQ0dUSYCv7tciZPJm4TT9SSXzGqKlaFnM6hupIDUudA0p3QwaOXCtjoTzsUgi4VNxDU6kR
	2jQgEAr0Ja3k93CznS180u34dz9pA5f7Y3cY6qGQODSI21dJbjX+kjbZ+4bokDOFpu1eC3za9Qwkt
	nWM/SyvO5BPqgNXEd4eZu96NWdsxldZrEFDEsfNwQ3mxpB1S6Qa2ew4Vl+3pvbNQt7m+F6fuJpPW+
	Jva+nlVQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mcikj-000JWq-8r; Tue, 19 Oct 2021 06:37:37 +0000
Received: from mail-mw2nam12on2076.outbound.protection.outlook.com
 ([40.107.244.76] helo=NAM12-MW2-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mcikg-000JVi-Fb
 for linux-nvme@lists.infradead.org; Tue, 19 Oct 2021 06:37:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NMSqA+SDQWcAu1WqDG6gEdPM4M4XXMgNHst1TrVV10CV2rtZqhHI06Y3fyV23PY4zWRi7AoRs28w7SBn0F+9Y9dicnHhB8j+Qo/N+mBcyw/q6QMcNyhAFLozBBwtImp9Mw1ZrhH8e71LUzn+aOPTbHiDXH9sFKDsZvLL7BnoyNWgcM1nDISfiZB6odOEtQB18J7fK/Vui2PYe/vxyXPSr74dz9I72pv46RdyQjUIJzPOpByG9Qza1QWGzFSLSDQSvhGx2fIAGPhPrfOaT57nqTuJtzbc8OSrP8jfnj/W89s+paVVttVjnStwZTAgUZVbEVtK+gTAlCvG9B8Q0H4CUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8FdvJZu8UnbTJYkS1e6FXJKDWHLX5vacOW4f5CSi/do=;
 b=S8J5D2l2bxXuQB9z/Xo8YvNjaWN8VPKGGPERpYqDGzREkaR0XU8hxh9K+2Y7IpgHzQge9jeUwN8ioT4PIy91v7MCf6LSoyHBAQAzscJMQ2xFYURHeGb+WWBHykpdaE0S/ZTEqqAq4KM3iDRKSPETXmMbzepAaXo55xoeyHC9QbMdq2FUgiQPv3m5uMs+1D72r2ZZ0tFKmkllZJHs7YZ5+F0h25x7iNx2XFUPl9dccGOx+o2/n7Q+cPsOLXTD+wFBfA/4octlsLqnSlFMe/L1dNR1bZ/onKW6/6nfoJVAlaNrm7XgV7xYgupWJTGaDeAPT4ugIh/tHQPbV9RB0/j/Mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8FdvJZu8UnbTJYkS1e6FXJKDWHLX5vacOW4f5CSi/do=;
 b=C7RHM2HL3bxJLnaGNwQsu2AsMhwpdmEqWx+0ySDyurfj1hRhdL0sQ98mOhPMVyo8LGFguktMAKUsYBJQ35yEfekfUGQVnHN+Le80SYytAdtRUB4XL4rzWLceSi6Db8XpYmbMUhPTKVnPwqIDp/324IiHuV4Wr6WPCInLEAmAALAjj16W5nqURujA04PJiwzfiwrPfXq+Hgsm49Kv1cHKzqo3yQ76C7oTcPhKagdYAk4RlopgskFLqe6Hc9CdRSFOLhmtaE183yhd7CqFlzYwhcSOQSDjeR03k3BpEn59hM+039ZIpE5CrlHz02eVSxniw1Y+djLaQE6MT9o5Jc+Akw==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by MWHPR12MB1262.namprd12.prod.outlook.com (2603:10b6:300:12::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.16; Tue, 19 Oct
 2021 06:37:31 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::3db1:105d:2524:524]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::3db1:105d:2524:524%7]) with mapi id 15.20.4608.018; Tue, 19 Oct 2021
 06:37:31 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH 1/3] nvmet: switch check for subsystem type
Thread-Topic: [PATCH 1/3] nvmet: switch check for subsystem type
Thread-Index: AQHXxDQo0hbMpPWRN02jlx9IzBUQGKvZ3y2A
Date: Tue, 19 Oct 2021 06:37:31 +0000
Message-ID: <78859610-656a-ef43-6a20-d3fc71dab4a2@nvidia.com>
References: <20211018152138.2128-1-hare@suse.de>
 <20211018152138.2128-2-hare@suse.de>
In-Reply-To: <20211018152138.2128-2-hare@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
authentication-results: lists.infradead.org; dkim=none (message not signed)
 header.d=none;lists.infradead.org; dmarc=none action=none
 header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ddee6725-e8ac-4ece-def8-08d992caed6d
x-ms-traffictypediagnostic: MWHPR12MB1262:
x-microsoft-antispam-prvs: <MWHPR12MB1262C55D761EF29D4C3B48AEA3BD9@MWHPR12MB1262.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1468;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TA/AWyvavjyOTSWPFjMYXQ2NBUDOn5q2Fsl5uopVSIyS1f857ZkkXsMyBymEA4FxmUO9R/Gg00LeCLDC55blxs0jR8M7StmB3Er6HKxkxg4XRmP9Vd3age8zGAHbeYB3e8rjBDLVL8vKH/8hsKXzWDa3zl8oXd1JUruhJ1I8nZ1bNPjKJAmmrbxd3oDsncbzRcCJg0XuufLFN+DCZlBSOG4suY9OUCZApBVFZJvdcqQjFYe/lHohCRiDm/6n8qXyHLf2IrTefH+HEtvgmRlxfFkgSNzeKY2j6x5ntd41A91U+PyYzBbfyWgvEf6VUxgSnZxI6AKMbkS1KxfzJ7AiVEdT4bJigx9jlbrOJ4ldOPtmbd5gx1iV+l7SP20P73xrO1nCpTaUirPekDy5/n/0594lx6FF0dg0Q7M6cpSXul5D5o7hEyZf93RrKxkEwNmDzbvAgU62nyFNpUEPMppgcHQjEYuE6O8r9ad6109rvEry1o6hNbxif2tBEzNiCQYeivToIovlvCJGBJ+XudOippBouYxd3xwbBfegCsSNfPqoD7OvkQqdjdU3N0sS3fgwnQiWOIDXCA4ckvppTLh1QBsQVdQXtHnz9BhbKjpra51YrbTa0VYgTlBq0W+w3pBr6Z0f6G93Vq4Y6FpHkLm9n58sFoiOV1osRVyJFFQJTGb8HtoJ3QHJ0oVH04O97fzz7Ck/dkUHEI/xO5VdlWIztMQoYiSJRAZDHet7St6g68kmyXlQc93bzDc8HNE8KoPOsIsGVEu8Kap0BPcQFE7tUw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW2PR12MB4667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(6512007)(6506007)(31696002)(31686004)(316002)(8676002)(71200400001)(2616005)(76116006)(38100700002)(91956017)(6916009)(66446008)(83380400001)(2906002)(36756003)(508600001)(66476007)(66946007)(5660300002)(64756008)(4744005)(86362001)(53546011)(8936002)(66556008)(6486002)(186003)(38070700005)(122000001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?di9LU2loNmVrdEw1enBpTTNlN21oR2pvVjlIRFFJVmtWcmJIbGMwYU9iYll1?=
 =?utf-8?B?WlNqN3FNTDUxcXFBZG5vbDIrYmQ3WFV0dHVkNXl3UmYva01vS1RRa1Y3VElF?=
 =?utf-8?B?Wkk2R2ZVR0JsdTdUUWtaMDROWnY0RDJJdlFxM1FGTFN1SWIzcXBKMkYwdHlF?=
 =?utf-8?B?VDVIMXMwUHFSOUQxZGtKUnBlN2J4SjBocVdnaG1KaVN2SmNpbTFaQlpsb2pQ?=
 =?utf-8?B?MTNpS1pSODlrTzE1bzVON3RUTTMxUFdrSUU1aldlUXFtYk0zWlFTeDdKaHlP?=
 =?utf-8?B?czE5Z2FNRVdzdW85YVg1ZktjV3dXcUJhc25PNGladWltbTJBcExsUWRKaytU?=
 =?utf-8?B?TGVqTzFMdGJXVjJpTFU0SW5LRHQxOHozSXFESWR0ZEZkN0ZKajZPWVRicG5F?=
 =?utf-8?B?RHVCdnRqRFNCVmNBK3lkRXFWUDJxRUxlWXBzb3Q2ZmdqNmlQQVoxQnlseVhD?=
 =?utf-8?B?ZFQwdHZNcC9WNnhPY0VKSmdpYVFjWTF0cUZJYUkrZnM3UncrV0haWHdnTUtC?=
 =?utf-8?B?Vi8raTA5cVhSTjJLV0Foc29HVjB3WllseFI5ZzBERzJrVWZlVFdUSUV4M1M3?=
 =?utf-8?B?WmM1VFl3bnluc0VjRlErN1FWMUNhSkRHWElJRDJISG9VcENFK0JSSm1mRVZv?=
 =?utf-8?B?VWdyKzZvU3phT0JKYVNFVzBMRDBOaGhEZFNnNFVSK0Y1a0pIVTFrQ2JTM1Rk?=
 =?utf-8?B?aSs3L1pob1NxazBpaEpRZUo2SnhJZ2M2N2prVFdLbXFlc1IzRW4wbGYxQUEz?=
 =?utf-8?B?bVR0MHUrNnFSdU1DTHU4ZTg5QUc3S0tHYkxacU95MU1UVXZwc25JSU00OGhu?=
 =?utf-8?B?NWhyVWhGRzdTcm9XUzVLTmlSNGVIaU83MDZmakhnNTZTYzB2TnlVWGgxYnk4?=
 =?utf-8?B?Vkk5a21KemxHeWNscUY3QUpZRkNQV0xhSVlYTzFuaXZWRm1pV1ZwZHBQa2pK?=
 =?utf-8?B?RWxVamNTN2x5WURZZC9NUzkxNVFlSFhvdThNcmErWTBQeG5tSE5BOFNmYXBr?=
 =?utf-8?B?d0tNUnV5TlpGUW9zRmxwaE12YkpRQk5DeDY0WS8zQ2x0aWZnYzRrZFQxV1VN?=
 =?utf-8?B?VXdyRmJOSUlhdCt6QmdKc1RjeThVRTZzbk40SUFiOHE4VW8zRnYzU2dHakNk?=
 =?utf-8?B?dlBtQmhTSW4rS0NaODVUNkhrSWdUNHF6c3N5NmtVQmpDZzZ6MTQ0QjVxamN3?=
 =?utf-8?B?VGM0TUhMRWJRTmN1TWkvaUxYdUE4RllOVnNud3YwNW91ZkNIVmdEOFQ3SEtV?=
 =?utf-8?B?a0lPbGN2YjZlRStIMHFoWUhYYmdMM0hYMVRrVUpEM1MwdE5JQW1YOTNGNzk4?=
 =?utf-8?B?c1FoN3VJK1hVMUR6VEVka1c2WlQzbkhJNzBhNFFSMjI0WStzV1RtZ0lIQTVY?=
 =?utf-8?B?dU1rbWd6aVc2ZWxENEg2ZDd3RHBTMGU3TSs4NkxJT0laT3Y2YmlZUVBSOE5T?=
 =?utf-8?B?dzNmNFVwbjZjQmJscnN2NGZSNjI2WERrVXViU2NOemdDdHdJd0pjaksrS3dU?=
 =?utf-8?B?dTJFaXUyMFBHVXY0WUtQczI2Sk5XMVdNVjFOUWhyUm9TUmxqY25VWGVMeVdo?=
 =?utf-8?B?NjdlRzJndHJDYzVOc2poT2FuT3AwcngvS2lNcW43K3RCZ25QTEtMZjZORWJW?=
 =?utf-8?B?SmJ4L2NSZExEQ2hPT3orV0Q0TXh3N1pDb0diUHd4WDl4UWpScVRzT04yTDk4?=
 =?utf-8?B?OUtjWUYxanl5V2dQMk50Vy9UeHdidkNsV2xUU3NiMys5T2o4V2krcHZDMUpo?=
 =?utf-8?B?a2pVYlVLY0VkckJQaExZbjYwQXFCOFM0eGROL05JOElFSzhMNmx4SktSRDZD?=
 =?utf-8?B?M2ZYK3p1aXFXS3N4RGMyUE41azJJbTZGN0ttdTIrZnJJRjFWYnpLNVNxcWJQ?=
 =?utf-8?Q?XIT8cW6OVYX6c?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <5F8C72AD59CEF34698B55DE173222BC2@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ddee6725-e8ac-4ece-def8-08d992caed6d
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Oct 2021 06:37:31.2306 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vxc/EHH56/aJUCRqFRQDPEeZ0DIX66rJUOrAssNm7FLiO1erfLDvfKrS/xyE6S4M1Q8hBDwFyMNCPdwwD4NYkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1262
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211018_233734_563457_64FC641E 
X-CRM114-Status: GOOD (  15.91  )
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

T24gMTAvMTgvMjAyMSA4OjIxIEFNLCBIYW5uZXMgUmVpbmVja2Ugd3JvdGU6DQo+IEludmVydCB0
aGUgY2hlY2sgZm9yIGRpc2NvdmVyeSBzdWJzeXN0ZW0gdHlwZSB0byBhbGxvdyBmb3IgYWRkaXRp
b25hbA0KPiBkaXNjb3Zlcnkgc3Vic3lzdGVtIHR5cGVzLg0KPiANCj4gU2lnbmVkLW9mZi1ieTog
SGFubmVzIFJlaW5lY2tlIDxoYXJlQHN1c2UuZGU+DQo+IC0tLQ0KPiAgIGRyaXZlcnMvbnZtZS90
YXJnZXQvbnZtZXQuaCB8IDIgKy0NCj4gICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyks
IDEgZGVsZXRpb24oLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL252bWUvdGFyZ2V0L252
bWV0LmggYi9kcml2ZXJzL252bWUvdGFyZ2V0L252bWV0LmgNCj4gaW5kZXggZjMxZGNjNGZiMWEy
Li5hZjE5MzQyM2MxMGIgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvbnZtZS90YXJnZXQvbnZtZXQu
aA0KPiArKysgYi9kcml2ZXJzL252bWUvdGFyZ2V0L252bWV0LmgNCj4gQEAgLTU3OSw3ICs1Nzks
NyBAQCBzdGF0aWMgaW5saW5lIHN0cnVjdCBudm1ldF9zdWJzeXMgKm52bWV0X3JlcV9zdWJzeXMo
c3RydWN0IG52bWV0X3JlcSAqcmVxKQ0KPiAgIA0KPiAgIHN0YXRpYyBpbmxpbmUgYm9vbCBudm1l
dF9pc19kaXNjX3N1YnN5cyhzdHJ1Y3QgbnZtZXRfc3Vic3lzICpzdWJzeXMpDQo+ICAgew0KPiAt
ICAgIHJldHVybiBzdWJzeXMtPnR5cGUgPT0gTlZNRV9OUU5fRElTQzsNCj4gKyAgICByZXR1cm4g
c3Vic3lzLT50eXBlICE9IE5WTUVfTlFOX05WTUU7DQoNCnNob3VsZG4ndCB3ZSB1c2Ugc3dpdGNo
IGFuZCBtYWtlIGNvZGUgbW9yZSByZWFkYWJsZSBmb3IgYWxsb3dlZCANCnN1YnN5cy0+dHlwZSB2
YWx1ZXMgPyB1bmxlc3MgdGhlcmUgaXMgYSByZWFzb24gLi4NCg0KPiAgIH0NCj4gICANCj4gICAj
aWZkZWYgQ09ORklHX05WTUVfVEFSR0VUX1BBU1NUSFJVDQo+IA0K

