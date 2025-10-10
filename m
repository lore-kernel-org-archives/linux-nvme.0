Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C195DCAC5BB
	for <linux-nvme@archiver.kernel.org>; Fri, 10 Oct 2025 07:27:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=31RvU54/5469irRLdiaAeteAtJW+7vuc2gmk3hdfW+s=; b=hFtaDlUKamlZd1q1GKzse/JDL4
	zbv95r1KJ9J+ijHYDvl1iQ+zuEG5vu5lZd6t6Dmot2CbUePYOTDh5PJNZ+LoOSSY5KzJiHtrhUOXT
	7/TGfCO3zaf80qL2W1op0TT258VunU9GBKZA3o5Wn+GOdDMOtWWADupiBPG3xumGEWbW1/Gr9IFwc
	WBHvuKuSRlF7j57At81I+eJPiGE1gMB1OmqfyHIw/bsO5GiDxgs00Zzq3v7xApiqu9Ai3ffdFuOsw
	5193EdC9L4oTzQAQeIKUDmrC25NAM9c3rxpRl+N5WBeXN/QBtFkUw3zv+4ABJ4M8T6OpqYh8u6Qi9
	qBIsIXIw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v77Wt-00000007riF-2xFw;
	Fri, 10 Oct 2025 07:27:07 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v77Wq-00000007rhE-3MEW
	for linux-nvme@lists.infradead.org;
	Fri, 10 Oct 2025 07:27:05 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 907A5227AAA; Fri, 10 Oct 2025 09:26:58 +0200 (CEST)
Date: Fri, 10 Oct 2025 09:26:58 +0200
From: Christoph Hellwig <hch@lst.de>
To: Daniel Wagner <dwagner@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: libnvme API design
Message-ID: <20251010072658.GA17812@lst.de>
References: <9812534f-6a15-4126-a4c0-7b4ae39e327b@flourine.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9812534f-6a15-4126-a4c0-7b4ae39e327b@flourine.local>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251010_002704_977993_0718DE9E 
X-CRM114-Status: GOOD (  19.80  )
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

On Thu, Oct 09, 2025 at 01:07:47PM +0200, Daniel Wagner wrote:
> Hi Christoph,
> 
> As you have suggested the command API should be inverted, that is the
> only stable API will be nvme_submit_admin_passthru and struct
> nvme_passthru_cmd and a bunch of helpers to initialize the cmd.
> 
> I've done updated a bunch of the identify commands and below is the
> result. I think we could reduce the number of helpers a bit,
> 
>   nvme_nvm_init_identify_ns vs nvme_nvm_init_identify_ns_csi.
> 
> Is this what you had in mind

Yes.

> (obviously I haven't gone the whole way to
> macros only, I like some type safty)?

What actual type safety do we actually gain here?

> static inline
> void nvme_nvm_init_identify_ns(struct nvme_passthru_cmd *cmd,
> 			       __u32 nsid, struct nvme_id_ns *ns)
> {
> 	nvme_nvm_init_identify(cmd,
> 			       NVME_IDENTIFY_CNS_NS,
> 			       ns, sizeof(*ns));
> 	cmd->nsid = nsid;

Given that identify includes nsid and just specified how it is
cleared to zero for the non-ns commands, maybe pass a nsid to
nvme_nvm_init_identify to simplify things?

> 	cmd->cdw11 |=  NVME_SET(nvmsetid, IDENTIFY_CDW11_CNSSPECID);

And NVME_SET still feels very oddly name..


