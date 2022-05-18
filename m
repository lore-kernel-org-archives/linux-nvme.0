Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43ECCC433EF
	for <linux-nvme@archiver.kernel.org>; Wed, 18 May 2022 14:42:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=P30prDm/L0SyLpE4Z2bHJTDIcuOuHsJDCgKkflPt5+A=; b=yvQswa66ObIe4IYL+9xhxXX7+M
	BIqOusqkeppA3NxmNjVM/v16VEBoXHYmB6n1uLcfxFl/XkiQWs2Rt+T2ncF6zWaJWk5fmRW9OHQan
	jv5araL/Q/BIXLyTrksJGToBiOtAHGj4em10IivwJxl547dXH2BIdfeISc3iLqsS6Lk8d6wGSU/2w
	mU+RRSgVicfHG82s37AIjBfV23Pm1JoEp5Z1zzm+iTjPJi15l0RSpkNnCDNCDQQFc9obNxObevGZE
	1HF9pVBAvb7OmWLjcY1gAIHvIqKp7QZ0+IZbAYqiom4IWPYrxN7GzSOsFRfVuJY1NJfl6O91YqvLR
	w9DtmDMg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nrKsO-002Zrq-TQ; Wed, 18 May 2022 14:42:12 +0000
Received: from ams.source.kernel.org ([2604:1380:4601:e00::1])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nrKsL-002ZqM-Mu
 for linux-nvme@lists.infradead.org; Wed, 18 May 2022 14:42:11 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 3B342B80EA7;
 Wed, 18 May 2022 14:42:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 831B4C385A5;
 Wed, 18 May 2022 14:42:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1652884927;
 bh=P30prDm/L0SyLpE4Z2bHJTDIcuOuHsJDCgKkflPt5+A=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=aso1ATWUOXp0iYZCeJu0leRfE0mGu2fp8LNlmyM+MBY4d3rT0ZX8rsTDuA7EHgUs0
 fTuSKHjvBDnkawviho5+IeInbwHdPMboHpr+rc7vFGalaI8YlKNBEXd5IadECIxLl+
 DmgZwCJqMOxRG8OUcnWbtGuZllcqWPoSKAGNORRgeTE1dSnsj7RjCN4w6imNxmMwW1
 rUthmRpBipfAju2hlwzqXuI56Zo7ANt/DJnbS71QjzYBLn9SveOU1Ol6NPOtWXLR8x
 cI8oIQUJoaGneFMcCgjV34E+Vrz82EGBPwvvN6KXzDwzSk0GDA+ImxTqbQxDP7JBMT
 nL7jbcvrYQUfQ==
Date: Wed, 18 May 2022 08:42:02 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Chaitanya Kulkarni <kch@nvidia.com>, sagi@grimberg.me,
 james.smart@broadcom.com, linux-nvme@lists.infradead.org
Subject: Re: [PATCH V2] nvme: set non-mdts limits in nvme_scan_work
Message-ID: <YoUFurG9sH1Qhfue@kbusch-mbp.dhcp.thefacebook.com>
References: <20220518064944.4228-1-kch@nvidia.com>
 <20220518085602.GA8066@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220518085602.GA8066@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220518_074209_931171_A7A65607 
X-CRM114-Status: GOOD (  10.89  )
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

On Wed, May 18, 2022 at 10:56:02AM +0200, Christoph Hellwig wrote:
> This re-reads the limits everytime a namespace is added or deleted,
> is that really such a good idea?

The limits are reported in logical blocks, which is dependent on the formats
that attached namespaces have.

