Return-Path: <SRS0=pISK=JY=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2ADDC433ED
	for <linux-nvme@archiver.kernel.org>; Tue, 27 Apr 2021 20:22:24 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C5B8761078
	for <linux-nvme@archiver.kernel.org>; Tue, 27 Apr 2021 20:22:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5B8761078
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:CC:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=eavgNwb/TVP4GCBUwJzVO1PHkMRcFm7QlNOiLBpcn/Q=; b=pf4ZDoiuhnkOImEaGEimi8oJa
	Ko3tHcUtDcIfYAo+XvKGoresuiLuHjmSMcT7zcugqAYvXR1JlBUqXARePUdCUIJb6LHBpXQx6269y
	YbDRnkfE6Ak97cDkTtcDJR6xBcVyqnPysGeAQV+KlgIeaqEaFXNZ8BvpMkDUoo2KOrWOSrFPEWpgd
	5B6tB0SIzZ8nnQ2T/Rj0/1wPXQ2r0KOAbf10H77IOlbCa2MHMJAex9tTd4PkvcjCNJb9WLX1Hfm1o
	/ApK6uABWVHlvaAN1IWmygW22b8mUaoGRjMRWzwU4aLXKDH6yGhjy1i0vY//Jev5+5G0yrEUQJxS1
	egT+wxV+Q==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lbUDc-002BiX-B0; Tue, 27 Apr 2021 20:22:04 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lbUDX-002BiB-Dp
 for linux-nvme@desiato.infradead.org; Tue, 27 Apr 2021 20:21:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:CC:To:
 Subject:Sender:Reply-To:Content-ID:Content-Description;
 bh=fiaYlcoLb3O9H9MAJq8qvDAm+vShn4NgsspG8l0T0SE=; b=S8B/wqyI6vZhAAFlSacpteiOs8
 FdR5I+TeXhvxyhgbiuwlr7TsFJl1uTtipl2t1luClecDMH+u371+Fd6YEcyfP7j5czov5Zub1DPZ7
 +2b+C8CHzNm0yahd64SsEL8NcQja+82rc9g/sM3iyjm3Q49MJBKOVx4Co4/31aGxsrZbCZvrMOXps
 Z7z13E56AQ+89eYWrowlyzcok7xiTEkJPUCYKa0ECKVqGZNRXyl3olSuPP5JouPos3HlbzAo7v7uW
 I6Pedjpt5yvhqmfM0NFZRn0aDRypXxK6YdayisExH+jNU3gSPSqpxkmZuTYcmME3ADxoXHkhHhCha
 4TQzXkiA==;
