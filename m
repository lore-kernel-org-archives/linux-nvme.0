Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C8E7E7716D
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Dec 2024 08:46:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lo+z/eAdOS45rozkX4MES6fgPJo8s2p01FSL/HGQ1KY=; b=zWQ08qWcFy7LzpHjtlnpu1oWWv
	h0oWPK++4L78kJLkyAaHxoASFFzFLi/xwFO2AIy8cPCfB6xdwaDo8zfDHqHMEsVYI5LQHGTVSdiLs
	erki+Ciipw3yGOoRsJ2TRS1EzZYVv7GfYBrIa/cQ+96bjG8lm56t4Wsx1DIdj+lC0pOCzk80x9tlr
	novKoz/C+DFyEXDS8Toevaoc8xEt/IcD0dsOFfXhyjnhJRXBB/rCZn0CnNJV+X/MHDfvsiZZusgDn
	YJHPSUzHcflxETwV6TS0dePTcgfSCb/uf0sF/paJgUAT9PXB8LWky0T1/Cuy6ZNV628HvjY2Z37nc
	tus3Vm4Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tIl1E-0000000Bvvg-37Ii;
	Wed, 04 Dec 2024 08:46:00 +0000
Received: from mgamail.intel.com ([192.198.163.18])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tIl16-0000000BvuE-0eOu
	for linux-nvme@lists.infradead.org;
	Wed, 04 Dec 2024 08:45:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733301952; x=1764837952;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=oN6ALZ+WXF3WOoD380KKvsF/e/UsydnQxVY4e+fMCSk=;
  b=IdPFUxt9TOCWKfRuRI7imHjxNrzjsfT15c9OOn7hq9Wp8rAifRWnCwVd
   BE2/X3cvuHqjcTvbw2tJgn78Ej474omJzGI6s1syKW5j4UNaHk0DWpmP8
   Iamg6qUYhs/LMr+D2IIRJJYvKzdGV4NbfTNAGu3JSKuNm0PvSE83Kc/6l
   3B/2oBx0CYmaW/QOffJStNHp9J+2t1eogHxfbfmyjakYoCeZ294dy+D9B
   +Nl178F5hjsMmF9a48DPSTTqC5e/B2JPlA4QMch8rIIfY0Uwm4xSILmD3
   u+8x6gBjm7ZKXRV9qaKxAF6b35I1uhiZafLdbY3XSVvLD6BRnykcNojDr
   A==;
X-CSE-ConnectionGUID: ioIP5GaLQ2WWcdywZPZgYA==
X-CSE-MsgGUID: aXSPRf20TKqsYZmhFAwROg==
X-IronPort-AV: E=McAfee;i="6700,10204,11275"; a="32915029"
X-IronPort-AV: E=Sophos;i="6.12,207,1728975600"; 
   d="scan'208";a="32915029"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2024 00:45:46 -0800
X-CSE-ConnectionGUID: +B+6sy3JSBWoawTmmbGPyg==
X-CSE-MsgGUID: +BLSRFDSQCSWfrm3I/VeZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,207,1728975600"; 
   d="scan'208";a="94045638"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Dec 2024 00:45:46 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 4 Dec 2024 00:45:46 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 4 Dec 2024 00:45:46 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.49) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 4 Dec 2024 00:45:45 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=khobahzt9FSn4XaYFxXVcSY4hB2rjRCJPnqeH67WOrPyn/iTaGvUh0iWikfea2XZOYer5vFR7yGMYjryRSpFrnGoEvDFJkfUYDhv2A1tIHF/u7pi4ixD45SvgszvInHiyev8ipPvDUt23DtddCCAcW5kl0Mm2tFjt/rvGxS9YFVlbnSPc3p6iaQ28LTKEdlcPAbMwqQhwm/CnlS44QTEwcl8Ryc8qAZVRsA94p/OLEksRqGVqNr0AJV+z9qTtOnJdmP5k0EkLV3O0FQUKSY142J+tch1EatlpJEnsgW34n2ywyitThEKZbTjbn6Suua+tQsqkGtvm/qOVqnQ7m4EJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lo+z/eAdOS45rozkX4MES6fgPJo8s2p01FSL/HGQ1KY=;
 b=o9obkmuXMsqCxwh9Fi+GJ7N0A9vb/e5FQsPIsPLCyemAfPpCSUtkuSRTHYUOa21Js0KIO2FXCuddNxmpoMax/NAntwy899392j6736J+Us4x96JqgjnqUhFZvXdEBikxgq7HofesoUA1gmkaii050JjVkiTkvJ/HtQvXPs1SeTgsX3suNMeeJB0LQcZTAoD+5hqyYgwKDJah6ZHkbFLoz78DOg5x0hgHPQOgzEK/3elTDGsfvJ55aRgg3P4x8DEsb3luiSxJKyDcYSoAuy4+yUIUv9U709B6RCZuvHHEHVXu0dsgqKO6HLVMj1vjEKs9wH18WiV4sVbLm2BSi7TaPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6129.namprd11.prod.outlook.com (2603:10b6:a03:488::12)
 by SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.18; Wed, 4 Dec
 2024 08:45:38 +0000
