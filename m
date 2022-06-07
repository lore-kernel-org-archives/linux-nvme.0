Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1202C433EF
	for <linux-nvme@archiver.kernel.org>; Tue,  7 Jun 2022 10:35:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5gpHnA+VeDcYgCrr0HJi0+P41I9QGa1CX7Am+jylfFE=; b=zdqJXuH6HtAyU7np6whaXv3LBT
	gRuAcFVKMo29Fl7Pq8sVfD1waieDg30y64wkBV132V7aLdE/gvAwAPNx3B+0FwY4NJDsd9Ik2yVN5
	cjYgr2nhB0awIcJS9YzABI7lB5R4wNEdcPtnuFbK7geb2Sjowhuf+yFvl2tootLugAatd0ZQg1Bn3
	n2Cjpy/TiEu/vCkygE6db9xnwjYK1l3LgBKuWL+5GWNM8mPTc6IOqXvpK97TQP3fCk+JhlMJXj9iL
	fTNA1BfFbARY0/9blTobaGDOlnti/4djG8n+6Sa58jAZZI9TRHPjl03WDzRozLHODkIbF10BRmoC6
	UxuZ3PJg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nyWYv-006hgQ-Bt; Tue, 07 Jun 2022 10:35:49 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nyWYp-006hdl-Gz
	for linux-nvme@lists.infradead.org; Tue, 07 Jun 2022 10:35:44 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 3541567373; Tue,  7 Jun 2022 12:35:39 +0200 (CEST)
Date: Tue, 7 Jun 2022 12:35:38 +0200
From: Christoph Hellwig <hch@lst.de>
To: Michael Kelley <mikelley@microsoft.com>
Cc: kbusch@kernel.org, axboe@fb.com, hch@lst.de, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	caroline.subramoney@microsoft.com, riwurd@microsoft.com,
	nathan.obr@microsoft.com
Subject: Re: [PATCH v3 2/2] nvme: handle persistent internal error AER from
 NVMe controller
Message-ID: <20220607103538.GA25071@lst.de>
References: <1654560915-22449-1-git-send-email-mikelley@microsoft.com> <1654560915-22449-2-git-send-email-mikelley@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1654560915-22449-2-git-send-email-mikelley@microsoft.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220607_033543_739941_DF3A6A2C 
X-CRM114-Status: GOOD (  17.93  )
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

On Mon, Jun 06, 2022 at 05:15:15PM -0700, Michael Kelley wrote:
> +static void nvme_handle_aer_persistent_error(struct nvme_ctrl *ctrl)
> +{
> +	trace_nvme_async_event(ctrl, NVME_AER_ERROR);
> +
> +	/*
> +	 * We can't read the CSTS here because we're in an atomic context on
> +	 * some transports and the read may require submitting a request to the
> +	 * to the controller and getting a response. Such a sequence isn't
> +	 * likely to be successful anyway if the controller is reporting a
> +	 * persistent internal error. So assume CSTS.CFS is set.
> +	 */
> +	if (nvme_should_reset(ctrl, NVME_CSTS_CFS)) {
> +		dev_warn(ctrl->device, "resetting controller due to AER\n");
> +		nvme_reset_ctrl(ctrl);

I don't think we even need the nvme_should_reset check now.

nvme_reset_ctrl first calls nvme_change_ctrl_state, which only allows
the transition to the RESETTING state if it previously was NEW or LIVE,
so we are already covered.  The only downside would be an extra kernel
message if we already were in another state.

