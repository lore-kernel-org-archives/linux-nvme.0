Return-Path: <SRS0=mQhi=PX=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6561C433F5
	for <linux-nvme@archiver.kernel.org>; Thu,  4 Nov 2021 07:23:13 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6AA6161108
	for <linux-nvme@archiver.kernel.org>; Thu,  4 Nov 2021 07:23:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 6AA6161108
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0FnS/ihla672fO24mrKK3fI46lfyVOAVx0YtjaBr+W4=; b=m/E7sm9ij7H7vgNDUo0J8wijXA
	AM6WIx1rhI72ZwctfsMov07kz4DUWkc1HFNDtL2B2DJ5WkrnTWOXQc4w9P/gcd+qEtrD8Xdti9PiN
	8GOovXwbKS4/s20W0F1pINsHRUIn0irCOYI6ahh3/0IdfpbVZF+zWA2eFa4RNRxKoN//cxhkhlM4p
	t8s9FazbnU+p0S2BfKTwzPdH5ck4Vcq7Nidzk3LM3b8kxNFRHH/9pHVFlfkVSu0DWh2foycxUjhUn
	eLANKlbLC0jY0U0nTu2YNsNXW24wk7VodAZOda44Vxi1QHbvqvkveXv1o2DdmmQ6N/wXFw4+6Ejyk
	80esPGMg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1miX5Y-008B48-Ko; Thu, 04 Nov 2021 07:23:08 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1miWxR-0089ND-TW
 for linux-nvme@lists.infradead.org; Thu, 04 Nov 2021 07:14:47 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 4A62468AA6; Thu,  4 Nov 2021 08:14:40 +0100 (CET)
Date: Thu, 4 Nov 2021 08:14:39 +0100
From: Christoph Hellwig <hch@lst.de>
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: linux-block@vger.kernel.org, linux-raid@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
 target-devel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-xfs@vger.kernel.org, dm-devel@redhat.com, axboe@kernel.dk,
 agk@redhat.com, snitzer@redhat.com, song@kernel.org,
 djwong@kernel.org, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
 jejb@linux.ibm.com, martin.petersen@oracle.com,
 viro@zeniv.linux.org.uk, javier@javigon.com,
 johannes.thumshirn@wdc.com, bvanassche@acm.org,
 dongli.zhang@oracle.com, ming.lei@redhat.com, osandov@fb.com,
 willy@infradead.org, jefflexu@linux.alibaba.com,
 josef@toxicpanda.com, clm@fb.com, dsterba@suse.com, jack@suse.com,
 tytso@mit.edu, adilger.kernel@dilger.ca, jlayton@kernel.org,
 idryomov@gmail.com, danil.kipnis@cloud.ionos.com,
 ebiggers@google.com, jinpu.wang@cloud.ionos.com,
 Chaitanya Kulkarni <kch@nvidia.com>
Subject: Re: [RFC PATCH 0/8] block: add support for REQ_OP_VERIFY
Message-ID: <20211104071439.GA21927@lst.de>
References: <20211104064634.4481-1-chaitanyak@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211104064634.4481-1-chaitanyak@nvidia.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211104_001446_142538_5E939226 
X-CRM114-Status: UNSURE (   8.60  )
X-CRM114-Notice: Please train this message.
X-Mailman-Approved-At: Thu, 04 Nov 2021 00:23:05 -0700
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

What is the actual use case here?

