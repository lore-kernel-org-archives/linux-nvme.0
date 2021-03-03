Return-Path: <SRS0=PLgZ=IB=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11C40C433E0
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Mar 2021 22:11:38 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7DBCB64EBB
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Mar 2021 22:11:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DBCB64EBB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=BPTuZvg2LmvasJ0k6jAfGhh2H2Ub1WCk/6Si0h55iPY=; b=MaSs60gZZb6JAIZ/HHmY0tX9+U
	Rl6vRQyfnfTzXvjCazde2Y2mTg0oBx24yV5C1IeVQoaZniv7w3dbCTKSXQUwAaCJWSINDj9Hds6QT
	Fekmc3DxDGSaAlyluOB+DB4ewMo2/6tcyc3rkvcKWk2wGYsr6Z+42jYf3VWljvY22LuSKZQecr04X
	u3KnzriXH8C97yot/qnh7tEFBbGp2KNVlytD5BA/BPqb+iosOkJWFeexh3eyHDw7vrzQzponATTe4
	yv39WZAfQUpM0z5ri4Xvw1bSgdi/4vCPlRUnxU/dXtfH1dkWE9O/YdBakF1JQJYd7ZIOrVRvZ12xl
	muEWpMVA==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lHZiF-006ich-1n; Wed, 03 Mar 2021 22:11:23 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lHTAq-005Kho-DA
 for linux-nvme@desiato.infradead.org; Wed, 03 Mar 2021 15:12:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:In-Reply-To:References;
 bh=xSbOx9BYWsEWTmTbZRYzJgmFAM6mA41kvRQ/re4xgMg=; b=BVB97C2XV6DacDTURDMAuvWXF7
 R7QSZmIR+kjw1elE4l84T+BdCphvXLVMH0ae64rVOa6g7+kxPk/zcY/xbuQIO4kpKC+zzxcc5BJP6
 /R4ItiZp408oQNP9/D5EiH3H7CB2RkelOJBQ9BzoulnV/5+pgU4Nz3u9BktESd+vu0JFTukB5PzEG
 UE9A1wa+pU5jEPZtYSDO36eAMUO+qwyLqJuiv5yX+3zeKczoDN3r2gl4wLeBHHCM2ihrXm6YX7s0P
 j9ZRiQat6Ubn73LHv7NysOe2TdQgYffqzt4sMUqNlppOwmCVutySJfXEZJMFNvqhKtSRs6OXSbjZo
 vFjhCZ3Q==;
Received: from [2001:4bb8:180:9884:624:26dd:6387:40e9] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
 id 1lHQzy-002cM2-Uv; Wed, 03 Mar 2021 12:53:09 +0000
From: Christoph Hellwig <hch@lst.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Keith Busch <kbusch@kernel.org>, James Smart <james.smart@broadcom.com>,
 linux-nvme@lists.infradead.org
Subject: reserved tag allocation fixups
Date: Wed,  3 Mar 2021 13:53:01 +0100
Message-Id: <20210303125304.1200789-1-hch@lst.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hi all,

this series is based on the report form Hannes, and first reduces
the reserved tags on the admin queue from 2 to 1 and then uses a
nowait allocation for the keep alive request to avoid a deadlock
during unlikely error scenarios.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
