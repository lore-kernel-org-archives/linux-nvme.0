Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1FACC5DF87
	for <linux-nvme@archiver.kernel.org>; Thu, 20 Aug 2026 14:01:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:
	Content-Type:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WSfTg+Kn4w/LraGKCTqKYGhsFX4dk/YuJ/fgLaYgRWQ=; b=AJ7vdxputXmSjHZWlqWuGPqfA7
	PJsSklEg08I3K50w0Jos0q71lmsLDMroHwzszfyOvMTKYUS3ldlEahNJAUgxFGwhEwfTgKCSjiojN
	88kuSOj5N75sHWerr83lR1WT6C4SCx4cYuJpztY7fOZKt365Ub6uX51gQzB0GdDH70I9M8koYDIfR
	YmT0uR7u0ogcGcYpBZqn5R8Rv/w2SfgHThyYl4aZ0QzO3Bw2JH1aLDm9ANtTDpt0onFCXR1l4tSDu
	Y0kiGmZZF/YeW20HNE0BOkZ7Rk6a0g/h2A4t9sMyBnJzMRtUh193EAPw04q7eT7HUYHXkwUfqUEUv
	f2yESpTw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wx3L5-0000000BekN-0IFU;
	Thu, 20 Aug 2026 14:01:51 +0000
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wx3L2-0000000BegP-0wnE
	for linux-nvme@lists.infradead.org;
	Thu, 20 Aug 2026 14:01:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1787234508; x=1818770508;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=kFYxltX2lc/P5pgXELXf9H23ME9Aa1/U/AXTKnAYSPM=;
  b=qEUHrCLV2hjrYoqTYCI6UVktyJd1gTva7g6KAYMDl9k3co4fLIQFWRbm
   GGOCtD2yPEqu5b2xB4M9CWL4uaULl7q2x50c1mQ9QhhPiK0VHFTipMXLo
   uvduqYBGnpoDtYgrkjYlCoc2N+SjV0oeYQlGc59nrESsjIUPYhdugDgew
   id9CYrLNmV1jSfj28AIH5E6BwVVXUilBKz0Lc7b5VzljwVG8mNhluc2GZ
   IMsWTH8FWyuAyR6mtXon+RAEE9/q+Jckiot9pYTXcWCusVA1hvBVvx+aZ
   PzK893hxUjwruGJyMiXEvC0kSg0IXDC6CkZPZ8E9I56YVFyVFA8FkW+m0
   Q==;
X-CSE-ConnectionGUID: qsa14hTAQPKENTsfIzqoWw==
X-CSE-MsgGUID: XcvHxMzoQraHiOOxCNEwTQ==
X-IronPort-AV: E=Sophos;i="6.25,233,1779120000"; 
   d="scan'208";a="149734539"
Received: from mail-centralusazon11010061.outbound.protection.outlook.com (HELO DM1PR04CU001.outbound.protection.outlook.com) ([52.101.61.61])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 20 Aug 2026 22:01:46 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MIEs+px87RdiSom6iWIDWBbA5VWB+XOWzdIC4+IrdZCxCfa1eRwekJR30FKCpVIzEAKDSHxRwCe0kNK6Ud3fBAGCfuFlM0FkQK2Lo/n6whBU0UiEDKEK+aJB4HAHfTgaaEAbG/FTQtL9Rut12hgiVSjY4GZJBdISaHeO3pBl7wogGd7eEM+qPzlKvQ2LltU3LhAh0SyyUK3WgXThexAA4BsaGx8uUBZpI5sFIVknT4jrIMoRRunPhZuTyRRc7JuWt3gyZTGo4VkILzQQIuEWW9PlMlpsAekRQjOnVg5gvD459wduuBmXiDUiBOqMifm4sCo7USiT/1o31Ijq9uWynA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WSfTg+Kn4w/LraGKCTqKYGhsFX4dk/YuJ/fgLaYgRWQ=;
 b=B4LDKmIIuuGkw3r1woIB54Ox5EqVG3mPw918Il8OZUtqmuKc469ALfSbaTNsAvNCRk1t2D2ihEcUPIWQbcZbQH/PNFJRMVED63GS992CkDh71LPBziA/FyDbiY0zxGAjrsr7gWWXPtufc10LJ02UrYlOLt7NnMawjVn/nTRP/N1V1vkPzBx1Vcp715LTgMyOjS359ELOJjJtOEo62Vn+V6bq0WNdTkuYKnr0djF/4b/p0JwOnJOR+yysf21Bxzn/tO4YL6XJEY0d8KBVIAq4iVfk4Di5qfv3+7l9gV0aDwXb2GwPT7F3cB2sHPz406OfpF9Mn21knTjtNFfmBxvfEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WSfTg+Kn4w/LraGKCTqKYGhsFX4dk/YuJ/fgLaYgRWQ=;
 b=GpsTW/xlI+ghhWEaceBBThORDS9dfu3RR2kEJU/GzmjLvcPDqUclEWWzHBpu1chnEqJFx97NJ0zdD6lMfruZvFTJbItiUt0h3xfVJNtoNvDcx+sGbvBVDwLQbAgqsXA8ChUofFWsXFpVXZB7/ievVyf6PrsxvIV9ixX41dPQQ6w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
