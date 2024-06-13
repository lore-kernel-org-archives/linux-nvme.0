Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C799BC27C4F
	for <linux-nvme@archiver.kernel.org>; Thu, 13 Jun 2024 16:10:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jhjoBEixCdgzxQ3iF+r/n1LVF+noWpyI7rGB9WCArWs=; b=r58FR009w/3Rj1pRhjdPScUUyI
	ztFBkIdorxKVj04P8hotQw31JUl8W3xsORIjY6yJOpF2tmR62YW3IvryjnBvh5pja2jh4Zt2Vlo3L
	jjAVJvzqYxyY3g637ZGsf+cTe1Qxf8QMLluNPUlijioubq27mGFxGjg0onTHvnBOI2HCyiJPYpQiw
	YfXIfArTScQseJN+S3aIAkEUEEZNXG40bRkUCXOMfQIDRcCJ+JbbK5fUYhCM/vd5Qp8Cwypf1sUPR
	3YkaT8sPZA/ODNBGbTMf1UV5p2hf1EQUvY34yXncy3kWWjxnfncF+l6EEGoB3WQJP60q+AXbUuq9k
	N6Gj7mUA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sHn2D-0000000HIul-2dpT;
	Thu, 13 Jun 2024 16:10:45 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sHn2B-0000000HItv-0p9c
	for linux-nvme@lists.infradead.org;
	Thu, 13 Jun 2024 16:10:44 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id ECF5B61B8C;
	Thu, 13 Jun 2024 16:10:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E47BBC2BBFC;
	Thu, 13 Jun 2024 16:10:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718295041;
	bh=hg3ZFX1ZdZkhCBl0cycfGdCXZQ4o5gfmME3tRBWguwM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BGawiitrSTl4D4rivmIxK2Oi0t9rHJYvZejrrvqg/cKKXIBd3EO7svZMgXA2PUpzl
	 UP/u0Z0iqXD/ywWs2CrkUjY7ovZAvm0ZJpzDd5aX5Oms9EaHiZLletbxjOsA+4lYbr
	 fwz5YexiuheI88zZR9yQwv0SBnNQipiVQmNTypdNkyt2eVPqRKku+QfV28PKZSAg3m
	 x7MByJYAMGn7iezYywecmd+wUyjXeIbkHtv0YJ/vgYtFPzW2ILqzh4naVVwp2wB/5a
	 Id7suEadAY11JqGsf6bfPQDdlIS53V0a+Esj+8wHpIFZewp/q+0I5/Vlnd+3iH5prr
	 0TJnH/oMecg/g==
Date: Thu, 13 Jun 2024 10:10:38 -0600
From: Keith Busch <kbusch@kernel.org>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Nilay Shroff <nilay@linux.ibm.com>, Keith Busch <kbusch@meta.com>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, hch@lst.de, sagi@grimberg.me,
	davidgow@google.com, akpm@linux-foundation.org,
	venkat88@linux.vnet.ibm.com
Subject: Re: [PATCH 1/2] list: introduce a new cutting helper
Message-ID: <ZmsZ_lKgOlB6Wypy@kbusch-mbp.dhcp.thefacebook.com>
References: <20240612155135.3060667-1-kbusch@meta.com>
 <f0e4c51c-8227-4f5c-876f-38fbb4a0e1bf@linux.ibm.com>
 <ZmrscxG51gFRDVlM@kbusch-mbp>
 <c475f0d8-3bc9-4d65-8fce-586f4b75b4fc@linux.ibm.com>
 <ZmsD_HDLBQAqOOU3@kbusch-mbp.dhcp.thefacebook.com>
 <31eb40f9-d68d-4348-b1fd-3cf057939297@paulmck-laptop>
 <ZmsGfle1aZQauzRb@kbusch-mbp.dhcp.thefacebook.com>
 <73b994eb-c689-48e0-b09c-a414041a0525@paulmck-laptop>
 <ZmsS9DZWl8TccvKz@kbusch-mbp.dhcp.thefacebook.com>
 <046f42c5-34b5-41a2-9680-5ef86ef25c01@paulmck-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <046f42c5-34b5-41a2-9680-5ef86ef25c01@paulmck-laptop>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240613_091043_374414_292304DA 
X-CRM114-Status: GOOD (  12.43  )
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

On Thu, Jun 13, 2024 at 09:01:47AM -0700, Paul E. McKenney wrote:
> 
> Is there a way to avoid this issue by making this be a statement parameter
> to a macro?

Something like this? It appears to work for the intended use, at least.

---
diff --git a/include/linux/rculist.h b/include/linux/rculist.h
index 3dc1e58865f77..cdd2e5c0d5cdb 100644
--- a/include/linux/rculist.h
+++ b/include/linux/rculist.h
@@ -204,6 +204,30 @@ static inline void list_replace_rcu(struct list_head *old,
 	old->prev = LIST_POISON2;
 }
 
+
+static inline void __list_cut_start(struct list_head *list,
+				    struct list_head *head,
+				    struct list_head *entry)
+{
+	list->next = entry;
+	list->prev = head->prev;
+	__list_del(entry->prev, head);
+}
+
+static inline void __list_cut_end(struct list_head *list,
+				  struct list_head *entry)
+{
+	entry->prev = list;
+	list->prev->next = list;
+}
+
+#define list_cut_rcu(list, head, entry, sync)		\
+	do {						\
+		__list_cut_start(list, head, entry);	\
+		sync;					\
+		__list_cut_end(list, entry); 		\
+	} while (0)
+
 /**
  * __list_splice_init_rcu - join an RCU-protected list into an existing list.
  * @list:	the RCU-protected list to splice
--

