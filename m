Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C60D6CAC582
	for <linux-nvme@archiver.kernel.org>; Mon,  8 Sep 2025 17:09:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3wQHCtWVLmJ0a3EcM3urZcDA22B3zVej/psV9vQXpHQ=; b=UKb6a1DuRG6s7E4BIGX6YxBD2N
	7ayvXOnd8Oz7tqXJkdJYbPRMLC+48tkLoIhsbXpakp2E76taVyGltm1o5SnP//+d6rwffTLRij5Oc
	ApxOupON2HegWuZc/q4RFhyYQvdaqsIWGA2zUZTMtlkXcvNfSBx3sZwS4sq6BMdm0c6T0Cw0LQYb9
	xx/bOPkEXdOvSwQwCZj5rzxA+PLeVnyYLkcrExF/x6wvT+qCj+nAGHxQ6ahNE73NY7+8PZgRttxLD
	pW6NevPUx0v4IKpDM9KrgAuqeo4QTVCuFdj1mSb8xKSwxJMkjxjw6/QMrozpXtcA7DleBQCEf+yyF
	m/ZY49xg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uvfMc-000000012Cs-0PzY;
	Mon, 08 Sep 2025 17:09:10 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uvbND-0000000HAkh-0PzY
	for linux-nvme@lists.infradead.org;
	Mon, 08 Sep 2025 12:53:32 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 467FE232F0
	for <linux-nvme@lists.infradead.org>; Mon,  8 Sep 2025 12:53:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1757336009; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3wQHCtWVLmJ0a3EcM3urZcDA22B3zVej/psV9vQXpHQ=;
	b=WDzSCpTIsnnSDlcxiaZkj/Un4Hd9hfkUKLSiN//wfKz7gUoG0GfOKmhIUwdg44HM3DR19m
	F4pFpJTus6Y3LKhPg6NleYJoiH4klwdNG6Df0zeGj7Jh6ZIR/UXS+OnRHgiPbQxz5SgEZh
	pxdwZu/3b2A0YIgZzP0nBFgqhfREcp4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1757336009;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3wQHCtWVLmJ0a3EcM3urZcDA22B3zVej/psV9vQXpHQ=;
	b=bI/5AJqYdVi6C6L/y1u5mFp/lylsTMUSm1bgyjcg7xf7L5ifunFOGzwiokx45bTZG0RINi
	8Hoy2BKByhYIisDw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=WDzSCpTI;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="bI/5AJqY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1757336009; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3wQHCtWVLmJ0a3EcM3urZcDA22B3zVej/psV9vQXpHQ=;
	b=WDzSCpTIsnnSDlcxiaZkj/Un4Hd9hfkUKLSiN//wfKz7gUoG0GfOKmhIUwdg44HM3DR19m
	F4pFpJTus6Y3LKhPg6NleYJoiH4klwdNG6Df0zeGj7Jh6ZIR/UXS+OnRHgiPbQxz5SgEZh
	pxdwZu/3b2A0YIgZzP0nBFgqhfREcp4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1757336009;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3wQHCtWVLmJ0a3EcM3urZcDA22B3zVej/psV9vQXpHQ=;
	b=bI/5AJqYdVi6C6L/y1u5mFp/lylsTMUSm1bgyjcg7xf7L5ifunFOGzwiokx45bTZG0RINi
	8Hoy2BKByhYIisDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2FA5713946
	for <linux-nvme@lists.infradead.org>; Mon,  8 Sep 2025 12:53:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id DW/lCcnRvmgrLAAAD6G6ig
	(envelope-from <hare@suse.de>)
	for <linux-nvme@lists.infradead.org>; Mon, 08 Sep 2025 12:53:29 +0000
Message-ID: <8ca7b858-2ab7-49e1-830d-522947b11b54@suse.de>
Date: Mon, 8 Sep 2025 14:53:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv3 2/4] nvme: extend show-topology command to add support
 for multipath
To: linux-nvme@lists.infradead.org
References: <20250904175654.1183750-1-nilay@linux.ibm.com>
 <20250904175654.1183750-3-nilay@linux.ibm.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20250904175654.1183750-3-nilay@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MID_RHS_MATCH_FROM(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:mid,suse.de:dkim,suse.de:email];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-nvme@lists.infradead.org];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Queue-Id: 467FE232F0
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250908_055331_283583_DBADAB95 
X-CRM114-Status: GOOD (  18.65  )
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

