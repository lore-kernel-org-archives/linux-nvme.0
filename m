Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 089A9C4167B
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Nov 2023 03:03:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wqs4JyFqyK23ko4jTrYpjTWfErqqeJ5qcDh1emPAgi8=; b=H/9yeeYukxS3i/27UAy0jBJlPE
	ToX+c41VHFZRyYBLy7z5+lvV+wLdyZQX+qYDrW7oXfye5eHJs809YJC6ipvhWurBlnstuP1yhtGGF
	iwmJ1hpIfb1JgjdJP3KfU2eInJFsCatb1Cvr1KpSWqwzdvlEn2/w27woQnDew42cGYKvQsK9L01I9
	XVjP5mX4xV/i6OeYWoxRklRLYHb0Pr2XsEj+s90jWA3ogHefIxS3lML15bk7gPpdrwJ+S1qPrSeIF
	yaMz/UK+PCh491STsW4Gpbhew/zl8AgbrPe+5Ke6EZsmdb0LRSlkVYze3yV26nICXeMm2Z1+4IUDp
	fFB0qF9w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r7oO2-003wKP-2z;
	Tue, 28 Nov 2023 03:03:46 +0000
Received: from 219-87-156-124.static.tfn.net.tw ([219.87.156.124] helo=mail.siliconmotion.com.tw)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r7oNx-003wJm-36
	for linux-nvme@lists.infradead.org;
	Tue, 28 Nov 2023 03:03:44 +0000
