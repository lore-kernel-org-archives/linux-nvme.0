Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22A56CD8CA4
	for <linux-nvme@archiver.kernel.org>; Tue,  9 Jun 2026 13:35:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Subject:References:In-Reply-To:Message-Id:Cc:To:From:Date:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+l/UTSLrEN1zHvyis/o72R6ISF/z8tIHnP6okV95VvQ=; b=QTSTANVOZb0VXFwsanoNcO9rkC
	7hJSBikpIbKo8W+Zv6QKFU2AcHquavvI3wwCNkBMLDbxk8b2SLEPhvjbEjytEWF2WeDpbTGux+QlW
	qFs44e10Yxe3zUl49cOFFWseBOSTUVPomTwhMEoveaO+9yPK9frROgfxdg/Pi8XtgQcYTNCtQ3Mrw
	9Rll9EP741rm6E8TRm8ygawgTrzdRJBQVtN36lu561ID0F0zuODkDsFSPGrP/0f6sN8JGXWcEJkAz
	VaGwnZSHmUaC6W7zoqfViyFELmCWvivTgRCGSDYWj0fZmg/v3xZXcDMehwY49JvfgIb9LXR1qW18M
	tcj6Fk6w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wWwc6-00000005g5X-4BlX;
	Tue, 09 Jun 2026 13:35:31 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wWwc4-00000005g59-2pR6
	for linux-nvme@lists.infradead.org;
	Tue, 09 Jun 2026 13:35:29 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 63BB2444D4;
	Tue,  9 Jun 2026 13:35:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78DDC1F00899;
	Tue,  9 Jun 2026 13:35:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781012128;
	bh=+l/UTSLrEN1zHvyis/o72R6ISF/z8tIHnP6okV95VvQ=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=k+SVVA9zJ4tZ2kJQU/0gMLQJI0sP3l3f3+9EDObAoVEqmqmDGDRhfcPdLarcJ5hu5
	 cosbVXc294Ptezv0LdrqnmGtqpTtieZ7tL8nDTJuoCg/x2CVjEcWbCsv+h/BZDvZes
	 yWneKR6KG7VZ5nuw10SM1qjtQCn5Nkwe4NJIZgin8QUaK/EpyHwxYbs+DDnx9rLTAz
	 EubtfDBFWaAVhMUJ1F4oY4VL/0JgUutzm2LlT4cq8rWa+emntjfO7dA84fZERFR2TN
	 39XZDyqo8x2OqfKyvVqTch6UnfocgkjDXZ8s3yqsBOEF+QrHL/jojwdLEUrc5GY4/4
	 fZsG68pIt97MA==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 768C7F40078;
	Tue,  9 Jun 2026 09:35:26 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Tue, 09 Jun 2026 09:35:26 -0400
X-ME-Sender: <xms:nhYoaplIY6wt8kTkhGrccaO3i8dwZ4W4I6UK32dxAmJzR_RZNJ8Cxg>
    <xme:nhYoavoyGhCnFRCcdyhKYQi21RJ6TedTCUqElDkX6oKHwsNB34l4sRB779JgyouOp
    Cwe8Uk4EKdFC-wn5ciK2fdDMtgZWmTLgpefCvOHGO5Ce27bOAWUFRY>
