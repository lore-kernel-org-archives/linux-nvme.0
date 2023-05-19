Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1806C77B7A
	for <linux-nvme@archiver.kernel.org>; Fri, 19 May 2023 02:29:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hM01Gof5unjO+a+6cqd9FyadYlH6muys2BjhS/hZ5tU=; b=THqfheS9DAOMd0QPwbTKwECEp4
	N49o7PI2VABRjStMHjr2q4GomqTqyD6Fh0Dbk2o8AygsA89ND1eZMlj6dzsEHPswgAXaA5wMhsTvN
	Izvpr6KVqSEg55vDjlGs1RJxdUR/WKWct4YoY45KXGzUb5xgDyFPlpiN36/5DpxnlWdR/Qc6mbaXE
	y06+lOg+rdC6o2T1ymhjANFwYsUZvbBUzAio7qUCACEfQ+OgG2y8LFKnYI1dymBEAN5u6nzRUF0ol
	WTJefkJv6NV3UWIx8YeUqo8/O6p1IQiypD3D+Ydfj9eH9as3IlF8zPVlS1cbJY6tej87Q13pK4U38
	2cZH7IAg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pzpsH-00EpPq-0y;
	Fri, 19 May 2023 02:29:45 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pzpsE-00EpPH-2d
	for linux-nvme@lists.infradead.org;
	Fri, 19 May 2023 02:29:43 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 26920648EF;
	Fri, 19 May 2023 02:29:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27ED7C433D2;
	Fri, 19 May 2023 02:29:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1684463381;
	bh=1apIaiMc2Eq4gZsfeg5/mmWzgJul1KO3wUMVQ9EM9EQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uV+P/yfEnoiHCL03P8oxuF2F6Rr8hA7Fg1y3h7ooS5wrcco6UlhnXbvj8WuhdDt9t
	 O2+FuVtj2RhzHbleQ2pBGLtBVmUg6mvNKpN1M/1IcZGJ+13Q0wTisTFOG21huNRvAX
	 ACLLWnBBDZrl7Z9CjVcO83eefrMYSecI1ARzlyjRBxUa9mFmy5+QAJ/5rILY6eZ17/
	 6h4yBuBTuA4VRfMVzEjjYz/AZIHgmXqQn+4IadJEUISqGwo6/RbuTGN6FHvl62R8fL
	 2f5LKCGL0vdefZduCAd+rS2pLpBko8bM1po/Wh22M/o2BlfT0yYJwI8FAYcmqFll8m
	 tnjLnrK0HOtiA==
Date: Thu, 18 May 2023 20:29:39 -0600
From: Keith Busch <kbusch@kernel.org>
To: Irvin Cote <irvincoteg@gmail.com>
Cc: hch@lst.de, axboe@kernel.dk, sagi@grimberg.me,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH 1/1] nvme-core : remove redundant check from
 nvme_init_ns_head
Message-ID: <ZGbfE7Wsief3erBq@kbusch-mbp.dhcp.thefacebook.com>
References: <20230517220915.7244-1-irvincoteg@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230517220915.7244-1-irvincoteg@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230518_192942_913231_6D44013E 
X-CRM114-Status: GOOD (  10.93  )
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

On Wed, May 17, 2023 at 07:09:15PM -0300, Irvin Cote wrote:
> -		if (!multipath && !list_empty(&head->list)) {
> +		if (!multipath) {
>  			dev_warn(ctrl->device,
>  				"Found shared namespace %d, but multipathing not supported.\n",
>  				info->nsid);
> -- 

Thanks, applied for nvme-6.5.

Side note, the very next print says this path was to be removed by 6.0,
so we're a little late on that. Did you actually hit this condition or
found it from inspection?