Received: from twexchange04.tw.smi.ad (10.10.14.75) by twexchange04.tw.smi.ad
 (10.10.14.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.21; Tue, 28 Nov
 2023 11:03:25 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (104.47.26.104)
 by twexchange04.tw.smi.ad (10.10.14.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21 via Frontend Transport; Tue, 28 Nov 2023 11:03:25 +0800
Received: from SEYPR01MB4341.apcprd01.prod.exchangelabs.com
 (2603:1096:101:5a::7) by SEZPR01MB5863.apcprd01.prod.exchangelabs.com
 (2603:1096:101:18e::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.27; Tue, 28 Nov
 2023 03:03:20 +0000
Received: from SEYPR01MB4341.apcprd01.prod.exchangelabs.com
 ([fe80::7eef:8266:d500:3bd3]) by SEYPR01MB4341.apcprd01.prod.exchangelabs.com
 ([fe80::7eef:8266:d500:3bd3%6]) with mapi id 15.20.7025.022; Tue, 28 Nov 2023
 03:03:20 +0000
From: =?utf-8?B?SmltIExpbiDmnpflv5fono0=?= <jim.lin@siliconmotion.com>
To: Jim.Lin <jim.chihjung.lin@gmail.com>, "kbusch@kernel.org"
	<kbusch@kernel.org>
CC: "axboe@kernel.dk" <axboe@kernel.dk>, "hch@lst.de" <hch@lst.de>,
	"sagi@grimberg.me" <sagi@grimberg.me>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, =?utf-8?B?Q0ogQ2hlbiDpmbPnvqTlgpE=?=
	<cj.chen@siliconmotion.com>, =?utf-8?B?RGF2aWQgWWVoIOiRieWvsOiejQ==?=
	<david.yeh@siliconmotion.com>, "hardaway.tseng@sk.com"
	<hardaway.tseng@sk.com>
Subject: RE: [PATCH] nvme-pci: disable write zeroes for SK Hynix BC901
Thread-Topic: [PATCH] nvme-pci: disable write zeroes for SK Hynix BC901
Thread-Index: AQHaIaaw356JjjC8nUSs8ZeDojc5rbCPCi6Q
Date: Tue, 28 Nov 2023 03:03:19 +0000
Message-ID: <SEYPR01MB4341EFAA7D4B563BFF903B45FDBCA@SEYPR01MB4341.apcprd01.prod.exchangelabs.com>
References: <20231128025737.53026-1-jim.lin@siliconmotion.com>
In-Reply-To: <20231128025737.53026-1-jim.lin@siliconmotion.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-rorf: true
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcamltLmxpblxhcHBkYXRhXHJvYW1pbmdcMDlkODQ5YjYtMzJkMy00YTQwLTg1ZWUtNmI4NGJhMjllMzViXG1zZ3NcbXNnLWFkODUzM2RhLThkOWEtMTFlZS1hNzZmLTE4NDczZDQyNWVhZVxhbWUtdGVzdFxhZDg1MzNkYy04ZDlhLTExZWUtYTc2Zi0xODQ3M2Q0MjVlYWVib2R5LnR4dCIgc3o9Ijg4NDIiIHQ9IjEzMzQ1NjE0MTk4MTAyMTk1MyIgaD0iNmFHc0dod2R4bDg5MkpwZHNzVHNmTEt1bUNZPSIgaWQ9IiIgYmw9IjAiIGJvPSIxIi8+PC9tZXRhPg==
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siliconmotion.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR01MB4341:EE_|SEZPR01MB5863:EE_
x-ms-office365-filtering-correlation-id: bb6fa33a-6f07-4d60-1ac8-08dbefbe936c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: S34iLwSGoGoO9JlIdtV61mERbzSpUH3/6eyXwm8E8vrvipRPzCzq8ttX0L4VQeDBbpc12JgmmwrL//4ASE7QJNTRvSUbgFVavh5noq09IjO45DSSY8RtR1n8kuO1vG1V1D6LJXU1jeICWz+Zk2vAnXGRBJzlsc2HwMa1znXK3+OoYvDH4/WSXNSsLj8U35lD03PihvIq1vHUPqmwRdZIxGpEKFr406nfCUFRZV5XStBnAbijzmUKjbA73jHtbDlmoxsuhsJqwgQrhYJEjKMKZlaxMtT0/0czxZELWQbxNViRz6FJpwe5MwgGYmoF8IHFrnIW//CuDpl3kd8jNgcUFx+R7C8WA80O+r3wCv7pPlUCSdBSzgqTFhrnhat7BC2PXNZy/FpUV5G7cfGznZazOSqVheQteNsfWuCkuk909GaEpoKuYNqSHCtPRkUi2p4pXxD48YyhBfuNZGGr9x/JBVmgCqlOB8BB2+Ru71thVS9Wbcrz6tOQ+SCwsjXBZ4UbyB39yO+cflxEeI5BxvEJ0SyJIXlpGnqU3a2BC06sTX5e35Sv3fNREdvqJrM43mECjzDkHpCnYcEyadcLh9/72wNsm2b0cWq7ne6SJSBPV5denoMp3LNbn9mZq3Ix/iwssMwTXBqjcp3Iue1kNcVcubyYjQp6Xxwh0Vc+mnbsbjQL9Y1N09GUE2v64+qJA5co1+UAEi2itJ7w7WxLaMfs3Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR01MB4341.apcprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(376002)(366004)(39850400004)(346002)(230473577357003)(230173577357003)(230373577357003)(230273577357003)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(5660300002)(2906002)(86362001)(71200400001)(478600001)(7696005)(53546011)(9686003)(316002)(54906003)(66946007)(66556008)(66446008)(85182001)(66476007)(4326008)(76116006)(8676002)(8936002)(122000001)(64756008)(33656002)(110136005)(6506007)(38100700002)(83380400001)(38070700009)(52536014)(55016003)(41300700001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZWxkOURZc04zcmpGR2hkbmdWUENFbHZzTTV4bUduQVdxRFBPSkdHMnloem1V?=
 =?utf-8?B?dlBremg3QUV3LzlzRkZPblM5WjBhVlo4eXFwbCtoUm5SeWFrWlBjN1Bkb1Vi?=
 =?utf-8?B?OVMrN2tXN0FOSSs4eFIwbVp0bUo5YlMvbVpRc1RpZFQ2OU9UTzRzRDZwMGY4?=
 =?utf-8?B?amNMVzVkbHhSKyt1MVNHUjVxT2VCNUR0RnJIZ3lWNGhZZnlONHBTcEpQZWZL?=
 =?utf-8?B?N29Gb2sxd3VIakhHbUlnQUhoL2JnaFZxVTJIblRJYzk1aENyMUxTMWdMVjg3?=
 =?utf-8?B?eDhJd1NZdmxtUjRJV1N2SWVScWUraE01OVFlWlNObEw4L1hocmFpZlFWMW5T?=
 =?utf-8?B?V3NJck8rcXArRFJQVHdqd0IveUNWYytTYjFCb3pzZzU0V200ZkZkVEVkVzl1?=
 =?utf-8?B?WjMyTXpwNGpBYXBYRi9rUHRrcFFuREd6ODgrNFRSOVdoZVlyc0h4L2tmdUpj?=
 =?utf-8?B?cUI1NlQ5VWk5K3BGRCsvb2dFOXo4a1duWEUwZ3FYYkc3TlIxMkJvblVDRXd1?=
 =?utf-8?B?ZWlMdHRYOFRQOUVUWGVhTVBSUXE1dCtLeE52MmVmVzR6OVI0eEV5VHBLTUdB?=
 =?utf-8?B?d3hPditPekREZXlUNGVjeGVDNER6bXk4bThtWGhFNG5JTWlCRWNwU2xreUlO?=
 =?utf-8?B?aWdrZzR0bGFJUkJwREh0K1ZkM1ZhRGl3Z0lMTEpmcFdRRmJxQ2N1Mm11Kys0?=
 =?utf-8?B?MFBpVE8ydDFaaTY5Q1Q2Y2JwMjJVWUZ2R0RRbGVWaUIveTBCQ3hpRmRwTFVu?=
 =?utf-8?B?UnZtcnpIeUF0SjBoSkFZTFJHbUVYTlJSWnNXNFdUdnc4NFZRb1FSQjY4NkVk?=
 =?utf-8?B?bmw3cmV1TWxYcU8ycFdyTGIyTmQ3NHRoWE5GWUhFTmlYNGNuWjJxWWRQN0VY?=
 =?utf-8?B?U05UMllhdzBFRnRzanBDdlZtU3JFNHQzQzN5NkRkS0JaMUtXUU1mZlUyTFVO?=
 =?utf-8?B?MnFNTlBPRG15OGlKYWJOdUt4Sjl5OGNsUW1UMFExUXVIaTFHczM5K2VyL1pI?=
 =?utf-8?B?US9xREJyTjFnemY5VitkZHQxSFBlTjlzeDhWTXM2VndqS2xLL2RGVDBwYjFB?=
 =?utf-8?B?WG9rYWxLSWI0RlpsVlc3TVJaWWpXdGdmZVNVVmRJZHZ4V1NxaUZaVGFnR29l?=
 =?utf-8?B?b002SVA5dXRHdnBPanJiZEkyUTJFZkRYb1N2OVhUT2g4YjYzTStDOTcxOUpG?=
 =?utf-8?B?NVlKS00wV21BaDlGQURNeWJ2elJVYm5Jd3VVMXlnR25OZjVobEYzSUQ0U2cw?=
 =?utf-8?B?U1RhZ01tWmlHZWE5U1ZIdGZ2dEZEcWJuSUw3VE5RVWV6aXNOZ0VzczBFZG5C?=
 =?utf-8?B?RUtTSSs5aHdDTVIxanRuYmNLam84cnpucWJWcE9ydUd3U0JyT0t4WUs0WWs5?=
 =?utf-8?B?SXZLVUg4dEpIYmt1RjdxTzAxT0hVWG82U0cxanJyTFVVdFgrd2hJZzZBQW8r?=
 =?utf-8?B?ODhlaUJ3WmgxdkdjUlZ4V3BQMndnTUIyLzIybDFHV3BzYUdaVHZab1Z2WDZ0?=
 =?utf-8?B?eU5iSXVHbnNLMC9PSG9OUStYTmUzMlVkUW43NzBvMWgrOXJlNW5WMDViaFlJ?=
 =?utf-8?B?RFN4cnM1cmQ2VjdJeXBrS0tVNkRZcmpMbkYvRWRYRjFvOHVtZ3hKQ1BGMFlH?=
 =?utf-8?B?aDNiYlVhdmdzUHFKRW5VWTQ0clZ6Z001dUxyV3I4aEJveUQxRXY1UFFQbStD?=
 =?utf-8?B?dWNkeDZpZVlxSFpqMWFlQkJHdkdqWHFoRDZhM0tLS1VEVWtacmZpZG1MVFJI?=
 =?utf-8?B?d1gxMEJ0QVBreTV3QytyOXR2RkMyYkNoMGwyWkQ1TXR5SklxOHVzejVGOUo4?=
 =?utf-8?B?RC94OGlHbWhWK0lpSVRNRlc5WldPZEtwRzhzb2Zpem1Jcm5aQzRSR2lqQ0JE?=
 =?utf-8?B?a3BkK3lKSXBhZ0w5R1dFMFl5Rm9BMHI1TjhaK2cxZzhmVFpVSExxS29jcFZ0?=
 =?utf-8?B?TU9HZnpGSHFlMTZyRFFUUHFyaWJDZnZNeS9Uc2lBRGVzVTh0N1B4NXAvekI1?=
 =?utf-8?B?VFNnQ1dzR1IrUVJyc0dqNDF6UTAyQ2JNczVPWVFwcFhNSHl4TWxmNFBiWWR1?=
 =?utf-8?B?MERMRVczeWkvWUVuOUp1TmorOFF0ZjVqQ1BLQUNpZitjak9lSG52bGcyVGhY?=
 =?utf-8?Q?aq04=3D?=
arc-seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hw9jbhQAO4xzXS0S/L15LyaEBUtT9qCGCyaYTDl8K0kKD0P0FmQKUXwiX33d71Hy2bPEVgiBeMcOhCDuYcweZEnCsWFHCG3IcjqFYVTE3diTaFJPKDLso3RnZLbEyMlfVPIR/PWBUQW7VAKmELwPz2WiQ9OcGR2t7fKU366l92BOQjVeg/P7FSb9QDwf+SrkEoeyO9vE74lAoMTBLEK2SJMtX0Tr3aA+qasx2FEQir9mrkBvVZF3vp2D1g1uYAkkSLGl+T8VUEiEaOm/YTmdcRoL5BuzmSEButvbycz/6u1knRB9F1SDqgIjX0anHTynFdG2cp/ct9nXYlCXu0uLqQ==
arc-message-signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wVNTj5t/InJhfbR8YQ+oc18CQkpiRKC5iWrwC4aZFiI=;
 b=dyLGUhXZYOa8qnqkIS4FQfzG1AexkXIvjksEMh+1rzelMR8EHrlJhf8Ctg6j46oYxnolhrLQ8DHyeI/MIQKNrpRYiQeud3YOqz/8zJEuY9EmWwlydQ0F3tHl87oRpfH3TlMbj60pYTUbKnzJXbVqr20rx1GRToSD2821R4EHghzKC03Q4NpquOiJKwJORP2NbERDyTD33DJHsvDDpoekabITJuq9kCp/7lYmcWLctc5Q/wcccZWsNoS7X5dRQeKlsCT22yb9s05LU1/+KmLPby2qI9ygL2vhc0Ldv2luXj7319IXMedScpVhiPYgQxymAK7ScDdOZP9EsoPGCFSlvA==
arc-authentication-results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siliconmotion.com; dmarc=pass action=none
 header.from=siliconmotion.com; dkim=pass header.d=siliconmotion.com; arc=none
x-ms-exchange-crosstenant-authas: Internal
x-ms-exchange-crosstenant-authsource: SEYPR01MB4341.apcprd01.prod.exchangelabs.com
x-ms-exchange-crosstenant-network-message-id: bb6fa33a-6f07-4d60-1ac8-08dbefbe936c
x-ms-exchange-crosstenant-originalarrivaltime: 28 Nov 2023 03:03:19.8651 (UTC)
x-ms-exchange-crosstenant-fromentityheader: Hosted
x-ms-exchange-crosstenant-id: 9f1a12d5-61be-4e93-94e4-5cfbe224c4f9
x-ms-exchange-crosstenant-mailboxtype: HOSTED
x-ms-exchange-crosstenant-userprincipalname: nx0nuKnLhfHEQGPsnEjrkucCaio3F4xMNGw9+a0b/zwbqoxAiOqSSRhwaUzArk3cHoQrltV25rYX+MIbGzDCnnS0msqS8juFlYB5Zzf+VZA=
x-ms-exchange-transport-crosstenantheadersstamped: SEZPR01MB5863
x-originatororg: siliconmotion.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231127_190342_013331_EE9E98A4 
X-CRM114-Status: GOOD (  16.05  )
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

SGkgS2VpdGggQnVzY2gNCg0KVGhhbmtzIGZvciB5b3VyIHJlcGx5Lg0KQ2hhbmdlbG9nIHVwZGF0
ZWQNCg0KSGkgRGF2aWQsIEhhcmRhd2F5DQoNClBsZWFzZSBoZWxwIHRvIGNoZWNrIHRoaXMgaXNz
dWUuIFRoYW5rcy4NCg0KVGh4DQpCUnMNCkppbQ0KDQotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLQ0KT24gVGh1LCBOb3YgMjMsIDIwMjMgYXQgMDY6MDY6NDJQTSArMDgwMCwg
SmltLkxpbiB3cm90ZToNCj4gU0sgSHluaXggQkM5MDEgZHJpdmUgd3JpdGUgemVybyB3aWxsIGNh
dXNlIENocm9tZWJvb2sgdGFrZXMgbW9yZSB0aGFuDQo+IDIwIG1pbnMgdG8gc3dpdGNoIHRvIGRl
dmVsb3BlciBtb2RlICJkaXNhYmxlIHdydGllIHplcm8iIGNhbiBmaXggdGhpcyBpc3N1ZSBhbmQg
U2sgSHluaXggaGFzIGJlZW4gdmVyaWZpZWQuDQo+DQo+IFNpZ25lZC1vZmYtYnk6IEppbS5MaW4g
PGppbS5saW5Ac2lsaWNvbm1vdGlvbi5jb20+DQoNCkZvciB0aGUgY2hhbmdlbG9nLCBsZXQncyBh
YmJyZXZpYXRlIHRoZSBzdWJqZWN0IHRvIHNvbWV0aGluZyBsaWtlOg0KDQogICJudm1lLXBjaTog
ZGlzYWJsZSB3cml0ZSB6ZXJvZXMgZm9yIFNLIEh5bml4IEJDOTAxIg0KDQo+IEBAIC0zMzk0LDYg
KzMzOTQsOCBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IHBjaV9kZXZpY2VfaWQgbnZtZV9pZF90YWJs
ZVtdID0gew0KPiAgICAgICAgICAgICAgIC5kcml2ZXJfZGF0YSA9IE5WTUVfUVVJUktfRElTQUJM
RV9XUklURV9aRVJPRVMsIH0sDQo+ICAgICAgIHsgUENJX0RFVklDRSgweDFjNWMsIDB4MTc0YSks
ICAgLyogU0sgSHluaXggUDMxIFNTRCAqLw0KPiAgICAgICAgICAgICAgIC5kcml2ZXJfZGF0YSA9
IE5WTUVfUVVJUktfQk9HVVNfTklELCB9LA0KPiArICAgICB7IFBDSV9ERVZJQ0UoMHgxYzVjLCAw
eDFENTkpLCAgIC8qIFNLIEh5bml4IEJDOTAxICovDQo+ICsgICAgICAgICAgICAgLmRyaXZlcl9k
YXRhID0gTlZNRV9RVUlSS19ESVNBQkxFX1dSSVRFX1pFUk9FUywgfSwNCg0KQ291bGQgd2UgZ2V0
IGFuICJBY2siIGZyb20gdGhlIHZlbmRvcj8NCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLQ0KDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogSmltLkxp
biA8amltLmNoaWhqdW5nLmxpbkBnbWFpbC5jb20+DQpTZW50OiBUdWVzZGF5LCBOb3ZlbWJlciAy
OCwgMjAyMyAxMDo1OCBBTQ0KVG86IGtidXNjaEBrZXJuZWwub3JnDQpDYzogYXhib2VAa2VybmVs
LmRrOyBoY2hAbHN0LmRlOyBzYWdpQGdyaW1iZXJnLm1lOyBsaW51eC1udm1lQGxpc3RzLmluZnJh
ZGVhZC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IEppbSBMaW4g5p6X5b+X6J6N
IDxqaW0ubGluQHNpbGljb25tb3Rpb24uY29tPjsgQ0ogQ2hlbiDpmbPnvqTlgpEgPGNqLmNoZW5A
c2lsaWNvbm1vdGlvbi5jb20+OyBEYXZpZCBZZWgg6JGJ5a+w6J6NIDxkYXZpZC55ZWhAc2lsaWNv
bm1vdGlvbi5jb20+OyBoYXJkYXdheS50c2VuZ0Bzay5jb20NClN1YmplY3Q6IFtQQVRDSF0gbnZt
ZS1wY2k6IGRpc2FibGUgd3JpdGUgemVyb2VzIGZvciBTSyBIeW5peCBCQzkwMQ0KDQpQbGVhc2Ug
bm90ZSB0aGF0IHRoaXMgZW1haWwgd2FzIHNlbnQgZnJvbSBvdXRzaWRlIG9mIFNNSS4NCg0KU0sg
SHluaXggQkM5MDEgZHJpdmUgd3JpdGUgemVybyB3aWxsIGNhdXNlIENocm9tZWJvb2sgdGFrZXMg
bW9yZSB0aGFuIDIwIG1pbnMgdG8gc3dpdGNoIHRvIGRldmVsb3BlciBtb2RlICJkaXNhYmxlIHdy
aXRlIHplcm9lcyIgY2FuIGZpeCB0aGlzIGlzc3VlIGFuZCBTayBIeW5peCBoYXMgYmVlbiB2ZXJp
ZmllZC4NCg0KU2lnbmVkLW9mZi1ieTogSmltLkxpbiA8amltLmxpbkBzaWxpY29ubW90aW9uLmNv
bT4NCi0tLQ0KIGRyaXZlcnMvbnZtZS9ob3N0L3BjaS5jIHwgMiArKw0KIDEgZmlsZSBjaGFuZ2Vk
LCAyIGluc2VydGlvbnMoKykNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvbnZtZS9ob3N0L3BjaS5j
IGIvZHJpdmVycy9udm1lL2hvc3QvcGNpLmMgaW5kZXggNTA3YmMxNDkwNDZkLi5mMjcyMDI2ODA3
NDEgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL252bWUvaG9zdC9wY2kuYw0KKysrIGIvZHJpdmVycy9u
dm1lL2hvc3QvcGNpLmMNCkBAIC0zMzk0LDYgKzMzOTQsOCBAQCBzdGF0aWMgY29uc3Qgc3RydWN0
IHBjaV9kZXZpY2VfaWQgbnZtZV9pZF90YWJsZVtdID0gew0KICAgICAgICAgICAgICAgIC5kcml2
ZXJfZGF0YSA9IE5WTUVfUVVJUktfRElTQUJMRV9XUklURV9aRVJPRVMsIH0sDQogICAgICAgIHsg
UENJX0RFVklDRSgweDFjNWMsIDB4MTc0YSksICAgLyogU0sgSHluaXggUDMxIFNTRCAqLw0KICAg
ICAgICAgICAgICAgIC5kcml2ZXJfZGF0YSA9IE5WTUVfUVVJUktfQk9HVVNfTklELCB9LA0KKyAg
ICAgICB7IFBDSV9ERVZJQ0UoMHgxYzVjLCAweDFENTkpLCAgIC8qIFNLIEh5bml4IEJDOTAxICov
DQorICAgICAgICAgICAgICAgLmRyaXZlcl9kYXRhID0gTlZNRV9RVUlSS19ESVNBQkxFX1dSSVRF
X1pFUk9FUywgfSwNCiAgICAgICAgeyBQQ0lfREVWSUNFKDB4MTViNywgMHgyMDAxKSwgICAvKiAg
U2FuZGlzayBTa3loYXdrICovDQogICAgICAgICAgICAgICAgLmRyaXZlcl9kYXRhID0gTlZNRV9R
VUlSS19ESVNBQkxFX1dSSVRFX1pFUk9FUywgfSwNCiAgICAgICAgeyBQQ0lfREVWSUNFKDB4MWQ5
NywgMHgyMjYzKSwgICAvKiBTUENDICovDQotLQ0KMi4yNS4xDQoNCioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqDQpDT05GSURFTlRJQUxJVFkgQU5EIFBST1BSSUVUQVJZIE5PVElDRTogQUxMIFJJR0hU
UyBSRVNFUlZFRC4NClRoZSBpbmZvcm1hdGlvbiBpbiB0aGlzIG1lc3NhZ2UgKGFuZCBhbnkgYXR0
YWNobWVudHMpIG1heSBjb250YWluIGNvbmZpZGVudGlhbCBvciBwcm9wcmlldGFyeSBpbmZvcm1h
dGlvbiBvZiB0aGUgc2VuZGVyLCBoZXIvaGlzIHJlcHJlc2VudGluZyBjb21wYW55LCBhbmQgaXRz
IGFmZmlsaWF0ZWQgY29tcGFuaWVzLCBhbmQgaXMgcHJpdmF0ZSwgcHJpdmlsZWdlZCBhbmQgY29u
ZmlkZW50aWFsLiBJdCBpcyBpbnRlbmRlZCBvbmx5IGZvciB0aGUgdXNlIG9mIHRoZSBkZXNpZ25h
dGVkIHJlY2lwaWVudChzKSBuYW1lZCBhYm92ZS4gSWYgdGhlIHJlYWRlciBvZiB0aGlzIG1lc3Nh
Z2UgaXMgbm90IHRoZSBpbnRlbmRlZCBhbmQvb3IgZGVzaWduYXRlZCByZWNpcGllbnQsIHlvdSBh
cmUgaGVyZWJ5IG5vdGlmaWVkIHRoYXQgeW91IGhhdmUgcmVjZWl2ZWQgdGhpcyBtZXNzYWdlIGlu
IGVycm9yIGFuZCB0aGF0IGFueSByZXZpZXcsIGRpc3NlbWluYXRpb24sIGRpc3RyaWJ1dGlvbiwg
c2F2aW5nLCBmb3J3YXJkaW5nIG9yIGNvcHlpbmcgb2YgdGhpcyBtZXNzYWdlIChpbmNsdWRpbmcg
aXRzIGF0dGFjaG1lbnRzKSBpcyBzdHJpY3RseSBwcm9oaWJpdGVkLiBJZiB5b3UgaGF2ZSByZWNl
aXZlZCB0aGlzIGVtYWlsIGNvbW11bmljYXRpb24gaW4gZXJyb3IsIHBsZWFzZSBub3RpZnkgdGhl
IHNlbmRlciBpbW1lZGlhdGVseSBhbmQgZGVsZXRlIHRoaXMgY29tbXVuaWNhdGlvbiBlbnRpcmVs
eSBhbmQgZGVzdHJveSBhbnkgYW5kIGFsbCBjb3BpZXMgb2YgdGhpcyBtZXNzYWdlIGluIHlvdXIg
cG9zc2Vzc2lvbiAod2hldGhlciBoYXJkIGNvcGllcyBvciBlbGVjdHJvbmljYWxseSBzdG9yZWQg
Y29waWVzIGZyb20geW91ciBjb21wdXRlciBvciBhbnkgZGV2aWNlKSB0byBhdm9pZCBhbnkgbGVn
YWwgcHJvYmxlbXMuIFRoYW5rIHlvdSBmb3IgeW91ciBjb29wZXJhdGlvbi4NCioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqDQrmqZ/lr4bmgKflj4rlsIjmnInmgKforaboqp7vvJrniYjmrIrmiYDmnInj
gIINCuatpOmbu+WtkOmDteS7tuWPiuWFtuaJgOaciemZhOS7tijlpoLmnInkuYsp5omA5ZCr5LmL
6LOH6KiK5Y+v6IO95ZCr5pyJ5a+E5Lu26ICF5Y+K5YW25omA5Luj6KGo5YWs5Y+45ZKM5YW26Zec
5L+C5LyB5qWt55qE5qmf5a+G6LOH6KiK44CC6Zmk5pys6Zu75a2Q6YO15Lu25YKz6YCB5LmL5oyH
5a6a5Y+KL+aIlueJueWumuWwjeixoe+8jOWFtuS7luS6uumdnue2k+WvhOS7tuiAheioseWPr+S4
jeW+l+aPremcsuOAgeikh+ijveOAgeaVo+S9iOacrOmDteS7tuWPiuWFtuaJgOaciemZhOS7tuOA
guiLpeaCqOmdnuatpOmDteS7tuiiq+aMh+WumuWPii/miJbnibnlrprnmoTmlLbku7bogIXvvIzm
iJboqqTmlLbvvIzmiJblnKjku7vkvZXljp/lm6DmnKrntpPmjojmrIrnmoTmg4XlvaLkuIvmlLbl
iLDmnKzpg7Xku7bvvIzoq4vli7/mj63mm4nmnKzpg7Xku7blhaflrrnkuojku7vkvZXkurrvvIzk
uKbljbPpgJrnn6Xljp/lr4Tku7bogIXvvIzkuqboq4voh6rmgqjnmoTpm7vohablrozlhajliKrp
maTmraTkv6Hku7blkozku7vkvZXlt7LliJfljbDkuYvmlofku7bvvIzku6XlhY3lvpLlop7kuI3l
v4XopoHkuYvms5Xlvovlm7Dmk77jgILorJ3orJ3mgqjnmoTlkIjkvZzjgIINCg==