Received: from SA1PR04MB10065.namprd04.prod.outlook.com
 (2603:10b6:806:4dd::14) by CH4PR04MB9082.namprd04.prod.outlook.com
 (2603:10b6:610:227::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.10; Thu, 20 Aug
 2026 14:01:39 +0000
Received: from SA1PR04MB10065.namprd04.prod.outlook.com
 ([fe80::9b98:bf8a:b0b1:ef85]) by SA1PR04MB10065.namprd04.prod.outlook.com
 ([fe80::9b98:bf8a:b0b1:ef85%4]) with mapi id 15.21.0339.007; Thu, 20 Aug 2026
 14:01:39 +0000
Date: Thu, 20 Aug 2026 23:01:34 +0900
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: John Garry <john.garry@linux.dev>
Cc: John Garry <john.g.garry@oracle.com>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH blktests v2] nvme/068: check module reference count with
 patience
Message-ID: <aocGphZ8C5r94O_i@shinhome>
References: <20260806033146.2067433-1-shinichiro.kawasaki@wdc.com>
 <57644cf9-ecce-4829-b7eb-82375960946e@oracle.com>
 <anRtGO3CBTh8Sjxj@shinmob>
 <a6c21f02-da8c-42bb-a6b8-4c20d14b2197@linux.dev>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a6c21f02-da8c-42bb-a6b8-4c20d14b2197@linux.dev>
