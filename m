Return-Path: <SRS0=YADc=KM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E8F9C433B4
	for <linux-nvme@archiver.kernel.org>; Mon, 17 May 2021 14:58:31 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 284B6601FC
	for <linux-nvme@archiver.kernel.org>; Mon, 17 May 2021 14:58:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 284B6601FC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=oYnoG5GN51ZTQ1oRzIlkYbMgSVNRfm0w7nwX0pjf7vk=; b=ihc/eUlgnRLr2Y7Oe0lzxeMS2
	kqGv2379grTnG3C5cpz6ChbxzK1/DBNQQj/I8XH7ywia9s59WLwWd6T1F9IPEmP6KJHBgcghLBZhO
	rpKtvgH7NGtrXEBfBb+T2CiqexuGFfSJpWbE/CfG8BJ7/O4vdq90ULrqZ+6Db5oFFgJiUIVV5XwzD
	sNtrhTor95oeSmWZSRnk54+IcxpMssjoZVuJdaTxTYg7y+3vYrbuysGz8GrxvshEVoUDVvkVhrRtt
	3w6HXxP801y93DBClA7zU2OLJhn9PtWifwn4Fk7idbOdr5WRdNWcDlSS3WrIG0zAmGcb08JixVyen
	uSGBU9Bhg==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1liehG-00FKko-7L; Mon, 17 May 2021 14:58:18 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1liehB-00FKkS-6k
 for linux-nvme@desiato.infradead.org; Mon, 17 May 2021 14:58:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=TZ19gTcmPO4a3EZaIyWBcOYXBxCKYE7Cve2jyRg7ZgE=; b=oWvslvW8MXEUZeYvVIP+FphLpe
 aZeYG90bfRfRPXwy5EPk+QsxYn9IQACLx6GVz6K52Wh64Cacmowa6GnkS+xdf8V/vvnI57kvV5xl1
 RjKmRRa73U3G16tkyCPoEqBse6RI60xA5A8P/IrqyYHdFkRvokCszuis3zTPAmcSp07aHB8Pc2rdf
 bbtgovCWGp5eSFpQO1mT94DKRLopw/CDmsfqNCXf5vsa43phss+6TY34uao+sYNglvzMMs5IX0ky7
 lyR4Oget+P/ZXPDSqTcSXVlCb5KCcDOvPDKwZAObYN7zqrokr0adaManoaEI9WlV2N34Md8hhtoqr
 90kBpdKQ==;
Received: from mx2.suse.de ([195.135.220.15])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lieh7-00DtJa-8r
 for linux-nvme@lists.infradead.org; Mon, 17 May 2021 14:58:12 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id F151FAEBB;
 Mon, 17 May 2021 14:58:05 +0000 (UTC)
Date: Mon, 17 May 2021 16:58:05 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Keith Busch <kbusch@kernel.org>, Hannes Reinecke <hare@suse.de>,
 "Ewan D. Milne" <emilne@redhat.com>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org, Jens Axboe <axboe@fb.com>,
 Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v2] nvme-tcp: Check if request has started before
 processing it
Message-ID: <20210517145805.end32zjhqfjh6kga@beryllium.lan>
References: <20210311094345.ogm2lxqfuszktuhp@beryllium.lan>
 <70af5b02-10c1-ab0b-1dfc-5906216871b4@grimberg.me>
 <2fc7a320c86f75507584453dd2fbd744de5c170d.camel@redhat.com>
 <ed3ccac0-79ed-fe10-89eb-d403820b4c6a@grimberg.me>
 <20210330232813.GA1935968@dhcp-10-100-145-180.wdc.com>
 <756aef10-e693-276f-82ac-514a2832b07f@grimberg.me>
 <492b8393-fc35-f58a-3768-94632a083c93@suse.de>
 <3156c563-94a4-4278-3835-b1f56f71869a@grimberg.me>
 <20210507204052.GA1485586@dhcp-10-100-145-180.wdc.com>
 <7a45dd7f-842b-4282-909b-082b501abcdc@grimberg.me>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <7a45dd7f-842b-4282-909b-082b501abcdc@grimberg.me>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210517_075809_482715_16CD0F88 
X-CRM114-Status: GOOD (  16.86  )
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

Hi Sagi,

On Fri, May 07, 2021 at 04:22:30PM -0700, Sagi Grimberg wrote:
> Yea, maybe something like this?

I did give this a spin with blktests (loopback device) and on real
hardware (FC). Seems to do work fine. Just two things.

> +/*
> + * nvme command_id is constructed as such:
> + * | xxxx | xxxxxxxxxxxx |
> + *   gen    request tag
> + */
> +#define nvme_cid_install_genctr(gen)           ((gen & 0xf) << 12)
> +#define nvme_genctr_from_cid(cid)              ((cid & 0xf000) >> 12)
> +#define nvme_tag_from_cid(cid)                 (cid & 0xfff)
> +
> +static inline u16 nvme_cid(struct request *rq)
> +{
> +       return nvme_cid_install_genctr(nvme_req(rq)->genctr++) | rq->tag;
> +}

-       return nvme_cid_install_genctr(nvme_req(rq)->genctr++) | rq->tag;
+       nvme_req(rq)->genctr = ++nvme_req(rq)->genctr & 0xf;
+       return nvme_cid_install_genctr(nvme_req(rq)->genctr) | rq->tag;

The first issue, it really needs prefix increment if you want to write
it in one line. And it should store only the first 4 bits.
nvme_find_rq() would complain with 0x0 != 0x10 after the first overflow.

> +static inline struct request *nvme_find_rq(struct blk_mq_tags *tags,
> +               u16 command_id)
> +{
> +       u8 genctr = nvme_genctr_from_cid(command_id);
> +       u16 tag = nvme_tag_from_cid(command_id);
> +       struct request *rq;
> +
> +       rq = blk_mq_tag_to_rq(tags, tag);
> +       if (unlikely(!rq)) {
> +               pr_err("could not locate request for tag %#x\n",
> +                       tag);
> +               return NULL;
> +       }
> +       if (unlikely(nvme_req(rq)->genctr != genctr)) {
> +               dev_err(nvme_req(rq)->ctrl->device,
> +                       "request %#x genctr mismatch (got %#x expected
> %#x)\n",
> +                       tag, nvme_req(rq)->genctr, genctr);

-                       tag, nvme_req(rq)->genctr, genctr);
+                       tag, genctr, nvme_req(rq)->genctr);

The arguments are in the wrong order. Got me a bit confused.

Are you going to send out a proper patch? I'd like to move things
forward and could offer to do some more testing if needed.

Thanks,
Daniel

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
