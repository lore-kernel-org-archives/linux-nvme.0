Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B288C3ABAB
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Apr 2025 16:35:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=50Xg/rv4t01nri/0FpWhP+2jvhe/pefUJYeaawbKZCE=; b=mEvARbjiQlatNLMRWRx+SjdlmJ
	zu3zx06O8zALtwR8Ntb1SrRrVtVbH32y7PjxhvUfN7O1sl92H5/UwGQxuQnbuhXFb4HR4q4vZtfP8
	i5WIi+jMNrvOVD/Op3BWhsD+wWPMeAcqHYIAM1hrpmgBcMng5BnGTGBXxDg2RouMcqJ15P5FNONmM
	dKetBeKan+Ox4pwIkAUpR+h00CYVNe3xap+MDoJ0o80MNiIwYuf2VwMjz0mo6LJN039aJjmmvB5AC
	N9osNROpnQ9rAZV264vCQ3Ac+6t8C4+JXZhZ0cnw0mOlOkb/KHOOMMBpN0QUb3ghS2cGYrLPuWn/F
	44paEgQw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u9nv9-0000000AGoI-0zRv;
	Tue, 29 Apr 2025 16:34:59 +0000
Received: from mail-bn8nam04on20614.outbound.protection.outlook.com ([2a01:111:f403:2408::614] helo=NAM04-BN8-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u9npK-0000000AFpb-084j
	for linux-nvme@lists.infradead.org;
	Tue, 29 Apr 2025 16:28:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q59d/AGWuuw24mlHX0eVhVkPhMbO9vcGUzGK+2Sz+GVPoZYZTIdmOKy8ZdzkgNScUMUOAA0a/kmPvaJvRuaf5FU8dbQ6EzKfmg33M8vsp2dAcZdTLkq+q5G68sovCsEIxOm/0NL57rYVqTqnx/gjvzZmTuo0XX34tdbK6e6MKnkbwh0Lf3f5laTPa3rBJpw4WdJxDIfgcammMSIVpPysWXZ5UFjkNVFL5ggXtkRsEO414S8wtWNwrACwXPxkOxZRKYAYUeWc9wIpfdGVZmJUu7CN4ImmYFkDOunzd+xLK29sx9clzO96Q7QwHkXfPilTjTFo4bCqFxH45hUdthdIAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=50Xg/rv4t01nri/0FpWhP+2jvhe/pefUJYeaawbKZCE=;
 b=muTZmJnpYKmBEEGTA2UcWdcial46GRCClgvLb2do43Xt85SA9HruuUq05CAQ+CfydjeLjMq1PjtJg5Keat2iQOPTG5aQnGwwv+TN3YnrCq2T4LUmB26rxEmgyY/82Gfp+bz4YY/WzJyr5ptgoSddS8rcndIHv8WT8ZasQ0TKNFKOD7F6trC4ZlVNiUBX2whtFfB/hc8oLytY/uYry5e2ESHVifiEGpkKv38rM7uUGCDVVAoR/0zvGsEaMzDOrqZUW8cRNEYWlDDCA8oKWA5JFGCWkonltftoSReyivItC7+JwbEnn2qIxr/zsg2DbRsoYadx4PgE2dyj+2BUKz+oyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=50Xg/rv4t01nri/0FpWhP+2jvhe/pefUJYeaawbKZCE=;
 b=JBHsj6Xm++2IgZiVeaHJaizdLrhfmKIqL7emgn/JeOfJKEd7HmEyS/YCt7acaBJMpw4uOvLOvOgGwPZ7TnxrUxcplPK12IMRpxzc41ngoRXRA4iQPxggzTDBwJNY5BhBcAYyZE/ALdolyBEmezQhMssZHx3cIAj2fIe2kkzbYa2E2f2y0nbtzOi8NZ9yH6DFsWWNsxamYxpSLyygCI9+/1tXG09jq7+xFkoW97OWX00JrgskzhKLbfv2AvgQECHb2YcY5hkSBwgJEXfj9aJQXJzmWkdYpmhl//0Dtla+b1uss4+xqK8igPp6yeqmCnWvywF8N7swW24ldIFNi4wmCg==
Received: from CYXPR12MB9386.namprd12.prod.outlook.com (2603:10b6:930:de::20)
 by PH0PR12MB7080.namprd12.prod.outlook.com (2603:10b6:510:21d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.34; Tue, 29 Apr
 2025 16:28:49 +0000
Received: from CYXPR12MB9386.namprd12.prod.outlook.com
 ([fe80::bd89:c3a2:6aba:1788]) by CYXPR12MB9386.namprd12.prod.outlook.com
 ([fe80::bd89:c3a2:6aba:1788%4]) with mapi id 15.20.8699.012; Tue, 29 Apr 2025
 16:28:49 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Alistair Francis <alistair23@gmail.com>, "hch@lst.de" <hch@lst.de>,
	"sagi@grimberg.me" <sagi@grimberg.me>, Chaitanya Kulkarni
	<chaitanyak@nvidia.com>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"hare@suse.de" <hare@suse.de>, Alistair Francis <alistair.francis@wdc.com>
Subject: Re: [PATCH] nvme-tcp: select tls config when tcp tls is enabled
Thread-Topic: [PATCH] nvme-tcp: select tls config when tcp tls is enabled
Thread-Index: AQHbtQGQAvjn/wXFzk2UMtxhaULWILO63Y4A
Date: Tue, 29 Apr 2025 16:28:49 +0000
Message-ID: <f3282cae-ce46-4aa3-8f55-dcc73da93d0e@nvidia.com>
References: <20250424101333.2908504-1-alistair.francis@wdc.com>
In-Reply-To: <20250424101333.2908504-1-alistair.francis@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CYXPR12MB9386:EE_|PH0PR12MB7080:EE_
x-ms-office365-filtering-correlation-id: f9269823-bf41-4595-a57f-08dd873aec08
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|10070799003|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?eEZ6ZVFqaWl6V2JheStodnRrdkU2REdWNityQWtvVGlIY3JXU3d5RTJMUHFF?=
 =?utf-8?B?WWZtSTdUbUJ6YVozYS9lNFBUUnNqQnk4Rmxjek9XVFhiWVFpUjI1ZDBpVXJE?=
 =?utf-8?B?aEN2VVdkYlQxOW9ZWHF0NHBraDQrT204Z2hTam42VUUySmJhaVpEcmhrNWdh?=
 =?utf-8?B?dS9BaXpRL001Qlk1cHZPZkVRdWxJMEM1bU5nZ2hBaFVPRVczWDhqRmNSTzJC?=
 =?utf-8?B?VWR3dzJBNkNyUGJSODQya1lBTkdsSnRBNEJibmg1ZlRVSkhRL0ZPbGd4bWly?=
 =?utf-8?B?SkhpT1JLYTdGMUV4WnFRczJEU1czQTlNK2h4c1BHVmpuMTZod2N0UjFyRGZW?=
 =?utf-8?B?K3hDM3VlZjV4QUJickkxbWJ2ckJHRkxCN2s0OXpaTWZPWUpQMklFWVg4RzFQ?=
 =?utf-8?B?SjNRZEo5RzhOcFVmUWNqcC9yWEkyU2VaQ0trTE9SSmJJSEx3YkJtb2pDeXJQ?=
 =?utf-8?B?ZnR0bFFYZml5Q1l6c2tKNnhBNXc2OXBBWGRkRmpyamY4aThHZ0Z4SWpkWnNo?=
 =?utf-8?B?RFZnUHEzL1piWk1hUlpoNUdNTjBaaTFyZmxZYjkrZzFTb1BLTUxwRDIvSFFs?=
 =?utf-8?B?akFYQ3lxMnVqUWlQeUV0bE42VGZWY1prMEtxL216Q0VRdk91enkxUGpZY1ky?=
 =?utf-8?B?elBBRWdIdEVBWEoyNzVNeWlWUDVPeCtnZ0tVOTZ5OThpamszWHUraGtxSTRq?=
 =?utf-8?B?MHZhME5salBqMXhUQUpCOWpvS0xERFNCNktEZWljdmpuN3kvd3hZWmFKeFRU?=
 =?utf-8?B?WWwrRjZPcTM4YVlaM214cE5LWW1aWlg3VEFxai9ZbGJLeWo0aEJVVjBNdU04?=
 =?utf-8?B?ajYvQ0pFekF1VithZ3draTdaenNPaWFCT0lYUWNEWkNueDRZTm5QZldOWE5l?=
 =?utf-8?B?ZXEwVUkyUEZjUXcxZGxLOXdYbG9SVkxWTlhISWxKTkgya0ZxUW9xYVdSaE10?=
 =?utf-8?B?RncvaXRCMm9LOU5ZUkhtUEtNL2V5eHU5MGVtS2FSVm9yRm9mNHRxZ3IwaFJi?=
 =?utf-8?B?UnVvMHdwMUdiK3N0amNvd0F0Q0R1NENGR3JrV0tsTzlmbmxwVDVUdG8yRUc1?=
 =?utf-8?B?dWNYWFJlWUpmOXpiVXVjbzhwNHpwZkI4dVljQjVRMytKMGdUaEtOUkZnSGp6?=
 =?utf-8?B?SFQwTEdGM2trMmhQT2xOb012WHFveFd6bFI0UitQVzNmbTROQXI2SFpETC9i?=
 =?utf-8?B?SzEzNHoxU0M4Q3M5VjY5MDNqdHEzYmtpVW83UGFodTEvSWtUWGlVVnBWMFVU?=
 =?utf-8?B?YzBXSTF4b0hvL1IxbGF0ZmQ2V3dQd1lYNlIzK09nWXQzK3JiOHlQek9XR24v?=
 =?utf-8?B?Q0FhQmZkZUVFVDRob1lMa0hZVmNaUnBnWkZpWk8rZXppUU1oK3dydXpZL2Vl?=
 =?utf-8?B?a212Sys2RVFud2o2M24yRUloWm5XVjdrb0VObkoyNmRRMjhYc0tENUFwY3lO?=
 =?utf-8?B?SGp0Y1lmNyt4OUJDZlVXeUxmeGdDUm5mM2VZWGdGZStIZDNOWkFDQ2JXU2Ix?=
 =?utf-8?B?dVYrM3UraU1DOEZudVczbnFyZVVsSVVyV3pCR0FqdXYvd0t5RWppSEdjVDFw?=
 =?utf-8?B?a0dsUU03S0ltU2xLUE1rSHhidStlekw4S0NBNVdvL2hkWEhOd1VYVzMwQmU0?=
 =?utf-8?B?VXhlZExDRWQ0QXBnK25qVVd4dk56VmRIWlBPNDgxK3dzYXlNVjBzbHBOd3Zn?=
 =?utf-8?B?Qy9ydk13MkttdzBkVXNGSnFKVmVZV09Gb1lIWjZzMXJwV1NNT1R4NHJkbTVi?=
 =?utf-8?B?ZlN5cWtWMUZpb2JCdUdyT2FDSFdTZEtFUkR3ejliVmNBSzh2RHc3Z2R2VFpr?=
 =?utf-8?B?ZmpZdHVsNkJHN2FvYWJSOGNOSXc4TVFuemxBUngvWEF2ODh2SHZUNmsrU0JP?=
 =?utf-8?B?QzhUK3hBR3pyeE04ZTBkcndaMXBVMmdLcklkR1J5ekg5cVhwZ2U5L0I3YXJm?=
 =?utf-8?B?ZUtPa2NDVkhrMDB2bWhNN2FKZW9LZStJM0hqdU9xeFQzMGcvY29sL0o5SzQ5?=
 =?utf-8?Q?6U5FyfGQIE9E7TPGoh7g3Qtm8SvlXc=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYXPR12MB9386.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(10070799003)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NzZrSk1jNVN4bTgvZWh0S2R3NXlWNUUzNk1NOWxtTkdKMkxyOStiR0o3R2th?=
 =?utf-8?B?VkRqMGt6NU8ycjZiYzhsendzK1NLRDNrNFFzaW1CbVlabkVwN2U3ajg5MEd1?=
 =?utf-8?B?cExDa1I4cWVkU1JQRjkyVWc5b05oNXJjVXZBVFZyL29WZ3Q4NHdLbnQyeVhI?=
 =?utf-8?B?eTJjUU9ZbmI0WWdteE15Z1dQOHRpRVdQRTB2dUFJSEdkdjBiaGtSdlpvWFU0?=
 =?utf-8?B?QjJVREsydkxXVWhHOWNxRmZjTWltVTZRUTFZV0kzMXpRNEhQckx4NlVWemNa?=
 =?utf-8?B?T3IzWlNER25GMkIzbjJkSFRYWi9vdllJWFVML0NOWEJHbTI3dzM2bU12cTBC?=
 =?utf-8?B?Y2NLbnhGaXNjYno3UG5va29mMWwzMnVKaDh1dk9QZ0c3UGJnMSsvSXE4b3JL?=
 =?utf-8?B?b2Zacys3dm5WV1FWbDdWdDBxbi9iWWZMdXdhVkkxV2l1RmRiY3JnRnpkekow?=
 =?utf-8?B?SnFQNHA4NVJDbEgwTEFqMkUxUmtWVkpTK2x6VEV1cW4wU2lCemNwZG1TYnE1?=
 =?utf-8?B?TDZuSUlsUGQzVFpNckdiWFVXdW1FMkYyRnROUE5obTBTcDc4RkVTOHY3Mno5?=
 =?utf-8?B?QmlMdjBwcUR1WnlPRWQ5eXRwTnpiajJlUUkxUnR6aVZtNjdYUjU3YSt2STlj?=
 =?utf-8?B?TE5QUHdmT29xR3RXVFJ5dG5SNkNieTRFWVpFQk9qajk3R2JRSzA1UkprZkd6?=
 =?utf-8?B?Yjl3TVJSbDVTOXRCTU4yWWhHS2hTK0V6UkVrZUM1QVcwMXQ5U2ZQWXA5N201?=
 =?utf-8?B?WTRjdkdNZFZ0cDhzSlgxODFyZDFQOXI3N2VwbHllWGI2RjMxVHBXT2svZkxj?=
 =?utf-8?B?dTJycHNJekVNM2FMQnJZY0VxQTJiLzAvdngzMm13VjliMWZCK255dmhUZ0Ni?=
 =?utf-8?B?ZXZYR1hvWStNd2JXek5PWU5jNU9CZGpjV294b3hJQldvNlpyWG8yR0tjSURS?=
 =?utf-8?B?cDA0Kyt1SHAyU3pUb3JzYU5TVDNxRkdrMjQ3VU81MlVmTU9YTzV2WHg0azA1?=
 =?utf-8?B?QW5HbHA0WCtndGJUSnNnbVJkWFIwV3VwMExJczhmWUNld3ZEYzZQcXREQ2hI?=
 =?utf-8?B?Skl2bG5MK2hMMzVzZmFCR1QwMEc4Z3dQRG9IZGYzTnAxVHVjQjV4bkFreWhV?=
 =?utf-8?B?dWFIc241MG1raHNJazBBdWpQalhWL2dJMStvYUVodFBtWlpUT3V4QnlEdERD?=
 =?utf-8?B?UFRBMVF4cTc5RWdVN25xQ0w4Zy8zcDFsTnhjKzNEaEdtemVIYjVrRGNya1pi?=
 =?utf-8?B?UjVrZXdxYXlFUzVoTG8rQmhTSTZKa056N2tiVGRpWDIzMFRzWWpsSEpBZG5W?=
 =?utf-8?B?UEppVTZHbGdpWmJtaEFCRUVsaXB1emtQQmJEbThJdzJPOXh1VUhCOElVanNG?=
 =?utf-8?B?bldSWEhqYkJtMkFtR05OaXVYQVZGL2tMQ1k1MzYvN0VuWlg1Q2RCMXhPUElL?=
 =?utf-8?B?UTU5Y3pmTmV2dkFVL1lTRlpMV0ovVy9ML3RTTnlpaStTdGRtR2JHb1E1aU9i?=
 =?utf-8?B?Nk9hcUxHN29vQ2JHOFhhbDY0YnU2UVhiWDd3elNkZllkRjUyYVpxWUxZRld2?=
 =?utf-8?B?cDNOL3dUZGpoVUg2MlpZNFQ4Qjd3aDBUUGx3VGRveUdXRVB5NlBVa1h6djkx?=
 =?utf-8?B?U1JmVkxhaEJXUE5iaWdhM1hiZm41Z2FoV21LSGVOZzc3TG9RNVFQRlFmdXBK?=
 =?utf-8?B?Smo0SmFGVk4xRktXMEFESzUrTVEwU0xIRkwvaTJnamFJdERZQUM3em10R0dO?=
 =?utf-8?B?M1phZVlFOVF0YkxVRlVKZ0krbjhkNGJhejErMDRFbEZGdnhKUitEcThZSnl0?=
 =?utf-8?B?ZGM1eWphUGdVYXJUa1VDeWFRZmhZVWlueUdrWDRNb3B5U1I3d0M2U1NzSjNs?=
 =?utf-8?B?MG5ocHlmdEY2WlJjc2pPRXorWnhLMkVvc0RuaUJ2empvMXZ3TkR4RysxQTVH?=
 =?utf-8?B?VWhJbWVTU1d4WDhRbVUvT2tmVHpoTy9Cb2RpRGN5enh0QzNyUzZtaGFXWTFS?=
 =?utf-8?B?eENHRkVsaEYrV3RkNG1kQmF3a2Vrc2h5NjdWWGNOdFZRUmJSYnhoTENibTho?=
 =?utf-8?B?LytFZGM1a29NU0ZFN1lhSW1KbW00eFdSOUhGM2pSSVJxdVM2MnAyMHFVK1U3?=
 =?utf-8?B?UWpBVHNoaTIyYW1CenN1aFMzZ3JyZWQyNnF3QXFWNU1NdzJmNnA3eFI3bElw?=
 =?utf-8?Q?5AD6zofS7PqXGbf269IkWbdZPubAF56/acYkGpaWCSyS?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8F9EC31392E213448B39842715949FCC@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CYXPR12MB9386.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9269823-bf41-4595-a57f-08dd873aec08
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Apr 2025 16:28:49.3753
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cqX0L1BHt8/VuzgB55Yiuad9B4yc1p9KIJQIKFWLxxGgTAsYOLcYsLuhmf282i1QC3ty//g5f1Xk6kvRpBZFSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7080
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250429_092858_070623_6A2A4DA6 
X-CRM114-Status: UNSURE (   8.55  )
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

T24gNC8yNC8yNSAwMzoxMywgQWxpc3RhaXIgRnJhbmNpcyB3cm90ZToNCj4gRW5zdXJlIHRoYXQg
VExTIHN1cHBvcnQgaXMgZW5hYmxlZCBpbiB0aGUga2VybmVsIHdoZW4NCj4gTlZNRV9UQVJHRVRf
VENQX1RMUyBpcyBlbmFibGVkLiBUaGlzIGFsbG93cyBUTFMgc2VjdXJlIGNoYW5uZWxzIHRvIGJl
DQo+IHVzZWQgb3V0IG9mIHRoZSBib3guDQo+DQo+IFNpZ25lZC1vZmYtYnk6IEFsaXN0YWlyIEZy
YW5jaXM8YWxpc3RhaXIuZnJhbmNpc0B3ZGMuY29tPg0KDQpMb29rcyBnb29kLg0KDQpSZXZpZXdl
ZC1ieTogQ2hhaXRhbnlhIEt1bGthcm5pIDxrY2hAbnZpZGlhLmNvbT4NCg0KLWNrDQoNCg0K

