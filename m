Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB7D2C5475B
	for <linux-nvme@archiver.kernel.org>; Fri,  8 Mar 2024 05:44:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7pcjFZfLo6HwknLEwSyzSSXqPX8JVwCVyCBGKQuvbNI=; b=o4SuQ8+KuiNLIN5dRdvho08E2H
	QVuHuCIfxD/H1ppM78+ZWvmA8Kchyc4X7hpMk0LX2m8BRI9ahMtNnPt2OT4BU6YqYrMYjx+jq2Awq
	xdw5PdPRRuV+E7Jai1ZfmmNFNHnFC8fjbP8/hqM4DsMBO5nqYjzCEr6vVTjzZ6oMrp7fiasDTDmpJ
	sHNLNVZrQFjAFwgYF284L7OsWg1mbB4mFN+7mL+jG93i+Z4xrD0RN0gKrNW+6oR8vqejr8GeDuakB
	Dyjw+URFeGnQ4b2H7SIs9p8rTztSSkxOSVU8zIdycm1KIk6aGSzCMenMiJiVeD1mZwsLXJ83gdf/J
	hN7V+B3w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1riT2H-00000007v2m-0jxa;
	Fri, 08 Mar 2024 05:44:49 +0000
Received: from mail-mw2nam12on20601.outbound.protection.outlook.com ([2a01:111:f403:200a::601] helo=NAM12-MW2-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1riT2E-00000007v27-05LJ
	for linux-nvme@lists.infradead.org;
	Fri, 08 Mar 2024 05:44:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZCLFulOPfh2AphOWklwCLrXOWL0rqXvcchknw2A95SvKiIO6Z1Y6K9c4VOCV8GBt4gDt6cHafPQAzdwiBzvSEnivqIonU9AiijlAkpaYEoPN1bzC7N/lmiGtoRCwHPf6W7LmiaDerr4dj9qQWHVf1vAfNbJgBnHee5JBy7VQdnXP0SAAvytdnCCOCmQtqLdRInMDTIxXY/AGCQLeVfY+yv70yYP8dacul4o37vYthpmIQ8vF+gb2XIVUU7lX01wbCq8BlynbIZmzPyc6peLsmO0P0KKqxg1zAmFfV8fm+9v8dE31/RqZlpuiLYOZMTWrQ9oFKCnOQWVO40Lpw6bg5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7pcjFZfLo6HwknLEwSyzSSXqPX8JVwCVyCBGKQuvbNI=;
 b=WC1igZFfBvZJM8W4L34TUebXmiUc6DAtUUJX5eN40YtKrvAb0kasKiogUzHQ0qJVk3XGdDcKjc/lCLSqd4oEPce58pEuUSqSzCDoTlwXXDpkp09AIQotQ5pb9uo32ggcAF/31Vde6rC7FfyOql8UvTts7bgPkKiyC6iGcI1jmcb3MSoIM0EJOp42G6Qpfm3uLd/nMx8HmnqgS7Bd2olwrAVzHVOHjCYa9q1Kb+LPeBzPEJUg8RMqRloAwGRGOb4+evNXEDDCHh6zHLJPgN45XKh2hzHmM5Zcq7cQqua3WedYeE829g4xWpbpfLStDypAspRnuNmKYIvOQApmvRxBew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7pcjFZfLo6HwknLEwSyzSSXqPX8JVwCVyCBGKQuvbNI=;
 b=JEzhZaT0q9oLXlnbmUfvxgQgYIV3Kyvog6auM2ZKRlt1VVBwWy1cxZj6HoGz5F3ZZULuq1US12cul+77ialQVlFus4VHy+/+UK9UVN0J24/C9osyrFbhxify2pXfDY/+JN5nLWUXGtoz1ERlhCj+VJG0KkLCWCsUCCEotIzl7pTrgjfsxgb4ML8zw4OTwGdI5tJ4+AIgpL0aiC+xyXJV5HJAWo/Li9JcO8dKn+fxRzJDdeW8pErImbYAAmcDnN9+ebKahU0FxQbiJIBsruCDAU8htyWwveObtBXHc6N3gej3sF6WLhf6rSMfy4++WOHc1NxlGFmhBxEmkBU1dcdz9g==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by PH7PR12MB5976.namprd12.prod.outlook.com (2603:10b6:510:1db::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.28; Fri, 8 Mar
 2024 05:44:39 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::a1:5ecd:3681:16f2]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::a1:5ecd:3681:16f2%7]) with mapi id 15.20.7362.024; Fri, 8 Mar 2024
 05:44:39 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Guixin Liu <kanie@linux.alibaba.com>, "hch@lst.de" <hch@lst.de>,
	"sagi@grimberg.me" <sagi@grimberg.me>, Chaitanya Kulkarni
	<chaitanyak@nvidia.com>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH v3 1/2] nvmet: add tracing of authentication commands
