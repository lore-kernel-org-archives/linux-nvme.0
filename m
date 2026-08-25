Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67D35C61DBD
	for <linux-nvme@archiver.kernel.org>; Tue, 25 Aug 2026 12:30:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=p2QFLpop+iDuhHnncN9iJ8U3QBoaUoOKlg13+IPP3VI=; b=X1pa/012viJEU3iEWiIxKt8t2J
	eNw/GMW41XJe3NbE9fSnAg1uWrjNRbefaNvDd85+MWoyMKH8G2UcMHqTknaRMsMVRnthZVymzoS7k
	MyiilltL+4n5nqcUxlIDBDGkK7en3rphQcoqqIqqrzgfMuKi2zMoPbHN7jKG6IxpkgPObcMFp7M7Y
	6+tmMFhOsAIFMgXTAb8skXqmge2T2Y21hvD5V11S+3YbXc+9v1ZnhySWy6f4j4fb5DplBDrfczuGr
	qERpyeX7VnXtwxzaR0MM91O1cTt6HpS2DDQuae3uMHzJjqnvrjrV4Kkd9kKctjBmWmLQXJWDRIQqN
	A+ka2y7w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wyqIc-00000000lvx-1vqF;
	Tue, 25 Aug 2026 12:30:42 +0000
Received: from mail-westusazon11022076.outbound.protection.outlook.com ([52.101.43.76] helo=SJ2PR03CU001.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wyqIa-00000000lun-2Wuw
	for linux-nvme@lists.infradead.org;
	Tue, 25 Aug 2026 12:30:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XToeSdLYeGfJIlTwE6/ZTMAv5oxsgO7GN9sDw8sdhOcKrn54RDSGcl14mDlM4TcadVjZbdSt02pwRH9i9ZUoEEGpkkSosJdJiYcHhLJYojHCbsImSn5zHVJC+tTy6CDbUV3dIuEW94Vh0k1rmluwhMOd7BzrjwmXhR2dMEfHzRlu1WXkByYyxM6FKmkc7nJruR0iDabtPG8qN9075nO4YcSBXXMTmDIE4sLPEZzZXTvMVxpoHcdxnSqOE+apADvZnXGQFlj/ewmdBEhBkZ7vfooSgNkrNF+v8myims+4+qP7h4MVY0V7eeiSzus5qxBkFroAGnebTzQKk0TmeFsAcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p2QFLpop+iDuhHnncN9iJ8U3QBoaUoOKlg13+IPP3VI=;
 b=S9IFmUWQfDwVP74hZpSfasUiP27qhpEy8hrz46i0fjHuLrGwLiXZXD4tdeMVF0l+kk/H+pEkxmUR70evJySVEkEGYnc947a9y9H0FfDVyUTB6GJbzwus01kBRfgZYWWlPKSnZv9Y4ei+L2a+XDG9UNIKkHNlmnRl3cxEaVpdfvael4XmOWQiaZZK1vstEjAQCCvCsI1FTb04VtCQ7PEHxMFB1eWGi4SE5nGtbVlWWNcGhMkk4Nd78mbHtrADhP6sIpL56PS4KuSLu+bxMfaXjCJEUiA/zsC42y8Aj08Sx4Mq5X/IsjPrnAGeSkx9sdbyRd+QleH8erSjCZDoxD9rZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=helsinkimemorytech.com; dmarc=pass action=none
 header.from=helsinkimemorytech.com; dkim=pass
 header.d=helsinkimemorytech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=helsinkimemorytech.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p2QFLpop+iDuhHnncN9iJ8U3QBoaUoOKlg13+IPP3VI=;
 b=PivBZErF1H2qG7IApnbheMbd80pl5FLzBwb6j0WdwOGyKq38xX5WYbmJyED7t/jXancPPfkbhAynw8Tbs5+3y10/jmsTmRvoVREzd3CZ8JNpylOaEdFGq5A/xPWqsPEBXIjpTWXHZ8UbhxzEXgERxQAvK+cXmQ1MPajIPc6YYLL1IDPrrjo8t0CPuspmK0CU5ENTPJAaKTiHC9HlDvTH27DrEuSvtPUa4BrBbxhPs4pHY8gFj2I+ebBEV7vV/mPZuffBKosHScAzpvJEEgb8QUlyJKrfOy2wKof1sxLORnmS5EkXR1UyyCgTGXSx6V/GYzSa/YT/bn7k+qTqzlk4jw==
Received: from IA4P221MB1623.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:56c::20)
 by DS4P221MB996748.NAMP221.PROD.OUTLOOK.COM (2603:10b6:8:31a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.6; Tue, 25 Aug
 2026 12:30:34 +0000
Received: from IA4P221MB1623.NAMP221.PROD.OUTLOOK.COM
 ([fe80::5c00:6f89:8496:336c]) by IA4P221MB1623.NAMP221.PROD.OUTLOOK.COM
 ([fe80::5c00:6f89:8496:336c%4]) with mapi id 15.21.0339.012; Tue, 25 Aug 2026
 12:30:34 +0000
From: Marko Ahvenainen <marko.ahvenainen@helsinkimemorytech.com>
To: Sagi Grimberg <sagi@grimberg.me>, "hch@lst.de" <hch@lst.de>,
	"kch@nvidia.com" <kch@nvidia.com>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [RFC PATCH] nvmet: passthru: use Invalid Field, not Invalid
 Opcode, for unhandled Get/Set Features FIDs
Thread-Topic: [RFC PATCH] nvmet: passthru: use Invalid Field, not Invalid
 Opcode, for unhandled Get/Set Features FIDs
Thread-Index: Ad0xS1MlsSFko5cdQN2aGdEMG+HkzABNUkiAAIMFS9A=
Date: Tue, 25 Aug 2026 12:30:33 +0000
Message-ID: <IA4P221MB162360CFF958BBD931D24041F4AF2@IA4P221MB1623.NAMP221.PROD.OUTLOOK.COM>
References: <IA4P221MB1623401F07A6952EFC9895FDF4A32@IA4P221MB1623.NAMP221.PROD.OUTLOOK.COM>
 <4aa2e0d5-e519-4125-b537-e4b035d07847@grimberg.me>
In-Reply-To: <4aa2e0d5-e519-4125-b537-e4b035d07847@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=helsinkimemorytech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA4P221MB1623:EE_|DS4P221MB996748:EE_
x-ms-office365-filtering-correlation-id: 035e2c95-e5c8-4009-5dd8-08df02a4a8c7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|23010399003|1800799024|10070799003|38070700021|6133799003|3023799007|56012099006|10067099003|4143699003|18002099003|22082099003;
x-microsoft-antispam-message-info: fyqg/HhwTt3vBemIWIiBGOVVvAkkyT5E0NhUlsNP8ffahdYBhwi9eSdgV6ZgHD7As94mCAMGCxEaapZ+XG8R84KiDaOv7z9mwNxNE82DfRxHAPQPQbViZWw6a/THYpscDSuimdlrTYcPYGrhMGjzzK2h96lm+mUpajPUBWsZeLiiTfxkS9yhRVYnTB2ReYn06EX9G1Lte2QLSFRvHgAS2f0QTiP98oQaKIXSNZQZRrLxSUdn+eHLzhXUKpfu1QdQsbXNySMM82qGYR3zWscknWBbUZFz7BKErFEUdVPtXZoH3Lu7apuYSyNIscjnOT2EhVXIVz/mp2d+XtyefmK7xDaanq99BxUNg7C03z+z8idQc6/3sDmMXdHEfna0RBcVYCWQLMcdDIELUjQISgx7Bp5C5pa5ZP2q+B0UNxpN/kojsLpMG5SVxpT0OiV5D8P6hxPVzGRrudpFGLwTZnSNIkDKutCPFvrcK8ysd4lSGL1A8NrfJmwljcRy/MF5YqH5C/3TpImo/uHlKzG1CWq1vUgKi4fqGWQP8Di+0lvYX9NlEHVKGPIzedGwdjTbXQMf1ma481ScGuYqvIQhTyeBCuUTdvWOnuE6QCwObBpJZfEt5dsY78zXMXrwqSJJVoN5aKqxhYWqFB85VGmzVr4L0tfimi1CVsIC/6OwAppivwMKritAxXbQV+5IvgdknuF2W3wVw5UQUEkVYY+Fn10eTwEltf8A7MmaafI1wau16Yo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA4P221MB1623.NAMP221.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(10070799003)(38070700021)(6133799003)(3023799007)(56012099006)(10067099003)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SlV3cTVLMEtjdGRLN0dGcFgvcDRXNVVOQW1QSE1vVFVIZTlDYUk4NDkrY0Rp?=
 =?utf-8?B?SzZHa3h3Ykt2VFE3YkFSQTByK203eUpFV0J1SVVUcmdJVFppQ1ZDR2EyZHVN?=
 =?utf-8?B?NGc4ZVFJR2g0eEFWd2lYVEVKaHhvUnp4c2trQnR0MWZPa1JzNUhVNGgrSjRM?=
 =?utf-8?B?L2lCYmZ3WTRtVlpjU3JxRDRKVFptM1ZpWXlvZWw5SS9KeWxBdUo2MEVXWEVl?=
 =?utf-8?B?VDc4WWl4eCtENU9KdXhzUkRSaEY3N2RDS3Q3aW5xdHNVMUo2cEo4b1RsVUZt?=
 =?utf-8?B?UlkwVGEvWUdzVi9DV01JaWZsazhOY3lBSUNHdElOckxjZE5sV1pQb3ZxeW9T?=
 =?utf-8?B?b0tPOWpGRjFOYVZDb0VGTmdwMis2QjIxN2x1UHVUVTNkS3RYWERRZVhyUllu?=
 =?utf-8?B?MzRPZlh6WmpsSk4rZzdmWjhQRHV1RXMvd21BVXdzajdGYlBvV0xzM0JvMDNE?=
 =?utf-8?B?UEZYcFMwQW5oVnJseWFKTWh0aTdMTitLQ0R3WGlXcDBVczVSamsyUEE0eWhF?=
 =?utf-8?B?ak1hNms2d3JhYjREV0ZMdVZLcUlKWUxmbFJTakhPZm92dkNpSHhnYjV1aWM5?=
 =?utf-8?B?U0JBUVFqWlZGQlprbDE5SitKcG1DRjZLZUhGdUg0eEZCMjVrb0Y2Zjl3RG5u?=
 =?utf-8?B?M0Z4MlZ0WjZiWmY5eHVlSEErczBNZ25vRG9rNENRMGloejJtbThXTk8rdk1q?=
 =?utf-8?B?bkZZODdpaWxPelNFZmRTMWw3OU1OaExBZzdxSGZuOHphVHZYLzNsd2xGR1Ru?=
 =?utf-8?B?OFQvT05Vd1I5ejF5bWRUbVZ3eHlKd1gxYWdjRmdvTXU2ZkZPenN1enVYc2s4?=
 =?utf-8?B?SlB2MnBiUHFtQmVucE9DY1UyR3FXK1hQM0VyTHF6SHZOa2R4cGtUNm5HTVlP?=
 =?utf-8?B?bjlta3I2MFByKytEd053Ly93cUVDSjR4QnNOZ0hKL281SmNnbk0rWWx1djhV?=
 =?utf-8?B?RzZXa0RlaVU5b1FIbmZaWmFvNFlIeHdGQTlVVHNaZk5BbkRtWVNBb1h2QXBE?=
 =?utf-8?B?UEQvb1FCT01oSU1QdmlSSFhZVmNZSFFwc1Y4M2s0MTl0K1hzZW9objRkcHls?=
 =?utf-8?B?Nms4YUdHYXhJdDBQTkpCa2t1S2s1VjRxOXZOcis1VTB2a0JsKzJsV3hCdlBj?=
 =?utf-8?B?NEJ6WjRNdGtwR0wxbDdYVFpIa2ptTmVud3Z6dWpXaUlBNW5hYXlUS1liUHFZ?=
 =?utf-8?B?cGpvYmRxSkxZcmI3WC9MOGt5ZUVqZU80cTZjK3BQNHM1VmNBd1RzQjZGN3VH?=
 =?utf-8?B?SE94MHh5UXpyYXc3RXNxeDRjbFlISnRmQnFKR0JTdlNOMm9aR1krN0JxNnZM?=
 =?utf-8?B?MXE2UXZkekxNYW1YVWE4Qy9WdzY2anJEdGc3U09nSDgzSkJTQTRZNFJXQkZh?=
 =?utf-8?B?aHNlNHlIemRTMTkrT1g1Y0RNNHRzS0cvWnpXelZRQXJjUGczVHpneGpsT21x?=
 =?utf-8?B?azVlR0NRZ3I5MkJVc1VNZ1ZjbXp0b0M0bzNBQWVZTmdreDJObGg4MEZmdGRu?=
 =?utf-8?B?RHdaTTBmcFRwUnp2ZlZnWlBHNlRQQUdRZ1I5aXphK0pVdHN4TlhEQVFDcng1?=
 =?utf-8?B?YUJuR0lOWFFSWE4rQktpeUNQa3YwSUIzTXBTeUlBNktvVHJzVzVnSEdPQXBD?=
 =?utf-8?B?OUtBUGRnTSt1OG4wcnkvVlRUYnBaZW1xcHVWdFdPbzA4dEk4R0lFb0hDVUpO?=
 =?utf-8?B?Zk9HRmZWNlhkOXR6Rjdpd28wK1dIU3J6Rm40eDZyMVZwQnBzZGExNDhkcUtr?=
 =?utf-8?B?d3ltWHUvWE1sc1E1Z1doZHhnWE8rU2RMbXhwRC8waFhnREp2UWJWZmhRU2Ja?=
 =?utf-8?B?RmN2blQvZ1pzRUszaG12WGNqT2VQa0RYa0w3Q3pUL0xROTlsKzhxM05SVDV6?=
 =?utf-8?B?U2dmVVpVVDZnZkg0S0M5NHM4ZnM1Z0VOSmJjV3g2NjJWUC95UWdjNXVSdG5S?=
 =?utf-8?B?clhhKzVVN0ZNYmZNc3ZUeCtVTkhwSDYwZnFyU2dqQkYxV2FhdkNNTG9VRzFK?=
 =?utf-8?B?Um8wb0ViaXNISFkya1VudXVvUE9YVyswMUZXR3NJMVF2V1pYMWxacmxhM0Ju?=
 =?utf-8?B?bm5vK3p5QzJrRGZKNDBPYlQ4eDNsUVkxNG5sSldORXBybS9ldHUzcTBGTWVB?=
 =?utf-8?B?MzEwQjdEQXlpbU8yU3RBcm1nS3N6WHlMUUVPazRlaGlmNkxvTE1TMHRoWlIw?=
 =?utf-8?B?UCtTd2VhVTJVbVdqR1B5MndHWlp1VWxwS0xmMkIrVnNnTHllc1RtMGVmNEkr?=
 =?utf-8?B?bVB6V0lFZERrUjFoYnJNMENQVlBJR054amRUNzIwSEJkUmYzYlFFbEptV3Vv?=
 =?utf-8?B?Z2N1Y1B4V1FhZm1KelA4aHo2dy9BN3NER244TGNTUEJtS2pUTEJPNEJwMWln?=
 =?utf-8?Q?haiyNMon71U6/GbajL/Tx+8DKWyE97J8J7Uqi/k7Ms5yH?=
x-ms-exchange-antispam-messagedata-1: Zv9nK25ypKRFYYen3egXiHlaTHmwKjecMdkp3KuAUFrLB+1oRKzsJBrD
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: helsinkimemorytech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA4P221MB1623.NAMP221.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 035e2c95-e5c8-4009-5dd8-08df02a4a8c7
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Aug 2026 12:30:33.9296
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9bffc3a-91d7-425f-aa80-f1c3728b9da4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: H6LH8HAScwFAilpwv7nDBHEs5lOc33sFkBpbEEZl4Rz/BG2ETXQ/CFwzA5S/qL9hWCBhuR+uv6qfmhz6oMtXNVKomP4pmm0EHY77lriYRyFUiDyqDW/fB2TwZeLPYQeH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4P221MB996748
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260825_053040_662546_39D8173B 
X-CRM114-Status: GOOD (  36.65  )
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

SGVsbG8sDQoNCj4gSGV5IE1hcmtvLA0KPg0KPiA+IEhlbGxvIGFsbCwNCj4gPg0KPiA+IE15IGZp
cnN0IGtlcm5lbCBwYXRjaCwgYmUgZ2VudGxlIDspDQo+ID4NCj4gPiBudm1ldF9wYXNzdGhydV9n
ZXRfc2V0X2ZlYXR1cmVzKCkgcmVqZWN0cyBhbnkgRklEIHRoYXQgcmVhY2hlcyBpdHMNCj4gPiBk
ZWZhdWx0IGNhc2UgLSB3aGV0aGVyIGludGVudGlvbmFsbHkgYmxvY2tlZCAoSVJRX0NPQUxFU0NF
LA0KPiA+IElSUV9DT05GSUcsIEhPU1RfTUVNX0JVRiwgU1dfUFJPR1JFU1MsIFJFU1ZfTUFTSywg
UkVTVl9QRVJTSVNUKQ0KPiBvcg0KPiA+IHNpbXBseSB1bmxpc3RlZCAoZS5nLiBGSUQgMCwgdW5h
c3NpZ25lZCBieSB0aGUgc3BlYykgLSB3aXRoDQo+ID4gTlZNRV9TQ19JTlZBTElEX09QQ09ERSB8
IE5WTUVfU1RBVFVTX0ROUi4gVGhhdCdzIHRoZSB3cm9uZyBjbGFzczoNCj4gdGhlDQo+ID4gR2V0
L1NldCBGZWF0dXJlcyBvcGNvZGUgaXMgYWx3YXlzIHZhbGlkIGhlcmUsIGl0J3MgdGhlIEZJRCB0
aGF0J3MNCj4gPiByZWplY3RlZCwgc28gTlZNRV9TQ19JTlZBTElEX0ZJRUxEIGlzIGNvcnJlY3Qu
DQo+ID4NCj4gPiBUaGlzIHN1cmZhY2VkIHdoaWxlIGRlYnVnZ2luZyB3aHkgbnZtZS1jbGkncyAi
ZHVtcCBhbGwga25vd24gZmVhdHVyZXMiDQo+ID4gbW9kZSAoZ2V0LWZlYXR1cmUgLWYgMCkgY29t
cGxldGVzIGFnYWluc3QgYSBuYXRpdmUgY29udHJvbGxlciBidXQNCj4gPiBhYm9ydHMgb3ZlciBu
dm1ldCBwYXNzdGhydTogbmF0aXZlbHksIEZJRCAwIGdldHMgYSBwbGFpbiBJbnZhbGlkIEZpZWxk
DQo+ID4gcmVqZWN0aW9uIChubyBETlIpIHRoYXQgbnZtZS1jbGkgdG9sZXJhdGVzIGFuZCBjb250
aW51ZXMgcGFzdDsgbnZtZXQncw0KPiA+IEludmFsaWQgT3Bjb2RlICsgRE5SIGlzIG5vdCB0b2xl
cmF0ZWQgdGhlIHNhbWUgd2F5Lg0KPiA+DQo+ID4gVmVyaWZpZWQgd2l0aCB0aGlzIGZpeCBhcHBs
aWVkOiBnZXQtZmVhdHVyZSAtZiAwIG5vdyBlbnVtZXJhdGVzIGV2ZXJ5DQo+ID4gRklEIG92ZXIg
bnZtZXQgcGFzc3RocnUgKE5WTWUvVENQKSB3aXRob3V0IGFib3J0aW5nIGVhcmx5LiBUaGUgRE5S
DQo+ID4gZmxhZyB3YXMgbm90IHRoZSBvYnN0YWNsZSAtIG9ubHkgdGhlIHN0YXR1cyBjbGFzcyB3
YXMuDQo+ID4NCj4gPiBUaGlzIGlzIGEgc3RhdHVzLWNvZGUgZml4IG9ubHksIG5vdCBhIHBvbGlj
eSBjaGFuZ2U6IEdldC9TZXQgRmVhdHVyZXMNCj4gPiBGSURzIGFyZSBzdGlsbCBpbnRlcmNlcHRl
ZCBhdCBtb3JlIHRoYW4gb25lIGxheWVyIGJlZm9yZSByZWFjaGluZyB0aGlzDQo+ID4gZnVuY3Rp
b24gKG52bWV0X3BhcnNlX2FkbWluX2NtZCgpL252bWV0X3BhcnNlX3Bhc3N0aHJ1X2FkbWluX2Nt
ZCgpDQo+ID4gYWxyZWFkeSBzZXJ2aWNlIEFTWU5DX0VWRU5ULCBLQVRPLCBOVU1fUVVFVUVTLCBI
T1NUX0lEIGFuZCBGRFAgd2l0aA0KPiA+IG52bWV0J3Mgb3duIGVtdWxhdGlvbiksIHNvIG5hdGl2
ZSBhbmQgcGFzc3RocnUgcXVlcmllcyBzdGlsbCB3b24ndA0KPiA+IHJldHVybiBpZGVudGljYWwg
cmVzdWx0cyBmb3IgZXZlcnkgRklEIC0gb25seSB0aGlzIGVhcmx5LWFib3J0IGZhaWx1cmUNCj4g
PiBtb2RlIGlzIGZpeGVkLiBJJ2QgcmF0aGVyIGxlYXZlIGFueSBicm9hZGVyIGZvcndhcmRpbmct
cG9saWN5IGNoYW5nZQ0KPiA+IHRvIGEgc2VwYXJhdGUgZGlzY3Vzc2lvbi4NCj4gPg0KPiA+IFVu
cmVsYXRlZCBhc2lkZSBub3RpY2VkIHdoaWxlIHJlYWRpbmcgdGhpcyBjb2RlOiB0aGUNCj4gPiBO
Vk1FX0ZFQVRfQVNZTkNfRVZFTlQgY2FzZSAoYW5kIHByb3BhYmx5IHNvbWUgb3RoZXIpIGluc2lk
ZSB0aGlzDQo+ID4gZnVuY3Rpb24gaXMgZGVhZCBjb2RlLCBzaW5jZSB0aGUgY2FsbGVycyBhYm92
ZSBhbHJlYWR5IGludGVyY2VwdCB0aGF0DQo+ID4gRklEIGJlZm9yZSBpdCBjYW4gYmUgcmVhY2hl
ZC4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IE1hcmtvIEFodmVuYWluZW4NCj4gPiA8bWFya28u
YWh2ZW5haW5lbkBoZWxzaW5raW1lbW9yeXRlY2guY29tPg0KPiA+IC0tLQ0KPiA+ICAgZHJpdmVy
cy9udm1lL3RhcmdldC9wYXNzdGhydS5jIHwgMiArLQ0KPiA+ICAgMSBmaWxlIGNoYW5nZWQsIDEg
aW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9udm1lL3RhcmdldC9wYXNzdGhydS5jDQo+ID4gYi9kcml2ZXJzL252bWUvdGFyZ2V0L3Bhc3N0
aHJ1LmMgaW5kZXggZTI3Zjg0ZTNjZjJiLi5kZjEzOTYwODFmODcNCj4gPiAxMDA2NDQNCj4gPiAt
LS0gYS9kcml2ZXJzL252bWUvdGFyZ2V0L3Bhc3N0aHJ1LmMNCj4gPiArKysgYi9kcml2ZXJzL252
bWUvdGFyZ2V0L3Bhc3N0aHJ1LmMNCj4gPiBAQCAtNDgzLDcgKzQ4Myw3IEBAIHN0YXRpYyB1MTYg
bnZtZXRfcGFzc3RocnVfZ2V0X3NldF9mZWF0dXJlcyhzdHJ1Y3QNCj4gbnZtZXRfcmVxICpyZXEp
DQo+ID4gICAgICAgICAgY2FzZSBOVk1FX0ZFQVRfUkVTVl9QRVJTSVNUOg0KPiA+ICAgICAgICAg
ICAgICAgICAgLyogTm8gcmVzZXJ2YXRpb25zLCBzZWUgbnZtZXRfcGFyc2VfcGFzc3RocnVfaW9f
Y21kKCkgKi8NCj4gPiAgICAgICAgICBkZWZhdWx0Og0KPiA+IC0gICAgICAgICAgICAgICByZXR1
cm4gTlZNRV9TQ19JTlZBTElEX09QQ09ERSB8IE5WTUVfU1RBVFVTX0ROUjsNCj4gPiArICAgICAg
ICAgICAgICAgcmV0dXJuIE5WTUVfU0NfSU5WQUxJRF9GSUVMRCB8IE5WTUVfU1RBVFVTX0ROUjsN
Cj4NCj4gSSB0aGluayB5b3Ugd2FudCB0byBzZXQgdGhlIGVycm9yX2xvYyBzdWNoIHRoYXQgaXQg
Y2FuIGJlIHZpZXdlZCBmcm9tIHRoZSBlcnJvcg0KPiBsb2cgcGFnZS4NCj4NCj4gPiAgICAgICAg
ICB9DQo+ID4gICB9DQo+ID4NCj4gPiAtLQ0KPiA+IDIuNDMuMA0KPg0KPiBZb3Ugc2hvdWxkIG1h
a2UgaXQgYSBwcm9wZXIgKG5vbi1yZmMpIHBhdGNoIGFuZCBzZW5kIGl0Lg0KPiBUaGUgYmVsb3cg
c2hvdWxkIGJlIHJlbW92ZWQgZnJvbSB0aGUgYWN0dWFsIHN1Ym1pc3Npb24uDQo+DQoNClRoYW5r
cyBmb3IgdGhlIGZlZWRiYWNrLiBJIHNlbnQgdGhpcyBhcyBhbiBSRkMgcHJlY2lzZWx5IGJlY2F1
c2UgSSBub3RpY2VkIG11bHRpcGxlIGluY29uc2lzdGVuY2llcyBhbmQgcG90ZW50aWFsIGRlYWQg
Y29kZSBpbiB0aGlzIHJvdXRpbmUsIGJ1dCBJIGRvbid0IGZlZWwgY29uZmlkZW50IGVub3VnaCB3
aXRoIHRoZSBkcml2ZXIgaW50ZXJuYWxzIHRvIHJlZGVzaWduIGl0IHByb3Blcmx5Lg0KDQpNeSBw
YXRjaCB3YXMganVzdCBhIHF1aWNrIGZpeCBmb3IgdGhlIG9idmlvdXNseSB3cm9uZyByZXR1cm4g
c3RhdHVzIHRoYXQgY2F1Z2h0IG15IGV5ZS4gSWYgc29tZW9uZSB3aXRoIGRlZXBlciBrbm93bGVk
Z2Ugb2YgdGhpcyBzdWJzeXN0ZW0gY291bGQgdGFrZSBhIGxvb2sgYXQgdGhlIHN1cnJvdW5kaW5n
IGNvZGUgYW5kIGNsZWFuIHVwIHRoZSBicm9hZGVyIHN0cnVjdHVyZSAoaW5jbHVkaW5nIGVycm9y
X2xvYyBhbmQgdGhlIGRlYWQgcGF0aHMpLCB0aGF0IHdvdWxkIGJlIGdyZWF0LiBJZiBub3QsIHRo
ZW4gdGhpcyBmaXggd2lsbCBzdGlsbCB3b3JrIGFuZCBpdCdzIGlubGluZSB3aXRoIHRoZSBjdXJy
ZW50IGltcGxlbWVudGF0aW9uLCB3aGljaCBkb2Vzbid0IHNlZW0gdG8gaGF2ZSBlcnJvcl9sb2Mg
c2V0IGZvciBvdGhlciBsb2NhdGlvbnMgdGhhdCByZXR1cm4gdGhlIHNhbWUgcmV0dXJuIHN0YXR1
cy4NCg0KQmVzdCByZWdhcmRzLA0KTWFya28NClRoaXMgZS1tYWlsIGFuZCBhbnkgYXR0YWNobWVu
dHMgbWF5IGNvbnRhaW4gcHJpdmlsZWdlZCBvciBjb25maWRlbnRpYWwgaW5mb3JtYXRpb24gYW5k
IGlzIGZvciB0aGUgc29sZSB1c2Ugb2YgdGhlIGludGVuZGVkIHJlY2lwaWVudChzKS4gQW55IHVu
YXV0aG9yaXplZCB1c2Ugb3IgZGlzY2xvc3VyZSBvZiB0aGlzIGNvbW11bmljYXRpb24gaXMgcHJv
aGliaXRlZC4gSWYgeW91IGJlbGlldmUgdGhhdCB5b3UgaGF2ZSByZWNlaXZlZCB0aGlzIGUtbWFp
bCBpbiBlcnJvciwgcGxlYXNlIG5vdGlmeSB0aGUgc2VuZGVyIGltbWVkaWF0ZWx5IGFuZCBkZXN0
cm95IGFsbCBjb3BpZXMuDQo=

