Return-Path: <SRS0=15Zf=IO=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8355FC433DB
	for <linux-nvme@archiver.kernel.org>; Tue, 16 Mar 2021 18:09:15 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CFDC165127
	for <linux-nvme@archiver.kernel.org>; Tue, 16 Mar 2021 18:09:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFDC165127
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=mYgklRkyxR5gOkNZwhgvxAucL/KzWOQHsmWscqQk5ZQ=; b=bKaOZsTiSFqBvCUqOngQe+TO9
	1cO0RP2OhSoA/x6SAF/tuQnLsKj2qChxuqvUnepOTuNMEoj0kEKyw+BohgpTAFwZjeZPOY86sQm1S
	dWQtxBf8FvKeU/ZloQh9uBfjwclJjISp+pFXpLh7fWABraFEdk260Ow4vIhJpVbSrF1yyHfvyE6tG
	elXX2xL9HOsR/SRpL31sMS5vz1XaM3HigZHzaxRMkY947Adi6kYa+dfutEVOlH5ibegESf6xDpWeD
	is3QIcnhYtCHSyxKZelmFHLRiLhqmX4xAS9/EBCQQuuoId2UNaypOe4FmlcB5xcv5uvbW7yzColZz
	Y6/UR4dGg==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lME7f-001YuW-LK; Tue, 16 Mar 2021 18:08:52 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lME7V-001YpD-8E
 for linux-nvme@lists.infradead.org; Tue, 16 Mar 2021 18:08:45 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 489136512E;
 Tue, 16 Mar 2021 18:08:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1615918119;
 bh=LUMJqnyLysp5yXlSOrzeMburOnCHmdjR7emZyxQKX+s=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=gHQyc/4JA0YLaLkR6nv3gq9Q4G+0ZCBd7oB4ipipKOxowxfRFsKHrCm6z2azkfMJD
 c57YU4CLxrYeCNEiTOlnnwOjkkmc1fJUmsHCoJzbgh0GoqzWTAqLCZRyqi0uWlnT3s
 eshfsAqt6g3ADUsNt9S0jQbwapGVUIa3JRIuv9Zm/yw04ZINDQY2lYL6UayHgetoz1
 s6/d8fXjLcXcG79s7bPIzF8un9iRA11mlPI0ksZcE/oae4CbZ8Ri47lcRYUAWILAhf
 ZUM0J/JjNwFONyZb8NNDij5jT/Rr4SfUCfwxUhtRj+2Q0O7aP/iAyzI8LAqu+Y0lOU
 2QvCSZcg1l2Sg==
Date: Tue, 16 Mar 2021 11:08:37 -0700
From: Keith Busch <kbusch@kernel.org>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org, hch@lst.de,
 Kanchan Joshi <joshi.k@samsung.com>
Subject: Re: [PATCH 2/2] nvme: use driver pdu command for passthrough
Message-ID: <20210316180837.GB4161119@dhcp-10-100-145-180.wdc.com>
References: <20210316170632.4161183-1-kbusch@kernel.org>
 <20210316170632.4161183-2-kbusch@kernel.org>
 <7d077a33-8100-245f-37c0-a6f66ff29ded@grimberg.me>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <7d077a33-8100-245f-37c0-a6f66ff29ded@grimberg.me>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210316_180842_155809_ED6D9329 
X-CRM114-Status: GOOD (  10.02  )
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

On Tue, Mar 16, 2021 at 10:44:11AM -0700, Sagi Grimberg wrote:
> 
> > -blk_status_t nvme_setup_cmd(struct nvme_ns *ns, struct request *req,
> > -		struct nvme_command *cmd)
> > +blk_status_t nvme_setup_cmd(struct nvme_ns *ns, struct request *req)
> >   {
> > +	struct nvme_command *cmd = nvme_req(req)->cmd;
> >   	blk_status_t ret = BLK_STS_OK;
> >   	if (!(req->rq_flags & RQF_DONTPREP))
> >   		nvme_clear_nvme_request(req);
> > -	memset(cmd, 0, sizeof(*cmd));
> 
> I'm assuming nothing broke with this clearing removed...

It's not really removed, it's just relocated to
nvme_clear_nvme_request(). The passthrough case calls it before
.queue_rq(), so this must makes sure we don't clear it twice.
 
> Did you happen to run blktests?
> - ./check nvme
> - nvme_trtype=rdma ./check nvme
> - nvme_trtype=tcp ./check nvme

I'll give this a try.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
