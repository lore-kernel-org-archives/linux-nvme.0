Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97B73606A320
	for <linux-nvme@archiver.kernel.org>; Tue, 20 Oct 2026 10:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=l/HJ/Buy;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=gguwOQri;
	dkim=pass (2048-bit key, unprotected) header.d=wdc.com header.i=@wdc.com header.a=rsa-sha256 header.s=dkim.wdc.com header.b=V9Yy5Jkd;
	dkim=neutral header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-sharedspace-onmicrosoft-com header.b=xN29iPnV
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:
	Content-Type:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MwRBvGxODyDyDwpykCH/sMlSrsIFpX6sekGvzGHY4C0=; b=l/HJ/BuyH+oQWaMdU5g8eci95i
	wxKbHrjkGQti+q4o2NJzsfYMLOVZi9bxjO42GpRgSMYGExe2NOl4sHyHDBsltHnZqBoRPZnKaeJfo
	us1MR2ILh5YaihcoeH8x00T7j/FY8AYejVbJL0n701NtBI6lhFBxZXvrbMvqJnfSBuJh0kWGSBW6Z
	XxL5KHyk+fo0924o4HKoVNGWfmqNPbnpEH+hLlJrXK98+KOn3zNbJ6C6+Wt3QoJqocHnPCXusdkjW
	JSKI+Sa2is88PFjTbEUwtnluBvrMOPeJ+13f1rwP1rBmcs3ddIJMf8MAfNkgBEkxf+ULpufeeUEvR
	MROFoUkg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xJ7IL-00000009Shd-2fGw;
	Tue, 20 Oct 2026 10:42:13 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xJ7IK-00000009Sgs-22kz
	for linux-nvme@bombadil.infradead.org;
	Tue, 20 Oct 2026 10:42:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=MIME-Version:In-Reply-To:Content-Type:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=MwRBvGxODyDyDwpykCH/sMlSrsIFpX6sekGvzGHY4C0=; b=gguwOQri5srwTnVd+0AUWgT3M1
	RWQ2lPRFVAAXj3L3thEuf+AQKbf0aGgvCWjACiFGWrO0TKvS+A23Bhfpsk4p19CZzR4qP8zncRw7n
	f6aRiB8xOGx3MQ4LaKHNChHxfKHB1S6IG+kLYKVcub8HjRBBJLR7i19Ed4ofO+0ssYEDFg6ytu2h3
	/1bLzFlMQO/8hHzQjlTSHXVcvL/RWYohobCqXF58lPawK+hbF0W5ZKHDDN6qnOmWzlUvBhiFkf923
	hTTIYkRbK2f32cvVHAVkTwmVLrE+rAglbLFYuc+vl5GzqoNHTRRZcM38EG6gbd2XOD3VSfdDBuoYc
	hBhp7FRw==;
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
	by desiato.infradead.org with esmtps (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xJ7I4-00000004boP-0xgT
	for linux-nvme@lists.infradead.org;
	Tue, 20 Oct 2026 10:42:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1792492916; x=1824028916;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=l0Rgb6ZkQgxbuj+xyUrCvBx/FClmWLEFPnD42SxpKAo=;
  b=V9Yy5Jkdz4Hy4HENv/UObr/qghB/88sio4rvX8C4Rdw8MjuvcmWlEnOy
   fXX/3Oww2yfNF3RjKRoDnpTpuqC9gyXNrkXtMrkVHtOlwNFJHvbM71IZf
   yHkIswlfFyQHgaNtadDJU0Xdycv1oA/hVerRHDAI/x/KH5Kxxk3OO/xOr
   2tTLQ+IsSvokvKuR9RSDYUfmYvggCltmPpVRgsAKN57tD2CiWhlPvIz/e
   DuhXfZWtC2vGq0iCYT9XzWZ7N97yv8q1ZIdTfeaWKoEbGjWQN1qGQougO
   yUTp6xV5Oh8VyWT8JU/GBvrOM4c+LdOGVc2O+MdtHkDFj2VHcHeyyeVyJ
   A==;
X-CSE-ConnectionGUID: D8fNrI32Rem2qt8oNES1Pg==
X-CSE-MsgGUID: mCq8UwW7QECt1Eq4wZVY/A==
X-IronPort-AV: E=Sophos;i="6.27,168,1786982400"; 
   d="scan'208";a="157580688"
Received: from mail-southcentralusazon11011062.outbound.protection.outlook.com (HELO SN4PR0501CU005.outbound.protection.outlook.com) ([40.93.194.62])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 20 Oct 2026 18:41:50 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ig9ifK/dhilGq9rtA/wWc3a3lz808gxLn0NsCiOy+OdKCafQ2joHNKWhyv4rfWNVORqd6jlv/VMWkOfNgQg7QrjL0itGTSxbe8hQMXAJOA0j1tsa5H4Sjq+zEB560bjKA9rjN22zzxp3GgKiBVOTswtxPMv89anfqvSNaKTGCEQJ5KFITXlkhpGgvvOdqY2gZBgo3cAScgBtuO8NuXIBTdkI2TiJAPKK7mmNixvq5Op4IWol3mAEDkkPNQ3VKv3W+7zPYOu1g0EyDOgHb+yc8n0f1jzlOJBwNatuxwf+MTKcXQyQuBvg/v+k1Ug4T1Xtd65hwbjytLZ5id0PBLycmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MwRBvGxODyDyDwpykCH/sMlSrsIFpX6sekGvzGHY4C0=;
 b=CX0Q8y8+qiEePcR1EYvEQU1AV9kWfDGelQ2H2sCXs75AeX/NntaitpjMV/RoIbucqqLmaSCUru2KeHv0me825vcE0MSXHGX6TXRMWIgwrVWUwxu0JmS0mWfNRA0chlUG8aiBWPSrKhnBuiRfsB84ifbu4W8VoV692hZyWKCEAFQyvVziPlUWbeGp+gjWYD4sL7f7nOcO6QFRzMDb5NTkaUCHHKiBhm7Q70KqMKGfdYEqwNpYlaT/j3xfgmCXLGgNaS5odorXYT6XReLh5eBocCZvQU5QQBOd9YpceVdlPFHsyYQ7Q7IF0cO/2QCFvNWV7h+PKikhGc3GXyqNMjsbNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MwRBvGxODyDyDwpykCH/sMlSrsIFpX6sekGvzGHY4C0=;
 b=xN29iPnVXsiLcfgESNVfYB9/VCdd9v4WnrTIGHuCkSQkdOT8zlwSgUqFupQ6o6yAkWOJPHLC5BitVUN17OSH8M4ett0zJ+O22dmAlbfzq00LiaNi43YaFCqfkk6EZt4+gagTg2jJ7XxN1WRXSOgpP2Z/AScIx+9xxzvhfFGb3Xg=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
Received: from SA1PR04MB10065.namprd04.prod.outlook.com
 (2603:10b6:806:4dd::14) by SA2PR04MB7513.namprd04.prod.outlook.com
 (2603:10b6:806:147::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Tue, 20 Oct
 2026 10:41:48 +0000
Received: from SA1PR04MB10065.namprd04.prod.outlook.com
 ([fe80::9b98:bf8a:b0b1:ef85]) by SA1PR04MB10065.namprd04.prod.outlook.com
 ([fe80::9b98:bf8a:b0b1:ef85%5]) with mapi id 15.21.0522.017; Tue, 20 Oct 2026
 10:41:48 +0000
Date: Tue, 20 Oct 2026 19:41:42 +0900
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Andrea Parri <parri.andrea@gmail.com>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>, 
	Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>, 
	Chaitanya Kulkarni <kch@nvidia.com>, Daniel Wagner <dwagner@suse.de>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH blktests 0/4] nvme: add nvmet zone report and FC
 regression tests
Message-ID: <atdEpM1uAdi7Dnh1@shinmob>
References: <20261014170046.2516-1-parri.andrea@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261014170046.2516-1-parri.andrea@gmail.com>
X-ClientProxiedBy: TYCP286CA0360.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:7c::6) To SA1PR04MB10065.namprd04.prod.outlook.com
 (2603:10b6:806:4dd::14)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR04MB10065:EE_|SA2PR04MB7513:EE_
