Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A31DC25B74
	for <linux-nvme@archiver.kernel.org>; Thu, 30 May 2024 06:35:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bbTCd5ZzyD5Ep6aQk9TPKymJAQmfQH6kjWgkoWaLYuA=; b=0eS0+CqdSxkllPW08uScIVDIEC
	6A6v7turT0RCWea8GuvGICLqDCWfxl9ReRH2YfAC894MxeZwe+mv6AhcaUIdTOFG6LwjKMDP763oF
	lRwH1m6thjg5xzyOn2eSJo4EHvyVkFOxfV8uv8gFAHNY3yuwj1a+Nym7HuhxkVdagexl51ST3Booq
	qkRx59T9EaVUNDLlQvPJFD9kIBYvbqamzIjR4nGel/BnFHQThfY3QJHSZOLUMZXDtvG0NDRoYfSGH
	LCj19daecVN/fykoblx6IPlZUBgJm6+oifnXQoiqyc7dxP7Gw2C1x3TTmdWPsifoROmEQxaCYIsrz
	CwTx7VRA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sCZNq-00000006QnF-0COi;
	Thu, 30 May 2024 06:35:33 +0000
Received: from out30-111.freemail.mail.aliyun.com ([115.124.30.111])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sCZNS-00000006QmE-2EKH
	for linux-nvme@lists.infradead.org;
	Thu, 30 May 2024 06:35:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1717050901; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=bbTCd5ZzyD5Ep6aQk9TPKymJAQmfQH6kjWgkoWaLYuA=;
	b=N+EXSj4sQo0Im/iKlMxDaItzbctAQT2GTGx0xXAtjXkV+3lCBhLU501vIHXIK7BP0I+Ci6CpwvfpVBodJgrzdfFHvO+79YLsZGuXk/I1lsKUeL1CdY8UymlUft9iGN71cU0/6khMDcy8xMIHdRoWnheZAwJjap0oSJqQnnhVwsE=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R911e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067113;MF=huweiwen@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0W7W.QNX_1717050898;
Received: from U-4C66YGPR-1953.local(mailfrom:huweiwen@linux.alibaba.com fp:SMTPD_---0W7W.QNX_1717050898)
          by smtp.aliyun-inc.com;
          Thu, 30 May 2024 14:35:00 +0800
Date: Thu, 30 May 2024 14:34:57 +0800
From: Weiwen Hu <huweiwen@linux.alibaba.com>
To: Keith Busch <kbusch@kernel.org>
Cc: Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	Mike Christie <michael.christie@oracle.com>,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 1/3] nvme: fix nvme_pr_* status code parsing
Message-ID: <ZlgeEbeLPkDx9mE3@U-4C66YGPR-1953.local>
References: <20240529122300.92377-1-huweiwen@linux.alibaba.com>
 <20240529122300.92377-2-huweiwen@linux.alibaba.com>
 <d5cdd059-cf7a-4465-8712-7814fe41f9b8@nvidia.com>
 <ZlehEZyVyJ0qUvWG@kbusch-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZlehEZyVyJ0qUvWG@kbusch-mbp.dhcp.thefacebook.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240529_233506_815894_009F9033 
X-CRM114-Status: GOOD (  23.54  )
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

On Wed, May 29, 2024 at 03:41:37PM -0600, Keith Busch wrote:
> On Wed, May 29, 2024 at 07:18:36PM +0000, Chaitanya Kulkarni wrote:
> > On 5/29/24 05:22, Weiwen Hu wrote:
> > > Fix the parsing if extra status bits (e.g. MORE) is present.
> > >
> > > Renamed nvme_sc_to_pr_err to nvme_status_to_pr_err to better match its
> > > semantic.
> > >
> > > Fixes: 7fb42780d06c ("nvme: Convert NVMe errors to PR errors")
> > > Signed-off-by: Weiwen Hu <huweiwen@linux.alibaba.com>
> > > ---
> > >   drivers/nvme/host/pr.c | 10 +++++-----
> > >   1 file changed, 5 insertions(+), 5 deletions(-)
> > >
> > > diff --git a/drivers/nvme/host/pr.c b/drivers/nvme/host/pr.c
> > > index e05571b2a1b0..25e23cdba151 100644
> > > --- a/drivers/nvme/host/pr.c
> > > +++ b/drivers/nvme/host/pr.c
> > > @@ -72,12 +72,12 @@ static int nvme_send_ns_pr_command(struct nvme_ns *ns, struct nvme_command *c,
> > >   	return nvme_submit_sync_cmd(ns->queue, c, data, data_len);
> > >   }
> > >   
> > > -static int nvme_sc_to_pr_err(int nvme_sc)
> > > +static int nvme_status_to_pr_err(int nvme_status)
> > 
> > do you really have to make this helper name longer ?
> > nvme_sc matches the NVME_SC and makes it easy to grep when
> > looking for symbols and error codes, but if everyone is okay with
> > this then sure go ahead ...

I change it specifically because nvme_sc matches NVME_SC_* too good. That makes
people think nvme_sc can be compared to NVME_SC_* directly, but it can not
actually.  We may think of another name, but "sc" is not appropriate IMO.

"sc" specifically refer to the last 8 bit in the status field in NVMe spec, and
nvme_is_path_error() also use "status" as its parameter name. So I think
"status" can be a good choice.

> 
> Yeah, I'd agree. In fact, just resend with only the "& 0x7ff" masking
> for the "Fixes" part of this, and that can go in for 6.10. Potential
> enhancments can come after.

OK, resent the first patch. I will resent the refactors after the discussions
here are concluded.
 
> > > -	switch (nvme_sc) {
> > > +	switch (nvme_status & 0x7ff) {
> > >   	case NVME_SC_SUCCESS:
> > >   		return PR_STS_SUCCESS;
> > >   	case NVME_SC_RESERVATION_CONFLICT:

