Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C67DBC369A1
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Apr 2025 09:01:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nI5/wWXIUZRYBSOfQDXNtptGJ+78RJqeJOH7zqpqd6I=; b=jRsileZbv5oCzYruzjsT9i0rpV
	AuK93WxvS/lkOF6g9JgI0p8UX7lpSu8l7YXR7ZBCK3RqXc8O9DlR5vSQASGIHLuqV13KLif3SCSK6
	+ju2KmNVyvNX1AEmfC4rY3B8LgzeMqJT8ynGzItBI2Ph45+xkC+yiWBM1RmPAv1FXsQER2vPjpA9K
	UvWAGCe9a6o2G9I8gJeVk72aRTw9NUNTjSpKtOglcXDx/uQ+lKXJwHl2xRVP9JmGSm+/jzwzXd7JB
	Sd6/CoFU9rKfhjJpYjaQupyAqiOV6AbQlsv9q8xWJobIUXP+szfLQwvSx70O3lOrNU5bNkgHSDFgU
	tM+h2GLg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u2RJ2-00000006eer-2O7r;
	Wed, 09 Apr 2025 09:01:12 +0000
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u2RJ1-00000006eeg-14gn;
	Wed, 09 Apr 2025 09:01:11 +0000
Date: Wed, 9 Apr 2025 02:01:11 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: "alan.adamson@oracle.com" <alan.adamson@oracle.com>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: Issue with AWUPF when using multiple controllers in a subsystem
Message-ID: <Z_Y3V6i7dG5Hr635@infradead.org>
References: <4a2e4561-9311-40c9-aa65-87e7a2e5b041@oracle.com>
 <90792c66-d0ca-401d-b171-57faea2c2cab@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <90792c66-d0ca-401d-b171-57faea2c2cab@nvidia.com>
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

On Tue, Apr 08, 2025 at 09:08:18PM +0000, Chaitanya Kulkarni wrote:
> >
> > I think the awupf belongs in the nvme_ctrl structure. 
> 
> AWUPF is a part of Identify controller data structure so Ideally
> it should be part of the controller attribute.

It is subsystem scoped really, and controllers should not differ
in the values as that would break multipath setups.

Unfortunately nvme doesn't have an identify subsystem and generally
is extremely sloppy about scopes.


