Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C10B8C47422
	for <linux-nvme@archiver.kernel.org>; Mon, 29 Jan 2024 06:13:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Yrp94TYq45QaMPeRAcJ/u1E9m+KFKlPFqVFnEQJXKT0=; b=c8g02sBEes1G3pVVHFIYV0Y2Vj
	Pg5vvLgtdBWUPKlOMmNin327QU69LvJAuG18HduS9S/jsGMpeY7iY7mECnxU9d9Xdb+EC21T3ux2M
	WPeMvJ7AOohit3hBd+HXzrxZzlZkV4b+qASwEeqyt1j7ptbvyGgn9p6tMO3PSqFH1wpNNWsMc05TX
	7UqgS2LiBTzj+LawL/tLp3UU4vtWMKzBdyaRilN4fg/ZrM02Hpt6Ii1vKu9gUCpcIJxZZXrqC65FT
	03yKXfwZAylcH9RqqjAoksNJXvkQpf4TaJrKiWQN7cYKr/yL+1fm/aDfkLy59AFNuklu335Y4rcX9
	V5LEr3GQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rUKu5-0000000BQC1-0sh4;
	Mon, 29 Jan 2024 06:13:57 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rUKu1-0000000BQBA-2MRj
	for linux-nvme@lists.infradead.org;
	Mon, 29 Jan 2024 06:13:56 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 172141F7D1;
	Mon, 29 Jan 2024 06:13:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706508827; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Yrp94TYq45QaMPeRAcJ/u1E9m+KFKlPFqVFnEQJXKT0=;
	b=UcEd7+JD/uB/WZz0/uicJfk2EZPIJjWoV3FMQMmTWVXn/8AB52kTnt+Cbw8v8eum8InEI2
	UK0SwcY4R12QHjvBbqMw3rTJTwiJMC5KeF5yF4uRggfn0TvBpfZfXtaH2wpxrh/Ow7K/Va
	b11tjN2HclmH63Wf3ip3gU3MgTvtyAE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706508827;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Yrp94TYq45QaMPeRAcJ/u1E9m+KFKlPFqVFnEQJXKT0=;
	b=XcS+YpTLW+lg5fh1KoRq3MSnSsBEYFIJnLbrw5PmEC8tgc8HudpSszbpXQuMqyhq8JI/+I
	feqXDg8HCpKrv9Dw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706508827; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Yrp94TYq45QaMPeRAcJ/u1E9m+KFKlPFqVFnEQJXKT0=;
	b=UcEd7+JD/uB/WZz0/uicJfk2EZPIJjWoV3FMQMmTWVXn/8AB52kTnt+Cbw8v8eum8InEI2
	UK0SwcY4R12QHjvBbqMw3rTJTwiJMC5KeF5yF4uRggfn0TvBpfZfXtaH2wpxrh/Ow7K/Va
	b11tjN2HclmH63Wf3ip3gU3MgTvtyAE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706508827;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Yrp94TYq45QaMPeRAcJ/u1E9m+KFKlPFqVFnEQJXKT0=;
	b=XcS+YpTLW+lg5fh1KoRq3MSnSsBEYFIJnLbrw5PmEC8tgc8HudpSszbpXQuMqyhq8JI/+I
	feqXDg8HCpKrv9Dw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8799F12FF7;
	Mon, 29 Jan 2024 06:13:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id a/i8HhpCt2VyRQAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 29 Jan 2024 06:13:46 +0000
Message-ID: <af60faa7-42fc-475a-b28c-cd11fe45d19d@suse.de>
Date: Mon, 29 Jan 2024 07:13:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/14] block: add a max_user_discard_sectors queue limit
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Damien Le Moal <dlemoal@kernel.org>, Keith Busch <kbusch@kernel.org>,
 Sagi Grimberg <sagi@grimberg.me>, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org, virtualization@lists.linux.dev
References: <20240128165813.3213508-1-hch@lst.de>
 <20240128165813.3213508-6-hch@lst.de>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20240128165813.3213508-6-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-0.13 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 XM_UA_NO_VERSION(0.01)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 BAYES_HAM(-0.04)[57.70%];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 RCPT_COUNT_TWELVE(0.00)[14];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[lst.de:email,suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240128_221353_801027_B6BFC517 
X-CRM114-Status: GOOD (  12.79  )
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

On 1/28/24 17:58, Christoph Hellwig wrote:
> Add a new max_user_discard_sectors limit that mirrors max_user_sectors
> and stores the value that the user manually set.  This now allows
> updates of the max_hw_discard_sectors to not worry about the user
> limit.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   block/blk-settings.c   | 12 +++++++++---
>   block/blk-sysfs.c      | 18 +++++++++---------
>   include/linux/blkdev.h |  1 +
>   3 files changed, 19 insertions(+), 12 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Ivo Totev, Andrew McDonald,
Werner Knoblich


