Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 160CCC47DB3
	for <linux-nvme@archiver.kernel.org>; Mon, 29 Jan 2024 23:29:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=D83Z1TgXr31js2p6hI1zS+YzHi5LXM+rdoPNxIRJxWU=; b=TD3/lplPwgpGZyxHVngDvmR8Cf
	QszNpcp8Q5ny/aGEnt3imuPtXERodwZ7F+6s1zF7NqMUgd1k1E3L/VZOAnbrodANI2jSBcnGUNh7j
	m0p44ElxUcA8FBK4bqAIkIdQusL4+DUje/MTQujQHBhG7/AOPaI0un+GfJdGUu3BnOJRjuZ0uiv2t
	YK28fZEmsYK2rPvsJAgpIhllzoINRXaYu0BsoHNCkaIJ9ihpwEPDwH6RDBT25LPPPNTbU0D2NHYUZ
	zCPv5d/MWlZBL3BUEyHw6pevZDEVeUDJRDusUqGon7ZwKXzjcg6ijChk0sySPKd0ILgrcl0n5dGng
	4iKKlEPA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rUb3v-0000000Eal1-2VTS;
	Mon, 29 Jan 2024 23:29:11 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rUb3s-0000000Eaj9-21Yi
	for linux-nvme@lists.infradead.org;
	Mon, 29 Jan 2024 23:29:09 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id EB9116239D;
	Mon, 29 Jan 2024 23:29:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E688AC433C7;
	Mon, 29 Jan 2024 23:29:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706570947;
	bh=ndf2vLbvZIQYQNE9pREjH50tsvV7CWwMiqHG6sTVNIc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=JpBD0pkApJsK1Lg9ekUAGkwlA0Sbgqlz2H8WvXFr8iKhHM0b0IKbSZ6wD1tcoj01C
	 DAovaEmy1aQXXzXMi2eQqUicPt4RfmG+am5adv7Qi73Q/sVjaPYxdHLM/Rpp9YOQON
	 YTdmRNVd6ARkl6PESrOQRGLy3l7DrYzuvUwDAYFGOee7U+d69xlAmHUwcC6ekt+ocA
	 V3sVhjRDUyF3KKAXV5sARfdzPALFpWl/tHwOykZZOkrIIIvezVsidD0NjebjuOmDUV
	 +my52WioNda7fDaQyJSmIRUSaQKuHEje67Ngc6C13QyBYk96LdB9iPoJR7+jxg8N7w
	 bB/k4NsdipxfQ==
Message-ID: <100af933-2253-45df-9045-5bd8e273df12@kernel.org>
Date: Tue, 30 Jan 2024 08:29:04 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/5] block: remove gfp_flags from blkdev_zone_mgmt
Content-Language: en-US
To: Johannes Thumshirn <johannes.thumshirn@wdc.com>,
 Naohiro Aota <naohiro.aota@wdc.com>, Johannes Thumshirn <jth@kernel.org>,
 Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>,
 Mikulas Patocka <mpatocka@redhat.com>, dm-devel@lists.linux.dev,
 Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
 David Sterba <dsterba@suse.com>, Jaegeuk Kim <jaegeuk@kernel.org>,
 Chao Yu <chao@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <kch@nvidia.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-btrfs@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
References: <20240128-zonefs_nofs-v3-0-ae3b7c8def61@wdc.com>
 <20240128-zonefs_nofs-v3-5-ae3b7c8def61@wdc.com>
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20240128-zonefs_nofs-v3-5-ae3b7c8def61@wdc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240129_152908_597695_8804D5D8 
X-CRM114-Status: UNSURE (   7.41  )
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

On 1/29/24 16:52, Johannes Thumshirn wrote:
> Now that all callers pass in GFP_KERNEL to blkdev_zone_mgmt() and use
> memalloc_no{io,fs}_{save,restore}() to define the allocation scope, we can
> drop the gfp_mask parameter from blkdev_zone_mgmt() as well as
> blkdev_zone_reset_all() and blkdev_zone_reset_all_emulated().
> 
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Looks good to me.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

But let me check zonefs (patch 1).

-- 
Damien Le Moal
Western Digital Research


