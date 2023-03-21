Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18203C74A5B
	for <linux-nvme@archiver.kernel.org>; Tue, 21 Mar 2023 11:06:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IXZSdd0M81z6DpSoHW6swPUfYpmIvvtdDtLIGv22r7U=; b=B8pjJ/wdTq74A4CEHdIK7X3Sw3
	eyLa8B0duigLzKjrrIMOnieVrwm6sWT+Cn1aNWDeV7HRs15w1MVpjaRJZFphNJhiSrek11IpOo827
	d/SI6xjSS9Owks3yBCklYnFsnv64H9FRabl5a14q6zc6bk0yc082DltYSr4fMqbCTN1TLsncL0S8y
	edA95ApNaxufbOzGpXeKVDy+NxRcIDtO+/bZvTX7fe1DahUkRGHEDSEwUP7kQgLGlw0tz3oG1B0Te
	JqS91ThuyTxKfN9bYrLfoHuvpd2oViyj9A85VMtU43/8UAzbpvrDiS5b2zm5xhILHjrHZBKb7EpRP
	rqPB0lBQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1peZpK-00C8Lh-2L;
	Tue, 21 Mar 2023 11:06:50 +0000
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1peZpI-00C8L8-0t
	for linux-nvme@lists.infradead.org;
	Tue, 21 Mar 2023 11:06:49 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 2A0F61FEF2;
	Tue, 21 Mar 2023 11:06:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1679396806; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IXZSdd0M81z6DpSoHW6swPUfYpmIvvtdDtLIGv22r7U=;
	b=RD4zHseKVX256h6i+C5OFKtpeiSiBhLQOatCeeDwU/P74jGOfVCs3TsTyT5qYpOeb/AdHS
	U2Eybo8JK68DP4vx977K3KB11fx065WFM2gjmsf+qZTiEJdHodS3Ae95QdQBTOxLK0Vqzm
	6JZ2XPS8IgOOcxAJw09n9HDlbC7uEsY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1679396806;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IXZSdd0M81z6DpSoHW6swPUfYpmIvvtdDtLIGv22r7U=;
	b=qE/RMSCImtJoouaNT7S2GIHp12eeSKz+NZ5+2FVaYJqZgINZF80hTPf9eSeEIkQTZ41ktv
	dfOKhvsuo7V/K8CA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1D24513451;
	Tue, 21 Mar 2023 11:06:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id V08aB8aPGWTLSgAAMHmgww
	(envelope-from <dwagner@suse.de>); Tue, 21 Mar 2023 11:06:46 +0000
Date: Tue, 21 Mar 2023 12:06:45 +0100
From: Daniel Wagner <dwagner@suse.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Keith Busch <kbusch@kernel.org>,
	"Belanger, Martin" <Martin.Belanger@dell.com>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: nvme-tcp: kernel NULL pointer dereference, address:
 0000000000000034
Message-ID: <20230321110645.ruxzlw5egzikagnw@carbon>
References: <bd0c1ec4-edd2-4225-c4d7-b091bde26494@grimberg.me>
 <20230321082308.n6ed7ieu5jdb2gj4@carbon>
 <20230321084917.s5xqklrttauxilnx@carbon>
 <a3d023ca-ca00-8207-2f89-fad23eddd58a@grimberg.me>
 <20230321090913.gwuvyuw76ha62hgb@carbon>
 <4c4b93b7-891d-cd5f-e4f2-50c242c799ce@grimberg.me>
 <20230321092556.7m3etb25jnd4sfj6@carbon>
 <316be6c1-0d90-0ea8-f9cf-1ec0086877a3@grimberg.me>
 <20230321104009.nltadi6zs6iz66h4@carbon>
 <f2653732-5566-ba2c-1dc5-412b20879ef8@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f2653732-5566-ba2c-1dc5-412b20879ef8@grimberg.me>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230321_040648_480877_A0151B3A 
X-CRM114-Status: GOOD (  18.20  )
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

On Tue, Mar 21, 2023 at 12:53:29PM +0200, Sagi Grimberg wrote:
> 
> > > admin_tagset.nr_maps = 1 (only the default map, no read, no poll)
> > 
> > Indeed, that would be to easy.
> > 
> > I've just triggered a crash where we are passing in a non-null bio. Some
> > more annotation. This time I am printing from blk_rq_is_poll() and
> > we see that that is also the case where we have a valid bio but
> > want to use the poll context:
> 
> That is not a crash, but a WARN stack dump.

Not sure how you get to this conclusion.

> It is still unclear to me
> how exactly you get to poll for a bio-less request.

I don't do anything special here. The only thing which is special is that I am
testing against Linux soft target with Hannes TP8013 patches.

> See my other reply, While I removed the below warning, and allow
> bio-less request polling, I was not able to observe any bio-less
> requests actually being polled.

Unfortunatly, somehow all your inline patches receive my inbox whitespace
damaged. Takes a few minutes to patch it manually. Anyway, with your patch
the crash is gone.

