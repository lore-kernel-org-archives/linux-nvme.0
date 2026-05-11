Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62B53CD4842
	for <linux-nvme@archiver.kernel.org>; Mon, 11 May 2026 12:28:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:References:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=sNytsJwy0L3qV/FleiDV2IJYEThWiI4DSshH1CDaGhc=; b=HIMHrQgddSA1Ez9nwqwdDhuIdH
	s3DERz79T2xwlnOJEVWpdHs/dy33FkME892aGh+kqMelfZp2ALaCH676zQDer7VZZQLhRm6IsVuq6
	Vth2IySpCzwomi5TUIMcaaFbLblpAj84E0jRKSiZneNvsJlcHnJODk67mwdRcLIxaI6BqDTdUzmBH
	DM4Im8NRVApCZgw3njrtV0x7tbLzLKARhHiR5csR2N5ZK6jT1JPHOUYJhl/bFbLmfUZPMEqMJUnyR
	a5yodmzKZPK8QEr+Hgq47AqL3K6HeBDDJPvEKkutcUokAdx3Y1XKOrP03aJ2NVGHprwEA0JjAXK4L
	X32QQ0oA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMPjs-0000000DWsK-0vY3;
	Mon, 11 May 2026 12:28:00 +0000
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMPjn-0000000DWrT-2lCJ
	for linux-nvme@lists.infradead.org;
	Mon, 11 May 2026 12:27:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1778502475; x=1810038475;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=LOkBQySpKq0SMsvZzaS41fRwmA+Xn01Y2Bo/sFgnm5I=;
  b=cNyyK0SvaC3GfdVoylHe9wIMtGZaepsfdEQNkEx0kbcQNKsRjRPSLbPr
   xfJqEnQ3S9bvAHfM5VQxaHmhuX58prQih0jtcxX/S7Obnmj5zPyd6fMrR
   zKcB0nRAmyibW4PgStsDRTgCf2exW/eonJ079pGL68TPBkc66JykCck6H
   XKluK2eR50uIcKcOEBq86sS0NY96OCvAXdfjWupgv4WO6lfun5wt+Hwnf
   MJT6Qvz9jCh84ZMZBi2wd2artl8xgKzvXhAHcJhCxv5ODHqNYQ5O9n8xc
   ratTgsfMsQhTiXwhH+vKIcLTC9lUe3BATg646wWaCLJcrocCpj/iSIUhA
   w==;
X-CSE-ConnectionGUID: yHUvlafkQ16LGbKcUyhG8A==
X-CSE-MsgGUID: DyhuPucXTqm/q5YvHt5EWg==
X-IronPort-AV: E=Sophos;i="6.23,228,1770566400"; 
   d="scan'208";a="142565596"
Received: from mail-westcentralusazon11013033.outbound.protection.outlook.com (HELO CY3PR05CU001.outbound.protection.outlook.com) ([40.93.201.33])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 11 May 2026 20:27:52 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JX8/jb1JIGFgQleV0uvgWMgqV2w/z98jwrnevROnwntn8gY8pXTTcc9hzFH6b0l5wlV61l4Kjq8YlEMWBoHq67aOKveDNEdfcNpxQt3BaQy16IkITv1WByO+EivJUQrD4JEZDZ1gB7Vn8PqoFc86/b66O33Rk0DCakcPcKsGvgjK5PEXkEadTm5GKSEI27YPRZcRlv69a3u+g5PRF2mfSoWtKduXIQAtiMyhzqb+BqQNs9+5HPTpYa+GdgsgWyDoVxvd8X8uSaCZPPwXTpKm8lvjB9gyCb0Dg3KXwk6vOniGIdjRS6RoK7/DUdR0Bk9HDgAJgi0lCQNzocifHHwBxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YwkeKh8HPSpttF5kB5ZZxHJU9iYR+0P/zjSDNY7j8SU=;
 b=Ubvj2Gk89xQROFSee88w3wI4VzCrG0nwAzWmQEvZN52vjBDtz8/HyyIYZaA6WzqhYjfuemEik0j0JAiLViOdzoRPF6yoULB6NTy0ZnKkiXYfixTppEIc0w8v+Xc4mIr23n3FQVUqou5wCnb/RcmHq0/ZexC0jaarO47NYv1TSF154X9wio9vW7FqDRx4zMZuklwGzB7vNfUFwUFWPVQGgxbWsBDIiZCtHbupZYD7csNNkF7Z/ssPsrCDNV24HS8aOkbItWgIXN6/sP+E+NyhLKd/SWP6WFtF+rVwDa/IB8ejY+GML/j1LZEckGRCjbM9Zj9fmYs8selRN6FjaOO4TQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YwkeKh8HPSpttF5kB5ZZxHJU9iYR+0P/zjSDNY7j8SU=;
 b=WuZCDwLj5Vw9boBaqQSnazYxfBm7oHS/jh7bu448hj7OVq8nF4EGcEbtXaA3cdfDCDl82WhLLDFuMXiMN57vmfktiHWcJ27G42GNd/jGHRNR3fDQekl8wo+mMD5ljI4o2hK87lGkTUHgj8pZl6Mp4ivulxxNVbOVIzE1A4uBEqY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
