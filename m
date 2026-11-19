Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C8A860A2626
	for <linux-nvme@archiver.kernel.org>; Thu, 19 Nov 2026 13:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=jnamIgzd;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GrCxvm/1
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Unsubscribe-Post:List-Owner;
	bh=ZEhJOzyXKju3tKMEHQwkNUXNp0T51VucdQQfkmvqiQM=; b=jnamIgzdXyzJpHVmU0I4lkCow+
	w0z3Ajwmg24aBkPMXhGViEqMh33QOAEz3uomJdFGT4obZ/hqqmrypfaoHeZXnyWJT63F582H9P4ct
	TD79vdsGyye0TMiROck+9dda7dvtftGSPZ+4B4qQojsOA3uN32EcLSCdqwADL7EN4Oujpsvdl/dyA
	WIn0Y4rK4Xza1TsHiV5YPp1d9FhV8IrmxwkNenBr5W1bbxOkYqgp7mNhp52cgbZTUTABENLScvgD+
	8BZ/8bLc8nYryjla1nXlvyT45F3Vyr7FNBAtw52qnd4xtJfUTyscdC7EBulWOe5Q4yJEEjwNOcO11
	dg0nSG3w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xU2HM-0000000C4a8-40gB;
	Thu, 19 Nov 2026 13:34:20 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xU2HL-0000000C4a0-2H02
	for linux-nvme@lists.infradead.org;
	Thu, 19 Nov 2026 13:34:19 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id D3F9E46053;
	Thu, 19 Nov 2026 13:34:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1FAA1F000C5;
	Thu, 19 Nov 2026 13:34:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795095258;
	bh=ZEhJOzyXKju3tKMEHQwkNUXNp0T51VucdQQfkmvqiQM=;
	h=From:To:Cc:Subject:Date;
	b=GrCxvm/1lTIpcplkRdycUOpd8LVxmcPVO6UlPCcpghV8chsq66wX7A7O7TxLup21a
	 pWIcbGGSrVmxkJTuFAJgNiOVC4ou3TGAx8Gmgh2LFsrtjcM1eYJ/sqRT7p+z09a5Ku
	 +FkxP7Y4U+dV7F9m3UXNaWI544KdtoU5vOTRGSbMCrIrWYHK7h+NtQUXQHr/IZaZjM
	 qv0yO2QAK4wQBVFeiYu7q0dMivT1CnGyBlmaULCWxP50XnjNFaACPP/IEUAgaYRg2e
	 1uX5zf32+m1tKzZO5Hsp1MBL8GjysMxL372SXHLPLsPpadYgh/NfVjrC8Bx5G//qwU
	 Soeyhs3nmUgpQ==
From: Christian Brauner <brauner@kernel.org>
To: linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-block@vger.kernel.org,
	linux-ide@vger.kernel.org,
	linux-scsi@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	bpf@vger.kernel.org
Cc: Christian Brauner <brauner@kernel.org>,
	lsf-pc@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org,
	Kanchan Joshi <joshi.k@samsung.com>,
	"Martin K. Petersen" <mkp@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>,
	Jan Kara <jack@suse.cz>,
	Vlastimil Babka <vbabka@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Alexei Starovoitov <ast@kernel.org>
Subject: LSF/MM/BPF: 2027: Call for Proposals
Date: Thu, 19 Nov 2026 14:33:58 +0100
Message-ID: <20261119-lsfmm-2027-cfp-b7edcf7eee48@brauner>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4868; i=brauner@kernel.org; h=from:subject:message-id; bh=cENfH9cFzvlCJSmEwugWKvbkFTl+BgVyZRO6iqPrl+M=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWT9+3VG1DDxxd21Poei9nSxHb701fr/tFS26NI9pTvER DV/vPD37ChlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZhI/X+G/2H/jtyIlWyy/Kzx pkTjrv7suc3aO9J/f7a59nzzxGs/iw4xMnxfnLzy8SvWLZstLi0+oXpXekH66ZjLC5b3zF69ztR vrjULAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The annual Linux Storage, Filesystem, Memory Management, and BPF
(LSF/MM/BPF) Summit for 2027 will be held April 27-29, 2027 in Porto,
Portugal.