X-ME-Proxy-Cause: dmFkZTEDCIIiozq5l4PyMP1KhHxMo20yBOrr1DxMjIfh/X+ZS8v3yNvexBCw5JykEEfxJj
    6MccADJBKKlCbmJe5OMK7gYITzGG3trc9yKUY9oLpnPrMH/J4PSSbHPnHNHJFqSYdElaII
    9iBVeVo/7DH31ynwuHt+N3W8NVL0ph6AYsqcFJQmXwTw8ll1Otg1/PqGU70oWnnJpoSnej
    6L23KmTHwLgcZfPQR3BFH5XELy6+HN8Jcbi0XqnZrEbG1VRgw9sjNzFt58mNpf7UDw9x5D
    WnwfjZDFvdnMKHWtu8bdmeGV0EmimIcHzfIpunMpJ3Pb3s1+HkSIgkq8e4ULdtGOkh8qhk
    OSnUiBs3qQrPNRK6d2FEY1FjLeMQn05ICZqbtfpqr6wuucoDO5aJdDlze+zm9r/lY8TCEC
    5oOc89AqrumaZPWOjQx52klmbedIM3qLpc2Bi49iMA8FyRlUbEaEpYxgVQhYLjlMg9lQmu
    tZN2pJkmE8PFIBnaRgiQOsBJxCC3Gxa59gP9uFk6nyJZpJLXFLQecy6A1lo5Qg50P4bs8N
    jGiKa4rWv5pKSr18Nignfn5NF9GsXE+pZwNxNV63qut9IYMHsRAgnRfFWeNK9N+U5e8Jzg
    6PjP7VflmeHMo5Lejr3TWlm+2rFVYFeQJTfP8bQ97pj/ZZJIG/KOReZ4EB6Q
X-ME-Proxy: <xmx:nhYoamOGRchH9ufTadJUhsexv-Fie4rUdaps1S8wyYz1jkdUWmQJKg>
    <xmx:nhYoalEKo-dU2IXldVZ-UEuGhCxQiR75Egv1pg1V9XepOdc5U66l5w>
    <xmx:nhYoarGIMtfhRtt8Q3GvIgYfWw0FzuCybUVgu7WF55kBDn-aSIxUig>
    <xmx:nhYoaq94dBwNO8GOvkiG7L6Qn1qP4Q4H5ZGU0-MpQD1i5RoJbbedOw>
    <xmx:nhYoaspKch9W2TMlyF-K9Ujwm2Nzi-EDZWGjxV8y5EY8V8k3JTTQgXZH>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 45AD4780076; Tue,  9 Jun 2026 09:35:26 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
MIME-Version: 1.0
X-ThreadId: AL3hV2aBoURB
Date: Tue, 09 Jun 2026 09:35:06 -0400
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
Message-Id: <2dc23995-3ff9-4714-ac6c-d70255b15687@app.fastmail.com>
In-Reply-To: <922040b0-f87e-484d-9f7b-78098024ad04@suse.de>
References: <20260605-tls-session-tags-v1-0-47bd1d94d552@oracle.com>
 <20260605-tls-session-tags-v1-3-47bd1d94d552@oracle.com>
 <922040b0-f87e-484d-9f7b-78098024ad04@suse.de>
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


On Tue, Jun 9, 2026, at 2:45 AM, Hannes Reinecke wrote:
> On 6/5/26 19:34, Chuck Lever wrote:
>> From: Chuck Lever <chuck.lever@oracle.com>
>> 
>> Access control mechanisms sometimes need to match metadata tags
>> between a session and a resource. A tagset provides efficient
>> membership testing and set intersection operations for this purpose.
>> 
>> The implementation uses a sorted array of string pointers. Unlike
>> hash tables, sorted arrays support efficient intersection without
>> needing to iterate one set and probe the other. Unlike rbtrees,
>> they require no per-element node allocation, minimizing memory
>> overhead for small sets typical of resource tagging.
>> 
> [ .. ]
>
>
> Isn't this overcomplicating matters?
> In the end, this a list of strings.
> Wouldn't a simple rbtree holding the strings be sufficient?
> (And quicker to lookup :-)

This isn't overcomplicating matters.

Consider that a TLS session might have several, even dozens of
tags. An NFSD export might also have a dozen or more tags.

We need a mechanism that will compute the intersection of those
two sets efficiently -- that is not a simple lookup. Keeping a
set of tags in a list or in an r-b tree would require MxN look
up operations to compute that intersection.


> Also see my comment in the previous patch. I really would make
> 'tags' a nested attribute, and then parsing the 'tags' attribute
> would be simple iteration over the tags.

I leave it to Jakub to decide the best approach for passing tags
via the netlink protocol.


> (And don't name it tagset. That will be confusing the hell of out
> of any storage folks, where a tagset is something completely
> different.)

Since the primary operation on this container is "intersection",
set makes the most sense. Stringset?


-- 
Chuck Lever

