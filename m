Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2258C54E58
	for <linux-nvme@archiver.kernel.org>; Mon, 25 Mar 2024 19:22:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Tqvm5aVIicouynsquATu6JDPxACGUlNRR5+wdAZdRqo=; b=hcb/9v9WVcdRSP2rxYrGa/xQIC
	A8vLoDkVQn1r+451YlacQozb+qSi9UOMSM0ROwrGzhTkd6XwuxWu0M9ZjrcdvjgRkIGnceCGwrqhw
	IJVRl2Ygu3e0XhyV+VLNvDXACVhYTxjwEVgMOTJc/uXYOascDw744+5XYFgfRiSJfN2u5DaPGrN5Z
	SnGQkb19FgPL7DhwMNSVOyvtUy++59jFdP3cnUA/t5lu68zz12BpLvdBnAi0tSF5LFbkWL1Qonjd6
	MeGGOa4zjHCIm8LF2L9rWxT4iV3MrdEg7S7zeXwvp8ElP+huyqEfd7MBpvnnw7ZE4qXebpUl2K6/C
	96bTyg5w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1roptz-00000001ZZB-0h3C;
	Mon, 25 Mar 2024 19:22:35 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ropts-00000001ZXa-2eiu
	for linux-nvme@lists.infradead.org;
	Mon, 25 Mar 2024 19:22:32 +0000
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 82ABB5CAC4;
	Mon, 25 Mar 2024 19:22:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1711394546; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Tqvm5aVIicouynsquATu6JDPxACGUlNRR5+wdAZdRqo=;
	b=SltEuylIp+RAiWkkNG/qKxFLVJlgQOYR5A/+Pq8RpQIYa8wa/XZyslC7Zwmyp6KkPq+XPh
	4nGCHkM1fc7IhlM1D9fAVLzw0KaXzYuXUb4N+J1WN26e34tBLbIUZPEdzpQ/KAVkc+nZm0
	7ckDGOZxAS3sztiQ/o4U6J8MXEd9awE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1711394546;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Tqvm5aVIicouynsquATu6JDPxACGUlNRR5+wdAZdRqo=;
	b=6h93tnyrOhl956stFMlpLAEZOcqkyrHITx1W9JU5swvrbHHmV5PJ5pOwsu4aUfg8bblgN0
	RjfttBFR/OJlcqBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1711394545; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Tqvm5aVIicouynsquATu6JDPxACGUlNRR5+wdAZdRqo=;
	b=JV7VdBa5wBEH6YspXAG1KkTrFfQ/6CzDFtOEvxP1fFWfiMcOFb3tD4qVQCV5JkQOQ1J8G/
	M1se8cqmPdId++sfSrKpx/+72MceUqNaLTeaQpPAlakIHckr1+C4gn/hYJf6RIZ/ZftoIG
	uI1vThh7/JcXzBAo7VsHnrA2ZYiFQAU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1711394545;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Tqvm5aVIicouynsquATu6JDPxACGUlNRR5+wdAZdRqo=;
	b=ivMcf1mjZu8fe21iT8xbi96bXiCcCr6i0vb8vQAH48GMCVaWm5kYT2MtyuhqlfRupQSERh
	AIX7w6c2Ft7sH4Bw==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 6EC0913A2E;
	Mon, 25 Mar 2024 19:22:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id kH/cGfHOAWZ/aAAAn2gu4w
	(envelope-from <dwagner@suse.de>); Mon, 25 Mar 2024 19:22:25 +0000
Date: Mon, 25 Mar 2024 20:22:24 +0100
From: Daniel Wagner <dwagner@suse.de>
To: Hannes Reinecke <hare@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
	Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org, 
	Redouane BOUFENGHOUR <redouane.boufenghour@shadow.tech>
Subject: Re: [PATCH 1/8] nvmet: add debugfs support
Message-ID: <xoxhdylgcv67l7htus5qrvr7x72otgefp4wo45hkt64k3ruuvg@fqu4ldobv2ib>
References: <20240322070333.3820-1-hare@kernel.org>
 <20240322070333.3820-2-hare@kernel.org>
 <yph2qil3t2wzdq4ogr2jkh7ybckyhapfmwacurixjozmtjhreb@7qdgjt4fgget>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yph2qil3t2wzdq4ogr2jkh7ybckyhapfmwacurixjozmtjhreb@7qdgjt4fgget>
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.01 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 TO_DN_SOME(0.00)[];
	 RCPT_COUNT_FIVE(0.00)[6];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-3.00)[100.00%];
	 ARC_NA(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 FROM_HAS_DN(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[]
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=JV7VdBa5;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=ivMcf1mj
X-Rspamd-Queue-Id: 82ABB5CAC4
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240325_122228_849869_9EBFAABB 
X-CRM114-Status: GOOD (  19.47  )
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

On Mon, Mar 25, 2024 at 07:18:52PM +0100, Daniel Wagner wrote:
> On Fri, Mar 22, 2024 at 08:03:26AM +0100, Hannes Reinecke wrote:
> > +static ssize_t nvmet_ctrl_state_write(struct file *file, const char __user *buf,
> > +				      size_t count, loff_t *ppos)
> > +{
> > +	struct seq_file *m = file->private_data;
> > +	struct nvmet_ctrl *ctrl = m->private;
> > +	char reset[16];
> > +
> > +	if (count >= sizeof(reset))
> > +		return -EINVAL;
> > +	if (copy_from_user(reset, buf, count))
> > +		return -EFAULT;
> > +	if (!memcmp(reset, "fatal", 5))
> > +		nvmet_ctrl_fatal_error(ctrl);
> 
> I'd like to use this also to trigger a reset. This allows to test the
> auth code a bit better, e.g. after changing the ctrl key on the target
> nothing will happen until a reconnect happens. Currently, I have to
> set the max queue count which triggers a reset. Also it would make the
> 'support real hardware' series for blktests why more generic.
> 
> This here should does the trick in my local testing:
> 
> --- a/drivers/nvme/target/debugfs.c
> +++ b/drivers/nvme/target/debugfs.c
> @@ -157,6 +157,8 @@ static ssize_t nvmet_ctrl_state_write(struct file *file, const char __user *buf,
>                 return -EFAULT;
>         if (!memcmp(reset, "fatal", 5))
>                 nvmet_ctrl_fatal_error(ctrl);
> +       else if (!memcmp(reset, "reset", 5))
> +               ctrl->ops->delete_ctrl(ctrl);
>         else
>                 return -EINVAL;
>         return count;
> 

and here the corresponding test extension (nvme/045)

	echo "Renew host key on the controller and force reconnect"

	new_hostkey="$(nvme gen-dhchap-key -n ${def_subsysnqn} 2> /dev/null)"

	_set_nvmet_hostkey "${def_hostnqn}" "${new_hostkey}"

	# Force a reconnect
	nvmedev=$(_find_nvme_dev "${def_subsysnqn}")
	cntlid="$(nvme id-ctrl -o json "/dev/${nvmedev}" | jq .cntlid)"
	echo "reset" > /sys/kernel/debug/nvmet/"${def_subsysnqn}/ctrl${cntlid}"/state
	nvmf_wait_for_ctrl_delete "${nvmedev}"

