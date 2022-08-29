Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64910ECAAD2
	for <linux-nvme@archiver.kernel.org>; Mon, 29 Aug 2022 07:57:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=W4J9Zslbyv4wMecZiJfmVaUUb7CJNNVK/fvG4dBa2Do=; b=DaBLnJtvdmEWWh2GOu7O02l6ig
	WHTVnWZKXCYVQ8wPra5aaxZjzdkzgAsgicDs+Sg33uj9+OKzDzC4igrXschr909z96ZPqWcfnXIJh
	gbwHGSg1axlg+nNhfwIb61A9vRvu6Tu+n6WrX7CwBO3kecpcieRx6PVTo96pXif7W3I+Pg1iy+00s
	Bar8jG8goaYSiI8PvibV8noBDFQ1QbboknvxwDppq/xzs9VqfTMLXsFoRCdYOkoViTL1zKwlbFOnd
	R6H1bh7yn5vDiehBxEawmUYcaPFV+/ep/HMzVaVwCVVmf/8b6ggZxIHqpkmPowQEmELppNTEGGUh6
	8SPl8JAQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oSZeI-005uBI-F3; Mon, 29 Aug 2022 07:57:34 +0000
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oSZeE-005u8A-Ns
	for linux-nvme@lists.infradead.org; Mon, 29 Aug 2022 07:57:33 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E861D1F8ED;
	Mon, 29 Aug 2022 07:57:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1661759847; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=W4J9Zslbyv4wMecZiJfmVaUUb7CJNNVK/fvG4dBa2Do=;
	b=iP7iR8QZg3eN6fVNwbGJuwRzCQlWejOBMYn+5bIJuj1xIpT8EWNYSkXPb88iaJwoB2ujLo
	np4rmZB/JVi7CQJCQO9ciPhUsGgY7J1kkxcedGQtroFghZmKW74C2FgxEHC2++f9PyVrLZ
	cavtxRPnM+WYCnOF3RzRrIDveEEOq/Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1661759847;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=W4J9Zslbyv4wMecZiJfmVaUUb7CJNNVK/fvG4dBa2Do=;
	b=Z2vcppmYFKf9Kh2uqSNzleYYBqkWjmEhC/pE8KC07hWoexuJ6fULYwfVIOXuTHQ0TQY+XX
	+q4ODzIXk+VYE+DQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DBE89133A6;
	Mon, 29 Aug 2022 07:57:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id QG+kNWdxDGMRfAAAMHmgww
	(envelope-from <dwagner@suse.de>); Mon, 29 Aug 2022 07:57:27 +0000
Date: Mon, 29 Aug 2022 09:57:27 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Hannes Reinecke <hare@suse.de>
Cc: linux-nvme@lists.infradead.org, Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH v2 1/3] nvmet: Expose max queues to sysfs
Message-ID: <20220829075727.d7rocu4teq3hxwas@carbon.lan>
References: <20220823074451.12170-1-dwagner@suse.de>
 <20220823074451.12170-2-dwagner@suse.de>
 <ea632332-d26b-6d1f-b45d-9971902a2ebb@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ea632332-d26b-6d1f-b45d-9971902a2ebb@suse.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220829_005731_305749_A21667C8 
X-CRM114-Status: GOOD (  14.12  )
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

> > +static ssize_t nvmet_subsys_attr_qid_max_store(struct config_item *item,
> > +					       const char *page, size_t cnt)
> > +{
> > +	u16 qid_max;
> > +
> > +	if (sscanf(page, "%hu\n", &qid_max) != 1)
> > +		return -EINVAL;
> > +
> > +	if (qid_max == 0)
> > +		return -EINVAL;
> > +
> > +	down_write(&nvmet_config_sem);
> > +	to_subsys(item)->max_qid = qid_max;
> > +	up_write(&nvmet_config_sem);
> 
> I would have expected this to trigger a reconnect; as it stands it requires
> the user to explicitly do a reconnect via nvme-cli, and there's a fair
> chance the number of queues will be specified there.
> Hmm?

Good point. Currently we do not allow to change the attributes when the
port is enabled. I think we should the same here because we currently
don't have an interface for triggering a reconnect without going through
the fatal error handler.

