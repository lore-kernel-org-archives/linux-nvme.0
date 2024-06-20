Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 455C9C41513
	for <linux-nvme@archiver.kernel.org>; Thu, 20 Jun 2024 14:15:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2bOUA5QxJ31WCm6TPcJHCbjgJxpPmWHLpzok2TtDYqc=; b=Ry31wfE7B9wPWvcYyQmZ7w7Vqr
	o7Vzp2yRnhIvpYIto77+GbBIoba1Z82VrvSahz10Ttq4fZFYgmRzcxk+Xib6ZXAOQiVqM7+hdxxDf
	wDPodkyYw0nkDjWovMK6QewU3vbDoegfWJ0KnyNp0h63XCG8QgEDSbAa/wLCQBrtNCeknvFMEnrpj
	T9GHMa3DgEfD8unwMFyewB6188jetZCQBppvAXQXwAjODtwuCQ/6vQS+vaz8c+eCE2fDcmaN4Mb6H
	Z4f6Hc7bRO7dNMlBOkZ4hKNNlM4eFUFFp+2Jt5hKYgL/jo5We5b8O4GbfYmDCjGdspOPlgTcdNxyi
	Sa0ONqtw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sKIZt-00000005ONy-3aaM;
	Thu, 20 Jun 2024 14:15:53 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sKIX5-00000005Nax-38BV
	for linux-nvme@lists.infradead.org;
	Thu, 20 Jun 2024 14:13:03 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 71E341F8A3;
	Thu, 20 Jun 2024 14:12:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1718892775; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2bOUA5QxJ31WCm6TPcJHCbjgJxpPmWHLpzok2TtDYqc=;
	b=zt1JXUWOXSP38EVlKaw+5G4O5YWCV2Nlcx6R+3dFKt1zVJGR4gP7Vbn6WZCxRqF0IwJM6j
	pFAR7qiyPX5cF3RCLcLfSPDkvVLJIjUKdo40QMdT+lqWYp/hEYMpPZORETKBnTQsfPxUgz
	nmePGnARD5yj1dAqT1Kx5i/XaR/Lqhg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1718892775;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2bOUA5QxJ31WCm6TPcJHCbjgJxpPmWHLpzok2TtDYqc=;
	b=miN6IEO0C7jAdufzLA7ujwgUOVZD2Kz32tibXGEWysr9O0buLyUIA2aBENYXrk12wrGJWa
	nJp2TA0rIFLNnACA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1718892775; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2bOUA5QxJ31WCm6TPcJHCbjgJxpPmWHLpzok2TtDYqc=;
	b=zt1JXUWOXSP38EVlKaw+5G4O5YWCV2Nlcx6R+3dFKt1zVJGR4gP7Vbn6WZCxRqF0IwJM6j
	pFAR7qiyPX5cF3RCLcLfSPDkvVLJIjUKdo40QMdT+lqWYp/hEYMpPZORETKBnTQsfPxUgz
	nmePGnARD5yj1dAqT1Kx5i/XaR/Lqhg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1718892775;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2bOUA5QxJ31WCm6TPcJHCbjgJxpPmWHLpzok2TtDYqc=;
	b=miN6IEO0C7jAdufzLA7ujwgUOVZD2Kz32tibXGEWysr9O0buLyUIA2aBENYXrk12wrGJWa
	nJp2TA0rIFLNnACA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8419713AC1;
	Thu, 20 Jun 2024 14:12:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id srm0HOU4dGZwWgAAD6G6ig
	(envelope-from <hare@suse.de>); Thu, 20 Jun 2024 14:12:53 +0000
Message-ID: <cfb9db60-6ff0-4c3a-9252-57d5e9c64d65@suse.de>
Date: Thu, 20 Jun 2024 16:12:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v9 01/10] block: Pass blk_queue_get_max_sectors() a
 request pointer
Content-Language: en-US
To: John Garry <john.g.garry@oracle.com>, axboe@kernel.dk, kbusch@kernel.org,
 hch@lst.de, sagi@grimberg.me, jejb@linux.ibm.com,
 martin.petersen@oracle.com, viro@zeniv.linux.org.uk, brauner@kernel.org,
 dchinner@redhat.com, jack@suse.cz
Cc: djwong@kernel.org, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-fsdevel@vger.kernel.org, tytso@mit.edu, jbongio@google.com,
 linux-scsi@vger.kernel.org, ojaswin@linux.ibm.com, linux-aio@kvack.org,
 linux-btrfs@vger.kernel.org, io-uring@vger.kernel.org, nilay@linux.ibm.com,
 ritesh.list@gmail.com, willy@infradead.org, agk@redhat.com,
 snitzer@kernel.org, mpatocka@redhat.com, dm-devel@lists.linux.dev,
 Luis Chamberlain <mcgrof@kernel.org>
References: <20240620125359.2684798-1-john.g.garry@oracle.com>
 <20240620125359.2684798-2-john.g.garry@oracle.com>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20240620125359.2684798-2-john.g.garry@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.79 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[31];
	TAGGED_RCPT(0.00)[];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	R_RATELIMIT(0.00)[to_ip_from(RLusjj3u5c53i6g8q6enupwtij)];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,lists.infradead.org,mit.edu,google.com,linux.ibm.com,kvack.org,gmail.com,infradead.org,redhat.com,lists.linux.dev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,imap1.dmz-prg2.suse.org:helo]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240620_071259_960753_5E8C8829 
X-CRM114-Status: UNSURE (   9.74  )
X-CRM114-Notice: Please train this message.
X-Mailman-Approved-At: Thu, 20 Jun 2024 07:15:52 -0700
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

On 6/20/24 14:53, John Garry wrote:
> Currently blk_queue_get_max_sectors() is passed a enum req_op. In future
> the value returned from blk_queue_get_max_sectors() may depend on certain
> request flags, so pass a request pointer.
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Keith Busch <kbusch@kernel.org>
> Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>
> Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
> Signed-off-by: John Garry <john.g.garry@oracle.com>
> ---
>   block/blk-merge.c | 3 ++-
>   block/blk-mq.c    | 2 +-
>   block/blk.h       | 6 ++++--
>   3 files changed, 7 insertions(+), 4 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich


