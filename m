Return-Path: <SRS0=ZIaN=KN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FF8CC433ED
	for <linux-nvme@archiver.kernel.org>; Tue, 18 May 2021 14:39:17 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C0E861006
	for <linux-nvme@archiver.kernel.org>; Tue, 18 May 2021 14:39:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C0E861006
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=GKdsMXi7qhElOQ/HezFkyGiUGb6PYaPK5YyfGbjPxkw=; b=d8GmoS6hJEsIK/7VJ9igOcpiS
	VYP39d9znvtmKZdKpkygp0tOghx7rIqYsXrh2CpoYGtO4CCR9t7VmFKG9xmB1Wy+S6cHJG7Jl2Y38
	dL3a811ADmMhb9Vz+3yUt+fggWXxTCxdgfaKeBAioaZLgAMXgwCtkl0BgjxMMNcaEQAe3RoGfNRcm
	aZ6+4gKWDmbT3RK2J/xJStvxgVrqeT4XOwARVCksWkX+Ydlvn+PTBcipp5BbU+yLLxViGVT9gJpZL
	FZGGgTkS762CKMV/CHmQgQ9FrwO0731exXxtmJrqzl60VVm66XVo6FiMdcdGU72NJzINye3moBIub
	Xtg5069dw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lj0ra-0014SR-Dr; Tue, 18 May 2021 14:38:26 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lj0rX-0014Rt-1Z
 for linux-nvme@desiato.infradead.org; Tue, 18 May 2021 14:38:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=XrAocr4bG6cLH2c2e81Es/x0nrAhiT3TYZt81kl+bOE=; b=16W7qc26UObHyFIQ9EIVL0tLxC
 8i0VHeZJt06B73wvzNwvcS8LJAOtX2HcYwODqud0pfyNZG4Msk3xo6xU8Z6IXWZaBDjs2fsmKBecJ
 YfjTamiLqq6hLN9NgRw2/TFMLv2BIXImuL23euWH/EavdNwk4cDbWNV80NowwillPK5fyDGiLDFy2
 ZSrCQCXnLLAZR2qybH+vSK/sMKh6lF8sprTMKe3MrlodoEK1F96HnYwHLnE62xgFzUBrbTfFAwqL8
 0spHm02cRYMHDfNP+ar3sak/VesAQKF8iZOa2xCBEynmi2LMP5awQwmqpIUEF28uQY1JLBbhyni+e
 48C8WeXw==;
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lj0rU-00Ejes-FA
 for linux-nvme@lists.infradead.org; Tue, 18 May 2021 14:38:21 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 98CDC6124C;
 Tue, 18 May 2021 14:38:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1621348700;
 bh=tonjLRl3Cv+4TlKSmwmXJv/OcpLkLBcg+zb3acV6pUc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=eae1d5tpHS8u1ah57hPGfdcfzxbAU6pbvEcAgl5EpBsRK+4OOgR6S4Qu0ijRnzXEb
 uesM9wIgy8E1iLdJot3ZbbSTrc3z97mbeA9aJ7faxQ8MZH2en79VKqLKJit016T+gY
 Q8FD3KV8Uu/kp/wTiLxF9Xw2lUVcaIouA4VHNk39C2JHFdJwxRQlLGqcUM5CK4GrhK
 Nsk4JUHl9GKe8OJlHcepYU5HCGeq1JUAv3pACz761faAX3hlJYHVyQLzzM+jxyQ6+s
 ebOmOKpDZfFkdozFN/ZvmKjdpxiLgZduEaiG2jVmcHH2EPkTV9BhNHUtiWrNjHyqY7
 E/62BdNNT0TJg==
Date: Tue, 18 May 2021 07:38:17 -0700
From: Keith Busch <kbusch@kernel.org>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org, hch@lst.de
Subject: Re: [RFC PATCH] nvme-tcp: rerun io_work if req_list is not empty
Message-ID: <20210518143817.GD2709569@dhcp-10-100-145-180.wdc.com>
References: <20210517223643.2934196-1-kbusch@kernel.org>
 <2479237f-ed41-6de0-6ffc-bed66046b2c2@grimberg.me>
 <20210518013804.GC2709569@dhcp-10-100-145-180.wdc.com>
 <11e1733a-24d3-72c2-1ece-4f9d1a8fade1@grimberg.me>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <11e1733a-24d3-72c2-1ece-4f9d1a8fade1@grimberg.me>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210518_073820_547779_0BA6D6E6 
X-CRM114-Status: GOOD (  25.74  )
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

On Mon, May 17, 2021 at 08:02:41PM -0700, Sagi Grimberg wrote:
> > nvme_tcp_send_all() breaks out of the loop if nvme_tcp_fetch_request()
> > returns NULL. If that happens just before io_work calls
> > nvme_tcp_handle_r2t() to enqueue the H2C request, nvme_tcp_send_all()
> > will not see that request, but send_mutex is still held. We're counting
> > on io_work to run again to handle sending the H2C data in that case.
> > Unlikely as it sounds, if the same nvme_tcp_send_all() context is still
> > holding the send_mutex when io_work gets back to trying to take it, how
> > will the data get sent?
> 
> Yes you are correct, overlooked this race. I guess this is all coming
> from having less queues than cores (where rx really competes with tx)
> which is not as common as a non default.
> 
> This is enough to convince me that this is needed:
> Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

Great! I thought the scenario seemed possible, but wasn't completely
sure, so thank you for confirming.

Christoph, can we pick this up for the next rc? For stable, we can add

Fixes: db5ad6b7f8cdd ("nvme-tcp: try to send request in queue_rq context")
 
> > > Can we maybe try to catch if that is the case?
> > 
> > Do you have a better idea on how we can catch this? I think there was
> > only one occurance of this sighting so far, and it looks like it took a
> > long time to encounter it, but we will try again if you have a proposal.
> 
> We can continue to test with the patch and hunt for another occurance,
> given the argument above, this patch is needed regardless...

Sounds good, we'll run with the patch and see what happens. If the tests
are successful, I'm not sure if we can conclude this definitely fixes
the timeout or if we just got lucky. If a timeout is observed, though, I
will try to work in a debug patch.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
