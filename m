Return-Path: <SRS0=PNO/=FP=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 957B8C4361B
	for <linux-nvme@archiver.kernel.org>; Fri, 11 Dec 2020 18:59:16 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B0BD23E1B
	for <linux-nvme@archiver.kernel.org>; Fri, 11 Dec 2020 18:59:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B0BD23E1B
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:In-Reply-To:
	References:MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=fxhlujZoRozZsMOAmec0+6cdDvjb8v39wFRgX3myaAI=; b=Gdasb5Yk2E8AL9st/Po+XxA7d
	NDsLn43lJbniafp/p/lwKP76PLKpfCMy2TyO09BOtMWmvgY5uSpqDZsK4xEGdpVRFSH13b89Vf8fZ
	CpNCVL2ZHQPVhHHfp88hhrM0hPoPCpzyQiHryTZrNsHQQb5YCv/qnskWhcjhXyUzZM9InKBypJand
	7S6GGGxHXYDb/vfDpGCeUtpoK0TOo9YsrvSLHUmv4Y6bppgXsKsWihuEG/Ro0TCVyMrmnvFOQydYi
	R6CnJmVtfdkuNUbLGlCNzZbN9B7RZs1cSCqqzGqf/72YEox0Uqz5h/7WNgNeZJn88p69hMykNTJcr
	x49NVI6Dw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1knndG-00034m-QK; Fri, 11 Dec 2020 18:59:10 +0000
Received: from mail-io1-xd44.google.com ([2607:f8b0:4864:20::d44])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1knndE-00033l-1u
 for linux-nvme@lists.infradead.org; Fri, 11 Dec 2020 18:59:09 +0000
Received: by mail-io1-xd44.google.com with SMTP id i9so10526057ioo.2
 for <linux-nvme@lists.infradead.org>; Fri, 11 Dec 2020 10:59:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Hm72ipNmSWlQdfl4sY0gkcF0qWVySUwNVz1JlI5UYoQ=;
 b=PV/P1DDhof48ulcONqCZgiaiYrL7odZ/v9mSq4IY+r3u6u7YESnnf2DBh8TyjdZ4Nb
 BhHBAnZN3OLpdeBxIduKRJmHsT+IujFR6trvyLuFMe1bxBredlcNfNlbiL4Y5VF4jPON
 yVlPOEmj4qsrA9EHJiG5GgaFa0nopTEEnnS9pNx+0f5LXrOPU36LJ2lwISWkNMP58gxm
 qBCg0C6XBvh8d4SnzZcRlKDgKT8PsbU3jwghtbK1axULg8A/pSujg0pXfM/OhbO65tNF
 b+66QMYyStlZSevIikB+eKthTmUBDsuOSSbZUOfCpjR1YzGL0u6iHsLhtqXi77Ay+Mwg
 WlMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Hm72ipNmSWlQdfl4sY0gkcF0qWVySUwNVz1JlI5UYoQ=;
 b=V8ii8ISSuj0UWojbu6yqaQ9AX2Ef9Qd2fYI51tc/XkLXcfR06XF4j5SzulCZUaFZIs
 aLHIXTSiKgd/cPhncn68mKy6O8qU4ZjCyPg5dYLFst4YVgx83q+1r8pkYVyJBXhLmIkf
 QztNzmjjp2RuOlfn395o4getrB8bGGXNjaVBmkv3T1JPvfBmY6McDUJ40/xxzvvkLm3p
 0XF0lZ1FP1zWKrFmepBg32oB0G9LedsZgwwCdfmVs4ggfX8s8CpV08CDvGruwAJdrGXT
 1+QwU3i5SVp5hr99cqR1zm6USSVfElO72qxUkO0N48ACmhoythdfxJNWDAfMZ60ypos1
 OsdQ==
X-Gm-Message-State: AOAM532zGva+qNyHaHlA939fCzrsLxdWU3HrlaoS/eCEcOlykz8RPzi6
 gs8g6wDxF3XCDRj68GWzDQ0OXsLdxd2n65xFIOwUig==
