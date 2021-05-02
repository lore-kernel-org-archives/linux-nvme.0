Return-Path: <SRS0=wOI1=J5=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9E10C433B4
	for <linux-nvme@archiver.kernel.org>; Sun,  2 May 2021 23:28:51 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 12A0660E0B
	for <linux-nvme@archiver.kernel.org>; Sun,  2 May 2021 23:28:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12A0660E0B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:CC:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=Wz7sql8sn8tyM953mDysWJnKx7jUsW/GsyWwb0djJuw=; b=L9kHF+CZezN7PPLNfcW8oa67e
	KqG6NUOHjn4gnJ9gvbml+AZyQITljVhlOWHQLCjivlH0axMZbkd8BjRBvy/bGwjBVqfOqPFa3tPJy
	XocrqGLN3cHsdhwn4iLwgVgg4EekmxPf7EVnT1IfyRbBa177IrLhoJ4q3gwRJU4OpDc/jlgkVn00o
	C8hPn/z7eFIwsn1l/uS9AMKRt1QQJUcrJ9BNw9fPyameFKkDETHKv4dr2dYkRyQ/RuJoYl5Pb7WGd
	YmUn9xSSuxEd2+PN7DrDe3To6YSsEjpXJZv6FR88a1mogyVat/NL2a6LC7PCRJlmz19GlOeADJJMN
	J9Jy5/9Vg==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1ldLVg-00CiEp-G1; Sun, 02 May 2021 23:28:24 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1ldLVb-00CiEM-M2
 for linux-nvme@desiato.infradead.org; Sun, 02 May 2021 23:28:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:CC:To:
 Subject:Sender:Reply-To:Content-ID:Content-Description;
 bh=UFgbQCQ/CmM2Gb5Gpb1i9CYRTPb53P/T4+rEC6ZqPkc=; b=JJBm2RH9n+INgpSf9XS/ggJ4kR
 D8U+p8oNlGMdZMD90rGDGZhzvHgK9o70K+sMsaAignZjV/gGNXNQh7Ea5AzMfmLX0tzi2NAOD44Aq
 8MTxT8lbapBG0JaA4ythH4qeafCsnLwQTqoyYj9pbrEq/TnZbse6fgSPfeNt59jMq2qz9/xzblJxH
 5nPkYbX8+e1NLvl5bZQ8LkV1AXar3OsA5DlopLI4VW9BtYd+zjcMrcHREC4Y29UpWuk4jQ5wWEanV
 MC9sBvKxDd71HTtE0cdn2UnTyrLeOhvNE1TkdsPk87DFSLn0iJ5vXRH2fJYuJd87ROVIwJ7JRpIYB
 iDVyNoiw==;
