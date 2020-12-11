Return-Path: <SRS0=PNO/=FP=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6E0CC4361B
	for <linux-nvme@archiver.kernel.org>; Fri, 11 Dec 2020 18:45:54 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D3F823F37
	for <linux-nvme@archiver.kernel.org>; Fri, 11 Dec 2020 18:45:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D3F823F37
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=1wGTT+gOXaTxVS0sxWnGnJcz4egrp7R3KfsptB3ZTuU=; b=CRxCb4b1ECyRYrIKeMhDLwFr7
	iUu6TLY9PceAuB5fsLBr5/4rFBO9s57nw6N0jmyA+ASglWz5rlab9wx05iZ7jEH+6fo//6b9ZTQwP
	UMvKEYZh4gX43kIHuPQqPHI8BCsG/IYMq5vnK/UVi2JKkpdZ0fpU5M//ZSV8tUPfGPj2vc9UNCW1t
	rEQwUat1hyYhpgsHi0H43IB5nskz12gJZc/bHN0dVnQW1/MCeO6/LDUeHHp0Mb9eEIJmDSRym+bEH
	8IGbViOTiky82DWZE0Es3GmGIhpE64neV2f9z026SZE9j26IvxQQAZjqOOtGeanm9dmdtU5AWjfS7
	n/E50FetQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1knnQN-00057A-Ge; Fri, 11 Dec 2020 18:45:51 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1knnQL-00056i-OU
 for linux-nvme@lists.infradead.org; Fri, 11 Dec 2020 18:45:50 +0000
Date: Fri, 11 Dec 2020 10:45:34 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1607712348;
 bh=vq7bQM3DXTCBGxuTRrXjVx4jcyD7Jiq6JLDy65/2dbY=;
 h=From:To:Cc:Subject:In-Reply-To:References:From;
 b=JECrMjjthufSyLYA3in7PoJvwcOIxZTdx6yQGryDlx73zqhkhTSq6aTpfhwQHZcUH
 ZkFDePlVsbOx3fTnn54CXPi3/WrnvKBKZCUji5JErN1og0Th6bNgUqSopADarsYyLb
 1YG1llHixG0UkkDloYRY4vY4aY5eL8xSDiTmqqi+BIYHkFf2YTnfyVesHfgCRxdHfM
 QUYqCdzTUYWWq03Jb9fxQkzKFaQrg+yO/mERelymOGYNhSS+UGhJ5jIKODcb3dbrFm
 5Xnkt2MtugzKSE9qO2RqL95jyaRU3cmoyonlQ2Rc7VE0UNcFwVocJEuoy4MNr4E+pI
 TE1psYP4YZ3ig==
From: Jakub Kicinski <kuba@kernel.org>
To: David Ahern <dsahern@gmail.com>
Subject: Re: [PATCH v1 net-next 02/15] net: Introduce direct data placement
 tcp offload
Message-ID: <20201211104445.30684242@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <5cadcfa0-b992-f124-f006-51872c86b804@gmail.com>
References: <20201207210649.19194-1-borisp@mellanox.com>
 <20201207210649.19194-3-borisp@mellanox.com>
 <6f48fa5d-465c-5c38-ea45-704e86ba808b@gmail.com>
 <f52a99d2-03a4-6e9f-603e-feba4aad0512@gmail.com>
 <65dc5bba-13e6-110a-ddae-3d0c260aa875@gmail.com>
 <ab298844-c95e-43e6-b4bb-fe5ce78655d8@gmail.com>
 <921a110f-60fa-a711-d386-39eeca52199f@gmail.com>
 <20201210180108.3eb24f2b@kicinski-fedora-pc1c0hjn.DHCP.thefacebook.com>
 <5cadcfa0-b992-f124-f006-51872c86b804@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201211_134550_049111_F2B6BE95 
X-CRM114-Status: GOOD (  32.79  )
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
Cc: Yoray Zack <yorayz@mellanox.com>, sagi@grimberg.me, yorayz@nvidia.com,
 Boris Pismenny <borisp@nvidia.com>, boris.pismenny@gmail.com,
 Ben Ben-Ishay <benishay@mellanox.com>, edumazet@google.com,
 linux-nvme@lists.infradead.org, davem@davemloft.net, axboe@fb.com,
 Boris Pismenny <borispismenny@gmail.com>, ogerlitz@nvidia.com,
 viro@zeniv.linux.org.uk, netdev@vger.kernel.org, kbusch@kernel.org,
 Or Gerlitz <ogerlitz@mellanox.com>, benishay@nvidia.com, saeedm@nvidia.com,
 hch@lst.de, Boris Pismenny <borisp@mellanox.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, 10 Dec 2020 19:43:57 -0700 David Ahern wrote:
