Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1F64CD5BB1
	for <linux-nvme@archiver.kernel.org>; Mon, 25 May 2026 16:51:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Message-Id:Date:Subject:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=FbcGJkRkbagmQAlyIHUAsEmLq39wb78AB89XfL80OeI=; b=TKJMzZR0L6eBFY
	mfOsAEZSv0xyFEUUjm48DKag0uxrNsTiLxCpw7FdqYiC/KZpt4gjlAA9lOJq20QIfHANGIGoefbyD
	gt22AXbrM5z4I90EwKZvWZWPgfU2FjFz1b06mrPiqXNbgYAnLeBmSRqPDJeyIyEUtD/hEJvZTz1lE
	ynK4N76Y/LQ1By5Pq+P9sc15Jo5UtKNl0lsmofcRtcjP4bJwWKzsZ86PI3UHOSqTv11UTQ1UeKPB8
	AhKk1hIhl9uwzPU6T6T7hmPpYk9oCvyP9RM34sS0mQSFOmC8SKGrUTJnrlmiT43tKLJkSbWczTqSA
	z/73cV1SmARDlujrwlrQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wRYWb-0000000046M-30Gn;
	Mon, 25 May 2026 16:51:34 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wRYWa-0000000045v-38rZ
	for linux-nvme@lists.infradead.org;
	Mon, 25 May 2026 16:51:32 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id E01AE600AB;
	Mon, 25 May 2026 16:51:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8E641F000E9;
	Mon, 25 May 2026 16:51:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779727891;
	bh=FbcGJkRkbagmQAlyIHUAsEmLq39wb78AB89XfL80OeI=;
	h=From:Subject:Date:To:Cc;
	b=CS9iD+vqjHrmh4orujpwww76w5tDcVoPNm/1HQCyDFBw+doetdYK4Lsd/SEu9XNQm
	 9c2EpKY8x/I23kaLV2nUxUeTmKRsJPE+hw/Dlpi0qjGhM2HXCi+txr7IjMYPreRr9p
	 +5DwH+0u/wURjeeoQ5JicHyopYPPSgcuWyOAiU5PAYO/teWHoPrgUTtDyK3POr8B7k
	 KhUPhwLMsN/aNQfXSSm/XRI1FgOsK8il1GMqXBk/8wXGhH/gl1Iui33zMTgs6zT+2c
	 BlJ9IZfSpGklXRaIq1nSJjtjE7JHdCD6wteJlOznhhf7eBEoCD9OUyNXDcP/81PKav
	 WtLVCCtmKAL9g==
From: Chuck Lever <cel@kernel.org>
Subject: [PATCH net v3 0/8] net/handshake: anchor request lifetime to a
 pinned file reference
Date: Mon, 25 May 2026 12:51:14 -0400
Message-Id: <20260525-handshake-file-pin-v3-0-66c616906ead@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/22OzQ7CIBCEX6XhLAr0V0++h/HAz2JXKxiojcb03
 aXVgyY9zuzMt/MiEQJCJLvsRQIMGNG7JPJVRnQr3QkomqSJYKJiJa9oMk1s5QWoxQ7oDR0VPN8
 yW9q85DlJxVsAi48ZeiAOenL8mPGuzqD7CTfFlIxAVZBOt5OVgpurRDedWoy9D8951cBnzndAs
 zRg4JTRQimtaqiENXLvg9QdrLW/zs8H8cMQfJEhEkNtjTS6qEVTsD/GOI5v3Gw1aisBAAA=
X-Change-ID: 20260516-handshake-file-pin-21390f5f3513
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: Chris Mason <clm@meta.com>, Christian Brauner <brauner@kernel.org>, 
 kernel-tls-handshake@lists.linux.dev, linux-nvme@lists.infradead.org, 
 netdev@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>, 
 Hannes Reinecke <hare@kernel.org>, 
 Alistair Francis <alistair.francis@wdc.com>
X-Mailer: b4 0.16-dev-da966
X-Developer-Signature: v=1; a=openpgp-sha256; l=4296;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=GvTDjam6ruQwEDM6OVKE0WQabQyhk+Y0lXRkOjTpfEw=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBqFH4K+n3aOBrQb+kVVmywjVPaGmJfJ+56t9uqq
 qExmpm9UeuJAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCahR+CgAKCRAzarMzb2Z/
 l/Y4EACKXt9PB65+GRACXl/7hBSiKwiKZXsV2dktTDJpjJKWaHVLTXFr7ufpXPGoWmJxtacyWdN
 yOraX3Z3C6yfOrQohiCtWarUuHu4Hi38aELwbCZrvZDOzWnEKg5j09SxE8yCSvM4s/v9plLhOb8
 mNxWFxbH7vnK39AtcCvsO+kdMLMkNSDw7z+ZWjtJZFDKN/08ifvnMceCiIfHoKmMDy8gbig7zmr
 pvx6XPqOsKFni5XR8HJ03yh71qGZEHk6j8YAazXpg0eHrfWRYiH6vNeAnXGSnSswQPJhd7lMhtb
 zpNDOulgi6TWTRfaVL9T2Wo1O2tDAQN9gF4MhVUHfjQfy+GvR/NPc/vStFmbjXq2x3vjzuOCM1m
 g02loLQ8BF0dfgXqM502ClX3wn/IhcEbZ22dX+tdmNuBGmSezB5HePqN2qIRWdrNEMOlObLqWMS
 LryOSk+QtRVulXVTxghUqBVaCwrr2q5A6DRCa0Jp4HeZw78mtgpr4grgYavkyXq8zIAut1cPjSP
 jSLq/+gEVNmN5v/Wa1uK1teIllL3TzUS1fp5QUfs8Wp743RGW7AlpK3CJ4C7ivcMe0Lcr84qWAY
 BK8UnI7vgXk3nZGM30WBqFepjLyIopGZ6gfGzi8ssi609J7SzeSf7wMyW4hv0gRVocYsgjD9u+m
 Z+mS3L5KGbraKPA==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
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

