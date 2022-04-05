Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB3DEC433EF
	for <linux-nvme@archiver.kernel.org>; Tue,  5 Apr 2022 05:47:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9N77M9cNjhksGU7BefB3pZOxyUZvmSLN4jDeAwD9K0A=; b=0b1Ob2ZEqpxIpD1wP6Sit3SLP7
	JkHOsbwNE4VJ9ITzfKk9kvxyNlfU8sJK3mBr7ybgaaLovKBn+i/UdcbhqcELC97SMfM6kv8cB4kkv
	IK+oHCdt3Fayq0pNM3KybTKCgrIan2YIR5ly4sGQWLDOgUcPUYypxw/ko6vLYMMijgIM9916cCf3q
	ZHKQFUhgO/t54CDhXV0ML/aKbbqs2VUDeP16pRmdCjyaE/RXzjTIxehvQFNAiXkArKymAbbMNvGUk
	o1svEhJ0HcFQuJZ/UU3dPAusUHygun9xgokLZaJOPeabTZ605SYEkGEO7A0E9rwDvZLQZ3VApi3Ut
	m1DBQbsw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nbc2c-00HCU8-CW; Tue, 05 Apr 2022 05:47:46 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nbc2Z-00HCTB-QV
 for linux-nvme@lists.infradead.org; Tue, 05 Apr 2022 05:47:45 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id EBFE768AFE; Tue,  5 Apr 2022 07:47:40 +0200 (CEST)
Date: Tue, 5 Apr 2022 07:47:40 +0200
From: Christoph Hellwig <hch@lst.de>
To: Hannes Reinecke <hare@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Keith Busch <keith.busch@wdc.com>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 2/3] nvmet: make the subsystem type configurable
Message-ID: <20220405054740.GD23466@lst.de>
References: <20220317142634.49324-1-hare@suse.de>
 <20220317142634.49324-3-hare@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220317142634.49324-3-hare@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220404_224744_041928_694C62D8 
X-CRM114-Status: GOOD (  13.81  )
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

On Thu, Mar 17, 2022 at 03:26:33PM +0100, Hannes Reinecke wrote:
> Make the subsystem type configurable to allow for unique
> discovery subsystems by changing the subsystem type to
> 'discovery'.

Does it make sense to change the type?  Or should we have a new top-level
interface to create and configure discovery subsystems from the start?

If we had e.g.

/sys/kernel/config/nvmet/discovery-subsystems/

we could start that out with a pre-filled well known discovery subsystem
but also allow disabling that for example if we really want.

