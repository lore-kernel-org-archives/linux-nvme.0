Return-Path: <SRS0=x9Yf=BX=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D69B9C433E1
	for <linux-nvme@archiver.kernel.org>; Thu, 13 Aug 2020 15:36:34 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A92920781
	for <linux-nvme@archiver.kernel.org>; Thu, 13 Aug 2020 15:36:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Vnp/T+Ff";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="vbbInyWZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A92920781
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=xpekUzVBckHUrMnMEJhixQ/fVTGVmTI0TsZ288gC6Vs=; b=Vnp/T+FfFEcoRSrOJBih5mblE
	W9pZTR8adJ1JzhMVLHVR+Jzu5Fcf5R79W/WSckJhEUgD6O61vBwcyigHaHMaafCxyuqKF8CHsMWe6
	BREpZv38eQ7fH5YHtZs7D3xeqwanmwq3dZEDcasYbBcikAkdzMxrITPrm2+WHTtDmbrubi3mn5oJS
	hsaYpp80jwqLCcAB8gT5qhYpmYPH1MOWkFs10vCiB6m9APGBLGQVaMmlHlv3S/dv9g1HIFeLMfni4
	UqqFVRka2EuArL/78bcIauL1hr726Ysu+77+a/00UxCTBMaMz20DiUGyldbAkNAQ+Ex9G0zEbMJZB
	735rBA6rw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k6FHL-0008Vr-KO; Thu, 13 Aug 2020 15:36:31 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k6FHI-0008Vc-Sq
 for linux-nvme@merlin.infradead.org; Thu, 13 Aug 2020 15:36:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=oDQjo0A1m2NKqUsao7EY+EoMha8yFoI0TvAWHJCtTuI=; b=vbbInyWZ6ytMdhzbphZOiCnNYw
 yraM7LhiI+HpUqnsv/UdJTNodrKjoCwaApWggtXcOIXDsgh22CPwXRR2ZizyGovsThQA+/fAlh5uX
 jJUsHvCri/f7sO+DeUwPAFdYzn6y7AA3FwNlofLJ8XG9P4zIJTgp62cwxkHRNb2haF5FVpweQz5ZE
 GsRZdmpLvIy44TUacpckzNqpa1DeHE6fzQBNNmIIkDnPf6y1k9Jmsj6WPzTsEBg6o0EV2NdrJ6luG
 trX44cM0XzP0XxNrGPJb0v1DDPxF8xEh2l6nqYeQCpjbVpjHMLglBUj2fFVA8iS1zfXOetKte3sUQ
 dCI5esdw==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat
 Linux)) id 1k6FHD-0008KF-JH; Thu, 13 Aug 2020 15:36:23 +0000
Date: Thu, 13 Aug 2020 16:36:23 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Mike Snitzer <snitzer@redhat.com>
Subject: Re: [RESEND PATCH] nvme: explicitly use normal NVMe error handling
 when appropriate
Message-ID: <20200813153623.GA30905@infradead.org>
References: <20200806184057.GA27858@redhat.com>
 <20200806191943.GA27868@redhat.com>
 <6B826235-C504-4621-B8F7-34475B200979@netapp.com>
 <20200807000755.GA28957@redhat.com>
 <510f5aff-0437-b1ce-f7ab-c812edbea880@grimberg.me>
 <20200807045015.GA29737@redhat.com>
 <fec745aa-0091-ee1f-cb0f-da9e18cf0aa2@grimberg.me>
 <20200810143620.GA19127@redhat.com>
 <20200810172209.GA19535@redhat.com>
 <20200813144811.GA5452@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200813144811.GA5452@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
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
Cc: Sagi Grimberg <sagi@grimberg.me>, Ewan Milne <emilne@redhat.com>,
 Christoph Hellwig <hch@infradead.org>, dm-devel@redhat.com,
 linux-nvme@lists.infradead.org, Chao Leng <lengchao@huawei.com>,
 Keith Busch <kbusch@kernel.org>, "Meneghini, John" <John.Meneghini@netapp.com>,
 Hannes Reinecke <hare@suse.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, Aug 13, 2020 at 10:48:11AM -0400, Mike Snitzer wrote:
> Commit 764e9332098c0 ("nvme-multipath: do not reset on unknown
> status"), among other things, fixed NVME_SC_CMD_INTERRUPTED error
> handling by changing multipathing's nvme_failover_req() to short-circuit
> path failover and then fallback to NVMe's normal error handling (which
> takes care of NVME_SC_CMD_INTERRUPTED).
> 
> This detour through native NVMe multipathing code is unwelcome because
> it prevents NVMe core from handling NVME_SC_CMD_INTERRUPTED independent
> of any multipathing concerns.
> 
> Introduce nvme_status_needs_local_error_handling() to prioritize
> non-failover retry, when appropriate, in terms of normal NVMe error
> handling.  nvme_status_needs_local_error_handling() will naturely evolve
> to include handling of any other errors that normal error handling must
> be used for.
> 
> nvme_failover_req()'s ability to fallback to normal NVMe error handling
> has been preserved because it may be useful for future NVME_SC that
> nvme_status_needs_local_error_handling() hasn't been trained for yet.
> 
> Signed-off-by: Mike Snitzer <snitzer@redhat.com>

I don't see how this would change anything.  nvme_failover_req simply
retuns false for NVME_SC_CMD_INTERRUPTED, so your change is a no-op.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
