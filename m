Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 401E6C0015E
	for <linux-nvme@archiver.kernel.org>; Wed, 26 Jul 2023 11:52:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=E1cfa4ohBW4wnijj8gQCvTvFKsMj0evNY8qB4UrrtUw=; b=TNo40lB9j+S+orOyVLX6WJsHqi
	IzH5cAUOGkSyzkkIKMm9XWiCucGXSjdPYI+HpdG8MFgDqcTruIFjozqhQUt9pUz/VNWZk0Xd7adzW
	pObL0wQfA1EIUizIoOfPknHyG7u9PP9L5VoiLFlCWQl8Qcw5/GIpzKNBT+yaRTQQB59kf7P5Ry1BY
	WpKAXtzQ5OY6cVusv3oqDUCuNMfrjzAsXJQd8pQNIYsoRK2LdglVIhX+I7vPbtEkxy/xb/2wzzi8d
	/IMDKNaYf5cy3O4TstOwRy3Nh5bnV2fwWBMz1RMVjxxnW1KugHsiZ87BeiFoxTh7okPvfFJ9itAwA
	UvpTC05w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qOd3w-00AF0K-31;
	Wed, 26 Jul 2023 11:52:16 +0000
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qOd3t-00AEyd-1B
	for linux-nvme@lists.infradead.org;
	Wed, 26 Jul 2023 11:52:15 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 5460B1F88B;
	Wed, 26 Jul 2023 11:52:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1690372325; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=E1cfa4ohBW4wnijj8gQCvTvFKsMj0evNY8qB4UrrtUw=;
	b=s/LdpKqjzDsSItThB04D14Wc8rbiutsHY0lGyCgaWDDo/E5+Y4bt/6H4nzZWQMzIExCaVq
	bCnkpXRRx88FX3YIHjvQzrVAJE8qbafn/7tpCdAO0UY3DFZw1K2bthgIc1aw0uBwgAvodk
	6ruG7qkOxEYDbp8HsFwZ2rxMS1wRJrk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1690372325;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=E1cfa4ohBW4wnijj8gQCvTvFKsMj0evNY8qB4UrrtUw=;
	b=CRn0dyRt2RXcNQNzqVosXgSmP6ZPyqKLpSQvi1l9Z3SnBDZdJ76zZi1ncSu+WisFn1kc/P
	9AFe1EQsonrD1dAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4758E1341F;
	Wed, 26 Jul 2023 11:52:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id NqVcEeUIwWT+MQAAMHmgww
	(envelope-from <dwagner@suse.de>); Wed, 26 Jul 2023 11:52:05 +0000
Date: Wed, 26 Jul 2023 13:52:04 +0200
From: Daniel Wagner <dwagner@suse.de>
To: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Cc: Guangwu Zhang <guazhang@redhat.com>, Ming Lei <ming.lei@redhat.com>, 
	Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>
Subject: stack smashing detected with 'nvme sanitize-log /dev/nvme0'
Message-ID: <dckvq3ohgqdkxg7wz4vslf36gaivgldl742vew67oyh2buj5nr@7ypn5ydt6kss>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230726_045213_565396_BC8C07C9 
X-CRM114-Status: UNSURE (   8.58  )
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

FYI, I got a a bug report [1] with a 'stack smashing detected' when running
'nvme sanitize-log /dev/nvme0' on Debian. Originally, it was reported against
udisk. udisk recently added libnvme which does now a sanitize-log call, so this
problem might exists for a while.

We figured out that an older kernel such as 4.19.289 work but newer not (it's a
bit hard for the reporter to test all combinations on his setup due to compiler
changes etc.).

There was a bit of refactoring in v5.2 which could be the cause of the stack
smash, because saw this recent fix:

 b8f6446b6853 ("nvme-pci: fix DMA direction of unmapping integrity data")

[1] https://github.com/storaged-project/udisks/issues/1152

