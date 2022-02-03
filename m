Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62210C4332F
	for <linux-nvme@archiver.kernel.org>; Thu,  3 Feb 2022 15:38:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hJc80QrxeNpdYK/bKJzdbQZVP7dPgDgH6+/SL6BaJLA=; b=TQmPwcwyhZLV5R9N+gn0z7bHF1
	QMuYNdZWq2b+sKYqu+ik0NhsTBCBJ2kX5rZHbjZUx7n8Qe8qZptHA4xx/1aQMq3Xi0vkgzu25j0pN
	qDK7+sdxBbMe3u8y/lSSa0PhDS4xk0GXoX72AsBC1NfjZ1dJzO8xhPpEStBR3yMYBx3tzir4pZKeM
	KsRwyObs9P2A2EsoILs/KfpkS3gBsVZk43jzA+SMa+k2+/tAAI8OgwP/lviY//ESGj9bNwufuSmWv
	61fWh67wjxCae7bwtQlZ3KYQG64CGyxmU80g+kOURWlH+RL4gPCzvMM9rZjPxhBhtsTM93R2kXl+0
	L7N+IVFw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nFeCC-001rhJ-LX; Thu, 03 Feb 2022 15:38:52 +0000
Received: from mail-pg1-f181.google.com ([209.85.215.181])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nFeC9-001rfr-UN
 for linux-nvme@lists.infradead.org; Thu, 03 Feb 2022 15:38:51 +0000
Received: by mail-pg1-f181.google.com with SMTP id s16so2538735pgs.13
 for <linux-nvme@lists.infradead.org>; Thu, 03 Feb 2022 07:38:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=hJc80QrxeNpdYK/bKJzdbQZVP7dPgDgH6+/SL6BaJLA=;
 b=JXCS5xDqcQnE3BtS/hsMTQL0nLD43jzotFiWYw7c8xdBDXb75H6EZzBXnG39ZDZHXw
 Hh9Pw19GOR0rc3UqZzyMeCSP/tOVGCHpZK5FZgAvJW1K9q3BlmPpLz8HX914DsfQciFi
 3mIy6SYS6YHA+4STm+08HJIDCn31sMWC41epVkbezAlE03+Y4ifC3yGDm6m5K1UoJOg2
 DTOi6WzHHHQUSUJDukUi12NKp0X5YllC8Wtco0RDJB9VBAKtp7j2Oz9fzJM+eo5LozF8
 sVy36GlQQE4n0Rb64KG541x6CLKEoZVjVZ/b/sR4jYqN0d07m3jaXq/iSxY1rGjNXFDF
 zdBQ==
X-Gm-Message-State: AOAM532bXDb0HnkVg33o5Fynw4W/HF76tY29lxxFbbcVEjdNkE+n1BJr
 AAbAqh0XMSYWk8QfrqpeYWI=
X-Google-Smtp-Source: ABdhPJyK53iWqvFX2Vqq2e4bGH4TKRnnEI6Nef430vI4MXHRwAQ64yyEJcJ63nBPtWhhnkJ6Y3aDlw==
X-Received: by 2002:a63:68c4:: with SMTP id
 d187mr15183399pgc.603.1643902727819; 
 Thu, 03 Feb 2022 07:38:47 -0800 (PST)
Received: from garbanzo (136-24-173-63.cab.webpass.net. [136.24.173.63])
 by smtp.gmail.com with ESMTPSA id b12sm12465462pfm.154.2022.02.03.07.38.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Feb 2022 07:38:46 -0800 (PST)
Date: Thu, 3 Feb 2022 07:38:43 -0800
From: Luis Chamberlain <mcgrof@kernel.org>
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: Mikulas Patocka <mpatocka@redhat.com>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
 "dm-devel@redhat.com" <dm-devel@redhat.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Javier =?utf-8?B?R29uesOhbGV6?= <javier@javigon.com>,
 linux-fsdevel <linux-fsdevel@vger.kernel.org>,
 Jens Axboe <axboe@kernel.dk>,
 "msnitzer@redhat.com >> msnitzer@redhat.com" <msnitzer@redhat.com>,
 Bart Van Assche <bvanassche@acm.org>,
 "martin.petersen@oracle.com >> Martin K. Petersen"
 <martin.petersen@oracle.com>, 
 "roland@purestorage.com" <roland@purestorage.com>,
 Hannes Reinecke <hare@suse.de>,
 "kbus @imap.gmail.com>> Keith Busch" <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>,
 "Frederick.Knight@netapp.com" <Frederick.Knight@netapp.com>,
 "zach.brown@ni.com" <zach.brown@ni.com>, "osandov@fb.com" <osandov@fb.com>,
 "lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>,
 "djwong@kernel.org" <djwong@kernel.org>,
 "josef@toxicpanda.com" <josef@toxicpanda.com>,
 "clm@fb.com" <clm@fb.com>, "dsterba@suse.com" <dsterba@suse.com>,
 "tytso@mit.edu" <tytso@mit.edu>, "jack@suse.com" <jack@suse.com>,
 Kanchan Joshi <joshi.k@samsung.com>
Subject: Re: [RFC PATCH 3/3] nvme: add the "debug" host driver
Message-ID: <20220203153843.szbd4n65ru4fx5hx@garbanzo>
References: <f0e19ae4-b37a-e9a3-2be7-a5afb334a5c3@nvidia.com>
 <20220201102122.4okwj2gipjbvuyux@mpHalley-2>
 <alpine.LRH.2.02.2202011327350.22481@file01.intranet.prod.int.rdu2.redhat.com>
 <alpine.LRH.2.02.2202011333160.22481@file01.intranet.prod.int.rdu2.redhat.com>
 <270f30df-f14c-b9e4-253f-bff047d32ff0@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <270f30df-f14c-b9e4-253f-bff047d32ff0@nvidia.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220203_073850_007261_169D2FB3 
X-CRM114-Status: GOOD (  18.47  )
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

On Wed, Feb 02, 2022 at 08:00:12AM +0000, Chaitanya Kulkarni wrote:
> Mikulas,
> 
> On 2/1/22 10:33 AM, Mikulas Patocka wrote:
> > External email: Use caution opening links or attachments
> > 
> > 
> > This patch adds a new driver "nvme-debug". It uses memory as a backing
> > store and it is used to test the copy offload functionality.
> > 
> > Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
> > 
> 
> 
> NVMe Controller specific memory backed features needs to go into
> QEMU which are targeted for testing and debugging, just like what
> we have done for NVMe ZNS QEMU support and not in kernel.
> 
> I don't see any special reason to make copy offload an exception.

One can instantiate scsi devices with qemu by using fake scsi devices,
but one can also just use scsi_debug to do the same. I see both efforts
as desirable, so long as someone mantains this.

For instance, blktests uses scsi_debug for simplicity.

In the end you decide what you want to use.

  Luis

