Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20FD1E81A29
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Feb 2026 14:25:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8oIu3pkSvSpCbBElDXLy1ptgrph+gMWaZ/fnS4KJrpw=; b=3KSPnlID+59omgnVnLvATrGRP5
	kSGLRdghusU2NB99MtM+8jBZkl5K3bj9adLibVKek9BhPRlxfHZeU/cZ6lsuTWUZh9gjiQdBzRGmu
	iJAJTF+dPuM0QXx8MGWpGo42/gUOFKkmz3JIUEypUBKCcrp0tS3NxKgxFyDlpbJqWGkPEAgYWdMlV
	UuuwH6pDfpL79+sfUuJuXUHavf9KeMENWhDc06J/BNbCaKKG6qA4hZ4iyrn5eh7MHe9Z3FkKi+4Sd
	5DrF/Sxax7H1wmJhTVbfTHbLbPcZIKxBH6d/QniONgKMMFs188oc8ibgyOTNOWBbrFEaEcvNzp25r
	glsSfE+A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vrzXM-00000006mjD-3CLQ;
	Mon, 16 Feb 2026 14:25:20 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vrzXL-00000006mj0-1se3
	for linux-nvme@lists.infradead.org;
	Mon, 16 Feb 2026 14:25:19 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 8A2FF600B0;
	Mon, 16 Feb 2026 14:25:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCA21C116C6;
	Mon, 16 Feb 2026 14:25:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771251918;
	bh=kCGqJIaDX5f6yv6thjxkoZ3TawsKPgZ0E8IC+FDXC/s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=th7wjGTXhr5+033pNx2RNmqJOLEwrDpNHhH1xpvmxoIOtpbE5xKkvTy7mepwc3dF6
	 S10itHpIrMEe1Z/gww83Hw5Mb4Yjb58gmZqfx03wRUX3efqs+FxtIEoy/ho4/kkFp4
	 XWafKuyReQvzDqlRzl9fzeMo9gxUEblLS4V1u9dw2af6zU9LJHDYXrv5NB0UdBYye7
	 B7rhgBV1BIuhG00cuZkCb6iJs2HYgfGgMD96ObgR/RbAHbagGHkREfdCyAtztNrRch
	 KpZHhaq1KUGkRG0pEFSFKHtDiokVYiTXwW0AOwP8rtBnG0FN0tkBVhR4gnjfBIr74Z
	 M5Ar+FD9JGQsQ==
Date: Mon, 16 Feb 2026 15:25:13 +0100
From: Christian Brauner <brauner@kernel.org>
To: linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-block@vger.kernel.org, linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org, 
	linux-nvme@lists.infradead.org, bpf@vger.kernel.org
Cc: lsf-pc@lists.linux-foundation.org, linux-kernel@vger.kernel.org, 
	lwn@lwn.net
Subject: Re: LSF/MM/BPF: 2026: Call for Proposals
Message-ID: <20260216-ruhelosigkeit-umlegen-548e2a107686@brauner>
References: <20260110-lsfmm-2026-cfp-ae970765d60e@brauner>
 <20260119-bagger-desaster-e11c27458c49@brauner>
 <20260129-beidseitig-unwohl-9ae543e9f9f5@brauner>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260129-beidseitig-unwohl-9ae543e9f9f5@brauner>
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

On Thu, Jan 29, 2026 at 05:13:52PM +0100, Christian Brauner wrote:
> On Mon, Jan 19, 2026 at 03:26:39PM +0100, Christian Brauner wrote:
> > > (1) Fill out the following Google form to request attendance and
> > >     suggest any topics for discussion:
> > > 
> > >           https://forms.gle/hUgiEksr8CA1migCA
> > > 
> > >     If advance notice is required for visa applications, please point
> > >     that out in your proposal or request to attend, and submit the topic
> > >     as soon as possible.

This is (likely) the final reminder to put in your invitation request!
The invitation request form closes this Friday, 20th February.

Fever has struck me down so all you get is a bad limerick:

There's a conference called LSFMM,
Where maintainers debate and condemn,
They argue till dawn
What's merged or withdrawn,
Then next year do it over again!

Don't forget to pester^wask^wremind your respective organizations to
sponsor LSF/MM/BPF 2026! If it helps, you can tell them that we're
considering renaming it LSF/MM/BPF/AI.

Thanks!
Christian

