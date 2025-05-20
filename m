Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E83AC5479B
	for <linux-nvme@archiver.kernel.org>; Tue, 20 May 2025 13:36:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Ivw0U1CM9XJTPtUCMqgU8z4q8yYbnRQgBFypJi+E53I=; b=1TVaPvR0kdrnvkBlStGZ/Wyd26
	MU08TpNub2yLKavi948d/5H2eyeY92dUSpL2PqpoiPlsy4ln4dlmEUIwElbi7p7QZEZQS5Qxi+4PN
	SkPBDvSue1RNbUq6RhJJqn3mmjU2BjgVlK+7GSKtXHmpiXbwFIt7GecvhYV9BrUW9Tx/jkAhugH6e
	NkV24yIly6b7whkIqV3yaDbopvx6Pp9fQxV82pjUd6uyluoohWqXqhCCmZ5alwvv+c2j2oE1WKzKe
	c09WIwmqzaSB4mzVsbkgmcxNx7evixhmMJFwSFlMkDvdIS6YWB6jgitpE9mxu7obcl8ydUOFJN/q9
	ikvWwVDQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uHN9K-0000000D2KN-3K62;
	Tue, 20 May 2025 13:36:54 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uHN7S-0000000D1zo-07on
	for linux-nvme@lists.infradead.org;
	Tue, 20 May 2025 13:34:59 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 9A98768D17; Tue, 20 May 2025 15:34:54 +0200 (CEST)
Date: Tue, 20 May 2025 15:34:54 +0200
From: Christoph Hellwig <hch@lst.de>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
	Daniel Wagner <wagi@kernel.org>, Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH blktests 0/2] nvme: check that nvme-cli supports json
 output format
Message-ID: <20250520133454.GB7074@lst.de>
References: <20250520061819.1148033-1-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250520061819.1148033-1-shinichiro.kawasaki@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250520_063458_205036_A2A6AE8E 
X-CRM114-Status: UNSURE (   9.49  )
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

The changes looks great:

Reviewed-by: Christoph Hellwig <hch@lst.de>

Although to me they would be easier to follow in one patch instead
of two.


