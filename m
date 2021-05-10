Return-Path: <SRS0=GcL3=KF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2662BC433B4
	for <linux-nvme@archiver.kernel.org>; Mon, 10 May 2021 07:01:15 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE6156105A
	for <linux-nvme@archiver.kernel.org>; Mon, 10 May 2021 07:01:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE6156105A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=7xin8YcM8UXA1N0nCbD4BbyDBrLeWo+T/XKKPOETZ9c=; b=YtmV2ITg5iVj98646dQ3+iqa3
	2iTv34QAt/XA221oHyuQTvDydtcvgc30tATz+MeP9FfEdRXftrQcxPRY05PDrkvYIsnmI4SEE9GDY
	omk8z8X+ehMtFLMONibWCRrARzeUGHWbl6ve3AVorWHey6yXLf6KOWAPCGo/NSffuz1RFZrvZlbN0
	8aFviXj/qt7BRphJbYnr40vANct62XKqhYQhnupKILIFvaHlzq2Oao9pj83BZuTfKabMvJ1406M59
	pXevlPAF26tYNyUDMOp752YVuHtdtZkg54UeDJBDZ8ve0ZhyuUfujtNy3WvPLKeswAhNjMRdn3YV/
	tLezwe1vA==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lfzuf-00DRJu-SE; Mon, 10 May 2021 07:01:09 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lfztw-00DR7L-OC
 for linux-nvme@desiato.infradead.org; Mon, 10 May 2021 07:00:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=JfcaAWiL9MX/KzgqZFMd5GxaGaNC7KsyrSBFfXwwLXo=; b=LU+5BXzuspGawJyGnwYMwo77tQ
 elW3TpjafPYst9bh5uRbksUq1UsKRV7+OhkLw7mom16QoF2ucZN0lSY8vnbzfxw1gO5soOfOEUvxB
 WqN35btsCcZiVMo/8AekjF9HbGs8WM2atsualeJpHJJjcTeAJ2hgCcYm/GuoKFN6buiVvJgkYdeAd
 uX3aFzjiqdpD6Qi/yaiDkzEWz33K93ggLLLRP9RKfe+QiJgE5+DHtNFMEqs6TKVzJA/ywiN4d8MZx
 1QWILLiNwv5p4XAXLLkoU9IcbIjjFLdRidivQooJJHvimmCJ8z6NwG5KYRt5nY48YYSm2chDxv/Jk
 dlxEuTpw==;
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lfztu-008MB1-Cu
 for linux-nvme@lists.infradead.org; Mon, 10 May 2021 07:00:23 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 779F967373; Mon, 10 May 2021 09:00:20 +0200 (CEST)
Date: Mon, 10 May 2021 09:00:20 +0200
From: Christoph Hellwig <hch@lst.de>
To: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me
Subject: Re: [PATCH V2 0/2] nvmet: consider req->sg_cnt for inline bio
Message-ID: <20210510070020.GC30907@lst.de>
References: <20210507015136.11069-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210507015136.11069-1-chaitanya.kulkarni@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210510_000022_590315_0496DF2B 
X-CRM114-Status: UNSURE (   7.63  )
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

Thanks,

applied to nvme-5.13.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
