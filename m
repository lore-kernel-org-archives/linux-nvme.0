Return-Path: <SRS0=GcL3=KF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_RED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41ED0C433ED
	for <linux-nvme@archiver.kernel.org>; Mon, 10 May 2021 18:02:30 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE3B161554
	for <linux-nvme@archiver.kernel.org>; Mon, 10 May 2021 18:02:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE3B161554
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:MIME-Version
	:List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:Cc:To:From:Date:Message-ID:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=4891Gj2btVIWVIkcBWtjrAA5xR4eCmKEBgVKgzCxHY4=; b=MWC8f2XMc3JxchZP1pyvXWW9G8
	jY5kmFQfV1Aj9sduapa4qaqH9JGZlQTmuwB1qJf1heamWnOorFYH9+LYYNG+4oLERMIySwXejkjMo
	HJecFUpLkDfcnP7g87t3iGzLVv95ekybwSx8xom9g6YYSl7LvjRcjamLp8DG1xF/ocdC6PcEp9OVd
	1o/baw2ni9IgyyHfcAb5BwC7HaKcbYU/HZOJzvF1KqJjUIbDhNQdeM7w0UYKY/l5ukwmxz/yw6q7W
	KC2ITz/tgHLbSn7O9YcVY1yQMMS+AkXAf2PgG+7tyiCU1oKwDZlzLPfAaIq1+/OvWjicUnp+Gddh2
	oq9cS2JQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lgAER-00FLES-SB; Mon, 10 May 2021 18:02:15 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lg9vD-00FEC7-HZ
 for linux-nvme@desiato.infradead.org; Mon, 10 May 2021 17:42:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Subject:Cc:To:From:Date:Message-ID:
 Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Content-ID:Content-Description:In-Reply-To:References;
 bh=n5gxQcJcWf8uN8nViJiC2oY2o4qpc3D4xM0tKR6YYWA=; b=bStAFxw4ySgoAUNiKUMDB4nVO0
 2T7j86Y04McW+4Wn/N3Hwk8nc1Ak5U8FGlRTqGzE0YEvM09hrkelrB55zjD1v1+GsjJb69IwJKd5W
 o7CnNxOpjgf9j/Blq1z4eeGvFofTBiHuVzehLvJgaV0YkVFDJB0DahxfSkcCWsScskvOS8FHvo8/m
 bwU6r+QaWZMAdeUPQ+Iclvjs35g8vB1twqbkv5Bap/7fXC6BCxJH3+pL96NlSrRzI8RaBrENgTnni
 5CgXL/H7dmfax5uLJyjwCcH33L/uOt6VXGvg22hB9gxyLtC+WeydejmKyQVgvq9HhgiA/C+v4JGXi
 +74G5j2g==;
Received: from mail-qk1-x72e.google.com ([2607:f8b0:4864:20::72e])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lg9vA-008zmb-4a
 for linux-nvme@lists.infradead.org; Mon, 10 May 2021 17:42:22 +0000
