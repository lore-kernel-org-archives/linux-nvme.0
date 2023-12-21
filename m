Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72E46C35274
	for <linux-nvme@archiver.kernel.org>; Thu, 21 Dec 2023 09:17:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=afsZBjEJLNrRami7LX1LeXszkJWNZ3H/aGbmJJOwZlM=; b=N8D1pwGIFaKUkdBtcj5hz0Z95F
	Bg025D2dd2TGdSGStKu3XyG94eY9PFXUIop/7+1hsJCRPFizmoMPD++aXbuSpvArpjMgEkTHYzaft
	CXrEBhAxKdebpNgS6hTKNPhm+/xPm3OrWsNAEirIutlOYdDz05rKsy/ViaCHPHgXjsQzLUkWHw25T
	OLIIw9yftQd3f6IEhb/gonNGwi90J5eHR6sFy7OuXI23Inpi4/SQp1PkKSCjOLdZne9cyzHWWqi9c
	GSl1Pw7vRu6RVjJnUJ6krM+aFgF2fLgtoU2nFfbaXbfQLw0W15y3VS8ZGcoSpKNI8DD6eLhZokG6z
	U7D7Ijvg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rGFBR-002Dhh-18;
	Thu, 21 Dec 2023 09:17:37 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rGFBO-002Des-0m
	for linux-nvme@lists.infradead.org;
	Thu, 21 Dec 2023 09:17:35 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id F3BAF1FB5E;
	Thu, 21 Dec 2023 09:17:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1703150250; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=afsZBjEJLNrRami7LX1LeXszkJWNZ3H/aGbmJJOwZlM=;
	b=ZgGBLaUTZ35sdBmN9jxBqi+ypLe/Y7Lj8/0MAODO3Ue3wxzDDLga38e2V857u71DgEbbC+
	V0HKyRC976bzKBJ3Ko00HyeHGvpXuw/7eNmYo2LkFwAIbc8UanIrpeLzUMIxjKnhqOv6Q1
	suWc+Z2QybrJtPjj2K32HWBhCC93X5w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1703150250;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=afsZBjEJLNrRami7LX1LeXszkJWNZ3H/aGbmJJOwZlM=;
	b=Rly12+U8wxzKyL98Ki48+s5PiiXsqV0wtep7Xwf7FBFlJmQs6S0pxFhMvJCn/7JSAm6uNN
	fXaed7EDXbtES/CA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1703150250; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=afsZBjEJLNrRami7LX1LeXszkJWNZ3H/aGbmJJOwZlM=;
	b=ZgGBLaUTZ35sdBmN9jxBqi+ypLe/Y7Lj8/0MAODO3Ue3wxzDDLga38e2V857u71DgEbbC+
	V0HKyRC976bzKBJ3Ko00HyeHGvpXuw/7eNmYo2LkFwAIbc8UanIrpeLzUMIxjKnhqOv6Q1
	suWc+Z2QybrJtPjj2K32HWBhCC93X5w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1703150250;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=afsZBjEJLNrRami7LX1LeXszkJWNZ3H/aGbmJJOwZlM=;
	b=Rly12+U8wxzKyL98Ki48+s5PiiXsqV0wtep7Xwf7FBFlJmQs6S0pxFhMvJCn/7JSAm6uNN
	fXaed7EDXbtES/CA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DEEA713725;
	Thu, 21 Dec 2023 09:17:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Hmn+NKkChGX0LgAAD6G6ig
	(envelope-from <dwagner@suse.de>); Thu, 21 Dec 2023 09:17:29 +0000
Date: Thu, 21 Dec 2023 10:15:15 +0100
From: Daniel Wagner <dwagner@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>, 
	James Smart <james.smart@broadcom.com>, Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH v3 08/16] nvmet-fc: untangle cross refcounting objects
Message-ID: <l3etc7ia7mx7fc6ko764amf56xrink2vyv3kdirzcuzwfls2nz@wy66e6t4oxbl>
References: <20231218153105.12717-1-dwagner@suse.de>
 <20231218153105.12717-9-dwagner@suse.de>
 <20231219051648.GA32634@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231219051648.GA32634@lst.de>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-0.89 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_SEVEN(0.00)[7];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.09)[64.28%]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231221_011734_456011_74802467 
X-CRM114-Status: GOOD (  20.87  )
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

On Tue, Dec 19, 2023 at 06:16:48AM +0100, Christoph Hellwig wrote:
> On Mon, Dec 18, 2023 at 04:30:56PM +0100, Daniel Wagner wrote:
> > The live time of the queues are strictly bound to the lifetime of an
> 
> > +	struct nvmet_fc_tgt_queue	*_queues[NVMET_NR_QUEUES + 1];
> >  	struct nvmet_fc_tgt_queue __rcu	*queues[NVMET_NR_QUEUES + 1];
> 
> For magic prefixes we use __, not _ in Linux.  But having two arrays
> of queues right next to each other, once with rcu annotation and one
> not rings a bit far warning bell to me.  Why do we have both?  When
> are we supposed to use either?  Why is FC different from rest?

This is my attempt to solve the problem that after NULLing the rcu
pointer and wait for an RCU graceperiod I still need to cleanup the
queues. Thus I need to keep hold on the queue pointers a bit longer.
Indeed not so elegant.

I'm sure there is a better way to do it, I just didn't figure it out
when I wrote this part. Any tips are highly welcomed how to solve this
puzzle.

> I really don't have any good answers as I don't know the code in the
> FC transport very well, but I think this needs more work.

Indeed, blktests still is able to run into a hanger. So not all problems
are sovled but getting closer.