Received: from mail-eopbgr700072.outbound.protection.outlook.com
 ([40.107.70.72] helo=NAM04-SN1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lbUDU-00GyFJ-7s
 for linux-nvme@lists.infradead.org; Tue, 27 Apr 2021 20:21:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PZBJ/MAcBHZhEP8a6pLGpLWA4Hsva+6tNEzoK0v1m7HvxKXRogS0tzlrq9hbeWuiOXT6E05aRFN+Ian1FjUWsBeGDX9+LnqdafU3q9kl6+bVoHGOmNuq5n7K+9YwHkvJKgxQ8xP1VaewKxvQ5+uyhTB9eHmpBCg6v6OYvhk8HcXjUdGLXiNN0j4i/eDLXQzV09XUTw+vOeZwSWa2K3ZU2qtadTXcbiRY01ESgdOuoZYt6K6tEneUou5Ye+hNZg8MEpMnC7dUnI8PqOsJ+SuqG6vUed1PVH79CcTtwFI+IxP2jx4CvsVp+HHH6ZTCPyIP5Q4AOCiTDkFlJmDgiUFMtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fiaYlcoLb3O9H9MAJq8qvDAm+vShn4NgsspG8l0T0SE=;
 b=WUCAWc7eklT0N+HHN2liR14NwEUisDaRtUzn/rZxL8vc9tfiD9a3SEX/d2MyI53dFqYMJjqTYzKL9zPjmur4Yh5as8pKvx67PfuvBWwFe8G5y/Y8m/IR5qE6Pe7OgFo0UjkZ4fVEwXbgrZEHNYsv9s1NDFy4jOAxWDVK8TCqF/D+UKSVfwdHG6mYjC3i/oFpJDYeBxw+5i7H1LmF6oWHwRapVmnrqg0Mdt6sGmTHeQcz+jgHRfF/CW9rxcfByHuI4QkLORC1zhpsyvdCy9+rVTooDTSNniAvBtFRfLPoNQ2hzAMp7qceG8vjx6nNZI6WVc3szPDlNV7X65aSFGMMEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=lists.linux-foundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fiaYlcoLb3O9H9MAJq8qvDAm+vShn4NgsspG8l0T0SE=;
 b=f1cLjDgUlJbPee3oc1owW4qJzOYw2drYOVLgBGG7CgWCfOlcbV6dojR9oa6/GZYYq3CSjd2v8qsNwQ1VJMXIj6M2FM3Q+9puzdrAmLhIMKaWc9oNv++w6be/wv2H8/OOL2Dnd6oEHnrUwqsFm3to5GEAYgY/wz6+eIvHCZSsRDUlfzkhsPrkYw5EEog3VOhME2loK1fVBnMyimEQQRW8rIvQaYbpzquVkd1I24R+d2T3uDkUaF6B1MEA68mty5Jsp0KPIdsGvn9ma750ibjFMNBSj3aoBSLJV/7+GE43y9FovhtYSGntCbuThGlSxQChmU1e1U8AxRGB318wOLbPHA==
Received: from MWHPR14CA0037.namprd14.prod.outlook.com (2603:10b6:300:12b::23)
 by MN2PR12MB4814.namprd12.prod.outlook.com (2603:10b6:208:1b6::32)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.20; Tue, 27 Apr
 2021 20:21:52 +0000
Received: from CO1NAM11FT036.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:12b:cafe::2e) by MWHPR14CA0037.outlook.office365.com
 (2603:10b6:300:12b::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.21 via Frontend
 Transport; Tue, 27 Apr 2021 20:21:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; lists.linux-foundation.org; dkim=none (message not
 signed) header.d=none;lists.linux-foundation.org; dmarc=pass action=none
 header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 CO1NAM11FT036.mail.protection.outlook.com (10.13.174.124) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4065.21 via Frontend Transport; Tue, 27 Apr 2021 20:21:51 +0000
Received: from [10.2.60.58] (172.20.145.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 27 Apr
 2021 20:21:51 +0000
Subject: Re: [PATCH 00/16] Add new DMA mapping operation for P2PDMA
To: Jason Gunthorpe <jgg@ziepe.ca>, Logan Gunthorpe <logang@deltatee.com>
CC: <linux-kernel@vger.kernel.org>, <linux-nvme@lists.infradead.org>,
 <linux-block@vger.kernel.org>, <linux-pci@vger.kernel.org>,
 <linux-mm@kvack.org>, <iommu@lists.linux-foundation.org>, Stephen Bates
 <sbates@raithlin.com>, Christoph Hellwig <hch@lst.de>, Dan Williams
 <dan.j.williams@intel.com>, =?UTF-8?Q?Christian_K=c3=b6nig?=
 <christian.koenig@amd.com>, Don Dutile <ddutile@redhat.com>, Matthew Wilcox
 <willy@infradead.org>, Daniel Vetter <daniel.vetter@ffwll.ch>, Jakowski
 Andrzej <andrzej.jakowski@intel.com>, Minturn Dave B
 <dave.b.minturn@intel.com>, Jason Ekstrand <jason@jlekstrand.net>, Dave
 Hansen <dave.hansen@linux.intel.com>, Xiong Jianxin
 <jianxin.xiong@intel.com>, Bjorn Helgaas <helgaas@kernel.org>, Ira Weiny
 <ira.weiny@intel.com>, Robin Murphy <robin.murphy@arm.com>
References: <20210408170123.8788-1-logang@deltatee.com>
 <20210427192838.GP2047089@ziepe.ca>
From: John Hubbard <jhubbard@nvidia.com>
Message-ID: <52f14602-94bc-fa98-0b97-5f4084d808a0@nvidia.com>
Date: Tue, 27 Apr 2021 13:21:50 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210427192838.GP2047089@ziepe.ca>
Content-Language: en-US
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 594ef245-3cb7-44f5-5081-08d909ba17f2
X-MS-TrafficTypeDiagnostic: MN2PR12MB4814:
X-Microsoft-Antispam-PRVS: <MN2PR12MB481497BFED71E349C1972892A8419@MN2PR12MB4814.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LdEM32LL+68YQ/yivUq8issFecE2lGG4Tk4FXqIzbX2qmLvmDqzOx1LDDEjAB5pAT9RuzvCb95J9bhN2Z6cJQ+PD9Q3J9A0sAE5XMDSyWHo2QuNEgVEusZrLjje9JbJtgBW8rLbVQGUJet77NmgadXx+DKdECITVEtsccbVDWhY8su0dC2+Pa7hjf6Y1vXzxjCQB6kFzskVUClQxamW5ACJ1Y8FqNOxXz2Lq3/Z4K2fBevP5y8ljuqg7jTM8ksax9bf/BdSMQzCdNTooc8bHRZMiovfNWeT1jB04ZgljfJKkIEQeWYR5MD5bsQ9Lh4g17HYrl/14jtvY0TYvJdHoZ7ZkOkqgSqMKvhKjnLNyhalXY+EeE4m2Ry1ywgZYstl81k98gOCOvJDJKyjbidj5k1WwHtG5ZEGpPPg0PHHbEUv2HlQ/RpBUAQz6+XFIoIkqU6RswmYfPJyFDcKfxBugAAvUBiwkaM7nrUcmQ6Jc+2yWC+cmebNs015pf4dxnjKNsb7PvZ2dMoO/0f0M7ruEgNWT97ySnnjCshC1DmBBjvbibRLVD06uP8LLQ1eL8FG61n9bSIWjww4fx7qtly+chduVXkHrJ1RE3UAYz5rkTSuEskDTa+ZoWwQt1THigT9uH0TUmS1rmfy2yzLO9CuSawkIg8vonoDzg8J7qrm1sd2r33ZUVgEkdcPZjXATNiPE
X-Forefront-Antispam-Report: CIP:216.228.112.34; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:schybrid03.nvidia.com; CAT:NONE;
 SFS:(4636009)(376002)(396003)(136003)(346002)(39860400002)(46966006)(36840700001)(2906002)(31686004)(31696002)(4326008)(54906003)(70206006)(426003)(2616005)(53546011)(82310400003)(83380400001)(478600001)(336012)(7416002)(47076005)(36860700001)(82740400003)(356005)(7636003)(5660300002)(8676002)(8936002)(36756003)(70586007)(86362001)(16526019)(26005)(316002)(110136005)(16576012)(186003)(36906005)(43740500002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2021 20:21:51.8999 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 594ef245-3cb7-44f5-5081-08d909ba17f2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.112.34];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT036.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4814
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210427_132156_514347_2154AC8C 
X-CRM114-Status: GOOD (  17.35  )
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

On 4/27/21 12:28 PM, Jason Gunthorpe wrote:
> On Thu, Apr 08, 2021 at 11:01:07AM -0600, Logan Gunthorpe wrote:
>> Hi,
>>
>> This patchset continues my work to to add P2PDMA support to the common
>> dma map operations. This allows for creating SGLs that have both P2PDMA
>> and regular pages which is a necessary step to allowing P2PDMA pages in
>> userspace.
>>
>> The earlier RFC[1] generated a lot of great feedback and I heard no show
>> stopping objections. Thus, I've incorporated all the feedback and have
>> decided to post this as a proper patch series with hopes of eventually
>> getting it in mainline.
>>
>> I'm happy to do a few more passes if anyone has any further feedback
>> or better ideas.
> 
> For the user of the DMA API the idea seems reasonable enough, the next
> steps to integrate with pin_user_pages() seem fairly straightfoward
> too
> 
> Was there no feedback on this at all?
> 

oops, I meant to review this a lot sooner, because this whole p2pdma thing is
actually very interesting and important...somehow it slipped but I'll take
a look now.

thanks,
-- 
John Hubbard
NVIDIA

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
