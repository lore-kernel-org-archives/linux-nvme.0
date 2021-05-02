Return-Path: <SRS0=wOI1=J5=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D64BBC433ED
	for <linux-nvme@archiver.kernel.org>; Sun,  2 May 2021 23:34:12 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 490DF6134F
	for <linux-nvme@archiver.kernel.org>; Sun,  2 May 2021 23:34:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 490DF6134F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:References:
	CC:To:From:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=LHt+i1IqlFyXUglOwFaWkjqbQWgfrpzZvmwJ5+D4hsM=; b=MH6fxCXEuKhRf3BTtf/pu3Vij
	JjK4wQxVv8Tyn+7ZzjpkkeNHx+um8vpxwROngzCMbwFw4MyFKpqAk+/X+hjb5JSUU7dQJUQm+EBS+
	AvWGRHsynX7QBDfG3AkedPYWSriSIHdH/sHePNOtgh+jsTB6M3fsgSmO5/qs1990kfb7FiW6ueGTj
	0L2z+a2OSsdgCR+ROtpCD6zCe9j45aEKm8SRl2MX+0KQq6EEQ+YEOTT8SqhfQdveP5gd434PGh2sR
	gw6TTjd5t6xvtwsD+7yPlh4zTaE0DGNKziQwicrK3BU63WnRDjz5IpVb0NbT/TmJTpmuHEwEd+bD0
	3MB5XlZew==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1ldLaw-00CidS-EH; Sun, 02 May 2021 23:33:50 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1ldLa7-00CiYn-3s
 for linux-nvme@desiato.infradead.org; Sun, 02 May 2021 23:33:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:References:CC:To:From:
 Subject:Sender:Reply-To:Content-ID:Content-Description;
 bh=xcoB9rLGkprvKPLH+bPA/60/uq/DD31cxgWYpuQaEP0=; b=Qi3Sk3+aRJXaR4Sx0K1y43lGGA
 2tY5OK660bHD5Yd7paEvjIxHU8dsMLyN8danObOvKg/ztbQ0LHPCWIEyl9bXZp5xtsa2Rjb2takD0
 MjS+fNoB0hk1XkJU6em9ounEN6VHYXkwg+RYMb7R4J9ojJ/c1VwTKkOgbaxt5H/1OjI1NpAGYYIb1
 lr0e9durHFIVuPZqmLnn8FdAl0LJ9DsCwljlA/ltvHhPOlVv8q7Yztk7WkG9PB9ZIANj7IGOKYRel
 /MoDUrGkhDnKfHHkOvwCKr6eFfvItNeDfVkeixD76fW/OFZyFMSp7Vfl28+JriGjrAz7XYCwrNHRw
 uWj6vcOw==;
