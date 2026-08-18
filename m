Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC9D0C5DF67
	for <linux-nvme@archiver.kernel.org>; Tue, 18 Aug 2026 05:38:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:
	Content-Type:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HAvIw+lMrMEIFIeniDiF1iF8IAsAfRcGUJpZijFtAp8=; b=M1PAPC1KEPaO0U+3xpoz7YyR8h
	vR+N6Lag0NvMMOQh3avI0qRR5HjWHGaEEYyJ2D8bI/7pHF96IH7ELSIDPWyA8BgBMQgJVRCpWrdNF
	0b1mH06bzXYWm/SqsA7FNwtNnUdttniCF8faQ+xTb4hInaXV41hCWKcEHaobqzpO4ljyRWVVpen2C
	WMB0LjzohP0Pn5hnXaON8U1+DiwT5tavx94hOCDyClr/Y3ilBxbukybg1Mlpam/gf2nIH71a1PMzA
	vd61no79FcD3ep2tNdj0XAultlSui+QLo0S3N6USVsJpZqbgea/DvCcPnIQ+SVeAhj9+9pRWsSVvy
	OaYepepA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wwCXG-00000007MAh-2N0i;
	Tue, 18 Aug 2026 05:38:54 +0000
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wwCXE-00000007MA6-21kd
	for linux-nvme@lists.infradead.org;
	Tue, 18 Aug 2026 05:38:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1787031536; x=1818567536;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=l52DjhKBPRchSumtpg80TA+iPTgGFB6FezzQ/TgGyww=;
  b=rHE5pQ0HTbOpPqEPGI08HY82tshkRU4HJ/JKBCWRefVucXr6dDWUEcq4
   wVVeUGt19coD9YTvn32mve8BIrUuybCPYdBWDr8D9b1STQe5bP5d97SyR
   ID05eP1lDp0TgmerXhbU1OBZ0s6/oufbOLJMaP6AZ/Pc/08l82SSjfrkM
   uwloEY6Wm8+FxuFVXImlftKHCnO9XYyb+8W41uxdNGdsmXtWcqmxMK9hj
   EyJkto7O7SkSChnk07cdx6Fu/t6YjnKUt4bq99kfp6qLz7h+2/oZvZM3X
   Eiv0Qno6mMIVDS+jQrr076lxSX92jUuRf45/RMHhNMJBsZJFA9DWkLSaR
   w==;
X-CSE-ConnectionGUID: dYUkB62VQ0qbPxmHmwdOOQ==
X-CSE-MsgGUID: QVIzZRpXSwmT6E29bCQkEw==
X-IronPort-AV: E=Sophos;i="6.25,230,1779120000"; 
   d="scan'208";a="153455744"
Received: from mail-centralusazon11011038.outbound.protection.outlook.com (HELO DM5PR21CU001.outbound.protection.outlook.com) ([52.101.62.38])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 18 Aug 2026 13:38:55 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iXnBaNEZmmKSQwW3ClrDn5CBGTfBiqi7B0Ct/Hy502s4gsLvJUA9jpPXbmTFW147cfW3tI7RX+ulbh0t8e6QkDfvqzt5QU3XlUMUmvZnOGP1Q9Qi/Us26zfQctKnNrUWsHGTbtP5bZAbFC5vFeRUAhgUrMJ+NIlFg8pWwCl1nXwZvf4eOMWyzfLq3QQS9RXLDYXTEzJ5Yy82jSkbDorwN8YcKoRupu9E0hycWlbV7/vJafxFtOKUlVrQtgBlGfYWhvoRdqA4ktlFcuQn0fKzOR49bltgk0m4pfji8mE/nEcStyWyJZRXqh17I4vorrvqlvA2kl3fV8JlyxewYzQzjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HAvIw+lMrMEIFIeniDiF1iF8IAsAfRcGUJpZijFtAp8=;
 b=WjQNQXeM52YYR16n+nyaHVUbGfzHrfom1UuNJ5lXrFEjKRGYDyHRF/k4Er9NToFHPq3qZlg4kzX/jG6NSbl3vgSN0gPYAkWP3GPMsZz+K6U9QbyYzCeSKsh/kgQsNDwpBhzk8We6M/nMDSAVfnnpsq83brChxBM9UIPIjXqS1u/BLfHkpBF5gNKrKDqE1Bp6ISCsy8942sTYrnbYg9xcuTN9ZilvCj6OuAuBrQYYp9BPjp5Bq6JGyOWws4sch+AlOPu0gcxKOl1NWfDLIgK3ee40tOdHqVXcNnOcrFEFlQ/j63Fdfua1vVowc5XVuixvKvczamPi1XJaDuntNQVjQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HAvIw+lMrMEIFIeniDiF1iF8IAsAfRcGUJpZijFtAp8=;
 b=eaw3QY8H870U7svNs7cQPPPHI89AFty3i7WF7hAXhgdx5XdNU8uMKt5OM0Azd7H4wiSiC/+jtfpbghRZbtW+VrzXYIIZdUqnPJ8BhcdFcmAR7wJ+Y9iLUQKFTWpoyFDTZ9meulXpC3xx6Jg4ES9mXRgL1Irb9t7GZjEY2GPbCyk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
