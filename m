Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7D29C00140
	for <linux-nvme@archiver.kernel.org>; Tue, 26 Jul 2022 20:44:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=S9ujFLos5ZzJxtOwNJ6RW4VbMsZaGWDEjqBa6k1DQP4=; b=EUZ9YrSRsEXtmhje24atXkyCFg
	D9qwbf3z2ys2M9aU3n/xxAcJm5IvOMZTROcTPg2bOIoeQUguyFDGwo4rUT6o23N1jJUSNv+J7NNu4
	RT1oivrtqU/zac0YdzAeofwDRoKxP8dcDcQxw4qXVHyVFxc6BRgJBj+4h3/jSuTI22oZjFytmel11
	G/NaDDGCWQeqn2Ca/AK/Azz8MTTMRju7rdDqiVGtvMgxGv+tzAST6dxvL6pHoLgr3CEhibYIHEt54
	K3y9fgKHn60tlE0M9nZ8KyuTbHfN9OhsNbhtYdmQRTVjGX4TbwwPGrECqsGubXh5ArgJkRQfjX/0i
	Fes3YqHg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oGRPY-003SPm-I6; Tue, 26 Jul 2022 20:44:12 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oGRPU-003SJp-RE
	for linux-nvme@lists.infradead.org; Tue, 26 Jul 2022 20:44:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1658868246;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=S9ujFLos5ZzJxtOwNJ6RW4VbMsZaGWDEjqBa6k1DQP4=;
	b=hPxowChmxF+tiUySQcnqesn8W0o75AHVfLpVtH9flIyVucxKUtJpv0hEbxhgeilwF1Mx0w
	FJ+vL1PLRwJC7oXDeCcKEAusSyNHZNofXYCefDVKVr0U7yN9+xf5WrpwxoCB2hxIBfZZaQ
	49Vsxe4s/cy03FX0fHZUjiBEZnC1Qf4=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-516-VNrhuQ2iNfis1ZExBtZWvA-1; Tue, 26 Jul 2022 16:42:29 -0400
X-MC-Unique: VNrhuQ2iNfis1ZExBtZWvA-1
Received: by mail-pg1-f197.google.com with SMTP id f128-20020a636a86000000b0041a4b07b039so6760236pgc.5
        for <linux-nvme@lists.infradead.org>; Tue, 26 Jul 2022 13:42:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=S9ujFLos5ZzJxtOwNJ6RW4VbMsZaGWDEjqBa6k1DQP4=;
        b=nnYLsXKhj0XJjVNMWXqUwdhSDnyejmb4I9QwwNW90O8mtEoQRRFqT2GSx7jMnHkbXB
         yG/xCJMufR0AlCXWK/jbKzhJn0Je0SwQEn6oe5YNH20U8jVmzAIqZ3vwMc6ufqcNUpVf
         IhNxknmxGgWYZIF7S1IZrxpys6i4h/MAAV+AZ0H4SQnqsZHklMl79GYS3/hxE7+RMgV3
         jwhRVSu3Q7hr3wt16kzqUhh2nnr2iAp+AmFZomMJvnfUW9x1OmR03Shd5f+6EHN88JDS
         7EgIw+wBBwWAss9BJyaX9Lf4WIGwaGVoqt+xNA1GQgHOqYj+U1hgYuDWqjRagnive4GW
         ysNw==
X-Gm-Message-State: AJIora+LNGl95qkwop3OxCOlV0XunsGO8HT5/z6UB8VIFFaiqWmVV3jw
	QGg26qqoN6jGUs9KIXuUVWhfE6WbZUnIT/w+eyw+KVQdNnmI5FCJXP2ExWHX+kt2jKX+KGblg57
	FBTouMah5nLhEVQ1qwEar9g47ba3TOvpsoJ1TQUntoNg=
X-Received: by 2002:a63:eb03:0:b0:412:b1d6:94ca with SMTP id t3-20020a63eb03000000b00412b1d694camr16162681pgh.468.1658868147989;
        Tue, 26 Jul 2022 13:42:27 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1taichG0/zwmNKzU5lA5kit8aXjZ0n1scRvQ1bALjyZQiEbyg1QQO8CMQIqjKYrEqVjb5L9EkAaP40jMsUrYOU=
X-Received: by 2002:a63:eb03:0:b0:412:b1d6:94ca with SMTP id
 t3-20020a63eb03000000b00412b1d694camr16162661pgh.468.1658868147752; Tue, 26
 Jul 2022 13:42:27 -0700 (PDT)
MIME-Version: 1.0
References: <20220721003358.543509-1-ming.lei@redhat.com> <Yt6DJBRXyGXbShIF@T590>
 <20220726111338.GA32638@lst.de>
In-Reply-To: <20220726111338.GA32638@lst.de>
From: Ewan Milne <emilne@redhat.com>
Date: Tue, 26 Jul 2022 16:42:16 -0400
Message-ID: <CAGtn9rn7NvOo8iCg=KV+Q78b1MNyE878RvghkOQYjcBS4LPZ+A@mail.gmail.com>
Subject: Re: [PATCH] nvme-fc: restart admin queue if the caller needs to
 restart queue
To: Christoph Hellwig <hch@lst.de>
Cc: Ming Lei <ming.lei@redhat.com>, linux-nvme@lists.infradead.org, 
	Chaitanya Kulkarni <chaitanyak@nvidia.com>, Sagi Grimberg <sagi@grimberg.me>, 
	Keith Busch <kbusch@kernel.org>, James Smart <james.smart@broadcom.com>
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=emilne@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220726_134408_992837_DE949229 
X-CRM114-Status: GOOD (  13.57  )
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

I have a reproducible test case, FWIW.  (It requires extra kernel code
to inject ERSP_IU errors though).
If you get an error at the wrong time when issuing commands e.g. in
nvme_init_ctrl_finish() it ends up
with a command on the admin queue and the admin queue quiesced.

-Ewan

On Tue, Jul 26, 2022 at 7:13 AM Christoph Hellwig <hch@lst.de> wrote:
>
> On Mon, Jul 25, 2022 at 07:48:52PM +0800, Ming Lei wrote:
> > Hello Guys,
> >
> > Ping...
>
> I'm waiting for a review from James, who apparently just got back from
> his vacation.
>


