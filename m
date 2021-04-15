Return-Path: <SRS0=SWCy=JM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A861BC433B4
	for <linux-nvme@archiver.kernel.org>; Thu, 15 Apr 2021 19:31:00 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C11E61153
	for <linux-nvme@archiver.kernel.org>; Thu, 15 Apr 2021 19:31:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C11E61153
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=q7StNrymtLq4uYGOTkkgyhJaMeK+TE4w5zj2hnuPv8g=; b=cyOWrJc6qPigzcWaSF7cnqe7L
	AJxIWop58pv8gp2fuDV3S/4IeopPGMJK6769O9GLZoVtykMAEPnWPNSdASTAFOVVEqwBmmD0QlB3L
	ZhEGde3q14oaXk8APbbDXQhLDFEdM/7N02nMoEhd3u+Q5NTrNATk+o3AHV4TRpdD8GMeoG06/J32M
	ne4sdE8N2mBSZpqYNDweTekugk9Sc2oBJ0oj6kQyXbfNXfMK9YRQaCBBUz6BDzGDETHQTXrsPzU4f
	0nxPwDSIcfKtToQguHvE/uNPNxx1A7gGMqT1x/R3pXy9sUnJK+Q8l8PeIU4n/tgyJh/B5UtnNOHGW
	d7XH6c3Hw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lX7hL-00H8fD-9x; Thu, 15 Apr 2021 19:30:43 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lX7hG-00H8el-CW
 for linux-nvme@desiato.infradead.org; Thu, 15 Apr 2021 19:30:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=L28qTk6uhW+fAs64rRSOMnRHWeA1ch4cWaljTMpaX0k=; b=RzCVrBfXU0TVKMGcpjEm/Hpd8u
 ixA4vskqaJQZN6Ud2UpD23OQtdfnZRcfbymvxGql6+WOIQsnXAwSi5CoRcRFWjcSTSemasyNdDVDy
 ciejARZhalUz+qeTLJb+DDSAGC2XTtcy7GisF1ll6lj7RSLMuTpmTv7rE5OK/JH88HayzsdPHP3vo
 5EAdwhD3D4csBz4jVLJ2qWYx7hXqL8VRB+OIjNNrM9G9dcgfrL4F3p282DCIU2VhH33yRJorSLFlr
 /7rZdYwr8mdMHmiPS8NQzhLWeBNiPGA471BCcuU+1XYN9Q+fvwxEY814SgzNKI58gix1dg6O42WbZ
 p7H7J6LQ==;
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lX7hD-008qYD-Vq
 for linux-nvme@lists.infradead.org; Thu, 15 Apr 2021 19:30:37 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0686C61152;
 Thu, 15 Apr 2021 19:30:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1618515034;
 bh=x8ZtAeHHjDnPvQQi/Da8RKo83qvqfBo3qi61FHykoLY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=QiOH+QRSHl7qk5yoymU7OEiBi6RAtm5nwyRFfGyXZUolUl/Fm8JxWknwGOC4N6slK
 NiVtJy9CeYF3Dh/i5TgPqwo3HdZ4ptLWD0tvpTeP6wQpLjReyh/9BCYTtYIZlTnvM/
 Bhb4xtESbY4sDyyoR6CANA6YKt+O3asCCoFNLF6oLlY0wi6RR4NsRsslHG00Hjyslg
 yGPLIct8FCin8DdzKKmP02239ePKCESSP3667lU/oYQmpJRIX+TNlF9MN7O5G12i0k
 xQxIBshVp8oA18H18eG7MfrUgz0yb5bcGbnkWE3mEvju5cVoGfTaw9QFQsEaQ3TdKP
 pauh4fChvXmQA==
Date: Thu, 15 Apr 2021 12:30:30 -0700
From: Keith Busch <kbusch@kernel.org>
To: Yuanyuan Zhong <yzhong@purestorage.com>
Cc: Chaitanya.Kulkarni@wdc.com, axboe@fb.com, hch@lst.de, sagi@grimberg.me,
 linux-nvme@lists.infradead.org, cachen@purestorage.com
Subject: Re: [PATCH v2] nvme-core: initialize status to NVME_SC_HOST_PATH_ERROR
Message-ID: <20210415193030.GA2452080@dhcp-10-100-145-180.wdc.com>
References: <BYAPR04MB49656BC34E2C7AA4E3324DF2864F9@BYAPR04MB4965.namprd04.prod.outlook.com>
 <20210414170833.24929-1-yzhong@purestorage.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210414170833.24929-1-yzhong@purestorage.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210415_123036_077461_DEFF1658 
X-CRM114-Status: UNSURE (   9.83  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, Apr 14, 2021 at 11:08:33AM -0600, Yuanyuan Zhong wrote:
> Block layer blk_end_sync_rq() silently drops blk_status_t error.
> When ->queue_rq returns error, nvme driver should set nvme status
> explicitly. Otherwise the passthrough command may take the stale
> status as result. A typical value zero will be interpreted as
> NVME_SC_SUCCESS, despite the dispatching error from ->queue_rq.
> 
> Instead of trying to fix it for every error return, this change
> initialize the status to NVME_SC_HOST_PATH_ERROR during
> nvme_clear_nvme_request().

It doesn't look like these types of errors are unique to nvme. Could we
not just have blk_execute_rq() return an error instead?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
