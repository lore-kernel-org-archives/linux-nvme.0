Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF61CC433F5
	for <linux-nvme@archiver.kernel.org>; Wed,  6 Apr 2022 17:22:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=j0YAuofNyVRBrLqFvRPSgCZ1AATK42Wl6B7GmthEW9Q=; b=I2EQXkuMjvoWTgxlsR+w9bRWkr
	4cml2ziDaxk9Ptnh7FezM2lqMXF3I7Eql6FHBc2jG3TQZAtdpQu6BgqeQab+Ts0DVDmE55ltXt+Cl
	p3289Lkj2OD1fohr1EWv8JXPHUwIFMawyitOt2hb/1NQVm6ER6n8M+5Mg6DhXqqqyftkPgWYgLXOe
	ER2quNSnoU5uCubX1s6pSlOWSAaecsGgst/dWohCmh3LI7qW6ObfXsAY8KlbwHGKnS36XnDAY7NrZ
	HUrfWKzQKjsoVU8w+DYiqJCvqAKMjkmbsNfUAuwSzvGccbRwiqIeN/mx8he+bMEWqBCLEW7ENDvZG
	RzqeRfWQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nc9M7-007LNw-EU; Wed, 06 Apr 2022 17:22:07 +0000
Received: from ams.source.kernel.org ([2604:1380:4601:e00::1])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nc9M3-007LMn-Vv
 for linux-nvme@lists.infradead.org; Wed, 06 Apr 2022 17:22:05 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 99373B82257;
 Wed,  6 Apr 2022 17:22:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC9D3C385A1;
 Wed,  6 Apr 2022 17:22:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1649265721;
 bh=lGAvfHI/jM3ZN8Yi0RrK4vO1CNk/H4bXkTqdbMRzoDc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=fGW/NMXbTNNf/0jKCxsy3ydzEGLiDWntFYQkj2vFTA0AOhnw4KWIOVtEQKW6ldGOk
 KR6CgtkXr+rGMjl93AuW4R/SJ0l5l/y7qsEqYHhDUKZ5w3zIuETGpJOgwH5mpBXaX9
 tNVT32sEvn0on6YxnuMLRrvK7KCFiWJFGDGHlTT8F1jD/6H5xM86YAM7lPMx1XAmjW
 jgNZ/yuyramPnzvPKTlVg6BDLa9dhZjNJpybtI4d+QWP2aaky7EwV6vi9j+P2MeQ7R
 bqYEllXYjVf08+gq9O6XHxEL6fkJdvfCbwOxP3C8kDVx6cl3WRlmSRjdhnpPeG9UN4
 0nB9OMRofo4oA==
Date: Wed, 6 Apr 2022 11:21:58 -0600
From: Keith Busch <kbusch@kernel.org>
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "hch@lst.de" <hch@lst.de>,
 "alan.adamson@oracle.com" <alan.adamson@oracle.com>
Subject: Re: [PATCH] nvme-core: mark passthru requests RQF_QUIET flag
Message-ID: <Yk3MNrI3YfjvbRqZ@kbusch-mbp.dhcp.thefacebook.com>
References: <20220406164109.30449-1-kch@nvidia.com>
 <Yk3FT78uVW+9rRV5@kbusch-mbp.dhcp.thefacebook.com>
 <21a3a237-5f3b-a608-2d79-e0a5fdcc0d88@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <21a3a237-5f3b-a608-2d79-e0a5fdcc0d88@nvidia.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220406_102204_230415_C377DE74 
X-CRM114-Status: GOOD (  15.99  )
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

On Wed, Apr 06, 2022 at 05:01:46PM +0000, Chaitanya Kulkarni wrote:
> On 4/6/22 09:52, Keith Busch wrote:
> > On Wed, Apr 06, 2022 at 09:41:09AM -0700, Chaitanya Kulkarni wrote:
> >> @@ -370,7 +370,8 @@ static inline void nvme_end_req(struct request *req)
> >>   {
> >>   	blk_status_t status = nvme_error_status(nvme_req(req)->status);
> >>   
> >> -	if (unlikely(nvme_req(req)->status != NVME_SC_SUCCESS))
> >> +	if (unlikely(nvme_req(req)->status != NVME_SC_SUCCESS &&
> >> +		    !(req->rq_flags & RQF_QUIET)))
> >>   		nvme_log_error(req);
> >>   	nvme_end_req_zoned(req);
> >>   	nvme_trace_bio_complete(req);
> >> @@ -651,6 +652,7 @@ void nvme_init_request(struct request *req, struct nvme_command *cmd)
> >>   	cmd->common.flags &= ~NVME_CMD_SGL_ALL;
> >>   
> >>   	req->cmd_flags |= REQ_FAILFAST_DRIVER;
> >> +	req->rq_flags |= RQF_QUIET;
> > 
> > This defeats the admin error logging logic since every admin command comes
> > through here. If you're sure we should do this, then I suppose you can remove
> > that unreachable code.
> 
> If you point out the unreachable code that will be great,
> I'll keep looking meanwhile...

The second half of nvme_log_error(), plus nvme_get_admin_opcode_str() and the
array it defines are unreachable since all admin commands don't log errors with
this change.

You could skip the RQF_QUIET setting and check blk_rq_is_passthrough() instead.

