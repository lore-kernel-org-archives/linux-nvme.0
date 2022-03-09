Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5F57C433F5
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Mar 2022 01:14:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=atVirWp5UnB0pCBJ+B8S1+gB8mjuq+Yu+nHp7/C14ao=; b=oJkQFmrbnJ7ED42CgQqez76q5x
	7rCk4A42qjSCwUtuSrDnIkI3oZXlmFaO6xxQEQTgJW5042TwpcgvLg0RUHv+Ats2XSKY89cOyyCc5
	04DTX9zWNJxVJoDxZnSRdcyvTp6uqfJNOFoxvh37jn3aIeUtIW83hmTGNxBm9jDDJMeD5eVCiYzGj
	/FiuvQnDPcTBtLr8V8QkXGz3YjETlm4kXqE2ZA1yyd+XjoDZ1hG9sHa69jM3nA0lYofD/p1XWgg+G
	ytO9tFcxwQ4dRSAIzLzZ9FOUBb1mdTAFgBswaYdVEbI/WlhXXU0+RpFklG9jEdKAcSnLKwzncdTGZ
	vs3JjfZg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nRkuS-006oON-41; Wed, 09 Mar 2022 01:14:36 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nRkuP-006oNA-EW
 for linux-nvme@lists.infradead.org; Wed, 09 Mar 2022 01:14:34 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id F0A0D61325;
 Wed,  9 Mar 2022 01:14:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33317C340EB;
 Wed,  9 Mar 2022 01:14:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1646788472;
 bh=KMmFpphAkJw5H4xtgMoUXBjVB0II6e0xEoEd+Ma14SA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=MQ2VHAKm0dkruIO7sm8cDWuBpBCF8q3ht9jRbIb/eteVP4X+X4R+6OtFhPCXGi7Bs
 mmbhG2qCUR4C6QWdT/BLnFb/vK7he71VqEj2BpOS9aZBVPVfCpJ2K2mWq6OKJf0WJ8
 P/aYodaUm9eMOD35Aan2VNFIwBhQ/+CVkO19nHUuPreLgwXEGzdilyMAYSUPAO0wLp
 4SWSXetvELZ6Jbp0kOUSI1ponykJQZnuqw26VTDXkWY+QnuwrYhYHgTtZKdtq7BXLR
 VLNuc6DGjEzf8eGnKrzpkEdgm6Z3hh3LvXXOfZDdfFENJqqy06NSLzX3Vs1HXd8XrM
 SIHnOOKvs35OA==
Date: Tue, 8 Mar 2022 17:14:29 -0800
From: Keith Busch <kbusch@kernel.org>
To: Ming Lei <ming.lei@redhat.com>
Cc: Maurizio Lombardi <mlombard@redhat.com>, linux-nvme@lists.infradead.org,
 axboe@fb.com, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, Ming Lei <minlei@redhat.com>,
 linux-kernel@vger.kernel.org
Subject: Re: nvme-host: disk corruptions when issuing IDENTIFY commands via
 ioctl()
Message-ID: <20220309011429.GA3948855@dhcp-10-100-145-180.wdc.com>
References: <CAFL455n1WaRxZuqCeQGWt1MVDnK8uUytUsAUVEUV9-LLQYv9gQ@mail.gmail.com>
 <20220308195238.GC3501708@dhcp-10-100-145-180.wdc.com>
 <YifyZ9MoUws/7esK@T590>
 <20220309003904.GA3948780@dhcp-10-100-145-180.wdc.com>
 <Yif8svaBscrL9WZk@T590>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yif8svaBscrL9WZk@T590>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220308_171433_554195_6FEB28FE 
X-CRM114-Status: GOOD (  20.67  )
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

On Wed, Mar 09, 2022 at 09:02:42AM +0800, Ming Lei wrote:
> On Tue, Mar 08, 2022 at 04:39:04PM -0800, Keith Busch wrote:
> > On Wed, Mar 09, 2022 at 08:18:47AM +0800, Ming Lei wrote:
> > > Given NVMe spec states that data length of IDENTIFY command should be
> > > 4096bytes, and PRP list can't be used. 
> > > 
> > > So looks nvme driver need to validate the command before submitting to
> > > hardware, otherwise any buggy application can break FS or memory easily.
> > 
> > No way. The driver does not police the user passthrough interface for
> > these kinds of things.
> 
> So you trust application to provide correct data always?
>
> From user viewpoint, this defect provides one easy hole to break FS or
> memory, it is one serious issue, IMO. The FS/memory corruption can
> be reproduced easily even in VM.

It doesn't seem so serious considering it's been this way for 10 years,
and we already knew about this. It's even been reported before:

  http://lists.infradead.org/pipermail/linux-nvme/2013-August/000365.html

> > It couldn't ever be complete or future proof if
> > it did.
> 
> But the spec states clearly the data length of IDENTIFY command is 4096
> and PRP list can't be used, so why do you think it isn't complete or
> future proof to validate data length of IDENTIFY in nvme driver?

The current spec says that opcode uses 4k today. What about some time in
the future? And why are you focusing on Identify anyway? The same
potential for abuse exists with any of the other numerous opcodes that
don't have a fixed transfer size, most of which the driver couldn't
possibly ever know what the transfer length is supposed to be. This is a
priviledged operation; the applications get to own the fallout if they
misuse it.

