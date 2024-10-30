Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C546ED7497D
	for <linux-nvme@archiver.kernel.org>; Wed, 30 Oct 2024 07:53:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZHnvsY6+5vNL5nZlbFrecxutulXDxYS3nLItcfyhZuo=; b=05A7XmLsDXcn3Ilrxw/xuTwbN8
	kqa1i4+HYGWHjpkjwQ6SVeh8+xOXjm0+6oidO4UYradhAWMu62hYRx9MVBwkVBQW8eyZjFHHQnjtG
	rTZDWJLLkU1lpMrpoavv5GGmLEWowjlu2PlOHe88SBdIe448KJM8OMiHorxmSPJOS0YiKkMT9dLy9
	+3h2PwbqpNINaESmFZoyC9T2ezUa4KI5i7f2oD/wJXceSw28vDeuNSI7zt19uApSgaKk1QZ2i4VI5
	dmqR9kdRuQSCO4eEJ1LONcF6lVMormYrt7azEN0iMsJhVkXf8f7ilnOKdh3EKLv26gfccMYQIdb2o
	H3GJGdZg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t63Wb-0000000HCw3-3dAG;
	Wed, 30 Oct 2024 07:53:53 +0000
Received: from mail-mw2nam12on20631.outbound.protection.outlook.com ([2a01:111:f403:200a::631] helo=NAM12-MW2-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t63Vz-0000000HCtV-1L3d
	for linux-nvme@lists.infradead.org;
	Wed, 30 Oct 2024 07:53:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h86e0gaPoZEE5XfANeJsjo21GieOgAfqv+lMsuWx3dH3WdovT7axLfVZYeMVthdZwjye9UdKzP3bQeOXhUPZ6xSXZI2NnKDuy+yv4Q0qu3QxLpLDufIzxNWFzpCuCm6JkW5qmsMHKmRorttQoMrBHkH0E09SrFhPEEJndopQOeBYVJVCf8EUKfNOnul5VZouTctzBRFsRQ4J2nXQ3+Vu0RkyOU9zclPJNPZTwdMrznwzBH56OYKxzFvvrzUN+6dvCeGqRm0Su4DzEFTnDJklDT8yk2+3bfAnVvidauaf2rlUfLvU/xYrvPWgBTeFFswSu4rfbvX8tlz5Q0L8TTiwRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZHnvsY6+5vNL5nZlbFrecxutulXDxYS3nLItcfyhZuo=;
 b=MuaVMyl5r866wIGXBH3cp3QWNMfPfTFdtJMxvNCOyb/2QQ+1DsD3bjMNDWTO4ORz1cTY8tFpM/GUeL1JpuEEus/wkxI7WNg5fz9iEd6+GWUy7KFQZQ4oZqkTARxCv4618aD6tF/+FKlsPxjqW/mIki9fV4Fi+z9jybqz+HEqHpi6eCmZwSAhGNomldrhzcYgvs3fNNWFJ50dYGgmkaVdHkTJ7Zab4z92QV4hcY/33An+hx4SaPUm/OrQ0InEZJ9/DzhSvO2zc8QHoARIdrCdbRMLxBq3r/ljHao8yZkrIpx1fXl5BlSnUBNRugWGKQKYSfQx4WKlpkEURnLNMJCDeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZHnvsY6+5vNL5nZlbFrecxutulXDxYS3nLItcfyhZuo=;
 b=g+m2ULTwOIc0zVnnMYV/2k6sHTu2Qj4K3+FLcFgrubt2EZ7XfM5NbFqQ4vj7eN9lxluRJ2QCSwD1+LHRVgBvpmg5/wAXM+D+pr7HrPDPsrF8+kuAsQZR0GK6cOE3rybKmthqHFXvRfwhwa3maAofuqPfe6Z30ynWbHxTXNkcfzDPg7hjyvjca/DVzEEvwVE4kIhdNMIbRf3JpSZG0shAGku6MoLwCa8kZ/Lzo4KK7uJGFMwXmuebifCnad8Eix3e9Wd9FQTU4Rc383j+LZ7CPfN1YiGQTuQMXQllMhG2Gj7gR11s02Ef76nr+r3rJdD5HlOwYRRRbHvTaLnD6fTUNQ==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by MN6PR12MB8591.namprd12.prod.outlook.com (2603:10b6:208:471::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.32; Wed, 30 Oct
 2024 07:53:07 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%5]) with mapi id 15.20.8093.027; Wed, 30 Oct 2024
 07:53:07 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
