Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A26CC47DD9
	for <linux-nvme@archiver.kernel.org>; Wed, 28 Feb 2024 09:03:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZdlyfiTj7uOjEqCuYbPSVSTzdP6OXVS1hl3H46xro4s=; b=liRq8mHfSf7mxteJ5o8R/r6bnm
	JDeY64zJ64AQ8httpZr5cfqN+zl4aO5SkqKDGh6U8zqbKhgNaH5klkpLApMCFkSjq3x8HGpl6mtdj
	NqnRJ31izZzF56dfiNKM7xrYOcrX7tM9Ie7KJ7riIjYmDJy7z4WOppmuYzcSxEytoiU7ifa4nY/pG
	+Ep5iQm0kGEb6xn9rnTlP+xCrp/s0jC+jiPAS9uSIzhKHH/BCWxeTfcI+DaiVnSCcM2eAgVBCIvUt
	CWP5wHMN7GAzkrv6QrsWij/mKm1sfY3f/Vu/rT5Vnpm5WFnnHtxI7ZOcbVmTRF3c8fWq22FBa/c2k
	JyRr6H1g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rfFqp-00000008afu-2bbr;
	Wed, 28 Feb 2024 09:03:43 +0000
Received: from mail-sn1nam02on2061b.outbound.protection.outlook.com ([2a01:111:f400:7ea9::61b] helo=NAM02-SN1-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rfFqm-00000008acb-1d4U
	for linux-nvme@lists.infradead.org;
	Wed, 28 Feb 2024 09:03:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=APEgQVEki1dukw3ejQNoDH1Ty5VjguD2+5EXuX2LqxiqfWEAnHbdtpA3VQatwV2BES6cZPKRxlkDdmH3mcz2nLdnDVBRqWlpoeUYJbt8dnuNDpKIJchtFVGETPpHV+cf758IGkMpKhgKeDB8GCIZIUNra08+XkLKD7IlpxSwm4RnbhK2Akiu4tLD/XZCmEFNtktuD0f3PzQeoO2UOXlAjgEhfaos614cHUP/4DQoL2Mhg/qDFOwS9UDlS9V9Xnds0bZKrkTba/0hpZSWdJQaX6+yn05yP6ZoDAYeex2oQ/2F/uV+JCwBrEXz0km57B18H1TcK65NZD4xhpKW/GroaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZdlyfiTj7uOjEqCuYbPSVSTzdP6OXVS1hl3H46xro4s=;
 b=cUnaairsu8oHiQ51EjLwavLanFKqdwiaruuxUyx6/LUjCDMpbk14YwuaJl92AjqBh/2hbhqEDO9N8VsCEIgyQm8fyAQY/eil2o2416oq1tFzeroqAvXhA/fsqA5Z7JfW2hJ+ubsArq4PRB1iq4EG/zJQjYYwvm7IPNvgMIid8UXQ5aXJ+Sb5e+qA9iX2lqzZ3X31EM4gag2PjtrVRwg+OUFOQZuzBRyD7H4CCLnssQR2iS0BHxtyiJqRo3jcbd5cW8FLeb0Ihvo6emZJ8F/88UUMstJSTvhn6N3Ce8EnFd8f3LX+pT2IDWtVlgtDhiNo3dmu1woxmu1xVyB9vEaHgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZdlyfiTj7uOjEqCuYbPSVSTzdP6OXVS1hl3H46xro4s=;
 b=T362FpQ1z2g+dH6jOFbawtngDlhNYAEYrRNPW+vi2Xft0UG32bP3X/1IZbAz+T1qnQHW6EoEysZX9IjVt4ZT08lDy6gg0wvfQ/L+03xSBRd+C8Ok/h0YJqL93aO1K8JjTP2VLomzNSmmVgmmFtuDmd1Ne/mUfPAarmKsemG7IWdjMEWv5BkeKbw8DFE2x70Tc6N/hvWbNKwGQP/PLx+PLL8/QIYF8/jMrI+2ceSKkEBlmCNkfeAdOGZ7oiqaC+60NnU8Gd7BkirYNSd5Vz7j5LoSnP8p/t1Rv8qIv36vWZwdl7eoBjEyNLWWFwXKwN1RAeDLeioBWYOPEYX7ivOToA==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by MW6PR12MB8758.namprd12.prod.outlook.com (2603:10b6:303:23d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.39; Wed, 28 Feb
 2024 09:03:31 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::ffce:bbde:c1ca:39ed]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::ffce:bbde:c1ca:39ed%4]) with mapi id 15.20.7316.034; Wed, 28 Feb 2024
 09:03:30 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Guixin Liu <kanie@linux.alibaba.com>, "hch@lst.de" <hch@lst.de>,
	"sagi@grimberg.me" <sagi@grimberg.me>, Chaitanya Kulkarni
	<chaitanyak@nvidia.com>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH v3 2/2] nvmet: add tracing of zns commands
