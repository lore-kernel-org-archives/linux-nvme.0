Return-Path: <SRS0=8iPx=CM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CF26C433E9
	for <linux-nvme@archiver.kernel.org>; Thu,  3 Sep 2020 16:18:12 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3ADD120775
	for <linux-nvme@archiver.kernel.org>; Thu,  3 Sep 2020 16:18:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="oFH1slSE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3ADD120775
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=tnSwpCrzsJyH3jCF9I/e/PoO2a3R6I1o5kue4f0NNWo=; b=oFH1slSEpNH3bkyGeUhoLmpPU
	TYxNRxM15qrqjCWcmnJR5Ril02zEdrIiOfH+AQDwGax13135oxsTLzM23Ewy+7Pb7j407wLjrVZsg
	uNlNB94G6iNU7dcS96Thua/VkosAphuFnzLpbdnJhJTptlfYiqd86rPAyt5EwHagOQ/G2qfLe+uEk
	YvhtGa8sxYyct0HG6pL6lfHc53jCveRSyH7C5RpqgYB3PlhfOgIHWiVMCKsYlYloN9CUWcW3hGvVS
	tpZKG+Ph3T9vRdwvt5Jfm9BXSwk5CEDFecluhTpd4y7xhcRbw/4OztrclXE1x0J/AGKes5NOphyfU
	Mt6n39Hvg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kDrwA-00068J-6y; Thu, 03 Sep 2020 16:18:10 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kDrw7-00067g-BR
 for linux-nvme@lists.infradead.org; Thu, 03 Sep 2020 16:18:07 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id BA58E67357; Thu,  3 Sep 2020 18:18:05 +0200 (CEST)
Date: Thu, 3 Sep 2020 18:18:05 +0200
From: Christoph Hellwig <hch@lst.de>
To: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: Re: [PATCH V2 02/12] nvmet: for pt I/O commands use likely for ns
 check
Message-ID: <20200903161805.GB25423@lst.de>
References: <20200831222707.35611-1-chaitanya.kulkarni@wdc.com>
 <20200831222707.35611-3-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200831222707.35611-3-chaitanya.kulkarni@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200903_121807_496136_43992203 
X-CRM114-Status: GOOD (  10.36  )
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
Cc: kbusch@kernel.org, logang@deltatee.com, hch@lst.de,
 linux-nvme@lists.infradead.org, sagi@grimberg.me
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Mon, Aug 31, 2020 at 03:26:57PM -0700, Chaitanya Kulkarni wrote:
> I/O commands (nvme_cmd_read, nvme_cmd_write) are most common commands
> when accessing passthru controller. Since for I/O commands ns is always
> present and the condition is marked as likely. Annotate post request
> submission ns check with likely which is dependent on earlier the ns
> check likely condition.

This really seems like weird over-optimization.  Any sensible branch
predictor should be able to find this out by itself.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
