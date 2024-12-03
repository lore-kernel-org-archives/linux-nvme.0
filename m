Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E562FE6C5F7
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Dec 2024 04:20:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TYCinlkKF9AcZuQNgs5WTj7fzUJ9R0PO9OaKWziHbwE=; b=azUH2I9J4xaUwtrUKCTu+MZivL
	DZHPaAsSEBlNUr+TkdX9uAESx5We7unqPFMoVtJdHsrjGjUtt01Cm2uKBoXZ2pQhzWZwNcnfCqNYL
	nUDyuY2zF6ModfOfpXVhuHR2aC83R/s/xtuMTRbqYeBdEZ7tr7ixAl1ezE4Jsdd3dOCuOTmwjIpnL
	PkgXwf6loh2L1Wnf53Z/RNWu8+Pw/ike1E2YqVebjWI19HvyC8n+C9bQhIPUWq1fpc2GdK6aue438
	B/glFHXIN1URxqdCvYfcuAyv4zsUicquuZEaRG1inQIRE26bW7qwPLEk7AoXlgI/wqH1SOUAhydDK
	uNjc4HyQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tIKOn-00000008CYE-1Ij8;
	Tue, 03 Dec 2024 04:20:33 +0000
Received: from mail-bn8nam11on2061d.outbound.protection.outlook.com ([2a01:111:f403:2414::61d] helo=NAM11-BN8-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tIKOl-00000008CWl-2Qaf
	for linux-nvme@lists.infradead.org;
	Tue, 03 Dec 2024 04:20:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d+5i8MiZZfZOUkGqO7EnXaGRiwZDZltmxGSCTKQTwft5KDn9GiWqHQC75Lm2cB4BCPx6iN4T4yP4Z+MMnVdpUahPHfsrG0fQbPffFlLFFVfkLWOj5lqKIWTsBjSkFLLjea9u0oELeEVWiUH5Dqafza2pfJzTURGiWOmMFXK0thPZJ2iFTlfVjDFyzpGpvmegfq45UPxdvy4VUy2pw5tEF4dGcCa/QfcBO1GBKVEFQZjkCwZylq9UM48XGZZETVnpG9aQnCcmd71Fu//JKSlSZvaOrKDpDXpMAQ4RZr1mEuN50hq+xKa4TQ7opSGkP8cRh8Fi6kzQ5bX66dPJjFgygg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TYCinlkKF9AcZuQNgs5WTj7fzUJ9R0PO9OaKWziHbwE=;
 b=IaelesFm+RPt1Din6pa+zfh8dOAU15CqEA/+qCHEcHHt8vTbiw5qqiEqF6h/oE0pfmyV6UQM93F3Y3VVJZgWICGXJUxkHcgaIIkeInEf5oKfl5+mUVnZ0RdEgwYLBVE48LpXtuT1a+OhSeAUy3l78ZVVTDz1NrGz3mXZBRItGrk0aMoNpWSCRTa5SbIkeoVrTITiIatLU22FIQIZWQ7FV2gkqKFp3pEDPgRi0eUFQaJ6aY5J5FOYXZqyymgZ5LNMDEyxOnJ/eDmWmDtMihpZ5gKOXgGXc3iVkQsh2+mIQhlTRSsGmSP6I5AiopKS/Xz4T7Qic6qVeAEkg8kmbmcHjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TYCinlkKF9AcZuQNgs5WTj7fzUJ9R0PO9OaKWziHbwE=;
 b=UgZxjs6d9xuA22t40GLCjTfmI+Of2HKhudXW8TTfk9SrXK2aHoclUWe//nQFsvuqio32xsePEE2qJncx4Z+c20SvO8mNCNcxTCrYYmbAvgiZBM7SZDyt8RX1OTPXetoTxHyde6FKJUuO3x94Smf+rHGBBaQLznyZJyJPWkNrIDa7FJnoATHTVEKp6xzzpy2A6jytWR3M9NEiWaRQVxprGlJCVh2pLgQVtpzzNQ0GO9vtBxfkOyky0Dvd+XqVBnrTwnfCgZi5eFgaDCqF1s+AZGRWrHORPx8tdwOCh+lAqqm88EUF2o/uS2XL2Clxng9zh6bmr6eI+wYtIuyPlolmtA==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by DM6PR12MB4451.namprd12.prod.outlook.com (2603:10b6:5:2ab::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.19; Tue, 3 Dec
 2024 04:20:24 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%5]) with mapi id 15.20.8207.017; Tue, 3 Dec 2024
 04:20:23 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>, Nilay Shroff
	<nilay@linux.ibm.com>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, hch
	<hch@lst.de>, "kbusch@kernel.org" <kbusch@kernel.org>, "sagi@grimberg.me"
	<sagi@grimberg.me>, "axboe@kernel.dk" <axboe@kernel.dk>,
	"gjoyce@linux.ibm.com" <gjoyce@linux.ibm.com>
