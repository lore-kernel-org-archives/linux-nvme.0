Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64A5DCD5BB5
	for <linux-nvme@archiver.kernel.org>; Thu, 21 May 2026 14:47:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Message-Id:Date:Subject:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=fH2SpemoXvJlgvEPFyN/jTDszhD95Yl9eAEB5XMDBJ4=; b=JasgBt1dUCn9XC
	iecQJkqACu7NPZYV3OIny42UgYBkaDrXeywXaYBXKeQyxUiL6QjawfYwLocJXYr2fAhW4i59ShNJt
	u0PuVktthKHXa8Et2HMQ7l5ugH8OXawj6cPVUagSf3zfIPHvr2YKjIrGX0oIDDRElvphhuyTi5yG1
	vN0pT9Cp+HTwOhBBUmv9gFP9N/DDqlRQiLfjM2ufzaiP8eOjQlBOjijjQXMhO/jxzmiRJwrBEti3a
	0HvwvMQDd7wFLUUwBUESIZsgKfYxIHA5rYSIUZWiVjjuO86GtMEEvBDLgeoEd1w1SPISBuj2Cc1ND
	3ZBwVECtcevFJNb/LkxA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wQ4gH-0000000881p-0zrG;
	Thu, 21 May 2026 14:47:25 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wQ4gD-0000000880c-3GWz
	for linux-nvme@lists.infradead.org;
	Thu, 21 May 2026 14:47:23 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 3258740F5A;
	Thu, 21 May 2026 14:47:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 281331F000E9;
	Thu, 21 May 2026 14:47:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779374841;
	bh=fH2SpemoXvJlgvEPFyN/jTDszhD95Yl9eAEB5XMDBJ4=;
	h=From:Subject:Date:To:Cc;
	b=bZRSHdU9XRb/JgMsQmWUMaMjTs9VSzOwvmHXd3oJl4taX46TJjZIY+A+8RanP30Dn
	 zTxg4Nicy+w4b37HUp7rS6iC0BMul3GGKbI1ust2WrerX36VY9fMIN9TRZYmz2AraJ
	 d7coIwOjRzqjmvDaJxSeh62yNm6UNdm87oEmjf1N8Aq+qTvs3kaJ3nY/dVFmjUpNAP
	 2tPgMPonRHmLhabGmKXePDmeoip1OhViwmSlbYNJ2x/qEhqGBUnyR4EZAVC+jNeo32
	 aZ0CQQjHudxJ2U2XIZbIbfjZq0Sq9GMlNKNu9gkdj2Pko2qm7qp+lRXp1zY4O7oy3y
	 xBbR2ZevVekqA==
From: Chuck Lever <cel@kernel.org>
Subject: [PATCH net v2 0/7] net/handshake: anchor request lifetime to a
 pinned file reference
Date: Thu, 21 May 2026 10:47:06 -0400
Message-Id: <20260521-handshake-file-pin-v2-0-b9dadc472840@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/22Oyw6CMBBFf4XM2iotgo+V/2FYtGVqR6ElLRIN4
 d8t6NLlvXPn5EwQMRBGOGcTBBwpkncpiE0G2kp3Q0ZNyiByUeUlr1gqm2jlA5mhFllPjglenHJ
 TmqLkBaTHPqCh1wq9gsMB6m8Zn+qOelhwy0zJiEwF6bRdqjTcdZLccrIUBx/eq9XIV85P4PhPY
 OQsZ3ultDpgJUwjLz5I3eJW+w7qeZ4/nQ1CQOcAAAA=
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3768;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=4tDM0iQVz/CyzfICFtw2BvtzDMiZSvmMCgLfoFd3Qho=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBqDxru74wmZ1hPJSsB7z0UzzxM4pcWKdGRouxfQ
 4xf3xqQ0HKJAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCag8a7gAKCRAzarMzb2Z/
 l5lrD/94B2E3+YLi84PAnO3Xy5EKOgN9uVEQS0np047cRFcMV/DHPjZCJl9BAnF/+0RqgFZVauD
 qa18arIp3nLIl350HhbzUmE9NfZgFHpDhueJGzHAJkrd8an+QmOMR6dzDN4G+C6wQ/PNzGoBZf4
 UbeBtJ2GPNpWLFNx7b9VuaELAdL3RtrcwHQxA0Nevpey4Pj2jeRFHf/fim7VuJi8nMBBoAJPsJs
 7L+gKp11eXXfiGycfNWFqF58NFnOdtlIymOEw9amBbF7LeCU6ECk+FCv1xVKxHvwf57/QTzT3dT
 u7XFgA1fMg2DzT5SALAfTw43ezo78pX0XDi3PEiGC1/T9kjE/26etr6TtB8RN0aVPcCggz3zyik
 8y3eOxCoFQG2yKuF2rmA/xhhJ+eFQ2nW4nPW/DNcgnG9mAYis8uQ3mXIY+Ae1rpFUNDz9+PIP7z
 0n/0Q5ZKUUaWxo4wZa5hdPfnlOkoJ//Qt0AzoYM2gKFulugzup6MtOLRTufMC40YoI35oJKc0Nw
 d9TD7Seapz3tXk9BKSZvS7Zcu8etLqKjT9tymxnz1WH90xh8ZLOQIy9gENAvZUycoHo99BpG9Eq
 pPbTyalIPsrkueJbyIB5ZgLnqP5b8p6/Ut5vk9WBqV8mzcy85GIKAFS6huGjgvP9jmCjQ0slUyc
 QqfRe0GIC32GvBQ==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260521_074721_867418_F8066550 
X-CRM114-Status: GOOD (  12.41  )
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
matching sign correction in nvme-tcp (patch 2).  An unrelated
netns-exit leak gets its own fix (patch 1), and new KUnit
file-count assertions verify the refcount contract (patch 7).

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
Changes in v2:
- Patch 3: move HANDSHAKE_A_DONE_STATUS upper bound into netlink policy (Jakub)
- Link to v1: https://patch.msgid.link/20260518-handshake-file-pin-v1-0-4bbcb7e62fda@oracle.com

---
Chuck Lever (7):
      net/handshake: Drain pending requests at net namespace exit
      nvme-tcp: store negative errno in queue->tls_err
      net/handshake: Pass negative errno through handshake_complete()
      net/handshake: Take a long-lived file reference at submit
      net/handshake: hand off the pinned file reference to accept_doit
      net/handshake: Close the submit-side sock_hold race
      net/handshake: Verify file-reference balance in submit paths

 Documentation/netlink/specs/handshake.yaml |  8 +++++
 drivers/nvme/host/tcp.c                    |  2 +-
 net/handshake/genl.c                       |  3 +-
 net/handshake/genl.h                       |  1 +
 net/handshake/handshake-test.c             | 38 ++++++++++++++++++++++-
 net/handshake/handshake.h                  |  6 ++--
 net/handshake/netlink.c                    | 19 +++---------
 net/handshake/request.c                    | 50 ++++++++++++++++++++++++------
 net/handshake/tlshd.c                      |  4 +--
 9 files changed, 101 insertions(+), 30 deletions(-)
---
base-commit: 42734af6632ebebf90552f0e2dce4d8e72dbb9be
change-id: 20260516-handshake-file-pin-21390f5f3513

Best regards,
--  
Chuck Lever <chuck.lever@oracle.com>


