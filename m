Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24066C4345F
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Apr 2024 10:17:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yFUqp1nH+UPHfIuto0Dg1YN9uZvY1VGk/aT+pL49ZgM=; b=iRqbz9l/flUy9rxNLtsJrIiMbp
	R8+2K55+qA8Y+/eOAaLCCpiCtIpGIsaQYcdDc944Hup2T0nA/pIY96ClfjacEKLhefXdHYRT86jBP
	chDhkajsTmF6a4+s5pN25oMF7hd6vOgNY2cZQveUAUf+gHWTnarCsjRcdTK5zfvRuIR1srZfGNH/R
	e/BdE66Slr0YJ8dxJCXlQik/unfgfLNehuLCGwlTujeC3nh3XvP+vLU620D462FixpXDtHlDdHUja
	DQJad0p4sgtYAPXOjusomE2+r7weufvDhMI7Wd8Tv89lNzI2lfWYG+59NS63E+JvIoPMW5Y4Wg8GI
	yWIR83Ig==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rx2MS-0000000FYFt-42fY;
	Wed, 17 Apr 2024 10:17:52 +0000
Received: from mgamail.intel.com ([198.175.65.20])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rx2MP-0000000FYEL-1We3
	for linux-nvme@lists.infradead.org;
	Wed, 17 Apr 2024 10:17:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713349070; x=1744885070;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=yFUqp1nH+UPHfIuto0Dg1YN9uZvY1VGk/aT+pL49ZgM=;
  b=RguYD/W7U+w7mw6OwOR7sJUpsiGkvpQkTRphWdFJnsP/xdnnMntuwL3N
   xX8pAJYsQGTiazBLVlL8mu/36Fz+m7tDFRfgBLGPoGepGUk9le+6iWJGc
   AmRehlJvIW3SfyxcF+eW6YrNEuPK5T/6+S5g8g/omX6lhVCxgDxja4UUr
   b+GvebJKVvaxENKbOsLKcu/yFBE9XJilFK/LVf1uCVbs/AqZeCY0O1bKh
   C1cW8BJQ0StzMApEwrRmP105wZ2LTnVetOZrOaEVxBSnXw0KSs+L3C+qe
   nfN9zDPsydYNK6lKVOfQZUMdZ/U2w3GcNAlWkzJ71b4C5RM2IxcM4oggs
   g==;
X-CSE-ConnectionGUID: VQDUwM3YSnarMM4iXGF6PA==
X-CSE-MsgGUID: 22IQLcSZRpSwcJuMWTP1gQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11046"; a="8662122"
X-IronPort-AV: E=Sophos;i="6.07,208,1708416000"; 
   d="scan'208";a="8662122"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2024 03:17:46 -0700
