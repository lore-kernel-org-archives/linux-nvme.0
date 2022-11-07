Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B179C4332F
	for <linux-nvme@archiver.kernel.org>; Mon,  7 Nov 2022 05:56:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=E5roDZn22aZvgZE9T8MXM2wr1DFwnon36DURBvJdObQ=; b=jFsbU6So2g8FlFgCD3l+RGLoMd
	YZGVdCejcnjjja2HadgF66uXDh3FEubzH3n0MvgNNxHBJiO3kN4iVQOQnDVilpEzu1ga/YJclW3DR
	zyZ7gue4IseriqUiR5kBnei1oqK5xpdhS8vKssejlBCT8xshP1RwnN/Y/XhpO+sUkmudU2Ca9PlkD
	L58P5QSMne1NYbVQOgoCxjsrl211Za1HJ4JzNUYgE8dhkhfrfyK8qH1x7G7uzQ+4MzWmX/QVl5KtC
	A9YA4wFcCDKdK+d+mY83a5M0+oJzNBMQMZiWJ+BtHb6n9GUmsctOBIh0iWUW3h64UW0C8/yaC9Ba6
	l1ZCpf/A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1orv7Q-00C4Yo-TI; Mon, 07 Nov 2022 05:56:24 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1orv7J-00C4XV-Cy
	for linux-nvme@lists.infradead.org; Mon, 07 Nov 2022 05:56:19 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 0B61868BFE; Mon,  7 Nov 2022 06:56:06 +0100 (CET)
Date: Mon, 7 Nov 2022 06:56:05 +0100
From: Christoph Hellwig <hch@lst.de>
To: Uday Shankar <ushankar@purestorage.com>
Cc: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	Jens Axboe <axboe@fb.com>
Subject: Re: [PATCH] nvme: scan sequentially only when list scan unsupported
Message-ID: <20221107055605.GF28873@lst.de>
References: <20221104223621.1435666-1-ushankar@purestorage.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221104223621.1435666-1-ushankar@purestorage.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221106_215617_621339_B7272906 
X-CRM114-Status: GOOD (  18.44  )
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

On Fri, Nov 04, 2022 at 04:36:22PM -0600, Uday Shankar wrote:
> Currently, if nvme_scan_ns_list fails, nvme_scan_work will fall back to
> a sequential scan. nvme_scan_ns_list can fail for a variety of reasons,
> e.g. transient transport issue. And the resulting sequential scan can be
> extremely expensive on controllers reporting an NN value close to the
> maximum allowed (>4 billion). Avoid sequential scans wherever possible
> by only falling back to them if nvme_scan_ns_list fails due to
> controller non-support of Identify NS List.
> ---
> This would break devices that claim to support version NVME_VS(1, 1, 0)
> or above, but don't support Identify NS List. But it looks like we
> already have NVME_QUIRK_IDENTIFY_CNS to deal with that.

Yes.  I'm a little worried about changing something this fundamental
after such a long time, even if it is the right thing to do.  But at
least we get a warning when the Identify NS List fails, so between
that and the fact tht nvme_scan_ns_list logs an error I think we can
cope.

>  	mutex_lock(&ctrl->scan_lock);
> -	if (nvme_scan_ns_list(ctrl) != 0)
> +	if (nvme_scan_ns_list(ctrl) == -EOPNOTSUPP)
>  		nvme_scan_ns_sequential(ctrl);

Maybe make this a bit more clear by lifting the nvme_ctrl_limited_cns
check into nvme_scan_work, though:

	if (nvme_ctrl_limited_cns(ctrl))
		nvme_scan_ns_sequential(ctrl);
	else
		nvme_scan_ns_list(ctrl);

and drop the now superflous error return from nvme_scan_ns_list.

