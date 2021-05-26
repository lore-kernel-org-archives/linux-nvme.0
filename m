Return-Path: <SRS0=7k1C=KV=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7796DC47088
	for <linux-nvme@archiver.kernel.org>; Wed, 26 May 2021 16:03:58 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3BEAC613B9
	for <linux-nvme@archiver.kernel.org>; Wed, 26 May 2021 16:03:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BEAC613B9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:CC:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=X6GSB7AXxLvpspwjuoBnqDT4u6Y6Zi4ME/QpkDTT6EM=; b=A/aq9R7+rvQDb7MnS+bnXDhQSV
	9RP1jiJNcKvc+t8ycIWiayrpQnZ0tJt3KyoiFl2MTh1mio3MxwsR++zFMdRh1Ugy1l/Czz/M2bLDL
	sJc346mhhYMOX1onmS+GsAV72rycY+8L/jdGAKYQs0+ph1Vipf6A6TvNVG8UGjoPxZJ1/aXjHCC7G
	IZ0e50m9Y7JTw/Jc2C2VjWLfIOfy86DQSBbn1I8KaF0+86TaTpYeRdvoqxcQ/Ib/sSleDJFsqLE4j
	zuVGtDVSxXAlfNZ2ognJ7q5FRZ/YD09Tb//b1+u2TbE7zuFsbXk4hQFvsRe4+mFaoDNXc2LW5GjmD
	iT80QQag==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1llw0a-00Faeu-7a; Wed, 26 May 2021 16:03:48 +0000
