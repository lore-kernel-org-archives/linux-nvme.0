Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7289CC5475B
	for <linux-nvme@archiver.kernel.org>; Fri,  8 Mar 2024 16:31:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6FTmumvMrr5kXfuzO7x191XdH4XCX6/AQPCjoP9vcwc=; b=zSAzI3v13LK9cORaUZ4ZfWHKuD
	G9QebK5lSTAjqLAejqSqs9bhZgrFvwA6g6U8YvGYiTth3WLIoTbZcTgAarpsVh3URNJqUAnSN3jNU
	7wVNCBQW03QsDzLFb6mmkt5SiaW6kTphC2134LEHHljYxlYWIcuB/RSVMGoNzlEBfWpXSbUkxSzZf
	d72H0SuiYVe1RBC9l98kSsD+KUBY7AzhGDVMdqwt0vg+Dqz1sU1fmGym5CAnFqj3wuhJUF2AZtgk/
	8fV/Yvw+wLuK897o7rpiws3KD+1yfmxwnV86z6vR9K7rEES1BdhjHs3QVv2O4hx6n0FWIcjPmNRpH
	2fSgtepg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rid7p-0000000ACEp-46Wo;
	Fri, 08 Mar 2024 16:31:13 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rid7l-0000000ACDD-1FJ1
	for linux-nvme@lists.infradead.org;
	Fri, 08 Mar 2024 16:31:11 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 5A70A68BEB; Fri,  8 Mar 2024 17:31:01 +0100 (CET)
Date: Fri, 8 Mar 2024 17:31:00 +0100
From: Christoph Hellwig <hch@lst.de>
To: =?utf-8?B?6K645pil5YWJ?= <brookxu.cn@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>, kbusch@kernel.org, axboe@kernel.dk,
	sagi@grimberg.me, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] nvme: fix reconnection fail due to reserved tag
 allocation
Message-ID: <20240308163100.GA17078@lst.de>
References: <20240308015435.100968-1-brookxu.cn@gmail.com> <20240308144208.GA9194@lst.de> <CADtkEefTzbYN4qEAgAXDTB-+HMxfENw2m+xcoxzy83YW-bGEhA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADtkEefTzbYN4qEAgAXDTB-+HMxfENw2m+xcoxzy83YW-bGEhA@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240308_083109_494769_B8E531DA 
X-CRM114-Status: GOOD (  15.99  )
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

On Sat, Mar 09, 2024 at 12:29:27AM +0800, 许春光 wrote:
> This works now, but I donot know whether
> nvme_alloc_admin_tag_set()/nvme_alloc_io_tag_set()
> will be suitable for all driver in future, such as driver for apple
> device not use these two funcs
> to init tagset (anyway it not use these two macros too), so maybe new
> driver would use these
> value in other position.

nvme-apply should realy be converted to use the generic helpers,
I just need some help from the maintainers.  I'll ping them.

But I'm fine with just taking this bug fix as-is and clean this up
later.

