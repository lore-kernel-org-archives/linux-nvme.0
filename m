Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE757606A326
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Nov 2026 21:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=jsbu+4am;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=B3k5bbEA
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=48wS641dZNlMgTbgKHYJJRZjCIIpBYSCk6vN7nPVst0=; b=jsbu+4am5SQGAv
	utuD5g8BwReoRvyJiiDnn/pRQutPMTxT+hqG6ooP7km+44ykC/9IB//IefgxZMFxtKxuYJ6J4drzn
	TtpsM0t4VRftQI6PD2yIAblmrDz2QLp96+BNEw7KPkpU01bL0mO4tamBZ+twCU5SOtYEhIeeY32zD
	AAJ+jUrnc1F8Yblg5mXsuv008bzWJ0ZoDVKexxqsy2CY8YKDWfDHNERIRUXBYZlbot7ixTsXGGPT7
	dEPpDm8oz3vJIUaIRu0zDnHk07byFEtFF320tM6gQGAO75vm/3TEJUhR9k5SEeIHb+UyEKljaF+OW
	MfgPOK9GZQui8+ZtS9nw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRFgm-00000007ilY-1iHO;
	Wed, 11 Nov 2026 21:17:04 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQhxb-00000003E0L-3Kba
	for linux-nvme@lists.infradead.org;
	Tue, 10 Nov 2026 09:16:11 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 8CB1744729;
	Tue, 10 Nov 2026 09:16:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF7381F0089F;
	Tue, 10 Nov 2026 09:16:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794302171;
	bh=48wS641dZNlMgTbgKHYJJRZjCIIpBYSCk6vN7nPVst0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=B3k5bbEAWfpJtZp1vzeXux0KzrY0ieZxwUJi/83P+f7eKHCKBYc9mkYVfNK2b/51Z
	 IE7odp0lQqQ7mwusK6pgB1WlHVkO/UlsckyLpTfE8Yp89sMOk+QjYT1he8sjTHJobl
	 zbSxv5PQZ8XY+Ts/6iaugpn66hCj3rJCosVRpDg0+EuqU7+TpcsCN1TcwITx1L6QCL
	 1C6NNljvCVnJ+dNekIZ/1LCG3UXVW6y81kv+eHD0umTjqyrBp3lV94BaeU5UIyHZKc
	 zDKybfsspnrP1qhiqd+dsnxznVfYXFvZSeoRYSBElTyxocH2QJC3b5d8zXbtpIhziF
	 ygU0pzxGVue5w==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 10 Nov 2026 10:14:18 +0100
Subject: [PATCH RFC 02/41] nvmet: check that the file backend supports
 ->{read,write}_iter
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261110-work-loop-pseudo-v1-2-4c998976c6c7@kernel.org>
References: <20261110-work-loop-pseudo-v1-0-4c998976c6c7@kernel.org>
In-Reply-To: <20261110-work-loop-pseudo-v1-0-4c998976c6c7@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Jann Horn <jannh@google.com>, Chris Mason <mason@kernel.org>, 
 Josef Bacik <josef@toxicpanda.com>, Christoph Hellwig <hch@lst.de>, 
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-nvme@lists.infradead.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Jan Kara <jack@suse.cz>, linux-scsi@vger.kernel.org, 
 target-devel@vger.kernel.org, driver-core@lists.linux.dev, 
 linux-mm@kvack.org, bpf@vger.kernel.org, 
 linux-security-module@vger.kernel.org, selinux@vger.kernel.org, 
 apparmor@lists.ubuntu.com, linux-nfs@vger.kernel.org, 
 netdev@vger.kernel.org, fuse-devel@lists.linux.dev, 
 linux-efi@vger.kernel.org, xen-devel@lists.xenproject.org, 
 ocfs2-devel@lists.linux.dev, linux-s390@vger.kernel.org, 
 linuxppc-dev@lists.ozlabs.org, linux-usb@vger.kernel.org, 
 Amir Goldstein <amir73il@gmail.com>, linux-erofs@lists.ozlabs.org, 
 linux-kselftest@vger.kernel.org, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.17-dev-ce4c1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1206; i=brauner@kernel.org;
 h=from:subject:message-id; bh=9rTO3vQgbbKMLgtf9DhInii/7oHGTrugRkWUh4dwMMs=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWR9ejBtltmGmxnek3mf9QvZzp8xjWWx5Y+Awzls7lyHP
 /4+2Dk3oqOUhUGMi0FWTJHFod0kXG45T8Vmo0wNmDmsTCBDGLg4BWAivzwZGU4478oq2RB1Nuut
 48Jj7Tu4n8+545UyJdpwumO4VdS2g7kM/9TW5p9ep3/AsD+mInRXw3I+rR/SC0xnPXVmN7wifGZ
 vBB8A
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
X-Mailman-Approved-At: Wed, 11 Nov 2026 13:17:02 -0800
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
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The file backend calls ->read_iter() and ->write_iter() of the backing
file directly but never checks that they exist. Everything that isn't a
block device ends up in the file backend. So a namespace pointing to a
file without them calls a NULL pointer on its first I/O. Only
buffered_io=1 gets that far as the O_DIRECT open fails for such files.

Refuse them when the namespace is enabled the same way zloop does since
commit 0c10f8a1a7ae ("zloop: check that the zone backing file support
->{read,write}_iter").

Fixes: d5eff33ee6f8 ("nvmet: add simple file backed ns support")
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 drivers/nvme/target/io-cmd-file.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/nvme/target/io-cmd-file.c b/drivers/nvme/target/io-cmd-file.c
index 695963dd932e..dfa8aa46188c 100644
--- a/drivers/nvme/target/io-cmd-file.c
+++ b/drivers/nvme/target/io-cmd-file.c
@@ -47,6 +47,11 @@ int nvmet_file_ns_enable(struct nvmet_ns *ns)
 		return ret;
 	}
 
+	if (!ns->file->f_op->read_iter || !ns->file->f_op->write_iter) {
+		ret = -EINVAL;
+		goto err;
+	}
+
 	nvmet_file_ns_revalidate(ns);
 
 	/*

-- 
2.53.0


