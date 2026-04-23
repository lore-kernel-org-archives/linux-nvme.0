Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96DF0FAD41A
	for <linux-nvme@archiver.kernel.org>; Thu, 23 Apr 2026 05:57:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6vv8oPnVixwFFUTdpYBXNzD/rjh/jJ7ct+j5htapQ2I=; b=ffnARXY/jWQcChg6I6kDqj2O0g
	gOvOUrLDXckcQG0kQb3QXjD5Q/bUot2xkPAlGFqWS4BbBdgwstDJPeRY/EX/Ei+U4Pri0c4xqZkpa
	2Tgwu/6o2EV10vt/+9ZW1gsk4KyzKxJ7T5rhMkVc0pOSb71s8kWMbeE92kAceesm/0+cH8/xSJHX0
	KacD3x/MWZRyLfRGp9bAJteFEep5x9EvkwyuGV7pTBhbiYG1nanJbNyeTVYnc6T0YRNlSOVguSpXL
	P7pSxUul6xfizln8HC/a3+VUr/+7Lr/p9ezs9EN+PXqqaXc0wgHRgn8znwnkTws8qDA+Rc978iqhm
	O2Mym+fg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wFn44-0000000B5aJ-0NBR;
	Thu, 23 Apr 2026 05:57:28 +0000
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wFn43-0000000B5a5-0shX;
	Thu, 23 Apr 2026 05:57:27 +0000
Date: Wed, 22 Apr 2026 22:57:27 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Tokunori Ikegami <ikegami.t@gmail.com>
Cc: Christoph Hellwig <hch@infradead.org>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH v2 2/2] nvme: initialize known effects to set ns_mgmt NCC
 and ns_attach NIC
Message-ID: <aem0x5CsghH7HoWd@infradead.org>
References: <20260422141159.10881-1-ikegami.t@gmail.com>
 <20260422141159.10881-3-ikegami.t@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260422141159.10881-3-ikegami.t@gmail.com>
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

On Wed, Apr 22, 2026 at 11:11:48PM +0900, Tokunori Ikegami wrote:
> This is to make sure scan_work done for the commands.
> Since nvme_passthru_end called when effects set.
> Also scan_work is flushed when NIC or NCC effects set.

Can you explain the rational a little better here?  Do you have a
device that does not have these entries?  And what problems does that
cause for you for which workload?


