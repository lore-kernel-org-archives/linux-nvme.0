Return-Path: <SRS0=zrHs=64=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0A61C433E1
	for <linux-nvme@archiver.kernel.org>; Thu, 14 May 2020 16:22:56 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8FBC820671
	for <linux-nvme@archiver.kernel.org>; Thu, 14 May 2020 16:22:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Ujqs7s81";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZKbjDYZW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FBC820671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=3NvG7Ap5u5uQYeVM0Eo7zLFC3ugH0ulGPTIofbDbIW4=; b=Ujqs7s81WsjwlA
	WeFGWyJkT+udWZCB7t6FDArdQlOXr0tdnwceI44QEWQqpocQg8CAnLjSWCEcnkT94F7Qlgoh2/8at
	CghuaIGj8wOfTj8KUprgtZU4C4KPP2uCbwwbdFNluBnIIp9DsPQe6ss+4ut1W1HnOzH6Kei66g9sB
	knBJnaN2QPF2dDB4j4NQeaFtFrYxOvGAgnyW986UYiIFNLqguPKVJ2Yj71OEYOT24iL6Or/RZdrmm
	NoWH8dQPONTQGIpUp8xT4bdc7zz6zZptJq0k4k1ELGWa2lfqF/2RFKkhKGiBe+6L+zJB8WsAqmB/L
	oYWWknR9FxYptEOfd+6g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jZGdH-0005rR-Gg; Thu, 14 May 2020 16:22:51 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jZGdF-0005r1-1K
 for linux-nvme@lists.infradead.org; Thu, 14 May 2020 16:22:50 +0000
Received: from redsun51.ssa.fujisawa.hgst.com (unknown [199.255.47.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id D20BF20671;
 Thu, 14 May 2020 16:22:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1589473368;
 bh=Fte72Mbp/XZajmoLfK0TqqRBmILe0jrvJk7vfY2qFHY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=ZKbjDYZWX8hARURlHDbWYHecqa1XxnFVVkhkUCMOw8CF9sy+LHNVS+N8oepswJ6YB
 hNIWOVU4xwe8omRZGZuPB4mWYp5d9p8CKhVy0JMX13l2jhjPzT3TljDZ1ismQIHpST
 gT+pj3r3APu5eZ9UYKzkJs1MWKf1rpVmRVOETSJg=
Date: Fri, 15 May 2020 01:22:41 +0900
From: Keith Busch <kbusch@kernel.org>
To: Martin George <martinus.gpy@gmail.com>
Subject: Re: [PATCH] fabrics: write reconnect_delay to fabrics device on
 connect
Message-ID: <20200514162241.GA2847@redsun51.ssa.fujisawa.hgst.com>
References: <20200511143715.2524-1-marting@netapp.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200511143715.2524-1-marting@netapp.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200514_092249_096484_7040BDC3 
X-CRM114-Status: UNSURE (   7.67  )
X-CRM114-Notice: Please train this message.
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
Cc: Martin George <marting@netapp.com>, linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Mon, May 11, 2020 at 08:07:15PM +0530, Martin George wrote:
> 
> Though '--reconnect-delay' option is defined for connect, it
> wasn't passed down to the kernel in connect_ctrl().

Applied, thanks.

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
