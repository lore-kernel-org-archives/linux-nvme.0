Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41F3AC001DF
	for <linux-nvme@archiver.kernel.org>; Mon, 24 Jul 2023 16:18:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=krO2KX98+g+8274HZ3EsHYhFKHuB+8A669TsehiLQPU=; b=hKRWXM4kZ+0/p2BkJQaITHnxdV
	K/Q94D2MRZzs57QP/stl4Q99o4jpWCotI+98qlLY3kyLOvqwtRYVQymmVTjJcEi6FpkV81pSkX7uM
	Te8zZ4oNHr3MsDruOaVVstPyXmHoKJT9A9j2IzgrJOlJOVp9X9UbvEbsRtjxydq/ZEb+tjLjgAMSa
	Zl9eHnrxUm9P/BoMWi4D60900GS4IGox1l2WczfStbkd8j2qO0zanR30wHlIHIX0DfgzhCyVP7O0+
	M2WUApPMxRWUYEvdS8iOgmys0+SFAGVCJ2cXKXXg6LdAuMqobgXmYth3IikMsnUELDSVBoWMbPZ5m
	M6aUGMDw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qNyGD-004pkQ-1i;
	Mon, 24 Jul 2023 16:18:13 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qNyGA-004piT-2P
	for linux-nvme@lists.infradead.org;
	Mon, 24 Jul 2023 16:18:12 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 9221E1FD71;
	Mon, 24 Jul 2023 16:18:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1690215484; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=krO2KX98+g+8274HZ3EsHYhFKHuB+8A669TsehiLQPU=;
	b=pFL/vJH5jJfmuS75M037M4+xbEQUajE95pRcgtKodGcsXDRB5QRsEVtptJAW6JNyM2dm34
	hCHIvb6outJfoam+0ivOM0IwibBeqnWzVnqSV0zA//BQS/Uv7vw7M2XlqLL5XFWo/dgdUJ
	NA1wGdGxVxY6QqOFJa0E1cJorQe+bfg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1690215484;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=krO2KX98+g+8274HZ3EsHYhFKHuB+8A669TsehiLQPU=;
	b=Xzri2DohYPnfevTdmoGnw9o+PTHBrT7Q92N3WLsJWDKKQ1vMz+vNc8ogptzif7GVkMTXSy
	pFF/6ksF2DqLE0Aw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 842CB13476;
	Mon, 24 Jul 2023 16:18:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id sMYhIDykvmTFHAAAMHmgww
	(envelope-from <dwagner@suse.de>); Mon, 24 Jul 2023 16:18:04 +0000
Date: Mon, 24 Jul 2023 18:18:03 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Caleb Sander <csander@purestorage.com>, linux-nvme@lists.infradead.org, 
	Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH libnvme] fabrics: don't pass sqflow_disable if the kernel
 does not support the option
Message-ID: <udo5xyydb5jb6isnpcbutuegifww2kuto44k3yu3eb6mnctwia@d7lmpffppurl>
References: <20230724090611.705366-1-sagi@grimberg.me>
 <CADUfDZr9bNo17_NmWLCu_kVdURQn7XbbwtZoi2XzF8NTNyL_VA@mail.gmail.com>
 <a20ee796-3690-9d2b-2363-4caaefc3aca9@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a20ee796-3690-9d2b-2363-4caaefc3aca9@grimberg.me>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230724_091810_949036_09993F08 
X-CRM114-Status: GOOD (  26.36  )
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

On Mon, Jul 24, 2023 at 06:35:55PM +0300, Sagi Grimberg wrote:
> > How do we know options is initialized here? It looks like that's done
> > in __nvmf_supported_options(), called from nvmf_add_ctrl(), which is
> > called a few lines later in this function.

I've paired __nvmf_supported_options() with build_options(). We can
move the call to __nvmf_supported_options() further up if it helps.

> This is for connecting discovery log entries, so the kernel cap was
> already read once for the discovery controller.
> 
> Although granted, this can be udev driven on an existing discovery
> controller. Probably need to do it regardless of adding a controller.
> 
> I remember when adding the capability to check supported opts I added
> an interface to do it per feature. Not sure why it was changed, it is
> much more sane to just read it on demand given that there is just a
> simple and short string copy in the kernel...

I was trying to avoid to do a open/read/parse/close cycle for each argument we
are going append in the build_options() function.

> Ideally this would become:
> 	if (e->treq & NVMF_TREQ_DISABLE_SQFLOW &&
> 	    nvmf_check_cap("disable_sqflow"))
> 		c->cfg.disable_sqflow = true;
> 	else
> 		c->cfg.disable_sqflow = false;
> 
> Daniel? Any reason why we are caching these opts in an executable
> with a short lifetime? And apparently we need to be very precise when
> we rely on this cache to be stable.

Ah I see, in this case let's bring nvmf_check_cap() (although I couldn't find it
anywhere... I can remember I saw those patches)

> If you prefer to cache it, at least do it in the start of every
> fabrics callback so we don't need to understand when this cache
> is valid...

I don't want to cache it, I just wanted to avoid the above mentioned
open/read/parse/close cycle for each build options.

