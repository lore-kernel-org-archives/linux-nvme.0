Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3215C25B75
	for <linux-nvme@archiver.kernel.org>; Thu, 23 May 2024 19:33:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qbY3K47NJYoI3RmtLZOhTg0emOF4yWvQrNYoA1GewCA=; b=WNrW8hR3hHeHh3uvD+r16ztgtf
	HD++E3aGB7/6Ro321u4EGvu3hxRu5y8OmXKps+k7mnpl8RXu3QWLQHrAhE5BNONmFEzv9MAufUr8+
	giO9syK15s3fzfBIaxfmGkGE/RyEemBhY2Fx8PmIQ8lxMAWPZuMSPwF/exDU8JuDTu/wXp8jhp2nw
	3oMd7ZVQAEkhh+hGp7EE1e1fLgwX1HIyS2kNh3hvjWXV3PivLDjpGOdkz9Lwg2mvpacGQTj2b343c
	0TUcV5hL/UIWUag651Ygl9+XwaEcY4/SP6szqKJ7xHPoip39xF2/0hGUCjGlq7QTiDSNN01yhdEqX
	/7O1uGDw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sAECL-00000007A48-3tlv;
	Thu, 23 May 2024 19:33:57 +0000
Received: from mail-bn8nam11on20601.outbound.protection.outlook.com ([2a01:111:f403:2414::601] helo=NAM11-BN8-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sAECI-00000007A2d-3sIg
	for linux-nvme@lists.infradead.org;
	Thu, 23 May 2024 19:33:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z4XyjrKQBUZ4PmkyycsauY+8EoeAPfojPbimlp4GiSiDtz1eO/2bhZAzOkqaAK6P/S7tKD6aRIbYg3bbkHA1iOlqwf9asAXxChV16B8uLv8ifApi7wPrHAOeEnM0i0Y8GgALGpEn8ffpeAq9dpvhXLY6zUKWU7Q6A18sGqgo/Bc1J7QrH444du0mxB78wAUfr9k2airvOkY6BDoCC9S0NXCSPKkXeHdnf+QyjkkKR78EMpSDc+d3+O0i/unOgn+PYzfQxbN6SeDv6UhdiLcz/wShhK1tCSE1QBS/tXIF6p0sdpMwYIdeAm6n+5wHAD6PAarwkZzt2VKmJ71XPnTJlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qbY3K47NJYoI3RmtLZOhTg0emOF4yWvQrNYoA1GewCA=;
 b=YlvNYo/iAuIvYnxY5Gezy9li8Qw/R5rJ7q1umLzwwGXCEUxFs5tzcktbwpnnSTnU+QQ6uOTiPzfRkY7NYazWrWy4//OI4WxIqiEnpaIUDXq1kP7OjPaeClLavgXXQ8iXPOIlNR3/8AKHbrx6xGpxcY7gDxCqOXN1UDCtwgiTtLRLpF8VKixCvSQbSA6BBOH6trIJ/vFyu2bbn3RNSWhx9SNdGi2Uo1oNqZE+jWk5kWETXAFaM+AQgfLlkyYsTIEP8eDyszQiP+z1r6Gd2VNcrgHdKpFEyVtObZS6xKXqg/exy4Iktpu57Sl4FShJRe8+YmJLgOn+bG+2VZpyt26gsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qbY3K47NJYoI3RmtLZOhTg0emOF4yWvQrNYoA1GewCA=;
 b=ouGoSXnT0ZZqSrGd+UrFUhYgaeGvkQuLzDARRm7O3dgkRc/l1wcML9nsGYH+Pxq0RZ1Z/DnE3Fg+2aTZrzp6M5OQORp9LIGHJ8tEtGHEZFN5HIGFF5l8NjEpmfiM4U+dDErFZXph7Kdc5YY2IUqsyafb1JNv6cisUJPwDXeJSp0sadt0Hkqn2BZDON43XZppB8nxBZSGmsqRFcgd0tLVuNgzN0Wf59RpzaeydFBK5VR51joc5CcjQXivwsAWJAA7bLHjPmSvoecoD6wbWzvBSXAYhmG1hQKVJIWkPweNHEXbdd9J5g+NOvIbO6SvTJjN6Emqu61bpxuJf6EzqkZbSA==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by PH7PR12MB7308.namprd12.prod.outlook.com (2603:10b6:510:20c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36; Thu, 23 May
 2024 19:33:39 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%4]) with mapi id 15.20.7611.016; Thu, 23 May 2024
 19:33:39 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: John Meneghini <jmeneghi@redhat.com>, Hannes Reinecke <hare@suse.de>,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>, "emilne@redhat.com"
	<emilne@redhat.com>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"hch@lst.de" <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>,
	"kbusch@kernel.org" <kbusch@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "jrani@purestorage.com"
	<jrani@purestorage.com>, "randyj@purestorage.com" <randyj@purestorage.com>,
	"hare@kernel.org" <hare@kernel.org>