Received: from SJ1PR11MB6129.namprd11.prod.outlook.com
 ([fe80::21c3:4b36:8cc5:b525]) by SJ1PR11MB6129.namprd11.prod.outlook.com
 ([fe80::21c3:4b36:8cc5:b525%4]) with mapi id 15.20.8230.010; Wed, 4 Dec 2024
 08:45:37 +0000
From: "Borah, Chaitanya Kumar" <chaitanya.kumar.borah@intel.com>
To: Christoph Hellwig <hch@lst.de>, "kbusch@kernel.org" <kbusch@kernel.org>,
	"sagi@grimberg.me" <sagi@grimberg.me>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, "Leon
 Romanovsky" <leon@kernel.org>
Subject: RE: [PATCH] nvme-pci: don't use dma_alloc_noncontiguous with 0 merge
 boundary
Thread-Topic: [PATCH] nvme-pci: don't use dma_alloc_noncontiguous with 0 merge
 boundary
Thread-Index: AQHbReWBD+JCWohHFEmsx2GrEYea9rLVxaWg
Date: Wed, 4 Dec 2024 08:45:37 +0000
Message-ID: <SJ1PR11MB6129C4C0AC5726D65A7A6909B9372@SJ1PR11MB6129.namprd11.prod.outlook.com>
References: <20241204004240.687875-1-hch@lst.de>
In-Reply-To: <20241204004240.687875-1-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6129:EE_|SJ0PR11MB6744:EE_
x-ms-office365-filtering-correlation-id: 755c5d29-fc53-46dd-f631-08dd144006a1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?EODI6Ayd2ixdA35GYFnD614t/E0RhM69PrityXUsaBzrxcARcXPxVPcaNauR?=
 =?us-ascii?Q?GK4BK29kInEp286xrDNeRSe2En+Y64pBo5YcwpxFYp0uKPsqKgTuJ7OqJFvU?=
 =?us-ascii?Q?NzF+WUkO9W7eLPwPcJoX1dMJ5c/LHjTixWhDfbDMehUXZ6wkv564tu5RF76e?=
 =?us-ascii?Q?cKivuZX7e5jh/z8rYkAvnd4MasvmhQdZotLlWDsewgdZHTqK3iYeWNgGnPGs?=
 =?us-ascii?Q?kL1D+UnHXRqiyvCdckwEIo3LdEd4FIgbjmgIg9iBkojHkO1TTE7brcb686KR?=
 =?us-ascii?Q?pGgp9i5E3FcXJsDV0SdDMGfboiwxTLznGEouPLG4KtNzjIeUjNIR/qV30F0J?=
 =?us-ascii?Q?liYZJ/wY5WVXRxonB30MxTm39G1YtgBrRtEqQIz6DKQ71EktD7lEMad2IgfB?=
 =?us-ascii?Q?r2Kj95xVR8jb0/MffNCKKS/f7RpoGx8S6CEKRQXm3wVPIu8DDyVWOIKaNUh/?=
 =?us-ascii?Q?iyPhRDo8SMPvFGGFm9GYKa9qsf1wiTY5MoAEcYyhxR35+Sn8GTTOhOqtKL94?=
 =?us-ascii?Q?4zjK0kMNqCSM2xAh20LtMK5s06LpA8rxnn+ZVkjRxaLrMtB8OBRydjobn1yd?=
 =?us-ascii?Q?VulAzPtahtaC1kCSWvdyHOxndvAfR3k4genzy7l+KRQuoSUn17zZM1g6poDv?=
 =?us-ascii?Q?wPnGKZrweXxGf3VBiaIE8bg6BXeX1q9XBhEtPSWRd8N3xZeo9xP3uJ8MGY6s?=
 =?us-ascii?Q?JdJrP02XDb51yJ4yIfKYuVLqqxvDK+tBoNa/Jwv+WZ/dNpZBWOOJwh57PVNE?=
 =?us-ascii?Q?UwMceewbivFYpjz8HbKBBIrJmCeoGY96280CIY18WnHVMAwcqPrxys1zMG+T?=
 =?us-ascii?Q?5Htzu/PxKGxQf/Fqyo5izIGJBzy6zcZLYkA2OOSF9Rm4EcRoF1avbKd23rgB?=
 =?us-ascii?Q?AdSwhR0CnttMxIwFvXQ9FUqyoEmjw1NithKkPVX1mBP5cuc56UbuIzMPj2zw?=
 =?us-ascii?Q?zgkSEjJKx4vb0ofkmvAc7K0G/+D03GheYNytQCF6C2D7WjWfclYgHvsSaxjY?=
 =?us-ascii?Q?OvmdQtOUPSuZvOf/KR40yFO59Pbx1THWsXXn7Gea+eIIuwxKI5p5IqKqgu3P?=
 =?us-ascii?Q?+vNN/TGJdowg8HviLfTK21urSaPJL5ggWNRZDSRAg/NKTV7Otr2d8w/CQiTq?=
 =?us-ascii?Q?VBDN3xgsHU55DVnHXStx+X4Oy465JnIaozqFAHD+oEq2nhX4kCSChu+ETa78?=
 =?us-ascii?Q?UJuJATfcDUIVh4pF143lmtnhQZ1+sq+At2fSpoNO0NUQnlLn/Osm2ezrn2PC?=
 =?us-ascii?Q?pN31ywgAivo4WAforI2UZvhBc6eJjXvopn+EM9eW/273HJngQCj92ltzQxj4?=
 =?us-ascii?Q?wCOWlvlMUfrPe6PNwYJ0CKHxftTjC0CbA31XXriLfOgYwlsNSTsrABRz29nE?=
 =?us-ascii?Q?3BNTpHJ45OosUH0wmr/8KcYhe3eaYiGfhJXNF4ccbGhlO/zISA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6129.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?pYYN2Rd11NSsnMhrIrCAvyLh1zlCY8OwZgPEBZfaGlb5DI14e+XrscHJiHWW?=
 =?us-ascii?Q?0Uif/a0VpbQqgHbdRa1Ga4N/VvBJEEXso3U94An3wa1EA0rZ0tcYzbFeZ9Do?=
 =?us-ascii?Q?qqe4vPkWJ7xMhfbSl1DODOVU2Qjl9Ii2YVUu7eiKDZFT6tUbFXVCN5Kd15aK?=
 =?us-ascii?Q?H1bHHVb5+A3S5Oywizm+R6JKVWFs77/5m6O/bSnkkuujNVBbeqG8NVyuk1CX?=
 =?us-ascii?Q?JjIJ8ikev5HY2gS8fHbbADhx6qxP2e5DCGgM9M52bePy91EAmqcuc7nz6wE2?=
 =?us-ascii?Q?VrpeO88V/rzOBfqsolQREdioxsfw0FhCWqUF48WAbhXMWQABnCxoBO1tIOFD?=
 =?us-ascii?Q?XRPn+lP8L+OHkt/twow0eWX1zAzRs/gq22BscZlkasKITfjJjahp2ih2hsd7?=
 =?us-ascii?Q?OZ6CWgytj170SHTm7x5arWlCZ1SXdfDUzAhmg/AhUdP++n+k7z/Wy5qRJLRT?=
 =?us-ascii?Q?UJj5UbdCZQV/3us2p84ubQY5VSgqP521Uy53gzFQrEL6WZBDZvx3pDu+rMHj?=
 =?us-ascii?Q?jgpBbkXpLsIwOg58oWN3l/wUQY1l22yvn3E1niT0pO9pDRC34MEdxlUI/LHB?=
 =?us-ascii?Q?K+l077UzXLUqNLji+3pDnTh/o7zI3SBgK0DxdmH6ZO8NuyZaVf9jDJOxt3Jo?=
 =?us-ascii?Q?AEh+LqL7C4Aqv/odTfAqgNlVgLgYVWw/WL6SgQd8BbdPM+uNfiKkYaDBOLcw?=
 =?us-ascii?Q?vS7nSnWyrt8Wzyb2bljlKVuuHn4PIXfev/BmwBKN3/cCPQrndsm3sV4wvCko?=
 =?us-ascii?Q?LC0+h16xVehp2t2xFd2fcFt7XMmRTy/2GmODR3CHLQvDJBAYkvmKJcTBnwd4?=
 =?us-ascii?Q?0fYanMcRFbUqOGpk2FkWso3TE2ZkD5QqAp+Z7+81cKzFYSHBK+PAw9QCWSzo?=
 =?us-ascii?Q?sKYqdh/mL88MW7Jz4o68CM8aNqu2TkycdMoZLtxf2E4HqSrxtJTZjRKtYFI4?=
 =?us-ascii?Q?SOfIe/f6gYuEszt6IhM0y5pQSA11/0tScq8SxJfIkNWVh+cBdGTv1VlR7iDz?=
 =?us-ascii?Q?qXoneyvHqu6vbULqn2WVOnOdvQhG1KzLgnCW6i/Titegf/+jdt5s0AuHoo0Z?=
 =?us-ascii?Q?5p0mT+dzqT34xrtQxnWl8OewZShzffKEvcuwQP/YjJgeEifSUEXCA6YdKrJQ?=
 =?us-ascii?Q?jk+xJeD8RncFfo/JV7sne/MqTitTSXvjYzaurcFjyr9DtB4r+0uBHG1N3yZI?=
 =?us-ascii?Q?IAp8o4aTxJlpPL7bhkQJ5kKjBoDyIXRBHTmruF38yxGkCFkGF9Fi89HboyIm?=
 =?us-ascii?Q?V87T3VBZfE3INpKMEq0zh64m4TQqGespV06nU7ROGJICcw/Iw+9jAPwQjREI?=
 =?us-ascii?Q?QhnWOZxF8Q6Ds5QQ3r+vmXriRqyJqI9Lb8xPUI5aIhHMvEB+vWW9aV72+1Gh?=
 =?us-ascii?Q?Rb0DtrzFg+TtC06ApanjLJOZ3wgPL9g9cvdiqXqS8oCxd534NAHANrVan10L?=
 =?us-ascii?Q?eDhuLqb1qxehShsMwlLFXbqgkUmzXbMOqzOnsbooAd3B8NpvT6cVivQAxSsh?=
 =?us-ascii?Q?N+bAjLHk8QQ9UvQU9A86vuyN7oGrgx226fWz+d3xB/NCm7wXsLGzouh1gBp2?=
 =?us-ascii?Q?VGCmnO/OqNCJD0xx0FrOtCmzThCZxBu/m/3sFL1g2gWiIfI90S4gaLjklm1f?=
 =?us-ascii?Q?iQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6129.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 755c5d29-fc53-46dd-f631-08dd144006a1
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Dec 2024 08:45:37.8001
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 13bVNLnLuW/hindiKwo7sK3Gtz74OhAeRU45u229YM2Y/hFZ5LPgGQ57Y3p9bi2EjjGg4m+EDCwP+lGV/XZwxyDHcKY/CBDa5cT59xb6tWc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB6744
X-OriginatorOrg: intel.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241204_004552_233572_67A7CDCE 
X-CRM114-Status: GOOD (  23.05  )
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



