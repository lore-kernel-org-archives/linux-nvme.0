Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AA30C433F5
	for <linux-nvme@archiver.kernel.org>; Mon,  7 Feb 2022 09:57:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=T8GS9Lx/Nzfe8shyS/bZ6AFUZk8Wg4JdFQgCVTpa/ow=; b=P+DfFH0+YjpxYhPcFfUkSCEVFQ
	ETJBiYT8v8v+FAR20sH4tfhrDjmAwGoiiiYsP+PfruBpBFar4baUJBkzTsKjHaTHqPeVP3Wb2y+EC
	1GbBipAfVAZ1QXVp1jXTS4gJAmNIVSxTPyeaGaG65k51FrvI0Jy35xKcTyLntXH6Dwr+txnGc425U
	vCR2JY2eu+rBAcTW036j286EOqQTAHdMpPBiJHmDeD5soBvVfhz7MvHnUy1FiM4Jgx71PYON+jP4m
	ioRml3s2de0qDU/faMMpaJMWQGHoCZ09VMuhteWl1FwkrPXPRKO0dJKwNn3rPZFC8YMlP/4kfaOdU
	faSEqNyw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nH0m1-009hLd-3E; Mon, 07 Feb 2022 09:57:29 +0000
Received: from mail-lj1-x229.google.com ([2a00:1450:4864:20::229])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nH0ly-009hJs-0n
 for linux-nvme@lists.infradead.org; Mon, 07 Feb 2022 09:57:27 +0000
Received: by mail-lj1-x229.google.com with SMTP id t14so18706607ljh.8
 for <linux-nvme@lists.infradead.org>; Mon, 07 Feb 2022 01:57:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=T8GS9Lx/Nzfe8shyS/bZ6AFUZk8Wg4JdFQgCVTpa/ow=;
 b=Ed+tt6LNx+FM2iQmQE+1H418+wYp0WiOdsm/3ibcYdtcajjtWUSvy6Zr1lCqSMfdTu
 MCGxgkD2cpro20lYahzc6+gySNFKYSzKSO0CJ/3bp/V2aQaTtLKDq7WbhGHaKlH3Dc8T
 sIP68l8ipATIFf7HK9DX9itcJovKwyqQU9ycTeS7sy5cE4a0muJYSKyoYiR3fB31LidS
 rDL1N1w027ij27ZYE+t0mReXf/jbaNn+T1MWmwy2hHKf+vg1zbOyS09aer9Z5OSQ/Wat
 /ryVkhvEED6SRdZ4UgDojneyxvtFIWT49X2lXj9lpIjvsz3bly3o+oaxnOI5223H9aQW
 l/yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=T8GS9Lx/Nzfe8shyS/bZ6AFUZk8Wg4JdFQgCVTpa/ow=;
 b=mB1pXkDVh8KtMXg8U/LDis8Ie8zFPfUelGdErZSyTirJwJVCTnGujsHTGXTH5+NGpf
 LmCo9KMOvzt7bIhBC/WU10iHi7N+WF5g1V+uPJrtAQMPorJtjBK5Wh49lVblWZcryvNP
 F6ZyKG3k0d3656njXekrPSCsCgxlekmsrauL1ngZTyC4jZMQTBhfmVUcc1GzriA8sBYN
 MsjbQh9kXIcdnSM7YYIsYeVtIr+fzpETlSO41gK4mjhvEuHRdrN6t0LNA7tQgyIT27LM
 elkEaUWc5rS5zcezy+a4lfVaUGgSre0AtbL5pEj0DoEwnoqxA0LIckT8jeabTCOzN/55
 zhWw==
X-Gm-Message-State: AOAM531eXKG/qV/qWo7IH8oSdMZCN7i7vb0DdrKzFHYqieGs/6q8Rqyp
 NpiexrleAdoLott0+KBdERxVveTGTJ+lyPnjCrM=
