Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F51BCD11C2
	for <linux-nvme@archiver.kernel.org>; Wed, 10 Apr 2024 09:51:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=ZNYlPU0KEhhjLcw4tt9CwnLkMxWce9aYNIunypk069o=; b=L2clZig+3icI1RBkWgkwUwzn58
	HR8mCRfRT7k3p018UbqpWTa1rrLpXb0agJBpIFGkpCrIE19fPi5KVLv1/4rV8doVah9lRdWwsN57Z
	JaQtJxQ7pobRnHZpA81wu5e4uP4mhDTiKIuFDR5Q/3Fg4r70i/4G+nUE0l3K65zrBrxHblTEAOKGK
	/YIa2oBxZcBrg3ohiQjV9jEkW4ZZeUsSNrUpWxsgefCKEaNi5i9uC900C9kWcX+83z/8zCVsHbjRc
	pXN51vKdEEfAGauhktAsWL1EnMn60ELAjdhQj0iI7fd/VGFXFgbOCdxyZuoM9wjMLyoFe3myNwu/Z
	0bNsKUXw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ruUbi-00000006EMj-2PAU;
	Wed, 10 Apr 2024 09:51:06 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ruUbf-00000006EKg-29xk
	for linux-nvme@lists.infradead.org;
	Wed, 10 Apr 2024 09:51:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712742661;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ZNYlPU0KEhhjLcw4tt9CwnLkMxWce9aYNIunypk069o=;
	b=G5l53alYfoeCYU0DxKY6x3v2ZT0kRwK+t12SSv9yWT6ZsJbEz1ZzeK/x4+JZ+N6OLtTzLk
	vgXl/7Wpu9yPrZ9MklGCroRNZnYxJC2v6Kp4ktTnyPZH5Jj5pkJNnhXgoegbiYZNKx3Qi9
	aHDUxjxNc8uFd8X/hI8YhSi5bBsMAMA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-610-EclIGeDqP8KORlfAGY5kaQ-1; Wed, 10 Apr 2024 05:48:50 -0400
X-MC-Unique: EclIGeDqP8KORlfAGY5kaQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 89547806626;
	Wed, 10 Apr 2024 09:48:49 +0000 (UTC)
Received: from kalibr.redhat.com (unknown [10.47.238.181])
	by smtp.corp.redhat.com (Postfix) with ESMTP id E2E63492BC6;
	Wed, 10 Apr 2024 09:48:47 +0000 (UTC)
From: Maurizio Lombardi <mlombard@redhat.com>
To: kbusch@kernel.org
Cc: sagi@grimberg.me,
	hare@suse.de,
	dwagner@suse.de,
	linux-nvme@lists.infradead.org
Subject: [PATCH 0/2] nvmet-auth: fix some minor bugs
Date: Wed, 10 Apr 2024 11:48:40 +0200
Message-Id: <20240410094842.370170-1-mlombard@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240410_025103_895941_4EDB71F6 
X-CRM114-Status: UNSURE (   7.84  )
X-CRM114-Notice: Please train this message.
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

First patch modifies nvmet_auth_host_hash() so it correctly returns
the error code to its caller.

The second patch replaces a pr_debug() with pr_err().

Maurizio Lombardi (2):
  nvmet-auth: return the error code to the nvmet_auth_host_hash()
    callers
  nvmet-auth: replace pr_debug() with pr_err() to report an error.

 drivers/nvme/target/auth.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

-- 
2.39.3


