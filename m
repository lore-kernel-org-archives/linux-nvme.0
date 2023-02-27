Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD7D7C64ED6
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Feb 2023 07:12:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+4ViIbovJwGC+zdssZ/cs2r4ghsqoWRzwfEhRkbDb7I=; b=FPxP+chx/nLWpgcCdPchAm2Ys5
	1lbXd90jTqaNqJdwq91jiboOuqfVJtV6nNi5HhC2mD7lUzRCZi3tYYbnHIfMTtOTLeRwiPStLu4LZ
	Qmsbt9zh0nMQN+AVlt4BZvtthm/Y7gZuT6OgtUqpnEEdNx/nk1kQkEgC5NZOX3Tz68Tu9IlnsVmBv
	jqcEd1+246AwwGoMm3wB/xvwpRKPv21/yTAw3XeXuWOU9AFjULEQZ7pin/u/aFxmHr6xuiapI57YX
	d7xDarmd3tPIStgGUkkgVVoA40HoAy8jNqyvSvvzXwJzloF648Rj7cgGZWHt5r+HoRh/YsniCw34H
	rsSjo28A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pWXg2-008dd7-Jq; Mon, 27 Feb 2023 07:12:02 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pWXfy-008dcW-NN
	for linux-nvme@lists.infradead.org; Mon, 27 Feb 2023 07:12:00 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id BD80B1FD63;
	Mon, 27 Feb 2023 07:11:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1677481910; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+4ViIbovJwGC+zdssZ/cs2r4ghsqoWRzwfEhRkbDb7I=;
	b=hiqKqCr3rsdarux/nmWo0bGmlzxf/2vvk4axvN6jKCp4QJaaJ9/jh8/49bATUmRgW1a8sv
	yH0Qg+5Kn8ysLtzRAikCc7MViNKizGqKScSEW3U/UxrnMERP8T2NFMVZ7CVee1aHwjtmQI
	JsszPpfaNbTkT8w/T2mp5ucWnw+jUOo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1677481910;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+4ViIbovJwGC+zdssZ/cs2r4ghsqoWRzwfEhRkbDb7I=;
	b=HmONjfa9GHu27sWRjsskdUPxGAf/J9U2GQHY1aAmmh5HUne/0wt1aQ0wwVzZ+5i1BDKGNv
	kmZPYUeExsTPe1Ag==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id AAC1D13912;
	Mon, 27 Feb 2023 07:11:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id SjbrKLZX/GP/EgAAMHmgww
	(envelope-from <hare@suse.de>); Mon, 27 Feb 2023 07:11:50 +0000
Message-ID: <1084ead0-860c-e658-0ca9-0c701fb91105@suse.de>
Date: Mon, 27 Feb 2023 08:11:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] nvme-fabrics: show well known discovery name
Content-Language: en-US
To: Daniel Wagner <dwagner@suse.de>, linux-nvme@lists.infradead.org
Cc: Chaitanya Kulkarni <kch@nvidia.com>
References: <20230221165106.21326-1-dwagner@suse.de>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20230221165106.21326-1-dwagner@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230226_231158_947065_2E47B7C9 
X-CRM114-Status: GOOD (  20.34  )
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

On 2/21/23 17:51, Daniel Wagner wrote:
> The kernel always logs the unique subsystem name for a discovery
> controller, even in the case user space asked for the well known.
> 
> This has lead to confusion as the logs of nvme-cli and the kernel
> logs didn't match.
> 
> First, nvme-cli connects to the well known discovery controller to
> figure out if it supports TP8013. If so then nvme-cli disconnects and
> connects to the unique discovery controller. Currently, the kernel show
> that user space connected twice to the unique one.
> 
> To avoid further confusion, show the well known discovery controller if
> user space asked for it:
> 
>    $ nvme connect-all -v -t tcp -a 192.168.0.1
>    nvme0: nqn.2014-08.org.nvmexpress.discovery connected
>    nvme0: nqn.2014-08.org.nvmexpress.discovery disconnected
>    nvme0: nqn.discovery connected
> 
>    kernel log:
>    nvme nvme0: new ctrl: NQN "nqn.2014-08.org.nvmexpress.discovery", addr 192.168.0.1:8009
>    nvme nvme0: Removing ctrl: NQN "nqn.2014-08.org.nvmexpress.discovery"
>    nvme nvme0: new ctrl: NQN "nqn.discovery", addr 192.168.0.1:8009
> 
> Fixes: e5ea42faa773 ("nvme: display correct subsystem NQN")
> Cc: Hannes Reinecke <hare@suse.de>
> Cc: Chaitanya Kulkarni <kch@nvidia.com>
> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> ---
>   drivers/nvme/host/fabrics.h | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/host/fabrics.h b/drivers/nvme/host/fabrics.h
> index a6e22116e139..dcac3df8a5f7 100644
> --- a/drivers/nvme/host/fabrics.h
> +++ b/drivers/nvme/host/fabrics.h
> @@ -189,7 +189,8 @@ nvmf_ctlr_matches_baseopts(struct nvme_ctrl *ctrl,
>   
>   static inline char *nvmf_ctrl_subsysnqn(struct nvme_ctrl *ctrl)
>   {
> -	if (!ctrl->subsys)
> +	if (!ctrl->subsys ||
> +	    !strcmp(ctrl->opts->subsysnqn, NVME_DISC_SUBSYS_NAME))
>   		return ctrl->opts->subsysnqn;
>   	return ctrl->subsys->subnqn;
>   }
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Ivo Totev, Andrew
Myers, Andrew McDonald, Martje Boudien Moerman


