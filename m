Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 064B4C001DE
	for <linux-nvme@archiver.kernel.org>; Fri, 28 Jul 2023 09:39:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UTS80klLbnFqHbKrK3Dj3cwhXNDWYzQsSTCfEY+2YQk=; b=fhrOMAeAkeYJ/aQyoWxgC/I4Px
	NImyv5Uc88M1wK9mLs6AWgCmbhUj4e+ldkbyiwxXzPvgdnbX3P4CoKGy89Rs4EE+NMU4WZfr5uWAH
	qdZiqFwh7i+niaB3ehsX1AuswKB2LIinF5N2sEqyBPC2MXmPLN6FcSHon29dmEgaRr+im8avr0mO7
	xJe39gRqeSwoR0abJrvgPzWg822cRqUd/9pWbjOtpW59Royvl9mjsQT+M3Avf0XtFSNdFX9JRYSaw
	WN4LePw8JqFR43i59F/YfOw/MZwzn43OODz4N7rUgLECGLmhRCnAABw0qxbuVp/13sctkFLJ9CQfk
	Q/c7b1xQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qPJwQ-002eam-1n;
	Fri, 28 Jul 2023 09:39:22 +0000
Received: from smtp-out1.suse.de ([2001:67c:2178:6::1c])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qPJwO-002eZz-12
	for linux-nvme@lists.infradead.org;
	Fri, 28 Jul 2023 09:39:21 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0C6D6218F8;
	Fri, 28 Jul 2023 09:39:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1690537156; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UTS80klLbnFqHbKrK3Dj3cwhXNDWYzQsSTCfEY+2YQk=;
	b=k6yw34OvvwJosvo61JWm0B4orQDm7drKaaasM/gnjg4jUMhEsfvOsyKQJZIGlZK0w9OORV
	XkyH9q3VCcURbvpbhu3Uf4o7LCymi6jPVGwRV1OzH7jSJXbZIaRCMyS7ckdPtAImAiCmnV
	hL6e99WSs/VQIGAyqs0CTN4A1pkxgKs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1690537156;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UTS80klLbnFqHbKrK3Dj3cwhXNDWYzQsSTCfEY+2YQk=;
	b=Utqqxapqt086nMlMaZvfTIs4CghEd5kYMu5jXBrWD34/V3Ai0LynDfI3IVdAbi6TZwdGp2
	8FuQRoFNg3WEGUCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id EE6FD13276;
	Fri, 28 Jul 2023 09:39:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id Ym37OcOMw2TfDwAAMHmgww
	(envelope-from <dwagner@suse.de>); Fri, 28 Jul 2023 09:39:15 +0000
Date: Fri, 28 Jul 2023 11:39:15 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Caleb Sander <csander@purestorage.com>, Christoph Hellwig <hch@lst.de>, 
	Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
Subject: Re: [PATH libnvme v1 1/2] fabrics: Shorten/rename supported option
 function/vars names
Message-ID: <aziheryo7hkrbpq36s2cqkrxhvrtkrkj5usnribvvpyoi3o4fz@43gdctwaktgt>
References: <r3xuoptvmxqnbt6gi26b6av2jj4wbi3eixgd74lmdauxip63jt@pxmvqyljanjr>
 <20230725084137.16139-1-dwagner@suse.de>
 <676b7c2b-7bcf-6138-0229-389ed9efaa92@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <676b7c2b-7bcf-6138-0229-389ed9efaa92@grimberg.me>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230728_023920_504549_5BE04331 
X-CRM114-Status: GOOD (  16.10  )
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

On Tue, Jul 25, 2023 at 01:55:00PM +0300, Sagi Grimberg wrote:
> > @@ -913,7 +913,7 @@ int nvmf_add_ctrl(nvme_host_t h, nvme_ctrl_t c,
> >   		free(traddr);
> >   	}
> > -	ret = __nvmf_supported_options(h->r);
> > +	ret = nvmf_read_options(h->r);
> >   	if (ret)
> >   		return ret;
> >   	ret = build_options(h, c, &argstr);
> 
> Why do we need an explicit call here?

No particially reason.

> Why it cannot be read on the first capability check?

Ah good idea!

> Something like:
> --
> diff --git a/src/nvme/fabrics.c b/src/nvme/fabrics.c
> index 800293e2a8e7..bb4bf2979eb0 100644
> --- a/src/nvme/fabrics.c
> +++ b/src/nvme/fabrics.c
> @@ -357,10 +357,18 @@ static int __add_argument(char **argstr, const char
> *tok, const char *arg)
>         return 0;
>  }
> 
> +static int __nvmf_supported_options(nvme_root_t r);
> +#define nvmf_check_option(r, tok)                                      \
> +({                                                                     \
> +       if (!(r)->options)                                              \
> +               __nvmf_supported_options(r);                            \
> +       (r)->options->tok;                                              \
> +})
> +
>  #define add_bool_argument(o, argstr, tok, arg)                         \
>  ({                                                                     \
>         int ret;                                                        \
> -       if (r->options->tok) {                                          \
> +       if (nvmf_check_option(r, tok)) {                                \
>                 ret = __add_bool_argument(argstr,                       \
>                                           stringify(tok),               \
>                                           arg);                         \

Sure, makes sense!

