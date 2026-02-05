Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EA76ECD991
	for <linux-nvme@archiver.kernel.org>; Thu,  5 Feb 2026 17:11:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Message-ID:Date:Subject:Cc:To:From:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=W8Bed35Y9k4z2Cz9+yiJtGJO0h+jr+Ao2ojxKEGSOn4=; b=slhG0eYlbO3GlM3RooVdpia0YO
	Li09crEcZxGjD+NQozM7VXG2MTM7i67k59Kb3AVJB20S+StpHArs60saJ6nNenQFr4q4///ZHMLEF
	JUxJo5UhWeu1lzXI/iaG2dxDwnUfyU6gpDoK5NvFN/+0pGJ5Yy7a5V7hSkaC+cciQd4wolc44Ojj8
	sGR0rFgrhg9+VKXC1lyiJbaFO/uzeGKQgIaWR/sOk855JLNahtxWyvWQUrgN7OVwOpAQWCxJtNHHK
	Ydnb+kFVzpFBSIYcCGyhqlLn9xhpKCUqNqZMvCfzozJA6O4Nhr7oXgy66Gt2/lRDm0+44+5+rDku/
	JvF7sPKQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vo2tS-0000000AH46-1oQn;
	Thu, 05 Feb 2026 17:11:50 +0000
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vo2tO-0000000AH3E-3Up0
	for linux-nvme@lists.infradead.org;
	Thu, 05 Feb 2026 17:11:49 +0000
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 615Fu4kE828551;
	Thu, 5 Feb 2026 17:11:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2025-04-25; bh=W8Bed35Y9k4z2Cz9
	+yiJtGJO0h+jr+Ao2ojxKEGSOn4=; b=efNfvgOv9oWE+vlv3zIZ3obWTRz9fS8M
	l2MC+XFplkAbapy1UsHwGQeGHDa/8IhJUPTp1mR3+rIij3ZHKtElKpfKdzPXopC2
	S5aKPl5cGE2OsDgUhD30nwVNsmoKJgIS4d9z+dceqDGniu1IbdCadvNazv1T+o/7
	K1ykVLrr2xViM7kxRiXPs7lk0UcHf0T0hjDaU0BK8Qw9U/+7VeIHP6nlFzeU3Ma/
	7wnx5nUdHt54Wy5wQWCcxg2urhq9X3nCVEbPksrE9gqINqGapFv+eNlrwROrliOj
	w2fLFFVIi5SR/DvvSFzU/5VLuZ0uda4teXqskoae4mMQ5khH6KPhqw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4c4d9v1e81-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 05 Feb 2026 17:11:34 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 615GpQtG031743;
	Thu, 5 Feb 2026 17:11:33 GMT
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azon11010060.outbound.protection.outlook.com [52.101.56.60])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4c186dfkmt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 05 Feb 2026 17:11:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bn2tCaAnQplB4MUJcgpU9jhQJ35RNMaibt1GQ8ZUKD/o0gjI6b8v4m1Pb5FNmC/Agksu54nZu0oml4NUpEcdmR7TKDzH5y3KTmm87SVMF1KBcOt6VrO+Na1A9x1wGxuKNo1KHSevMuNviCAK82pE6AoSA50yEbz9knVAgzf87dtGRnx7PgvZPtAuvMIpQrZHdkrTfhQiQ/2oNh1teMRS6OA6tTLBbmHyrHjgEGijW3RVGjzIypJUsIuk4ID75KhXVjyReFLnc3L+uz7F0r1gQRXfAwslhMAwya3gvL3GHy4cbyTsWu6FRv0EMRiXysXMnCAy5/l/p4f99ENDxDlBaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W8Bed35Y9k4z2Cz9+yiJtGJO0h+jr+Ao2ojxKEGSOn4=;
 b=GNIAopmluXd2fl02CerSF2EOqdMPL3q7m0Oa2X4w9DnSd/PWxfZGe+7SWbAVFWz5tG930tPaskN+7SUQyqRAGYCHaMyAuuBFlTTIDSvSRM//iCq2N/dxdpnRcchehDfhZLRCW9BQ+1Ok2AVo7nfj7PxBQMwNEtpKHKjo9gkQTh0NfG5x6Zio2l/6nrbCLDPyLtZ4suUW8UBNiDzsTJy/iRUbEmgyqFMcnhvvLA2EhCfUfo2S0pfn6HY/uUyynpGVx1AEYH4QOt5Uv68grGpUKY7hbNWFl95lpqJqyMB+ZZdoo5N84dAteXyMXe7OXGMdNM3+AK5WNIr9KvVNVp0Hpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W8Bed35Y9k4z2Cz9+yiJtGJO0h+jr+Ao2ojxKEGSOn4=;
 b=F10jSV/D5qUY6TJtwJv4tVyWAUCgzU9UBPjez16im/bHv0zjWOwnoiEi3kEr0FgpVFCUHFdl7FbZfoHO20gkTPLJ704NX6lBuirlk8ExBN9/O7WZnlE6AXezqHrdTd3yfDwf+2/iAEx5AMWJ1CfZYZT7brxAOurLmzMHfHvm24M=