> -----Original Message-----
> From: Christoph Hellwig <hch@lst.de>
> Sent: Wednesday, December 4, 2024 6:13 AM
> To: kbusch@kernel.org; sagi@grimberg.me
> Cc: linux-nvme@lists.infradead.org; Leon Romanovsky <leon@kernel.org>;
> Borah, Chaitanya Kumar <chaitanya.kumar.borah@intel.com>
> Subject: [PATCH] nvme-pci: don't use dma_alloc_noncontiguous with 0 merge
> boundary
>=20
> Only call into nvme_alloc_host_mem_single which uses
> dma_alloc_noncontiguous when there is non-null dma merge boundary.
> Without this we'll call into dma_alloc_noncontiguous for device using dma=
-
> direct, which can work fine as long as the preferred size is below the
> MAX_ORDER of the page allocator, but blows up with a warning if it is too
> large.
>=20
> Fixes: 63a5c7a4b4c4 ("nvme-pci: use dma_alloc_noncontigous if possible")
> Reported-by: Leon Romanovsky <leon@kernel.org>
> Reported-by: Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>
> Signed-off-by: Christoph Hellwig <hch@lst.de>


Tested-by: Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>

> ---
>  drivers/nvme/host/pci.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c index
> 4c644bb7f069..778f124c2e21 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -2172,6 +2172,7 @@ static int nvme_alloc_host_mem_multi(struct
> nvme_dev *dev, u64 preferred,
>=20
>  static int nvme_alloc_host_mem(struct nvme_dev *dev, u64 min, u64
> preferred)  {
> +	unsigned long dma_merge_moundary =3D
> dma_get_merge_boundary(dev->dev);
>  	u64 min_chunk =3D min_t(u64, preferred, PAGE_SIZE *
> MAX_ORDER_NR_PAGES);
>  	u64 hmminds =3D max_t(u32, dev->ctrl.hmminds * 4096, PAGE_SIZE *
> 2);
>  	u64 chunk_size;
> @@ -2180,7 +2181,7 @@ static int nvme_alloc_host_mem(struct nvme_dev
> *dev, u64 min, u64 preferred)
>  	 * If there is an IOMMU that can merge pages, try a virtually
>  	 * non-contiguous allocation for a single segment first.
>  	 */
> -	if (!(PAGE_SIZE & dma_get_merge_boundary(dev->dev))) {
> +	if (dma_merge_moundary && (PAGE_SIZE & dma_merge_moundary)
> =3D=3D 0) {
>  		if (!nvme_alloc_host_mem_single(dev, preferred))
>  			return 0;
>  	}
> --
> 2.45.2


