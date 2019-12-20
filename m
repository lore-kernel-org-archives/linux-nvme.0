Return-Path: <SRS0=LlAf=2K=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E92BC43603
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Dec 2019 21:21:05 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D135D206DA
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Dec 2019 21:21:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="QXdHj7nG";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="rWWY0UW2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D135D206DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=lCMuL/E7O4NGq97Ms2o2/1ycg+7tz9jJGDk+QzJnPuU=; b=QXdHj7nG5b7UwH
	WwCpbG2mzU5QZXB7DcU1u3FI/7LtzwghbH90kzY2X0V4++uFEox8e4eWOMHLuKYA6EG9iFgHjYh9p
	1t7YgCThSUUuRLWFY7DeSjCf/qyRUSl06v2enZLczVRM0+lFM9fly0PTtEL9GcGq3zFlxDZ4Hu4EK
	6gX3KPUHJ6W0JTZ9nZDU17uVXqlYbwGxoE+bM5fvfnzsFIu2bjEaQfdCCQ/YfHb82k4xA5Lgu4rvs
	jleIY9I039nQgD2YEJubc6DW42cVGmwHEuIN4Aegn76Vn2+0+DlHVm85Bj0ZeAHFqDMxUtfMiUhxs
	1BApIy+BdrFiSgTNL3sQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iiPhk-0008K7-5m; Fri, 20 Dec 2019 21:21:00 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iiPhg-0008JP-Mb
 for linux-nvme@lists.infradead.org; Fri, 20 Dec 2019 21:20:57 +0000
Received: from redsun51.ssa.fujisawa.hgst.com (unknown [199.255.47.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id A3AF02146E;
 Fri, 20 Dec 2019 21:20:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1576876855;
 bh=yGg5OlUqc48W/wvYsM0UnmokbFwFG5mhnif2M8frODU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=rWWY0UW2sFFIBtlkukfagk7PdXSlhHtKkyDbmN0b7MlVVaPBN978xsJ77maOc5+h1
 zVfm2zAtRKL4MQhZmbqbtcHmYyG4LkE1kE8h/KV2mhe6tE4b8ByzgApeesSeq2/RE7
 yFZy3wqZzchXnF7KcDZWUkhm7HkMaNg5GSwoO/1U=
Date: Sat, 21 Dec 2019 06:20:49 +0900
From: Keith Busch <kbusch@kernel.org>
To: "Ober, Frank" <frank.ober@intel.com>
Subject: Re: Polled io for Linux kernel 5.x
Message-ID: <20191220212049.GA5582@redsun51.ssa.fujisawa.hgst.com>
References: <SN6PR11MB2669E7A65DD0AD9DC65A67C58B520@SN6PR11MB2669.namprd11.prod.outlook.com>
 <20191219205210.GA26490@redsun51.ssa.fujisawa.hgst.com>
 <SN6PR11MB2669F3546ADCCAEF1D8E50308B520@SN6PR11MB2669.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <SN6PR11MB2669F3546ADCCAEF1D8E50308B520@SN6PR11MB2669.namprd11.prod.outlook.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191220_132056_759340_D401EB73 
X-CRM114-Status: UNSURE (   8.32  )
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
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, "Rajendiran,
 Swetha" <swetha.rajendiran@intel.com>, "Liang, Mark" <mark.liang@intel.com>,
 "Derrick, Jonathan" <jonathan.derrick@intel.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, Dec 19, 2019 at 09:59:14PM +0000, Ober, Frank wrote:
> Thanks Keith, it makes sense to reserve and set it up uniquely if you
> can save hw interrupts. But why would io_uring then not need these
> queues, because a stack trace I ran shows without the special queues I
> am still entering bio_poll. With pvsync2 I can only do polled io with
> the poll_queues?

Polling can happen only if you have polled queues, so io_uring is not
accomplishing anything by calling iopoll. I don't see an immediately
good way to pass that information up to io_uring, though.

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
