Return-Path: <SRS0=l2Ft=BH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0339FC433DF
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Jul 2020 09:43:16 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C2BC020786
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Jul 2020 09:43:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="sIUfzH0f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2BC020786
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:References:
	To:From:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=wyFEtfn7sLrVJfR4/zzo/2pUQE7OWElDQ+xiMFhhsl8=; b=sIUfzH0fygTUE5orUhGGqXCjl
	1jdrWeSWYdweilDWB2Q0YlsgKNR8V5QTk7F9n6nsOzMiiZWl79u3SjhUUOfwowBgqhD7gA2K5SDu9
	ApjU6qYLfbD9ssokAHOhJAidemlllgWRITOXDE/yp120zWeNHsM+POymUYy8Yu+hEs+miYkWyiBPF
	oNjK/ZzqnnwyafSiZsWc7n8bSGe2w9rkHI6qDp2/zwwoi0uaDhZANjiANx/cjMmy2WNc41Er0jMBr
	KgtVFOk3PE2DcUePMn7QFh4UaqQNicz/da6zPPrRH9DMVVBB6h8/dJ1xSx1XRX5UatVYi6wwDMnjE
	rnGAPENoQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k0M8d-0003za-OE; Tue, 28 Jul 2020 09:43:11 +0000
Received: from mail-pj1-f68.google.com ([209.85.216.68])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k0M8a-0003yn-Vh
 for linux-nvme@lists.infradead.org; Tue, 28 Jul 2020 09:43:09 +0000
Received: by mail-pj1-f68.google.com with SMTP id a9so11209868pjd.3
 for <linux-nvme@lists.infradead.org>; Tue, 28 Jul 2020 02:43:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:cc:references:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=UUVmTpxXz4wQsES92rzvuhj8anv3EYHGJFmNkZcSM/I=;
 b=pDVOjw3C+aSDooiZRhIESAxjSaY0VStUT3Xjr+dd9la9OD1FJLsjYEWIOwi9EGeeiF
 u7RSy0SCUmX+W7jZ3pVR6V9J3MZRHjG6/nIMp9p7h7F/ZksvynUtwnjoIdBJgN4+pMjf
 ZI75WBdUo/qc/6JIcABkY9PiJUVElozU5XbOqNsP5cBAMSV5vJSaRGCu1WWPjVp9Rb8k
 hp5x29kWK8Yd/KYrt2m9yRXBl1TmQHpa3pDB+1MHNajdkuAAC4bBpZVpqviNFtkExuuf
 iyDfZ5W3wyItV5TifOdfb66VYzvgu0D3vIuRK6jp7FcHV1gPm4UqYcIBIMjFU/VlN2NJ
 6/iA==
X-Gm-Message-State: AOAM530b051JvRqSTOrNbKR4+jOMLtjS9d6rfEjStGwC3Bvs3Icn7HUU
 lUZYCJCfMRQ02TGtAN9KunQ=
X-Google-Smtp-Source: ABdhPJx0SNP3y2ppgHVkQbLyOdkXsmyvE9dQdhMdVCWwleLidD7zxMzyb4xKz6wGjiw9QXka6LdejA==
X-Received: by 2002:a17:902:8498:: with SMTP id
 c24mr22772382plo.332.1595929388125; 
 Tue, 28 Jul 2020 02:43:08 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:541c:8b1b:5ac:35fe?
 ([2601:647:4802:9070:541c:8b1b:5ac:35fe])
 by smtp.gmail.com with ESMTPSA id k125sm1078093pga.48.2020.07.28.02.43.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Jul 2020 02:43:07 -0700 (PDT)
Subject: Re: [PATCH v5 1/2] blk-mq: add tagset quiesce interface
From: Sagi Grimberg <sagi@grimberg.me>
To: Ming Lei <ming.lei@redhat.com>
References: <20200727231022.307602-1-sagi@grimberg.me>
 <20200727231022.307602-2-sagi@grimberg.me> <20200728071859.GA21629@lst.de>
 <20200728091633.GB1326626@T590>
 <b1e7c2c5-dad5-778c-f397-6530766a0150@grimberg.me>
 <20200728093326.GC1326626@T590>
 <44f07df6-3107-3e7f-ee02-7bc43293ee6b@grimberg.me>
