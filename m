Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9659DEB64DC
	for <linux-nvme@archiver.kernel.org>; Fri, 21 Jul 2023 06:03:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OPBQuRzNxQw18t9j+rYQduOBhkqtLoro+aysNop9G+I=; b=h6EovfZjzrs+QSahsch8Qble3J
	gbWZNunMb7yPdDqyvp3hwWutYkaZZNt0Mw5EFHFdorG0eg55BhfFG6jFa+4Al5uSFmb16pyRSFdRB
	OA4ThrWS57xLFT+t42Nqg3SlXq2KGMhrN/k+VjAZZk9AnrC00xBq9CUttddowAz5lIIKlxb2+CQvn
	DCWY98RYk11DAuzwogV4gz6guddAVP/mK6RQm1xLnRfu5YviolbQFBttWF+SUks6VEPKB9hJ8zLrI
	t2gH5GyLNY1SwZ67QTIZzWB5hoMKJhx97Wy0oH848qzqe1ZamnXzm9TnyRF6Ux39ncnOaZ3asS4Rd
	fCv5qsyA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qMjEk-00CzbF-0V;
	Fri, 21 Jul 2023 06:03:34 +0000
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qMjEg-00CzaK-2t
	for linux-nvme@lists.infradead.org;
	Fri, 21 Jul 2023 06:03:32 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id F3BC1206EC;
	Fri, 21 Jul 2023 06:03:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1689919408; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OPBQuRzNxQw18t9j+rYQduOBhkqtLoro+aysNop9G+I=;
	b=OyK0x8dD0Le9yHUzL5KpsVi50NeXgm58G/WnxaPWLIgjOP16FLkmkiNT06IPYkcQhf+jl3
	POm8WOp2pXD79yhiliFwoXX/7jt0sjwe3O3F+rAGwswUusWxBhN+uJPGJ9olYD//A/hSEn
	00e3O2FR54QKQdzO5SctGCkGX0Wfilo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1689919408;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OPBQuRzNxQw18t9j+rYQduOBhkqtLoro+aysNop9G+I=;
	b=+BmOmsWv6NDklO/L72/NX4lOWMztuiZZhmno/x+yVkrdfZMUetNUy4JnedLXJhGoK2RGcI
	o9NFACVqJjB6ChAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BC84E134BA;
	Fri, 21 Jul 2023 06:03:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id w7woLa8fumRgDAAAMHmgww
	(envelope-from <hare@suse.de>); Fri, 21 Jul 2023 06:03:27 +0000
Message-ID: <985419bf-adfa-15fa-056d-743e18149257@suse.de>
Date: Fri, 21 Jul 2023 08:03:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 6/6] net/tls: implement ->read_sock()
To: Simon Horman <simon.horman@corigine.com>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 Boris Pismenny <boris.pismenny@gmail.com>
References: <20230719113836.68859-1-hare@suse.de>
 <20230719113836.68859-7-hare@suse.de> <ZLl9wUxKrZpgHMxY@corigine.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <ZLl9wUxKrZpgHMxY@corigine.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230720_230331_084734_33CEC385 
X-CRM114-Status: GOOD (  16.52  )
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

On 7/20/23 20:32, Simon Horman wrote:
> On Wed, Jul 19, 2023 at 01:38:36PM +0200, Hannes Reinecke wrote:
> 
> ...
> 
> Hi Hannes,
> 
>> diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
>> index d0636ea13009..4829d2cb9a7c 100644
>> --- a/net/tls/tls_sw.c
>> +++ b/net/tls/tls_sw.c
>> @@ -2202,6 +2202,102 @@ ssize_t tls_sw_splice_read(struct socket *sock,  loff_t *ppos,
>>   	goto splice_read_end;
>>   }
>>   
>> +int tls_sw_read_sock(struct sock *sk, read_descriptor_t *desc,
>> +		     sk_read_actor_t read_actor)
>> +{
>> +	struct tls_context *tls_ctx = tls_get_ctx(sk);
>> +	struct tls_sw_context_rx *ctx = tls_sw_ctx_rx(tls_ctx);
>> +	struct strp_msg *rxm = NULL;
>> +	struct tls_msg *tlm;
>> +	struct sk_buff *skb;
>> +	struct sk_psock *psock;
>> +	ssize_t copied = 0;
>> +	bool bpf_strp_enabled;
>> +	int err, used;
>> +
>> +	psock = sk_psock_get(sk);
>> +	err = tls_rx_reader_acquire(sk, ctx, true);
>> +	if (err < 0)
>> +		goto psock_put;
> 
> skb is uninitialised here,
> however, it is used in the psock_put unwind path.
> 
> Flagged by gcc-12 [-Wmaybe-uninitialized] and Smatch.
> 
Will fix it up in the next round.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Ivo Totev, Andrew
Myers, Andrew McDonald, Martje Boudien Moerman


