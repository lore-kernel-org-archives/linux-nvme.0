Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80B0DC54E49
	for <linux-nvme@archiver.kernel.org>; Thu,  7 Mar 2024 05:32:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=L47MhA6RlNNWhsEXCUPqvDSxXvqi0AMkVxgVFxt+deE=; b=kdX0MCw2nubqkdcrIqzXn6x6Oj
	QBON30FVYT44lIcpODL5hg6PsigU4adbfbOEQ7DtpvL0CA7AI1Ua4qav5Wca+95ONhgD80R5yOsHU
	xbL9OQQ4pF0DIOrc3N2aJDqQout7dELTjpjd2ziWGMZ8Bi6xr+5MLxT3hYTX3+8CO6cGnwMSVlkq2
	u/40Dplc+DZs4jNStXMBmdNvp8VqDT3WZYnNO1e4v/6LmkJt+20ckhxOJVTlgg4v4GP4J6bvejTx9
	J3VY1xP2+0vuQTEmamsAlPPBhTR/MFy9qXdFZP6m8YJ9Jcc9SCX7DimI3qGMNVd0V/O4CQz+vHaE7
	BB09D0+Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ri6MI-000000038ig-3ZoM;
	Thu, 07 Mar 2024 05:31:58 +0000
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ri6ME-000000038gv-1vZl
	for linux-nvme@lists.infradead.org;
	Thu, 07 Mar 2024 05:31:57 +0000
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1dc3b4b9b62so4340155ad.1
        for <linux-nvme@lists.infradead.org>; Wed, 06 Mar 2024 21:31:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1709789513; x=1710394313; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=L47MhA6RlNNWhsEXCUPqvDSxXvqi0AMkVxgVFxt+deE=;
        b=bIujRsRrlfHNJr6wuGlQHd343/ct4h9ZRJVLEHTGp5LEKOo5/DEoAbRdigA5ANSvcx
         c0ONNM/dUMCBgK0EOukl+QhNNwgXSRCyq6COPB0WSNW2zLGnBgSZPGe8L9oqd9dleo1B
         3ShpeO+TPj0IqRCNVPCr4vQR4pTn7bJb9W674ofdY4RigXn/GWgdEkHxdZ6A3Z8I58IF
         hEjXuGS2secIRctEWUcai2tPogjtuarzhLxgdvip20+5LT3ziJtxAsRxAD5iphlO8tKp
         S10jE+h71DCDf6+xJ8kMaqZ9Ss6SpT6AYyRADzGJpf1CPa3sWCbE4G66Ibdh3hbpg07n
         QOiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709789513; x=1710394313;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L47MhA6RlNNWhsEXCUPqvDSxXvqi0AMkVxgVFxt+deE=;
        b=GRmr/nE4eNwvpD/M5nzJlvizpzwuWoNrajmo9LlZiRNpiJ75Jv/gT4XXS+TLVP008b
         a/LUfVmquaLnTiefX6io7Znswh0HGUK+oPl+DJrpJQoScsI0yGVOHxUO1Vdb20+MredX
         LTFhkXaGQ5XwS9P5htNAWo+d7aCbcyHTP99kPAKQ3vVIoupuRoIKHvcc+Y57TPacBFwZ
         v40ErMQ2WL05HxAV2X1Mq4Fkj6JUqd6wbW34Pkyew8shdnoOhbjZ93c8AQATv9HO2Isr
         cuE7QhVPGthcjkkhQoI4fu8egjI8Y9xCgIbYHE84Ktsd++gsgUUnyHq65I7RWN9cihm+
         DvDQ==
X-Forwarded-Encrypted: i=1; AJvYcCVkWPrMhEg+B5hWO/mE24jCBTcFqKMD5jbtW+Wy1SUjLL4ktkiKzvjGJk4b9Y46xlgLecaL7LiFZQdb0x7TMSQWXdLjRCNvQEroXwVuFks=
X-Gm-Message-State: AOJu0Yw/WJ2sFuNVGTu36zfKH2NjyVJZd2S5VnqYyxUj+8sh6rizVFW7
	lgFeEk0hCOn6sFl+fWiUukxJRxMyJmUuJPfzZUTmTQ0QYLf1Dc2M90xvmexoqr0=