Received: from mail-dm3nam07on2072.outbound.protection.outlook.com
 ([40.107.95.72] helo=NAM02-DM3-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1llur2-00F482-W5
 for linux-nvme@lists.infradead.org; Wed, 26 May 2021 14:49:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j0AjvAA0Pute4AxyTP/j8iQ2HeFnBWH6vKRn3TXoVyGez93nQ0/JnPVvED+lsdUrn3zcVon+riCMjeMoXno42tGKU2qhbEFyBToQyfgIrcjxjveB78QfOPp5Otwk+MQRty6iZyTDhB0CoSelfpmTW30RA70O8tX13sMqSOl1/b1qKpGFMRoJyja1086T7+GXoK5qbj1XHpPXatsgDGF9Md4vZ9n0OSc0LP8lkLk5pGVvTIntmYMKEt1C1g2zuTLQOCWH5bMbso59dsPTrV8HduExkJIcxX7M2ssRM+tdZk1HLEiThJCsDVsuwlKZwu6UdEb7vmrE446DpFtJwoI0iA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d8Khe39iYLmQIE4e+psrLcav2fmMR7b615uJ5Uk69F0=;
 b=UOwH6ie6Z2BKuqEcejNlCRblYse8ib48jB1yUioY5acHcbOnHZ5VsPbhyQO4Adhb0P17Wp3Mn1OF9TCHQJfFKP8emyUlPvnu/Mf64H1AmbrWyKg83OZqMnPgsOLOKU6a33xd9sq/JryLSShrX06Lc7aRIaVXTp+1oBN9gFkFA8rhiQKpPji6al/XUj97/ujwnWx/TRCWIHPBlWAH51Zp1JHVyjzPPyfREM4Zh91nwXJCA193oTN1+OTiHOlLxI9cQbMno6J48ErZuFOup+qVR39qTRNYnd+okoQ2BhSclg7OSP2gP/O3TANdluwDAPv2Zc4Xbd42+E0kDPlmMkNctg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=grimberg.me smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d8Khe39iYLmQIE4e+psrLcav2fmMR7b615uJ5Uk69F0=;
 b=olOS4wEXDtqChAu5XUF1+tr/O8+aKAE9+dBs/5sP4tHe98Azjc7VIB7gRF0MCs6+CkvrSvpFm/IswbzVyd9Fc5Lh6iz0CI0Nu9z5x+2Sqe0Xp5rSYtbHIbG/VPmCD4Tr6bm5mjSCIzpHCqGB/rCsSoXlh27JVdhAJob7IL68mrvM3LkxtChOqvrmRWjeqYLy980HkvsjOt58VyAilyI1fZskyEBbHnBv2xKbfVjMje/7xVN7Ohx8MmTvwBg/1IwvfG4eVI0LHM1t+J1fWWNk4Id9QP4drc6JQluJABLV1JlrkrUuGRzBPyoGwJi6ZTxmcOgRBFAxeS/MOt6cw4CuPg==
Received: from MWHPR17CA0086.namprd17.prod.outlook.com (2603:10b6:300:c2::24)
 by MN2PR12MB4095.namprd12.prod.outlook.com (2603:10b6:208:1d1::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.27; Wed, 26 May
 2021 14:49:47 +0000
Received: from CO1NAM11FT014.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:c2:cafe::28) by MWHPR17CA0086.outlook.office365.com
 (2603:10b6:300:c2::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20 via Frontend
 Transport; Wed, 26 May 2021 14:49:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; grimberg.me; dkim=none (message not signed)
 header.d=none;grimberg.me; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 CO1NAM11FT014.mail.protection.outlook.com (10.13.175.99) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4129.25 via Frontend Transport; Wed, 26 May 2021 14:49:47 +0000
Received: from [172.27.15.108] (172.20.145.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 26 May
 2021 14:49:44 +0000
Subject: Re: [bug report] nvme sends invalid command capsule over rdma
 transport for 5KiB write when target supports MSDBD > 1
To: Christoph Hellwig <hch@infradead.org>, Sagi Grimberg <sagi@grimberg.me>
CC: "Walker, Benjamin" <benjamin.walker@intel.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, "Israel
 Rukshin" <israelr@nvidia.com>
References: <BYAPR11MB2824E1B94D81B837E474A7A6EF269@BYAPR11MB2824.namprd11.prod.outlook.com>
 <dc96c3cf-e895-77c0-3d1a-1bc7e96cfd40@grimberg.me>
 <YK5W7F5DD4grBZLB@infradead.org>
From: Max Gurtovoy <mgurtovoy@nvidia.com>
Message-ID: <3c944010-a9e7-cab2-07ad-78d50c8bd82f@nvidia.com>
Date: Wed, 26 May 2021 17:49:41 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <YK5W7F5DD4grBZLB@infradead.org>
Content-Language: en-US
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 892dc83d-6cf6-4c93-8b67-08d9205581d3
X-MS-TrafficTypeDiagnostic: MN2PR12MB4095:
X-Microsoft-Antispam-PRVS: <MN2PR12MB40955000DEE683754B8AD897DE249@MN2PR12MB4095.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1oKsb0ItO0AoqD+pn3amW7628847LRzRmgSAv8oktYfoIygLhhsJb0/aSLi9Set9NUA7OiYLWpA0/2VFcjJa3X31CIK8NbHNI+2Fta0RHqBhe2V9L56AlXF75CavLWIbYQ2HX1Qop/K7xc97mw/CG/RMcLAWNBN5jiYJ8M5Y89f5mCLgdecP6DtlTRwccMiaTYoXHQN4ZS68TTipHzSYzGqN6s6cdwUjuxF7Ppwe6ux4Ta6J/j+a711mhtBNRx5kfq1e/Y+LOLAnPO0PrtF94dyrS2HpCTTn3OvBOx4mKP3s2jw/z3B0uasc4mZp/ZycSRQPyIrqm5/ZPVgU69qsUA9ewtVJVYYRM8hz3EPfxvGdWzYLxIpjGtAsgQIQ0Et0lDltEMYnZPoVLpELInpUGVLtfqkKVU4DUUUzCz/3J+4hU6XD/7xrO8D067jt8ievoG6mH+dDXL0PFpcehW7hE3AmY8ftQTns4trCatYlpATWPaGP7n6i/qNpuoHib5SBoyzP5Fzu7xSjdaiP0ZynhEYj83M7NXwk+dCh3IbRR0r1DBopXaz/00xDfgFJs+7IjdpHfWJvCuUQ0jsjYE15Jc5Xr9OZGdERsbNeWNTuwZVfnzL/Qw/Ix/AiKUjz1Crb80UwWC1GEgZplrDNiOP+KlhnNMbPGvG/Zy2nzyDJnOEvoy6l91XPRcuRlRAUlV/u
X-Forefront-Antispam-Report: CIP:216.228.112.34; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:schybrid03.nvidia.com; CAT:NONE;
 SFS:(4636009)(136003)(376002)(396003)(346002)(39860400002)(46966006)(36840700001)(70206006)(5660300002)(4326008)(36756003)(36906005)(26005)(8936002)(8676002)(70586007)(47076005)(82740400003)(36860700001)(82310400003)(336012)(53546011)(7636003)(478600001)(426003)(356005)(86362001)(31696002)(31686004)(54906003)(316002)(107886003)(6666004)(16526019)(2616005)(186003)(16576012)(110136005)(2906002)(43740500002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2021 14:49:47.1000 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 892dc83d-6cf6-4c93-8b67-08d9205581d3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.112.34];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT014.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4095
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210526_074953_258616_61FA29F3 
X-CRM114-Status: GOOD (  14.16  )
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


On 5/26/2021 5:10 PM, Christoph Hellwig wrote:
> On Wed, May 26, 2021 at 02:12:08AM -0700, Sagi Grimberg wrote:
>>   {
>> -       struct nvme_sgl_desc *sg = &c->common.dptr.sgl;
>> -       struct scatterlist *sgl = req->data_sgl.sg_table.sgl;
>> +       struct nvme_sgl_desc *sgl = &c->common.dptr.sgl;
>> +       struct scatterlist *sg, *scat = req->data_sgl.sg_table.sgl;
>>          struct ib_sge *sge = &req->sge[1];
>>          u32 len = 0;
>>          int i;
>>
>> -       for (i = 0; i < count; i++, sgl++, sge++) {
>> -               sge->addr = sg_dma_address(sgl);
>> -               sge->length = sg_dma_len(sgl);
>> +       for_each_sg(scat, sg, count, i) {
>> +               sge->addr = sg_dma_address(sg);
>> +               sge->length = sg_dma_len(sg);
>>                  sge->lkey = queue->device->pd->local_dma_lkey;
>>                  len += sge->length;
>>          }
> We do need for_each_sg here indeed, but you also need to keep
> incrementing sge for each loop iteration.  I think we can also
> drop the scat local variable with just a single users and all the
> renaming while we're at it.

Is the above fixing the issue ?

Seems like code refactoring to me, right ?



_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
