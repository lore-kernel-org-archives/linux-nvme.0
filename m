Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89800C433F5
	for <linux-nvme@archiver.kernel.org>; Wed,  2 Feb 2022 05:58:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WZQskbfglYds00Lw2LuF1T37UDp3X/4QsTuyYVY49D4=; b=HAiZrK7IJKmHVRJZGKW/pWot0l
	cEJ6H8PvyglKOfGGh+i3bgragIV5k7buDWGXeu0zjmpIKrInA86mbhU5xXBAWOEPbrklTPALOnBOH
	wNzz//kkEP97DDBATorHgI6FtmFOrOvnGmV9WSZSCeJRCgHyLF7JLkE3Hmh7lNhklsaIKaXnVfwdc
	rWh6YkP72jhVh5JdxwGeJkjHtfi3xHP7NRKkAFiWk2z0LkkjWY2Q1d9TzotQ3jkmWs7qmMu8ch1se
	X1mEU11lHvKEuJfUPFebU4QUXS8Zb1Or2WhuFW92L8rLFVJOm8Xb46HXhhNxN2FjqXf3fDlNFVzS8
	lBPiFMtA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nF8ej-00EFpT-5d; Wed, 02 Feb 2022 05:58:13 +0000
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nF8ef-00EFon-Gc
 for linux-nvme@lists.infradead.org; Wed, 02 Feb 2022 05:58:11 +0000
Received: by mail-pj1-x1033.google.com with SMTP id
 g15-20020a17090a67cf00b001b7d5b6bedaso4977620pjm.4
 for <linux-nvme@lists.infradead.org>; Tue, 01 Feb 2022 21:58:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=WZQskbfglYds00Lw2LuF1T37UDp3X/4QsTuyYVY49D4=;
 b=V2UAimiTGBYdn7kGrIea/5T4KORuUdOl9CZJ9G7Z1E9uP+BetrhT2YyHl8BIMLY6Ga
 3J8s3R3xiuvvDKHAIr5bDSv67Dfe6RbEbVb/rLUKdpgBaHCROr66xcWpxWHknnZgox4D
 p75MB7kRK07FM2GbTzqpjrWzHCoINGRAy4TUQModN4fLnmngfDUWie76+5xOByFdQHNl
 5cmw+Z73ArAGEWNVMJnzebbpGyqKXL7/aMsldgd1Srd9Aa/BRbI+M4DBCWLeZ4QoIiqt
 Fv2PQkYjqiMf7p72wvIh+ADbl3I3Sdru7C8+CDuh9TZhiaW3bsZQPHjmVOf7eRVYhDxS
 F4yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=WZQskbfglYds00Lw2LuF1T37UDp3X/4QsTuyYVY49D4=;
 b=LWJZ6w7eNogSSHoO9U9an5j+UtdmMPdS5xfW951b+/B3vfTPilnRc4uU05qUTK1SE5
 wL4mX91lDfdG4bz0pLSACggjeXLFiy470+5e8oUzB16EZSMyOOJmUNRHMlNKB+6Lvfi4
 EiHT7QsiYSFhn4L/pDV/tTgbDy3bVUCxQBIJijWGBaBNboAzrikgsuq2mELwV3K5DpSb
 JoJnfgALrnhOqCfBq4VCCJmrnJBB01cdCVMXE4PiXQaXSFAO42Yw/2rSDdHikl+cQKGU
 xySgY5eIgdBXqf2LNfRmaFPraZ4occiHCoeM+FUGxysjf0Ph+p4ECU7XU3hbhi6BbPat
 r8Pg==
X-Gm-Message-State: AOAM533H3nTDKpowS5en6C8lbhPG/3EsqVvy8RcMHR2sy20q+NIpAhbJ
 VsBUJ7Hk0hr1ELRW9DaMTC+OFG+2D7qwQsznw/I=
X-Google-Smtp-Source: ABdhPJyeBo4k/TNkTynsMQzGTravvy1ipnwIWve44CKgxgd4qgZ2/EjFAto44bCHIwoCs/6vMk7KTjcopXMkjlGETB4=
X-Received: by 2002:a17:902:c652:: with SMTP id
 s18mr29246528pls.1.1643781483598; 
 Tue, 01 Feb 2022 21:58:03 -0800 (PST)
