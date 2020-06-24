Return-Path: <SRS0=WpAz=AF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E842CC433DF
	for <linux-nvme@archiver.kernel.org>; Wed, 24 Jun 2020 02:51:49 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B4A3B20874
	for <linux-nvme@archiver.kernel.org>; Wed, 24 Jun 2020 02:51:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="y/uYsRDH";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="cutbL0Cc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4A3B20874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=BrwuKoGq8Bw+Xh0jCha6fprmAnN33/r1r8ZChDfkiQY=; b=y/uYsRDHsSVJ2uJrbfi/W/dWQ
	8VxGwZ1GFJBCcv7tkwvUW/a917Gao8fM1v+fmcl+F9NxR9ECGnq7yHOB8t+aWg6cnZw8QPwX9sf4s
	0irJ8wiV0eNsp0tY7FZph/Sh+B2uIZDM5N4C84DoOgHd2+kv7pZKz3HQ7Jx2+lAdVoLGWz7uawHk7
	9XIYU0wJjylU4WI5749AUcYdm6LcM6UzAScwzB8Q2PvP/AfIuoLny6awf1whFKW/CevkLi4DCILdR
	r8RHD/VbxsgMXIb7fBPaOW1RiHugkc03Lst7ZP00gOhzX8FNEQ99VFntl92OKkvH5bvReRPvpj8RD
	Xacy7v+8g==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jnvVn-0002Hu-Eo; Wed, 24 Jun 2020 02:51:43 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jnvVj-0002Fl-MD
 for linux-nvme@lists.infradead.org; Wed, 24 Jun 2020 02:51:40 +0000
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id C79BB20874;
 Wed, 24 Jun 2020 02:51:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1592967098;
 bh=jvZa+2rBHSyCXMiDZ8ktCel23EW/OJugQWSsjHUz3ro=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=cutbL0CcHkkg+4b6NpuS2PGm23TKRP7oEHx3sltDDa/FVKLuZBqHcIqYNpFO5RjX8
 msWggVCSkOhG9pHSSnbuY0LW7GGaiDggMGY0JiVaVhJbr+sXTb6cbYeMOL32Bae90i
 Cp6qzO9aa4lcXwbyhxXho+TSZz9oI8dHtbUxMIks=
Date: Tue, 23 Jun 2020 19:51:35 -0700
From: Keith Busch <kbusch@kernel.org>
To: Baolin Wang <baolin.wang@linux.alibaba.com>
Subject: Re: [PATCH 1/3] nvme: Add Arbitration Burst support
Message-ID: <20200624025135.GA1291930@dhcp-10-100-145-180.wdl.wdc.com>
References: <cover.1592916850.git.baolin.wang@linux.alibaba.com>
 <bf3f47ba50f72d0b775ca4bd098f183056d964ba.1592916850.git.baolin.wang@linux.alibaba.com>
 <20200623144014.GB1288900@dhcp-10-100-145-180.wdl.wdc.com>
 <38482b1b-b1c7-bb41-b086-6ce00f6a9d1d@grimberg.me>
 <20200623180108.GA1291100@dhcp-10-100-145-180.wdl.wdc.com>
 <20200624013408.GA40094@VM20190228-100.tbsite.net>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200624013408.GA40094@VM20190228-100.tbsite.net>
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
Cc: Sagi Grimberg <sagi@grimberg.me>, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, axboe@fb.com, baolin.wang7@gmail.com,
 hch@lst.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, Jun 24, 2020 at 09:34:08AM +0800, Baolin Wang wrote:
> OK, I understaood your concern. Now we will select the RR arbitration as default
> in nvme_enable_ctrl(), but for some cases, we will not set the arbitration burst
> values from userspace, and we still want to use the defaut arbitration burst that
> recommended by the controller, taking into consideration any latency requirements.
> 
> So I'd like to add a parameter to decide if we can use the default arbitration
> burst like below, how do yo think? Thanks.

I wouldn't call this the 'default' arbitration since it usually is not
the default. This is the 'recommended' arbitration value.
 
> static bool use_default_arb;
> module_param(use_default_arb, bool, 0444);
> MODULE_PARM_DESC(use_default_arb, "use default arbitration burst that
> recommended by the controller");

"use controller's recommended arbitration burst"

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
