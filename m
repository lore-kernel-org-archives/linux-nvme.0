Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92265C19F2D
	for <linux-nvme@archiver.kernel.org>; Tue,  9 Aug 2022 06:50:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NtyiXNO/68GduxCQ2BEQA6bfYzBgIRpy6mZgWw59tI0=; b=nTpmX6zH1nvsLjQd9hFk5yXQdR
	kL/5OBcTZxEokX6Fvspu6lk7C/OCQLKBM8/GtTgqOwgWSG07QZJyQ98KS1o7O0Ce3HDMTyUc8Fnq6
	J6atDJmQcdNQtDuayG19BopLfqEt6E6g2sIIwOgsnDI0BlqSDi3AduDTsoLfnleKUmjH9XBpCg6F/
	OH9lhAlK9ky0imerN+zOB9ZPJ7DFOZGs3TYHyjbUg3korvz7nkVZVZxxz45oF92CgTletT4DzcXz0
	FHAhrhR6pq9rLIBRpKBEF9sD0hd/r7AlY0F5+X4D0rH+OTOxwYufi6XkIhgTg2t5s6uxML66YVH5E
	d3zEPwnA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oLJ4Q-0026No-F6; Tue, 09 Aug 2022 06:50:30 +0000
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oLJ4N-0026MP-VK; Tue, 09 Aug 2022 06:50:27 +0000
Date: Mon, 8 Aug 2022 23:50:27 -0700
From: Christoph Hellwig <hch@infradead.org>
To: amit.engel@dell.com
Cc: linux-nvme@lists.infradead.org, sagi@grimberg.me, hch@infradead.org
Subject: Re: [PATCH] fabrics: parse nvme connect Linux error codes
Message-ID: <YvIDszUQtaDrurlY@infradead.org>
References: <20220801184039.17593-1-amit.engel@dell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220801184039.17593-1-amit.engel@dell.com>
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

I've added this to the 5.20/6.0 tree with the message fixup now,
thanks!

