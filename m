Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C4D8606A329
	for <linux-nvme@archiver.kernel.org>; Thu,  5 Nov 2026 01:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=CS5G+W6B;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=rAu0W/Ml
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=Ps3bkSqtfsrgstmYftM80u+Gq8+pZ99izrkSLjJxp7c=; b=CS5G+W6BU6sxYUzsZonSBCkdzL
	WIDid2WqqqJDJsXdpjYhUbHnxMMNptxHzu+Z4D6W9dFjqNsR53p6nsZZvcAwQq1GNlZxlVGFO5R4f
	EZFB/Z9F1b0lqdBPlNrsXwEq6HH/swY7HRI4N8gSUtj66XZkUhHDWkvbIBoEgUpwmwjz3sJPIxtgR
	h14gPPLdmB3hq0zgD9iVJHMi+u3xg9MTt+TD6aeyi03AJ0Z2Jrl0/syWi1TnilogXB+6JfJ4dpC6D
	SFGtVoZd4rayhmKTWdfQ9bKOaGjbLTk1Br0xjCCBDffXGINwhiwnmx6/d8doxuVmtoTqEMbAKqLIn
	PCh6wjZQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOmDO-00000007TLI-309L;
	Thu, 05 Nov 2026 01:24:30 +0000
Received: from mail-southcentralusazlp170110003.outbound.protection.outlook.com ([2a01:111:f403:c10d::3] helo=SN4PR0501CU005.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOmDL-00000007TKq-25gs
	for linux-nvme@lists.infradead.org;
	Thu, 05 Nov 2026 01:24:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tB/OcMPxrDa0vb74KT+gqQsE3TIxaMKOxOrWjhyQLOMzEUMYcsBzIxlCufpNZuRE7TJhZChlXIBdBxf/O2y31qaeRU/XPlGFzxZDIPaSU/LzrnG9CiNkuUF1ZBnMiE5O17ZFbWpTU+OaVswnEcgGjprIdg3MZeQvcjkcBQlRszcQHDs7603dRyIyydX6x0yBa0hvAaYwv0ZSWao2/D9olatfGvfSYdUD1cPXRdzkN9ItDk1AJ24Ijy4UNd8TzBPP1Vmx78p04BXPtZjtnGyafr5TGvrdqMjMVvgCTijrsb1FUNpvayAT80rsqPIVGTdNh1pujDamfe3UNmmn+hz0tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ps3bkSqtfsrgstmYftM80u+Gq8+pZ99izrkSLjJxp7c=;
 b=Qo/sVzjlKWJKH0SAl6FUK6CbGsLqUg6BZXBWPIAqR1zeNQf4rTav7HreQFh6tJlnG0nOPMNDbwFlv0dSF6R7JpCJR0/0Nrrq5tJq7+Tfflw+kq5Optxinw33KIQz72t/EYTOK4wMAFCiUH4kjeE1zl/kPzPMv8/ZNCMKJF3YJ0EBCxmWCMh1bHhwQbpjouPXYwxxBWIPkFt88z8m6eKJ42zGZEvArsTLhcLF46D1XoV81gLlPyhS5kWxP0VqEGyt49ojgWviYZVN7wedfhpJ8vdVvk/EPbIdLYsfqYIa/YzoRIeRozmVE5zSkaV9HWjwz3PlzDl3dT3Tz2cVnKuXGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ps3bkSqtfsrgstmYftM80u+Gq8+pZ99izrkSLjJxp7c=;
 b=rAu0W/MlCyIg2V6sRwyI4+s29RoY5Qr+ENNh5tk9BpVnkgdUQwKvjkxiTlcsMhK5eK6JmbRxLr4UaDOXEWFPmqo0CrQeDWlw4aqYxZftTufJmGBeu6DvA1efLcAjZVhZ9+KTRMQaY/G2my9ah0sfBa08s/PTHTThuJVHlUsB38hGbTeLHcJc5XD8CDeUdCLDEo9BBsdyh/Pwdngr7Q1vg6rP02WHa87yTAZCTKJW1n7inXMqN7eWDi90X4c8FKCw1pQHAvkJv0B3EtnziVl7bIck1L4y+k9cMFuTcPlYVRkGsh9srpuvRhlQ0nlwnLgSIg3HQ28B2S1oarbfiz5ChQ==
Received: from MN2PR12MB4159.namprd12.prod.outlook.com (2603:10b6:208:1da::17)
 by CH3PR12MB7714.namprd12.prod.outlook.com (2603:10b6:610:14e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Thu, 5 Nov 2026
 01:24:20 +0000
Received: from MN2PR12MB4159.namprd12.prod.outlook.com
 ([fe80::5f4c:13a2:f9f8:8aee]) by MN2PR12MB4159.namprd12.prod.outlook.com
 ([fe80::5f4c:13a2:f9f8:8aee%6]) with mapi id 15.21.0592.007; Thu, 5 Nov 2026
 01:24:19 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: =?utf-8?B?5ZCV5rOz6ZKK?= <lvyongzhao@bytedance.com>, Chaitanya Kulkarni
	<chaitanyak@nvidia.com>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: Question about your NVMe VFIO live migration RFC
Thread-Topic: Question about your NVMe VFIO live migration RFC
Thread-Index: AQHdbFsF0AEvbPIen0qRbFgCFw02ELcesAyA
Date: Thu, 5 Nov 2026 01:24:19 +0000
Message-ID: <51083975-0a4d-4e87-b948-a7fb11c127db@nvidia.com>
References: <bb010166e7ebb1ce9e5bb0a7ef25ce65a60a87ed.4c9e6c9c.eb62.429f.930f.0ed46a1c4d87@bytedance.com>
In-Reply-To: <bb010166e7ebb1ce9e5bb0a7ef25ce65a60a87ed.4c9e6c9c.eb62.429f.930f.0ed46a1c4d87@bytedance.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR12MB4159:EE_|CH3PR12MB7714:EE_
x-ms-office365-filtering-correlation-id: 5068db72-b003-4ba1-3496-08df3adb8426
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|10070799003|1800799024|376014|23010399003|366016|38070700021|261022105027099003|5023799004|11063799006|56012099006|261021121427099003|261028144727099003|261102123227099003|261026140227099003|10067099003|18002099003|22082099003;
x-microsoft-antispam-message-info: Ixa9rVRIZkGACJQOLS7tVaHGaelvjtd4jXotbe9iUZR300vJktwYdW3fW2U7/Fw5YWrj1Pr1W43CAnJZBcu3OjoKwjXyaV0vmNb0CF4P2g4yf2My/8T8eIrkXS9z9YcbfPLY/+EgUW9GJo/7zjGZv7rWctB86KaO4GhlTHuSW76/wz+O7uLhI3THP7bTdXuv7eqxJm7PEFsvpAOaajsKAYCnKU+B2OuEdlrSAJ/xHAzugJBZGpOsI12qVDzuRT/eoo1F0/CBsFdZ3FtpzllL/3j47756oNQ3LEs7qu+yDe/hYkDyjSYMwHW5C0MV9TCh7JC400eGztd2EKtQik+jxRXxy+Xrh3TjXeE6ivFtdPPKAIR1IpUJ9g5PHckCxNVhrshLT19Kv6lL5RyjeTsMZowbpfZWaSOrWnrwSzah4ICYIBUq6TUBoOnXdTNLkdNgljfubUKizI7Ew9zuzv7QG0SErjOKyfGnlpd+d2zLgMEvTSeJikOT30+vxLDlMaj+WKue9B3bCtbBHTVOCyQCuXibvVkEkK8AATRhZZAY1h4eXfP4D6yAdeY/YSJckjSMQERvnPoBGRig1SuUN/ujrYqVujKiS3vlhyPf9/D1JUI/ZASqZ4okm5cSUdkgyocF/YhXNbHsN62nqZkkfXfY4EC65mW8zj5ijb59+Tq6g/MPwjpmrfFYvJa4SQGvXhciKRlnNFQhi43pAcPA5VL8fPkWT9E9YhSdevjQqbqkfXU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4159.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(376014)(23010399003)(366016)(38070700021)(261022105027099003)(5023799004)(11063799006)(56012099006)(261021121427099003)(261028144727099003)(261102123227099003)(261026140227099003)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OVV2SWJuaWp1MU5iUW5YaHlxTytBK21LZFhTUGk1Ylp1M1k1Nng4cFBGN0pK?=
 =?utf-8?B?WnVNMW92dzByOCtqUVg0cml4RlpWUmdBc1YzQ3ZOZENlZ21rblFCeVlPSE5R?=
 =?utf-8?B?SXU4bUhTUHBFR3l3V2xYZG1UQkx0cExaaWpPTkdQNy9Ybkdya2NueFRUSjFl?=
 =?utf-8?B?bERlaUxYbjNDK2w2ZUw3SlkraHZ4a2hHQUg2Z3VaalN6S0U2V3Iwd0dtaHky?=
 =?utf-8?B?b0VjRk4xUXpSc2V3Ylg4VHQza09vQmR4M3R5RWNrZ1dPRlVCSU1KL0NpZUFm?=
 =?utf-8?B?NmNmODN4QWJBUHdxZDdJUXlMU25ZOHpBVnRtcmduclR5OUFGSERSdEN0RWcz?=
 =?utf-8?B?Wk5ySnV1NDVsOVRwUWMxK2RROG5mV3JkWW95NXVodmdXbjRHK0RJdUJGeDAv?=
 =?utf-8?B?dFVGdTMrNDk5aGthTDE5TXZJVXlqR3o5Y0NSSDB4RGNXVURUT3MzTDRnVlpC?=
 =?utf-8?B?UHNOZ3N1eUdPSDZBQkJGUnVTbUVmOEFsditVTk01RHBEMnE4c3dFS09sT0dG?=
 =?utf-8?B?dDFORVU4K1QvMnFxUWEreHN2YzVOSzZwWUVueGJlV0lpSDZQeVo2M0JRNXBI?=
 =?utf-8?B?SXJBRW5sYlVlMGsvMEJRajQrUEpXVmY3TVM1bzBJODZTZTRwek5rZ09qUXZ5?=
 =?utf-8?B?V3NFUWRocUd2dkRrTThZWldhQUYzdlQ2ZElUQ2ZEZzVWUkwzV283aithM2Vx?=
 =?utf-8?B?SGgzenhkNXhncHp0ZVR0Q0FnSXlkbHZaOWhobjBMU3lpRXNmalBWa0dtcGRz?=
 =?utf-8?B?Wmk3cVc1RHJnT1QxekJXU2FsUTVGUVpVdWlGVEVSSGRUQTBJbS9QdUVFOUFx?=
 =?utf-8?B?aGVQOXZHWDVWSGd6cFc3YlA1cEkzcWUwNlMyS1o4RHV2OUJyRlREMXZJWVBi?=
 =?utf-8?B?Zm04enlFRi83UGthYmZmOWduMU1hK011SmRqTDdqd1ZlQVpEWEZmVnIxd084?=
 =?utf-8?B?YXRLbEFPOTlLM0tteW9iYmVodFB5SC9YblhnSk9yZmVFNEZvcFVQVDdZM1FZ?=
 =?utf-8?B?S2owM3kxemxvQTlVSDdGZGpUMHIxNlBoQUZrbFFoa21pOUI0bjZlMHdJandX?=
 =?utf-8?B?ZEFteWt1b3JRQmMvOUFZeVVBY01pWG1OVDB5UTBiRVFjei9WMlpSYlFackVQ?=
 =?utf-8?B?M0pCZ1JEc1dXS1gweDhtdS82KzVrdWEyZ3VaV3VSa1VEckI3QU1mL3hQaHJB?=
 =?utf-8?B?bVZ0NWpKdnByVXd5TXJEcEpzbDVGQkRoYXF4QTB4a3RDZmk1dUxpdTN5TlVI?=
 =?utf-8?B?UFJFT2ZjVnNzTzV5RGQvSUljY255aVZTc0hoTXo0Z2JOWEhGa043a1QzalZa?=
 =?utf-8?B?a2xFQkRha095eTJzS2FoY3loMk8vTHFtNmRNaVFSUFlNNGprRjNleEdyTWNO?=
 =?utf-8?B?M2twNnNldW1Mc1FJTlk4Wm5sQzZ6WGQ3Wm9EVzNhbVJBTFdKK0tUd002a01z?=
 =?utf-8?B?SHpWZGVaQzVyQWdwUGhzSzR4N2NtVTFpcHFhTis2Y0Y3L2dyTk1BKzRjcTNB?=
 =?utf-8?B?Qy9LYWxmeEJNdjRDc3FiUDV4ZVpLTFRIVFFDWFRJVy8xc1FJRDdwNTVnMWNB?=
 =?utf-8?B?MzkyalZteHNVcnlUTS9rc1RQeWMrVUNhdmJ5QklvZm5YT1FYdFJ1cG1tdGZi?=
 =?utf-8?B?SVVpVnZFblBQOFhBcmZudEt3cjlVRzQwVC9yMG10TEZUeS9VenFrc0g0cnlN?=
 =?utf-8?B?Znk4UUFlT1J5bFRKeEV4QkVXSlg4MEdGT1dxU3A4d3VxQjlJdW52S0Z2dXB5?=
 =?utf-8?B?TzZ0djAzcjBRNFpGNmg2Q3RoV2k0ckFyamRvNzZ2eXRHMVhuNkl6bXZwdE1h?=
 =?utf-8?B?Zlk2b2w4aFY0RXRoVnlzbG5lbDhLM3hrOGFKbUJ3V3JaY3JEVXQ2Ykh2bUpQ?=
 =?utf-8?B?RkdxUUpCRXB5OXJNbkZNWWtIaHdzYVpLRmc1aytKN2F6REVjTjJsc3h6cC9C?=
 =?utf-8?B?c2pvamV6K0o1VzlMOVlyRlBMTStFT2ZkUzg3TTY5U0VTTWpmZXpuc0lpa3VO?=
 =?utf-8?B?NHNWeEhWejZkNmdranZQMFd0Ym5Nb0o2R0NvZ01CSGhteGNYQXYrS1VWK3BV?=
 =?utf-8?B?QnQyNFE3NEs5bTJ0T1djSUR4Yk50b3NVZ3dTVmxPSDNrS0pYMG1vejk5ZHls?=
 =?utf-8?B?d3I5TDJEWnNZeEVRcU1oa0NKaVZiMjd6cnRUVzNlYWxTS2pXcHlOeldaYzJx?=
 =?utf-8?B?bC9TL1dHRDhQRGE0OGRNd0JmMmh3SEIvV1p6aTVlWHRZS0w4OTd0ejRHdXJw?=
 =?utf-8?B?alpqTWRDSXpZTXZXbTRrSEJYdzNMWVRJNVl6Q1FGNHhaTVF6ZzhJckZzSGpr?=
 =?utf-8?B?NGF1WW1JdWlab2w2NEswT1dBQTBMSHlzRUNtSEZzT0xzRmVjV3lIYnRqOG13?=
 =?utf-8?Q?2rqjOg2WBi0I1Ffpw0RorbBKKyQQzsjlPqE/n+MB58SFW?=
x-ms-exchange-antispam-messagedata-1: DdNkdXD3XGAzrQ==
Content-Type: text/plain; charset="utf-8"
Content-ID: <B152205BD251174780FAD6211D81C837@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4159.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5068db72-b003-4ba1-3496-08df3adb8426
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Nov 2026 01:24:19.9069
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hvwB7maMpQz/TkxF9NB6a7Nn1fg4WPZQyMdIjew9vNmj3vme1x7zLX0myWw6yXzjtQAOr7iKWAh7nHL7SCC2UQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7714
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261104_172427_540266_AD9FBA8C 
X-CRM114-Status: GOOD (  12.91  )
X-Spam-Score: -2.1 (--)
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-7.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

T24gMTEvNC8yNiA0OjQ5IEFNLCDlkJXms7Ppkoogd3JvdGU6DQo+IEhpIENoYWl0YW55YSwNCj4g
SSBjYW1lIGFjcm9zcyB5b3VyIFJGQyBzZXJpZXMgIltSRkMgUEFUQ0ggMC80XSBBZGQgbmV3IFZG
SU8gUENJIGRyaXZlciBmb3IgTlZNZSBkZXZpY2VzIiwgcG9zdGVkIGluIEF1Z3VzdCAyMDI1Lg0K
PiBJJ20gY3VycmVudGx5IHN0dWR5aW5nIHRoZSBOVk1lIFZGSU8gZGVzaWduLCBwYXJ0aWN1bGFy
bHkgdGhlIGxpdmUgbWlncmF0aW9uIHN1cHBvcnQgZm9yIFNSLUlPViBOVk1lIGRldmljZXMsIGFu
ZCBmb3VuZCB5b3VyIHdvcmsgdmVyeSBpbnRlcmVzdGluZy4NCj4gSSdkIGxpa2UgdG8gYXNrIGFi
b3V0IHRoZSBjdXJyZW50IHN0YXR1cyBvZiB0aGlzIHdvcmsuIElzIGl0IHN0aWxsIHVuZGVyIGRl
dmVsb3BtZW50PyBIYXZlIHRoZXJlIGJlZW4gYW55IGZvbGxvdy11cCB2ZXJzaW9ucyBvciBuZXdl
ciBkZXZlbG9wbWVudCBicmFuY2hlcz8NCj4gSWYgdGhlcmUgaXMgYW55IG9uZ29pbmcgd29yayBv
ciBhIG5ld2VyIHZlcnNpb24gYXZhaWxhYmxlLCBJIHdvdWxkIHJlYWxseSBhcHByZWNpYXRlIGl0
IGlmIHlvdSBjb3VsZCBwb2ludCBtZSB0byB0aGUgcmVsZXZhbnQgcGF0Y2hlcyBvciByZXBvc2l0
b3J5Lg0KPiBUaGFua3MgZm9yIHlvdXIgdGltZSENCj4gQmVzdCByZWdhcmRzDQoNCg0KWWVzLCBp
dCBpcyBtb3ZlZCB1bmRlciBOVk1lIFRXRyBMaXZlIE1pZ3JhdGlvbiBTb2Z0d2FyZSBXb3JraW5n
IEdyb3VwLg0KDQpJZiB5b3VyIGNvbXBhbnkgaXMgcGFydCBvZiB0aGUgTlZNZSBUV0cgdGhlbiBw
bGVhc2UgcmVhY2ggb3V0IHRvIG1lIGluIA0KdGhlIFRXRywNCg0KSSdsbCBiZSBoYXBweSB0byBz
aGFyZSB0aGUgc3RhdHVzIHRoZXJlLg0KDQotQ2hhaXRhbnlhDQoNCg0KDQo=

