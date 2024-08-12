Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22AB4C52D7C
	for <linux-nvme@archiver.kernel.org>; Mon, 12 Aug 2024 14:59:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:In-Reply-To:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5Q2tOiS7qzuYZ0xQTI2GQl0PMGIuYPn8zH8yOqVwH3M=; b=HkcT+6YWCx0itYofT+vL6oIJk0
	T0FsXMgm8ccOrLaurqdf4yfJmhDAw/FvX/hK/fVoMpkay+XKAM5DNpWIIsV+sKdDNz+CKzJXv9oNu
	BgyYwslOSU0VC5bjFHuUrlhhQI9cPd2tzhlMWApqEjt1t47JWQZybjlilCj3xUIspj0SWtEatjOwU
	2P6cbwuf9Q9wBjGzysrYjk9nvTfIlLK5HvzhEYzPfjNpCBdZRqn72jVhuotpMtJb7wajPpD5DcSGu
	/bgsum/VuWcS6Zmao/7erTOg7io3+XCFVVhO0+BO9+kUEcSix4acdbxCz43UUK+YArEGNkQuAQfh0
	I/mTaMiA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sdWWS-00000000f5U-3HKk;
	Mon, 12 Aug 2024 14:59:48 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sdWWP-00000000f3u-3XGR
	for linux-nvme@lists.infradead.org;
	Mon, 12 Aug 2024 14:59:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723474781;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5Q2tOiS7qzuYZ0xQTI2GQl0PMGIuYPn8zH8yOqVwH3M=;
	b=dLKLVordaVLA6bPBXt96PkcvpcaozTcRgyH0FjtJPyVFIzXNoJ3A0mPRRK2kyko58IEzxe
	ylwnpCWnATsXpspMtmQ+kTJIwbI1DPGBtDswT18iSHEQ+I6+/g8XWBdczAPXkZqkaYtPBF
	UEw6hx48eHl+QDKza+k49yZ9zmF3ZXQ=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-393-HiaSUBYQPTSOu0g63A0qUw-1; Mon,
 12 Aug 2024 10:59:35 -0400
X-MC-Unique: HiaSUBYQPTSOu0g63A0qUw-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D34BC1955F65;
	Mon, 12 Aug 2024 14:59:33 +0000 (UTC)
Received: from fedora (unknown [10.72.116.46])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0A6341955D72;
	Mon, 12 Aug 2024 14:59:27 +0000 (UTC)
Date: Mon, 12 Aug 2024 22:59:22 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Hannes Reinecke <hare@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org, Sagi Grimberg <sagi@grimberg.me>,
	Mark O'Donovan <shiftee@posteo.net>,
	Changhui Zhong <czhong@redhat.com>
Subject: Re: [PATCH] nvme: move stopping keep-alive into nvme_uninit_ctrl()
Message-ID: <ZrojSva2rQXY+CT+@fedora>
References: <20240809135427.378953-1-ming.lei@redhat.com>
 <17cbd822-daae-4954-b184-974432ca2fe1@suse.de>
MIME-Version: 1.0
In-Reply-To: <17cbd822-daae-4954-b184-974432ca2fe1@suse.de>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240812_075945_974966_9BC3D64F 
X-CRM114-Status: GOOD (  22.51  )
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

On Mon, Aug 12, 2024 at 01:56:01PM +0200, Hannes Reinecke wrote:
> On 8/9/24 15:54, Ming Lei wrote:
> > Commit 4733b65d82bd ("nvme: start keep-alive after admin queue setup")
> > moves starting keep-alive from nvme_start_ctrl() into
> > nvme_init_ctrl_finish(), but don't move stopping keep-alive into
> > nvme_uninit_ctrl(), so keep-alive work can be started and keep pending
> > after failing to start controller, finally use-after-free is triggered if
> > nvme host driver is unloaded.
> > 
> > This patch fixes kernel panic when running nvme/004 in case that connection
> > failure is triggered, by moving stopping keep-alive into nvme_uninit_ctrl().
> > 
> > This way is reasonable because keep-alive is now started in
> > nvme_init_ctrl_finish().
> > 
> > Fixes: 4733b65d82bd ("nvme: start keep-alive after admin queue setup")
> > Cc: Hannes Reinecke <hare@suse.de>
> > Cc: Mark O'Donovan <shiftee@posteo.net>
> > Reported-by: Changhui Zhong <czhong@redhat.com>
> > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > ---
> >   drivers/nvme/host/core.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> > index 053d5b4909cd..562afa71ea85 100644
> > --- a/drivers/nvme/host/core.c
> > +++ b/drivers/nvme/host/core.c
> > @@ -4612,7 +4612,6 @@ void nvme_stop_ctrl(struct nvme_ctrl *ctrl)
> >   {
> >   	nvme_mpath_stop(ctrl);
> >   	nvme_auth_stop(ctrl);
> > -	nvme_stop_keep_alive(ctrl);
> >   	nvme_stop_failfast_work(ctrl);
> >   	flush_work(&ctrl->async_event_work);
> >   	cancel_work_sync(&ctrl->fw_act_work);
> 
> Huh? What happened here?
> Commit 4733b65d82bd ("nvme: start keep-alive after admin queue setup")
> has _exactly_ the same hunk.
> Someone else must've changed it afterwards, so please update the 'fixes'
> tag to refer to the correct commit.

It is exactly 4733b65d82bd ("nvme: start keep-alive after admin
queue setup"), which moves nvme_start_keep_alive() into
nvme_init_ctrl_finish(), but not move nvme_stop_keep_alive() to
nvme_uninit_ctrl().


Thanks,
Ming


