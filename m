Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED3A8C77B75
	for <linux-nvme@archiver.kernel.org>; Wed, 17 May 2023 15:44:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=N9sTOt9kI0Yb9+TAnXE9LOm7dJ8ZedMAf3coSN8YOLA=; b=UJGxoDu2J0cT4g6l9E8tIewhH0
	i53RR9mi97X3Eqi0iVuqrlY/C/aztA5ky2I/ik3HZF8S1QLRsnhH/4bnVziDcsu+g38LevHK7HsJL
	6T2g4B4NmTu3n9vC/hUWzL5dMDzynoaOdTHNpV/kvur6vCoxannVGzrEQYnt+b49PIbTxkGvE/2gz
	4f0g/JsUOus0trlw7hn5CoN1yxqBE/5MOckKfjZB1+Xic9IcMrSj+wYoISEBEJh5LUWUYcjj9Pm/K
	ZAFQdNXWIWATeSHwHUN46/fqXGMsoxdp8VbYhEnpx/VCLttCnAkCG0ikLylnEnc07p03XHXbKWEfT
	uEy8aecw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pzJK8-00ALfX-0q;
	Wed, 17 May 2023 15:44:20 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pzJK5-00ALf8-1N
	for linux-nvme@lists.infradead.org;
	Wed, 17 May 2023 15:44:18 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 2EE0761425;
	Wed, 17 May 2023 15:44:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5176FC433EF;
	Wed, 17 May 2023 15:44:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1684338255;
	bh=N9sTOt9kI0Yb9+TAnXE9LOm7dJ8ZedMAf3coSN8YOLA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Jfbnlt1DzAeBouNk3p6mdoQ7bkSe+fxy2yNhRpsRJd9vNaofRFhmHggfuCMmM1lc3
	 teYNL7+4/kG1Gb4fqiZ/sF6vX3EERszDMRgI1is58Br/754jdqgA4m7oVMmdIjEL9E
	 VW7LZyJLtQw3gD9P+1vmfSLe8emrJ1kEyryYterQdAODEvtB44ChE1jFnYExpLIgk1
	 bDskfFHfbtYgnWz2LUs0+AlyXcPPbNdXHI9q5zugpWADmgJKKcjiI1yN9HESXX3q76
	 O8DK+jeu22kNljrg7N9KlKXDr+NdOPiSGBe3ymyCUFdEM7j9C3IoRAe7iWAOcL/Di7
	 RO++axRAmlsxA==
Date: Wed, 17 May 2023 09:44:12 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: sagi@grimberg.me, linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme-multipath: don't call blk_mark_disk_dead in
 nvme_mpath_remove_disk
Message-ID: <ZGT2TBCeoTf/v+ug@kbusch-mbp>
References: <20230517075345.246138-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230517075345.246138-1-hch@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230517_084417_507235_DA942074 
X-CRM114-Status: UNSURE (   8.13  )
X-CRM114-Notice: Please train this message.
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

Thanks, applied to nvme-6.4.

