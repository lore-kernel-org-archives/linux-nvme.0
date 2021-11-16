Return-Path: <SRS0=wlVn=QD=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E0D1C433EF
	for <linux-nvme@archiver.kernel.org>; Tue, 16 Nov 2021 09:23:06 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D411F61B27
	for <linux-nvme@archiver.kernel.org>; Tue, 16 Nov 2021 09:23:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D411F61B27
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:In-Reply-To:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ajgnNJ6HcbbNi96WySElCqVIMd+iTgvuqFp5lknccLQ=; b=j5IZcKKI3+woUSzXKA5JlzztcO
	muLQ18bBwWoFqpoDMfTfJfgD4HQYFEGffz7cTMah8hOuMNpMX73ZiwTW9rdaaRLIRsf5+NvAw9mWX
	B55tP/ZzhQVy0MuujfU++0WPwR/FvlElgtQC/HmZXO16FX0hFeALiF1TqjLxFEoiig6120hp4t2np
	qnoNUy8gjdqpLc5DQTG7Rr7mLDMWGSQMUCrKe7JL6Ii/h2fxxMYCbzEL3ggCyx9i9HqhC/E8ret+2
	U8jRm2WVQYA3eze8U5FWsloLvqhnr5YYJu4Liq10DTyc/wp4byHGypHs56xiLLegsN91hX+vEHQFO
	vviV8I3Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mmug8-000vaU-V8; Tue, 16 Nov 2021 09:23:01 +0000
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mmug6-000vZs-5v
 for linux-nvme@lists.infradead.org; Tue, 16 Nov 2021 09:22:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1637054577;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ajgnNJ6HcbbNi96WySElCqVIMd+iTgvuqFp5lknccLQ=;
 b=fIHCHTk8Js2tL4B57AlYaM/jNvfIJPrc6BcDHMu/1hfdzlHaox2wkFGV+UKegHwZY2rjLJ
 Er/i/pAFqc6/iO7/KMK4DZV12eGNH8nzac4bMO5M52Mhd0HO8WFH+zoGo8UpnuflVpWMDl
 gw+caPH6UiIo5lyoRCECzF1NegCsuyw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-523-aG7e2k2lN16iQs5vdOugcw-1; Tue, 16 Nov 2021 04:22:53 -0500
X-MC-Unique: aG7e2k2lN16iQs5vdOugcw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9EE08CC622;
 Tue, 16 Nov 2021 09:22:52 +0000 (UTC)
Received: from raketa (unknown [10.40.192.80])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6961360BD8;
 Tue, 16 Nov 2021 09:22:51 +0000 (UTC)
Date: Tue, 16 Nov 2021 10:22:48 +0100
From: Maurizio Lombardi <mlombard@redhat.com>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, chaitanya.kulkarni@wdc.com
Subject: Re: [PATCH V2 3/3] nvmet-tcp: fix memory leak when performing a
 controller reset
Message-ID: <20211116092248.GG21836@raketa>
References: <20211115163114.48716-1-mlombard@redhat.com>
 <20211115163114.48716-4-mlombard@redhat.com>
 <6f864cab-8460-3956-5784-2c3669069028@grimberg.me>
MIME-Version: 1.0
In-Reply-To: <6f864cab-8460-3956-5784-2c3669069028@grimberg.me>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mlombard@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211116_012258_325602_72DD23B5 
X-CRM114-Status: GOOD (  24.34  )
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

On Tue, Nov 16, 2021 at 11:07:29AM +0200, Sagi Grimberg wrote:
> 
> > If a reset controller is executed while the initiator
> > is performing some I/O the driver may leak the memory allocated
> > for the commands' iovec.
> > 
> > Make sure that nvmet_tcp_uninit_data_in_cmds() releases
> > all the memory.
> > 
> > Signed-off-by: Maurizio Lombardi <mlombard@redhat.com>
> > ---
> >   drivers/nvme/target/tcp.c | 5 ++++-
> >   1 file changed, 4 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
> > index 028b47ff0f0f..5a238fa067cd 100644
> > --- a/drivers/nvme/target/tcp.c
> > +++ b/drivers/nvme/target/tcp.c
> > @@ -1427,7 +1427,10 @@ static void nvmet_tcp_uninit_data_in_cmds(struct nvmet_tcp_queue *queue)
> >   	for (i = 0; i < queue->nr_cmds; i++, cmd++) {
> >   		if (nvmet_tcp_need_data_in(cmd))
> > -			nvmet_tcp_finish_cmd(cmd);
> > +			nvmet_req_uninit(&cmd->req);
> > +
> > +		nvmet_tcp_unmap_pdu_iovec(cmd);
> > +		nvmet_tcp_free_iovec(cmd);
> 
> I understand how unmap_pdu_iovec is re-entrance safe, but sgl_free
> called from free_iovec is not. What prevents it from being called
> for commands that have already freed their sgls?

The commands that have already freed their sgls
will have the pointers set to NULL,
calling sgl_free() against a NULL pointer is safe (it does nothing, like kfree())
but if you prefer I will add a check.

Maurizio