X-ClientProxiedBy: TYWPR01CA0041.jpnprd01.prod.outlook.com
 (2603:1096:400:17f::16) To SA1PR04MB10065.namprd04.prod.outlook.com
 (2603:10b6:806:4dd::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR04MB10065:EE_|CH4PR04MB9082:EE_
X-MS-Office365-Filtering-Correlation-Id: 172da011-d6b5-4945-e448-08defec38e89
WDCIPOUTBOUND: EOP-TRUE
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|19092799006|23010399003|22082099003|18002099003|3023799007|6133799003|56012099006|10067099003|4143699003|11063799006|5023799004;
X-Microsoft-Antispam-Message-Info: O3SOc4k5SR7hL8msDopuy7P35hoV2SOgGH0Pcpg18+f+HuAgaLXNxv/YkN5AKm0I+rH7sfSu5E17R2SgzR79UOyXmslTWlFyjxNCxYeakg0uwgA8LJydtr5iQLPajwApdSXq8hjMUbVl6h4oCcyw+VAuYTNdmxXblLso4aTaaCSxkqczhRR3aq4HXc0rJVrZo7BnGveU0WTASOn2ZENVm30182gqwOgE24qnZD8s+GJyaSsfTkKLc4JFzXe62Cm8E2p/wZgTIyGDHG0t2RroeaM4ODMTfG27ZDYNKXeb8ISJZ9dMwyaj5pqmBor/BY03NRpX59WteRUc9ajHoi8yl/K0dyENvEvWhf9v5HmTVwJKklw25AdJR7H47e23pfIqVrIzXq9w8yhh+ArzSkZjSvZtjnNM2MCoL1UErjzbpmavpNKR/jWi+h9LGrQIjAdthd4ynxIUEtyhCGcK6iu/P6q5CUK0nt8TIvlI/PhyXABzbJiyhgCSBp0H3SmZDHy6aU7c7YzvT3fsXgNCFOVhFt4xB6ECG/cukRTG2djZaEOOiIdvkV3eFB1NMedDmOuo6wDShIZQ7e3cyNmk3AzF9ZHIyFvoiyMQTLb+zc8QDtviT4uDe1MX8jm9tPBujt81ylh67HBoWdLMuQ2Q9CV/ojhZy8TIC+Z9peoGuuAANGU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR04MB10065.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(19092799006)(23010399003)(22082099003)(18002099003)(3023799007)(6133799003)(56012099006)(10067099003)(4143699003)(11063799006)(5023799004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8daB1wiFARACy32YP11VNnEN/KrMsAtYENKcJKoQ4+IyI32rNeKUjxOZfkXE?=
 =?us-ascii?Q?95ZzYBa8UhToJh9idLIajvC1AWwvk82ujMjbKDbe6Kc8IL28ralT5noX2DIo?=
 =?us-ascii?Q?rWMy5VN0wtlMzdzh2ObtcJH9umJemkKqnS2PYf0LCCcHlrmIahIOuLQN7/xl?=
 =?us-ascii?Q?XV23qReqigUt3dSr53KUuU2U/yGOWUIuonjLMLGsWYd+lIeLHtXLegGJgw6+?=
 =?us-ascii?Q?3deDhqVXlfa3r9KUCN5tbg0t69yHc8YLoXBDjsBEBTYSqtQbIxEzbbmqn2EX?=
 =?us-ascii?Q?P0G7gL0uuSTnfGYXY+zgk0rr7BMMHsLYIltj9PvlSuVc5Y3/aYZrNqInfGYU?=
 =?us-ascii?Q?I4l+ujIE/XNE94M5c2meOlUpIanMkSTiw6lgk0QWAALcC93lrdhXv4PwbxPW?=
 =?us-ascii?Q?Z2fydITuAwzQpP7WtVkByJ+pRzfIyQuNDzfE3x59GQYWZ6Dr2lYirpPnVfCp?=
 =?us-ascii?Q?SRGhHD/FS78ckl8+BraF55pl7nbfg+ZzDhh4mRcxin3sCwK98E7V3TMl/sTZ?=
 =?us-ascii?Q?tvuckPEw/Dbo61jPizDq+u1+mQCuiGinwMlsntSgW5TCd0WGqZ4x8gdTVSjS?=
 =?us-ascii?Q?aiNWHTaOUv/ADXcsCx70+SDYGFDThlg5NULgGO95CJtsiIAN0+XuXSiwM6nq?=
 =?us-ascii?Q?btm0nrqe5xfQTFhumBxkJaH0uIOhTNp5L4B8OfzoFM7T8XAoubW023nWYLfg?=
 =?us-ascii?Q?H7FZ+BEsC/97jRgwXarvGlUfg5z0DWuP/AKyiUoxH51MW7qGLHoFY2Yb9FaI?=
 =?us-ascii?Q?2l37joUTVXiAc9V9S8GA5PkFMJFkMNtLCAiHTO+Y6S+o0z3WanHt1WAGH9J/?=
 =?us-ascii?Q?GB7V17ZoNhtRc3OrMi9E8dsc3rrwU8GEU8kam+010T+2bqDqSkL1OeP6l7dO?=
 =?us-ascii?Q?r5W4Ou8ZWuTwudB+lEpHET45Glrvn8JmsyeWGwZJM4bOVpbO5vZ/6IktMxy6?=
 =?us-ascii?Q?HXG7sUE5i/s3CRjfR+HiRLvdO2t3f5zMhuEFeMSKTag7XK/GGXGuL8wm/rDM?=
 =?us-ascii?Q?ZXWWATnkMmyO/fmmm9GsUc/BQivs9FSwAUBIIIekKIjCZ5MPEDN1VDWafw80?=
 =?us-ascii?Q?/bfVVgsvIChLpDs3Oyo36udUfnLwvC3skSnjiBxOnMTmNmRaGF5+8kBIwGFE?=
 =?us-ascii?Q?WNTZla2HtFjYGX45yrf2sGwSpdnZFoMmdazaSh5gqlHtZg2sf1+hyNjTk7Sa?=
 =?us-ascii?Q?67UnhYJF1XhQXCKsWZCF/lws8svziixS4Uja9yahUzP1xrLo2YbfPsTcWk33?=
 =?us-ascii?Q?MC+6ZpwPL9ccqMOcvPw9NkwNe7y+FNhjTbn3IgEXyWOQhXpMs4T4n4LzGGmg?=
 =?us-ascii?Q?GiqQELLVqC/LqMJg1Z9XlFeTCKMNBdx9Wm0YkffCloCkP9YWwKX1gk8SdWp2?=
 =?us-ascii?Q?dMRMOwokpMXqOHMl40AskC6koRcKk958KyHaL2E86tuOmkRtD9heEmJ12Uun?=
 =?us-ascii?Q?TqVEDdLRCN8TL4mq39O1S1guR8nf1CJe+exlQ79fQO2t8sYgudt/jQPa318N?=
 =?us-ascii?Q?tuCAmeOd57/qzEGRZybOkXP3azxF0T7U07MBLroEKY1TvzU3kQNz//M2MABR?=
 =?us-ascii?Q?R5lKA1TR6076nIVzr8/FMpAHGlD81AkTBMUgzOAzzNbEV6ylowFvz9XolqJr?=
 =?us-ascii?Q?VRQwPgQ/1sfpgJBbENXV8NkDF650WZ96Q1+eIC6Iw55XUbEqwS7gPIJ0hDKs?=
 =?us-ascii?Q?HkzXVv9vOgmug/AHzWYGZF1Ap+rt24sHCgwBHEUPZGzr5jPZUOJ2dk41iBjm?=
 =?us-ascii?Q?1jI4A9Hl8cRwmUFewvDe1NodeAoUsok=3D?=
X-Exchange-RoutingPolicyChecked: lYNdQoHvFwYNdcZUqz6uxF3CfVNOcAtBRweueWRSneKxYptR4M49FgOwIiC6ysDP7N1fX+IEUbofj8HzxNjGrPPiV5e9L3VMYVIwFzpbVKctj4/rijugfhB8xmVY7jJ7cj+c0FWr24oMNA7EbKmbk8HwNJpzks3JHWoL+PME7kkAndGTKy9NKQqQE1yTZc1rCdCTMpRxSprKskXZ9KfMIYLdS4Ti29CN6Cd3b5iggk7tC862MkHuo+O45JPgrw/jGCUdVvEFjuwXwKGEnbru5ooPUcWOi77eBo41ave04AQ9EpaXc/MPm24RS1x5t3agYNis0tGCxQHJhLVU2PaXJQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Hkes6LqgJ1po+UPdy0/VfA8T9BISnSMTl3xVyfu2dVvxu1rrZ28WU8mlIxmWSwCcb0geVvt/42R9p63ZJqTMBvA2CC0yoP9NqYeqy0QRaG20TCetPiHApz5yt40oWXocX1cAbGpi4FMvt6/D+Bs2FyLKY0cK55bR4wtW3+t3v1FqdYXqacM6XnC8TKSbFsbzokkc7IjX9YnMoJVflgBuPbuK86PHgExdGGA4Jk1gTM3MBr65MHWWQqIHCQlQ+5nTddJaYxuRwWEZkg18fpH+5kGGPnMLdOJM66lTWsGZmPn3LXd5MFEHHhvgLQz5P7ZpMyMEmr9lzXTe5pkxqEhg00BOwaTLVZiJG4L3GMXruM9bRc9VVCCWnm2PVPWeNgbtPFdCZmwi2sEsDZruOYrzvzq8yz5z4Cgw1dlJe+N7nz/fyFAZgbLY2KKWYhN63tyFTe3c3cmPdOywuj0ceI8LJgjEbuNfFhqlOLBo3P6GNNYy6OtVo0IFx8Mk7PAdB7751YyyFxSxv6FDGyF7vRh5mHaUO72DEbZNidP6Bb2vA28r6VfjBpNcF+uzo7v5Q2Frb6JPkgqDKZYzLb4k9wF3wWWf6kTv3AaoTgwmdsOhYTKAo8VjgtjAfIVaouU1i64a
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 172da011-d6b5-4945-e448-08defec38e89
X-MS-Exchange-CrossTenant-AuthSource: SA1PR04MB10065.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2026 14:01:39.7877
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8JKfzneAEwW6YUA6t6yM8nR1FSP1jmt4+isr8jlLkIL2wqagCzU5tqwDLRKuXTXPg6v0Cg7nItHJrM1lg7ucC5mH41XTXDFyZhItCAhCCTI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH4PR04MB9082
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260820_070148_330968_39F7DB2E 
X-CRM114-Status: GOOD (  28.63  )
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

On Aug 07, 2026 / 09:32, John Garry wrote:
> On 8/6/26 12:30, Shin'ichiro Kawasaki wrote:
> > > > +_check_nvme_core_ref_count() {
> > > > +	local refcnt i
> > > > +
> > > > +	for ((i = 0; i < 10; i++)); do
> > > > +		refcnt=$(_module_use_count nvme_core)
> > > > +		if [ "$refcnt" == "" ] || [ "$refcnt" -eq "$refcnt_orig" ]; then
> > > I thought that refcnt_orig was local to test(), so I am unsure how it is
> > > accessible in this function...but it seems to work.
> > This is a bash uniqueness. Here I quote a relevant paragraph from the Bash
> > manual [*]. Some paragraphs follow and explain how bash handles local variable
> > scope.
> > 
> >    Variables local to the function are declared with the local builtin (local
> >    variables). Ordinarily, variables and their values are shared between a
> >    function and its caller. These variables are visible only to the function and
> >    the commands it invokes. This is particularly important when a shell function
> >    calls other functions.
> > 
> > refcnt_orig was declared as a local variable by the caller of
> > _check_nvme_core_ref_count(), then it is visible in _check_nvme_core_ref_count()
> > also. I used this feature intentionally, but I understand it looks weird. If you
> > like, I will update the patch to pass refcnt_orig as a function argument
> > instead.
> > 
> > [*]https://www.gnu.org/software/bash/manual/bash.html#Shell-Functions
> 
> Understood, thanks for the info.

FYI, I applied the patch in the current form.

> 
> BTW, on another topic, it seems to be a common pattern to loop waiting for a
> condition to be true in the blktests codebase, like:
> 
> +_check_nvme_core_ref_count() {
> +	local refcnt i
> +
> +	for ((i = 0; i < 10; i++)); do
> +		refcnt=$(_module_use_count nvme_core)
> +		if [ "$refcnt" == "" ] || [ "$refcnt" -eq "$refcnt_orig" ]; then
> +			return 0
> +		fi
> +		sleep 1
> +	done
> +	return 1
> +}
> 
> In the kernel, we have functions like wait_event_timeout(wq_head, condition,
> timeout), which calls @condition and checks the result to break the loop and
> determine success. Could it be possible to have such a helper in blktests? I
> don't know how...

Thanks, it sounds a good idea to me. I guess we can use bash "eval" feature. I
guess the helper function like below will do the trick:

	_wait_event_timeout() {
		local timeout_in_seconds=${1}
		local condition_str=${2}
		local i

		for ((i = 0; i < timeout_in_seconds; i++)); do
			if eval "$condition_str"; then
				return 0
			fi
			sleep 1
		done
		return 1
	}

With this, _check_nvme_core_ref_count() can be reimplemented as follows:

	nvme_core_refcnt_is_orig() {
		local refcnt_orig=${1}
		local refcnt=$(_module_use_count nvme_core)

		[[ "$refcnt" == "" || "$refcnt" -eq "$refcnt_orig" ]]
	}

	_check_nvme_core_ref_count() {
		_wait_event_timeout 10 "nvme_core_refcnt_is_orig $refcnt_orig"
	}

This looks a bit simpler.

