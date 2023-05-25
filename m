Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E6A4C7EE29
	for <linux-nvme@archiver.kernel.org>; Thu, 25 May 2023 15:36:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=sc9/A1ISF0HUM7/3YE2Bc4dABEzMpIo0TnaeyXm8SqM=; b=xGvEQdnbSBpbYfjDDKLDNaLKvH
	mbDBkpWRlqhEPPRFexZ4f4smc1yVC2u8gcGskDAPxdmPQLzm1AgjGO4+79u9fTr2QeTKflLVwD/jL
	oXSRvnlVxKXndF4VS3YJIncbyjUxdO/NMcSB4jNUim9BUMJopvNy6Y4iN7lT4c6Tk32rsbpTQEA7F
	OWo6jH1scd5SmO8MaKPkmvvxTKmnMUmblnFb7oH8lojOk6mKpKiqtQxaMbXnTkStEmPhKWVKgW2QU
	7i7cmRIxxfSW4bY3YSgVs50O1KkJ2RUcU2NrwOMl1IeQ9f6WMPS8pzlefTwd+KLsM0zTA5tc34ADM
	/qERMWrA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q2D0a-00Gz0n-2A;
	Thu, 25 May 2023 15:36:08 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q2D0Y-00Gz08-1s
	for linux-nvme@lists.infradead.org;
	Thu, 25 May 2023 15:36:07 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id EEE80646F0;
	Thu, 25 May 2023 15:36:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 060ACC433EF;
	Thu, 25 May 2023 15:36:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1685028965;
	bh=sc9/A1ISF0HUM7/3YE2Bc4dABEzMpIo0TnaeyXm8SqM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=thrbzE/PYiSRU6Z8aTdxtFZDkRhN2fi4gcxaQ+I8zmrjx4DqdEZ2jRa01m7NJjXZZ
	 q/CqSg4uCMIuTi2A1FnE7Di7KRJGYF8cEQOY+R5ismtHMAcFp4lS0RMN5QDs0fTXls
	 wp1I4sgqGd0ufqdCUXY3GR1ABzUBU04W+7zApRJeSc3k47lsHs3r5zKd3u4mNGOoiX
	 4VTovlmBzXqir2nvUgfWEyQDP8yA6fH3QOSMtllFjZnyxtvlPnH/tMZq0zd0JL1yzk
	 zOEjWpwWCZa6JGrbyUpZxHhylZqZHOufW1u60y8QxKCXc50BYTnLHtyOmwPmkfanUM
	 op4nPvyUqrU/w==
Date: Thu, 25 May 2023 09:36:03 -0600
From: Keith Busch <kbusch@kernel.org>
To: irvin cote <irvincoteg@gmail.com>
Cc: hch@lst.de, axboe@kernel.dk, sagi@grimberg.me,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme-pci : redundancies in nvme_alloc_queue and
 nvme_init_queue
Message-ID: <ZG+AY7/lheC7Hsbn@kbusch-mbp.dhcp.thefacebook.com>
References: <20230521024618.103138-1-irvincoteg@gmail.com>
 <CALL+9ehvM3GxGS9Y-KVyyK+HyO14yRmGZFEPjD6pmEUMX3VNzw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALL+9ehvM3GxGS9Y-KVyyK+HyO14yRmGZFEPjD6pmEUMX3VNzw@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230525_083606_657457_70EA1871 
X-CRM114-Status: GOOD (  10.85  )
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

On Sat, May 20, 2023 at 11:47:37PM -0300, irvin cote wrote:
> I'm trying to resend the patch but somehow all the new attempts seem
> to bind to this thread...

It's not really a big deal to me that it's continuing the previous
thread, but how are you sending your patches? If you just use 'git
send-email' without specifying any reply identifier, that should start a
new thread.

