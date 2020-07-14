Return-Path: <SRS0=z7iv=AZ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0980C433DF
	for <linux-nvme@archiver.kernel.org>; Tue, 14 Jul 2020 11:19:44 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC21E2220C
	for <linux-nvme@archiver.kernel.org>; Tue, 14 Jul 2020 11:19:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="FE5ajnHb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC21E2220C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=a64vaSP66/ccVwzgMAp7UmA3rcrKyXOQSPpw2lUN5os=; b=FE5ajnHbMWhC2eDD7aCdUxnpt
	pYSXXoA1773i4xd45L2C+Bg5ZmpClrt0vJbo7h2LkjoL1zbpUKt5V63LXcvUwrkryUaIk2PskJgxe
	ju9JcFlbu+cWjI7rKAqtLQYZzqe9BVMph4wXcA22loJ8VKVOBzubQxIz3WY0v4klz0ifbWTLBaCVV
	SttxNJQCpUnN1wZK+8biaJ/tOYseURxWNQuY8FzRrFHON4Iq3Wmx6KqinhKd3DMEZAnrD+tgtC3BC
	VH0raec+RktML2jxFoyPNdO4HqXEKhDv8CxhusK5lT3JNouwpQW9cnusp9zSsR23MHxpuRZrPW9eL
	SN5EysJqA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jvIyK-0005ak-IU; Tue, 14 Jul 2020 11:19:40 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jvIwW-0004OS-LW
 for linux-nvme@lists.infradead.org; Tue, 14 Jul 2020 11:17:50 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 6BE1368CFE; Tue, 14 Jul 2020 13:17:46 +0200 (CEST)
Date: Tue, 14 Jul 2020 13:17:46 +0200
From: Christoph Hellwig <hch@lst.de>
To: Baolin Wang <baolin.wang@linux.alibaba.com>
Subject: Re: [PATCH] nvme: Remove redundant validation in nvme_start_ctrl()
Message-ID: <20200714111746.GA17883@lst.de>
References: <710eb90d9c1c125bdb37aae31ddc41a0f9782fa6.1594621435.git.baolin.wang@linux.alibaba.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <710eb90d9c1c125bdb37aae31ddc41a0f9782fa6.1594621435.git.baolin.wang@linux.alibaba.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200714_071749_680156_D33E693E 
X-CRM114-Status: UNSURE (   7.55  )
X-CRM114-Notice: Please train this message.
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: sagi@grimberg.me, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, axboe@fb.com, baolin.wang7@gmail.com,
 kbusch@kernel.org, hch@lst.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Mon, Jul 13, 2020 at 02:25:21PM +0800, Baolin Wang wrote:
> We've already validated the 'kato' in nvme_start_keep_alive(), thus no
> need to validate it again in nvme_start_ctrl(). Remove it.

Thanks,

applied to nvme-5.9.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
