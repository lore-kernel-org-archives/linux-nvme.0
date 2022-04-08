Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C906C433EF
	for <linux-nvme@archiver.kernel.org>; Fri,  8 Apr 2022 15:18:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1fYkgby3MDh8X9S6pVc0LtlgW+GpooRrnJ46GEBqnWM=; b=wVj4bDStAekNQ4V4TVUZgMUPsn
	74LgG/fWTtA+L2uYxMNa2eA6m2UV0IK4dHQ/tbDLvJmA6dHQcBzJiEB6cSxoKYrD+5S2206lBH6OD
	az5sEhhK9t6Qml/KjVuAB+U2j5Z0JHsXojzxcJcQnanfwTYxCkkG4ORHI8L73jDA0YtaBui9W8l3q
	eL9UTQdLkxZuxinU47L1rpdVLUM6xo3KAOtS4zIIARv0MZYroGEA49AUOGqC3s0mZDsucKpjdrsPw
	eTz0k4AHYzCUePre9Jt18vjxvvxWvMcYiZa/6zD8wun5epbBTSMFlFPJLFViReRLnk4P1Un6ZnkKX
	sGJ4Vkow==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ncqNX-000EML-OO; Fri, 08 Apr 2022 15:18:27 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ncqNU-000EL6-Ic
 for linux-nvme@lists.infradead.org; Fri, 08 Apr 2022 15:18:25 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 0E19561ECA;
 Fri,  8 Apr 2022 15:18:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBA2FC385A3;
 Fri,  8 Apr 2022 15:18:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1649431102;
 bh=jQkL9058wobgXn9MA9Z7hcwkNpMiCP//EpyVcQVFUUw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=aLJJNAJE0HqJrIhi6cgQjR9MrOiPvSgXZOe/0vMNMvGPo+gCnXkCcHjTybea2qmok
 JXgdiIHdbYlXMxMYqmeL/ovxpyu8dQAiUTd7oyiTiKmm2Z/jQY4xZ4Jdua9BPH1PD8
 GIsJdgjxNgo5BXxUa5DLhl/KLz5vNH2L3gr/bXQFMn1aQc6WJJTj2SU/F5sdWa0gse
 tcH5GEQ7lKGLExeolnxyjXO90YvlUrCetb/wM1bLT7JnzQhmQNEO7DtQUT9yOzRrOc
 zZ3KIVz9bYpkVeF4ePI5yYvHVLNbMkNxrWAtmuOBNLk5kzYM5c0EeN9PA05zLOzm9Q
 20UHBd//AZTlw==
Date: Fri, 8 Apr 2022 09:18:19 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: =?utf-8?B?6YeR6Z+s?= <me@kingtous.cn>, linux-nvme@lists.infradead.org,
 axboe@fb.com, sagi@grimberg.me, kingtous <kingtous@qq.com>
Subject: Re: [PATCH] fix: nvme_update_ns_info method should be called even if
 nvme_ms_ids_equal return false
Message-ID: <YlBSO/vH7DjE6kC9@kbusch-mbp.dhcp.thefacebook.com>
References: <20220408051915.GA31955@lst.de>
 <ABwAxgCYBwe5Iq2fM1-8qqrc.3.1649398333597.Hmail.me@kingtous.cn>
 <20220408062210.GA410@lst.de>
 <7b59552e-196e-d06a-f057-aaa3e9432841@kingtous.cn>
 <20220408080721.GA2888@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220408080721.GA2888@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220408_081824_714252_115EDD8B 
X-CRM114-Status: GOOD (  14.89  )
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

On Fri, Apr 08, 2022 at 10:07:21AM +0200, Christoph Hellwig wrote:
> On Fri, Apr 08, 2022 at 03:56:49PM +0800, 金韬 wrote:
> > This is output from dmesg. Seems that "eui" has changed.
> >
> > [    2.086226] loop0: detected capacity change from 0 to 8
> > [   26.577001] eui changed from 0100000000000000 to 0000000000000001
> > [   26.577003] nvme nvme0: identifiers changed for nsid 1
> 
> Ok, looks like the device is broken and changes the EUID after power
> cycles.  Can you send the output of lspci -v?
> 
> Also just out of curiousity, does the ID keep changing if you do more
> suspend cycles?

The eui isn't legit in the first place (no OUI), and appears to be swqpping the
byte order during resume. This should be reported to the vendor.

