Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4721C433EF
	for <linux-nvme@archiver.kernel.org>; Thu, 24 Feb 2022 15:59:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=gqOgm8FvfYxrPnxT+G4DW2qNZzJhArG622fIixWhtpg=; b=0Vrhk3ndXh422Dz5ywdb+qSYTU
	bHHSrHyLRVQ1PaAaDHdxua8Ktec5E25OZArHKMv4x6i/X6JzjDpj7o+3npX4XNqOJM6iauIieg4Gn
	wF6AGixM5RzjHXBprvkNg9BuBvVer6S72SHYJvQM1mqDFDbEr6TojWXrhFm9jt6i3cjxXr4dQ3nr9
	YJXu9RDLyacYjRuMP8AWtSYFwr1OJRyx2hzcXLPZ4KX6ag+4n85nib1TmAkUdJelZqen6y1jtm926
	19jpfkPqsmI4LK+EsapuXu06E6qPCdxj8uJrzWFm2iEjewwvv9AmRrW6aCRMrAj3U3o3psziNFO+b
	YuL3INIQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nNGWh-001Pom-Hf; Thu, 24 Feb 2022 15:59:31 +0000
Received: from mail-qv1-xf2e.google.com ([2607:f8b0:4864:20::f2e])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nNGWe-001PmE-77
 for linux-nvme@lists.infradead.org; Thu, 24 Feb 2022 15:59:30 +0000
Received: by mail-qv1-xf2e.google.com with SMTP id j11so4420855qvy.0
 for <linux-nvme@lists.infradead.org>; Thu, 24 Feb 2022 07:59:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
 h=date:from:to:cc:subject:message-id:mime-version:content-disposition
 :content-transfer-encoding;
 bh=gqOgm8FvfYxrPnxT+G4DW2qNZzJhArG622fIixWhtpg=;
 b=h5ZN26X5NAmhxjI2cNyZTmm5+2BZQaB4PhQXbBOhwml31PknsRkSxpnie5Pk4e0n8N
 ucMddJt/VKcrD9FCGE1zCONNj+58mibz9qaTly7ZSs8IOPNpfWSdXIk9bJOyY3v2osKR
 fbaKNoDJ5JuvmWbPO700vsU0BSR38IoUkcctt81R1wocDgUthuwF+/lFAHdfS3zgLGgC
 LpHaI3b7NWCQPs6HVwySmgr9xSeRIEpx6+ByISYyqPZ7GlchosjA+y3B47saPKpwOWcA
 QUFvAm0akg5UlWQlGCmRw+5HXyDvIck88WNhoeWOXMTwVNMR3907iZEJ4Rb23hd08jHx
 Am1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
 :content-disposition:content-transfer-encoding;
 bh=gqOgm8FvfYxrPnxT+G4DW2qNZzJhArG622fIixWhtpg=;
 b=Gswkta/2ceak+lHrGpm7tRgsppmS08/EKY2XsXffwVKtiMaIMFrUYvpe15d9dbGOAq
 FqoxYiY7emipVPEY4xH3floOppXH1lNY1qqZ8KJycnBZiBLCW0T0YiAzYQOApAZmmoAa
 H7OKlGxyKfccZImMUb/yVNYuJNbIBsMovrS5XTJIX1O02ScisKiVRf5A7hzc45FcyS5o
 bLpFtsWhboJfVBj6u2CQw/rBVfg6+Q7sATmJfTz0nNtQ5E8fYYb+ymqBWDRSTHHrtY/l
 QmI2IMgk3WTbksmiUdabnSLLIkZBJJYSQkbD6OYVw9Bg8l43vqzR5nav6fN9WMwNdS+u
 aURA==
X-Gm-Message-State: AOAM531bUwUboq11aiQHDd1aHwM4lZrBvSglAU001gsU1fGLS4gwOMPn
 AoHvWzvWvNERG9KcLpndbmu2AQ==
X-Google-Smtp-Source: ABdhPJyLQ1BrprrPj7Z/ncbZLKkWpbFJ6QCGUwxS4i7cOHcc1fXc5hBuljJyNTFV6nRd3+MQsFxngQ==
X-Received: by 2002:ac8:578c:0:b0:2de:7281:6234 with SMTP id
 v12-20020ac8578c000000b002de72816234mr2991255qta.359.1645718365211; 
 Thu, 24 Feb 2022 07:59:25 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
 by smtp.gmail.com with ESMTPSA id z14sm1739862qtw.56.2022.02.24.07.59.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Feb 2022 07:59:24 -0800 (PST)
