Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5951AC433EF
	for <linux-nvme@archiver.kernel.org>; Mon, 11 Apr 2022 11:24:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OnRIZ5SMssAKlNadVql3OaM236DqCr03QXsnpE8VrrI=; b=OrBd60OV45yQGxh/8D+YwW2gQO
	H0sulftkNDKSujGE80OEDY1sNRCUCoPBUqb84aH2cNCeAgvtV9Q/vRo0bwZD6WIeGeJjOatcbL1uY
	Wmr9UIfszbUg7A3NsB4GUL3nvtqFyin1QjZeecFMvv0cZufZNRYmIY1h+TWLmfHwCPlHghcqC1md0
	KM8HVLxyfYLuo4JEQG9PUvAI8PxRXT3gGcqHL3oCX8RLqgb+hWXUVV6PGM7omwEKyK6Im7mTBAsbn
	1ijfCM97ik0N6Ms+i7zpjA7SGAk2mVvsm8y3URXQzySryNvXD+Dyk/w7u7by8TKx0Yom8HwGpCxse
	Jeq8PaMQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nds9B-008evB-S0; Mon, 11 Apr 2022 11:23:54 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nds7h-008e0b-Mg
 for linux-nvme@lists.infradead.org; Mon, 11 Apr 2022 11:22:23 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 525A71FCFD;
 Mon, 11 Apr 2022 11:22:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1649676138; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=OnRIZ5SMssAKlNadVql3OaM236DqCr03QXsnpE8VrrI=;
 b=Y4AG9xK0wwOawE/slu0CAxAtd6J3kcwJcf7gcdt5X561yHQuLZEL124jUYYv9Bf1gcAlci
 RBe+CmQx7L76gix2DmoF38CGKBFOkm8P6fYfIsd1EpZNb3Vo5s7xwT+UwgWaRKFybfEzDY
 uG7WtZgHlUwlAk8nDG6rmI21ItLFYUs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1649676138;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=OnRIZ5SMssAKlNadVql3OaM236DqCr03QXsnpE8VrrI=;
 b=EJ82iwtjlwdn83bSuJd54B0rOA3QG39ky3gaKZrZQ5UnTel7RMfS3x5rgBmXUQ62B9eKAl
 8hrlh2n44vxIEbBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4544813A93;
 Mon, 11 Apr 2022 11:22:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 3XLbEGoPVGL+dQAAMHmgww
 (envelope-from <dwagner@suse.de>); Mon, 11 Apr 2022 11:22:18 +0000
Date: Mon, 11 Apr 2022 13:22:17 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Anton Eidelman <anton@lightbitslabs.com>,
 linux-nvme@lists.infradead.org, Martin.Belanger@dell.com
Subject: Re: [PATCH] nvme-tcp: handle failing req immediately for
 REQ_FAILFAST_DRIVER
Message-ID: <20220411112217.vihnysakkzawmrvo@carbon.lan>
References: <20220407092540.66227-1-dwagner@suse.de>
 <eef5eda6-f00f-b879-858f-80f7ce44a362@grimberg.me>
 <20220407122054.reywmgnysnhryvg2@carbon.lan>
 <129b9f99-fd4d-1920-dee8-652e774a3b57@grimberg.me>
 <20220407133806.xawe6y5v5uec4vzi@carbon.lan>
 <48363e60-d506-b1bf-cb3a-db781290f285@grimberg.me>
 <20220407135353.uupdcx2jbk37qtpx@carbon.lan>
 <20220407150155.sryxcqrv25wt3irp@carbon.lan>
 <adb47490-e13a-1c18-c6fb-23a233471796@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <adb47490-e13a-1c18-c6fb-23a233471796@grimberg.me>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220411_042221_920187_31A3A57B 
X-CRM114-Status: GOOD (  26.27  )
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

On Mon, Apr 11, 2022 at 12:58:09PM +0300, Sagi Grimberg wrote:
> > > I see there is a shutdown_timeout which is 5 seconds on default. Seems
> > > not to trigger though.
> > 
> > Obviously, the shutdown_timeout is not connected to the register
> > writes. So we would need something like:
> 
> Looking at this, its probably not what we want...

I agree. We just have to make sure that we fail these register
read/writes on transport layer and don't requeue them.

> I've inspected the code and I don't think that we should check
> the return code at all, we should simply fail the request. If
> the io_work context is running in parallel with the the error
> recovery handler we have a bug that we need to fix.
> 
> How about this?

Yes this would work fine for my case.

> --
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index 10fc45d95b86..6d59867bb275 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -1147,8 +1147,7 @@ static int nvme_tcp_try_send(struct nvme_tcp_queue
> *queue)
>         } else if (ret < 0) {
>                 dev_err(queue->ctrl->ctrl.device,
>                         "failed to send request %d\n", ret);
> -               if (ret != -EPIPE && ret != -ECONNRESET)
> -                       nvme_tcp_fail_request(queue->request);
> +               nvme_tcp_fail_request(req);
>                 nvme_tcp_done_send_req(queue);
>         }
>         return ret;
> --
> 
> Adding Anton,
> 
> Anton, do you see an issue with this change? io_work is safely
> fenced from the cancellation iter so there is no reason for
> us not to fail the request here when the socket closes (or
> any other reason for that matter).

