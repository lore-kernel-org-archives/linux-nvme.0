Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 910F0C369A1
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Apr 2025 10:13:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YWsfhzZGPsaI31YwN8VzvAy3pifAVFt5iJMKM3k1qf0=; b=iDSkPFkS7jyfcQUGNem692nNLu
	9g4idqZ9NCFR9dCbZ2BSw5KXDu33E+g67KaHwKGf7fEBJ7zq2GL3/ShcKC3D4iSYOnEKp+dRb7W/u
	j2vmLiphVvjuLajmE4Hl+x/I6GRi/vFNkzX5Uzf7/X7hNYDy646CK1mIoJGPmhKzgVHSM2uhd78an
	GStJYvCJRTFuGlWVbqxUNxM/WZxE9Ij34sbdz9Rwh7QBrPoitHYUo1MOMf7UHmPciWku7wx6YOLoZ
	AoG5xKQOx6lJ0XprqpvYp6CPUoKpD0mK2KSv+PmWrB7ErBajEU+8amTFcGnZ7/oFXW8UKsBXEFHW3
	HN4BH/9A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u2SQS-00000006nnj-3FSO;
	Wed, 09 Apr 2025 10:12:56 +0000
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u2RHd-00000006eYu-2dWR;
	Wed, 09 Apr 2025 08:59:45 +0000
Date: Wed, 9 Apr 2025 01:59:45 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Anton Gavriliuk <antosha20xx@gmail.com>,
	Daniel Wagner <wagi@kernel.org>
Cc: linux-nvme@lists.infradead.org
Subject: Re: nvmetcli restore fails in add_subsystem
Message-ID: <Z_Y3AYFzE3L2ujBW@infradead.org>
References: <CAAiJnjpzCfDViPDsixbyOe3V3w5EMDa-ScEt0jod9b-YJjJw7Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAiJnjpzCfDViPDsixbyOe3V3w5EMDa-ScEt0jod9b-YJjJw7Q@mail.gmail.com>
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

On Tue, Apr 08, 2025 at 01:53:09PM +0300, Anton Gavriliuk wrote:
> Hello
> 
> I'm trying to set up an NVMe/FC target on Fedora Server 42 beta.
> Config file attached.

I haven't seen such a failure, but I have also never used nvmet with
the fc transport myself.

Daniel, have you seen anything like this by chance given that you
are the most active nvme-fc developer at the moment?


