Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DE82C433F5
	for <linux-nvme@archiver.kernel.org>; Wed,  2 Feb 2022 08:19:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=V/NZfgHaSUAxDpbG84WAZJHvK5I2zu1+8Qqp3EtSev0=; b=cI0/fLWsX36JytXrqH4kMw/ag3
	YNQeYGthlhVF7xma0DtCqdkq/HmSKMHVfLudBG0gdu+TxoLQO2P5jLngZr/dccFcw6VUQrTZvp6M+
	+cYuXaSlMPfedjnuGYOdqBIRemDb7NI99H+lviCEP+G+6oKuVC3zGqtDmRWOYJt3iDDGQuOOB30hx
	lOowJmO5dQrwCKSTw4y7PTgEQbdKeHFGQ2u/7ikgEFbex8IC9PstQL480txFdu7M79KAnHR2lglmO
	c1vJWEzx3paQPjM4Cc2Dy9Nkj7ayp+IuraEZrPXH9ZgvIno3JhsNWhR9gCykIvy8ZbmPXIm5iS9UQ
	l7tWxTdg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nFAr6-00EY4F-3z; Wed, 02 Feb 2022 08:19:08 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nFAr1-00EY1U-KG
 for linux-nvme@lists.infradead.org; Wed, 02 Feb 2022 08:19:06 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 2A38F68AA6; Wed,  2 Feb 2022 09:19:00 +0100 (CET)
Date: Wed, 2 Feb 2022 09:18:59 +0100
From: Christoph Hellwig <hch@lst.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
 Keith Busch <kbusch@kernel.org>, Chris Leech <cleech@redhat.com>
Subject: Re: [PATCH 1/4] nvme-tcp: fix a possible use-after-free in
 controller reset during load
Message-ID: <20220202081859.GA18942@lst.de>
References: <20220130092119.595854-1-sagi@grimberg.me>
 <20220130092119.595854-2-sagi@grimberg.me> <20220201080335.GB29518@lst.de>
 <654808ec-81e9-0205-779b-7502ee6c5b0a@grimberg.me>
 <20220201135841.GA2518@lst.de>
 <59c5afdf-c7c8-58ea-90d0-83b8edb5b4cb@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <59c5afdf-c7c8-58ea-90d0-83b8edb5b4cb@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220202_001903_856054_D6B05658 
X-CRM114-Status: GOOD (  15.95  )
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

On Tue, Feb 01, 2022 at 05:25:02PM +0200, Sagi Grimberg wrote:
>
>> On Tue, Feb 01, 2022 at 02:36:03PM +0200, Sagi Grimberg wrote:
>>> The driver will make sure to flush ctrl->async_event_work _after_
>>> changing the controller state (it is flushed in nvme_stop_ctrl).
>>> Only after that it will continue to free the admin queue. So if
>>> this check passed, it is safe to submit the aer command.
>>>
>>> I think that the ctrl->state check should be sufficient. In fact, I
>>> think we can move it to the core instead of doing it in the drivers:
>>
>> Maybe through in a comment explaining this?  Otherwise having less
>> checks and having them in the core is always a good thing, so I'm
>> in favour.
>
> I sent a v2 already. You want me to send a v3 with something like:

I've added the comment manually and applied the v2 series, thanks!

