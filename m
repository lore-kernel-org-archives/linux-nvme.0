Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8372C27C79
	for <linux-nvme@archiver.kernel.org>; Thu, 20 Jun 2024 06:53:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=W6O26vnPfvoWcOupq7pR2I5YGCtg/iI6owoc4tOPySQ=; b=0LColtBFXDqoMxhwPLVvq5IVv6
	NLEP6JAqBaZXJeNIJrn27d7OIFJZGu7jvUOzFjrBJx43QRYpf1GDJ5o1lRyuT/zcSjzOAQe+vsVmG
	eoEccZQB+IoSFlixFfVOTdHJ3gpjk6ClR8im5AIWtbq+DKy61y/7h0bPRgNSWkD6gFvO5SvoapWsc
	6hTRd6DSVjvp9/6SJDDPDg5UwTdXlkcBClRQCTtzT6StUzN7PfG4MTDEIi6/3Yt9p2+20bN3Uwk2+
	Wt7IjgiDYM98iSxA32Rz9JfjLShVNUgiaeqCR9sfn6uWxz/eStovc84mhHkC1siDr9Ff3czXyi/9x
	sOh5awsA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sKBfT-00000003rwh-1xZe;
	Thu, 20 Jun 2024 06:53:11 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sKBfN-00000003rua-0LIR
	for linux-nvme@lists.infradead.org;
	Thu, 20 Jun 2024 06:53:09 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 4D4211F795;
	Thu, 20 Jun 2024 06:53:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1718866383; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=W6O26vnPfvoWcOupq7pR2I5YGCtg/iI6owoc4tOPySQ=;
	b=IN7/AnlfwoClkOcAW98DTAEqTv5kqa790xrwmGusPgggaAG8eVfTL2FZVnAOEoRu25Tce+
	SZ0fxWkFMxw3T8oPoDe8SMkJH8yQ7SIQYwzMRdbJkNZ2rslk7txlUfo/g4G+7xZdWcabUk
	6xDJeg73IjUHQGYFp0kLmBDoYkX3u3s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1718866383;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=W6O26vnPfvoWcOupq7pR2I5YGCtg/iI6owoc4tOPySQ=;
	b=R2fqXy+XqZw2oE952chSeCjr0xCK7R+ZNQx1P6go2l7aYN8fijUBaHlIbGigkrSLzCwkn4
	D0oODFG3kTj6KTCQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="IN7/Anlf";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=R2fqXy+X
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1718866383; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=W6O26vnPfvoWcOupq7pR2I5YGCtg/iI6owoc4tOPySQ=;
	b=IN7/AnlfwoClkOcAW98DTAEqTv5kqa790xrwmGusPgggaAG8eVfTL2FZVnAOEoRu25Tce+
	SZ0fxWkFMxw3T8oPoDe8SMkJH8yQ7SIQYwzMRdbJkNZ2rslk7txlUfo/g4G+7xZdWcabUk
	6xDJeg73IjUHQGYFp0kLmBDoYkX3u3s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1718866383;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=W6O26vnPfvoWcOupq7pR2I5YGCtg/iI6owoc4tOPySQ=;
	b=R2fqXy+XqZw2oE952chSeCjr0xCK7R+ZNQx1P6go2l7aYN8fijUBaHlIbGigkrSLzCwkn4
	D0oODFG3kTj6KTCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3CEC51369F;
	Thu, 20 Jun 2024 06:53:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id NjvyDc/Rc2YnQwAAD6G6ig
	(envelope-from <dwagner@suse.de>); Thu, 20 Jun 2024 06:53:03 +0000
Date: Thu, 20 Jun 2024 08:52:58 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, 
	Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
	Gregory Joyce <gjoyce@ibm.com>, Srimannarayana Murthy Maram <msmurthy@imap.linux.ibm.com>, 
	"axboe@fb.com" <axboe@fb.com>
Subject: Re: nvme-cli : attaching a namespace to an undiscovered nvme
 controller on multi-controller nvme disk
Message-ID: <wyl5mqslq24pjjprd44ezt2pwhdbsj5gfwcfzvwrqoynwqokzv@25rthmjworl5>
References: <f1a7c1e2-3203-4b7a-a922-82fa812455bd@linux.ibm.com>
 <yhvmfctxhfzrcsq4lx6nr3f5n67kegrixtthh3pals7vn5qr26@k5as5whcdrum>
 <dfb2488a-6275-4822-94ec-07a575cbf09c@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dfb2488a-6275-4822-94ec-07a575cbf09c@linux.ibm.com>
