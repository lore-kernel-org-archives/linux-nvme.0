Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22D56C25B79
	for <linux-nvme@archiver.kernel.org>; Wed, 22 May 2024 15:56:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5kdeKz62VCjZ2czxLUEdB36cemCi8WznUWnGc3QwAdM=; b=fu+bm/kYQ7IjCLzTl86sd2KnyG
	uAnnglFjz7zpsnUhTqyXWmk0nTgYXmOhx9bdNQ4y83dGovpnQ4yTR1sTpzmSqFJ3NgwBjhpKLk2OM
	i7YSzKcHGofs2VBm1mhWt+ZZy/CYD2F1wRAdWkkt16YGiGmkvgxk5XkzZFLBd8comfngIu1C+zoGo
	aveSkYNeRLE17r2WAQBOXJvfZUAMP8eKhcVDuNDkcZmAx4Q4reUL97qxy1M++ovwTWDUZTqgt4dQV
	JE5rsnP457FGskaliQ3d2v5LyHTSgAZPacldFoXSJh7fUrm5MRdKaBmXUOV/81Z53UfmqlaHyxXMc
	hFdz8k4g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s9oKb-00000003SNg-2woC;
	Wed, 22 May 2024 15:56:45 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s9oKY-00000003SLx-2JtU
	for linux-nvme@lists.infradead.org;
	Wed, 22 May 2024 15:56:44 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id B642762A2A;
	Wed, 22 May 2024 15:56:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4D94C2BD11;
	Wed, 22 May 2024 15:56:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716393401;
	bh=v8cAZZ8J7bzfnYp5o6idecynXR7i2En6YomK8I+ZL6k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pLD0jpc6QQLiSCCbEJeS+c7bGv0AsYyKFZKKbtw7cQcYIknJL1fcWPR1nAQOaha9z
	 oj90/comP+41/pQqz2/wj5CvnrFTF5uQC0UNTxkUZAqgW0q1cR8Z3MY+IsA9aLbbmZ
	 cvUOEP/gBVlbuVuPlIQR4qqx0iTloDgBs79fnz/MdQ/bHuc85GvC8LeRWH+uzqIQzo
	 dhJStFVW+HggCYESP7xGiH2i+5p1grYKCuMq8W7YuzuWiyzt8FfJV6s2KRNJJW6btu
	 ddOK2mZSKdYQi2qF79qYmKlBuSMycmJo7poUF62W6nXV9XOVNp/jO5K7RkEgUEehL6
	 6CPfgG9iDIigg==
Date: Wed, 22 May 2024 09:56:38 -0600
From: Keith Busch <kbusch@kernel.org>
To: John Meneghini <jmeneghi@redhat.com>
Cc: hch@lst.de, sagi@grimberg.me, emilne@redhat.com,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	jrani@purestorage.com, randyj@purestorage.com, hare@kernel.org
Subject: Re: [PATCH v4 1/1] nvme: multipath: Implemented new iopolicy
 "queue-depth"
Message-ID: <Zk4VtiCjeqkBKCBA@kbusch-mbp.dhcp.thefacebook.com>
References: <20240522154212.643572-1-jmeneghi@redhat.com>
 <20240522154212.643572-2-jmeneghi@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240522154212.643572-2-jmeneghi@redhat.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240522_085642_732140_7E67435A 
X-CRM114-Status: GOOD (  12.22  )
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

On Wed, May 22, 2024 at 11:42:12AM -0400, John Meneghini wrote:
> +static void nvme_subsys_iopolicy_update(struct nvme_subsystem *subsys, int iopolicy)
> +{
> +	struct nvme_ctrl *ctrl;
> +	int old_iopolicy = READ_ONCE(subsys->iopolicy);
> +
> +	WRITE_ONCE(subsys->iopolicy, iopolicy);
> +
> +	/* iopolicy changes reset the counters and clear the mpath by design */
> +	mutex_lock(&nvme_subsystems_lock);
> +	list_for_each_entry(ctrl, &subsys->ctrls, subsys_entry) {
> +		atomic_set(&ctrl->nr_active, 0);

Can you me understand why this is a desirable feature? Unless you
quiesce everything at some point, you'll always have more unaccounted
requests on whichever path has higher latency. That sounds like it
defeats the goals of this io policy.

> @@ -1061,6 +1066,9 @@ static inline bool nvme_disk_is_ns_head(struct gendisk *disk)
>  {
>  	return false;
>  }
> +static inline void nvme_subsys_iopolicy_update(struct nvme_subsystem *subsys, int iopolicy)
> +{
> +}
>  #endif /* CONFIG_NVME_MULTIPATH */

You can remove this stub function since the only caller resides in a
CONFIG_NVME_MULTIPATH file.

