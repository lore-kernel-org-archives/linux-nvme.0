Return-Path: <SRS0=ia7R=ZO=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 401D5C432C3
	for <linux-nvme@archiver.kernel.org>; Fri, 22 Nov 2019 17:25:13 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 183D020714
	for <linux-nvme@archiver.kernel.org>; Fri, 22 Nov 2019 17:25:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="B1RglhJ+";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=toxicpanda-com.20150623.gappssmtp.com header.i=@toxicpanda-com.20150623.gappssmtp.com header.b="hgmkiI/t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 183D020714
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Subject:To:From
	:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=qlGtAZPlL3lZAWL/4Ivl0jTRw2QJ7gQRx+Wa49tPKP4=; b=B1RglhJ+FE/bpw
	GYf2z11etBaZe0uGalaK5oP9stOZPdRbxDzeiJzerhxMDvbYIhm4xtQRHOge9RNKdQzh2j/iUpU8w
	6TcbF2UWa3gianAwfRWuWdg42ETUUUecORiG6giZLH9aDQX9w4XmR3CbMJpsGs3dIfLxhaiLapqC4
	LWipZzBL7WfU2H3+gT7zuHnrUo6pSV4YCMHUut3ma2E6yrIRqCNoRBGZ7wM/Mnkk6Q05JONwWj68y
	0TnaaQb3vKl7U/A1cYMmFCSs2ZJlI3JJlEZ196ie3TUCl+wjNeq1a+kFz2xpE7EPA5jKQMTKFrfJy
	lUy1Avxv3zhRHJyoL/0Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iYCgA-0004Q6-PT; Fri, 22 Nov 2019 17:25:10 +0000
Received: from mail-qk1-x733.google.com ([2607:f8b0:4864:20::733])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iYCg7-0003mo-HR
 for linux-nvme@lists.infradead.org; Fri, 22 Nov 2019 17:25:09 +0000
Received: by mail-qk1-x733.google.com with SMTP id m125so6927260qkd.8
 for <linux-nvme@lists.infradead.org>; Fri, 22 Nov 2019 09:25:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:mime-version:content-disposition
 :content-transfer-encoding;
 bh=x/t7YYwiNsScpRNZxre9kXNgeO6TrTQHVlcYwrBCrmw=;
 b=hgmkiI/tZFKNu2W5QdfvM49rKbFOs7bBlKXRcGQuWUpeB9HVnV7xPQvLfZFsHGrcgp
 /sLYsLft4o106guDCcDSTYez9sFUVFecJ71E7kyba4rIArbBT4iKkopzLMS36Go22kP5
 fcYXTTSuTWOZBRPy0ELYTiskw5s57Y8gPtMYmwYqvUaFcPBnJpKzQsAjtsjxB8lKr69s
 a7iq6JE3aUqT+o/Dr7lNJNSA3I+y4Q3ksVfYa9E2EhF3v6H47xgaTcNlzlbAVZ0fV5J/
 blbgb4ln/ZEjoNzLcybGwttpT9/wr0pflt3fK3tkzMWxqvn7oSZSzJ6LTXSKxNYU+Gha
 iGOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
 :content-disposition:content-transfer-encoding;
 bh=x/t7YYwiNsScpRNZxre9kXNgeO6TrTQHVlcYwrBCrmw=;
 b=p93l5iGQ5jG1eLRANWLqKagf48fox/GQ+BpwWnQzHulcqJyt1UcQudCq5U48AGI45+
 tXY0vmNTK3JLEF69Mb55Gs9q5DdaR9FAxDQb/jbeCj2b/mhMTvA8sTOxr45QZWCsET3u
 sCStQvGd6j0Zo6KMt49M3gwmFn0e5UqIdR0xIZt6TBa75xboNRxth5EXLk2YtI0pgW2c
 g8coqdFmjmr4uD60bV6dtlZMr3wkHMV+0M33GLjAGKKI2C9UxJXVtlv7KwG3WtaoG3yk
 P2dYVZpPnsPTz/vOMnePgkZlliHqhuOUrpuNVW/qlANEMvybcqW5U6DA/U5vxsxBkmRV
 Bc7Q==
X-Gm-Message-State: APjAAAWwD28wsem7VXRni2QgdskKV4n6/vltctgmTo3TO/FY0vNii5sF
 +VBPCVYWKS0HlYz8uU5fv/sEQQ==
X-Google-Smtp-Source: APXvYqx99CvvuJPnYd+Rq7afdv0vTgv7dWSgTIm3gn4xoBOvZhWu0Jdh2wyfyVQMdyNPJWGIaahWcw==
X-Received: by 2002:a05:620a:13d1:: with SMTP id
 g17mr14227390qkl.313.1574443505421; 
 Fri, 22 Nov 2019 09:25:05 -0800 (PST)
Received: from localhost ([2620:10d:c091:480::64e2])
 by smtp.gmail.com with ESMTPSA id v189sm3302167qkc.37.2019.11.22.09.25.03
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 22 Nov 2019 09:25:04 -0800 (PST)
Date: Fri, 22 Nov 2019 12:25:02 -0500
From: Josef Bacik <josef@toxicpanda.com>
To: lsf-pc@lists.linuxfoundation.org
Subject: LSF/MM/BPF: 2020: Call for Proposals
Message-ID: <20191122172502.vffyfxlqejthjib6@macbook-pro-91.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191122_092507_639294_99872C9F 
X-CRM114-Status: UNSURE (   9.17  )
X-CRM114-Notice: Please train this message.
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
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

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
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