X-Spamd-Result: default: False [-6.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 4D4211F795
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240619_235305_511182_A7397BE5 
X-CRM114-Status: GOOD (  30.12  )
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

On Tue, May 07, 2024 at 05:14:40PM GMT, Nilay Shroff wrote:
> I think the information which we need to contain this issue is already
> available through sysfs. If we scan nvme topology then we could find 
> the controller id assigned to each controller under each nvme subsystem.
> We can then leverage this information to figure out whether each controller 
> id specified in the attach-ns command is valid or not. So essentially we 
> match controller id specified in attach-ns command against the controller id 
> learnt through scanning the topology. If we find that any discrepancy then we
> can show the WARNING to the user. I have worked out a patch using this method. 
> I have attached the patch below for suggestion/feedback.

So this is just about issuing a warning. That's fine. I thought you want
to do some more 'difficult' stuff.

> diff --git a/nvme.c b/nvme.c
> index c1d4352a..533cc390 100644
> --- a/nvme.c
> +++ b/nvme.c
> @@ -2784,6 +2784,23 @@ static int delete_ns(int argc, char **argv, struct command *cmd, struct plugin *
>  	return err;
>  }
>  
> +static bool nvme_match_subsys_device_filter(nvme_subsystem_t s, nvme_ctrl_t c,
> +		   nvme_ns_t ns, void *f_arg)
> +{
> +	nvme_ctrl_t _c;
> +	const char *devname = (const char *)f_arg;
> +
> +	if (s) {

use the early return pattern to avoid long indents, e.g.

    if (!s)
        return false;

> +		nvme_subsystem_for_each_ctrl(s, _c) {
> +			if (!strcmp(devname, nvme_ctrl_get_name(_c)))
> +				return true;
> +		}
> +		return false;
> +	}
> +
> +	return true;
> +}
> +
>  static int nvme_attach_ns(int argc, char **argv, int attach, const char *desc, struct command *cmd)
>  {
>  	_cleanup_free_ struct nvme_ctrl_list *cntlist = NULL;
> @@ -2839,12 +2856,68 @@ static int nvme_attach_ns(int argc, char **argv, int attach, const char *desc, s
>  
>  	nvme_init_ctrl_list(cntlist, num, ctrlist);
>  
> -	if (attach)
> +	if (attach) {
> +		const char *cntlid;
> +		int __cntlid;
> +		char *p;
> +		nvme_host_t h;
> +		nvme_subsystem_t s;
> +		nvme_ctrl_t c;
> +		nvme_root_t r = NULL;
> +		int matched = 0;
> +		nvme_scan_filter_t filter = nvme_match_subsys_device_filter;
> +
> +		r = nvme_create_root(stderr, log_level);
> +		if (!r) {
> +			nvme_show_error("Failed to create topology root: %s",
> +					nvme_strerror(errno));
> +			return -errno;
> +		}
> +
> +		err = nvme_scan_topology(r, filter, (void *)dev->name);
> +		if (err < 0) {
> +			if (errno != ENOENT)
> +				nvme_show_error("Failed to scan topology: %s",
> +						nvme_strerror(errno));
> +			nvme_free_tree(r);
> +			return err;
> +		}
> +		nvme_for_each_host(r, h) {
> +			nvme_for_each_subsystem(h, s) {
> +				nvme_subsystem_for_each_ctrl(s, c) {
> +					cntlid = nvme_ctrl_get_cntlid(c);
> +					errno = 0;
> +					__cntlid = strtoul(cntlid, &p, 0);
> +					if (errno || *p != 0)
> +						continue;
> +					for (i = 0; i < num; i++) {
> +						if (__cntlid == list[i])
> +							matched++;
> +					}
> +				}
> +			}
> +		}
> +
> +		nvme_free_tree(r);
> +
> +		if (matched != num) {

Wouldn't this check also trigger when the user wants to attach to the
discovered controller?

I would also suggest to move this check into a helper function in order
to keep this function a bit more readable.

> +			fprintf(stderr,
> +				"You are about to attach namespace 0x%x to an undiscovered nvme controller.\n",
> +				cfg.namespace_id);
> +			fprintf(stderr,
> +				"WARNING: Attaching nampespace to undiscovered nvme controller may have undesired side effect!\n"
> +				"You may not be able to perform any IO to such namespace.\n"
> +				"You have 10 seconds to press Ctrl-C to cancel this operation.\n\n");
> +			sleep(10);
> +			fprintf(stderr, "Sending attach-ns operation ...\n");
> +		}
> +
>  		err = nvme_cli_ns_attach_ctrls(dev, cfg.namespace_id,
>  					       cntlist);
> -	else
> +	} else {
>  		err = nvme_cli_ns_detach_ctrls(dev, cfg.namespace_id,
>  					       cntlist);
> +	}
>  
>  	if (!err)
>  		printf("%s: Success, nsid:%d\n", cmd->name, cfg.namespace_id);
> 
> Thanks,
> --Nilay
> 

