Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94094C4345F
	for <linux-nvme@archiver.kernel.org>; Thu, 18 Apr 2024 16:17:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/39LjZa6Gn+ZKgu/B9geApk+Jt3D0wS2lK1WR+GMOxU=; b=Fmmy8J5X+Z0PUQlNf/qRYoqCvk
	Qe2p1y39HJaBnI9Xi5LZLl+RrqOBIoLyoTkE1i9RgBQD3CgJ0QKvROwnhpft0hcHFXL+VCahsbtcQ
	Z/JCaI9KVjxbdpFePSfkdYBDJS4l74vsEO9F76zwX7uToJS8ii2C4dGJhk7mCUcrYwzGzytke9fUC
	W+IkAPOV5rXAVNBf8ek/+ahSN67G6df0UUShLdOLdBezyx/LER5wOtgMh4IKg1k5hurGGFhyYqq98
	JmUxyNCZfdrjP/y4cmhVhC6oa4IpJaYtOaaTOdcRSdpoGXHbwEXzdYWqtqHDG+RFYuidoVR+uvohP
	4lQFhKDA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rxUSJ-00000002z6m-3vnt;
	Thu, 18 Apr 2024 16:17:47 +0000
Received: from mgamail.intel.com ([192.198.163.15])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rxUSE-00000002z6K-3D0A
	for linux-nvme@lists.infradead.org;
	Thu, 18 Apr 2024 16:17:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713457063; x=1744993063;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=/39LjZa6Gn+ZKgu/B9geApk+Jt3D0wS2lK1WR+GMOxU=;
  b=aqOQoI9vYxzGzc4aLLuhWfmUaRvaYMeu3xMne8otEi5UiCMZ5ije9Qhw
   nXo4yy6ql0kIomr3bJlB+IC+qFslPsAqAfyGbx6Bgk1gVgJMfmxAtaIMK
   bakeb9SY+9vAOXNU6K1Mn5GNLauu81NPJgy28LG5Hp5XIYCZ4FwG97cpw
   jaGV3uN/uoYkyBl3D2CexbPpVLwWPsFBupnmQHUvyweBVgdY3lxqau61W
   7D6pmnC8LZ+55BCzmDWQiKLd4EVmtKlycwjt0rfp06tI73WG/my3zsltG
   4RltQOMahwey9X11O0EGiTxfcUbq+x9TdCrlVYJQHdQShLPijnvYaQusA
   g==;
X-CSE-ConnectionGUID: uA2MAPjNQ8SpTS8DeJ1YQg==
X-CSE-MsgGUID: asklzTz4T/uMG3O2JJw5gA==
X-IronPort-AV: E=McAfee;i="6600,9927,11047"; a="9189285"
X-IronPort-AV: E=Sophos;i="6.07,212,1708416000"; 
   d="scan'208";a="9189285"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2024 09:17:30 -0700
