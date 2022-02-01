Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B35AC433EF
	for <linux-nvme@archiver.kernel.org>; Tue,  1 Feb 2022 10:21:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=eIOyvFawBB1yczxqwT9GD1wEUXr2GprPDkj97BLOhM8=; b=jQz+rhseAHkzvgMwT/0FX6OwUI
	W8OXib/1WzoQHhWVrt7iCGfKJRHmD04Ig6kM7++xc4CD29NVG0pW/dwGF/nitG/crNdQ96qUYIffa
	QaUAzDlmr6NfVg3i+wRzlz9q6995gMsdc4Fr/pSZ+bamg3uPVwjF+HQJ2XwJ7S8p3RDPQkH9jyOXN
	c98ozIwlwpeVjQ1VXT3t7olUMnKIKL3FqHOIX1Hu/BGRSoNqIIZufwTfmY+zpPaGXhqqCbikyeR31
	G3SckxETJzCOPYcYAq8eAWuzr6zR0Fv8K021AZC90deT0qAz/uqwHV5uGvsxjcX7wdFqAa3E/svJ+
	BPsxLgUA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nEqHw-00Bj3N-S8; Tue, 01 Feb 2022 10:21:28 +0000
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nEqHt-00Bj2F-Qw
 for linux-nvme@lists.infradead.org; Tue, 01 Feb 2022 10:21:27 +0000
Received: by mail-ej1-x62d.google.com with SMTP id s5so52371227ejx.2
 for <linux-nvme@lists.infradead.org>; Tue, 01 Feb 2022 02:21:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=javigon-com.20210112.gappssmtp.com; s=20210112;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=eIOyvFawBB1yczxqwT9GD1wEUXr2GprPDkj97BLOhM8=;
 b=pJgqMkadljh7RQEG1OifyORi8FTJ4yvtTfhp3Fv0W8KUnRAFhPQ4ydhJvfbXum++fP
 3t7f7doYblsNgo7oMDTiOlmZxcYOiY37CgCvg8/RYn8T+Po8tgv7lvxp9CBGdStWf3sq
 WwtEU3TOLf/MOIjXnUbZGNWUc0SaOZUQaiLRhguRevht8Ac2tVvAoukw0t2U0+1QzAhu
 BEo/9KKub7Q2qd+N8AHo5ghjz9HneRcptN27Xs5gNExbv0R+eQ++gXKpGeAVamTqzYf9
 GzqAZGpYgMj5ryA1ScCFdqG68fiEHF0J+CN6knWH805XRJi4UYxN58axR+bPXe0b2yhC
 lyGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=eIOyvFawBB1yczxqwT9GD1wEUXr2GprPDkj97BLOhM8=;
 b=OZcrLdncqtJbTl8E39hw5uV/RcZHnWa7PtcvA7Jt6zzn7eel3KfvoxZOO8ie+WYzdH
 aL1BKUSVSW3ALSn/wcCXnl4mt/xxcvezLvKv/G0SL4CuC/E9RcIUREvoznbQ+9ut2GIN
 hXhD8Wu0kSIEqk/8xH2X2BOik6YdgLvkEskFWIBWkruXUXwZtfdc8DpBSYv5DAMOx8rB
 EHlLmWPEqE93y3MYnPkztUQNyQlMb8FiD7KTI7X/28NgzvC555hB5ge8FO8zm8l7yaWl
 f4ZcVaa/QoL9D6CKXgcPiNbWwd4CA28QYKrxFQQAGi4pXu4qECcw7dErsQ+d3achGuUb
 O7jw==
X-Gm-Message-State: AOAM530NcBzuk+a8reqMvb+HL5NWo9PgpIdR/uPEQbVytNLSv0+O9D2n
 xnsiFIiuX3xAsGXbKgq0jWUATg==
X-Google-Smtp-Source: ABdhPJx58nqEvb1Npa2CsMHZtPsUoqQzJ41tgdoNFsHrDBZEqyc2NUJcMe6tBJmOhT19Yval8hSzoA==
X-Received: by 2002:a17:907:7f1a:: with SMTP id
 qf26mr14491120ejc.20.1643710883991; 
 Tue, 01 Feb 2022 02:21:23 -0800 (PST)
