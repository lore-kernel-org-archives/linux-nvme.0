Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3822CC3ABAC
	for <linux-nvme@archiver.kernel.org>; Tue,  6 May 2025 16:33:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=E4mCQwL1Uxne/Gy07x58fnky17A/jdw4i+ezrFDE8/c=; b=HESQKQLzASA9wssKXU4PpN2Mu9
	WVtboTpdprpRvT8BicIAYiYvcz1WnENCu+/JROaEft/6+tjUQjPKj5436SKlvSNNob4qNeXOa7i7g
	T+lReWTp4FnA0sYno0dRax0QEIZXVPtzuTCJTrqWGiXxJb4EbeBDr3c+OYQLGiV0RWwOM1BGpHlLN
	ShA0xOgd7pUuXWdTZV9R0L8hNV8UAgFtCojaOT8KeGaWuMz0onBOsBzivn+3pR51YWS2MPaiWCR5O
	79wFGibWXzRBQOLQJqktdwCGfO+r8k9+SQBdOK0Ks4nv3KdV3hOkFCsU748uaxCXUgv2qTHunFfaK
	YiO7kv+A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCLE0-0000000Cgbn-15Uf;
	Tue, 06 May 2025 16:32:56 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCHx4-0000000C0sL-1d0A
	for linux-nvme@lists.infradead.org;
	Tue, 06 May 2025 13:03:15 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id BC67E1F390;
	Tue,  6 May 2025 13:03:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1746536591; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E4mCQwL1Uxne/Gy07x58fnky17A/jdw4i+ezrFDE8/c=;
	b=v1NPXejmCFJz1+0SIGexiWlmWiSsPD6SHWtzREb8EtyllMO0gP/YuBEg21vBJoCMXA2p39
	Yxb5+4XAJg/tsfyhh4H1OaJZogrRNLg+a3ScwS2teWS8PZLLE7R+0vUq66U06sIyfFBrDm
	qMcwe94VmAaW2rHW7wmzJxX7dl2Y/tg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1746536591;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E4mCQwL1Uxne/Gy07x58fnky17A/jdw4i+ezrFDE8/c=;
	b=rNQUYH0TbQDCXBVemh3kmUEeRGQPTfbDoKKjlCIz9ba1zGtypKf0AMR/JQO43cARZ7v1eQ
	Cx7HR/gtUOnmEcBQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1746536590; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E4mCQwL1Uxne/Gy07x58fnky17A/jdw4i+ezrFDE8/c=;
	b=N+AE0FNtm3C0DZdOsHpEDmRdXNJAQfZI950mv0eT/q6if/983yfJxEAyuFbuuyIfjkJHMF
	3b/g9gOtxLFk1q+kUwk4zZYdV7u01hiBszoUR2R/1R7OHE0nsTAWB1OEdBHDqIfyid/vF6
	IgjKY6P9NwBM90lgG9GrRbyr2GhYQ8c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1746536590;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E4mCQwL1Uxne/Gy07x58fnky17A/jdw4i+ezrFDE8/c=;
	b=0QdD7lyGBJdfX3l1DmEa9YeIovRInPtAeQyBcISeYZ0Mxv1Ixz4vqltcK0TMnkNvWqJldg
	aWPATKuGfqOrBuDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 97F2E13A30;
	Tue,  6 May 2025 13:03:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id pxujJI4IGmiXNAAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 06 May 2025 13:03:10 +0000
Message-ID: <cc795966-8c09-48ed-80e4-c70ff4143202@suse.de>
Date: Tue, 6 May 2025 15:03:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: kernel TLS configuration, was: Re: [ANNOUNCE] ktls-utils 1.0.0
To: Christoph Hellwig <hch@infradead.org>,
 Chuck Lever <chuck.lever@oracle.com>
Cc: kernel-tls-handshake <kernel-tls-handshake@lists.linux.dev>,
 Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
 linux-nvme@lists.infradead.org
References: <oracle/ktls-utils/push/refs/tags/ktls-utils-1.0.0/000000-c787cd@github.com>
 <32e4bd99-a85f-4f53-94bd-b8c3ecf2c66f@oracle.com>
 <aBoCELZ_x-C4talt@infradead.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <aBoCELZ_x-C4talt@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:email]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250506_060314_571994_25994CAB 
X-CRM114-Status: GOOD (  14.33  )
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

On 5/6/25 14:35, Christoph Hellwig wrote:
> Hi Chuck,
> 
> let me use this as a vehicle to rant^H^H^H^Hprovide constructive
> feedback about configuration of the tls upcalls now that I finally
> got around playing with both NVMe and TCP over TLS.
> 
> For modular systems configuations the amount of monolithic state
> in tlshd.conf is a bit unfortunate.
> 
> For NVMe it isn't all that bad, but having to hardcode the .nvme
> keyring still means that:
> 
>   - we need userspace configuration past just enabling tlshd to enable
>     any kernel subsystem using TLS upcalls.
>   - hard code the keyring used in the userspace configuration
> 
> Can't we ensure the upcall passes the keyring to use and avoid
> this issue entirely?
> 
Hmm. We do that already:

         dev_dbg(nctrl->device, "queue %d: start TLS with key %x\n",
                 qid, pskid);
         memset(&args, 0, sizeof(args));
         args.ta_sock = queue->sock;
         args.ta_done = nvme_tcp_tls_done;
         args.ta_data = queue;
         args.ta_my_peerids[0] = pskid;
         args.ta_num_peerids = 1;
         if (nctrl->opts->keyring)
                 keyring = key_serial(nctrl->opts->keyring);
         args.ta_keyring = keyring;
         args.ta_timeout_ms = tls_handshake_timeout * 1000;
         queue->tls_err = -EOPNOTSUPP;
         init_completion(&queue->tls_complete);
         ret = tls_client_hello_psk(&args, GFP_KERNEL);

... but we never evaluate the 'keyring' parameter from tlshd.
Should be easy enough to fix.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

