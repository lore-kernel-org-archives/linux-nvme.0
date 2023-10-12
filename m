Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7FB6C41513
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Oct 2023 16:18:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kU6Y4niZuQ18xMENCkLwMN8Ro8KaC7xT1pcxVuD/XhU=; b=Ob5cq4OXKnGeT9qaH1h+5aVOoH
	r28bS3fE9oZjdPSelWIzwjBCirXzD/KQi3eT0dUOaepsiBY0QmJKFyoU0XV4SNhKmtQM0Pi3+Sm/E
	COpNGT/llvaNXOCvpvLzIqYXAb79xYxhtmIIR3F7k53RgqoQ0rOfkuQMsGkRKT1UPf2wovvGtR62y
	vd4CtojBg6e8OoYLtIT6HRII9nrSi3Qd28yYT5g6JYLS/H7oRiv8iIeB9TL/725m0JXWnFgYh7hIt
	J/wMTfmy5OiZC5h3IzQVFIS1dezZqICs2AryOr20+vIoFhBL4UStmNn4Iwb+3DeCVZ93ac5S1fPRs
	xROSLCbg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qqyOK-001OHd-2k;
	Thu, 12 Oct 2023 16:18:28 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qqyOI-001OGe-07
	for linux-nvme@lists.infradead.org;
	Thu, 12 Oct 2023 16:18:28 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D72151F896;
	Thu, 12 Oct 2023 16:18:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1697127501; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kU6Y4niZuQ18xMENCkLwMN8Ro8KaC7xT1pcxVuD/XhU=;
	b=Zzv3etgy/z/LKOQ5sT+oBsdz0hRixjCzr6xfyBfjAGVc9LZXpLcNHl+XyAStD0sIMsfq4G
	S5E9zuodDQN+/lTcFIHY45hI6ZqMnjccE51IrRu0d2jtQNkWOpsZWiYTE+9caF3lNur1Qw
	QULaohvRBL+iMTT26jLJ4kLTtJrSBjk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1697127501;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kU6Y4niZuQ18xMENCkLwMN8Ro8KaC7xT1pcxVuD/XhU=;
	b=BUa7nPlGmZE9YxZjy+0tLjB1BFdyYpNxoZI+Y94KqxKfQLXu4faQBm/Q4T4b4vTQ6QoVac
	POxtMvy0grHibADA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 97174139ED;
	Thu, 12 Oct 2023 16:18:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id /FAtI00cKGUFTgAAMHmgww
	(envelope-from <hare@suse.de>); Thu, 12 Oct 2023 16:18:21 +0000
Message-ID: <787c2581-d9b0-404e-ac2d-764324af3fc9@suse.de>
Date: Thu, 12 Oct 2023 18:18:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvmet-tcp: use 'spin_lock_bh' for state_lock()
Content-Language: en-US
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 linux-nvme@lists.infradead.org
References: <20231012125954.58709-1-hare@suse.de>
 <ZSgMH3uNeccez5Gf@kbusch-mbp.dhcp.thefacebook.com>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <ZSgMH3uNeccez5Gf@kbusch-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-4.27 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 XM_UA_NO_VERSION(0.01)[];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[4];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-3.00)[-1.000];
	 BAYES_HAM(-0.18)[70.19%];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-1.00)[-1.000];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_COUNT_TWO(0.00)[2];
	 RCVD_TLS_ALL(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231012_091826_238012_606350E2 
X-CRM114-Status: GOOD (  13.50  )
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

On 10/12/23 17:09, Keith Busch wrote:
> On Thu, Oct 12, 2023 at 02:59:54PM +0200, Hannes Reinecke wrote:
>> nvmet_tcp_schedule_release_queue() is called from socket state
>> change callbacks, which may be called from an softirq context.
>> So use 'spin_lock_bh' to avoid a spin lock warning.
> 
> Doh, I missed you already sent this fix:
> 
>    http://lists.infradead.org/pipermail/linux-nvme/2023-August/041593.html
> 
> I can apply it on nvme-6.7, though this feels like a fix that can go in
> now. Depending on which way we go, it will cause a merge conflict for
> either stable or the next merge window. Do you have a preference? I'd
> just do 6.7 if you don't care.

Na, just apply it on top of the TLS patches. That should be fine.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Ivo Totev, Andrew
Myers, Andrew McDonald, Martje Boudien Moerman


