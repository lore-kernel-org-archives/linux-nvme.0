Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34540C433F5
	for <linux-nvme@archiver.kernel.org>; Wed, 18 May 2022 23:07:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M2OU/ev/wtDvqHYNj5hP9zKluj3H/LLJ6QYPls9G5Tw=; b=FDsRIWyQzB+GYvxNPyGk3T0zuf
	ZONWG1iwkag9XmRf6C4VUXcLNTtK2rh/n1MVe1QPgUELt6FjWSg8KR0c5p4jaM1k+hufmNrHS4BP7
	VV9kmVuSzg7EFLA557p+74HE7daIi0UOAAyhKu7RPz8V2ond5jhMmlhCaDWCsGCnueEVjOaI9I76x
	2EvvBpNfOK8p/tQnLlmoryeBFNPcSuTNIuUCkY8fgP4e4ab5UTbF4bdyztXp4UheQyTPIT0LWlb6X
	iNUds4s6M5CR7AYb//6Y+zydEkeB7jnFjW8sdzCNrvKfRDQdrhvMvwK8ha2j4EmQ24M8s6B0P8SK6
	tJwiETkg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nrSkr-004EMG-9l; Wed, 18 May 2022 23:06:57 +0000
Received: from mail-pj1-f46.google.com ([209.85.216.46])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nrSkn-004ELR-En
 for linux-nvme@lists.infradead.org; Wed, 18 May 2022 23:06:55 +0000
Received: by mail-pj1-f46.google.com with SMTP id ds11so3537758pjb.0
 for <linux-nvme@lists.infradead.org>; Wed, 18 May 2022 16:06:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=M2OU/ev/wtDvqHYNj5hP9zKluj3H/LLJ6QYPls9G5Tw=;
 b=HOX/MbghSm/XT6lgoKirAboAUAA3wXODNCzX0NNGhvYHONx8xUZOFvlH3d+ubx5HtN
 5A5Xitb8kdRaBLI8SbO8mq+UwKo54R+10MFUfwSDHozxCtlGrhmaZMZY13xG53iLoG+5
 kiomNapKax8S81CLu2HupFhefgyuYvriuAFnoFi3Dtgi4NTrXQ/COW+YrbTzSBsz/FWc
 ibpTmLg22lJ52fcD25Dnz6rkeoLQg8QZxoJjCmZR8/C6q+e7Ifa/Xnwp02xkRiy+WgPB
 zqs3KrFS5hZvvCt7uPc2oN648CRfJQgzOyf7L43vg2SS7faaOxoDlWSGBArQU1fZxmJZ
 yDyA==
X-Gm-Message-State: AOAM5334cT47U2SUTWEVSmw1U7exz6JH25EdLMk99tjyX2GVSOOQiqrE
 1YP6QRR07P7QGv2y5loZ1p+TkfSI0NY=
X-Google-Smtp-Source: ABdhPJxrRrwxuaXVXZU5unUYT2Wp/ah35BZYv61mf/nd9Yr//ww7daRstQvEvrGocfyzbj6E/VCrbQ==
X-Received: by 2002:a17:90a:9282:b0:1dc:4a1b:ea55 with SMTP id
 n2-20020a17090a928200b001dc4a1bea55mr1854383pjo.24.1652915210525; 
 Wed, 18 May 2022 16:06:50 -0700 (PDT)
Received: from garbanzo (136-24-173-63.cab.webpass.net. [136.24.173.63])
 by smtp.gmail.com with ESMTPSA id
 t1-20020a17090340c100b0015e8d4eb271sm2130390pld.187.2022.05.18.16.06.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 May 2022 16:06:49 -0700 (PDT)
Date: Wed, 18 May 2022 16:06:46 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: Theodore Ts'o <tytso@mit.edu>
Cc: Christoph Hellwig <hch@lst.de>, Pankaj Raghav <p.raghav@samsung.com>,
 axboe@kernel.dk, pankydev8@gmail.com, gost.dev@samsung.com,
 damien.lemoal@opensource.wdc.com, jiangbo.365@bytedance.com,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 dm-devel@redhat.com, dsterba@suse.com, linux-btrfs@vger.kernel.org
Subject: Re: [dm-devel] [PATCH v4 00/13] support non power of 2 zoned devices
Message-ID: <20220518230646.5xx6dpo4helwyqcv@garbanzo>
References: <CGME20220516165418eucas1p2be592d9cd4b35f6b71d39ccbe87f3fef@eucas1p2.samsung.com>
 <20220516165416.171196-1-p.raghav@samsung.com>
 <20220517081048.GA13947@lst.de> <YoPAnj9ufkt5nh1G@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YoPAnj9ufkt5nh1G@mit.edu>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220518_160653_529049_B2B8A661 
X-CRM114-Status: GOOD (  15.85  )
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

On Tue, May 17, 2022 at 11:34:54AM -0400, Theodore Ts'o wrote:
> On Tue, May 17, 2022 at 10:10:48AM +0200, Christoph Hellwig wrote:
> > I'm a little surprised about all this activity.
> > 
> > I though the conclusion at LSF/MM was that for Linux itself there
> > is very little benefit in supporting this scheme.  It will massively
> > fragment the supported based of devices and applications, while only
> > having the benefit of supporting some Samsung legacy devices.
> 
> FWIW,
> 
> That wasn't my impression from that LSF/MM session, but once the
> videos become available, folks can decide for themselves.

Agreed, contrary to conventional storage devices, with the zone storage
ecosystem we simply have a requirement of zone drive replacements matching
zone size. That requirement exists for po2 or npo2. The work in this patch
set proves that supporting npo2 was in the end straight forward. As the one
putting together the BoF I can say that there were no sticking points raised
to move forward with this when the topic came up. So I am very surprised to
hear about any other perceived conclusion.

  Luis