Received: from mail-dm6nam12on2055.outbound.protection.outlook.com
 ([40.107.243.55] helo=NAM12-DM6-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1ldLVY-002jOU-PE
 for linux-nvme@lists.infradead.org; Sun, 02 May 2021 23:28:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WJma0NhP2/oHwug2Xw1O4AmnzQMPI+NWndBH8dJTNC9Y1jsONu397i4kKJnBIfibVTfWAwytx9cSgIcwUHwvuY7GK1i2f06ncbhjBQmpxYXypzDxFYbOtv1rKuJYsenHgNZ5+Cej8RJMkMEiJU4L4gaj2Zd3T2uIS3OaXVnEjd6ubXByT8kXT5kUzNquS4PnTZ4Qua2KDLLRj4zaqFgrZVo0AJDlPITbKlb2YaDykqqRPvrKnZHkC6eVawb5nIEhvNoHebccP4ZKj3ZwFlTkubkAOVtl1c45HFWyjtgjf1Ng9qm1cpicMPTWVHTYlGdm5Md1LIFK4FrgW7m7Ufn5qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UFgbQCQ/CmM2Gb5Gpb1i9CYRTPb53P/T4+rEC6ZqPkc=;
 b=FkiEqAtA02CCJN/oPXxvbvHNgYEc5E/2stvq/pDwria9EhXqi8n+q4zRa4Ljzb8ok2CBkThyRv8S8+pOYgzliMbPfK1SCCUwP7lExb5dDTVftlyIGvsyPssB1ncek5cs7w7l78PR8yyYrc3+MuPYcRK/lihaiv72lO6oFpLdI4VGK4HEBy4g5FFKawoQWwNW5V5aG4Kw4RXU3YqugW6wSpSf2ZDTvlIaOV8DxRM/gHJBZwKrCK8GWekStw4Q3SoogHuHhRau2SC7PARKn+Lp9S2dzAPUWxWnaw3d9ev+vC3ezLPqWPa/x9UkCf0BX+oOb+KzzDHnScKoy9OvrrqyVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=raithlin.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UFgbQCQ/CmM2Gb5Gpb1i9CYRTPb53P/T4+rEC6ZqPkc=;
 b=BdHkouwqwfcJFXyALyUuQlhXYtBJm4sf4cQFVuIHTa3zykExdtfNamYprhdc0idRkx8/rnP8h7ckjCmW5/ws5/MBSsc8zvTh4dLFLbRDhqirKJnQay7qJO8Dl/dR8/wi1si8+RsTxd/RajzJS+HeiBjK2pW3f4RyFrya6xIJ6A5Y/GlWcGSv0aJxDY82Ze1TtXNYemSsaHb2F4f+kXf/9SOuiSSmt6KkSTNiZyLcM7I36sP8UfXTOE7fnhkPeKJ3XeUlJ49jWFdjlSl5qVQzRDaYUJ3QnvTS751cLZ6NkTI3yVZFoyOcm3BQaufIDU/zM/gnyaAvkJ+1rRMUGWJjmw==
Received: from BN9PR03CA0327.namprd03.prod.outlook.com (2603:10b6:408:112::32)
 by BL0PR12MB5010.namprd12.prod.outlook.com (2603:10b6:208:17c::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.26; Sun, 2 May
 2021 23:28:11 +0000
Received: from BN8NAM11FT008.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:112:cafe::f3) by BN9PR03CA0327.outlook.office365.com
 (2603:10b6:408:112::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.25 via Frontend
 Transport; Sun, 2 May 2021 23:28:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; raithlin.com; dkim=none (message not signed)
 header.d=none;raithlin.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 BN8NAM11FT008.mail.protection.outlook.com (10.13.177.95) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4087.32 via Frontend Transport; Sun, 2 May 2021 23:28:10 +0000
Received: from [10.2.50.162] (172.20.145.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Sun, 2 May
 2021 23:28:09 +0000
Subject: Re: [PATCH 09/16] dma-direct: Support PCI P2PDMA pages in dma-direct
 map_sg
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
From: John Hubbard <jhubbard@nvidia.com>
Message-ID: <37fa46c7-2c24-1808-16e9-e543f4601279@nvidia.com>
Date: Sun, 2 May 2021 16:28:08 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210408170123.8788-10-logang@deltatee.com>
Content-Language: en-US
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f60ec66a-bc5c-43cd-60b9-08d90dc1f344
X-MS-TrafficTypeDiagnostic: BL0PR12MB5010:
X-Microsoft-Antispam-PRVS: <BL0PR12MB5010617BD45D420E4C740268A85C9@BL0PR12MB5010.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uD2uq+E4ZORkD2HW9/ItHvlVey8s8ypwvcgiRNJ2lnNjcYR1BQv0REIp/DQBs8aVcz+MDnBi2q92C1YupHhOY7VsYqZ1jM/2Suj8bSGfrSdU61B3QZeb7PaCZvTAtvxVazmbhBu6vYkn3gKAairDMtz1E7Pm+oRqU1XnDWX0IoHhWlo+Ar5ZnXjBhnot7CFrIZ3xHBRURbFxdZiaqia6KZ3vbN8TxT2rQZOLPyRZ21rC0y8Qlse5qt6m5WqVkYD+PRc73mxhgf9EqbwM9iwnMwnhuBQ2wJ3OtEIecK6Sq6kMi7VqtYeZxDwLCFjuxtRWMB2+bvabzMw8KCKrMDROJb1llmoqa8od+ftKddt55oG1gN/gbGi5QBYLLguRIQEuzQou2E/IoQJtV89rvO5HeruSALNkhQXNmZ1cGU85QjpMxSv4IpcNVulAA6NKAP+9eAa6E8k6eKMuXiWwrYicgC/cIMUO7CFywQkF7nOJMTaAHJbrmb0RDbfys4xtvi4R0qPHO0n1vYJKNKEwf1eK9tQZR+6XPusYRC1ZEUhOodLfljjJLotuOYqFiuVehivAsb+y22bOt7H98S6BfJoxvtuubeCSgdblkW/BFtNUYKIuZ28oTbKoP4rCbs2Tpfv5hp8t7g9ZGwFokrFkb7Le7DJomzJZeJqdlXcGc2NuOFsfFSAoQ/rotBei0viRVdk/J35syOstQkC1EgdzXIADiw==
X-Forefront-Antispam-Report: CIP:216.228.112.34; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:schybrid03.nvidia.com; CAT:NONE;
 SFS:(4636009)(136003)(39860400002)(396003)(346002)(376002)(46966006)(36840700001)(54906003)(8676002)(5660300002)(2616005)(336012)(31686004)(31696002)(70586007)(70206006)(7636003)(426003)(16526019)(26005)(186003)(82740400003)(7416002)(316002)(2906002)(53546011)(82310400003)(356005)(86362001)(47076005)(83380400001)(16576012)(8936002)(478600001)(4326008)(110136005)(36906005)(36756003)(36860700001)(43740500002)(2101003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2021 23:28:10.8920 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f60ec66a-bc5c-43cd-60b9-08d90dc1f344
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.112.34];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT008.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB5010
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210502_162816_873574_3A47EBE3 
X-CRM114-Status: GOOD (  32.03  )
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
> Add PCI P2PDMA support for dma_direct_map_sg() so that it can map
> PCI P2PDMA pages directly without a hack in the callers. This allows
> for heterogeneous SGLs that contain both P2PDMA and regular pages.
> 
> SGL segments that contain PCI bus addresses are marked with
> sg_mark_pci_p2pdma() and are ignored when unmapped.
> 
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> ---
>   kernel/dma/direct.c | 25 ++++++++++++++++++++++---
>   1 file changed, 22 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
> index 002268262c9a..108dfb4ecbd5 100644
> --- a/kernel/dma/direct.c
> +++ b/kernel/dma/direct.c
> @@ -13,6 +13,7 @@
>   #include <linux/vmalloc.h>
>   #include <linux/set_memory.h>
>   #include <linux/slab.h>
> +#include <linux/pci-p2pdma.h>
>   #include "direct.h"
>   
>   /*
> @@ -387,19 +388,37 @@ void dma_direct_unmap_sg(struct device *dev, struct scatterlist *sgl,

This routine now deserves a little bit of commenting, now that it is
doing less obvious things. How about something like this:

/*
  * Unmaps pages, except for PCI_P2PDMA pages, which were never mapped in the
  * first place. Instead of unmapping PCI_P2PDMA entries, simply remove the
  * SG_PCI_P2PDMA mark
  */
void dma_direct_unmap_sg(struct device *dev, struct scatterlist *sgl,
		int nents, enum dma_data_direction dir, unsigned long attrs)
{


>   	struct scatterlist *sg;
>   	int i;
>   
> -	for_each_sg(sgl, sg, nents, i)
> +	for_each_sg(sgl, sg, nents, i) {
> +		if (sg_is_pci_p2pdma(sg)) {
> +			sg_unmark_pci_p2pdma(sg);
> +			continue;
> +		}
> +
>   		dma_direct_unmap_page(dev, sg->dma_address, sg_dma_len(sg), dir,
>   			     attrs);
> +	}

The same thing can be achieved with fewer lines and a bit more clarity.
Can we please do it like this instead:

	for_each_sg(sgl, sg, nents, i) {
		if (sg_is_pci_p2pdma(sg))
			sg_unmark_pci_p2pdma(sg);
		else
			dma_direct_unmap_page(dev, sg->dma_address,
					      sg_dma_len(sg), dir, attrs);
	}


>   }
>   #endif
>   

Also here, a block comment for the function would be nice. How about
approximately this:

/*
  * Maps each SG segment. Returns the number of entries mapped, or 0 upon
  * failure. If any entry could not be mapped, then no entries are mapped.
  */

I'll stop complaining about the pre-existing return code conventions,
since by now you know what I was thinking of saying. :)

>   int dma_direct_map_sg(struct device *dev, struct scatterlist *sgl, int nents,
>   		enum dma_data_direction dir, unsigned long attrs)
>   {
> -	int i;
> +	struct pci_p2pdma_map_state p2pdma_state = {};

Is it worth putting this stuff on the stack--is there a noticeable
performance improvement from caching the state? Because if it's
invisible, then simplicity is better. I suspect you're right, and that
it *is* worth it, but it's good to know for real.

>   	struct scatterlist *sg;
> +	int i, ret = 0;
>   
>   	for_each_sg(sgl, sg, nents, i) {
> +		if (is_pci_p2pdma_page(sg_page(sg))) {
> +			ret = pci_p2pdma_map_segment(&p2pdma_state, dev, sg,
> +						     attrs);
> +			if (ret < 0) {
> +				goto out_unmap;
> +			} else if (ret) {
> +				ret = 0;
> +				continue;

Is this a bug? If neither of those "if" branches fires (ret == 0), then
the code (probably unintentionally) falls through and continues on to
attempt to call dma_direct_map_page()--despite being a PCI_P2PDMA page!

See below for suggestions:

> +			}
> +		}
> +
>   		sg->dma_address = dma_direct_map_page(dev, sg_page(sg),
>   				sg->offset, sg->length, dir, attrs);
>   		if (sg->dma_address == DMA_MAPPING_ERROR)

This is another case in which "continue" is misleading and not as good
as "else". Because unless I'm wrong above, you really only want to take
one path *or* the other.

Also, the "else if (ret)" can be simplified to just setting ret = 0
unconditionally.

Given all that, here's a suggested alternative, which is both shorter
and clearer, IMHO:

	for_each_sg(sgl, sg, nents, i) {
		if (is_pci_p2pdma_page(sg_page(sg))) {
			ret = pci_p2pdma_map_segment(&p2pdma_state, dev, sg,
						     attrs);
			if (ret < 0)
				goto out_unmap;
			else
				ret = 0;
		} else {
			sg->dma_address = dma_direct_map_page(dev, sg_page(sg),
					sg->offset, sg->length, dir, attrs);
			if (sg->dma_address == DMA_MAPPING_ERROR)
				goto out_unmap;
			sg_dma_len(sg) = sg->length;
		}
	}

thanks,
-- 
John Hubbard
NVIDIA

> @@ -411,7 +430,7 @@ int dma_direct_map_sg(struct device *dev, struct scatterlist *sgl, int nents,
>   
>   out_unmap:
>   	dma_direct_unmap_sg(dev, sgl, i, dir, attrs | DMA_ATTR_SKIP_CPU_SYNC);
> -	return 0;
> +	return ret;
>   }
>   
>   dma_addr_t dma_direct_map_resource(struct device *dev, phys_addr_t paddr,
> 



_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
