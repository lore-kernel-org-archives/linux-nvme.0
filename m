Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 625DFC433EF
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Mar 2022 07:43:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IznW8wrmCBZkD5BwAGQiSM8eU+KwdXLI6muGuQ/WvVM=; b=yLaHnaJWMKOSLpFUkQu28bL7aa
	jLtOfqVzbz36GVLN9uCSrQFYF0NpRhBBat8iwTaB4jChvONze2D34uClxMIZNN0GE7uXFRrhmr+Hr
	5U1vCHLSDxuNNqNdEddVTuw6ouS5uhzkwPenVYMt/G7PLit3pvQvzwinQEQgL7zJolMHRxF3OeUxy
	4Q5OexBtzz42v3YA3qi8byLeFFXVJ4xImjOglh4lubhhGwp7I0t+egCTTT0n/RQVo4UWFWlEkFMor
	aoyDooSrLQOUkCwQIuB0kS4BG/QDZAfOjCDAHJlBdc7RDxYLyXGNrSKSGEYFBQnI/4XSmpt470U0/
	QHVOpCKA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nTfMf-004CCc-Dd; Mon, 14 Mar 2022 07:43:37 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nTfLw-004Bo6-GA
 for linux-nvme@lists.infradead.org; Mon, 14 Mar 2022 07:42:53 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id C2BC068AFE; Mon, 14 Mar 2022 08:42:49 +0100 (CET)
Date: Mon, 14 Mar 2022 08:42:49 +0100
From: Christoph Hellwig <hch@lst.de>
To: Chaitanya Kulkarni <kch@nvidia.com>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me
Subject: Re: [PATCH 0/2] nvmet: nvme_excute_get_feat() cleanup
Message-ID: <20220314074249.GB4570@lst.de>
References: <20220309174308.41832-1-kch@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220309174308.41832-1-kch@nvidia.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220314_004252_713696_20E4F2B2 
X-CRM114-Status: UNSURE (   8.06  )
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

applied to nvme-5.18.

