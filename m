Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF65CC433F5
	for <linux-nvme@archiver.kernel.org>; Fri,  8 Apr 2022 05:46:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/rJXrqGxCxJ1EcVkkpsdq1B87jM7PqoRPPeklMr5l8A=; b=oj2Iz9B0PvylaxRrhEtuPrILGT
	dkzqAxkaCZyMZhCZM5zJTN9I2nUC2olCPlOvZNcXsu+S3QO3NFj9KozaWjH63TihfCh3tUEJwBpEb
	hmq5ty6vIivuWjjUEdAe9JzlkyuIuEDt3TRaHQ5bsw9//uCU4M4pkAE7pXLbkDt59LrD2MNMOprAV
	KIngxF0BUflejmBANJmN1mGcY/y+DoC7shDY5H1tS2Se7Vk8KzHU62MGz0XIx6c13XTaudsoOBZ0M
	XQtQZ0xNYcgrKe1J2tQ0ubugU7rk1mCbb8tw/hmXKRlrKNBX4B/vHjzMnG9+fV1Myzppc10fE3LNc
	W/pSdLNA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nchSN-00FC1w-86; Fri, 08 Apr 2022 05:46:51 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nchSJ-00FC1A-Tm
 for linux-nvme@lists.infradead.org; Fri, 08 Apr 2022 05:46:49 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 3983668AFE; Fri,  8 Apr 2022 07:46:45 +0200 (CEST)
Date: Fri, 8 Apr 2022 07:46:44 +0200
From: Christoph Hellwig <hch@lst.de>
To: Hannes Reinecke <hare@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 1/3] nvmet: make the subsystem type configurable
Message-ID: <20220408054644.GC32232@lst.de>
References: <20220407104808.29007-1-hare@suse.de>
 <20220407104808.29007-2-hare@suse.de> <20220407154417.GC15988@lst.de>
 <e2f2a304-0886-606c-a24f-7b7d08663421@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e2f2a304-0886-606c-a24f-7b7d08663421@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220407_224648_172883_B3D74879 
X-CRM114-Status: GOOD (  14.64  )
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

On Thu, Apr 07, 2022 at 06:55:09PM +0200, Hannes Reinecke wrote:
>>> +	down_read(&nvmet_config_sem);
>>> +	list_for_each_entry(p, &nvmet_ports_list, global_entry) {
>>> +		list_for_each_entry(s, &p->subsystems, entry) {
>>> +			if (s->subsys == subsys) {
>>> +				up_read(&nvmet_config_sem);
>>> +				return -EACCES;
>>> +			}
>>> +		}
>>> +	}
>>> +	up_read(&nvmet_config_sem);
>>
>> Does this scale?  Do we want a flag in the subsystem instead?
>>
> Hmm. Seeing that it's a synchronous userspace operation I don't really 
> care; worst case the 'ln -s' call takes a bit longer.
> But okay, I'll have a look.

Well, it is quadratic behavior, wich we generally avoid.  Something
like a counter of enabled ports in the subsystem should easily remove
the need for it.

