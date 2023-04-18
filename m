Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 921A1C6FD18
	for <linux-nvme@archiver.kernel.org>; Tue, 18 Apr 2023 18:21:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+Vb51FrCA0x6tudFNHJPxL6H9t8CJX0lMGUkKX+YACg=; b=4+RGOk1Pc/IbCpMuUDN6USzFPZ
	juF5sQRnYsm+L9q/Pl+d2jUocRyYx4uQ0cWAVhr4uLb0RubD7RgMiuCanrayh+/ha79cJK4iuUqAq
	WwyOWjqclhqJxdi3izps+qbQ2aRcxPfkd1/vsCUif/NY17wEVN9U2wykd7qxukgheZ/H0gX6GlmQH
	st730IY5roqlzOB6BGRKVVOz568do+XFRqxRDzqKax65Jn2zRXIqEJUmTwFc1kMultuU9t4S4H4rp
	0yyH949TD62TDBiHHm9/0hbfRyJl0NQpODkAeXoowNdzdH1zSpkmZqg9ENqWQs+VK2WBtebuD5qJ4
	A36fkuFA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1popxY-00332k-13;
	Tue, 18 Apr 2023 18:21:44 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1popxV-00332C-3B
	for linux-nvme@lists.infradead.org;
	Tue, 18 Apr 2023 18:21:43 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 2B56A637E7;
	Tue, 18 Apr 2023 18:21:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D81CC433D2;
	Tue, 18 Apr 2023 18:21:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1681842100;
	bh=9dvoyZb0MWqatGlzMrz+nMM+VV4b7Xxa7SB0wWjMDWE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Geea2t25czw64u+Gbxdb/RPfuxKHZ/W8yTnK4zawCkLCOzUpX25c3WVL1m36yv62O
	 ZBwC74PzBORY4AQzsP84JsI1udvQb/f3q6lHeZSOdVQPEVOs75+wHnJuvjnk9p3/rX
	 5v+EBGxJUO8hEj8NEoCYatO9tseaQg6ZPT9ZYpPRL3186S8D9wICG1VxIXjbZMjKqK
	 dG4q3I86OODZREQ5jUbxj8FXuoxLDlgvj+whEPf1HwlTMr3iwu0nNduzvYRUE2Cdjx
	 QTqymNutq+7gSEXogmaadoztgBG9G2PApbzkUTkIbe7Ae8cQgjwxvjKwSQuSbw6hhB
	 YHdGQBwjPDkig==
Date: Tue, 18 Apr 2023 11:21:39 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Hannes Reinecke <hare@suse.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>, Keith
 Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org, Chuck Lever
 <chuck.lever@oracle.com>, kernel-tls-handshake@lists.linux.dev, Vadim
 Fedorenko <vadim.fedorenko@linux.dev>
Subject: Re: [PATCH 08/18] nvme-tcp: do not set MSG_SENDPAGE_NOTLAST
Message-ID: <20230418112139.546aff79@kernel.org>
In-Reply-To: <f02fb607-1339-2c68-4bd5-ced65d71b822@suse.de>
References: <20230417130302.86274-1-hare@suse.de>
	<20230417130302.86274-9-hare@suse.de>
	<36976756-b4c5-f2a5-34b8-e9731a49c477@grimberg.me>
	<654702da-246a-934c-14e4-7b179c46ed98@suse.de>
	<5df08f86-2599-6e47-2fdc-bda8d70edaf2@grimberg.me>
	<20230417131654.427ebd6a@kernel.org>
	<f02fb607-1339-2c68-4bd5-ced65d71b822@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230418_112142_089133_F22AFCDC 
X-CRM114-Status: GOOD (  18.19  )
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

On Tue, 18 Apr 2023 12:33:03 +0200 Hannes Reinecke wrote:
> Ah-ha. Found it.
> 
> Turns out to be an arguably invalid control flow on our side.
> 
> The initial 'connect' command is a command PDU with inline data.
> So in our (current) flow we do a 'sendpage()' with the 
> MORE/SENDPAGE_NOTLAST flag set as we have to transfer more data.
> Ok so far.
> But for transmitting the actual data we evaluate 'sendpage_ok()', which 
> returns _false_. And then we continue to call 'sendmsg()' for the inline 
> data.
> This confuses the TLS software stack as sendpage() and sendmsg() are two 
> distinct code paths, and we end up with a TX stall.
> 
> Solution: check 'sendpage_ok()' when we have inline data and use 
> 'sendmsg' for the command pdu if required.
> 
> It always pays to dig deeper if one's not exactly sure what's happening ...
> 
> Will be updating the patchset.

Hm, yeah, sendpage(NOT_LAST)+sendmsg() could indeed be buggy/untested.
It wasn't something we could have tested from user space, we'd need
kunit or some such :(

Adding it the backlog. And adding Vadim to CC in case he has cycles 
to take a look.

