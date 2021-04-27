Return-Path: <SRS0=pISK=JY=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE1E7C433B4
	for <linux-nvme@archiver.kernel.org>; Tue, 27 Apr 2021 16:25:53 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 74EAA61164
	for <linux-nvme@archiver.kernel.org>; Tue, 27 Apr 2021 16:25:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74EAA61164
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=n7bSm1KWEfanOOqDcPZWrato/SAy0YPc2F5p4pVzWfE=; b=e25V5bIniL74275JkUCmCFZNY
	sN78mIA+ETQt1cKPG9Zd2J5pmbPpjBYVoY4JTYm9jHZTPbUAOCy+IaHJrgH5Wu9pGdHBsYJtqFbAS
	2+96OhHTMzc4NUs4TWL5Ybw2JlfLei3vJSdWldWth/yXl60ltq2NhdFB43NLEimjdBWFj51LDEWHw
	2SrVcfwNPLplFhuu+ktX3ETIl+dDirMGXs3WCNs1xB//JwiZIjYYCv8cM14IDF47sK62FhxX0MY18
	3YYC0b50R5tI9GvW5QDWG4bDSJzAgBGQ01z6G5kUmTTfjmGDBNi7Sp3NF5uLo3wj/YAYi9R0/qh/k
	PUzHUPCIA==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lbQWq-001teZ-1n; Tue, 27 Apr 2021 16:25:40 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lbQWo-001teN-Hv
 for linux-nvme@desiato.infradead.org; Tue, 27 Apr 2021 16:25:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=Rzf9CBm0A/UxqwDq3gprGxlgmTOSHA44Yt9/BDak0pc=; b=mRylvOs4G8XJGViIGzFTQAxFHW
 kH6Hjcir5R2eagZ9JeBTDmMQ3qpY6Hn1zbmZh5aVmXHKqsdZRx1UGU8mWKmSvDrjZxFm7Z5A1HCC4
 mdUlXjRJWiuOojmmJVajXB3CAkGUfyDLlBxqUv5LDN4JdW7xw2bOGHbegGH2XPF0L6OXXDBFag7xd
 L6UxwsoMt0unG6rPLo7e5i0ClbFqqCDeWURTvdliygkSfL8s91F/9TNtnCMDBoW32Z20XQpSEcNky
 ugDUeMDxaGzrVxdvhj6rl61zYnatLODArR3cxhEgNdnea69iU48EbLsArWNOoQkFEWBKwYO0jSf82
 V80fzy3Q==;
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lbQWl-00GrNK-Of
 for linux-nvme@lists.infradead.org; Tue, 27 Apr 2021 16:25:37 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 5DF8B68C7B; Tue, 27 Apr 2021 18:25:23 +0200 (CEST)
Date: Tue, 27 Apr 2021 18:25:21 +0200
From: Christoph Hellwig <hch@lst.de>
To: Hannes Reinecke <hare@suse.de>
Cc: mwilck@suse.com, Keith Busch <kbusch@kernel.org>,
 Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>,
 Chao Leng <lengchao@huawei.com>, Daniel Wagner <dwagner@suse.de>,
 linux-nvme@lists.infradead.org, stable@vger.kernel.org
Subject: Re: [PATCH v3] nvme: rdma/tcp: fix list corruption with anatt timer
Message-ID: <20210427162521.GA26528@lst.de>
References: <20210427085246.13728-1-mwilck@suse.com>
 <0ff2dbc0-0182-f54d-b750-084feac53601@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <0ff2dbc0-0182-f54d-b750-084feac53601@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210427_092535_967901_A1E2ED6A 
X-CRM114-Status: GOOD (  11.09  )
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

On Tue, Apr 27, 2021 at 11:33:04AM +0200, Hannes Reinecke wrote:
> As indicated in my previous mail, please change the description. We have
> since established a actual reason (duplicate calls to add_timer()), so
> please list it here.

So what happens if the offending add_timer is changed to mod_timer?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