X-Google-Smtp-Source: ABdhPJwpcnW/LD0hBwEh6qnyE/GfOgKDPGIKie34XV1jsVl4zmy6NPKzJLOboGZWGRNv+BkeskeB4Fd4mCAleCSLLgI=
X-Received: by 2002:a6b:928b:: with SMTP id
 u133mr16737943iod.145.1607713143870; 
 Fri, 11 Dec 2020 10:59:03 -0800 (PST)
MIME-Version: 1.0
References: <20201207210649.19194-1-borisp@mellanox.com>
 <20201207210649.19194-3-borisp@mellanox.com>
 <6f48fa5d-465c-5c38-ea45-704e86ba808b@gmail.com>
 <f52a99d2-03a4-6e9f-603e-feba4aad0512@gmail.com>
 <65dc5bba-13e6-110a-ddae-3d0c260aa875@gmail.com>
 <ab298844-c95e-43e6-b4bb-fe5ce78655d8@gmail.com>
 <921a110f-60fa-a711-d386-39eeca52199f@gmail.com>
 <20201210180108.3eb24f2b@kicinski-fedora-pc1c0hjn.DHCP.thefacebook.com>
 <5cadcfa0-b992-f124-f006-51872c86b804@gmail.com>
 <20201211104445.30684242@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <20201211104445.30684242@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 11 Dec 2020 19:58:51 +0100
Message-ID: <CANn89iKdEHTxv6-Gv1d5-vuw1Yv4ySjK7iC6be+xJJvPvA-rsA@mail.gmail.com>
Subject: Re: [PATCH v1 net-next 02/15] net: Introduce direct data placement
 tcp offload
