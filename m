Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3811CC52D7B
	for <linux-nvme@archiver.kernel.org>; Tue, 13 Aug 2024 06:16:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9fHtZseue14ViqRgi8X6malYopuN0jjVBWYrPzmhb/w=; b=Co4eP1b+zacC9hTTWrqjA6q7YY
	dTa7h4C4qECOlC3UGS3CD4M7dTTSW1XipEHSkt4irkeLB6CsiMHaQ5sDGpDHTiTMxA/JRxMzXxct7
	BUn4+xFEYbuKbx9cyO9xkuPenMnZ/0p5m5nptHMD2Lnkxac4GFALwncoQjfJfVtujQmpV/kNvwwV1
	YWJUTxvSTJ1N5KWgUvdSTYXD7M6LTC13oqEJNXse0BGt5wCrOhS2ZRzE9Gl2mYCAm9Cyx7mjud49I
	Is6c9TgpU5dlcEKcD7X8q9k+rBwlh4Rq/Pm7Yko89P8r4HTQF20uoUU10GVraMpU3kkGOh6KloXKV
	5fQ1qnwA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sdkpS-00000002YHl-17gQ;
	Tue, 13 Aug 2024 06:16:22 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sdkpM-00000002YEB-0wY1
	for linux-nvme@lists.infradead.org;
	Tue, 13 Aug 2024 06:16:20 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4456D22718;
	Tue, 13 Aug 2024 06:16:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1723529774; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9fHtZseue14ViqRgi8X6malYopuN0jjVBWYrPzmhb/w=;
	b=18o1xJU68ybPaRloja7hhYRirPs+d/fYnXBVLQ2gvVEnqYSks11EJfBtMELhv8MqcuZKuR
	NOesZIh26dOTWdtNBWsalsk/ET/ko+aYhREaJdjhaSp+4K75hBn3+oPiBUmaxVnIexg7V0
	EdOeYeOl1EHmyp33RFT8pbpP8fCyelY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1723529774;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9fHtZseue14ViqRgi8X6malYopuN0jjVBWYrPzmhb/w=;
	b=Q/lLp8m8bAnwJZ51HRgYMENHndH9Sm51XhoBol4ADSpjSFCQ0i4V+30t1BySEgsMK/zq+F
	uYV7xCDF7RvOosAg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1723529774; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9fHtZseue14ViqRgi8X6malYopuN0jjVBWYrPzmhb/w=;
	b=18o1xJU68ybPaRloja7hhYRirPs+d/fYnXBVLQ2gvVEnqYSks11EJfBtMELhv8MqcuZKuR
	NOesZIh26dOTWdtNBWsalsk/ET/ko+aYhREaJdjhaSp+4K75hBn3+oPiBUmaxVnIexg7V0
	EdOeYeOl1EHmyp33RFT8pbpP8fCyelY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1723529774;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9fHtZseue14ViqRgi8X6malYopuN0jjVBWYrPzmhb/w=;
	b=Q/lLp8m8bAnwJZ51HRgYMENHndH9Sm51XhoBol4ADSpjSFCQ0i4V+30t1BySEgsMK/zq+F
	uYV7xCDF7RvOosAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0B4D613983;
	Tue, 13 Aug 2024 06:16:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id hPs9AS76umYfDgAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 13 Aug 2024 06:16:14 +0000
Message-ID: <110b9276-9aac-47e9-8f88-9dccd60b949c@suse.de>
Date: Tue, 13 Aug 2024 08:16:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2] nvme: move stopping keep-alive into nvme_uninit_ctrl()
Content-Language: en-US
To: Ming Lei <ming.lei@redhat.com>, Christoph Hellwig <hch@lst.de>,
 Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 Sagi Grimberg <sagi@grimberg.me>
Cc: Mark O'Donovan <shiftee@posteo.net>, Changhui Zhong <czhong@redhat.com>
References: <20240813013527.666491-1-ming.lei@redhat.com>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20240813013527.666491-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.29 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lst.de:email,suse.de:email]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240812_231616_492244_ED7339DB 
X-CRM114-Status: GOOD (  17.09  )
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

On 8/13/24 03:35, Ming Lei wrote:
> Commit 4733b65d82bd ("nvme: start keep-alive after admin queue setup")
> moves starting keep-alive from nvme_start_ctrl() into
> nvme_init_ctrl_finish(), but don't move stopping keep-alive into
> nvme_uninit_ctrl(), so keep-alive work can be started and keep pending
> after failing to start controller, finally use-after-free is triggered if
> nvme host driver is unloaded.
> 
> This patch fixes kernel panic when running nvme/004 in case that connection
> failure is triggered, by moving stopping keep-alive into nvme_uninit_ctrl().
> 
> This way is reasonable because keep-alive is now started in
> nvme_init_ctrl_finish().
> 
> Fixes: 3af755a46881 ("nvme: move nvme_stop_keep_alive() back to original position")
> Cc: Hannes Reinecke <hare@suse.de>
> Cc: Mark O'Donovan <shiftee@posteo.net>
> Reported-by: Changhui Zhong <czhong@redhat.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
> V2:
> 	- fix "Fixes" tag
> 
>   drivers/nvme/host/core.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich


