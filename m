Return-Path: <SRS0=ZUg+=YX=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5229CCA9EAE
	for <linux-nvme@archiver.kernel.org>; Wed, 30 Oct 2019 00:46:22 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1227620862
	for <linux-nvme@archiver.kernel.org>; Wed, 30 Oct 2019 00:46:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="IF/40Oxv";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="0mkvNHFu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1227620862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=wTnUGFj44B/Fqeouxje/XDL/dZws4NTOa6iGVAq1fVA=; b=IF/40OxvWGvj8T
	rltRnWptFWlGTrsPuIsOUfNR02On/HwGE3rqct6BlmQ9PpY11e0ghXVwj7dNuL1NlpKV44hCIsnzu
	oseaQj+nGK8qG+T3MUz7sBW0TLq97JBAfxjU1uzg2zKBGyYeVfsWPQnVx/8/8tFS3FyHymxbwwx0e
	al5C4Yre5u0aiMlA2/Nqpl62WVpj5WnngIt38Tg8qNKaSPZ3FmozwLE9h0bbDidEVRwbZDvGZtVvD
	worR3TKirS5rJjFPVcGk/U2Chw6HWrkNwJvTXJ6ib/Yg+Kwu08AWbvILA37+1RXp0Nzsd6/BF/GrM
	4rQiFYaKiC9Hc6ZX1XZw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iPc7s-0005MZ-LL; Wed, 30 Oct 2019 00:46:16 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iPc7p-0005ME-6u
 for linux-nvme@lists.infradead.org; Wed, 30 Oct 2019 00:46:14 +0000
Received: from redsun51.ssa.fujisawa.hgst.com (unknown [199.255.47.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 1512820862;
 Wed, 30 Oct 2019 00:46:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1572396372;
 bh=7XnGcMly4H4r86iV4yPtrefx2MJBReOWzxLcZQb+qLs=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=0mkvNHFudXsjSsDwXa5mKzL9ykB0R8fNNI3epi9uSvkNA3lnnZX+31G+83eQarzBd
 tdjtareRyeHFY7odTDx9xf7hv1OUmo8hM7EsRqcLEu3hvM0UE+rVv5vwU1DH71hLF+
 a0xH/ElyMhj4Ys9mJhkdSQYcvGoviHuWVtw949As=
Date: Wed, 30 Oct 2019 09:46:09 +0900
From: Keith Busch <kbusch@kernel.org>
To: Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH] nvme: Fix parsing of ANA log page
Message-ID: <20191030004609.GA15332@redsun51.ssa.fujisawa.hgst.com>
References: <1572303408-37913-1-git-send-email-psajeepa@purestorage.com>
 <8972928e-9382-3a25-5c53-918eb0a9fe14@grimberg.me>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <8972928e-9382-3a25-5c53-918eb0a9fe14@grimberg.me>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191029_174613_274651_07AADD46 
X-CRM114-Status: UNSURE (   7.26  )
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
Cc: axboe@fb.com, Prabhath Sajeepa <psajeepa@purestorage.com>, hch@lst.de,
 linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Thanks, applied to nvme-5.4. This is a new branch that was force pushed
to replace the previously defunct one with the same name.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
