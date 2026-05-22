Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8C27CD5BB0
	for <linux-nvme@archiver.kernel.org>; Fri, 22 May 2026 12:11:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ahdv2TE4wxYr2fslYafDOVqm40bcy6xzOEfBW1MXqa4=; b=HdgYDtVdjHpiOzCdqWlCIcdvZs
	crZL4crnQa4zSOZ9rX9zScJx3doSZ8/t961jBjhjSjf3XYBsXokZRReS+pOo8Weqk7OunNWB/qSr8
	5oL5UdmmfXZFqipFlTe0uV2XpSfeAiMn6KeDddzWCUYFt4/L80s7NC83dJuEyWDl6CHjI50gKOZlq
	h6SsA1F9lWQXj2RMrR1OoiWqCKy/uTk2/JCx9Wr108XdIpNk1cUSyiW8hnDrs0BMLBuoWxBqK2fEL
	j8cVdCSypH/B+ifg4v1EbCnnsbfToX/1SR+/9ENdwlmZS252HKY/NfRbpeeESbgW/volFRr2iIHvQ
	Uqj3Jlfw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wQOiU-0000000Ak6Z-1emA;
	Fri, 22 May 2026 12:11:02 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wQOiR-0000000Ak5a-3UjT
	for linux-nvme@lists.infradead.org;
	Fri, 22 May 2026 12:11:01 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id AF46F68BFE; Fri, 22 May 2026 14:10:54 +0200 (CEST)
Date: Fri, 22 May 2026 14:10:54 +0200
From: Christoph Hellwig <hch@lst.de>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: John Garry <john.g.garry@oracle.com>, linux-nvme@lists.infradead.org,
	hare@suse.de, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
	dwagner@suse.de, kanie@linux.alibaba.com, jmeneghi@redhat.com,
	randyj@purestorage.com, martin.petersen@oracle.com,
	gjoyce@linux.ibm.com
Subject: Re: [PATCHv6 1/8] block: expose
 blk_stat_{enable,disable}_accounting() to drivers
Message-ID: <20260522121054.GA21338@lst.de>
References: <20260520182112.863076-1-nilay@linux.ibm.com> <20260520182112.863076-2-nilay@linux.ibm.com> <e9b2c9a7-b9d5-48f3-8a79-cf925b99b7e1@oracle.com> <c0d1d025-0c34-4df0-a123-1324e2a99389@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c0d1d025-0c34-4df0-a123-1324e2a99389@linux.ibm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260522_051100_015128_701B91BD 
X-CRM114-Status: UNSURE (   7.46  )
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

blk_stat_enable_accounting is currently only useful for blk-mq based
drivers, so please keep it there.


