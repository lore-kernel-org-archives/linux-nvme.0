Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FF35C433F5
	for <linux-nvme@archiver.kernel.org>; Thu,  7 Apr 2022 09:12:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cpqwMyQIg/GHA3HLBnEVr2xPXAOdYjqHUrWcTSysHLI=; b=r7X2aJ8FUOjW0/qrpIuS2TDmEY
	9BhI4FSvYLKo8hNMAfvPuzE6B0WJngUu+QHo1WbnLWSY2prO9iACurcHbJTL1Qzox+wPisWTTRzA+
	Ti5x5Uj8okXxK8HrP44YA2PF41dsFYXMyVoVyHQ2MUcRtxnrOB82xAVO0RaTCb3cepcmO90FIFX3W
	rg/jGPNO0h81L0zZ6AQWm75yWv0R5E6nBTmG8i/nRSKv7abclJ/eOLi98sAzcvvmSCojcFZiNOBlM
	t2300nDm0ySr603nSMxyYpWVyNr/jUU4r/8Ik16daMTujcRcCGax3ezmprAeg8rAtHxMWWPEW/mhB
	IWA+9C9g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ncOBf-00AjXi-R2; Thu, 07 Apr 2022 09:12:19 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ncNrK-00AaF5-9t
 for linux-nvme@lists.infradead.org; Thu, 07 Apr 2022 08:51:19 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 1629668BEB; Thu,  7 Apr 2022 10:51:13 +0200 (CEST)
Date: Thu, 7 Apr 2022 10:51:13 +0200
From: "hch@lst.de" <hch@lst.de>
To: Alan Adamson <alan.adamson@oracle.com>
Cc: Keith Busch <kbusch@kernel.org>,
 Chaitanya Kulkarni <chaitanyak@nvidia.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "hch@lst.de" <hch@lst.de>
Subject: Re: [PATCH] nvme-core: mark passthru requests RQF_QUIET flag
Message-ID: <20220407085113.GB19062@lst.de>
References: <20220406164109.30449-1-kch@nvidia.com>
 <Yk3FT78uVW+9rRV5@kbusch-mbp.dhcp.thefacebook.com>
 <21a3a237-5f3b-a608-2d79-e0a5fdcc0d88@nvidia.com>
 <Yk3MNrI3YfjvbRqZ@kbusch-mbp.dhcp.thefacebook.com>
 <92C8BCED-6845-46D4-BCD0-78E790A5F86E@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <92C8BCED-6845-46D4-BCD0-78E790A5F86E@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220407_015118_586505_F7685857 
X-CRM114-Status: UNSURE (   8.90  )
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

On Wed, Apr 06, 2022 at 10:06:06PM +0000, Alan Adamson wrote:
> Using RQF_QUIET or blk_rq_is_passrhrough() will mean no nvme admin-passthru command will log an error.
> I ran into this using the blktests I’m coding up for verbose errors.  Is this the behavior we want?

Well, you submitted the logging so we're curious about your use case.
SCSI skips logging errors for internally submitted commands, but not for
userspace passthrough.  So we could move the RQF_QUIET into
__nvme_submit_sync_cmd / nvme_keep_alive_work / nvme_timeout / etc.

