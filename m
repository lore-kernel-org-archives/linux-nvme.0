Return-Path: <SRS0=/SuC=JR=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0B6EC433B4
	for <linux-nvme@archiver.kernel.org>; Tue, 20 Apr 2021 10:08:32 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F730613AE
	for <linux-nvme@archiver.kernel.org>; Tue, 20 Apr 2021 10:08:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F730613AE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=7b81AIw9ZdFgspmBhj5Hp40HjgKDm9xZ1VCz2XaTFo8=; b=cSlqruBrJCRznRoJLIXoZ06oXt
	MSrSl+xdU9mCnLgVqin7hhPwe6FIVPivRMs67B8PTRdQq+ni2q3T7dZrOeAtOYUV8nvSLYYDLnUmP
	ppGA4Ih0gJQramc0kZmX+jmQ9SPNJcnMLwrZon9caM1QHaJZRCnximPOqaIaSmr7fNkA6PwINeX+s
	r12XwfKzFTYEtYcDGlgXUZN53HgaIj7pw2VPzYcgKfUnFdpEAgLOPvU0p+p7SztqBvVHPx95VGrki
	Ij3ee5Gdh1sRYj/tWMNm/umL+7BC5GZysMJQFcPX0rHRhZ+SzbcLrHM8zsnnl5dipc6pumBVYH2Z6
	PrJvibbg==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lYnIT-00BqMu-Nr; Tue, 20 Apr 2021 10:07:58 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lYnIP-00BqMT-PG
 for linux-nvme@desiato.infradead.org; Tue, 20 Apr 2021 10:07:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:In-Reply-To:References;
 bh=IDx6t48YwD+rTiw9Ltq+KniGBKS4WnlSnWbrrVWkh7w=; b=pAFB9FVUBqhIVZhMLCDQEG6f7/
 7zXuZmOjIN4J2n0DaCUE0EhuhQAPZecupzJgnoGoY4XJ/ZQV2W7rqwv3DCy3Lxt+AidzCDdoRxuv2
 2Gplinpcxc3NEqfLr132GkMeRZlymFzif/5w5yQguibemfbQvQJhbA1MqMC20ZCp1vze1WIDAtbIy
 sZkzJ6GzHq/U8/xyp++g+CClAG1vLTzGn2S7TgGuDtotOjQ+bFGgjNgU3vvHiC+Tdo+a1E5sbPE+y
 sqWQGeSvXX47x/sjfL5LyZeDVHcMFRNXFdeQ7je6rqZQoWAeNfj89INYXrIwytqsmv7BFL2ZY2ftk
 3j7DBKxA==;
Received: from [2001:4bb8:19b:f845:7e4b:8a2:58e2:9b7b] (helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
 id 1lYnIK-00C0bH-R1; Tue, 20 Apr 2021 10:07:49 +0000
From: Christoph Hellwig <hch@lst.de>
To: Minwoo Im <minwoo.im.dev@gmail.com>, Keith Busch <kbusch@kernel.org>,
 Sagi Grimberg <sagi@grimberg.me>
Cc: Kanchan Joshi <joshiiitr@gmail.com>,
 Javier Gonz??lez <javier.gonz@samsung.com>, linux-nvme@lists.infradead.org
Subject: nvme generic per-namespace char device
Date: Tue, 20 Apr 2021 12:07:45 +0200
Message-Id: <20210420100746.2801722-1-hch@lst.de>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
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

this series picks up the generic per-namespace character device
from Minwoo and Javier with a few small fixes.

Changes since v1:
 - ensure the cdev idea is freed
 - dropped the already merged ioctl cleanup

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