X-CSE-ConnectionGUID: pfFI7YTxSmC+6aI8A/9TvQ==
X-CSE-MsgGUID: Q/OClN5eSaaBI2yEHhEIug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,208,1708416000"; 
   d="scan'208";a="22647671"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 17 Apr 2024 03:17:45 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 17 Apr 2024 03:17:44 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 17 Apr 2024 03:17:44 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 17 Apr 2024 03:17:44 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.173)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 17 Apr 2024 03:17:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WtHY3OBj7v6wxa6VA0dNOYNpJmJnPYAknA1LBFpjmo5mrBn09tg1MgdIGtpUt0T65Q9UASDihVdU0RMOXZXOG/MQfOyDTEDt5dGARjeJvpUEVS15fqAhVOf3uuP60k9OWAOwzw9iIpgcYTHEoONc5X4cpManN1Ugv25FGXBKJ4FDDMCrUTF3rG5Of3J1yaQ9gJpg2jENYGICIGy7Tv+zwQYXN7A9zKtO6W/dK4GG8m+7bQd3lrS4qxD+K1ieuVwgu+a+IjHWUVRqbX/7R5NQofHoAiJ7LnqH9Chisqf3npcfxCf5g9u4drk8ednpOJXaXG89veCCyyqMINIa4fkFtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yFUqp1nH+UPHfIuto0Dg1YN9uZvY1VGk/aT+pL49ZgM=;
 b=I4SOEDSizuuyG+G4FWz50slE2VQ3rckOVy+8Yl2SaOyAXDTmJscvdfBpT/opejPyN5IoPXWSo/HyPLnTdFbYCyiqkNlijicgzXYrqQyboUthrJjBgxv3lCz1jI0CzqwZ3ewZrwOmJdPFRiFjLs48zMqgj/r2W8+VTr1GgDA4M5iyuuZeDOh7gmB8NQnVe+3htb1Lkwp/tPmF77++no7t/+f8eS3Jz5g0LOKLN5SO5YGY4bwgsENJPUxEuy23yiAwuBwnHN+ZSok+9CDeX6BT8odzZGfU+ouX/4ld+wgaiACmTUr95URoomxy26LzVlFrbrEIAozpueCn1QDIQqHjfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW4PR11MB6909.namprd11.prod.outlook.com (2603:10b6:303:224::12)
 by SJ0PR11MB4781.namprd11.prod.outlook.com (2603:10b6:a03:2d8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.27; Wed, 17 Apr
 2024 10:17:36 +0000
Received: from MW4PR11MB6909.namprd11.prod.outlook.com
 ([fe80::9c45:d2ae:db71:b99]) by MW4PR11MB6909.namprd11.prod.outlook.com
 ([fe80::9c45:d2ae:db71:b99%7]) with mapi id 15.20.7472.025; Wed, 17 Apr 2024
 10:17:36 +0000
From: "Brzezinka, Sebastian" <sebastian.brzezinka@intel.com>
To: Sagi Grimberg <sagi@grimberg.me>, Daniel Wagner <dwagner@suse.de>,
	Christoph Hellwig <hch@lst.de>
CC: "Zawadzki, Tomasz" <tomasz.zawadzki@intel.com>, Keith Busch
	<kbusch@kernel.org>, Hannes Reinecke <hare@suse.de>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: RE: nvme-cli spdk plugin
Thread-Topic: nvme-cli spdk plugin
Thread-Index: AQHakKHulKFaoIuf+k+uc6D5mVE6LrFsNmIAgAAIyGA=
Date: Wed, 17 Apr 2024 10:17:35 +0000
Message-ID: <MW4PR11MB6909AABD66425491A12CA138ED0F2@MW4PR11MB6909.namprd11.prod.outlook.com>
References: <xulnfwru3jfl2nooq27yym7nx3cdpxqslzqz5nvwnkymncapnt@pzascju2tmvf>
 <2ed308dc-95d3-4f7c-8c3d-134f5ec56063@grimberg.me>
In-Reply-To: <2ed308dc-95d3-4f7c-8c3d-134f5ec56063@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR11MB6909:EE_|SJ0PR11MB4781:EE_
x-ms-office365-filtering-correlation-id: 39237145-3b21-4e71-c80b-08dc5ec79a4e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rfUSYSYKdcwBwxBUlcSO4b8aXqnbIrsT1i6UUzRV9kwp4ZzAYLVnnHedxnmzZpMRjAz6tQPfK1yFXv5HCYzhizthq9IpwOpTYlAHdbWadGqT0fwpNEO1a033bMbJKYPi7KeFl0szJ+smSyYV4+2h1q2/BiW3RCd2rTH8BfXFPdnr6/OTuYAf9YvWKvTEhN4inWUWy5eIAnYet62iz3lLdHChX1t7qxI7nW1jExKmCRifWQTG0UITpL8Vwe2RckixInAU+bWCnhCsLka1dkLVHt9eZua3/DjTlN6DxDzChjbnOJJAJ+6Y7J/xfifQvh/i0cXoqsIyYGC5vyqPxpn1ueDoOtLT93ig7Rdmr9YymShwmNwN9ckMXaGosykz+Omajbg+odT5jeJFozm0K0a5FFYM05XBtdAvSFF1KqxD/DyE5M75BpsOe3Ao0+dI1OuP4mqAokdlHUL5iYYGu2X0uT7N8fWoUhjC/HlWiJUmIBavCty5FR019t9Yip+l2AHOQBBA8sjrQp9kPzvzeDp4eTtYvCE1sNVZ8jrn1TA9fwyAfQdi1+oR6C8QuNDYlYW3gpR+SY54nCXeQGxveGHXmwC3otOeoGT2SPU1Z9M6VG9yOR3jQJX3f/5RwfM8LLJNVDIkt5ffWlI6HcVXbOl9QWQ0et/udYLmaqXgCcYwVxI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB6909.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WnFLTkRzMGlvSXBtWUV0UGgwTGlYVVIvNmdGcFAzNW1EZ09yNHZNWFd4OHRY?=
 =?utf-8?B?bFcyaWFUNmtJTjI3VE8zd01obk5rSGVFRFd5bnN4ekJyanNMOCtpMlpEYWli?=
 =?utf-8?B?ZDJKbDJFMUtvcmV3blRjRC8zRmR6Sndzc0pUYXRQanlKQnUxY09XQit1dlRH?=
 =?utf-8?B?a1hldWR4cjVGMWFVS0lXMGc5NVV5YnltM09DRUl4OGpYczBPK21DZ1JPT1BM?=
 =?utf-8?B?aFl0Zm9QVHFpeDdha0RCYzkwZkVpWjNQV0t2V2RiMVVkR0pUKzBkV1VGZWg1?=
 =?utf-8?B?S1QxZVlNcUdWNDBNeXBXREd1SVVwTlJkaEZDS1pnV2ZHN09zM0kvS1ZNczMz?=
 =?utf-8?B?cVFKU1BtaFFSRE9LZGFMaUQ2NWR5SG01RG8reHJObFl2aElzc0UyRGZvMEMv?=
 =?utf-8?B?eHVGYzZwcytxM2NrVXJHTW5zbjVrRGhCYnVNcUdPUlFDL0VrbDYwYmFUZ2dO?=
 =?utf-8?B?VXc4T1JEbDRwMGg3MGg2VXNmSkY5VjBqN1JrazFWb0dFblVoUkx6UE5BVDY2?=
 =?utf-8?B?VGlGMXJPaGFVMURJWDBINWFHcE9NYVI1OWNML0h0RnoybE5JeTBPNG5aeU0x?=
 =?utf-8?B?T2d0c1RFY1djajkrc1BUelVrME9qUWRhZmtuelJOTXZLdEFKNGd1bDN0aUhK?=
 =?utf-8?B?SUtFWWFoK0VXdGxSYlBEdERBS1ZCcEJxR3pnMGl2bCszbGJzVEFaUW53MEJC?=
 =?utf-8?B?Tld1aVZoMDdQdS9zOUp5MzFWekt5cGhOcVpMRHlxKzFlV3lRSGZVZFFDeTJH?=
 =?utf-8?B?L2ZEVmxaeFp0VWFNWFFUWGZGVVhnUVJjMmpUWms3b1dacVBEZUw1dTdPZmFx?=
 =?utf-8?B?Vmthd0F4Ni9tcFB1MHJvNTkyWUE1MUJmcHczZ0JwSlhrS2xzbUhTVVIraThP?=
 =?utf-8?B?YUdJTFY5SCtBVGNXRzRCTjJnS0Nua2VtL3VMaGxUYzJqSjBzNmdQbC9vQTFn?=
 =?utf-8?B?RkhtQTNvcGVsQ1dram4yN0dzdVB4THZMZFErT1g3dkphSDdENkZkYWUxREpK?=
 =?utf-8?B?NTBqbFRBUnJrdWdzQU40VWZDOTV3R2FzSW1hRVZHdDVJcXh4SDlxQVZwa3Rr?=
 =?utf-8?B?UUJVZENlWFRicTBXMDJETWdGeERuc0xLaDNKb2xyY0N0QWhrYStrQ0lhVno3?=
 =?utf-8?B?RVVrR2lmdlVURWQwU3o5VHh2T1lac093TDBNUWMwSDFXQkF5T29WRXVERk5O?=
 =?utf-8?B?dUJFZ2FmZVR0Z013bVhqUDVvc2NwSm5rQ29jejlLcXlSOUMyNmNXV08rNE9t?=
 =?utf-8?B?dHRIL015ZDNNUXlaaitMV0FHdU11ZmNyNXBuWGUzejNCQjdKZXh0VDNYWUh2?=
 =?utf-8?B?OU4xdjZaSkFGclljTEJBQVhzaVB1d3dCMUpNTGV1T0JMVStvL0U2dFBiWTFm?=
 =?utf-8?B?N3MyVlZFdXoveldxTTFoaDZuS2Q2WnBzMEd4ZDRQZ1dHUSsvZmhjVVNzdEF3?=
 =?utf-8?B?TmQ4ejJyS0tHWFJNVmVSZFByQURaeTg0K0J1NnduNStnc3cyUXhUK24rckZY?=
 =?utf-8?B?L3J5ZXE0cU1oWGlyb2Q4UUhXckRqeDBySEN1Mmh1M09ET213MDJjYTZtNHlt?=
 =?utf-8?B?R3dtM1lPRHBOSlpQcXBucmpYWlhhZktUdFNDbGxCTkM2aCs5VHRZbTVBNmth?=
 =?utf-8?B?TXFWK0ZsdmllREtVM21HWkwzRjdOVTc0R3Q0R0JKQTJnenk5dVFQWmxVa2RR?=
 =?utf-8?B?VU1JWWhjUkpXVHdlQmkvR1JQYUFwS2tuMWRSVXpLR3VSU29xeVZpdEVQTmt5?=
 =?utf-8?B?bWtJeTZpOTAyNTUxQ0doNjF6WHhpd3JmK0w1MUxQNVoweElzajNOcFVWOXFR?=
 =?utf-8?B?NzJnUlFyQlJZRmNPUTVpYUtqeHZwcmFucFlOOVpyUVRYM0lTejJkSHY2Tm1h?=
 =?utf-8?B?SjVvTldVN3RCdUxEOVZ5Nm9FTEExYXlNVkhQU09sczJ6KzdTQlRKbG1aMllG?=
 =?utf-8?B?QWcvN1l4dnptRmFoMG5UZ2NLaG1qbkNhOFRscU1qeC9UNEpLTDA2cGxXeTBx?=
 =?utf-8?B?Z0F0cTQ0UU1QVXdLUkRZWlFNMlNrc2hLYjVUMGpnRzhYa2lOZk01aldKNVcw?=
 =?utf-8?B?cnRhZS9HUVFPOFJZQ2cxRDBMYXRlY0NSQ1ZveXhEQk9vYnE1aW05S3JKemYx?=
 =?utf-8?B?RWNwZ2U5RzZOeVZpazFBKzJCYnNNbUp2amsrNjNrY0VVbW1LNlV4cmhvVG5N?=
 =?utf-8?B?U0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB6909.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39237145-3b21-4e71-c80b-08dc5ec79a4e
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2024 10:17:35.9793
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: D+wFdx6qn7KM8cz/AmKIne8Od7ZjSTHSpJ/CpiBVzM2kDuXYUFCC+/1Fjs2FJOQB+SrlPqPOSwUSdbkkQP/38tglaQx7DGgVMttFDPSNeE8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4781
X-OriginatorOrg: intel.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240417_031749_462998_A30A2DCD 
X-CRM114-Status: UNSURE (   6.29  )
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

PiBDYW4gc3BkayBlbXVsYXRlIHRoZSB3YXkgbnZtZSBkZXZpY2VzIGV4cG9zZSB0aGVtc2VsdmVz
IGJ1dCBpbiBkaWZmZXJlbnQgcGF0aCBwcmVmaXg/DQoNClNQREsgcmlnaHQgbm93IGNhbm5vdCB1
cGRhdGUgc3lzZnMsIG9ubHkgQ1VTRSBpbiAvZGV2L3NwZGsvIGlzIGF2YWlsYWJsZS4NCmh0dHBz
Oi8vc3Bkay5pby9kb2MvbnZtZS5odG1sDQoNCj5OVk1lIG5hbWVzcGFjZXMgYXJlIGNyZWF0ZWQg
YXMgY2hhcmFjdGVyIGRldmljZXMgYW5kIHRoZWlyIHVzZSBtYXkgYmUgbGltaXRlZCBmb3IgdG9v
bHMgZXhwZWN0aW5nIGJsb2NrIGRldmljZXMuDQo+U3lzZnMgaXMgbm90IHVwZGF0ZWQgYnkgU1BE
Sy4NCj5TUERLIE5WTWUgQ1VTRSBjcmVhdGVzIG5vZGVzIGluICIvZGV2L3NwZGsvIiBkaXJlY3Rv
cnkgdG8gZXhwbGljaXRseSBkaWZmZXJlbnRpYXRlIGZyb20gb3RoZXIgZGV2aWNlcy4gVG9vbHMg
dGhhdCBvbmx5IHNlYXJjaCBpbiB0aGUgIi9kZXYiIGRpcmVjdG9yeSBtaWdodCBub3Qgd29yayB3
aXRoIFNQREsgTlZNZSBDVVNFLg0KDQo=

