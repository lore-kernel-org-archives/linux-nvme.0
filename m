Return-Path: <SRS0=1D85=OM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C87BAC433EF
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Sep 2021 08:11:02 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 859DF61264
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Sep 2021 08:11:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 859DF61264
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:CC:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+i0fIU+azPbewySr0nEowXe/LWXto62peuX2m4E9zT0=; b=zv6d9CXIGK7Yx8VtJmXBxafkaF
	VshoKXw7bGpfm7Tf8LvDS42nGJOUIsA91O87fRJh7yW2eTM+3awn/4efp3T9KPbrMZXEBKHTPHvYn
	JTYnha5Nnyd6qeDuY7DE5WuZ2boj7l/QGc9gv8IdftwH0TdcELceCyCJY/OvFMtujH6O06WHOtBrR
	/1Ytj+k6NN3ewsp/GhLjby6K7h2EN/9UEkKRZuytTanCM79RfVLRzi3jlyEDK975hEJ5VDTDKd6Lu
	PoLTF88cLv77wqrhw/X4/3IdHE01usL6Xvdz3nToSpPRec0XDoQnpCEh+hnEKlUN9HK1HTBZj0t9a
	zhMrefdA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mSxL4-007PeM-0G; Wed, 22 Sep 2021 08:10:46 +0000
Received: from mail-mw2nam12on2087.outbound.protection.outlook.com
 ([40.107.244.87] helo=NAM12-MW2-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mSxL1-007Pdd-A5
 for linux-nvme@lists.infradead.org; Wed, 22 Sep 2021 08:10:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nK9cokG9Y5ucgladinhGD64HjJyfDUwqRok9IR1A6ID0HbiJJdDUHKmJ+W2EFlD1JPYIJuKo25hirwOtn0MA9/+Z8j6bzZD3lDcQ0KCQSjpnrIcjxq1MwKhSk3B1+iEWS5jo8neDyWWZ62XHnllw5juZ0Rt8rvyURsxW6rdIFcQVm8ZQJUk5WcakSLJBbUSb5mDKORt3ZjSvoJkkAeee1z+Hv0gepvY7JN+yo/zQazLvpiuffQe/CWpnFjuLT/Q9eSU8aVTrzDP8aRm10HWNOSm0d7lJD9eV3JKCfC4kic1fz7tGVdTA2owPZFWaUWmpnHfCy4E2BZYA69zs/5P2cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=tYG4zkVqaaIM+I499sblC53bScFccLQGZCHfQPDjCNU=;
 b=e6QeNDGi1dWx9zOU2frrvZShv/33pupW4BZV2usmyO/nQwVMPbXtk10jAsG1/kyUf7huJ15E9sKX7Ilb7Rd2vBxUIcXIRhpwJ6y21QrEaxjultoZ6Fcv6fBI8p2BLTg99s3eFBWuCzqF/bba7FmHyj8BtXEYhjZo8vt1QSV/jE8Fl0kT/7GxRQ5WNdEsQ5zZ+55mjKGINqvw3zcUwi3Lr/7s2fsceM7fnGhUijFb1yk6NY8w7kw5RANsGOrR7+tgcrQhifwbM47+vUASp4dgm0amwlzDGXrLC/rGhBM56u+gX8EUi7yTUlt79rVbjhnMobz8/wYDqVLIj7Scj4BDFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.36) smtp.rcpttodomain=grimberg.me smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=nvidia.com; 
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tYG4zkVqaaIM+I499sblC53bScFccLQGZCHfQPDjCNU=;
 b=t8P5kQvDOZVASyCpqizndHO4zOuZvihxncJwRG05YvNsFbpgKvlCNONy185t3hqj1YofOJwyP1knibhN7e+Pq/3aIsX2OlI9Z28cY7GPIeouGqor1oolXXhcXSy4wAIPdW4AQd+k/uhFjTWUNslKbija1fYI4pFHJnOiCOf3nKRr+cDi9kwbNX5sMJXCbxvELlb8cLikH74XMw1OpZ7/dWMOIH00yys7Cx8XUzQbKaINFRJg0hkhwWtBVBa+ZXxAoA4wzfQZTebcrKo4zHQegtqY+TixHgmzLr7XHBTjovlpj5lloemueo/g0TGXmvyHCgw/MHLwehxJjvuC6ycP7Q==
Received: from DM5PR19CA0033.namprd19.prod.outlook.com (2603:10b6:3:9a::19) by
 DM6PR12MB4105.namprd12.prod.outlook.com (2603:10b6:5:217::18) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4523.14; Wed, 22 Sep 2021 08:10:35 +0000
Received: from DM6NAM11FT044.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:9a:cafe::5c) by DM5PR19CA0033.outlook.office365.com
 (2603:10b6:3:9a::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13 via Frontend
 Transport; Wed, 22 Sep 2021 08:10:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.36)
 smtp.mailfrom=nvidia.com; grimberg.me; dkim=none (message not signed)
 header.d=none;grimberg.me; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.36 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.36; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.36) by
 DM6NAM11FT044.mail.protection.outlook.com (10.13.173.185) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4544.13 via Frontend Transport; Wed, 22 Sep 2021 08:10:35 +0000
Received: from DRHQMAIL107.nvidia.com (10.27.9.16) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Wed, 22 Sep
 2021 08:10:34 +0000
