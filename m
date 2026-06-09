Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 952AACD8CA4
	for <linux-nvme@archiver.kernel.org>; Tue,  9 Jun 2026 14:30:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Subject:References:In-Reply-To:Message-Id:Cc:To:From:Date:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mNllo/EAh5OGpFDve9m7daTWGpd6XC59pL4YC3FC5iw=; b=ekNwxi3O/t9J/5YpHN+UZoYhZo
	BSdCkh9D001KfXL64SnyI8nmfL34xqnuFrG5N6ZyPuFU6YGR+vo4pno79ambSpXWnh1ZSlM2/hEEc
	X4owJQk+q29EiGPvKS2e6RaC4UDpLOq4f+FNPKY5ckx+ExFwd2pbqAjM1yGsAazfrm0id+IhEUXj7
	gjq8K2LTJ/e75z/YdXeHQjRrPW3ae6EM+i3lbMZzkHDbtWv4AjeEabcOm3bqtoiHkqZI7LIhj2T8o
	NgEcydgNFeGXvNC4AyqZ5Byb26YVlCHzVENF8hievJVxd5dNt0SI+CSQ2mpvbf9hadZj4UM64yp7P
	V2XV2FwA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wWxTI-00000005m8P-3ggV;
	Tue, 09 Jun 2026 14:30:29 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wWxT8-00000005m1G-3pk2
	for linux-nvme@lists.infradead.org;
	Tue, 09 Jun 2026 14:30:18 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id A7C9540628;
	Tue,  9 Jun 2026 14:30:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9E6A1F0089F;
	Tue,  9 Jun 2026 14:30:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781015418;
	bh=mNllo/EAh5OGpFDve9m7daTWGpd6XC59pL4YC3FC5iw=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=aTJSty4Diblx3iJfPXl9JSxScs3lyUKgJCVZzgLCaiFqkA3vhlyBrCYmGVXuhEms5
	 cyA1dxJETNcGxsoa8DXJQiv4uKqQf8o87ua1TKaKLHeyxHkXD77Ko8kWeBH7JskyR0
	 kzeEovugzp8iInPqlzwEnx84F4VRCrNcqerPtJeaQNWRgVVCDgmihcB/KDhk3tptaJ
	 A6kBnPvu+VgkMuklRacvUntgF0Mdcbf8et30Wh+jNIvLUaC3yUfjBPYoTmYBxwCDX7
	 G+x2lkUzhxpHjyeCNdoEylWcDAyhPd5tIB0jbgxAVRSwzt12KaxopsgQHvEzioHSAw
	 G/Q3H/4z1fJqg==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 1D36DF4006A;
	Tue,  9 Jun 2026 10:30:17 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Tue, 09 Jun 2026 10:30:17 -0400
X-ME-Sender: <xms:eCMoapKexCjkXyEZ3eOdAyNVK7HmUxvij5QfLLNufEv9AWuLQ4OiaQ>
    <xme:eCMoav-DVagjzGgldgg9bfWz6OkOAYl2zJ8oTpsg5ImJjBNBsKlotda8ZuMZ-tUyS
    jc9znDr0HiG4_kteXTEsN8IZh6LjAvOD7SyHAkeLQCKWo1rczrSMA>
X-ME-Proxy-Cause: dmFkZTEizTHeulnQTPsT2PqpHc+Eyp22TRfQg2TIYhjfXCvDwYB5d+dpktqe8zqEr5vrux
    inI0MaXzbLYOKH28GbCSYr7WNBS7ciLxN3MktKo4fd/b0/auhV9bx5/335lN43MtbhHgaw
    pcY4At/FI5BH9Q+isuapA48wsxxK8yGo3GI50GUcEsmXZ1OJSWRlC2olrybnDDHyFp/NCB
    sl9G29kfAu+FwiIfTdK1EP+bilNHvKeRJr2fVvvpZF64ZwSk4jSC2N1yq2mWiRQafdMPLV
    CPoO225ay/zgAbScNX405bdIc8NAHneoofbMWsiMbGl4+bxfS42vp4TMFVMvhR1biniuhF
    gvJfHtIE1phaCbK1q36GPBiNyAV/F4vqu6uIxtQxoD1dJq0DktPPW31G3BxxS/DDwqjrzB
    RM0eEpdb5KDlAKMkqagjqGzPeerJfvJ2R3HRgCBCp6AqoN4fzYVfxbwVYOLm3gwM9TeC27
    plWvOKPFbqflqJm5JC5PDKit7/NxQNlDe9prBsBtEp0jUDEI9+ImrN9ZRzgO9vbtzVoOlL
    CmWOk5Mxr4UToBD/NN0Yb/wJ5R+iy9F3tj4YLdCzN20W2o+KnzZ3UEAmM+2XtO7Um8cabI
    WDsPNsJ0mSyPa/ZAAAEOlRdmYZTGnWn+I1l+KodL7EdPraTepwLkDI2nFjPg
