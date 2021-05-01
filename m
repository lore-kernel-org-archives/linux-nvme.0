Return-Path: <SRS0=FZGd=J4=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE794C433ED
	for <linux-nvme@archiver.kernel.org>; Sat,  1 May 2021 09:59:32 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0942261352
	for <linux-nvme@archiver.kernel.org>; Sat,  1 May 2021 09:59:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0942261352
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:
	References:MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=y+ojRa8N4NxEuhJWqVbW0ZmAUNFNtmM2bnOejIlttlY=; b=NJ3n2+33oIH/HNUFzXp8GZGN1
	wgNjY57FP9wENMeeXv+X/ZGVRp0DMzolWtCdigZA4u+1w/LGC293376ckEPQ9S5D9sGPUvVeFTnbq
	dZ5bvYhHh+kunpVCADa6Cyuz59jqvIiKDz03kBLTCOnf8/GMa0/+wolN7ZmGcmWVuS1esL8ukWtSW
	CqydCvaj3qkI+HfGWq4+gUXZGU8WSL3W6vEp7E1MWi163KwIrTsN44EDkQshlP8pZIM3h0dArgDrz
	Rs6yDCUr9X2DQSC1UF2UqZCGVLlNSi5CBT+jlRPXzXmkW5uJmPkPYC9QfZD92wd33AxYKZhjUSQu4
	4c4PoUYuw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lcmOw-009qDM-Fl; Sat, 01 May 2021 09:59:06 +0000
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lcmOp-009qC3-Dj
 for linux-nvme@lists.infradead.org; Sat, 01 May 2021 09:59:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1619863126;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=W5WG7DkRT2Xf+VtRz8w4RVjZ4eIad6NHKvSkXv+86Cc=;
 b=K6gf+JG/x6AWZlVZlv2HYoiGvTVC+8sPyg2mmCDKRFbVzRgKhMRN+f3pn3UbIWOVSavcNz
 E3+i0WKPV0lq9Y5CtPyLyLslyPOlawy2kC+ySNv+Oh1mTYzTlvWxstyFvYckWLAStPl8fx
 /ZppK0a1umo3tDVxX5WLAmBK4DyvGw4=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1619863137;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=W5WG7DkRT2Xf+VtRz8w4RVjZ4eIad6NHKvSkXv+86Cc=;
 b=HNDejjRaYGmD6IxNofvouchTxpMF4TVT/XV013f37M7TPquHvVPCKKtzoUtsAacw6LxweT
 tbCB6/tPBrKJvvYwGMGhZCTc75vxwo4g/Pz+OiCgDEHF9eB6HOxnTfHkO97SiW8mbBsqfu
 3Z4SRnslsoWdpSR46CiL62PJSBbA0hA=
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com
 [209.85.219.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-443-tTSUfMD7NiCa-NfVbo9hig-1; Sat, 01 May 2021 05:58:45 -0400
X-MC-Unique: tTSUfMD7NiCa-NfVbo9hig-1
Received: by mail-yb1-f198.google.com with SMTP id
 d89-20020a25a3620000b02904dc8d0450c6so1367698ybi.2
 for <linux-nvme@lists.infradead.org>; Sat, 01 May 2021 02:58:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=W5WG7DkRT2Xf+VtRz8w4RVjZ4eIad6NHKvSkXv+86Cc=;
 b=s3IxUXCwTOYvQerA+eASUV5S9wWVhvij5EQxQcaTS4cFrlDHf9JTIyt8EUUH3/doBL
 GIqkqR4hfPJQINX8SbDruZ1Pjs+0lENU+TRC/GlidSGDizWLrB3H1o6K9NbwqU6lWBfj
 d1g/wc96sL6gL7QzJiT/q39E0lEYgjnfcIv8QdivbTK5hy6Vhk/bzJnm8A0My/zJPlwV
 4wRwcpp+59eUrnsNknoUoeqWMGp+soFbcnLXuiyUKofARibZbe6JMieU30ZJsrpkBY6h
 H95coA98p55Ss0NTmqyJEsVZcswYUkLW8RO5YQi9t6W84bVosWPfzb/XWwQ00K/G6DHP
 jpNQ==
X-Gm-Message-State: AOAM531esL2RyGWZI6dY0DWdbgid9wVE3/yokX2BRONREWumbEdJyJWn
 fje2fYVDZT8bEiwpsLWk0gCHfGUAlyGcEtpzwTFu5QSy8BOGdrTVuhRDwhbUNJyMg9IsogtJBRJ
 tuT5MLQ6v7u1xhGwsvbkR/09TYHk0AmjLUunYS7+wqDs=
X-Received: by 2002:a25:820b:: with SMTP id q11mr12937128ybk.124.1619863124372; 
 Sat, 01 May 2021 02:58:44 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx3qfPjv06cSd5AQdciBB4pqA8zEoz9TzHDg0vVN9FyanY1AqssflyxafvDMZCvSwzGdPZrb0Ubhac45cGKLoo=
X-Received: by 2002:a25:820b:: with SMTP id q11mr12937109ybk.124.1619863124133; 
 Sat, 01 May 2021 02:58:44 -0700 (PDT)
MIME-Version: 1.0
References: <CAHj4cs-hAaHhWU4Kb4NrQ9Fvi7DiH95P=Q=7zK-inxpeZtztkw@mail.gmail.com>
 <3243ab72-ffe3-e655-ef0a-d695885ce2c5@grimberg.me>
In-Reply-To: <3243ab72-ffe3-e655-ef0a-d695885ce2c5@grimberg.me>
From: Yi Zhang <yi.zhang@redhat.com>
Date: Sat, 1 May 2021 17:58:32 +0800
Message-ID: <CAHj4cs9uOHRgRe9PJ3_0A4NMo4T1q4XzCYG6UAV-V=RZ39i1iQ@mail.gmail.com>
Subject: Re: [bug report] blktests nvme/022 lead kernel WARNING and NULL
 pointer
To: Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org, skt-results-master@redhat.com, 
 Bruno Goncalves <bgoncalv@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=yizhan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210501_105900_760963_CAA9B2CE 
X-CRM114-Status: GOOD (  13.89  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Sat, May 1, 2021 at 8:55 AM Sagi Grimberg <sagi@grimberg.me> wrote:
>
>
> > Hello
> > Recently CKI reproduced this WARNING and NULL pointer with
> > linux-block/for-next on aarch64, seems it's one regression, I will try
> > if I can bisect the culprit.
> >
> > blktests: nvme/022 (test NVMe reset command on NVMeOF file-backed ns)
> >
> > [ 1879.759978] run blktests nvme/022 at 2021-04-30 12:30:36
> > [ 1879.804283] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
> > [ 1879.819087] nvmet: creating controller 1 for subsystem
> > blktests-subsystem-1 for NQN
> > nqn.2014-08.org.nvmexpress:uuid:0da758a0-4d84-4133-82dd-9801235b55cd.
> > [ 1879.833081] nvmet: unhandled identify cns 6 on qid 0
> > [ 1879.838079] nvme nvme0: creating 128 I/O queues.
> > [ 1879.852353] nvme nvme0: new ctrl: "blktests-subsystem-1"
> > [ 1880.879731] nvme nvme0: resetting controller
> > [ 1889.940458] nvmet: ctrl 1 keep-alive timer (5 seconds) expired!
> > [ 1889.946377] nvmet: ctrl 1 fatal error occurred!
> > [ 1889.950928] nvme nvme0: Removing ctrl: NQN "blktests-subsystem-1"
>
> It appears that we are somehow now expire the kato after/during a reset
> sequence and then seem to race reset and remove...
>
> bisection will help definitely.
>
Hi Sagi

Bisect shows bellow commits was the first bad commit.

commit a70b81bd4d9d2d6c05cfe6ef2a10bccc2e04357a (refs/bisect/bad)
Author: Hannes Reinecke <hare@suse.de>
Date:   Fri Apr 16 13:46:20 2021 +0200

    nvme: sanitize KATO setting

Thanks
Yi


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