X-Google-Smtp-Source: ABdhPJxV5weaU4Xoj+nXg6b8L1jKYRkPcK3VXq+/Al3uXfmdamOSUyvoF17yjujMX3jIRgFIA5NTrgrLqSjbGfGwu24=
X-Received: by 2002:a05:651c:108:: with SMTP id
 a8mr8630674ljb.479.1644227843616; 
 Mon, 07 Feb 2022 01:57:23 -0800 (PST)
MIME-Version: 1.0
References: <f0e19ae4-b37a-e9a3-2be7-a5afb334a5c3@nvidia.com>
 <20220201102122.4okwj2gipjbvuyux@mpHalley-2>
In-Reply-To: <20220201102122.4okwj2gipjbvuyux@mpHalley-2>
From: Nitesh Shetty <nitheshshetty@gmail.com>
Date: Mon, 7 Feb 2022 15:27:12 +0530
Message-ID: <CAOSviJ0+97ouVbQpQD1RykdyyM2Z_wVRrQjciizzMPS+pLOEsQ@mail.gmail.com>
Subject: Re: [LSF/MM/BFP ATTEND] [LSF/MM/BFP TOPIC] Storage: Copy Offload
To: =?UTF-8?Q?Javier_Gonz=C3=A1lez?= <javier@javigon.com>
Cc: Chaitanya Kulkarni <chaitanyak@nvidia.com>, 
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, 
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
 "tytso@mit.edu" <tytso@mit.edu>, "jack@suse.com" <jack@suse.com>,
 Kanchan Joshi <joshi.k@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220207_015726_110125_CDE8451E 
X-CRM114-Status: GOOD (  22.01  )
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

Chaitanya,

I would like to join the conversation.

Thanks,
Nitesh

On Sun, Feb 6, 2022 at 7:29 PM Javier Gonz=C3=A1lez <javier@javigon.com> wr=
ote:
>
> On 27.01.2022 07:14, Chaitanya Kulkarni wrote:
> >Hi,
> >
> >* Background :-
> >-----------------------------------------------------------------------
> >
> >Copy offload is a feature that allows file-systems or storage devices
> >to be instructed to copy files/logical blocks without requiring
> >involvement of the local CPU.
> >
> >With reference to the RISC-V summit keynote [1] single threaded
> >performance is limiting due to Denard scaling and multi-threaded
> >performance is slowing down due Moore's law limitations. With the rise
> >of SNIA Computation Technical Storage Working Group (TWG) [2],
> >offloading computations to the device or over the fabrics is becoming
> >popular as there are several solutions available [2]. One of the common
> >operation which is popular in the kernel and is not merged yet is Copy
> >offload over the fabrics or on to the device.
> >
> >* Problem :-
> >-----------------------------------------------------------------------
> >
> >The original work which is done by Martin is present here [3]. The
> >latest work which is posted by Mikulas [4] is not merged yet. These two
> >approaches are totally different from each other. Several storage
> >vendors discourage mixing copy offload requests with regular READ/WRITE
> >I/O. Also, the fact that the operation fails if a copy request ever
> >needs to be split as it traverses the stack it has the unfortunate
> >side-effect of preventing copy offload from working in pretty much
> >every common deployment configuration out there.
> >
> >* Current state of the work :-
> >-----------------------------------------------------------------------
> >
> >With [3] being hard to handle arbitrary DM/MD stacking without
> >splitting the command in two, one for copying IN and one for copying
> >OUT. Which is then demonstrated by the [4] why [3] it is not a suitable
> >candidate. Also, with [4] there is an unresolved problem with the
> >two-command approach about how to handle changes to the DM layout
> >between an IN and OUT operations.
> >
> >We have conducted a call with interested people late last year since
> >lack of LSFMMM and we would like to share the details with broader
> >community members.
>
> Chaitanya,
>
> I would also like to join the F2F conversation as a follow up of the
> virtual one last year. We will have a first version of the patches
> posted in the next few weeks. This will hopefully serve as a good first
> step.
>
> Adding Kanchan to thread too.
>
> Javier

