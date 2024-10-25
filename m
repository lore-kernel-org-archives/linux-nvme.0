Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B21CDD1039E
	for <linux-nvme@archiver.kernel.org>; Fri, 25 Oct 2024 15:51:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CvpqzvWg4v2oK+kN1TcMGDXHHiV7zIMR9uEvorkFEeg=; b=QWg19voJAFeSYlRqmHaEFKyqQJ
	wQXwA0O0sSq0BdbvR8a1M4RZsvpbrUp+kDJdjYbv91eRafg4uZ8jIrUAmo2SQdjhHvE+hKRbgfssx
	jyV3LpPzvMP+Drcqm80FO/jRwknGOb2bncgiWE8y9lU4sq3HFrygyNSIlRWtSP9pXm8rfZI24VWe1
	kmtHa9gwf5/sgc1cXMk7AXeQhE+rHSEbVMUFsU5LTg0OSaUqKjLaaLwqC0S+fMkbhQARSWAEmsOzV
	OtyjMrKtHahOxNGtaG7q8qkyIkWKqpaSTL8Ygz3AbAWtWpI1BlWqKNpQdfkLIk7OP27Q+Rn5ZUiLn
	R0yfTPLw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t4MbO-00000004Jt2-1skP;
	Fri, 25 Oct 2024 15:51:50 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t4MXr-00000004JS8-0y2Q
	for linux-nvme@lists.infradead.org;
	Fri, 25 Oct 2024 15:48:15 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D9D2E1FB87;
	Fri, 25 Oct 2024 15:48:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1729871289; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CvpqzvWg4v2oK+kN1TcMGDXHHiV7zIMR9uEvorkFEeg=;
	b=0nKP16UT7SzsQDi8jsWEEI0oGUHcxBbOfI4B8PEzXZkI2aikGZbc3JRHAXdzIjBxW/AufV
	sM/ixLobDD2/psylG+3Z7k2Ic5v6eW2BqX0wB7q8UW5TJklbrtHy69FY7PUq/ftvfKVvnZ
	cpcOeetaaLIXZz+0A9sRBGeDnelqn18=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1729871289;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CvpqzvWg4v2oK+kN1TcMGDXHHiV7zIMR9uEvorkFEeg=;
	b=ikUR1FAnsdtztYI1nMfPE2YaqwGOqq1Jwlh7jbH8e+1aYXOdOvGsr3BYo09+9FAdu16k8/
	Oo7e9LQZP6DbpABA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=jkqb4qIs;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=zXaBNAPW
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1729871288; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CvpqzvWg4v2oK+kN1TcMGDXHHiV7zIMR9uEvorkFEeg=;
	b=jkqb4qIsUtMfFhg3ZaNP9EkMHE1OROcyP0W2BB4LN8y8OUXLboOZxLc9s6wDQGJsa1tQNq
	REbHqRMig+Lfw/GBm8CGeU6qjxT8YJOvKzZZrW0PZUyqazwcXDjk/E1sVH0PVsu5lSh0Ai
	c03sHODQXbbnO07GY8C1a46WqmDGf4A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1729871288;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CvpqzvWg4v2oK+kN1TcMGDXHHiV7zIMR9uEvorkFEeg=;
	b=zXaBNAPWVgJB/JqXFc2Ek6d91ZST4bCkoz9r4lAz5mO0fGYuSro5gdlCVIELNxe6OuPiy7
	Ey8QCEmHFv40QpCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BDBCE132D3;
	Fri, 25 Oct 2024 15:48:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 8isBLLi9G2djdAAAD6G6ig
	(envelope-from <dwagner@suse.de>); Fri, 25 Oct 2024 15:48:08 +0000
Date: Fri, 25 Oct 2024 17:48:08 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-nvme@lists.infradead.org, Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH blktests 13/15] nvme: delete all namespaces in
 _remove_nvmet_subsystem()
Message-ID: <f93f04a8-ae68-458d-a1bb-900d984a9208@flourine.local>
References: <20241024010025.2216242-1-shinichiro.kawasaki@wdc.com>
 <20241024010025.2216242-14-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241024010025.2216242-14-shinichiro.kawasaki@wdc.com>
X-Rspamd-Queue-Id: D9D2E1FB87
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241025_084811_447398_E8BCF3E3 
X-CRM114-Status: UNSURE (   8.96  )
X-CRM114-Notice: Please train this message.
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

On Thu, Oct 24, 2024 at 10:00:23AM GMT, Shin'ichiro Kawasaki wrote:
> -	for ((i = iterations; i > 1; i--)); do
> -		_remove_nvmet_ns "${def_subsysnqn}" "$i"
> -	done
> -

Hmm, I read the two test nvme/016 and nvme/017 doing explicit allocation
and deallocation of namespaces. What is missing to check if any
namespace is left after the explicit _remove_nvmet_ns run. I think this
should be added and instead removing the loop.

