Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CB0BECAAD5
	for <linux-nvme@archiver.kernel.org>; Mon,  5 Sep 2022 12:10:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bCD3Gcca9PyBhn/bMrZc+GmkBfLrPHzEyfLCIGCUgZ4=; b=RQxLYsm96MasL3UjIDu4q2aIby
	dJzMNWQUTt7pK2ItnqoNodTkireJaUB5NymIkuUWQ2jQlwcuFtQF5Y1gHr2yNqFA05H84ElD99gcp
	2MUI77fPECXm4IVfyhPGhrP1maSF/2OPCQb+gra/0BHsfBSKLBH6XXoBVFCJsf/URfG1E6x/4Jgkp
	BnHA6zWNdSG4R/9wWvlcc4kTt6hfhiqKftBr5WYIyzIv+ARQ1+rLJO7cXxnZtiflPDqGvf5c2I9DC
	mC69HefTw3rpYP2M9PLP2SCwlrlTRE5aPoFYHe7LqGkRFcWmqMrdWAn/UovwoZbvLou9g0ZSZ/6Kd
	Xpi8o3Pg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oVAw0-001sfD-Tt; Mon, 05 Sep 2022 12:10:36 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oV9J5-000D1a-Rd
	for linux-nvme@lists.infradead.org; Mon, 05 Sep 2022 10:26:28 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 618BD5FBFD;
	Mon,  5 Sep 2022 10:26:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1662373573; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bCD3Gcca9PyBhn/bMrZc+GmkBfLrPHzEyfLCIGCUgZ4=;
	b=JTatifeDXweBm1CGrfRfcowwo9NDmbNmRfzYnKUmz5VQdPqzu5DklDURUMWm2IMa5CJF8n
	4KUqyn9rFRLb9d/kd+AIyxRIRbobAeiHKPxWfKjJDrxMDXX04eJJrBZ5DL4DKVEZxgYpVp
	OTRzungCyKY3T/OeL4QCisiOr/Etwgs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1662373573;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bCD3Gcca9PyBhn/bMrZc+GmkBfLrPHzEyfLCIGCUgZ4=;
	b=FxGc6+x0bwnAZQhqsjtSDA8La6mWvdGjQo54sz75rUh3tbErM1vmIVRKkut4Yv6Kp+dPkI
	MSE9JZSbQHhAoNDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5428E13A66;
	Mon,  5 Sep 2022 10:26:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id WyGEFMXOFWOQRQAAMHmgww
	(envelope-from <dwagner@suse.de>); Mon, 05 Sep 2022 10:26:13 +0000
Date: Mon, 5 Sep 2022 12:26:12 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org
Subject: Re: crash at nvme_tcp_init_iter with header digest enabled
Message-ID: <20220905102612.xur4ul2bhade6ccv@carbon.lan>
References: <20220819075117.rzvbecyvh2wuwokj@carbon.lan>
 <9a0bc2f1-b1d0-a34d-2e9f-926da3fc2ab4@grimberg.me>
 <2913fc75-49a6-346e-136c-31b87d6487fc@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2913fc75-49a6-346e-136c-31b87d6487fc@grimberg.me>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220905_032620_927117_80ECB5E0 
X-CRM114-Status: GOOD (  13.40  )
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

On Mon, Sep 05, 2022 at 12:46:40PM +0300, Sagi Grimberg wrote:
> > diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> > index e82dcfcda29b..3e3ebde4eff5 100644
> > --- a/drivers/nvme/host/tcp.c
> > +++ b/drivers/nvme/host/tcp.c
> > @@ -1229,7 +1229,7 @@ static void nvme_tcp_io_work(struct work_struct *w)
> >                  else if (unlikely(result < 0))
> >                          return;
> > 
> > -               if (!pending)
> > +               if (!pending || !queue->rd_enabled)
> >                          return;
> > 
> >          } while (!time_after(jiffies, deadline)); /* quota is exhausted */
> > -- 
> 
> Daniel, any input here?

I haven't heard anything from our customer yet. Let me ping them again.

