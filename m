Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F632CFA44F
	for <linux-nvme@archiver.kernel.org>; Wed, 23 Oct 2024 16:06:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FCTi+vAR5nzDL4Eh/Sdb1xFjL5xZH+hXG0IGEPab2V8=; b=Y3Tj5cBJHx3fsvFZo4yGYdo0ed
	GGAW+F3Fv8+Iq70XSO+Lck/Gxct/u93g6GKuPmVq7Z9n8HGBRc3/+Ipfivt/vl+q3ZbbJuaLpCiK9
	+/3/UYgYsAcTl8fPa/JX1zHLLaA0yb0oUdQWe7tcokUW0T3i+i50fRBZBtkSPgD/Dq+z5pktOOQQR
	3gbeOWirOh0aVhVvOsQidmJEeef+OCkBbhvlUtAJhZVExFJEx+MtMfo5m1hS7fN5kEP1k01ARq/06
	//TyOBqRsUJDJH6HkkukNP6k1GopSnBZgpGcoJW3lU7puLuKXczcEdjY7yKf4VuAvY2oR/GmJvebz
	/kekNInQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t3dsX-0000000F4vO-2ffk;
	Wed, 23 Oct 2024 16:06:33 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t3d1T-0000000Ety3-3t5A
	for linux-nvme@bombadil.infradead.org;
	Wed, 23 Oct 2024 15:11:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=FCTi+vAR5nzDL4Eh/Sdb1xFjL5xZH+hXG0IGEPab2V8=; b=LqK/V/4Puumrt7uoHNZGn6YKeU
	FJyxpZY9MeAz2Yj3/16PsSOXVUMcCt3QpIHpyCdbS2pWkX2JcFPGMRCTXr2Z1FoZyzzgc3cz+tV8W
	jY6g4742fgwGjFz3SyqUk3FK33H4izpGa99OGzknoKxq//WmTRGOK8rTtea1iIyN6jbLvEz0PBeiU
	No9L9axx77B7geOai3RW6x7FLFNFYMxtLkcFCzYRAYdHLkEzGsAbNVChyFC6oNGAwEwF7hANCbXbQ
	HVXfpE2Qcv45S+co/2UZdcoNVTteU607b9f0uD3XFjuoe6/ROjlKNmNwNb1TWG5TBCbJ5dHBiB57Q
	vI3rxA8A==;
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by desiato.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t3d1Q-00000008QpJ-1j0Z
	for linux-nvme@lists.infradead.org;
	Wed, 23 Oct 2024 15:11:42 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 619605C537B;
	Wed, 23 Oct 2024 15:11:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A94CC4CEC6;
	Wed, 23 Oct 2024 15:11:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729696295;
	bh=7Ci+1VRRQAeGgpY4mOg7BY4y0w6hvWCuk9NHiqCnv1Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Svf45+sGTdavvppxxmZK5HAawuPXuAo9zf/wp6dnv47MK9EH2uW6G+7yuU64NGUNG
	 Gapg6DHyDJyf/ux/1flJtMWwUNk+zw2vQsWFSsrXUjIrMydu3ZBd/ETYAZBr6T4qLT
	 s4Lf9RT0KjlBtIAmUJrFumb3vn+dIEsZJiU9zGewdZNmuA3AK2b7H2054sdjtmZlI6
	 TvgO4jhpp54Swg1lhiI9cWwmNEiPDW/PWih1QOh/JME9TYEe6gVKW9b9EBvsNbA9mQ
	 8sOnAgVJvhGuGLoyuCdLr7qyj+0z6qTx8DnrCeyM9yBJWuksnAklt7BJJnXNFL5tFS
	 BEHk5S9ibpkVQ==
Date: Wed, 23 Oct 2024 09:11:32 -0600
From: Keith Busch <kbusch@kernel.org>
To: Tokunori Ikegami <ikegami.t@gmail.com>
Cc: Christoph Hellwig <hch@infradead.org>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH v4] nvme: change nvme_ns_has_pi() to
 nvme_ns_supports_pract()
Message-ID: <ZxkSJJm54Gs9exWw@kbusch-mbp>
References: <20241023100915.11263-1-ikegami.t@gmail.com>
 <ZxjwAsny4yOUHvUD@infradead.org>
 <Zxj2rPzTGILnrUup@kbusch-mbp>
 <Zxj3xwDyP1j8Y1Ms@infradead.org>
 <Zxj4SDRxSJfca_Wa@kbusch-mbp>
 <a41a55be-dd3d-477b-8eac-27f80da63ed0@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a41a55be-dd3d-477b-8eac-27f80da63ed0@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241023_161140_826980_677EE197 
X-CRM114-Status: GOOD (  22.77  )
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

On Wed, Oct 23, 2024 at 11:44:13PM +0900, Tokunori Ikegami wrote:
> About the mention "The spec says it only works if ms == PI tuple size,
> otherwise it doesn't do anything." do you mention for example the
> specification description below?
> --------------------------------------------------------------------------------
> (NVM-Express-NVM-Command-Set-Specification-Revision-1.1-2024.08.05-Ratified)
> 5.3.2.1 Protection Information and Write Commands
> Figure 166 provides some examples of the protection information processing
> that may occur as a side effect
> of a Write command.
> ...
> If the namespace is formatted with protection information and the PRACT bit
> is set to `1´, then:
> ...
> 2. If the namespace is formatted with Metadata Size greater than
> protection information size, then the logical block data and the
> metadata are transferred from the host buffer to the controller. As
> the metadata passes through the controller, the controller overwrites
> the protection information portion of the metadata without checking
> the protection information portion regardless of PRCHK settings.  The
> logical block data and metadata are written to the NVM (i.e., the
> metadata field remains the same size in the NVM and the host buffer).
> The location of the protection information within the metadata is
> configured when the namespace is formatted (refer to the DPS field in
> Figure 114).
> Figure 166: Write Command 16b Guard Protection Information Processing
> ...
> [figure b]
> b) MD>8 (e.g., 16), PI, PRACT=0: Metadata remains same size in NVM and host
> buffer
> ...
> [figure d]
> d) MD>8 (e.g., 16), PI, PRACT=1: Metadata remains same size in NVM and host
> buffer
> --------------------------------------------------------------------------------
> In the example case b) and d) the 16B MD data should be sent by the host
> application but the driver does not set or handle any 8MD and 8PI. Is this
> understanding correct?

The important point for those MS>8 formats is the host *must* provide a
buffer for the transfer, otherwise you'll get corruption. This means
those formats are not usable if your kernel didn't set
CONFIG_BLK_DEV_INTEGRTY, or you have a fabrics transport that doesn't
support these.

The format where MS == PI size can still work without
CONFIG_BLK_DEV_INTEGRTY or fabrics support because the the pr-action
disables the host<->device transfers.

The function, nvme_ns_has_pi(), is specifically looking for the formats
that don't require the host to provide a metadata buffer. The comment
above the function says exactly this:

  "NVMe ns supports metadata actions by the controller (generate/strip)"

The only time that happens with PRACT is if metadata size equals the PI
size. Section 2.1.5, Figure 9 says this more succiently.

> By the way actually does the kernel nvme driver support the ms >= PI LBAF
> case as correct by the current implementation? (Seems only supported for the
> ms == PI LBAF case only.)
>
>   Note: Only the function nvme_configure_metadata() checks the ms >= PI case
> to set PI type.

It should work fine with any MS>PI size as long as the disk can
successfully register with blk_integrity, which again, depends on your
kernel config and transport type. That block layer can handle protection
information with extra metadata in the same buffer.

