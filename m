Return-Path: <SRS0=wOI1=J5=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00306C433B4
	for <linux-nvme@archiver.kernel.org>; Sun,  2 May 2021 01:23:30 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 45C93613EA
	for <linux-nvme@archiver.kernel.org>; Sun,  2 May 2021 01:23:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45C93613EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:CC:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=3oeE8tqqWWasxyufHiQkaAdH+yJeyC7+GR8X4aWncIs=; b=PLSPoWobnTSjldNfJmZ/fcedA
	p2tJwPTA8oCqEtotT7CmeXYRmVCncLLdqVHfm+JJXAt5ysE3+qC5He94fdwEksd/A5Qqo6oHlWGVM
	sPWKl682i++SkJmZaCOl/zcwKhgocExxfIFd0FfELQ74TFcxjtaHiIJa2b7LXJaqw1svqy+4riVSE
	ijpo3aCiasiVgWEoYacMxvN8mR4L3ocbH9j5LQmCkpU2Wbg2K4faZ2AZG14bi9g40hZgeHvf9yW7E
	nEn06T9v08cEY/nofT91kXuT0TJmJkWIzn33+pVHpn46F9mNMtPJmMrTqW/JGYKBHViGOlRpudEYb
	5vPBdTfbw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1ld0ox-00AydX-T2; Sun, 02 May 2021 01:22:56 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1ld0os-00Ayco-Ob
 for linux-nvme@desiato.infradead.org; Sun, 02 May 2021 01:22:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:CC:To:
 Subject:Sender:Reply-To:Content-ID:Content-Description;
 bh=Ej3WlTKIg/JVEtkdlMBgeu0l5FwaFcyahxQlMRcA+ck=; b=hHxRrimjA461xw3sw6VixKe478
 vZMjWL6o7lL8DEa4lD9eyZYla7cn4hrzGBvDT4uT94TeK+vGMN3NiFmEkkTM83wh5MGC0yWZABtzm
 A8ZvWiE9Pj156Beq5wjuxRunnB1HABaOYBI4KRh/ehwl/TucqE8pGSXmSRSZGzn9/UTkURyf+Fyu9
 Tl1+QL5lzMsaLHUlsKauWZb/sfL40MUlgmFDFRXxjtzZ/6Rz2n3vpCOujgW20zEPOYsq1GLykG4Eh
 Yc/+lH9cKXurfutyu6YkHp2x5pN1QuGycBqNK8eD/KVFu998YSguB+jXCoAHiTs9TAhDd48wsYvRQ
 I7a9ThoA==;
