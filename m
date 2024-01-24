Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29CC5C46CD2
	for <linux-nvme@archiver.kernel.org>; Wed, 24 Jan 2024 06:12:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=udd3HW/OJ3qxeYOiR3o1RLD5AKysJyGUjUBIu/iAPa4=; b=K5azQWajwE3iGCA7UB6zOchc9t
	YrEnCXzyAKFOfw0r+je3pKQKQsQl/v0DAN0dvxFM7FIj9TYEz+WvjyvKcFsDEsVn8fuzMz7HTgU00
	cqLLNV9Xs3kiOGYb4KSgvMKpfvvOZR/Dxr3k3VQe2spIrNu5Shgs+XaPytR9c8OMwlUfX/3higNxT
	BdiYtpIPWVyo86MIh62YhCGQgx2s2ePj3bzh0MVDueDvvR4WJPO49sTfobTagYsJxlfb3FHsdZNmX
	pM1uLUPSegBhBi0RozqXkOrkq4ytfIx1AmS22mX9cdF0vliovCIVSOITVXJOhRkZdsVu6yQfNqPHz
	0D1ZW7ow==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rSWUw-001gts-1C;
	Wed, 24 Jan 2024 06:12:30 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rSWUt-001gs1-2d
	for linux-nvme@lists.infradead.org;
	Wed, 24 Jan 2024 06:12:29 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 381F11F7DA;
	Wed, 24 Jan 2024 06:12:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706076746; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=udd3HW/OJ3qxeYOiR3o1RLD5AKysJyGUjUBIu/iAPa4=;
	b=z8KMZ1c3vhEylryzpkiEtI77edu6jzcWHkQuZQHsZzLTu063QlXGaawLmP6LQ+JgZqGive
	NTicebaWWHx+tWxtQQ8uwDSVqb8A+UaSxKrQ0PCX5QFe8IXb6CbHw8Aj6ydgiC1zngAFgt
	vee9blyEOrFGYJ0hrhSl+Kj2VKqATJ8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706076746;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=udd3HW/OJ3qxeYOiR3o1RLD5AKysJyGUjUBIu/iAPa4=;
	b=FyFtRMW7GVAYVVe+BAWBDkagC/ZF1oe7ImYbEwwnQOqCAeg7/yb1QFhyqBUmO7maWRKl9B
	eE6askof2T5RwCDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706076746; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=udd3HW/OJ3qxeYOiR3o1RLD5AKysJyGUjUBIu/iAPa4=;
	b=z8KMZ1c3vhEylryzpkiEtI77edu6jzcWHkQuZQHsZzLTu063QlXGaawLmP6LQ+JgZqGive
	NTicebaWWHx+tWxtQQ8uwDSVqb8A+UaSxKrQ0PCX5QFe8IXb6CbHw8Aj6ydgiC1zngAFgt
	vee9blyEOrFGYJ0hrhSl+Kj2VKqATJ8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706076746;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=udd3HW/OJ3qxeYOiR3o1RLD5AKysJyGUjUBIu/iAPa4=;
	b=FyFtRMW7GVAYVVe+BAWBDkagC/ZF1oe7ImYbEwwnQOqCAeg7/yb1QFhyqBUmO7maWRKl9B
	eE6askof2T5RwCDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 905ED1333E;
	Wed, 24 Jan 2024 06:12:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id cOfQHUmqsGVVRwAAD6G6ig
	(envelope-from <hare@suse.de>); Wed, 24 Jan 2024 06:12:25 +0000
Message-ID: <a9b57560-5ebc-44b4-83cb-11a3205fec8c@suse.de>
Date: Wed, 24 Jan 2024 07:12:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/15] block: use queue_limits_commit_update in
 queue_discard_max_store
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Damien Le Moal <dlemoal@kernel.org>, Keith Busch <kbusch@kernel.org>,
 Sagi Grimberg <sagi@grimberg.me>, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org, virtualization@lists.linux.dev
References: <20240122173645.1686078-1-hch@lst.de>
 <20240122173645.1686078-8-hch@lst.de>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20240122173645.1686078-8-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-1.38 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 XM_UA_NO_VERSION(0.01)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 BAYES_HAM(-0.09)[64.72%];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_TWELVE(0.00)[14];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[lst.de:email,suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240123_221228_003413_3801E0E2 
X-CRM114-Status: GOOD (  11.62  )
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

On 1/22/24 18:36, Christoph Hellwig wrote:
> Convert queue_discard_max_store to use queue_limits_commit_update to
> check and updated the max_sectors limit and freeze the queue before
> doing so to ensure we don't have request in flight while changing
> the limits.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   block/blk-sysfs.c | 14 ++++++++++----
>   1 file changed, 10 insertions(+), 4 deletions(-)
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


