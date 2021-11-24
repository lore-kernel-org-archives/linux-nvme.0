Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4A51C433EF
	for <linux-nvme@archiver.kernel.org>; Wed, 24 Nov 2021 09:29:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:CC:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zgB4eU2CHBeQ2ZMPdtH9ZTB0h35u+91SonKnRyqMKhw=; b=0abKYbO8+2f0go6ep19x4UMF+n
	77DCX/iSkhMfNEJfgNcICj80NbXTNPohdov8v7ddom4d9M6/8lzcQTL4KqwOAfpAn7tlBe3DNMV62
	I+Qzl+ckT0uZnkI75OA350dQnn379VVBSOa7fVnb4egBVT8sPoy9S3+aFa7OZ9tJIfsjTHf6oMwNO
	QKb7ddn2Kzx1lOD4gbyMPSrIeziCLuIdcufwAeYKMYcGKE95ZLS5JJ8qAC0WfcXt8QMdPhj2mHrmA
	F5FvhMUqXxpnkpCMF1JIPATE+UAyLQwdT53xywI+XWDvG3Altfn9J7WzTraOSveamhg9hpZlzaVji
	zBzyLo2g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mpoau-004OiZ-84; Wed, 24 Nov 2021 09:29:36 +0000
Received: from mail-bn8nam12on2069.outbound.protection.outlook.com
 ([40.107.237.69] helo=NAM12-BN8-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mpoar-004Ohy-G4
 for linux-nvme@lists.infradead.org; Wed, 24 Nov 2021 09:29:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DGAFOW3+4IzRgOmIx+G25CfsnOnatrABpRSMQVLdI7A/GkLXdeBkKubT4H0yMsGW92aPsotmlzCVrYWxPdOwTHnZoNMQdKUXYcmzhDod/KXY8DS6udfCDkYtTp/1E28PFm9oNHU3kof7q13bqYd4OhjQmtfNhVDD9V77LFOOKkEnlwfGPc4sDUuFrp03C7efWWv/GO1u1gbiRTEZ4ItQ9LKcJXkdpINs5TzPYHKE+Nq+M5lvaPPDcwr4Al7IOO/DZSW80XXR6VH351Bcx7Kdpe9T1+QuBKNH8ub/KI0YcFAdSbMhVCfuijgu6PRyt0bzreYfOUF1zEvAQ/an3UcR2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zgB4eU2CHBeQ2ZMPdtH9ZTB0h35u+91SonKnRyqMKhw=;
 b=Pnm0GpXyl0F63ehzmydiTmxQGEVc9k54Eloc/BjX3TEBOU3wkQWLOE6B6YyYgc/9QzsIwIrd5J8VFeFV3dNuWa1T6O+hwJBZudAA1V5e1uP1WwUEqUu+2Dz7Z94g09HQmo+w+FWX2Ya2+A+mw+UJs/GXQSva2AuJjBq7miiWqAWCUkkJyqvYgw/5U1daarLLgn0w85CwI+zUPDkgZIKtmuXCHCO6NavrLQ7Yq8BRtAlpDpxwrjfW7vebPO++Ml7Vgn32Fud5zK6S1XKJNA9oCQuXfzaSXW7AugP1yz93CNscjJTeOL6P4mrZhnLdWCf3bHvxzddqgMpj+TjCxCJ9aQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=lst.de smtp.mailfrom=nvidia.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zgB4eU2CHBeQ2ZMPdtH9ZTB0h35u+91SonKnRyqMKhw=;
 b=QPE4AYzJnARQAu/YEKFs4SZkw1052Yr/CszrDqFRhDSbQZgLBwkJ6Kokn3dsNYMFrNXRyVg6oyof94d4WTIFJ4qXVdOn38u0ULPY/rAA37OFrf2RNGrYkG3jxydRZby1ZnPPRLo7RaXYyxHSpJIBHe3+GDHIciA0TPIUHZYFrVI1HROM5bpa9yAZUe1XaW+vwOWptWU2tRMb2TlFcTjjLizUaca8QeOGv9vkf9JhfRJLfgIMIQX1FOxSiibpTcg0MVLQ1OqUzoiDsjCWinZ700oqufUZG3sr/UDomn3zh01qUM1+J12JdnjYmwGLk88bkOIaiYnXEkFc0dUyQbmVOw==
Received: from MW4P220CA0017.NAMP220.PROD.OUTLOOK.COM (2603:10b6:303:115::22)
 by CH2PR12MB4151.namprd12.prod.outlook.com (2603:10b6:610:78::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.16; Wed, 24 Nov
 2021 09:29:26 +0000
Received: from CO1NAM11FT042.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:115:cafe::d7) by MW4P220CA0017.outlook.office365.com
 (2603:10b6:303:115::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.21 via Frontend
 Transport; Wed, 24 Nov 2021 09:29:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 CO1NAM11FT042.mail.protection.outlook.com (10.13.174.250) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4713.20 via Frontend Transport; Wed, 24 Nov 2021 09:29:25 +0000
Received: from [172.27.15.9] (172.20.187.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Wed, 24 Nov
 2021 09:29:21 +0000
Message-ID: <493d597c-e38e-db9f-aed3-11e64bcb1321@nvidia.com>
Date: Wed, 24 Nov 2021 11:29:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH] nvme: disable namespaces with unsupported metadata
Content-Language: en-US
To: Keith Busch <kbusch@kernel.org>, <linux-nvme@lists.infradead.org>,
 <hch@lst.de>
CC: Sagi Grimberg <sagi@grimberg.me>
References: <20211123174554.3574990-1-kbusch@kernel.org>
 <20211123211029.GE3540867@dhcp-10-100-145-180.wdc.com>
From: Max Gurtovoy <mgurtovoy@nvidia.com>
In-Reply-To: <20211123211029.GE3540867@dhcp-10-100-145-180.wdc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.20.187.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3b4b23c0-632a-4e07-9efb-08d9af2ce7ee
X-MS-TrafficTypeDiagnostic: CH2PR12MB4151:
X-Microsoft-Antispam-PRVS: <CH2PR12MB415182F0EDA88E731D5668A1DE619@CH2PR12MB4151.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1zBwRheEq30nHY9AM7ZQdwl9pf0OJ8LD4e6IqyFsQg70UzBL5Nmhetywb2Eokvu/le45t28yt52dquw0EfqWw8hq4VPkocRmTplxJrFAgZKWQOE/M7mWAar3MPtjaKWen5Ry6njmAUkiQwu0hkVpEGZAl+/aPLQYwawlSidTjRp/FfB9oqxdf0mVu+TfYGpl37AxXDsNu9w9C0KSi8j/toY/+Sfw7gt0QTrmnzS3X4juomrIswPqj2vTz4WMoUGfcX0Loo+T/yYX/AMjvKGrjn9nVThzTNcm5OxYA8/ce2um/U+qkSfYZBMI/rI+IbVZoecTH1Jrs6rAyCj9XlJ2yv6KAEbt7mSPkadDE6Sel6pP6KRQTcZnKjaZydAAnxNg9agBE5CY0v16J7OxwMkq7POopEtl9YhFpEnUr4sb0dY48zMbnj8RxhydLWz4+x9wgBCFpBnCJFPU/MmWNP2k6rBpyoFreuJrmuB1acM+ju9kkSf0o0r5GJYWFi1YMXxiMmYiGM8QM7R9y+qb0fsZcd4pXA3pobG+lnwXho5OEAuRJe3DkWTQX8y+N1A9Lhib8ricO+tFo1mEJeLW+bewXTI7DD2Wb2uhTYPpbRaPI9neQ/bg7cfOgBXcxGRTsbIQgJXPR9ajPmquKSns5sPR+VUT5g0zzm/q7towNgC1OoNA/TfA4YCdq5ic87xIfK7T+AksqQQreG26ynEgYhFqfrbqdcpBRMyyZinrKc+NkW4=
X-Forefront-Antispam-Report: CIP:216.228.112.34; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:schybrid03.nvidia.com; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(53546011)(26005)(16526019)(186003)(31696002)(31686004)(6666004)(5660300002)(336012)(356005)(83380400001)(47076005)(8676002)(426003)(2906002)(8936002)(7636003)(110136005)(4744005)(508600001)(70206006)(86362001)(2616005)(16576012)(70586007)(316002)(36860700001)(4326008)(82310400004)(36756003)(43740500002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2021 09:29:25.3063 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b4b23c0-632a-4e07-9efb-08d9af2ce7ee
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.112.34];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT042.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4151
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211124_012933_747547_08D5F90C 
X-CRM114-Status: GOOD (  11.41  )
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


On 11/23/2021 11:10 PM, Keith Busch wrote:
> On Tue, Nov 23, 2021 at 09:45:54AM -0800, Keith Busch wrote:
>> The only fabrics target that supports metadata is RDMA and usable only
> Sorry, the above should have said:
>
>    "The only fabrics host driver that currently supports metadata is ..."
>
> I believe the spec allows all transports to support any arbitrary
> metadata format. The drivers just currently aren't able to, and we can
> update this path as they become more capable.
>
>> if it is 8B per block, and formatted for protection information. If an
>> rdma target were to export a namespace with a different format (ex:
>> 4k+64B), the driver will not be able to submit a valid command for that
>> format.
>>
>> Suppress exporting these namespaces as read/writeable to the block
>> stack.

Looks good,

Reviewed-by: Max Gurtovoy <mgurtovoy@nvidia.com>


