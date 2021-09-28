Return-Path: <SRS0=nS76=OS=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBA8CC433EF
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Sep 2021 20:41:30 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 797056137E
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Sep 2021 20:41:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 797056137E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=MmNIFOUGzt5ZbtZ741nBNPyqnc+pfP/+zujxBJxyDwo=; b=AUPxcL0VKZZDCY
	kYowptICPWV3gvQsuBW4GdORkp/rlvRYn9iJWr2xkT4PZ7nsuO7wnlIPBK9zkakYrxtgYY6Clnky5
	JMtnDDbp9lIksjUTQbPrM/8Ld7X5uGB9M+j7RZ13Eie8Rz30es98NpJbvgxaN1XqbwpGGXQ2fCfRV
	pUcjSTVc+l6KEVFQmAMLHKVjpFBHumBmCFckq73cQCuZ828Z0UEHKaSUdAzATgo5/zvIZ6FMOHq1J
	2aMZyO3DbqBbsjhB7bf/nya/ZkRbqE1oyCMrMX+MpRf2Uzl80fDNutWr/XaVs8vC2r4RsK4mckkoj
	xlab4jub0CAz8027aGKg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mVJuM-008mXV-NW; Tue, 28 Sep 2021 20:40:58 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mVJuJ-008mX1-EK
 for linux-nvme@lists.infradead.org; Tue, 28 Sep 2021 20:40:56 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6892E6136F;
 Tue, 28 Sep 2021 20:40:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1632861654;
 bh=NLf12B7HJC8SjIhd363qbSg5tbs/ByEhomOR8oYu2nY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=seSUTJC2waLQYvrtkcZ3Pmo0TFK0nkxlu8aTjIE9PQCqPcc17GpNMmzffdXCA0hI5
 JGExwa4nnmhC7XAxdG5h+p/H56gpBIEueWLeniuGDtWgWOmsVTLyxh10YLfMyFW7fz
 sse5tBsNEgcvw3MOjjqIMcJtWr2eYEOALAoWKspLhYZyY0xEWgyorS3ZidVAOU6zkL
 KcYd6JGHdTXR1sjJhEfvMaQNPw0423RwFD+mYAFvQr0AtS9eq/EvZzyOI/N9rOrld/
 FUfajk4fOLEnLd7htplwvVgbUs+6VfXB05iqIjexBjBmwvwQAhjgzujf6IwPPX3aYh
 C13VMp0+ttnUQ==
Date: Tue, 28 Sep 2021 13:40:52 -0700
From: Keith Busch <kbusch@kernel.org>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Subject: Re: [PATCH] nvme-tcp: fix incorrect h2cdata pdu offset accounting
Message-ID: <20210928204052.GA390773@dhcp-10-100-145-180.wdc.com>
References: <20210914153855.16177-1-sagi@grimberg.me>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210914153855.16177-1-sagi@grimberg.me>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210928_134055_518647_E8F36960 
X-CRM114-Status: GOOD (  17.66  )
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

On Tue, Sep 14, 2021 at 06:38:55PM +0300, Sagi Grimberg wrote:
> When the controller sends us multiple r2t PDUs in a single
> request we need to account for it correctly as our send/recv
> context run concurrently (i.e. we get a new r2t with r2t_offset
> before we updated our iterator and req->data_sent marker). This
> can cause wrong offsets to be sent to the controller.
> 
> To fix that, we will first know that this may happen only in
> the send sequence of the last page, hence we will take
> the r2t_offset to the h2c PDU data_offset, and in
> nvme_tcp_try_send_data loop, we make sure to increment
> the request markers also when we completed a PDU but
> we are expecting more r2t PDUs as we still did not send
> the entire data of the request.
> 
> Fixes: 825619b09ad3 ("nvme-tcp: fix possible use-after-completion")
> Reported-by: Nowak, Lukasz <Lukasz.Nowak@Dell.com>
> Tested-by: Nowak, Lukasz <Lukasz.Nowak@Dell.com>
> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
> ---
> - Keith, can you ask the WD team to test this as well?

I finally have some feedback on testing, and it looks like this patch
has created a regression. The testers are observing:

  [Tue Sep 28 02:12:55 2021] nvme nvme6: req 3 r2t len 8192 exceeded data len 8192 (4096 sent)
  [Tue Sep 28 02:12:55 2021] nvme nvme6: receive failed:  -71
  [Tue Sep 28 02:12:55 2021] nvme nvme6: starting error recovery

Which we had seen before, and you fixed with commit:

  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit?id=825619b09ad351894d2c6fb6705f5b3711d145c7

I only just recently heard about this, so I haven't looked into any
additional possible cause for this regression yet, but just wanted to
let you know earlier.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
