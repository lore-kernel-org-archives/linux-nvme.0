Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2149AC4345F
	for <linux-nvme@archiver.kernel.org>; Tue, 16 Apr 2024 02:51:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Cc:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Mw0QqXCbc17oeXSX8U/d8XddrvY69M8VeIRfhRSvR10=; b=PfpgElSY0ORTwDRhKpIdaPs0aB
	XtAJ2XH/mspeVcqHglCm5M5SXJyEJIoU1V0ty9XgemCC26SOCM7FotFi1JO09/qcXCTMrJwtv9Dr0
	Izy3EO72b6UXE+KS5PP6pY7H2nxJsFbAfMVXqoHZI3+xoyOhutu0FwGbC9ozp/gQ2plJ1yU8d632W
	7U667/Lb5QxYm6RdTrz93onKzFNNlhGczEQiWQ6Zcqh8PH4jCgnvLSRiENcKtm1vsaSE7JZx1mSTB
	qMyboNKk8bTmtxkIqLepZhF1gMpDMosO+aeWgf6xWuck4AtkKTSe69abgv2crgg3RLwgANH4i5zYe
	kKZhwVdw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rwYuz-0000000AaHo-2Z04;
	Tue, 16 Apr 2024 02:51:33 +0000
Received: from mail-bn8nam12on20601.outbound.protection.outlook.com ([2a01:111:f403:2418::601] helo=NAM12-BN8-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rwYux-0000000AaGx-20wN
	for linux-nvme@lists.infradead.org;
	Tue, 16 Apr 2024 02:51:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R7mOdQOrD7wf9dIPHLsI48S0zYCiblOc18ml8wxTYB7+UAtEq9m5wfUd85M6dBJxclZynYIR3TiEn5mtf8GXntS2VnsGZLZtUGntXwd0ImbfcN1Lzum2oPhLD/IZ9Pg6hgza3k4PpSPYBTN5InjAh8l0htKy20XF3UxkHoNOCyyAdC59CYwFZgLxs5kdomWCbe7lY27y4UIFhSODCXTFgJpC/Wbfqz6VwZ7rPRIvCi98CHuIr46L1OrlGYMMX3X35xR90qiavdEnh40FuYO2YQKZHJRVCgTM5dhKHC9XFPC6gyVStdwD64YOzcn/766ibjlZQQwHaeqbihW/r+octw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mw0QqXCbc17oeXSX8U/d8XddrvY69M8VeIRfhRSvR10=;
 b=mRhK65/sHVbY3QnZy9pWu4p3bkb+ddWdnICj9PkxC1gBT0XcpHmAxkCrPvmr5067mIHlMgxK1teGwEhbIzWiTpi9KIvbuOVtZkLO1xOTfGLi/EFT3NLJRNANPlXWYLI47MsNi7fVLYiUq345JvYoH/GPE8DLBbVpuKD4WuKIHBb9GocC1a2Ed3hKSEbrHKzHq5BnYAHDA15050r8GHSP+GLwZsqHjzbeVKJXt8kKGrJGr77GFmnbUteWsskRS6CBfWSx3JqEGRB4jjPLVAhVX3id7tKqRfYZATX9biPHwjED4Lu9O8OUWJV0Xf5oQjDeo8NUn4PIqpjknvPfzavPag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mw0QqXCbc17oeXSX8U/d8XddrvY69M8VeIRfhRSvR10=;
 b=GUYVz6sew4SKfPGgHixu1+U8jEDnT4LjEWFBN3sskYnOBS3/iDkPg+d0fls6meIKLfHmWypeJ6IrsmUCUeGcM3TrMU8C1BPdYSNYDOIUyV6mct4+3PRPtyyLOtPsGHZJGUJpyOuN/qIg2pMiNH44M5XQbe0SdaiVwyhqG/tedurTXwnqrGZnAlX91ERboLg0tK6Z5vcmTR5jY5Io5kIJkfKswyfyNDRdsW8FnOoGseEyMnILPTEMdyA3RbFtXmQLJ1Q28lRPGRdK02d1ANKuwUGCx2a1CVTW998gpr5ny0UKm2Q6CeyJ+RoC6EEBwQNKyvx1BQAKCW0iu/h8Qp87Bg==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by SN7PR12MB8129.namprd12.prod.outlook.com (2603:10b6:806:323::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Tue, 16 Apr
 2024 02:51:24 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::a1:5ecd:3681:16f2]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::a1:5ecd:3681:16f2%7]) with mapi id 15.20.7452.049; Tue, 16 Apr 2024
 02:51:24 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH 1/2] nvmet-auth: return the error code to the
 nvmet_auth_host_hash() callers
Thread-Topic: [PATCH 1/2] nvmet-auth: return the error code to the
 nvmet_auth_host_hash() callers
Thread-Index: AQHaiyyu0E1sMWK5/kWjW3JsHUrrabFqO5YA
Date: Tue, 16 Apr 2024 02:51:24 +0000
Message-ID: <fbd57e65-c476-4744-9b78-c958a531163e@nvidia.com>
References: <20240410094842.370170-1-mlombard@redhat.com>
 <20240410094842.370170-2-mlombard@redhat.com>
