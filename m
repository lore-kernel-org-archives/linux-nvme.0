Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 937D4C001DF
	for <linux-nvme@archiver.kernel.org>; Mon, 31 Jul 2023 05:58:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=h6y91OBFoVTUXIYPFYmDpZb6yvZnL1uNSNSMeZirCqc=; b=sju0ogat66rza+OYuqLEGgY7im
	Kid3d6+ypMu0/F1HACU/77VRyXXlqgjD+SRWOHJxi8choXPETDHdT/2tVxSNbrpkj6CD6FkaVeOq3
	1YZvsTn1U5pbE9fiedkHgc/Jli5J+2lKG5I61lxg9Ctn8E+HI20hsLKcFWjwiLsciP+q6px/PgR6m
	H23YuX2wDJFlN06jCsMvymJMMgax3WPnG2qnr5m24cprFsPVcTaFZamB4bwXV5NroYSLb+cUvLUDr
	CG3GCV4HmAuksMqN7gkwISDY98gTJ9NjsEBX+rq/IxCQaROFt9togzI3IXk9YaJ0LKUG6AAxmQadI
	d5aOkiUg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qQLv4-00E2PW-1c;
	Mon, 31 Jul 2023 05:58:14 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qQLv0-00E2It-1U
	for linux-nvme@lists.infradead.org;
	Mon, 31 Jul 2023 05:58:11 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 0421567373; Mon, 31 Jul 2023 07:58:07 +0200 (CEST)
Date: Mon, 31 Jul 2023 07:58:06 +0200
From: Christoph Hellwig <hch@lst.de>
To: Mark O'Donovan <shiftee@posteo.net>
Cc: linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
	sagi@grimberg.me, hch@lst.de, axboe@kernel.dk, kbusch@kernel.org,
	hare@suse.de
Subject: Re: [PATCH 2/2] nvme-auth: set explanation code for failure2 msgs
Message-ID: <20230731055806.GB30150@lst.de>
References: <20230727134748.4163796-1-shiftee@posteo.net> <20230727134748.4163796-2-shiftee@posteo.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230727134748.4163796-2-shiftee@posteo.net>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230730_225810_643719_906248D3 
X-CRM114-Status: GOOD (  11.81  )
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

On Thu, Jul 27, 2023 at 01:47:48PM +0000, Mark O'Donovan wrote:
> These error cases were not setting an auth-failure-reason-code-explanation.
> This means an AUTH_Failure2 message will be sent with an explanation value
> of 0 which is a reserved value.

I'll leave the final decision to Hannes, but shouldn't we find a common
place, either behind a label or in the body of the function to set
chap->status?  Having to add this in a lot of error labels doesn't feel
very maintainable.


