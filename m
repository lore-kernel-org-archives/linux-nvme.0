Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8AEEC54E4A
	for <linux-nvme@archiver.kernel.org>; Mon, 26 Feb 2024 17:38:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-Type:
	Content-Transfer-Encoding:References:In-Reply-To:Message-Id:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RxTJeUuu1N/TIPajR55nn7e23m9c5xQj95jq67VyvpI=; b=wbITMyBfHsmey6H4RdurfMV3F7
	/x2t9nfo7BFt12nu6AUGE7XZXvaLQpf+DehNweh7wsNTdt3A23wFkenG1n5cLmS2zueyuA67cB9FJ
	kK7SUePFVl0wlURo0vIL0qXMz468ph9DfCv01W1NDTcpP9R2YfeROE7ajoikRqF3XDBJGFQAJeC5/
	fF6vMd9AVAteCFD4k7m2KDvWeP50i+WFq9TyM1gz0Wqh/g+YldojQoE3uZWrstQSJrbiUbl8L46bi
	iKFvPfIdruozXXN1E90RAlghoW7Kzb4fvWdGnISuji91ciXsnQiydmUfKel6nTxhUNt1Y9Zew0Yeg
	0MEvsvzA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1reevl-000000021gL-2nJz;
	Mon, 26 Feb 2024 17:38:21 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1reev0-000000021ER-1RSc
	for linux-nvme@bombadil.infradead.org;
	Mon, 26 Feb 2024 17:37:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=MIME-Version:Content-Type:
	Content-Transfer-Encoding:References:In-Reply-To:Message-Id:Date:Subject:Cc:
	To:From:Sender:Reply-To:Content-ID:Content-Description;
	bh=RxTJeUuu1N/TIPajR55nn7e23m9c5xQj95jq67VyvpI=; b=bMutxAFMcUhkjYOxM7QsTbu4mg
	Knb80vf6gDyfuDtvqtdMs3pH2dCqAdsfna5OQ+DbJ0Vuigsx1O8tkdlCTmOgLKVbgq1vZomiRVl+6
	3+LszzqOBmXjduXAR9VKwMQ5yzs8X3/EHZpljp29aJ1er9oCDANO64yV77A0Wohe4xUK3pRBiDmyJ
	yWLAGnS4hYjiaFPtysb926MA8shQaW4GBpe1u6umUw5x78p/FjfwHYrGpUFoCwrm2eHGrPHTF+4wo
	AcFgoNuXnizu/bZ4ZTrHIU4hQxcOmMPl2b73ZNzGsrZIlnIGqQX6wpHo8GPT+UjaQIkfR6QSWIOMk
	i3D3p6hA==;
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
	by casper.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1reeuw-00000000B7M-2EPR
	for linux-nvme@lists.infradead.org;
	Mon, 26 Feb 2024 17:37:33 +0000
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41QGnLmX016088;
	Mon, 26 Feb 2024 17:36:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=RxTJeUuu1N/TIPajR55nn7e23m9c5xQj95jq67VyvpI=;
 b=OCQfSMJA7K8yywD6HGk9JNT/NSkQYKJL4T0oQXSFpp974e2bOO6EkOJGgBbYKH9RU7XF
 k8DkEcn74dldMgj71zBrRBT79x/wLjcJfxVhAMv0BlH300XxJxcImEZ2KZ1+PwoB63yX
 5xagSYOlIjFhItBv+aGwpCF4bBvEvGNbSWQO2N6f0EuXqMeAfGW3urUw7ESXwYuMcIG3
 StpZql/URmltIezPIKLcnskJOWlbs+R4WBddwUtgrMDhL+6wweKeUGFohC21AP1XsPa/
 8ClSdvBRjcmPQIWdXtQodJ7ePCCP9lnXYyI0qz4tdtX0XhVv04eSDg1DTd9Eq//HjPlX +Q== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wf90v540h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 26 Feb 2024 17:36:54 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41QGjeVF022403;
	Mon, 26 Feb 2024 17:36:53 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3wf6w61thw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 26 Feb 2024 17:36:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hTPkT48euYyCzEyszjEI5JqFqpAYyzKp4qipU0jVn8VQ0X2alD7HbdxfMrsdf2/Sp5btb/itmKC1a3qzEjAvSBUD66j7038EF6BnvypN5GhlwA/l4Ersdffu4LnNS7LM93C4mLY4SOSsHQN97kRPstwzXgHghML2phu9uYS8lfvz9eYSs8dMsXdFG9NOyiF7/++L9yweNjLqa2xXV5FoHP+0yf8VXbcoOXD4vCjmc6gezrC+sUNPaB/pvkMTK8f4w0G8be8iXrVCLRmDrwMqCAH2qw7F8BUFwQrsIZWMR2QDfp/BC9ghGgCV8wEl/LemO/EYhWNhlLGd6DOJzV3Fyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RxTJeUuu1N/TIPajR55nn7e23m9c5xQj95jq67VyvpI=;
 b=EWW7kk6chMI1oNo4MPP+Rp4LYq3r6Gh+Rnfbo3q4xgyGcN8Dwl+UAdvBJPvrAUScDq0ny5IMDc5VtLFrfGtx8ZhgVr40gMO9wIoe6aUrX+MoubwF6gxtPqGxikk1lgwycUo2fqDeqA2hMHamD8Y448KlrtGBKbrMHNGEmGy2Pg3FzP+dEMHagjA7cCu6fgtZIXL+jH7YwDIcBITK/sx/XgNEXxEVMXR5douAwNpS54TpiDuniYVxR0w3HVU5Z2toHHrTVBFeTq+k1tU+7V9P1jmMMPOxAwbeE/9Nwg6hry2JyKIPoCKUYBYU2/ClcdnJLH/WALpzrfa8eL1sLWwzVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RxTJeUuu1N/TIPajR55nn7e23m9c5xQj95jq67VyvpI=;
 b=RTaM11Fmy9mCXqLTCCM8DXEp7GMjkR1mjxnawxvwkYQRPDVnu3zdffoQk14RG9hHTC3hqs+yFLAYAqyFy0nJyJHatU1LjIe1cmUm/nGNJdgMfgd7TEaoLmKkb8rGRVVqVMiGwNt2HTTFR3ydYHwlJakD7JP9fHRTMBmlKPB45QI=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by MW4PR10MB6298.namprd10.prod.outlook.com (2603:10b6:303:1e3::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.34; Mon, 26 Feb
 2024 17:36:51 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::97a0:a2a2:315e:7aff]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::97a0:a2a2:315e:7aff%3]) with mapi id 15.20.7316.034; Mon, 26 Feb 2024
 17:36:51 +0000
