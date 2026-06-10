Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6019CD8CB2
	for <linux-nvme@archiver.kernel.org>; Wed, 10 Jun 2026 13:44:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Subject:References:In-Reply-To:Message-Id:Cc:To:From:Date:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wPPDhxKh3hPc6l1/pq4WkUoyCmQ73QpGV3SN3sLOFRo=; b=niR1yoa0LMWpT0r/LXohfWjVHc
	cZEFe3AxV/db2yv4kItqyXgi7WVhRfxgsGNFLpE7bKvGlyjZl6f3JqGPM6UEq9112Fd7as3tJ/fH+
	v5bvdHXk94tTMgvyU4QK80C32YHU9qCMiYLy6NmruIEowMIyFTm+cIEhuz6HvcTQcUB8+2IDFsf2b
	fiuVhJV5TAii/nMzobXHDe+PHoDR61jDkUbDZM9w4X9aVFORIKP7XKxVAT3nHwJEVJ+G7LoStDLeN
	KUj4gQM/tsjkwKCFC7ZtxXCHcPppfRlNA1GMuwzq/OL2E8uhKWru9AbnSW+s7p9AnDYkMUHlkYRL+
	lBt9KoSg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wXJEM-00000007ns9-2WgO;
	Wed, 10 Jun 2026 13:44:30 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wXJEL-00000007ns1-2xwq
	for linux-nvme@lists.infradead.org;
	Wed, 10 Jun 2026 13:44:29 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id AFB2F600AB;
	Wed, 10 Jun 2026 13:44:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4D971F00893;
	Wed, 10 Jun 2026 13:44:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781099068;
	bh=wPPDhxKh3hPc6l1/pq4WkUoyCmQ73QpGV3SN3sLOFRo=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=BVOSb6H3xr1dTTnA6IyJcvki9vKqeErst4XNJQblTnHZck+W55a5bkHy06PA/rFnk
	 BzeNsmCCR+ATshWPpMmlo2gztxWdn55c8KGJyJOGAH4FKWyZTviqHmrGgZfmrtO47J
	 rAYWUhy+/L5fGIUYkxwrOtkIaFAqCO1c103WVtdawY8TzxjEdd1oWbOaKCvfv0eKz1
	 LO/D5npkfeUSOdkHl5SZB836NW+DDVt2nxfzA4ZVvQuNv36qwmdAt693elYcL2lmTu
	 NbZanSLLCgP0sc96gpZhb4QHrCWGpxKNj47fqYPXftu/RAxXtR4qr+sW7xcN2c1lIh
	 1TtZIIf6YqTIg==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id E2E81F40077;
	Wed, 10 Jun 2026 09:44:26 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Wed, 10 Jun 2026 09:44:26 -0400
X-ME-Sender: <xms:Omopaszll95i-3fJFd6CskCrToGzY4ZK5vyfiFZgBFxT5A37wj_iKQ>
    <xme:OmoparHzwNrSu-NHoBGiw2xAHot2S5IZPLxAX7cvsUO4E8cgFFtcUK-uvezsl8z7a
    qA4ZDPYhIc04TVClC9TyDxb9zuKDfHsd92yRUJ_GAkdehaZSGnbrEU>
X-ME-Proxy-Cause: dmFkZTFo6lJcIYlhfzO/M7VQ/JnV1u4EHs5xq3VlZnBCfR540veWQVuwQPexuiS4eLQ9He
    2632OciM8xFfTwlrrqsfBrJFYSd43AdzjUtlKEJQ7ztos01/QDK8f0NKCFDLtiH6/PI8Xe
    Rh2ta8+yx4RJ4qjkPUZJSjLMMGk67Y/x5VondMjwqe2J5HUezBrRZBfgby9HaDQa7uw9XA
    0ZO+vPRgUARmUBEwHVMK6OUZuHsQgeTPM7dNVId1LklSaSvhzscZLscEOlrBX68uUL7Uh4
    muMOzMveIndhSACewxMIyLTuWF4kgSGQA1trSBckDEF95S7IOLs0WvEff0ifWxq3h8dABF
    jXli4WNoMJObTrcXcZhT0yNEAGez015qGKZV3dDKd1g4fY1WCNfiR8az0cNsMcYG9r/f94
    RmJR6z8dJkqd2jYr+DvoCTuxD7PEMyJYsJSrBb9mIimXygUailkO9U7B6uHpBQY9n01Q97
    tKgpWLnVyvG97FcfHsXmTxL9sFLQFjuwEszrMy9he8qsdkIRErVenWi6bLoMWDswWmbGoo
    Ga+BkuaRorJ9sCj5WwOXAM3d4Q2TAaVa03KR3AWtXT98T3fz7h5B9Yzn+Ln2hbF/31V4D/
    6ygODKDG7YLbZ4wsWnGwkCvkMWUYOwu/ABIzt0CbYHI1lEj00Aa+97pJGzRA
X-ME-Proxy: <xmx:Omopajb9Q_c5ELOPrPCO6ibbO_KC0kOAKkNXt8CMSh5PlPS741hyyQ>
    <xmx:Omopaig0QQ3SWZ50PrMxg56iDMdHDDDh0_hGEPmNDcVjFvzwdG3V7Q>
    <xmx:OmopajyDVfnPWFVoqrteEXQ0si-20fOP1_OVPianFEFhUzhQ45fXcA>
    <xmx:Omopat4HlpRERPyyuchP9miI8KLrPxVqOjV1SbaSnUREM4u7j1P-3w>
    <xmx:Omopas17tC3U4tMRF30GWJtmyX6viVpeXC8T8icfy2hd8u-bp3QpqJGk>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id B460F780070; Wed, 10 Jun 2026 09:44:26 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
