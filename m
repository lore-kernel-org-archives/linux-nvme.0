Return-Path: <SRS0=/X2o=ZE=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F12CC43331
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Nov 2019 21:52:55 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE6E721925
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Nov 2019 21:52:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="tTsBSCw4";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="f/LYteq4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE6E721925
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=76s5c1Aijs3IW3ZOK9guu5UsYJBSqGqWQ/BJ0GY5YIc=; b=tTsBSCw42J0vSz
	Le5rvEVT+PRhQE0oXeAKcfZJSwFZolTDV1tuQTiRggIHv3rFMnsn6mQRoD7UZV9oKNvkIkhkvUEj4
	mD0wnDeR/QB8DOrhCZTNQ8Iulq9fqPBCRtVIV59d7i3EDWwnP+jlYehnBvxv3hRBg0K+lUXjluctL
	DN+lsYJ7gEUaj4jyahcaUikicowszZHKnMLmwx7ClYrV3z2VZDm4LxaZUCfVGxJwTBPOHAAaWwqG1
	YU81Bca8eIlMraZ/jErAKULGSZSgokKRXJx82fXWlDpDA6CSPbQGdezpgInSv+EttY/i067SAKxQR
	aEZ6qWpuxJ4H2gk7rpDQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iUe5j-0005fa-PZ; Tue, 12 Nov 2019 21:52:51 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iUe4S-0004WQ-Ix
 for linux-nvme@lists.infradead.org; Tue, 12 Nov 2019 21:51:34 +0000
Received: from redsun51.ssa.fujisawa.hgst.com (unknown [199.255.47.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 07D9220818;
 Tue, 12 Nov 2019 21:51:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1573595491;
 bh=4DSWgtb4tmNu8Jk/HoIdyqOEAaVitwmkwhdnvMohPu8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=f/LYteq4nLXfp53QEY9eFXflnInpDZgMX+4wKY3zKxrQCAgVdYMlZTd/NiFIWH+gB
 bBo3mvOmuUOfNFGy/BmVLdrnM2JgmCIXHwsK0H8gevtx2fbvi4+NOv98RpCD0LQEyR
 nBkBPmp3xwDV4mqOh+YNS+F2+88iyfTeFyOX7k+0=
Date: Wed, 13 Nov 2019 06:51:28 +0900
From: Keith Busch <kbusch@kernel.org>
To: Eduard Hasenleithner <eduard@hasenleithner.at>
Subject: Re: [PATCHv4] Workaround for discard on non-conformant nvme devices
Message-ID: <20191112215128.GB1964@redsun51.ssa.fujisawa.hgst.com>
References: <0f86cf43-f9c5-2b03-e9f2-e769abdfd35b@hasenleithner.at>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <0f86cf43-f9c5-2b03-e9f2-e769abdfd35b@hasenleithner.at>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191112_135132_693749_D9A9D02D 
X-CRM114-Status: GOOD (  20.20  )
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
Cc: linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, Nov 12, 2019 at 09:55:01PM +0100, Eduard Hasenleithner wrote:
> As documented in https://bugzilla.kernel.org/show_bug.cgi?id=202665 there are lots of Linux nvme users which get IO-MMU related errors when performing discard on nvme. So far analysis suggests that the errors are caused by non-conformant nvme devices which are reading beyond the end of the buffer containing the segments to be discarded.
> 
> Until now two different variants of this behavior have been observed: SM22XX controllers round up the read size to a multiple of 512 bytes. Phison (E12) are found to unconditionally read the maximum amount of discard segment data allowed by the spec (256 segments or 4kB). In case the start address of the buffer is not aligned (512B or 4kB) and the actual data fits in the remainder of the buffer page it may cause the controller to read a page which is not mapped on IO-MMU.
> 
> The patch changes the nvme_setup_discard function to unconditionally allocate memory for a segment array of maximum size (256 segments). This prevents the nvme from reading beyond the end of the IO-MMU mapped buffer.
> 
> Signed-off-by: Eduard Hasenleithner <eduard@hasenleithner.at>

Just a few style comments on kernel guidelines. I won't ask you to
resubmit a patch since I steered you in the wrong direction earlier, so
I modified these points inline with the commit. Please take a look here:

  http://git.infradead.org/nvme.git/commitdiff/530436c45ef2e446c12538a400e465929a0b3ade?hp=400b6a7b13a3fd71cff087139ce45dd1e5fff444

First, changelogs need to be word wrapped at 72 characters and use
imperative tone:

  https://www.kernel.org/doc/html/v5.3/process/submitting-patches.html
 
> --- linux-5.3.7/drivers/nvme/host/core.c.orig	2019-11-12 20:42:16.394800789 +0100
> +++ linux-5.3.7/drivers/nvme/host/core.c	2019-11-12 21:23:07.635266361 +0100
> @@ -555,15 +555,22 @@ static inline void nvme_setup_flush(stru
>  	cmnd->common.nsid = cpu_to_le32(ns->head->ns_id);
>  }
>  
> +#define DSM_SEGMENTS_MAX 256

We actually already have a #define NVME_DSM_MAX_RANGES

>  static blk_status_t nvme_setup_discard(struct nvme_ns *ns, struct request *req,
>  		struct nvme_command *cmnd)
>  {
>  	unsigned short segments = blk_rq_nr_discard_segments(req), n = 0;
>  	struct nvme_dsm_range *range;
>  	struct bio *bio;
> +	/* Some devices do not consider the DSM 'Number of Ranges'
> +	 * field when determining how much data to DMA. Always allocate
> +	 * memory for maximum number of segments to prevent device
> +	 * reading beyond end of buffer. */

Multline comments style look like this:

  /*
   * This is a multiline comment according to the kernel documentation
   * at https://www.kernel.org/doc/html/v5.3/process/coding-style.html
   */

> +	static const size_t alloc_size = sizeof *range * DSM_SEGMENTS_MAX;

The 'sizeof' always uses the () in linux kernel coding style.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
