Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C840DC282D9
	for <linux-nvme@archiver.kernel.org>; Tue,  4 Mar 2025 19:40:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=98gqWV++H4CGrTOO1RWIa1Ttz+WIPNmSFDAZVZZFF50=; b=xqgfJUTFKdR/RvmjbDotsA5KD0
	5PYV05FrUUZP7C8/zaCKxmtHHgD1IYJIWxFfEY5gx5Mli1TSIp+PHh+rs7xgz8yICm42q7Srr38ix
	jYPd4jg/jw2U7RyanE+UPw3Se14awxk5rzYM7t+qlRYRTJgbA1G+hyRpFITBETSHIuiCh5KiDmHoP
	6tqI4c7dVND3pYt/FAswlpYF8aTyvPZReHu/7S42MUhrJWxZ6d/BWwprHQ+CrYT15JMCtq1VAvH/1
	xGPC1Tt4zFzNWMDMgC1fzlfaiuzElnGm4pPqWTraAGR9zTa6HMueomgC48ZrBQnNKcWT3RUrtTi05
	zzMArRHw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tpY7f-000000063oc-3oAb;
	Tue, 04 Mar 2025 19:40:11 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tpX5F-00000005rgy-0CmP
	for linux-nvme@bombadil.infradead.org;
	Tue, 04 Mar 2025 18:33:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description;
	bh=98gqWV++H4CGrTOO1RWIa1Ttz+WIPNmSFDAZVZZFF50=; b=shoNOOBlDSyrVlY7aaosv3nZFc
	KxMW4c5Md0WbVS/b7qDEvCAJBCUdVNU0d/FBrxuNo+Fgw3MIQJdXRdZ4en/ylC9cAOEHQ5hMozKb5
	oV3CjLvrFQyYxrg+7A5OAG5seJoMq7IxZXoCtCMb1odq3GsGAFXeB0DayrkKuGo46/ZYfze5wqDkp
	OjYJ3BQEWfu4JXKcXtZyJL5ND9Ftor7L5rrChlsUKWZLe0jSTebimjapwDCFV6ekKvN4mkdnxIV7N
	CbZYOed5BWxMlSJQxDuC2NMyQq+WeTVSWGI9l12n9knnPE9D/awZg0mJJo3bKHUGOQ4IiQijhjrOC
	+D1D+u9w==;
Received: from smtp-out1.suse.de ([195.135.223.130])
	by casper.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tpX3K-00000002rL1-04hd
	for linux-nvme@lists.infradead.org;
	Tue, 04 Mar 2025 18:32:14 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 5DF272119C;
	Tue,  4 Mar 2025 18:31:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1741113095; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=98gqWV++H4CGrTOO1RWIa1Ttz+WIPNmSFDAZVZZFF50=;
	b=iGF8nCVEghjpKrLCZOiCymKnzhoQswaqs64TGfxMeJuzOWT65W3XrZGN3v7AV+UyssMp/e
	ix3h0g+2RQLxjOBsOqc+/K0nPQk8tYbtSp8sQNbJQBUOg6641nTakn8p9+tPvN/HzJwlJi
	QqcDWvUaUsXt3egrKVYrhqDXfqfYCuE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1741113095;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=98gqWV++H4CGrTOO1RWIa1Ttz+WIPNmSFDAZVZZFF50=;
	b=hTcdK1Gab110pYfgKOYtAYZqF16LnhApuOLx/MpF+2NvteiHs6G9ED1jz9tWhjBL8p3eup
	6zXkZrcVonC9GPDw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1741113095; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=98gqWV++H4CGrTOO1RWIa1Ttz+WIPNmSFDAZVZZFF50=;
	b=iGF8nCVEghjpKrLCZOiCymKnzhoQswaqs64TGfxMeJuzOWT65W3XrZGN3v7AV+UyssMp/e
	ix3h0g+2RQLxjOBsOqc+/K0nPQk8tYbtSp8sQNbJQBUOg6641nTakn8p9+tPvN/HzJwlJi
	QqcDWvUaUsXt3egrKVYrhqDXfqfYCuE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1741113095;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=98gqWV++H4CGrTOO1RWIa1Ttz+WIPNmSFDAZVZZFF50=;
	b=hTcdK1Gab110pYfgKOYtAYZqF16LnhApuOLx/MpF+2NvteiHs6G9ED1jz9tWhjBL8p3eup
	6zXkZrcVonC9GPDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 438B31393C;
	Tue,  4 Mar 2025 18:31:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 6mMpEAdHx2fefQAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Tue, 04 Mar 2025 18:31:35 +0000