MIME-Version: 1.0
X-ThreadId: AL3hV2aBoURB
Date: Wed, 10 Jun 2026 09:44:05 -0400
From: "Chuck Lever" <cel@kernel.org>
To: "Hannes Reinecke" <hare@suse.de>,
 "Donald Hunter" <donald.hunter@gmail.com>,
 "Jakub Kicinski" <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 "Eric Dumazet" <edumazet@google.com>, "Paolo Abeni" <pabeni@redhat.com>,
 "Simon Horman" <horms@kernel.org>, "Jonathan Corbet" <corbet@lwn.net>,
 "Shuah Khan" <skhan@linuxfoundation.org>,
 "Andrew Morton" <akpm@linux-foundation.org>,
 "John Fastabend" <john.fastabend@gmail.com>,
 "Sabrina Dubroca" <sd@queasysnail.net>, "Keith Busch" <kbusch@kernel.org>,
 "Jens Axboe" <axboe@kernel.dk>, "Christoph Hellwig" <hch@lst.de>,
 "Sagi Grimberg" <sagi@grimberg.me>, "Chaitanya Kulkarni" <kch@nvidia.com>,
 "Jeff Layton" <jlayton@kernel.org>, NeilBrown <neil@brown.name>,
 "Olga Kornievskaia" <okorniev@redhat.com>, "Dai Ngo" <Dai.Ngo@oracle.com>,
 "Tom Talpey" <tom@talpey.com>, "Trond Myklebust" <trondmy@kernel.org>,
 "Anna Schumaker" <anna@kernel.org>
Cc: kernel-tls-handshake@lists.linux.dev, netdev@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-nfs@vger.kernel.org,
 "Chuck Lever" <chuck.lever@oracle.com>
Message-Id: <98b7f6ef-3c1d-4af0-86d0-cad6d1f29b1c@app.fastmail.com>
In-Reply-To: <d14fff89-3c7b-40ea-9380-e8c37499916e@suse.de>
References: <20260605-tls-session-tags-v1-0-47bd1d94d552@oracle.com>
 <20260605-tls-session-tags-v1-3-47bd1d94d552@oracle.com>
 <922040b0-f87e-484d-9f7b-78098024ad04@suse.de>
 <2dc23995-3ff9-4714-ac6c-d70255b15687@app.fastmail.com>
 <d14fff89-3c7b-40ea-9380-e8c37499916e@suse.de>
Subject: Re: [PATCH 3/9] lib: Add a "tagset" data structure
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
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



On Wed, Jun 10, 2026, at 3:06 AM, Hannes Reinecke wrote:
> On 6/9/26 15:35, Chuck Lever wrote:
>> 
>> On Tue, Jun 9, 2026, at 2:45 AM, Hannes Reinecke wrote:
>>> On 6/5/26 19:34, Chuck Lever wrote:
>>>> From: Chuck Lever <chuck.lever@oracle.com>
>>>>
>>>> Access control mechanisms sometimes need to match metadata tags
>>>> between a session and a resource. A tagset provides efficient
>>>> membership testing and set intersection operations for this purpose.
>>>>
>>>> The implementation uses a sorted array of string pointers. Unlike
>>>> hash tables, sorted arrays support efficient intersection without
>>>> needing to iterate one set and probe the other. Unlike rbtrees,
>>>> they require no per-element node allocation, minimizing memory
>>>> overhead for small sets typical of resource tagging.
>>>>
>>> [ .. ]
>>>
>>>
>>> Isn't this overcomplicating matters?
>>> In the end, this a list of strings.
>>> Wouldn't a simple rbtree holding the strings be sufficient?
>>> (And quicker to lookup :-)
>> 
>> This isn't overcomplicating matters.
>> 
>> Consider that a TLS session might have several, even dozens of
>> tags. An NFSD export might also have a dozen or more tags.
>> 
>> We need a mechanism that will compute the intersection of those
>> two sets efficiently -- that is not a simple lookup. Keeping a
>> set of tags in a list or in an r-b tree would require MxN look
>> up operations to compute that intersection.
>> 
> It sure would. But we're dealing with a comparative small number
> of entries (later patches cap it to 64), so runtime really is of
> no concern.

I'm going to push back on that. Let's compare the proposed
tagset implementation with a putative r-b tree-based one.

On a big NFS server, mount operations happen frequently. With 5
tags on a session (say) and 5 allow-tags on an export, that is
25 lookups, each O(log(5)) (for r-b tree).

With the current tagset implementation, it is O(5 + 5).

If both the session and export tags are using the maximum number
of tags, an "intersection" turns into 4000+ lookups, each
O(log(64)). With the current tagset implementation, it's only
O(64 + 64).

The performance of one "intersection" operation goes south
quickly with the number of tags when conventional data types are
used.

And these are all memory fetches, so not all that fast. r-b trees
are notoriously non-optimal in terms of memory access efficiency,
though not as bad as a linked list.


> But let me see if I can come up with an alternative implementation
> using rb trees.

I'm skeptical that an r-b tree implementation will be much simpler.
It will definitely be more costly in terms of CPU and memory
accesses.

For the time being, note that TLS session tags have no support
for PSK -- there are no data items inside the shared keys on
which to match a tag. We might find something else to match on,
though, who knows?


-- 
Chuck Lever