Received: by mail-qk1-x72e.google.com with SMTP id x8so16164805qkl.2
 for <linux-nvme@lists.infradead.org>; Mon, 10 May 2021 10:42:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
 h=message-id:date:from:to:cc:subject;
 bh=n5gxQcJcWf8uN8nViJiC2oY2o4qpc3D4xM0tKR6YYWA=;
 b=IWPeC1KeCJWcRYiMi/iOkteNjl3MP0cQx6RWg3IG/lTEXG+OBFqZJ84ZKty0x0V1hA
 wWO4vZplz7tfGCQg2OV6cRT9D03LcQnDGInItUJ4R/NYr5RJY0QI0bdszTf6qKkkqmOd
 1FQRKCKPAl8QMuzpFRSg48xlfhpQZpTIn6LIuK5Aq4lKpQwysWDGQ0/UmFsPQY7/dhZ3
 5CpfDXUDx7eDnAHO3sKNFZJ/xSRpZSVO6nWf0LwZ1DH9rk2V9jdLBAm1mbcl9qMeLeGP
 3OhD1lZ8+lKsbnJZjS62/KlPRlCzHUt/lHTnk/S4rjJQjyFjLwdIYFrLUFpmLfO/tthm
 WHhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:message-id:date:from:to:cc:subject;
 bh=n5gxQcJcWf8uN8nViJiC2oY2o4qpc3D4xM0tKR6YYWA=;
 b=cH1wTj7vvDILDnxWxESBqtBgjPKzNbaTp0sJq4UY74UyshKx37Rtbt3hxc63EbGHDN
 O9BMhnq8Ar+MorjjjtMXukvBkA3Aj6D4siWxeg5Ehqot9IDwruFkgPCijmM1i6G3foSO
 Gj26AhIVeg2RWqH13MOLr6lCebv7Sgo0VGSRNUPFfsL8VpoywOMhdIWkPShyhC2rMQs2
 k3SKp8WVR7yC1+HeHBm4NcjkF82LibPUpZeXcvt8DB3pJuo94gyUgwLeohg0vUVJ+WqL
 K2VcjV3iuThInB7zYb4la3B49KBfdBch5m0MxofUCdn2+/SA2kFbfALBBQM5KKAfsy3P
 o1zg==
X-Gm-Message-State: AOAM530i2WFYAFFkrUCnPguo/+de0EOTXaq/KOpsL/3tUnv/j9dWDmEV
 5biiBu4DxxD6cM7IN5vtn2SAdA==
X-Google-Smtp-Source: ABdhPJxQFETD6GAmxPhza4gO2s5UxBFf1tocdyjImVzCAogXWQ07nVOtv38yIho+4lIEBuKwJZC63w==
X-Received: by 2002:a37:a2d5:: with SMTP id
 l204mr22524422qke.331.1620668538377; 
 Mon, 10 May 2021 10:42:18 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
 by smtp.gmail.com with ESMTPSA id z30sm12740561qtm.11.2021.05.10.10.42.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 May 2021 10:42:17 -0700 (PDT)
Message-ID: <60997079.1c69fb81.77f3f.a045@mx.google.com>
Date: Mon, 10 May 2021 13:42:16 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: lsf-pc@lists.linuxfoundation.org
Cc: linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
 linux-nvme@lists.infradead.org, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: [RESEND] LSF/MM/BPF: 2021: Call for Proposals
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210510_104220_248898_31A9E14E 
X-CRM114-Status: GOOD (  12.99  )
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
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4640498375845617177=="
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

--===============4640498375845617177==
Content-Type: text/plain

[apologies, 2021 and email is still my nemesis]

The annual Linux Storage, Filesystem, Memory Management, and BPF
(LSF/MM/BPF) Summit for 2021 will be held from December 6 to December 8
at The Margaritaville Resort Palm Springs in Palm Springs, California.
LSF/MM/BPF is an invitation-only technical workshop to map out
improvements to the Linux storage, filesystem, BPF, and memory
management subsystems that will make their way into the mainline kernel
within the coming years.

COVID is at the front of our minds as we attempt to put together the
best and safest conference we can arrange.  The logistics of how to hold
an in person event will change and evolve as we get closer to the actual
date, but rest assured we will do everything recommended by public
health officials.

LSF/MM/BPF 2021 will be a three day, stand-alone conference with four
subsystem-specific tracks, cross-track discussions, as well as BoF and
hacking sessions.

On behalf of the committee I am issuing a call for agenda proposals
that are suitable for cross-track discussion as well as technical
subjects for the breakout sessions.

If advance notice is required for visa applications then please point
that out in your proposal or request to attend, and submit the topic as
soon as possible.

This years instructions are similar to our 2020 attempt.  We're asking
that you please let us know you want to be invited by June 15th, 2021.
We realize that travel is an ever changing target, but it helps us get
an idea of possible attendance numbers.  Clearly things can and will, so
consider the request to attend deadline more about planning and less
about concrete plans.

1) Fill out the following Google form to request attendance and
suggest any topics

	https://forms.gle/Dms7xYPXLrriFkcXA

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


--===============4640498375845617177==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

--===============4640498375845617177==--
