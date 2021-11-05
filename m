Return-Path: <SRS0=yHGa=PY=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56C26C433EF
	for <linux-nvme@archiver.kernel.org>; Fri,  5 Nov 2021 13:05:32 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0AE4960F38
	for <linux-nvme@archiver.kernel.org>; Fri,  5 Nov 2021 13:05:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0AE4960F38
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=javigon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EFUXh461CIiXVx1x45I6hR/O2ueRgYCwIDIidW8J+Tw=; b=k1ApHLhCT6yTna7+LI5Mgu/tSL
	CSeGW5kquHHJHxGcIj2DDLCcmsYlIC6KODysjGEpcYCtBwVpP1HoTbiLknICE9+Kfv225/DX41Jtc
	Iyh4IMMInlaponKMVOc5T7iLvnLCYVSnm7pdnSbbpWUfMx/yxaFvzM42KkdBNyXgb6OhCALcBopcT
	bDFjv4lWIT5aHeNWIpy+5R3Kp9AQuNBVihHhzs8e/OHPkOHmjYwDFmFU8s9vXOsHjTrtjbHk78Ro4
	6hbp/WRLhonNuMvrxwDmQo0bIrHl9YIeQWiacInFnfF+md81+T6cz/DV8hcSQiGxhAg7uPd5n9x0B
	1omu6APg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1miyuJ-00BPG0-0G; Fri, 05 Nov 2021 13:05:23 +0000
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1miuX5-00Arzx-2Z
 for linux-nvme@lists.infradead.org; Fri, 05 Nov 2021 08:25:08 +0000
Received: by mail-wm1-x32e.google.com with SMTP id
 z11-20020a1c7e0b000000b0030db7b70b6bso8993258wmc.1
 for <linux-nvme@lists.infradead.org>; Fri, 05 Nov 2021 01:25:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=javigon-com.20210112.gappssmtp.com; s=20210112;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=EFUXh461CIiXVx1x45I6hR/O2ueRgYCwIDIidW8J+Tw=;
 b=lMD/pi28y/Uv87QFeGqi0ofGemcaTx7QwUjSrauWalLa469Orq1Qism8wG/Zujo4DV
 XEqrKE0BTjAS5ohOcQPDQpCzeHVg6xpGVaa6dMCJN7psjsa3R0ZylPVI8xKmBsw2HcdF
 fT4JBNVt+B+3Y4qpWJQ0DkUerPO6Nn213HCtaKFKnOx5YpRZMykH6ocakGNFpu7aisod
 XUBewMdfBmEudQkXh5zAxOmiNk18R4APKkSq+aIWB2ARaGpnG0Ng8YAyR2fGaAtCLH/M
 NOI8a+Uu6gwDVNLWesNr2iVNbTRMPPSvUzA6rKSJP6tS1RZVpLM9qt8P6TFo+eL13yc+
 u2wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=EFUXh461CIiXVx1x45I6hR/O2ueRgYCwIDIidW8J+Tw=;
 b=n6OZ+lOst6Ofo26z83Ng+yQD5GXjgNn/fdRBboUhU1emmchFgHAuhWbck55T77E7Uo
 47BOCMNKrXS1O6wUcCeioExkXR3MlTxsG2hl2ygEeZuGT5BvUehemQCOL7t7t/aOwh4R
 hV2ySQ+mj2SDzy9p6N8+eAFfMSlQ/9n7Y/54K8di5knk/HuiftOQYu4IkK1WZZugC2iT
 QlddCa88WlZYJzDjLrCoKS1kCU7pfUhq/fTRwZppGia1D42RaaS4FIuK6xZYDL8Ttr7X
 s2Lch1nJCsW6rYrM4Mo8XCc+I93hZQ+V2Ciui8ejOaJO5xZ1b8HQGvL1JkRpn4qOXuZ3
 zLew==
X-Gm-Message-State: AOAM532wX4czstBBmgjwiBg3SEAuWT2l3Xem4+jNce9RMNprdTE+FZGn
 ZPngDtaCcdP38OSnhCt9QBD8TA==
X-Google-Smtp-Source: ABdhPJx8UdeUgoUtHGGn9mgxXZu5qrGkFYtzQTF9umijJZfwGuuTFS/MsOT6GwSa2FPyLrvx70gJsw==
X-Received: by 2002:a1c:1b08:: with SMTP id b8mr27658572wmb.28.1636100703566; 
 Fri, 05 Nov 2021 01:25:03 -0700 (PDT)