On 9/4/25 19:56, Nilay Shroff wrote:
> This commit enhances the show-topology command by adding support for
> NVMe multipath. With this change, users can now list all paths to a
> namespace from its corresponding head node device. Each NVMe path
> entry then also includes additional details such as ANA state, NUMA
> node, and queue depth, improving visibility into multipath configs.
> This information can be particularly helpful for debugging and
> analyzing NVMe multipath setups.
> 
> To support this functionality, the "--ranking" option of the nvme
> show-topology command has been extended with a new sub-option:
> "multipath".
> 
> Since this enhancement is specific to NVMe multipath, the iopolicy
> configured under each subsystem is now always displayed. Previously,
> iopolicy was shown only with nvme show-topology verbose output, but
> it is now included by default to improve usability and provide better
> context when reviewing multipath configurations via show-topology.
> 
> With this update, users can view the multipath topology of a multi
> controller/port NVMe disk.
> 
> Examples:
> 
> $ nvme show-topology -r multipath
> 
> nvme-subsys2 - NQN=nvmet_subsystem
>                 hostnqn=nqn.2014-08.org.nvmexpress:uuid:12b49f6e-0276-4746-b10c-56815b7e6dc2
>                 iopolicy=numa
> 
>            _ _ _<head-node>
>           /              _ _ _ <ana-state>
>          /              /      _ _ _ <numa-node-list>
>         /              /      /
>        |              /      /
>   +- nvme2n1 (ns 1)  /      /
>   \                 |      |
>    +- nvme2c2n1 optimized 1,2 nvme2 tcp traddr=127.0.0.2,trsvcid=4460,src_addr=127.0.0.1 live
>    +- nvme2c3n1 optimized 3,4 nvme3 tcp traddr=127.0.0.3,trsvcid=4460,src_addr=127.0.0.1 live
> 
> For iopolicy=numa, only NUMA node list is shown (queue depth is hidden).
> 
> $ nvme show-topology -r multipath
> 
> nvme-subsys2 - NQN=nvmet_subsystem
>                 hostnqn=nqn.2014-08.org.nvmexpress:uuid:12b49f6e-0276-4746-b10c-56815b7e6dc2
>                 iopolicy=queue-depth
> 
>            _ _ _<head-node>
>           /              _ _ _ <ana-state>
>          /              /
>         /              /     _ _ _<queue-depth>
>        |              /     /
>   +- nvme2n1 (ns 1)  /     /
>   \                 |     |
>    +- nvme2c2n1 optimized 0 nvme2 tcp traddr=127.0.0.2,trsvcid=4460,src_addr=127.0.0.1 live
>    +- nvme2c3n1 optimized 0 nvme3 tcp traddr=127.0.0.3,trsvcid=4460,src_addr=127.0.0.1 live
> 
> For iopolicy=queue-depth, queue depth is shown (NUMA node list is hidden).
> 
> $ nvme show-topology -r multipath
> 
> nvme-subsys2 - NQN=nvmet_subsystem
>                 hostnqn=nqn.2014-08.org.nvmexpress:uuid:12b49f6e-0276-4746-b10c-56815b7e6dc2
>                 iopolicy=round-robin
> 
>            _ _ _<head-node>
>           /              _ _ _ <ana-state>
>          /              /
>         /              /
>        |              /
>   +- nvme2n1 (ns 1)  /
>   \                 |
>    +- nvme2c2n1 optimized nvme2 tcp traddr=127.0.0.2,trsvcid=4460,src_addr=127.0.0.1 live
>    +- nvme2c3n1 optimized nvme3 tcp traddr=127.0.0.3,trsvcid=4460,src_addr=127.0.0.1 live
> 
> For iopolicy=round-robin, both NUMA node list and queue depth are hidden.
> 
> Note:
> The annotations above (e.g., <numa-node-list>, <ana-state>, <head-node>,
> <queue-depth>) are for illustration only and are not part of the actual
> command output. A more human-friendly tabular format will be introduced
> in a follow-up patches.
> 
> Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
> ---
>   nvme-print-binary.c |  1 +
>   nvme-print-json.c   | 36 +++++++++++++++----
>   nvme-print-stdout.c | 85 ++++++++++++++++++++++++++++++++++++++++++---
>   nvme-print.c        |  4 ++-
>   nvme-print.h        |  1 +
>   nvme.c              |  4 ++-
>   nvme.h              |  1 +
>   7 files changed, 120 insertions(+), 12 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

