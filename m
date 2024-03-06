Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D401C54E41
	for <linux-nvme@archiver.kernel.org>; Wed,  6 Mar 2024 14:35:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=i//jDsTDtD6aipHKSJbo3y9InLD9ekcY4Q8bRAz7D0I=; b=UxR/6Nn0FTIvFBmN/WR5rDLgqG
	bK7EuLiwvjAhrhGfaHvK2dV/lkNKsAkapW8W1OEqh1JlbcGjHFSsjgDiYWDgHvycYOH57DUlDcFq7
	hWEzCg+2teK1KtVl2kRc90C3JrX3rcF5w+64tHp2pZYP2mwPIyx2HJKAcVUWaleIgq+9oods3mysP
	2KRTkgK4mAr3DUjDgSGiFmgmhN0odfpVtfZQ1UzBDHba8yLtP41UEW4gYXjkbmi9zJSsjk6ZYC3XR
	Mhn3b6km9wrrImVXD3AbimwPmacQUqZIFugZN49KuPiBoI7tGX7Jv/5SoExikNv/imY4ofjH00QP3
	OFStyYBQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rhsN2-00000000bK6-1WtQ;
	Wed, 06 Mar 2024 14:35:48 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rhsMw-00000000bHY-2XQy
	for linux-nvme@lists.infradead.org;
	Wed, 06 Mar 2024 14:35:46 +0000
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 46F616B282;
	Wed,  6 Mar 2024 14:35:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709735740; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=i//jDsTDtD6aipHKSJbo3y9InLD9ekcY4Q8bRAz7D0I=;
	b=m4u3k3yne6nn9gziGmKyJC1bqD6h90BtyE0ne1tka1Dq4kOzVEs0QdrQzXeu8+E1p9JDmg
	WrBGZQ0TIHy15Tw51d+FmeJHt+l31wLyS7hNDRDUY7nq1OX92qpVmtc9PNAh7qDhERhBE+
	T4PCyFEoA0O8Ofm9EqCoyfWdCEJbV1w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709735740;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=i//jDsTDtD6aipHKSJbo3y9InLD9ekcY4Q8bRAz7D0I=;
	b=Q+rqqaEfdxrDJlwELieO87zVpiqsYl9MeocJVZaH1CNEP1Qd9PuVDHbcMrZy6guBliGcFw
	ppsPPBudgOFH/YCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709735740; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=i//jDsTDtD6aipHKSJbo3y9InLD9ekcY4Q8bRAz7D0I=;
	b=m4u3k3yne6nn9gziGmKyJC1bqD6h90BtyE0ne1tka1Dq4kOzVEs0QdrQzXeu8+E1p9JDmg
	WrBGZQ0TIHy15Tw51d+FmeJHt+l31wLyS7hNDRDUY7nq1OX92qpVmtc9PNAh7qDhERhBE+
	T4PCyFEoA0O8Ofm9EqCoyfWdCEJbV1w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709735740;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=i//jDsTDtD6aipHKSJbo3y9InLD9ekcY4Q8bRAz7D0I=;
	b=Q+rqqaEfdxrDJlwELieO87zVpiqsYl9MeocJVZaH1CNEP1Qd9PuVDHbcMrZy6guBliGcFw
	ppsPPBudgOFH/YCQ==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 350E01377D;
	Wed,  6 Mar 2024 14:35:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id 7n2DCzx/6GVEbQAAn2gu4w
	(envelope-from <dwagner@suse.de>); Wed, 06 Mar 2024 14:35:40 +0000
Date: Wed, 6 Mar 2024 15:35:39 +0100
From: Daniel Wagner <dwagner@suse.de>
To: Keith Busch <kbusch@kernel.org>
Cc: James Smart <james.smart@broadcom.com>, Christoph Hellwig <hch@lst.de>, 
	Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/5] nvme-fc: fix blktests nvme/041
Message-ID: <nyqtklcyo4ujtea27sawcktbodbbfkmxvmc5oo3igokp2lvwtf@fnwdppuzruog>
References: <20240221132404.6311-1-dwagner@suse.de>
 <ZdY7HavMstT3KbHe@kbusch-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZdY7HavMstT3KbHe@kbusch-mbp>
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=m4u3k3yn;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=Q+rqqaEf
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.11 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[7];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.10)[65.09%]
X-Rspamd-Queue-Id: 46F616B282
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240306_063542_896826_2C1D65DB 
X-CRM114-Status: GOOD (  22.59  )
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

On Wed, Feb 21, 2024 at 11:04:13AM -0700, Keith Busch wrote:
> On Wed, Feb 21, 2024 at 02:23:59PM +0100, Daniel Wagner wrote:
> > As suggested by Keith I've merged the new flag for nvme-fabrics with the last
> > patch. I also added some information why nvme-fc is handling the initial connect
> > attempt differently as requested by Christoph.
> > 
> > The new flag is called connect_async and the default is false/0. I've tested
> > with a patched nvme-cli/libnvme version and all looks good. When this series is
> > accepted I'll update nvme-cli/libnvme accordingly. Note, that even with an older
> > nvme-cli the blktests (especially nvme/041) will pass with a newer kernel.
> > 
> > (nvme/048 is still fails but this is a different problem. On my TODO list)
> 
> Series looks good to me. Sounds like it's not fixing any regressions, so
> I think this goes to the 6.9 branch. I'll wait till end of week for any
> other feedback before pushing anything out.

The second patch should be dropped in this series and replaced with the
patches from Hannes '[PATCH 0/4] nvme: fixes for authentication errors'

https://lore.kernel.org/linux-nvme/20240301112823.132570-1-hare@kernel.org/

Should I send out new version or do you take it from here?