Message-ID: <6a678d5d-22b2-5238-92c5-d68e2aafeb9e@grimberg.me>
Date: Tue, 28 Jul 2020 02:43:06 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <44f07df6-3107-3e7f-ee02-7bc43293ee6b@grimberg.me>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200728_054309_085714_CC8C5366 
X-CRM114-Status: GOOD (  17.90  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Jens Axboe <axboe@kernel.dk>, "Paul E. McKenney" <paulmck@kernel.org>,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 Chao Leng <lengchao@huawei.com>, Keith Busch <kbusch@kernel.org>,
 Ming Lin <mlin@kernel.org>, Christoph Hellwig <hch@lst.de>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Cj4+Pj4+IEkgbGlrZSB0aGUgdGFnc2V0IGJhc2VkIGludGVyZmFjZS7CoCBCdXQgdGhlIGlkZWEg
b2YgZG9pbmcgYSBwZXItaGN0eAo+Pj4+PiBhbGxvY2F0aW9uIGFuZCB3YWl0IGRvZXNuJ3Qgc2Vl
bSB2ZXJ5IHNjYWxhYmxlLgo+Pj4+Pgo+Pj4+PiBQYXVsLCBkbyB5b3UgaGF2ZSBhbnkgZ29vZCBp
ZGVhIGZvciBhbiBpbnRlcmZhY2UgdGhhdCB3YWl0cyBvbgo+Pj4+PiBtdWx0aXBsZSBzcmN1IGhl
YWRzP8KgIEFzIGZhciBhcyBJIGNhbiB0ZWxsIHdlIGNvdWxkIGp1c3QgaGF2ZSBhIHNpbmdsZQo+
Pj4+PiBnbG9iYWwgY29tcGxldGlvbiBhbmQgY291bnRlciwgYW5kIGVhY2ggY2FsbF9zcmN1IHdv
dWxkIGp1c3QganVzdAo+Pj4+PiBkZWNyZW1lbnQgaXQgYW5kIHRoZW4gdGhlIGZpbmFsIG9uZSB3
b3VsZCBkbyB0aGUgd2FrZXVwLsKgIEl0IHdvdWxkIAo+Pj4+PiBqdXN0Cj4+Pj4+IGJlIGdyZWF0
IHRvIGZpZ3VyZSBvdXQgYSB3YXkgdG8ga2VlcCB0aGUgc3RydWN0IHJjdV9zeW5jaHJvbml6ZSBh
bmQKPj4+Pj4gY291bnRlciBvbiBzdGFjayB0byBhdm9pZCBhbiBhbGxvY2F0aW9uLgo+Pj4+Pgo+
Pj4+PiBCdXQgaWYgd2UgY2FuJ3QgZG8gd2l0aCBhbiBvbi1zdGFjayBvYmplY3QgSSdkIG11Y2gg
cmF0aGVyIGp1c3QgZW1iZWRkCj4+Pj4+IHRoZSByY3VfaGVhZCBpbiB0aGUgaHdfY3R4Lgo+Pj4+
Cj4+Pj4gSSB0aGluayB3ZSBjYW4gZG8gdGhhdCwgcGxlYXNlIHNlZSB0aGUgZm9sbG93aW5nIHBh
dGNoIHdoaWNoIGlzIAo+Pj4+IGFnYWluc3QgU2FnaSdzIFY1Ogo+Pj4KPj4+IEkgZG9uJ3QgdGhp
bmsgeW91IGNhbiBzZW5kIGEgc2luZ2xlIHJjdV9oZWFkIHRvIG11bHRpcGxlIGNhbGxfc3JjdSAK
Pj4+IGNhbGxzLgo+Pgo+PiBPSywgdGhlbiBvbmUgdmFyaWFudCBpcyB0byBwdXQgdGhlIHJjdV9o
ZWFkIGludG8gYmxrX21xX2h3X2N0eCwgYW5kIHB1dAo+PiByY3Vfc3luY2hyb25pemUgaW50byBi
bGtfbXFfdGFnX3NldC4KPiAKPiBJIGNhbiBjb29rIHVwIGEgc3BpbiwKCk5vcGUuLiBzcG9rZSB0
b28gc29vbiwgdGhlIHJjdV9oZWFkIG5lZWRzIHRvIGJlIGluIGEgY29udGV4dCB0aGF0IGhhcwph
Y2Nlc3MgdG8gdGhlIGNvdW50ZXIgKHdoaWNoIGlzIHdoYXQgeW91IGNhbGxlZCBibGtfbXFfc3Jj
dV9zeW5jKS4KeW91IHdhbnQgdG8gYWRkIGFsc28gYSBwb2ludGVyIHRvIGhjdHg/IHRoYXQgaXMg
YWxtb3N0IGFzIGJpZyBhcwpyY3Vfc3luY2hyb25pemUuLi4KCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4LW52bWUgbWFpbGluZyBsaXN0CkxpbnV4
LW52bWVAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWls
bWFuL2xpc3RpbmZvL2xpbnV4LW52bWUK
