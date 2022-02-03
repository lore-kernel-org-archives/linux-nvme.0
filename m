Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B1EFC433EF
	for <linux-nvme@archiver.kernel.org>; Thu,  3 Feb 2022 16:55:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cpQ1Mp2ClyF5htsCdEVCEmstDBlcaB8dwtTZPOS+eL4=; b=d9cP6vUjzvmRkH+dvkoJ5Sr/CU
	g+xgtrwVxgjiPrwC4v/JvMUEfXIKls/06s+N4Sa0f4xGziTFz49I8SV5XeAjhWEjC0cvaHFgwwsD2
	sAOnd5ZVzWuxDQo99zWozHsW5EYny2on3/ZFgdykfcXr8KzkGElToSAgZ9i/0NaC5U84BX2wvZOvP
	Jpl6jQ6re3kM4cmuYmDp4ZEln5dpYP43ubDYoqlxfQPMA2LVWiwYaSpg3NHUwG4T1QpGS8rpN+bzZ
	3UepPtZV+u0aJ0cIyVnJD8xkyVSyc92HHd/VT77Yn0kuZmDG3EsQ8Ruv7cb2O04DembXsnQ7AipXp
	VjI82fdg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nFfOM-0023LK-DD; Thu, 03 Feb 2022 16:55:30 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nFfOJ-0023Kd-Oi
 for linux-nvme@lists.infradead.org; Thu, 03 Feb 2022 16:55:28 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id EE2EF615AC;
 Thu,  3 Feb 2022 16:55:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC8D7C340E8;
 Thu,  3 Feb 2022 16:55:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1643907326;
 bh=Y3oXeb2rdvl0m/0lludmJ65Qgn9tZhoKvBnSiX8nlO4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=h69sBuRIdhnW6gfdCUyfCc3HtXkp0KngK2axJ43udIbYmzJgEr+Xycq1m9wqMkDFq
 AOqYjNefat4KEykhYi7hoIVs/0P7LHsy/oo+5qtFLMa14Vyz+0P6L3QQq3mTlp3jyy
 uKfF2TvygWGDTcJItL4PaKb3k1JlsRQKnEiOzkF4ad/9HzJXRTQWGtPxFCH8DFT0qw
 iWASEgoOHdqfIU9Kkf0EPlCOinZhnOCFz7yfqQRbyHBcvt3/omZhwriECSE6BMCSnu
 WKxp1XEvuTmcsnOVm0RfNKnAL7C34/eoQXnzjZ9mdi++wXzu2DL/uunJciygOmJeOh
 jaNX6EzbVoOxg==
Date: Thu, 3 Feb 2022 08:55:23 -0800
From: Keith Busch <kbusch@kernel.org>
To: "Belanger, Martin" <Martin.Belanger@dell.com>
Cc: Hannes Reinecke <hare@suse.de>, Martin Belanger <nitram_67@hotmail.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "axboe@fb.com" <axboe@fb.com>, "hch@lst.de" <hch@lst.de>,
 "sagi@grimberg.me" <sagi@grimberg.me>,
 "Hayes, Stuart" <Stuart.Hayes@dell.com>,
 "Rose, Charles" <Charles.Rose@dell.com>
Subject: Re: [PATCH 2/2] nvme: Expose cntrltype and dctype through sysfs.
Message-ID: <20220203165523.GB142129@dhcp-10-100-145-180.wdc.com>
References: <20220202213451.33599-1-nitram_67@hotmail.com>
 <BL0PR13MB4291C612318AC862FDDEB7719C279@BL0PR13MB4291.namprd13.prod.outlook.com>
 <49b2d58e-80b4-94f2-77ef-c2d1ec19e581@suse.de>
 <BLAPR19MB45318B8797176BF97BAB0A30F2289@BLAPR19MB4531.namprd19.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BLAPR19MB45318B8797176BF97BAB0A30F2289@BLAPR19MB4531.namprd19.prod.outlook.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220203_085527_874822_87103040 
X-CRM114-Status: UNSURE (   8.38  )
X-CRM114-Notice: Please train this message.
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

On Thu, Feb 03, 2022 at 11:59:33AM +0000, Belanger, Martin wrote:
> 
> Internal Use - Confidential

This is not appropriate for public mailing lists. I assume it's some IT
policy auto-appending it, but I'm sure there must be ways to remove it.

