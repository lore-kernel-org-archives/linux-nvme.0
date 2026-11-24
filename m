Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0ED9606A32E
	for <linux-nvme@archiver.kernel.org>; Tue, 24 Nov 2026 07:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=gkRkjnsa;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=Lq2M2ZZ4;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=JXKgSCPk;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=Lq2M2ZZ4;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=JXKgSCPk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=iLPU7nD0/7mAvUwfwvVn8oZ/ejWFMFdeFuiwoi6o4So=; b=gkRkjnsaGgzLFT
	JljqUpOOc3e4EzhPHlTMjAqctbWrMfb7kz7MZvT4yR4R7Tu43HN9RujVOhVyPCM8I7tWZsfidNE3d
	D6nP/fQQxpGhG5b/BHs/hdVusAAwdKAANWeuPX9vwt1PfvDtNEevYjAotvmmKL2yvOlP6bVJzuwxC
	mT37BM+rbyJ9EEi+TGcYKFe16QRH4G/bQVBbUu7hW1bKnvjWAGDJVxnb1YEWU6FlThIE4Bfry6E6e
	0bo0NkvxAPUuf5OMUU7r0BHcnc00UoeuaKAT0+UJPDMBjxcYb6T8WG7Tkedfgs9RjUyOZKt7EWi3E
	Gozk1IP+N+bMfUvefnMw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xVkYc-00000005hx6-0zRo;
	Tue, 24 Nov 2026 07:03:14 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xVkYa-00000005hw1-0Vtc
	for linux-nvme@lists.infradead.org;
	Tue, 24 Nov 2026 07:03:13 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B852C220D1;
	Tue, 24 Nov 2026 07:03:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1795503789; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iLPU7nD0/7mAvUwfwvVn8oZ/ejWFMFdeFuiwoi6o4So=;
	b=Lq2M2ZZ4kTrUUmoYynLrbZk9OLnSnM+5+kB9gdfGQvr3slJvuaRAEKVdycQkRSSab2Rh1Z
	giMZUdPFYHqZFMwCOKQcTN0fNwegmDZQ6mMcOSGXo3Sa/btZ37J9w7tUv1K2Skc1W1pZ0J
	b2T09ZJs7JlJYyGVGE0zbFD2XiFkT1o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1795503789;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iLPU7nD0/7mAvUwfwvVn8oZ/ejWFMFdeFuiwoi6o4So=;
	b=JXKgSCPkfyuTAbY+/PYOvVRhGkndcNvN2sbZHqwTkdvq9AVFbRj8nR6lrGYgSOXv+OlRtk
	xskvfYEg2elbzNCw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Lq2M2ZZ4;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=JXKgSCPk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1795503789; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iLPU7nD0/7mAvUwfwvVn8oZ/ejWFMFdeFuiwoi6o4So=;
	b=Lq2M2ZZ4kTrUUmoYynLrbZk9OLnSnM+5+kB9gdfGQvr3slJvuaRAEKVdycQkRSSab2Rh1Z
	giMZUdPFYHqZFMwCOKQcTN0fNwegmDZQ6mMcOSGXo3Sa/btZ37J9w7tUv1K2Skc1W1pZ0J
	b2T09ZJs7JlJYyGVGE0zbFD2XiFkT1o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1795503789;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iLPU7nD0/7mAvUwfwvVn8oZ/ejWFMFdeFuiwoi6o4So=;
	b=JXKgSCPkfyuTAbY+/PYOvVRhGkndcNvN2sbZHqwTkdvq9AVFbRj8nR6lrGYgSOXv+OlRtk
	xskvfYEg2elbzNCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4E6BE13505;
	Tue, 24 Nov 2026 07:03:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id b9qEBa02BWujNQAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 24 Nov 2026 07:03:09 +0000
Message-ID: <a4ade153-75b8-47f6-908a-b61b207c85da@suse.de>
Date: Tue, 24 Nov 2026 08:03:08 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] nvme: document NVMe/TCP per-queue address sysfs
 attribute
To: Nilay Shroff <nilay@linux.ibm.com>, kbusch@kernel.org, dwagner@suse.de,
 hch@lst.de, sagi@grimberg.me, chaitanyak@nvidia.com, gjoyce@linux.ibm.com
Cc: linux-nvme@lists.infradead.org
References: <20261123173727.2022020-1-nilay@linux.ibm.com>
 <20261123173727.2022020-3-nilay@linux.ibm.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20261123173727.2022020-3-nilay@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: B852C220D1
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-13.50 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim,suse.de:email];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim,suse.de:email];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Score: -13.50
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261123_230312_364880_09B0DE11 
X-CRM114-Status: GOOD (  15.40  )
X-Spam-Score: -2.1 (--)
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/23/26 6:37 PM, Nilay Shroff wrote:
> Document the per-I/O-queue "address" sysfs attribute introduced
> for NVMe/TCP. The attribute is available at:
> 
>      /sys/class/nvme/nvmeX/queues/<qid>/address
> 
> Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
> ---
>   Documentation/ABI/stable/sysfs-nvme | 18 ++++++++++++++++++
>   1 file changed, 18 insertions(+)
> 
> diff --git a/Documentation/ABI/stable/sysfs-nvme b/Documentation/ABI/stable/sysfs-nvme
> index fcfd0426866c..953ecee81c43 100644
> --- a/Documentation/ABI/stable/sysfs-nvme
> +++ b/Documentation/ABI/stable/sysfs-nvme
> @@ -534,3 +534,21 @@ Description:
>   		managed: (RO) Shows who owns the CPU placement. 1 while
>   		io_cpu is driver managed, 0 once the user assigned it,
>   		for the life of the controller.
> +
> +What:		/sys/class/nvme/nvmeX/queues/<qid>/address
> +Date:		November 2026
> +KernelVersion:	7.5
> +Contact:	Nilay Shroff <nilay@linux.ibm.com>
> +Description:
> +		(RO) Shows the socket endpoint addresses associated with
> +		an NVMe/TCP I/O queue. The output contains the following
> +		comma-separated fields:
> +
> +		traddr: Peer transport address (IPv4/IPv6).
> +		trsvcid: Peer transport service identifier (TCP port).
> +		host_traddr: Local transport address (IPv4/IPv6).
> +		host_trsvcid: Local transport service identifier (TCP port).
> +
> +		Returns an empty result if the I/O queue is not live.
> +		Returns error if host or peer transport address can't be
> +		determined or transport address family is unsupported.

Please merge it with the previous patch.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

