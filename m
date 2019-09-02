Return-Path: <SRS0=YEyo=W5=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51C55C3A59B
	for <linux-nvme@archiver.kernel.org>; Mon,  2 Sep 2019 08:25:54 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 233D021874
	for <linux-nvme@archiver.kernel.org>; Mon,  2 Sep 2019 08:25:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="EnJl84bz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 233D021874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=XjUy7OX+ABEKrKg44UlHr6JqqBZMutxuOQVN2vT3jSM=; b=EnJl84bzip5fzI
	lU03VL0lPLs+tK1YtXz2Em2q4dhadYHiN8+NCosKFMbddLp38s9WMJyLHG5m/8+FSbX7zaF8ixRIH
	vfDaom210P+2gADt0GazJaAE3NpBUXQ9dMgc4wV8FnOmVZc9XxYpp8qtcImjnSfw8m1FpuguFKaMx
	x/WP1dZCA3W74wrJnqKffgBMJGnMANbLzos7vixXCyX/+GT9HiTSsZ+0XJRN+960MmpMDUybOIUA9
	7pFpQKF2RAdoAytsjLM0+lwE/C5KcyEGSp3kRrsk34i1OnYpElqmY6H5mknN0LmRWPuq8p6NxoYH+
	swpdzA+UCs20wxUDoKZg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92 #3 (Red Hat Linux))
	id 1i4heq-00080V-4e; Mon, 02 Sep 2019 08:25:52 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1i4hen-0007zf-Hp
 for linux-nvme@lists.infradead.org; Mon, 02 Sep 2019 08:25:50 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id CB9F8227A8A; Mon,  2 Sep 2019 10:25:46 +0200 (CEST)
Date: Mon, 2 Sep 2019 10:25:46 +0200
From: Christoph Hellwig <hch@lst.de>
To: Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH v10 5/7] nvme: make nvme_identify_ns propagate errors back
Message-ID: <20190902082546.GB29846@lst.de>
References: <20190830191914.29713-1-sagi@grimberg.me>
 <20190830191914.29713-6-sagi@grimberg.me>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190830191914.29713-6-sagi@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190902_012549_740250_904A730F 
X-CRM114-Status: GOOD (  10.74  )
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
Cc: Keith Busch <keith.busch@intel.com>, James Smart <james.smart@broadcom.com>,
 Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
 Hannes Reinecke <hare@suse.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Fri, Aug 30, 2019 at 12:19:12PM -0700, Sagi Grimberg wrote:
> right now callers of nvme_identify_ns only know that it failed,
> but don't know why. Make nvme_identify_ns propagate the error back.
> Because nvme_submit_sync_cmd may return a positive status code, we
> make nvme_identify_ns receive the id by reference and return that
> status up the call chain, but make sure not to leak positive nvme
> status codes to the upper layers.
> 
> Reviewed-by: Minwoo Im <minwoo.im.dev@gmail.com>
> Reviewed-by: Hannes Reinecke <hare@suse.com>
> Reviewed-by: James Smart <james.smart@broadcom.com>
> Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