Received: from localhost (5.186.126.13.cgn.fibianet.dk. [5.186.126.13])
 by smtp.gmail.com with ESMTPSA id r17sm3448703wmq.5.2021.11.05.01.25.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Nov 2021 01:25:02 -0700 (PDT)
Date: Fri, 5 Nov 2021 09:25:01 +0100
From: "javier@javigon.com" <javier@javigon.com>
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, "Darrick J. Wong" <djwong@kernel.org>,
 Chaitanya Kulkarni <chaitanyak@nvidia.com>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
 "target-devel@vger.kernel.org" <target-devel@vger.kernel.org>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
 "dm-devel@redhat.com" <dm-devel@redhat.com>,
 "axboe@kernel.dk" <axboe@kernel.dk>, "agk@redhat.com" <agk@redhat.com>,
 "snitzer@redhat.com" <snitzer@redhat.com>,
 "song@kernel.org" <song@kernel.org>, "sagi@grimberg.me" <sagi@grimberg.me>,
 "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
 "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
 "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
 "johannes.thumshirn@wdc.com" <johannes.thumshirn@wdc.com>,
 "bvanassche@acm.org" <bvanassche@acm.org>,
 "dongli.zhang@oracle.com" <dongli.zhang@oracle.com>,
 "ming.lei@redhat.com" <ming.lei@redhat.com>,
 "osandov@fb.com" <osandov@fb.com>,
 "willy@infradead.org" <willy@infradead.org>,
 "jefflexu@linux.alibaba.com" <jefflexu@linux.alibaba.com>,
 "josef@toxicpanda.com" <josef@toxicpanda.com>,
 "clm@fb.com" <clm@fb.com>, "dsterba@suse.com" <dsterba@suse.com>,
 "jack@suse.com" <jack@suse.com>, "tytso@mit.edu" <tytso@mit.edu>,
 "adilger.kernel@dilger.ca" <adilger.kernel@dilger.ca>,
 "jlayton@kernel.org" <jlayton@kernel.org>,
 "idryomov@gmail.com" <idryomov@gmail.com>,
 "danil.kipnis@cloud.ionos.com" <danil.kipnis@cloud.ionos.com>,
 "ebiggers@google.com" <ebiggers@google.com>,
 "jinpu.wang@cloud.ionos.com" <jinpu.wang@cloud.ionos.com>
Subject: Re: [RFC PATCH 0/8] block: add support for REQ_OP_VERIFY
Message-ID: <20211105082501.ltdfepz6inrffiux@mpHalley-2>
References: <20211104064634.4481-1-chaitanyak@nvidia.com>
 <20211104071439.GA21927@lst.de>
 <661bcadd-a030-4a72-81ae-ef15080f0241@nvidia.com>
 <20211104173235.GI2237511@magnolia> <20211104173431.GA31740@lst.de>
 <20211104223736.GA2655721@dhcp-10-100-145-180.wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <20211104223736.GA2655721@dhcp-10-100-145-180.wdc.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211105_012507_149663_0BEBB1A6 
X-CRM114-Status: GOOD (  16.09  )
X-Mailman-Approved-At: Fri, 05 Nov 2021 06:05:13 -0700
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

On 04.11.2021 15:37, Keith Busch wrote:
>On Thu, Nov 04, 2021 at 06:34:31PM +0100, Christoph Hellwig wrote:
>> On Thu, Nov 04, 2021 at 10:32:35AM -0700, Darrick J. Wong wrote:
>> > I also wonder if it would be useful (since we're already having a
>> > discussion elsewhere about data integrity syscalls for pmem) to be able
>> > to call this sort of thing against files?  In which case we'd want
>> > another preadv2 flag or something, and then plumb all that through the
>> > vfs/iomap as needed?
>>
>> IFF we do this (can't answer if there is a need) we should not
>> overload read with it.  It is an operation that does not return
>> data but just a status, so let's not get into that mess.
>
>If there is a need for this, a new io_uring opcode seems like the
>appropirate user facing interface for it.

+1 to this. I was looking at the patchset yesterday and this was one of
the questions I had. Any reasons to not do it this way Chaitanya?


