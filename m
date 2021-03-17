Return-Path: <SRS0=uaVC=IP=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8137CC433E0
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Mar 2021 14:07:23 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EDDD064F5E
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Mar 2021 14:07:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDDD064F5E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=KygqTE74+rTlJclER6TfFgtlrxzMwPSgqu7deVlRtHI=; b=l5YVs5i3AiNDzfEgTV+eFo+D4
	Kqt4bef/fyBrt46AsECjo2Gb9f8sE1PThHC/K9VnSw4oK1wxGzkCGXJblGaZTgaLImZuj2n1HRZY5
	ZcNA0r8BEXT8PE54HnQnwRmx7veq4N3zkdPlo/wMDFu8tFmakwwkTUldM9S80i1faxtbyHC7kE7hc
	2gRBUZSNarNjLE7nGXADivThqpg9RsMAqC5dFa5K7pByGw8QF/XSCs+UsfJBpef4ASRy9ovFGfTNQ
	0gQoacOWyAOyMikii/5Euccp4PNTUKQttX240dWBjkD2JZNQZU+nAoxXuaoXhjY3PlCM+GUiblfnf
	RlHteATKA==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lMWpJ-003DdL-BA; Wed, 17 Mar 2021 14:07:09 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lMWpB-003Dco-Nz
 for linux-nvme@lists.infradead.org; Wed, 17 Mar 2021 14:07:03 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7446D64F6A;
 Wed, 17 Mar 2021 14:06:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1615990020;
 bh=3/WZ60pVg8JKdytjs2UEJTq3mAGPkzsrSIxNuSEeItI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=KcGF8Qr5Pf9Ejbdgm4Y+rb5hfYGLSPmaM61Wm30ZTv503I6YfpDROquJURWEzeo9t
 uaRIhQUn1kpvJqKPjVldXdg0n+1p3PugNp45BwaH8uMSA1ZThEBilcq+g1e76YD07K
 Fc0VaFvlVaM3xWFQBpJL7wVF6IDB/qTTUhh7RitnUhXEYwrDADs3Tj8VMtkmirr9k5
 EA0wza2U20HUcOe2I/jcwH/xhSbOU9+S7IGEg/lyXxoHAMuqVT4KNiphz1RQtoKhDQ
 Wp3dicSJ8TQ/B2pQd/5pL9xhyOskGnKatm7tQ2/UK0tH4Fy8hY8dl+wNyNMJj2MPDW
 b7TERsclyOOaw==
Date: Wed, 17 Mar 2021 23:06:53 +0900
From: Keith Busch <kbusch@kernel.org>
To: Kanchan Joshi <joshiiitr@gmail.com>
Cc: linux-nvme@lists.infradead.org, Sagi Grimberg <sagi@grimberg.me>,
 Christoph Hellwig <hch@lst.de>, Kanchan Joshi <joshi.k@samsung.com>
Subject: Re: [PATCH 2/2] nvme: use driver pdu command for passthrough
Message-ID: <20210317140653.GA26641@redsun51.ssa.fujisawa.hgst.com>
References: <20210316170632.4161183-1-kbusch@kernel.org>
 <20210316170632.4161183-2-kbusch@kernel.org>
 <CA+1E3rKQ-275KmsUNC1d9XP1rK6uVHWKmptj7Hkb2BVeqZJqag@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CA+1E3rKQ-275KmsUNC1d9XP1rK6uVHWKmptj7Hkb2BVeqZJqag@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210317_140701_984890_0D199C6F 
X-CRM114-Status: GOOD (  11.03  )
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

On Wed, Mar 17, 2021 at 03:16:59PM +0530, Kanchan Joshi wrote:
> On Tue, Mar 16, 2021 at 10:48 PM Keith Busch <kbusch@kernel.org> wrote:
> > @@ -595,7 +598,7 @@ static inline void nvme_init_request(struct request *req,
> >
> >         req->cmd_flags |= REQ_FAILFAST_DRIVER;
> >         nvme_clear_nvme_request(req);
> > -       nvme_req(req)->cmd = cmd;
> > +       memcpy(nvme_req(req)->cmd, cmd, sizeof(*cmd));
> >  }
> I am wondering if this memcpy() is fine. The "nvme_req(req)->cmd" is a
> pointer which may not have storage assigned to it?

The nvme drivers set it via blk_mq_op's .init_request(). This happens
before the request_queue is initialized, so the command pointer should
always be initialized before execution can reach this part of the code.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
