Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5513EE49A0
	for <linux-nvme@archiver.kernel.org>; Wed, 23 Aug 2023 15:38:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Eenv0E3pbFxBLmV/yDdoisR0p0sMffadvPsgkrHKufY=; b=jRXDD2uBrzpY9dMITyEyk7jkNH
	m67fSYe0KeYfKAENtIWrU82SRnv8L5F83oigZWobOooXL7ex0chfidA6I/WdRc9LvfWFHC44egfRh
	tBuDn29qi6pw2/3GQ8vxpWX1ucrPqQnU7u9ZwUsu2fM3359OHJffn5W7WCSLdVfmAlHDFMIUWzpu8
	uJMTTC1h03V93UHDjwiuP1J7E/zAtlthWi/UUt8DCcJLwCQUcg3CenEeMiFqZo/znozDWm15dW70/
	QdbOeryuk5/Q9xs51TEAne03q7wdiN399m1CnoK+LMdGTvMYJvzKLoJhXHn9arrcAEC+jj0ecB79K
	JFdfcAgA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qYpvl-000zro-07;
	Wed, 23 Aug 2023 15:38:01 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qYpvf-000zrC-11
	for linux-nvme@lists.infradead.org;
	Wed, 23 Aug 2023 15:37:56 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id B457160AC4;
	Wed, 23 Aug 2023 15:37:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7600CC433C7;
	Wed, 23 Aug 2023 15:37:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692805072;
	bh=8/9EbLHyidtqZz27exoTNlGynMuUFw3JiOjBx/Kfn5E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=szp+06IUki47DlwYhUpPF4uCnVR1u/gpgYuDmLl4MmW0eYocsYv352z+4jxjs/bLY
	 Tavde0xtBAjE44kETh28E5Fh4W5ttrfpxNqMiahZHO4Qn/XRytDeUGrDySmEm4y6R7
	 RUdGRBULsDcZieMFtdUHF1efA3Dzd6IpjImZfuk2R8IfJ/0aJH2NFs+Og60yfmRaO2
	 CPlufVIgO/Hv9zGn9uXbD9BLOjlAfX6flK1lGZgpLxd4fYG2+n1SFOhzV+xWYGjPde
	 akWUuduMcXkh6FSbiSvgaJYwpYQSZB7dXExyrynEsdjJzXnjLCTEBHk6foV0ft/7FH
	 /7WvUqrXHLjuw==
Date: Wed, 23 Aug 2023 09:37:48 -0600
From: Keith Busch <kbusch@kernel.org>
To: Daniel Wagner <dwagner@suse.de>
Cc: Christoph Hellwig <hch@lst.de>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	Guangwu Zhang <guazhang@redhat.com>, Ming Lei <ming.lei@redhat.com>,
	Oleg Solovyov <mcpain@altlinux.org>
Subject: Re: stack smashing detected with 'nvme sanitize-log /dev/nvme0'
Message-ID: <ZOYnzFSgWAwnkWqs@kbusch-mbp>
References: <dckvq3ohgqdkxg7wz4vslf36gaivgldl742vew67oyh2buj5nr@7ypn5ydt6kss>
 <20230726131643.GA16186@lst.de>
 <zopmb3355u2vorlkvas3gqb53azp7qtb7yq2kyc3reezlyqtcy@iev3wkvzumsq>
 <ZON+qrAwuO3eQB6G@kbusch-mbp.dhcp.thefacebook.com>
 <4ub43j2q4glt42cwgmaf4cohswt4xaz3lna5nquvb5lavjitvv@tctmuwftqil6>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4ub43j2q4glt42cwgmaf4cohswt4xaz3lna5nquvb5lavjitvv@tctmuwftqil6>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230823_083755_463427_77047429 
X-CRM114-Status: GOOD (  28.14  )
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

On Tue, Aug 22, 2023 at 09:55:38AM +0200, Daniel Wagner wrote:
> On Mon, Aug 21, 2023 at 09:11:38AM -0600, Keith Busch wrote:
> > I don't think we want to bounce to kernel memory for the device to
> > overwrite it. I suggest just change nvme-cli's stack allocated santize
> > log to a use page aligned and sized buffer.
> 
> Sure we can add workarounds in userspace, though I think this is a
> regression and should ideally address in the kernel somehow.

Not sure if this is a regression. Even prior to the DMA alignment
settings change, you'd still hit this if your stack buffer aligned to
512b. The kernel bounce buffer sounds like it just corrupts kernel
memory instead, so we can't have the driver just go back to the way it
was for these devices; someone has to over allocate the buffer.

A device over running their DMA buffer, though, sounds bad enough that a
firmware fix should happen instead.

> > diff --git a/nvme.c b/nvme.c
> > index 181141ad..7f98a506 100644
> > --- a/nvme.c
> > +++ b/nvme.c
> > @@ -2376,7 +2376,7 @@ ret:
> >  static int sanitize_log(int argc, char **argv, struct command *command, struct plugin *plugin)
> >  {
> >  	const char *desc = "Retrieve sanitize log and show it.";
> > -	struct nvme_sanitize_log_page sanitize_log;
> > +	struct nvme_sanitize_log_page *sanitize_log;
> >  	enum nvme_print_flags flags;
> >  	struct nvme_dev *dev;
> >  	int err;
> > @@ -2419,13 +2419,19 @@ static int sanitize_log(int argc, char **argv, struct command *command, struct p
> >  	if (cfg.human_readable)
> >  		flags |= VERBOSE;
> >
> > -	err = nvme_cli_get_log_sanitize(dev, cfg.rae, &sanitize_log);
> > +	if (posix_memalign((void *)&sanitize_log, getpagesize(), 0x1000)) {
> > +		err = -1;
> > +		goto close_dev;
> > +	}
> > +
> > +	err = nvme_cli_get_log_sanitize(dev, cfg.rae, sanitize_log);
> >  	if (!err)
> > -		nvme_show_sanitize_log(&sanitize_log, dev->name, flags);
> > +		nvme_show_sanitize_log(sanitize_log, dev->name, flags);
> >  	else if (err > 0)
> >  		nvme_show_status(err);
> >  	else
> >  		nvme_show_error("sanitize status log: %s", nvme_strerror(errno));
> > +	free(sanitize_log);
> >  close_dev:
> >  	dev_close(dev);
> >  ret:
> 
> Anyway, I suppose we want to do this far all get log commands, not sure
> if it is limited to the get sanitize log alone.

Perhaps for saftey we could do that for all logs < 4k in size. There are
not very many of those.

