Return-Path: <SRS0=HgRT=5J=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35B4EC43331
	for <linux-nvme@archiver.kernel.org>; Tue, 24 Mar 2020 16:20:41 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 090D82073E
	for <linux-nvme@archiver.kernel.org>; Tue, 24 Mar 2020 16:20:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="WBq14Q8O";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="0WJf2kZ3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 090D82073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=m9AdpVVYcBA5Mhma9aRqckWcZb0qqCnG9EO4iCStSJM=; b=WBq14Q8Olh/Ed+
	9X5obDutVIlePJXXu5h1tOIUOtagRkA3vw1qLyg/vRQxSy3/rG/a/wQTAxpBRrGIlbOBgdKu9Waw3
	DVlfc6uxqygdf6b4SFne4/gpBJcjUB6MUi5p66f7f3ZnqaJiANGCGlTjRsMii8FdiVlmqRWL/rUL9
	nWJdjJCjkKDa8HJpmvVPsWKFJR/x8pa4dva2TGOcLNuasLTpe2mIKCZonpJFoyYO7ixT7+SZFAuqQ
	At/xGXjzg7Wn6kLb/oLNL0Zeak5KCs/dDOhxahfk9AMhzo1aQKE/wd9lj0XuLpYhkhXBikRZoCWz/
	GY53kfDfpSusevY8eZ9g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jGmI9-0004iG-VI; Tue, 24 Mar 2020 16:20:37 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jGmI8-0004he-3j
 for linux-nvme@lists.infradead.org; Tue, 24 Mar 2020 16:20:37 +0000
Received: from redsun51.ssa.fujisawa.hgst.com (unknown [199.255.47.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 1531F2073E;
 Tue, 24 Mar 2020 16:20:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1585066835;
 bh=qGI8shyX0mcDqQKmGNvD4oXC5Q9IgR2cQc+prDbBC2Y=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=0WJf2kZ3gOs16rDm+KBUe1ksMsArcLquuviZdbsW5ZrdfUPbMRsw0/0tdTtKE9PwJ
 nZ9PcDpmPZngRCorVbmC1fC7Pqj9rRC5uYNeQ9VJIzCsn1WF3iP5Mq3tCw+dyvCpDi
 /v1I2jbqGgUfDlEmKtVKuyAycGIeaBs/acmDYRM0=
Date: Wed, 25 Mar 2020 01:20:32 +0900
From: Keith Busch <kbusch@kernel.org>
To: Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH] nvme-tcp: fix possible crash in write_zeroes processing
Message-ID: <20200324162032.GC30956@redsun51.ssa.fujisawa.hgst.com>
References: <20200323220630.14900-1-sagi@grimberg.me>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200323220630.14900-1-sagi@grimberg.me>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200324_092036_175050_6C57CED1 
X-CRM114-Status: GOOD (  10.28  )
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
Cc: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Mon, Mar 23, 2020 at 03:06:30PM -0700, Sagi Grimberg wrote:
> We cannot look at blk_rq_payload_bytes without first checking
> that the request has a mappable physical segments first (e.g.
> blk_rq_nr_phys_segments(rq) != 0) and only then to take the
> request payload bytes. This caused us to send a wrong sgl to
> the target or even dereference a non-existing buffer in case
> we actually got to the data send sequence (if it was in-capsule).
> 
> Reported-by: Tony Asleson <tasleson@redhat.com>
> Suggested-by: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>

Applied for 5.6, thanks.

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
