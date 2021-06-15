Return-Path: <SRS0=Oc5T=LJ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CFABC48BE5
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Jun 2021 22:41:04 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2966361246
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Jun 2021 22:41:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2966361246
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=nTp7X86WlGTIX1OVbaRd1zjtNZZYHfpUrW+VgRwAo4Y=; b=rzSVlw96t9im2f
	e2+SiNjZTJ3Rs2ieuPUHGgDvKOEUCjGATn+J1EDkI84ms6vxUG7gq4h4ZVq+MFzQl7R5W6PIDsH1C
	LwWmn/umBNBRfq7lNVX3TkDETss5m7A9T39XhqsB9X0zPNe61ANi5F1gA6kZ+FFd7iYcEWTel8WyG
	+C9GNy6Wmp7GxwG8DpYXnFngr4BA+wKnc6tUlUwRMwwcve1cQ9xsi6xxhjs6Yw/6+3wXH47QlRgfO
	6EraKn8CAJLD6HEhC/jkc0Sjx6lEcwwRG71Kf8XhpFUaUnkHSYFld21lOfmHD8vbUMRzFvjb5ABh6
	44bHdHy9T3Kux6RoWJ+Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ltHjm-003dxv-2t; Tue, 15 Jun 2021 22:40:50 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ltG3l-002ver-Ge
 for linux-nvme@lists.infradead.org; Tue, 15 Jun 2021 20:53:22 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id B7A9F61350;
 Tue, 15 Jun 2021 20:53:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1623790401;
 bh=+hOLFdcpau3+2H8yb+r55MzHUqXSL+nBdVOcLZBMAxQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=jZ0cATCycQbjI0i1dw18qTX9cx8L3KKSVWF5rSR/YJ/jIma1jrPPW3ahDgB0Y+k4I
 4gyJpolZMvPwmCe3+EgY+MExv4uldBukcA4HAtQHROiGxVTRvt77YtVbIzkBCzTRGz
 kqcyKND9CVzNd83GtllBVOC0wfd4IAXcJEeNWIqvyqLVI+TNr+NjrzvHAuOrkjN2UF
 ch8qUECU+jJ1cYL1hxtoncdRS+A5IGrd6J2tJaiyKuQQowluBoDGOleqYL5P+F2/5Y
 qvKAQ0EXLPapJNi+3IjCmJDpw+1G/d+IIpFe3fdCvzb4q692bpylRPKHcoMfe/g+A5
 9Ov0/UJS4jMxQ==
Date: Tue, 15 Jun 2021 13:53:18 -0700
From: Keith Busch <kbusch@kernel.org>
To: Casey Chen <cachen@purestorage.com>
Cc: linux-nvme@lists.infradead.org, Yuanyuan Zhong <yzhong@purestorage.com>,
 Ashish Karkare <ashishk@purestorage.com>
Subject: Re: nvme-pci: Fix multiple races in nvme_setup_io_queues()
Message-ID: <20210615205318.GD646237@dhcp-10-100-145-180.wdc.com>
References: <CALCePG2ukbm=mjZiKij5_3T4sTc4H5wRuityrr2Ljv0HvfJqtQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CALCePG2ukbm=mjZiKij5_3T4sTc4H5wRuityrr2Ljv0HvfJqtQ@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210615_135321_611003_3FB36F80 
X-CRM114-Status: GOOD (  16.19  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Mon, Jun 14, 2021 at 11:26:55PM -0700, Casey Chen wrote:
> (Please ignore the previous email, the call paths comparison shown in
> commit message should look better if you copy then paste in a code
> editor)

Your email client also mangles your patch, rendering it unable to apply.
If you're able to set up 'git send-email' from your development machine,
that will always format correctly for mailing list patch consumption.

I am aware of the race condition you've described. I never bothered with
it because of the unsual circumstances to hit it, but since you have
identified a test case, I agree it's time we address it.

> ---
>  drivers/nvme/host/pci.c | 33 +++++++++++++++++++++++++++------
>  1 file changed, 27 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 3aa7245a505f..81e53aaaa77c 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -1590,8 +1590,9 @@ static int nvme_create_queue(struct nvme_queue
> *nvmeq, int qid, bool polled)
>   goto release_cq;
> 
>   nvmeq->cq_vector = vector;
> - nvme_init_queue(nvmeq, qid);
> 
> + mutex_lock(&dev->shutdown_lock);

There doesn't seem to be a reason to wait for the lock here. A
mutex_try_lock() should be fine, and simply abandon queue initialization
if we locking fails.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