Received: from SN7PR04MB8532.namprd04.prod.outlook.com (2603:10b6:806:350::6)
 by SJ0PR04MB8259.namprd04.prod.outlook.com (2603:10b6:a03:3e7::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.18; Mon, 11 May
 2026 12:27:50 +0000
Received: from SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::ce42:7775:2df8:8729]) by SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::ce42:7775:2df8:8729%6]) with mapi id 15.20.9891.021; Mon, 11 May 2026
 12:27:50 +0000
Date: Mon, 11 May 2026 21:27:38 +0900
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, 
	"linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>, 
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, 
	"lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>, Bart Van Assche <bvanassche@acm.org>, 
	Daniel Wagner <dwagner@suse.de>, Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>, 
	Jens Axboe <axboe@kernel.dk>, "sagi@grimberg.me" <sagi@grimberg.me>, 
	"tytso@mit.edu" <tytso@mit.edu>, Johannes Thumshirn <Johannes.Thumshirn@wdc.com>, 
	Christian Brauner <brauner@kernel.org>, "Martin K. Petersen" <martin.petersen@oracle.com>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, Javier =?utf-8?B?R29uesOhbGV6?= <javier@javigon.com>, 
	"willy@infradead.org" <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
	"amir73il@gmail.com" <amir73il@gmail.com>, "vbabka@suse.cz" <vbabka@suse.cz>, 
	Damien Le Moal <dlemoal@kernel.org>
Subject: Re: [LSF/MM/BPF ATTEND][LSF/MM/BPF TOPIC] : blktests: status,
 expansion plan for the storage stack test framework