X-Google-Smtp-Source: AGHT+IGz82Z2o57rsxo8MUUyj5kmz5ZD4c9J2gDw8Id8hGUA6zXaFrREbrxI/w7LJItZwwUPJP5S2w==
X-Received: by 2002:a17:902:b494:b0:1dc:a836:19af with SMTP id y20-20020a170902b49400b001dca83619afmr523182plr.32.1709789512233;
        Wed, 06 Mar 2024 21:31:52 -0800 (PST)
Received: from dread.disaster.area (pa49-179-47-118.pa.nsw.optusnet.com.au. [49.179.47.118])
        by smtp.gmail.com with ESMTPSA id lh13-20020a170903290d00b001dd58258d19sm127006plb.40.2024.03.06.21.31.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Mar 2024 21:31:51 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1ri6M8-00G7kw-1e;
	Thu, 07 Mar 2024 16:31:48 +1100
Date: Thu, 7 Mar 2024 16:31:48 +1100
From: Dave Chinner <david@fromorbit.com>
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: "kbus @pop.gmail.com>> Keith Busch" <kbusch@kernel.org>,
	NeilBrown <neilb@suse.de>, Tso Ted <tytso@mit.edu>,
	Matthew Wilcox <willy@infradead.org>,
	Daniel Gomez <da.gomez@samsung.com>,
	Pankaj Raghav <p.raghav@samsung.com>, Jan Kara <jack@suse.cz>,
	Bart Van Assche <bvanassche@acm.org>,
	Christoph Hellwig <hch@infradead.org>,
	Hannes Reinecke <hare@suse.de>,
	Javier =?iso-8859-1?Q?Gonz=E1lez?= <javier.gonz@samsung.com>,
	lsf-pc@lists.linuxfoundation.org, linux-mm@kvack.org,
	linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [LSF/MM/BPF TOPIC] Large block for I/O
Message-ID: <ZelRRFTBvpyXeVGD@dread.disaster.area>
References: <03ebbc5f-2ff5-4f3c-8c5b-544413c55257@suse.de>
 <5c356222-fe9e-41b0-b7fe-218fbcde4573@acm.org>
 <ZYUbB3brQ0K3rP97@casper.infradead.org>
 <ZYUgo0a51nCgjLNZ@infradead.org>
 <9b46c48f-d7c4-4ed3-a644-fba90850eab8@acm.org>
 <ZZxOdWoHrKH4ImL7@casper.infradead.org>
 <ZdeWRaGQo1IX18pL@bombadil.infradead.org>
 <ZdvIlLbhtb7+1CTx@dread.disaster.area>
 <ZdytYs8W9o0CIu_C@bombadil.infradead.org>
 <ZekfZdchUnRZoebo@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZekfZdchUnRZoebo@bombadil.infradead.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240306_213154_797986_E38C799E 
X-CRM114-Status: GOOD (  12.17  )
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

On Wed, Mar 06, 2024 at 05:59:01PM -0800, Luis Chamberlain wrote:
> On Mon, Feb 26, 2024 at 07:25:23AM -0800, Luis Chamberlain wrote:
> root@frag ~/bcc (git::blkalgn)# cat
> /sys/block/vdh/queue/physical_block_size 
> 4096
> root@frag ~/bcc (git::blkalgn)# cat
> /sys/block/vdh/queue/logical_block_size 
> 512

This device supports 512 byte aligned IOs.

> mkfs.xfs -f -b size=4k -s size=4k /dev/vdh

This sets the filesystem block size to 4k, and the smallest metadata
block size to 4kB (sector size). It does not force user data direct
IO alignment to be 4kB - that is determined by what the underlying
block device supports, not the filesystem block size or metadata
sector size is set to.

Sure, doing 512 byte aligned/sized IO to a 4kB sector sizer device
is not optimal. IO will to the file will be completely serialised
because they are sub-fs-block DIO writes, but it does work because
the underlying device allows it. Nobody wanting a performant
application will want to do this, but there are cases where this
case fulfils important functional requirements.

e.g. fs tools and loop devices that use direct IO to access file
based filesystem images that have 512 byte sector size will just
work on such a fs and storage setup, even though the host filesystem
isn't configured to use 512 byte sector alignment directly
itself....

-Dave.
-- 
Dave Chinner
david@fromorbit.com

