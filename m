Return-Path: <SRS0=ZIaN=KN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72E0CC433ED
	for <linux-nvme@archiver.kernel.org>; Tue, 18 May 2021 06:57:24 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D2A061007
	for <linux-nvme@archiver.kernel.org>; Tue, 18 May 2021 06:57:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D2A061007
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=YZEMQLpfXQ3OpcuFy4ZTyg7viRw57VQ2CUvCC0EHFsI=; b=e5stkFwM/q7tn8hSEaoKRPnbu
	CRWZVx88cY+RkNu0SoWc0Qprws5dcw9PpOF/DQEaTyYPmm73b1rcB7vRds+bSdbchpuXMk5Qtj9kr
	ADmZBfH/bD/MeELI8JgAHa6QQOq/1JxpTk7HTaUfVwibEm+GgzUsM4WYVFzoafyZ2TmoZhq1rle6c
	+mTMI5SCBoD28P5YRZS65guFmXlkoGgyXqTZIG9hiqKRgo8sx0gWgR5+ZZq/xjoX9EIy9fJxhKB8e
	7XDVqAcbAROVNJeCWPJElkb+2PSQpQJXygCVWweV7BFM2In2cHkO3OBdrt7Hr3yC93kLBQ/tBxpYA
	IxUseEtsg==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1litfJ-00HE75-Ux; Tue, 18 May 2021 06:57:18 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1litfH-00HE6a-Fx
 for linux-nvme@desiato.infradead.org; Tue, 18 May 2021 06:57:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=00M/ZL/+3uqIp6D76cEkm3Cr6FBkm/wxeZJzhFqfv3U=; b=IMXm0FIqsrXl+zp7jHZaHFue+w
 fNFTYv1Y/bpuwVbBzHo9VpHaEdqI6fHyepIISMFD5WMhWcj5UsA7UlTz8OaDg+/S98k+h9CGO6mmN
 VSU5B9gcz+qZ2oErBHzzDN2l1wyL2hdUuk8a3qsRDXpKcpWXMgem0j0JFVGp0rtQ+2XNnqILpPUwP
 x36UDVG2l3ku1YNbl2PCO3r3MkWaMguAJDCufNrO492MnxMW4h/QdlLPEyw+386SbUjMqJV+E493Y
 dQifProfnG6BkpiYjEqG5n+Nsq37KnwHGGcqfWmIioL+KlpnOMVXI2o2lV3MvnuYFpAEFw6tNm3H2
 BXszfz6w==;
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1litfE-00ENsR-SV
 for linux-nvme@lists.infradead.org; Tue, 18 May 2021 06:57:14 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 3FF5467373; Tue, 18 May 2021 08:57:10 +0200 (CEST)
Date: Tue, 18 May 2021 08:57:10 +0200
From: Christoph Hellwig <hch@lst.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Keith Busch <kbusch@kernel.org>, Hannes Reinecke <hare@suse.de>,
 Christoph Hellwig <hch@lst.de>, Keith Busch <keith.busch@wdc.com>,
 linux-nvme@lists.infradead.org
Subject: Re: [PATCHv4] nvme: allow to re-attach namespaces after all paths
 are down
Message-ID: <20210518065710.GA8255@lst.de>
References: <20210517081809.104813-1-hare@suse.de>
 <20210517152601.GA2709350@dhcp-10-100-145-180.wdc.com>
 <688618fa-a079-6d84-adf2-01ee36f95d76@suse.de>
 <20210517154942.GA2709391@dhcp-10-100-145-180.wdc.com>
 <4b32451c-2426-c86f-ebc6-9de74e0bbde6@grimberg.me>
 <20210517180144.GC2709391@dhcp-10-100-145-180.wdc.com>
 <21fc1351-51e2-2d66-d988-b07763a7ae5d@grimberg.me>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <21fc1351-51e2-2d66-d988-b07763a7ae5d@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210517_235713_091868_6916D701 
X-CRM114-Status: GOOD (  17.44  )
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

On Mon, May 17, 2021 at 11:20:36AM -0700, Sagi Grimberg wrote:
>
>>> That is because we keep the device node around even though it doesn't
>>> have any bottom devices. Which is what I think Hannes tried to fix
>>> in an earlier patch.
>>>
>>> Also, if an NVM subsystem happens to recycle nsids, it will trigger
>>> pretty surely. So I'm not sure this is an obscure case...
>>
>> I'm not very concerned because (1) deleting an in-use namespace is
>> surely a user error, and (2) it currently doesn't work either, and no
>> one's complained yet AFAIK.
>
> You're not wrong. It's just that one error (on ns X) can manifest in
> other potentially completely different namespaces created. I guess
> this kind of thing can happen when ns administration is done by
> adminX (or scriptX) and the ns mounting is done by userY where what each
> is doing is unknown to each other.

We also check for the matching identifiers in nvme_init_ns_head, so
we'll error out there.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
