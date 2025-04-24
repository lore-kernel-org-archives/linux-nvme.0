Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87B42C369C2
	for <linux-nvme@archiver.kernel.org>; Thu, 24 Apr 2025 16:07:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xN7gtMb2g2PQyiNkBVkCGh+FwN6CDKIGTTJ418S/DQo=; b=mGxnJm5rfAZHqERcoJIpWf14K/
	pEWupTuB3Gi3IOwionIzcZtwrqE5nuT6nxZj7SP39iw48U4om3B2g5hwGnc+5NmU/JpVLhsPfhcq3
	TGtNRzFIb+JX+TUvCboqFZy9yOdBz5zX0nGyakouGEi8V0tCMc7VvRiVuPklSwXqku1CQ76pSHDIm
	4yxqcsNn1l4c9F0vKWLTPSiDTlOxIsLwDa6wvurdgj2y5GDCY0Q762J7pi8w7ZC3Wzx+nqkUxdkSp
	cveEqDkvyWpYLUrDMOys5RQdPAwpQuCw2UGPcMBKZmJzgn4FdU+i4sT+opYK4IH028phWjLLtqVLU
	tcG0yszA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7z6d-0000000EfIK-265Z;
	Thu, 24 Apr 2025 16:07:19 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7yIS-0000000ET30-17dd
	for linux-nvme@lists.infradead.org;
	Thu, 24 Apr 2025 15:15:29 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A99E121181;
	Thu, 24 Apr 2025 15:15:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1745507726; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xN7gtMb2g2PQyiNkBVkCGh+FwN6CDKIGTTJ418S/DQo=;
	b=YfnSxhH4RvX7GtW21+kDoD3inA7mki4S5Nyybsd0PWmYEz4D0XysEM2aGtPaAci4OJMYFL
	8Uc5yo8U8vWB7+GmRM563+sBUR3vsBENHVrdJ9k2Qs1gn+1laO2ZH1Wztai/DiaUMyp8Aj
	1e4t5aCNpKkFRupFTJ4lP9DO88yXwaA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1745507726;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xN7gtMb2g2PQyiNkBVkCGh+FwN6CDKIGTTJ418S/DQo=;
	b=yU7HW0+CreOhRKoBTnN7Ith2MmAFqb4IDVacmrNzLFZA0SbBAfxwMxXtkmmVBE0PNgNUal
	h1kkC9cUjxWmF1Bw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1745507725; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xN7gtMb2g2PQyiNkBVkCGh+FwN6CDKIGTTJ418S/DQo=;
	b=LyeJKA5DF22rw2dhIQJ4cvhsKZtKG2qV+HHi2IosfrVZtdNWTcu2WAg+qVRr7wRN8pVb6q
	09QDPR8BiyBvlkolnBytoANqvEayq6T8/F5EspMZF2p7tF5FR12bfKXIotd0rC1cfWLJT/
	zgh+Lp+tZAC3bQkfh/xUsrEgBlJ9W5c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1745507725;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xN7gtMb2g2PQyiNkBVkCGh+FwN6CDKIGTTJ418S/DQo=;
	b=jFfn5wMNMnIZKwymyfSCoIXPJpHC8jy01eyKSi2/AND7XT7X2+Rys3MGACk+UZtsv+cjBL
	ZRntf8maZD6DBwBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 750961393C;
	Thu, 24 Apr 2025 15:15:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id lhe+Go1VCmhEAQAAD6G6ig
	(envelope-from <hare@suse.de>); Thu, 24 Apr 2025 15:15:25 +0000
Message-ID: <c2655edb-feb1-49ef-acaa-f47e8262ba97@suse.de>
Date: Thu, 24 Apr 2025 17:15:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [bug report] nvme_auth: kmemleak observed with blktests nvme/tcp
 nvme/062
To: Maurizio Lombardi <mlombard@bsdbackstore.eu>,
 Yi Zhang <yi.zhang@redhat.com>,
 "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>
Cc: hare@kernel.org, Sagi Grimberg <sagi@grimberg.me>,
 Keith Busch <kbusch@kernel.org>
References: <CAHj4cs-05=-TJAyTVNcf4R9GbnfKVRrEkEVZXEhUACts+WYQYQ@mail.gmail.com>
 <D9EXJYETM8DK.1MXQ018Y4BK6G@bsdbackstore.eu>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <D9EXJYETM8DK.1MXQ018Y4BK6G@bsdbackstore.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.997];
	MIME_GOOD(-0.10)[text/plain];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_TWO(0.00)[2];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250424_081528_449332_4FA8D3C7 
X-CRM114-Status: GOOD (  11.07  )
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

On 4/24/25 16:14, Maurizio Lombardi wrote:
> On Thu Apr 24, 2025 at 2:53 PM CEST, Yi Zhang wrote:
>> Hi
>> I found this kmemleak when running the blktests on the latest
>> linux-block/for-next, please help check it and let me know if you need
>> any test/info for it, thanks.
> 
> I believe the issue lies in the nvmet_auth_insert_psk() function.
> The tls_psk  pointer is allocated but only freed in case of an error,
> unlike in nvme_auth_secure_concat(), where it is always properly deallocated.
> 
No, it's an issue with the kernel config; we don't free the key if TLS 
is disabled.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

