Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 116AD606A32C
	for <linux-nvme@archiver.kernel.org>; Mon, 23 Nov 2026 01:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=ZwQ4bpxH;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CsxJXzR1
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Subject:References:In-Reply-To:Message-Id:Cc:To:From:Date:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=iLrnKxxVMWKMeMeAgoH7MuH9sETQs3VlmpYHt8ql4sI=; b=ZwQ4bpxH7ZE5vt
	W1DJBHKj1Wfrn0VlzVVjDTSeqr+Txdyo3wwCCV9mKP73IHAxIyQ+4mw0h+3xXN2z3gADTJotaQo3c
	UOO1OVwLf82XyE/aLJRtHmSurXW0hPV62kNS4GWjbip0GTsRAfRi/vVVEAeGCo/P3ccyEnkcWugTB
	kndowLbsUDgugbdksrkWR9teAMrzV21ygmYzlmSpubxMpN7g23bAyjlq1/mdxQA6X76BA3ejIWWZd
	lOW6RYszVybKR+avr8hSRLmV2pQokLSohzkbgIh6Vk0dQ0vmZN8uHKntqcUWPTtjDPIj/2DRMfjtd
	f0dfYMIDcRWr73J/PffA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xVIPs-000000023I1-1GMR;
	Mon, 23 Nov 2026 01:00:20 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xVIPq-000000023Hr-3C8i
	for linux-nvme@lists.infradead.org;
	Mon, 23 Nov 2026 01:00:18 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 13BE061B36;
	Mon, 23 Nov 2026 01:00:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BE141F000CF;
	Mon, 23 Nov 2026 01:00:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795395617;
	bh=iLrnKxxVMWKMeMeAgoH7MuH9sETQs3VlmpYHt8ql4sI=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=CsxJXzR1yflwMnj8XPbzLcPCJmf70siSQZaD/VFXj0qrc7OmQbPjZKWb6v7NUd97p
	 EVgTwO478HHWS0KM3ejN5NFaQDfiovYLGaIFk/jqhi/d/bc40penOkQnCwCjKzxiLC
	 yXr5ITyUVKhoz0ayrlF8wOHVIGvf2t2NWQqbpA6LtNSn6hpvmAPvkpsAs5MLkioiJT
	 CUUm6HKvIMtH47SbOJ/xbyJ4P8UHzzMsHrq4ycDpt//TR2rNRV3ZxKyOmlWAyAsyM1
	 nqac3iYrMpm4VRK2JBMIBbGiHdBKMmds3Eq52DD8dRrl4NPx3SNhIC8a3ww2MrMXyw
	 ron5q8LYyDA4g==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 6EB60F40068;
	Sun, 22 Nov 2026 20:00:16 -0500 (EST)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Sun, 22 Nov 2026 20:00:16 -0500
X-ME-Sender: <xms:IJADa4sWS_dWu437hzP3u_w67qUb75GfYEhu1TxxpCUo9Lsq218FBA>
    <xme:IJADawRP7O4VUoTS_etAOCQEWoybhwVvPLWPNNTfEGqh-zjIwSRE_ZZhNHMnwcGq9
    dNTDm10gIMcCymq22gB5myU20ajGQDo42acDS00hnC1bwIFCWIxBcw>
X-ME-Proxy-Cause: dmFkZTFIEef34L9gI7dEhgKcCVtUw+ZHC7e1XQRRVaW1n+cw99FavR/qIyYWKGr2MqAkqJ
    6dhS7cnALR9U3ZGnrXPxbBjkn2gnPlsDeJJbmilHbZ2LoGNqFSZCVPqRmwTEDmqyQNYEwL
    6eMHNPgd/OyeBZuEpy31PIQfTrMNWhreYLasRbhMUMpxMEyQE1jfdf6ma5OFi5/yUoVRUB
    WKxkGewiptcJ0vE4zUWHQdVw7V6g0usmVnBmOU8E1DJl2AUHmLqFSQxtbEFxPZerZ+9DZl
    CF6V81tXc9kuP1iBWOa4WhpAf5TahRuYRKw8944qHu1bekT0hg2JpuWuP2dT5kLq7DfXjl
    nbMAXZ6W6YXQb9BCsBJLYHO9fydxixQTjnwYQ5oBG3KjeLcw5kzd9XDkqkmTMIwtj4pxI5
    wxEnYzFYasHvRGuYX5dij4IlMU8YdbtToqGlBnFZ9KPMKQy94rItjr69cl0QiROLWpS+xy
    BnJ6U7bmmpXGdXOzjITEFLcSwkYbpW59VGWKDrbOCGiccG+GFmaOog4xnBlMVQBKr0ZFHJ
    ERCaDhj+x325PLeYXpu+AniAdKkuKQQEUP0gsSq58IrTLMdImBLQ6/JJLNgKKdUHrvAhTh
    6ZxcRxRCMuSxXSV6lN0iX9waARWZUoaGEGPlXS/hUM4tmI0eHdeqUZkAIk3A