In-Reply-To: <20240410094842.370170-2-mlombard@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|SN7PR12MB8129:EE_
x-ms-office365-filtering-correlation-id: 2b16bc67-8a1c-498f-4e8d-08dc5dc01aeb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OWN9MdD2FmsDMDqMsFIOww/tkDb7VddlHpP91nvrIX9cQAG39GGS1jMhGSUWgrxuKkRqTJhsyNvPmd2mbDONpt4Zy5D10TF2rqRmdAtSLn7qVXjFIor75NXeX9ByT7ewEeZ5qu9iTn8yjNzQuFWDja643IWsvSdDHRbBFTlvMiqZZlRYWdP+q5CJ8Nr3tnIMbFcHEmXo4z3O6RV6+f+6SgC0PZxNJtzkDANC2aDxjk5Tabx7sFcmkMnORyi7m6d+BkRg4YpzgGOKc1t52YsIhqW8raW56h/H2mflZokwYaeL+tRhRwjS+/sJPzJIAfN8syMYauOfnpT2ISE+zjcb3e7Df/uhAoXN4BcLPL+Qbhr1pI7XYiDB3Dd7QfwQ4VCnjY89zB2JB9vBJtmnWIYy0W2h+thenquyeSKln3JIz4TjukA+TGiBX+71XnQmEgmv6T6D0DnB5sZGxAoVt1/+8qTpvawlBVR10RrjF7KfvAtbpkG0Foklx1qgaZmSnOvJipz7gBI0tw68hmtmxeOg66vRqei3S9GjcF/bpFMMHd7Cavilp03/27smzgtvtEzDrECft5HvDbN0wtdWSictAj0rYldO2jZVRnTQ+OfGCTPtTT8NRjHoTQ1/kmGWNuv2rbUpzQDQr93EC4qKDQfAJmTfhZ+ztunmpYtgkTYQZpi1bii//J5VIvvwB8S4qlZpMFVUTfh/eyKMsMzwPsTxatM+xpLE+GZoYitmwtTBq8I=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WUVmODZxQmxkNUNUMmFsWDZ4bmRKV3dzR20yTm9EQVlldVhkT3dyR292K0Ry?=
 =?utf-8?B?ck10QlljVnBPNXdlbGw4YU02WjZCc0tadFA3ZTVId2REb3FTR1pSOFRJUWEy?=
 =?utf-8?B?TTlLeW82aEdsYmFxOWdWUmdzYlZQdW9oNUQ3N1p3N2h1bGFjTGNKbEh2R1Y5?=
 =?utf-8?B?djlENjJnbGx2V25IUWZVdytlWUJ4V0EzeDU1Y3JhRitmRXR2bUxVUUVtWHNZ?=
 =?utf-8?B?QjJaOGFvclkrVFY2TlhMRmlrcVNLeWtPWENYbGRhcTVndGVYS3ZmR1U0ZSsw?=
 =?utf-8?B?NFhTekZzNS9lMy9WQ1FKd2w5WngwNElDaFBJcUdLQ0UxSDJCWUk0VHFtQ3A0?=
 =?utf-8?B?LzhuMkRSRHFNVlV6T2RyT3ZsaU1DbmJVSmNCa2JiUTFLL3FONkNseGo1SDcv?=
 =?utf-8?B?d2svU3czcHg5eVFjWGpqR01YRmFZMStYcSt2U2Vlai83dDFyU21TNy9hcWoz?=
 =?utf-8?B?RjNRWkIrVnJhMkh0M1ZiYjBDS0xhVXlKVlZHQVJaSFZETHdXVGpJck9ZWEI4?=
 =?utf-8?B?dlgwR0dJdFBCZ2dOVDJ1bUZEaG1DeWthY3F0UFdwY3J1am9pM0dmdHJIdlpw?=
 =?utf-8?B?RnZ2UjBEdVlDdFBaZ1RXd1NFSVhXei84V0JiNFB6M2JmL1lzRHoxMXpXZm0w?=
 =?utf-8?B?SHh5UDJpZ2VLOVFoOFhpMVhwNEVMdVZwa1FYWFE4NmhneDJoa2ovSnZGakVH?=
 =?utf-8?B?dndpZDlDWkgyc1B2YnUrRmxvRERNTnNOUzE0c3RsNnQzMGwyMGlHNFNZL214?=
 =?utf-8?B?UHRnQXcyUjNuRkZqWVdMa1NKMFJHdmJyeDd5aWJqdUc5NTBLTW52T0FmQXFm?=
 =?utf-8?B?Z3lLNDQ3VVFlZzZ2RDZVcm40cTFuOEh0QUxYQkNGMHBPNTZ3Qy9lV3I3ZDRY?=
 =?utf-8?B?WElkVkpzWjIyZnVoZlJkY2RSdTFmMGtwa1VRdGpvSGRZUkJYUS8rMG9hQkdM?=
 =?utf-8?B?OSt4bUMwQkhTbk5XNjRnYWpVeldMT0NJKzM2QzY5S3FPVEM1NDgrMG02NnZG?=
 =?utf-8?B?YlhKRjJsbnRDLytpT0Z5U2lKaEduU0pCcGp1N3FjK1NiLzIvaDhPSm1EeFRq?=
 =?utf-8?B?ZHg0dEJuQ1RFMHMxdEdEQjBKNis4MTErSVhzdytDS04zblp5ZndvbWxpdmNR?=
 =?utf-8?B?cUs2N3kyR1UvZU1FajV2ZkdUdTRWYTUyYXlHWnQwdlJocDBZSGllUW9xaFZw?=
 =?utf-8?B?aUpCQlBmSFZhMS9nUlhlb0FjOEF1OGc2UUpQRDF4ZC95eEJJM0J3b25YL2Zw?=
 =?utf-8?B?b3ZORm1DeEdSZmt2bjJ5akN2aTdUTng0dEVWcFMxTWwzdnhRcFFDVmdCL0pz?=
 =?utf-8?B?bHdIMUVSS2hEMVFLbnhkcGFTZ2ZxbTZyUFpaaDJUc0UyYkRkVEtvZ0QyWmxx?=
 =?utf-8?B?RmhuUDFHRHhwdmxUTWQxQmZEaWVHc3lZdkZGb1dNNHlIb205OExiQkZZYjR1?=
 =?utf-8?B?TndzQVp2ZHFLR0t2YnZBeWhSeW1JWjkrMFR0dnlUMmEvOHBBSzlzd05rTDk1?=
 =?utf-8?B?U1pZdVcvaHNMby9wRmhNNWxjQUk0NVpudTROV2VHcVgwY2V6bEVvQjcyKzVO?=
 =?utf-8?B?cVhYNGdGSGI1TEpNVXIxdWoyOEUyekl0QjhmcWxBTUZ2ZzIxa3VoOE5jVldu?=
 =?utf-8?B?ZEIxdURZTU1WSFZoVU5OY2J4bWJIQXJESlVEQ1BMMUxOejArTExyM1M4ZnN0?=
 =?utf-8?B?cEFBQkZvZ0FVMzB3VFNJd3RPcUtORi92dHh1WEEvK3ZzNzU1SjVTYTd6Q0J1?=
 =?utf-8?B?Wk5ZK0R3eW9jR2JnSEw0QnJ2ZnFEdTNpWVNGT0o3MVRCVzZ5bzdYdjJFUnhQ?=
 =?utf-8?B?MXV3RCtKalZKSjdhM2puWitvL2doYS9Fa3hiOFp3UktWR3ZIeFRGNkswWnU3?=
 =?utf-8?B?YytMdzdvMnBVeTQrSlFRQitnRzVoWnY2cHJlcEx3STRXSHdQN2g3b1FXUVdJ?=
 =?utf-8?B?b29ISVoyanBWTm84MjVUZHl0dDNMaVU3V1pRSk4rNjFxbUpLNnQvbG1TaTJh?=
 =?utf-8?B?RE1kaTBwVnduTUtlUDZHNkUvTTZKdUU2VGpSZWdpSVIxYWk3TjZrTDN6bk1U?=
 =?utf-8?B?ZGF2TmtMZWltdzFtd2ViVitTOFRYOE9iVHVpRG4rb1JScWZZU2lsaW1UV0ps?=
 =?utf-8?B?VzJBcjUwL1NWamtWR1huUFVNK2pPK0YzZ1J0a1k3VDNSdFRIeEFVb1lJR21k?=
 =?utf-8?Q?0qoAP2ATCixREMuxMZhiA5xQL0BM2caUSk6Nwt8ncRUl?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <14E096EE331AC64090F45940575133E3@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b16bc67-8a1c-498f-4e8d-08dc5dc01aeb
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2024 02:51:24.6115
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3rExMHMqzF/SEo+nmZoIcGPBbaF7phaQ0m6MorCqia7obL4EIZ8cNMR5mBidiFptkLiABN1FZ+Q4dKi//+Hv6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8129
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240415_195131_550905_056EAC00 
X-CRM114-Status: UNSURE (   8.34  )
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

T24gNC8xMC8yNCAwMjo0OCwgTWF1cml6aW8gTG9tYmFyZGkgd3JvdGU6DQo+IElmIHRoZSBudm1l
dF9hdXRoX2hvc3RfaGFzaCgpIGZ1bmN0aW9uIGZhaWxzLCB0aGUgZXJyb3IgY29kZSBzaG91bGQN
Cj4gYmUgcmV0dXJuZWQgdG8gaXRzIGNhbGxlcnMuDQo+DQo+IFNpZ25lZC1vZmYtYnk6IE1hdXJp
emlvIExvbWJhcmRpPG1sb21iYXJkQHJlZGhhdC5jb20+DQo+IC0tLQ0KDQpMb29rcyBnb29kLg0K
DQpSZXZpZXdlZC1ieTogQ2hhaXRhbnlhIEt1bGthcm5pIDxrY2hAbnZpZGlhLmNvbT4NCg0KLWNr
DQoNCg0K

