Return-Path: <SRS0=McG4=37=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EB1DC35242
	for <linux-nvme@archiver.kernel.org>; Tue, 11 Feb 2020 20:43:25 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 67BD720714
	for <linux-nvme@archiver.kernel.org>; Tue, 11 Feb 2020 20:43:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="fTlN5vig";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="AOX7bxTW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67BD720714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=KyrlLq/us8aZ4q9muM5+Uwh+ES8aoSFGPyY86YBTqeg=; b=fTlN5viguXZp8Q
	6uF0YIRpv2bQ7j3OoS6a1WOXhT/C8SBP9Rf+VpU4LrlipHpGA5dHDbbRnb76z95IG8nT5rQwGTdes
	QyxPvr3na3q1E8cN9gkNYFaVx/vfqS5cbrzeoclfFlH3DjlUp5H5N/1XG6Um50xijw7X4SqNRIiB8
	K2/INajn5bKLrJ0nZZpW9aoTPpxfGhq/StqlTQz+VjrcjIZGkMM9nztbu3zx6G5BmN6k92UqalCzv
	OObhUBNr7XFXIZNgMUHGU9GKQf0JC5XLYF7QJjFweJGQX7tIyB66uyZWY8HMP6gljZ9sv/p1r7oph
	Qgq1GkG6muriTQ2WVcIA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1j1cNP-0002Tm-8g; Tue, 11 Feb 2020 20:43:23 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1j1cNM-0002TM-S3
 for linux-nvme@lists.infradead.org; Tue, 11 Feb 2020 20:43:22 +0000
Received: from redsun51.ssa.fujisawa.hgst.com (unknown [199.255.47.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 6201C20659;
 Tue, 11 Feb 2020 20:43:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1581453800;
 bh=JFW8+SEIHkcT9Rc//xmVXpzSmYUZReLclkdh62nn5ZU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=AOX7bxTW47LBZ+CLW1eeLYewASiV/TQ7iOkCSBqir9BzO0SPinnmcbIAYybx/7GUP
 e53xTh2ujWla+jB2WgzPptcuq4XkVW5Xvkd2HPioLrdsnxy9uUjcW+ZZ/n3qR+ECH+
 kveOET7gMrNo//5leDTSi/jzavDCSnyT+hr1hvPc=
Date: Wed, 12 Feb 2020 05:43:13 +0900
From: Keith Busch <kbusch@kernel.org>
To: Jean Delvare <jdelvare@suse.de>
Subject: Re: [PATCH] nvme: Don't deter users from enabling hwmon support
Message-ID: <20200211204313.GA3837@redsun51.ssa.fujisawa.hgst.com>
References: <20200211134136.099ac9eb@endymion>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200211134136.099ac9eb@endymion>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200211_124320_929235_30C03ECF 
X-CRM114-Status: GOOD (  11.96  )
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
Cc: Guenter Roeck <linux@roeck-us.net>, Christoph Hellwig <hch@lst.de>,
 linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, Feb 11, 2020 at 01:41:36PM +0100, Jean Delvare wrote:
> I see no good reason for the "If unsure, say N" advice in the
> description of the NVME_HWMON configuration option. It is not
> dangerous, it does not select any other option, and has a fairly low
> overhead.

The initial commit probably used one of the other Kconfig options that
contained the same wording as a template. But okay, the overly cautious
description here looks fine to remove.
 
> As the option is already not enabled by default, further suggesting
> hesitant users to not enable it is not useful anyway. Unlike some
> other options where the description alone may not be sufficient for
> users to make a decision, NVME_HWMON is pretty simple to grasp in my
> opinion, so just let the user do what they want.
> 
> Signed-off-by: Jean Delvare <jdelvare@suse.de>

Added to nvme-5.7 with the reviewer's tags. Thanks!

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
