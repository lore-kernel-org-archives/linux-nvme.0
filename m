Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63FE8C19F32
	for <linux-nvme@archiver.kernel.org>; Wed,  5 Mar 2025 12:25:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zJqsz2NVELIZl5yOknUz77xTPiHmarwJyXJIJqXem2Q=; b=J6lJZHig8WCn+r0w8XY8j6MTVm
	No4SZWaY4U8BGev83IVIWDdY2eRfMPCNMLtmRcpXUAtXtQD6phZxDQJrpZ6/rM7/yfSJ4llHamR6X
	m84pzjgId90Yic2iC9cdGEA9ObPXP2dIuRBJZ9YJ9NYx9oRoDwleCW6AYNs5JDvgT4LKmuAmsKs4V
	dveXU9MxeqDH7tqd5RPlrUhMvWZEfkQy66u0mu9fEzTIRVsYfNDqDElCY+YCLwraIpnlHFCDzM6Fi
	rX4uNqaA/Y6iEK4bz6dw/QCY7om88HOnFepKXXFpEE6ZCGmYs1w976273p8q6RbkeY6qqXewUZnw4
	K7iTy09A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tpnoU-000000080yE-3Nig;
	Wed, 05 Mar 2025 12:25:26 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tpn9X-00000007toY-2Fi0
	for linux-nvme@lists.infradead.org;
	Wed, 05 Mar 2025 11:43:08 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 8D7001F788;
	Wed,  5 Mar 2025 11:43:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1741174983; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zJqsz2NVELIZl5yOknUz77xTPiHmarwJyXJIJqXem2Q=;
	b=ebhiAuDnQS199TjZG8AAJpxugVhPJtLaq30vA2Idc/yDd3qx02vdR4t3zOfAr05bAhMjQj
	qyAZP+5pK5MWfA++UyOC1xvcpHmJ3sOydM2RAgrMHnG9Y6E2slVb6yCl2PqxFj18CAd0ed
	PmXkYdeypsVu2hGMkxzhVDsNLuD/qv4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1741174983;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zJqsz2NVELIZl5yOknUz77xTPiHmarwJyXJIJqXem2Q=;
	b=hwes1V/7+XDPlkDpuN18RUpOjUnTeIPkVaUJ94Xyo6Awr50qTOEOhnnd0yfpqHP0A4XKnp
	wxvbnqKFm5PYL/Cg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1741174983; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zJqsz2NVELIZl5yOknUz77xTPiHmarwJyXJIJqXem2Q=;
	b=ebhiAuDnQS199TjZG8AAJpxugVhPJtLaq30vA2Idc/yDd3qx02vdR4t3zOfAr05bAhMjQj
	qyAZP+5pK5MWfA++UyOC1xvcpHmJ3sOydM2RAgrMHnG9Y6E2slVb6yCl2PqxFj18CAd0ed
	PmXkYdeypsVu2hGMkxzhVDsNLuD/qv4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1741174983;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zJqsz2NVELIZl5yOknUz77xTPiHmarwJyXJIJqXem2Q=;
	b=hwes1V/7+XDPlkDpuN18RUpOjUnTeIPkVaUJ94Xyo6Awr50qTOEOhnnd0yfpqHP0A4XKnp
	wxvbnqKFm5PYL/Cg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5B8A11366F;
	Wed,  5 Mar 2025 11:43:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id c+yJFcc4yGfJGAAAD6G6ig
	(envelope-from <hare@suse.de>); Wed, 05 Mar 2025 11:43:03 +0000
Message-ID: <7439cb2f-6a97-494b-aa10-e9bebb218b58@suse.de>
Date: Wed, 5 Mar 2025 12:43:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Kernel oops with 6.14 when enabling TLS
To: Vlastimil Babka <vbabka@suse.cz>, Hannes Reinecke <hare@suse.com>,
 Matthew Wilcox <willy@infradead.org>