Subject: Re: [PATCH blktests 0/2] add nvme test for creating sleep while
 atomic kernel BUG
Thread-Topic: [PATCH blktests 0/2] add nvme test for creating sleep while
 atomic kernel BUG
Thread-Index: AQHbQji3EVk3HAUJ80KUvF6hxUTdIbLPiuoAgARl+gA=
Date: Tue, 3 Dec 2024 04:20:22 +0000
Message-ID: <3a9e7942-68af-477a-a9b4-65fc6df86979@nvidia.com>
References: <20241129080231.2994578-1-nilay@linux.ibm.com>
 <kuvftnq5cjwtzh557umohu7afvndg3tl4lx6qfjjuwd675phk3@y5iaypkzdsz6>
In-Reply-To: <kuvftnq5cjwtzh557umohu7afvndg3tl4lx6qfjjuwd675phk3@y5iaypkzdsz6>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|DM6PR12MB4451:EE_
x-ms-office365-filtering-correlation-id: 404dd103-e581-4cd5-74a7-08dd1351ce3a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|10070799003|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?VEVuNE96d1J0TjhjdDI3WUNYR2dHenl6MzBhRkhSeGFLR2NYTVRsYmJVZjlL?=
 =?utf-8?B?THpRRXJzLzRYZjNhZnhiQXEvbmtmMmJZOEhYRS9QZ1FWbVovZ1ZJKzU4c0hs?=
 =?utf-8?B?QVdKeWhtR0xwdURadmlNMUZVSTVCMzhpSFJWMDcvY010TnpYdEVBM3ZZUVZU?=
 =?utf-8?B?dUJOK3VqUi9BbXBJUzh4ZXBaU2pubVdIdGFWRitaR2F5ZGFtK0NFb0d1c2Vy?=
 =?utf-8?B?ZFRMdGg2UVhWZzc2QjIxQTcwUFZPV2FseXJXQSs3a0lHWUUvcTBYRllleUNt?=
 =?utf-8?B?dGkrVEE4VDB0MTlTWUN3Mkg1SmU2em5jQ3lYTkFwdlpIV1VmSjc1WFgxUkd1?=
 =?utf-8?B?Y2JKN0hVQlIwb292STRqamFkTm5QQUZQdW13SkYvQ1RlTUw4TFdZUUFmUkoy?=
 =?utf-8?B?RkpyYStRZWM3cVBKdmptc3dDUzJXc0lvR1dNc0xCTGN4bGwvZ2ovbWlQQ0RP?=
 =?utf-8?B?dVkycCt3TWlzUXlhdndsL3FGelJuYUZzaHdvcDBlQXNzYUxaVzdaZkEzZi9u?=
 =?utf-8?B?VWhkUDBPcUtNNmtKVTdPb2xpQThlcGV1VVh2UFNUb2JFQWpjbnVtSmxTbVh2?=
 =?utf-8?B?clJvZWs4NFpucjNSbXRWMG1PZTk0MDAvNDBVMlZRQjhYOTZMSTlxYnB4bGxi?=
 =?utf-8?B?MFNZZU5kNVl5S2hLdWllSTU4UnhKYXdxMUxlYmRZWmZKVzFFYWxuMDU0cUt4?=
 =?utf-8?B?dW8wNWJmVk1YVjRRY2hab0tJNEtDQno4VmJIVWdhUS9xVkxLYjJ6cGR2djJr?=
 =?utf-8?B?MUxMZVBXU3llaWpXWkpWZmV2TVk3TzY2TkhrY05tamRPNW9kdG5hK2pQd05q?=
 =?utf-8?B?dC9NTDd0WkF5aHQrZVdqMzNFSFE2Ry9ubFhnN1JKbzJGY3kvcTlLWk5wb1FB?=
 =?utf-8?B?Vnp5cWNDQTczdk5oVUV6RlphY0tUajFqajNXOTVnN2ppTE80MnhsOVlSZzJh?=
 =?utf-8?B?MHU0cnZwWmkzbmNPVjMwOHpYTnZvT1dKT2JteGlIYXpRV3hwVElWSldUY1V1?=
 =?utf-8?B?TGo3YnBkdDJvOGtMU0N0ZkZOSzBjK0NBajJkTm5CQmNRNXpTMUpwd0JlTkdS?=
 =?utf-8?B?K0JXYlVsaDR2dUhlZzVUTWkwUHIyYUVieXJ2TkF5ZVVMd0VLK3JBT3pQS0hM?=
 =?utf-8?B?Zmk0OFJoS1hhanpURlc4b2Rjd0Q1SnlsYVUweFlPVHdEZ2RnSWZrOG9aWUdw?=
 =?utf-8?B?TVZPWmRTN3FOd0g1VkFTVmMxTVZ4aTA2REd2ZitCeFJuMVFLTzFqc3RabGNG?=
 =?utf-8?B?N3dyMHBGN2xnbkRjSFdTd0VwL0NvWkVHb2JKUU9jbm1leGpKY0wrcEZReFlV?=
 =?utf-8?B?UnJwYS8yYlZ0a0dyV1VYL2ZUb3lRYmd2a2d3UXJWeDhLQ1ViVS82bWVVVDd6?=
 =?utf-8?B?NGJFZGt2cUhkTGFQY3ZDanZhR0M2Y1FTYjRHNEE5N0JmVmdzTFo3SDZIeXBH?=
 =?utf-8?B?OUlEeGFxbCtBV1VmRU41TVd5K2I5WUlBbGVUbzBKcU42dS90RGlFdTJmT3JR?=
 =?utf-8?B?R1ZLUGRaanUzUWlqaXVsMkNab0pLMytxY2UvdVFEcnFxbGxIV3d5anV0RWY3?=
 =?utf-8?B?TDlWZjRxNm1TRmtwTjNMdGo0QkFucmxGdStqWFhBK0NJZGFLY3lmS0NJOUow?=
 =?utf-8?B?S0orOWxFR2RXeUdQWXp3a0JJbFAvRk1JZVRyU2kvV3JLaTkxZWZGSDJPZ3FD?=
 =?utf-8?B?VDF4QnphNUZsSmVXREw0K2NwdExMSUQ1eVc5Z3BsWW5oeEhlSXg3Zko1MTdr?=
 =?utf-8?B?OW5JejlTaXE4L1hxRnJFaHVKemZUeERZcjRub1JuYTh0VWJSY0lpMGMxZEc2?=
 =?utf-8?B?emo1cnZNdnBoMGFHcE50RmtIbVBVVERiRjVVUC9yQlQ5dms4L1dodlJyRXZo?=
 =?utf-8?B?R29NMUh4bGMxSjc3RmtIenovWnJ2U2NrcE5wNGppVnQ1aUE9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UWp0U2tMK2F3VTRqbXRTbVhqRWlCQnVoR0diSlp4UVZ5SDlERSsrdyt4ZlZG?=
 =?utf-8?B?THNYc0dpWTQ2TUdwUEZSRktqalFtTkMzS2Q3YkwzMzRCVkNwTXk5V1VYTGoy?=
 =?utf-8?B?dzVqc3pqazRTSjQ4VGJzTldRWFJXWWx1L0tJZFVYeDVPRXRPaXF0dW4zQllH?=
 =?utf-8?B?dGRhU1pqUGJnN1B5RjVIZkIyeFZHQVNCUTk2dEJaVDNvMmNsczZSYmdDTnUr?=
 =?utf-8?B?bllhbWovVHpHZ3o5ZzdzMWpWRkJ1VW84OG1rWTVnL1UwUGxEak81NDB3bmh1?=
 =?utf-8?B?ZzNnejJIKyt0VVE5VmdiVkN6RUdSaHJwN1Awd1Y5bVVMZnovWndBVCs3UkI1?=
 =?utf-8?B?VTVTQUorYVVaT2NOTjJtaXRoSjRTdkVLcUdCdjdVR3pJSHZGVkUwWGx0Yi9m?=
 =?utf-8?B?Y3RYMmxRMHVHS1N5cUNPRUpIRFhHNTVHSGFxZ2QwZEFIUWtHVGo5cHlWOGlN?=
 =?utf-8?B?UXp3Z3RNc3Y1RDltUDN0RE1LU0I5OTNjMDljbkJGb3RnSmJ2ZTBSZWZDVHpW?=
 =?utf-8?B?bjFFanJxQ2k4MlVBYlYwMmlQMXRyYXlRbitjdXhSM3Rmb2xMWFUwMVMrdHFO?=
 =?utf-8?B?Mlo4VTQ5dnJwKzdJa1FmSmloZnZKRnFCZk5hZTgzQWFSblJsU0hDZmlQVks2?=
 =?utf-8?B?ajQ1NjdGaTF5OGxINzRUVEt2UXUySXdzQU5yQlBaRkwvNm1BVWE5bTN4RDlz?=
 =?utf-8?B?YzJITmliZERURVVXWkU4VXlydkV5VmJsRUQ4UVFwblRSWTE5QkFWQVIrUFFk?=
 =?utf-8?B?OXd0SkRjU0swSitoWThpOXkxS0lqaTEzdHNpS0xVdXhQQ0JTdVlIRGRlNW9x?=
 =?utf-8?B?WUp5a0swOGpkNHJteWFwelhvYWwxZWN2bEt2NEZrNHllVXl5ZEhtSTN5SWlO?=
 =?utf-8?B?QnFMREtGNXVCL1k1VHA2YlBPSkxVcXNQc2xQa2JVSCt4NDNVTjdsdUxqb09W?=
 =?utf-8?B?K0lxb1RtWVBURHZldERGcCtpZE50U1NFUXM0VFA3V1BaT3BqK3lHeVZTWHY0?=
 =?utf-8?B?V2h6U3MrbDdLK3k2ajJrSEdqUndndWdoTGNaM2d0anRaNVQ5a3pPRjhIdW53?=
 =?utf-8?B?QndNZTNIVHRSNm00N0J2MXUzZElnKy9waFRuMDRKQzFPaXlFTUhZNXhwM092?=
 =?utf-8?B?NzYyWnl5a2U4VUdoZWEweU95Yk5wU2UyMSsvTllucmVsSFUxWnduMWNtUmlD?=
 =?utf-8?B?dXU0ZzlMYW9nbkFsRzI2QnZ3QXJneXNpQzgxV250SDNnRzJIZVNFcEZ4Qis3?=
 =?utf-8?B?MG5uRTN4RHZpaWt3K3lHU25neDNNK21tT3k2cStqUk13TWY1TGhjU2c4cEZm?=
 =?utf-8?B?NlRGeWpjQlJTM0JMNDlka1gyRWJhV1JqNTl1N0RWQmM2c1JYbGRONmh0OVB6?=
 =?utf-8?B?V1BRb20xYS9QZnVmYjgrWFRzTEQzc1JrVjA0M1hmcTlITXFaM2M3YzN2R0Mx?=
 =?utf-8?B?K2FibVc2Z3lXRzAvaXZ2dFdOQkR4YWV5WmFvMGpvamdyNzMvU3NPNnJoZ3Fu?=
 =?utf-8?B?eGwraDNzVVZaVTFjUkh3Y1M5dWlMTjN4WTNnSngxZnBOZkdVaDBzanNlT2Jz?=
 =?utf-8?B?bGpzOEV6SmpPOXVVOExwY3kvYm1TQk8wTnh5di8rWFdOdlR5UEYzaUgrZnla?=
 =?utf-8?B?T045b0lPZEJjZ1gvZFNxb3dmd0swUDJ5STNPdmMwWE02bC9TdjU5aE1hQlRU?=
 =?utf-8?B?Tm1sbkhWOE4zZHJRL3V6QkxBeS9KendIY1BHM0NjNE5LT2ZXQng3am9oTXJT?=
 =?utf-8?B?SUNPd3ZaNHpxbnpHaEJjazlzdkJLbjF0eUlPdGo3SE5tdVZXb0svbWZtaWxs?=
 =?utf-8?B?SDFHVTB2T1AvM3VybGlyM090ME9GQ2pHY3pRWkdtTktRMXpkdkFzbjdSQjl5?=
 =?utf-8?B?bVE1WDBRaUpKUi9nbEZNT05YMlcyV3V1Mk9RR0hXeGlqdENTOU1OL0tmY3NU?=
 =?utf-8?B?TUFsbXN4dENIL2tkUkJrY3pLU3RjdDR4dm5yNTdSVlFqb3BIUVA5V0paMU0z?=
 =?utf-8?B?SnpXUXZVVStJWWh3dHBsL2VuZ2pHd1FxVlNxWjA5WEloT2FEMjd5WHMzb05R?=
 =?utf-8?B?bVgzeS9zNTQ4TDJxaURtWlZXbitJdEFFNWluLzRmMGhnTzZOTUJXenhWQnZr?=
 =?utf-8?B?c1UvN29yVHRhd3JiTlgrc25oT2oyYnhFMEtBNFM4Vm5wTUhzd0lyaFdSd3g1?=
 =?utf-8?Q?+rmU10FYM69yIWC6LIaxsn+uZ53mdjWVZzO0RSGYsS+I?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A2909753CFBF074B922F23DF9B1A52D7@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 404dd103-e581-4cd5-74a7-08dd1351ce3a
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Dec 2024 04:20:22.9593
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hPLlX9rfAPikUIhA1l9jOstqfP0MjL5thFhjD86446JUmjLhj1Jp2CqHcvrC8PQEJKUApf9MuPZsoC20vV9arA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4451
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241202_202031_619713_9A4E520F 
X-CRM114-Status: GOOD (  14.30  )
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

