Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADF26C624A4
	for <linux-nvme@archiver.kernel.org>; Thu,  3 Sep 2026 12:57:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:
	Content-Type:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=igrdGo5lM7xfrgH/nYA4FSoanceeA3T4XoX89kVztqY=; b=bTGeMrKRenENwi8VNq1VSGXBUo
	7M2g6COz3jtEBjyKWFKO8jVsI78OPNCfKkpqFnW8yrlBFmOXJCO36ToAr0bMeoIiVPVNjuRvstB4s
	dDOYYZwfXW6vc6Z6/YZI6bayg+jXH3K+vCXPAKXOOhCimBqIVxPfeARlSCz6KiaefS4oIXMb381aA
	DL/GMeD2jpfgHoytziqRsRp+9yN9/FGdc7EKiinWOo/OYSJBk4RCJv2IvqjchBWS9hMasz3aOwpb/
	UNgW0cUsMM8H+MGxLM+u6YXw5OGBRw+fqZcaVnQt+jX4u+FfxhZzXExN9KAqcQt4v5hGeNqx/RfRl
	zbfKLguA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x270j-0000000HMZH-320z;
	Thu, 03 Sep 2026 12:57:45 +0000
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x270d-0000000HMYl-15tZ
	for linux-nvme@lists.infradead.org;
	Thu, 03 Sep 2026 12:57:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1788440259; x=1819976259;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Cmp5Kwz9hxiNlPJmvBQe0+IeAYjIrbQAazaYN9fgsS8=;
  b=FHOZcUJRwtJ0Sr2vz2sXfbcdR0JXKElwlXsH241jymoL7V2ibYn45t5d
   A9vy7fnhf+QAq+gjmxb0Ky5vHWTkgRG1/IlHvZ07f2a9O9x3kb4KsqvQ1
   +jp7jvFE8OWSvwSbeCXVFBDFPdLO8+N+2dGFXXL47empQK+K9qy7wC9rH
   MB08gthUSBolRj/NzBmADAOqzLvjiHs5mVVypG3PnuJDpsA5idIKxgoVo
   /05vEKCtGaLhbFSNOUgenvRyGhyWRCVI4beCuzjIotiUVBEDYkBC+2xsf
   5rGTwPLuO53pfSQrTBrKauV4mwAmTyG/vHM9RHXXSIpMkI7txoS7s2Zgc
   g==;
X-CSE-ConnectionGUID: 3bmK+VmDQqeb7X2eKFSICQ==
X-CSE-MsgGUID: K/MozBEQTbaRb67k+mwckA==
X-IronPort-AV: E=Sophos;i="6.25,260,1779120000"; 
   d="scan'208";a="154874139"
Received: from mail-northcentralusazon11012060.outbound.protection.outlook.com (HELO CH5PR02CU005.outbound.protection.outlook.com) ([40.107.200.60])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 03 Sep 2026 20:57:38 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a0RQBH0YcCsM87+VWYvFcUJDRr4/gf/XZ1XWwsxqnZOvMxMQbQpWwcC2FlRQ2MWRBger1QBm4wLf2uTpGyJLf9hF/8xEaZp2FuGUoDuKDetlZGR2+MbxG0SBKGMmFlKT9ReXf/OGAbHKM6RsCq1aLfh5X5Cxx0OXo9fwD8bcaVczoOR+RrxRgLwxWRffahbN4OFMHxobPqBTwI4SOZpU7ir3ZUgybuQtHeGuZlry16n9Bq6/SZAu3oXHPqIf1AlRhp+S0euyJhQMgLBEuvMz7DO6aaQrbk30tC5DoBkfa9HUbSypQ04/CJQx1ox4sX3HWheOMFPqakozDm4kUZebSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=igrdGo5lM7xfrgH/nYA4FSoanceeA3T4XoX89kVztqY=;
 b=XVD6TMmyPSPCioeCNDwPTsH5J1FxbH2QlehgRzMohq/vxyqFRnAWU2n8uksKxi4ZwEXH5AHYWfl13ojahHifjeyyo8XP3G6zWKPfUZ6DMWwdTolzJUHNtaLEx9A85qrcA5CAR+mGjMquZ3XsLp8jGNXLxdITcnjCD4eptR6oSlF9P8nNPYQCuK+mooT0IhU8puENQkS86IXXQKCE7cW4kYUQOJeq2rMm0v0xFx+2vC6dVAZI8NaUUmN4XNUJTWlZVdv9Erzb4HEK7u8sm76xqKUpSTjQWCJ/SN/Y2GVuIvKjHL29JEugDdkbOp2g8flWZ9pI59w2mE2nV5Dx69zvsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=igrdGo5lM7xfrgH/nYA4FSoanceeA3T4XoX89kVztqY=;
 b=eF+jObWWFjCbwi/VUygvaVCYFAjjYsZbNZsa0fPd2UjyB9psZBqY8LRrpiW35fK3kBsXGlYlPRP4YdHPMRWNTAUOQ6qV0HDYb/o6vjXMsHERdcQ2o1Mo122QuwpSyreUBMrax85cRKSyz8OIb3sw5RPC1Du3zk9mOYehN6zec5I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
