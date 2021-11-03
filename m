Return-Path: <SRS0=DxE/=PW=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 896EBC433EF
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Nov 2021 07:22:40 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3057761156
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Nov 2021 07:22:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 3057761156
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UjnXusBBy4ZDy8SyzEHeBeC9YUD9rWmDwpqpEe/PQW4=; b=KIesgrqD3uT8pqPXY86wqiuWH3
	OzSuYERS6zcM+gqw1BFFHuQy4IoBPe7E0FLqzDv2/F/tvz3BdLASxu1uIyJg3tcGa1NQ8JRHTZhnZ
	B/ogmAbTdyS9goyCNZQETYjHiwDOt/vB9gKTlIXi4acRoklO/mmLMy1hhbf+NITGfGIhyGoeAM1oe
	BbvRQ3vYZYf80dgFpTI84Ucz/cwRzAsdVEvzN9SxFfVGXs8lMlb/DEtMs6aovpzTZFRaRIdTPjzpk
	I0Slq6Ga0llFBBTmQ1pF0BLUd6dwh4ZOY8bzq60hfcTQfMB2WPVB1iuluakoXY752H1O7ZXyl/A5M
	LOj9rCqg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1miAbS-004PJC-Tr; Wed, 03 Nov 2021 07:22:34 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1miAbP-004PHM-Mi
 for linux-nvme@lists.infradead.org; Wed, 03 Nov 2021 07:22:33 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id D56F168AA6; Wed,  3 Nov 2021 08:22:23 +0100 (CET)
Date: Wed, 3 Nov 2021 08:22:23 +0100
From: Christoph Hellwig <hch@lst.de>
To: "chenxiang (M)" <chenxiang66@hisilicon.com>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
 Jeffle Xu <jefflexu@linux.alibaba.com>, Ming Lei <ming.lei@redhat.com>,
 Damien Le Moal <Damien.LeMoal@wdc.com>,
 Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 "Wunderlich, Mark" <mark.wunderlich@intel.com>,
 "Vasudevan, Anil" <anil.vasudevan@intel.com>,
 linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-nvme@lists.infradead.org
Subject: Re: [PATCH 14/16] block: switch polling to be bio based
Message-ID: <20211103072223.GB31003@lst.de>
References: <20211012111226.760968-1-hch@lst.de>
 <20211012111226.760968-15-hch@lst.de>
 <beb633f4-4508-ea53-4a34-adf0f20cda85@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <beb633f4-4508-ea53-4a34-adf0f20cda85@hisilicon.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211103_002231_932831_93F81230 
X-CRM114-Status: GOOD (  11.65  )
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

On Wed, Nov 03, 2021 at 03:11:25PM +0800, chenxiang (M) wrote:
> For some scsi command sent by function __scsi_execute() without data, it 
> has request but no bio (bufflen = 0),
> then how to use bio_poll() for them ?

You can't send these requests as polled.  Note that these are passthrough
requests only.