Message-ID: <2290e466-4294-47ce-a1b1-9f05fa3c6e32@suse.cz>
Date: Tue, 4 Mar 2025 19:31:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Kernel oops with 6.14 when enabling TLS
Content-Language: en-US
To: Matthew Wilcox <willy@infradead.org>, Hannes Reinecke <hare@suse.com>
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
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 EP+ylKVEKb0Q2A==
In-Reply-To: <Z8dA8l1NR-xmFWyq@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	TAGGED_RCPT(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[nvidia.com,gmail.com,kernel.org,grimberg.me,lists.infradead.org,vger.kernel.org,kvack.org,oracle.com];
	MIME_TRACE(0.00)[0:+];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250304_183203_598238_95F51D9C 
X-CRM114-Status: GOOD (  15.38  )
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

On 3/4/25 19:05, Matthew Wilcox wrote:
> On Tue, Mar 04, 2025 at 04:53:09PM +0000, Matthew Wilcox wrote:
>> Right, that's what happened in the block layer.  We mark the bio with
>> BIO_PAGE_PINNED if the pincount needs to be dropped.  As a transitional
>> period, we had BIO_PAGE_REFFED which indicated that the page refcount
>> needed to be dropped.  Perhaps there's something similar that network
>> could be doing.
> 
> Until that time ... how does this look as a quick hack to avoid
> reverting the slab change?
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index d6fed25243c3..ca08a923ac6d 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -1520,7 +1520,10 @@ static inline void folio_get(struct folio *folio)
>  
>  static inline void get_page(struct page *page)
>  {
> -	folio_get(page_folio(page));
> +	struct folio *folio = page_folio(page);
> +	if (WARN_ON_ONCE(folio_test_slab(folio)))
> +		return;
> +	folio_get(folio);

Maybe we could do just VM_WARN_ON_ONCE if we fix the known offender fully.

>  }
>  
>  static inline __must_check bool try_get_page(struct page *page)
> @@ -1614,6 +1617,8 @@ static inline void put_page(struct page *page)
>  {
>  	struct folio *folio = page_folio(page);
>  
> +	if (folio_test_slab(folio))
> +		return;

And that means knowing where the put_page() side is and skipping it for slab
pages like for the get_page() side below. Hannes could you apply this patch
but also with WARN_ON_ONCE here in put_page()? And tell us where the
put_page() splats. Thanks!

>  	folio_put(folio);
>  }
>  
> diff --git a/lib/iov_iter.c b/lib/iov_iter.c
> index 65f550cb5081..8c7fdb7d8c8f 100644
> --- a/lib/iov_iter.c
> +++ b/lib/iov_iter.c
> @@ -1190,8 +1190,12 @@ static ssize_t __iov_iter_get_pages_alloc(struct iov_iter *i,
>  		if (!n)
>  			return -ENOMEM;
>  		p = *pages;
> -		for (int k = 0; k < n; k++)
> -			get_page(p[k] = page + k);
> +		for (int k = 0; k < n; k++) {
> +			struct folio *folio = page_folio(page);
> +			p[k] = page + k;
> +			if (!folio_test_slab(folio))
> +				folio_get(folio);
> +		}
>  		maxsize = min_t(size_t, maxsize, n * PAGE_SIZE - *start);
>  		i->count -= maxsize;
>  		i->iov_offset += maxsize;


