Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDDCDCD37B5
	for <linux-nvme@archiver.kernel.org>; Mon, 11 May 2026 08:07:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PhuoCovHwRqravBVZA/TF9jBwzVO1ys+iZf38Rg+8EI=; b=O9xzwNtQt2Yn32gLjjAEAtipqX
	Hve93b9l6putFc71Vcw7rI66Hd4TO4manoYXF44SqZdPZf3mGwYlzljFQKEqw+IN+y/gOtJ1mSs3o
	eamprQw0+8bL+vuXE7PbAjc3410MVHmaUZB05IP4IvLDC0tQ3I9mgID8bkQWBqkLCy8kGLASlkeN2
	WfPginCgBoaCSE1uLb3xtiHY/kWayf4iAS9jvAsy97IBTBKvRAOFLzieICdcdwBqsz23oobVCXkq+
	sNrNPShafFiEhbbgiD+szQLzCirkASxKU/VXPrC/hQO0HjF/ezM8UWISlzUuVBLn7ZNhzwWLVmoMb
	IBYCX17w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMLfk-0000000ChjJ-2cea;
	Mon, 11 May 2026 08:07:28 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMLfi-0000000ChiL-3EPO
	for linux-nvme@lists.infradead.org;
	Mon, 11 May 2026 08:07:28 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 0C2DF68BEB; Mon, 11 May 2026 10:07:22 +0200 (CEST)
Date: Mon, 11 May 2026 10:07:21 +0200
From: Christoph Hellwig <hch@lst.de>
To: Maurizio Lombardi <mlombard@redhat.com>
Cc: kbusch@kernel.org, mheyne@amazon.de, emilne@redhat.com,
	jmeneghi@redhat.com, linux-nvme@lists.infradead.org,
	dwagner@suse.de, mlombard@arkamax.eu, mkhalfella@purestorage.com,
	chaitanyak@nvidia.com, hare@kernel.org, hch@lst.de
Subject: Re: [PATCH V4 2/9] nvme: add sysfs attribute to change admin
 timeout per nvme controller
Message-ID: <20260511080721.GB29677@lst.de>
References: <20260508133335.98612-1-mlombard@redhat.com> <20260508133335.98612-3-mlombard@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260508133335.98612-3-mlombard@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260511_010726_972777_F04265DF 
X-CRM114-Status: GOOD (  16.99  )
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

On Fri, May 08, 2026 at 03:33:28PM +0200, Maurizio Lombardi wrote:
> Currently, there is no method to adjust the timeout values
> on a per controller basis with nvme admin queues.
> Add an admin_timeout attribute to nvme so that different
> nvme controllers which may have different timeout
> requirements can have custom admin timeouts set.

Please use up all 73 characters for commit messages.

>  
> +static ssize_t nvme_admin_timeout_show(struct device *dev,
> +			struct device_attribute *attr, char *buf)

The indent for prototype continuations should use two, not three tabs.

> +	 * Wait until the controller reaches the LIVE state
> +	 * to be sure that admin_q and fabrics_q are
> +	 * properly initialized.

Please use up all 80 characters for comments.

> +	 */
> +	if (!test_bit(NVME_CTRL_STARTED_ONCE, &ctrl->flags))
> +		return -EBUSY;
> +
> +	err = kstrtou32(buf, 10, &timeout);
> +	if (err || !timeout)
> +		return -EINVAL;
> +
> +	ctrl->admin_timeout = msecs_to_jiffies(timeout);
> +
> +	blk_queue_rq_timeout(ctrl->admin_q, ctrl->admin_timeout);
> +	if (ctrl->fabrics_q)
> +		blk_queue_rq_timeout(ctrl->fabrics_q, ctrl->admin_timeout);

Do we really want to apply the the admin timeout for the fabrics queue?
If so can you document here why we do that?


