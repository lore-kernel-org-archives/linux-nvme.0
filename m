Return-Path: <SRS0=sGEd=4I=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8187FC11D0C
	for <linux-nvme@archiver.kernel.org>; Thu, 20 Feb 2020 16:47:18 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 54A10207FD
	for <linux-nvme@archiver.kernel.org>; Thu, 20 Feb 2020 16:47:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Y5kMhOgC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54A10207FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=otPQo7NJbhefJ6K4ghgQuzc809+OIvtZuE1MDbGeEsI=; b=Y5kMhOgC52ObNm
	xReaRnmlbJ1/2GfV5ZqSFDd7gmv7ZR9vlgbB8GEvdPmYBBQDrSuURINPHfqoU2+h/TfWTZifL/la7
	mGaNTwyj7NXg6EC5bt2zIceOFfBAVfKODPSZbcOyKR2nKShwnkV5wJjVfmMyQsHqqwkP5jh2Su1Kl
	46QfLJNIIyaFoEWLaXUClbp6BPXG4V/1T3UviMv03vezp2lpHnXlduHJAdRzLPRyZ+xq/XPbvye/9
	7dvdHHKXWbYs2ZeXRWObkGhZMuvn3K1PbS2Xvir5oMJBhlHq8y+VtaMBE+dbCSAx0H7oCNizPqw/V
	03ARGXjbtiKFDwTx9xmw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1j4oyo-0001Dk-Km; Thu, 20 Feb 2020 16:47:14 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1j4oyk-0001Cd-VW
 for linux-nvme@lists.infradead.org; Thu, 20 Feb 2020 16:47:12 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 0B1BA68BFE; Thu, 20 Feb 2020 17:47:05 +0100 (CET)
Date: Thu, 20 Feb 2020 17:47:04 +0100
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH] nvme-multipath: do not reset on unknown status
Message-ID: <20200220164704.GA13560@lst.de>
References: <20200220145241.12982-1-kbusch@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200220145241.12982-1-kbusch@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200220_084711_161519_BE5ABBED 
X-CRM114-Status: GOOD (  11.50  )
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
Cc: hare@suse.de, John Meneghini <johnm@netapp.com>, hch@lst.de,
 linux-nvme@lists.infradead.org, sagi@grimberg.me
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, Feb 20, 2020 at 11:52:41PM +0900, Keith Busch wrote:
> From: John Meneghini <johnm@netapp.com>
> 
> The nvme multipath error handling defaults to controller reset if the
> error is unknown. There are, however, no existing nvme status codes that
> indicate a reset should be used, and resetting causes unnecessary
> disruption to the rest of IO.
> 
> Change nvme's error handling to first check if failover should happen.
> If not, let the normal error handling take over rather than reset the
> controller.
> 
> Signed-off-by: John Meneghini <johnm@netapp.com>
> [changelog]
> Signed-off-by: Keith Busch <kbusch@kernel.org>

This pretty much looks like my edited version of Hanne's patch with
John's changelog and your edits..

>  		if ((req->cmd_flags & REQ_NVME_MPATH) &&
> +		    nvme_failover_req(req))
> -		    blk_path_error(status)) {
> -			nvme_failover_req(req);
> +		    nvme_failover_req(req))

This conditional could now fit onto a single line.

Otherwise this looks fine to me.

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
