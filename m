Return-Path: <SRS0=D68J=FL=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7A33C4361B
	for <linux-nvme@archiver.kernel.org>; Mon,  7 Dec 2020 15:31:31 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A3B123730
	for <linux-nvme@archiver.kernel.org>; Mon,  7 Dec 2020 15:31:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A3B123730
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=/pRebkCeCcNX7mTEvCoNsfxCokeeOw7U03J/U/ffrEg=; b=LRdi52nFuoUmG9PnewY1bvo4d
	o73Tnba7dEGZnsyMA6h1GFhbW9Cnn5h6WG6BzTaN4QKgXkW9atx0bc+JkKIQaLCjNaftHD+LrZ0gc
	Fx5tJ4ejd8LZ3HJfXLkCUuT0DPoFkrcLSi6EFgYAbNXup4JKMYRZ2D0US7Md33P6XV5Xz0mMk4+Qs
	QuAdAoxTZpDXilDf4qT1btV4nmTNGEGiM4NMLIjGiruhpUj8MH5Vp0DJ4qDm5ggfnfVPlrwplMAEe
	Gx4Tfhtq9FtBaOSp0dvKVjV8p4Ue07PG9xBvM1OHf0El/5Tvg5z3b4JNVKqcjita0P5V0AfPvQ3a4
	gRjl6EgWQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kmIU4-0000Hl-Jg; Mon, 07 Dec 2020 15:31:28 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kmIU1-0000G7-1k
 for linux-nvme@lists.infradead.org; Mon, 07 Dec 2020 15:31:26 +0000
Date: Mon, 7 Dec 2020 07:31:21 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1607355084;
 bh=7KcYWdDPAa3xTdfzsTDCvlsl8029O/eQwXth/zsyUjA=;
 h=From:To:Cc:Subject:References:In-Reply-To:From;
 b=GUXzHx6c8K2auuIaCqrxksoZ7Vzv5J5CYHgujHbhpqOeGq+jfQGqnG6KOwu7FhqFz
 yBKBJuOdh3ZXybLIcR/T44XCfhIhqkx54a6DK6U9mv/9JvJikBazuY1TOvDA7NSXoB
 wvgKfQUBg+AXoqNmvqtPJdctNLwT8i6amZXhTKD4pDOCsUu230oo1qM5yJQJH8y/pZ
 A8LfkHVAcXd//YwobLRdFJudYVVbamHJTup9a4ZYgf1O7uLCpmUHep6YFec2vwX9Uy
 vHWguQ4g/D/kNNKY2c+53hJsrJF4yaNbGeSDisRpOkl5qBssweAICT0Ml9K2P/tJ/q
 jMZ0DlMKSGfIw==
From: Keith Busch <kbusch@kernel.org>
To: Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH] nvme: retrigger ANA log update if group descriptor isn't
 found
Message-ID: <20201207153121.GA3679937@dhcp-10-100-145-180.wdc.com>
References: <20201205152901.56665-1-hare@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201205152901.56665-1-hare@suse.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201207_103125_178664_345B7060 
X-CRM114-Status: UNSURE (   9.85  )
X-CRM114-Notice: Please train this message.
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Keith Busch <keith.busch@wdc.com>, Christoph Hellwig <hch@lst.de>,
 linux-nvme@lists.infradead.org, Sagi Grimberg <sagi@grimberg.me>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Sat, Dec 05, 2020 at 04:29:01PM +0100, Hannes Reinecke wrote:
> If ANA is enabled but no ANA group descriptor is found when creating
> a new namespace the ANA log is most likely out of date, so trigger
> a re-read. The namespace will be tagged with the NS_ANA_PENDING flag
> to exclude it from path selection until the ANA log has been re-read.
> 
> Reported-by: Martin George <marting@netapp.com>
> Signed-off-by: Hannes Reinecke <hare@suse.de>

This looks good to me.

Reviewed-by: Keith Busch <kbusch@kernel.org>

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
