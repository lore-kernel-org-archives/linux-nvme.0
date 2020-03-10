Return-Path: <SRS0=yUYt=43=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 014FAC10F27
	for <linux-nvme@archiver.kernel.org>; Tue, 10 Mar 2020 17:53:34 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C2ED521927
	for <linux-nvme@archiver.kernel.org>; Tue, 10 Mar 2020 17:53:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ACysytUb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2ED521927
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=bt/36jBDBIJW1BbcfqKDaKEjWdifY1VUw+VECG6fY0Q=; b=ACysytUbn40qPu
	4o7BC1L84zvJljDWsiIpHrwaLwjImyLt7JfIfpgl+W9y66G1aKujOXGfi4hxf5NYzrnD4246eBWf4
	6ec1JCgYG7HEe6Jh1CntqmNTPa+WNeYiQhoCqkeV804wGX1HylaAMVSomjw5LPWUXvcuxZfPRzeDk
	oCKAc4yK4F6AR4nMXSLOAF/Q7nebeuwWNZM78F3iCmaTeSQVNE1n1nCt8PF4AxfG/HPPcHhZguMV4
	H5V5s0fBGExCyO3l7DyvIoziVTrR2QlH6DiX9ti+54bXcBJLf8WP0DvlfHOqHxwNvBEEhrxvLCGJ5
	ILG7387qTF4C2Orn0a2g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jBj4N-0002bN-Ra; Tue, 10 Mar 2020 17:53:31 +0000
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red
 Hat Linux)) id 1jBj4K-0002b3-Qh; Tue, 10 Mar 2020 17:53:28 +0000
Date: Tue, 10 Mar 2020 10:53:28 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Prabhath Sajeepa <psajeepa@purestorage.com>
Subject: Re: [PATCH] nvme-rdma: Avoid double freeing of async event data
Message-ID: <20200310175328.GA9203@infradead.org>
References: <1583788073-39681-1-git-send-email-psajeepa@purestorage.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1583788073-39681-1-git-send-email-psajeepa@purestorage.com>
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
Cc: roland@purestorage.com, sagi@grimberg.me, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, axboe@fb.com, kbusch@kernel.org, hch@lst.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Mon, Mar 09, 2020 at 03:07:53PM -0600, Prabhath Sajeepa wrote:
> The timeout of identify cmd, which is invoked as part of admin queue
> creation, can result in freeing of async event data both in
> nvme_rdma_timeout handler and error handling path of
> nvme_rdma_configure_admin queue thus causing NULL pointer reference.
> Call Trace:
>  ? nvme_rdma_setup_ctrl+0x223/0x800 [nvme_rdma]
>  nvme_rdma_create_ctrl+0x2ba/0x3f7 [nvme_rdma]
>  nvmf_dev_write+0xa54/0xcc6 [nvme_fabrics]
>  __vfs_write+0x1b/0x40
>  vfs_write+0xb2/0x1b0
>  ksys_write+0x61/0xd0
>  __x64_sys_write+0x1a/0x20
>  do_syscall_64+0x60/0x1e0
>  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> 
> Signed-off-by: Prabhath Sajeepa <psajeepa@purestorage.com>
> Reviewed-by: Roland Dreier <roland@purestorage.com>

This looks good as a hot fix:

Reviewed-by: Christoph Hellwig <hch@lst.de>

But I really think we need to do something about init vs timeout
in the state machine.  Otherwise we're going to deal with racing
resource deallocation forever.

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
