Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B97ACC00144
	for <linux-nvme@archiver.kernel.org>; Mon,  1 Aug 2022 16:39:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=K6XYuMRS7DfCVOppKpAixwOtdxeMhJkaDPq19UUZPMk=; b=Wnt0f67LFWJ1B343PEGKeNL9gR
	zeRWtKuMLxUXau59M0nj/1PH9KttO9PGfU0i7wJh/nym36iHCwDmusP646xKb7TLiyx1rl16T7qHp
	HFEyGWCR3KXaWgc2rRtX11fIQbRyBw49FmeCJz4/qwLOIC+NEy6WsIugBTygCulzV2mDtHf119ECY
	dFr4PGY9nQGX7gPGyfRyO2mfB1Dh9/ikqqFX3RhpDCfb1tWsBxbktgqlv6r7u+y05k3blK9AWUb+r
	K2BUMrPNMhLYzaheu3j004F8tFljwK3ngqOXzRl7EPgZI6iLfclF3enHjJkNEqQ49oleHlkU2RUCe
	SDpRMevg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oIYS8-007wfr-0P; Mon, 01 Aug 2022 16:39:36 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oIYS5-007we9-AE
	for linux-nvme@lists.infradead.org; Mon, 01 Aug 2022 16:39:34 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id D995660F9C;
	Mon,  1 Aug 2022 16:39:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1AD7C433D6;
	Mon,  1 Aug 2022 16:39:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1659371971;
	bh=if7VBHOoZbEUD1MUL0+fP/8g7PG6scZwLZIokPqEyWI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EUkzQcEHreSpYLeh33GNEcpx7ftvc74QdtaEedpg5VK7chy0e8EkCSqqnA1zD20mv
	 PZokdVxbuPfPGifEQY2jbO4u2qj52sANSDS8ePB6TKO/DHCuw3jEbuZe3r5do0FTA7
	 wtQYVggedYkt0ATDmMgDjNbsKynl8QLmBv7zIumeSxz0AjP1vH4/OO3DuM6xmTnLNW
	 PnOfMpj9bwF31//u4CI2P40bjMSeU7tHv0pLLu3/0CefCTsifUIFTyiO8LAOvcdS+O
	 lN5ms98LAtlRLUJOPDgdQA1zxR4OlmCRT6dwElYp/ZuJlA1vRDmYLo/qY3DfncAIqp
	 oM3tlzNo0YOzQ==
Date: Mon, 1 Aug 2022 10:39:28 -0600
From: Keith Busch <kbusch@kernel.org>
To: Gilles BULOZ <gilles.buloz@kontron.com>
Cc: Chao Leng <lengchao@huawei.com>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: NVMe write protection support
Message-ID: <YugBv1bYQMj4A9+m@kbusch-mbp>
References: <DU0PR10MB62528F66099C2311E2AF1EEE809A9@DU0PR10MB6252.EURPRD10.PROD.OUTLOOK.COM>
 <90b10a73-4c32-4a84-97b4-88f5a926c771@huawei.com>
 <1070fdd5-c1bb-92bd-c5f0-9efd9d88d518@kontron.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1070fdd5-c1bb-92bd-c5f0-9efd9d88d518@kontron.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220801_093933_644436_76630CFB 
X-CRM114-Status: GOOD (  28.43  )
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

On Mon, Aug 01, 2022 at 02:41:45PM +0200, Gilles BULOZ wrote:
> Thanks Chao for your suggestion : "Suggest: set the NSATTR of namespace to 1 when identify namespace."
> Also thanks to Andrey Kuzmin for his private reply : "It sounds like the
> kernel nvme subsystem is either ignoring or misinterpreting the status code
> returned by the controller in the write completion. Per spec, an attempt to
> write to a write-protected namespace must be declined with 'Namespace is
> Write Protected' status code (see Nvme Command Set Spec. Fig. 67 for
> details) which, apparently, isn't critical wrt the device itself."
> I'll check all this with our NVMe manufacturer

The driver doesn't do anything special with the "Namespace is Write Protected",
status so that should get a generic IO Error if the device was returning that.

The driver will currently return a Medium error block status if we get a
"Attempted Write to Read Only Range" nvme status, though. Maybe that would make
more sense as a target error.

 
> Le 01/08/2022 à 12:01, Chao Leng a écrit :
> > 
> > On 2022/8/1 16:36, Gilles Buloz wrote:
> > > Dear developers,
> > > In case an NVMe module has a write protection feature, what is the
> > > best  method for the NVMe to tell the kernel it is write protected
> > > (if any),  and how the kernel should handle a write to such a module
> > > ?
> > Suggest: set the NSATTR of namespace to 1 when identify namespace.
> > > As computer manufacturers, we had a request from some customers to
> > > have the NVMe module fully write protected (fpr safety). So we asked
> > > our NVMe manufacturer partner to add thiss feature to their NVMe.
> > > But the problem is that if a write is done to this module while it
> > > is write protected, the kernel treats it as "critical medium error"
> > > (giving something like this in the dmesg : blk_update_request:
> > > critical medium error, dev nvme0n1, sector 977537456 op 0x1:(WRITE)
> > > flags 0x800 phys_seg
> > >   2 prio class 0).
> > > OK, no write should be attempted if the write protection is enabled,
> > > but this critical medium error is maybe too much because the disk is
> > > actually not damaged and read is still possible.
> > > For SATA devices I see that we have a message like that in dmesg :
> > > "sd 6:0:0:0: [sdb] Write Protect is off", but nothing like this for
> > > NVMe. So maybe the write protection is not supported/expected for
> > > NVMe devices ?
> > > Thanks
> > > .
> > > 
> > .
> 
> 

