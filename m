Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 193CAE77188
	for <linux-nvme@archiver.kernel.org>; Fri,  3 Jan 2025 09:29:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jmVJJz+38rmIB/8qMaixIq1CEISbYL2BWv1447YsIio=; b=N1TT1p48zD6ZtsiDfs0yferIHH
	lDVm3inKimNCcLsWFhuzT+OuYkBFZ4m7+sULYyLUCtBsn1AJG21F1YDu1ouq+SJpFbQJvInrh/PUl
	Iz+K13xQ18gewF3XClRDZNCb3tqW6WXop3ybfNqBj+3YLkoG+yNJm0WrLbQp2P073iDn6slE7D4YX
	wjmnatiu+IzsGMp9kWiQiI6iVZHvtKL+KbHE3oAQIPxDfKd/iHF0UbkMWC405KKXQocfKAsnCf/kU
	OfYexO/qh3bvvs30Eo//q5l681AQAW/pn0NK4l6vterIwCLPB8NGK0j3hd7+LwU21gU8B8W7ZIY4W
	+wZapkig==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tTdzb-0000000Cc6e-2xLG;
	Fri, 03 Jan 2025 09:29:19 +0000
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tTdx8-0000000Cbaw-0eXi;
	Fri, 03 Jan 2025 09:26:46 +0000
Date: Fri, 3 Jan 2025 01:26:46 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Vishnu ks <ksvishnu56@gmail.com>
Cc: lsf-pc@lists.linux-foundation.org, linux-block@vger.kernel.org,
	bpf@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [LSF/MM/BPF TOPIC] Improving Block Layer Tracepoints for
 Next-Generation Backup Systems
Message-ID: <Z3etVqYMWjh9n7s5@infradead.org>
References: <CAJHDoJac2Qa6QjhDFi7YZf0D05=Svc13ZQyX=92KsM7pkkVbJA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJHDoJac2Qa6QjhDFi7YZf0D05=Svc13ZQyX=92KsM7pkkVbJA@mail.gmail.com>
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

On Wed, Jan 01, 2025 at 12:04:56PM +0530, Vishnu ks wrote:
> - I'm developing a continuous data protection system using eBPF to
> monitor block request completions
> - The system aims to achieve reliable live data replication for block devices
> Current tracepoints present challenges in capturing the complete
> lifecycle of write operations

This is nuts.  No, we don't guarantee any stability in the trace points,
and certainly not for data integrity operations.

Please make sure this never gets near any production system.

