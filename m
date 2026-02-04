Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AA6EE8B386
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Feb 2026 01:14:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xjBRAILllbiil6uqa4uIRKWQgWlKn8ntrdvr6J4sf/I=; b=BgiTf+q7XigGlNtHZBYbj2dlNp
	clxgkRdjk941hHhR1Wfbzmi/6w+aZvIW5xEmlBSQj1HTP12BpVesGTI9r+KIkn7lQrF/ai8CxOXsk
	rOhett0cBOTu9f/Lyi01vPfYvKxxL2q06NRO/SuHq2c9CR4vlyFQDaGYxQ9CTD50wOl6B0aCY+41d
	NxrmacgfJEv1m7Tjhryofvj7ZdGtZ8fr8i/Lte3147sMohDtorS7UpeKEik/WbepxYa7E2VHcog4x
	DF1jhxM7efWkbeaMAhDjEyBCKfVzbQR/3gJl5+GLBi8Zst9hraUacCJtKx/gGvyi/KzYNTyDtRanp
	DGDObngA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vnRTJ-00000007fpg-2zIn;
	Wed, 04 Feb 2026 01:14:21 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vnRTF-00000007fpL-3gfq
	for linux-nvme@lists.infradead.org;
	Wed, 04 Feb 2026 01:14:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770167656;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xjBRAILllbiil6uqa4uIRKWQgWlKn8ntrdvr6J4sf/I=;
	b=BxD6ahImDD/Ao6NH0fLjyXC8JP2mmfY0LMZJOobyjp+LFZjVepUoj4toUATPNq5+/xOJdU
	mL8wWRZRXGnBX5TWD+I/wpmb2IRYqXSz78dmNmfyhkE27j0Vb14gCv3E9Joo8gR/V2PWHy
	Lv8yP969zX+mx4/ceiDhlOloOl7LVbE=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-590-KSNMtdGmMBKhM-Cfzgz2eA-1; Tue,
 03 Feb 2026 20:14:12 -0500
X-MC-Unique: KSNMtdGmMBKhM-Cfzgz2eA-1
X-Mimecast-MFC-AGG-ID: KSNMtdGmMBKhM-Cfzgz2eA_1770167651
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3A99C180034F;
	Wed,  4 Feb 2026 01:14:11 +0000 (UTC)
Received: from fedora (unknown [10.72.116.35])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7EABE1800109;
	Wed,  4 Feb 2026 01:14:07 +0000 (UTC)
Date: Wed, 4 Feb 2026 09:14:02 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Hannes Reinecke <hare@suse.de>
Cc: lsf-pc <lsf-pc@lists.linux-foundation.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [LSF/MM/BFP TOPIC] Block-layer device resets
Message-ID: <aYKdWsdnSVrZ3UC7@fedora>
References: <50ee77fa-0c44-422e-9ee2-eece60b189e1@suse.de>
 <aYFoBafih46bLK0T@fedora>
 <65937263-912c-4250-af26-054b2b6be72b@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <65937263-912c-4250-af26-054b2b6be72b@suse.de>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260203_171417_985118_5BE3B1F4 
X-CRM114-Status: GOOD (  18.81  )
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

On Tue, Feb 03, 2026 at 06:51:25AM +0100, Hannes Reinecke wrote:
> On 2/3/26 04:14, Ming Lei wrote:
> > Hi Hannes,
> > 
> > On Sun, Feb 01, 2026 at 06:06:52PM +0100, Hannes Reinecke wrote:
> > > Hi all,
> > > 
> > > We are currently working on implementing cross-controller resets for
> > > NVMe, which requires to send a command to the target which then should
> > > terminate all commands on a given controller.
> > 
> > Can you provide a little background why this reset is required? And for
> > solve which problem?
> > 
> Sure. It got triggered by me wanting to use a ublk device as a backing
> device for nvmet namespace.

ublk supports it, either delete & re-add the disk or use UBLK_F_USER_RECOVERY &
UBLK_F_QUIESCE for keeping disk node.

> During a nvme reconnect the target is supposed to abort/flush all
> outstanding commands on the backing device. As this is a block device
> we would need to have an interface into the block layer allowing us
> to do so.

It could be hard to provide such generic(ioctl) block interface:

1) use queue freeze

- hang risk, because some or many block devices don't implement timeout or
error handling

2) use queue quiesce

- still need driver cooperation for draining the inflight IOs

Basically the hard part is in driver side.

Thanks,
Ming