From: John Garry <john.g.garry@oracle.com>
To: axboe@kernel.dk, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
        jejb@linux.ibm.com, martin.petersen@oracle.com, djwong@kernel.org,
        viro@zeniv.linux.org.uk, brauner@kernel.org, dchinner@redhat.com,
        jack@suse.cz
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        tytso@mit.edu, jbongio@google.com, linux-scsi@vger.kernel.org,
        ojaswin@linux.ibm.com, linux-aio@kvack.org,
        linux-btrfs@vger.kernel.org, io-uring@vger.kernel.org,
        nilay@linux.ibm.com, ritesh.list@gmail.com,
        Prasad Singamsetty <prasad.singamsetty@oracle.com>,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH v5 06/10] block: Add atomic write support for statx
Date: Mon, 26 Feb 2024 17:36:08 +0000
Message-Id: <20240226173612.1478858-7-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240226173612.1478858-1-john.g.garry@oracle.com>
References: <20240226173612.1478858-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH0PR07CA0032.namprd07.prod.outlook.com
 (2603:10b6:510:e::7) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|MW4PR10MB6298:EE_
X-MS-Office365-Filtering-Correlation-Id: 201fc476-6276-4e4b-b404-08dc36f18401
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 64T6DozHSYpgOjPv3rp7o72zSHg5icpX38M+Sq52Gctfy1eQJzL8IXpwdF9FcFsXhvPf1RLkYnJKB8nCHiYDGsaCJu0eaPJjTXzsfC9hYmoq76HbqXSBcsgTqn3V2bh9zGnLP4HnazLvRF2riQdet0yugAKiskFO4Q74c/ErOMDwBegP1T1X9A5GSib/0Hmuu8+ShskMKaITaotpG9CLAtpwpDoOdz/cJoMQ4oABxjnxryH84PkvnALeeRbR8KspW0Y94vM2iPywqmE3UcZyrAqS3AwToNFm/mImC/lTeAkGY27nohCPGBOl0qdurUbdlRz09XhHtQlbB/4rtTBLEK4qFYal0NHyOZzO9BjXUjQFN6u9eJ6/PcAjH4G7lC+ct3lW/O/ox8DjTPdhVLzESqqyG/Lk2fy3Z1lfj8G/go0cJe59oa1DD4Z4cEBPsrjRI0lN83qGo8+IgkfNRGB2BNyNoMH4izCxT5k2AnoU4lgU27c9vKJEsGu6T6mzKylAmgfFOnGQFN6v/DNlrUbZ9qMyxCQ2zmyGWAp9zwrZXRCzcVFI8X/zipntKMnNg3GSSYcSSqQA2/qOMuFzXFLAD5GGgO9DSM1PYxw2JGXRK9TBUKlQCwtMPJ+zalBN8Qu1Ux6TswK8Hc9bncFLy65x8S+D29VVaxBM4HNTTi0SRNIeFKrGbmLE5DK3XJExpEpQwX0/ZRec+69/4ohU0Sz11w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(921011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+TM/THG3yJ6h93JvLQRo9Qhh8EZM001ZGlaFxsFA6UFG5tLvC1Jl62AP4LGf?=
 =?us-ascii?Q?5bUEJHGZFiVJV4WVofBjwwToIqscLsDC92pPEhj6Fb3Vwy0Jiza9IADLz2vc?=
 =?us-ascii?Q?pwiwD/dWTYttLJQ867doChXJv4QrZHuVvhVs8jGtkMQsDFPmBTSjXUEHGEM6?=
 =?us-ascii?Q?2L0suRD7kEBrFFcbloOHfaLmH3pUYAzBaw/8yeosjzKBI4cNGOM2MBqZ5hSP?=
 =?us-ascii?Q?e0uiBk+6TiS2x/J/MWPcVIYBRqRpnsUfWcGajEogY9VkzJew4r4/UszrsbwU?=
 =?us-ascii?Q?Kfy2alJimacxQ9xlodeXB/FmJ0/jKN6r7i7enPTcAoCawARtnN/moeZHGTMI?=
 =?us-ascii?Q?xLgO+/UxgHGJ8s0Uj9omrowZ51SKieS7TlLfHQwiz7bmyvZMrgVUTtnNALUB?=
 =?us-ascii?Q?5lkTnlMNx6RRf5MW0Qzj5QuH7ZkIbBf6DdvbMqS0TShz2mVUAyc3gTgWBsfA?=
 =?us-ascii?Q?9loMg34zDh+GaUpZz/B4oF1YdMgLTkoONOB1zUcP3iSndLAJTPeQolXhsYQX?=
 =?us-ascii?Q?gnd4IQpBetCROAy7bVSG4pH/25gGKNdGhSgnwGG0GsMxWKXqQ+7WF0NdgLd+?=
 =?us-ascii?Q?qoXKIetMVwHsMU/pV2Jl5qfd1PeO305VeoIDvlc1wSSbbF5Y7j7bUxWBxkQ0?=
 =?us-ascii?Q?VtAldRbGQBE9Yu6Xn/LGEcs7YpVSm0886hZurc9IqYxx7dx27pNBqICxQQj/?=
 =?us-ascii?Q?acwV+KbQiNJpb8jLaMAfS67SQ4VsQ9D6UZB8vpWRtHPYdmeNI4GLIwRKcmmy?=
 =?us-ascii?Q?AxiBd962mQo+a5QmrpnsJQ0fbnfD9Oyg8P4ojkE7i+hFdFfH7STgUGaUNHhT?=
 =?us-ascii?Q?kbblDIcwMTZPNm+1+quXLyfnvWW2pNFS6A8wjh2ZT0vO47waOK/onzkUUdr5?=
 =?us-ascii?Q?NpinsOOItDYfCZwrwKxXcHrU/M+NCWYlgrYcvKS3YjfHjGMZQIjh4PayygvF?=
 =?us-ascii?Q?tD+Ia6ndPqovQmuqmYMUYqWE398d770agfrlLOhuNhFrdYkCCC8eYut0vCgU?=
 =?us-ascii?Q?dreWSMFteBczg/dIVCu/7TKj9RnM3/Iafwpg3XeKznNzg2PeerJO+jaDPUVT?=
 =?us-ascii?Q?55V1Ph7WfvrCjkRT824EtgWy6TUS4aWALwO8XUE7NZ7ZDOst0z7cvqgjw9vY?=
 =?us-ascii?Q?mnUnnrl/We9fuDLp0zYeAjKzucWrW632rvKjlhlBhDhSWmxa/kzEOC8pznjU?=
 =?us-ascii?Q?BVUWY66b/ogYAqz54zymV8U7MtdIM8QOE7lAgmBX1maCxzdS2VivawStd+gf?=
 =?us-ascii?Q?jeSCrB7kjse9kgMwgjTrJXeo2Cluu/aN84U9yb9CsFoSjh9HRqivMzpPaglM?=
 =?us-ascii?Q?5G1SH7jtEYtXSGWttV+fzcLPppHgsbAw+aiQ6EZMC+no7enhExYy0bX1NGzy?=
 =?us-ascii?Q?W2fodMLlRM1Nng1qY9q69T3aXrwqGZy/7gwAztifKlV4tPLY6sH1pdm/jshW?=
 =?us-ascii?Q?1J13O12dtagNf2qg0No1DI/XsiqSnzF1fzhv3PNNyUwI2mhRuY0xZlUH6Y0K?=
 =?us-ascii?Q?olXbvCulwHrcHeKm03TleDTaw2XEwbxADMvHfyOGFORwF8jHIqg0WudaofIl?=
 =?us-ascii?Q?iITAZkRWs4sqC5vvPkel8RXfKRAttHc6ZVQzH99C4nSuDpJoXOl5LN8/1MXX?=
 =?us-ascii?Q?Jw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: ghVj9UEFSkPcSS0znC/GTbd0wKgly9MVy7QyI0uXduplmTE66bwCfO6epcAIE29RU7pvWMfzfi7HI8vKKlv0PQ6+xowSKQnS/OcYrJGV9Rv/hRI6WjR8MwdWD1+gIiDgvBxXv2+nJZxzT47PO3hr1QBADQDb5FDXWcOxxt1tO++aSd5hYGbe+a2T56h3PXLz5PeHTAs4iXJtjt63M3vhFETPjOlytNwE0KY2O6kfoBGVI694vDWVaffrgnL40O9t5fOUOZGNyax+L3qDaqODc8J+ryqxka2XO42iWO5+VprCh5iJb9rxINT47kt/jAQwZkZ/2qRsA0q0nE52HUQuEtNgc3PZBsIrY8X4RoHv0cC6b6JlTZAcx3uxK/w1EeskQDBTjTRxcyR3Ypvh6B3jIPe3f0oHUsYjKObfymiFif+JS+2nD30AAru12eSsPph4ir1LgVCxDR6deXIuuA2octWcu5EE2RMhjhphWCG2rjAKKhfbki4YhUlgqqe0vtdNRe/vkKs4kVHyZQkoulF5EWGy+ccyOZa0XHLU7nohlAYH/VZVdO6XQO809hKifDJ6lUhjaWj6AdloUN0RMsBa4sqlJar7hsVm3ovqBLXLoz0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 201fc476-6276-4e4b-b404-08dc36f18401
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2024 17:36:51.0780
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CBAevY9y3iNPxmzsjPE794FUpkrSI8MrDcM5W9lkr5LpW3gSDZhQS3VyJVlWZjt3zoHmhzt0wVBp2PnriewA0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6298
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-26_11,2024-02-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 spamscore=0
 mlxlogscore=999 adultscore=0 mlxscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402260134
X-Proofpoint-GUID: -SZ7PoMCFaAGtIfoNLTgRdJD7OtHA1c3
X-Proofpoint-ORIG-GUID: -SZ7PoMCFaAGtIfoNLTgRdJD7OtHA1c3
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240226_173730_972708_91727334 
X-CRM114-Status: GOOD (  24.92  )
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

From: Prasad Singamsetty <prasad.singamsetty@oracle.com>

Extend statx system call to return additional info for atomic write support
support if the specified file is a block device.

Signed-off-by: Prasad Singamsetty <prasad.singamsetty@oracle.com>
Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 block/bdev.c           | 36 ++++++++++++++++++++++++++----------
 fs/stat.c              | 16 +++++++++-------
 include/linux/blkdev.h |  6 ++++--
 3 files changed, 39 insertions(+), 19 deletions(-)

diff --git a/block/bdev.c b/block/bdev.c
index e9f1b12bd75c..bd23f10a425a 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -1117,23 +1117,39 @@ void sync_bdevs(bool wait)
 }
 
 /*
- * Handle STATX_DIOALIGN for block devices.
- *
- * Note that the inode passed to this is the inode of a block device node file,
- * not the block device's internal inode.  Therefore it is *not* valid to use
- * I_BDEV() here; the block device has to be looked up by i_rdev instead.
+ * Handle STATX_{DIOALIGN, WRITE_ATOMIC} for block devices.
  */