To: Jakub Kicinski <kuba@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201211_135908_154511_E9918683 
X-CRM114-Status: GOOD (  41.07  )
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
Cc: Yoray Zack <yorayz@mellanox.com>, Boris Pismenny <borisp@mellanox.com>,
 yorayz@nvidia.com, Boris Pismenny <borisp@nvidia.com>,
 boris.pismenny@gmail.com, Ben Ben-Ishay <benishay@mellanox.com>,
 linux-nvme@lists.infradead.org, David Miller <davem@davemloft.net>,
 axboe@fb.com, Boris Pismenny <borispismenny@gmail.com>,
 netdev <netdev@vger.kernel.org>, ogerlitz@nvidia.com,
 Al Viro <viro@zeniv.linux.org.uk>, David Ahern <dsahern@gmail.com>,
 kbusch@kernel.org, Or Gerlitz <ogerlitz@mellanox.com>, benishay@nvidia.com,
 Saeed Mahameed <saeedm@nvidia.com>, Christoph Hellwig <hch@lst.de>,
 sagi@grimberg.me
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Fri, Dec 11, 2020 at 7:45 PM Jakub Kicinski <kuba@kernel.org> wrote:
>
> On Thu, 10 Dec 2020 19:43:57 -0700 David Ahern wrote:
> > On 12/10/20 7:01 PM, Jakub Kicinski wrote:
> > > On Wed, 9 Dec 2020 21:26:05 -0700 David Ahern wrote:
> > >> Yes, TCP is a byte stream, so the packets could very well show up like this:
> > >>
> > >>  +--------------+---------+-----------+---------+--------+-----+
> > >>  | data - seg 1 | PDU hdr | prev data | TCP hdr | IP hdr | eth |
> > >>  +--------------+---------+-----------+---------+--------+-----+
> > >>  +-----------------------------------+---------+--------+-----+
> > >>  |     payload - seg 2               | TCP hdr | IP hdr | eth |
> > >>  +-----------------------------------+---------+--------+-----+
> > >>  +-------- +-------------------------+---------+--------+-----+
> > >>  | PDU hdr |    payload - seg 3      | TCP hdr | IP hdr | eth |
> > >>  +---------+-------------------------+---------+--------+-----+
> > >>
> > >> If your hardware can extract the NVMe payload into a targeted SGL like
> > >> you want in this set, then it has some logic for parsing headers and
> > >> "snapping" an SGL to a new element. ie., it already knows 'prev data'
> > >> goes with the in-progress PDU, sees more data, recognizes a new PDU
> > >> header and a new payload. That means it already has to handle a
> > >> 'snap-to-PDU' style argument where the end of the payload closes out an
> > >> SGL element and the next PDU hdr starts in a new SGL element (ie., 'prev
> > >> data' closes out sgl[i], and the next PDU hdr starts sgl[i+1]). So in
> > >> this case, you want 'snap-to-PDU' but that could just as easily be 'no
> > >> snap at all', just a byte stream and filling an SGL after the protocol
> > >> headers.
> > >
> > > This 'snap-to-PDU' requirement is something that I don't understand
> > > with the current TCP zero copy. In case of, say, a storage application
> >
> > current TCP zero-copy does not handle this and it can't AFAIK. I believe
> > it requires hardware level support where an Rx queue is dedicated to a
> > flow / socket and some degree of header and payload splitting (header is
> > consumed by the kernel stack and payload goes to socket owner's memory).
>
> Yet, Google claims to use the RX ZC in production, and with a CX3 Pro /
> mlx4 NICs.

And other proprietary NIC

We do not dedicate RX queues, TCP RX zerocopy is not direct placement
into application space.

These slides (from netdev 0x14) might be helpful

https://netdevconf.info/0x14/pub/slides/62/Implementing%20TCP%20RX%20zero%20copy.pdf


>
> Simple workaround that comes to mind is have the headers and payloads
> on separate TCP streams. That doesn't seem too slick.. but neither is
> the 4k MSS, so maybe that's what Google does?
>
> > > which wants to send some headers (whatever RPC info, block number,
> > > etc.) and then a 4k block of data - how does the RX side get just the
> > > 4k block a into a page so it can zero copy it out to its storage device?
> > >
> > > Per-connection state in the NIC, and FW parsing headers is one way,
> > > but I wonder how this record split problem is best resolved generically.
> > > Perhaps by passing hints in the headers somehow?
> > >
> > > Sorry for the slight off-topic :)
> > >
> > Hardware has to be parsing the incoming packets to find the usual
> > ethernet/IP/TCP headers and TCP payload offset. Then the hardware has to
> > have some kind of ULP processor to know how to parse the TCP byte stream
> > at least well enough to find the PDU header and interpret it to get pdu
> > header length and payload length.
>
> The big difference between normal headers and L7 headers is that one is
> at ~constant offset, self-contained, and always complete (PDU header
> can be split across segments).
>
> Edwin Peer did an implementation of TLS ULP for the NFP, it was
> complex. Not to mention it's L7 protocol ossification.
>
> To put it bluntly maybe it's fine for smaller shops but I'm guessing
> it's going to be a hard sell to hyperscalers and people who don't like
> to be locked in to HW.
>
> > At that point you push the protocol headers (eth/ip/tcp) into one buffer
> > for the kernel stack protocols and put the payload into another. The
> > former would be some page owned by the OS and the latter owned by the
> > process / socket (generically, in this case it is a kernel level
> > socket). In addition, since the payload is spread across multiple
> > packets the hardware has to keep track of TCP sequence number and its
> > current place in the SGL where it is writing the payload to keep the
> > bytes contiguous and detect out-of-order.
> >
> > If the ULP processor knows about PDU headers it knows when enough
> > payload has been found to satisfy that PDU in which case it can tell the
> > cursor to move on to the next SGL element (or separate SGL). That's what
> > I meant by 'snap-to-PDU'.
> >
> > Alternatively, if it is any random application with a byte stream not
> > understood by hardware, the cursor just keeps moving along the SGL
> > elements assigned it for this particular flow.
> >
> > If you have a socket whose payload is getting offloaded to its own queue
> > (which this set is effectively doing), you can create the queue with
> > some attribute that says 'NVMe ULP', 'iscsi ULP', 'just a byte stream'
> > that controls the parsing when you stop writing to one SGL element and
> > move on to the next. Again, assuming hardware support for such attributes.
> >
> > I don't work for Nvidia, so this is all supposition based on what the
> > patches are doing.
>
> Ack, these patches are not exciting (to me), so I'm wondering if there
> is a better way. The only reason NIC would have to understand a ULP for
> ZC is to parse out header/message lengths. There's gotta be a way to
> pass those in header options or such...
>
> And, you know, if we figure something out - maybe we stand a chance
> against having 4 different zero copy implementations (this, TCP,
> AF_XDP, netgpu) :(

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