Received: from mail-mw2nam12on2053.outbound.protection.outlook.com
 ([40.107.244.53] helo=NAM12-MW2-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1ld0op-002DHc-PJ
 for linux-nvme@lists.infradead.org; Sun, 02 May 2021 01:22:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SIHJv5ULzGB9BTKM3THgKK/44bPOV2bIjALZ1Lo5zhiDsVGLhYCBSNRkMKZGAi/fpkR6N6sg2cR1ehpN5KwnsOCJE+O5XZxLL/p2jU2943wG4D3mhhrL2Shk2TUxCyoKL7AX9FQC6b7BKbMabyGO6a4fTmHe60+sMX70i4PWqx8b8GdCC+31Jo3Ax5/1LfYFU9/Lbs28MbF1deFXsHe6Zd0nuvhSQ5bGwmUxx1rDwEBUZMh8DTO1rPFBz/Y0AXFSKs2ZrWpWJU7BGabxLdgCjTBLSqeSSuFp1dnuDLKc9RVnkvq02ujMleGpAoMndaD3p/geQkhMU5lJIuSKixwLSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ej3WlTKIg/JVEtkdlMBgeu0l5FwaFcyahxQlMRcA+ck=;
 b=Kd5FzTw6WgluwvaQ2bSQbTQbJV7duJNCIWTKHVOfi9xOT8g/mIYCKONIAKCkyDezs4INxCsA2cOYzYYjMswW0z0ya7NBkNGbpe5cG5S80u/TgvcUU7MeKwMJTxyHSOPRJFh2yjM7qZlQP41XX3YGftC/KTnK9c/+SVlizY8Q/T7A25bn9gLB0XHKjysTHIcfYI1hwj4tpCCIe36iIg4GRwJfdyQHFdIvJ8VWvZ0mDrXmcwZuLRExLpfR0lxYvoKpFw0EsoN33zFw8qK76U6OGX+xmUFeuSDtAcfN7K5Rs8OvvEbDTsVCJ/CyTd9NpNV7hqo1nYMEcyUxRbhUgAiQvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=raithlin.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ej3WlTKIg/JVEtkdlMBgeu0l5FwaFcyahxQlMRcA+ck=;
 b=K2otKTPQuoWRdI4Bcd5q9ChCMpI1P9wDm7UW/tReWDEajVuSOPwtnSyI0fMrwpRr+S0X9C4makC2BFD6pw4OfhYJlwphAHv0nM4IHFVfiHSm4NZXpqYujrIhKWvbvhV0s4JYD6i3Uebc1JMY8bhvW++fr3YV7p1CtP/UrklHQEjoMj97aYTUIsheozShM/Mt6wjsdb1jfiU96rA4p2K23Od32AKVsgMI4iGFZL9ZZfUSPC/dgjPg9XLbs2FiHMsLlOyvK4BTRWk5PNjH/Kf+6nYN1ig68PVXgp28O5npQvNqbSSdcIJ9/bd9Z7gA9/e5WC5XtjCHB/bVvrRU71xnMA==
Received: from MWHPR04CA0030.namprd04.prod.outlook.com (2603:10b6:300:ee::16)
 by MWHPR12MB1341.namprd12.prod.outlook.com (2603:10b6:300:11::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.21; Sun, 2 May
 2021 01:22:44 +0000
Received: from CO1NAM11FT066.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:ee:cafe::b7) by MWHPR04CA0030.outlook.office365.com
 (2603:10b6:300:ee::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.39 via Frontend
 Transport; Sun, 2 May 2021 01:22:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; raithlin.com; dkim=none (message not signed)
 header.d=none;raithlin.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 CO1NAM11FT066.mail.protection.outlook.com (10.13.175.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4087.27 via Frontend Transport; Sun, 2 May 2021 01:22:44 +0000
Received: from [10.2.50.162] (172.20.145.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Sun, 2 May
 2021 01:22:43 +0000
Subject: Re: [PATCH 00/16] Add new DMA mapping operation for P2PDMA
To: Logan Gunthorpe <logang@deltatee.com>, <linux-kernel@vger.kernel.org>,
 <linux-nvme@lists.infradead.org>, <linux-block@vger.kernel.org>,
 <linux-pci@vger.kernel.org>, <linux-mm@kvack.org>,
 <iommu@lists.linux-foundation.org>
CC: Stephen Bates <sbates@raithlin.com>, Christoph Hellwig <hch@lst.de>, Dan
 Williams <dan.j.williams@intel.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>, Don Dutile
 <ddutile@redhat.com>, Matthew Wilcox <willy@infradead.org>, Daniel Vetter
 <daniel.vetter@ffwll.ch>, Jakowski Andrzej <andrzej.jakowski@intel.com>,
 Minturn Dave B <dave.b.minturn@intel.com>, Jason Ekstrand
 <jason@jlekstrand.net>, Dave Hansen <dave.hansen@linux.intel.com>, Xiong
 Jianxin <jianxin.xiong@intel.com>, Bjorn Helgaas <helgaas@kernel.org>, Ira
 Weiny <ira.weiny@intel.com>, Robin Murphy <robin.murphy@arm.com>
References: <20210408170123.8788-1-logang@deltatee.com>
From: John Hubbard <jhubbard@nvidia.com>
Message-ID: <5f15dc88-fefd-e2db-8c0b-6f7b84826749@nvidia.com>
Date: Sat, 1 May 2021 18:22:43 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210408170123.8788-1-logang@deltatee.com>
Content-Language: en-US
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c2b919ff-3ce4-4c4c-ab09-08d90d08c980
X-MS-TrafficTypeDiagnostic: MWHPR12MB1341:
X-Microsoft-Antispam-PRVS: <MWHPR12MB13418FE188FBC589AD584400A85C9@MWHPR12MB1341.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: i6Wujbml4zBaa6I8AEn4PNCVoI278xZIicYiMG+7DvzbZ+XdrrM22xYRuunMsqwnmefHN0QogsIYoXRsblJxtXP5Q/8qf4IdA2Ko/I0bDFSXNwSf9VzmMWKo5CEPP86gQUUlSeE546oIkRIs0Tc7B7c4nbZjKHHaODxrGilaZessd2Bmw9KAXlDHVpDDetkQ23i7ImNMh7/e/TX+TvbcuABFLug2TqJHN/7RQhr8Mgl2FNSSAyLOS+2kXhvsQmuzMLnGlAKp3m2WQx1gga8PWXdQWcgKa7InBJ3wPtKvOhjbvZV1ntgVr5cb6B1dUbDh5WthSecR64A8cEdIdHpGY8Qh/dhDE3e2gfHwh9O+gV0ewViZbPDOSdbYwjhAAmPUYs0tDXSIOd4EoYStxE3kzLBZglXyqhg7bhaDWDnS2fWh1Au7jA6/YsAiTfDcywfya2fDmOsBHf3yZ9fSF8XGbt+EsX8a1Et+oB0ZHcj1clIJAozXDyjcK4GnfqYvsCszsHlpU5PjDT48LIVeT1UYzjSsnxl/7WLo9rIPkHcgJQflHzFJLm5WBXLjIYqRRLrcGd2B6EgDcSkL9eqt226//WojDeDyidWmgI81o9it1vCz9HWs29qb4S30WsN71L1rhrFc5xZAYOu9PD6esY2uaXbH6C346zVLSOcV1O0I/3Pn5FJQZ68+ZlkFBLQ89yDnIlnjZNvMREvBfS82nqakKA==
X-Forefront-Antispam-Report: CIP:216.228.112.34; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:schybrid03.nvidia.com; CAT:NONE;
 SFS:(4636009)(136003)(346002)(396003)(376002)(39860400002)(36840700001)(46966006)(31696002)(2616005)(31686004)(4744005)(356005)(47076005)(186003)(16526019)(426003)(36860700001)(336012)(26005)(36756003)(82740400003)(8936002)(7636003)(8676002)(110136005)(316002)(54906003)(16576012)(4326008)(86362001)(5660300002)(70206006)(7416002)(70586007)(53546011)(2906002)(36906005)(82310400003)(478600001)(43740500002)(2101003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2021 01:22:44.0148 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c2b919ff-3ce4-4c4c-ab09-08d90d08c980
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.112.34];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT066.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1341
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210501_182247_858499_42BB77DB 
X-CRM114-Status: GOOD (  17.30  )
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

On 4/8/21 10:01 AM, Logan Gunthorpe wrote:
> Hi,
> 
> This patchset continues my work to to add P2PDMA support to the common
> dma map operations. This allows for creating SGLs that have both P2PDMA
> and regular pages which is a necessary step to allowing P2PDMA pages in
> userspace.
> 
> The earlier RFC[1] generated a lot of great feedback and I heard no show
> stopping objections. Thus, I've incorporated all the feedback and have
> decided to post this as a proper patch series with hopes of eventually
> getting it in mainline.
> 
> I'm happy to do a few more passes if anyone has any further feedback
> or better ideas.
> 

After an initial pass through these, I think I like the approach. And I
don't have any huge structural comments or new ideas, just smaller comments
and notes.

I'll respond to each patch, but just wanted to say up front that this is
looking promising, in my opinion.


thanks,
-- 
John Hubbard
NVIDIA

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