X-ME-Proxy: <xmx:IJADa9tgInJBZbfsFld5p5JrI8Itckc4f2VozugegDhGM907yqycEQ>
    <xmx:IJADa7Xy3LG_ZOZ_qvzau2WE8U1-A1vvhHRRtX6mX1YxYtEAPjVoAg>
    <xmx:IJADa-UFKkrlDBOhAa5-6tdDePlsI-glyEWAKNNR6eCa_YplXYYaAg>
    <xmx:IJADa2QQ72b8k_XUKhSAfqzxdUmM6n0BgsgzQFMq0W7EM-xYGnzUaA>
    <xmx:IJADa9Er_AzpJ81CrK5IEChZ9fPPJmpYEvNOo-MdKuZvbqLn-BZDi3o4>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 438A0780070; Sun, 22 Nov 2026 20:00:16 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-ThreadId: A8Z6fJDuAPLk
Date: Sun, 22 Nov 2026 19:59:56 -0500
From: "Chuck Lever" <cel@kernel.org>
To: "Jakub Kicinski" <kuba@kernel.org>
Cc: "Donald Hunter" <donald.hunter@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, "Paolo Abeni" <pabeni@redhat.com>,
 "Simon Horman" <horms@kernel.org>,
 "John Fastabend" <john.fastabend@gmail.com>,
 "Sabrina Dubroca" <sd@queasysnail.net>, "Keith Busch" <kbusch@kernel.org>,
 "Jens Axboe" <axboe@kernel.dk>, "Christoph Hellwig" <hch@lst.de>,
 "Sagi Grimberg" <sagi@grimberg.me>, "Chaitanya Kulkarni" <kch@nvidia.com>,
 "Jeff Layton" <jlayton@kernel.org>, NeilBrown <neil@brown.name>,
 "Olga Kornievskaia" <okorniev@redhat.com>, "Dai Ngo" <Dai.Ngo@oracle.com>,
 "Tom Talpey" <tom@talpey.com>, "Eric Dumazet" <edumazet@kernel.org>,
 kernel-tls-handshake@lists.linux.dev, netdev@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-nfs@vger.kernel.org,
 "Hannes Reinecke" <hare@kernel.org>
Message-Id: <b76fc2c2-466c-4638-876a-3f9af436d29a@app.fastmail.com>
In-Reply-To: <20261121161302.69f202c8@kernel.org>
References: <20261113-tls-session-tags-v3-0-91271964cdb0@kernel.org>
 <20261121161302.69f202c8@kernel.org>
Subject: Re: [PATCH net-next v3 00/10] Deliver TLS session tags to upper-layer
 consumers (NFSD)
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On Sat, Nov 21, 2026, at 7:13 PM, Jakub Kicinski wrote:
> On Fri, 13 Nov 2026 14:21:58 -0500 Chuck Lever wrote:
>> NFSD controls remote access to its exports today by IP address and
>> hostname. Neither of these are cryptographically secure. For
>> instance, a MitM can replace the response to a server's plaintext
>> DNS query. As a result, a malicious NFS client can pretend to be a
>> client whose hostname matches one that has access to exports it
>> would otherwise be denied access to.
>> 
>> So instead, we want access-control decisions to be based on
>> cryptographically-vetted objects such as TLS peer-certificates.
>> In-kernel x.509 parsing would duplicate work mature userspace
>> libraries already do, so let's make tlshd evaluate peer certificates
>> in user space.
>> 
>> The certificates are evaluated against admin-defined policy, such
>> as whether the certificate's Issuer matches a particular string.
>> tlshd then marks NFS TLS sessions with those policy matches. Admins
>> also provide a set of policy names on each NFSD export (allow_tags).
>> Computing the intersection with these per-export tags is quick and
>> completely separate from the details of parsing x.509 certificates.
>> 
>> A yet-to-be-posted patch series introduces tag set support to the
>> exportfs command in nfs-utils. tlshd 1.5.0, current as of this
>> writing, already implements TLS session tagging.
>
> I submitted this for AI review now, I think due to the problem
> Simon flagged CI didn't just gobble it up automatically.
> The AI review will not be emailed to the list automatically but
> hopefully it will be ready here by the time you read this:
> https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261113-tls-session-tags-v3-3-91271964cdb0@kernel.org

There are some drips and drabs here. I can re-roll, and think more
about higher level policy-based access control.


> Any examples of APIs like the one you're adding working well?

I found one or two while developing these a year ago. Nothing
is leaping to mind at the moment, though.


-- 
Chuck Lever (Come to NFS bake-a-thon! https://nfsv4bat.org)

