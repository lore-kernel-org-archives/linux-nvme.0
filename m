Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43ACEC3600C
	for <linux-nvme@archiver.kernel.org>; Mon, 31 Mar 2025 15:30:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=R4Y5c2ieoau2C/1jQntOziuMiF9n562jm75stn/gHag=; b=jxopI3rpuZPwN4jmhPr0km3g46
	n46AqU1dE4LcJurVykBQc8djVx2iOl0OC8DQYDRH7FXogc/lvlZxHb8mYfAkj3VhiwTLgpxzGCsbg
	kPy3QJ/N8P3vQ7LiR5h+6IZlBAHZ9LwnDhdZVtb0/0+LGrl5tGbbpGUvt5pCzaclZFBz/tANNCUuN
	Nk8crc9jEKW7T1Zq5klPS1OyMN2jxXC+zT2vpK5+B8rdU9iWm93ganBZ66Ar5rL4CO+TyxMmb6JzW
	/KDUV+NHxhtW8haTsYK30rRAZSoLMTjAmKFL0PmelmQUrLHD/n558D/Nh2LnaPMbD+cz6XtN4oHcR
	CYYQhNWQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.1 #2 (Red Hat Linux))
	id 1tzH69-00000000nnG-3n8D;
	Mon, 31 Mar 2025 15:30:49 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1tzGfT-00000000gla-1V5J
	for linux-nvme@lists.infradead.org;
	Mon, 31 Mar 2025 15:03:16 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id AF85CA42FD5;
	Mon, 31 Mar 2025 14:57:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6305C4CEE3;
	Mon, 31 Mar 2025 15:03:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743433394;
	bh=qbx82Y2/6IQ2gEQKBF1QXMQQkYu0QqCxMvkhutduH1c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rcYfRvYeVQO9zwe5S+WKsp/sYS4C92zi4cL5VbSbXMSPwg8QDBdlJpniRIPDhjbSt
	 7BDFnxUXXjHhvzQRgzRflIBG2n1oYMhmJtdvHHLqyYEIpGi1WCUu/H/QhNn+UDE8lF
	 7ehXX6r/p9BWMdGkc5uI19vF0R3do6Xqyxxc8Wuh7KEa8mR6lten05KBo7upyKifsu
	 iXweFZhXUHFQZQD41luMJ7Nz2oNEHTsA0CSrsGHrGYJ9txrFVwKQbGz+DtAnkbs0JT
	 RQ4iBqcmwTrWDebGGOBz1yF8dgsnRrg5v6dSi8BnzbylsVwVpIUkZ5CoA11a+hWJrN
	 Jh3P3RHzt7QyQ==
Date: Mon, 31 Mar 2025 09:03:11 -0600
From: Keith Busch <kbusch@kernel.org>
To: Kamaljit Singh <kamaljit.singh1@wdc.com>
Cc: axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	niklas.cassel@wdc.com, damien.lemoal@wdc.com
Subject: Re: [PATCH v1 1/1] nvme: add admin controller support. prohibit ioq
 creation for admin & disco ctrlrs
Message-ID: <Z-qur5YnK2ZtiRR3@kbusch-mbp.dhcp.thefacebook.com>
References: <20250328213640.798910-1-kamaljit.singh1@wdc.com>
 <20250328213640.798910-2-kamaljit.singh1@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250328213640.798910-2-kamaljit.singh1@wdc.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250331_080315_456291_743F1B71 
X-CRM114-Status: GOOD (  12.87  )
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

On Fri, Mar 28, 2025 at 02:36:40PM -0700, Kamaljit Singh wrote:
> -static inline bool nvme_discovery_ctrl(struct nvme_ctrl *ctrl)
> -{
> -	return ctrl->opts && ctrl->opts->discovery_nqn;
> -}
> -

I suppose it's fine to rename this function with an nvmf_ prefix, but
it's not really related to the rest of the patch and makes the diff
larger than necessary.

> +	/* An admin or discovery controller has one admin queue, but no I/O queues */
> +	if (nvme_admin_ctrl(&ctrl->ctrl) || nvmf_discovery_ctrl(&ctrl->ctrl)) {
> +		ctrl->ctrl.queue_count = 1;
> +	} else if (ctrl->ctrl.queue_count < 2) {
> +		/* I/O controller with no I/O queues is not allowed */
> +		ret = -EOPNOTSUPP;
> +		dev_err(ctrl->ctrl.device,
> +			"I/O controller doesn't allow zero I/O queues!\n");
> +		goto destroy_admin;
> +	}

The queue_count comes from the user. If the user provides a bad value
for an IO controller, you're erroring. If they provide a bad value for a
discovery or admin controller, you override the value. Why the different
behavior?