MIME-Version: 1.0
References: <f0e19ae4-b37a-e9a3-2be7-a5afb334a5c3@nvidia.com>
In-Reply-To: <f0e19ae4-b37a-e9a3-2be7-a5afb334a5c3@nvidia.com>
From: Kanchan Joshi <joshiiitr@gmail.com>
Date: Wed, 2 Feb 2022 11:27:36 +0530
Message-ID: <CA+1E3rJhT_mXiJHWJF14BeE8mz2vRaz4D0gpZRxPJzwr4S-EbQ@mail.gmail.com>
Subject: Re: [LSF/MM/BFP ATTEND] [LSF/MM/BFP TOPIC] Storage: Copy Offload
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, 
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
 "dm-devel@redhat.com" <dm-devel@redhat.com>, 
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, 
 linux-fsdevel <linux-fsdevel@vger.kernel.org>, Jens Axboe <axboe@kernel.dk>, 
 "msnitzer@redhat.com >> msnitzer@redhat.com" <msnitzer@redhat.com>,
 Bart Van Assche <bvanassche@acm.org>, 
 "martin.petersen@oracle.com >> Martin K. Petersen"
 <martin.petersen@oracle.com>, 
 "roland@purestorage.com" <roland@purestorage.com>,
 "mpatocka@redhat.com" <mpatocka@redhat.com>, 
 Hannes Reinecke <hare@suse.de>, "kbus >> Keith Busch" <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>, 
 "Frederick.Knight@netapp.com" <Frederick.Knight@netapp.com>,
 "zach.brown@ni.com" <zach.brown@ni.com>, 
 "osandov@fb.com" <osandov@fb.com>, 
 "lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>,
 "djwong@kernel.org" <djwong@kernel.org>, 
 "josef@toxicpanda.com" <josef@toxicpanda.com>, "clm@fb.com" <clm@fb.com>,
 "dsterba@suse.com" <dsterba@suse.com>, 
 "tytso@mit.edu" <tytso@mit.edu>, "jack@suse.com" <jack@suse.com>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220201_215809_597014_0DCBFF23 
X-CRM114-Status: GOOD (  22.98  )
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

On Thu, Jan 27, 2022 at 12:51 PM Chaitanya Kulkarni
<chaitanyak@nvidia.com> wrote:
>
> Hi,
>
> * Background :-
> -----------------------------------------------------------------------
>
> Copy offload is a feature that allows file-systems or storage devices
> to be instructed to copy files/logical blocks without requiring
> involvement of the local CPU.
>
> With reference to the RISC-V summit keynote [1] single threaded
> performance is limiting due to Denard scaling and multi-threaded
> performance is slowing down due Moore's law limitations. With the rise
> of SNIA Computation Technical Storage Working Group (TWG) [2],
> offloading computations to the device or over the fabrics is becoming
> popular as there are several solutions available [2]. One of the common
> operation which is popular in the kernel and is not merged yet is Copy
> offload over the fabrics or on to the device.
>
> * Problem :-
> -----------------------------------------------------------------------
>
> The original work which is done by Martin is present here [3]. The
> latest work which is posted by Mikulas [4] is not merged yet. These two
> approaches are totally different from each other. Several storage
> vendors discourage mixing copy offload requests with regular READ/WRITE
> I/O. Also, the fact that the operation fails if a copy request ever
> needs to be split as it traverses the stack it has the unfortunate
> side-effect of preventing copy offload from working in pretty much
> every common deployment configuration out there.
>
> * Current state of the work :-
> -----------------------------------------------------------------------
>
> With [3] being hard to handle arbitrary DM/MD stacking without
> splitting the command in two, one for copying IN and one for copying
> OUT. Which is then demonstrated by the [4] why [3] it is not a suitable
> candidate. Also, with [4] there is an unresolved problem with the
> two-command approach about how to handle changes to the DM layout
> between an IN and OUT operations.
>
> We have conducted a call with interested people late last year since
> lack of LSFMMM and we would like to share the details with broader
> community members.

I'm keen on this topic and would like to join the F2F discussion.
The Novmber call did establish some consensus on requirements.
Planning to have a round or two of code-discussions soon.


Thanks,
-- 
Kanchan