Date: Thu, 24 Feb 2022 10:59:23 -0500
From: Josef Bacik <josef@toxicpanda.com>
To: lsf-pc@lists.linuxfoundation.org
Cc: linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
 linux-nvme@lists.infradead.org, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: [REMINDER] LSF/MM/BPF: 2022: Call for Proposals
Message-ID: <YherWymi1E/hP/sS@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220224_075928_326947_793C4B28 
X-CRM114-Status: GOOD (  15.06  )
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

A few updates

- The COVID related restrictions can be found here 

	https://events.linuxfoundation.org/lsfmm/attend/health-and-safety/

- We are working on a virtual component, however it will likely not be
  interactive, likely just a live stream and then an IRC channel to ask
  questions through.

--- Original email ---

The annual Linux Storage, Filesystem, Memory Management, and BPF
(LSF/MM/BPF) Summit for 2022 will be held from May 2 to May 4 at The
Margaritaville Resort Palm Springs in Palm Springs, California.
LSF/MM/BPF is an invitation-only technical workshop to map out
improvements to the Linux storage, filesystem, BPF, and memory
management subsystems that will make their way into the mainline kernel
within the coming years.

COVID is at the front of our minds as we attempt to put together the
best and safest conference we can arrange.  The logistics of how to hold
an in person event will change and evolve as we get closer to the actual
date, but rest assured we will do everything recommended by public
health officials.

LSF/MM/BPF 2022 will be a three day, stand-alone conference with four
subsystem-specific tracks, cross-track discussions, as well as BoF and
hacking sessions.

On behalf of the committee I am issuing a call for agenda proposals
that are suitable for cross-track discussion as well as technical
subjects for the breakout sessions.

If advance notice is required for visa applications then please point
that out in your proposal or request to attend, and submit the topic as
soon as possible.

This years instructions are similar to our previous attempts.  We're
asking that you please let us know you want to be invited by March 1,
2022.  We realize that travel is an ever changing target, but it helps
us get an idea of possible attendance numbers.  Clearly things can and
will change, so consider the request to attend deadline more about
planning and less about concrete plans.

1) Fill out the following Google form to request attendance and
suggest any topics

	https://forms.gle/uD5tbZYGpaRXPnE19

In previous years we have accidentally missed people's attendance
requests because they either didn't cc lsf-pc@ or we simply missed them
in the flurry of emails we get.  Our community is large and our
volunteers are busy, filling this out will help us make sure we don't
miss anybody.

2) Proposals for agenda topics should still be sent to the following
lists to allow for discussion among your peers.  This will help us
figure out which topics are important for the agenda.

        lsf-pc@lists.linux-foundation.org

and CC the mailing lists that are relevant for the topic in question:

        FS:     linux-fsdevel@vger.kernel.org
        MM:     linux-mm@kvack.org
        Block:  linux-block@vger.kernel.org
        ATA:    linux-ide@vger.kernel.org
        SCSI:   linux-scsi@vger.kernel.org
        NVMe:   linux-nvme@lists.infradead.org
        BPF:    bpf@vger.kernel.org

Please tag your proposal with [LSF/MM/BPF TOPIC] to make it easier to
track. In addition, please make sure to start a new thread for each
topic rather than following up to an existing one. Agenda topics and
attendees will be selected by the program committee, but the final
agenda will be formed by consensus of the attendees on the day.

We will try to cap attendance at around 25-30 per track to facilitate
discussions although the final numbers will depend on the room sizes
at the venue.

For discussion leaders, slides and visualizations are encouraged to
outline the subject matter and focus the discussions. Please refrain
from lengthy presentations and talks; the sessions are supposed to be
interactive, inclusive discussions.

There will be no recording or audio bridge. However, we expect that
written minutes will be published as we did in previous years:

2019: https://lwn.net/Articles/lsfmm2019/

2018: https://lwn.net/Articles/lsfmm2018/

2017: https://lwn.net/Articles/lsfmm2017/

2016: https://lwn.net/Articles/lsfmm2016/

2015: https://lwn.net/Articles/lsfmm2015/

2014: http://lwn.net/Articles/LSFMM2014/

3) If you have feedback on last year's meeting that we can use to
improve this year's, please also send that to:

        lsf-pc@lists.linux-foundation.org

Thank you on behalf of the program committee:

        Josef Bacik (Filesystems)
        Amir Goldstein (Filesystems)
        Martin K. Petersen (Storage)
        Omar Sandoval (Storage)
        Michal Hocko (MM)
        Dan Williams (MM)
        Alexei Starovoitov (BPF)
        Daniel Borkmann (BPF)

