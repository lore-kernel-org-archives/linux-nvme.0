Return-Path: <SRS0=9cKU=3E=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28B18C32771
	for <linux-nvme@archiver.kernel.org>; Wed, 15 Jan 2020 21:54:24 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF30B2081E
	for <linux-nvme@archiver.kernel.org>; Wed, 15 Jan 2020 21:54:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="kunCHzgc";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=toxicpanda-com.20150623.gappssmtp.com header.i=@toxicpanda-com.20150623.gappssmtp.com header.b="KePd9Zfq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF30B2081E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Subject:To:From
	:Date:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=gZYdPWtYp14H6xghmiNScCSKOSrquMu/QCbbcrW7Xcg=; b=kunCHzgcbNUTdD
	kr1E/9IWMRMWyaKrvQnUk+cLEdFQPuPiPQVOPq6zvRkoCO3aRetALuryTW1U9ghPd0pGMnqwAihbD
	BEXYQLfJxucgzLez3bnjH5x18OmZ2UPyuF7FhrsVujNWb+PfZE/M1jsm3/h551eJrb6xVeLrSUMHD
	1+3loQ4BItLzofAQpcKs+JFg+R2b4MUPQ75IhSGgwF52ojiZAIWdShDzNpN+Tu/oDipj0ofZLCucV
	+mX1pglWGbcvSAnDp2/26TihW+aqLgpAD2KQFiFKkR0F5jAwiKfuZ4YDNvMA+oD/OAB9wuhkOwJXi
	ud8I6Y+xeKA0Nq1Tn5Ag==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1irqcE-0000Zr-Jb; Wed, 15 Jan 2020 21:54:18 +0000
Received: from mail-qt1-x834.google.com ([2607:f8b0:4864:20::834])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1irqcB-0000YV-2Y
 for linux-nvme@lists.infradead.org; Wed, 15 Jan 2020 21:54:17 +0000
Received: by mail-qt1-x834.google.com with SMTP id e12so17191856qto.2
 for <linux-nvme@lists.infradead.org>; Wed, 15 Jan 2020 13:54:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:subject:message-id:mime-version:content-disposition
 :content-transfer-encoding;
 bh=JtTvNccN+0/+lCGUOatY00GbzmTZrZ9tQej/2dZXgxw=;
 b=KePd9ZfqDfmOkXqFFTc3Q9LwzsdRxP/xYXtHcwOYE2P45KBCjSc7c09L/RvSjEB3lY
 QMzCYCg4J138ouYNcOygau/65JCD6GLK9yg6ZujG+wHqgyj6xyoPj6PIg6EXpnaufwh7
 Z510eSm16ZQQlyVQUQ6H4u455OeTZzrZoL2cHWu/2KDD55t3Dg3KPfSsFqOK1sG2ro6C
 wpw0NoTRojtNoZ1Mm/O6vJrSogBMAqYbLVyoBo6in2wt4xTkU/Q6oi+gH+1liu+6xGtu
 DNYenwCawyAjhSHWPmBnnZtQIznYZmw6UFDfQNPmBQgDGs4Z4KR8S2bmvh8uklxplGW+
 9kVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:subject:message-id:mime-version
 :content-disposition:content-transfer-encoding;
 bh=JtTvNccN+0/+lCGUOatY00GbzmTZrZ9tQej/2dZXgxw=;
 b=C4JkKNi6Xs2beoDaqAdKlZLgCCUvBiHB/0Zp6x5sP4P2J5ldWD2AABmfKqfCBJMEEA
 kRH4mVV71sDJ82TaZD6S15SARaL1N+juX+1hlbxrCzMr6PJXlyZwSNFwokqTpVMg4TZJ
 TRjWsOXn4qQ+i5BTp8gm+KRkADsBMqy/wP0jq6OyipbgbI/Wl7iBi8SK407SkL0vDwjY
 TNlzk6ylTjuwfGLltUVsWVgCu6PmbtGwy61M8MiDy/dJHKJYtR5FYhAA04I6oc3AjDAl
 VQKc5HnYlSWGFOiiOeS/aHQ3Fh1QECxHHzf82KD3objVVV2o3ZPF37KGaOBm22jUaqRk
 lrwg==
X-Gm-Message-State: APjAAAXqq+9GnyhCdPig2pAzCSpmWpem6fjXHM8kqdWPjFxWX15mqH8E
 8Qoi5KedQ8KGtrHKG11/1UkCSg==
X-Google-Smtp-Source: APXvYqxcRE3B5iQiFW7B0tOZ3c36MzfvnKAl5xIFQTt35nmhPCQoqb66aA5/hose3wVQiuv4Glt7kQ==
X-Received: by 2002:aed:2150:: with SMTP id 74mr707121qtc.323.1579125251168;
 Wed, 15 Jan 2020 13:54:11 -0800 (PST)
