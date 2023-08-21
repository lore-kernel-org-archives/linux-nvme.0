Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33AC9EE4996
	for <linux-nvme@archiver.kernel.org>; Mon, 21 Aug 2023 12:34:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-Type:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EF1PlT5zlMIlwTDXJxdhQ4hrGl2+vSuU4uNUXUY0VhM=; b=N2/j6SG6NsvfqbjEhEfWERewz/
	uO+iFSB3UXSTho7ApjEYgy/QG1NfnXM9H+1hX0DtfeqBx729qsmRigyOqr2H5LHFR1xbuChAIUuBA
	FpdV7HLhCubvRMWX5cuLxnJwgYPFbz5RyhIT4p/za+t6tjrBugrYH/Ju7ybr7uJt88gZVGEoUvQ4E
	ovDTdsTUpNte+V0DwJWBsiXVQNkS+V5peUg1KTU6QVSNjlQ6ncz/m3zkIQebey1AlcTbsJzaItg3e
	pCHCXb81IAmpzlfOu+4Pr/aLjnxdzYSor/Fh8v4IOImirVnOJ5FNeC/Ct43BKO3txJX7XAkgGmLQ+
	5l8+FyQw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qY46l-00E0SX-2x;
	Mon, 21 Aug 2023 12:34:11 +0000
Received: from mail-bn7nam10on20617.outbound.protection.outlook.com ([2a01:111:f400:7e8a::617] helo=NAM10-BN7-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qY46g-00E0PU-2w
	for linux-nvme@lists.infradead.org;
	Mon, 21 Aug 2023 12:34:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NHrDnNl0KL4Vr8MaHU8XEda4v4Hb2/z+NOTiAL5ZHT0W3TW7jBCTM7IdUW5rUdMCDCeTIvXQGpC0P+RShzqK2DfF/iZ3Ko4A7Xkxf4K3bHSWtRFpjFELP311C81pWKlMLLQZQIycjlajDw9WyCNnN8DZRAYEl25/fJJhQWKjSyg12JnwbTWQGtDKPEblLOIFjmwyrBMYwEY5oMWPGjnO+8Y2DIY3URrPDfmQVLtGVMrfHuEfYRDFfvfhDlIe0N4FFF2LFUCMGjXL1L9qJUGmI0HTpmej/DUjjl5sx1C1wBGSqUBuwZ5TPCiSlo/4MclJp6+kFjmepDtBFTK+qHhVzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EF1PlT5zlMIlwTDXJxdhQ4hrGl2+vSuU4uNUXUY0VhM=;
 b=XBFZPmOrcbon0r7ui+Gozoc0fp6bXwOhTdI/13DcaWFj7OMZd0Rpq7FGLf3Qc6nlA2CesQU/qbgneBWkMoRCtBAWbHKEJ2YjmLG9wPrwYppzkOznxRDcYNE2HffvNUHUn0borzFpT0g48nrpP0Xah6ex94EYzKlwHRFt00r8he9WOE9r/060oNzRThBolhOd4zZAEyHuTEeO0Iogr1licKj8I/33oZBdWMAD5MMUmr0uxK9QfoEaNDzwDvgGTEYfKcFGpqcs3efvGIvgPipiUadSap669w4Wzym93waBpejC/R9dvgJpHs6AQPmIcUQtbZKFAw6Sj/vNjgOjUMdXYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EF1PlT5zlMIlwTDXJxdhQ4hrGl2+vSuU4uNUXUY0VhM=;
 b=bsAFgxd6Klz/wf0ThkBE/mZ9mqZBtImRgrT5OPzekgExNyDKXc4r5JzqTYe+m28a3YoeEYhhi0M9ivn30P7zSOTzzGBmX4ZdyCem8dOv4cb4NjK66mRkgjr/wkcp6LXZTV6gMnUZHtIGn+NusHwGJVMHDXVAwmvM6xga6D8p/BEBy1hZ4xzzt6YH4ObbP/vBCnbDYdMpjIVNfQduStRrWjpwByM6t2ObYopnlgr7dkYJa3Jyzp8H4f7oUUoLtWw2gAQ45v4dAQUGWsBLt/R9dHPG7eNu231yOosMKfWfmY1O1gdevarlzEVFW4vXEuJeWAzQAWB6vL5VG+UsevfcBA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com (2603:10b6:a03:45e::8)
 by MW4PR12MB6874.namprd12.prod.outlook.com (2603:10b6:303:20b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Mon, 21 Aug
 2023 12:33:59 +0000
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::968e:999a:9134:766b]) by SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::968e:999a:9134:766b%7]) with mapi id 15.20.6699.020; Mon, 21 Aug 2023
 12:33:58 +0000
