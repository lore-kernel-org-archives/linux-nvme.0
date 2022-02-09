Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C95EC433FE
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Feb 2022 07:53:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=a3C1Ia2fPQvJ2jHdpSYVkre4n72E08491jrojoCfRv0=; b=xzjYJO/tR93MBvaqCFJ1S/1aTO
	W3aqVfQIZ0EZntLrkKUSMTqsiD+5+/ZIGGmVu8roMWMLDgb2Pa7vyYTjsWk1H45cyZCjM5m6ciXjb
	kRTASkDJfjdUBld6sp80YLkbxKJppl+FFgj/VCpyKv/mITGKYLQsJCYvjIs3nt1lhOVFLE6EVpA66
	twZmTW904lkf9iJl0uQIhs4112z0YknmkCsYdQcz70q7Z8we5b3NWbtF35Z0FuPovo/QidII8hHCB
	/1bggyDFlADJjmmkZwQ51RhBCXqq4ALcIn+uE8eiEvPVg8BodSxCQBaS7NpZXk/8+M11TvSPj+Jr0
	8oXjQvqA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nHhme-00GXWH-6z; Wed, 09 Feb 2022 07:53:00 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nHhmb-00GXV7-3f
 for linux-nvme@lists.infradead.org; Wed, 09 Feb 2022 07:52:58 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 5053F68AFE; Wed,  9 Feb 2022 08:52:54 +0100 (CET)
Date: Wed, 9 Feb 2022 08:52:54 +0100
From: Christoph Hellwig <hch@lst.de>
To: Bean Huo <huobean@gmail.com>
Cc: kbusch@kernel.org, axboe@fb.com, hch@lst.de, sagi@grimberg.me,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 beanhuo@micron.com
Subject: Re: [PATCH] nvme: add nvme_complete_req tracepoint for batched
 completion
Message-ID: <20220209075254.GB9647@lst.de>
References: <20220207232806.411801-1-huobean@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220207232806.411801-1-huobean@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220208_235257_333580_64ECF271 
X-CRM114-Status: UNSURE (   8.01  )
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

applied to nvme-5.17.

