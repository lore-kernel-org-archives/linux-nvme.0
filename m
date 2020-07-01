Return-Path: <SRS0=8PNV=AM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF5FEC433DF
	for <linux-nvme@archiver.kernel.org>; Wed,  1 Jul 2020 21:14:36 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C47220748
	for <linux-nvme@archiver.kernel.org>; Wed,  1 Jul 2020 21:14:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="0ci/gwgs";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ei01p+2U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C47220748
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe
	:List-Id:Mime-Version:References:In-Reply-To:Date:To:From:Subject:Message-ID:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uUekgI38XOgrNzHzotCwRPJitvumwH6iWQZqlXCyLJc=; b=0ci/gwgsNgyxN5C+yuRAm+7iHf
	Ub8omneF7x+tgaLz5tl9pWDfxF/4uvacidJCvtiiXl/+zhckGXfVt568qu0Gqy7nksUXGCReNtdzi
	hv0RaH7OlTJgIMUeb505AmRHBURuEi8z2MXQdA3hkcA8Hntd7kusOWTEkrjM9MFPOgO+f3Nf43jST
	P+zCHf9HAkxcLP5pvgsaLHX7SYnzBDqXQTOruI1rA8WzBm1ITGIbHUa7c0B/d/6U29oH+cdYUWu7L
	/g0rowLl6R4X5IdhFw/9eoUlGGBfnzKOaLpjVjCjrXlc40NkUXG1Q1qvYSptjRwxawURsT1Dpp54q
	PtsT5FMA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jqk3p-0000yz-G5; Wed, 01 Jul 2020 21:14:29 +0000
Received: from us-smtp-1.mimecast.com ([205.139.110.61]
 helo=us-smtp-delivery-1.mimecast.com)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jqk3m-0000yY-SD
 for linux-nvme@lists.infradead.org; Wed, 01 Jul 2020 21:14:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593638066;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RSwHAVaCMBLtuvOcLOFxR9Ql/NjCDwxC+95iOCUGSD8=;
 b=ei01p+2UPOc1qgRh+oiYGjKVsSx7MODV/oVlMlAWvV+OvGoy14gvPiL1hGDoMnkVcCqjHN
 s5npJ4jRiqwynUE5pb/gkMh8Ny9hC0M9SyggJiKdqQZ0PxDVN+QXbD+gbR4gKfvj1NMzUb
 Ns314yOdxEIUTzoDyMoR0KKd5QuwkhA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-480-nP1p3-VLMxiORXTQOjXsWg-1; Wed, 01 Jul 2020 17:12:41 -0400
X-MC-Unique: nP1p3-VLMxiORXTQOjXsWg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8504580183C;
 Wed,  1 Jul 2020 21:12:40 +0000 (UTC)
Received: from ovpn-112-19.phx2.redhat.com (ovpn-112-19.phx2.redhat.com
 [10.3.112.19])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1B9785DAB0;
 Wed,  1 Jul 2020 21:12:40 +0000 (UTC)
Message-ID: <b44b1328494628e4e0fdbfb226a7ffffc9a139a8.camel@redhat.com>
Subject: Re: [PATCH v5] nvme-fabrics: reject I/O to offline device
From: "Ewan D. Milne" <emilne@redhat.com>
To: Sagi Grimberg <sagi@grimberg.me>, Victor Gladkov
 <Victor.Gladkov@kioxia.com>,  "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>
Date: Wed, 01 Jul 2020 17:12:39 -0400
In-Reply-To: <8ddc3564-494a-d32d-cf97-ce7d8174f91c@grimberg.me>
References: <cde32cd53001412889cea1e1fe28e7f7@kioxia.com>
 <8ddc3564-494a-d32d-cf97-ce7d8174f91c@grimberg.me>
Mime-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=emilne@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200701_171426_951769_2ACCC679 
X-CRM114-Status: GOOD (  15.21  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

I'm seeing an I/O hang followed by errors returned to userspace on
NVMe/FC and NVMe multipath with the v4 patch.  It fails right away.
This is with a test that does alternating link bouncing on the target.

-Ewan


On Tue, 2020-06-30 at 17:18 -0700, Sagi Grimberg wrote:
> > @@ -612,6 +613,8 @@ bool __nvmf_check_ready(struct nvme_ctrl *ctrl,
> > struct request *rq,
> >   	{ NVMF_OPT_NR_WRITE_QUEUES,	"nr_write_queues=%d"	},
> >   	{ NVMF_OPT_NR_POLL_QUEUES,	"nr_poll_queues=%d"	},
> >   	{ NVMF_OPT_TOS,			"tos=%d"		},
> > +	{ NVMF_OPT_FAIL_FAST_TMO,	"fast_io_fail_tmo=%d"	},
> > +	{ NVMF_OPT_FAIL_FAST_TMO,	"fast_io_fail_tmo=%s"	},
> >   	{ NVMF_OPT_ERR,			NULL			}
> >   };
> > 
> > @@ -631,6 +634,7 @@ static int nvmf_parse_options(struct
> > nvmf_ctrl_options *opts,
> >   	opts->reconnect_delay = NVMF_DEF_RECONNECT_DELAY;
> >   	opts->kato = NVME_DEFAULT_KATO;
> >   	opts->duplicate_connect = false;
> > +	opts->fast_io_fail_tmo = NVMF_DEF_FAIL_FAST_TMO;
> >   	opts->hdr_digest = false;
> >   	opts->data_digest = false;
> >   	opts->tos = -1; /* < 0 == use transport default */
> > @@ -751,6 +755,28 @@ static int nvmf_parse_options(struct
> > nvmf_ctrl_options *opts,
> >   				pr_warn("ctrl_loss_tmo < 0 will
> > reconnect forever\n");
> >   			ctrl_loss_tmo = token;
> >   			break;
> > +		case NVMF_OPT_FAIL_FAST_TMO:
> > +			if (match_int(args, &token)) {
> > +				p = match_strdup(args);
> > +				if (!p) {
> > +					ret = -EINVAL;
> > +					goto out;
> > +				}
> > +
> > +				token = strcasecmp(p, "off") ? 0 : -1;
> > +				kfree(p);
> > +
> > +				if (!token) {
> > +					ret = -EINVAL;
> > +					goto out;
> > +				}
> 
> Rethinking about this when reading the code, let's drop the "off"
> string
> option, nvme-cli is probably the better place for free text
> processing...
> 
> I think that overall this looks reasonable. But I'd like to hear
> others
> on this. Keith, Christoph, Chaitanya, James, Hannes, please review
> this approach.
> 
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-nvme
> 


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
