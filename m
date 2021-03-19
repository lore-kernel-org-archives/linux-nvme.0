Return-Path: <SRS0=D92Q=IR=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA6B6C433DB
	for <linux-nvme@archiver.kernel.org>; Fri, 19 Mar 2021 13:37:54 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 36E9F64EEE
	for <linux-nvme@archiver.kernel.org>; Fri, 19 Mar 2021 13:37:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36E9F64EEE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=IAkUNhG7CLjPTvqNdEPDYV6F8vY5RUCeGggcK30SxF0=; b=Gx+GgG1AqhxCRPtay3mcPEP1+
	Vq/CZZkCobd3/07pWcd0C4Q7ADG0f3E7qR1uw5I2TUW8i/Fqul2c/Vz+bUi/2kVrq84BEZIjIfpmt
	KtentVuXQDKsxGJlg0IyvHX/YoYW4zErkG/aRv2MnHmtrXgR4UMRPcK+hDvFd5MwRRG7fjBc11uP9
	kwZkHNwhJ3wtzlpK6yyZOCN17/no8CxXV2of2RGyX+PdO2kRPzILMTujz4yF3XV5sA4LXfWAZUAk9
	g5EiGrrkOAtjWeBGp15gn4hMYe+mbg07fiAikIan6GEmRYqDWe8TB9bKsZy+4gGZezulkq1IaGHXu
	+FVl4i/nw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lNFJl-007UNG-9v; Fri, 19 Mar 2021 13:37:33 +0000
Received: from verein.lst.de ([213.95.11.211])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lNFJh-007UMk-Ge
 for linux-nvme@lists.infradead.org; Fri, 19 Mar 2021 13:37:31 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 3427268C4E; Fri, 19 Mar 2021 14:29:11 +0100 (CET)
Date: Fri, 19 Mar 2021 14:29:10 +0100
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@lst.de>, io-uring@vger.kernel.org,
 joshi.k@samsung.com, kbusch@kernel.org,
 linux-nvme@lists.infradead.org, metze@samba.org
Subject: Re: [PATCH 1/8] io_uring: split up io_uring_sqe into hdr + main
Message-ID: <20210319132910.GA4249@lst.de>
References: <20210317221027.366780-1-axboe@kernel.dk>
 <20210317221027.366780-2-axboe@kernel.dk> <20210318053454.GA28063@lst.de>
 <04ffff78-4a34-0848-4131-8b3cfd9a24f7@kernel.dk>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <04ffff78-4a34-0848-4131-8b3cfd9a24f7@kernel.dk>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210319_133729_621859_592A474C 
X-CRM114-Status: GOOD (  29.01  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, Mar 18, 2021 at 12:40:25PM -0600, Jens Axboe wrote:
> > and use that for all new commands going forward while marking the
> > old ones as legacy.
> > 
> > io_uring_cmd_sqe would then be:
> > 
> > struct io_uring_cmd_sqe {
> >         struct io_uring_sqe_hdr	hdr;
> > 	__u33			ioc;
> > 	__u32 			len;
> > 	__u8			data[40];
> > };
> > 
> > for example.  Note the 32-bit opcode just like ioctl to avoid
> > getting into too much trouble due to collisions.
> 
> I was debating that with myself too, it's essentially making
> the existing io_uring_sqe into io_uring_sqe_v1 and then making a new
> v2 one. That would impact _all_ commands, and we'd need some trickery
> to have newly compiled stuff use v2 and have existing applications
> continue to work with the v1 format. That's very different from having
> a single (or new) opcodes use a v2 format, effectively.

I only proposed it for all new commands because we have so many
existing ones.

> Looking into the feasibility of this. But if that is done, there are
> other things that need to be factored in, as I'm not at all interested
> in having a v3 down the line as well. And I'd need to be able to do this
> seamlessly, both from an application point of view, and a performance
> point of view (no stupid conversions inline).
> 
> Things that come up when something like this is on the table
> 
> - Should flags be extended? We're almost out... It hasn't been an
>   issue so far, but seems a bit silly to go v2 and not at least leave
>   a bit of room there. But obviously comes at a cost of losing eg 8
>   bits somewhere else.
> 
> - Is u8 enough for the opcode? Again, we're nowhere near the limits
>   here, but eventually multiplexing might be necessary.
> 
> That's just off the top of my head, probably other things to consider
> too.

At some point there isn't much left of the common space if we
extend all that, but yeah.


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
