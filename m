Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F039C04FF6
	for <linux-nvme@archiver.kernel.org>; Tue, 16 Apr 2024 09:06:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WzjFYuBPcLQGUW/6s4sUNPgHiLDBwXrTw8xenDAKiOU=; b=eSp9RHNITmaXhGNEscj7/Oc8GZ
	AOwDUks4J2k+zRI2C+oBzqwzD6pMhI0OMPCep5XR9fOD0FdoLfgUC0wVBuI6s9450snBr1byEDTT+
	TFEJhepSrhWFkFTRG4uq7Ugikxg108LRPo+oY4FqkXCSKsC1Zp7rbNhVAxBqPKW9H4lkQCC3l2/H1
	utJNprEd1IUzONgUFrfWjR1O6vIpTzoYSF868rs5QgJymCnS2FpaPwPi/ePtPpEVBgeYINRhJhhut
	ZYuF8T879EWcpi7W3pYC6Vi7NU75jloPvWT8Me049HbPnA6lpzIKTtzRO9y9TVl/XEpcQkne36h8N
	LyNZAGmA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rwem0-0000000BY7u-2jFN;
	Tue, 16 Apr 2024 09:06:40 +0000
Received: from mail-dm6nam11on20601.outbound.protection.outlook.com ([2a01:111:f403:2415::601] helo=NAM11-DM6-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rwelu-0000000BY6M-3jl0
	for linux-nvme@lists.infradead.org;
	Tue, 16 Apr 2024 09:06:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gBbsIu1IIwCM8bFMIlMc1aN7pzNFQTjGnOrs4XTm9gFVTTt4uD8B4ovVQezVHRTVSG2XeNehm72yhTsVegixtAW6/WVfoNkUkGPHMXkGgxkc6V9XYNC7H3q1TCPSmdo16vru2FfE+AskYCgRr57JHrWPCEodKxxsJaMdV5QD7rk9B7HWa5hfHi9PMC3fNpUXwcVUOcgULKPvB/ORbi7euWGASD4Fj1S6EytDrKciFR9LfeHPTNzLmvQkewM5LmppSv6mJ4ZfpkEsvT9q/zGII2y5QATb/MbL7LSv0qzJ6aP4ThJHjiz0OE/Z+Tuwrw1FRsZYh0PbkN97aDNfyhl7WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WzjFYuBPcLQGUW/6s4sUNPgHiLDBwXrTw8xenDAKiOU=;
 b=jnmGLxY9ZgdBD2XBW+MI/M+ZgCDDzFdoNS4HNGaEKApUwsVdnlAHiXvxImPthbcM253YnYImTT6pCt6OXvsIJJmb8eQ9a8B2KYKYk3rsy4ORDhtYF9yb+Mey2tiPhbogVmZ3W/mgzrZse4uwbeVAUKk4kzPwHJ4KC/PuTNxkgFZhhKsp0MKMxA8eNDN4MZ+zo3eU35n++AGbadtkWKP5DTw5xNVN1V9Y1WCZlU9XuZJoZs2nqLpZG9sE2nUQYbBXO9tpHb3UycMbqvAezyN/izOIDX9DyqmfE9EecMsjW9wbnkif467lRdE+/r70p0OiAgw9ffqPkpbZ8/pRrhYRkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WzjFYuBPcLQGUW/6s4sUNPgHiLDBwXrTw8xenDAKiOU=;
 b=TbHF3olj8QPuHNQyAP1SFO+vbcQWiLDCbWj7kI1nyUf/tP5B48LPd+Ggjv4T6cP7aqGA63AVXAym2mVPvxRMgL/1cvsG5rwU3DyEqL4jwGo1/SOIAchoxapBssTMERlRqcerZvaM64S9KrrRu1blIpgNdX7rUdNuJ+PX8j9dSBtrpfdAy7bAxLrpG7jPGzS0JmhbK90GcZ4WXGHpZOFDrQ2OC5RYZgYZss9XPm7Iikhpd2YpBOKHDFZ3EzPkt25ZD8SZ343N2TSwzBEWp8ojwERBBhwKtSaJqVQuh/amO1PJOaPyKLY0y6IjkkuoQ6Jwgl6cEzrZMRQ/koAd+qIlzg==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by IA1PR12MB8467.namprd12.prod.outlook.com (2603:10b6:208:448::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Tue, 16 Apr
 2024 09:06:27 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::a1:5ecd:3681:16f2]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::a1:5ecd:3681:16f2%7]) with mapi id 15.20.7452.049; Tue, 16 Apr 2024
 09:06:27 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Nilay Shroff <nilay@linux.ibm.com>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>
