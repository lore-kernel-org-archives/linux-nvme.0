Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9054BC433F5
	for <linux-nvme@archiver.kernel.org>; Fri, 25 Feb 2022 18:19:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=awTPMhI6+fWH7ThvGcKadtNwX/TwnNDPzuU9+kvBQs4=; b=bajqOWUg5I2gBGyF9dWSCbolAU
	SW5iqMQ4Re1nDm90Q6iWzQeqwKY/9U0be9XLq4h3rVloH/jC2lWdukLj1w3Oy5dWNHp/8zFFdLMBL
	MN6CH4FUvwYEq0DZKXXdnKIC6IJy1xvi0/jhJlfsrSKn3+UMlvHx4WBR2Zdrc5vLBZcRpL/YH8D4W
	WtRG6OCJjq6IJa+VsmkAkIT/U/Xok5bEKoMTlLZt/T0iH9nan0ENnATV3h2TQIoJNmcyS4b3aKmvo
	OQ9LyXjUdSsakW+JuqI5th1NXIcVtrigyoxiu1QYip8M3+n/YuDTuIahJL3PvW8bbVYZTDXNMplHC
	RvX+/XaQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nNfBL-006Xlr-MN; Fri, 25 Feb 2022 18:19:07 +0000
Received: from relay3.hostedemail.com ([64.99.140.34])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nNema-006NPW-6k
 for linux-nvme@lists.infradead.org; Fri, 25 Feb 2022 17:53:39 +0000
Received: from omf08.hostedemail.com (a10.router.float.18 [10.200.18.1])
 by unirelay07.hostedemail.com (Postfix) with ESMTP id 1280E22362;
 Fri, 25 Feb 2022 17:53:18 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by
 omf08.hostedemail.com (Postfix) with ESMTPA id F0D6F20026; 
 Fri, 25 Feb 2022 17:53:13 +0000 (UTC)
Message-ID: <cc8405c39037d1b63df3d901051118f9b12c36a9.camel@perches.com>
Subject: Re: [PATCHv3 03/10] asm-generic: introduce be48 unaligned accessors
From: Joe Perches <joe@perches.com>
To: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org, linux-block@vger.kernel.org, 
 linux-crypto@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org,
 axboe@kernel.dk, martin.petersen@oracle.com, colyli@suse.de, Hannes
 Reinecke <hare@suse.de>, Arnd Bergmann <arnd@arndb.de>
Date: Fri, 25 Feb 2022 09:53:11 -0800
In-Reply-To: <20220225160300.GC13610@lst.de>
References: <20220222163144.1782447-1-kbusch@kernel.org>
 <20220222163144.1782447-4-kbusch@kernel.org>
 <20220225160300.GC13610@lst.de>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.4-1ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Stat-Signature: spz4ukuecs8kzmbxa6om18zqso8poejr
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: F0D6F20026
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1+7WrsVDd0XN45qTzKLE5sj7V3piTJ4Lf8=
X-HE-Tag: 1645811593-962451
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220225_095332_396869_DD51B556 
X-CRM114-Status: GOOD (  12.00  )
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

On Fri, 2022-02-25 at 17:03 +0100, Christoph Hellwig wrote:
> On Tue, Feb 22, 2022 at 08:31:37AM -0800, Keith Busch wrote:
> > The NVMe protocol extended the data integrity fields with unaligned
> > 48-bit reference tags. Provide some helper accessors in
> > preparation for these.
> > 
> > Reviewed-by: Hannes Reinecke <hare@suse.de>
> > Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
> > Acked-by: Arnd Bergmann <arnd@arndb.de>
> > Signed-off-by: Keith Busch <kbusch@kernel.org>
> 
> Looks good,
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Perhaps for completeness this should also add the le48 variants
like the 24 bit accessors above this.