Received: from localhost ([107.15.81.208])
 by smtp.gmail.com with ESMTPSA id g21sm9058033qkl.116.2020.01.15.13.54.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jan 2020 13:54:10 -0800 (PST)
Date: Wed, 15 Jan 2020 16:54:09 -0500
From: Josef Bacik <josef@toxicpanda.com>
To: lsf-pc <lsf-pc@lists.linuxfoundation.org>,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
 linux-nvme@lists.infradead.org, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: REMINDER: LSF/MM/BPF: 2020: Call for Proposals
Message-ID: <20200115215409.5pd4fnoawqzs7rvw@jbacik-mbp>
MIME-Version: 1.0
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200115_135415_257080_55300FE9 
X-CRM114-Status: GOOD (  11.91  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

This is a reminder that we are still taking requests for this years Linux
Storage, Filesystem, Memory Management, and BPF Summit.  Below is the origi=
nal
announcement but we would like to hilight a few changes and re-iterate a few
things.

1) The venue has been finalized and as such the website is now live

	https://events.linuxfoundation.org/lsfmm/

2) Please make sure to fill out the google form to make sure we don't miss =
your
request.

3) PLEASE STILL SUBMIT TOPICS TO THE RELEVANT MAILINGLISTS.  The topics of
interest part of the form is so we can figure out what topics from the
mailinglist are the relevant discussions to have.  If you submit a topic pl=
ease
feel free to paste a lore link in your form if you've not already filled ou=
t the
form.

The rest of the details of course are in the original announcment which is
included below.  Thanks,

Josef

-------------- Original announcement ---------------------
The annual Linux Storage, Filesystem, Memory Management, and BPF
(LSF/MM/BPF) Summit for 2020 will be held from April 27 - April 29 at
The Riviera Palm Springs, A Tribute Portfolio Resort in Palm Springs,
California. LSF/MM/BPF is an invitation-only technical workshop to map
out improvements to the Linux storage, filesystem, BPF, and memory
management subsystems that will make their way into the mainline kernel
within the coming years.

LSF/MM/BPF 2020 will be a three day, stand-alone conference with four
subsystem-specific tracks, cross-track discussions, as well as BoF and
hacking sessions.

On behalf of the committee I am issuing a call for agenda proposals
that are suitable for cross-track discussion as well as technical
subjects for the breakout sessions.

If advance notice is required for visa applications then please point
that out in your proposal or request to attend, and submit the topic
as soon as possible.

This year will be a little different for requesting attendance.  Please
do the following by February 15th, 2020.

1) Fill out the following Google form to request attendance and
suggest any topics

	https://forms.gle/voWi1j9kDs13Lyqf9

In previous years we have accidentally missed people's attendance
requests because they either didn't cc lsf-pc@ or we simply missed them
in the flurry of emails we get.  Our community is large and our
volunteers are busy, filling this out will help us make sure we don't
miss anybody.

2) Proposals for agenda topics should still be sent to the following
lists to allow for discussion among your peers.  This will help us
figure out which topics are important for the agenda.

=A0 =A0 =A0 =A0=A0lsf-pc@lists.linux-foundation.org

and CC the mailing lists that are relevant for the topic in question:

=A0 =A0 =A0 =A0 FS:=A0 =A0 =A0linux-fsdevel@vger.kernel.org
=A0 =A0 =A0 =A0 MM:=A0 =A0 =A0linux-mm@kvack.org
=A0 =A0 =A0 =A0 Block:=A0=A0linux-block@vger.kernel.org
=A0 =A0 =A0 =A0 ATA:=A0 =A0=A0linux-ide@vger.kernel.org
=A0 =A0 =A0 =A0 SCSI:=A0 =A0linux-scsi@vger.kernel.org
=A0 =A0 =A0 =A0 NVMe:=A0 =A0linux-nvme@lists.infradead.org
        BPF:    bpf@vger.kernel.org

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

2019:=A0https://lwn.net/Articles/lsfmm2019/

2018:=A0https://lwn.net/Articles/lsfmm2018/

2017:=A0https://lwn.net/Articles/lsfmm2017/

2016:=A0https://lwn.net/Articles/lsfmm2016/

2015:=A0https://lwn.net/Articles/lsfmm2015/

2014:=A0http://lwn.net/Articles/LSFMM2014/

3) If you have feedback on last year's meeting that we can use to
improve this year's, please also send that to:

=A0 =A0 =A0 =A0=A0lsf-pc@lists.linux-foundation.org

Thank you on behalf of the program committee:

	Josef Bacik (Filesystems)
	Amir Goldstein (Filesystems)
	Martin K. Petersen (Storage)
	Omar Sandoval (Storage)
	Michal Hocko (MM)
	Dan Williams (MM)
	Alexei Starovoitov (BPF)
	Daniel Borkmann (BPF)

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
