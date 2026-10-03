Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EFAACA5FDD
	for <linux-nvme@archiver.kernel.org>; Sat,  3 Oct 2026 11:55:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TANupNPWri8xwQs5Q+uaxNBtEA6grayuDJGaesA0B3Q=; b=i8Jy8ILXRzQA8v/6FxdfNqIE+7
	Dt7bGjqZZWvismSChcs3RKFR2+Ij8X6ayFL0cdAvB4SFX3+ByTgR/cAWhEJQqSheYu6HxGpaJXaWD
	4EA+HTqpxobeRBphywZu7JGmhkPVWKJMqRHnQGBtrB1RBAdXCl0ICvTrt05KyEF0k/tRwW7J4jf5R
	51vcUQkfdZ7uBw1e1XA43Eik0NPRUM/NpLk6wBm+FSO8sD07g1RxLCsaur6Kqr3+3553Vbjos0k0Q
	8twNPMj6SKB+EXloZ9DFt9pJJuHbUSM1aX6X+1LB9d6WCK/qv+R5HHlZpzj3UKqcsU0LKBv98SvuQ
	EAJLRlrg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xCyKj-0000000DRla-0Sxo;
	Sat, 03 Oct 2026 11:55:17 +0000
Received: from mail.cyberchaos.dev ([195.39.247.168])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xCyKb-0000000DRkZ-2V1D
	for linux-nvme@lists.infradead.org;
	Sat, 03 Oct 2026 11:55:11 +0000
Message-ID: <94912d46-381d-4988-800a-6ef3b595233f@cyberchaos.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyberchaos.dev;
	s=mail; t=1791028505;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TANupNPWri8xwQs5Q+uaxNBtEA6grayuDJGaesA0B3Q=;
	b=Y2td9nO9LpScuzyhMiGCjYwcds81El2zfh+nKQTxtGzQqQxRMk3T8UelFMlprC8rTZoXJi
	V5S5WDxgm/YNmf7j7b25TPuB1bdxirYUS5Yk3NCdD0v2IDq2euCcLqLBTHd20UuiWYuqVr
	mZ+jdXoN4/6W+d9Z6ayQt1h6Vx/B0Zc=
Date: Sat, 3 Oct 2026 13:55:01 +0200
MIME-Version: 1.0
Subject: Re: [PATCH] nvme: do not reset controllers in NVME_CTRL_NEW state
To: Maurizio Lombardi <mlombard@redhat.com>, kbusch@kernel.org
Cc: linux-nvme@lists.infradead.org, mlombard@arkamax.eu, hch@lst.de,
 hare@suse.de, dwagner@suse.de, asahi@lists.linux.dev,
 Sven Peter <sven@kernel.org>
References: <20260915095827.698928-1-mlombard@redhat.com>
Content-Language: en-US
From: Yureka Lilian <yureka@cyberchaos.dev>
In-Reply-To: <20260915095827.698928-1-mlombard@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261003_045509_894619_CAC0AD10 
X-CRM114-Status: GOOD (  21.54  )
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

On 9/15/26 11:58, Maurizio Lombardi wrote:
> During NVMe controller creation, the controller is exposed to sysfs via
> nvme_add_ctrl() while it is still in the NVME_CTRL_NEW state.
> This creates a narrow race window where a userspace process can write to
> the reset_controller sysfs node before the initialization thread
> transitions the state to NVME_CTRL_CONNECTING.
>
> If a reset is triggered during this window, the state machine allows the
> transition from NVME_CTRL_NEW to NVME_CTRL_RESETTING, and the reset work
> is queued. However, the original creation thread continues its execution,
> subsequently moving the state to NVME_CTRL_CONNECTING and finally to
> NVME_CTRL_LIVE.
>
> When the delayed reset work finally executes, it attempts to tear down
> the controller and transition the state to NVME_CTRL_CONNECTING. Because
> the state is now NVME_CTRL_LIVE, this transition fails, triggering a
> WARN_ON in the reset work.
>
> Fix this by removing NVME_CTRL_NEW from the allowed prior states for
> the NVME_CTRL_RESETTING transition.
>
> Fixes: 8bfc3b4c6f9d ("nvmet: switch loopback target state to connecting when resetting")
> Reported-by: syzbot+4a1d521d19d6321f5aad@syzkaller.appspotmail.com
> Signed-off-by: Maurizio Lombardi <mlombard@redhat.com>
> ---
>   drivers/nvme/host/core.c | 1 -
>   1 file changed, 1 deletion(-)
>
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index beea23d04a70..7ea8dd27d08d 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -598,7 +598,6 @@ bool nvme_change_ctrl_state(struct nvme_ctrl *ctrl,
>   		break;
>   	case NVME_CTRL_RESETTING:
>   		switch (old_state) {
> -		case NVME_CTRL_NEW:
>   		case NVME_CTRL_LIVE:
>   			changed = true;
>   			atomic_long_inc(&ctrl->nr_reset);

Hi!

I was testing something with linux-next 2026-10-02 and ran into an issue 
with the
nvme-apple driver where /dev/nvme0 exists but none of the namespaces appear,
and the dmesg is awfully quiet about the nvme device. I bisected it down to
this patch, which as far as I can tell leads to the nvme-apple being 
stuck in
NVME_CTRL_NEW state. Without being familiar with the matter, this looks like
the nvme-apple driver was using this transition as part of its 
initialization
procedure.  If one of the NVMe people who know how these transitions are
supposed to work could have a look, that would be much appreciated, as
otherwise this will break nvme-apple in 7.3-rc6.

Thanks,

- Yureka


