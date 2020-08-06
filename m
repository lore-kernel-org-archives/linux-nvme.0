Return-Path: <SRS0=CEZP=BQ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B67CC433DF
	for <linux-nvme@archiver.kernel.org>; Thu,  6 Aug 2020 18:42:49 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D647F221E2
	for <linux-nvme@archiver.kernel.org>; Thu,  6 Aug 2020 18:42:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="jGd52YJo";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QMk7g3zj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D647F221E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=F9I71lLVDwREIgrnQ0kmRTsFwAeVP2oL7JEgvWIXjvU=; b=jGd52YJoC/1XjnghZ77b/PJnh
	LubDkgxKHrBFA7ZqnThgV1ZEuNoW9n62XIea+QCOzKWjD302l3Gh4/Etzr7AE5NmTWK2P4qYxKJt5
	9s85GZ3lDW73ESNhqFlXBD82eL4FyF2bEM4tIM6YnbdUUBq6mpYbtIhUNlAGVnMl3+3nh/3yOQ6no
	GXrzYB4y2t/zT6CZPwHyNdOVjcBN6WXzzrOn7kn7nXtLlmuA9U8uLRROxfUw6vXOBnpvfs91My6hT
	qm7lv359eol5bph7H/zKBChzvHNeWnUli16gLtVHO6EX0JcVMsjQMk1T3GcQ1lNoPIuQnafGs3xUL
	yJ5VOS69w==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k3kqi-0004L7-UB; Thu, 06 Aug 2020 18:42:44 +0000
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]
 helo=us-smtp-1.mimecast.com)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k3kqd-0004Jq-LJ
 for linux-nvme@lists.infradead.org; Thu, 06 Aug 2020 18:42:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596739357;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=agVjEbJrRlx5VVgYFBKVfg0tL7lXWb3bc0Z0XxfvzUQ=;
 b=QMk7g3zjrlMdLCb52yLRd5DCGR/nF3g1EHU+0n2EoxxL9u5vDMmOnI7zSwxuH1Xzens/PS
 pnPaif6D/wY9ZShA5ND8XMR3FZEAUDRE3Rk8w6tnIRVbNYt8ZaO6UT/lcnclWY1zd12rgc
 e2Kze2/nzyFjs9pHfN8h9oKUGMYfHyk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-115-WVqEK9zoNjKrmA0ZkT8Qwg-1; Thu, 06 Aug 2020 14:41:01 -0400
X-MC-Unique: WVqEK9zoNjKrmA0ZkT8Qwg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0B1C4100AA23;
 Thu,  6 Aug 2020 18:40:59 +0000 (UTC)
Received: from localhost (unknown [10.18.25.174])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A11C4101E841;
 Thu,  6 Aug 2020 18:40:58 +0000 (UTC)
Date: Thu, 6 Aug 2020 14:40:58 -0400
From: Mike Snitzer <snitzer@redhat.com>
To: "Meneghini, John" <John.Meneghini@netapp.com>
Subject: Re: nvme-core: fix io interrupt when work with dm-multipah
Message-ID: <20200806184057.GA27858@redhat.com>
References: <20200728111956.GA31546@lst.de>
 <6df01884-5498-0809-b358-0c9f7d775a73@huawei.com>
 <20200729055903.GC31113@lst.de>
 <43e5dee8-1a91-4d8b-fdb5-91f9679ddeb3@huawei.com>
 <8d01b123-478f-f057-1598-8283dd099b03@huawei.com>
 <20200805152905.GB1982647@dhcp-10-100-145-180.wdl.wdc.com>
 <255d55e3-f824-a968-e478-3efeda095696@huawei.com>
 <20200806142625.GA3075319@dhcp-10-100-145-180.wdl.wdc.com>
 <729820BC-5F38-4E22-A83A-862E57BAE201@netapp.com>
 <E3390A8E-D582-47BA-A085-21663D883365@netapp.com>
MIME-Version: 1.0
In-Reply-To: <E3390A8E-D582-47BA-A085-21663D883365@netapp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=msnitzer@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200806_144239_730721_02DA1315 
X-CRM114-Status: GOOD (  22.43  )
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
Cc: Ewan Milne <emilne@redhat.com>, Christoph Hellwig <hch@infradead.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Chao Leng <lengchao@huawei.com>, Keith Busch <kbusch@kernel.org>,
 Hannes de <hare@suse.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, Aug 06 2020 at 12:17pm -0400,
Meneghini, John <John.Meneghini@netapp.com> wrote:

> On 8/6/20, 11:59 AM, "Meneghini, John" <John.Meneghini@netapp.com> wrote:
> 
>     Maybe translate to
>     >> BLK_STS_IOERR is also not suitable, we should translate
>     >> NVME_SC_CMD_INTERRUPTED to BLK_STS_AGAIN.
> 
> I think this depends upon what the error handling is up the stack for BLK_STS_IOERR.
> 
> What does DM do with BLK_STS_IOERR?

DM treats it as retryable.  See blk_path_error().

>     > BLK_STS_AGAIN is a bad choice as we use it for calls that block when
>     > the callers asked for non-blocking submission.  I'm really not sure
>     > we want to change anything here - the error definition clearly states
>     > it is not a failure but a request to retry later.
> 
> So it sounds like you may need a new BLK_STS error.   However, even if you add
> a new error, that's not going to be enough to communicate the CRDT or DNR 
> information up the stack.
>  
> } blk_errors[] = {
>         [BLK_STS_OK]            = { 0,          "" },
>         [BLK_STS_NOTSUPP]       = { -EOPNOTSUPP, "operation not supported" },
>         [BLK_STS_TIMEOUT]       = { -ETIMEDOUT, "timeout" },
>         [BLK_STS_NOSPC]         = { -ENOSPC,    "critical space allocation" },
>         [BLK_STS_TRANSPORT]     = { -ENOLINK,   "recoverable transport" },
>         [BLK_STS_TARGET]        = { -EREMOTEIO, "critical target" },
>         [BLK_STS_NEXUS]         = { -EBADE,     "critical nexus" },
>         [BLK_STS_MEDIUM]        = { -ENODATA,   "critical medium" },
>         [BLK_STS_PROTECTION]    = { -EILSEQ,    "protection" },
>         [BLK_STS_RESOURCE]      = { -ENOMEM,    "kernel resource" },
>         [BLK_STS_DEV_RESOURCE]  = { -EBUSY,     "device resource" },
>         [BLK_STS_AGAIN]         = { -EAGAIN,    "nonblocking retry" },
> 
>         /* device mapper special case, should not leak out: */
>         [BLK_STS_DM_REQUEUE]    = { -EREMCHG, "dm internal retry" },
> 
>         /* everything else not covered above: */
>         [BLK_STS_IOERR]         = { -EIO,       "I/O" },
> };
> 

We've yet to determine how important it is that the target provided
delay information be honored...

In any case, NVMe translating NVME_SC_CMD_INTERRUPTED to BLK_STS_TARGET
is definitely wrong.  That conveys the error is not retryable (see
blk_path_error()).

Shouldn't NVMe translate NVME_SC_CMD_INTERRUPTED to BLK_STS_RESOURCE or
BLK_STS_DEV_RESOURCE?

DM will retry immediately if BLK_STS_RESOURCE is returned.
DM will delay a fixed 100ms if BLK_STS_DEV_RESOURCE is used.

(Ming said BLK_STS_RESOURCE isn't Linux specific and can be used by
drivers)


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
