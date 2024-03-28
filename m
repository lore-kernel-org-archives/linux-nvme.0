Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0970C54E67
	for <linux-nvme@archiver.kernel.org>; Thu, 28 Mar 2024 06:18:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OK7i87kZkjYLoO9/CO9cjm8bHRXTx+x5nN6c744bJsI=; b=xtvTHQNQ/zMpdev4VfGVDZ9T5w
	7Xxp44XhwJP+zDOlO6mcNxd2nY3cwgbeoQce0ZLbMnJNC73KsISJ3fuac4YoApl8LIxrgqNmLp6EK
	BfFP/5iU9ApcZQvTqeQYzzt1wKkL6gswGuw7VkktkNUtJdywJ/8aPQxfP7WBwPAAs66SwbCRsXyv+
	eJn+kJnw8SIMaItQxvGLqrp3lRtneu0YA421uRFlajc/F2s3mif1HI+9zosBSJZQkgCInsnV8oHDt
	lkewMsDJZFEPSsXQwlAoTC5vuEQxarSQpCTZ9vyO/0RnabYtwx0Cj4AuWIKz9EKIeoVXuLXip/Cgn
	YawuXsXQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rpj6E-0000000Ch2Q-0PyL;
	Thu, 28 Mar 2024 06:18:54 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rpj6A-0000000Ch1x-3zPQ
	for linux-nvme@lists.infradead.org;
	Thu, 28 Mar 2024 06:18:52 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 2BD7161705;
	Thu, 28 Mar 2024 06:18:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07767C433C7;
	Thu, 28 Mar 2024 06:18:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711606729;
	bh=DcdBFLi2iHg0JyIcbXViXY0Ox+JVcwfx/2i+vA44zSk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=uQfFncZMpRUXNDgCJ4gvVf62eY58ZK1vc6bGvNFNUixRkzy02qkO+00yLb85NwgY7
	 ihfYvifCzJ1UfQGmYFT336ENiG82JegY5aEprU6YEkm8hYC86RGoUS1mzefV4rxUm+
	 7h+vFsZttY1fcdsdf/5mRAi07l+e/OcJwhdm8B5xrnDwmRitY4MeH40ztRURVFb7iO
	 SFh6NsU9KE41dwZDU6T4d4miG+jxUsA9hwnUNwJROPlmTPUHSdRwKmmhpNihptKOby
	 26Tzf5alRmJ50wZJOpta9g+XsQFe9uXrVPuUuB6TeB/W2yDmUTIGzEtlb22RPPJ3Hz
	 s9YJhw3LEMV6w==
Message-ID: <ca3fe7b0-7e27-4ac9-b669-5263c3cec550@kernel.org>
Date: Thu, 28 Mar 2024 15:18:46 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 09/30] block: Pre-allocate zone write plugs
To: Christoph Hellwig <hch@lst.de>
Cc: linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
 linux-scsi@vger.kernel.org, "Martin K . Petersen"
 <martin.petersen@oracle.com>, dm-devel@lists.linux.dev,
 Mike Snitzer <snitzer@redhat.com>, linux-nvme@lists.infradead.org,
 Keith Busch <kbusch@kernel.org>
References: <20240328004409.594888-1-dlemoal@kernel.org>
 <20240328004409.594888-10-dlemoal@kernel.org> <20240328043016.GA13701@lst.de>
 <714d0cbc-be4d-4aa9-b200-73c6caaa1d18@kernel.org>
 <20240328054652.GA16237@lst.de>
 <7d8f3ec4-c416-445f-92db-7d2b60726821@kernel.org>
 <20240328060357.GA16819@lst.de>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20240328060357.GA16819@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240327_231851_072704_EC8A2044 
X-CRM114-Status: GOOD (  12.69  )
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

On 3/28/24 15:03, Christoph Hellwig wrote:
> On Thu, Mar 28, 2024 at 03:02:54PM +0900, Damien Le Moal wrote:
>> But that is the problem: "checking the zone number again" means referencing the
>> plug struct again from the lookup context while the last ref drop context is
>> freeing the plug. That race can be lost by the lookup context and lead to
>> referencing freed memory. So your solution would be OK for pre-allocated plugs
>> only.
> 
> Not if it is done in the Rcu critical section.
> 
>> For kmalloc-ed() plugs, we still need the rcu grace period for free. So we
>> can only optimize for the pre-allocated plugs...
> 
> Yes, bt it can use kfree_rcu which doesn't need the rcu_head in the
> zwplug.

Unfortunately, it does. kfree_rcu() is a 2 argument macro: address and rcu head
to use... The only thing we could drop from the plug struct is the gendisk pointer.

-- 
Damien Le Moal
Western Digital Research