Received: from mail-co1nam11on2050.outbound.protection.outlook.com
 ([40.107.220.50] helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1ldLa3-002jWO-T0
 for linux-nvme@lists.infradead.org; Sun, 02 May 2021 23:32:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B36hyR8YzFAnS9eeRK/hQMlEukXxjhAhT/fGfsQ/BZBEBB5WwtDf34WwXumw51ZAEbrvEMt0OKvTuGiGr65VLFjXRbGe1tt2RrI5bPPDlJb62AwZsZ4dGG0sUN6qaP+x5KsWFHG4MSHU1d0WWxvbXx8o+ffqgGuzJBip+2dYhdfzDPEjHP1Ob8NbE3YyiTaEeQ1zaL+BRQBpkrfV//fI+x5sniHfDnnkDevC5WBE4qPp775x5pSpXAW6hCxMwS7F9ZRfDTc3a7qntHpkLrTUWQQeFO6YcAOxW5b8VT7TnzlfT3P7a9yNUkIgBGXe8eA3IpMqRXvKQIJp9rjsx72aYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xcoB9rLGkprvKPLH+bPA/60/uq/DD31cxgWYpuQaEP0=;
 b=Mtfruyn3VdNf+q0uNVf598At+bo/m1vxcYRgvsZmYfA5TAKP4MYNt4XIKK7P0DXgfnW+ObiIGjCYxxV5Z1Muvt4DG6MzmW2ZA+oBEGXHSDpYT/RSaYnsvv4ZGzcu28R2QG+AQrdYSRt171j68ob0dUcelTxRJ/hoMQUoeOXooCL3haTxS7ek8wX+c614DjDC6Safp4lAzG3xV4sANFX5XA5oYrZsWCJ7uamVdBQrNSIdtMMtZOZ4LkXX4xoJAx14DMCm9lpn78je6UWG5yXOkHIJ3QkE54wTpyDOKJfiVPr6txXSB9NiEod7I9YTRGeF+qJ35meY9QJQJSlk1/t/Ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=raithlin.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xcoB9rLGkprvKPLH+bPA/60/uq/DD31cxgWYpuQaEP0=;
 b=MO49TZfxcwz4GnwbvoWMD9EDBonrifyetwJ/FLyO6IaYLe/k9nq0+UQQ1Hc+UponK6YQn53KvznFwjaa1w/MB7BnVAPMsvmhswVZ8O7dRCSNvGDF+EZaLf4OeEDyRV5lgiLOMU4I+3/iudNgl/uktyqmkCBZemTpeYZ3MtWLgHMedRpJ+47VkTNGkKGPxvmsFIQLzjgue9poAem4OuqHYUKtnfVipZo5kHYK6+Gp/zH+94eFnM9R796elY15tZL1LMn44N/F2ts86XP0Y59MfOm3octFgXORx4Yx81PwKS1eWStAhI7JwBhSuS5WbNoA4No8lDCZfnzRxlnLBVQI6w==
Received: from MWHPR22CA0045.namprd22.prod.outlook.com (2603:10b6:300:69::31)
 by MW2PR12MB2425.namprd12.prod.outlook.com (2603:10b6:907:f::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.38; Sun, 2 May
 2021 23:32:51 +0000
Received: from CO1NAM11FT042.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:69:cafe::13) by MWHPR22CA0045.outlook.office365.com
 (2603:10b6:300:69::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.25 via Frontend
 Transport; Sun, 2 May 2021 23:32:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; raithlin.com; dkim=none (message not signed)
 header.d=none;raithlin.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 CO1NAM11FT042.mail.protection.outlook.com (10.13.174.250) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4087.27 via Frontend Transport; Sun, 2 May 2021 23:32:50 +0000
Received: from [10.2.50.162] (172.20.145.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Sun, 2 May
 2021 23:32:50 +0000
Subject: Re: [PATCH 09/16] dma-direct: Support PCI P2PDMA pages in dma-direct
 map_sg
From: John Hubbard <jhubbard@nvidia.com>
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
 <20210408170123.8788-10-logang@deltatee.com>
 <37fa46c7-2c24-1808-16e9-e543f4601279@nvidia.com>
Message-ID: <f2ac9584-6133-cd3d-e9a0-bff20adfb23e@nvidia.com>
Date: Sun, 2 May 2021 16:32:50 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <37fa46c7-2c24-1808-16e9-e543f4601279@nvidia.com>
Content-Language: en-US
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ccf9cb84-36f7-42fc-2b50-08d90dc29a1f
X-MS-TrafficTypeDiagnostic: MW2PR12MB2425:
X-Microsoft-Antispam-PRVS: <MW2PR12MB24257AE763276687633D91BCA85C9@MW2PR12MB2425.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JE84jnW6G0vqJjT7yu4KVMnQyR3Fss9I7iTg5tFhdTUcYDwQZ/DgNNTL8ZvKQyP7a/FOe3OVGfWhMSFyHtig6uHa5P+k3bE0PyAfqBdltC7KaT338ZYBp/dBlHWAnG0Yym29oLv6XzteTXNhXpXX8eiM7qRYJFu0fwLcVZ30cVtew0xF/CPfIcCBnX8U6YEutzZQjch4RqdEJwSSgsdNEsBBHiru577OLIXjdr1KylHTFnWZ3cITF5NRy8ryEIaWgWLpXD2ojwJ3k9sducOXfU348cGJ3Xoe7CVCaxEPN2ZoCtaw10uq214a9MUh6mNAbdp3GVuq4Oz7pASwca5p7YNY+5XsC5ICF7RwEjPVD/2lLcCmEg+RVD56j6+NBfAXGsUqCir36WdZ8TDyZ/XSi/hCK2N7Jaa59tGPpAEBaXnE5ZosiNGa1IutHXuY87NbmDCj3pSCtoi+BQ/7D6in62XgdgpfgR7V86gg366TeWazHZr6eiOIUntKjXxTxMxwv7r8KFQTGSBtw71779qkqBcjJGrMXs+W2OojeFbFzFyzF6QOA45Tnt/GtcScf3S15J2ST0lICokPl5xsLRrEZw6KZfTGAdXUvAGznTJDKC7X1EFFaBT00qUfw/wTN60eBxn4CM8MCIKq8NAPz7QcrnBLpHsOEr7EOCSi+XRK0ZAFuwcmRCgiE1VfKPLLJKlWuyGf6PXU7yp2AlzMqxr/Nw==
X-Forefront-Antispam-Report: CIP:216.228.112.34; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:schybrid03.nvidia.com; CAT:NONE;
 SFS:(4636009)(396003)(376002)(136003)(39860400002)(346002)(46966006)(36840700001)(8676002)(186003)(36860700001)(4744005)(47076005)(82310400003)(336012)(426003)(110136005)(53546011)(478600001)(26005)(31696002)(31686004)(4326008)(70206006)(36906005)(54906003)(82740400003)(2616005)(7416002)(356005)(86362001)(316002)(7636003)(8936002)(36756003)(2906002)(70586007)(16526019)(83380400001)(5660300002)(16576012)(2101003)(43740500002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2021 23:32:50.9216 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ccf9cb84-36f7-42fc-2b50-08d90dc29a1f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.112.34];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT042.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2425
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210502_163255_949823_A4346010 
X-CRM114-Status: GOOD (  12.95  )
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

On 5/2/21 4:28 PM, John Hubbard wrote:
> On 4/8/21 10:01 AM, Logan Gunthorpe wrote:
...
>> @@ -387,19 +388,37 @@ void dma_direct_unmap_sg(struct device *dev, struct scatterlist *sgl,
> 
> This routine now deserves a little bit of commenting, now that it is
> doing less obvious things. How about something like this:
> 
> /*
> * Unmaps pages, except for PCI_P2PDMA pages, which were never mapped in the
> * first place. Instead of unmapping PCI_P2PDMA entries, simply remove the
> * SG_PCI_P2PDMA mark
> */

I got that kind of wrong. They *were* mapped, but need to be left mostly
alone...maybe you can word it better. Here's my second draft:

/*
  * Unmaps pages, except for PCI_P2PDMA pages, which should not be unmapped at
  * this point. Instead of unmapping PCI_P2PDMA entries, simply remove the
  * SG_PCI_P2PDMA mark.
  */

...am I getting close? :)

thanks,
-- 
John Hubbard
NVIDIA

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
