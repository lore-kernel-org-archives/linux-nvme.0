Return-Path: <SRS0=Uo3O=YD=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,FAKE_REPLY_C,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F37D2C10F14
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Oct 2019 16:14:24 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE79E20B7C
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Oct 2019 16:14:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="RBbz/9MZ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="uQtOtVeF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE79E20B7C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
	List-Owner; bh=jOVn8aciPLSlEk0vTUi7bE6tKOQ8vwgElpkTnJCa934=; b=RBbz/9MZ0MHzq4
	24k72vvSSMgd+zhgyY1MtVCftDmGAhNcTyEM6DX5QjLAVvHoBPmV7zP6EBM2umux2fgFRFlU8uFL8
	iqGFsUhnXv3Z1vhjIdd7QYvPWCHnTiV4WHPaDxzUs1AQMGE+ZNuywDLmToCMcEUySXdqQvzDzaWjQ
	47YyVBAOk6uPCeLYC9mAEkyoeNkZLTmKdpZRY8IGMaoShICJLhEgiWUclwPsWrJeC76GeIUSouzwI
	ofjoKRNErR7U4mb8ZcuNP56xSJy8nVC1L5jJSZFFhdPJc79Lj+CoX23CuWq1ziy2x4Qwjyo5zcEoh
	xnw3o00bowfBxaUdoPHA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iIb55-0005wl-LE; Thu, 10 Oct 2019 16:14:23 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iIb53-0005vt-4B
 for linux-nvme@lists.infradead.org; Thu, 10 Oct 2019 16:14:22 +0000
Received: from localhost (unknown [69.71.4.100])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 44118208C3;
 Thu, 10 Oct 2019 16:14:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1570724060;
 bh=FAVk8gKLODf5YWnYfPHlctJQwGl0YhqkTGhjRC/RqsU=;
 h=Date:From:To:Cc:Subject:In-Reply-To:From;
 b=uQtOtVeF2sLlaukbORqJxciQvRrLcp3kWiz/Sz6arfB4ukY5c1rhpODOSHY9kbUbO
 sXvmB8z8UuCDA4ly22WRfROejwODMbrh/c+fuw3WM6I1LDfEksb/iwm4PRFceuyT1K
 RcP8aYPKlkFKiFjoVyWKd17mpeYjBBUP8HdrJlUM=
Date: Thu, 10 Oct 2019 11:14:17 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 1/1] PCI/ASPM: Remove pcie_aspm_enabled() unnecessary
 locking
Message-ID: <20191010161417.GA14520@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20191010140121.GA31701@lst.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191010_091421_189650_F2653734 
X-CRM114-Status: GOOD (  11.06  )
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
 Mario Limonciello <Mario.Limonciello@dell.com>, linux-pci@vger.kernel.org,
 linux-pm@vger.kernel.org, "Rafael J . Wysocki" <rjw@rjwysocki.net>,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 Keith Busch <keith.busch@intel.com>,
 Kai-Heng Feng <kai.heng.feng@canonical.com>, Rajat Jain <rajatja@google.com>,
 Heiner Kallweit <hkallweit1@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, Oct 10, 2019 at 04:01:21PM +0200, Christoph Hellwig wrote:
> On Thu, Oct 10, 2019 at 07:47:46AM -0500, Bjorn Helgaas wrote:
> > +	return bridge->link_state ? !!bridge->link_state->aspm_enabled : false;
> 
> Can we unobsfucated this while we're at it?
> 
> 	if (!bridge->link_state)
> 		return false;
> 	return bridge->link_state->aspm_enabled;

Yep, after some of the follow-up patches from Heiner, it looks like
this:

  bool pcie_aspm_enabled(struct pci_dev *pdev)
  {
	  struct pcie_link_state *link = pcie_aspm_get_link(pdev);

	  if (!link)
		  return false;

	  return link->aspm_enabled;
  }


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
