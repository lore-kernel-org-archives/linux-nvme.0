Return-Path: <SRS0=3CeD=3T=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_DBL_ABUSE_MALW,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42176C2D0DB
	for <linux-nvme@archiver.kernel.org>; Thu, 30 Jan 2020 15:00:08 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F0FA9206F0
	for <linux-nvme@archiver.kernel.org>; Thu, 30 Jan 2020 15:00:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="XEeFuhX+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0FA9206F0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=J1O1VI1D44m4Qf8BRkN+IC195Lgxd9KZAdrW0ZLAD4M=; b=XEeFuhX+Byq2LM
	o38T0+jvHQQ4H87yUBASbwNuOgpgVwBOSwfHHxUSPXVKPe/UnnUyCj94XSBHjhXLF3iXnKZZQVdRp
	fSwqckmp7T629K2FnUoxNTXkDhTBguDvkGQ/Nehu/wMgBt53SWceaoNaDJMN8iDZwwEPf9Xc/gQoX
	A5E60B90B0erQ6WO8MdQQjXBkiVq9XmkbKDy4OlEguMsu1dOysFb8Hct4f82+k3hRbtACSoJc2Sh0
	J245Kbv3bwG3tmv6rspLXAXPhBUreazkW/WNmh/dbRBh8vIzClPTkg9/Ugu7bCLzfP9lQcRZlRStq
	YdGVmjcoryKZ0IH2tqGg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1ixBIa-0005Qd-KB; Thu, 30 Jan 2020 15:00:04 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1ixBIX-0004yB-PD
 for linux-nvme@lists.infradead.org; Thu, 30 Jan 2020 15:00:03 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id EB7AD68C4E; Thu, 30 Jan 2020 15:59:59 +0100 (CET)
Date: Thu, 30 Jan 2020 15:59:59 +0100
From: Christoph Hellwig <hch@lst.de>
To: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: Re: [PATCH V3 4/4] nvmet: update AEN list and array at one place
Message-ID: <20200130145959.GB4798@lst.de>
References: <20200119212326.19701-1-chaitanya.kulkarni@wdc.com>
 <20200119212326.19701-5-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200119212326.19701-5-chaitanya.kulkarni@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200130_070001_978218_E70C4C16 
X-CRM114-Status: UNSURE (   7.44  )
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
Cc: Daniel Wagner <dwagner@suse.de>, sagi@grimberg.me,
 linux-nvme@lists.infradead.org, hch@lst.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Sun, Jan 19, 2020 at 01:23:26PM -0800, Chaitanya Kulkarni wrote:
>  	if (sq->ctrl) {

This can be ctrl.

> -		nvmet_ctrl_put(sq->ctrl);
> -		sq->ctrl = NULL; /* allows reusing the queue later */
> +		nvmet_ctrl_put(ctrl);
> +		ctrl = NULL; /* allows reusing the queue later */

This last line still needs to be sq->ctrl.  Everything else looks fine.

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
