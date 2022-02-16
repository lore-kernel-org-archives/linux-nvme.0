Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88360C433EF
	for <linux-nvme@archiver.kernel.org>; Wed, 16 Feb 2022 16:51:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LQDoSTaMcxHMbx5k2QZK1RM+UZknS6Sx0gvdQS/RTS8=; b=NQPfbdKCT6aDRLhlkkErWqoFH2
	sOcjvIFTfhu07wZSiJdo7vtumZBHxqHUn486IRAMKv364LXpyZVvUCMupQUPPZRJ16XP3HHBMew4o
	ngpEQHJAHRceqX2DATLG4A+wHMHAtx+SeuxR5sHHRH40SOkJkt3XZBipsS8sykldW2fR6PgAYzkUO
	RuQGtyDYADipnWIhD9oS9GujssTPbYkEwze3Ga+LQa0AwxGBs4r80gbRLuJ5DNhHl1upYsrVI9Ro0
	8DYsoEodWWnJ70kC0UFQ2Qp7pQXf4XBAWnCHnDqwN77Mgop3t5FFVrPpF4b0AUwPWecqi2L6rL/gQ
	mlbUvkOg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nKNWW-007mqp-RT; Wed, 16 Feb 2022 16:51:24 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nKNWP-007mnf-2o
 for linux-nvme@lists.infradead.org; Wed, 16 Feb 2022 16:51:18 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 783DF1F383;
 Wed, 16 Feb 2022 16:51:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1645030274; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LQDoSTaMcxHMbx5k2QZK1RM+UZknS6Sx0gvdQS/RTS8=;
 b=g/E/t9Rqex5Lx+IkZwnrTb06fRJPPIgcm+DkJgH0XJ2kvt9oNVJ4TqGiOPsepAjULoczuI
 2R2we92at3HKgsXhmOKBdKYfghAf+2Cqt8i8BbnFpknRikui1QejxQQbHcBNXQP9yYNkLh
 v+5JeFtPZBxzA/pd958Lg4EISPw2C6I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1645030274;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LQDoSTaMcxHMbx5k2QZK1RM+UZknS6Sx0gvdQS/RTS8=;
 b=W9O4ILcgL0CRKYTvWzJ8QzjTyPpEAi7ciYqNZMhamE+qfl0J84F1oHffqo5YU6ICYqi1vx
 uZ/8u/dmObFY2BDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 662D213B35;
 Wed, 16 Feb 2022 16:51:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id yccOGYIrDWJuWwAAMHmgww
 (envelope-from <dwagner@suse.de>); Wed, 16 Feb 2022 16:51:14 +0000
Date: Wed, 16 Feb 2022 17:51:14 +0100
From: Daniel Wagner <dwagner@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: kbusch@kernel.org, sagi@grimberg.me, joshi.k@samsung.com,
 linux-nvme@lists.infradead.org
Subject: Re: [PATCH 2/2] nvme: also mark passthrough-only namespaces ready in
 nvme_update_ns_info
Message-ID: <20220216165114.rdz4ivusdtds4e3o@carbon.lan>
References: <20220216141220.4162670-1-hch@lst.de>
 <20220216141220.4162670-2-hch@lst.de>
 <20220216145737.dijq4xgmmn3ky2yg@carbon.lan>
 <20220216150939.GA18782@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220216150939.GA18782@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220216_085117_294617_CFBD3695 
X-CRM114-Status: UNSURE (   8.35  )
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

On Wed, Feb 16, 2022 at 04:09:39PM +0100, Christoph Hellwig wrote:
> We always want to unfreeze it, just as before.  The unfreeze just moves
> after the place where we set NVME_NS_READY.

Ah, thanks for explaining.

Reviewed-by: Daniel Wagner <dwagner@suse.de>


