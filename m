Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35AD7C433EF
	for <linux-nvme@archiver.kernel.org>; Tue,  1 Feb 2022 01:54:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DEQ16urBvP0UlaY7sL7xRV/9fsqy0EWylw9ub26/KfQ=; b=Z3NIEfI8Ud4bPyqrnqScMlw5HV
	c/dOzwulQ25rOKqggM0eALLXSg+W3FHuulPcJBTSixSapLG1p2/Qpc77wxa1r2sGqJi1jcG/RAGXA
	jufE9oK77UXvBVmfyqDBiI5RciKXfHzSYiCXj9qN1B+ntfZhtnBBJgUT7J4X4pPSrLPwVuyEEMwmM
	KazAIp5/LOaw5LjGHllm9CXJqAzKQG23xjTj7qfcl0ISTmtiZkR4zcJKcTjQZ+NNrViupIpix53o4
	nJ/MwJxQhXYLQTsrQkH0Vzl8hbvZr8Nux3FtaPNATbOem8/INWKZIvDyogZKbGL4MGpWcY2wYPUSO
	BG8njObQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nEiNX-00AzAW-Hg; Tue, 01 Feb 2022 01:54:43 +0000
Received: from mail-pg1-f169.google.com ([209.85.215.169])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nEiNV-00Az9Y-LN
 for linux-nvme@lists.infradead.org; Tue, 01 Feb 2022 01:54:42 +0000
Received: by mail-pg1-f169.google.com with SMTP id g20so13902970pgn.10
 for <linux-nvme@lists.infradead.org>; Mon, 31 Jan 2022 17:54:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=DEQ16urBvP0UlaY7sL7xRV/9fsqy0EWylw9ub26/KfQ=;
 b=HxeEiJzeEzBSDCYVEk+ouwEwUxBEfcPvvChTbbQR9LaYaqSu1GifHUGpeytssOmhGg
 CskHb+KLdSfhTBt/2ZhGbISkCSpBc6OhNn1V6UHNyphH8n+004CUvv4d1gD7NdyzkyFn
 8zCpzIaEvCxWRQdvGlWGh+4uV2kbJvOtk6RdK7Lr+FyBeD3ZPqw9kVYdqdF7ZZhkiOH/
 qEIXoCTm0r0IikNAljqgANmYjCw4ovNnYrrYu7/+SX7QObuNU65sKdIv4PpZJ4MNHsqu
 ktIC3qP57dFnFZjoqlwGMoZV9HWoAeEJXJNED0A6bHGuNAyzqeSqTK11vRmN65tj46p9
 qjdw==
X-Gm-Message-State: AOAM530romqXCbcAFFtmg2lqkawBVDcJpKf45yIyi/7+HiShrVmjJY+C
 t0r5Wk9m+mKO1bN4baHAYhw=
X-Google-Smtp-Source: ABdhPJxwurPLwookDKYfdK759aK7v43l+AjycUMO4NhyGq1GqximIDE/k24pt0ls+ZyULuBGbLpUaw==
X-Received: by 2002:a63:1ca:: with SMTP id 193mr16567674pgb.20.1643680479518; 
 Mon, 31 Jan 2022 17:54:39 -0800 (PST)
Received: from garbanzo (136-24-173-63.cab.webpass.net. [136.24.173.63])
 by smtp.gmail.com with ESMTPSA id k9sm446369pfi.134.2022.01.31.17.54.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Jan 2022 17:54:38 -0800 (PST)
Date: Mon, 31 Jan 2022 17:54:35 -0800
From: Luis Chamberlain <mcgrof@kernel.org>
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
 "tytso@mit.edu" <tytso@mit.edu>, "jack@suse.com" <jack@suse.com>
Subject: Re: [LSF/MM/BFP ATTEND] [LSF/MM/BFP TOPIC] Storage: Copy Offload
Message-ID: <20220201015435.okpgudxfrrtxwcd4@garbanzo>
References: <f0e19ae4-b37a-e9a3-2be7-a5afb334a5c3@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f0e19ae4-b37a-e9a3-2be7-a5afb334a5c3@nvidia.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220131_175441_729682_5933A70C 
X-CRM114-Status: GOOD (  13.61  )
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

> * What we will discuss in the proposed session ?
> -----------------------------------------------------------------------
> 
> I'd like to propose a session to go over this topic to understand :-
> 
> 1. What are the blockers for Copy Offload implementation ?
> 2. Discussion about having a file system interface.
> 3. Discussion about having right system call for user-space.
> 4. What is the right way to move this work forward ?
> 5. How can we help to contribute and move this work forward ?
> 
> * Required Participants :-
> -----------------------------------------------------------------------
> 
> I'd like to invite file system, block layer, and device drivers
> developers to:-
> 
> 1. Share their opinion on the topic.
> 2. Share their experience and any other issues with [4].
> 3. Uncover additional details that are missing from this proposal.

Consider me intersted in this topic.

  Luis

