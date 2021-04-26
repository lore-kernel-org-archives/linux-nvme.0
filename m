Return-Path: <SRS0=AvHe=JX=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E852C433ED
	for <linux-nvme@archiver.kernel.org>; Mon, 26 Apr 2021 14:36:21 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 04ED861004
	for <linux-nvme@archiver.kernel.org>; Mon, 26 Apr 2021 14:36:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04ED861004
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=SgVXsRM8nyq8ICljSRkYNbIhlxVgL9zei0pShmBmFlY=; b=mA32I0HDT5MmeHHFr67RZICmL
	qH+3Pkz7TGCa5mNtbq7jTIto09f7Wa/RL3CqWI6ETtTyN+nXdKFB10Y2u3t4ooSx+kiGYB9/eE5Xp
	YPohk2JkwTMhOFXfAnf4Yela9+pZj9Md1frWYRWeNMzMJKO8ioTavi4bqV94rcoGBdAP5t7JyPNh6
	THp37MTTWkZrMtxPQ3yqaO6sf0KBvILTZcxCr0rQDAQfnmRDlFpGhPmMKnZ6JaHwhXDBHJ4exbWaJ
	UmMmlqgHJ6OEoe7nj+rZRNPjCf1vSOOHTZoUZwJSxSSiNbKbHfMq3Xsm2LgfIHc0lHWAZ6NYQ3XM9
	xNnCyTjTA==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lb2LG-007rAZ-3i; Mon, 26 Apr 2021 14:36:06 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lb2LC-007rA1-OD
 for linux-nvme@desiato.infradead.org; Mon, 26 Apr 2021 14:36:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=l2WBiCb5duYJRA9nKpihqrJOH1Qjg6utSrFiu8qAdtc=; b=Od4I3UJoHb5vECp2M8/5cd1a3w
 utpiF0KPvWowyrAfu8zBGGWX634AAAfxuIwcsmya82dCnn9Sremq6rh/J7+aJcgdb8S1thVquqGLD
 45KAKXr+kgVa9HXL21uFtdWm1/rkWVWTlFnTepFihKSHxT+uebC3Ue4g2KXSn6lhugE8lR6wA6cLc
 WDh4UHbuBTOzA8rkwPFKub4mt4ajnPYryfuXtDXOezNAI16GVXmeFj9VaQfhKyiYC0LmhHj2xEjSG
 q1nJaLeWqzKdLTC/VrojK2ksBHbwAfedhRisMAlMNBKbxw9A2sSb2U0kdCzcuhT/VfuYmhxNO4dWF
 IP0ToUTQ==;
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lb2LA-00G12f-C1
 for linux-nvme@lists.infradead.org; Mon, 26 Apr 2021 14:36:01 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 79A7668C4E; Mon, 26 Apr 2021 16:35:58 +0200 (CEST)
Date: Mon, 26 Apr 2021 16:35:58 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org, sagi@grimberg.me, hch@lst.de,
 axboe@kernel.dk, linux-block@vger.kernel.org,
 Yuanyuan Zhong <yzhong@purestorage.com>,
 Casey Chen <cachen@purestorage.com>
Subject: Re: [PATCHv2 2/5] nvme: use blk_execute_rq() for passthrough commands
Message-ID: <20210426143558.GB20668@lst.de>
References: <20210423220558.40764-1-kbusch@kernel.org>
 <20210423220558.40764-3-kbusch@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210423220558.40764-3-kbusch@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210426_073600_575447_F2F06D9B 
X-CRM114-Status: UNSURE (   8.91  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
