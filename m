Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F6ABC61CE3
	for <linux-nvme@archiver.kernel.org>; Mon, 24 Aug 2026 16:54:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cd11BQOfydxZdM/GZKvkf4pQbJMLZ08a2QIPMPafgFE=; b=2A+TlrH5zcQAtM/D4zmld+VeLc
	mp7hMclWhMl+Yzex27Fau/S3UyhPsgvUeyUrcBcDsMjJxQNuT9haGmYPQIZ6j0fZ9DLuelndK41rN
	TFsEfKbXeznqz//eheVFLkAZaiwJXJmqWMbAseBZ3mnkaFM/EQ0CSgol3oPH2RdX+Nu+eua8UoFU1
	UPK0F++k45Qi0j46L80UuRIBYZjqJiwFNUbpE9Ud92eksbsRPG4sXHrL4+df1dr3RQK3nXye/3IpC
	xBZzHeJJWhgS0O1tALUjC/F1wHF16Na1KkiSY4uv6HQk4TPWQAVA3e8s5FI18QNGYMMR1rVlwl3us
	/C+uGIXw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wyXwY-0000000H5T1-1zOo;
	Mon, 24 Aug 2026 16:54:42 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wyXwX-0000000H5Sm-2oBB
	for linux-nvme@lists.infradead.org;
	Mon, 24 Aug 2026 16:54:41 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id C8B5340D91;
	Mon, 24 Aug 2026 16:54:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 280AA1F00ACA;
	Mon, 24 Aug 2026 16:54:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1787590480;
	bh=cd11BQOfydxZdM/GZKvkf4pQbJMLZ08a2QIPMPafgFE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=LCcC67kksqVXgprPAJO1gv5A/0mcO1uIenDqIv297BkaDPukGsZHhoAOylGvLEBdB
	 yY3lGNcWftSSLt4KZmK+x68GIPqaKyVR0fpZxxB/aHSX1FXiFRUNUUdJb8K3XOJIo0
	 8TLq6/rc5/6HR5fykJVA0FDbP+GUAH6Foy5RYLN8=
Date: Mon, 24 Aug 2026 18:54:37 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Shivam Kumar <kumar.shivam43666@gmail.com>
Cc: linux-nvme@lists.infradead.org, Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	Ibrahim Hashimov <security@auditcode.ai>
Subject: Re: Prior report for the nvmet-tcp unbounded SGL length fix in 7.3
Message-ID: <2026082438-stank-rectangle-bbdf@gregkh>
References: <CA+ysrSKO9ufMWQ=s_xM_uh1OhKmEb8v0tOwYH+g2vtxeWqW8DQ@mail.gmail.com>
 <2026082412-matchbook-perennial-03af@gregkh>
 <CA+ysrSKxTa--qGNrZu5SPLner+OTvHYFjfuSRnFW+xkqnQ+VBA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+ysrSKxTa--qGNrZu5SPLner+OTvHYFjfuSRnFW+xkqnQ+VBA@mail.gmail.com>
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

On Mon, Aug 24, 2026 at 12:07:28PM -0400, Shivam Kumar wrote:
> Hi Greg,
> 
> Just the CVE, if one is assigned to 4a3f002, being recorded as the
> reporter would be all I'm after.

We do not have names/reporters on CVEs at all, we rely on the git commit
text, but also will be glad to link to any external documentation as a
reference if needed.

But I think you got the git id there wrong...

thanks,

greg k-h

