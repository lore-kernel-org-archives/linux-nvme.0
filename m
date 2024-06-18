Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44DA4C27C53
	for <linux-nvme@archiver.kernel.org>; Wed, 19 Jun 2024 07:53:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9z79po/TJVDD48lw+qBBI8QGJ3DbIG7zBMssmH5c+Zo=; b=vKXkT7+5HHVCl0bbWnX3NBx7bt
	57IHQHMs39BKYioj/GlcuPl5jZncVa2yhVQN2GZJ2KIwoTBwzmRo9S1B4G2Gnq7PXJG3aPKEv/P82
	PnujudYTskhuPPuyrKebW2NVTt60mZ/8iHQgjnjlpoxRD2ioT9cKpFEDHtg+QgepjitLL6QfM4TIR
	3Y+1SO0KPeNOayi09BB4xtPPDHhcw+TUHh/+JE19CdfKGD5IkL8HjBta8LzZBproPwa/cAaspblpw
	/c1t/1+iQ9xQVk26+k7ASBz8KRw3tOkkIV9GPvnmeE7nIpC0xbOJqOQl4+Y5PxyZsdjXI7lS4My1+
	K2YUIJfA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sJq86-00000000HWK-2ZA5;
	Wed, 19 Jun 2024 07:53:18 +0000
Received: from sin.source.kernel.org ([145.40.73.55])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sJcaP-0000000G1LX-1jJu
	for linux-nvme@lists.infradead.org;
	Tue, 18 Jun 2024 17:25:38 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 97E88CE1BAB;
	Tue, 18 Jun 2024 17:25:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FC4AC3277B;
	Tue, 18 Jun 2024 17:25:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718731533;
	bh=9WtmB9Bn0bftxKxvR8395pd356hshFubR0WI4s7a7NQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=L/glrhDYm4sY+aW6Z7pWsticv8PewU9RhtaYYM2XXCXyQ7dJn+bapDjh1iVAIjRrm
	 piW4D1gKTzDt5/l4zvkKQZd0ituyOTiYFBFUrZj3cl3kj9qCzTOuKdBYTrjdfDqvHf
	 nw2tYUPmW/v+qurual1veLYcOf4R5ngMB1OFAzv5aGGzHXY83G9L75JQT5CeaVBtod
	 2vadkoi5t1N78i5jAUnEDEN/yOnXJn4a4rZtBDP63+dfj4QXWar7NBEGVqaB3yJ/I/
	 UbiWMjl6sosNLYMm1qGpqwcWgkWXMfAe7m8B6h7YzteDo5W9fG1kRjVrdUPgtl0jbw
	 nYq5nfgtQA4zA==
Date: Tue, 18 Jun 2024 11:25:29 -0600
From: Keith Busch <kbusch@kernel.org>
To: John Garry <john.g.garry@oracle.com>
Cc: Christoph Hellwig <hch@lst.de>, axboe@kernel.dk, sagi@grimberg.me,
	jejb@linux.ibm.com, martin.petersen@oracle.com,
	viro@zeniv.linux.org.uk, brauner@kernel.org, dchinner@redhat.com,
	jack@suse.cz, djwong@kernel.org, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-fsdevel@vger.kernel.org, tytso@mit.edu, jbongio@google.com,
	linux-scsi@vger.kernel.org, ojaswin@linux.ibm.com,
	linux-aio@kvack.org, linux-btrfs@vger.kernel.org,
	io-uring@vger.kernel.org, nilay@linux.ibm.com,
	ritesh.list@gmail.com, willy@infradead.org, agk@redhat.com,
	snitzer@kernel.org, mpatocka@redhat.com, dm-devel@lists.linux.dev,
	hare@suse.de, Himanshu Madhani <himanshu.madhani@oracle.com>
Subject: Re: [PATCH v8 05/10] block: Add core atomic write support
Message-ID: <ZnHDCYiRA9EvuLTc@kbusch-mbp.dhcp.thefacebook.com>
References: <20240610104329.3555488-1-john.g.garry@oracle.com>
 <20240610104329.3555488-6-john.g.garry@oracle.com>
 <ZnCGwYomCC9kKIBY@kbusch-mbp.dhcp.thefacebook.com>
 <20240618065112.GB29009@lst.de>
 <91e9bbe3-75cf-4874-9d64-0785f7ea21d9@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <91e9bbe3-75cf-4874-9d64-0785f7ea21d9@oracle.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240618_102537_732513_4E868681 
X-CRM114-Status: GOOD (  12.36  )
X-Mailman-Approved-At: Wed, 19 Jun 2024 00:53:06 -0700
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

On Tue, Jun 18, 2024 at 08:46:31AM +0100, John Garry wrote:
> 
> About NVMe, the spec says that NABSN and NOIOB may not be related to one
> another (command set spec 1.0d 5.8.2.1), but I am wondering if people really
> build HW which would have different NABSN/NABSPF and NOIOB. I don't know.

The history of NOIOB is from an nvme drive that had two back-end
controllers with their own isolated storage, and then striped together
on the front end for the host to see. A command crossing the stripe
boundary takes a slow path to split it for each backend controller's
portion and merge the results. Subsequent implementations may have
different reasons for advertising this boundary, but that was the
original.

Anyway, there was an idea that the stripe size could be user
configurable, though that never shipped as far as I know. If it had,
then the optimal NOIOB could be made larger, but the atomic write size
doesn't change.

