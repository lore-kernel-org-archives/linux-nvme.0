Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17B19C433F5
	for <linux-nvme@archiver.kernel.org>; Fri, 17 Dec 2021 21:25:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wKJtFGSaxIU7cCuvXgMfn751UqMdn/UpHJXcrIkox9w=; b=UiBXmhl8/Q4J1G0ZIJo8m0bsw8
	GVd+3aEhdXMO+2Gzv8KkS7DyrofCGkAlqj/MtclVGjv+7qkHCsHvVcnGawviZy7BdEcE0xQZHTJu2
	2TrYPf23h+1woo32S42jIdRoFMBjQru1NdReOcIXSxKyD0sv4leco/kW1lGCYVCX0cUwOAMb8GdNR
	ny+mfiY5AsdWz/NIlh2VVcH4NA9CvZ9yJ36HN3V4na34f3JPV0Xcf20wLoPKNAMhz9HEd/FRMaOSi
	8zB5uczdR8uPpY6Lw5TETD2gdZL77UT7g19XRn0ncNNmCfP1T5V6wOSgy5WCiVrBOVduTSKqkAWHi
	7N61djMQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1myKiq-00CQLi-Vd; Fri, 17 Dec 2021 21:25:01 +0000
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1myKio-00CQLI-10
 for linux-nvme@lists.infradead.org; Fri, 17 Dec 2021 21:24:59 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by sin.source.kernel.org (Postfix) with ESMTPS id 1FBA0CE26DC;
 Fri, 17 Dec 2021 21:24:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3B6EC36AE2;
 Fri, 17 Dec 2021 21:24:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1639776293;
 bh=tiRZcDyzCLfUIrCHfvpqxMZOaQwjKW6wa+WRVmkCk+M=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=sGlAd6qNAonFn/7pX8SOS7JEiYLy+AC99jNTYqn+QQ2Fg5xQAwAxoDr8KO+3jT0qV
 S6zTZiGeZbkNtZfhdK/L7E/6pHq8E39oE0+rTMsCuzMN7wRqrpmuZW6UNt8kwcdRmp
 Th2g3FWpUgCiMMC6m/HJlyhZTGm03ZAqhQAM6DRvSwWdJEDKbyEcUZdPbOIVA6waRU
 LHnTkk+2O3EZZ1tBSmfykO41t0W+5Ad0O77Qn+NOzi4dzv0EOmOblwkYh2aO21Rb5E
 EUNpgFd0RtJL/2XpJPiU1tjR7gaDw8x1qQCs/W8lHDeaFIsSVGMeuCIS4MEtip7OJi
 lvCVuopXBcPVQ==
Date: Fri, 17 Dec 2021 13:24:50 -0800
From: Keith Busch <kbusch@kernel.org>
To: Daniel Wagner <dwagner@suse.de>
Cc: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, Keith Busch <keith.busch@wdc.com>,
 linux-nvme@lists.infradead.org, Chaitanya Kulkarni <kch@nvidia.com>
Subject: Re: [PATCHv2] nvme: add 'iopolicy' module parameter
Message-ID: <20211217212450.GA4167229@dhcp-10-100-145-180.wdc.com>
References: <20211217150222.142014-1-hare@suse.de>
 <20211217180358.6j65izoebwk3raea@carbon.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211217180358.6j65izoebwk3raea@carbon.lan>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211217_132458_299318_996C4B2F 
X-CRM114-Status: GOOD (  14.08  )
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

On Fri, Dec 17, 2021 at 07:03:58PM +0100, Daniel Wagner wrote:
> On Fri, Dec 17, 2021 at 04:02:22PM +0100, Hannes Reinecke wrote:
> > +static int iopolicy = NVME_IOPOLICY_NUMA;
> > +module_param(iopolicy, int, 0444);
> > +MODULE_PARM_DESC(iopolicy,
> > +	"Default multipath I/O policy; 0 - NUMA (default), 1 - Round-robin");
> > +
> > +void nvme_mpath_default_iopolicy(struct nvme_subsystem *subsys)
> > +{
> > +	subsys->iopolicy = iopolicy;
> 
> Wouldn't make sense to check if iopolicy has a valid value too?
> 

Even better would be to ensure the iopolicy can never be invalid in the
first place. If the module param is invalid, then the sysfs attribute
for it will run off the end of the array, among other problems.

The sysfs toggle already ensures a valid iopolicy, so just need
something similar for the module parameter. You can append a callback to
the module parameter (module_param_cb) to enforce valid values only, and
I think using that would be appropriate here.