Received: from [172.27.14.84] (172.20.187.5) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Wed, 22 Sep
 2021 08:10:31 +0000
Subject: Re: [PATCH 2/2] nvmet-rdma: implement get_queue_size controller op
To: Christoph Hellwig <hch@lst.de>
CC: Sagi Grimberg <sagi@grimberg.me>, <linux-nvme@lists.infradead.org>,
 <kbusch@kernel.org>, <chaitanyak@nvidia.com>, <israelr@nvidia.com>,
 <mruijter@primelogic.nl>, <oren@nvidia.com>, <nitzanc@nvidia.com>, "Jason
 Gunthorpe" <jgg@nvidia.com>
References: <20210921190445.6974-1-mgurtovoy@nvidia.com>
 <20210921190445.6974-3-mgurtovoy@nvidia.com>
 <0b93503b-93c6-6314-939a-34bd69c30113@grimberg.me>
 <300d5661-c22c-bb8f-e5c3-38902dd946a0@nvidia.com>
 <20210922074550.GA16099@lst.de>
From: Max Gurtovoy <mgurtovoy@nvidia.com>
Message-ID: <01762668-1572-9f37-73e8-714d4ff23323@nvidia.com>
Date: Wed, 22 Sep 2021 11:10:28 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20210922074550.GA16099@lst.de>
Content-Language: en-US
X-Originating-IP: [172.20.187.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 DRHQMAIL107.nvidia.com (10.27.9.16)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e931eb27-1433-41d0-9bb0-08d97da07494
X-MS-TrafficTypeDiagnostic: DM6PR12MB4105:
X-Microsoft-Antispam-PRVS: <DM6PR12MB410546EF37121C9425A9B943DEA29@DM6PR12MB4105.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SQ6Jl9+zO2zeoy2j3aJYVmqjlzMsPiiBtskjamRVOC2Zpat2j6D3SyDk5xh+9EIxFhMpu+LOFtH9mpGxtyYIKbHWZ63KTUVMn0X4Jh06mqm74vLOM22RKSCm0aMGN8qPD7V5ORyInkWxAbPj3IE9ydsi/QPk/5XlXisnTmbI7K+hB4THOxnhg8OQ91CJfKuTnlJbxXfHqXT+AHeRbmcHk0hg9rCvkJLYnw3oIFHJskaign3FnSvm4hXQR6g4WkuFpHD5jAmgJ5/gRkMzu3RryMVGNmns9Kxg7DVPSy3K2ejCehHYQgit/AZtv+aqDULlRFZ60tBDtVhNjwwUNqkrDR2mx8vslKLf4h9wk6PYakTpPCrbvjbnAP1PevNtcqC8+jhcuH0AJuDEFowjNEivLH6KtSZGqFit1G8LdS8igMCmrZINgaxc5P7amJHIeaSXkowGHSuMFkg+lOuhZxE92+LqAUSpFIEL5dT+1LWCFFPrO8r3J1JTvMmHC5toB34oM4iC84CsxqYCS4ZsLKqrWxhUQIFrrA6qWDbWA7kTjwYR1gnubHYvyFmQb/NOrVXDlZ6U4DxV/SCukXJyhZsD+zRE2wk+22nb3JfYTwblJzqrtk/QKqkNeiE9mWct6uZ6TQ5Vey69Y6Js/xJ8fcHQb1XN2l9RzFllIuQkrzkFiuq3a4h3pLEzhAT0/kSBX8zxXuYJUgnWQ/nv0/qbxW3shRzpZfI1QC3YvfWfuss1dBU=
X-Forefront-Antispam-Report: CIP:216.228.112.36; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:schybrid05.nvidia.com; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(54906003)(82310400003)(2616005)(508600001)(16576012)(4744005)(70586007)(356005)(16526019)(8676002)(31686004)(426003)(336012)(83380400001)(36906005)(316002)(6666004)(186003)(47076005)(36756003)(36860700001)(70206006)(31696002)(6916009)(5660300002)(26005)(86362001)(8936002)(4326008)(2906002)(7636003)(53546011)(107886003)(43740500002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2021 08:10:35.2632 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e931eb27-1433-41d0-9bb0-08d97da07494
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.112.36];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT044.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4105
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210922_011043_582922_2B54CC09 
X-CRM114-Status: GOOD (  14.13  )
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


On 9/22/2021 10:45 AM, Christoph Hellwig wrote:
> On Wed, Sep 22, 2021 at 10:44:20AM +0300, Max Gurtovoy wrote:
>> So for now, as mentioned, till we have some ib_ API, lets set it to 128.
> Please just add the proper ib_ API, it should not be a whole lot of
> work as we already do that calculation anyway for the R/W API setup.

We don't do this exact calculation since only the low level driver knows 
that number of WQEs we need for some sophisticated WR.

The API we need is like ib_get_qp_limits when one provides some input on 
the operations it will issue and will receive an output for it.

Then we need to divide it by some factor that will reflect the amount of 
max WRs per NVMe request (e.g mem_reg + mem_invalidation + rdma_op + 
pi_yes_no).

I spoke with Jason on that and we decided that it's not a trivial patch.

is it necessary for this submission or can we live with 128 depth for 
now ? with and without new ib_ API the queue depth will be in these sizes.

>

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
