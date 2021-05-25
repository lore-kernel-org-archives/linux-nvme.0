Return-Path: <SRS0=dfbP=KU=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1B7BC2B9F8
	for <linux-nvme@archiver.kernel.org>; Tue, 25 May 2021 07:52:42 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6CA7961401
	for <linux-nvme@archiver.kernel.org>; Tue, 25 May 2021 07:52:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CA7961401
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=xLBBKiC4l/luPUrFtpS+eLmVOyG0qvQwWo/RlC88gTg=; b=jMnRk69I4VFAqH
	9KT8PMFKrqbynbsxXe4EIKvlTehzZ4pE5jhgGk3aEnFVTZACL/EjD07Us48S+ury63QGIqQi/JHIG
	SplU/U8xx90cylAGtPHWppIWuuRcBtwpvEmtFTFi6d4pEjQKL4V/UJqvyYNkKvEokAppv/GbIRjzw
	zmdbgCUt2vBzLzpzp64XtEk0pnISgLZBW2tOmcEhw7iYOt0iQfbDnb23SjvSq1Ph6zU38LXN7D8wl
	ejYcEzyXVd9Gw9Q6uQ0pxFT8VmxBDPDoL5ntaoiaX7yUiUIVQfqFaj6WiKBJuH+7yuLtHVhzxmdEr
	4Mi24L6joW6NCV1mILFg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1llRrY-003yup-3l; Tue, 25 May 2021 07:52:28 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1llRrT-003ytF-Pu
 for linux-nvme@lists.infradead.org; Tue, 25 May 2021 07:52:25 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1621929142; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=j2fhzr5837zU52YoYCCj7OktYsUUOPoJ2zCaPYIo83k=;
 b=FYHFW19kcHff0IwGFZ5Mi4waWtuwa+eDq8I9Hvz2IxEKqnsB7CWcTvlz7ytmv5vxSl3XP5
 C/AhJsLtMbxLxuNScTPxongo0aUnBbL6Mhw4JHQY49U+9aloLF2RlUDr5GAnY8mQbMa7ho
 K0qabBWmtya5dMLd44GRlbUdZ77olmo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1621929142;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=j2fhzr5837zU52YoYCCj7OktYsUUOPoJ2zCaPYIo83k=;
 b=jkKPQIu7zYgNJ/mnzjMS8+pVaCI2J+4jvEvclpUsXmJiPc9yNqKQ8wmzXI60hdr2VYg+l0
 ERYJWKrnSaq0IjAw==
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 6AF0BAE1F;
 Tue, 25 May 2021 07:52:22 +0000 (UTC)
Date: Tue, 25 May 2021 09:52:21 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 Jens Axboe <axboe@fb.com>
Subject: Re: [PATCH] nvme: Use NN for max_namespaces if MNAN is zero
Message-ID: <20210525075221.uuzabne3qizne3er@beryllium.lan>
References: <20210521144734.90044-1-dwagner@suse.de>
 <20210521145306.ld7jc6alchimyzny@beryllium.lan>
 <20210521152702.GB29013@redsun51.ssa.fujisawa.hgst.com>
 <f89bf79e-937c-96ba-4622-4a29fce00b0e@grimberg.me>
 <20210524073703.GA24372@lst.de>
 <20210525071259.j5g7koxqad7hwpkp@beryllium.lan>
 <20210525072234.GA13966@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210525072234.GA13966@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210525_005224_008399_568F3097 
X-CRM114-Status: GOOD (  10.28  )
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

On Tue, May 25, 2021 at 09:22:34AM +0200, Christoph Hellwig wrote:
> For non-ANA MNAN doesn't have to be set indeed.  But we also don't use
> the value at all either.

Ah yes, I somehow though we still allocate the log buffer. Obviously, the
buffer is only used with ANA... time to fetch a coffee.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
