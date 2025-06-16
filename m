Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F6DEC71155
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Jun 2025 12:43:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7tCOtFMu510pDT64Ss1x2pgqP1AqQ3/fZ3/P/JpQkFw=; b=kULG+Sx+NYyle3iSdwELzqxFe4
	6a6hCkjgXwKC7s0cQXkcKTdkDHjUB6RTAnV5LmslrdnlhiNU3T87jmU3P302mY08bebyh+QXkJh8I
	8xObZOCgbgzk3jXJHVmUI+NO0gI85C1YUMjglIMd+rwMDf1EaTHOhd5wFVYXhEaqbBa6ZkP3C+Nzz
	SNK/nqE8sXbr5OTHqYOBdKg4CTfZY4upKFpmOrrq8qsS1W80o79kp0p1zbJI8ey99lkSmcOMWZvJO
	ShwnVjVPQ+BZwa289Q0ZgfqLuts93BEO+j6JwxL+GUPG1hW/kfVmwhLogcRJty2eSuvuF1vyNEixR
	Wrhw6V0A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uR9Bo-00000004PGZ-03kZ;
	Mon, 16 Jun 2025 12:43:52 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uR8A2-00000004Duu-3Hor
	for linux-nvme@lists.infradead.org;
	Mon, 16 Jun 2025 11:38:01 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 65D3267373; Mon, 16 Jun 2025 13:37:55 +0200 (CEST)
Date: Mon, 16 Jun 2025 13:37:55 +0200
From: Christoph Hellwig <hch@lst.de>
To: John Garry <john.g.garry@oracle.com>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
	Yi Zhang <yi.zhang@redhat.com>,
	Alan Adamson <alan.adamson@oracle.com>
Subject: Re: [PATCH 2/2] nvme: fix atomic write boundary validation
Message-ID: <20250616113755.GA22348@lst.de>
References: <20250611055432.2401372-1-hch@lst.de> <20250611055432.2401372-3-hch@lst.de> <19e6e970-9bda-4822-8c86-e3387b1b4594@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <19e6e970-9bda-4822-8c86-e3387b1b4594@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250616_043758_967936_8CA574BB 
X-CRM114-Status: GOOD (  16.48  )
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

On Mon, Jun 16, 2025 at 11:19:44AM +0100, John Garry wrote:
> On 11/06/2025 06:54, Christoph Hellwig wrote:
>>   		ret = nvme_init_effects(ctrl, id);
>>   		if (ret)
>>   			goto out_free;
>> +
>> +		ctrl->subsys->awupf = le16_to_cpu(id->awupf);
>>   	}
>> +
>> +	if (le16_to_cpu(id->awupf) != ctrl->subsys->awupf) {
>> +		dev_err_ratelimited(ctrl->device,
>> +			"inconsistent AWUPF, controller not added (%u/%u).\n",
>> +			le16_to_cpu(id->awupf), ctrl->subsys->awupf);
>
> Could we just disable atomic writes instead of doing this?
>
> Or are there bigger issues, like the value returned from 
> nvme_update_disk_info() for setting the physical block size is just not 
> valid?

This brings up back to the old problem of how do we tell the file system
and/or application that the atomic write size it probed suddenly went
away entirely because a new controller disappeared.


