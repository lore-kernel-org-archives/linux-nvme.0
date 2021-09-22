Return-Path: <SRS0=1D85=OM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42D93C433EF
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Sep 2021 09:36:33 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 12243601FF
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Sep 2021 09:36:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 12243601FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:CC:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KDsz75mStgrdG3w+99u43irdrEy7B5lmzzmolAPeDbw=; b=kzvxDuxUQHebZR7QepyJARRl60
	ZumsrJLq3OE7vc4V7/y6SCCpH5Jt8BapiLWitMq8nNRjhrWT+ADvgLA9MuDTLgSryRzfasJaRDLvf
	R0g4Kk+m/lKCRsHPywEfTOg10xRNC2Zi2nBNoGmt5lhAilXGch2jF13834lGDmp+T03cdejDNUFL/
	K3/LWpQML7SvLS7G/l9a9AdT+ZhcQuHp//z8Be0bUEdI+ADn2HnNvTkI0LnRgDKMTrBOO/Rvi3ped
	B8tT4q6WZscRJsFdiwty3u/jxsVqO823ql0GGVbjuYqgybVUhvHCJSSWUQgM2DXGqIgkk9+xvKrOA
	uE2dpiRA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mSyfW-007b6C-Bg; Wed, 22 Sep 2021 09:35:58 +0000
