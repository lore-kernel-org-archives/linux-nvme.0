Return-Path: <SRS0=SWCy=JM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 243C6C433ED
	for <linux-nvme@archiver.kernel.org>; Thu, 15 Apr 2021 08:21:49 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E194E61166
	for <linux-nvme@archiver.kernel.org>; Thu, 15 Apr 2021 08:21:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E194E61166
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=f4TqRgfEKifOdp8/B50AFoa6sA7xxdWNHb7yvJ7mMfE=; b=cBZ8qPVc+IN/5vwPO4Q9n//d8
	TQAErHuLHA9pL8w0UA/FkMs74UFOBPXq8+OoF1hlbzO8/YwpZuuLu8NbH09lRh6GsvXSlLu6ZNDYL
	ZU8yeCdXLH+gngIZ2tEm6MtnDU9bWNg3aSD1y9v+SVlAxiY5rE0I3WGhsa7HirnFdaVBydPWvz5Vx
	tbklH1gEbySk5PEEQH4OoqrXzLCNqdajbbu9Uu4STH3aYmYnizeZVw/Ag1FcnH5mJ8TImNpZeJdG7
	B2vtVJey1hTCoBwzgsALWIwMrL/ttRKLwV0iFar8cwJkfejDQ2uEVD7Sva9rej7IG79Ni/3+qdPDP
	EJfoAB2uQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lWxFh-00FKtt-EM; Thu, 15 Apr 2021 08:21:29 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lWxFb-00FKtF-G1
 for linux-nvme@desiato.infradead.org; Thu, 15 Apr 2021 08:21:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=mzdZB4W4tK1YoIpVXqrIlcRVaBOWBGFtglH23yBLCYQ=; b=PqxpC1HoBQMfT7UhjbGe6NyvPo
 NQIo1S+c0inu2jcPBThF7xynKpRd9S+WvWGGEiSzbyo5UXcEawSEDUW+Z0Jy6b5w9TKFUkzr4nMxz
 ZNpH8FlfQCBwSWkrWl2sxso2IBd61ERyj5kzX/ZdmqXC2lkjxEKjz4OCv6zwmOds8WAI9GaynVOrX
 qDCf5Lml34Fjlqbh1ega0RUv8VgmWNf+RemIeq0XLvhHFk1vQjJOOqZD9jHPleVOM/3cdpnXkq/y/
 VX56hlcc3A7TmVYVqycTJbZiwk+MAWnbS6KkCMu3A9ng5yM+xH1RNBDIEubiFWMOM9lLoYtE2P1eP
 WKygqKpg==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat
 Linux)) id 1lWxFB-008Hiw-Bc; Thu, 15 Apr 2021 08:21:00 +0000
Date: Thu, 15 Apr 2021 09:20:57 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Prike Liang <Prike.Liang@amd.com>
Cc: linux-nvme@lists.infradead.org, Chaitanya.Kulkarni@wdc.com,
 gregkh@linuxfoundation.org, hch@infradead.org,
 stable@vger.kernel.org, Alexander.Deucher@amd.com,
 Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
Subject: Re: [PATCH v4 1/2] PCI: add AMD PCIe quirk for nvme shutdown opt
Message-ID: <20210415082057.GA1973565@infradead.org>
References: <1618458725-17164-1-git-send-email-Prike.Liang@amd.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1618458725-17164-1-git-send-email-Prike.Liang@amd.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

A cover letter for the series would be really nice.

On Thu, Apr 15, 2021 at 11:52:04AM +0800, Prike Liang wrote:
> The NVME device pluged in some AMD PCIE root port will resume timeout
> from s2idle which caused by NVME power CFG lost in the SMU FW restore.
> This issue can be workaround by using PCIe power set with simple
> suspend/resume process path instead of APST. In the onwards ASIC will
> try do the NVME shutdown save and restore in the BIOS and still need PCIe
> power setting to resume from RTD3 for s2idle.
> 
> In this preparation patch add a PCIe quirk for the AMD.

The above looks very hard to understand to me.  It uses some AMD
specific terms, and also is overly specific to NVMe.  Any other PCIe
device not doing a runtime-D3 in these slots will have the same problem.

So I think you should generalize the flag name and description to
describe what broken behavior the AMD root port has here, and only
cursory refer to drivers that are broken by it.

I'd also much prefer if the flag is used on every pci_dev that is
affected by the broken behavior rather than requiring another lookup
in the driver.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