Thread-Topic: [PATCH v3 2/2] nvmet: add tracing of zns commands
Thread-Index: AQHaaiF5ndCSQXvKBkCGN34W4yqeOLEfdbuA
Date: Wed, 28 Feb 2024 09:03:30 +0000
Message-ID: <fdc99871-82ad-4ac1-90f1-754d9b65a000@nvidia.com>
References: <20240228083755.125259-1-kanie@linux.alibaba.com>
 <20240228083755.125259-3-kanie@linux.alibaba.com>
In-Reply-To: <20240228083755.125259-3-kanie@linux.alibaba.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|MW6PR12MB8758:EE_
x-ms-office365-filtering-correlation-id: 1c0a0a74-7ef1-45f6-e8a5-08dc383c2253
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WZf9PB9lX3XyRM2evwJWEOJPNI2XeYo0qkVsuvHKd7eDlgwWCYWVDljRa9EaAEoPKOh+tUncCgiRz/jg1X8jjyM/pNtSll8p2h/805u95S6ohSvs9OZiryTLIXAjqaNYQU6eYCKiUC5+18A4E/JbkxvICDLY5bXRlmCyYCMUZD8VxzrFeXnYeHS69jdzq8FVARlWnr4ZnYIhfOEGR1yk5d3Q2rlu9wJI93TKR7pTzcUvU6M/OxomlAvui2RVoXmK1cPm8nIiBYKq1JMNs1/j6KGMTfF6/wZsEa5FmQXuxTlwfi+4RV7OmD9Xt86ykvyTI5z0NBJEu06KfHpWLfgqiBbOlBk6DkLWX4kkAAvNRZYqNObKLpmx7ma3Ha5rQQRtSIu0VpGupNkpWK6Kq8KBsE5G8vEEA2j5tEN3Zhrii4Z5XUT2GyBbj/2DppDm5sBu/ABcr8VmRL4w+BK2iYnXAqvWCY4YLqokycf3mkz4AKW4ZrwMWLpkHHO+hDTStSpbsKlc++egwvJt2hfMmuL4/eY+N05lZOgd5Y7dgVjyG3QjUT/ulfAcoLzBpe53U1lJ6wMIPnmLM0DunPScNRUFHYdRlilZg8IGTDyusDweSrE1mIJLAG1IbbRxyB26yyMqBy5hnVdBcn4xnZrb2rKsWhjBMMOl+MFgO4hvBUEVj+INCG+/T3Djad4hkfPoksWCK6+vjdUtTjosB0X/vCDCQg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eldBTDlFMG5QVURXK2dFdE1CcmxjTW9KUVh2T2xUMmp6M0hLSTNrckhzVkxH?=
 =?utf-8?B?aDUwV2ZzQ3RiWWdYQ0M5di9aWXpuZWR0QWEzenhtOFV3YitSUU1xdXppbUhY?=
 =?utf-8?B?MzYxRGo4VVBFVDlwUHhWczFSS2VSZzRlNFE2Ty92NVJRR011RGhSVVFqR2k3?=
 =?utf-8?B?VFV3bkFJZzY3UWFjc3c4NHplUnBNVXBubldmV291OXcxVERQbXZMNWZ4ekZ2?=
 =?utf-8?B?RU5vRGYweHRyL1REaGpNS3Y4eVhpcldnWW1hdlkweGFSL0lVZUFtT25hUFhB?=
 =?utf-8?B?RElZdVZOYzRSVnIzY1NMY3gyZzQzVkRrWGR5djIyMTNSbmJHVnFhNEpKWklY?=
 =?utf-8?B?WmVGZVRBSTdQbXFhSkYvMlFzQzhPdGhBV0o2b1RjRGJLYk80cHNNRTBvVk1j?=
 =?utf-8?B?bWRGWUVtbVduNnFuNnU4SGhuS0UxNXQycUNxRlpWbGJqUE9VemQwSVhpNVc4?=
 =?utf-8?B?K2ZqZ3p3UlNCS3k1VDc2RDFlZkJFZlp5QzBMNnNNUTZsZEQyMVdFTXVZNUx0?=
 =?utf-8?B?c21uNGRXejc4REVHc3lQQ2FHZkc2Y00rUzVUSHNmM2JjTk9zKzVhcEFwaFZl?=
 =?utf-8?B?c1FCOGoxWHB0cGsvRnB3NmMrWmhLbDZ0aWlNZVVNVUpOS3YxZllKOUhMcmRP?=
 =?utf-8?B?MTR0T3MxNmNHbWFGdnIzQ0htNmJFZjRVL1ViWXRZaU1vU0FVTlpQTjJGSjJp?=
 =?utf-8?B?QTRhUS83MVBvOHJGcWR1N3ArVmw3eGw0YysyMFRtM3dPWU5UQVBDaytzU2FG?=
 =?utf-8?B?Q01DUmxJZWVTQ04xa1FYQ3diUENrbUozL2xJMk55K3FQSldrbmdDZjM2TDFG?=
 =?utf-8?B?Yi9qVGN1enNpYVdQdHFhRjFES2hrUVFLV09DVGx5dVBRM0NTWTVncU5CU1Vp?=
 =?utf-8?B?SU5jTWtRbTdsS0dQbXpGSFZDK2VwTXBHNEdwNmJrM2xMaWZOZFpubTIxL0tW?=
 =?utf-8?B?d3RnZ1Y0V0dONFVWTkpEZmtSSjNpTlRKd0lPT0V1bFNCSW0zM0ZoWFdWS1o1?=
 =?utf-8?B?dWFDRFptV3k5TExPZHhDNXNKWXR3RDZZdkIzTHdocVNWem1rZ0NDZm01TXpL?=
 =?utf-8?B?SW9WVGlsdjluN294M0FTNHg1dFVxVDVFVmY5OTdlWlpOTHY1L3JhSnlWdE5L?=
 =?utf-8?B?WkNyb2JjeHNGK0RHa0tJRXV4SFRVKzVvSTR5UkNtYytISDUvdTJremxjQkRr?=
 =?utf-8?B?b2JvSWliUGxIcm9DUXBnRSs3MHFuVXBNdmJrT3VmelBHVWRDSmtjNXhRcSs5?=
 =?utf-8?B?b0FobVJUZWE4b3ZOYVlacDltMHVEQmRtSzFhLy9BR29XNW1RRjhSTldQR1hh?=
 =?utf-8?B?MktYMWNqMHU5bFhaV3VTMXBOTzRXOXJHY0d4MTVSL3laNGx6ejVHY2VtcmJm?=
 =?utf-8?B?c0VaWFdUVlNWQm1leTJJRXhTMlZGSWswbUFxYWNwcUZZQUZkSUVnaDAyWG9M?=
 =?utf-8?B?MjZjRkFxRUZLTFRUNVpVQWEyMnFXVEF3citHWW5uSzlxZFY5eWNLN1ROMFlw?=
 =?utf-8?B?YmVWY2E0dnEwd3FPSUNYNDhvVVdqcXlxejBWWW1RQkZ6SmNOMzZiZGJ6V3pT?=
 =?utf-8?B?cFZTZFRKWnpobG5uYWozdnJwOGhJaDd6L2twa1RKTFlXWTZyaThzY0wyNjVY?=
 =?utf-8?B?RzU0QVB3K0R2ZWZXR1c0V1poNkpFZDh0T2VLd0ZrY1pHRkhhT2RpQnlBN0ZL?=
 =?utf-8?B?QnIzTXdPVkI0cW1wL0o0Smk2V1RiZ1RhWkJqVEdkVEpnSFNjN2plZjgxVW9t?=
 =?utf-8?B?MkxaUU1qN0R5eElxUDJTWjRHTDQ2aUYybVc4K0NUZWdPT1F5a29sbHpYbG1K?=
 =?utf-8?B?c0t6VG9TV0J3SDFiMnVkTnhvYmxlL1FZa3VJMTJUV211cVZSMFZDa2FzQnFs?=
 =?utf-8?B?am4vOUZVckRkN1JlWC95b0I0S0RBWFNCV1FhTXBQKzFJVzhjSEI3YXF3cUxa?=
 =?utf-8?B?NGVZRW5KYXN1MmxWbVhaQUdYVmdUK3hwS1NoNE9rMFdKUDRlV3RpK1BEaG5o?=
 =?utf-8?B?aGZuRkZFMmJvL0ppdlpsK1pqdnB2UDNUQ2pITDZWTFNQTlUyY1FFNXE2QnJw?=
 =?utf-8?B?Z05hSnNRZFJzeFpqNlhyam82S1gzSlI5QmllUUVZRWc5YTN2ZFdGekhsWjJr?=
 =?utf-8?Q?aVnjB7J+WVqqeuhd7ntWPMzUj?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CB26FCB391D7DB4AB6E461D865CE4722@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c0a0a74-7ef1-45f6-e8a5-08dc383c2253
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2024 09:03:30.4526
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gg9bA1gS0fkKPilK5xHHATMgMT60ASUudQpaYKg4mTM26ILoptH7oq1zcSLXLoe3DO0hTdwCRhpYuXhgnOm+0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8758
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240228_010340_452475_2E7BE455 
X-CRM114-Status: UNSURE (   7.45  )
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

T24gMi8yOC8yNCAwMDozNywgR3VpeGluIExpdSB3cm90ZToNCj4gQWRkIG52bWVfY21kX3pvbmVf
YXBwZW5kLCBudm1lX2NtZF96b25lX21nbXRfc2VuZCBhbmQNCj4gbnZtZV9jbWRfem9uZV9tZ210
X3JlY3YgcGFyc2UgdG8gbnZtZSB0YXJnZXQgdHJhY2luZy4NCj4NCj4gU2lnbmVkLW9mZi1ieTog
R3VpeGluIExpdSA8a2FuaWVAbGludXguYWxpYmFiYS5jb20+DQo+IC0tLQ0KPg0KDQpMb29rcyBn
b29kLg0KDQpSZXZpZXdlZC1ieTogQ2hhaXRhbnlhIEt1bGthcm5pIDxrY2hAbnZpZGlhLmNvbT4N
Cg0KLWNrDQoNCg0K

