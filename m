Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25EB1CA5FB3
	for <linux-nvme@archiver.kernel.org>; Thu,  1 Oct 2026 05:56:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:
	Content-Type:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+mxY0ocRqhq+jPWAYX6/Qp9n/kQLpyxgiHNL30/y7HI=; b=3sLLE4tDsR28h8ujK6evgnjnA7
	In2X5j7vH7dH5WjEZ4YzoB8H86edul/i+d65MLDYOSBBFjZx12RkkzRVWXUX4YcN6OfYjOa50KPzK
	mTI/AHYBnfAEkAaLE3DBBlexCyjqpr/jJCfUGpPEiyKo/uRwzjnYf+1t//9gVD0za1WPoM3VD4mF+
	78SlwYf+fdCU8syhLYH+4hOfGGnII3sTBf30wnBczd7ct614BZbqdqkSlZu/vfQzSVjJqIvpRjbpl
	3jvhCfAUlrH0XEXdgbQ9bqmLKPVnp+j/mOJ6hgLPQ6RgaKgrytJ3PKLffKob3B1i35sOpuVpNNaaT
	lodIZjmA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xC9ly-00000007qoI-00jq;
	Thu, 01 Oct 2026 05:56:02 +0000
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xC9lw-00000007qno-0019
	for linux-nvme@lists.infradead.org;
	Thu, 01 Oct 2026 05:56:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1790834165; x=1822370165;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=0fulaGAkDG7WKiVIaeUlN28J8h6w/IOPfZHaS89wEE0=;
  b=CFZQvsszzPPGeuNqnBO8eJwB0GBguBfziQrvg1Gjfe/ip6FWBV0GCRIU
   gdq58rIF9rMUqjBC74931dph27QkPFKplIXSiOEopuI47CAH7aBCtjJay
   e6N96Fnn9N3RrSavS4CrRVwijTPD/jk4aiim7MECB1VYculCPP7O5vh0Y
   oCmPEWo5Jc4dZYI5Zcix44tlqnzUKNFq+RorhmfUpZvi0y6y7WA0syEBM
   zvadyp/QT/TqQCc8skRtlBhTDjgZQW+rxgvbWPMNiNVWJUXFpNOydnnUw
   +LGXe0+0ygWEZgGl9EBFuhm0la4NkmMAwI8loUQH7M5PVQfDQllTSaE8k
   g==;
X-CSE-ConnectionGUID: aoP66wsZSHu7IZLipWsTjg==
X-CSE-MsgGUID: cAtkIUNKQSaRBYQj9ppRnA==
X-IronPort-AV: E=Sophos;i="6.27,134,1786982400"; 
   d="scan'208";a="156864738"
Received: from mail-eastus2azon11011019.outbound.protection.outlook.com (HELO BN8PR05CU002.outbound.protection.outlook.com) ([52.101.57.19])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 01 Oct 2026 13:56:01 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X0vt0j4SY77AH15yaoSQqIVXPY1nAycILrccD+ib5PEzE1xonXQ0mGVlZj5nT1W8hNtiS8H0KcauqPXkrVWY/v8DWWu/yJEUB7XAgdcXuFdVf2OaqnNA1QqevRsGumbMTcp1WqYiHWxdcRRlt3w45HY+LcW+//NL8ipmEWI0Nibbz6Z6rBYBuuQ3hyCVMEyAbdhjhOpIDArsufJ5xPxDm1LuH20evLoldL30d7SQvru14nGo73DSJK5GmLHWGmcKk6hqd5vP/m+8+fOxHyFJ0eYnn4vAAUjW6B26on4fHw+Y5O6bgCqLrcHN0q6kgkhU5P37v7KdQ4aCPJElq78m3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+mxY0ocRqhq+jPWAYX6/Qp9n/kQLpyxgiHNL30/y7HI=;
 b=rVVRig0J1bmK13RXmjDKTPQ9Kz/GAOlz3WOMBqnu9sUmdJkw2YVH0qVfG3MoE5LX/r+nTd3E+lBvftOWURMx3H5sPXruvSHpMNUXWkheRBe5O/Cam2JwHkKV4j+GwHp3QHxnTgxX35+ei+lLZiMMBgfhKSvcZ40yh2g9KhtXjicxbYQjx8LuzsDSFVyPJruBT3fNSqGvuVK1Fqqt6yGH8CUg9K6oCM2MLdWSAmVUsiTdF1+B3OnzIodCCsGXL4CKqXwS/uWb6E6G0jB4BXjsUA1ZZ00d1Ej9joktxAGpidzuVLJFlVHZsnBTLJDuyAWPpevqW4NqLW9TSx051t8fyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+mxY0ocRqhq+jPWAYX6/Qp9n/kQLpyxgiHNL30/y7HI=;
 b=etzcZr78EhgAnPNEm1oWqMBCGwam3M5VOl8QcfaOy+x5iPLdBfnVh7OES532imAZghZR/J9bBs37JHFQ+TvcbIQN8UHQ9bzHVF1ZvFhaQ06qvdh7Slai68JWzRrZ6BR63WQtA1LJFqcmFpd8KJ3ddcwe6l3LFJe4CxBpj82J5hs=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
