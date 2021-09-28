Return-Path: <SRS0=nS76=OS=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E292C433F5
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Sep 2021 02:43:30 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 10FA660F58
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Sep 2021 02:43:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 10FA660F58
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=gumqsTTStX2eHz9oimk1Gt/mFXuCMP8bKgAw2CYo5zE=; b=GeXtbOSCwnkKsS
	JLL9vqheshho4ALF0UDa4N0hw/GMnzZZeKnKnti5Dv2LFn/k2hlyUozrfrCB96ZOlTMeZdjH79AO8
	7VWj5EettCqaWLBxGMqliBBg5VyVeWzniR0qe6yzs0KoOUD6D5IE5q1Bl7VEVjLW634cwS1+Gu9KY
	/yOkgr8xGLTLKPJWogLvr1NhG0z+wLmuK/PypCEagNStOOuKprp14wwipn7d4SsppIbrfJcyIbvAW
	tsIVrKPJX4V3br884ov06hvtJpf28pPgthLBJVUFJT8f2BwSnK2sB+86rf17Mz1GDx32USPy+wCPF
	ncTm7JsxJLUm7iyNLpXQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mV35N-005LNJ-Ps; Tue, 28 Sep 2021 02:43:13 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mV35K-005LMA-G2
 for linux-nvme@lists.infradead.org; Tue, 28 Sep 2021 02:43:11 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6CAC5611CA;
 Tue, 28 Sep 2021 02:43:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1632796990;
 bh=LtlTDC3PreqInxwLpDkcz4xZDswchLeYYsC/Pjk5h54=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=DSuR/anszbzUEOrdKiLRw9CCzk77chq2EpaxqkD2uRZD4D88+0yjem1BtOnKrNPtP
 NeUOtMCzWUobx7iPVJYIdL0qpQFaDOwKlM3Pdfy15QEKsHBh9E6+2N4qTa9TEGk3Os
 7ORj6x/D0aWL1ux2WGoIA6tupkj3dxtYg+iwe1sZ1H3resv3V+Ama+MFEzNXBbT/+n
 k/usedh1REBkCLXGKGhlDGIGdOaEyw8I1TUq6g+h/jx+2A2mgMj1/gUTNfl9t4Cpzd
 YK2ALgz10D3RaIZ4WGz9xn72PvC6afrKJoLNP+MrX1w5KSaSi/JTb6lBT5Y+jR26Du
 4AnFsWX8QhUJQ==
Date: Mon, 27 Sep 2021 19:43:07 -0700
From: Keith Busch <kbusch@kernel.org>
To: Steven Seungcheol Lee <sc108.lee@gmail.com>
Cc: axboe@fb.com, hch@lst.de, sagi@grimberg.me, linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme.h: expend lbaf on nvme_id_ns, lbafe on nvme_zns_id_ns
Message-ID: <20210928024307.GE387558@dhcp-10-100-145-180.wdc.com>
References: <CAGrZSEyrdJaZkHX9fPse0bv3d1x-HU7vvPQeg5JyR++_hOs8bQ@mail.gmail.com>
 <20210927200357.GA387558@dhcp-10-100-145-180.wdc.com>
 <CAGrZSEwC4zKuXf-kwZmPrb1o7iGD4mqF_8zJ8n1PQ0KcohFAzg@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAGrZSEwC4zKuXf-kwZmPrb1o7iGD4mqF_8zJ8n1PQ0KcohFAzg@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210927_194310_587468_11176142 
X-CRM114-Status: UNSURE (   7.50  )
X-CRM114-Notice: Please train this message.
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, Sep 28, 2021 at 11:19:40AM +0900, Steven Seungcheol Lee wrote:
> @Keith Busch
> As I mentioned on commit, Its already been used from kernel source.

You are introducing new things with his patch. How is the kernel already
using them before they exist?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