-void bdev_statx_dioalign(struct inode *inode, struct kstat *stat)
+void bdev_statx(struct inode *backing_inode, struct kstat *stat,
+		u32 request_mask)
 {
 	struct block_device *bdev;
 
-	bdev = blkdev_get_no_open(inode->i_rdev);
+	if (!(request_mask & (STATX_DIOALIGN | STATX_WRITE_ATOMIC)))
+		return;
+
+	/*
+	 * Note that backing_inode is the inode of a block device node file,
+	 * not the block device's internal inode.  Therefore it is *not* valid
+	 * to use I_BDEV() here; the block device has to be looked up by i_rdev
+	 * instead.
+	 */
+	bdev = blkdev_get_no_open(backing_inode->i_rdev);
 	if (!bdev)
 		return;
 
-	stat->dio_mem_align = bdev_dma_alignment(bdev) + 1;
-	stat->dio_offset_align = bdev_logical_block_size(bdev);
-	stat->result_mask |= STATX_DIOALIGN;
+	if (request_mask & STATX_DIOALIGN) {
+		stat->dio_mem_align = bdev_dma_alignment(bdev) + 1;
+		stat->dio_offset_align = bdev_logical_block_size(bdev);
+		stat->result_mask |= STATX_DIOALIGN;
+	}
+
+	if (request_mask & STATX_WRITE_ATOMIC && bdev_can_atomic_write(bdev)) {
+		struct request_queue *bd_queue = bdev->bd_queue;
+
+		generic_fill_statx_atomic_writes(stat,
+			queue_atomic_write_unit_min_bytes(bd_queue),
+			queue_atomic_write_unit_max_bytes(bd_queue));
+	}
 
 	blkdev_put_no_open(bdev);
 }