X-CSE-ConnectionGUID: aio9WikYQfCuptfrvCOVsQ==
X-CSE-MsgGUID: i/YngH+4S0yR/enLgdWyMw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,212,1708416000"; 
   d="scan'208";a="27694739"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 18 Apr 2024 09:17:30 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 18 Apr 2024 09:17:29 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 18 Apr 2024 09:17:29 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 18 Apr 2024 09:17:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GqGXPBKlT1cv+XBIn2HoN0VRi3rc9vGXR8La7olAfMFgUAAEIrsjuip5HA2lLdHzAmWG7XJOAmzc8l9dsUlPo9JVsy5Ryw8K7gQLpslKZ6L0dq838UHcrURdgZ8ntUDvXT3KpsTgSx23LuLaGe+BAmD/q1ZoV2baIcQWwqX/7/R9UW2bGbltJvBw4ibda81anT6dCETAI0k3NMoCc/PSKXffwTUqB/fvLq5x2eNeZCJOpSlerWRyGGgwbjxZ49jBI8JlscK8K9Hjm35q6GeAVmJrbTMkDAo9AQe3giGcmW7h6TEJ4GC0ueriT521khm1ePJnNBxMn0lty71ywHmXfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/39LjZa6Gn+ZKgu/B9geApk+Jt3D0wS2lK1WR+GMOxU=;
 b=UUApqAcdBebuqNnDgYQz9IejNefpA/heJlePbwVjY69zQ2cZenipQkoPY9eRH43DDltZ0KJIEL1Ns9eqKtQPXGm7VJiZpczUEcf1x7ESGD0bvc6Umh8Urur/95U9MD8xI0a4d7a/ZJCfBTNzJH0/0Tk7zRqqvS7o4P4zo7dBnsXnf25qA6GcmMAnofrmuj0c0+n4oRwHoIDhs4c0sbnJFKN2cdvursekwvKzskTbjUsEzapo1VdPMWS7KPKjwDLscpCB7icyvqN/8sBRVPfBn2/jQSC2hTl7mQG/10mXdDtzqSF6cMCkD5lsdCoVICGoz6IsBsO9J1S+9EzMyhqp3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN6PR11MB8103.namprd11.prod.outlook.com (2603:10b6:208:473::10)
 by MW3PR11MB4634.namprd11.prod.outlook.com (2603:10b6:303:54::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.37; Thu, 18 Apr
 2024 16:17:27 +0000
Received: from MN6PR11MB8103.namprd11.prod.outlook.com
 ([fe80::2cc8:42af:1a1e:ee1a]) by MN6PR11MB8103.namprd11.prod.outlook.com
 ([fe80::2cc8:42af:1a1e:ee1a%2]) with mapi id 15.20.7472.037; Thu, 18 Apr 2024
 16:17:27 +0000
From: "Zawadzki, Tomasz" <tomasz.zawadzki@intel.com>
To: Keith Busch <kbusch@kernel.org>, Hannes Reinecke <hare@suse.de>
CC: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, "Daniel
 Wagner" <dwagner@suse.de>, "Brzezinka, Sebastian"
	<sebastian.brzezinka@intel.com>, Sagi Grimberg <sagi@grimberg.me>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: RE: nvme-cli spdk plugin
Thread-Topic: nvme-cli spdk plugin
Thread-Index: AQHakKHuQnlqNUoknU6oKrkiXVn1ALFshR4AgAABhwCAAQqUgIAAi0QAgAADioA=
Date: Thu, 18 Apr 2024 16:17:27 +0000
Message-ID: <MN6PR11MB8103E3599A137C129353E577EE0E2@MN6PR11MB8103.namprd11.prod.outlook.com>
References: <xulnfwru3jfl2nooq27yym7nx3cdpxqslzqz5nvwnkymncapnt@pzascju2tmvf>
 <20240417142610.GA31809@lst.de>
 <7a926cbb-51f9-4e03-b737-b4434b1270dd@kernel.dk>
 <09b3d5e9-0ead-44b0-8517-2a1954026784@suse.de> <ZiExvFvUPk4HOt3d@kbusch-mbp>
In-Reply-To: <ZiExvFvUPk4HOt3d@kbusch-mbp>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN6PR11MB8103:EE_|MW3PR11MB4634:EE_
x-ms-office365-filtering-correlation-id: 54ddf0da-8cda-4740-62ec-08dc5fc30a33
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3InC90qxLDA9MWBArUwFWfdIygPdW/qsF+qUf6a7qPuBdIHfSAj+dWHjCYPJO6W6ha9WzAa3a8KoBbLSH9PH2EjfJSnx6iu8fNzaGKpnidk16s9kSPfZoDpq7KuS3FnJFR14U+jKnz2Ql3hR6bMaqH2z/zKruhsDfHt/foaAsV7CArJG+pkC3N3qCE4zHIafshK7IqAzdZeigL1+1s/1P9FJTOsxM2ZTdraBTAyc4Mz0ZElALZcEoc4rQVoAcPPQzU/1+RaNan6/DgHHY5mpjaTW5NuaRJ8oyUv097mov3G23CpiQn82OnsFEgLOlyw7tBHi42a/JpYtcla5SZurvbc3fqKjtelZCbdXhK5KPNdFRjzoRO0l5z9AtTkM0juwKdBI7INmIKK/DEGZjACHBjtclbyoD+HFRLP0eK3wYIPLxiy9Z7WVCCTSI0TofxDPY/9PfIeL2AyEiFcOjFs2436Pcr7Ig9BuWAehXkpGXgKN3vU66izvEMMJPXwpAvQ4zGr52PEn5alFEtpyE2/QeF66eepy4Ck9v43FKYhx1n4Hq5QIcW7qCdMua1PUQdkRyoUNnJAZmXIHVRHTPRoEb6cEYEWtXYZysXiNm5cN+5ZJ7nHatm0bazmO1lhl2Vt80KUX29kc5LoD97Xw76/0Pbn8vjKFvrsI8Ibnb3eITF0gIHKt6rjj2a6aNG4cQgVgGxnDD4YxN0LKuHCVQ/0xFXdynZj1g4wcjWDgiGzoYgk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8103.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NStEeE1ENlRKektVcWJtbko1Zjc3WmVoNytPby9FNnpJakZGZXNmbHZOSEZP?=
 =?utf-8?B?Umt5NmExdEluaVRaY3RPclk0TFJwb2ljQkZwWnM1eHQ2YUVOanl0WFF3QnF1?=
 =?utf-8?B?NU80dDRjUzJQQyt3aTB3UVowR2E2NE9iWDVJUFM0Um5ZcGFTZEppSTNiTTFT?=
 =?utf-8?B?Q3ZYQ1p1Tys1K2VBNWl0TkYxeDVGRm5Kejg1ZGNzSkpIQjl3TzV3bGc2YTho?=
 =?utf-8?B?ZUtCSlZQbjc4bkN6TmtKa0s0SzdIM3hnQkFTS2FIVy9idFBkanMzUXcvcTJE?=
 =?utf-8?B?MUcwSTB6K3dLZnFaSjFqWEV0WDRyWHp4WmRORjFpbU9FSW1wbmxhVENSUFdt?=
 =?utf-8?B?RFIvckkrSHVQdXp5cU0zRXBFM0E0NHlBcFFjL3ZMY0lLSFdRRWUvamh0NXhL?=
 =?utf-8?B?QmdiVVBxNnI4YnVGQWY1TU5ieEd0YitkcmsyQ3h1MFJvSUY0bkcrb3YwSWZK?=
 =?utf-8?B?ZnhlSUUwMmN0WWtha0ttL2s0RWlzZHNyMy9FZkZZdjhPRjJmd040L2JsN2N4?=
 =?utf-8?B?REpoWVZmMW5lb3FJUitYWThyajNqS2xNbWdKTXZrb21MYThrcG1OMk1GNmls?=
 =?utf-8?B?MlpCeWc2TjlIeENjNnNxNDE0dzQ2QnZvbm1RZnNZSlZOTzdPT2N0ZXd0d3Bp?=
 =?utf-8?B?emtzVWs4YnhFVjNyZ2RpSzA0dlhoUUk1ZWhNL21KV2FaRmRzbGw4eWVXRjM5?=
 =?utf-8?B?Mjdqb3pBVXhPQUZYQnpFUWhWbElZeVFOd3YxemNsQ2tVZDlBZjZYVUYwSGd6?=
 =?utf-8?B?NFoyWTlUZVMvdGxlMGd3OG1BditIRGlOYUU0WmZlUnh3RFNWek1Od1FBVU5y?=
 =?utf-8?B?K29seGlPdzY0NmJ0d1BzckptamVIQlZkcG1ZZEJHeTRhM0EvcEFXMExJT0tN?=
 =?utf-8?B?czQwRzZTbFNtcTBERjFwOWE4L3FQc0FQdmxEVnBEYy9DUDJKZHdzU0FIK1RF?=
 =?utf-8?B?VzQ3d3ZNSW5VT3NyamhTTEw3STJpWGhBT3pKUDZkU3VocWp3eDl4WXBlUkJB?=
 =?utf-8?B?Yk9tVURQRTROTFV1T1NTaFllS2xXR1NBUGVnc253elVxS2lsbnJMSStBWU0y?=
 =?utf-8?B?eDhxSS9pNE5jZWVkeW1zbG5NU21rWG50TGdXVG51d2pMd0dFU1N1Ly94Rk9T?=
 =?utf-8?B?MDYxMWdmeWQ5T3d5ZFdTaDkzSWFJajMrZXhDWHhMcTBRRUgzNGhMWHdlM283?=
 =?utf-8?B?WVdOWXhXLzk2Tk9aZjRVSktzazh6MGt6SjNqZ1dPSXNvczUwNDJmRkZTclQw?=
 =?utf-8?B?Q000d0FGa0JqUGttaUpIVWpVQmtQRUVXQUVjajZFa2FMaEt3cGJ0bElRVmxX?=
 =?utf-8?B?Wk5taVJienRMczNvSXZ2ZFNjZkFjTlJmNStIaGE4U0srYWpPdDBud2pHM3Bp?=
 =?utf-8?B?enBrUjJGT0pxY1pZT1dHOG5ockMybWZHcHZzVzlZaU80bmFCWnhRN1Y1Tm5x?=
 =?utf-8?B?eTA2NTlNWWdxdDRERnRlVlVncmdRZGltYjRuZW14K0lWZ3JDdWlwejdpNkc0?=
 =?utf-8?B?elVMNVJSZlp4QzE5NXBMam1QYm1tNFdSQ2MvdGdDL3QzVExQTmtGK0h5STBr?=
 =?utf-8?B?YVJuVUE2czBrY2N5eDZSL3FBR25mZzBYWE92NlJRRCtMdGVLT3pZM3l1enVN?=
 =?utf-8?B?VldaakZtczlXNU9OUlVkb2I0U1BZaTVBTGh2S0xwd1BBVTFOdUd5WFk3RHdJ?=
 =?utf-8?B?d1lvcHZRTjY3VENjYThnVXVnYmZxS1ZkNVZ3aHRsQ3IybTVkS1NvNzh4RUhR?=
 =?utf-8?B?TmhhQnNvS2lKeDNscGJtUkNsdGFZUWJTa0xPN2R2c285ZUFENDVJdzdnZnR6?=
 =?utf-8?B?VkRLTnVFNEl1eHhkSmVUQllNcG5aeUN3THZiSW5sQWswcUROVVhiUTU0dW02?=
 =?utf-8?B?R3hSbS9WMWdXM2dLaTRteEZxREVWeTYrWWVadTZMS0V2UkVvdEp0ODVaNkRj?=
 =?utf-8?B?WGRHMFdHa3FvZC9BRkp3UlR6SXQ0SlpBTkxIUmdBZUtkV0lYUGpOelZjdGdp?=
 =?utf-8?B?Q1VzTDdWdURldDEzR1hZdUZITmlnTkY3UmR4bEExeXRnOTc4d1NtMGE3dUNr?=
 =?utf-8?B?Zldob0NWZWVIQWtTeUZIcUs0WVAwMG1VZVRsYkt4dVRNQ3QwaVhTcUQ3ZFlv?=
 =?utf-8?Q?PcCIfufaCYijOk6B2rbO0ZiBK?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8103.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54ddf0da-8cda-4740-62ec-08dc5fc30a33
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Apr 2024 16:17:27.3943
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jwDNYQorOGLOhWr+k3z3bMZhrZdHAcahA6qox6AJQcIFyi00KQnFZUhtL6EsR1lwtnbNimzzofvdaRVfScqXyWF6o871pHPBHJ5uHFxozQc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4634
X-OriginatorOrg: intel.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240418_091742_849033_2BAD3C17 
X-CRM114-Status: GOOD (  36.81  )
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

PiBPbiBUaHUsIEFwciAxOCwgMjAyNCBhdCAwODoyNTo0NUFNICswMjAwLCBIYW5uZXMgUmVpbmVj
a2Ugd3JvdGU6DQo+ID4gT24gNC8xNy8yNCAxNjozMSwgSmVucyBBeGJvZSB3cm90ZToNCj4gPiA+
IE9uIDQvMTcvMjQgODoyNiBBTSwgQ2hyaXN0b3BoIEhlbGx3aWcgd3JvdGU6DQo+ID4gPiA+IE9u
IFdlZCwgQXByIDE3LCAyMDI0IGF0IDEwOjMzOjE3QU0gKzAyMDAsIERhbmllbCBXYWduZXIgd3Jv
dGU6DQo+ID4gPiA+ID4gVGhlcmUgaXMgYSBQUiBbMV0gcGVuZGluZywgYWRkaW5nIGEgc3BkayBw
bHVnaW4gZm9yIG52bWUtY2xpLg0KPiA+ID4gPiA+IFRoZSBwcm9ibGVtIHRoaXMgbmV3IHBsdWdp
biB0cmllcyB0byBzb2x2ZSBpcywgdGhhdCB3aXRoIHRoZQ0KPiA+ID4gPiA+IHJlY2VudCBjaGFu
Z2UgdG8gdXNlIHN5c2ZzIG9ubHkgZm9yIGRpc2NvdmVyaW5nIHRoZSBudm1lDQo+ID4gPiA+ID4g
c3VieXN0ZW0sIG52bWUtY2xpIGxvc3Qgc3VwcG9ydCBmb3Igc3Bkay4NCj4gPiA+ID4gPg0KPiA+
ID4gPiA+IE15IHF1ZXN0aW9uIGlzLCBzaG91bGQgd2UgaGF2ZSBhIHNwZWNpYWwgcGx1Z2luIGZv
ciAnbGlzdCcgYW5kDQo+ID4gPiA+ID4gJ2xpc3Qtc3Vic3lzdGVtJyBvciBzaG91bGQgd2UgdHJ5
IHRvIGdldCB0aGlzIHNvbWVob3cgaW50ZWdyYXRlZA0KPiA+ID4gPiA+IGludG8gdGhlIGV4aXN0
aW5nIGNvZGU/IFNvIHRoYXQgJ2xpc3QnIGp1c3Qgd29ya3M/DQo+ID4gPiA+DQo+ID4gPiA+INCG
IGRvbid0IHRoaW5rIG52bWUtY2xpIHNob3VsZCBkZWFsIHdpdGggYW55dGhpbmcgdGhhdCBpcyBu
b3QNCj4gPiA+ID4gZHJpdmVuIGJ5IHRoZSBrZXJuZWwgbnZtZSBkcml2ZXIuDQo+ID4gPg0KPiA+
ID4gRXhhY3RseSwgd2h5IG9uIGVhcnRoIHdvdWxkIHdlIGNhcmUgYWJvdXQgc3BkayBhdCBhbGwg
aW4gdGhlIGZpcnN0DQo+ID4gPiBwbGFjZSwgbnZtZS1jbGkgb3Igbm90Lg0KPiA+ID4NCj4gPg0K
PiA+IEFuZCB0aGF0IGRlcGVuZHMgb24gdGhlIGRpcmVjdGlvbiBvZiBkZXZlbG9wbWVudCB3ZSB3
YW50IHRvIHRha2UuDQo+ID4gRG8gd2Ugd2FudCBudm1lLWNsaSB0byBiZWNvbWUgYSAnZ2VuZXJh
bCcgbnZtZSBtYW5hZ2VtZW50IHRvb2wsIHRoZW4NCj4gPiB3ZSBzaG91bGQgaW52ZXN0aWdhdGUg
aW4gaGF2aW5nIGFuIHNwZGsgcGx1Z2luLg0KPiA+IE9yIGRvIHdlIHdhbnQgdG8gaGF2ZSBudm1l
LWNsaSBhcyB0aGUgY2xpIGZvciB0aGUgbGludXggbnZtZSBrZXJuZWwNCj4gPiBkcml2ZXIsIHRo
ZW4gY2xlYXJseSB3ZSB3b3VsZG4ndCBuZWVkIGFuIHNwZGsgcGx1Z2luLg0KPiA+IFRoYXQsIEkg
Z3Vlc3MsIGlzIHRoZSByZWFsIGRpc2N1c3Npb24uDQo+ID4NCj4gPiBQZXJzb25hbGx5IEkgd291
bGQgdm90ZSBmb3IgdGhlIGZpcnN0IG9wdGlvbi4gQnV0IEknbSBzdXJlIG90aGVycyBoYXZlDQo+
ID4gb3RoZXIgb3BpbmlvbnMuDQo+IA0KPiBJIGRvbid0IGFjdGl2ZWx5IG1haW50YWluIHRoaXMg
cmlnaHQgbm93LCBzbyBJIHRoaW5rIGl0J3MgcmVhbGx5IHVwIHRvIERhbmllbC4gSXQNCj4gbWFk
ZSBzZW5zZSB0byBtZSBmcm9tIGEgZGVzaWduIHN0YW5kIHBvaW50IHRoYXQgdGhpcyB1dGlsaXR5
IHNob3VsZCBoYXZlIE9TLQ0KPiBhZ25vc3RpYyBhYnN0cmFjdGlvbnMuIEl0J3Mgbm90IGEgcHJp
b3JpdHkgZm9yIG1lLCBidXQgaWYgcGVvcGxlIGFyZSB3aWxsaW5nIHRvDQo+IG1haW50YWluIG5v
bi1saW51eCBrZXJuZWwgZW52aXJvbm1lbnRzLCBhbmQgYXMgbG9uZyBhcyB0aGF0IGRvZXNuJ3Qg
aW50ZXJmZXJlDQo+IHdpdGggTGludXgga2VybmVsIGRldmVsb3BtZW50IG9yIGJyZWFrIGV4aXN0
aW5nIGtlcm5lbCB1c2FnZSwgdGhlbiBJIGRvbid0IHNlZQ0KPiB3aHkgbm90Lg0KDQpBcyBtZW50
aW9uZWQgaW4gdGhlIG90aGVyIHRocmVhZCwgU1BESyBoYXMgdGhlIGFiaWxpdHkgdG8gcHJlc2Vu
dCBpdHNlbGYgYXMgYSBDVVNFIGRldmljZS4NClRoaXMgYWxsb3dzIGZvciBpbnRlcmFjdGlvbiB3
aXRoIG1vc3Qgb2YgbnZtZS1jbGkgY29tbWFuZHMganVzdCBieSBwb2ludGluZyB0byB0aGF0IGRl
dmljZS4NCklzc3VlIGlzIHdpdGggbGlzdC9saXN0LXN1YnN5c3RlbSB0aGF0IG9ubHkgcmVsaWVz
IG9uIHN5c2ZzIGVudHJpZXMuDQoNCkNoYW5nZXMgbWFkZSB3aGlsZSBzcGxpdHRpbmcgbnZtZS1j
bGkgYW5kIGxpYm52bWUgYSB3aGlsZSBhZ28gbWFkZSBwZXJmZWN0IHNlbnNlLA0KYWxvbmcgd2l0
aCByZW1vdmFsIG9mIHRoZSBmYWxsYmFjayBvcHRpb24gb2YgYnJvd3NpbmcgL2Rldi9udm1lKi4g
UmVpbnRyb2R1Y2luZyB0aGF0DQpiYWNrIHdhcyBub3Qgc29tZXRoaW5nIHdlJ3ZlIGNvbnNpZGVy
ZWQuDQoNCk9uIHRoZSBvdGhlciBoYW5kIGFkZGluZyBhIHN5c2ZzIGxpa2UgcmVwcmVzZW50YXRp
b24gZm9yIFNQREsgZGV2aWNlcywgd291bGQgc3RpbGwgcmVxdWlyZQ0Kc29tZSBjaGFuZ2VzIGlu
IGxpYm52bWUuIFRob3NlIHdvdWxkIGJlIHRhcmdldGVkIHNwZWNpZmljYWxseSBmb3IgdGhhdCBp
bnRlcmZhY2UuDQpJIHRoaW5rIHRoYXQgdXNpbmcgRlVTRSB0byByZXByZXNlbnQgdGhhdCBldmVu
IGdvdCBzb21lIHBvc2l0aXZlIGF0dGVudGlvbiBzaW5jZSB0aGlzIHRocmVhZCwNCnlldCBpdHMg
bm90IHNvbWV0aGluZyBJJ3ZlIHNlZW4gYW55b25lIHBsYW4gdG8gdGFja2xlLiBUaGUgY29uY2Vy
biBoZXJlIGlzIHRoYXQgc3VjaCBhcHByb2FjaA0Kd291bGQgc3RpbGwgcmVxdWlyZSBtb2RpZmlj
YXRpb24gb2YgdG9vbHMgdG8gbWFrZSB1c2Ugb2YgaXQsIHBvdGVudGlhbGx5IGRlZmVhdGluZyB0
aGUgcHVycG9zZS4NCg0KVGh1cyB0cnlpbmcgdG8gbGltaXQgdGhlIHNjb3BlIG9mIHRoZSBjaGFu
Z2VzIHRvIG52bWUtY2xpLCB3ZSBkZWNpZGVkIHRvIHByb3Bvc2UgdGhlDQpTUERLIHBsdWdpbiBm
b3IgdGhvc2UgdHdvIGNvbW1hbmRzLiBJdCBpcyBzaW1pbGFyIHRvIG90aGVyIGFscmVhZHkgZXhp
c3RpbmcgcGx1Z2lucw0KdGhhdCBsb29rIHVwIHRoZSBwYXRoIGZvciBsaXN0IGNvbW1hbmQuIEJl
c2lkZXMgaGFzIHRoZSBiZW5lZml0IG9mIGJlaW5nIGV4cGxpY2l0LA0Kc28gdGhlcmUgaXMgbmV2
ZXIgY29uZnVzaW9uIGZyb20gdGhlIHVzZXIgcG9pbnQgb2Ygdmlldy4NCg0KUGxlYXNlIGRvIGxl
dCB1cyBrbm93IGlmIHlvdSB0aGluayB0aGVyZSBpcyBhIGJldHRlciB3YXkgdG8gaW50cm9kdWNl
IHRob3NlIHR5cGVzIG9mIGNoYW5nZXMuDQo=

