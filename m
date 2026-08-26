Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 881F5C5DF97
	for <linux-nvme@archiver.kernel.org>; Wed, 26 Aug 2026 14:23:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bkEkjai77PL3VkD9zUJjJ7IcDmioQfb+WhMFmt4sWAk=; b=ep1ltW5YdM2KsfX4CWFpvcda+o
	t6f39NaJ81/SR4OMb7qnEx4WtSvG5P7TZC0cqYz3zrZmz/0dvFM6EjeNeU+2BwDnG6oImKIPvZklK
	lrwOZIpnzG7hHKePhadZP8u1EsAeZm+NUnKAXrI7WOoHL+2S3u27pNu6+9INArZ4rICsgG4fYS5vk
	7CucVvggytQ4MIyFZHLYsKsGryWo8No1h7XP2XyE55ncQAkhdslRnxhih5f0buuOQ59Itztc6jv8T
	28m+u2nuNL5Fc6RdwY1vKZPfl1QVa79tUSs/jFFykjfXNanouUDWXfKAZIESJ7bXW3d6uxqCsc5+X
	h5/d3Mbg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wzEXa-00000002aqm-17eR;
	Wed, 26 Aug 2026 14:23:46 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wzEXZ-00000002aqe-0B7L
	for linux-nvme@lists.infradead.org;
	Wed, 26 Aug 2026 14:23:45 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 7506D41245;
	Wed, 26 Aug 2026 14:23:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E2121F000E9;
	Wed, 26 Aug 2026 14:23:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787754224;
	bh=bkEkjai77PL3VkD9zUJjJ7IcDmioQfb+WhMFmt4sWAk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=cHrly7z5HtT8i+OMuv+Ieo/UF3PbQM5PsDqZoifjAtTKP8nzX9lSEnrUdgBt5GnF2
	 /J5iff3z5BeRtU5TIvBgIgEIPOyJjDcRCMpxnRwCsjHk9yyj3+oMEmymMiKlfBiRub
	 ++Gvj8SWWV5Rg88IUQtW2t+x81SRHpjrkMoxyw5ZXdzt3l6Lgq+TGzz2g6WHgsCFrk
	 uv7ondxGI12EgNscePQZenDJbJnP7BgTHqR5ze0dC6yez8AKk81/R1GdmtVE/oVua2
	 6lfuDeA2o3+cLSumTKPd2wCNglYRY45z9eGMMJjY8l65ZjB8nzNHhP4mX1ozVNGNpe
	 xR5kEDy8b8EVQ==
Date: Wed, 26 Aug 2026 08:23:42 -0600
From: Keith Busch <kbusch@kernel.org>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: wenxiong@linux.ibm.com, linux-nvme@lists.infradead.org,
	gjoyce@linux.ibm.com, wenxiong@us.ibm.com
Subject: Re: [PATCH V2] nvme: Add module reference counting for multipath
 devices
Message-ID: <ao727q88MeuHbU2F@kbusch-mbp>
References: <20260812223206.720363-1-wenxiong@linux.ibm.com>
 <d3cb6438-f1b6-4b46-9f96-56819052bc02@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d3cb6438-f1b6-4b46-9f96-56819052bc02@linux.ibm.com>
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

On Wed, Aug 26, 2026 at 06:10:09PM +0530, Nilay Shroff wrote:
> when none of those namespaces are actually in use. So for instance,
> with this change now, I can't rmmod nvme.ko until I delete
> all namespaces/paths created under PCIe nvme subsystem, even though
> no one is using the namespace/path under that subsystem.

I'd call that a feature. :)

> Instead, I think the module reference should track the lifetime of an
> active user of the multipath namespace. When the namespace is in use,
> the corresponding transport module(s) need to remain loaded and once
> the namespace is no longer in use, those references should be released.

That's what v1 was trying to do, but it doesn't work. The transports
used to reach a namespace may not be the same across the open and close.

