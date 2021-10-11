Return-Path: <SRS0=GEgN=O7=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F263C433EF
	for <linux-nvme@archiver.kernel.org>; Mon, 11 Oct 2021 19:13:10 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 17C2160E53
	for <linux-nvme@archiver.kernel.org>; Mon, 11 Oct 2021 19:13:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 17C2160E53
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=/QX3LMOzQZcj3q1DimazM0+6lg6bSnRpG3ehpNiud/U=; b=loEvRbS7L8BgwJ
	PZntdxXU7Ez+spA8pTsk9tVduAFM8QcGy0BKOtvEFKShu10NtnvEKp/CyJgROJfWzij1ZBB4pXwhG
	UX3M1zNxTz6EE6KVRDsZxAAbOw1SbrSyY6BO9Y/Fziy6eYOMq55DfC9eCjw/CtGGwL+4XkqA8PZI1
	JjFs4JJWRF5P4SQIUnwpLuQu/Vkc+yNA1/rkwtRDoW4HKO9U93Q1s1rGltq+neii0W9GKoGQZpHSJ
	6G97qoVxWzmCBelI7yQtwfdXk+xUd/QW86mgADCyNSAZFbZFcdEDe0U7wZJy9qDRZuuFYGx45Hb94
	+SKl7XI9Jrn/PXEv3EDQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ma0jG-00AT4V-Vp; Mon, 11 Oct 2021 19:12:55 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ma0jE-00AT3m-9E
 for linux-nvme@lists.infradead.org; Mon, 11 Oct 2021 19:12:53 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 94EA260E53;
 Mon, 11 Oct 2021 19:12:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1633979571;
 bh=LoGOZtxcG5VKmjYlhGIF6zG1jDyJNiDKClkO6AFaIsc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=WmGcxjtpqYLvGIq2C2CZEAXPh6hgxtxTPe1zgqY3fCi1rKVRiiZ1ErQfSz63Mwf8d
 DsPEGGFEeYALcrSFi2ExcGtfBv0taYERFhsDa2AxQquQtqePr4F9KJ+7bScWKmzUvZ
 j6NCCSiZy3aLaSQ3KE0bxnQDJGaLvZ4jeRAidkdcVRNvVvbQvxScu5N0pWQylB48OH
 Tr1mXkRaPAPlcedHN+wpW7aX7UCHE8aSmBkyJpy/ueHLrqhL6X8n2vwwbthMj3G3CR
 AGyRjl29z2KI9glhQDJipTcxk/m9hnH2Ky8uO+hD4gftMJSheSeoMc+xrwtHENb51z
 yqgDT4XB4JcCg==
Date: Mon, 11 Oct 2021 12:12:49 -0700
From: Keith Busch <kbusch@kernel.org>
To: Michael Fuckner <michael@fuckner.net>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: Namespaces on MZQL2960HCJR-00A07
Message-ID: <20211011191249.GB635062@dhcp-10-100-145-180.wdc.com>
References: <34244386.3221623.1633769595569@com4.strato.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <34244386.3221623.1633769595569@com4.strato.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211011_121252_362700_86D22E42 
X-CRM114-Status: GOOD (  12.84  )
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

On Sat, Oct 09, 2021 at 10:53:15AM +0200, Michael Fuckner wrote:
> I have a system with 2x PM9A3 (FW GDC5302Q) and nvme1 shall use namespacesfor testing.
> 
> I could use nvme detach-ns, delete-ns and create-ns, but it fails at attach-ns the new namespace to make it usable:
> 
> test135:~ # nvme id-ctrl /dev/nvme1|grep -e nn -e cntlid
> cntlid    : 0x6
> nn        : 32
> test135:~ # nvme attach-ns /dev/nvme1 --namespace-id=1 -controllers=0x6

The long options should use "--" rather than just the single "-". I'm
unsure if that changes the parsing, though.

> NVMe status: Controller List Invalid: The controller list provided contains invalid controller ids(0x211c)
> 
> Any idea how to attach this or other namespaces back so I can use the drive?

Was the namespace attached to cntlid 0x6 prior to the detach/delete part
of the test?

When you created the namespace, did the output confirm the namespace was
created as nsid 1?

Is the namespace attached to any other controllers? You have to specify
multi-controller enabled when creating the namespace in that case.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