Cc: Boris Pismenny <borisp@nvidia.com>,
 John Fastabend <john.fastabend@gmail.com>, Jakub Kicinski <kuba@kernel.org>,
 Sagi Grimberg <sagi@grimberg.me>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 linux-mm@kvack.org, Harry Yoo <harry.yoo@oracle.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <Z8XPYNw4BSAWPAWT@casper.infradead.org>
 <edf65d4e-90f0-4b12-b04f-35e97974a36f@suse.cz>
 <95b0b93b-3b27-4482-8965-01963cc8beb8@suse.cz>
 <fcfa11c6-2738-4a2e-baa8-09fa8f79cbf3@suse.de>
 <a466b577-6156-4501-9756-1e9960aa4891@suse.cz>
 <6877dfb1-9f44-4023-bb6d-e7530d03e33c@suse.com>
 <db1a4681-1882-4e0a-b96f-a793e8fffb56@suse.cz>
 <Z8cm5bVJsbskj4kC@casper.infradead.org>
 <a4bbf5a7-c931-4e22-bb47-3783e4adcd23@suse.com>
 <Z8cv9VKka2KBnBKV@casper.infradead.org>
 <Z8dA8l1NR-xmFWyq@casper.infradead.org>
 <d9f4b78e-01d7-4d1d-8302-ed18d22754e4@suse.de>
 <27111897-0b36-4d8c-8be9-4f8bdbae88b7@suse.cz>
 <f53b1403-3afd-43ff-a784-bdd22e3d24f8@suse.com>
 <d6e65c4c-a575-4389-a801-2ba40e1d25e1@suse.cz>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <d6e65c4c-a575-4389-a801-2ba40e1d25e1@suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_TLS_ALL(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[nvidia.com,gmail.com,kernel.org,grimberg.me,lists.infradead.org,vger.kernel.org,kvack.org,oracle.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email,suse.de:mid]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250305_034307_792962_66335D06 
X-CRM114-Status: GOOD (  23.46  )
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

On 3/5/25 09:58, Vlastimil Babka wrote:
> On 3/5/25 09:20, Hannes Reinecke wrote:
>> On 3/4/25 20:44, Vlastimil Babka wrote:
>>> On 3/4/25 20:39, Hannes Reinecke wrote:
>> [ .. ]
>>>>
>>>> Good news and bad news ...
>>>> Good news: TLS works again!
>>>> Bad news: no errors.
>>>
>>> Wait, did you add a WARN_ON_ONCE() to the put_page() as I suggested? If yes
>>> and there was no error, it would have to be leaking the page. Or the path
>>> uses folio_put() and we'd need to put the warning there.
>>>
>> That triggers:
> ...
>> Not surprisingly, though, as the original code did a get_page(), so
>> there had to be a corresponding put_page() somewhere.
> 
> Is is this one? If there's no more warning afterwards, that should be it.
> 
> diff --git a/net/core/skmsg.c b/net/core/skmsg.c
> index 61f3f3d4e528..b37d99cec069 100644
> --- a/net/core/skmsg.c
> +++ b/net/core/skmsg.c
> @@ -182,9 +182,14 @@ static int sk_msg_free_elem(struct sock *sk, struct sk_msg *msg, u32 i,
>   
>          /* When the skb owns the memory we free it from consume_skb path. */
>          if (!msg->skb) {
> +               struct folio *folio;
> +
>                  if (charge)
>                          sk_mem_uncharge(sk, len);
> -               put_page(sg_page(sge));
> +
> +               folio = page_folio(sg_page(sge));
> +               if (!folio_test_slab(folio))
> +                       folio_put(folio);
>          }
>          memset(sge, 0, sizeof(*sge));
>          return len;
> 
> 
Oh, sure. But what annoys me: why do we have to care?

When doing I/O _all_ data is stuffed into bvecs via
bio_add_page(), and after that information about the
origin is lost; any iteration on the bio will be a bvec
iteration.
Previously we could just do a bvec iteration, get a reference
for each page, and start processing.
Now suddenly the caller has to check if it's a slab page and don't
get a reference for that. Not only that, he also has to remember
to _not_ drop the reference when he's done.
And, of course, tracing get_page() and the corresponding put_page()
calls through all the layers.
Really?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

