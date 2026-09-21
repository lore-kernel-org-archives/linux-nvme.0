Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23AA7C982DE
	for <linux-nvme@archiver.kernel.org>; Mon, 21 Sep 2026 08:10:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Wq8GkXu52IjXpfx96S39S/uyZjL4l1Evpo4NpUflPXk=; b=upK0moULmkV4muVUzGEOvDjp8u
	j4PB7MWSWW43Yaxtiwgk/LI/cAgoaPXruouCeob5wHVTzzy3KaEsH/M+4Ix5Y3AGvV3CxFnhQDn8P
	B6Zl29+99/cFZPL3JPAoWrDom/a0aFNCfczU6L7p7YQDmZ7jI9/Ke2/X15J6FVjnkKBYZHixZNIwK
	wdn1+MVuFxpwNoYBCtP2T2Nsk9V0DQIrLvkCai+I6iX/ymH/MEhZy/dlzB8qXJgil4JXx+Kci/zgG
	1QRJ1rGP44tcG3wkKhU8/AIRupQPtj9tSVT9K0EA3/Hc5xfsDMNVSLXNdGX2IqX4U1nghwnmKs2IY
	Cxn2Drtw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8Z6h-00000001J9M-2cjh;
	Mon, 21 Sep 2026 08:10:35 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8Z6d-00000001J8a-09VY
	for linux-nvme@lists.infradead.org;
	Mon, 21 Sep 2026 08:10:32 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D131C1F7DB;
	Mon, 21 Sep 2026 08:10:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1789978225; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Wq8GkXu52IjXpfx96S39S/uyZjL4l1Evpo4NpUflPXk=;
	b=2LsdN6NoVX7CAUCNgVoxNtPuOibq2LixlO8aMRK0/8sk7DcNeEYXVo+08VXoewOC5h9L6z
	VRAFYZByK6ccB1DWLJ0eOWWewHYjpayd6ed3Bks8jWJSZjvzL2kj2gzlj4AhTNVhjCpPry
	7ptBc6xsCccIgvXdoIUnuGRvVhycnGE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1789978225;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Wq8GkXu52IjXpfx96S39S/uyZjL4l1Evpo4NpUflPXk=;
	b=fC5utse749tdAtoBGt1n5SoTDpU75wEuqrfvI3xNHIpGjBzUyIEo8lyHNYSljI+Xg8XMBm
	My73ccebgvkH/5DQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1789978220; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Wq8GkXu52IjXpfx96S39S/uyZjL4l1Evpo4NpUflPXk=;
	b=b39Q3DIgO5LAvfTzhxuO4FpBGDxhfgfDu6iS0eiltCzU/lVb1CpWX2MFXhq+cPYWIC90Of
	2YpsHkzc5NW274iXQp/Lf3fmwnVYRFBnto6gg3Myd7WbJJ6MO0u9+Lje9bCoWLvVaKYVJ3
	W6SYq4VOgBFzyECNhXF5odiCJhZQtqI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1789978220;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Wq8GkXu52IjXpfx96S39S/uyZjL4l1Evpo4NpUflPXk=;
	b=9VDiOOQd6mtGhs/tOdWgTqvkoo0EqmVUwtQXnjL99r37Cs9+GxsJa/4/5x6pa/v1/aZW7U
	lTaZq2MmAiuuNJCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 94C6A1368D;
	Mon, 21 Sep 2026 08:10:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ztH+GWvmsGqOHgAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 21 Sep 2026 08:10:19 +0000
Message-ID: <90913716-f86c-4f9c-b9de-82ff81e760b1@suse.de>
Date: Mon, 21 Sep 2026 10:10:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 15/18] nvme-fc: Hold inflight requests while in FENCING
 state
To: Mohamed Khalfella <mkhalfella@purestorage.com>,
 Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
Cc: Justin Tee <justin.tee@broadcom.com>,
 Naresh Gottumukkala <nareshgottumukkala83@gmail.com>,
 Paul Ely <paul.ely@broadcom.com>, Hannes Reinecke <hare@kernel.org>,
 Chaitanya Kulkarni <kch@nvidia.com>, James Smart <jsmart833426@gmail.com>,
 Randy Jennings <randyj@purestorage.com>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20260918181614.3947933-1-mkhalfella@purestorage.com>
 <20260918181614.3947933-16-mkhalfella@purestorage.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20260918181614.3947933-16-mkhalfella@purestorage.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[broadcom.com,gmail.com,kernel.org,nvidia.com,purestorage.com,lists.infradead.org,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[purestorage.com:email,suse.de:email,suse.de:mid,imap1.dmz-prg2.suse.org:helo]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260921_011031_249499_7E927D6B 
X-CRM114-Status: GOOD (  14.77  )
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

On 9/18/26 8:14 PM, Mohamed Khalfella wrote:
> With the association torn down at the start of nvme_fc_fencing_work(),
> canceling the held requests inside nvme_fc_delete_association() would
> complete them at fence START, letting them fail over to other paths
> before CCR/CQT guarantees the target can no longer execute the original
> commands - defeating the hold this patch introduces.
> 
> Split nvme_fc_delete_association() into __nvme_fc_teardown_association()
> (LLDD-facing teardown, no request completion) and
> nvme_fc_flush_held_requests() (cancel tagsets + unquiesce queues).
> nvme_fc_fencing_work() now runs only the teardown half up front and
> flushes the held requests on the FENCING -> FENCED transition. The
> queues stay quiesced across the fence so nothing new reaches the dead
> association.
> 
> Update nvme_fc_fcpio_done() to not complete aborted requests or requests
> with transport errors. Held requests cannot be forced out mid-fence by
> the block layer, nvme_fc_timeout() always returns BLK_EH_RESET_TIMER and
> nvme_fc_start_ioerr_recovery() is a no-op in FENCING state. Every held
> op is FCPOP_STATE_COMPLETE before the fence starts (aborts drained,
> synchronize_rcu() done), so the flush never touches the LLDD.
> 
> Signed-off-by: Mohamed Khalfella <mkhalfella@purestorage.com>
> ---
>   drivers/nvme/host/fc.c | 116 +++++++++++++++++++++++++++++++++--------
>   1 file changed, 94 insertions(+), 22 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@kernel.org>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

