Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9F08C4332F
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Nov 2022 16:17:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=P3U+vS4QsIqzfiZV9cTvDH91MgM7yX82ttGOfkFlGNg=; b=SeVjaEhJ5cVy5/DzmNvR50h0hN
	YJDr/oSZ0pVaf/eUKPJrBhqfBpUBM2q0kqq0b9TkMwRjyRLAD59NdeDn+niAt4fMYlY2la3KMU2hQ
	6cJtdOrzgV39cRBJeeckTWt+Cx9Y5pX2wsSikCjR6boEZOFHnec0LOR39RWT1HJ2ySi5GaVshKL9X
	lYr2HgiBtbaCSyCy3ih1BuqXyNjNlCdgfHSZRyEEaD0PsZPxbAL8WFpI9y8Tl1e9GQtRtOZj362WP
	G6IDZ4xcKtfKftr0IbgScTnwVgfcTdELmESiNJBOb28zCVAVZ4EElNe7aCO7LyKU4uY5rbjxKkW3U
	YVxMVpmg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1otAEr-0075sC-QR; Thu, 10 Nov 2022 16:17:13 +0000
Received: from ams.source.kernel.org ([2604:1380:4601:e00::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1otAEo-0075qD-Tm
	for linux-nvme@lists.infradead.org; Thu, 10 Nov 2022 16:17:12 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id 8B35BB8224D;
	Thu, 10 Nov 2022 16:17:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEE6BC433D6;
	Thu, 10 Nov 2022 16:17:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1668097028;
	bh=jHQYljocGbuo3QvGC7wUKf70+7SlGf6UNjS7TdV08IU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NYR+c5A99xk7pQjhH8PwQhPzU+O5664GrRSuQuy9N1Fie9eVsvrz4gbmDSdSczk06
	 E9lMXpV2r3Twrrm5bK0DSyb0kVuaVlhK8LpsRbyO+KhuhJ2KVMZBdRbnXzmaei4Yuv
	 C7Nw6eO2C/fY4Q+MzQnzsR0ZO59G3hMfXgAeWFrLUJWKfkasc55+FxtChjseX98Dbr
	 eh0/5HgxGxkUDSH0A5+85MnXn6WnUUFdcV7fex9sji3V+x+CbYNU2kI+0KAvwgrDXd
	 1jBsHZo3v8WABdgAz1REfvxIvTm+30qiylKzq8MIsSIvciuXbrL+UZ9UI2nd2M9yEY
	 GFxjzXNGEtA1Q==
Date: Thu, 10 Nov 2022 09:17:05 -0700
From: Keith Busch <kbusch@kernel.org>
To: "linan (AK)" <linan122@huawei.com>
Cc: kbusch@fb.com, linux-nvme@lists.infradead.org, yi.zhang@huawei.com,
	chengzhihao1@huawei.com
Subject: Re: question about CVE-2022-3169
Message-ID: <Y20kAdltGKrusE5+@kbusch-mbp.dhcp.thefacebook.com>
References: <144969fe-3764-d5eb-587a-79c4fd195076@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <144969fe-3764-d5eb-587a-79c4fd195076@huawei.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221110_081711_129476_53A217FE 
X-CRM114-Status: GOOD (  20.60  )
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

On Thu, Nov 10, 2022 at 06:23:20PM +0800, linan (AK) wrote:
> Hi,
> 1e866afd4bcd("nvme: ensure subsystem reset is single threaded")
> fixed CVE-2022-3169.

The description in the CVE is nonsense. That patch won't "fix":

  "the NVME_IOCTL_SUBSYS_RESET through the device file of the driver,
   resulting in a PCIe link disconnect"

That's exactly what an nvme subsystem reset is supposed to do, as is
documented in the spec since the capability was introduced:

  "When an NVM Subsystem Reset occurs, all PCIe links in the NVM
   Subsystem transition to the LTSSM Detect state."

The patch just makes sure you can't stack different reset types along
with a unbinding event, so the test case in question will just become a
no-op for the subsystem reset part.

If anything, the CVE should have been that a non-admin user could have
triggered this, but a completely different patch fixed that.

> IIUC, ERROR path I got in this CVE:
>            CPU1                                CPU2
> nvme_dev_ioctl                            nvme_dev_ioctl
>   nvme_reset_ctrl_sync                      nvme_reset_subsystem
>       reset_work
>         nvme_reset_work
>           nvme_setup_io_queues
>             nvme_remap_bar(dev, size)
>               if (size <= dev->bar_mapped_size)
>                 return 0;
>               iounmap
>                                               reg_write32   //error
>               ioremap
> 
> In nvme_remap_bar(), the premise of ioremap is "size >
> dev->bar_mapped_size".
>   size = NVME_REG_DBS + ((nr_io_queues + 1) * 8 * dev->db_stride);
>     1)nr_io_queue = dev->nr_allocated_queues - 1, Onece set to
> "nvme_max_io_queues(dev) + 1" during probe time, it could not change.
>     2)db_stride is doorbell stride, it didn't change during my test
> Therefore, I cant find a way to make iounmap happen.
> 
> Could you tell me how you trigger the ERROR?

To get a panic, something needs to happen to cause the driver to unbind
from the device at the same time as sending a subsystem reset. I'm not
sure how the original bz reporter managed to make that happen, but it
didn't matter to me since we're supposed to handle these concurrent
events. I'm guessing a previous subsystem reset triggered link-down
unbinding, which unmapped the BAR at the same time another thread wanted
to send a follow on subsystem reset.

