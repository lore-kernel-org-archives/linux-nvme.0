Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F008CC6FA82
	for <linux-nvme@archiver.kernel.org>; Thu, 22 Sep 2022 05:31:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=aKo4o5xU+rFN7JmlD4QwtxVBzOd7zs+OL+4rxnqxRNk=; b=Hvddkj3i5I62fwwB6GwhvRYbmI
	56kzgBoTOT20mT+GHcHvU2JyG6QG6fzn8v5jE0Gs/mVX5jpaQ065gG4S4BhUjmLZ9S4A2jgsmYUs6
	UxxSuR49eZHERiC7CL/zRcC3hwf7JQe3mHCQ5g0dWEzK/RJlGHTKIzkrhsFnFgz0c1IwYTSK/5qmw
	ZCKMLVwDZFpPkfHKE26mUZdykc1rwkE+ZadWV0wixV4b6JnlPYfI+bNLO7h7R/1oLjsGhhfXMeEQi
	m42zXfNoLFBnVoSGhsrh2oAfZPA7o5JBCDS/iC1UcjGrXKDGAPmXSvXKgqchbsXYjkrspuv5AeSGb
	tz4KRHsA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1obEoP-00DQ5P-LF; Thu, 22 Sep 2022 05:31:49 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1obEoM-00DQ4A-Fr
	for linux-nvme@lists.infradead.org; Thu, 22 Sep 2022 05:31:48 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 6D3BC68AFE; Thu, 22 Sep 2022 07:31:37 +0200 (CEST)
Date: Thu, 22 Sep 2022 07:31:37 +0200
From: Christoph Hellwig <hch@lst.de>
To: Rita Lin <ritach_lin@phison.com>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	=?utf-8?B?77+9U+aZn++/vXw=?= <redd_huang@phison.com>,
	Tina Hsu <tina_hsu@phison.com>,
	Vita Hsueh =?utf-8?B?KOiWm+S8iuWAqSk=?= <Vita.Hsueh@quantatw.com>,
	"Wang, Audrey" <audrey.wang@hp.com>
Subject: Re: nvme-pci: disable write zeros support on SSDs
Message-ID: <20220922053137.GA27191@lst.de>
References: <36fd82e8780742c2881f078f98110e5e@ExMBX2.phison.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <36fd82e8780742c2881f078f98110e5e@ExMBX2.phison.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220921_223146_709250_0FCF73F5 
X-CRM114-Status: GOOD (  12.99  )
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

On Thu, Sep 22, 2022 at 02:03:01AM +0000, Rita Lin wrote:
> Dear receivers,
> 
> We would like to apply to disable write zeros support on Phison SSDs.

Can you explain why these SSDs do claim write Zeroes but it doesn't
actually work, and why this is not fixable in a firmware update?

