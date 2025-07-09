Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DE2EC83F03
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Jul 2025 11:11:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=k0lEYy/bxtMHnAtOlshx/2pgn3/70H2PJZnlOoUpd8U=; b=WUdhSi91//74U1gW20n74Dx/5u
	svVFQ992710z1pmWV+BNw989GlPKasUUmKqbQ1L1395hr4ZrSsxlfmHsTTnszIKhgwCxO3E5IwMqr
	/9wvl6aaG7ZeSUfX4DiM5Ej1CALRnbshMtPUlFk0eBY1w2alIQSkDM+uXX+FgxnCmKDj+Qwuio4DI
	DiHAPi5Pg2INsLhmvmx3I9D9aJ2G00d+bMqmqTvM67UUeV/TdMdcEB3NtOCwCzuff5Z5oLFT6kyyt
	nShQKDOmpFVwEr2O0Iw5KIegpVPSWJDkXJtqdyaDV8RA5BnO4J4G/D0WMqLNlBCiXom0aSEgq2ntU
	0Kpnalmw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uZShX-00000008RuH-2OyI;
	Wed, 09 Jul 2025 11:10:59 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uZR6t-000000088b1-0bTm
	for linux-nvme@lists.infradead.org;
	Wed, 09 Jul 2025 09:29:04 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 2D8171F441;
	Wed,  9 Jul 2025 09:29:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1752053340; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=k0lEYy/bxtMHnAtOlshx/2pgn3/70H2PJZnlOoUpd8U=;
	b=YM45qU2PIKx5wbzLgc4NXrfQrn1rxm/DB0BW2zO4nE8SBJnrFALjLhjUWXO9W9eHkVjItN
	bK843wExi3aMHmFXa016Mxrfb4u3jX566dJCK/MZCkmtkBRcpJ7L6G2Yod14xe7OMe0cb9
	4bddrSuS5JO66arjb8+omYe2n2HPii4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1752053340;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=k0lEYy/bxtMHnAtOlshx/2pgn3/70H2PJZnlOoUpd8U=;
	b=5OKCQo75qvSASli3BgqIrri82edfcU9KHOpyzEn/4V8yhB8pBq0TIKQ6IFn/VG0QuMWLmC
	UHZXTFOztHR1bhAw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=YM45qU2P;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=5OKCQo75
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1752053340; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=k0lEYy/bxtMHnAtOlshx/2pgn3/70H2PJZnlOoUpd8U=;
	b=YM45qU2PIKx5wbzLgc4NXrfQrn1rxm/DB0BW2zO4nE8SBJnrFALjLhjUWXO9W9eHkVjItN
	bK843wExi3aMHmFXa016Mxrfb4u3jX566dJCK/MZCkmtkBRcpJ7L6G2Yod14xe7OMe0cb9
	4bddrSuS5JO66arjb8+omYe2n2HPii4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1752053340;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=k0lEYy/bxtMHnAtOlshx/2pgn3/70H2PJZnlOoUpd8U=;
	b=5OKCQo75qvSASli3BgqIrri82edfcU9KHOpyzEn/4V8yhB8pBq0TIKQ6IFn/VG0QuMWLmC
	UHZXTFOztHR1bhAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 114F0136DC;
	Wed,  9 Jul 2025 09:29:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 6tbbAVw2bmiKDQAAD6G6ig
	(envelope-from <dwagner@suse.de>); Wed, 09 Jul 2025 09:29:00 +0000
Date: Wed, 9 Jul 2025 11:28:55 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: linux-nvme@lists.infradead.org, hare@suse.de, kbusch@kernel.org, 
	gjoyce@ibm.com
Subject: Re: [PATCH 2/2] nvme: extend show-topology command to add support
 for multipath
Message-ID: <91e8e0de-70a7-484d-af9f-f06645011ae6@flourine.local>
References: <20250704135001.292763-1-nilay@linux.ibm.com>
 <20250704135001.292763-3-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250704135001.292763-3-nilay@linux.ibm.com>
X-Rspamd-Queue-Id: 2D8171F441
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.de:+]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250709_022903_524574_F4A52362 
X-CRM114-Status: GOOD (  10.96  )
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

Hi Nilay,

On Fri, Jul 04, 2025 at 07:19:54PM +0530, Nilay Shroff wrote:
> $ nvme show-topology -r multipath
> 
> nvme-subsys2 - NQN=nvmet_subsystem
>                hostnqn=nqn.2014-08.org.nvmexpress:uuid:12b49f6e-0276-4746-b10c-56815b7e6dc2
>                iopolicy=numa
> 
>           _ _ _<head-node>
>          /              _ _ _ <ana-state>
>         /              /      _ _ _ <numa-node-list>
>        /              /      /  _ _ _<queue-depth>
>       |              /      /  /
>  +- nvme2n1 (ns 1)  /      /  /
>  \                 |      |  |
>   +- nvme2c2n1 optimized 1,2 0 nvme2 tcp traddr=127.0.0.2,trsvcid=4460,src_addr=127.0.0.1 live
>   +- nvme2c3n1 optimized 3,4 0 nvme3 tcp traddr=127.0.0.3,trsvcid=4460,src_addr=127.0.0.1 live
> 
> Please note that the headers shown above (e.g., <numa-node-list>,
> <ana-state>, <hed-node>, and <queue-depth>) are included for clarity
> only and are not part of the actual output.

I do like the annotation what the numbers mean. Could you also add those
annotation to the output?

Rest looks good from a quick look.

Thanks,
Daniel