Received: from mail-dm6nam10on2085.outbound.protection.outlook.com
 ([40.107.93.85] helo=NAM10-DM6-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mSyfS-007b55-P6
 for linux-nvme@lists.infradead.org; Wed, 22 Sep 2021 09:35:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g/EKG6KRFmagmyOIU4bf8asymUhIpokcoolvgQYu68ufELuKC6C7uGwjfDLYgbT5JgNa1V0uS1T13ACRl7cOCyDwD2iT32opqWwsCB3Bk0jqqzMdy8NcC/G2bGRzuk61rtw415JOU9Hv2+eK1yHaqWn47A6JVriMVOd3tvZ8Pl02JkXF/spjUrH/Bnv9K/FlJdI/9FMdg/nHt30GbbPvLgEGLV4qgWRo8ANrgQO43VxJuO9oKblj/vhzEpeWR155Gs/P6055HXMS8JeLWClnZvTuOE7GD4k4ofZju6YfsXfSdTbgtoSD4TU0eIjEMZZNpkp07YP3S6j6QYo7oqFD7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=KPcJqnnIKgGSMDZW22ehtGWYw6wp7Kep7GFwleTr3v8=;
 b=DNeuGcopJdI0usoGDQkLkQLojhNPn+ovgPa3k5pJqdL/Dq8DNhEBy0mMwzhKXKNyGJuc479xbNL8RyWkGyyFqtfHExPKYLNxvyXB8mPLhiRuAXJbkmxAzQuYFgi7NGf2rTaEFQfdo1Xm6dm5t1zyVr7uR3p5xU9lGbJuYANH8NdbRxIvtsZexK++n/2qMuLPuxvrwdEL2JEFlaxBm2GzOctlsW1DVteMHpQOg69xQlDb7tdFZKZv4JCnN6Y4yC/1BT5oePQTDd6rNwylQ1Q8BflZNO5jY9xNBYLRI/e6bOp4RoZXWnEKJmhXBoBn6d5njAyjRvhD3r5UqK50n4V/qQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=lst.de smtp.mailfrom=nvidia.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=nvidia.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KPcJqnnIKgGSMDZW22ehtGWYw6wp7Kep7GFwleTr3v8=;
 b=kxwhwbfxCjv/ezFOv+uLVxtKnTo1YVuJoyj0mTouz0gzSvGkX6arW/OlHCwZ9QdaX4Q2VgKG8wjcc3WrD2FKakUgEk2fv/bfBjAFCKCDSJjjKv51Yek28hNO1O7pxcv+tLtDBHxCUa4rVDJ+NOz29H02V/EXHaIU3foWy2t0ps7loKKf6pRRNrg834OHxiKSAnoDFgpISn6mjN2MDn/i4Oh8roNBhvw+lBZfVqUXFmBtDuIXxJExTkVmoLp/dKNzdNOPV/H1tDw5QAhfXl52sQ1dV/X2yLvD53tnYbZTUZOE82eRxgbkPVILXY4WwuE8hEuER301WDjq0BCJ+o+XQg==
Received: from BN8PR16CA0021.namprd16.prod.outlook.com (2603:10b6:408:4c::34)
 by BYAPR12MB3176.namprd12.prod.outlook.com (2603:10b6:a03:134::26)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14; Wed, 22 Sep
 2021 09:35:52 +0000
Received: from BN8NAM11FT026.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:4c:cafe::82) by BN8PR16CA0021.outlook.office365.com
 (2603:10b6:408:4c::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13 via Frontend
 Transport; Wed, 22 Sep 2021 09:35:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 BN8NAM11FT026.mail.protection.outlook.com (10.13.177.51) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4544.13 via Frontend Transport; Wed, 22 Sep 2021 09:35:51 +0000
Received: from DRHQMAIL107.nvidia.com (10.27.9.16) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Wed, 22 Sep
 2021 09:35:50 +0000
Received: from [172.27.14.84] (172.20.187.6) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Wed, 22 Sep
 2021 09:35:47 +0000
Subject: Re: [PATCH 2/2] nvmet-rdma: implement get_queue_size controller op
To: Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>
CC: <linux-nvme@lists.infradead.org>, <kbusch@kernel.org>,
 <chaitanyak@nvidia.com>, <israelr@nvidia.com>, <mruijter@primelogic.nl>,
 <oren@nvidia.com>, <nitzanc@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>
References: <20210921190445.6974-1-mgurtovoy@nvidia.com>
 <20210921190445.6974-3-mgurtovoy@nvidia.com>
 <0b93503b-93c6-6314-939a-34bd69c30113@grimberg.me>
 <300d5661-c22c-bb8f-e5c3-38902dd946a0@nvidia.com>
 <20210922074550.GA16099@lst.de>
 <01762668-1572-9f37-73e8-714d4ff23323@nvidia.com>
 <6df58d37-0519-9e97-bae5-a529084c8341@grimberg.me>
From: Max Gurtovoy <mgurtovoy@nvidia.com>
Message-ID: <67a2a26d-beca-5d6d-e58a-430cfc97020a@nvidia.com>
Date: Wed, 22 Sep 2021 12:35:45 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <6df58d37-0519-9e97-bae5-a529084c8341@grimberg.me>
Content-Language: en-US
X-Originating-IP: [172.20.187.6]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 DRHQMAIL107.nvidia.com (10.27.9.16)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dd50bcda-7c29-41a9-c5c4-08d97dac5dfb
X-MS-TrafficTypeDiagnostic: BYAPR12MB3176:
X-Microsoft-Antispam-PRVS: <BYAPR12MB317672213E0A324664D72455DEA29@BYAPR12MB3176.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FIlJxd/1g2aZLV4iUhysIqxsr0lNYaS9ljWzu/XDU0W5asbmCpQfctIFpuf8HK59+Mz1q0tmxvPEmUDCqnkIJNiZSimA6FNfj1KOz/9NAG8YTeooGY2d0vSvdHW821d9MO7ww0hx7dAyxnot+0SUkBAwUS776TH1r6irqKqWUOudN2L0leQzAc6MLg2N1WfEFv/spmCBtfq9hMFRPWzvmDSy25z8GYnxQPH68g5cNqJ0gyCbtIr85T9eqeOkiWqywC33FdPo2JTLi0kK+htt36VP0j9za0+hi4m2023iC1vp97iTPlDH8dJ4TszOyODGuRnrPSfgmMx/ldrsqsOHJd9zZ8cG4tHLBjkg+8x1D89TMlHJGhB1z4rcEV1pwGlumgYlWdtnXow83aoB33/7X+UoRWoqUP7xKFIf2Wmd9J7YhknExG+gnwz2KwjnTTba+lZO7zmTHRMEURF1KlqMG1wxaXAxz5u2ynL9mabiCFANVKcA/xah/DK+ey0LVBnzmBwASCib5dubrAKjblHY2HBSIrSDyE/H0SKtnpv3bhqmjhccl7XqoEpvvmtMRDu86vzJGotN3t61aNcUG118ebcuqNSTcYwtrQqi15i2S1ony9ZM4KU/OCw/wbFwRF7fLYSnogl5GwNG/ULruIpfMSYVUnjnJAnKp9vuuG54zfzkhppvJj3/vAldQRfDq6WDF49VhlX/ANtTu9uofXrxHpOP9/O74oaQ/0fLbN9a+0U=
X-Forefront-Antispam-Report: CIP:216.228.112.34; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:schybrid03.nvidia.com; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(110136005)(36906005)(336012)(70206006)(5660300002)(4326008)(316002)(36860700001)(7636003)(356005)(53546011)(70586007)(26005)(2616005)(16576012)(54906003)(31696002)(186003)(508600001)(47076005)(16526019)(8936002)(107886003)(83380400001)(36756003)(82310400003)(2906002)(31686004)(8676002)(86362001)(426003)(43740500002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2021 09:35:51.2465 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dd50bcda-7c29-41a9-c5c4-08d97dac5dfb
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.112.34];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT026.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3176
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210922_023554_879434_8CF4AC48 
X-CRM114-Status: GOOD (  21.54  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


On 9/22/2021 12:18 PM, Sagi Grimberg wrote:
>
>>>> So for now, as mentioned, till we have some ib_ API, lets set it to 
>>>> 128.
>>> Please just add the proper ib_ API, it should not be a whole lot of
>>> work as we already do that calculation anyway for the R/W API setup.
>>
>> We don't do this exact calculation since only the low level driver 
>> knows that number of WQEs we need for some sophisticated WR.
>>
>> The API we need is like ib_get_qp_limits when one provides some input 
>> on the operations it will issue and will receive an output for it.
>>
>> Then we need to divide it by some factor that will reflect the amount 
>> of max WRs per NVMe request (e.g mem_reg + mem_invalidation + rdma_op 
>> + pi_yes_no).
>>
>> I spoke with Jason on that and we decided that it's not a trivial patch.
>
> Can't you do this in rdmw_rw? all of the users of it will need the
> exact same value right?

The factor of the operations per IO req is to be added to RW API.

The factor of WR to WQE is in low level driver and is ib_ API.


>
>> is it necessary for this submission or can we live with 128 depth for 
>> now ? with and without new ib_ API the queue depth will be in these 
>> sizes.
>
> I am not sure I see the entire complexity. Even if this calc is not
> accurate, you are already proposing to hard-code it to 128, so you
> can do this to account for the boundaries there.

How does the ULP know the BBs per max WR operation ?

I prepared a patch to solve the case we say we support X but we actually 
support less than X.

128 Value is supported by mlx device and I assume by other RDMA devices 
as well since its the default value for the initiator.

The full solution include changes in RDMA_RW, ib_, low level drivers to 
implement ib_ API.

I wanted to divide it to early solution (this series) and full solution 
(the above).



_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
