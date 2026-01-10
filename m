Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A953BD277D7
	for <linux-nvme@archiver.kernel.org>; Sat, 10 Jan 2026 13:25:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=t8hmhKecuVTGXZjRDkn2ex5jlI1GPUMbmXgngKLupKI=; b=xV5lCtaY7L6PMT/DXgfCp7VRjM
	DWzr7fmNnurA4OXkF2I09Z0uIev6rdiOVY3DH2iQRv26zPsPvfG7SfPEFdbNmeNN8uXiB+tGRQc9P
	DqD8olMqqZXjv0K6Xw8Ka79JzAYbNi5UFYl1Kf1P6TavTeFYVRN779Xybns03TYciT/Q3mTodHghS
	OLdo1TAMtMdGZ3ChVkzkUiVUXLADVXbDzjThIrXOJOWABEhIkUzkpbZG+anpg2/21JkuG2jmEo0Y2
	iF5Myyy43g+mTBSMQsGwQ8QgH/I/W4QgJ1E1NiUcOzL9n8i/Stg7qxGTF/wHRw+yDISw17+Vquwgz
	hmmJWAbg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1veYxg-00000003TEu-0jVl;
	Sat, 10 Jan 2026 13:25:00 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1veYxd-00000003TEZ-40aR
	for linux-nvme@lists.infradead.org;
	Sat, 10 Jan 2026 13:24:59 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 8CF5F418B9;
	Sat, 10 Jan 2026 13:24:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66204C4CEF1;
	Sat, 10 Jan 2026 13:24:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768051496;
	bh=XA4YqUHgVUeiBE4BwIy5hjNCCWAzL6nLNBDSXX3oIa4=;
	h=From:To:Cc:Subject:Date:From;
	b=jdjV/hI9oazcXsnapq++rNYBetnJTCDRp1y0SsdGZQ9mJvOp4uDsRJuu9Aplp/pjE
	 HIli9Mc6YG1zVJccQyojy4dbZEm0u0u4oqLZIIaPPqIQk1gEft9lfyQr1QjAxOKyRZ
	 LkDNJd8y+kK6sZhx41M5sHN/+wXzT6K9oHq22GKAvQtGfMG0ZOQ5pXrFSqjvIamnoA
	 sbYPtzN3H0SeI5hZFjpVtV4Xs09wTfH9c+M9in87y58XFTClsTJumtBme2vHTUZXd0
	 +xxvB8838GPVI5655N+E1lN3bAxlk1c269Qf3gVOwp/Phtu80PA3RUhJ7ImjXJNgsr
	 DgFUeKAtm/45w==
From: Christian Brauner <brauner@kernel.org>
To: linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-block@vger.kernel.org,
	linux-ide@vger.kernel.org,
	linux-scsi@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	bpf@vger.kernel.org
Cc: lsf-pc@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org
Subject: LSF/MM/BPF: 2026: Call for Proposals
Date: Sat, 10 Jan 2026 14:24:17 +0100
Message-ID: <20260110-lsfmm-2026-cfp-ae970765d60e@brauner>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3604; i=brauner@kernel.org; h=from:subject:message-id; bh=XA4YqUHgVUeiBE4BwIy5hjNCCWAzL6nLNBDSXX3oIa4=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQmBTNfW5TyusdikYe/c1Vxhbhzj9Yb+TkB+0RNHjjt4 fm3coN6RykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwEQEmxgZzpoGuQadvLVQvthV 6leEY91rxzlTngl7mvFk9XC9OZz4iJHh/sXdHe69W85W2X1VetGk33XRcSeThHbBCvFFKWFM3Yu 5AQ==
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260110_052458_039114_95625796 
X-CRM114-Status: GOOD (  11.06  )
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

The annual Linux Storage, Filesystem, Memory Management, and BPF
(LSF/MM/BPF) Summit for 2026 will be held May 4–6, 2026 in Zagreb,
Croatia.

LSF/MM/BPF is an invitation-only technical workshop to map out
improvements to the Linux storage, filesystem, BPF, and memory
management subsystems that will make their way into the mainline
kernel within the coming years.

LSF/MM/BPF 2026 will be a three-day, stand-alone conference with four
subsystem-specific tracks, cross-track discussions, as well as BoF and
hacking sessions. Please check out:

          https://events.linuxfoundation.org/lsfmmbpf/

for further details on the venue and hotels.

This is a call for proposals for technical topics for this year's event.

We are asking that you please let us know you want to be invited by
February 20, 2026. We realize that travel is an ever-changing target,
but it helps us to get an idea of possible attendance numbers.

(1) Fill out the following Google form to request attendance and
    suggest any topics for discussion:

          https://forms.gle/hUgiEksr8CA1migCA

    If advance notice is required for visa applications, please point
    that out in your proposal or request to attend, and submit the topic
    as soon as possible.

(2) Please send topics to

          lsf-pc@lists.linux-foundation.org

    and to the relevant technical audience:

          FS:     linux-fsdevel@vger.kernel.org
          MM:     linux-mm@kvack.org
          Block:  linux-block@vger.kernel.org
          ATA:    linux-ide@vger.kernel.org
          SCSI:   linux-scsi@vger.kernel.org
          NVMe:   linux-nvme@lists.infradead.org
          BPF:    bpf@vger.kernel.org

(3) Please tag your proposal with [LSF/MM/BPF TOPIC] and ensure that
    each topic is a separate thread.

(4) The Google form has an area for people to add required/optional
    attendees. Please encourage new members of the community to submit a
    request for an invite as well. Maintainers or long-term community
    members can add nominees to the form to help make sure that new
    members get the proper consideration.

(5) For discussion leaders, slides and visualizations are encouraged to
    outline the subject matter and focus the discussions. Please refrain
    from lengthy presentations and talks in order for sessions to be
    productive; the sessions are supposed to be interactive, inclusive
    discussions.

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

The program committee for this year consists of:

          Javier González    (Storage)
          Martin K. Petersen (Storage)
          Christian Brauner  (Filesystems)
          Amir Goldstein     (Filesystems)
          Jan Kara           (Filesystems)
          Vlastimil Babka    (MM)
          Matthew Wilcox     (MM)
          Daniel Borkmann    (BPF)
          Martin KaFai Lau   (BPF)

Thank you,
Christian Brauner

