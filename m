Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB35EC27C79
	for <linux-nvme@archiver.kernel.org>; Thu, 20 Jun 2024 06:55:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cJzlk15XpWs5bLsVN7LwrgIQ4TrmQWUdbdkdZI1/c8Y=; b=KX8rs7GKKfm20P4nD908IPkSfZ
	27D0vYsq9+b0rrKUC2nNBilIvrNPlg7Py5qXDapbjYL175wKQjbPb/ih9w/zaHL9ljIad5d57g5dg
	JwhnPRpC+enVu1ZSs1WiETF2HlYhYWLiJdh8M86IV7y0Ip7OXny2dAvh7gUTCQsjvMlPhSvLQxTH/
	oJHv412c7cmWFq6eXzEFkcsiRmEocH363CofdC8/hnvQQ1ynQopiWSUoSqoyC0feLMDLYT4FZuACs
	+p537CEVQE2iaJzZIVsvrShon/RrurAEKYYRAX4HxwRwf6C5xdeqz4fo6+l9efUi5ONG/QEcNOAAb
	PLIjaKeA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sKBho-00000003sRl-0adc;
	Thu, 20 Jun 2024 06:55:36 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sKBhi-00000003sQC-3iOP
	for linux-nvme@lists.infradead.org;
	Thu, 20 Jun 2024 06:55:34 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 64B1221A93;
	Thu, 20 Jun 2024 06:55:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1718866529; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cJzlk15XpWs5bLsVN7LwrgIQ4TrmQWUdbdkdZI1/c8Y=;
	b=ketcq9PlipNGFh2ETf6GCaYNQDQyyq6a7UAh4qmsTYY2wx9X/EB22SF7Flw1Hz0FaaOnor
	7vBun0eIipz3mMI/pmOb2QryxUqOec4y1ky7PTb8evBvh0bGMIswhGnuT4RvpoA9sdKtU9
	CtFGaksc5AC2qdpoNrPYDpMQmkNlV+c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1718866529;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cJzlk15XpWs5bLsVN7LwrgIQ4TrmQWUdbdkdZI1/c8Y=;
	b=eiU4Wjooj8pGRSET+FvPBMHbKqGGRJWAQLRNKsVP+ucsJS4mAhyoU2DtP0wyutT+WU5RGs
	RRvKyxTOIuGk8pAQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1718866529; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cJzlk15XpWs5bLsVN7LwrgIQ4TrmQWUdbdkdZI1/c8Y=;
	b=ketcq9PlipNGFh2ETf6GCaYNQDQyyq6a7UAh4qmsTYY2wx9X/EB22SF7Flw1Hz0FaaOnor
	7vBun0eIipz3mMI/pmOb2QryxUqOec4y1ky7PTb8evBvh0bGMIswhGnuT4RvpoA9sdKtU9
	CtFGaksc5AC2qdpoNrPYDpMQmkNlV+c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1718866529;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cJzlk15XpWs5bLsVN7LwrgIQ4TrmQWUdbdkdZI1/c8Y=;
	b=eiU4Wjooj8pGRSET+FvPBMHbKqGGRJWAQLRNKsVP+ucsJS4mAhyoU2DtP0wyutT+WU5RGs
	RRvKyxTOIuGk8pAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4351F1369F;
	Thu, 20 Jun 2024 06:55:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id yC8eEGHSc2bfQwAAD6G6ig
	(envelope-from <dwagner@suse.de>); Thu, 20 Jun 2024 06:55:29 +0000
Date: Thu, 20 Jun 2024 08:55:28 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: shinichiro.kawasaki@wdc.com, chaitanyak@nvidia.com, kbusch@kernel.org, 
	sagi@grimberg.me, hch@lst.de, linux-nvme@lists.infradead.org, 
	linux-block@vger.kernel.org, venkat88@linux.vnet.ibm.com, sachinp@linux.vnet.ibm.com, 
	gjoyce@linux.ibm.com
Subject: Re: [PATCHv4 blktests] nvme: add test for creating/deleting file-ns
Message-ID: <iq3w7dbe5bydidn4omoxh7o6vew6w37ovybu67xzvja3kojcp7@hghcwi5egngh>
References: <20240619172556.2968660-1-nilay@linux.ibm.com>
 <rxeyn6susgjlguqg3jk7ntthjvhn6gt3meu4dcb5kchynz3b2e@uznnvlner6ri>
 <ec685e52-0ea9-4928-8b96-4ba503e8664b@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ec685e52-0ea9-4928-8b96-4ba503e8664b@linux.ibm.com>
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240619_235531_103860_6801DF54 
X-CRM114-Status: GOOD (  15.33  )
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

On Thu, Jun 20, 2024 at 12:10:32PM GMT, Nilay Shroff wrote:
> 
> 
> On 6/20/24 12:05, Daniel Wagner wrote:
> > On Wed, Jun 19, 2024 at 10:55:02PM GMT, Nilay Shroff wrote:
> >> +		truncate -s "${NVME_IMG_SIZE}" "$(_nvme_def_file_path).$i"
> >> +		uuid="$(uuidgen -r)"
> > 
> > This adds a new dependency on an external tool. It should be mentioned
> > in the README and added to the list of tools to check for:
> > _check_dependencies(). Alternatively you could skip the test if the tool
> > is not available. Anyway the rest looks good.
> > 
> The "uuidgen" is part of util-linux package and I saw that it's already mentioned
> as one of the required packages for blktest: https://github.com/osandov/blktests

Ah, I just grepped for uuidgen and there is no other user. So all is good.

