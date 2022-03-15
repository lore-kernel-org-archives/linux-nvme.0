Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFD70C433F5
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Mar 2022 08:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JgO/bcnaowmbkBQln5efK1Le/ytjaeIo6kTm9T5yG38=; b=cAYfP4F5Im0Lp3NXGocerYT5+o
	L90KayV/Z3pcfrwA8vuV4jxCW3LEY765WMaawjZUCBdBcNSXTesprWnOyDHGG7NcgQKlEO51oJ9C0
	2OHBIHCAbcGgcoTydIcLxMyzwMQtFca55GOpuAFpJUPWfpVnoBZjjUk5j/jaRndfzVSQAx9Uwl6Jb
	jBnyciOSWyoaFI1/4CeHxSjyaHjNvljRqJcNVSUArJp39/9vpgIMXRhCQlvVBu3Byt8FQKciWX0Y9
	5+oANKC16z7c7/D3pehwP6PqZSnEvVV+6v5HWcTmEPe2sNIdwKzvgwnITGm2cuTi/vfhr5Nr4Lsfr
	j474ugoA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nU2G4-008ENL-RX; Tue, 15 Mar 2022 08:10:20 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nU2G1-008EMQ-Nk
 for linux-nvme@lists.infradead.org; Tue, 15 Mar 2022 08:10:19 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 1D6FF68AA6; Tue, 15 Mar 2022 09:10:14 +0100 (CET)
Date: Tue, 15 Mar 2022 09:10:13 +0100
From: Christoph Hellwig <hch@lst.de>
To: Hannes Reinecke <hare@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Keith Busch <keith.busch@wdc.com>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 3/3] nvmet: do not allow to create a subsystem with the
 discovery NQN
Message-ID: <20220315081013.GC3082@lst.de>
References: <20220314105333.56714-1-hare@suse.de>
 <20220314105333.56714-4-hare@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220314105333.56714-4-hare@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220315_011017_950761_6D3F414A 
X-CRM114-Status: GOOD (  13.68  )
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

On Mon, Mar 14, 2022 at 11:53:33AM +0100, Hannes Reinecke wrote:
> configfs will only protect us against duplication of subsystem NQNs,
> but discovery subsystems might have two NQNs, the standard discovery NQN
> (which will be used as the configfs directory name), and the additional
> unique subsystem NQN.

This is something that we should probably pick up as fix ASAP.  Can
you add a proper fixes tag and submit it stand-alone?

