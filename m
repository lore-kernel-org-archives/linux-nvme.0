Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7591C44508
	for <linux-nvme@archiver.kernel.org>; Tue, 14 Jul 2026 16:59:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=z8tNQOvyWMASAGCFQU1N5sFM4EYY2yRRnJqdBDbwURE=; b=CQCD6iy1v3ExkAovgDNkSy4JZS
	DrzMwNel+ei3cXYIT/dlsQcGSjDx/HU88tw+POcSie9ZGnXvLgnevauagQaT67quRIA0LL/bd4+Pr
	7P6OSyHbduWEWhw2A79AQCcj/MLehpcSvIJ7PjlEs5AGRZUC3KoiciBDQzvnp677Z+H+8khySXsku
	xX5vfnNjOcgP0gJacQNCzkPm7aKDLM3KB1sS+2yBupkDxmCM2LNyxjKDsaEXRvPG7cTj8u9rBbsxG
	XVLAXH0ve4fUU+4KnEx5Zkn6QQRtCdA156v4Y+RtSOSxujxjWFtK+YceZkya18A1Gi5XUA0jqgaIM
	T9hWGSVA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjgTE-0000000Ci4k-0cYF;
	Tue, 14 Jul 2026 16:59:00 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjgTB-0000000Ci4M-1jPI
	for linux-nvme@lists.infradead.org;
	Tue, 14 Jul 2026 16:58:58 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id CE6C53E21;
	Tue, 14 Jul 2026 16:58:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1784048334; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=z8tNQOvyWMASAGCFQU1N5sFM4EYY2yRRnJqdBDbwURE=;
	b=a708VJraVOHk9xcYK1Zc7Jf6M0MkVT/5zGOMCZVUyBDxBWCT6ckALRtu7IVeztvvK3AMmm
	pzG4/Tilnq4Of47MlOScppVojpXiIuwzEXhd2yKSNv/PfKx2o7aK+OMR362eT9XiRJFdMM
	ksTmmJlvBAc5rZ9a2Pmcdezi0t/fPaI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1784048334;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=z8tNQOvyWMASAGCFQU1N5sFM4EYY2yRRnJqdBDbwURE=;
	b=RK7rtBomu4/wfnFRBjIKUSjsQBUgHXtnhLML8hBvBhg1UFDhq3QeClGyo9/nyfi9pWehix
	WWKxiNysuGIrbBAA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1784048332; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=z8tNQOvyWMASAGCFQU1N5sFM4EYY2yRRnJqdBDbwURE=;
	b=MDdCCMvzoM0Y+Uf55Bgu1mdgL2Eq2rsgD+PNcArL3pzR8PnjhPn9xXXm+/Z1qxgjWYTWHO
	nYSnDZcpQLWjOHGD7mu0c74zy/sHukM7NkcBujysWIqSMEvLoXiJmDLrBUjl/j1Ajis/o0
	UN62hMr587L414rBTUBVFHm0/Msb3sU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1784048332;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=z8tNQOvyWMASAGCFQU1N5sFM4EYY2yRRnJqdBDbwURE=;
	b=BQ+OuUDNiba0nEFd/zcMvlXae09n6+gU9ZRcKqBNiPxiTXTBcLuDDEqkmTrhWWNRg18X/R
	+BddpPStCdzNcqAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BA47B779AE;
	Tue, 14 Jul 2026 16:58:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id q+vcK8xqVmqzMwAAD6G6ig
	(envelope-from <dwagner@suse.de>); Tue, 14 Jul 2026 16:58:52 +0000
Date: Tue, 14 Jul 2026 18:58:52 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Hannes Reinecke <hare@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Daniel Wagner <wagi@kernel.org>, 
	linux-nvme@lists.infradead.org, Sagi Grimberg <sagi@grimberg.me>, 
	Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv2] nvmetcli: store DHCHAP attributes
Message-ID: <4e06f41e-0ec2-44b1-b4dc-1015bcec2615@flourine.local>
References: <20260713135318.125238-1-hare@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260713135318.125238-1-hare@kernel.org>
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,flourine.local:mid]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260714_095857_613798_0E8B663D 
X-CRM114-Status: GOOD (  10.96  )
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

On Mon, Jul 13, 2026 at 03:53:18PM +0200, Hannes Reinecke wrote:
> The DHCHAP authentication is stored under hosts/, and are starting
> with 'dhchap_'. So add a 'dhchap' attribute group for the host object
> to correctly save and restore DHCHAP values.

> --- a/nvmet/test_nvmet.py
> +++ b/nvmet/test_nvmet.py
> @@ -426,6 +426,7 @@ class TestNvmet(unittest.TestCase):
>          root.clear_existing()
>  
>          h = nvme.Host(nqn='hostnqn', mode='create')
> +        h.set_attr('dhgroup','ffdhe2048')

I suppose this should be 

         h.set_attr('dhchap', 'dhgroup','ffdhe2048')

set_attr wants 3 arguments.

