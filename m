Return-Path: <SRS0=ZIaN=KN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64723C433B4
	for <linux-nvme@archiver.kernel.org>; Tue, 18 May 2021 06:59:21 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2585461007
	for <linux-nvme@archiver.kernel.org>; Tue, 18 May 2021 06:59:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2585461007
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=JvkBg7w3TN+MNr3jKP/RDq1Poj5m9ineXzJeeZihkUs=; b=FkgicKSNdcMxjFc9TvxnIUVnG
	jR4Vaj5rX6c3IuyttKvJEazk4qV4B3bT3bhG0gvMubUXJOksrv0mTVFGTpGE9JpiorhjUM03Iop4q
	Hd0M2pkacWmH0ipCEJJwtoHGz1oMvQsoEplBZYt6MJxiaZPudqhUvItgQYnzI0xb+IBFrFAbqU0RD
	ie1BdC4FeFji1audL9uFEziUSJ9XgUVKr0HxESdk8ODhHU7LK5GjunFrBcjtHFJoAcd/xgLnGwu5h
	ndRIM4Yimwv5hewXcvmRr7lB6cZCdecur/viwzD7asmwM0tLwLT6jc/UVJDDlk1ACruB9+XphjQIR
	EfAdwjMlA==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lithE-00HESm-4r; Tue, 18 May 2021 06:59:16 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lithC-00HESP-U1
 for linux-nvme@desiato.infradead.org; Tue, 18 May 2021 06:59:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=O9lG4gm2dZQhWJkXr0yb7btcYljkPkkWp/1EuwvDpWM=; b=gTy7qXHRubgOUOc7b8cinkvqX+
 cj7QxSFp7xeP1IAi39A+J6RwwirbwvxisJEUsLoWDGybsf4ZbS/Gus0FwIEvByxxYfsff7PCVK7Mf
 NqRciP8ZyTMaqSibHz8fZ5iMnMWJfFc4XY4+EoiqUCPyzWlfnDDRgnQL+Pd/22+5xdsXCvAdvPavs
 dQhjot5awCVsiuJTPA+v5Hae3oGXY4tAAaKFBi1ER7T7hELGb02zOQmRXJocH2Xw1coErY+V94wZU
 qaI2FpIXhdU5HjxNZN1YmQf9pjWFniumIy176TZ0KGz3Exf911NwZkg/yoNEEWyUxesAqHRhkm5Td
 0OzpxWZQ==;
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lithA-00EO0I-GU
 for linux-nvme@lists.infradead.org; Tue, 18 May 2021 06:59:13 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id E5C6467373; Tue, 18 May 2021 08:59:09 +0200 (CEST)
Date: Tue, 18 May 2021 08:59:09 +0200
From: Christoph Hellwig <hch@lst.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
 Keith Busch <kbusch@kernel.org>, Daniel Wagner <dwagner@suse.de>
Subject: Re: [PATCH 1/3] nvme-tcp: don't check blk_mq_tag_to_rq when
 receiving pdu data
Message-ID: <20210518065909.GA8300@lst.de>
References: <20210517175955.602725-1-sagi@grimberg.me>
 <20210517175955.602725-2-sagi@grimberg.me>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210517175955.602725-2-sagi@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210517_235912_710543_F06B2305 
X-CRM114-Status: GOOD (  13.30  )
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

> +++ b/drivers/nvme/host/tcp.c
> @@ -699,12 +699,6 @@ static int nvme_tcp_recv_data(struct nvme_tcp_queue *queue, struct sk_buff *skb,
>  	struct request *rq;
>  
>  	rq = blk_mq_tag_to_rq(nvme_tcp_tagset(queue), pdu->command_id);
> -	if (!rq) {
> -		dev_err(queue->ctrl->ctrl.device,
> -			"queue %d tag %#x not found\n",
> -			nvme_tcp_queue_id(queue), pdu->command_id);
> -		return -ENOENT;
> -	}
>  	req = blk_mq_rq_to_pdu(rq);

We could simplify the initialization a bit now:

	struct request *rq =
		blk_mq_tag_to_rq(nvme_tcp_tagset(queue), pdu->command_id);
	struct nvme_tcp_request *req = blk_mq_rq_to_pdu(rq);

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
