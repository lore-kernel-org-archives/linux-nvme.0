Return-Path: <SRS0=Uo3O=YD=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88741C4360C
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Oct 2019 19:23:28 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A298206B6
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Oct 2019 19:23:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="DhjmfmJL";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kv+GOT8c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A298206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=xk5Ij2a31mhAgPNytmpAFlw6H7A6E7q4tbc1Fldxoq0=; b=DhjmfmJL6snNY+
	jzqasFFOfzEBc7C3/oO7QfbLivThoMzx1oDXL8x12bd2d2WDfw3ab05qMbKitBGBfjpapNta3MaKH
	bnhtzClWFxcs2fTMdewkK2ndjOQTAT49wDDTRLt725vepXrjYzbfRvWxJTnm/AB2BlaPutIq+z4b0
	8pd7mYCcLNKtg1C8zScLCP87iOX6ZvOeqk6t8FqRklbspUQeEg+UcjlLKYU7cdIy/8IiKgTdx9hoH
	qVGbikPCIwXLMmlE8gW7F8DVWW8EX4M8E7dhXe0a2EfWBNmwK/IAfRuAScM8YzIF5lRQrUh/6Povo
	kfCuYdq6+YskVowQ5T3A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iIe20-0005o3-6n; Thu, 10 Oct 2019 19:23:24 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iIe1x-0005ni-Gv
 for linux-nvme@lists.infradead.org; Thu, 10 Oct 2019 19:23:22 +0000
Received: from washi1.fujisawa.hgst.com (unknown [199.255.47.10])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id AECE6206B6;
 Thu, 10 Oct 2019 19:23:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1570735401;
 bh=GNUS+nDFpNwOg/cBGY+9j0/kcNVzWZ+C8K9FXfqmVyo=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Kv+GOT8cpTC8/Yn/VBjoy80FO28UNt2ys/VVmJ0T8NbWQ5r+xyCc5eUThQ7AXgHOu
 m2q0NHxJt2XfZDvsk23aGfCxMe2I1MP3qXwu+47UXQe/W0L1HLcUAaLNkprDKrsAhb
 NyURP/at/BqEOLhFqiDnZesrmXDw30I6k49hGeco=
Date: Fri, 11 Oct 2019 04:23:18 +0900
From: Keith Busch <kbusch@kernel.org>
To: Jeffrey Lien <Jeff.Lien@wdc.com>
Subject: Re: Issue With NVME CLI list Command
Message-ID: <20191010192318.GB22635@washi1.fujisawa.hgst.com>
References: <CY4PR04MB117531DFE8560BD3A72787CFEA940@CY4PR04MB1175.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CY4PR04MB117531DFE8560BD3A72787CFEA940@CY4PR04MB1175.namprd04.prod.outlook.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191010_122321_584372_C82BFE8E 
X-CRM114-Status: GOOD (  15.00  )
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
Cc: linux-nvme <linux-nvme@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, Oct 10, 2019 at 07:11:10PM +0000, Jeffrey Lien wrote:
> Keith, 
> I'm getting a "Failed to scan namespaces" error message back from the
> "nvme list" command after updating my fork and picking up your changes
> from Aug 28th.  The cause of the failure is the following check in the
> function verify_legacy_ns (in nvme-topology.c):
> 
> 	if (memcmp(id.mn, c->id.mn, sizeof(id.mn)) ||
> 	    memcmp(id.sn, c->id.mn, sizeof(id.sn)))
> 		return -ENODEV;
> 
> The problem I see is that ctrl info is never filled in (at least in my
> case).  Both c->id.mn and c->id.sn are blank.  Looking back in the
> legacy_list function, I don't see how the ctrl info is ever filled in.
> Maybe it's just something strange in my case; I would have thought
> someone would have stumbled across already but maybe not.  If I remove
> the above check; everything seems to work so I think the code is
> basically working as expected.    Could you review the changes and
> either confirm what I'm seeing or let me know if I'm missing
> something.  

Hi Jeff,

What kernel version are you using?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
