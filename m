Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57375C433FE
	for <linux-nvme@archiver.kernel.org>; Mon, 16 May 2022 22:35:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Subject:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=NpPlI000Df83tLILxBmUWAGtNMcZvLgAm6/3k71RE7c=; b=4ifJRHKBi3m809
	7sR1yExhr7urxbKrQwD1VCcExIFSiMI3bx1CBDXZsHdEYAFQ2D9FK2s4rmqtYVGWljeJBUIL/EDVo
	d0pEb1FAbLE9l7T9xAb55A2SuM7/bhULOvsu3jSFUMZEUOUTFvDcc7aFZDLxbuJ4HRHyZN6ZxfMSD
	gD/3AP13cGOVRNNFLL4WxK5KUW1WlzAi9+d0aANQR/BEmwzedfBQlGd1aLjRfe+woot7rt2DUDUQE
	KMdeC6qfenWfQLHg1HvmtXRtFamBW29YAjgqoXdb1Whpp7+sAEI9AkWMSFhsU8NRdC/htw2qQDUPi
	sGEvlYBzaKtQ0lLVKsGA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nqjJM-00AULR-S9; Mon, 16 May 2022 22:35:32 +0000
Received: from ale.deltatee.com ([204.191.154.188])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nqjJK-00AUJw-Lo
 for linux-nvme@lists.infradead.org; Mon, 16 May 2022 22:35:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=deltatee.com; s=20200525; h=Subject:In-Reply-To:From:References:Cc:To:
 MIME-Version:Date:Message-ID:content-disposition;
 bh=NpPlI000Df83tLILxBmUWAGtNMcZvLgAm6/3k71RE7c=; b=nbbvOq1l/AOdW8AAdrmqYaX3SU
 +BKP4b1ioPIDOKq5mxiC8mxgQx+PJa8pqsNHrgF9heI1XStQtL1VX0tf8YSfIeC5w751r6d+sGV4m
 YCJFqNXQKwgefLzj15o31jE+GfMK9z76fYxadtGnYb6i1FY8ViSnTzZpTyFZpPgGCEuUhOxKi5nQK
 WJT6Mvc2WszLg5OliMAGH7cR5pd8ttOWl3E9TEyQMAcmT2ojXYYVSMGZ9dYV0NQR93BLhEDhzYmBC
 M1DHMP1xM4/0qw7GLD84zbXyXZ3nZo4nwnI3t7/sGUsGgETlEkwd5jum/jgKn5WGfRo2VcUk4VTcz
 z7jevUug==;
Received: from guinness.priv.deltatee.com ([172.16.1.162])
 by ale.deltatee.com with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256 (Exim 4.94.2)
 (envelope-from <logang@deltatee.com>)
 id 1nqjJC-0009d5-0n; Mon, 16 May 2022 16:35:22 -0600
Message-ID: <06e36931-33bf-7c3a-9b7f-afdd9686ccc5@deltatee.com>
Date: Mon, 16 May 2022 16:35:21 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Content-Language: en-CA
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: "linux-mm@kvack.org" <linux-mm@kvack.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
References: <20220407154717.7695-1-logang@deltatee.com>
 <32d5901d-f7d3-0701-0b72-1493897b025e@nvidia.com>
From: Logan Gunthorpe <logang@deltatee.com>
In-Reply-To: <32d5901d-f7d3-0701-0b72-1493897b025e@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: chaitanyak@nvidia.com, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 iommu@lists.linux-foundation.org
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH v6 00/21] Userspace P2PDMA with O_DIRECT NVMe devices
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220516_153530_751808_6C54CC62 
X-CRM114-Status: UNSURE (   7.82  )
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



On 2022-05-16 16:31, Chaitanya Kulkarni wrote:
> Do you have any plans to re-spin this ?

I didn't get any feedback this cycle, so there haven't been any changes.
I'll probably do a rebase and resend after the merge window.

Logan

