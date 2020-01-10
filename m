Return-Path: <SRS0=/IAj=27=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A7E4C282DD
	for <linux-nvme@archiver.kernel.org>; Fri, 10 Jan 2020 16:31:49 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E0B6E2084D
	for <linux-nvme@archiver.kernel.org>; Fri, 10 Jan 2020 16:31:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="MAia3Riy";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="IrbMpNEO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0B6E2084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=7by8VpFHWZavwp0x5wf1fH9pbjl9C/Hh2Cihq0YUZ84=; b=MAia3RiyNcp3LW
	4T4UOoqsPj1dxbQW7iqspqpEt8F6X6bfDIN1/VMC1irhAdCiLgDX9nekxYPFD+OLu9ZbcgkbFUtjd
	bJjJZjbIhwIAw65sSPyL6TstaBRIea6g1cySrYqxbwEv8RoY0w/oZ6/pFDTAtcWubFchf9s6jQotQ
	1xxetESES0WbWiPo/Dyq1IwR76xCHEDLhEY3TrQskpbiXXsGt32NiWQ55Yu+Vzw18lJCOEXhjTMVC
	w4fkKqXVan2ifIOGw8pghdPX7eXqPpCF9KeX3OcU8dv9Zu54NrdQyXloHn1bUZ+Z4VEUMYsZjKZAS
	rPPvIVGD8zW3e2v3KZCw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1ipxCM-0002kp-1V; Fri, 10 Jan 2020 16:31:46 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1ipxCJ-0002kE-D4
 for linux-nvme@lists.infradead.org; Fri, 10 Jan 2020 16:31:44 +0000
Received: from redsun51.ssa.fujisawa.hgst.com (unknown [199.255.47.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 65178205F4;
 Fri, 10 Jan 2020 16:31:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1578673902;
 bh=Rrk4n1nHKqxj+BZCcSgnpXUKkWUtPTA1mv68Gy7dZO0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=IrbMpNEO3empPNaJOZ9/BBjsosxffjbyeTmhwaC5ygwe1vlJhhVWfAh0XUUOmOySF
 nPLJuu4WDpKEvLXufBqY1wH+gLdayWRrZ2S6z2KwnwLWQ/Z/yLjN7KIp/aLEd+Sx26
 dThCEIS9BeCJC1ZHLa2ixTdNyl1x5Tb/XyRM+3G0=
Date: Sat, 11 Jan 2020 01:31:34 +0900
From: Keith Busch <kbusch@kernel.org>
To: Amol Grover <frextrite@gmail.com>
Subject: Re: [PATCH] drivers: nvme: target: core: Pass lockdep expression to
 RCU lists
Message-ID: <20200110163134.GA18579@redsun51.ssa.fujisawa.hgst.com>
References: <20200110132356.27110-1-frextrite@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200110132356.27110-1-frextrite@gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200110_083143_460004_F8439B61 
X-CRM114-Status: UNSURE (   9.31  )
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
Cc: Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
 "Paul E . McKenney" <paulmck@kernel.org>, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, Joel Fernandes <joel@joelfernandes.org>,
 linux-kernel-mentees@lists.linuxfoundation.org, Christoph Hellwig <hch@lst.de>,
 Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Fri, Jan 10, 2020 at 06:53:58PM +0530, Amol Grover wrote:
> +#define subsys_lock_held() \
> +	lockdep_is_held(&subsys->lock)

This macro requires "struct nvmet_subsys *subsys" was previously declared
in the function using it, which isn't obvious when looking at the users. I
don't think that's worth the conciseness.

> @@ -555,7 +558,8 @@ int nvmet_ns_enable(struct nvmet_ns *ns)
>  	} else {
>  		struct nvmet_ns *old;
>  
> -		list_for_each_entry_rcu(old, &subsys->namespaces, dev_link) {
> +		list_for_each_entry_rcu(old, &subsys->namespaces, dev_link,
> +							subsys_lock_held()) {
>  			BUG_ON(ns->nsid == old->nsid);
>  			if (ns->nsid < old->nsid)
>  				break;

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
