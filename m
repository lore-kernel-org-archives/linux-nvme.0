Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76C83C43334
	for <linux-nvme@archiver.kernel.org>; Wed,  6 Jul 2022 16:35:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xdo/5JtnlIb6RMWfoDtgacKgN09MJQhcviMxVDzNNpY=; b=AZMqijfnyl8JoF76Rkc3g+Btqa
	jPVXARQneU/bmfgc3ZejvU10v+mEcgCAQ55nVai85kpBOV+feuWsJRJOYsjVblSsntGoTH53UNoOd
	E/HgaHdKWSPaJTE+RFibtTQFZz1gu0GfVnL9njIy5/d3Gt554+CLIYxOLnwNyuKtGfcXpwDGkNNhy
	Z9g9E8gry/VWwlxDsypu9YDb+lU1vSK+Bxszf7TeXEDuPX8DvIxxgLm+XueExImRCSAG9Q+ty+ECM
	PTw40T7WCPb//44geFwrbEqirqNZbYZ+g3uLBq54JkuW3UI/wJiYSyZrRcl2jdH0SkahsotOQKlTh
	q2gJRpOQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o97zy-00BOEf-Sc; Wed, 06 Jul 2022 16:35:34 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o97zv-00BOD9-C4
	for linux-nvme@lists.infradead.org; Wed, 06 Jul 2022 16:35:33 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id A93B568B05; Wed,  6 Jul 2022 18:35:28 +0200 (CEST)
Date: Wed, 6 Jul 2022 18:35:28 +0200
From: Christoph Hellwig <hch@lst.de>
To: Hannes Reinecke <hare@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
Subject: Re: [PATCHv18 00/11] nvme: In-band authentication support
Message-ID: <20220706163528.GA2388@lst.de>
References: <20220627095207.105201-1-hare@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220627095207.105201-1-hare@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220706_093531_621382_8695AB94 
X-CRM114-Status: UNSURE (   8.12  )
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

Thanks,

applied to the nvme-5.20 branch.

