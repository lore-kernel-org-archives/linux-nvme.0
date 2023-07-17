Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13385EB64DC
	for <linux-nvme@archiver.kernel.org>; Mon, 17 Jul 2023 09:46:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-Type:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+elP8oTv8g3H4q+v/grn0braelL5lh8JtPcT8NOBkp0=; b=Iu5m3H2lMfpMECs71faBUaQhSb
	Z3o3ux2MBBjU4S3m+mGKeiI1lK6i50/H8BuIT+eXo9C++K86UIbvZC9toM3n/VFaAeZ/GxTOQcoqc
	aHwCWp421lwU1jdNTIDg6zlSaxEKKfIbDYRQKRad5j4B/6tH8pm26+HjOiHCnaNuy+FYjUwzTn0ro
	5kO1z0GYr7XBtX9uQYfkTd4bPCQdnr4aNqDZkXh1d0zxShn4Gur0+c84/+M/zo/+dJHfpAfb3DboV
	jK1/pR5rmXyaYgwnuw5g+q4XNg7sqy/wTNg2AMlLUlY5n/JwBgH7vfJ5wFgDh/JSCw4onsihpCKEw
	yc5prRng==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qLKnx-003fn9-0n;
	Mon, 17 Jul 2023 09:46:09 +0000
Received: from mail-bn7nam10on20621.outbound.protection.outlook.com ([2a01:111:f400:7e8a::621] helo=NAM10-BN7-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qLKnu-003flw-0D
	for linux-nvme@lists.infradead.org;
	Mon, 17 Jul 2023 09:46:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AA2y8ihugE/0vrVffjJ0KIAvbENRR/vC2MF3Eoy2+RwrLdwAdMAv2xMHNMUUvchPg3ZD2wq4N+1OMwVMoVFK0lHxKi8i42hiT0ER5LefaOTWWhY7BDxfE5AFqHLKJTW9FdbwRy+IBeIy/YBfWzMC/7P8jmmXYhG+zbkJO6Fnt7lkPrhNbCWskIzLBT0idN4oHYLmas+o6UN0dQBJexXI7xHYAXW4qHNofpGLT3q6N1sbKvEnDHdRpX8kce/vYjKHwxbgjotcMaGiwdO9QytcmDF93b0y23VoHwT3xgOizgps1p3Z6Emv8Qk0yeK20PkemHVggbDkzNYAg1OFTfbZMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+elP8oTv8g3H4q+v/grn0braelL5lh8JtPcT8NOBkp0=;
 b=iUaSt0ry+xSqwkpFO9pBpVgcvDn8XBOiMvFCVZN88N+88RO7LvqOa7VXY57ozQVt3htTA/MSLBa6Y8vh6VzyjYUOsit2bLSujCNTxmkktHdXdvdmZLrCRUW4fGfFY0z4XdTFIuhvJ0f6p2aA3or3t0+FgDW+Hs9yz3IRYacb2uEc2sHGmA/k7WJR/kUVHo9QDxkDGagSLqnh9B8Kjl/v8MTZB/iST0TBxZlIi12A+vDOW/fB8qaNRXRSCfH1QCy/ttoWYuFu9gu/drxY8AsLbTgDjo8F66SOaZr7jI6WTQ2bgUNnVWUleedBHYDTSw1hgBMyfJiOO8BkgbFE3F4cuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+elP8oTv8g3H4q+v/grn0braelL5lh8JtPcT8NOBkp0=;
 b=EnFNRZ4R5UVM75MeSgxYp2KKJvyv9APD6TPBuNvqcoscCDZ4hiygYGVOu3F+UVukpo7LVLj81ro+QpL1bMD1zyaw5GYGtE9orKx4hf5cOUBpXC3eh0EUmt5KFfZFNPibrNshR86ELzwE1Scy9pEE2BtOHP9Q1GfLN68iztTEhFkfHFPrwmwMyg2hHXFMP8o87qtdPn+mWvmrytEVGieW8Jg8hpTeKf9MsM4xncBetCfQt5WmS4We9QiVsa5YJ6UuC/OQmAvPL+IJ/7LM4gjOAaDG20aj7OUPcfTA2tTGbwNPD+l41t/+cu5l6YpWMJyIxe/7xun8NVB87V2nxCcLWQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com (2603:10b6:a03:45e::8)
 by DM4PR12MB6231.namprd12.prod.outlook.com (2603:10b6:8:a6::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.31; Mon, 17 Jul
 2023 09:46:00 +0000
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::968e:999a:9134:766b]) by SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::968e:999a:9134:766b%7]) with mapi id 15.20.6588.031; Mon, 17 Jul 2023
 09:45:59 +0000