LSF/MM/BPF is a small, invitation-only technical workshop for the
people who develop and maintain the Linux storage, filesystem, memory
management, and BPF subsystems. We get together to work through
problems and to map out improvements that will make their way into the
mainline kernel within the coming years.

The summit runs for three days and has four subsystem-specific tracks.
Topics that touch more than one subsystem get joint sessions with all
affected tracks in the room. You're welcome to sit in on sessions of
other tracks too. There's also time for BoFs, hacking sessions and the
hallway track.

The sessions are supposed to be interactive, inclusive discussions. The
discussion leader outlines the problem and then the room works through
it. Slides and visualizations are encouraged but please refrain from
lengthy presentations.

The agenda is built from the topics proposed on the mailing lists. The
discussion a proposal gets on the list helps us figure out which topics
are important. The program committee then selects the topics and sends
out the invitations.

Attendance is limited to keep the sessions productive. When you request
an invitation, please tell us what you'd like to discuss and what
expertise you bring. We also want to make sure that people who are new
to the community get proper consideration. So if you're a maintainer or
have been around for a while, please nominate newer contributors in the
form.

LSF/MM/BPF is an in-person event and we don't offer general remote
participation. If you're needed for a topic but can't travel, let us
know and we'll try to find a solution.

Important dates
===============

    January 27, 2027    Deadline for invitation requests
    Mid-February        First round of invitations
    April 27-29, 2027   LSF/MM/BPF 2027 in Porto, Portugal

Venue
=====

The event will take place at the 

    Sheraton Porto Hotel & Spa
    R. do Ten. Valadim 146
    4100-476 Porto, Portugal

Do note that for this years iteration it is of the utmost importance
that you make use of the Linux Foundation hotel block.

All further details are availabe on the event site:

    https://events.linuxfoundation.org/lsfmmbpf/

Requesting an invitation
========================

To attend, please fill out this form by January 27, 2027. Proposing a
topic on the list without filling out the form will lead to us discussing
it without you!

    https://forms.gle/hhC9zXMsAJCR2dda6

In the form, please tell us:

    - what general areas you'd like to discuss and what expertise you bring
    - whether you need a visa. We handle those requests in the first
      round of invitations, so please don't wait.

We realize that travel is an ever-changing target, but the requests
help us get an idea of possible attendance numbers.

Proposing a topic
=================

In addition to the form, please send each topic as a new thread with
[LSF/MM/BPF TOPIC] in the subject to:

    lsf-pc@lists.linux-foundation.org

and Cc the lists that are relevant for the topic:

    FS:     linux-fsdevel@vger.kernel.org
    MM:     linux-mm@kvack.org
    Block:  linux-block@vger.kernel.org
    ATA:    linux-ide@vger.kernel.org
    SCSI:   linux-scsi@vger.kernel.org
    NVMe:   linux-nvme@lists.infradead.org
    BPF:    bpf@vger.kernel.org

Please use exactly this subject prefix so we can find the topic
proposals when putting together the schedule. The mailing list
discussions will be linked from the schedule so other attendees can get
a sense of whether a topic is of interest to them.

Previous years
==============

LWN has covered previous iterations of LSF/MM/BPF extensively:

    2014: https://lwn.net/Articles/LSFMM2014/
    2015: https://lwn.net/Articles/lsfmm2015/
    2016: https://lwn.net/Articles/lsfmm2016/
    2017: https://lwn.net/Articles/lsfmm2017/
    2018: https://lwn.net/Articles/lsfmm2018/
    2019: https://lwn.net/Articles/lsfmm2019/
    2020: 404 - Cancelled by The Plague
    2021: 404 - Cancelled by The Plague
    2022: https://lwn.net/Articles/lsfmm2022/
    2023: https://lwn.net/Articles/lsfmmbpf2023/
    2024: https://lwn.net/Articles/lsfmmbpf2024/
    2025: https://lwn.net/Articles/lsfmmbpf2025/
    2026: https://lwn.net/Articles/lsfmmbpf2026/

Program committee
=================

    Kanchan Joshi      (Storage)
    Martin K. Petersen (Storage)
    Christian Brauner  (Filesystems)
    Amir Goldstein     (Filesystems)
    Jan Kara           (Filesystems)
    Vlastimil Babka    (MM)
    Matthew Wilcox     (MM)
    Daniel Borkmann    (BPF)
    Alexei Starovoitov (BPF)

Thank you,
Christian Brauner

