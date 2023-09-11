Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA022EE57DF
	for <linux-nvme@archiver.kernel.org>; Mon, 11 Sep 2023 20:21:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FJzq25epzpaHuRojhKcKrxwLU59ayXTMoCyIXAaxcT4=; b=d3u8DBxqH4w1pBSEG929RiQuac
	sC/dEYXggYupqH6PA/VXLL5aKBAcin+YHULwMaLhln9HyRY8uoImQ25daeWPF2l1lNN1Ujbf8aSP3
	RL2LdBCtNXPRqycxaBgGQpgwv2ooYIbjiKseJn9rB9tzgP9MuUO4CIgsstXZb8ghER6A6wKuOwINc
	2IFbwz/yzgzL5AHpWpz5imsruFWp6MsoA1t2xdk3Qvk8+ZgolfA7jWvLg6IwKdeUqKqBvQpegDuPB
	FsOhHOzVvmyOBBuRLbI4zCCN9j/YPvVTAMvU7TxRXxiy3afcg/UhYIzjQ4WRVhtUb4nA4ZILtDM9d
	vRLtlCRw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qfnPY-001GpB-1b;
	Mon, 11 Sep 2023 20:21:32 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qfnPV-001Gnv-2h
	for linux-nvme@lists.infradead.org;
	Mon, 11 Sep 2023 20:21:31 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 27BE9611D5;
	Mon, 11 Sep 2023 20:21:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43F20C433C7;
	Mon, 11 Sep 2023 20:21:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694463685;
	bh=ifurHTfD/rz+WeSAjb0JVVNYuU1Cfmlv0GKMYTTrDJw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HbqPLTZ9LeNmAlmVzcYu36tyFIABx8PJv7gicVSRS0UoDC+4rWJItiASAHjYRxQYX
	 mts0sxkgjGe7LbjxTyoB/Ejo+jjSBEpX5l+Y0hmVtWScremxmJFgSKGRwo9+lbjQqo
	 lwOiXmCKHpugXKdCtMHrn1MlMmSRxcoJiZqFUy04p9xj/Bl8aVlZoJxbCxqbtUCnIr
	 baWvj2BMlP+tF5HCsVdDiVcbmQEOWi7Lbhf5uI5Wgm5w+jKEyVgwiqoy3nL1J5tWZ0
	 HbnO4rCvELbOjwidiFN9Iclxu+j/J8UjhB2Xxf7T3x0ykErySXK2zd3f4esbJXbTOp
	 eNG3PfWvWF4fQ==
Date: Mon, 11 Sep 2023 13:21:23 -0700
From: Keith Busch <kbusch@kernel.org>
To: Alexander Motin <mav@ixsystems.com>
Cc: Ameer Hamza <ahamza@ixsystems.com>, linux-nvme@lists.infradead.org,
	axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
	linux-kernel@vger.kernel.org, edmund.nadolski@ixsystems.com
Subject: Re: [PATCH] nvme: prevent id ctrl csi for specs below 2.0
Message-ID: <ZP92wmbIHpzZKEyZ@kbusch-mbp.dhcp.thefacebook.com>
References: <20230910212641.338438-1-ahamza@ixsystems.com>
 <ZP9fOBSl59u8u0hq@kbusch-mbp.dhcp.thefacebook.com>
 <2f1414ab-9152-17ab-d2c6-96f4f5de7d45@ixsystems.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2f1414ab-9152-17ab-d2c6-96f4f5de7d45@ixsystems.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230911_132129_914907_9A2A4984 
X-CRM114-Status: GOOD (  20.15  )
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

On Mon, Sep 11, 2023 at 03:29:34PM -0400, Alexander Motin wrote:
> On 11.09.2023 14:40, Keith Busch wrote:
> > On Mon, Sep 11, 2023 at 02:26:41AM +0500, Ameer Hamza wrote:
> > > The 'id ctrl csi' command was introduced in version 2.0, as specified
> > > in Section 5.17.2.6 of the NVME Base Specification 2.0. Executing this
> > > command on previous NVMe versions returns an "Invalid Field" error,
> > > and the error entry is saved in the log page. Although, Commit
> > > c917dd96fe41 ("nvme: skip optional id ctrl csi if it failed") reduced
> > > the error occurrences, but the error persisted during the initial
> > > module load. This patch ensures the command isn't executed on versions
> > > older than 2.0, and it also eliminates the skip implementation because
> > > NVME_ID_CNS_CS_CTRL is expected to succeed with version 2.0.
> > 
> > NVMe TP's are allowed to be implemented by versions lower than the
> > release that first included it. I recall the first nvme controller I'd
> > seen that implemented this identification reported itself as 1.4.
> 
> Then there must be a way to detect it.  How otherwise it is not a standard
> violation to send arbitrary effectively vendor-specific commands to a drive?

For identification structures, you detect support for these by seeing if
the device responds with success or not.

Not sure what you mean by "standard violation". The standard defines
ways for the controller to respond when it receives an unrecognized
command.