X-ME-Proxy: <xmx:eSMoajydRPr-3XfKnVMdGvDQyBe_v-zUgmtCASsY_NKiBiclA2Vivw>
    <xmx:eSMoara60p1DcjOLLYYii5Hx-wzp5cVEClGXsLDboIukoE9m05ED6A>
    <xmx:eSMoarJhF3VGKrbDDOqeyll3AEz18DOvuZp8G3Ii1fOxpQ5PV-s09g>
    <xmx:eSMoahzEx9yATQYXzLeypZFFTodr7zoXwfg9bS3LZjk0ocHzxe9bwg>
    <xmx:eSMoajNWKedofmIUTPxdyquFv_J51zANp_OViVMCBNz3-k_uqafaWKfG>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id DD895780070; Tue,  9 Jun 2026 10:30:16 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
MIME-Version: 1.0
X-ThreadId: A_qtNCD-JAng
Date: Tue, 09 Jun 2026 10:29:56 -0400
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
Message-Id: <7b5276ff-cceb-446c-97ec-65ad80689495@app.fastmail.com>
In-Reply-To: <40199ef9-416e-4a58-908a-ed514dfd6ff2@suse.de>
References: <20260605-tls-session-tags-v1-0-47bd1d94d552@oracle.com>
 <20260605-tls-session-tags-v1-2-47bd1d94d552@oracle.com>
 <40199ef9-416e-4a58-908a-ed514dfd6ff2@suse.de>
Subject: Re: [PATCH 2/9] handshake: Add tags to "done" downcall
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


On Tue, Jun 9, 2026, at 2:41 AM, Hannes Reinecke wrote:
> On 6/5/26 19:34, Chuck Lever wrote:
>> We'd like tlshd to tag certificates according to admin-defined
>> characteristics. The tag list is to be returned on a successful
>> handshake. Upper Layer Protocols (such as NFS) can then authorize
>> access based on the set of tags returned to the kernel.
>> 
>> For example, suppose NFSD wants to restrict access to an export to
>> only clients that present certificates whose issuer DN contains
>> "O=Oracle". tlshd can parse incoming certificates, and add an
>> "oraclegroup" tag to handshakes where a client presents a
>> certificate with "O=Oracle" somewhere in its Issuer field. NFSD can
>> then be configured to look for that tag and permit access only when
>> it is present. NFSD needs no knowledge of x.509 certificates.
>> 
>> This patch plumbs in the netlink protocol elements for tlshd to
>> return a list of tags to the kernel when a TLS or QUIC handshake
>> succeeds. Subsequent patches add tag extraction and storage in
>> the handshake layer.

> Not sure if I agree with this; to my untrained eye the 'tag' attribute 
> is just a string, and someone else will have to parse that. But we
> are at the netlink level here, so we _can_ have nested tags.
> Wouldn't it be better to make 'tags' a nested tag (ie a list of tags)
> such that we can avoid parsing in the caller/consumer?

Had some time to digest your comment a little more...

The tag attribute is declared "multi-attr: true", so it is already a
list rather than a single delimited string. tlshd emits one
HANDSHAKE_A_DONE_TAG attribute per tag, and the kernel receives each
tag as a separate netlink attribute. There is no string to split in
the consumer; the parsing you are worried about does not happen. 

This matches remote-auth directly above it, which is likewise a
multi-attr scalar list in the same DONE message.

A nested attribute earns its keep when each list element is a
structured record with several sub-fields to group. A tag is a single
string, so nesting would add a container attribute, a second
attribute-set, and a nested policy without making anything on the
consumer side simpler. If a tag later needs to carry structured
metadata, nesting becomes the right tool, but that is not in scope for
this series.


-- 
Chuck Lever