> On 12/10/20 7:01 PM, Jakub Kicinski wrote:
> > On Wed, 9 Dec 2020 21:26:05 -0700 David Ahern wrote:  
> >> Yes, TCP is a byte stream, so the packets could very well show up like this:
> >>
> >>  +--------------+---------+-----------+---------+--------+-----+
> >>  | data - seg 1 | PDU hdr | prev data | TCP hdr | IP hdr | eth |
> >>  +--------------+---------+-----------+---------+--------+-----+
> >>  +-----------------------------------+---------+--------+-----+
> >>  |     payload - seg 2               | TCP hdr | IP hdr | eth |
> >>  +-----------------------------------+---------+--------+-----+
> >>  +-------- +-------------------------+---------+--------+-----+
> >>  | PDU hdr |    payload - seg 3      | TCP hdr | IP hdr | eth |
> >>  +---------+-------------------------+---------+--------+-----+
> >>
> >> If your hardware can extract the NVMe payload into a targeted SGL like
> >> you want in this set, then it has some logic for parsing headers and
> >> "snapping" an SGL to a new element. ie., it already knows 'prev data'
> >> goes with the in-progress PDU, sees more data, recognizes a new PDU
> >> header and a new payload. That means it already has to handle a
> >> 'snap-to-PDU' style argument where the end of the payload closes out an
> >> SGL element and the next PDU hdr starts in a new SGL element (ie., 'prev
> >> data' closes out sgl[i], and the next PDU hdr starts sgl[i+1]). So in
> >> this case, you want 'snap-to-PDU' but that could just as easily be 'no
> >> snap at all', just a byte stream and filling an SGL after the protocol
> >> headers.  
> > 
> > This 'snap-to-PDU' requirement is something that I don't understand
> > with the current TCP zero copy. In case of, say, a storage application  
> 
> current TCP zero-copy does not handle this and it can't AFAIK. I believe
> it requires hardware level support where an Rx queue is dedicated to a
> flow / socket and some degree of header and payload splitting (header is
> consumed by the kernel stack and payload goes to socket owner's memory).

Yet, Google claims to use the RX ZC in production, and with a CX3 Pro /
mlx4 NICs.

Simple workaround that comes to mind is have the headers and payloads
on separate TCP streams. That doesn't seem too slick.. but neither is
the 4k MSS, so maybe that's what Google does?

> > which wants to send some headers (whatever RPC info, block number,
> > etc.) and then a 4k block of data - how does the RX side get just the
> > 4k block a into a page so it can zero copy it out to its storage device?
> > 
> > Per-connection state in the NIC, and FW parsing headers is one way,
> > but I wonder how this record split problem is best resolved generically.
> > Perhaps by passing hints in the headers somehow?
> > 
> > Sorry for the slight off-topic :)
> >   
> Hardware has to be parsing the incoming packets to find the usual
> ethernet/IP/TCP headers and TCP payload offset. Then the hardware has to
> have some kind of ULP processor to know how to parse the TCP byte stream
> at least well enough to find the PDU header and interpret it to get pdu
> header length and payload length.

The big difference between normal headers and L7 headers is that one is
at ~constant offset, self-contained, and always complete (PDU header
can be split across segments).

Edwin Peer did an implementation of TLS ULP for the NFP, it was
complex. Not to mention it's L7 protocol ossification.

To put it bluntly maybe it's fine for smaller shops but I'm guessing
it's going to be a hard sell to hyperscalers and people who don't like
to be locked in to HW.

> At that point you push the protocol headers (eth/ip/tcp) into one buffer
> for the kernel stack protocols and put the payload into another. The
> former would be some page owned by the OS and the latter owned by the
> process / socket (generically, in this case it is a kernel level
> socket). In addition, since the payload is spread across multiple
> packets the hardware has to keep track of TCP sequence number and its
> current place in the SGL where it is writing the payload to keep the
> bytes contiguous and detect out-of-order.
> 
> If the ULP processor knows about PDU headers it knows when enough
> payload has been found to satisfy that PDU in which case it can tell the
> cursor to move on to the next SGL element (or separate SGL). That's what
> I meant by 'snap-to-PDU'.
> 
> Alternatively, if it is any random application with a byte stream not
> understood by hardware, the cursor just keeps moving along the SGL
> elements assigned it for this particular flow.
> 
> If you have a socket whose payload is getting offloaded to its own queue
> (which this set is effectively doing), you can create the queue with
> some attribute that says 'NVMe ULP', 'iscsi ULP', 'just a byte stream'
> that controls the parsing when you stop writing to one SGL element and
> move on to the next. Again, assuming hardware support for such attributes.
> 
> I don't work for Nvidia, so this is all supposition based on what the
> patches are doing.

Ack, these patches are not exciting (to me), so I'm wondering if there
is a better way. The only reason NIC would have to understand a ULP for
ZC is to parse out header/message lengths. There's gotta be a way to
pass those in header options or such...

And, you know, if we figure something out - maybe we stand a chance
against having 4 different zero copy implementations (this, TCP,
AF_XDP, netgpu) :(

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
