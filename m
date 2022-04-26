Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17234C433F5
	for <linux-nvme@archiver.kernel.org>; Tue, 26 Apr 2022 23:47:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1V9EOSw1c5iKVLkeMp37ESaN6Kkvlgvd0izgWOjOBWU=; b=o5TDyQYaPtxbbAZCnxDIgCrAcV
	UYMrgL3IXEL56XDm1NrQZQ7cvwfuE6W6GKFjgPi3mDgUJdomPy1/svS8y6soXMuifGiKT83Bxfna1
	6Vq0V+d/jP+FTESt085R642B8qZtr/XjjDrPding1WG6zk4EM8s53IyX8jVw7sNh4drdRWGyiFjZN
	hkt99FsAnNVmI1Lat+Zj5PAa4sKiTLZrxHlmA0b1TiWGi5/BtA2G8e5hVBcrTqIu0X467Ih7QSEuz
	7WKZr7DjLsueKAIv0U3qYBDsW0wWfAPWz2646OzYhdsiz1rXA6SB5CgMeHNEFAveRzprOyo0VvSWz
	okLmyqVw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1njUtv-00GhVU-Th; Tue, 26 Apr 2022 23:47:23 +0000
Received: from ams.source.kernel.org ([2604:1380:4601:e00::1])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1njUts-00GhTj-Bw
 for linux-nvme@lists.infradead.org; Tue, 26 Apr 2022 23:47:22 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 465A5B820BF;
 Tue, 26 Apr 2022 23:47:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A101DC385A0;
 Tue, 26 Apr 2022 23:47:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1651016834;
 bh=aldCnNd4EyeN6oO79S0ufp4A5mLgFgvG7eBHbO6bp0Y=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=YV/uvMOOQZ+SOpxLMocOmVBQQRUgAcb+25R4Avl1bprJuYj4xUDMDANomomg7Kq17
 PXYMW1oXzKkztaE6Kh0K1gA3a5pw+VSPKIOcxxF58ITApQhovH43NSB3azVyDnvjPJ
 8HxFU+4TQisTlylymFg2gpNC/LCgCBL592Cp85+/wUhTOUrQKC0r7PfpWi1BrP/Jp1
 EZDIDzrGPsg+Kwgc9Tg4CiaNJ0ALZ/iV4JJ2cQmu3HeKQI7/8wS7B9T3cdZhBoFIUv
 1lTxjBcstBNgeHUvJt0EX5W1WLw4cuGfeq2SzQLlun5JrKE1gcwJWDnmlnsocRIRfL
 9CB+n91A6+MZg==
Date: Tue, 26 Apr 2022 16:47:12 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Chuck Lever III <chuck.lever@oracle.com>
Cc: netdev <netdev@vger.kernel.org>, Linux NFS Mailing List
 <linux-nfs@vger.kernel.org>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>, "linux-cifs@vger.kernel.org"
 <linux-cifs@vger.kernel.org>, "linux-fsdevel@vger.kernel.org"
 <linux-fsdevel@vger.kernel.org>, "ak@tempesta-tech.com"
 <ak@tempesta-tech.com>, "borisp@nvidia.com" <borisp@nvidia.com>,
 "simo@redhat.com" <simo@redhat.com>
Subject: Re: [PATCH RFC 4/5] net/tls: Add support for PF_TLSH (a TLS
 handshake listener)
Message-ID: <20220426164712.068e365c@kernel.org>
In-Reply-To: <BA6BB8F6-3A2A-427B-A5D7-30B5F778B7E0@oracle.com>
References: <165030051838.5073.8699008789153780301.stgit@oracle-102.nfsv4.dev>
 <165030059051.5073.16723746870370826608.stgit@oracle-102.nfsv4.dev>
 <20220425101459.15484d17@kernel.org>
 <E8809EC2-D49A-4171-8C88-D5E24FFA4079@oracle.com>
 <20220426075504.18be4ee2@kernel.org>
 <BA6BB8F6-3A2A-427B-A5D7-30B5F778B7E0@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220426_164720_748019_97E66150 
X-CRM114-Status: GOOD (  35.64  )
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

On Tue, 26 Apr 2022 15:58:29 +0000 Chuck Lever III wrote:
> > On Apr 26, 2022, at 10:55 AM, Jakub Kicinski <kuba@kernel.org> wrote:
> >> The RPC-with-TLS standard allows unencrypted RPC traffic on the connection
> >> before sending ClientHello. I think we'd like to stick with creating the
> >> socket in the kernel, for this reason and for the reasons Hannes mentions
> >> in his reply.  
> > 
> > Umpf, I presume that's reviewed by security people in IETF so I guess
> > it's done right this time (tm).  
> 
> > Your wording seems careful not to imply that you actually need that,
> > tho. Am I over-interpreting?  
> 
> RPC-with-TLS requires one RPC as a "starttls" token. That could be
> done in user space as part of the handshake, but it is currently
> done in the kernel to enable the user agent to be shared with other
> kernel consumers of TLS. Keep in mind that we already have two
> real consumers: NVMe and RPC-with-TLS; and possibly QUIC.
> 
> You asserted earlier that creating sockets in user space "scales
> better" but did not provide any data. Can we see some? How well
> does it need to scale for storage protocols that use long-lived
> connections?

I meant scale with the number of possible crypto protocols, 
I mentioned three there.

> Also, why has no-one mentioned the NBD on TLS implementation to
> us before? I will try to review that code soon.

Oops, maybe that thing had never seen the light of a public mailing
list then :S Dave Watson was working on it at Facebook, but he since
moved to greener pastures.

> > This set does not even have selftests.  
> 
> I can include unit tests with the prototype. Someone needs to
> educate me on what is the preferred unit test paradigm for this
> type of subsystem. Examples in the current kernel code base would
> help too.

Whatever level of testing makes you as an engineer comfortable
with saying "this test suite is sufficient"? ;)

For TLS we have tools/testing/selftests/net/tls.c - it's hardly
an example of excellence but, you know, it catches bugs here and 
there.

> > Plus there are more protocols being actively worked on (QUIC, PSP etc.)
> > Having per ULP special sauce to invoke a user space helper is not the
> > paradigm we chose, and the time as inopportune as ever to change that.  
> 
> When we started discussing TLS handshake requirements with some
> community members several years ago, creating the socket in
> kernel and passing it up to a user agent was the suggested design.
> Has that recommendation changed since then?

Hm, do you remember who you discussed it with? Would be good 
to loop those folks in. I wasn't involved at the beginning of the 
TLS work, I know second hand that HW offload and nbd were involved 
and that the design went thru some serious re-architecting along 
the way. In the beginning there was a separate socket for control
records, and that was nacked.

But also (and perhaps most importantly) I'm not really objecting 
to creating the socket in the kernel. I'm primarily objecting to 
a second type of a special TLS socket which has TLS semantics.

> I'd prefer an in-kernel handshake implementation over a user
> space one (even one that is sharable amongst transports and ULPs
> as my proposal is intended to be). However, so far we've been told
> that an in-kernel handshake implementation is a non-starter.
> 
> But in the abstract, we agree that having a single TLS handshake
> mechanism for kernel consumers is preferable.

For some definition of "we" which doesn't not include me?