Received: from localhost (5.186.121.195.cgn.fibianet.dk. [5.186.121.195])
 by smtp.gmail.com with ESMTPSA id w24sm11634557edu.97.2022.02.01.02.21.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Feb 2022 02:21:23 -0800 (PST)
Date: Tue, 1 Feb 2022 11:21:22 +0100
From: Javier =?utf-8?B?R29uesOhbGV6?= <javier@javigon.com>
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
 "dm-devel@redhat.com" <dm-devel@redhat.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 linux-fsdevel <linux-fsdevel@vger.kernel.org>,
 Jens Axboe <axboe@kernel.dk>,
 "msnitzer@redhat.com >> msnitzer@redhat.com" <msnitzer@redhat.com>,
 Bart Van Assche <bvanassche@acm.org>,
 "martin.petersen@oracle.com >> Martin K. Petersen"
 <martin.petersen@oracle.com>, 
 "roland@purestorage.com" <roland@purestorage.com>,
 "mpatocka@redhat.com" <mpatocka@redhat.com>,
 Hannes Reinecke <hare@suse.de>, "kbus >> Keith Busch" <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>,
 "Frederick.Knight@netapp.com" <Frederick.Knight@netapp.com>,
 "zach.brown@ni.com" <zach.brown@ni.com>, "osandov@fb.com" <osandov@fb.com>,
 "lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>,
 "djwong@kernel.org" <djwong@kernel.org>,
 "josef@toxicpanda.com" <josef@toxicpanda.com>,
 "clm@fb.com" <clm@fb.com>, "dsterba@suse.com" <dsterba@suse.com>,
 "tytso@mit.edu" <tytso@mit.edu>, "jack@suse.com" <jack@suse.com>,
 Kanchan Joshi <joshi.k@samsung.com>
Subject: Re: [LSF/MM/BFP ATTEND] [LSF/MM/BFP TOPIC] Storage: Copy Offload
Message-ID: <20220201102122.4okwj2gipjbvuyux@mpHalley-2>
References: <f0e19ae4-b37a-e9a3-2be7-a5afb334a5c3@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <f0e19ae4-b37a-e9a3-2be7-a5afb334a5c3@nvidia.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220201_022125_960799_D4C9C9FB 
X-CRM114-Status: GOOD (  17.62  )
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

On 27.01.2022 07:14, Chaitanya Kulkarni wrote:
>Hi,
>
>* Background :-
>-----------------------------------------------------------------------
>
>Copy offload is a feature that allows file-systems or storage devices
>to be instructed to copy files/logical blocks without requiring
>involvement of the local CPU.
>
>With reference to the RISC-V summit keynote [1] single threaded
>performance is limiting due to Denard scaling and multi-threaded
>performance is slowing down due Moore's law limitations. With the rise
>of SNIA Computation Technical Storage Working Group (TWG) [2],
>offloading computations to the device or over the fabrics is becoming
>popular as there are several solutions available [2]. One of the common
>operation which is popular in the kernel and is not merged yet is Copy
>offload over the fabrics or on to the device.
>
>* Problem :-
>-----------------------------------------------------------------------
>
>The original work which is done by Martin is present here [3]. The
>latest work which is posted by Mikulas [4] is not merged yet. These two
>approaches are totally different from each other. Several storage
>vendors discourage mixing copy offload requests with regular READ/WRITE
>I/O. Also, the fact that the operation fails if a copy request ever
>needs to be split as it traverses the stack it has the unfortunate
>side-effect of preventing copy offload from working in pretty much
>every common deployment configuration out there.
>
>* Current state of the work :-
>-----------------------------------------------------------------------
>
>With [3] being hard to handle arbitrary DM/MD stacking without
>splitting the command in two, one for copying IN and one for copying
>OUT. Which is then demonstrated by the [4] why [3] it is not a suitable
>candidate. Also, with [4] there is an unresolved problem with the
>two-command approach about how to handle changes to the DM layout
>between an IN and OUT operations.
>
>We have conducted a call with interested people late last year since
>lack of LSFMMM and we would like to share the details with broader
>community members.

Chaitanya,

I would also like to join the F2F conversation as a follow up of the
virtual one last year. We will have a first version of the patches
posted in the next few weeks. This will hopefully serve as a good first
step.

Adding Kanchan to thread too.

Javier

