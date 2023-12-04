Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9A3BC4167B
	for <linux-nvme@archiver.kernel.org>; Mon,  4 Dec 2023 10:56:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=iKuxUm4EpqkG8l1uBiyIY5KmFP9UqU1KqJjWbZ5s9PU=; b=Ne02beQKDASdPQ0ljyVv24INgI
	nZlZlASLELAybcRwzG0YbY02NXIfLu9SZSFpFpzAlXeFqEbu7kQx8zcgZHVj25m8LoByG+nv0kChW
	PVqxm0rlmsohI3YtiAjUPWQVxXccxz/1zwX4ZS1FRz/PFVaj0CNxchD7jpJjFsiO988KV7TZ5mAeX
	npuWEHCkEK6tdaJ7rTvgCGf5TZPSYRRNZne6nlg6j78RUNKMmBRJZOSo2648kZIEaKMkOHCigFjFn
	eAf8KROsFOlFf64eh1Nx61x8ThUmtIr6C7eNsEtiQzumCukh5Rz3B5Tay+0r1TjsevdK2tLG7wIc+
	djUDoHhA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rA6cp-003bSq-2j;
	Mon, 04 Dec 2023 10:56:31 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rA6cS-003bE4-2q
	for linux-nvme@lists.infradead.org;
	Mon, 04 Dec 2023 10:56:30 +0000
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9F75722078;
	Mon,  4 Dec 2023 10:56:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1701687366; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iKuxUm4EpqkG8l1uBiyIY5KmFP9UqU1KqJjWbZ5s9PU=;
	b=ggMcWY4xiP4cbTQR6eX9yvQ38Vb80UnvkiqWuIDcorOddKQTdoPsbddAjoBO6b07JCeXwc
	sDrJXq1POkgPKBOTP3uYe9uurILUKmgm3ohE0TeJkrZrW+AVZD7yMVMum4ih7+meVKNWMw
	tjd5PoHxZBxR7ek3ANLfUSi/UOaJJdA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1701687366;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iKuxUm4EpqkG8l1uBiyIY5KmFP9UqU1KqJjWbZ5s9PU=;
	b=bV3HaQkbbJFTQPHg/xu7uzhYVvCi9eSFnZM+bBessVGQatSzYoTGWcW9OJzsQ529ICKFBv
	hzVogOWoiT1fHFAQ==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 8B79813588;
	Mon,  4 Dec 2023 10:56:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id BuCaIEawbWWASQAAn2gu4w
	(envelope-from <dwagner@suse.de>); Mon, 04 Dec 2023 10:56:06 +0000
Date: Mon, 4 Dec 2023 11:56:05 +0100
From: Daniel Wagner <dwagner@suse.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@suse.de>
Subject: Re: [RFC v2 2/3] nvme: move ns id info to struct nvme_ns_head
Message-ID: <v7ixirgnem6tlk7zcirhkazkrswx26yfuq7xxwxnvicyueqvn4@ubhf4axlztc5>
References: <20231201092735.28592-1-dwagner@suse.de>
 <20231201092735.28592-3-dwagner@suse.de>
 <24805050-82d3-4704-98ff-1909213abbbc@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <24805050-82d3-4704-98ff-1909213abbbc@grimberg.me>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-0.79 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 RCPT_COUNT_FIVE(0.00)[6];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.19)[-0.964];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.00)[22.63%]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231204_025609_205898_E01ECA05 
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

On Mon, Dec 04, 2023 at 10:30:52AM +0200, Sagi Grimberg wrote:
> > -bool nvme_mpath_clear_current_path(struct nvme_ns *ns)
> > +bool nvme_mpath_clear_current_path(struct nvme_ns_head *head)
> >   {
> > -	struct nvme_ns_head *head = ns->head;
> >   	bool changed = false;
> >   	int node;
> > @@ -181,7 +183,7 @@ bool nvme_mpath_clear_current_path(struct nvme_ns *ns)
> >   		goto out;
> >   	for_each_node(node) {
> > -		if (ns == rcu_access_pointer(head->current_path[node])) {
> > +		if (head == rcu_access_pointer(head->current_path[node])->head) {
> >   			rcu_assign_pointer(head->current_path[node], NULL);
> >   			changed = true;
> >   		}
> 
> I'm not sure about this one.
> 
> This is changing the behavior of the function. Previously  it only
> cleared the current_path if it was directed to ns, now it will if the
> current_path has the same head, which is always the case isn't it?
> 
> I'm unsure to why this change is needed?

As Christoph pointed out we really need to check the ns pointer. I tried
to workaound not to use nvme_ctrl_find_ns. Anyway, I'll drop this hunk
here.

Thanks,
Daniel

