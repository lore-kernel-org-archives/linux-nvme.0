Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85D9BC433EF
	for <linux-nvme@archiver.kernel.org>; Thu, 23 Jun 2022 14:57:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pp16SfCwpoCB4rbkTa8KCcxbDZV5zVHS1qGXD02tC/w=; b=0HxkzOsWSq7ZiIYSBR04EvH+q1
	xQecebnpEBZgjLRSyWfNmWU71jyNVt5dz8ueOO3vlOc7kyOo3Lj+ydeQBlSTIqS2Pcjc0On0Uopmp
	mjeui5Cq6piwfCKactUD2OdNqP8mXglNr7vfxcim2IdxeBOwVmSo+Rms2wx4P8sUiB83m/ZsECj0a
	lHefwRlxMjQe6ipA3a3BNi3jngv2HDHgZaFQRzLLFlAVjt8XRK3OIX+Pryx51T+dRTROyesy2NApR
	N9vvYLoHGymCRZNSnxVmmYiVzNx8xes3egxhQUJrNedaFO6uNUA99xXfclCOLKXeMGPXtrlbZAIZO
	hDd3WkTg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o4OH3-00Fd8Y-99; Thu, 23 Jun 2022 14:57:37 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o4OH0-00Fd7S-5r
	for linux-nvme@lists.infradead.org; Thu, 23 Jun 2022 14:57:35 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id B45B361E7A;
	Thu, 23 Jun 2022 14:57:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 736C3C3411D;
	Thu, 23 Jun 2022 14:57:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1655996253;
	bh=s+BjEHBkCbCyThPI0APDniSN+GtItYyxkZNjJqx1lHM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uGCQVXpWIAIL6LnfafNYvnqWW5JSjbiZ7VQYLoiOyL2fafIfk0vkreA0UedzYtFaG
	 TGqgJaoeUj7dMLyF/+/sznKgS+oa1H1nyTchKf+mY23a/e0cJziSimE0136nnfl++i
	 dQYKTTiUom2618u86/V4PuEiUtxHMshdIDsjAkYDBBrOW8f8sQDWe/ojl6vfgsSdI9
	 hHlB0UHkXBlG9j8M+bpmfZXC6H57M9tsGEzBEcEx93R0MZzlPU4TxNIRN/7kKb3N2F
	 yMYUhN35naa7UgGe1a3p7jKBWVL50KW7aclVuzIsJPoiBLGQWX3Si4yox8ZZ68NVxX
	 x5LEtxWbNt1Rw==
Date: Thu, 23 Jun 2022 08:57:29 -0600
From: Keith Busch <kbusch@kernel.org>
To: Joel Granados <j.granados@samsung.com>
Cc: hch@lst.de, linux-nvme@lists.infradead.org, joshi.k@samsung.com,
	gost.dev@samsung.com, k.jensen@samsung.com
Subject: Re: [PATCH v3 2/2] nvme: enable generic interface (/dev/ngXnY) for
 unknown command sets
Message-ID: <YrR/Wc/1Wx959Dnu@kbusch-mbp>
References: <20220622135556.2185991-1-j.granados@samsung.com>
 <CGME20220622135844eucas1p1c224ccf50c43f722cc228c59d8c395a7@eucas1p1.samsung.com>
 <20220622135556.2185991-3-j.granados@samsung.com>
 <YrN5dWNZkUnFpjSH@kbusch-mbp.dhcp.thefacebook.com>
 <20220623083918.kvtkpwyy3ob52sp4@joelS1.panther.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220623083918.kvtkpwyy3ob52sp4@joelS1.panther.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220623_075734_293702_933FCC9A 
X-CRM114-Status: GOOD (  23.18  )
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

On Thu, Jun 23, 2022 at 10:39:18AM +0200, Joel Granados wrote:
> On Wed, Jun 22, 2022 at 02:20:05PM -0600, Keith Busch wrote:
> > On Wed, Jun 22, 2022 at 03:55:56PM +0200, Joel Granados wrote:
> > >  static void nvme_validate_or_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid)
> > >  {
> > >  	struct nvme_ns_ids ids = { };
> > > -	struct nvme_id_ns_cs_indep *id;
> > > +	struct nvme_id_ns_cs_indep *id_indep;
> > >  	struct nvme_ns *ns;
> > > -	bool ready = true;
> > >  
> > >  	if (nvme_identify_ns_descs(ctrl, nsid, &ids))
> > >  		return;
> > >  
> > > +	if (nvme_identify_ns_cs_indep(ctrl, nsid, &id_indep))
> > > +		return;
> > > +
> > 
> > There's no check that the command-set-independent namespace identification is
> > supported, so an error should be expected for many controllers instead of
> > abandoning the namespace.
> good catch. But is the error really necessary?
> If the controller supports NVM or ZNS then we can continue with the
> normal (command-set-dependent) namespace identification.
> 
> I see two situations:
> 
> 1. When we are dealing with NVM or ZNS command sets:
> 1.1 Should bring up a block device regardless of supporting command-set-
>     independent namespace identification
> 1.2 Time-to-ready will be used only if command-set-independent is
>     supported
> 
> 2. When we are dealing with something that is not NVM nor ZNS:
> 2.1 Should bring up a char device iff the command-set-independent
>     namespace identification is supported.
> 2.2 Should abandon the namespace with a dev_warn if the
>     command-set-independent namespace identification is not supported.
> 
> Am I missing something?

I think your description sounds like what we want to happen, but that's not
what the code does. When validating NVM or ZNS namespace, but the controller
doesn't support CNS 8h, the code returns early instead of allocating the
namespace.

