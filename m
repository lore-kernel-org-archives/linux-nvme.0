Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A03C9F8D759
	for <linux-nvme@archiver.kernel.org>; Thu, 16 Apr 2026 15:27:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:In-Reply-To:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vFY8emkWvh+CcCvc2Sq9jqOrMYd8LQx+4a873ps+EKA=; b=24QPwRnLxWtatK4bkd1k2RBimB
	7bDyIcT6pC9oLJwxMh1eCgo233q0if5zT0JK6p72b/qU5/0DnwPCJHTmT3fxH3FFY7zjjPvgWVEin
	paQ+FigWsRv1/ktXLOAUSfF6K+TSZf6x4h9WUK4Vh1XLUOTg1+SAsEdafeMQc1pjkfmKO1gGU5S0B
	4TU6OGVUbM3V7Xt9ofgME8gy2GYMp/Ef8Opzs6aRS2ZsDQ9YSAnIf/a9Po2MYBKUMNVw+19q9wKqR
	A8/hzZxrsSJSXOUNlybqvD0dtW8dO1AYNmDunRyUjwLMYS/01wu75ahn2t52+2mO6vXDi6/vgTwkJ
	QeafHetw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wDOdA-00000002caa-1POj;
	Thu, 16 Apr 2026 15:27:48 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wDOd7-00000002caF-1ynD
	for linux-nvme@lists.infradead.org;
	Thu, 16 Apr 2026 15:27:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776353264;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vFY8emkWvh+CcCvc2Sq9jqOrMYd8LQx+4a873ps+EKA=;
	b=HbB6oiE9iql50JUwThUd7v99LbzSr3pqDkioHgjZCM1aVBnK1sj6LYFcHSMjF57FEyNx9q
	L1XOc4lKe+TxFJ2t64vfemS9hd21Dp36QTrSHwylPTgTV2a2pUuX1jyLpwBw2ghiHOp5WE
	V+gxctJ99w/FvJpKkqeOI/icF8844Ys=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-154-RD7OP0XxOxWsppgXoN-JIw-1; Thu,
 16 Apr 2026 11:27:42 -0400
X-MC-Unique: RD7OP0XxOxWsppgXoN-JIw-1
X-Mimecast-MFC-AGG-ID: RD7OP0XxOxWsppgXoN-JIw_1776353260
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3F2E11955F07;
	Thu, 16 Apr 2026 15:27:40 +0000 (UTC)
Received: from rhel-developer-toolbox-latest (unknown [10.2.16.224])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 46A7530001A4;
	Thu, 16 Apr 2026 15:27:36 +0000 (UTC)
Date: Thu, 16 Apr 2026 08:27:35 -0700
From: Chris Leech <cleech@redhat.com>
To: Hannes Reinecke <hare@suse.de>
Cc: alistair23@gmail.com, hch@lst.de, sagi@grimberg.me, kch@nvidia.com, 
	kbusch@kernel.org, linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
	yi.zhang@redhat.com, mlombard@arkamax.eu, linux-block@vger.kernel.org, 
	shinichiro.kawasaki@wdc.com, Alistair Francis <alistair.francis@wdc.com>
Subject: Re: [PATCH] nvmet-tcp: Ensure old keys are freed before replacing
 new ones
Message-ID: <20260416-landlord-encounter-c93f2733de5f@redhat.com>
References: <20260415230250.2783414-1-alistair.francis@wdc.com>
 <959f800d-b92e-406e-a174-680fb09c884e@suse.de>
MIME-Version: 1.0
In-Reply-To: <959f800d-b92e-406e-a174-680fb09c884e@suse.de>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-MFC-PROC-ID: gamTQuCaV1djB0WlaGBshTXYAhOo-KgcXfQM6A3u9EM_1776353260
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260416_082745_582184_7B1F7348 
X-CRM114-Status: GOOD (  33.22  )
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

On Thu, Apr 16, 2026 at 08:16:14AM +0200, Hannes Reinecke wrote:
> On 4/16/26 01:02, alistair23@gmail.com wrote:
> > From: Alistair Francis <alistair.francis@wdc.com>
> > 
> > Previously after the host sends a REPLACETLSPSK we freed the TLS keys as
> > part of calling nvmet_auth_sq_free() on success. A recent change ensured
> > we don't free the keys, allowing REPLACETLSPSK to work.
> > 
> > But that fix results in a kernel memory leak when running
> > 
> > ```
> > nvme_trtype=loop ./check nvme/041 nvme/042 nvme/043 nvme/044 nvme/045 nvme/051 nvme/052
> > echo scan > /sys/kernel/debug/kmemleak
> > cat /sys/kernel/debug/kmemleak
> > ```
> > 
> > We can't free the keys on a successful DHCHAP operation, otherwise the
> > next REPLACETLSPSK will fail, so instead let's free them before we
> > replace them as part of nvmet_auth_challenge().
> > 
> > This ensures that REPLACETLSPSK works, while also avoiding any memory
> > leaks.
> > 
> > Fixes: 2e6eb6b277f59 ("nvmet-tcp: Don't free SQ on authentication success")
> > Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> > ---
> >   drivers/nvme/target/fabrics-cmd-auth.c | 7 +++++++
> >   1 file changed, 7 insertions(+)
> > 
> > diff --git a/drivers/nvme/target/fabrics-cmd-auth.c b/drivers/nvme/target/fabrics-cmd-auth.c
> > index b9ab80c7a6941..58185184478a4 100644
> > --- a/drivers/nvme/target/fabrics-cmd-auth.c
> > +++ b/drivers/nvme/target/fabrics-cmd-auth.c
> > @@ -412,6 +412,13 @@ static int nvmet_auth_challenge(struct nvmet_req *req, void *d, int al)
> >   	int hash_len = nvme_auth_hmac_hash_len(ctrl->shash_id);
> >   	int data_size = sizeof(*d) + hash_len;
> > +	/*
> > +	 * If replacing the keys then we have previous successful keys
> > +	 * that might be leaked, so we need to free them here.
> > +	 */
> > +	if (req->sq->dhchap_c1)
> > +		nvmet_auth_sq_free(req->sq);
> > +
> >   	if (ctrl->dh_tfm)
> >   		data_size += ctrl->dh_keysize;
> >   	if (al < data_size) {
> I am not sure.
> The authentication variables should be freed as soon as the authentication
> completes; the session key is ephemeral and
> should not be stored longer than necessary and will _never_
> be used again once authentication completes.
> The TLS key, OTOH, is used throughout the session and needs
> to be present while the session is active
> As such, both sets have vastly different lifetimes, and
> I would argue that this
> 
> void nvmet_auth_sq_free(struct nvmet_sq *sq)
> {
> 	cancel_delayed_work(&sq->auth_expired_work);
> #ifdef CONFIG_NVME_TARGET_TCP_TLS
> 	sq->tls_key = NULL;
> #endif
> 	kfree(sq->dhchap_c1);
> 	sq->dhchap_c1 = NULL;
> 
> is actually wrong as we should not modify 'tls_key' here.

I agree with Hannes, and was just about to respond with the same
feedback.  I think the freeing of the auth temporaries needs to be
returned to fix the memleak, and the real problem is the setting of
tls_key to NULL.  That doesn't seem like the right lifetime for tls_key,
and it looks to be a reference count leak as well.

Is the presence of sq->tls_key the best check to see if the socket is
currently in a kTLS mode?  (it might be, I'm not as up on the target
code)

- Chris


