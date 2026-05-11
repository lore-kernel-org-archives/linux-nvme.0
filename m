Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73D08CD4842
	for <linux-nvme@archiver.kernel.org>; Mon, 11 May 2026 12:22:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=i1HHks+J8dHk+GfisPpemusf7TjEeXHyXZFWZlt11dI=; b=fQ3WcGRLxMuUI/4TrfLPdfWX9v
	g4K63YvvtK0ToWJWE2ud82Bh157SBpNUxVUJBWiqUQNPBMpqmvSX/aci/xFXzGgDPl86mVhYCJQx7
	jnk91ETMDtAjfMTWRwS6RqjMSyB/EIqJlxi1EJFO91ttse6JDMn9q1tYwh8Q7CmtOD8RF64Ep7cj/
	wWU+je3oYjNqCIgX7cWQDLwR4r0KIrJ3lQ+FVh8+FvvHK0PlB7SECd4GyGVa+j4ld0A8bE5k0l9PB
	7XkckEiR2oJilJTuRqofoS8JMSCjzvD77JpQIhAQcOZd6cV7Li639yh1Cqrrbq77zlyjsACIkEgfM
	TU7/ykmA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMPec-0000000DW0b-3r5F;
	Mon, 11 May 2026 12:22:34 +0000
Received: from hch by bombadil.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMPeb-0000000DW07-3Qnd;
	Mon, 11 May 2026 12:22:33 +0000
Date: Mon, 11 May 2026 05:22:33 -0700
From: Christoph Hellwig <hch@infradead.org>
To: AlanCui4080 <me@alancui.cc>
Cc: Christoph Hellwig <hch@infradead.org>, Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme: make providing NGUID as UUID usage less scary
Message-ID: <agHKCd_FwVEQYcvA@infradead.org>
References: <UPNVP7_KTI2VieaAyBtUMA@alancui.cc>
 <73735bc1-9821-42d8-9594-1e9cdb03e15a@grimberg.me>
 <agGQZU4NwAgSzHLD@infradead.org>
 <2MLVK7hsTb2JIM2tKTgqIg@alancui.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2MLVK7hsTb2JIM2tKTgqIg@alancui.cc>
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

On Mon, May 11, 2026 at 04:59:19PM +0800, AlanCui4080 wrote:
> > It is worse.  For some reason the commit seems to imply the uuid
> > replaces the nguid and they can be intermixed.
> 
> Which you refer to?

The original patch adding the warning.


