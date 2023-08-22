Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C16ECEE4993
	for <linux-nvme@archiver.kernel.org>; Tue, 22 Aug 2023 07:55:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=f89fnvxGk5eYUx+/3/51FdeyDDZko2exWvUQvW6cSYk=; b=IeqkmiCWE5e0Tfs/dKWN2cTrrn
	/j6ev9JqbRj9EpGAHtwcUnnvhROJ4tl1lpyA+jmkzu5tPJr2sXc/yRTtF2/taYldU7wD/jSgytUIM
	dSNkm3HSiwEjp7ZwT8AJJcE48b06G6QH3aKeDL1yv8acVn+TwyNVt9C0Kr1wnaWMpoOoCc0X2VBnn
	+H4Un8py2cRADYaOH8Midmpz61nqG38RWW6VShlAJ5gnNuiJ1Y0wtD0uRjNZJeaEjMpMMJTPVL+eD
	XgG6HXatCzdWiU6utI3jHo6kQ1bHedoxkuoI4F3ugJOl3DusZMBcvrObPgv+/yu6r6mcWWNL5RIfa
	ARVkz9Bw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qYMEd-00FPCz-1Q;
	Tue, 22 Aug 2023 07:55:31 +0000
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qYMEa-00FPCJ-00
	for linux-nvme@lists.infradead.org;
	Tue, 22 Aug 2023 07:55:29 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 5E9B71F85D;
	Tue, 22 Aug 2023 07:55:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1692690923; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=f89fnvxGk5eYUx+/3/51FdeyDDZko2exWvUQvW6cSYk=;
	b=YmPzeQcwS+qJsjtAhlsU1HWgXPagV68tSbQN4WPC0iPXv09YUmhUSL36ovmEqEYF9OC2D9
	ppzoEvNhldImr2JSMeCQguQJQyoT52Q+vE9MTtqNziaglZd9AtR3e551ofSBUOiGgd2bwW
	92cl05xqZeUYZKBIV9Ftv/udlKnlpnc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1692690923;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=f89fnvxGk5eYUx+/3/51FdeyDDZko2exWvUQvW6cSYk=;
	b=72EIygnhfghrWmJfmKKpOu/DSNSH1LbvS4LIQfEQnJqNm4cOeDTkCtodF/CqurO0+Q7W3m
	0BL/SuWWiSG/e2CQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 43F4D13919;
	Tue, 22 Aug 2023 07:55:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id 7cqKEOtp5GS+XgAAMHmgww
	(envelope-from <dwagner@suse.de>); Tue, 22 Aug 2023 07:55:23 +0000
Date: Tue, 22 Aug 2023 09:55:38 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, 
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, Guangwu Zhang <guazhang@redhat.com>, 
	Ming Lei <ming.lei@redhat.com>, Oleg Solovyov <mcpain@altlinux.org>
Subject: Re: stack smashing detected with 'nvme sanitize-log /dev/nvme0'
Message-ID: <4ub43j2q4glt42cwgmaf4cohswt4xaz3lna5nquvb5lavjitvv@tctmuwftqil6>
References: <dckvq3ohgqdkxg7wz4vslf36gaivgldl742vew67oyh2buj5nr@7ypn5ydt6kss>
 <20230726131643.GA16186@lst.de>
 <zopmb3355u2vorlkvas3gqb53azp7qtb7yq2kyc3reezlyqtcy@iev3wkvzumsq>
 <ZON+qrAwuO3eQB6G@kbusch-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZON+qrAwuO3eQB6G@kbusch-mbp.dhcp.thefacebook.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230822_005528_205151_28E4156C 
X-CRM114-Status: GOOD (  19.64  )
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

On Mon, Aug 21, 2023 at 09:11:38AM -0600, Keith Busch wrote:
> I don't think we want to bounce to kernel memory for the device to
> overwrite it. I suggest just change nvme-cli's stack allocated santize
> log to a use page aligned and sized buffer.

Sure we can add workarounds in userspace, though I think this is a
regression and should ideally address in the kernel somehow.

> diff --git a/nvme.c b/nvme.c
> index 181141ad..7f98a506 100644
> --- a/nvme.c
> +++ b/nvme.c
> @@ -2376,7 +2376,7 @@ ret:
>  static int sanitize_log(int argc, char **argv, struct command *command, struct plugin *plugin)
>  {
>  	const char *desc = "Retrieve sanitize log and show it.";
> -	struct nvme_sanitize_log_page sanitize_log;
> +	struct nvme_sanitize_log_page *sanitize_log;
>  	enum nvme_print_flags flags;
>  	struct nvme_dev *dev;
>  	int err;
> @@ -2419,13 +2419,19 @@ static int sanitize_log(int argc, char **argv, struct command *command, struct p
>  	if (cfg.human_readable)
>  		flags |= VERBOSE;
>
> -	err = nvme_cli_get_log_sanitize(dev, cfg.rae, &sanitize_log);
> +	if (posix_memalign((void *)&sanitize_log, getpagesize(), 0x1000)) {
> +		err = -1;
> +		goto close_dev;
> +	}
> +
> +	err = nvme_cli_get_log_sanitize(dev, cfg.rae, sanitize_log);
>  	if (!err)
> -		nvme_show_sanitize_log(&sanitize_log, dev->name, flags);
> +		nvme_show_sanitize_log(sanitize_log, dev->name, flags);
>  	else if (err > 0)
>  		nvme_show_status(err);
>  	else
>  		nvme_show_error("sanitize status log: %s", nvme_strerror(errno));
> +	free(sanitize_log);
>  close_dev:
>  	dev_close(dev);
>  ret:

Anyway, I suppose we want to do this far all get log commands, not sure
if it is limited to the get sanitize log alone.