From: Aurelien Aptel <aaptel@nvidia.com>
To: Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
 netdev@vger.kernel.org, hch@lst.de, kbusch@kernel.org, axboe@fb.com,
 chaitanyak@nvidia.com, davem@davemloft.net, kuba@kernel.org
Cc: Or Gerlitz <ogerlitz@nvidia.com>, aurelien.aptel@gmail.com,
 smalin@nvidia.com, malin1024@gmail.com, yorayz@nvidia.com,
 borisp@nvidia.com, galshalom@nvidia.com, mgurtovoy@nvidia.com
Subject: Re: [PATCH v12 10/26] nvme-tcp: Deal with netdevice DOWN events
In-Reply-To: <f92abcda-695a-b427-f342-a3540a45be1a@grimberg.me>
References: <20230712161513.134860-1-aaptel@nvidia.com>
 <20230712161513.134860-11-aaptel@nvidia.com>
 <b94efb3f-8d37-c60c-5bf6-f87d41967da4@grimberg.me>
 <253pm3nuojy.fsf@nvidia.com>
 <186675e2-464f-bec4-1a26-5a516ef11540@grimberg.me>
 <253bkf5vjyu.fsf@nvidia.com>
 <f92abcda-695a-b427-f342-a3540a45be1a@grimberg.me>
