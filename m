Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A6A2C433EF
	for <linux-nvme@archiver.kernel.org>; Tue,  1 Feb 2022 13:58:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lqVMey1PVda4F9/a9N7FseBE1S+PvPNiUIaEBo7epRo=; b=VJiJDIp1wlyxBFfbX4MHAa2BJH
	pKrpN7bskwxF2gtbtBWqZsnRebhFKKhIk2/MwZIzqT3Q3qN36DkvNQif9hSeG9eUoIwt3r3jhIn4o
	Nf0XsRlhYifgVVmbXPeiWU/Ad1lfzwGIUKYRylNQpo8o5egUtZk8prA47qccTMh8dGjh2nq4wk8L1
	W2Vb4VRcM12w0aMQARYZ2NlyjJNqltT3SS/4U/eaZ+nDCBgCxRyY82rX24RG1KndBLnqtV2sBH4Dl
	haXNVXCAo/A+m4vOk+r2nIQ7MJ2xvWT2iQ+Dyk/qfNHS5b6TPgE/jqONKCeo/3CXAVQx7ZhmvBOW2
	wTq8mvYA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nEtgJ-00CNaj-3U; Tue, 01 Feb 2022 13:58:51 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nEtgF-00CNZQ-EI
 for linux-nvme@lists.infradead.org; Tue, 01 Feb 2022 13:58:49 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id BDEDF67373; Tue,  1 Feb 2022 14:58:41 +0100 (CET)
Date: Tue, 1 Feb 2022 14:58:41 +0100
From: Christoph Hellwig <hch@lst.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
 Keith Busch <kbusch@kernel.org>, Chris Leech <cleech@redhat.com>
Subject: Re: [PATCH 1/4] nvme-tcp: fix a possible use-after-free in
 controller reset during load
Message-ID: <20220201135841.GA2518@lst.de>
References: <20220130092119.595854-1-sagi@grimberg.me>
 <20220130092119.595854-2-sagi@grimberg.me> <20220201080335.GB29518@lst.de>
 <654808ec-81e9-0205-779b-7502ee6c5b0a@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <654808ec-81e9-0205-779b-7502ee6c5b0a@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220201_055847_663185_93CA77D5 
X-CRM114-Status: GOOD (  16.21  )
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

On Tue, Feb 01, 2022 at 02:36:03PM +0200, Sagi Grimberg wrote:
> The driver will make sure to flush ctrl->async_event_work _after_
> changing the controller state (it is flushed in nvme_stop_ctrl).
> Only after that it will continue to free the admin queue. So if
> this check passed, it is safe to submit the aer command.
>
> I think that the ctrl->state check should be sufficient. In fact, I
> think we can move it to the core instead of doing it in the drivers:

Maybe through in a comment explaining this?  Otherwise having less
checks and having them in the core is always a good thing, so I'm
in favour.