Received: from SA1PR04MB10065.namprd04.prod.outlook.com
 (2603:10b6:806:4dd::14) by BY5PR04MB6504.namprd04.prod.outlook.com
 (2603:10b6:a03:1d2::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Thu, 1 Oct
 2026 05:55:53 +0000
Received: from SA1PR04MB10065.namprd04.prod.outlook.com
 ([fe80::9b98:bf8a:b0b1:ef85]) by SA1PR04MB10065.namprd04.prod.outlook.com
 ([fe80::9b98:bf8a:b0b1:ef85%5]) with mapi id 15.21.0472.015; Thu, 1 Oct 2026
 05:55:53 +0000
Date: Thu, 1 Oct 2026 07:55:45 +0200
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: hch@lst.de, kbusch@kernel.org, sagi@grimberg.me, kch@nvidia.com, 
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, gjoyce@linux.ibm.com
Subject: Re: [PATCH v2 1/2] nvmet: defer setting ns->enabled to false in
 nvmet_ns_disable()
Message-ID: <ar30Q5H1fuyFtDwM@shinmob>
References: <20260918162736.802665-1-nilay@linux.ibm.com>
 <20260918162736.802665-2-nilay@linux.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260918162736.802665-2-nilay@linux.ibm.com>
X-ClientProxiedBy: VI1P189CA0026.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:802:2a::39) To SA1PR04MB10065.namprd04.prod.outlook.com
 (2603:10b6:806:4dd::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR04MB10065:EE_|BY5PR04MB6504:EE_
X-MS-Office365-Filtering-Correlation-Id: 0489d88e-5bea-4427-d26f-08df1f80a754
WDCIPOUTBOUND: EOP-TRUE
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|19092799006|6133799003|22082099003|18002099003|10067099003|4143699003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: TV1KDt9lp3811BKYZanGaX5olSv/kJrlH+OwvbgJGWYQQNJb9YFeL2S+9c0aO67awLLt15TEVcXsU6K4gBseV6uGDfWh/C+dFMq1rED9cQUFDJpTdtZRNWmYoZwm7l7jLO21zC05lyxsxcqpBVxApO4v+h8IuhV4+DLe7zVnTpuJYcNKLkOmvWVMABf5yCFQv+gqBJ1tJmzJ4nkTU0Sa+Dj/wWq7QQARsw/arfuW/G8aJ0mKJP40R7HoA96nlCeIQb0eYbESOKYKJ5KqznGiRf22Im0UjszZBUiFycSe+xQ4q6FWC3jlo/RDFwypKZqdtSyi30i3eJbPe4bIzihsTZcNF/Orj/96ock2jz3gCASu/kaHdik1aaVQL8oilLBXH5f7SatraG6Pza7qnoToTq0RvA4EpIaBTFVfT4JBflBc0d9HBq7bKlBJAuNcIDXmFqLsd5ecg7uo0uSA5sOMZ1BVVoU52iQ3nJo+RAO/f81OskX7M81eqPxfQ6TcoAXMgGGHohPbj7GmnuvTtptOJokpaOvB/1mMxDL5g3ToDKvtiK7VuTDabUGJqkItPkW4GHkDY9KA09WMHHtdTN7XbG4Z3vJK+6OMLClbNxdQasazYdOw8JWnPXu6IcV235VdGoEQd0YQUOOTmaLJC4OMEafcuvYOHzqglgusAuKdYCY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR04MB10065.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(19092799006)(6133799003)(22082099003)(18002099003)(10067099003)(4143699003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?O/dV4Kcfgj4EwYC00MEVntgxVsd5YKobK8HwaxmgDv4FG0GPlMsZ9135LomC?=
 =?us-ascii?Q?fdJIq/TqqNjjr4TlWYJmA/TFXLEp4WLct1xYJ6OEWywra8MO0F8Tp9iNvU8k?=
 =?us-ascii?Q?agkKmVqe6Axl1ieU/cOT9K156/J8JMv6OrmXFhiEoHBfZfm1Mmscq6HfSWWV?=
 =?us-ascii?Q?LSPaLi2pOsnQMGldWKeIN0Q02UvdmxVRuJD7mnBlIAuuTqaskhJJ5P91hlNp?=
 =?us-ascii?Q?k2jcRwYyRidiFe3yDQd6u4aqa5txXzTgm0E0C85qHvyGQV2GNpkIgRXCm6Z1?=
 =?us-ascii?Q?aTXI/sz8if1Yvc9MYCShx37ygDoNuWeYinoadlcnJRaMMo6bb/XVGLAF0Z+Z?=
 =?us-ascii?Q?E2y+g45wshwWcFW/f5dx56EWqNhitoRJhtQ19ZM42sJY43d53Fxa0FlSuDmJ?=
 =?us-ascii?Q?HQfMAUjRiQpiHLVhwgbYxSt/lnLchXPs3TsIv+r7j1PnYmvFuQQFa7B+QfUk?=
 =?us-ascii?Q?u7LwHNs98ka+xYjmLLMVOWDufTd+GuFhtZILLA00X0C4XoIASRRK1MkqwcWi?=
 =?us-ascii?Q?JwX16CgXFrVK1hdm5Yyn8pt/YtmX4NLxtfjdfnb+l8RGuLu+6/tWYNl+c9/0?=
 =?us-ascii?Q?rbkHNg59Og7N8XeytrgNpReX94A7K22WnLrQp9O57+rCY0WkNCu0UlUwC5S0?=
 =?us-ascii?Q?rFFJe5tfoNRlHZFJ/7JmOpl20yjl1nzDrQmFn2dyF3fmnetlu6A9nK1Q0MwX?=
 =?us-ascii?Q?SJRUG+Rh3O4EhhuAlSC/oMc08CHZYUlTaHZcwsaL8/5XOF0WMx3xL+i7TizF?=
 =?us-ascii?Q?8wdsIN0CWU/g/FMABERBF5546gPmmVvWHgNiGJfew4KtJHqhVNu7Z8lqjhuP?=
 =?us-ascii?Q?0iEKo9QpcIS2O8i1BFLNTWFkesNjLMweQ9gcQZd61er8VKcUCiBXlQ0WwHFQ?=
 =?us-ascii?Q?Hhhp9/Hz2IA8By6jMtPCCuMvBxL8X3PbMcDVH7jA2c6pnVBU56eIV8nTT+8/?=
 =?us-ascii?Q?Nvjiy2FHWKHQt48L5e2u/dLGqGfvce20DXcLhiD9fURxQfmGNAMQLljYiEEX?=
 =?us-ascii?Q?eDgsWw7Bo1K39cbU5G1YGBJZMhuPPyiraGpF8l03kfubo441P07jBUsiNYH2?=
 =?us-ascii?Q?zylZD+UcPMNvt/mX4EoMDyGxpqQRQTdyiV2NiO3F8sOJI19bv0fiBjojdxaG?=
 =?us-ascii?Q?R5MSda6IZHexVMe1aDcF54E0zl+oNyHftE1tP3J+jSuOuNu/JNqrIojuiVyy?=
 =?us-ascii?Q?zCFv0liLpS3YeCcSLkPYUVX2UWlGDeImEYHCmD+oQQdI0sKTOE1aAL0SAmxs?=
 =?us-ascii?Q?PeoGbs/auJIXuJ4rAkIYdwTg7B/bmptjbf/fCl3YnDRcHlridlLOKMb4upIf?=
 =?us-ascii?Q?A/4E5ONMIM0SB/qkONnf3yCB34m2ebA8wYdoi0ZwTouJIZVRt6WilszHG6b+?=
 =?us-ascii?Q?9SgfUPlN2zGW7RAB6K4QJiCnGin2/OkAPKsXvK5bkyVX+vvKpnJBtt8ZPKz2?=
 =?us-ascii?Q?eGU3uE5Nr5GeE0MC+EJyrUrHPgkX05rU7w1C0Z9T1HtigmQGIwGFrqEyKlyo?=
 =?us-ascii?Q?tTTAJQBXVYDOdmOLL4w25A0FPIYwFq0ksbH7o7szpA9dgKOZSdsm77LDnieH?=
 =?us-ascii?Q?ttcd8v3BqU7mhyNq9intN77NY6zh3r8xQAnOaozg3I512QoGHjjnaGDXzEeT?=
 =?us-ascii?Q?W48Gw5Tr4bU8x+M8uTfHcMdNSBflF8mzLWwzFnNA8xMQvRB378TEAPN9EWee?=
 =?us-ascii?Q?iROIg9GA6wS2aadaPHWaCzYRNsSYvNhGjh3kGNrK5QdS6cJXK/a4WsKe4N0z?=
 =?us-ascii?Q?m+o+e9T7o1AaCrfyLfltpVVxQ6ExKY0=3D?=
X-Exchange-RoutingPolicyChecked: m5Z6eVU+ky3EeB9qNZ7jRcexVlm84W2367cmfJkdLmY+Z4FX58lmxTbYb9sTs/FIThCDmRjhrSXV5bSEBIprwPajBil4kWY+92b3IaNEosE/m1R4JMUF5vpVQzbz2f9QL8t5M6b1N8y+T1iXej0R8toCl8/yfyAIIVgq2TUFzRyxZqhyS3jopWzGTIsp6OIPhmQVeyBpQy2xZigdJ6vF4+XaE+zTvhDzRauQbIjRFvXeOrI3PvqmsQk48v/tmg9jHsARr6i7O6oBFaHchRjOTSjDH/JXYrQ8HTliAitYuAFVZhiHxrhTYnjMLNvNZSvpmXMefpEHxOXeoYP8kCHTZQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: CLxJcxtjvbAPxyLjrqGz2hfcHljTLwIlfpVY4GHfX5rgCftxPUt8mkM14RNq6xkC87w8cfRlNXXim/6WtAniKcXuP2ZWBFTfI2cCx0NWA3mN6DlGOJMAh2RwWa0890d8cCIf8WfXGaBg9viKMNae/SkqsM3bLNYTqmRyT5sq0CW8r43+drfu/6aRugtSsFw8H22oe6oTpWQWP12US3t74R9hgwINQChKydAKMPRqvnOkCrVsqgHYxQ1BjgvXHb0AN4jn3wuESzZq48ZoznI/Do7OJHLZ8z25iP2XpPR266gMXABxD3GNwPz8f3P5BgZJfqrfgARhCVaPSYalKrlJBiW8N3q/L1XCrxbijwCuefda7HnLgXLh9/SALe85pfVz10B21WhCUPF+/HnWpcAcf2k4N1Fe/QnLTaXh8UgJtk7wL98A6h89cKPDKpVA4rdEW/b5vqDUW+joCe+3d5ML0/0y/7c3RQ0RvfLvb3TbJ7MVE4KUndzkZi7IyfjMSnOcHs1Lxr4Q1OZOe8HxgC9unE7Tr/CzFbQSo8yeTDY/Vhwp9dISiwB3yDD2W3+5jR7rv9AT9vsgosOcxwty6CfaU6+SSGc3o81JINsKLf6lJWLJuwHUY/dNEJPBBkCgHoPM
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0489d88e-5bea-4427-d26f-08df1f80a754
X-MS-Exchange-CrossTenant-AuthSource: SA1PR04MB10065.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2026 05:55:53.5230
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4ynmeS8QXyJQScSkqxxhhogZaOj5pHopv4s2k6nPE2kV+dGnO4pniKEh152teNzillfgHOKm28KUBvIjaMMKzErvrLyb4EcXTvEu8JfXjvw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6504
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260930_225600_070972_CF57B7A2 
X-CRM114-Status: GOOD (  20.53  )
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

On Sep 18, 2026 / 21:57, Nilay Shroff wrote:
> nvmet_ns_disable() currently clears ns->enabled before draining
> in-flight I/O references. This allows namespace configuration to be
> changed while existing I/O requests can still hold a reference to the
> namespace.
> 
> This can race with configuration of namespace attributes such as the
> device path, UUID, NGUID etc. These attributes can be accessed by I/O
> requests without holding subsys->lock and must not be modified while
> such requests are still using the namespace.
> 
> In nvmet_ns_disable(), keep ns->enabled set while existing namespace
> references are being drained, so namespace configuration remains blocked
> until all in-flight I/O has completed. Set ns->enabled to false only
> after the namespace references have been drained and the namespace
> device has been disabled.
> 
> Introduce the NVMET_NS_IO_LIVE flag, which is set after the namespace
> is successfully enabled in nvmet_ns_enable(). When nvmet_ns_disable()
> starts, clear NVMET_NS_IO_LIVE so that the I/O path stops admitting new
> I/O once the flag is cleared. Using test_and_clear_bit() in
> nvmet_ns_disable() also prevents concurrent callers from starting a
> second disable operation.
> 
> Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>

Recent blktests-ci trial runs for nvme-7.3 branch reported failure of nvme/052
[*]. It is required to repeat the test case 3 to 20 times to recreate the
failure on my test system. I bisected and find this patch is the trigger of the
failure.

Nilay, may I ask you to take a look in the failure? I'm not sure if this should
be addressed in kernel side of blktests side.

[*]

  nvme/052 (tr=loop) (Test file-ns creation/deletion under one subsystem) [failed]
      runtime    ...  12.165s
      --- tests/nvme/052.out    2026-09-29 00:36:09.236884509 +0000
      +++ /home/runner/blktests/results/nodev_tr_loop/nvme/052.out.bad  2026-09-29 01:06:09.513359622 +0000
      @@ -1,2 +1,4 @@
       Running nvme/052
      +namespace with uuid "492157d2-1f3b-4bc2-b717-e6234d0fa466" not  created within 5 seconds
      +FAIL
       Test complete

