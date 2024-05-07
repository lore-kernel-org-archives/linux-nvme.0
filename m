Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FF3EC10F1A
	for <linux-nvme@archiver.kernel.org>; Tue,  7 May 2024 15:08:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FccU009ahZQbYrA0GKnlDX4FDykbZk97qVjIGVNccF8=; b=iAGMimGGSQcUGQcnWXU23+84Lj
	dI4ZD2YfkEygquelhq/AMQak2sapfZPat20eRwluFGMaIxF/gGwjG+4WLGk851Y1EhXYrsR90/gmd
	uIcnVImX97asPLDa/LZ/QEucwmSfOy5UK8YhYhcAIQK0sVDBLHiQ8VKobmZ9SWhh2a36K758hoi84
	NSPUiH9qgAOsb6lJDzxKY9xrv8w6SWIRj8qH5QmUD0drwKxxE+yyagXlFDOlVkYgdpFZWTznyEfsJ
	O1S+Ok1z5zpMLCaeThBgF+4ORsPdCcg/nUZaQ2h+XhBRbGr0yvav9ZoPBEcgqKkIm0VeytZuIpOsr
	biiwoJFw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s4MQh-0000000BfYT-2130;
	Tue, 07 May 2024 15:08:31 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s4MQe-0000000BfXb-1yJx
	for linux-nvme@lists.infradead.org;
	Tue, 07 May 2024 15:08:29 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id ED9FE616F0;
	Tue,  7 May 2024 15:08:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 580B1C2BBFC;
	Tue,  7 May 2024 15:08:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715094507;
	bh=2Ny8QNPQctxLXHmPoWuNPeNM1KIsJaxQF7Q9hi9vDUU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sv1eueVuLHj8EHtroeQptznQg9dz/ECvpaAREYnNq45DSUl2C6fXyQeYpJHo3kRzh
	 s7kil9WHZCcTZrdypPboo6qCiDyMwlvCIoHIDpy14z+8u4J0yaf1rZfb1HOjqduVuA
	 V6oEy5iyv1lqG//AQT3ZzEQ/G9+UIR9cxIAyp2w6kdW0uCiGgc0zer8TCm/98/3Nfi
	 f+wEqhWxZLskz2KYvTi85yNMV5fgpnb7xCKMUtxih/S0NtJYNbfNXOIGUOKS2jc3Wi
	 NZAjwHJiQK3M4b4Nkeq83b/63laYIHb6N4fa9eoP7+M/+g11Wd8T4xQnxsActZv+NC
	 NzvDbyuxuAPtQ==
Date: Tue, 7 May 2024 09:08:25 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
	Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Subject: Re: [PATCH v2] nvmet-rdma: Avoid o(n^2) loop in delete_ctrl
Message-ID: <ZjpD6TRPE37kztWa@kbusch-mbp.dhcp.thefacebook.com>
References: <20240507065444.1109334-1-sagi@grimberg.me>
 <20240507072626.GB6569@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240507072626.GB6569@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240507_080828_578133_3E541887 
X-CRM114-Status: GOOD (  14.87  )
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

On Tue, May 07, 2024 at 09:26:26AM +0200, Christoph Hellwig wrote:
> On Tue, May 07, 2024 at 09:54:44AM +0300, Sagi Grimberg wrote:
> > From: Sagi Grimberg <sagi.grimberg@vastdata.com>
> > 
> > When deleting a nvmet-rdma ctrl, we essentially loop over all
> > queues that belong to the controller and schedule a removal of
> > each. Instead of restarting the loop every time a queue is found,
> > do a simple safe list traversal.
> > 
> > This addresses an unneeded time spent scheduling queue removal in
> > cases there a lot of queues.
> 
> Looks good:
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> 
> (crossing fingers we're not going to run into a mess due to
> rdma_disconnect)

Sounds like nvme-6.10 material then. Applied to that tree.

