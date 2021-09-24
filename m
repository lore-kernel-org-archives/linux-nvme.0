Return-Path: <SRS0=ODQg=OO=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EABF9C433EF
	for <linux-nvme@archiver.kernel.org>; Fri, 24 Sep 2021 03:13:36 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A3E0060F44
	for <linux-nvme@archiver.kernel.org>; Fri, 24 Sep 2021 03:13:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A3E0060F44
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=tQIWeO4o8CVmvUEvb9+P0goTDV9PYI3diTPO/IlhJq4=; b=qCkAd2kmyAxyZc
	X2EG8jElDdisuXb8GpeUP9gSIY5yCu7T23+xGvUZZyZ5TlAU9nS2KzT7layTj0uFhqPuZaASic6sh
	3vOHNbfjs8jdr2EDjreFSlKHHP8UCqrYIDrmuWVaGJf84qDI7Y2AwcAKsBaH5jnO5RvAg1+1+1Ejj
	P30gmh+E6zD8n4GU/WmB1CjVP7ERf6pVPSikIqDI/zdf1WrtclFbgjY+162iNEHgr66aR5OrfvLJB
	VBCclCPXgZHk94hZPafoHZ+kuFN/cNF0l3eP08YlNskrqg0Phcfih8gu4jYDC0tsmtSk7S6Wktrmh
	G5DgOAilWVXbD1El5rQg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mTbeJ-00CyC0-OW; Fri, 24 Sep 2021 03:13:19 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mTbeH-00CyBR-I0
 for linux-nvme@lists.infradead.org; Fri, 24 Sep 2021 03:13:18 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id F2F4360F44;
 Fri, 24 Sep 2021 03:13:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1632453197;
 bh=9C1CpZebNZPOuS8BQ6bPo6u0WIU3rIY+JsZNrLixgCQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=EKx2oHfhlzhM5slykpGEQOjGp8DGeqyDjzyrI5RMJ/Hpl0QxnP5yww1fE00Ve/r5M
 I17KU3rstlYN0wBktF9sstccjKtM4bZli6ZJ3XOvPrPuMhsH5fAd170rOV67HJEQsp
 aj7EwqrZRuoQPpoYjIJMAyFzvYwcP4ruzmU7pAWXeb2g6dAJ7UXO0dEdWzMIkUHeby
 yNp6ysDdiWBBfMEn20SOGWtgzdAFPae5kGLq/baehgnCRFtsFOuYrTToOq6nKJ9x2/
 EM1uQfemSQyIm8duXeZ+T4xQxHQmxGMXcEbIdOOMOvSS8zkSiHLohBAnuPUmlFZeLt
 UvFSvgiFeJNvg==
Date: Thu, 23 Sep 2021 21:13:15 -0600
From: Keith Busch <kbusch@kernel.org>
To: Yi Zhang <yi.zhang@redhat.com>
Cc: linux-nvme@lists.infradead.org
Subject: Re: [bug report] nvme removing after probe failed with pci rescan
 after nvme sysfs removal
Message-ID: <20210924031315.GA14438@C02WT3WMHTD6>
References: <CAHj4cs_9AM7YvirAhcztZjhOV0nac_qShHs9qs4B1JAMc3PXdA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAHj4cs_9AM7YvirAhcztZjhOV0nac_qShHs9qs4B1JAMc3PXdA@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210923_201317_634934_FA1615A0 
X-CRM114-Status: UNSURE (   7.26  )
X-CRM114-Notice: Please train this message.
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

On Wed, Sep 22, 2021 at 09:56:47AM +0800, Yi Zhang wrote:
> # echo 1 >/sys/bus/pci/devices/0000\:87\:00.0/remove
> # echo 1 >/sys/bus/pci/rescan
> # dmesg
> [  251.864254] pci 0000:87:00.0: [144d:a808] type 00 class 0x010802
> [  251.864286] pci 0000:87:00.0: reg 0x10: [mem 0xc8600000-0xc8603fff 64bit]
> [  251.864337] pci 0000:87:00.0: reg 0x30: [mem 0xffff0000-0xffffffff pref]
> [  251.889196] pci 0000:87:00.0: BAR 6: assigned [mem 0xc8600000-0xc860ffff pref]
> [  251.889206] pci 0000:87:00.0: BAR 0: assigned [mem 0xc8610000-0xc8613fff 64bit]
> [  251.889777] nvme nvme0: pci function 0000:87:00.0
> [  251.889888] nvme nvme0: readl(dev->bar + NVME_REG_CSTS) == -1,
> return - ENODEV

An all 1's return almost certainly means the memory read request failed. The
test your described usually means the target did not properly configure the
memory range it was assigned. Is this directly attached to a root port?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
