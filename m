Return-Path: <SRS0=yUYt=43=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00493C18E5A
	for <linux-nvme@archiver.kernel.org>; Tue, 10 Mar 2020 16:56:47 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C633E222C3
	for <linux-nvme@archiver.kernel.org>; Tue, 10 Mar 2020 16:56:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="QaBTZ5Fh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C633E222C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=JWurlnGz9xaTdokkQUV9UoxZBIFWdzEaIoj4WjzHtZY=; b=QaBTZ5FhrUprgY
	u6QYqRuNwJTVFDITGbWBiPumwsrUlLbiXw+CYtPQGyo5Xqn8G+vvebth2Uh3n3Rb/K5xtVnTMg131
	+o0meJbovcbmrXQsOi6cN8pEdYq1uqt7k0ZeHTx0u185RVr2U/LRgj7HxhhxVpKBE/MArMm+sGkcm
	H6eCZvVyFioJtF+yzo1g6lNB2YVMVGWGYI8ghXIGskWWXZ2Hb25yB/3iK/pb6Vs9pSkxhNn22lvcW
	xGITsRpOWvNisyzX6tT5N+AVRSUtAY8SBBRrPollUDpXofzphy7kXJmNdIoNhUgWQRJ2Fm5a3h/Q1
	bxGURBD041kbO6ISugRg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jBiBP-0002XH-Qo; Tue, 10 Mar 2020 16:56:43 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jBiBI-0002Oh-7A
 for linux-nvme@lists.infradead.org; Tue, 10 Mar 2020 16:56:37 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id C03CF68BE1; Tue, 10 Mar 2020 17:56:33 +0100 (CET)
Date: Tue, 10 Mar 2020 17:56:33 +0100
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv2 1/3] nvme-pci: Remove tag from process cq
Message-ID: <20200310165633.GA7114@lst.de>
References: <20200304181246.481835-1-kbusch@kernel.org>
 <20200304181246.481835-2-kbusch@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200304181246.481835-2-kbusch@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200310_095636_405612_6A8DC6F4 
X-CRM114-Status: UNSURE (   7.15  )
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
Cc: bijan.mottahedeh@oracle.com, hch@lst.de, linux-nvme@lists.infradead.org,
 sagi@grimberg.me
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, Mar 04, 2020 at 10:12:44AM -0800, Keith Busch wrote:
> The only user for tagged completion was for timeout handling. That user,
> though, really only cares if the timed out command is completed, which
> we can safely check within the timeout handler.
> 
> Remove the tag check to simplify completion handling.
> 
> Signed-off-by: Keith Busch <kbusch@kernel.org>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
