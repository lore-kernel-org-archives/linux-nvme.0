Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9EF6C2BD09
	for <linux-nvme@archiver.kernel.org>; Thu, 27 Jun 2024 12:04:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cQHkUa/3HkzD4+9RTO7+x3BZNiIiWmDKbk5Y/WfqxaM=; b=r6jNKS/ICb62JdzYW+Zaf2NRE+
	XEmZ8/Q8f9rQVNhRvN57w1U16C3qtxpTTQ7/xRA9nX8GYXv4o7dAAhNh5TYrECqsLnq3xnhda5CBl
	47AnPiQaVbBL89Mw6DpS3S9N9tP6xFeteiU3U0fBlnbbztptki2R7ZPp56teSbvH9dp1rBFJO/f6g
	fKuFjv/qpwid/XqFVmTrBfZomNVC0GBMYGssO5yBaG/a11ZtpITBSgeInO2wo5izUaA8h+JgRVuhB
	yFVRHhQUCM9FL4qo9+LSUJEh9za30D9NzF4OZVWiRaxtwBZkNwj6d+2jr8q46HnyqW0XHmbLzhFGa
	AbFwTMVg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sMnrD-0000000AGkt-2AiW;
	Thu, 27 Jun 2024 12:04:07 +0000
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sMnqs-0000000AGiv-0s2e;
	Thu, 27 Jun 2024 12:03:46 +0000
Date: Thu, 27 Jun 2024 05:03:46 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Daniel Wagner <dwagner@suse.de>
Cc: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	Hannes Reinecke <hare@suse.de>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH blktests v3 0/3] Add support to run against real target
Message-ID: <Zn1VInQSahym_HhZ@infradead.org>
References: <20240627091016.12752-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240627091016.12752-1-dwagner@suse.de>
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

On Thu, Jun 27, 2024 at 11:10:13AM +0200, Daniel Wagner wrote:
> I've added a new hook so that the default variables can be configured via the

Please make your mails readable by following the normal 73 character
limit.

Also what is more "real" about these targets?  They mostly are
remote and more diverse.  Maybe say arbitrary?


