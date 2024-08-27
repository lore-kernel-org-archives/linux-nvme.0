Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1555C54734
	for <linux-nvme@archiver.kernel.org>; Tue, 27 Aug 2024 12:34:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:CC:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=43z38L9ck/FEEnaOFK+Qd+eA4TyH6kpruuxAhEBjErA=; b=dffupadK6iOFZgNImnnnagB4Jj
	Q7iHDssAwW71JnYimFtjK4oFc2Hc+A+5RiGozDQ2PHDH7J3rEcxox0L+Udogx8vjU6HHkYWnn0geF
	nWnJu2aOYubWU132N4HZFfyXym7dQV6Eb+N/5KuZVz3K1jDiXoC0FDAnjqEXA7vcOJdohtgZRsBQc
	Y3kWQOF3udOZA0EtWG0rbzblTHvDKjs1XF7CwI2L4+iIyM3cA8tXt20HAXfF12EAXIP32+Bai2OAI
	1IJt4XpLMzPyCNsed2yzxZpS9CWi+43/WjJQtjRcm781k+DnvOb/4hK3j4YuzoYnLmyK9rie3iDjl
	uAhL8q7A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sivPA-0000000BG6j-0nzG;
	Tue, 27 Aug 2024 12:34:36 +0000
Received: from smtp-fw-52002.amazon.com ([52.119.213.150])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sivJb-0000000BESP-2IVC
	for linux-nvme@lists.infradead.org;
	Tue, 27 Aug 2024 12:28:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1724761732; x=1756297732;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=43z38L9ck/FEEnaOFK+Qd+eA4TyH6kpruuxAhEBjErA=;
  b=fzUSfgetbQ19gVxe00wXOTo04WT8wmwMRF7Us+H6cQc/MRnRbQw2ceyn
   eTvW2DJu5sSdhyMR4QN7m8QMzOMqd4rpXgVWa0UmTP0zKP8/QkbAKElgm
   AjlQeJCXe/0l6oZtltKhx8RsTMWT8FwFSWxAW8Bgg/c5uFmlU96Aznk4K
   E=;
X-IronPort-AV: E=Sophos;i="6.10,180,1719878400"; 
   d="scan'208";a="655082231"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52002.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2024 12:28:48 +0000
Received: from EX19MTAUEC002.ant.amazon.com [10.0.0.204:63259]
 by smtpin.naws.us-east-1.prod.farcaster.email.amazon.dev [10.0.24.174:2525] with esmtp (Farcaster)
 id 0e9731a8-47bb-4d71-8b54-f4fd6c78971e; Tue, 27 Aug 2024 12:28:47 +0000 (UTC)
X-Farcaster-Flow-ID: 0e9731a8-47bb-4d71-8b54-f4fd6c78971e
Received: from EX19MTAUEB001.ant.amazon.com (10.252.135.35) by
 EX19MTAUEC002.ant.amazon.com (10.252.135.253) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Tue, 27 Aug 2024 12:28:46 +0000
Received: from dev-dsk-pjy-1a-76bc80b3.eu-west-1.amazon.com (10.15.97.110) by
 mail-relay.amazon.com (10.252.135.35) with Microsoft SMTP Server id
 15.2.1258.34 via Frontend Transport; Tue, 27 Aug 2024 12:28:45 +0000
Received: by dev-dsk-pjy-1a-76bc80b3.eu-west-1.amazon.com (Postfix, from userid 22993570)
	id 99C8920A60; Tue, 27 Aug 2024 12:28:45 +0000 (UTC)
From: Puranjay Mohan <pjy@amazon.com>
To: Christoph Hellwig <hch@lst.de>
CC: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, "Christoph
 Hellwig" <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	<linux-nvme@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<puranjay@kernel.org>
Subject: Re: [PATCH] nvme: check if the namespace supports metadata in
 nvme_map_user_request()
In-Reply-To: <20240827121955.GB1607@lst.de>
References: <20240827121701.48792-1-pjy@amazon.com>
 <20240827121955.GB1607@lst.de>
Date: Tue, 27 Aug 2024 12:28:45 +0000
Message-ID: <mb61pjzg2gneq.fsf@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240827_052851_804896_0F82C076 
X-CRM114-Status: GOOD (  10.66  )
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

Christoph Hellwig <hch@lst.de> writes:

> On Tue, Aug 27, 2024 at 12:17:01PM +0000, Puranjay Mohan wrote:
>> +	if (meta_buffer && meta_len && bdev && !blk_get_integrity(bdev->bd_disk))
>> +		return -EINVAL;
>
> Overly long line here.  If we go past my initial RFC I'd probably
> restructure the function a little bit, i.e. add a new
>
> 	bool has_metadata = bdev && meta_buffer && meta_len;
>
> and then use that both for the support check and the actualy mapping
> below.

Sure,
I will send v2 with these changes now.

P.S. - It looks like we will need manual backports for stable kernels as
this won't apply directly. I will send them after this is accepted.

Thanks,
Puranjay

