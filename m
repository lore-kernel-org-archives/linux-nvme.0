Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EF1BC433EF
	for <linux-nvme@archiver.kernel.org>; Mon, 21 Mar 2022 22:44:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:Date
	:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=f/WibOBWz2igIwP8FygRiQUZT28aGjtXkg9rQnX0gqU=; b=qvLLXjZOry/QXHD+kZ2KrhFMVG
	SOYbyzRX8IkkCXQAd11jRGtZgd+x5wXjPzNu/7Zk+eDsG4TWjjUq+qLyM3PglU/8Ylv26J35OOeh7
	3VCZ6hWbAsFt8dS6/ANUmLuxqlKGpByzRmW/BVyKUgE9jjqazp1OtRpar3EVH8SWMtgioVs+GLP/2
	25ktNTAiOUi0K3zjM8e8jKsyYJxXk7pATSyu5Bbnx+kDR6VuJz+bNMjSeugazZiql77a3kHi/0Hhi
	VPR6JyeI4/eSx0TIiVs6Ulfq/Z4v3K6tCWpca8Q7SY6q+VEqOqn3ax/LAO/PcYzIDKzZ129MqBbVo
	A+W7Wapg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nWQky-009HjE-Bi; Mon, 21 Mar 2022 22:44:08 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nWQko-009HgI-Ha
 for linux-nvme@lists.infradead.org; Mon, 21 Mar 2022 22:44:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1647902637;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=f/WibOBWz2igIwP8FygRiQUZT28aGjtXkg9rQnX0gqU=;
 b=SaSs+BfqR9hdnFlDmI3u0pp7kKjrFyGAer7y5udUT6mOlaAQMqrZwE+LFSixvY4nio4cTL
 KHsis1P/Yl3OlX9gWJZ2YGof/oCh8tKu7fy5AccAY3xAWmPuJznLXBbFEwJn8li2zCN6Pc
 UctaAKzjINWmAQmLWa0Cd9cAz11p/NU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-75-EeoUBjPIOjiif_fc0czPjw-1; Mon, 21 Mar 2022 18:43:54 -0400
X-MC-Unique: EeoUBjPIOjiif_fc0czPjw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B2FC8185A79C;
 Mon, 21 Mar 2022 22:43:53 +0000 (UTC)
Received: from localhost.redhat.com (unknown [10.2.17.73])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D4C26141DC5D;
 Mon, 21 Mar 2022 22:43:52 +0000 (UTC)
From: Chris Leech <cleech@redhat.com>
To: linux-nvme@lists.infradead.org,
	sagi@grimberg.me,
	hch@lst.de
Cc: lengchao@huawei.com, dwagner@suse.de, hare@suse.de, mlombard@redhat.com,
 jmeneghi@redhat.com
Subject: [RFC PATCH] nvme-multipath: break endless loop in
 nvme_round_robin_path
Date: Mon, 21 Mar 2022 15:43:03 -0700
Message-Id: <20220321224304.955072-3-cleech@redhat.com>
In-Reply-To: <20220321224304.955072-1-cleech@redhat.com>
References: <20220321224304.955072-1-cleech@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.7
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=cleech@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220321_154358_691323_E50CB83B 
X-CRM114-Status: GOOD (  15.45  )
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

This is a backstop for the odd loop construct in nvme_round_robin_path.
It counts how many times the head pointer has been passed, as that's the
only thing guarenteed to stay on the list.  Once is needed to start from
a different place and check the entire list, twice is excessive looping.
---
 drivers/nvme/host/multipath.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index ff775235534c..c2039746ca15 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -261,12 +261,13 @@ static struct nvme_ns *__nvme_find_path(struct nvme_ns_head *head, int node)
 }
 
 static struct nvme_ns *nvme_next_ns(struct nvme_ns_head *head,
-		struct nvme_ns *ns)
+		struct nvme_ns *ns, int *head_pass_count)
 {
 	ns = list_next_or_null_rcu(&head->list, &ns->siblings, struct nvme_ns,
 			siblings);
 	if (ns)
 		return ns;
+	*head_pass_count++;
 	return list_first_or_null_rcu(&head->list, struct nvme_ns, siblings);
 }
 
@@ -274,6 +275,7 @@ static struct nvme_ns *nvme_round_robin_path(struct nvme_ns_head *head,
 		int node, struct nvme_ns *old)
 {
 	struct nvme_ns *ns, *found = NULL;
+	int head_pass_count = 0;
 
 	if (list_is_singular(&head->list)) {
 		if (nvme_path_is_disabled(old))
@@ -281,9 +283,12 @@ static struct nvme_ns *nvme_round_robin_path(struct nvme_ns_head *head,
 		return old;
 	}
 
-	for (ns = nvme_next_ns(head, old);
+	for (ns = nvme_next_ns(head, old, &head_pass_count);
 	     ns && ns != old;
-	     ns = nvme_next_ns(head, ns)) {
+	     ns = nvme_next_ns(head, ns, &head_pass_count)) {
+		if (head_pass_count > 1)
+			break;
+
 		if (nvme_path_is_disabled(ns))
 			continue;
 
-- 
2.35.1