T24gMTEvMzAvMjQgMDE6MTAsIFNoaW5pY2hpcm8gS2F3YXNha2kgd3JvdGU6DQo+IE9uIE5vdiAy
OSwgMjAyNCAvIDEzOjMxLCBOaWxheSBTaHJvZmYgd3JvdGU6DQo+PiBIaSwNCj4+DQo+PiBUaGVy
ZSdyZSB0d28gcGF0Y2hlcyBpbiB0aGlzIHNlcmllcy4gVGhlIGZpcnN0IHBhdGNoIGlzIGEgcHJl
cGFyYXRpb24gcGF0Y2gNCj4+IGZvciByZXVzaW5nIGEgY29tbW9uIGZ1bmN0aW9uIG52bWZfd2Fp
dF9mb3JfbnMgZnJvbSBtdWx0aXBsZSBudm1lIHRlc3Qgc2NyaXB0cy4NCj4+IFRoZSBzZWNvbmQg
cGF0Y2ggYWRkcyBhIG5ldyBudm1lIHJlZ3Jlc3Npb25bMV0gdGVzdCBmb3IgY29tbWl0IDUwNTM2
Mzk1N2ZhZA0KPj4gKCJudm1ldDogZml4IG52bWUgc3RhdHVzIGNvZGUgd2hlbiBuYW1lc3BhY2Ug
aXMgZGlzYWJsZWQiKS4NCj4gSGkgTmlsYXksIHRoYW5rIHlvdXIgdmVyeSBtdWNoIGZvciB0aGUg
Zml4IGFjdGlvbnMuIE11Y2ggYXBwcmVjaWF0ZWQuDQo+DQo+IEkgdHJpZWQgdGhlc2UgYmxrdGVz
dHMgcGF0Y2hlcyB3aXRoIHRoZSBrZXJuZWwganVzdCBiZWZvcmUgdGhlIGNvbW1pdA0KPiA1MDUz
NjM5NTdmYWQsIGF0IHRoZSBnaXQgaGFzaCA2ODI1YmRkZTQ0MzQuIEkgZXhwZWN0ZWQgdGhlIG5l
dyB0ZXN0IGNhc2UgZmFpbHMsDQo+IGJ1dCBpdCBwYXNzZXMuIEkgaW5jcmVhc2VkIHRoZSBudW1i
ZXIgb2YgaXRlcmF0aW9ucyBmcm9tIDEwIHRvIDEwMCwgYnV0IGl0IHN0aWxsDQo+IHBhc3Nlcy4g
RG8geW91IG9ic2VydmUgdGhlIHRlc3QgY2FzZSBmYWlsdXJlIG9uIHlvdXIgdGVzdCBzeXN0ZW1z
Pw0KDQp0ZXN0Y2FzZSBzZWVtcyByZWFsbHkgdXNlZnVsIHRvIG1lLCBidXQgd2UgbmVlZCB0byB0
dW5lIGl0IGluIGEgc3VjaCB3YXkgDQppdCB3aWxsDQpoYXZlIGNvbnNpc3RlbnQgcmVzdWx0IHll
dCBmaW5kaW5nIHRoZSBidWcgaW4gYWJzZW5jZSBvZiB0aGUgZml4Lg0KDQotY2sNCg0KDQo=

