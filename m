Return-Path: <SRS0=WUqE=4B=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9CC4C2BA83
	for <linux-nvme@archiver.kernel.org>; Thu, 13 Feb 2020 17:03:14 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 98E01218AC
	for <linux-nvme@archiver.kernel.org>; Thu, 13 Feb 2020 17:03:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="D2U6YYwl";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="VV4LoRV9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98E01218AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=zBUF0aE1pFhqBlLnhVd5+seovGH5tnZe2xVENIARIQg=; b=D2U6YYwl3uXd71
	uJsNoqn28vIi42RXuqb/vRX8L9+oWOjNE1RnRu6Mi+ZcjQeNVr6NDM52If63s7RA1BJYkgmHPw3Mr
	0jHjZDkj74FhIGGPj/TMcolnwfDYgPu/wKM1wdzwpwXqJ4LMYIgfO8uovTg4wRmRMMrir3oGYFJ6P
	TfU1gUyd9LA70Ixh00RXJnemC0h9hXzVioXMYxAxcl0gbf3IyJATFtc2MAFa2BUGeS+6JLLir3uhD
	f+I7uQNM3YwcDlEAg0R29rWk+Qc+pQnP3BndHrf88owZeOrc51LLrF177Lx5zwGwSjBfF2PBZcRPv
	SA7xYVj7wPNQyoJQEmKA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1j2HtO-0004IV-J6; Thu, 13 Feb 2020 17:03:10 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1j2HtM-0004IB-4V
 for linux-nvme@lists.infradead.org; Thu, 13 Feb 2020 17:03:09 +0000
Received: from redsun51.ssa.fujisawa.hgst.com (unknown [199.255.47.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id B3092206DB;
 Thu, 13 Feb 2020 17:03:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1581613385;
 bh=tj8oWrMjvpzrTNVtrQ+xRVVkFV0SrHR5ddgrMqS0S9k=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=VV4LoRV9KDvQZz4rhEsXhaay7CgUYn/gmyQvfVfKbR9MTamE0O3zAzlzHcyjnqU0x
 JunwrSOpq5N1eTVsj3pvQpOxMis/exF/24u+uSuAgJwVMeiTIAW0pa8LPKdU9Q2BDb
 Sj+NR6DGfa/jG6NyFRibju8PJgfJH7XxQs+4DZy0=
Date: Fri, 14 Feb 2020 02:02:58 +0900
From: Keith Busch <kbusch@kernel.org>
To: Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH] nvme-multipath: do not reset controller on unknown status
Message-ID: <20200213170258.GC7634@redsun51.ssa.fujisawa.hgst.com>
References: <20200212134140.105817-1-hare@suse.de>
 <20200212175317.GA5813@lst.de>
 <6d4d18e3-c3a1-7d93-5abf-1ae46e18ca8c@grimberg.me>
 <3345c55f-3a42-315b-1d62-20f9aaab296e@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <3345c55f-3a42-315b-1d62-20f9aaab296e@suse.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200213_090308_196538_A9B4F358 
X-CRM114-Status: GOOD (  12.67  )
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
Cc: Keith Busch <keith.busch@intel.com>,
 John Managhini <john.meneghini@netapp.com>, Sagi Grimberg <sagi@grimberg.me>,
 linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, Feb 13, 2020 at 08:02:20AM +0100, Hannes Reinecke wrote:
> But this is precisely the case I'm arguing against here.
> One of the lessons learned from SCSI is that reset only makes sense if
> the system misbehaves and resetting it would make this error go away.
> 
> Receiving a status code which we don't know about does _not_ fall into
> this category; the very fact that we have a status code proves that the
> system does _not_ misbehave.
>
> So what exactly will be resolved by resetting?
> There actually is a fair chance that we'll be getting the very same
> error again...

I agree, the types of issues a reset may resolve don't seem applicable
if we're actually getting response. Is there even a single defined NVMe
status code where a reset would be an appropriate escalation?
 

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
