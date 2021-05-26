Return-Path: <SRS0=7k1C=KV=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E712DC47088
	for <linux-nvme@archiver.kernel.org>; Wed, 26 May 2021 17:54:34 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B13B4613D3
	for <linux-nvme@archiver.kernel.org>; Wed, 26 May 2021 17:54:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B13B4613D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=LmVT061tL5vmw1fGc2aLnAmr9hoxmNiOdH5aMcPgKjk=; b=kr3hNBBKmlYJ+b
	w6rPvqCnTJyEj8GAwRq3SoZQGSiTU1sr1CIFdFoOQCnlBk8NFfD41xIsXmXSK4KU4TeFd733mM/1Z
	10ZvbhSYIvLWCjTncPYBF0MvwomLTTRxPHXpsw5JNexcfgOW6DDStNUUGBzwN+M4HpJOW55EUViwZ
	YB8qKkiUZ1CNarLinHwMWKQD5Joo0GDnAqDQYRjReCan5hJwaql9oKwVW9cpEdc5FTMUMEJviItW8
	wMmv5HrRvNjkDXaQhuRf2xmisKRxZe60JEemSIW13gQzPzWrMaPp737lD8uBjUMKR+wSP5akNKmkr
	TMswiS4eJKOK0IgBIPJQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1llxjV-00GHdy-3Q; Wed, 26 May 2021 17:54:17 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1llwgp-00Fr0S-Dd
 for linux-nvme@lists.infradead.org; Wed, 26 May 2021 16:47:28 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 74081613C9;
 Wed, 26 May 2021 16:47:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1622047646;
 bh=s+yE6psxf3KkcTLQCC4Gza4D+cLOuX0rOBi/W7lBLec=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=UaAFP54csNrfFcr3XjJByc2ihvpS7FhLy3f0mrJfUoehIyNY1BOLm/JdCO9QSVwmo
 NF9BKCtS5HdT+3kbGRpYbMvG39Tn9e/zPL0j1G32Ew7pi2zZu9jdA6RnZ9E2ndg7YM
 +V2FH25LnsiUkhIiD8bma9NSoDgvhZAaeSPYg62sdsGeje//CLpEBiAnXnDNTOlH1l
 Mxes6Fu+0G2g+1QjLupj/9OyzHx/zuc538dwXn/kOr6LfqA1Zim9E0sOYUHXwZltnq
 98aiKowPi/bRpOM2kpwreyLBywcLcD+s3CCmntcambT4/qdgtTjcOSw6syMm2jptcf
 sATfNCt5wribw==
Date: Wed, 26 May 2021 09:47:24 -0700
From: Keith Busch <kbusch@kernel.org>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org
Subject: Re: [PATCH] fabrics: add fast_io_fail_tmo option
Message-ID: <20210526164724.GB3705650@dhcp-10-100-145-180.wdc.com>
References: <20210517182616.607768-1-sagi@grimberg.me>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210517182616.607768-1-sagi@grimberg.me>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210526_094727_518825_52A34827 
X-CRM114-Status: UNSURE (   5.94  )
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

Applied, thank you.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
