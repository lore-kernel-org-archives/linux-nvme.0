Return-Path: <SRS0=CVBY=5U=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48519C2BA16
	for <linux-nvme@archiver.kernel.org>; Sat,  4 Apr 2020 07:10:21 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F20A206F5
	for <linux-nvme@archiver.kernel.org>; Sat,  4 Apr 2020 07:10:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="lyTL7pNA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F20A206F5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Ell1OW+Pz78hBjZSXg/8MPl/jXceE3oswLxY65dF5pQ=; b=lyTL7pNAVl9yNl
	1wCQZ3ti08WZzR5LRL4+4nvUhdxMBRtCcuQPidslnhJqR3UGzQK1MWrmV/Nnifl9R29X43ceX+inS
	2O0j1y98QhuSj5FSyTKypNTekiONEjNu1GPjKOjBir2a6ZYuF9WRvgzQ8h9xrhH0r8ISXk6YASk/3
	7W8A3hLzL2eaKkAQExb6wGqCXmAs5PWmq+JSNnAUg4Omr+SCHNjrBh8Z/OisQX1UAkm5c7JeAUGIM
	ePxwxqt6v3dsD4D0y/DiykNsw2UJOnMJRM8SGh5ijnEq1eaxbvLxvg/iPSb0bgqgNPYmMTIG9OQqA
	s9XXOLTW1Z7M7wSmUvhA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jKcwd-0001R3-4q; Sat, 04 Apr 2020 07:10:19 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jKcwZ-0001QO-Vx
 for linux-nvme@lists.infradead.org; Sat, 04 Apr 2020 07:10:17 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id AF16B68C4E; Sat,  4 Apr 2020 09:10:12 +0200 (CEST)
Date: Sat, 4 Apr 2020 09:10:12 +0200
From: Christoph Hellwig <hch@lst.de>
To: James Smart <jsmart2021@gmail.com>
Subject: Re: [PATCH] nvme-fc: Revert - add module to ops template to allow
 module references
Message-ID: <20200404071012.GA14574@lst.de>
References: <20200403143320.49522-1-jsmart2021@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200403143320.49522-1-jsmart2021@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200404_001016_176210_9366DE8C 
X-CRM114-Status: UNSURE (   6.08  )
X-CRM114-Notice: Please train this message.
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Keith Busch <kbusch@kernel.org>,
 Himanshu Madhani <himanshu.madhani@oracle.com>, stable@vger.kernel.org,
 linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Thanks,

applied to nvme-5.7.

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