Received: from DS4PPFEAFA21C69.namprd10.prod.outlook.com
 (2603:10b6:f:fc00::d54) by CH0PR10MB5068.namprd10.prod.outlook.com
 (2603:10b6:610:c7::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.15; Thu, 5 Feb
 2026 17:11:29 +0000
Received: from DS4PPFEAFA21C69.namprd10.prod.outlook.com
 ([fe80::ba87:9589:750c:6861]) by DS4PPFEAFA21C69.namprd10.prod.outlook.com
 ([fe80::ba87:9589:750c:6861%5]) with mapi id 15.20.9587.013; Thu, 5 Feb 2026
 17:11:29 +0000
From: John Garry <john.g.garry@oracle.com>
To: hch@lst.de, kbusch@kernel.org, sagi@grimberg.me, axboe@fb.com
Cc: linux-nvme@lists.infradead.org, John Garry <john.g.garry@oracle.com>
Subject: [PATCH 0/2] nvme: a couple of small fixes
Date: Thu,  5 Feb 2026 17:11:13 +0000
Message-ID: <20260205171115.2610321-1-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.43.5
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH0PR07CA0087.namprd07.prod.outlook.com
 (2603:10b6:510:f::32) To DS4PPFEAFA21C69.namprd10.prod.outlook.com
 (2603:10b6:f:fc00::d54)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPFEAFA21C69:EE_|CH0PR10MB5068:EE_
X-MS-Office365-Filtering-Correlation-Id: 08c81ae1-c954-4282-2f5b-08de64d99a0d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?jbj0mbGJkC3EZLoY05exlW+2JjxCyF/gT099osd0QMgvRAErt78kcseaYFfm?=
 =?us-ascii?Q?bulsnCcp6mUhIyCGO18iUeEVxvBx07yaoM/ISmd+KFRJUP5kWhHdBW+wigLu?=
 =?us-ascii?Q?nNyxfIITE62Z1D8fXr+TZwV8D06BpDc8HVvQq23V7AKAc2RMOa0L+/CzTBg4?=
 =?us-ascii?Q?CxAcn+BqV7jZVpwCo2F5wM8MXn1Usut6Op7FZmoSNJ4Dej1iuY0iTVzuF7BP?=
 =?us-ascii?Q?cRFD8Efy246fLQG/DI4Cjwv2SRlbVZKB2fSXQMfs2Ked0ga7SDBmlKMrKaTE?=
 =?us-ascii?Q?zpybAjO1taikm5iCU9UMxCdpkeM3NGllnN762P+K30SPV1HLSOJq1WFzlgzV?=
 =?us-ascii?Q?qqzz0OcXF2W8GYnpc/7q4SPUjf1I+aFNUxUSt05OMHGhdRUKY0ysC0qyj53k?=
 =?us-ascii?Q?4WORV7bsrhpEnJezXJ/4PiYUeJ9uoLeUs/NXok2lcXzIZekW0xyw7UmLUXIP?=
 =?us-ascii?Q?HYxnMghSX6l1uSIozG0fbq6IregDYwbN1dQ6N5Q4AOdxGNxZ/pbOeJZP6Z0V?=
 =?us-ascii?Q?1L1qv7FvOAU72YNMzBd8tpIx4ULmfrStYglnkNaiEDKLGeGbuZR7HDevBrHV?=
 =?us-ascii?Q?O13q5cZ9HMJOzLvUb3jSmQcCxWBqn4Ioz2QcvurHBJL4LqpLII24Rr+D2qlI?=
 =?us-ascii?Q?SXXDbXmVFsyDpx517GcqT4Sy5BhXfLYLK4wGnCh6n+HdFWINp4DfGjUcm2JM?=
 =?us-ascii?Q?aRyrI7FUbbO2wUyRAy7Mn5609osfx/0rydALqy9liYU+DT/uPVRKhPWHrgtV?=
 =?us-ascii?Q?J1L2RZLmduUMK26xXkn/4hXevLbpNEZlrdyE2nw9bBEHpXgGPQuZ58CZCR4m?=
 =?us-ascii?Q?DL8mdmzu1K7NRpuphP/LMMG2DGxQYKceIXpI51g0QGgerVU1mz4mcWoSLwob?=
 =?us-ascii?Q?n1U2MY+PAyqsSPLjQ0CsJRUAKbPcJ0gRw/m6Vvasd/wBy5hVOFHnX5dm/jR5?=
 =?us-ascii?Q?NrnBhOzdZX4oP2lBt85A1Il3su77ZuXOZPcehH7cdYjzns9bpArr7sIDs5K7?=
 =?us-ascii?Q?9C/5FlmKgldO2++cC7L4Uoq9ywARyMetyQOuk6p3zo88mOaL571/PGEnF69I?=
 =?us-ascii?Q?33qYN8109yjcNFmW9nGYa0lAVHMapR2B/XN7WtFWwJFg+PgcxbwshOL95t4o?=
 =?us-ascii?Q?Gr8GssmmZUxjU1O320X3BnpJ0GhDdnAfwVOqnEbGFwxSE0JSTSPA/qwL4UHL?=
 =?us-ascii?Q?nir6vFJ7kT7P/w5V7tJ80sMIzQYh1jqO9BuPh73IGBTSFd5ykaqQ98mxvCKi?=
 =?us-ascii?Q?EPNPvnTbULDbHh0RpHFGLYj+tS8JSpZbAgL5LgBrxhjl0U4cca58mGyQGpff?=
 =?us-ascii?Q?SglYjar3z6ZHmSd8TONAVkx57SxFnSyColXLf3X18CH5jvymDYIt/ChFy9s5?=
 =?us-ascii?Q?iEesZ+QqmjYfPcHDgQ6mBsILUj5M5At8WEuOMAON9SVIw2JV3LenABi2eV7S?=
 =?us-ascii?Q?3ldRkBE7tZ9ZgISqJd8fA0377E1Vsl2sAN9knaf67ZR7Bli8AvsII53h/oqK?=
 =?us-ascii?Q?6aw/DGwFnJCKdVarJ1gl8+0cgCUVg996YbskAfBJ5W6hHjaTakT8AmUAMt9E?=
 =?us-ascii?Q?RY8m7qRjMZHMqqFsKhk=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPFEAFA21C69.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UhVOqmw1ik0WKymeh2BGqkcS3VK+QzUO4rkGt3hw7iRn2cCpZ4eLkLhWUfHW?=
 =?us-ascii?Q?RvsHO943dAhVlJ/gF9yqxS+mQLsHWodNAT9YUdMXHwUIGUYiyhq4hjsSkq2q?=
 =?us-ascii?Q?i8JSMrHJf81u7RhVZJxEiE52hmiLYKNBLorhCBJOktUwX6WmOugqVnAFybCv?=
 =?us-ascii?Q?IDL/T3i1B6QZREJae9VfUyz1yfaVba/I3I3grk9jgAhl178ivkZc6KnAdyh7?=
 =?us-ascii?Q?idmAh0rU7IFUaqxSsi47DjCz/dWQWr6tdgyiD0wSmqMrS5RYqHQub7q0hStr?=
 =?us-ascii?Q?DrXgVkgmomU7V4B6am580Kesi9ROjGpyHDIKWF9SELico4eV5Z6E+6EeYvKc?=
 =?us-ascii?Q?0nHqtr7Ka1vCh9tmf5VNoyD1lCXGmqVdiv28fvpYdfb4ZvJuRuARox8WTp2F?=
 =?us-ascii?Q?m3/vWumNGrPMMLAfCBPzRZnhKqjHLaBNIrxuxsGbUcj3lsVKllGXtqzkfFOj?=
 =?us-ascii?Q?9BOsSMkzxvksn1OU8FkiFR6y3pcOxfPK5/S+kRZOHZvsDzrib0spoGk6DJ+3?=
 =?us-ascii?Q?/JXdqGapyq5M+flynTl60hFZ8ucL+GgOEtjRTKyuytlupSXeHTNLNwO3FeVp?=
 =?us-ascii?Q?imt3GllxpafrluDYgJEE7NHPzaqlnwP/25/hkx4S2tOhvzVOM0PToVR9RceV?=
 =?us-ascii?Q?gmq62308i8ViiVZlHjQOOn0RSlI2DyBCYpw6Hp3upZ4UwWaaDpDc5HsskJcY?=
 =?us-ascii?Q?3Pcz29RWha9LzAKWzJirh/nP9oyyIXM70TDGM/LHEKhPQN12PtRL7sMbOAAL?=
 =?us-ascii?Q?clEpB75CgGJ28Y+cGPz0znzXw1ldESDS+RuhQ9moQa3UWECx+yBXZqrL0V28?=
 =?us-ascii?Q?aT7gO9oZhx1c1WbBpsP/euO+osfoZo4Chct4+DL0fdpdUK8jqTJKJZ6knA0w?=
 =?us-ascii?Q?aJY6SmSpK74Cftj5DQpjrhYGVcSDMlmKkAxveaQ0qZ+rM9OAtloWbhuMiT1v?=
 =?us-ascii?Q?injVH0N9V8OnEJL2q8DHufS/jckThgyAC+DvOWkYUkA1Rbqt8TcteBL1hAyM?=
 =?us-ascii?Q?2tZY9EI5SxaFPnYB5n1Zxvlo7+s0voywPbzHh0gNkRVwQo3TQ1Ne5UzxO48y?=
 =?us-ascii?Q?Xf29inlRJ4WdbO8OU/WQ1BWGizK9GcnKP10WrKefazmvUP557EDQCurlJuYy?=
 =?us-ascii?Q?SbNAwtPiVkdPAsQZ5t6hkBXdepkr1YLEk1Kai5HsJNWKrF/tKfElloQHvYCZ?=
 =?us-ascii?Q?1R2ke79y24+lV/vEln1Iv7ZgPLctS7NN4LtecXFMZfoazoZZi1w1cm8+o1UO?=
 =?us-ascii?Q?uwmoivKLHu/W/Sr4jxMQuJ4NfhicVUGBTv/C3qRaYDwJkM5HDSp0R+XZsxiX?=
 =?us-ascii?Q?rFE5kqMvERi9rjP6Y36ji2VAq4S1nHcvc/8dbYR/nGqDdFaRjXKDIdFMRcsm?=
 =?us-ascii?Q?PdsGo/f9njP7suKhIIk7lGRskc1Sm0+Wv004sfWO4lBC8jHwh4fxhgDK9Z9O?=
 =?us-ascii?Q?GpaFWee+Dk6wGedbnLkP8LOusef5m6jHvfFgATjYd7a8OwRJ5Ec08DQTel82?=
 =?us-ascii?Q?K7KKU/IGvi0GZ+yqrDYQz2vE0O2U6ZGWu1vK5BykWFrQTNuSCBMNr/G2UD/M?=
 =?us-ascii?Q?jA6+KDxueazAOuThGT04/XmL06lESgSWwINrmr4iIrzZ5j+hW6ysozMoleAw?=
 =?us-ascii?Q?h43VUA3JwEtnwJFEiQGyR04DE39roTbShAs1x4Rfue7fQEqYhaD7A+T1Zvmm?=
 =?us-ascii?Q?wesW9CDt6w8OloylRaKQroHvj6un9EX6fUkyp8s3KZ68j4zXmk8jenFZiJ+E?=
 =?us-ascii?Q?0vvMjja0J6QIcSpReECIbO/fHKuJou4=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: mjqdX/sKldIpuKvQ3dJn1FpNpOuvCLzV5hmPosIWBccPc9EZYD76jOqT6Xdz8uD6UXDpC2y8afP9Wlvc3bbBWizVdVhRd6NnBwC1csBMsHWRiCXKpwgH/UbHBRiENimX37PZzsbggySDEQsjsCInDyfakhz5Bk4cP42onkEH/vbySuz7FBxwxMjBzMTUdZ+6qkPzn5BqllM7SQgJzeaToZJZ2VWd1rmw12QfSfYaFvvqG4xt2crE8E4515aGOkLfubKWi3Hymb85jG0h9PUEyuHcTjYPK+1FWPbVkmszanQzHYln9c4TmlornDouEOULylX5A1mpv9ybpuYXMCkmHTmcC6sl4izH0xhWBFhya+WgymwEfoE9/K2++KdjkiYUzYlBRF2PwZnPaEEG+zoZMxowzIgG5Vy3/x1Xkj4pASWU5Ljcxu0RWA2xS2I+D15W+lb96BrJFi4YkOgLWofre2/DriJgkBGRqWHfVeIuvImpBNdkEMlYjmfRYnSgcdWyYBmr3zPYgzcjjlJL81my8PfMnic3+TXbJQfNxFyrpQKfwlLMc7um53Oc1I5SyFyAJQRBF78d+vlHz6x99ijkfHJPiakjCe7LiPcUqelMn98=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08c81ae1-c954-4282-2f5b-08de64d99a0d
X-MS-Exchange-CrossTenant-AuthSource: DS4PPFEAFA21C69.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2026 17:11:28.9809
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZOZUvQql/l0BcvMNUJKmqTwC5bbsKkqSjkYAojn8e2VbUXCeI8NMkfXw2j1v+D2eIuDeUQI5d3AOyx6eERepFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5068
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-05_04,2026-02-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 mlxscore=0 adultscore=0 phishscore=0 bulkscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2601150000 definitions=main-2602050130
X-Proofpoint-ORIG-GUID: 7fGQWpwJuwqGjEl-l4D5N6pTIPlFA-8v
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA1MDEzMCBTYWx0ZWRfX9QYBK5EkgKBK
 N6pgD9DJeuwPaGAN6FPrqmwyAnwG1bbzYXohdE97taGb7cAAUMpW1sEL2VNgjKIiC/PXVYJ3PhM
 BHBmSTGMFDubzy3pf2fNntrrcHzeaqytF9oAwcp2p/tCjvs5ZG6tDiQWJXU2auJUFQ4kk2BXR1g
 a2TAF26SVdKJaFm0HurBIUNEUi54lM7L/Hm/94Hvxr6mdBYEaBK6BG0VaXmIXZ3iB5dM5CdIePw
 f/L/okcYhR0lGytdEaF9DEzjciUHkI8Ev55W6Ah7db4RNS6InJKGPr5+Bot5POZOWc+QE/LM14u
 SHkp8i8kSS148DY8v1jYG0vH0kbS5o9AUXsy5naAmZ0LedVvilyiKIPmq6budmGD2D9fo3oHbMv
 tzT8HEW3gEk/FcuiyhGuLyvLMdM9wFjOKPECpaNyuhvJqwxSGAsu+Hzyc7GLpz1RVGaoWJWSVsw
 qutmT1SJigPvuoYYyDw==
X-Proofpoint-GUID: 7fGQWpwJuwqGjEl-l4D5N6pTIPlFA-8v
X-Authority-Analysis: v=2.4 cv=NprcssdJ c=1 sm=1 tr=0 ts=6984cf46 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=HzLeVaNsDn8A:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=KI_POkIgGbBZOTm3lFIA:9
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260205_091146_880709_BD3D94F1 
X-CRM114-Status: UNSURE (   9.66  )
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

This is just a couple of small fixes, based on nvme 7.0 queue.

John Garry (2):
  nvme: correct comment about nvme_ns_remove()
  nvme: stop setting namespace gendisk device driver data

 drivers/nvme/host/core.c      | 7 -------
 drivers/nvme/host/multipath.c | 2 +-
 2 files changed, 1 insertion(+), 8 deletions(-)

-- 
2.43.5


