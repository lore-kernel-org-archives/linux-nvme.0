Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76D68C77B7C
	for <linux-nvme@archiver.kernel.org>; Wed, 10 May 2023 16:26:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xqKjAu2Ln3e+SxW5FOCmLl+pgDCLcTh+wEsGGbIzFDE=; b=zUCjj3hV+FggiYUIiNDq+7qm9d
	QUfNl+nhMLMtjW1Gu4o0IidAyGLuR7joMi1PrXBehSN9vQo1+qSwyDkh/+fQZkg8jNOmrQlNS/iwS
	VN+UZn051czwAA+YzanazYxrU7vU6rGoR9uQGds8MvpyR2R91rkXT9u9s43PH3awpoAE6XMWLkwNe
	FUERyP1MuE83h3APaOD/GGMKeeHRhpPHize/o51BHMDO2GNv3D7KuTa5nHplTZ/LOG3xUWUMdzD4W
	dPJb0nfwMUvrqIxJFOCyio+Td8U0IeNW93ttwqpgNjpvDivXU7srcDx4dWQGXbFq+vaBP13Tl6RSh
	v4E469hw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pwmdy-006ZB2-0X;
	Wed, 10 May 2023 16:26:22 +0000
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pwmdv-006ZA7-2u
	for linux-nvme@lists.infradead.org;
	Wed, 10 May 2023 16:26:21 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id DD1B61F899;
	Wed, 10 May 2023 16:26:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1683735976; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xqKjAu2Ln3e+SxW5FOCmLl+pgDCLcTh+wEsGGbIzFDE=;
	b=T64tsp2YrkfQoNaZ0OGLNGehh/vXUxbgNzq2pYz8tS+PoorS7iIouGwxYdtBL/l4Gf1ysq
	CvjacOAdcvCOhC63z1R1TllsrsvmbBfk+/26AplZ1Bcxn7s7l8df5J1yZ3gK4QQDRc5EUX
	JSeI6Bp6mloRJ7QSomBMV9sHOEIx6FA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1683735976;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xqKjAu2Ln3e+SxW5FOCmLl+pgDCLcTh+wEsGGbIzFDE=;
	b=NuyBZwNJKHEwDU3crPkK5pKq5UQGDKsxdJiZ8jA/62JcmkI2qZIr8FYPf/8LdQb06YhYI6
	MJSDLxOZj4BMOvDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8D518138E5;
	Wed, 10 May 2023 16:26:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id ZTOIGajFW2T0bwAAMHmgww
	(envelope-from <dwagner@suse.de>); Wed, 10 May 2023 16:26:16 +0000
Date: Wed, 10 May 2023 18:26:14 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Hannes Reinecke <hare@suse.de>
Cc: Max Gurtovoy <mgurtovoy@nvidia.com>, Sagi Grimberg <sagi@grimberg.me>, 
	Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org, 
	Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [PATCH 11/17] nvme-tcp: enable TLS handshake upcall
Message-ID: <rblzrcob7f7wigp2rbjfscfcimsmwgny32bn6v5feqjdurfql2@oqfuodcyp3xy>
References: <20230419065714.52076-1-hare@suse.de>
 <20230419065714.52076-12-hare@suse.de>
 <31551564-2fcb-50d2-99c3-3d09473fce06@nvidia.com>
 <55ffd26c-9776-a2c7-99b2-fc45de60c0bd@suse.de>
 <09624f1c-a1e9-ad8b-bccf-c7696c398b4f@nvidia.com>
 <206d203b-a921-0f69-ea75-fc17dc505e19@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <206d203b-a921-0f69-ea75-fc17dc505e19@suse.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230510_092620_102284_18A35EEA 
X-CRM114-Status: GOOD (  18.25  )
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

 > > > > index bbaa04a0c502..2aa8fb991455 100644
> > > > > --- a/drivers/nvme/host/fabrics.c
> > > > > +++ b/drivers/nvme/host/fabrics.c
> > > > > @@ -609,6 +609,9 @@ static const match_table_t opt_tokens = {
> > > > >       { NVMF_OPT_DISCOVERY,        "discovery"        },
> > > > >       { NVMF_OPT_DHCHAP_SECRET,    "dhchap_secret=%s"    },
> > > > >       { NVMF_OPT_DHCHAP_CTRL_SECRET,    "dhchap_ctrl_secret=%s"    },
> > > > > +#ifdef CONFIG_NVME_TCP_TLS
> > > > 
> > > > This ifdef is redundant IMO.
> > > > We have to many of those already in the code and we should
> > > > reduce to be able to keep the code maintainable.
> > > > 
> > > We have been going back and forth on this, and the consensus was to
> > > _have_ a compilation flag here. This allows the userland utility
> > > nvme-cli to determine whether tls support is available on any given
> > > kernel.
> > 
> > nvme-cli will determine tls support using check for "static const
> > match_table_t opt_tokens" ?
> > 
> Yes. The table is displayed by doing a 'cat' on /dev/nvme-fabrics, and
> nvme-cli will be parsing that to figure out if a particular option is
> supported.

FWIW, here the filter code:

https://github.com/linux-nvme/libnvme/commit/d123131f2e542e5a4c046cb65a68fc1fb97ea384

