Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C04DFC6FA8A
	for <linux-nvme@archiver.kernel.org>; Thu, 15 Sep 2022 15:42:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=E+f78KcwCsN6dDgoNHa82d5GxDQmIauK2QBNQykhlZ8=; b=o1ogFeo1exyNcCof/RxopdNjNT
	QNmvTy8Abbn3ZQyKIuS7OHYtBm9ty3HGfg+fAgOuq1CxLnsWJu8Q4OGU/qh3WBqAHI8raH5sudYro
	UH7OhqSOOf0PyZddcuYOpdb6unGal2wPLinAhukD0G05c0JMpclSe6CgwJIV7sJNdoOU1FlnANFDc
	FlDlntZLf10moKr9UMMCTlcfyJ5zyolMVhqhByi+KOvKLI8gmx0A4Cb43T708bIwrGgF3nT2Xv08p
	dZDC5OE2fieYu1SwWwHOxGKne+nNrS9IKhOtTm/xdR+oJ5Rl6CNqXWtDq68b5rtZpUIms65prZ3nZ
	/F6gg1Mg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oYr07-00CWBd-H4; Thu, 15 Sep 2022 15:42:03 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oYr02-00CW5L-GT
	for linux-nvme@lists.infradead.org; Thu, 15 Sep 2022 15:42:00 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8591F21B7D;
	Thu, 15 Sep 2022 15:41:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1663256507; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E+f78KcwCsN6dDgoNHa82d5GxDQmIauK2QBNQykhlZ8=;
	b=EpfXO4hhLoabs6VgUMGB6/xYhAU8MvPFKBJ5ty17xk2kIdgfR6YOuRcJiSDLqSTJ2IHoBA
	mNQ7N5mSNMYrpJ6LSrDqCqzZYTADJPXuF0ovpl98h26V2jVeF7j93kq5XocupI1367V5T8
	x12HEpqLT/SSpqIyRtv9CxQTjJLgfgc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1663256507;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E+f78KcwCsN6dDgoNHa82d5GxDQmIauK2QBNQykhlZ8=;
	b=4CyjsOTgwGwLTc97oQHabX4jjsWM9aqsjw2xQXTXqjY6pECCmBICJ/F8RtmTEsyDqAo15D
	6NzoTSXBE1jUinBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5F12213A49;
	Thu, 15 Sep 2022 15:41:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id QNvmFLtHI2PZGgAAMHmgww
	(envelope-from <hare@suse.de>); Thu, 15 Sep 2022 15:41:47 +0000
Message-ID: <381b003e-3510-8cbf-031d-b5314b17560d@suse.de>
Date: Thu, 15 Sep 2022 17:41:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH blktests v3] nvme/046: test queue count changes on
 reconnect
Content-Language: en-US
To: Daniel Wagner <dwagner@suse.de>, Sagi Grimberg <sagi@grimberg.me>
Cc: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 James Smart <jsmart2021@gmail.com>
References: <20220913065758.134668-1-dwagner@suse.de>
 <20220913105743.gw2gczryymhy6x5o@shindev>
 <20220913114210.gceoxlpffhaekpk7@carbon.lan>
 <20220913171049.kgim57lu5rqb7j3g@carbon.lan>
 <20220914090003.jbc5xmtfxjjssuz3@carbon.lan>
 <3b58b91d-e217-86a2-b2e4-3b0656bbe0e9@grimberg.me>
 <20220914110717.pvzm2666mklkg73a@carbon.lan>
 <20220915125037.fqhcokdn4scnklyq@carbon.lan>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20220915125037.fqhcokdn4scnklyq@carbon.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220915_084158_807263_28191431 
X-CRM114-Status: GOOD (  23.69  )
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

On 9/15/22 14:50, Daniel Wagner wrote:
>> So do we agree the fc host should not stop reconnecting? James?
> 
> With the change below the test succeeds once:
> 
> diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
> index 42767fb75455..b167cf9fee6d 100644
> --- a/drivers/nvme/host/fc.c
> +++ b/drivers/nvme/host/fc.c
> @@ -3325,8 +3325,6 @@ nvme_fc_reconnect_or_delete(struct nvme_fc_ctrl *ctrl, int status)
>                  dev_info(ctrl->ctrl.device,
>                          "NVME-FC{%d}: reset: Reconnect attempt failed (%d)\n",
>                          ctrl->cnum, status);
> -               if (status > 0 && (status & NVME_SC_DNR))
> -                       recon = false;
>          } else if (time_after_eq(jiffies, rport->dev_loss_end))
>                  recon = false;
> 
> This part was introduced with f25f8ef70ce2 ("nvme-fc: short-circuit
> reconnect retries"):
> 
>      nvme-fc: short-circuit reconnect retries
> 
>      Returning an nvme status from nvme_fc_create_association() indicates
>      that the association is established, and we should honour the DNR bit.
>      If it's set a reconnect attempt will just return the same error, so
>      we can short-circuit the reconnect attempts and fail the connection
>      directly.
> 
> It looks like the reasoning here didn't take into consideration the
> scenario we have here. I'd say we should not do it and handle it similar
> as with have with tcp/rdma.
> 
But that is wrong.
When we are evaluating the NVMe status we _need_ to check the DNR bit; 
that's precisely what it's for.

The real reason here is a queue inversion with fcloop; we've had them 
for ages, and I'm not surprised that it pops off now.
In fact, I was quite surprised that I didn't hit it when updating 
blktests; in previous versions I had to insert an explicit 'sleep 2' 
before disconnect to make it work.

I'd rather fix that than reverting FC to the (wrong) behaviour.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Ivo Totev, Andrew
Myers, Andrew McDonald, Martje Boudien Moerman

