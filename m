Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 776EDC2BBCA
	for <linux-nvme@archiver.kernel.org>; Tue, 25 Jun 2024 16:02:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nRL+ztyRIR5ezJzXt9DsWqFdB6uKZtQOaQtr70Ch+kk=; b=G9gdkwli7DM+FauK0KdZ6ipe3B
	SC6qVTsZlVl26bOWSzBQzMGydS37feDeO0FRgsEOUet9g0wYwI0QNfYfE5TF4PaT9gLxt4cQ7RhBh
	9wCajQDFdVv6rdjFeHA/6LXiBPxrnat04dMTOtxMHiflsQ+1x5pxxJQlNMoCtd9IGufasrVGa7d32
	AJXPQ89a6D6AphygUprGUfPn0nNCFvtfy5ZZ1lRxqDLJcA2I6gtg4VLmTM9RIB22JXbQq8Fut8EO1
	CXjAXbeN3/v33elMGdpq3rBHzsprA5ZM6nvRMnHj/qnbhBobEKrQSyb7hxx31DkLbivKmmtzlzOYi
	e+AMnE7Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sM8d5-00000003d1u-1gBn;
	Tue, 25 Jun 2024 16:02:47 +0000
Received: from sin.source.kernel.org ([145.40.73.55])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sM8d2-00000003d0n-46V7
	for linux-nvme@lists.infradead.org;
	Tue, 25 Jun 2024 16:02:46 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id EF7F1CE0C70;
	Tue, 25 Jun 2024 16:02:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A53A0C32781;
	Tue, 25 Jun 2024 16:02:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719331362;
	bh=f+hMhdJzIFMxvM6EZwwotUNdHgjS/JWzzW5ag75ffB0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dtSWLUhba0nE2TJnopG8mFjEDdqpJVigNnrcxvfntwIlYN2ZqGTDau8gEQAFqdQ5I
	 KEsFtSe04hGQOjHz+2MDjXm9DX2ChTqyDr18nephV8n64iIvnKznWnNl9cCdZ5LkV5
	 BZt7jGxbQl3LiH+Ni/kad74DyxY2sRZ41od+oVIUjKmlNUbK5p4vbkQOfL9SIlhBdy
	 l7A5r0phXxCsjDkEeythwN4B0VciBQg4ZKOpcKrZWTy4oY58VMvfDJlG17D7VfE9Wn
	 pKwuqBOiiOyhNJqSi9U4p+11pWUPJXbdNlpCiXeLL/NhwRUamYLb0Qd9ni1a+LLlOt
	 3hR9/lDldi7/w==
Date: Tue, 25 Jun 2024 10:02:39 -0600
From: Keith Busch <kbusch@kernel.org>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: Keith Busch <kbusch@meta.com>, hch@lst.de, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, Gregory Joyce <gjoyce@ibm.com>
Subject: Re: [PATCHv2] nvme-pci: do not directly handle subsys reset fallout
Message-ID: <ZnrqH9bHJ-IhQBtL@kbusch-mbp.dhcp.thefacebook.com>
References: <20240624172649.2268634-1-kbusch@meta.com>
 <e4eb3d7c-e9d9-41fa-81cf-e3f248d3e0a8@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e4eb3d7c-e9d9-41fa-81cf-e3f248d3e0a8@linux.ibm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240625_090245_215341_0D373C80 
X-CRM114-Status: GOOD (  15.35  )
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

On Tue, Jun 25, 2024 at 03:32:59PM +0530, Nilay Shroff wrote:
> On 6/24/24 22:56, Keith Busch wrote:
> > +	}
> > +
> > +	writel(NVME_SUBSYS_RESET, dev->bar + NVME_REG_NSSR);
> > +
> > +	/*
> > +	 * Read controller status to flush the previous write and trigger a
> > +	 * pcie read error.
> > +	 */
> > +	readl(dev->bar + NVME_REG_CSTS);
> > +unlock:
> > +	mutex_unlock(&dev->shutdown_lock);
> > +	return ret;
> > +}
> I noticed that in your earlier proposal we were changing the NVMe controller 
> state from RESETTING to LIVE just after write to NVME_REG_NSSR. In this patch,
> you removed that code and due to it now pci error recovery code (nvme_error_detected()) 
> couldn't change the state of controller to RESETTING and that causes the pci error 
> recovery to immediately bail out without recovering the NVMe adapter. 
> 
> I think we need to change state of controller to LIVE after write to NVME_REG_NSSR.
> So was there any specific reason you removed that code or was it missed out by mistake?

Thanks for the catch, that was unintentional. I'll back it out and
submit with the correct state transition.