Received: from SA1PR04MB10065.namprd04.prod.outlook.com
 (2603:10b6:806:4dd::14) by LV2PR04MB994088.namprd04.prod.outlook.com
 (2603:10b6:408:426::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.11; Thu, 3 Sep
 2026 12:57:36 +0000
Received: from SA1PR04MB10065.namprd04.prod.outlook.com
 ([fe80::9b98:bf8a:b0b1:ef85]) by SA1PR04MB10065.namprd04.prod.outlook.com
 ([fe80::9b98:bf8a:b0b1:ef85%4]) with mapi id 15.21.0360.008; Thu, 3 Sep 2026
 12:57:36 +0000
Date: Thu, 3 Sep 2026 21:57:32 +0900
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-nvme@lists.infradead.org
Cc: Daniel Wagner <dwagner@suse.de>
Subject: Re: [PATCH blktests] common/nvme: do not truncate FULL file at nvme
 disconnect
Message-ID: <apluqlTcYccjkIF2@shinhome>
References: <20260828082721.2828731-1-shinichiro.kawasaki@wdc.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260828082721.2828731-1-shinichiro.kawasaki@wdc.com>
X-ClientProxiedBy: TY6P301CA0018.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:3bf::19) To SA1PR04MB10065.namprd04.prod.outlook.com
 (2603:10b6:806:4dd::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR04MB10065:EE_|LV2PR04MB994088:EE_
X-MS-Office365-Filtering-Correlation-Id: 20e38b19-bad5-4e5a-5b94-08df09baedc7
WDCIPOUTBOUND: EOP-TRUE
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|23010399003|19092799006|1800799024|366016|6133799003|10067099003|56012099006|22082099003|18002099003|11063799006|3023799007;
X-Microsoft-Antispam-Message-Info: CNrJ0+pUnsmH9BbwZd2qPXuLvmlfib0PosaoKefifBwxmexxlAAnH/G44ig4ncOcO2eZSJCpCogzA/tf+WLoNtUQ4v/Wdx8uE83infJDmQNFVXxtWCaqh3NRggBHuigt1vgwBkEODPZHqidKFKrfoDC3Mk2p/dh/WJQ2MJRLCTUqKpG9GdtIUaComh0aJYXc8h7otbsU99ppFzS3LRzzKesCU/nXJLnLgF3MnCOV0CzWbODYQH3DGPE+TZH2QAXYguiqUgv2lmUWyclHw5N6Y7+AUnmyk8iZe8OJJHrX/qMBcM2wAE4THAtImluaoStUvICCPQI+ih/lJ5J9B3oQpMkmHJobI5GuLxf67qLp8vYtcVL+dTPQbWuj/B1fTSwlaJ3OBtvL8bjjOmNi6SFBQiO1rGi2zfwclwc6gpfMIcwT2oimiIbaYhcqxb/XGKUpW59M+rhfxR2pjMGZIHNe+7VIPhSaa/U+l+7qXujLkVPO4Dz1zHZf2/MoZ+tXzkq89Y1jqQM7VvP8WrhfA9vVURcqJTIqMhaVKU9UerQtd40w+s6w7BJAOQDkjfjaCahcyy+3s+oUwdkzbeIGsG8qEk9rzOAMHB9SQAFqO86M7bPyAPGjyL8tqCjcPX9USws0itWhhf5wZ6FDbDuVGOHYvc2Dou1Y8KQmZEN7SbaC9rU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR04MB10065.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(19092799006)(1800799024)(366016)(6133799003)(10067099003)(56012099006)(22082099003)(18002099003)(11063799006)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?e9mDX5JH4668VjDyzzC4i1lIFOp3gFCb69Ly5hotxRfKhgj57L5GnedX3DXw?=
 =?us-ascii?Q?VjNYeJ2onaMj2nNDz2Zvj5U60eZAVULokRnxW+0DfcVDIjnkVyzAzpJ1VnTm?=
 =?us-ascii?Q?uYmHWrR476iE185krLfUf4NjhnGdG3u3UnWsA/n65ddv5E18c9cPs8RwzdMw?=
 =?us-ascii?Q?iaFwjdpX754tDQ8ao5yYdhvdRlkel2nnF8ZGqFAzJQNl04emDkIQErpwaRpX?=
 =?us-ascii?Q?4fhQt2PMBKCfwuh7RLbz4+TEMqZ+r+4zsW1t0cxaCHCeepsFLemhnqVQGXfV?=
 =?us-ascii?Q?ykGAwS3gGmy5P/HBn9GdZh56sLNJqAg0JnInjbmpQiUXMZVAIoxbIqWWzLSY?=
 =?us-ascii?Q?B8POw4MdVqjhLWaLLl1YFGDkORZBjks2+JiskcXuUEH7uJDDi301vixqnTKP?=
 =?us-ascii?Q?glvziqlIe2xvv8ckmJ8q3K2LnKwjayjvOkAFTIAEJwDWFS81Z9urXGq7EvEd?=
 =?us-ascii?Q?kslyeYKSI/oiSDhXCeQWPrsgQrhWyP/GIoxHV1z1XwUe2EFmUIqVNZTnexrr?=
 =?us-ascii?Q?gYX7lqrk1gm1M0cO2/h5/quCpolM2PBIchQrT+182sTQ4/dz0+xIENILedue?=
 =?us-ascii?Q?CMfwN2dPaxVrRCV6qWlRIti207OEGi4UVp4b8MkEheuOrE8gcoJGmtlQZ6r1?=
 =?us-ascii?Q?781/R2MT6iQIm+I+scRNhnjeXxIx8QDcakxHHwDmS6Y6AQPFexcLe5bszVxG?=
 =?us-ascii?Q?aLUtqCWdgvfOK9vmNn2S54nBZFI1C9uzRK36GsnLnO7mORILeUqq+3S99dN0?=
 =?us-ascii?Q?Xc60AsbF4b0HENs76DA2/ZX/2Tjs7httx9ed5ekFHCUk7D92i9sIR6Tb2p7m?=
 =?us-ascii?Q?uulLHjNCFv5i0ezqlqoPO4X072vMch9eMGVFjPR9mNKdjrjmsG4vQxhx8EDH?=
 =?us-ascii?Q?6A8WohYY0P07wAmIFS4al74zb/omFjuOuYNChYWBiZnJ14dEDKfQH6zITJHl?=
 =?us-ascii?Q?g+WCPx+mlu4ai1AhjNSr38PsBIVGrCeAQhRYKADI5xhxZ0EzaBBJEUHDKMBD?=
 =?us-ascii?Q?3zMKK9J3KZxsXxJ3Zw+bX0ah9qmuKgMQxMuQEsitdtkLdu4Rd0bwxTmzW/Ur?=
 =?us-ascii?Q?/+v/fH2c5xeJ0o9BKh2U4N9M64Sk3CmvJjizel/rODHMCWt+tuYQYzWBJ+bI?=
 =?us-ascii?Q?3M9QBjrUKYqsSCmpEzn6jvS7/6nHv3hBdzbjUQZj9gbJObWPrmN+mXyx3tZN?=
 =?us-ascii?Q?2UDdNEVwm6m0sBsTonPpwHN906ez3bxoI+8kAlavNndgUowDK+6eYVtDvw2M?=
 =?us-ascii?Q?EK02FWTCBK82ZMBsvO/qfIPie4DgJGDQblaucNiltGTBlGkNnolD2Kav/+g8?=
 =?us-ascii?Q?S5uSnh1eOl4eps/fLvVVPs1rRvU6E/Z3TdevBeWT51EGnxlVMkb8CoRz5frX?=
 =?us-ascii?Q?H3nUQAB8vP01Y3/tjBENhOX722OH6hqgcQGhL/7pVBLjgWtRSlCjv8v/7dVh?=
 =?us-ascii?Q?Ng8zg+8KqEsP+EojVpsfCzqKQSHWdbt+pONEsr6SVpwddAY1rofU8VBQWKxK?=
 =?us-ascii?Q?2eDaLArF6D4BAFEJgc5stVo02bWmLHvZG/CbcN8baJPpZE01ETxIDzvTQ9nu?=
 =?us-ascii?Q?SKcEZkcn2puyR2DKQ7Qo+gBNfdjo/7kn3RZy/SjITrddUigeXN6MsQjbRkNV?=
 =?us-ascii?Q?GXZ06zvyBNAm/lO4tW6Ubwo6gCLNkDlDxlk682PoLglkHSTY3cy/pgInjyla?=
 =?us-ascii?Q?2suOLnQus9iXDyH8FmvGoKpaRilEnLj1vGm12qhIFJY5fxyuhO9r+WSCEPRo?=
 =?us-ascii?Q?S4Y2GG2cWU4CoPKBvCfYn3ZbyKaIoHw=3D?=
X-Exchange-RoutingPolicyChecked: UiGtJVeikqeJNCmGHovXQxqR28elJsFQHCLWbfZqYfXnqdaTodm19DhGWqQmmtdrXobhAEN7jiUW7Ei7AE+C35NvBgF1MXuv64UMFh/TYwRUAJh8MAL+Is/db/0RN3/U0Z3t2ibCaGcLf5gwvZoIOvIrlvim6CGnjcPfyxXgayywQu8CcsHBcnjnPI0E4zuzjlvJpJkl+11neLUVZoDko73XZTV4fPkWgXe8EjNBti9psHdXOHFZHO3OsMXKFJ7akf0MATEWd1DUF7q4aRzPBPXtAWQDI8uADRlmZZJ/VT0ot2p6FrwWxKoC3XWSxtBvWQgbfT0BUQFmlx3s5U188g==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: t19YePuibXS8F6zt2qcqUFJvzh/Ce30+4XBuchxzyb6JqGHbUAkkHyV+39ql0E/k8uHSJwe+djfsvmUGMnUTwvqi9JtJzqtvZGX/sK8pLzPlCTUYPPv9bWr+nxqTTBwD2XVCls6pjfkAJPOO1zvQZvl1x7V3xxlE6TVnsw0Ow+qVCUdfO4qDOYM9Lmh04X2q87jw4+SUv/Si+ZccRosvTzkX+puTFOmJWbLZNHTuy3ZFig4ECb+IH4VHv0xQNPRzCtla2KALPc1glEKVbIX4GryJ1KGFErYIkhgAzpfzezD2SQ1xda0JFuQbTpxco4AinYYl9eFaQOr4mFh8QhUl9zjKmxdbL2MYKmUOi4OmNrG4aUYohaLG39PYIR5v7UGeStbpkE+QQw8Jqbcwii/w1Pi8loDv6d/4fykEXcXVBoNiC/DMm7WYNLDagruEfGC/mGnlZ3niWsKGYwrVLvSCVQGHShc1wwbmDCV/4bYnjFeluhShmJ5RKv/2fvgZn+xclCcMa3616cZNH3KmhnwucsaXMpL5kKRrOTsABBm5Ok3BwmqgrElmX4HjN0zTOAc88AEktgYqp18zjq4W07yESiC15E5HmqDJQ/KwNI4C066NdU2JuGmQgAO7Cx7oT5SY
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20e38b19-bad5-4e5a-5b94-08df09baedc7
X-MS-Exchange-CrossTenant-AuthSource: SA1PR04MB10065.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2026 12:57:36.8509
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SBa3OvM6QRiimYwntVfEUs+3oK7TAR+Sf/UDA+uXhcsC9ZymlUMTR150D0OUCG57HZcTZfPSK0iNH26oU/LfqoSyBnCgv9OfQF2ZbMgFtu8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR04MB994088
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260903_055739_309547_E6A7DF58 
X-CRM114-Status: GOOD (  11.49  )
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

On Aug 28, 2026 / 17:27, Shin'ichiro Kawasaki wrote:
> Commit df7cf50409ce ("nvme: rely on nvme-cli status code") reworked the
> nvme-cli command error handling. As part of that change, the 'nvme
> disconnect' commands in _nvme_disconnect_ctrl() and
> _nvme_disconnect_subsys() were made to record their output in the FULL
> file using the '&>' redirect operator. However, '&>' truncates the file
> and so overwrites its existing content, wiping out the logs that each
> test case had already left in the FULL file.
> 
> Use the '&>>' operator instead, which appends the command output while
> preserving the existing FULL file content.
> 
> Fixes: df7cf50409ce ("nvme: rely on nvme-cli status code")
> Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>

FYI, I applied the patch.

