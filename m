Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D728FF94CCA
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Apr 2026 06:00:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=h0jAH6vPTmoCRkyAaHxH7CkG5nLF56hOJae/nLg5D2g=; b=rRjrbayvrF1Ipe4YHE/sRFGl7f
	v/dghfYV3WImShsdqkvjvUWajEtseiAlvPSg3Iz5Z4fqwRDNZ/a2z5Zo9hZNGVviNpoZkuxrGQl2a
	jMGg8Qs5JLlaJ/osFAFen449LetyMHWfmkuEBjyN/RiCS344zQ2C0yYRUMznQL/LXaSERXbtfbwvT
	hESyCEg4LaV9dJjBXAbvDQ/HoojugMLaNJLvd4OF8dWJeA7b2Y9ogbHwXftHXrfG/5Es6duVBzQHu
	dMWCgKUxrZSid1gIvlZjlYnq3g97TpkUvX+U6aguONeJpcmvxUWTOuxjccPqmVbjFWRdjPsQEyj53
	V9oZuLkA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wFQd0-00000009dU1-13wa;
	Wed, 22 Apr 2026 06:00:02 +0000
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wFQcy-00000009dTM-1Wf6;
	Wed, 22 Apr 2026 06:00:00 +0000
Date: Tue, 21 Apr 2026 23:00:00 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Tokunori Ikegami <ikegami.t@gmail.com>
Cc: linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme: delete unnecessary empty lines
Message-ID: <aehj4EER-v3Wmupp@infradead.org>
References: <20260418071217.13866-1-ikegami.t@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260418071217.13866-1-ikegami.t@gmail.com>
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

On Sat, Apr 18, 2026 at 04:11:51PM +0900, Tokunori Ikegami wrote:
> Also fix a comment indentation error.

What drives this?  Like most subsystems we usually only take cleanups
together with fixes in the same area.

>  	if (!(readl(anv->mmio_coproc + APPLE_ANS_COPROC_CPU_CONTROL) &
>  		APPLE_ANS_COPROC_CPU_CONTROL_RUN)) {
> -

The more important fix here would the incorrect indentation for
the continuation of the condition above.