CC: Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH blktests v2 02/13] nvme, md/001: make trtype argument to
 _create_nvmet_port() optional
Thread-Topic: [PATCH blktests v2 02/13] nvme, md/001: make trtype argument to
 _create_nvmet_port() optional
Thread-Index: AQHbKphD0dLJ+VX0A0mxvS/foa1aKbKe7FKA
Date: Wed, 30 Oct 2024 07:53:07 +0000
Message-ID: <cb4cc2fd-b1c1-4cb5-83da-c338690b1cd0@nvidia.com>
References: <20241030065149.2297405-1-shinichiro.kawasaki@wdc.com>
 <20241030065149.2297405-3-shinichiro.kawasaki@wdc.com>
In-Reply-To: <20241030065149.2297405-3-shinichiro.kawasaki@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|MN6PR12MB8591:EE_
x-ms-office365-filtering-correlation-id: 3b1dbb3f-03c9-4603-3444-08dcf8b7e49e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?ZVhXdEtQSzZueDhDV2F6YlNRcDVhUUpCazNYQ0VoeE5SM3lhL05YQ3ZpU1Vt?=
 =?utf-8?B?R3NuM1RDNVJleWxNTTRRSjAzNGpPTEd1aUVraXdKMUozbUgwN3o5VTRXazVL?=
 =?utf-8?B?VHJIRXFtSGZseGVpTEpRaUtxeFROOG5CSnpvaHJRbGhBMERnQkhvaU1oUDVZ?=
 =?utf-8?B?QXN1MnpqZGV4dm5mVDJNK3JrZCtYODZKTUgrSUpod2VWNEJuTHFNV21XbFNh?=
 =?utf-8?B?M0h5cUVWbklwbXNRV3ZQYzArWmtPMmQ4NHptanVRWHJ5UkFraVRJK3VBa1pE?=
 =?utf-8?B?VHZGK1g5ZG5zRXBoeHpqMGhLWFlMdVo4ZHp3cVVwLy9mQ1RtbEQ2Wm9IN1NH?=
 =?utf-8?B?Mi9ScWpuNTJDTjFGcFVtdGtZNVlGUVFJT2w5S3B1bWdsekNBZUxXUFB1S2NX?=
 =?utf-8?B?czhrdzZLd0RsNDlNZERWbkw4dXJMVGd2MkxtZlBjV0NNMCttWUFrYU1xNFcz?=
 =?utf-8?B?Y2FPSzE3eHRIRUh1b0NwaE1rakJ3NGtBenRoam5Eb1EyQWZ5VGVRV1hwQk0y?=
 =?utf-8?B?QyswaGt1Z3hoWDkrS0ZQeDhTMW5RbnVGWDFtZVJFUmFzUlpqRnFRQUwwWndZ?=
 =?utf-8?B?OHJ3K3RWSXFhVXRtYXhKMTlLREtwQTJ5OThWQ3Y5c3BNaWNTZjdNc2pIZG1m?=
 =?utf-8?B?dkxTb1lqNEUrVkhGb0psNWNJUDlLNFYzakhpSHp2YmxvS1NIc0kwMElaVy9U?=
 =?utf-8?B?UFgxZ0E4a2EwMWJvVzVnYnlDeGZ1NUI2akhtK1FBMHc0TWpneDZKalVWbXlV?=
 =?utf-8?B?MFVQZDFOYnFTUVdTSit2NGtZVUgxK2JMS25mOUhuQUJ2Vm1DOUk4V1R1bmxm?=
 =?utf-8?B?aFBQT0FSZVdRUWhxeHU3T0xpamo0cUFaMWpWeU84YWM1VDZ4bkRpMWpJNTlL?=
 =?utf-8?B?QTNOQ0QvTythYk03TFE1QkMyYW1PekZSRUo1c0IzZXFSY3BpNTdWc3V3NmVF?=
 =?utf-8?B?eG1GeXhZcERrV1BoVkRiL0M2cHgxaWliVHIyT3NrVEZRa0lPajVJMEl0ZnNH?=
 =?utf-8?B?QTZPOFA0cHZQUEhTLzRQdXBNTkZoVno0VzRFVjEzaVlDeklGNHJ6bFNKYi9t?=
 =?utf-8?B?cVRqSFVVcFh1K2VQRG5hVzA3cFJTSjZ3dkZ6Rnc4WS8xZWRaU0dSaDJPZVcz?=
 =?utf-8?B?cStLSFExanI5SGRTRWZjM1pLU3RWQStKV3dwSUlEWFBYMTR3MmVWb2VnMy9O?=
 =?utf-8?B?T0Jsa0Z5SXZZc2NWZk03Qy9WOFBNbXlQOFlvWFp5Tm90RVBKeGExK2F6V3pL?=
 =?utf-8?B?U0hUMEp0anVCVWdtd2RvVW80bmhEdGw3U0E2MlJBSW9RYkNDN0huK1NtRmhJ?=
 =?utf-8?B?dzFjRk13YTd3UUlLVWs3Z1c1OTFQVngwV1N4MkdXejU3RGQ1aU1aMjNzZnJC?=
 =?utf-8?B?cWR2KzlsbVZPV3NURTFVYXVwOUtydW96Z0gvSllxUW94U1llUHRpWVZPS3NI?=
 =?utf-8?B?NFVydTBrYTUrVUE2SzBYV2RMTGdSZk92bjhPdHFyUEE2M0pFV0VncGY3MVU3?=
 =?utf-8?B?M0ZicGI5S2UvT2JOQ3RMUFZYZHl3RmRIeGtpdFZkVmdYLzF3Nzg2S01LcmVp?=
 =?utf-8?B?cml5WTRxaHY1aXNrdWxJN05ZN2NFSXNTK0FrRGg5elh1LzNDMlNlVW90Z2JR?=
 =?utf-8?B?U2FRNDllVXByYm9Wa1hYMms1R1dSaGRyclFNQ3o0eVVkNkNLRlhmbFpDdDhu?=
 =?utf-8?B?cm9EOVFOUWRrNGEybVN5WmR4bmFYNnB6QmtLUE5Lck4zdnc0bnhxVDd0c3RI?=
 =?utf-8?B?T1pONU90ZlJuRTZ4bHR4WUhNQzk3MnhCUldpZHBMZG1EZGp4SnIyTXhzOE5F?=
 =?utf-8?Q?qFC6LDPrmB2p9pXycauR7oHsCz5AlhXV/4kJ8=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eG9DNDl0Zzd4OFNwUnZBMUtKYmJML0tHNy9Cd0sxV1JrVWdPWW9hMG1xdlNI?=
 =?utf-8?B?SkliSTBsc2hzYldhV3ZpUG92ZFZJdFlMdFBFaTUra243T2NXbzdxMEhlUTVX?=
 =?utf-8?B?aW5WT3g5RzhBaGxEZllWN3REWDNZajhtcDcwRzh5c0d3cmdIS1Bad2laU0dC?=
 =?utf-8?B?Y3Rta09ERWdYNmFsZmVwbCtLRzZEeWw2YW42aHJEU0JsN1E3RU9EbHpjQmhp?=
 =?utf-8?B?MjBXVWJBSWdKYWcyWnNVakxDTWh1NTBqRWNoMis1Rjh5NWthbzA0YW80ZllL?=
 =?utf-8?B?R1hlVDVieEtmLzdTTVY3LzBmc0RURFNKV1Bubm40dE8zR25pY1V4NjZRc1A3?=
 =?utf-8?B?YU5rSHl1RWdlZ1RqV3g1ZFN1ZDhDUzNTb2tNOUxIWW5UNDBsdFdibGpNRHQ4?=
 =?utf-8?B?a3pLcUhGSXhUWVZuUVRDRkJWY1hxaHc1SHV1MkJvaTYwbENCQ0dtWS9DY1Vs?=
 =?utf-8?B?SjI0cXhTcXhUUFZMa3dDYTUvRXdraU1FekJmQmFmbTM2VDdEUGFGUi9KalNZ?=
 =?utf-8?B?R2RpMHhzcEszdGtqOUhVc0l2Mng5b2hUMmUwb012M3VaS3NDNXk2MkZKdlZO?=
 =?utf-8?B?MEhodE1nT0I5YnBPOFpBRUhSdDFrVjlTeEpUYnNhelk3VllYek5Bbi9TUXR0?=
 =?utf-8?B?aVB2VEw2VlBQMytjOTlNS21oL0NVc2pRbFhheGFRenhpYkpwTDNFa2JFL1RB?=
 =?utf-8?B?SE1STDZINU5pVjF4SFROcjk2RWx0UWN3ZEhkNXlGaVRPc05sTmxnVzdxeEZr?=
 =?utf-8?B?WjQ3N2lvVnZNU0hnVFdBQ3pOTTBiRGt1cFVpSk1mbTRrenVuNnkrU2NrcGV3?=
 =?utf-8?B?V1B1aUNhZHVtRlgxM25jNHlLaEdHaittWEdCU1U4ZXZXZTBySmQ5KzhaWXVP?=
 =?utf-8?B?NHhrMmlnQVRSNWZ2ZElxTkp1Z25MaFpQeVlXU2xIR1FGNHZrbDhFWXVoY2Fk?=
 =?utf-8?B?L2dOM01zdVBnMHdKdnNsWTM0WTFaYmZZL2lPblc2Yk5pTVFDRG5IQWpHTkFK?=
 =?utf-8?B?cDF6M1oreTNrUVhSK2p0cmJYbksxM2doeGFja1RLajl6WGE4YXU3M2dTRHBX?=
 =?utf-8?B?aEVvNURuWE1KcWVPYll4VDFhOWEyZHo0dWlvUC91Q1pHcE8vZUYxaFJ3bDJh?=
 =?utf-8?B?c0w3Q1dPbEdYSU9nZjBXczZhUlJQKzVCaWRIQ0pCa2NwL2lvaFlxQXFibWhJ?=
 =?utf-8?B?ektjNEhJRmk2engzQTE4SEtFS0p0UTF0NEVJSDRwRXIyTDY3SkM2SUJvcm1m?=
 =?utf-8?B?Ykd1aFZtSmJLL1lXS0pxT29uWW5oQlcwbzQydzdkOVZUcHdRVzRSWUk2OE9M?=
 =?utf-8?B?Ti9YTElIb28zL1Flay8xQkNmZlFQMkw1d2hvcjFkaHZ1TkhoVWxqYlBua0w1?=
 =?utf-8?B?WlhsOVlGQnBPREQ2c1F3cjZLOEk5L2JjV2pyRVBMYi9zcm1xTmlyVnlpZHI2?=
 =?utf-8?B?d2cwNzVzSCtCOEkrMDRxd3hoM3ZQWHlVelRaRzZyeU91WDhleTEzVTRQUFB5?=
 =?utf-8?B?azBMRnMzNXhTSWNELzNZN09PQm1JelpBU09NV2ExRjg0ZFU2MmI1T1UwTDJN?=
 =?utf-8?B?KzcwSVNIN1RPZnlPREZtbUVuV29EMkFkUjIyb3c4QWNoa1haMHArUkM5ZmRs?=
 =?utf-8?B?bkxpSUE0Z2pPaUl4c0h0ZEhldDZyaGp4WU9TaTZLUHByMDFsRElhZFZGVlhG?=
 =?utf-8?B?WURiNG5XQVR5YkFTb1lsQ2tOQlRKNVVWOFNIZTlrT05WYnRiRGF5dmNRYWdP?=
 =?utf-8?B?eERURHdhNzJiQ2REQU1LN1MvemN3ZDduRTV0THNaOVdhR01WamcxU1djQ0Uy?=
 =?utf-8?B?TkFmN1Z4WEtodTZ3SS9iMVFHR3huN2VLUlV6RXJCMkhCSm1qMmhLNnA1ZkI4?=
 =?utf-8?B?MisyY2NheElRamFMSnNnVE45bFkydFZ4bk9PY283Q2ZuUVczeGZFdnZwekZj?=
 =?utf-8?B?dnphallRb20wVnZpZFBHWlVTTXlDK0cyNHMyNHNNbWNUR25qTkN6Yzd5ajcz?=
 =?utf-8?B?M3ZYdDRqL2xSbmR6cGptbktPREx4Z241UVdpSUViU1IxcFEranIwZUdIRHBu?=
 =?utf-8?B?dHFwakp0U2JrYmU2QlA2MW9wTUFmRjFxb0h6MnRTbXJqdjBkTkRoRnNLdFBU?=
 =?utf-8?Q?N8Jyl+EB32Yw6NvGIj2y7I2Ht?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6A1151E4190CE2478BD35ABCA1D4EB3E@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b1dbb3f-03c9-4603-3444-08dcf8b7e49e
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Oct 2024 07:53:07.7760
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: orINOI++SFY43sfneE3qED8p/LtPTmcBmfmxHbvsdegynh4C93ZYI59CQ0ZXtXfvss/iYFr3JmAH96kTV+KH1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8591
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241030_005315_433947_4BCDF9A3 
X-CRM114-Status: UNSURE (   8.77  )
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