Subject: Re: [PATCH v5] nvme: multipath: Implemented new iopolicy
 "queue-depth"
Thread-Topic: [PATCH v5] nvme: multipath: Implemented new iopolicy
 "queue-depth"
Thread-Index: AQHarGjF7HO7Dhk/3EeKOsPlzX5snbGkOs4AgAAhN4CAAHlRgIAAYhAA
Date: Thu, 23 May 2024 19:33:38 +0000
Message-ID: <93b0f8fc-e6d4-48a6-8790-a9e7cf649b63@nvidia.com>
References: <20240522165406.702362-1-jmeneghi@redhat.com>
 <935f7e10-ccb4-4891-8f29-84909c061e7a@nvidia.com>
 <60758e4d-4bdc-4a99-a151-a9009a8a460f@suse.de>
 <4d90d565-c156-4e4c-8a16-f32aa73fc809@redhat.com>
In-Reply-To: <4d90d565-c156-4e4c-8a16-f32aa73fc809@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|PH7PR12MB7308:EE_
x-ms-office365-filtering-correlation-id: 43b0401c-c143-465a-50b9-08dc7b5f3f1a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|7416005|376005|1800799015|366007|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?NVdQc0JxeXU2aDBGMlJ4VXR5ZHYyT2RPTlVVcEg3RDRPeDQ2NUpaWWV0NDhZ?=
 =?utf-8?B?b0x0UFZDcmJJdloyNnRJQ2ZmMGRsR0dkY1kzRGxidTFpK21DeHZqNDdtcWZS?=
 =?utf-8?B?aExOSFZ4M3pKaXBzUk4rRzVjbFEzamNrTVpaSjNEYjZJSUM1TmVNdDd4ZEg0?=
 =?utf-8?B?VjBDWE94Z0pGTVlTalVWajYzZzZONCtlYTJFYi90d1lNUWdmdDk5TUh4L1Q0?=
 =?utf-8?B?cU9xQjZZYWhES3VUSHkxaFcvcDZjTHZ4SCt5UHJOdFZML3lqME40UjN5TEUv?=
 =?utf-8?B?eUxzNy90L3RMeUZHWjlPVDB0TGFSZTBtUmdBeDFvY2RmU29nOStVdzJiV1hQ?=
 =?utf-8?B?UjVkSm9mbjlUelBFNlpTbSt4RGY5N0czbTRBUVpPMk9MVTBwYlNMVEJ2cSt0?=
 =?utf-8?B?RTJ2U1djOGdzamxScmh4b1dGNEUzVzYxWWxGOWJQZ0dnWjFVa3oyWlpkc3p0?=
 =?utf-8?B?THZqZ3ArUWQ5eHFnQzJIRTE4akd2WFh2S1ZBdjAwdUxBRmg1Rk91bGxMdzF3?=
 =?utf-8?B?T2QzcGR1QTl0SkllYzNPS0ZoL0RrRlcvNkFQQjNEdFN6WE5MclpsR3ZSbDFs?=
 =?utf-8?B?d2NYVjNIb3F0Ym0rRmY3a0t0aXQxNG9VYzdSZWYzWkkzZjg4TTMyVXR6aXNn?=
 =?utf-8?B?YnFIQ0cxeFdDSTZBeGJ2ZjloRGNaVWtjcGRReVBYVklMbU5TR2hzWVhUaktQ?=
 =?utf-8?B?WWM5WTluOEJ5WHBOUjR5YzhLSUZzRkFtSFo1ZXA1bENEZEhyRGlCRkJJOURK?=
 =?utf-8?B?QytycmRhcGFTNTJxNjJ4MHFLOXlCWGE3VTZFc25iUCtoaDFYOEhkcHJWMmE4?=
 =?utf-8?B?T01EazBTZkplZmxydis2TXFDNkdrOHY2dUFEdWRrOU5JU1lST2tTa1dOQjFt?=
 =?utf-8?B?SXl0c1J1d2Z0YVVDYW44YUtpS0xiMFZCN1h3STJLN3NUSnYrNnl0eGRrazFG?=
 =?utf-8?B?eWtEdG9IZXdBNXlJNWZBbTF5czRzZ256dkxOMG9Pa2NlUGY3azRBM2dlNWVl?=
 =?utf-8?B?dUJDZ055K1NkMlpCNVdNVWc0ZnAwM0xWbWtheWY3N3NxdWdkNHcxSFhGWWVF?=
 =?utf-8?B?WDQzaGgvSm14by9kTmY4c2NkZ0VsNkVGRW96Z3VwejBDbDlab1RlSjZWRHl3?=
 =?utf-8?B?VFR5RlZTRW5nMC9NcWZ5VjlzTjNMais1WUNTdk9LUUhsbk5aanh6QXNUY1NR?=
 =?utf-8?B?bUJIelF4ODd1N09qUFJIZ2x5RUtDeVI3ZEVPSFdoSlMzNUZyand4ZjV2Wkow?=
 =?utf-8?B?SWJocGppOGQ1WDIyVnBQMzJSTDEzVGExWVNYSk03QTk2VmV3VTRIaG55dytT?=
 =?utf-8?B?amIxbVc0ckdRakVaUmtibUhiWExDVG5oZUNNSjlUQlpqTkVSbTZjWXNGL0ww?=
 =?utf-8?B?Z3VEdWNNWlVCM05BVVJ0VTJQaEZQU1pVc0dpUENTN1YzaU43MmRCUlhOdUI3?=
 =?utf-8?B?TzZtUWZpUDNQcGMvcWYvc2Q1RkxkejNlMjhYY3ExclcwWDd5SWhtbXpzWXMy?=
 =?utf-8?B?V1V2bTVNSEdKcFFkd1VKcVg0akpUTzVqY1RIdnFvNExQOTc1ejRHTDdveVQx?=
 =?utf-8?B?c2lBd2Rka1hqNkRscllBZXdLbmFaemZmdytIdHY4c3QxV0czRWYrRDkveXJl?=
 =?utf-8?B?NFJ5L1B5RzhkU2k2c3F4TzcxZlVpMTRSektZbHRsbTNQNWt4Uyt4QUpIRHZU?=
 =?utf-8?B?L0t1eHcvb2VITUpMODNramNRYjlxQTR5WUxtMlVubWYyQU1LY2ZXSThGbU83?=
 =?utf-8?B?aVdSUTdnZ1VVdkNVTG1GSk90aDFRUGh5VGFIVnZzR2k4ZERCVUpIOE5zN2ZB?=
 =?utf-8?B?Rk4vRjhUZHJHZ3Qyc1p0UT09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(376005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RVAzaHNFOXRrcS9mZnY5Y3ZRdDdRdklmUUdoa1l5SkVRbXpIeFVPTnpsSzNy?=
 =?utf-8?B?N25PZkswMzhhRkxTUzlMUkt0aVlIZ3l3MmR6anlPMzJqSXYyQ2FTeE5IT3dI?=
 =?utf-8?B?dkJ3MGJ1WmxjTHJndE5BRTdtc01CLzlTMUNIK0FPbTVycXZaMktmWU1JNDRQ?=
 =?utf-8?B?UDU3R1hZSTUxazVzZFpEcXd6MVVzUmpMVElSclZwMkdqSUR2NXJ6NkNRQmk1?=
 =?utf-8?B?bVVUbmRxWEVmTEhhekdFUkIwSkR2OXlyc2ZGakJwSnlRRUZUNFJObThWSXl4?=
 =?utf-8?B?K2JHUFpXc0RYSTMya2dtVGRxTkZuMDZnaUw3YVgrMys0VHpDRWliWlkwaVYx?=
 =?utf-8?B?M2toSUU3OHZya0J4NG5Lc1B0Tkg4RjFWckdQUGR1eFlsWHJyWVVBN09JUW14?=
 =?utf-8?B?RlpTVFZwL2U4QmFQd2NPQTRneENGQTRnS29nSXlBZHNMKzUrcTlQK3JvWlU2?=
 =?utf-8?B?MEpmNytLS2FsaldibjkvZ0JaeG1uVTFETE1ZL3RYd2tQSjl5MHFOemdwcS9i?=
 =?utf-8?B?M2dLb1hFQlNOdkU0RDl3S1VMTXRmNmsyTFdQNW0rQkR0UXpSb3d3VDlRV05E?=
 =?utf-8?B?MUF2cWxOZUNEcDBkQk5rZG1wVkkvNGRtOU5Ja0huTkVZanJ5ZzI1WTZzTTFD?=
 =?utf-8?B?WUVxMlppV2huenFGT3hkcStzeDR5cHpEaS90ZlozNmQ1WFMzRHlhdzY0QkIv?=
 =?utf-8?B?ajhQMkVLNk9yM3RaSWIvSjVQWXpENC91bDJsY1VCRVVBb2hSeFpkdXlRRlRv?=
 =?utf-8?B?UEUweEJiNEphTy9WS01rMUdnVzI4dUkxRXZWWDRPR0Q2b3VwOXJ1WGFidm1F?=
 =?utf-8?B?OWM2WUN0YXRwbWhNbXVPNlI5OGV3QTVFcUFHa1JDcW1vMUNRajZZbjQ5SXcv?=
 =?utf-8?B?cUZxUXk3akpFbXN1dTBmOUdKeUlJTGlJbjJEUWhwdlhhQkUxdFJ5TThhT21w?=
 =?utf-8?B?ell5d3lybUljUVorYllwY25jQk9xMnI4aU5ZdnU2M1lhc2RMSEdlSU1rSlBu?=
 =?utf-8?B?VmNLQlJzSzBZK3g2dXFnaW95SlRoYXc4SUo3cDNxUHEvaXFLSnM2RXQ1cjVX?=
 =?utf-8?B?TzhvdXpTeEJ1b1N0bUtiR0lFV2hmT1dXZEt0WmovbExvZm1hZDkyeitTWTZ1?=
 =?utf-8?B?Zk1rbEtTSXAwSFY1WUdSWndNVWtpVW5xTlh6ZDZYeXM5Z0lmL1A1K0szWm1O?=
 =?utf-8?B?bk1PUW9kYkJFSEtpVDFaanNrdjFPdVlFdjB4dEhrSi9TVFRCYlFGQXJZdncx?=
 =?utf-8?B?V3V4eE8xOGJOOGN2WW5lVnpoSzh1TjhNT1MxWTNMYVgyUVZaV1dWUC9YYlVT?=
 =?utf-8?B?MkZSMTlnaUYzWmU0Wk5qVGgzbGJxUkF1dXlYK0o4c3NZWkxNTjlrT2ExeHha?=
 =?utf-8?B?UjJaaFNjb3NmUWsyYVNUTjRIZENFc1FqNVFib09ySlRZYS8rK1NCMC9namFt?=
 =?utf-8?B?NDBMS0NLZHFKNEZ5YnJFU2xQT2tsU1l4RWgxK3VSSW5rTWtKOC9SMks1UFpl?=
 =?utf-8?B?UTM4YnRDNlhNdkt3NGNTODNuZmVmcGtnZ21waVRjUjBOUHIrZ3Y0UzRoVlRG?=
 =?utf-8?B?b1dqK0wyWEUydXUzYkJPRXNCaDdYOHlBclZCdXpFMUFGZkswdkZoYVFNWkhh?=
 =?utf-8?B?WjFFZ0FtQTVJUmJiRk4zemZNdytaY3pxVEUrMmVXblhvbkllYVovY1ZybU1S?=
 =?utf-8?B?QlQ2b01Pc1phbGNMUS9OZVBSb013RUV2c3diNzV3OGZHTU40Mi96UUdEamhk?=
 =?utf-8?B?MTdNc2RxMDhqZmJocEpLd1hEVnFNQnNUeUlnM0Nid3pLaXJVVjBXTi9aZkpr?=
 =?utf-8?B?bGVDVjQreFlVK3h4Rm1VQ0FWV2FiaEFJWEFqUHVmWWdxZlZEZUlSWjFKcXZx?=
 =?utf-8?B?dWJJQzloTE5FMENKOGZ4Ri9DVWdjZzBic2xVM0ZLaUFjK092QTJjOFd4eHlw?=
 =?utf-8?B?OGJQTlVBUndnb0JmM3QyRkJXUnE2K2hpYUkyY2d3YkI2aEtJTi9wTWYvZDZJ?=
 =?utf-8?B?cERXaDhPcEhrSHRrK2x2TWdTMCtLWXJ2S1NFWG1TRUR5cVB0YWlyU0RRMEhv?=
 =?utf-8?B?TzJ5VU5OcDJpM2FCMnlsZERRUW9QY0h3OFNZaGVoeWNvb1o3SnBJRVFWNVpi?=
 =?utf-8?Q?VFtmUmS+RgrKm02IcFvVrUceN?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <28FBC3E28BCA5D4081E0651AA0FD9A35@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43b0401c-c143-465a-50b9-08dc7b5f3f1a
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 May 2024 19:33:39.0031
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4HmoTZMnLvLvPv+qH1YF3nuUxFmY2eLOL+fi29SyL9XVO572D+j3E4PjZf3rVpsgEnkyZkFePCl0gfcCVq5V9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7308
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240523_123354_978493_C8BA10DB 
X-CRM114-Status: GOOD (  12.61  )
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

T24gNS8yMy8yNCA3OjQyIEFNLCBKb2huIE1lbmVnaGluaSB3cm90ZToNCj4NCj4gT24gNS8yMy8y
NCAwMjoyOCwgSGFubmVzIFJlaW5lY2tlIHdyb3RlOg0KPj4gQXMgcHJlc2VudGVkIGF0IExTRiBi
eSBEYW5pZWw7IEFMVUEgc3VwcG9ydCAoYW5kLCB3aXRoIHRoYXQsIA0KPj4gbXVsdGlwYXRoIHN1
cHBvcnQpwqBpc8Kgb25lwqBvZsKgdGhlwqB0b3BpY3PCoHRvwqBiZcKgaW1wbGVtZW50ZWTCoGZv
csKgYmxrdGVzdHMuDQo+PiBBbmTCoHdpdGhvdXTCoHRoYXTCoHdlwqBjYW4ndMKgaGF2ZcKgYcKg
bWVhbmluZ2Z1bMKgUUTCoHRlc3QuDQo+DQo+IFNvIGFzIGEgcGFydCBvZiB0aGlzIHBhdGNoIHlv
dSB3YW50IGEgYmxrdGVzdCB0aGF0IHZlcmlmaWVzIA0KPiBxdWV1ZS1kZXB0aCBtdWx0aXBhdGhp
bmc/DQo+DQo+IE9yIGFyZSB5b3VyIGp1c3QgdHlpbmcgYWNjZXB0YW5jZSBvZiB0aGlzIHBhdGNo
IHRvIGEgYmxrdGVzdCB0aGF0IA0KPiB0ZXN0cyBtdWx0aXBhdGggdGVzdGluZyBvdmVyIGFsbD8N
Cj4NCg0KYXMgSSBtZW50aW9uZWQgdGhpcyBlYXJsaWVyIGhhdmluZyBhIGJsa3Rlc3QgaXMgbm90
IGEgYmxvY2tlciBmb3IgDQphY2NlcHRhbmNlIG9mIHRoaXMgcGF0Y2ggYXQgYWxsDQoNCm9uY2Ug
dGhpcyBwYXRjaCBpcyBtZXJnZWQgaXQnZCBiZSBuaWNlIHRvIGhhdmUgaXQsIGJ1dCB5b3UgaGF2
ZSB0byB3YWl0IA0KZm9yIERhbmllbCdzIEFMVUEgc3VwcG9ydA0KYXMgbWVudGlvbmVkIGJ5IEhh
bm5lcyBpbiBwcmV2aW91cyBlbWFpbCAuLi4NCg0KDQo+IFNlZW1zIHRvIG1lIHlvdSBoYXZlIGEg
cGF0Y2ggZGVzaWduZWQgdG8gZG8gdGhhdC4uLg0KPg0KPiBodHRwczovL2dpdGh1Yi5jb20vb3Nh
bmRvdi9ibGt0ZXN0cy9wdWxsLzExNA0KPg0KPiAvSm9obg0KDQotY2sNCg0KDQoNCg0K

