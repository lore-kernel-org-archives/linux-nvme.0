Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D689EE7C4E2
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Oct 2023 17:32:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8Ug3lR9zhPv/2XylFpKuTSQDn6iRr4EhPVNHKOye1i8=; b=eBF9TLU5ec3Whcdj3qZRlsFQsH
	puL727otjuEqzv5eJUvwSjOeVrUTRv23usDm17s3kdlZwvFkgLBRBM8cs/am/ocVCT4MpiFIWUiDm
	+iiPjgNSMYazSlbdXGlJA5ytBPlhGOQCfpp0pBI/d+gUDtIApgLYAVs4jnI8qP/J3q6K4EZIK60ja
	8hnAdK0mn2hqyQWdXPYfqKDyyQcVhZknV/+fKMLl+WsMW7vpSUhXovM8yMV9osUOnNvLnwoP6fgWv
	tEW80XsXJV+/ZSgz6XWNiT7CkwPaFK2VLHIRmYTYMz+oQqCknW84qLfuPZ8h4vZoILV5wi7M2CGA3
	SMmE467Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qo5jf-000bax-2S;
	Wed, 04 Oct 2023 17:32:35 +0000
Received: from sin.source.kernel.org ([145.40.73.55])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qo5jc-000baS-2A
	for linux-nvme@lists.infradead.org;
	Wed, 04 Oct 2023 17:32:34 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id E7778CE19E5;
	Wed,  4 Oct 2023 17:32:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21561C433C9;
	Wed,  4 Oct 2023 17:32:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696440748;
	bh=W9hkSL3Mou8wKa/FxxQNX9QCvyVPYGZ0u/8FwzlXasI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QXYPi9UjTP8PQ8stedo0wU9LxoUWM/fYZ+QMZC5fnRES7C46Ds0UCkChL6u0fzOGY
	 f1SrEOHO7JjYa8G2kB+cP6U9bs0LKNsWbdCzek0Jd5hz6E+YglF4wPM/zm7W6DVo9o
	 /eAzzwyKgocWEhMM9oG+dKUpf7vo5Deij8A+c3yDi2oud8SA3vF2oRrJSi1NzEykqZ
	 kmx0QwgWAzGefulqKuoFFx0iwyUgiMKIUyZf1dLdbmU8ojtFUdSHtj6DeISva7OXiQ
	 rxXIemlrwAxQP4EU3FvtxaXBM1REHqj3ndvf51Z6DtIepweA2nmVBU5Tk7UlvNPqJO
	 Y7WL9ZzloeJWw==
From: SeongJae Park <sj@kernel.org>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Greg KH <gregkh@linuxfoundation.org>,
	sj@kernel.org,
	linux-nvme@lists.infradead.org,
	Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
	zahavi.alon@gmail.com,
	stable@vger.kernel.org
Subject: Re: [PATCH] nvmet-tcp: Fix a possible UAF in queue intialization setup
Date: Wed,  4 Oct 2023 17:32:26 +0000
Message-Id: <20231004173226.5992-1-sj@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <01901640-fc6d-5d15-3aa0-9f4586ba5141@grimberg.me>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231004_103232_904181_1450CC43 
X-CRM114-Status: GOOD (  24.89  )
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

On Wed, 4 Oct 2023 16:25:13 +0300 Sagi Grimberg <sagi@grimberg.me> wrote:

> 
> >>> Hello,
> >>>
> >>> On Mon, 2 Oct 2023 13:54:28 +0300 Sagi Grimberg <sagi@grimberg.me> wrote:
> >>>
> >>>>   From Alon:
> >>>> "Due to a logical bug in the NVMe-oF/TCP subsystem in the Linux kernel,
> >>>> a malicious user can cause a UAF and a double free, which may lead to
> >>>> RCE (may also lead to an LPE in case the attacker already has local
> >>>> privileges)."
> >>>>
> >>>> Hence, when a queue initialization fails after the ahash requests are
> >>>> allocated, it is guaranteed that the queue removal async work will be
> >>>> called, hence leave the deallocation to the queue removal.
> >>>>
> >>>> Also, be extra careful not to continue processing the socket, so set
> >>>> queue rcv_state to NVMET_TCP_RECV_ERR upon a socket error.
> >>>>
> >>>> Reported-by: Alon Zahavi <zahavi.alon@gmail.com>
> >>>> Tested-by: Alon Zahavi <zahavi.alon@gmail.com>
> >>>> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
> >>>
> >>> Would it be better to add Fixes: and Cc: stable lines?
> >>
> >> This issue existed since the introduction of the driver, I am not sure
> >> it applies cleanly that far back...

Based on the rule[1], I think people who need this fix on the old kernel would
do that.  I'd just say adding Fixes: would help it, so better than nothing.

[1] https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html

> >>
> >> I figured that the description and Reported-by tag will trigger stable
> >> kernel pick up...
> > 
> > <formletter>
> > 
> > This is not the correct way to submit patches for inclusion in the
> > stable kernel tree.  Please read:
> >      https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
> > for how to do this properly.
> > 
> > </formletter>
> 
> I could have sworn to have seen patches that did not have stable CCd
> nor a Fixes tag and was picked up for stable kernels :)

I could also swear.  Stable kernel maintainers are great at finding fixes on
their own.  But I think adding those could help them avoiding any mistake, and
therefore better than nothing, again.

> But I guess those were either hallucinations or someone sending patches
> to stable...
> 
> I can resend with CC to stable.

Thank you :)


Thanks,
SJ

> 
> Thanks.
> 
> 

