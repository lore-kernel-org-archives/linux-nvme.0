Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55490EB64D8
	for <linux-nvme@archiver.kernel.org>; Wed, 21 Jun 2023 06:45:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qbhW/xtXawV8CcYB2r3wrfEJyjcnLGE2+cj2i7CdGr8=; b=L6c1BkDt944EO17uu0obBch08F
	8aKBpkTmPKaWbKHTbQNIzQOgluexWNCuF7hc3TOo6eNZLHScYUnmmFaEZs8gIUREA0EMb5YVUKley
	Wj+atFA1F49EdHmbv0Z4n+ATx62vF+Y4+nnI1VN1cVT46FrvmDx+9BntXPyoEz6b1ReIJzFy8vogY
	Y/fLuMBaNFs+/+E369clsTh8E2fVlhUgKiacioexa8Z0kc9B5eBfmed0qC17riKxhtcI4en4uzHlu
	het3uzEB/+TiACBIgfEkshgi18oqtOZMiBpWXwIM+iv6TuTE0HHR4mctY2jeTKPiOTgvU6kpusdZZ
	I9WzEC/w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qBraP-00DSno-2M;
	Wed, 21 Jun 2023 06:45:01 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qBraM-00DSkJ-1M
	for linux-nvme@lists.infradead.org;
	Wed, 21 Jun 2023 06:45:00 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 5EB861F895;
	Wed, 21 Jun 2023 06:44:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1687329896; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qbhW/xtXawV8CcYB2r3wrfEJyjcnLGE2+cj2i7CdGr8=;
	b=oYcKbW9d4asRiUSaLI7GdaATkUtnxaY3xnpXcr/RV/O9mIYKt4PnLWuzMT3xjpcYxZu+ve
	zfBbz//1xFBbZGD9xF+1F62O2Qv3hgRDAjyDETOwjcl9LkZTHZ+AwbUZi7+GN54jyrlPbW
	wqs0kVAd/SOkiNC1B4sn1N0KFR/dH/c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1687329896;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qbhW/xtXawV8CcYB2r3wrfEJyjcnLGE2+cj2i7CdGr8=;
	b=o0dhvQ653XkwtEuy5Ue/g1465bmo5k9uimtF/1EV7mcvN455BaUdNjZE1eh0W2DhzMlx5N
	e2oz699jB+575/Dg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0EC76134B1;
	Wed, 21 Jun 2023 06:44:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id 092mAmickmRbJgAAMHmgww
	(envelope-from <hare@suse.de>); Wed, 21 Jun 2023 06:44:56 +0000
Message-ID: <bae9a22a-246f-525e-d9a9-72a074d457c5@suse.de>
Date: Wed, 21 Jun 2023 08:44:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 4/4] net/tls: implement ->read_sock()
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>, Sagi Grimberg <sagi@grimberg.me>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 linux-nvme@lists.infradead.org, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 Boris Pismenny <boris.pismenny@gmail.com>
References: <20230620102856.56074-1-hare@suse.de>
 <20230620102856.56074-5-hare@suse.de>
 <5bbb6ce4-a251-a357-3efc-9e899e470b9c@grimberg.me>
 <20230620100843.19569d60@kernel.org>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20230620100843.19569d60@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230620_234458_613350_F46E8880 
X-CRM114-Status: GOOD (  20.24  )
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

On 6/20/23 19:08, Jakub Kicinski wrote:
> On Tue, 20 Jun 2023 16:21:22 +0300 Sagi Grimberg wrote:
>>> +	err = tls_rx_reader_lock(sk, ctx, true);
>>> +	if (err < 0)
>>> +		return err;
>>
>> Unlike recvmsg or splice_read, the caller of read_sock is assumed to
>> have the socket locked, and tls_rx_reader_lock also calls lock_sock,
>> how is this not a deadlock?
> 
> Yeah :|
> 
>> I'm not exactly clear why the lock is needed here or what is the subtle
>> distinction between tls_rx_reader_lock and what lock_sock provides.
> 
> It's a bit of a workaround for the consistency of the data stream.
> There's bunch of state in the TLS ULP and waiting for mem or data
> releases and re-takes the socket lock. So to stop the flow annoying
> corner case races I slapped a lock around all of the reader.
> 
> IMHO depending on the socket lock for anything non-trivial and outside
> of the socket itself is a bad idea in general.
> 
> The immediate need at the time was that if you did a read() and someone
> else did a peek() at the same time from a stream of A B C D you may read
> A D B C.

Leaving me ever so confused.

read_sock() is a generic interface; we cannot require a protocol 
specific lock before calling it.

What to do now?
Drop the tls_rx_read_lock from read_sock() again?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Ivo Totev, Andrew
Myers, Andrew McDonald, Martje Boudien Moerman