X-MS-Office365-Filtering-Correlation-Id: c3778642-5ea3-4442-325f-08df2e96be7d
WDCIPOUTBOUND: EOP-TRUE
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|19092799006|23010399003|1800799024|3023799007|10067099003|56012099006|22082099003|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info: S6ysV1ZYPLzJYI/W2W8bxbtyKzGWjER7v30naVUH++UHmCn7rJxgDVS2sKDjQBJAlbEb7Od35Gcbtxsc8go4xebTmasOQYQbdnVLmfVnYz0TAdlZucRHB6+4RtpJk/gKi0Hj7QTJd8SLCKNnpIISpxIBsCHezjoSTEI6mbDLU+MK+660of/ZdSAYuDMLcK736ImsGdlKXX3T1ABfVrAuVj28QcW9lhF4t0gOiPDbC40F9XtN44sI7KxXP6fZh+BU3PikD7baFH9HWEBbd44pdLe31GS5mT+PcdTBpi3of7+w9mGci0NrwLNI4gafyu6T5HD5YiR1y+6T/sDp4rwkiHoFjgtnLU+/hezgIzYBnQnfYjosSCKv4QvdpEymCMfaOcitquz1mt7/zdfr9y84K8na6eMh/GbLRJ9iMVg7AOYBZAWP3cycKZhB88lG9+icmMpy6AxLQDB/euayhkPcEPWgOU6OVGsVhd41X7VnWApSGtt1oaa5DpG6cD66iPRK68yfAAqSymsxbI2OFqF18J1xbEkN/Z9OhAEQw2WJ3+i0Sg/GDSC0wcuVFWJfc0EMlvJK08tfpCJ1fXmCt+C4Qe2MGSVkCb3xbi1NcFa7TEJUlhWPCS8n6+MxLlqMsPrt
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR04MB10065.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(19092799006)(23010399003)(1800799024)(3023799007)(10067099003)(56012099006)(22082099003)(18002099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?R2ikTdNMzTZCS0Pv0MuQLChdqrHI1zjfRH3LQwtdfdu4HBSy8wLM2Fjaf/uM?=
 =?us-ascii?Q?jpSAP/AlAfETByttcAZTmRgbZlZE/KDyo2e9ChfUnMrJzBuQBepQJjALlb1w?=
 =?us-ascii?Q?qgRJU/d39Pjsw39lDN8hPh1syo0nMVGSIz0w/MCXQmJjARnWB2fzOKH6oJRx?=
 =?us-ascii?Q?8TPwqdVNI7YAzWsWiPlhtLSEUPiXN0vyWDd4idzkI3Jjn2FB0cA87PQbuGE/?=
 =?us-ascii?Q?UOgY4OaJbpc17xO0wsk7racpmF+twNQYoEDLyr7mpjcpodxGlugy9XzChGpO?=
 =?us-ascii?Q?SDhpsMyO1YfpXS+zSu/JGuOVDFVjLggSq6p8ttsrQqTpV8YbD1fBidjgfomQ?=
 =?us-ascii?Q?2fR1iNEQOU5sl8iqVlFYtQxeOudvKpCPSjx1lS9E8GHD7hzXo37c7TGtcvnk?=
 =?us-ascii?Q?1yIUZ2gIVXzaZhxyxWbqgn44aW71ONv5TDIBFbi+875w1zyKC1IWRFmr8/Ne?=
 =?us-ascii?Q?HgCf6NFLmivxDAzyT4PCv6Ane1XvyEjexpFWm1BK3hhbaKN7ZeewYMfIEPwf?=
 =?us-ascii?Q?C7qr9zQMAdOPyXrZklih5VTn86NQ4NRtCZLIAmpudIWCQ652+EvAwC7ZTuJ3?=
 =?us-ascii?Q?m/nEmjihvbxX5x/YhQwLQJvaEnriNrsWBPbjp9Lh/M4VnOVYeCMH3xVLkdfX?=
 =?us-ascii?Q?iN5WmgwV9PW8A3tVucScCCQHw+PfLecxhrf9AE2GLWQyrlky5RCgBFM7Y0ei?=
 =?us-ascii?Q?KS+8W4OJzgSZh2fKE47DtD6iefASYFH7kgRYx+RSthvtVvt7hTCNkc4F3WhU?=
 =?us-ascii?Q?hXtq1NwzUx4IXucH3Yhh0Ca20gjQwaMd7u3ymijKO3LIRM1IOwPqNQ9xjqsR?=
 =?us-ascii?Q?EJquG9Rf+kb4ZX5uHeDXuykk+ByD8+UN+BXPAvbFwDvKq2Ir58a61FY6QYw5?=
 =?us-ascii?Q?/vhiICUjzMq+ancpeNJkHS31RrN/kyNrgVG/mS6R99kbvhnw47ZaaOzjt3/w?=
 =?us-ascii?Q?ncRQu8Tm/P1srds6g5k9dx0qDi8qg8R1+Fkwp+blgNHY+ZrGZL8d5mH+UmBY?=
 =?us-ascii?Q?vk2iyha5PlNU5Tb4JvknjB9bz4RKtSuYHsmii5SGZDJxg1dQOv2zJB+tAWYO?=
 =?us-ascii?Q?EGS6leb23QXm2bAihd4P70EwnFKh5yCXhuqBlFQoyRZugxqdwB82YhH6wxcv?=
 =?us-ascii?Q?7wPXED+pmFd1JDDrGwMTakjup/BKlHSl41Yan94+mg1AVf6CSvDttumd1325?=
 =?us-ascii?Q?PAooBtI3KzyEtpMP/NzHTBc6+ySBp1YBw/YIYBp+atZshCoZne8TGjuAGtZq?=
 =?us-ascii?Q?WxRIFVHSXbmP2G9fL6sJm8hDyrRuT0oJ66c6OmLsbxoYr1Dx6fZooUN6VDoN?=
 =?us-ascii?Q?vKLJ8Ojmn/1+8pCuZh1wHe7jGwAkClFhxh3dmrVV2x/iAiBhh7ICk3WOsWrb?=
 =?us-ascii?Q?oL2nTlk4ultfEIhux54RE6qfKQGO2Dr9IK9BZ8Z45y1afsZ6IjPz5dyVhveT?=
 =?us-ascii?Q?UpCDXOChoeFcXmdn8FAigM6vFGU8dYo+fvUKju1MkNymw4EsNOu62OJNlM/5?=
 =?us-ascii?Q?eY5Z7U3ETH/H3G6NaA+67OfwSI0ajd/iAGvniMC6W2K3dr142hjaE0BUlTch?=
 =?us-ascii?Q?HPmN18fshaqGth7No9Eqv4e0uqEWIlYJawbef+YR+iLOfZ1ETeOq2MzhgvC0?=
 =?us-ascii?Q?B9yO2/0J4Ar8oLT09VAca/vtjbZp3jDtxfDuiuoJd6LzEOCxIgzm6xI7OCCH?=
 =?us-ascii?Q?CNzi+X4DMuUdqn+OE1qyEjUhdz/MY+M323V7xalqPpngdSQwE4pE/VaLM33v?=
 =?us-ascii?Q?5gq6wqDYPm98AsBGti/OxuiGNy8Dg1k=3D?=
X-Exchange-RoutingPolicyChecked: Frnr2nReAQZ+1NddDC2Ci02YaKghGaVSr1Iri035gAovcPhbJeCW1kaa1Jh73zw1DXi6oGUas7FAaNgdZwvbUOLvNKP5/hgCashrokao+9i6tXwdjp7Gak/0f6edmazZ84NTF+mUpvhzv0H3xMI6huOIRqVWiJCfMhyOGPlMMQOlCypELHrBIbnFm38fpB7GErkHX9sFRfFJEh8689Lct8k4TeE4yoLEvHkLfPzzWcjBQTn/3T7v2MSdWsvrl1P7TVpwlGoMGq71yMrjMdV/x7pmKAFlMf/JT9FZHtmFicDe/OApHokBG0srAJzNtUsNae9tCwF/qQR8n+PR+UeRQg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: vXXlb2W93SEYSpCLgesHHf7SX+DfDThb6ycoJD4fiTFpa/dHyKSVdrnauo7O8HubmI3j3+8eWJf5Jr4Esd72oKXpRmqZvHed+LA8AGLYbLPuDbx8N3JM7CU4DSiSQDCJkK/1gXhS0+eO/5FuMYsuB2SavqyXh0ZTI3cBPRSyudBUyHUJpRilqBEq6I8ohAJCTQygOlcVy3J/2gNUQ/0M3i2sBZvQ/orL99v01vTSbZfv7f5ll3JLZ+ZYT+ldmxH/D3h2jnsfZfkavBx2lxO58N4x1QYtX8fd3E4zivuvsRn6Ov4aWgAmHgg1zJt1aM0KkcnvZk8ZErhOFyl93eM79RNx+2iXgqX6jY9/JKs01LKocPM0IkMD623RFef4vABTn9KCMRrkkPDcdXEzmJbfRR7/YIwDK/3V81A0uAHFotAMQ8wTu18FTMDrwRrUyEVX+xVL92dnYVxEL363O3cNPRqoL/QMbQXwbBrE0CfApC2g5+a3mlrvpM3Z2HfuUc1VldLkeXuImll5JjZSIAcjPOdHktXAPkJAp0ONx/+gCsUii09N0l331VF5gcoFHa+yrm1SHLgue74vhxDr6MYSz3UaDyrQOLL2YRsAahBeAHiM1UvUCGam1f/AcPzD+y+3
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3778642-5ea3-4442-325f-08df2e96be7d
X-MS-Exchange-CrossTenant-AuthSource: SA1PR04MB10065.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2026 10:41:48.6500
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VRz3anAjrQ/ltyTA28ICRKlQlraUKiTjR1Bf3vsyVl/0SVDOZ6RyIpg0jYwRu5owBC8RyAOcgLHj/Im+3zwR6dzPpah0RmKi2U4/C9+GrBw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR04MB7513
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261020_114203_327862_F237FBFE 
X-CRM114-Status: GOOD (  18.99  )
X-Spam-Score: -2.5 (--)
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
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Oct 14, 2026 / 19:00, Andrea Parri wrote:
> Add regression tests for three nvmet bugs fixed by the kernel series
> "nvmet: fix stale data exposure and ZNS validation" [1]:
> 
>   nvme/071  "nvmet-fc: only send read data for successful commands"
>   nvme/072  "nvmet: zns: don't leak stale memory in zone management receive"
>   nvme/073  "nvmet: zns: reject a NUMD whose byte count wraps"
> 
> The nvme/072 fix is already applied to nvme-7.4; the other two are still
> under review.
> 
> Patch 1 adds the zoned null_blk target setup, cleanup and zone report
> status check that nvme/072 and nvme/073 share.  Patches 2-4 add one test
> each, with a small C helper for nvme/071 and nvme/072 where nvme-cli
> cannot express the check.
> 
> All three tests run on every configured transport.  On a kernel without
> the fixes, nvme/072 and nvme/073 fail over loop, tcp, rdma and fc, and
> nvme/071 fails over fc, the only affected transport.  All three pass
> with the fixes applied.
> 
> The tests take the next free numbers, nvme/071 to nvme/073.  If other
> nvme tests land first, I'm happy to renumber them and resend.
> 
> [1] https://lore.kernel.org/r/20261012141239.156408-1-parri.andrea@gmail.com

Andrea, thank you for this series. I ran the new test cases and they work as
expected. They all failed with the kernel v7.3, and they all passed with the
kernel fix patch series.

Overall, the patches in this series look good to me. I made some comments for
further improvement. Please check and see if they make sense for you.