Received: from SA1PR04MB10065.namprd04.prod.outlook.com
 (2603:10b6:806:4dd::14) by DS0PR04MB993626.namprd04.prod.outlook.com
 (2603:10b6:8:42d::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Tue, 18 Aug
 2026 05:38:48 +0000
Received: from SA1PR04MB10065.namprd04.prod.outlook.com
 ([fe80::9b98:bf8a:b0b1:ef85]) by SA1PR04MB10065.namprd04.prod.outlook.com
 ([fe80::9b98:bf8a:b0b1:ef85%4]) with mapi id 15.21.0315.016; Tue, 18 Aug 2026
 05:38:48 +0000
Date: Tue, 18 Aug 2026 14:38:42 +0900
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Xixin Liu <liuxixin@kylinos.cn>, hare@suse.de
Cc: axboe@kernel.dk, hch@lst.de, kbusch@kernel.org, 
	linux-nvme@lists.infradead.org, sagi@grimberg.me
Subject: Re: blktests nvme/062 lockdep =?utf-8?B?4oCUIGRlZmU=?= =?utf-8?Q?r?=
 TLS inline send to io_work?
Message-ID: <aoPuIUSQvZxujmv7@shinhome>
References: <ajtk1CaN1pBreS4O@shinmob>
 <cover.1782436781.git.liuxixin@kylinos.cn>
 <8803a2bf-3f8e-4ee9-b6d7-5467bfc1b1ce@suse.de>
 <reply-hannes.062lockdep.20260629.liuxixin@kylinos.cn>
 <reply-hannes.062lockdep.20260701.liuxixin@kylinos.cn>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <reply-hannes.062lockdep.20260701.liuxixin@kylinos.cn>
X-ClientProxiedBy: TYCP286CA0005.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:26c::9) To SA1PR04MB10065.namprd04.prod.outlook.com
 (2603:10b6:806:4dd::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR04MB10065:EE_|DS0PR04MB993626:EE_
X-MS-Office365-Filtering-Correlation-Id: ee731f07-0ced-45e7-cec8-08defceafa12
WDCIPOUTBOUND: EOP-TRUE
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|376014|1800799024|19092799006|366016|10067099003|56012099006|11063799006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: cSTqFil/4XbFPFMnJBpc6eeewGcgoJUctHlp79+Syg1jhuWrFucMePazr50fBnuwwRTKAqT9xvv3PgkG05LzrrEONUWrZFa4OUXGQlM2XPLB6DOaV4VVMwEP56Iv31H5EyiXlHsFBonfjfbkzsuYLX1QDJVdAqxId9UbaxRFM79O9RA63BsQoF6Lz2fMajGlECTNMZqqSMDWKQpHcUBRXIoUFqdKu9k35GCvFzDoKB5MN+A14MhW/3Wx8iW6qKQm1BGVFb2oS9p9p4SohmvMFP17wFF3A7N2uDv8t9Dpfn7xHMfqgPNC/a6m634XxYYO4vIMrk1TRbsksCKKz6fa3PgYwZLUE2kV7Yi9mlswfe07LOhwJ032ND9mN8EntFfuscXO3tCI9kSdgQrSdOs5QIpNqzn/EjkABqB6fsAANlz4Hk7aKOTD/ao8v6rkXhrJaLIrjuY+bnV7V3tkIGCpmQRgPm3AZRb5dQJWR7AUinZmzS9Q/0NwJt7yg33o1XeUP7nQoSuAxwj9TTdP/jQifMPt5DXYn/WPhPJDF04ea5/O5craozxMSL5590dkDap9IY6oTVURJPBCql+kPA5vNH1/2e/0RnsqC9ln+UNYz+6mH3UqOB1dV8Wbl7391OE4gSfHbDqGQQMo7jcXvtOtzv4iPWhh/gGuBrPwtz0dWPQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR04MB10065.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(19092799006)(366016)(10067099003)(56012099006)(11063799006)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?foDYqS56miEY2QsABHE2pt+/zCTCmpTN4btfF3sV/slnvHT+Wvlhwmyq7zp/?=
 =?us-ascii?Q?Ln/YtFy3mGm29e+2zkinATGJkxHFcVzdnU4po7fHdoQRb09O4Kl+ozWTFefU?=
 =?us-ascii?Q?YblWGvvz7PZo4cFUTwQmVAE4Sx/dTt1xARMO3eJ8EVW2EoWCZtVI8EkUg8AB?=
 =?us-ascii?Q?DR5MTbCEGyVnm5rZqnzUgbqdVn/AFgIfoBX/jjE36ObZG+s+vIP1rx2RrhpI?=
 =?us-ascii?Q?WSFfyqLuPsOVpsOCYtsQkvoiLLlIN2zeUTwFsx0616XTRFe5NXt4w6iIU7L7?=
 =?us-ascii?Q?N46vDqZ2rtVnK2AvtQ+pkIFpB8UVDkF0rr8v+KL4eN7JE6NSb2WuKq3x7kZd?=
 =?us-ascii?Q?0AqURnZwwkWYCg8aaJ0/1OIso1WTG4WR4YqeCt/KhiBKUDtUdi9yTr2SYCAB?=
 =?us-ascii?Q?e7DE3n6w5mgP44FTXw/noZ8ad3pOK9zoPa+W5MQ35IaszAKrkMdBUp78LsA2?=
 =?us-ascii?Q?fDNr2AHEhoHQqdSGWRd1oI1hXRDpUaKWVFmH/WiSGhbE4LVrP4tmQzx0P4XF?=
 =?us-ascii?Q?p/Au08dVwh3lep220RBfzIoQCMR5QMXSMTzbuxGzZRin7IYcSTG6NVFo2BfR?=
 =?us-ascii?Q?dcGLAHAG+oWUYYdypxVcGE9koCJH4v1hT5tBteBFiSfgcE9ue1Z0HiA44Wz9?=
 =?us-ascii?Q?P45vIAVPnPpi9ta+uNSm2qN/+zcK9Ij9MCO++2/2rGvzwKIVwzFc6gkM0Jmj?=
 =?us-ascii?Q?aOBSlQV1Dcv+zfLISTKx1xSB992dF70uGEnVbH69UAx7Iajfe8v2peMIEGa/?=
 =?us-ascii?Q?F922ryiXhM3VD3H4b8xYilOEo8y07zO8b+A1JtXeishwro0wU/+TbJqs0+t1?=
 =?us-ascii?Q?XyMqEtih6m2Z1MPToXb3rXK/4dkQIIhDK0njOpSyCz5xTPgeMeB8+4TIF+UL?=
 =?us-ascii?Q?JPLWoZeeTqkPTtqqOSXzJu6wvAHlsFWU102i4SUPooNpRrxK8ujwB+C9nRC4?=
 =?us-ascii?Q?dybpztFViT9ZbwLbtp2QQrncu+rNliH+sVYltO8fZXR/3rIofgGdkUV9FiB/?=
 =?us-ascii?Q?gWbsuiL1+GQnoEr/0R+NCfp3mmsywGE3IYWD9nPujtoDn43gOKM78s6DZULj?=
 =?us-ascii?Q?cahyNsdeon6M6tc8tfROGIgATzVe3DWA7thU6gS4LJrNLcVVKNfireOXmTta?=
 =?us-ascii?Q?7m236J2/QKtd7pztjSWhtryXfzl1aikiSHRJwZI7P2vDUD6vYqz0KUtHT+tB?=
 =?us-ascii?Q?Fj3JlwmfvPhjx/xXBLzW4mfoVpsIO7CtJpFSm5zjL3I+ABR0URCGSTMsUR5H?=
 =?us-ascii?Q?sdFqUViKwC5PJnNrKftUO3DPiPoKi8Urlt53fS9hKwK7UW8IKAMSf+nWuWGX?=
 =?us-ascii?Q?ry1bcLO618Kd4/Rs70coK57xAP4r6nR0RljtkXBqy/9OfqfH38zUMjikW5Zp?=
 =?us-ascii?Q?LgaS1MHbbDFvmu625MFWMegRDvTYtrHKruifSSeVSvGYAqpEg9z/w98v3vKz?=
 =?us-ascii?Q?csbICDrWN7QEzWKMHsuMwamL9UphVnrQZ/oG/cE1nzEnmvwb6DX1nRpY4DsG?=
 =?us-ascii?Q?PDpmDTR1uurt4AoZBgt8+xyblFh/oBbYQTfjOyr993v0ioIv8wJze1jvMKvh?=
 =?us-ascii?Q?cclWb4qQRRp5mdR+iOS7QI9gxBzI6wjzanqzReMSsPJ395hFKEuc8XWjZVFC?=
 =?us-ascii?Q?+QYVVr22/sz6mMHZrB6KKqCARZN0I6qc/nRHvhM4TFdx8dvVbc72/UlMMzBE?=
 =?us-ascii?Q?12EoDXzKIQ3qegKGwyPDcX6CqGqCYGF5ELzu4HxacaHA7SH6k55m1ZBt25pB?=
 =?us-ascii?Q?z+XvBqPl3D3VBQjdw1K37iN10nYLeqE=3D?=
X-Exchange-RoutingPolicyChecked: F9dmWfwIhKaywkIp3WSEeS3kPaTiBU2/SoSdlcQ6iE+6grUFQ/E06jx+oX2rTnZyen+KZuE8QtcymZT+uDLFBGlQvCoxlTnuCJZv99mPCYe8hoq8lihrIenhVi2eUkdCIMVeNniC3CJlvo43mVWJjNMBd5shvI2y9RDCuPZO/4gUXd8PUPohTNOdmqwUvMYoJcWSHl+YRxvsdW/PKzkfX75sNLJkrSRvIeEE1HNfHGjDUzfjE24pr0omIe+6GG1XDKS79s3B9RNMuQZWbxSn8mQrW5Fubvgkdmti+Ldx54NUM9kONwo3iUJla1DmF0U8oiRMYSrdF+N6o5meqyWBVQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: s9OWdpRuJeWunQdSLLDHiDiWLXMHWXxh18g1ZKD7I/PveocVZ4CXoFkadMyqCDs9iu9Ld+U8cB1e0kCIF4m9BOPqJkP2zny2zC886nmi3OtgyiS6aUy8AcBg3fymXm6MOAqjFRKiros+BA1bWNOr+9Yzu6FYQ3lefVAaVv/ryF2LsjobgpX7iVzNTIlSCh7WZGmEpZyAJehCUOSoJVbD/nmJV4FbBpOtKtHBaF6bTEgmJV25BXgnDm1MzCPxAxRNU+vPevcG/uVLRDmfGWphqzPTjEck75KBhe1ls64/obV3Wu9FvPTfJLuC+z2yIO5YOHvKIBsDHuJirnfh9MGYA8BFpfMej+VWpcBgeEvecW9Hkh1hadoH6Oy/a3RTNfeBfRMkS8FokpYhboSTTM/jbNdzz7SM2Zd61GCNd0TKO11VjrQALP+rV2kOc2tzeGTJKI5fw+tdiBH6E8wBQyjT4x3heEmbPrHGQ0VtknzKmpm3pXtC1BkZJgNQSB3yq+3CvURs/YtyDsLN/FM8aMQ0wmiNPrWtTtP7gL+G2Wbc881xRpf9/FpIKTgfQaTz3TTjrSlzi5j2vP6gJ6OlPJgRRNxAcErquA/jnSyfkh/3DlgN+ZeRsjZEQN6JmgsGfkgR
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee731f07-0ced-45e7-cec8-08defceafa12
X-MS-Exchange-CrossTenant-AuthSource: SA1PR04MB10065.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2026 05:38:48.3347
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HOE8jQbSoek7GO6kxWDwzyhFEh250Mvk6DniQvZ0Y9bHolTQZ7vVQ9kdIlT56G++zvstV1BPtRuGN+xt9bD+PYCCpkyxBViYa+B8QACyOCA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR04MB993626
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260817_223852_573907_A448461B 
X-CRM114-Status: GOOD (  20.42  )
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

On Jul 01, 2026 / 09:50, Xixin Liu wrote:
> Hi Hannes,
> 
> On Mon, 29 Jun 2026, Hannes Reinecke wrote:
> > The most likely testcase showing regressions would be having as many
> > jobs as your machine has CPUs and use qd=1.
> > Just a single job will not be enough to show a noticeable difference.
> 
> I re-ran the TLS perf comparison with one job per CPU and queue depth 1
> on a new test host.  Please treat the results below as the authoritative
> perf data for this workload.
> 
> Test setup
> ----------
>   aarch64 server, 128 CPUs, linux-next 7.2.0-rc1-*-perf-dirty
> 
>   Same-machine nvmet-tcp with TLS; target backing store is a 32G file on a
>   local NVMe SSD.  fio runs against the connected nvme-tcp namespace.
> 
>   Compared inline send_all (baseline) vs deferring TLS inline send (io_work).
>   fio randwrite 4k, direct I/O, 30s per run, 15s warmup discarded before
>   each mode (10 runs total):
> 
>   - iodepth=1, numjobs=128:
>       baseline 54539.4 IOPS, mean 2.34ms, p99 6.02ms
>       patched  54529.0 IOPS, mean 2.34ms, p99 5.99ms
> 
>   - iodepth=128, numjobs=8:
>       baseline 54632.6 IOPS, mean 18.74ms, p99 47.08ms
>       patched  54633.6 IOPS, mean 18.74ms, p99 46.92ms
> 
> So on a 128-CPU box with the workload you called out, deferring TLS inline
> send still looks neutral across 10 consecutive runs after warmup.

Xixin, thank you for the effort. The nvme/062 lockdep WARN still exists with
v7.2 kernel. Per your suggestion, I applied the patch below [*] on top of v7.2
kernel, and confirmed the nvme/062 goes away. This is great from blktests user
point of view.

Hannes, Xixin provided the latency numbers above. Are they enough to show no
impact of the fix patch? Or do you think more workload variations should be
covered?


[*] trial patch

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index ba5c7b3e2a7c..122d815270b9 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -411,6 +411,7 @@ static inline void nvme_tcp_queue_request(struct nvme_tcp_request *req,
 	 * are on the same cpu, so we don't introduce contention.
 	 */
 	if (queue->io_cpu == raw_smp_processor_id() &&
+	    !nvme_tcp_queue_tls(queue) &&
 	    empty && mutex_trylock(&queue->send_mutex)) {
 		nvme_tcp_send_all(queue);
 		mutex_unlock(&queue->send_mutex);

