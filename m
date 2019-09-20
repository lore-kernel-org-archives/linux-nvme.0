Return-Path: <SRS0=jFtc=XP=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59AA3C3A5A2
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Sep 2019 17:46:23 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 32C7E20640
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Sep 2019 17:46:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="uq/L2pmR";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="hyrgx05T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32C7E20640
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=51TX9Q4X0fEuA4Kv98uSGGLrakLEB5UERYF+PeOzTi4=; b=uq/L2pmR6JikDj
	4F+b6e1+SWjESCCqckYEpyXyO0RAnzsGhrFEzmU7rQPsc0ErnsziKlPTBlYAtbwsXst+Sz9neSY9w
	fBmvkeuviyXHvFPcdpXZhHzYF8me986di5/HHFmyZ6X3NE7trT3DUkAP+/D8gCZw/EfKowrr4a1vR
	A9TdnpBNdcI7pRWmgDBejUJXVq2YVxGhl58kJPsUCEe58BNrVDPDPEzInowPRAfw5DKDEaccHvjy3
	gHPHF5ldKiCGjf20/Q4oZe7ijiUersz1arrgrc8U78+r7vxS2/eWeWqFaeeDc/ntKb9PJ4xI+NT0T
	rE7WUZcmiviOYfheq3BA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.2 #3 (Red Hat Linux))
	id 1iBMz4-0002xq-TO; Fri, 20 Sep 2019 17:46:18 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.2 #3 (Red Hat Linux))
 id 1iBMz2-0002xT-RV
 for linux-nvme@lists.infradead.org; Fri, 20 Sep 2019 17:46:18 +0000
Received: from C02WT3WMHTD6 (unknown [8.36.226.102])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 7D92920640;
 Fri, 20 Sep 2019 17:46:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1569001575;
 bh=E62ia8SOUrBiyYyyWI8Hdlh2Y8guZZFrUsqYiQPOejk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=hyrgx05TpxfWKLOJcjkaSAcmPUb+eZxHRgnq3zFu7Yu4vqeAQ3/z3bYrnM53xPQg3
 sIkdUI0s1DahlDAFD/4eptLYTkfo5UFGZ/UeBlD0N5nLgdkI2koXFCS6N6iVUpZBCS
 Pz2RqCBa2EbGCaMFRQ9fAZ3+M2t8eBzSI2fwTQX4=
Date: Fri, 20 Sep 2019 11:46:13 -0600
From: Keith Busch <kbusch@kernel.org>
To: Mario Limonciello <mario.limonciello@dell.com>
Subject: Re: [PATCH v2] nvme-pci: Save PCI state before putting drive into
 deepest state
Message-ID: <20190920174613.GA97775@C02WT3WMHTD6>
References: <1568830555-11531-1-git-send-email-mario.limonciello@dell.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1568830555-11531-1-git-send-email-mario.limonciello@dell.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190920_104616_911794_0FBDA8A1 
X-CRM114-Status: UNSURE (   9.90  )
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
Cc: Crag Wang <Crag.Wang@dell.com>, Sagi Grimberg <sagi@grimberg.me>,
 sjg@google.com, LKML <linux-kernel@vger.kernel.org>,
 linux-nvme@lists.infradead.org, Jens Axboe <axboe@fb.com>,
 Ryan Hong <Ryan.Hong@Dell.com>, Jared Dominguez <jared.dominguez@dell.com>,
 Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, Sep 18, 2019 at 01:15:55PM -0500, Mario Limonciello wrote:
> The action of saving the PCI state will cause numerous PCI configuration
> space reads which depending upon the vendor implementation may cause
> the drive to exit the deepest NVMe state.
> 
> In these cases ASPM will typically resolve the PCIe link state and APST
> may resolve the NVMe power state.  However it has also been observed
> that this register access after quiesced will cause PC10 failure
> on some device combinations.
> 
> To resolve this, move the PCI state saving to before SetFeatures has been
> called.  This has been proven to resolve the issue across a 5000 sample
> test on previously failing disk/system combinations.
> 
> Signed-off-by: Mario Limonciello <mario.limonciello@dell.com>

This looks good. It clashes with something I posted yesterday, but
I'll rebase after this one.

Reviewed-by: Keith Busch <kbusch@kernel.org>

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
