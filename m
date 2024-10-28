Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2633D3E2BC
	for <linux-nvme@archiver.kernel.org>; Mon, 28 Oct 2024 19:46:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WkAZFsfM1A1Gu8KWgawyNu0Srcl7qjDqjZ9OBg9Fves=; b=RcEpRRB1vqxM3NTHDAUSoLyr/1
	w8+IvDNpqRo5vs8HYzxNUUg2x1LRQRxcejzBbk6FJsIjtmIviRKLib9XCS0t2ZhI5tLCbBRXFBgaj
	ZtzAEieptb3ZuAIzjZ5K7CMLtATQMFa3u4CRpQqRwDnnOIqSj2Zu049hS3AlhnK25DJlXlHQelJdm
	LTSbUgXh92tBhYsMKlnvb6DaOshb8jF0U9h9w2UOeWSSq76z6/iMIR2AOXbuOUbbo77KOPTD+vW9B
	fD/AKiRvupq+CfVpgJY6sSk8vcdOXl8ESxlIIfrx5AB2mcY9AyYAGYu6m4xnx2gDrvxh895gc2nNs
	Pps3Kt5g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t5VhK-0000000C2lv-3aWg;
	Mon, 28 Oct 2024 19:46:42 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t5VhI-0000000C2lV-2vvV
	for linux-nvme@lists.infradead.org;
	Mon, 28 Oct 2024 19:46:42 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id DA7D7A41B64;
	Mon, 28 Oct 2024 19:44:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8F33C4CEC3;
	Mon, 28 Oct 2024 19:46:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730144799;
	bh=qZt8mJEDRl+Yth1e6zFjf+4BIU5q5r0ncS6SezGz7b8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bx5NAOQS/qZimCwhu4Tm3bsAGYBRGjZwoqtP1zKvpbF3pT9s4gfzbc2zgrfenOZxM
	 zdZx6V1GKJeeI3+fls+Mx6UJfo4cVmLb0T/WZETo/fTXodQMVaxzL4KpJJbIT5dKVG
	 3svJm0EpMXZmnG8eoR6/0xvc8BLpglaWX9OTudu69TonjzK73RHXZimXm/5AEVQsVD
	 yLbjvDq27Hnr1p/9R5hfXS1hrxbPWwjmulI+itn7PHPZc/qB8v6lT54MVddl9Umfzu
	 nTuuhsKPauBDPxabGkrHj1EVc35BnyDJthVXBlOVp4WTHiSQNw6coamAekfchPx/fS
	 QksMEwbvoRQaw==
Date: Mon, 28 Oct 2024 13:46:36 -0600
From: Keith Busch <kbusch@kernel.org>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
	io-uring@vger.kernel.org, linux-fsdevel@vger.kernel.org, hch@lst.de,
	joshi.k@samsung.com, javier.gonz@samsung.com
Subject: Re: [PATCHv9 3/7] block: allow ability to limit partition write hints
Message-ID: <Zx_qHAqoFpl7Ivj7@kbusch-mbp>
References: <20241025213645.3464331-1-kbusch@meta.com>
 <20241025213645.3464331-4-kbusch@meta.com>
 <626bd35e-7216-4379-967d-5f6ebb4a5272@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <626bd35e-7216-4379-967d-5f6ebb4a5272@acm.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241028_124640_827958_4AE267A7 
X-CRM114-Status: GOOD (  11.24  )
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

On Mon, Oct 28, 2024 at 11:27:33AM -0700, Bart Van Assche wrote:
> On 10/25/24 2:36 PM, Keith Busch wrote:
> > When multiple partitions are used, you may want to enforce different
> > subsets of the available write hints for each partition. Provide a
> > bitmap attribute of the available write hints, and allow an admin to
> > write a different mask to set the partition's allowed write hints.
> 
> After /proc/irq/*/smp_affinity was introduced (a bitmask),
> /proc/irq/*/smp_affinity_list (set of ranges) was introduced as a more
> user-friendly alternative. Is the same expected to happen with the
> write_hint_mask? If so, shouldn't we skip the bitmask user space
> interface and directly introduce the more user friendly interface (set
> of ranges)?

I don't much of have an opinion either way. One thing I like for the
bitmask representation is you write 0 to turn it off vs. the list type
writes a null string. Writing 0 to disable just feels more natural to
me, but not a big deal.