T24gMTAvMjkvMjQgMjM6NTEsIFNoaW4naWNoaXJvIEthd2FzYWtpIHdyb3RlOg0KPiBGcm9tOiBI
YW5uZXMgUmVpbmVja2U8aGFyZUBzdXNlLmRlPg0KPg0KPiBBbGwgaW52b2NhdGlvbnMgYXJlIHVz
aW5nICdudm1lX3RydHlwZScgYXMgYXJndW1lbnQgdG8NCj4gX2NyZWF0ZV9udm1ldF9wb3J0cygp
LCBzbyB3ZSBjYW4gYWxzbyBtYWtlIGl0IG9wdGlvbmFsIGFuZCBkZWZhdWx0DQo+IHRvIG52bWVf
dHJ0eXBlLg0KPg0KPiBTaWduZWQtb2ZmLWJ5OiBIYW5uZXMgUmVpbmVja2U8aGFyZUBzdXNlLmRl
Pg0KPiBSZXZpZXdlZC1ieTogRGFuaWVsIFdhZ25lcjxkd2FnbmVyQHN1c2UuZGU+DQo+IFNpZ25l
ZC1vZmYtYnk6IFNoaW4naWNoaXJvIEthd2FzYWtpPHNoaW5pY2hpcm8ua2F3YXNha2lAd2RjLmNv
bT4NCj4gLS0tDQoNCkxvb2tzIGdvb2QuDQoNClJldmlld2VkLWJ5OiBDaGFpdGFueWEgS3Vsa2Fy
bmkgPGtjaEBudmlkaWEuY29tPg0KDQotY2sNCg0KDQo=