diff --git a/fs/stat.c b/fs/stat.c
index 83aaa555711d..0e296925a56b 100644
--- a/fs/stat.c
+++ b/fs/stat.c
@@ -265,6 +265,7 @@ static int vfs_statx(int dfd, struct filename *filename, int flags,
 {
 	struct path path;
 	unsigned int lookup_flags = getname_statx_lookup_flags(flags);
+	struct inode *backing_inode;
 	int error;
 
 	if (flags & ~(AT_SYMLINK_NOFOLLOW | AT_NO_AUTOMOUNT | AT_EMPTY_PATH |
@@ -290,13 +291,14 @@ static int vfs_statx(int dfd, struct filename *filename, int flags,
 		stat->attributes |= STATX_ATTR_MOUNT_ROOT;
 	stat->attributes_mask |= STATX_ATTR_MOUNT_ROOT;
 
-	/* Handle STATX_DIOALIGN for block devices. */
-	if (request_mask & STATX_DIOALIGN) {
-		struct inode *inode = d_backing_inode(path.dentry);
-
-		if (S_ISBLK(inode->i_mode))
-			bdev_statx_dioalign(inode, stat);
-	}
+	/*
+	 * If this is a block device inode, override the filesystem
+	 * attributes with the block device specific parameters that need to be
+	 * obtained from the bdev backing inode.
+	 */
+	backing_inode = d_backing_inode(path.dentry);
+	if (S_ISBLK(backing_inode->i_mode))
+		bdev_statx(backing_inode, stat, request_mask);
 
 	path_put(&path);
 	if (retry_estale(error, lookup_flags)) {
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index dee88e27ad59..40b40e49b244 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1542,7 +1542,8 @@ int sync_blockdev(struct block_device *bdev);
 int sync_blockdev_range(struct block_device *bdev, loff_t lstart, loff_t lend);
 int sync_blockdev_nowait(struct block_device *bdev);
 void sync_bdevs(bool wait);
-void bdev_statx_dioalign(struct inode *inode, struct kstat *stat);
+void bdev_statx(struct inode *backing_inode, struct kstat *stat,
+		u32 request_mask);
 void printk_all_partitions(void);
 int __init early_lookup_bdev(const char *pathname, dev_t *dev);
 #else
@@ -1560,7 +1561,8 @@ static inline int sync_blockdev_nowait(struct block_device *bdev)
 static inline void sync_bdevs(bool wait)
 {
 }
-static inline void bdev_statx_dioalign(struct inode *inode, struct kstat *stat)
+static inline void bdev_statx(struct inode *backing_inode, struct kstat *stat,
+				u32 request_mask)
 {
 }
 static inline void printk_all_partitions(void)
-- 
2.31.1


