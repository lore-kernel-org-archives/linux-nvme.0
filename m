Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E3B8C282D1
	for <linux-nvme@archiver.kernel.org>; Thu,  6 Mar 2025 16:10:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:content-type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=+cfEalFeHj5YpvOARqzqMOax/Qs9RmowjR3UWGObzbs=; b=C6xhsDlay4NYMTSvIyO7FiSyYn
	HqLVVhOgEfkUIi45pH3Fp6kc7QjYvnjdW0D60zvm7Uq4jgJla7YGsXAg3zkMgrdRQ8AJyuzDenVeY
	ICCk5UqswYOPQDEqK43euUlHGg5jeULOlt3NsgR7qBv/cIkA+OUg4XlQ2kkfXWXb4pqzSyCoB6klk
	mCsEwSybXu+4JK2jcxILm7c+CytS5CwLyre/lAJp04DMCa7dg49uxn2gpnKNo9lxZjHNRGzIsCXMC
	tbqawnmkB9/ulBXx1TCt/8KS6OjO61CmCeoQIlD6YkrtBWPRguzkgWtgxwIXcthRPEZaeJ59ntnLl
	SS6JVtVQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tqDng-0000000BQx8-1o61;
	Thu, 06 Mar 2025 16:10:20 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tqDhe-0000000BPm1-0tNI
	for linux-nvme@lists.infradead.org;
	Thu, 06 Mar 2025 16:04:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741277045;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=+cfEalFeHj5YpvOARqzqMOax/Qs9RmowjR3UWGObzbs=;
	b=gq49PFskU92JCZVyCVHUDTFZsdubbqCtTINvI069mO/NsR+3Rl9oDmNSnzdAkhglMBWW/E
	JqLeyVTAGFUluzSdYf3NhPYHKZkRfiQNry269YF9m6fdhMkgzHVsJJ3LXxqHtDPP61/9rr
	P3+2SMgAzsmpuXGTAsgaDOJyyyS0T5M=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-136-r5FlR3L8MgCsZwODH1wlMg-1; Thu,
 06 Mar 2025 11:03:52 -0500
X-MC-Unique: r5FlR3L8MgCsZwODH1wlMg-1
X-Mimecast-MFC-AGG-ID: r5FlR3L8MgCsZwODH1wlMg_1741277031
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D4D3F1828AC8;
	Thu,  6 Mar 2025 16:03:26 +0000 (UTC)
Received: from rocky.redhat.com (unknown [10.44.32.245])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7B5EF1801769;
	Thu,  6 Mar 2025 16:03:24 +0000 (UTC)
From: Maurizio Lombardi <mlombard@redhat.com>
To: sagi@grimberg.me
Cc: hare@suse.com,
	mlombard@bsdbackstore.eu,
	linux-nvme@lists.infradead.org,
	kbusch@meta.com
Subject: [PATCH V3 0/1] Fix an infinite loop in nvme-tcp host driver
Date: Thu,  6 Mar 2025 17:03:21 +0100
Message-ID: <20250306160322.1370300-1-mlombard@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: td3oofitvCli_JHFd9A-H_Tb9wRRMuQAKHxroQYuRNw_1741277031
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250306_080406_324140_55596385 
X-CRM114-Status: UNSURE (   8.46  )
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

I have two points I would like to discuss:

1) Are there any error codes other than -EAGAIN that deserve
   a special treatment like not starting an error recovery?

2) I remember that Hannes proposed an alternative approach to fix this.
   He suggested allowing the controller to transition directly
   from the CONNECTING to the RESETTING state.
   However, I am wary of this solution because it would allow
   the resetting code path to run concurrently with the
   connecting path, potentially introducing new race condition bugs.


Maurizio Lombardi (1):
  nvme-tcp: Prevent infinite loop if socket closes during CONNECTING
    state

 drivers/nvme/host/tcp.c | 1 +
 1 file changed, 1 insertion(+)

-- 
2.43.5


