Return-Path: <SRS0=YEyo=W5=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEA92C3A59B
	for <linux-nvme@archiver.kernel.org>; Mon,  2 Sep 2019 08:25:35 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C056B21874
	for <linux-nvme@archiver.kernel.org>; Mon,  2 Sep 2019 08:25:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ShDH7CxU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C056B21874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=u/CRuMBGYTHRiQP69jQih44NIVN5Rawkiu0/zdOiQOk=; b=ShDH7CxUcdTyQh
	yUSAyuDljvQtg2208YmWrGnwk5CtE7ZszGbpMs6flozLaK3MFR9uK03wbTTFDlSA4zLWTJxU27aDj
	3/cRbrojeoQ08xhdSpdIPzrXN9GlKLWKELdURU7YS19GZrILlCDe6PJ2Qd4PL97p2z6QGnngHz2H0
	aOpEvV22dxXEs6eFiiOaO7BBAXtyhGCOrMkADDmh6UMdaGa8CPUEOlGn4YHwIbxWzYHxeptF3CtD0
	m34WrrBw5Q0nfV/u6HYTZjxMFPpadlQUZPqBO58SFwbS2dGoLdNmZehDHlf9wQ8a7VVXxIJeTgnXA
	51B4X+Icj+MJG/NUl9qw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92 #3 (Red Hat Linux))
	id 1i4heP-0007q2-HT; Mon, 02 Sep 2019 08:25:25 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1i4heK-0007pY-TD
 for linux-nvme@lists.infradead.org; Mon, 02 Sep 2019 08:25:22 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 2D52B227A8A; Mon,  2 Sep 2019 10:25:17 +0200 (CEST)
Date: Mon, 2 Sep 2019 10:25:17 +0200
From: Christoph Hellwig <hch@lst.de>
To: Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH v10 4/7] nvme: pass status to nvme_error_status
Message-ID: <20190902082517.GA29846@lst.de>
References: <20190830191914.29713-1-sagi@grimberg.me>
 <20190830191914.29713-5-sagi@grimberg.me>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190830191914.29713-5-sagi@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190902_012521_097949_08F08E66 
X-CRM114-Status: UNSURE (   8.99  )
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
Cc: Keith Busch <keith.busch@intel.com>, James Smart <james.smart@broadcom.com>,
 Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
 Hannes Reinecke <hare@suse.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Fri, Aug 30, 2019 at 12:19:11PM -0700, Sagi Grimberg wrote:
> No need for the full blown request structure.
> 
> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
