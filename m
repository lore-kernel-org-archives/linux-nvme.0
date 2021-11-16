Return-Path: <SRS0=wlVn=QD=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E85CEC433F5
	for <linux-nvme@archiver.kernel.org>; Tue, 16 Nov 2021 09:05:39 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A8FC461BF6
	for <linux-nvme@archiver.kernel.org>; Tue, 16 Nov 2021 09:05:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A8FC461BF6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:In-Reply-To:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SEw6vbHYTj7NAZPbZxxNjIOlGFb/5xK3M29fNdJDoMA=; b=C1YbWybKojdVJduSOR5sJj2JVa
	P7/6TUZSQRP1oaA7KuTJ+8j1c1AteZbVIjPRMtLao6s8/ZuICJa56h3ELFENxBS/VRL1PKR/YjyNv
	jx/tbRaUXkR4WAY0ec7IurpV2sInb45chpCWyKWJPuGA4GN939cq9FpqK82mShfnbrOl4KPTJzlJY
	t4k2eE3qEyNWN4uHDzHaD0yGespIXfTSPuVhGQHIcue0Gao571eciK6IOWQF/4//H0qQV3iFH7A6u
	Nl9MtTgF7AJ2l+fsLFZ+/BGxX2JElQ/p5fvxMrZsyr9RC66vxsRCwdIsqxruHIePhsFpkctdL97Pr
	G8mEy0wA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mmuPI-000qYQ-Tg; Tue, 16 Nov 2021 09:05:36 +0000
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mmuPF-000qXf-Oi
 for linux-nvme@lists.infradead.org; Tue, 16 Nov 2021 09:05:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1637053530;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SEw6vbHYTj7NAZPbZxxNjIOlGFb/5xK3M29fNdJDoMA=;
 b=hYZeIyDmxcdC1Dy5JHKlfGX+98bijuza0vY/1+lqLjkXicfRtDtdTgC2dTglCPcVgTdKT/
 VFNYXUeHNOn+1CkPmQNBYUNAhroPaiQUE3/ZjkRAp3P3EnofQxfJy+eJEk9SWmxzWz/Qne
 MLxFxC8m6hdAtS6K0u6LKWs3pX+wuNI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-519-33sKvGKtOXKkXck7Yfv1DQ-1; Tue, 16 Nov 2021 04:05:27 -0500
X-MC-Unique: 33sKvGKtOXKkXck7Yfv1DQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 546AD100B79B;
 Tue, 16 Nov 2021 09:05:18 +0000 (UTC)
Received: from raketa (unknown [10.40.192.80])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id EDF23472E4;
 Tue, 16 Nov 2021 09:05:16 +0000 (UTC)
Date: Tue, 16 Nov 2021 10:05:13 +0100
From: Maurizio Lombardi <mlombard@redhat.com>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, chaitanya.kulkarni@wdc.com
Subject: Re: [PATCH V2 1/3] nvmet-tcp: add an helper to free the iovec
Message-ID: <20211116090513.GF21836@raketa>
References: <20211115163114.48716-1-mlombard@redhat.com>
 <20211115163114.48716-2-mlombard@redhat.com>
 <eaeb64d3-1c55-27c3-3f22-e8f140164902@grimberg.me>
MIME-Version: 1.0
In-Reply-To: <eaeb64d3-1c55-27c3-3f22-e8f140164902@grimberg.me>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mlombard@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211116_010533_932845_CC10D93B 
X-CRM114-Status: GOOD (  21.57  )
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

On Tue, Nov 16, 2021 at 11:00:56AM +0200, Sagi Grimberg wrote:
> 
> 
> On 11/15/21 6:31 PM, Maurizio Lombardi wrote:
> > Makes the code easier to read and to debug.
> > 
> > Sets the freed pointers to NULL, it will be useful
> > when destroying the queues to understand if the
> > iovecs have been released already or not.
> > 
> > Signed-off-by: Maurizio Lombardi <mlombard@redhat.com>
> > ---
> >   drivers/nvme/target/tcp.c | 28 +++++++++++++++++++---------
> >   1 file changed, 19 insertions(+), 9 deletions(-)
> > 
> > diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
> > index 84c387e4bf43..9aa81af84efa 100644
> > --- a/drivers/nvme/target/tcp.c
> > +++ b/drivers/nvme/target/tcp.c
> > @@ -166,6 +166,8 @@ static struct workqueue_struct *nvmet_tcp_wq;
> >   static const struct nvmet_fabrics_ops nvmet_tcp_ops;
> >   static void nvmet_tcp_free_cmd(struct nvmet_tcp_cmd *c);
> >   static void nvmet_tcp_finish_cmd(struct nvmet_tcp_cmd *cmd);
> > +static void nvmet_tcp_free_iovec(struct nvmet_tcp_cmd *cmd);
> > +static void nvmet_tcp_unmap_pdu_iovec(struct nvmet_tcp_cmd *cmd);
> >   static inline u16 nvmet_tcp_cmd_tag(struct nvmet_tcp_queue *queue,
> >   		struct nvmet_tcp_cmd *cmd)
> > @@ -297,6 +299,16 @@ static int nvmet_tcp_check_ddgst(struct nvmet_tcp_queue *queue, void *pdu)
> >   	return 0;
> >   }
> > +static void nvmet_tcp_free_iovec(struct nvmet_tcp_cmd *cmd)
> 
> I'd call it nvmet_tcp_free_cmd_buffers maybe. It is freeing
> both the data buffers, sgl vector and iovec.

Ok no problem for me, I will resubmit it.

Thanks,
Maurizio