Thread-Topic: [PATCH v3 1/2] nvmet: add tracing of authentication commands
Thread-Index: AQHaaiF3WNbJy4YkHkO33V/qRiBtSbEtYywA
Date: Fri, 8 Mar 2024 05:44:39 +0000
Message-ID: <89139c83-8583-4fa3-b215-3b54c25bf866@nvidia.com>
References: <20240228083755.125259-1-kanie@linux.alibaba.com>
 <20240228083755.125259-2-kanie@linux.alibaba.com>
In-Reply-To: <20240228083755.125259-2-kanie@linux.alibaba.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|PH7PR12MB5976:EE_
x-ms-office365-filtering-correlation-id: ea0a9b85-31c6-4a95-1669-08dc3f32d882
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sKHdkr4Zbr4a6b4eUy47xpY5NTed9yEvIcWG3vhIVPuPSl3XPcMTAxR058Du+RyifY7boiULINbZgHc4vYGDappcPMkB9GkWvkIhq5FzxMxJ3QfbBpaJ4+GlhJ5BB2ywN0frBGedSShZ23RPfuN9JE2n7Cd6+UxzhZvLI2J24RYrFnbpDuIH35zI9SLWstfZUB18RDuhJqdi1Kj9J4azgfCPEKUOEf5bGFJTSJ4bFxC+iqXVARw5w5V8EBFcW9ZCPn1J7M7jvytU3rWZyGIuzLDdanlSTmn9ZtF/1h5tkBjQnH/xZbgSMgywQTl7OGVgGptTf+d8SCOcs0g+XKNc4acccIxUXr3d55RreUX/g292HnbgCYlToVU9KuaslhI5NAQngmIkuMWvGVbokJsFxzH93LF7EyRANLo5wTED2Do8/ldEv/xGPs8qPSs9hMUqHN8ZArxpMjGJR1LJHiRc1rK3HdKEFY5YrSSHcUKkMtpxU4hCyDci/eGHlkU+D4jwBf0/N7y6bJWXsvW5mYeePiZPUhNaXMoQj+gecN3/dMWZlRiEtUxCfruSFR3xX/SnQtvLPcffh67s/xLwdUx9JFtHBLB0IUUl3NiTkFWA4xUwGSdw4u8vrtePKdOedw42m/73G+bnslheadNY1L+CAjWxE8AtFoceeQe2agA+2Sphbf4+nCAlFz16vMeWgFYJ6FRwvCmXuUogNmKSBKCjkg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?N2NwaXU2TzBuQzRhMVZEVVFqbnFiWmtNSXduaUpLWFlJY0Nsemo2ZUd5NVQ0?=
 =?utf-8?B?aVFDNGk1UDBZOGM5NmpWdmUyNWg3dUpzOTZxK0ZiR1llZGt5Tk41aytYVmVt?=
 =?utf-8?B?RGwzaEx6elRBSHYwTHNuVTNvMzk3K2h6MHZOWGsxelVaSHBjQ2gyNFlMOWJ2?=
 =?utf-8?B?aVdBa1Qyb21hblVQSHQ4YzEyY0ZoSWlGZUdUMnhET1VrZ1dmeHpzOTl0ZXh0?=
 =?utf-8?B?ZGN6c3dtRTlYclZIWFkreHZHcnlzS1JZTlVEM0ZhYUlTZ0NidVhQNlBpMFBh?=
 =?utf-8?B?dllvajZLcXBYODhnVGtVMmo2T1JsMWxNRmk4bVpXZ21zRTN6dGI3WGdTS2hR?=
 =?utf-8?B?blBWQmFOZUZybXk5TDIwWGE2Sm1kaUFRTXE2cnVJTmtzOUdWUlE1cFo0TWp0?=
 =?utf-8?B?bUdqWDdqem5oOUlna0N5YkEzalRKOGlIcGxONFExOGJDRXVFWEZOTkhLQXlY?=
 =?utf-8?B?eWx4Q05nVHZnTElEOG9LcDRSQ1JsbDYwZDBQMi9qYy9XS1lpbnBzblFQL1Fi?=
 =?utf-8?B?N3RaSkozQlRXZmFsNDhYVW1DOW1KRHJQMjdKVytYQU9Zcy8wdFBXM3Z0ODI4?=
 =?utf-8?B?KzBZaG9CRitlVHpVT2lXWVlzRTVVcXZqOGdGTHhuTHYwcklpNmltSkNOUzhv?=
 =?utf-8?B?OTZoSkwwdzQ5MFlDTzJOVitsN2c4dU9SZnpkTnJJS3Q3cUFiQ1pNZys4Tkdw?=
 =?utf-8?B?S0p6QkUxSytYZUN1Q1Y4NUIwK0FnWWtMNWxuVUdQdXJCWnlueExlY0J0Q3Zr?=
 =?utf-8?B?cXdpTG9mWks4NHBqb3VlN1JvVzZHSXJUOEZEZkwvUnVMNEJPVUI5UmEyWTBR?=
 =?utf-8?B?Zy9qSmEraFlHU0dMOTJNcDZLMm5NcDVQU2QwT283Q2dha21KcFdySkJDYjNN?=
 =?utf-8?B?UitRc0VwVml3M3lJVjBGVnNKYXZpN3dobjkyTExOS3lHSjZ5MDVCTDcrWU53?=
 =?utf-8?B?dDBvRU5jZENHU1o0YnZvYlZCMnk2K1QxVll1L21aemwxcUpqbThxbGdLUnc2?=
 =?utf-8?B?OE1TOW5raHBscG5LTnVpZERFK09LWWpLeEtBaEthQ1JURGpGK2JydzAxNE9l?=
 =?utf-8?B?anEyUTU3dkFoVWsvZVU3cVJ4djBMV2RUWjliQU5JN2g4bXpjRTNuUWhXT0RV?=
 =?utf-8?B?TUt3bnYvRXRKeDZvektLZXJubVBoczQrbTRqOXZQYkNhT3A1TkpleUxTeEpl?=
 =?utf-8?B?R0YycTQ2WDZqWmhqbkpjMEM5a3VNcUs1TW50aEpJMkhGaVFPdmk2YkE4ZlYy?=
 =?utf-8?B?cG5oMCtORHNqbTlJQktkMmltSmxZOCtwdGFVL055dS9OazQ0c2t6SDV4N3VX?=
 =?utf-8?B?aW9EaTNWVzZ4aWZrVm5RSmh2bC9NNllLZlhBbG5iT3A5cUgwenh1cTc4YjNR?=
 =?utf-8?B?TFp0Y09SK3Q4V0hGU0F5dEl5RmJ2dmtidGpYbUUzQk12N20waXExR2t3MHdr?=
 =?utf-8?B?eGZyZGtJK05NNVdCM0lmbDFvVHNHaXJyQ21vOFZsdkI5N1ZpUk5TSkh2c0I1?=
 =?utf-8?B?QytMalhnY21lTjVVSnliUVZGZVk5akMzZnFjUE9TNW5VK3hxajROcENndHU4?=
 =?utf-8?B?RmNpTkJ6V29hSHAxMGQ2bGZodGRMU3RKTzV5MmkvVlFDZmcwWllGWVhhQnVK?=
 =?utf-8?B?VDlNR0UxcjhpRk9UcWZSa0cyWGVwTWFDZ3pTTU9ySkE4R2daWHVzcU1adllQ?=
 =?utf-8?B?N3lyNGpYb0FUZ0NwRURKQkZoM1JWMk56S2t3UTZUUmRpd2ZaWTV1cE43VXd6?=
 =?utf-8?B?QkVIRGRsd2xoNnlwaDdhZG1IQ294eFlZd0FxRmxHNHc3dE5CS1FWbnhZNXdr?=
 =?utf-8?B?M0Z6L2NhMU1oZnJkemNTU2VvaWxzV1lrdHRBZ0VlOUc2M2syYnRPald6V0F1?=
 =?utf-8?B?OU03WUtXSnlKYkx4cnF1WTgwMjNySm1HMzlaQkhNVDQ5YVB1bFhNTGlBc1N2?=
 =?utf-8?B?cE1ZMmZYWWRrSWhSNXZRaThJUTRreldYRElrMFEzd1ExU1FQQ1lScm90Qm9y?=
 =?utf-8?B?bFQ2RjdNRnZjTWNKeGZTQkNIOEVCS1RmWkNxdi9JeWJQcEkrNHBSS2hpeVFJ?=
 =?utf-8?B?anVoWENSZkxEampxNWlpd3lkby92RnZNOGVGUVhzYW9EVERBVW9rN3ZYOWd4?=
 =?utf-8?B?bm1xZ1JoQnNwa01TblZGd2FqT01DRERNQVFyU2NXYys0RWVobUlFd0Nuakp2?=
 =?utf-8?Q?mzAix90FhvgAKzuCT+iD2jukwiq2YHvQy1y63aYPXoJ8?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B1E5F409478D704AB28C00276A58B5B4@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea0a9b85-31c6-4a95-1669-08dc3f32d882
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2024 05:44:39.2987
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6T18yCzu5lK6+3+MaggaOzaJoAgPGU3kH9LVaNwhtT49mh6F7+qCfvsL9PkpKPEXr7jdqXfqDAooIesr/Dk2hA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5976
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240307_214446_200415_941860F7 
X-CRM114-Status: UNSURE (   8.12  )
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

T24gMi8yOC8yMDI0IDEyOjM3IEFNLCBHdWl4aW4gTGl1IHdyb3RlOg0KPiBBZGQgbnZtZV9mYWJy
aWNzX3R5cGVfYXV0aF9zZW5kIGFuZCBudm1lX2ZhYnJpY3NfdHlwZV9hdXRoX3JlY2VpdmUNCj4g
dG8gdGhlIG52bWUgdGFyZ2V0J3MgdHJhY2luZyBmYWNpbGl0eS4NCj4gDQo+IFNpZ25lZC1vZmYt
Ynk6IEd1aXhpbiBMaXUgPGthbmllQGxpbnV4LmFsaWJhYmEuY29tPg0KPiAtLS0NCg0Kc29tZSBv
ZiBteSBlbWFpbHMgYXJlIG5vdCBkZWxpdmVyaW5nIHRvIHRoZSBsaXN0LCBob3BlZnVsbHkgdGhp
cyB3aWxsDQpnbyB0aHJvdWdoIC4uLg0KDQpSZXZpZXdlZC1ieTogQ2hhaXRhbnlhIEt1bGthcm5p
IDxrY2hAbnZpZGlhLmNvbT4NCg0KLWNrDQoNCg0K

