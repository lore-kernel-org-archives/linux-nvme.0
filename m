Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB806D0C61E
	for <linux-nvme@archiver.kernel.org>; Fri, 25 Oct 2024 14:43:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=x+RBc3/5wKCtwLNByyQbKCCgsPn8b9yrINYGPaD+EBM=; b=rt9fh40YdIZWY4lOneE79wB5sa
	EXprIIXznzEkNeZyPgyehgANMNk8NHRGs33mn1M0wu+BKfUwN3uub2g4fI4xSDtCs117p8uAxVhsZ
	cgv+stUQhlmzdhdqlfLmnTc6UwntsYEZMJCKz07Eh1aEkGSfz2B5jdFcXW/A57BH+BeKWL/r0UMf/
	PeFd8/WrQ9IcFHi0+8tOb0ZpPynMV2ksbo+bwJ66aRv/QdkfE9BUqZvYQoYuxPD3a2Gp+z2IN4TFq
	HR/fhKeWrYm7wb/OjdzU+RA9pc69dOA7tQLQQpyIPAkCIVy06g5Kp8jzoLHCoyGzKMD6qQhptRtZL
	9CZywobA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t4LXE-000000043ge-3M72;
	Fri, 25 Oct 2024 14:43:28 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t4LEr-000000040Ko-0hQq
	for linux-nvme@lists.infradead.org;
	Fri, 25 Oct 2024 14:24:32 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B138021CE2;
	Fri, 25 Oct 2024 14:24:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1729866267; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=x+RBc3/5wKCtwLNByyQbKCCgsPn8b9yrINYGPaD+EBM=;
	b=ZmqoxRmlcSsTgQPsNpqZvrGwBtVBTArjjhtvGiQK3cMiB94rd+uFz8mg3FBOP4fa61PAir
	lwZozqvKD6ZKHE6VZJZuVnsJA2ftlIRdgokZk+eB/f8BXooU+qlKYjnby8kZx63W0bR0Hz
	NcBYxYj99157QF/d0Vj/hiGOSPRWHxI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1729866267;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=x+RBc3/5wKCtwLNByyQbKCCgsPn8b9yrINYGPaD+EBM=;
	b=2oe4iK4n1qVw6owWPggM0xYBmXVx+HP0lz230WNaTpnsNlFiI71cHhlHNqLZCBOZbeseCa
	IbetCRgy78NjZNAg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1729866267; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=x+RBc3/5wKCtwLNByyQbKCCgsPn8b9yrINYGPaD+EBM=;
	b=ZmqoxRmlcSsTgQPsNpqZvrGwBtVBTArjjhtvGiQK3cMiB94rd+uFz8mg3FBOP4fa61PAir
	lwZozqvKD6ZKHE6VZJZuVnsJA2ftlIRdgokZk+eB/f8BXooU+qlKYjnby8kZx63W0bR0Hz
	NcBYxYj99157QF/d0Vj/hiGOSPRWHxI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1729866267;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=x+RBc3/5wKCtwLNByyQbKCCgsPn8b9yrINYGPaD+EBM=;
	b=2oe4iK4n1qVw6owWPggM0xYBmXVx+HP0lz230WNaTpnsNlFiI71cHhlHNqLZCBOZbeseCa
	IbetCRgy78NjZNAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8CEEF132D3;
	Fri, 25 Oct 2024 14:24:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id eXv/HxuqG2dQWgAAD6G6ig
	(envelope-from <dwagner@suse.de>); Fri, 25 Oct 2024 14:24:27 +0000
Date: Fri, 25 Oct 2024 16:24:26 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-nvme@lists.infradead.org, Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH blktests 05/15] nvme/{rc,002,016,017,030}: pass port ID
 to genctr helper functions
Message-ID: <c1408ce7-377d-4b67-92b5-83cb0344b138@flourine.local>
References: <20241024010025.2216242-1-shinichiro.kawasaki@wdc.com>
 <20241024010025.2216242-6-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241024010025.2216242-6-shinichiro.kawasaki@wdc.com>
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,imap1.dmz-prg2.suse.org:helo]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241025_072429_379701_D5DE86B0 
X-CRM114-Status: UNSURE (   9.77  )
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

On Thu, Oct 24, 2024 at 10:00:15AM GMT, Shin'ichiro Kawasaki wrote:
> Commit "nvme: sanitize transport parameter in _create_nvmet_port()"
> introduced wwnn and wwpn calculation based on port ID for fc transport.
> This means that --traddr and --host-traddr options for "nvme discover"
> command should reflect the port ID. This change was missing for the
> genctr, or Generation Counter, related helper functions and it made
> the test case nvme/030 fail.
> 
> To avoid the failure, pass the port ID to the genctr related helper
> functions and reflect the port ID for fc transport.
> 
> Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>

Reviewed-by: Daniel Wagner <dwagner@suse.de>

