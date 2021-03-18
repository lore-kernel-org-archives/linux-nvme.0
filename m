Return-Path: <SRS0=ZogQ=IQ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB029C433E0
	for <linux-nvme@archiver.kernel.org>; Thu, 18 Mar 2021 05:48:35 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 638EE64F0C
	for <linux-nvme@archiver.kernel.org>; Thu, 18 Mar 2021 05:48:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 638EE64F0C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=gVw1Yjf3ciFvOJQ+ZxWF0U/4JPibpk6w/sPQi9JMt0Y=; b=jiXofO+zDozmQnFsVUIyfD77Z
	p21qyDGNp5qLKoVCdAB6XhbdUgKzNRSAJSSMJsHj8ZEB9wwP4GqlskKEhoq5uTSy1huwd0N+PZGtr
	I4muqGrVJMCMcy8ZojGN8XiXbqviTo/oHH/IzlBUYu8uBrUdYQXcgen7chqh3tn9YSG8/Y6jovvUT
	VxWjYvNJNowXQ2q6CmiZdZuOqPmb15aL6UqfT34p5JQA38xoXGamRQ5VvmBrFwL2nnWYnpcUWnaTD
	hJ+1AFouOWlt+8yDeMIgLxnH14YsnlA0S/p8lBuT8SMmeoedisblQ9bTAxFsY/CtJt3K3R7YlEs9I
	wU+ypbwjQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lMlW2-004YUP-J1; Thu, 18 Mar 2021 05:48:14 +0000
Received: from verein.lst.de ([213.95.11.211])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lMlVx-004YTh-BJ
 for linux-nvme@lists.infradead.org; Thu, 18 Mar 2021 05:48:11 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 6B9C668C65; Thu, 18 Mar 2021 06:48:07 +0100 (CET)
Date: Thu, 18 Mar 2021 06:48:07 +0100
From: Christoph Hellwig <hch@lst.de>
To: Kanchan Joshi <joshiiitr@gmail.com>
Cc: Jens Axboe <axboe@kernel.dk>, Kanchan Joshi <joshi.k@samsung.com>,
 Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
 io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
 anuj20.g@samsung.com, Javier Gonzalez <javier.gonz@samsung.com>,
 Nitesh Shetty <nj.shetty@samsung.com>,
 Selvakumar S <selvakuma.s1@samsung.com>
Subject: Re: [RFC PATCH v3 1/3] io_uring: add helper for uring_cmd
 completion in submitter-task
Message-ID: <20210318054807.GA28576@lst.de>
References: <20210316140126.24900-1-joshi.k@samsung.com>
 <CGME20210316140233epcas5p372405e7cb302c61dba5e1094fa796513@epcas5p3.samsung.com>
 <20210316140126.24900-2-joshi.k@samsung.com>
 <05a91368-1ba8-8583-d2ab-8db70b92df76@kernel.dk>
 <CA+1E3r+Mt7KKeFeYf7WY3CoKwnkXT-jE2EgJSTE6zaAfJX0dzQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CA+1E3r+Mt7KKeFeYf7WY3CoKwnkXT-jE2EgJSTE6zaAfJX0dzQ@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210318_054809_569077_EE136563 
X-CRM114-Status: GOOD (  18.33  )
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

On Thu, Mar 18, 2021 at 10:55:55AM +0530, Kanchan Joshi wrote:
> I started with that, but the problem was implementing the driver callback .
> The callbacks receive only one argument which is "struct callback_head
> *", and the driver needs to extract "io_uring_cmd *" out of it.
> This part -
> +static void uring_cmd_work(struct callback_head *cb)
> +{
> +     struct io_kiocb *req = container_of(cb, struct io_kiocb, task_work);
> +     struct io_uring_cmd *cmd = &req->uring_cmd;
> 
> If the callback has to move to the driver (nvme), the driver needs
> visibility to "struct io_kiocb" which is uring-local.
> Do you see a better way to handle this?

Can't you just add a helper in io_uring.c that does something like this:

struct io_uring_cmd *callback_to_io_uring_cmd(struct callback_head *cb)
{
	return &container_of(cb, struct io_kiocb, task_work)->uring_cmd;
}
EXPORT_SYMBOL_GPL(callback_to_io_uring_cmd);

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
