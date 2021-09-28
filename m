Return-Path: <SRS0=nS76=OS=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A08B7C433EF
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Sep 2021 03:56:40 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5081E611F2
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Sep 2021 03:56:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5081E611F2
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:Reply-To:List-Subscribe:List-Help:
	List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:
	In-Reply-To:Message-ID:Subject:Cc:From:To:Date:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=uq+38Maw57KtvABEarXvGxOgqXJ4OMdOWHO+CJosLII=; b=wL7ijSVWlluOS5
	v9htEafx8IkWzdL2FmEfTHxcrUsYtWWFZRxQqjYz/4x0G6j0P/1kL02zJX97AEhN2JlUhaIdfFZ2i
	JdvXGX6hL6RQJKmY5BoXvzT4KqfjDxS7+tZ7WkesY57H7FIz6whQ3OdB2edx9U9qAGkGpZBySjzI4
	F+8mM/JHFutcQbaBS4cTw5GM3+DAs8vSjChMaSujKWRo1rrMKctJsj9G+RKOFF+WKAMWnXlTiLRsD
	dsGlu+ZFFVkK0wxzQe3V05+/gYYIBPgeP7vWHEKrJh2ngzAjsEXwdaBqTqsDfeRzfEChpRZJOirzQ
	sn2QrUoV6WonH5zMPcMA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mV4Dk-005TjK-7w; Tue, 28 Sep 2021 03:55:56 +0000
Received: from mail-4319.protonmail.ch ([185.70.43.19])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mV4Dh-005Til-3e
 for linux-nvme@lists.infradead.org; Tue, 28 Sep 2021 03:55:54 +0000
Date: Tue, 28 Sep 2021 03:55:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
 s=protonmail; t=1632801350;
 bh=z1qNPQYLno566jNlHm1NK9hDE1ClX3aiY9sUnHP8IGA=;
 h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
 b=FpyjKWYUTJZEzCBq/l98SDJXyUebazy9Isq1zrQEeV/tSAKAbZ24ol8uQng33ZeKe
 jvqQPcGb+vbQoCLw1b8s4I/4bbKqO1IFnzWlWpYDZIYX2bLsjTcY9gml0CxprwHIln
 sTMypClLOazy8Onpb6HLG+pqc42wYq4m0iUQkXcQ=
To: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 sagi@grimberg.me, hch@lst.de
From: Orlando Chamberlain <redecorating@protonmail.com>
Cc: linux-kernel@vger.kernel.org, axboe@kernel.dk,
 Sven Peter <sven@svenpeter.dev>, Aditya Garg <gargaditya08@live.com>
Subject: Re: [PATCHv2] nvme: add command id quirk for apple controllers
Message-ID: <38101793-e0b9-ecf4-d235-465cb8e334b3@protonmail.com>
In-Reply-To: <20210927154306.387437-1-kbusch@kernel.org>
References: <20210927154306.387437-1-kbusch@kernel.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210927_205553_345872_C7E197DC 
X-CRM114-Status: GOOD (  10.91  )
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
Reply-To: Orlando Chamberlain <redecorating@protonmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org



On 28/9/21 01:43, Keith Busch wrote:
> Some apple controllers use the command id as an index to implementation
> specific data structures and will fail if the value is out of bounds.
> The nvme driver's recently introduced command sequence number breaks
> this controller.
> 
> Provide a quirk so these spec incompliant controllers can function as
> before. The driver will not have the ability to detect bad completions
> when this quirk is used, but we weren't previously checking this anyway.
> 
> The quirk bit was selected so that it can readily apply to stable.
> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=214509
> Cc: Sven Peter <sven@svenpeter.dev>
> Reported-by: Orlando Chamberlain <redecorating@protonmail.com>
> Reported-by: Aditya Garg <gargaditya08@live.com>
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> ---
> v1->v2: fixed logical bug checking the quirk setting
> 
>  drivers/nvme/host/core.c | 4 +++-
>  drivers/nvme/host/nvme.h | 6 ++++++
>  drivers/nvme/host/pci.c  | 3 ++-
>  3 files changed, 11 insertions(+), 2 deletions(-)

Works on my MacBookPro16,1.

Tested-by: Orlando Chamberlain <redecorating@protonmail.com>


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
