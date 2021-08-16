Return-Path: <SRS0=M7ZW=NH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF7CDC4338F
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Aug 2021 21:03:44 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8AA2D60F11
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Aug 2021 21:03:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8AA2D60F11
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=u0znJsaxSKhJxhEs3XdeLh9foReNd9Eyx8VQ6oam5f8=; b=R2YZuwEsD5qTFK
	MpcHl4MojaqQeUFJ6w12aKw4oDovUFsmD6q17X2rCl+dgzRE8CywNmdocgGw3gOELf8bVYl+3av5/
	CdmnfWsn6xIKKgj+fwX59/WTZ30KPceLmJIXr5X4c4ZRu0ipGt/mwqCTHOItlJ3Dj8JXhxrRVJnbw
	XD3wUzwijv65dixGco8fx0zkWWpr9M26i66r5OBOtEQzGVEO/v2immD1NOO4Mzc0CQjB8Hw6iFpgk
	BAMRMmnludTBXiNwVe/eNYZbHYLGErzeVKVIk/T6h+IGKJtqlR35vWfevI8eWnvfMjMVtuZ8KNnVD
	0r0vm20ajJjkG+aHt5pw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mFjlH-000HzS-W1; Mon, 16 Aug 2021 21:03:12 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mFjlF-000Hyf-49
 for linux-nvme@lists.infradead.org; Mon, 16 Aug 2021 21:03:10 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0EE5160F11;
 Mon, 16 Aug 2021 21:03:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1629147788;
 bh=Gd4Cdh2m5li1PwmMIceieTl0p0IroqgTfVSOGp6997w=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=a+OQGCOjGzD6xEEHM4xYRf1fV1QVkXKpHx9qvPbn2mNY+sciRCIf8KxPcOGwS5WCZ
 y4AZtpowCytQbZevtdtAJzs7oRpz8PY9hDxEDB/oC9KiQ9KtWF/M6+sxf+XmKdtj7i
 Upqhv57hOag/lLtDL1DleYw2tPbXX1DINgXtbB4cKIf3ckSXByV5AClO5umayBT2e5
 2MOGo3FtMH2hH/oQ+liQWOHaHjiRjxKrF27nVoyitkmBFFlriHKtyVUG/PTu77KnF+
 bRkqgZVbHXtj/XNrB4qNJQafDAxp4kgoS6rlM/NAPIF30p08442qBYgAGxJsS9u3li
 AlptZuWgqMrOg==
Date: Mon, 16 Aug 2021 14:03:06 -0700
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme: remove the unused  NVME_NS_* enum
Message-ID: <20210816210306.GA223699@dhcp-10-100-145-180.wdc.com>
References: <20210816124604.606056-1-hch@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210816124604.606056-1-hch@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210816_140309_223623_D09C62C8 
X-CRM114-Status: UNSURE (   8.92  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Mon, Aug 16, 2021 at 02:46:04PM +0200, Christoph Hellwig wrote:
> These values are unused now that the lightnvm support is gone.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks good.

Reviewed-by: Keith Busch <kbusch@kernel.org>

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
