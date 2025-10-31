Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9465BCCF9FA
	for <linux-nvme@archiver.kernel.org>; Fri, 31 Oct 2025 02:54:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DgaHiyKRdYU74VsMGhz5XY8gecCA7Rt5sxTvv8wAZpM=; b=ojwyBJGPl5i9ZlkfdZ32ALNNkt
	JQ8+CEsS+ECyNgngjL2aMpojbcZmNky/JeJ9ErTgtxhkh1A1XLWDW2f7s0rou+O+MaR7koeN26Q5j
	OfX/fOTuI4TPrEKJuYBQ0da/Py6QwW0UA5Pco29uB+/W73LFesMUzo6Qu2HHBhuMVxFpQlk0a+XgA
	X4G6mSj7OarGAARO4gJRp3u4ehT11y6y7DFir9H4ANKHi9lqZ1qtm4UxdmqBIc+ucNCyioAD0seYk
	CbBdirQs7M+SwmkCB+NhkWdLDPit/7SkLU/qb3wItvRv/Iue/+YapdnY4Z6Bh/uf/pjDwAt7DlOAs
	brcl7Hrw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vEfHk-00000005Hvk-0WWd;
	Fri, 31 Oct 2025 02:54:40 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vEfHh-00000005HvF-3vO1
	for linux-nvme@lists.infradead.org;
	Fri, 31 Oct 2025 02:54:39 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 7E72643FAC;
	Fri, 31 Oct 2025 02:54:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0C34C113D0;
	Fri, 31 Oct 2025 02:54:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761879276;
	bh=DgaHiyKRdYU74VsMGhz5XY8gecCA7Rt5sxTvv8wAZpM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=grr5rAdYEq7b6KZM9PFaJcgYOZ+IQyOBEI1Uu3q6h/YKGKsK/aLDVvMykktf3vbwb
	 EgEk6k+kmEMc8ul3gaaH7FceRJHsHdkB6cHhLT1BiNbBLpRrab+vvk+PjyUf1836ce
	 9Pxn5V3cMnFKhIM9Smn7iLvrLahJ7XeFNZ0F8SroqeEtrxs6gBkX9RdlhoexsRRvnQ
	 cWZSTYIVp7D9IL69d4J8vEWSe1+vMW7fJqwg6vt9GKjF4ut8DUx637TLDXYUcBI2AS
	 QlGE0w8jugpwW1chVfJkKw5lDjgP20jo9y788DY0lfZP3LjPbYVysECnAETQTNzkWh
	 duqchz5rx1JFg==
Date: Thu, 30 Oct 2025 20:54:34 -0600
From: Keith Busch <kbusch@kernel.org>
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: Casey Chen <cachen@purestorage.com>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"yzhong@purestorage.com" <yzhong@purestorage.com>,
	"sconnor@purestorage.com" <sconnor@purestorage.com>,
	"axboe@kernel.dk" <axboe@kernel.dk>,
	"mkhalfella@purestorage.com" <mkhalfella@purestorage.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: Re: [PATCH 1/1] nvme: fix use-after-free of admin queue via stale
 pointer
Message-ID: <aQQk6nWYeB71PBK_@kbusch-mbp>
References: <20251029210853.20768-1-cachen@purestorage.com>
 <20251029210853.20768-2-cachen@purestorage.com>
 <aQKzxpJp98Po_pch@kbusch-mbp>
 <9669f8a9-11ad-4911-9e03-00758e1d9957@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9669f8a9-11ad-4911-9e03-00758e1d9957@nvidia.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251030_195438_377726_CA1ED2A4 
X-CRM114-Status: UNSURE (   6.32  )
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, Oct 30, 2025 at 08:12:53AM +0000, Chaitanya Kulkarni wrote:
> On 10/29/25 17:39, Keith Busch wrote:
> I've added required comments that are very much needed here,
> totally untested :-

Honestly that seems a bit verbose. The code mostly speaks for itself
with this move: the controller's request_queue reference remains active
as long as there's an active controller reference.

