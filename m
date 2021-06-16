Return-Path: <SRS0=zgHd=LK=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CB42C48BE5
	for <linux-nvme@archiver.kernel.org>; Wed, 16 Jun 2021 15:02:23 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D08BC600EF
	for <linux-nvme@archiver.kernel.org>; Wed, 16 Jun 2021 15:02:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D08BC600EF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	MIME-Version:List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe
	:List-Id:Subject:Cc:To:From:Date:Message-ID:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=5lbfxRGYZGWOg3ba93K1smgsSK36qbLS0p8XQzHLqG4=; b=QdW
	OkM4sF01lo/K/qe9dtgJmBzafwTAVJxIJoebFr3nzM+DjLmcZXTS68rHhl0S3871JKa2Cti4azyKc
	Y6x639Xh+3yLf7aKadm3ICiaaNCRfkwoSLnd4v5sHe3DvxTJiUDhH8vyzGE0TAchFDrOKHKEGiohz
	Xfyfz9vAmM6rrJ8srA6AIJH7ZlxhTCW6Td8tyVlIo7hFLDlVrDStnti4zv/41YCybMFuzEROi8mku
	PAkGulnbcTPSA7DXp0FFAM7PBggwl7TC7Eyb4VbSRkR8QZpTB44UHzh5Lu7xtRbxuK/9MtkQ4+0xj
	3c43BMpqO2VgOjYWcv34d0idhwxAc7Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ltX3S-006nnN-Lo; Wed, 16 Jun 2021 15:02:10 +0000
Received: from mail-qv1-xf2b.google.com ([2607:f8b0:4864:20::f2b])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ltX3O-006nm7-Qo
 for linux-nvme@lists.infradead.org; Wed, 16 Jun 2021 15:02:08 +0000
Received: by mail-qv1-xf2b.google.com with SMTP id dj3so923489qvb.11
 for <linux-nvme@lists.infradead.org>; Wed, 16 Jun 2021 08:02:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
 h=message-id:date:from:to:cc:subject;
 bh=VCvQSABjEdEuwxE7dUwxvVJle5680VQCMhFOlxSQ0RU=;
 b=1JHFKXXWxomTbkugVQMZnpalACfTC8IlhOqgFvXblCYSIV7KNdgtakEsiLHcEej6RT
 JMoGmH/y0ghKIyrRakbnD9xBFw8SxlZryrGCRT8fl0oiHQetebcqzmfoUogSF9v0kAIW
 eDJreJOM1uKAxARBQLgDGsmB8eZZl1YTybntm+qGmc+RuZMpi4gM4BhV1qDurg6d0kDD
 2T97LEdmKUz4vZZ3ssL+4B2CMbb4CCvfPD40tcjIGGkpP0vlqoEis5WjiBG1xhdz25EG
 n0B94JW6T5shp64W3FCHZibHWYySzxnd9yvc4aK2zyBH0mnbxKxxYVV79CGpyznCfnJq
 RY3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:message-id:date:from:to:cc:subject;
 bh=VCvQSABjEdEuwxE7dUwxvVJle5680VQCMhFOlxSQ0RU=;
 b=XFHMhGvymqabNKwNZ+NKsDXGYWdNAquf9JMKtkTFoIJ0YZs3oNoqAyS6pLZlgSkmo/
 EwfrmYdwDiBovbZ7XTuNHCZTO1vAYTaUUtjJPBkaumtCFhRW2wvuZAueWxIx0q7VMcTZ
 IgD98D+UDrdnPmokxrZSFDNUS4af4F+CQ6SjMvsPdEv2zZaApUJDnd4ErcmZfXym5dc8
 R231X8Sp+bkyXz7Jw2glcipKrPAdl1kDLFmhwBDBehpA4dJkT9KmQApDm5/JFI2OPjxE
 gx/vTU4Scz2nj6KN7T07Nl5GgoHT+V+X/szNGl36joy2kLY+D2xhHUdiwLO3MvdVlBXp
 Hz5Q==
X-Gm-Message-State: AOAM5301PpNULtoBNXXrcbWU3ZsykvT7zflFJVB5z/PiOZG2IG7SJAQ7
 98e0WGNm9U2p3muBkXRvrm9VOQ==
X-Google-Smtp-Source: ABdhPJytC9l/wfvfg7sP8rjAGewkfuTAUH85RNI3r+SM2Ul/Q9EdT8cKP9pkjx6l7tAtOlLX0/G9Rw==
X-Received: by 2002:a0c:ed46:: with SMTP id v6mr465673qvq.46.1623855724103;
 Wed, 16 Jun 2021 08:02:04 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
 by smtp.gmail.com with ESMTPSA id y20sm1390690qtv.64.2021.06.16.08.02.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Jun 2021 08:02:03 -0700 (PDT)
Message-ID: <60ca126b.1c69fb81.90af4.93a7@mx.google.com>
Date: Wed, 16 Jun 2021 11:02:02 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: lsf-pc@lists.linuxfoundation.org
Cc: linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
 linux-nvme@lists.infradead.org, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: [REMINDER] LSF/MM/BPF: 2021: Call for Proposals
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210616_080206_913343_43340F2E 
X-CRM114-Status: GOOD (  14.59  )
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
Content-Type: multipart/mixed; boundary="===============1869395730755968814=="
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

--===============1869395730755968814==
Content-Type: text/plain

Thisi is just a reminder that we're still going ahead with an in person
LSF/MM/BPF this year.  The Linux Foundation is working out the safety
guidelines and will update the landing page when that is nailed down.
In the meantime there is plenty of time to register your interest in
attending.  Thanks,

Josef

---- Original CFP ----

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


--===============1869395730755968814==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

--===============1869395730755968814==--
