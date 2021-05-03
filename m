Return-Path: <SRS0=U7R3=J6=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B20ADC433B4
	for <linux-nvme@archiver.kernel.org>; Mon,  3 May 2021 20:26:11 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E925E611CB
	for <linux-nvme@archiver.kernel.org>; Mon,  3 May 2021 20:26:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E925E611CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=B5Q+EFwDg1i06sQ0pmQwW3GRxIApqy0BMjO64AqTzRw=; b=Tb+6GWTDnV51li1lQjMzQfy1R
	DF/tNKtbFVPTFpiGgaXMpMFvCSGZc/M2BD4j8S+mwpXm2k6ghW7hpogpKfGdrpLNop9OO0f/SojKR
	NpwUL0PIZuNY1/iyPXG4PSH1lOxcLWufWONNg26wZxDBL+ep7f7x16r8uQRGAKZwrHxfSZeE92Bjr
	Vtc7bkKJraOP5ojwSgjtjmTuhvhKEWvs4N7hKDibjqPaSyI2Q+9QPJq+UArdh187IRolCxKZp6tNT
	w8a4Dl9hf3nOeYwJRuQpQfvAjTtBff1q3/4c880Pxg1+tB0JKyetG18aIBp/9Ref/PUdiAte/rtnn
	5Bjy7nNpA==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1ldf8b-00EoAU-EF; Mon, 03 May 2021 20:25:53 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1ldf8Z-00EoAK-Im
 for linux-nvme@desiato.infradead.org; Mon, 03 May 2021 20:25:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=E+16CdGjdNE4vxbFovPFg/6nMkOwg2LVFJVdDs3aI40=; b=hJ6krmPesb3EKdYAPQIKxkVULh
 Qa9rbwARWnA+D3SdQX5AqpYrpq7f7ZlQlcqBcBssnJJVLFJ4tOCIMVU2VUr5oP5yuMF0KpDK8sxk4
 ZlHvaedoSZ4+E6luz27ZYvnzxzQvXnDd1ZysvmJKyh/xvdv9wS9iwKf9JTZDMKmshuCpcRSflrHJq
 di4dsue7zFu4EC+LmsCuGjUVoIg4ISScVaFqoNILbQTw3MjH1ScVCuG/QHiBJ08vYojFlzwqmK8bn
 xAVXoH0FwjvqK9pJxNrzsqKIKBiN4qUB428Go1//iEqUGhaEvyNBxFb1k0+KNj4Mmmz4PBdc7uq/T
 J8wUOqrg==;
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1ldf8W-003Sma-Ut
 for linux-nvme@lists.infradead.org; Mon, 03 May 2021 20:25:50 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0C27E611C0;
 Mon,  3 May 2021 20:25:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1620073548;
 bh=MOSFAIdZqNleM+KUNalYW0ckTNUPaXUwjVJL8VZ4oAE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=WMVl2ModaDkjzeYhLNKmrILCSZIEB0PXwbnufPDziSa7nD1o72qb2w3XvUf9ojVXJ
 enpAtvvEkMyHzkaVNv8WZNYLTT23Nv+BYqhdweLUxrEp4TEDW+B1y6xk2HuUJJlhk2
 SX8Y0kCQOsG9JltA+VHsoY/U+I8U6ab0h0MiJOpW19jiL7jer25lf8uN+/37p0h8on
 3U7S/V3qzsKE5k/dofMBgF9IPdOkGrO20oJgD/tCgXkH+5mbHsm+yBLCtEkaifF41U
 i7UB/5CvpYSMAQr6aThKPl5+YcZFwY/LLp57a/aU1XH1kHZQtfucHYXr11igZcBCgF
 sGt9iukNYek7w==
Date: Mon, 3 May 2021 13:25:45 -0700
From: Keith Busch <kbusch@kernel.org>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org, hch@lst.de
Subject: Re: nvme tcp receive errors
Message-ID: <20210503202545.GB910455@dhcp-10-100-145-180.wdc.com>
References: <20210427233956.GA631292@dhcp-10-100-145-180.wdc.com>
 <549e4f57-5f6e-d5ed-db63-8f82e9a7490a@grimberg.me>
 <20210428155847.GA21854@redsun51.ssa.fujisawa.hgst.com>
 <00a3b480-2885-b32b-139a-ef68ff21bad5@grimberg.me>
 <20210428180147.GB21854@redsun51.ssa.fujisawa.hgst.com>
 <500074cf-c0e8-807b-5b30-a3474d37700f@grimberg.me>
 <20210429033328.GC24074@redsun51.ssa.fujisawa.hgst.com>
 <bd3c39f9-3768-7494-e63b-7baf9ad9b615@grimberg.me>
 <20210503185121.GD910137@dhcp-10-100-145-180.wdc.com>
 <96afc178-f5db-dd56-59a6-467e032c619a@grimberg.me>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <96afc178-f5db-dd56-59a6-467e032c619a@grimberg.me>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210503_132549_105186_EF7894B4 
X-CRM114-Status: GOOD (  27.74  )
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

On Mon, May 03, 2021 at 12:58:23PM -0700, Sagi Grimberg wrote:
> 
> > > > The driver tracepoints captured millions of IO's where everything
> > > > happened as expected, so I really think something got confused and
> > > > mucked with the wrong request. I've added more trace points to increase
> > > > visibility because I frankly didn't find how that could happen just from
> > > > code inspection. We will also incorporate your patch below for the next
> > > > recreate.
> > > 
> > > Keith, does the issue still happen with eliminating the network send
> > > from .queue_rq() ?
> > 
> > This patch is successful at resolving the observed r2t issues after the
> > weekend test run, which is much longer than it could have run
> > previously. I'm happy we're narrowing this down, but I'm not seeing how
> > this addresses the problem. It looks like the mutex single threads the
> > critical parts, but maybe I'm missing something. Any ideas?
> 
> Not yet, but note that the send part is mutually exclusive but the
> receive context is where we handle the r2t, validate length/offset
> and (re)queue the request for sending a h2cdata pdu back to the
> controller.
>
> The network send was an optimization for latency, and then I modified
> the queueing in the driver such that a request would first go to llist
> and then the sending context (either io_work or .queue_rq) would reap it
> to a local send_list. This helps the driver get better understanding of
> what is inflight such that it better set network msg flags for EOR/MORE.
> 
> My assumption is that maybe somehow we send the the initial command
> pdu to the controller from queue_rq, receive the r2t back before the
> .queue_rq context has completed and something may not be coherent.

Interesting. The network traces look correct, so my thoughts jumped to
possibly incorrect usage of PCIe relaxed ordering, but that appears to
be disabled.. I'll keep looking for other possibilities.

> Side question, are you running with a fully preemptible kernel? or
> less NVMe queues than cpus?

Voluntary preempt. This test is using the kernel config from Ubuntu
20.04.

There are 16 CPUs in this set up with just 7 IO queues.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