CC: "hch@lst.de" <hch@lst.de>, "kbusch@kernel.org" <kbusch@kernel.org>,
	"sagi@grimberg.me" <sagi@grimberg.me>, "gjoyce@linux.ibm.com"
	<gjoyce@linux.ibm.com>, "axboe@fb.com" <axboe@fb.com>
Subject: Re: [PATCH v2] nvme: find numa distance only if controller has valid
 numa id
Thread-Topic: [PATCH v2] nvme: find numa distance only if controller has valid
 numa id
Thread-Index: AQHaj0DL5uOxMb7+oE2Z3Jlm6ub9+bFqLzYAgABHuoCAACVJAA==
Date: Tue, 16 Apr 2024 09:06:27 +0000
Message-ID: <ccc7f60e-3c12-4245-afda-b4bdcb6c22ef@nvidia.com>
References: <20240415142408.889236-1-nilay@linux.ibm.com>
 <a31a6787-16cb-4dfb-afa4-f24d66faab3f@nvidia.com>
 <391005cb-2a3d-426e-b539-30faf23c6efc@linux.ibm.com>
In-Reply-To: <391005cb-2a3d-426e-b539-30faf23c6efc@linux.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|IA1PR12MB8467:EE_
x-ms-office365-filtering-correlation-id: bdaaba56-de95-445f-9337-08dc5df47f93
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DClNMzoSWFYcCIdy7q7MQKxeBt1YyXWu296+aYKYgIOBxVThB2Um5M9O2gq2h6I8ogQGDE3IEhM+jdXwg8gv/NTE5so3tHf5ZQf5+RMFuk4MA58NAButCgfbF/KKjrnIYgZwGqdOxObS5cIBeQ4QiVthI8NiLbC5Szv1X3IlGej4nR2vSo3vDhlXdtVPdyZdVIEdBjGeTxKu/gbQx6L/0L/UgR5w5Re0SuiWw8fP03P1mZD02pVGpWvRq4evYn2mT1kShsolkgp7VaQhXGTdV6lZJzLw3KquCn51OLsPwHmi1esC0F/jvcitSrgBp3pB7AVZAx6tmipNORv/oZisJaU9r9u3R983mg1N4JoF9/u7o/JqyxTrgVZGaVsHTh5LsrjXntJTuOVhHd+N1klfdiZHn0xUitWJkGMXu8ZnCpHPh+A3NXe/3Pt93ru7bKhqLBR6LDHOqn6+UlW1pU17Atvosm7FI3O+DSa+wiSz/bivZuKRdTD9g22SwFeqIyHNeC/xuL+OLzAHMC27GC+Iad/2Tpe7KnMHOO49FAemAPNU5uITIqYUYGE83UOWANdPakxmv0+b6sJOGw+ft8W/qeQOGa7fYoGZ+r7Rs4rkrLyJlJ+iNonez4/WRyhtarC7lDRHW3HAFbJNdbDzX7n5lYZKiBb4yaffm+CNhI6URowWHPCH1mWnYyqm1BuueNsKPlFLd7ETi2AdzDTxFHwYwiN5Pw9MAwA++8+tf0PybrA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?b3BZS3V0QXc3S1plNWhFdDlRWW5uT0lpeXJoY0x1b2VTVXFGaTVBTUo1ZEpn?=
 =?utf-8?B?MjVSMlE0aVhxajdaOVVncUdtSlJsUElpK21CNlczYlhRTkt1TmVQWVBPUzNl?=
 =?utf-8?B?bitnc1ZxU0FxRDZuMGV0S0szeHl4V1ZycWlZdWZ2alhFbmt5QndpR0JmMUVs?=
 =?utf-8?B?QkRCZWpYS0p0dEsyZThwUkZTTHBOR0t5WExtK1l2c2YvT0lZaWNCT0djeDFK?=
 =?utf-8?B?NCs5NDVLVXBjbnBPSitiWis1Wi84WjIwOFMrREdNTmhtWDFwVHJFbU5zRzd3?=
 =?utf-8?B?eTZUaFNlV2VPczg2M0NsTFhBREFBclZLalFqRCtHVkJUSTB3Umc0Vm05eFMx?=
 =?utf-8?B?bHlxcHRTTWN2WHBiMEsvbUI2M1BVZmhxMExIT1l1ZHFZaFQyZld4ZkNrQnpp?=
 =?utf-8?B?dlkwRVpDQTJlSUJwWFIrdzcrMTVzR012cjV3Z0FtelVhWTl2eFRHQ2lQQ0NP?=
 =?utf-8?B?SVRWS1EzcFVYeEpwOEt5Z3V4Sm5tSkZ3Z2NCV1V2S3RsVFhaQkxrcHcrSTRN?=
 =?utf-8?B?Q3FNdFNKbHY1TWZhdGRkUHJOY25WK0NMNTk3U2hzcFlQL2liTlJ0YzZtUXVY?=
 =?utf-8?B?YWRISEhzSTNjdnM3a21mS1F0QTdzUTh1anBaRFdxQUxDdDRnaTZuQ25jc0tB?=
 =?utf-8?B?SStCcXVYTmdnclJLYzJoSTFXaGpwZ1I0YzNCOFpnVDFFRi9OOVl1T0VrSklj?=
 =?utf-8?B?aVVpWTdaYWpJcW9rSUR1VDdqZHVzZ2tWNWRYTUdmMnhJeTVUdzZzdTU3eHBP?=
 =?utf-8?B?TWtyMWtnU1l3cnZ2dVhBeWFXa1JEVHd6a1Y4N2pKSVAyVG16MDdOOGNoYUg4?=
 =?utf-8?B?enRNemlJVXlXbEF1MWRyMVRmemZFQWl4eTNQeGVPMFQ2WGQ3TFBvd0cwVHlu?=
 =?utf-8?B?NDdGVnNFU3JpWGdSb0Z5YmgySC90VjhCcnBmT2hWSnFpYXUxdnFVR0lxNHJN?=
 =?utf-8?B?d25vbGVUNUZUTkxQcjl4WDNpK3pKcjVraUdpNDc0cDJBaW5iRDZCYWZmVWpq?=
 =?utf-8?B?T1NwZFZUOXdreVhjZWVJMjgzYmsvUjVzd3BOb2w3N25vdG0zdGJ0Tno4aVV0?=
 =?utf-8?B?NVl2YnE3d0RnTG4xaDhIcTVQOWlkWDVBckg4Zk5VS201UjVRT21Hd1lMK1FH?=
 =?utf-8?B?d3JDVXhVdHpveU5WcmtYb2VKb3cxM2NhMWNsUGY4NXV0QW53YmlIZFFYUFdL?=
 =?utf-8?B?QWhqYUd5WWMxaElvdWhleVN4OGFFMlBPWk5Kb204MzFaZnoweUs0R1J5em5O?=
 =?utf-8?B?aUFVZ2p1NHVFZ1ZIUjFDYXZiMXd1eURlRmF0a0V6TGYyOTdhRFdMcmFPc3k3?=
 =?utf-8?B?ZENobDFkdUtTbVNEdnU1Z2J6a0J3SjZHVVNTRUYramk0ak1YeCtNU1RnRmM0?=
 =?utf-8?B?eHlmeG1rdDAvZVlmcHluTTNkY2svTVFwOHZzTzdYR0oxcStwUlZWR3hmTDQr?=
 =?utf-8?B?VGdyRnJkZk9tRXlIWFg5cjV1WWg0UVV5QnhXTlFKaitTVnRFMWpCeVNpRFhM?=
 =?utf-8?B?RjRkWTVjdFI3QWd4YVl4ZktXU3Z3Q2kybHJQcitZbktJb29JNnhiQVZCdFVY?=
 =?utf-8?B?b0JvNmRVNWY4R0ZTK2RVSHlGcnN1TE9mK1NFeURtTHNRN0RuSUtiV2poSDBm?=
 =?utf-8?B?RWxiWktJRzRtRjArZnduaExBNE56WXZOYmRZakorYzVRbUg1aEN4c0lnaksw?=
 =?utf-8?B?RFhYZzB4RG1CNmJjcFN2L1FzVmVNR2JsVlByeVl6VzlpTDhNUExWMkNNWW0v?=
 =?utf-8?B?NllENXhTanAyZ2tQL2o1cS9pb0szVnozVk1qMmtMaTd1MVc1cmxMbko1UWVG?=
 =?utf-8?B?SVl1YjMyamRPWFIwTGJYUjN0T1R2c2Q2RjBxTzVjMmhXNkxWVno4cjMrc2Yr?=
 =?utf-8?B?RWJRcnNOMFoyVTQwZVBzMnI2VnpmcHhselZPd1B5ZXJ0aXR0cTRDSVduVjd4?=
 =?utf-8?B?bFRsNWRvUzQ1SkNid0hPMHVpNFZtM2Z3RVFaK1RZT0QrU3JDYkNyQi8vWmY4?=
 =?utf-8?B?QnR2Mk9BQzlEbXhjWnJnM2paOWtLaDdwYzFwY282YjBUMFZyL1BOd1Bpc0dM?=
 =?utf-8?B?d0RlZEhZa3VIbndlcnBRbFY4SUJIdlNjdng0VXVrYUx4dzNxTE5MMksrcm9E?=
 =?utf-8?B?ZEZ4Z0x5N1RTNERBU3BBZzVWbVdrSjhSQWQ3cWhOdU5oMG5HSEZhbVFEbWN0?=
 =?utf-8?Q?jO03+FYalnttB2ijfIKK8dw/gxJLsQajEbDfyjysro9R?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5984EEC95E0E2E4F87AD830B4EFA0A51@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bdaaba56-de95-445f-9337-08dc5df47f93
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2024 09:06:27.3003
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: E7yRUjKmsC7dIFjCfilMWaFTJRvJ9nDRvIIxVXyiy/8BOo+zkwSOfUTGhgM2QE0StJrW+Zt0D4ZuM5NhV/XHzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8467
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240416_020634_966763_515CA732 
X-CRM114-Status: UNSURE (   9.20  )
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

T24gNC8xNS8yMDI0IDExOjUzIFBNLCBOaWxheSBTaHJvZmYgd3JvdGU6DQo+IEkgZG9uJ3Qga25v
dyBidXQgY2hlY2twYXRjaC5wbCBkaWRuJ3QgY29tcGxhaW4gYWJvdXQgbXkgcGF0Y2ggb3ZlcnNo
b290aW5nDQo+IDgwIGNoYXJzIHdpZHRoLiBBbnl3YXlzLCBJIHdpbGwgcmVmb3JtYXQgdGhlIHBh
dGNoIGFuZCByZXNlbmQuDQo+IA0KPiBUaGFua3MsDQo+IC0tTmlsYXkNCg0KY2hlY2twYXRjaCBk
b2Vzbid0IHdhcm4gdGhhdCBhbnltb3JlIGZyb20gd2hhdCBJIHJlbWVtYmVyLCBJJ3ZlIGJlZW4N
CnZpY3RpbSBvZiByZWx5aW5nIG9uIGNoZWNrcGF0Y2ggdGhlbiBjb3JyZWN0ZWQgb24gdGhlIGxp
c3QgYWJvdXQgODANCmNoYXIuDQoNCi1jaw0KDQoNCg==

