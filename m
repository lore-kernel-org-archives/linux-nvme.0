Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73914C3A5A7
	for <linux-nvme@archiver.kernel.org>; Tue,  6 Dec 2022 16:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:In-Reply-To:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6ge3pwq/JlMlTkSjEGqqkwIK42+btCPQr7/pr8xaxyc=; b=l0a6qDeNPUwBzeMCc3NMoBx0PF
	1V1gKW1eYBe6h8kDKJwDu82KIa+QubHDrpoj1LbbemrQ3pXs2MU9YnsmhSkRxFWw3xS+5MYCbJ7BM
	vwPzrBNzT/jpX2Bh6bqSQNedqkLNpvuy8Q0tP7K7XZrQckb6KL7ZHVGgUJLGzXViWGzVZKiRtatS+
	KxrLlx+bCpVpsopQ5KuLizH1g/IglRfjKjaN8+T6eGdoMWgD3OO+00H+yKtsoZ+KlF9lPdHTInaSR
	/Z6ykYGSMQ1Ijd3fxKinUqxKWGjlXCJcAvd3j5YnMT5qdvvb6UYMPqU0o4dhqdfXrqnfi57+ae3G7
	lp+RdlYQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p2azT-00F9h3-Va; Tue, 06 Dec 2022 16:40:20 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p2azQ-00F9Z3-QH
	for linux-nvme@lists.infradead.org; Tue, 06 Dec 2022 16:40:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1670344815;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6ge3pwq/JlMlTkSjEGqqkwIK42+btCPQr7/pr8xaxyc=;
	b=Xk47YCMHQFcecOb0gDIVywpoGugGseEWcbMtyQf9hpgy4eZKBSwDADF8AQ8a/nh2IICS8o
	c7nSS1s3tSksn3m5ec0lcfOrfHtIXiOQwvEf5J8Wuf0uP++tI0XQqKV16kA0SR10fNgjHm
	abIYC7MeOM0kJdec3qeJKNT4WHT2yWQ=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-639-n3syOv7WOniJvnxcW_8EZA-1; Tue, 06 Dec 2022 11:40:14 -0500
X-MC-Unique: n3syOv7WOniJvnxcW_8EZA-1
Received: by mail-wr1-f69.google.com with SMTP id d6-20020adfa346000000b0024211c0f988so3354045wrb.9
        for <linux-nvme@lists.infradead.org>; Tue, 06 Dec 2022 08:40:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6ge3pwq/JlMlTkSjEGqqkwIK42+btCPQr7/pr8xaxyc=;
        b=sB9izkbE9G3NBzvDOtBBgz9fR0Q3yU7CRCX0jbQqd5aw6BDyp9CBERDu4Yx4HWZJwd
         D9532Wwr3bxkCPiu/N/cUnkT2pkPbHsJqIXPr8CQyWwZL5CBwumOQasumgs2J5yXZFCs
         +lVzKW64NeEZwtQZ8R9i8i7KP0DCh9CqlXq4dyAFRfAwI7bmKZ8aX4efiBEARgeGrRlK
         PutmCEEOGdiDENm3TPwi3Q0JGuvzw5NIkKQe6eWtSVkSGJH9y5nGm1L3SbfzgMb0K4ee
         IqwX2kTF4tGWMnWrvUFFA0rg8djr2K4LhfRKcmECAOBz4vAZ6CTnAJ0pvEuu8A5uuerT
         vbtw==
X-Gm-Message-State: ANoB5pk2G5zIiKKSXxnOg7XqT4QymzxHSJKwrqVd2NMl42Mui/zFTaBK
	1EI28q5Vt6GtxX/YibLCISZN65+oUclUO67qUQMCb99mdQEJz6kH110m3Vx1TkNvClq1dkh9+2I
	3kUVstQ5ZpQTVlcg+6A0Yy56O7+k=
X-Received: by 2002:a05:600c:43d6:b0:3cf:a856:ba2f with SMTP id f22-20020a05600c43d600b003cfa856ba2fmr54374400wmn.37.1670344813013;
        Tue, 06 Dec 2022 08:40:13 -0800 (PST)
X-Google-Smtp-Source: AA0mqf4NVS4Nr5mwzewnBswh2mp5LN3uIb1H6IjnbaF2zAiGYSd8n0GAdY9XUcgUa+xExhq9zeGgKw==
X-Received: by 2002:a05:600c:43d6:b0:3cf:a856:ba2f with SMTP id f22-20020a05600c43d600b003cfa856ba2fmr54374381wmn.37.1670344812837;
        Tue, 06 Dec 2022 08:40:12 -0800 (PST)
Received: from redhat.com ([109.253.207.7])
        by smtp.gmail.com with ESMTPSA id h20-20020a05600c351400b003c6cd82596esm29427965wmq.43.2022.12.06.08.40.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Dec 2022 08:40:12 -0800 (PST)
Date: Tue, 6 Dec 2022 11:40:06 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Alvaro Karsz <alvaro.karsz@solid-run.com>,
	virtualization@lists.linux-foundation.org,
	linux-block@vger.kernel.org, dm-devel@redhat.com,
	linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
	Jason Wang <jasowang@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>, Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH v3] virtio_blk: add VIRTIO_BLK_F_LIFETIME feature support
Message-ID: <20221206113744-mutt-send-email-mst@kernel.org>
References: <20221205162035.2261037-1-alvaro.karsz@solid-run.com>
 <Y49ucLGtCOtnbM0K@fedora>
MIME-Version: 1.0
In-Reply-To: <Y49ucLGtCOtnbM0K@fedora>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221206_084017_037661_A3D2E9B4 
X-CRM114-Status: GOOD (  17.71  )
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

On Tue, Dec 06, 2022 at 11:31:44AM -0500, Stefan Hajnoczi wrote:
> On Mon, Dec 05, 2022 at 06:20:34PM +0200, Alvaro Karsz wrote:
> 
> I don't like that the ioctl lifetime struct is passed through
> little-endian from the device to userspace. The point of this new ioctl
> is not to be a passthrough interface. The kernel should define a proper
> UABI struct for the ioctl and handle endianness conversion. But I think
> Michael is happy with this approach, so nevermind.
> 
> > @@ -219,4 +247,8 @@ struct virtio_scsi_inhdr {
> >  #define VIRTIO_BLK_S_OK		0
> >  #define VIRTIO_BLK_S_IOERR	1
> >  #define VIRTIO_BLK_S_UNSUPP	2
> > +
> > +/* Virtblk ioctl commands */
> > +#define VBLK_GET_LIFETIME	_IOR('r', 0, struct virtio_blk_lifetime)
> 
> Does something include <linux/ioctl.h> for _IOR()? Failure to include
> the necessary header file could break userspace applications that
> include <linux/virtio_blk.h>.
> 
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

Good point. I think it's preferable to add a new header
for this stuff. virtio_blk_ioctl.h ? Have that pull in linux/ioctl.h
Also VIRTIO_BLK_IOCTL_GET_LIFETIME
might be a better name to avoid confusion and collisions.
And s/Virtblk/virtio-blk/

-- 
MST