Message-ID: <agHGnYHo4HEKhYJb@shinmob>
References: <31a2a4c2-8c33-429a-a2b1-e1f3a0e90d72@nvidia.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <31a2a4c2-8c33-429a-a2b1-e1f3a0e90d72@nvidia.com>
X-ClientProxiedBy: TY4PR01CA0049.jpnprd01.prod.outlook.com
 (2603:1096:405:372::14) To SN7PR04MB8532.namprd04.prod.outlook.com
 (2603:10b6:806:350::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR04MB8532:EE_|SJ0PR04MB8259:EE_
X-MS-Office365-Filtering-Correlation-Id: dede7fa5-9fa6-4e83-7706-08deaf58b654
WDCIPOUTBOUND: EOP-TRUE
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|19092799006|1800799024|366016|11063799003|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: T/cTLeHqPBkvcHJBle8TQ+z5MtrdEQibUs/evsRc/0IMEKTYDcWKtPrCJChU/u/F/GA48JF645DrLNlI50GD5h0EMB/IniRp4rnRq/viuB9uT5bVlFuNBIhUAh9s9FQo7N3AvtDiKBTpuXa9x+PC9I6Zv0PjOQkT8xuSqgBGSNL6BteRiZr2ePjX3i+MDt6uQ/78IlXPougBIlAHWNBE92cAQRSGgH1zUe7llvvsy835R+iN2gI5SXZPs0GM4JQaDlvGk+OpfvodXvaZ46J9JawEgDVNR68hAYSfHMU685/D4w3FcBeJyFK7Q0QuBDh+90Rv8z1mcgdH3XXrKWAlOcpRsuFRBZUbHI6GjHhSxlEA60a+n7g/O5BztOF88pRDNZT9PxB3KQVEVFVvaJfflYRtPwvRGIcZKsrGJgZ7dvMuv8vHzgIlKbyThidNv9BDOjt6PgUoVOSneQ1IXidPni7a1SeBdcdb29PF7le3Vi2KXo8od997C7Fw3vwBdg/Ze3hj8t4pRZk0ErMpePM9MV5zof+8JQJP/hqPrqvG9JKFVn9r2gkRyxaxibebpWcWsGpaSHTe+FhxtyFiSuvjiMm5e7acCnUDbn5SsWtWmUDL1SMd2ZznEsYbWZs5ga1wZtsZU2Oa6yKjgtI/ZWvp+Lo6zcnRfGFkW0ICmK41+Jl50giTs0FpakpKeotVkyMir1t9gm3iAjHeAu545kvvJw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR04MB8532.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(19092799006)(1800799024)(366016)(11063799003)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?2ffoo//z3kwZGm2xBRb0Gb7m48RskcAKWBpFTpbla6Y4NlAa7IAJEGxL21?=
 =?iso-8859-1?Q?RHiXy6DiG15Bm27udsKePBGNbqPXwxlBeDzj9Kn0GVyZDAX46vDEmuxpCT?=
 =?iso-8859-1?Q?DFQmzso0o87BHybwPOUqRgbo0ESJg7V4SprDTnaO5IRfgmWG1+yOYtibDg?=
 =?iso-8859-1?Q?6ZfnrmztOBPOULHG2WVtlo/mBDqR4JyG9hLQdSXirUyup5euPXXFW1CyZ/?=
 =?iso-8859-1?Q?8nEtpKR4tK/MIvCF/GRh+kte1WjzKvA+GHGInnFO7lddRB8HTLbLEEAUwN?=
 =?iso-8859-1?Q?v+LAr7O5AzEXw8bzsneL7fJFSZ+pfrgKVhcoMhNT7g38TgIlJtStS6bFyT?=
 =?iso-8859-1?Q?fgsJWFV6AlhL34TfC3fCZIi8a2nF1mmBDD+NT51i5GFHSB6bMsMcnUf58E?=
 =?iso-8859-1?Q?fRrrsiG7vgU3Mjacz5q86MLObunF3nhFuPG181c74iFthfWVzxU18FSdM+?=
 =?iso-8859-1?Q?y2drbVx9/5MwLUs77K10Vc3tNNd+00haB0qroKugyajvPI++aJ1wO2qFVU?=
 =?iso-8859-1?Q?Okblmo8jA6JCJkscZs3GLQU8xd9VfEpghmInOLXO4jpBoYmnDUpuvsWNLD?=
 =?iso-8859-1?Q?rXrK2Njld/ajLMyW8ZIy3BPGVIhU9JUO6P9X7saxJ+9v/knG7a+SuIo14Q?=
 =?iso-8859-1?Q?f0AUMQS+TLMEyCAEz1JsAHr8cpZrKKBS+vm0K1W9DA/X6z8X5VZ48mZzr3?=
 =?iso-8859-1?Q?bmK3K/RIbIyu5yfvisy/KTyDmCwqZD8U71C56I8pC1gMo/aSuT+g60WFFf?=
 =?iso-8859-1?Q?1siJw0e7IRrSzOXJ3Zt3lCI0hhNVnSra6LdifU+vD4XZcOJvoS6kiXB8ta?=
 =?iso-8859-1?Q?8Xj2DiC+M+QmLTulLbLmeboJBS1w68wSzSJZFuc6F+Wgzsv9xc3PtubQpT?=
 =?iso-8859-1?Q?bEXsZWl3OzbZyieMt2sd+xbDdJV53Y8QINRxGzm6jzHwcZZNxXsNskUwqp?=
 =?iso-8859-1?Q?hi7jfaVXRArKM/WfM14qy1KJNRnok/6m40VDXk6/Eqyw+CLzJREut7byQf?=
 =?iso-8859-1?Q?C5r6hlY8Bx28HDv9BmES40IEH20q0ii5w5PO/rwbM9a/exraj7XyOu/Dwq?=
 =?iso-8859-1?Q?qz7KcLRDXtGch6TwOvDvC/p1M9W3Fukqz4ZnKdIfpKKKr1RtmWOLc8okr9?=
 =?iso-8859-1?Q?9pj1JiYYu/Lnxfd5dSF9C9K2t5auvypsV0mUIBEfg1lw1Vh+o8EFOEyijU?=
 =?iso-8859-1?Q?szd+fEETPfDMM2GRcQcv59Jczrm90wgl9RWV3ft+omys6Q4yaXIesNTpeC?=
 =?iso-8859-1?Q?yv75tUpjbUQg91q1QdY4luJDkKk09q4KCpJNxgiiUedVcKUnhZT+eWUh/p?=
 =?iso-8859-1?Q?vVCdKDT3jUhepLP9M36FCAdpTdHP2K9yN3GOIHqSlkjwENK56RMSDBg6ir?=
 =?iso-8859-1?Q?np3S8Ns4oJUxBChx/T8jB5CgRxC6lOZfZVLQEplbk0ACDXRYwDjZYCDyFa?=
 =?iso-8859-1?Q?gdjd7v8sr2JnDAOvE2AGW9EGQjkAHTvPZsywabaoLvd0PRSZXHknd5vf01?=
 =?iso-8859-1?Q?FxTGvQmQLpCM2WNhbcKflSfFLcpa8ofHY6VQ9NxaaEdpMqRvqw7Fa9xlYZ?=
 =?iso-8859-1?Q?ZEySLJnlw5Ce9kOb5wfB6vczYBJc0mxN9UWztOmzJfuGq+vaeivCphUmNG?=
 =?iso-8859-1?Q?y41V3TyNbdXr1tX0ZDrrX04IuYogy6o4ZE0yi1HMqETM3gOPAzGM4xGj4H?=
 =?iso-8859-1?Q?MpCBmEGTf6P2gpcLhrmWzN0WGZe3+aisOpmsO2poce48pGFICi1VWw3GGv?=
 =?iso-8859-1?Q?N6EDcpxJW56CUrOGYJov3RSUe0qWqwH03O89NsjCQ78x418fss69uGmDB9?=
 =?iso-8859-1?Q?wa1TAHnha1jxAuhjsi9sTopISLKkbKk=3D?=
X-Exchange-RoutingPolicyChecked: YQ8tVr4FUXuX96bv90j7vEjBHV7TlnofiJLpknsYTe/0vU2wCikab4O+lkdwr+ErOYqwaSy5htdA1QZklVPXLbNYwakwfSfs4vv0RVT/aSLnsBcT+DP/hasyKKzhZuvRTiJ7uTht6C08BomxrXiz7b5MvHAH3O5Gu3zS0hSOj/Qor6/GvGjPcfm47LCV2NNTdJdt7EvuwWPDpTzsy8uPX36tGC1HtFwZSL3dnWDopzNiK0UWFbm2r1FoFSsFeg5W3vJNvjeNtYKIwos1BNe05eRQXyaN2EnxZ8ZsVQ9VpG1Ml6QrrTEtQCGDzlwA/ZtDIkubI+GE5l5CrZ15DwW42A==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: oOZp+neYj7jn3lZD8c/hDZDN58oxy0Xn8Jf8DtbAcobAXRSiTBs+iwil3b8cKyqpnnHjZhmWJVIOHY6kHgUw4qXUC1ATNIEBtmm+IIBJItBT3UY23TUhYBEoYiAhEZ26TYjvIeH50HFSYtyEUlkaTGRrPKv9sW+x35Zd1M1KV7fN0RcL3ctpkLhlbrgjDrpsVHzX2hTti4kgUYdUMluRE8NzWJxbIB5wyBHt2CxoRsfIEo/IEmG617rw5gjzPyFSL34YhYfdXI1WjUHhyEXQBw83wnDlLCN2zxoDlofcvHkF8LxjYvsPJwsrQYuCHU4xYhUpguOeUHmVP0bwoj6qadBcy0njj8hztz2rixVKV0EYmKQyy2ubgHial4FX/6Z1TurqI0XEnzFjAnLnn+m320T4+6aMxdY+HvcCZLPxxz12yUnVswZbWc/x/9gJUZhLraxK67eSh7/kIjoxvdeLnq9UlPaik77t8PaK50Qprfb6bavFuO0sOf9JkgG8pZePkdSFJ4cq9fPDpbh1U1Q8f2Auc51aq6eWBl/hpf2v10eiEyids6C4/F1yhjFOt+dMqpWaPWVkWlLdk1AVr/nQmWoG0kpRPke1Bce1X2CVJG6rYSjYkZ1tODwvmjgzCZf/
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dede7fa5-9fa6-4e83-7706-08deaf58b654
X-MS-Exchange-CrossTenant-AuthSource: SN7PR04MB8532.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2026 12:27:50.0442
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uVz6N+x0oSjibynn6kKswwi5fwo6zn4U8OK+x5r200wiDTbtMgYWT3FtyXtX3SdbavdjsGRh2ch5197upaJ9AJ91RawJ0xdiOfOBjv1MU+A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB8259
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260511_052755_780100_57FBCDBD 
X-CRM114-Status: GOOD (  20.21  )
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

On Feb 11, 2026 / 20:35, Chaitanya Kulkarni wrote:
> Hi all,
> 
>    Since the discussion at the LSFMM 2017 [1], Omar Sandoval introduced 
> the new
>    framework "blktests" dedicated for Linux Kernel Block layer testing.

[...]

>    For the storage track at LSFMMBPF2026, I propose a session dedicated to
>    blktests to discuss expansion plan and CI integration progress.

My thank goes to the session attendees. Here I share my memorandom about what
was discussed there. If I overlook anything, amendments will be appreciated.

----------------------------------------------------------------------------

blktests CI
===========

- Regular test runs for branches (nightly or -rcX)
  - It will be helpful to run blktests for -rcX releases and report.
  - Ted has resources to run blktests regularly, but it requires someone to
    look into the test results [*]

- Repeated test case run
  - fstests has the feature to repeat failed test cases 10(x) times.

- kdevops has the feature to find out the failure recreated by 1000x times
  repeat
   -> This will be a 2nd step topic and looks too early currently.

- Kernel config for CI runs
  - Please enable DEBUG_ATOMIC_SLEEP [**]
  - Can we specify kernel config for each patch author?
    -> It will require too much resource

- PatchWork for linux-nvme
  - Good for patch status tracking also
  - Should ask kernel.org

- e-mail reporting
  - e-mail address should be available at kernel.org
  - Do not report the "ALL PASS" case. It will be noisy.
    -> Will send out report only for failure cases.

blktests improvement ideas
==========================

- For easier config:
  - Ted has the config generation tool.
  -> I'm interested in it, and would like to take a look.

- VM integration
  - VM integration script will help new users to try out blktests
  - Haris thinks this is useful: he created own VM runner like virtme-ng
  -> Will introudce virtme-ng script


[*] I would like to volunteer to take the role to look into the results.
[**] I checked later and confirmed that DEBUG_ATOMIC_SLEEP is already enabled.
     Ref: current config:
      https://github.com/linux-blktests/blktests-ci/blob/be781155bacf49bf318ee8859572fb7ca1f72aea/playbooks/roles/kernel-builder-k8s-job/templates/build-kernel.sh#L22

----------------------------------------------------------------------------

I also had good talks in hallways, and got two new ideas to improve blktests:
1) "machine readable result reports" and 2) "command tracing" for easier test
case debug. I plan to work on them.

Thanks again for all of the discussion!