Date: Mon, 21 Aug 2023 15:33:51 +0300
Message-ID: <253lee4shg0.fsf@mtr-vdi-124.i-did-not-set--mail-host-address--so-tickle-me>
Content-Type: text/plain
X-ClientProxiedBy: VI1P190CA0015.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:802:2b::28) To SJ1PR12MB6075.namprd12.prod.outlook.com
 (2603:10b6:a03:45e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6075:EE_|MW4PR12MB6874:EE_
X-MS-Office365-Filtering-Correlation-Id: bcff513f-4296-481a-a417-08dba242e448
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0VEv59rBAKb90jz//JcQPWa/v6u4w/cOCx4wPh1yNM7Pab85vyPEFGHOioidiTIt9iSqlq2nZV8vPswkuyVP3mpoSuNUo2nNA3XLQBCiXOQv7ng5VCDTjXHvmSBUiuWCpEl/QWfn/Q345t5aWgO5rMeDjBeB/0HL1smAJWJGPuTGHlOJX6TxxYX1fe90QtgeeGo+2v7CvdWrpGjfzAVZ8OTfperZ27Gjh+yp1BmKdWn/6/Yid6+eGBXZLRsh+seeQ3HwpEXl9jmCsKUqj7N/leFsxPGQoiXd92kHiFUZdoFgabrQx9J733MdwCBwMpNexqOGCnL0o8VRfsK5TK994Zw/WSSEgjiNXozWK924PZNjcaoSQWSfwL9BmZIwO7IaTc6UDwH0BFtQ80XyasjgobPRIlufsJ2jRim0D6Txq1e2tQUkIfJaPlI7jFCZF+FOFJLW/Y21RQ4Vy3co5DRnfmiIeW9HArB+daor1TphM8hDRoYY/1LDzF/hSFqCSmLPVR7SUNwXWQZliNU07DyRjPi5GoFJ2F2Sb8ITZCZchFHYBOF1bi9BPlHUkfoOLB+L
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6075.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(39860400002)(346002)(366004)(376002)(186009)(1800799009)(451199024)(66476007)(66556008)(6512007)(316002)(66946007)(9686003)(8676002)(8936002)(107886003)(4326008)(41300700001)(478600001)(6666004)(38100700002)(6486002)(6506007)(83380400001)(4744005)(2906002)(7416002)(86362001)(5660300002)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3yyGsFGrIQ5dE1p5F5yO3YPFfGii2tg3L1ykeQoXIu/wD3c3pDmSGtjWyr28?=
 =?us-ascii?Q?YJ1UIMLJGNx5WO31sPkN18KPB7Q5v8EoKn64+qSNjV21KU+eMJAMkbVzt4Bo?=
 =?us-ascii?Q?7tsgrQQN3uoCq6DrK5kmRci5YGTz+Jq4x4v6LdFL6yxb91Yhq5Oozd7VTFMl?=
 =?us-ascii?Q?6PDrTm030stiyYAk9cqw3d+jk0sd+PmDzBJhBXp9ijPpK1vtG5mU9nSWaHew?=
 =?us-ascii?Q?50nOMaGp8ddbAOvMP/DkR5tnZyuRFOcBP0v7qK3XsiNaAOn40eDiUaVs/Zsz?=
 =?us-ascii?Q?vekwDqiI7MdxzduWWD/QETiRQ+++xluAXcnMGhWRYQjK59Y1tR5g7+1vTrfj?=
 =?us-ascii?Q?T7n+eCwSnK33eiq0naylJMVrWPp0WKhzr2FuAnMJE0QIDb3Tj95bQLWHjtiz?=
 =?us-ascii?Q?NJKHwbAzXspwY9z5WkUODnvSQ3ORgj8PEC5rzyg+oiThhoW30DLntFKYy+G1?=
 =?us-ascii?Q?sMooiU2U3y2LWN7ojA0FZ7lZtjAtAsJ/AETepM8Sj3I5hg11WuwrAaRM4H95?=
 =?us-ascii?Q?nvxY2uk8LLcoVcf2BvKOiZnzFW1vdJXgPrMjte1H4w9FbvwtW3ql+3atvVa4?=
 =?us-ascii?Q?7o+0bBCWIzq+zpQ/w0x39qljw+zdvOjCTtpd943tdXzX2YY0jad0PHu1hV7V?=
 =?us-ascii?Q?T9fvUhOK0rzMWNlwT7jPHiCdEKuwfGlzciotbblekmHio8FqEY/dNkghGQlr?=
 =?us-ascii?Q?viX79/YWuPIDRmOTIwqCFOQI6oZew1LAEIPtGHeu6V/+q+NcWLTs8roGZVO9?=
 =?us-ascii?Q?wT+PctEMyejbDSV+ktwm4H8IKLtJT6+mCPcUJUw7wLzEFlnjHGtwxrcwjubd?=
 =?us-ascii?Q?tU62Faxl3J7R11oECPDNTrEyx0lV09vNxRehKk6Sz/0vgGO5g5Ep3SYTd/Ro?=
 =?us-ascii?Q?GxDHGaGXbONDbk6pjdehx7/K7S/pxjYDp9ksU7DglOXNwx147Z3PbTqbEnLw?=
 =?us-ascii?Q?QDr6WfRPqz1CAgi8vS4+4W20boR9ozLm5/NIbnirLjfoao800MtqpOtBXaiZ?=
 =?us-ascii?Q?snm4txn043CKCpYXJMie4lOQ+shZJreGsMBjwq8szUOMmXnPnN9sqUgU9Ntk?=
 =?us-ascii?Q?imJ6hVTOI+yYkh2SS3EeI8D9JAYLonhcSeVl9TT2z92nKNIZT6Z73uBxjekT?=
 =?us-ascii?Q?rRm7Ai2K+noC9Woiat1xATqg5xk03fV3Y3LKkMdBM9bZHqYp0cVfQUzkdiyb?=
 =?us-ascii?Q?Xn1hKApIXjlGOh+3+UwUssAtz0v95AG2ddANWExK3BpiTdeCZU8Vbegigu7A?=
 =?us-ascii?Q?qxVnmgu2PhBoGkc7VV7zI5fLTYgRRxciGYb4rtA0ju+Em5j/gQ7d9GDyltcH?=
 =?us-ascii?Q?43dfhOaptN1JZI5HFK8/G/CcUIaZMjbhsS/Bqkp/csCHuiRApPx1yCxVocOA?=
 =?us-ascii?Q?tTJayKBg5hQUFxMhLlZGIn1ctZ8MTlS0YtUzS2c3ZjrWCBUHS4i8dR00x67G?=
 =?us-ascii?Q?HTnmCRpOAaRqT85gKWtz0GrQfoMyTN+FSaNT+/CltUmjOd5mRoR/VPsgD4w8?=
 =?us-ascii?Q?QKMuFkWs4NSwV/zCKBeSTcrSC1jaduNd+cjIC4ZdSOpmzy5lA+K2iYocDZq4?=
 =?us-ascii?Q?9qGkt2WAzuvnnNKmjHW8ZlHMioThV0q0TUCqbr/v?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bcff513f-4296-481a-a417-08dba242e448
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2023 12:33:58.7447
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N8NoxthnWzYNytUkt85T5BY4oi2xMhPrKmTJudm46K9sZa053ujVIIBx4GZ5MGl60vhT79Wb25tlxghFG7Eu2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6874
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230821_053406_997863_C3A7993B 
X-CRM114-Status: UNSURE (   4.13  )
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

Sagi Grimberg <sagi@grimberg.me> writes:
> I'm assuming you are running with lockdep and friends?

We tested it under the following configuration:

    CONFIG_LOCKDEP_SUPPORT=y
    CONFIG_PROVE_LOCKING=y
    CONFIG_PROVE_RAW_LOCK_NESTING=y
    CONFIG_LOCKDEP=y
    CONFIG_LOCKDEP_BITS=15
    CONFIG_LOCKDEP_CHAINS_BITS=16
    CONFIG_LOCKDEP_STACK_TRACE_BITS=19
    CONFIG_LOCKDEP_STACK_TRACE_HASH_BITS=14
    CONFIG_LOCKDEP_CIRCULAR_QUEUE_BITS=12
    CONFIG_DEBUG_LOCKDEP=y
    CONFIG_PROVE_RCU=y

No warnings were printed in dmesg.
Anything else we should verify?