From: Aurelien Aptel <aaptel@nvidia.com>
To: Simon Horman <simon.horman@corigine.com>
Cc: linux-nvme@lists.infradead.org, netdev@vger.kernel.org,
 sagi@grimberg.me, hch@lst.de, kbusch@kernel.org, axboe@fb.com,
 chaitanyak@nvidia.com, davem@davemloft.net, kuba@kernel.org,
 aurelien.aptel@gmail.com, smalin@nvidia.com, malin1024@gmail.com,
 ogerlitz@nvidia.com, yorayz@nvidia.com, borisp@nvidia.com,
 galshalom@nvidia.com, mgurtovoy@nvidia.com
Subject: Re: [PATCH v12 03/26] net/ethtool: add ULP_DDP_{GET,SET} operations
 for caps and stats
In-Reply-To: <ZLJxfcKFwGN24jEP@corigine.com>
References: <20230712161513.134860-1-aaptel@nvidia.com>
 <20230712161513.134860-4-aaptel@nvidia.com>
 <ZLJxfcKFwGN24jEP@corigine.com>
Date: Mon, 17 Jul 2023 12:45:53 +0300
Message-ID: <253edl6swfi.fsf@mtr-vdi-124.i-did-not-set--mail-host-address--so-tickle-me>
Content-Type: text/plain
X-ClientProxiedBy: VI1PR07CA0222.eurprd07.prod.outlook.com
 (2603:10a6:802:58::25) To SJ1PR12MB6075.namprd12.prod.outlook.com
 (2603:10b6:a03:45e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6075:EE_|DM4PR12MB6231:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c4964d1-536f-40e1-0d0f-08db86aaa03f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FwdCeETbJXNxrOAPk5MAbEFx9pC09M1XlPxReW8mwJIdFONnHB62a2tR/tlDicpVKhR9qLgFC24qNnh4d3AwSJAKrp/1VyCgBBnDb4CB1Hnskp3Q99rsDLnIwORtVifVjDz6kqCxaVfx/tzZCRGNVIbTNY28pGr+K6ZOTPBDu4ot4wjHE7DMOuIE4h6jTVoXvlP000oc+lwzxC0LUNBomFQb1QLd7kK6RkB1uG/cyg5P9it/z1tXr3Oz3MJf4+4A9DfxIjwp0DWt8doqqRY2SFC7evJpe3pDDFRUqIvjcj9eA3N0bJIq400H/qIGTpvt8HRE0VLg+atLAXpG8iomWENAnnzsxc0kmkhN4WodVS7lCy2gPFGE6y7nUQG5+T3WHeD60q2yzRLhPbowqPzc99A2KEMob3CusKh4MLDfxzzB0yZo3GJUUV4q2qB5cnipzuQv7HoUK7Y3DwsyRKz0DFxHSniyKz/DoAWO4baiFlHHl5lapcCWuZTVSzhZyPLx4n7TogjnRo2gBoUn/NySmyyZ/OMrGeeILEWG0m+hAw52IcFSbPgWcYkKqCfb6beB
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6075.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(396003)(136003)(39860400002)(346002)(376002)(451199021)(558084003)(2906002)(478600001)(6486002)(6666004)(8936002)(8676002)(7416002)(41300700001)(66476007)(316002)(6916009)(66946007)(66556008)(4326008)(38100700002)(86362001)(6512007)(9686003)(5660300002)(26005)(107886003)(186003)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?F0zorCxwVky0JfR5AbV6xRnx6UJKIq+f0qO/pIMX9MZavEffTaotaRxoq8Os?=
 =?us-ascii?Q?KJWR/IZu6uPWNTyLvn/NsTjxmxpS5qrcCtcid0eDUEaJgzGtonV1NQTm2Vg4?=
 =?us-ascii?Q?jyD8+SrDxgopFgjwoUxpDaEMJeErAozeqM/goZkrO44PBnWkTvb+zm4G+7N7?=
 =?us-ascii?Q?EXaRLBbJ1aPos8Er//1XD7YLt3peW7BLKj4rx6b3VPY2J2Iuy2bo1De5dJWx?=
 =?us-ascii?Q?nQ/vvcn2zf84FEs8xYqDNLuQrD2oEoJpyJ5vACC9b0OqwCrAG4khf7YmiIVC?=
 =?us-ascii?Q?bPLPb1ua4Y0GsvFXJIoXzkv7eDx8evhm9LvHQx8hiJbvE+nPO6HjbCXu+Rtb?=
 =?us-ascii?Q?h+wctCtKQOimbTVMzKpg1PPui//QFvY6oFIuyH9ncjUu/VvelSPLGwVb7OWT?=
 =?us-ascii?Q?qVh/f8tKEiSsw9i3HwrS4UIpgHHnmOpOoCS/BSlYwK6tMz/t2xH19KhPoUnu?=
 =?us-ascii?Q?QYrE+4kLj0zG6EtdJQZgIjEJ0z6+/7SZ70uD0oPm4XzQMKybbHJnsRZDmiAh?=
 =?us-ascii?Q?fe9JnDBuD9rRgijJdRQnb1IUfVhNBFMoGn/6iF78jbHU9CALjQalcOJl4/0y?=
 =?us-ascii?Q?i40/Z0Vb8u43/Y57s0irmFauAKJ8/zM/I1CPZlXKSxaPxuTy9H/Iky3RPaO+?=
 =?us-ascii?Q?b+W7auYEswhrcYWef/D7yiH1ZtmaMw2EUEr2FCqKdBJ8DoCURMOeg8ybuXrC?=
 =?us-ascii?Q?ohnZv1hBRMWRCdb6ZCIG6GkyXHk0GvQ3sLrNwt+DwFBPkDfqDwXYwFBzfsTv?=
 =?us-ascii?Q?4bdT4yPyYE2tL8NTZ69aVUCCuL603oTEHQ3/aVWInybqh35hQM4BowUYd/vg?=
 =?us-ascii?Q?SmW6nOXoDDvIjo5woClnLdRojOcXI2exenlM0SRsZcuttNb9QNIul08R52Hv?=
 =?us-ascii?Q?s/F/z/fwBt/vqSzm3xl/u1WWxCVz58Jc8qCXVFBP0IfytrrLMU2hmlzi0cZo?=
 =?us-ascii?Q?BCkXh2aGY99QuMg4ud5twp7t67mLRymOu5ssiqUbBlMuoUrY9RIzaoxGF/ZP?=
 =?us-ascii?Q?DfcVGmy7nijUZN5zYCCYIA1YboD5Wo1AHvtVYIaBkgCUKCY7Qnqdiz+srP+Z?=
 =?us-ascii?Q?BMuFuBCfdW99lvoxo90UKBML90M9ntgRXFr9UbxaPrC14U7wykUws+J5+8Zv?=
 =?us-ascii?Q?aCjHMT4hea9HbVGzvs1ytU1AFiUJcFEAf2DypCNgqIUtMVAewdyh4otwiRLq?=
 =?us-ascii?Q?S9WSbk3xNIYSGdhvq2Wt1NFgVpgEPIt1RDrBsJE67257XtKUcYcOsteKyIb+?=
 =?us-ascii?Q?hDGh3KjBznUbUihsP/4yEJ0pT1bXYaDuX0Uf33cKVbf+htj7HeaTodLeHy4J?=
 =?us-ascii?Q?mTxXCelvJEXevePhwtJDshJRbf82YpIBuRIZ5eHqMw/Ckz3X3xpYxKJsS/vC?=
 =?us-ascii?Q?UVxIetD3t+4Hf/GN3ZZpufmWP14r3urwoa/xNp4EAF3CxwJos+Y4jUC0k0th?=
 =?us-ascii?Q?8m3jVglaV3hX0yzW4T5tYbk7BNkGDY0tecexALSYnNc+sxHsxIKaDNaF0SHy?=
 =?us-ascii?Q?iBtTehCfa/EUHscFi+QFaD3kAePKButja0ma25iusVOUosU3DjLA6gV1cHxr?=
 =?us-ascii?Q?VBZVgMtD27meYQM736qG75Kc604tLAvWATGEg727?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c4964d1-536f-40e1-0d0f-08db86aaa03f
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2023 09:45:59.6413
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WDU85LyTOJEedkJoG5evVqO1FFkBRNAE+gPViCkYhExyoR1Hi1Z/XdeVmd8449y1twXqUGI9M36O2sUUiDid+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6231
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230717_024606_304607_11EC13FE 
X-CRM114-Status: UNSURE (   4.08  )
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

Simon Horman <simon.horman@corigine.com> writes:
>> +     struct nlattr *nest;
>> +     unsigned int i, attr;
>
> nit: please use reverse xmas tree - longest line to shortest -
>      for local variable declarations in Networking code.

I'll fix it, thanks

