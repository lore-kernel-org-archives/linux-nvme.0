Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EECA3F99C79
	for <linux-nvme@archiver.kernel.org>; Sat, 18 Apr 2026 11:37:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=L7bwugRpccIipnAdTLaiDh6Aizt/AO7kL9dxWFVM0g4=; b=PVX/5Rc4jVAR0BXbJo09wYFvW0
	/vViCsZ36Ue2zn9W+uXgrEgWUY6gm5XBTlTr8/1RO/VTvSM84st/jba0l/ElLjhB4WrgwWOpEahUp
	cbWbga+GfU/IzxIY1e0EbpFyRAebXHA8NQ7gFfat7+dXDObA3XJ02yAbX9qQ92C4IbylFnTw8VYIx
	P1ofSIaMbP+HNClpX+6RU0TqruQ3pZN4Re8l36l1M9pB+xusGNmCVGXQL6FKb1MX39jFmoFj6Ilh1
	s5i9WE8tE9tiAQJsi5FR2vdC2YpHeKgdk76NDU36dL3K17HWPld3TLI7jln/ISjlexDaoFifK/+tj
	Z3y6DEdQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wE3zG-00000004wne-475T;
	Sat, 18 Apr 2026 11:37:23 +0000
Received: from out-172.mta0.migadu.com ([2001:41d0:1004:224b::ac])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wE3zD-00000004wms-4BBv
	for linux-nvme@lists.infradead.org;
	Sat, 18 Apr 2026 11:37:21 +0000
Date: Sat, 18 Apr 2026 13:36:58 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1776512223;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=L7bwugRpccIipnAdTLaiDh6Aizt/AO7kL9dxWFVM0g4=;
	b=UBdWe1dExc+zfAuPmB/aknQFrw1Xii++JamXUDteqE21FqHPUIOl5EE/sMngLL+GxM0x3D
	dhe0P5nCqAczfOp06+iVbHTchz/ZZ/xK2lk6zu/QriU0p1vM5KuBZXQLkbmBBeL/pESLnM
	YnTu169idUl6iHl+EI9zhMAjhWa5/50=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Hannes Reinecke <hare@suse.de>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	stable@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] nvme-auth: Don't log shared secret in
 nvme_auth_dhchap_exponential()
Message-ID: <aeNs2pNRuex8JH8q@linux.dev>
References: <20260303190350.78705-2-thorsten.blum@linux.dev>
 <655d293e-51ce-4e24-93d1-587480d0680f@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <655d293e-51ce-4e24-93d1-587480d0680f@suse.de>
X-Migadu-Flow: FLOW_OUT
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260418_043720_518561_E5792052 
X-CRM114-Status: GOOD (  14.52  )
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

On Wed, Mar 04, 2026 at 08:17:03AM +0100, Hannes Reinecke wrote:
> On 3/3/26 20:03, Thorsten Blum wrote:
> > When debug logging is enabled, nvme_auth_dhchap_exponential() logs the
> > DHCHAP shared secret. Remove the log to avoid exposing key material.
> > 
> > Fixes: b61775d185a3 ("nvme-auth: Diffie-Hellman key exchange support")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> > ---
> >   drivers/nvme/host/auth.c | 2 --
> >   1 file changed, 2 deletions(-)
> > 
> > diff --git a/drivers/nvme/host/auth.c b/drivers/nvme/host/auth.c
> > index 405e7c03b1cf..5e4df2ac3cc0 100644
> > --- a/drivers/nvme/host/auth.c
> > +++ b/drivers/nvme/host/auth.c
> > @@ -655,8 +655,6 @@ static int nvme_auth_dhchap_exponential(struct nvme_ctrl *ctrl,
> >   		chap->status = NVME_AUTH_DHCHAP_FAILURE_INCORRECT_PAYLOAD;
> >   		return ret;
> >   	}
> > -	dev_dbg(ctrl->device, "shared secret %*ph\n",
> > -		(int)chap->sess_key_len, chap->sess_key);
> >   	return 0;
> >   }
> 
> Yeah, that was primarily for debugging.
> 
> Reviewed-by: Hannes Reinecke <hare@suse.de>

This was never applied, was it?

Thanks,
Thorsten