handshake_nl_accept_doit() has accumulated four follow-on fixes
since 3b3009ea8abb ("net/handshake: Create a NETLINK service for
handling handshake requests"): 7ea9c1ec66bc, 7798b59409c3,
fe67b063f687, and dabac51b8102.  Each was a local refcount or
NULL-check correction; none moved where the file reference is
owned, and the same code keeps producing the same class of bug.
Reworking the ownership is what breaks the pattern.

For the duration of a request, sock->file has no single owner.
Submit publishes the request without taking a file reference;
accept_doit acquires one inside the handler, after the request
has already left the pending list.  The consumer can drop its
own reference at any time, including the moment between
handshake_req_next() popping the request and accept_doit
reaching get_file().  The submit-side sock_hold() pins only
struct sock; struct socket and sock->file remain under the
consumer's control via the file descriptor.

This series places the file reference under unambiguous
ownership.  handshake_req_submit() pins it on the request and
completion or cancel drops it (patches 4-5); the submit-side
sock_hold() then becomes redundant, and dropping it also closes
a publish-before-pin race the late sock_hold itself opened
(patch 6).  The handshake_complete() API and its consumers move
to a uniform negative-errno sign convention (patch 3), with the
matching sign correction in nvme-tcp (patch 2).  Patch 1
hardens hn_lock for BH context, the netns-exit drain fix
builds on the new file-pin infrastructure (patch 8), and new
KUnit file-count assertions verify the refcount contract
(patch 7).

Three things in this restructuring want a careful look.  In
handshake_complete(), the fput() of the request's file
reference has to come after hp_done() -- fput() can transitively
run handshake_sk_destruct() and free the request, so the patch
stashes hr_file in a local first.  handshake_sk_destruct()
itself is kept on purpose: it owns rhashtable removal and
kfree, and remains the backstop if a consumer path bypasses
handshake_complete() entirely.  Third, handshake_req_next() now
returns its request with an extra get_file() held under
hn_lock; accept_doit must consume that reference (FD_PREPARE on
success, explicit fput on the fdf.err path), and any future
caller has to honor the same contract.

---
Changes in v3:
- Gate submit error path fput with test_and_set_bit to prevent double fput from concurrent cancel
- Convert hn->hn_lock to spin_lock_bh (cancel reachable from softirq via nvmet-tcp)
- Pin file references during netns drain to prevent use-after-free on local list
- Series re-ordered to improve bisectability
- Link to v2: https://patch.msgid.link/20260521-handshake-file-pin-v2-0-b9dadc472840@oracle.com

Changes in v2:
- Patch 3: move HANDSHAKE_A_DONE_STATUS upper bound into netlink policy (Jakub)
- Link to v1: https://patch.msgid.link/20260518-handshake-file-pin-v1-0-4bbcb7e62fda@oracle.com

---
Chuck Lever (8):
      net/handshake: Use spin_lock_bh for hn_lock
      nvme-tcp: store negative errno in queue->tls_err
      net/handshake: Pass negative errno through handshake_complete()
      net/handshake: Take a long-lived file reference at submit
      net/handshake: hand off the pinned file reference to accept_doit
      net/handshake: Close the submit-side sock_hold race
      net/handshake: Verify file-reference balance in submit paths
      net/handshake: Drain pending requests at net namespace exit

 Documentation/netlink/specs/handshake.yaml |  8 +++
 drivers/nvme/host/tcp.c                    |  2 +-
 net/handshake/genl.c                       |  3 +-
 net/handshake/genl.h                       |  1 +
 net/handshake/handshake-test.c             | 38 +++++++++++++-
 net/handshake/handshake.h                  |  6 ++-
 net/handshake/netlink.c                    | 29 +++++------
 net/handshake/request.c                    | 81 ++++++++++++++++++++++--------
 net/handshake/tlshd.c                      |  6 ++-
 9 files changed, 129 insertions(+), 45 deletions(-)
---
base-commit: 87a1e0fe7776da7ab411be332b4be58ac8840d10
change-id: 20260516-handshake-file-pin-21390f5f3513

Best regards,
--  
Chuck Lever <chuck.lever@oracle.com>


