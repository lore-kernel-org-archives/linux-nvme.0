Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64E70CFA466
	for <linux-nvme@archiver.kernel.org>; Mon, 24 Nov 2025 13:38:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fGnf1zvNYnk55vDoYwHQmt5WFO2pnbA0Jle9HXGkL5k=; b=BTp1yp6GBCXAod/ZI27ib7603O
	7Hoh/MPKGDJkYhZSQHStU5/3LEmii5Zk3V4AOS+Jb5ub+Df41r03vHQlhnawwhaifvfyL2JvwUhs1
	Y4rmH8EYVj9PCfpqH1mU4cSjeVcsaezdPKAbGKQ0GKXrJ3ZreGlG6HnJiSQvbfWWHPjSswKVnps1Z
	DWT9votryaHFaNX1zAu7QIuTisz9giG1GIaGr91m1fXY1vBYY95TQwF06RcUwr7dmjzjzsVwhLDuL
	0SGkDyuMD6HmnmY0FDijxK8kV/ZFLEtlBldMqejlXBSX8HwKfyBE6b/0wjtfy+loodt/TJH+P6evt
	EuEnB/MA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vNWmP-0000000BlVO-3S5c;
	Mon, 24 Nov 2025 13:38:57 +0000
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vNWmN-0000000BlUs-2jy8
	for linux-nvme@lists.infradead.org;
	Mon, 24 Nov 2025 13:38:56 +0000
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-64165cd689eso5577680a12.0
        for <linux-nvme@lists.infradead.org>; Mon, 24 Nov 2025 05:38:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763991534; x=1764596334; darn=lists.infradead.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fGnf1zvNYnk55vDoYwHQmt5WFO2pnbA0Jle9HXGkL5k=;
        b=KHjnF0d5TGrIxyzNeJcQSWQXG3cMzqyTcGC62jmQJPsgAZi3IoIJaKnMGiBg27jqFA
         5p5tNQb7EC4oTjyo2RkDn8Jw1lP0t/n+Ic3Ear0+IAQEwZBk4HGpmIIqxJSTu4QmtfQh
         eRpRprt5oBTqBeSK2EHMaN+BnO+137FUvsfdRM7JkDJNi/Kq+R/KYIf8roSu1Ud9j90O
         MqapwiOWY3oenmy9vUVmx9CUENwFBBu4zcxYF3c92SHICUpd8CMbc23+cBXZV7dHFEmi
         LH0F+kdP2mSdTw1BhkWNVccWNqkMmjrpS/sOZ0vHyS99RMYb5UKTCML0I+F+DTdFKrQl
         vR9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763991534; x=1764596334;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fGnf1zvNYnk55vDoYwHQmt5WFO2pnbA0Jle9HXGkL5k=;
        b=DQVQ52Ia2//W7sdWiJgfmO4Vb+3rZkSMhQlTj+ghy/17hUvQr+hxdKO5pTGtYoqlBf
         LBVx8hzjF50ic9YDzZaoTf+w+s0uR5bd189P0uKBgVKp8fT/CxzCgsB7DNPycX6wrDKT
         23cWYCTUrlYN8N7l53h2mVU/06MPgVejOWmklrTHAYHRaNnEenz3xj8gfCdq5NoZ98rR
         KME09GmsRjbJhx1p+9aYw+LTiepjAXMh/0ddQuT/MIaNilWwylMmX6loq8P4gwcoQlPW
         XJll76hIqwBZw/peThofnw9Rufb0wupl0d+Ts5kIy996gMRtX7h68GnNV9YeFYqqCuNp
         5vjQ==
X-Forwarded-Encrypted: i=1; AJvYcCVpa2AVcpwTdz3bgeV7w3ouVbh9kLh7UNYQ/O8JYwLGl/mwm+eFhESsMHh/DTVprwKCcVWTbw+osGml@lists.infradead.org
X-Gm-Message-State: AOJu0YydvzCcXbwr0guYSzxqlwtS+ITj0a9i7S7Itp/nZ6k+rex/MQJR
	fOy1DNtQCHJu+EMTpSTUgedhoVcbDokZAuyPIpJXmoAcc7+mLhO5V9IMR+LJIYPPAmvBG8pW7T0
	2md7KshyIggJei2hHAh6rhegpkCx95w==
X-Gm-Gg: ASbGnct3JEiAJ7+RoM7Fh8ybZtB1XeE8aL6v6nlQkHvhpMskZqD6RYjDnVZ5WUhWNnK
	RnHhQ9Pag4XGy4NqZK9nflP2p2ACUm+Qat+gQ1hXakY5ifRgTPaA1Yyxs1beQRgtagjwS+mB9eU
	UxmePWSquyHeHKK1k1cbOKm2+r34ykniVMyiPcfuvQa8Ky4EJ1ns3DQTTK88QVwAM9fbBgrUxft
	L1wEj3R/ouLKtn36n1VWc2JMRes29WsS/oXTOdEold7eBg7dWHc+amQZJAPr2Kj8CDNzolOJJVD
	Vr4sitxR98a/wjq+avtBNBInOQyIbM5pgAFCUrT7qhsCa4//r366Ivi2pp+tKCGbzz0=
X-Google-Smtp-Source: AGHT+IEIrrPvcFC3+rTLrgAPrW5zl0/cNdfSGGH+WdJU8CBkNncTEWdpxNp4QGdNjnbB8MXP5BRq+4un+OL6bxIbhcQ=
X-Received: by 2002:aa7:d814:0:b0:640:93ea:8ff3 with SMTP id
 4fb4d7f45d1cf-6453969fc53mr9852940a12.13.1763991533736; Mon, 24 Nov 2025
 05:38:53 -0800 (PST)
MIME-Version: 1.0
References: <cover.1763725387.git.asml.silence@gmail.com> <51cddd97b31d80ec8842a88b9f3c9881419e8a7b.1763725387.git.asml.silence@gmail.com>
In-Reply-To: <51cddd97b31d80ec8842a88b9f3c9881419e8a7b.1763725387.git.asml.silence@gmail.com>
From: Anuj gupta <anuj1072538@gmail.com>
Date: Mon, 24 Nov 2025 19:08:16 +0530
X-Gm-Features: AWmQ_bnDcYvcgkdgCo-kXgELlQbBhcvXrCXwL82qa0EngBmCaaIoNiIBz4Az0nk
Message-ID: <CACzX3As+CR4K+Vxm2izYYTGNo1DezNcVwjehOmFjxTqaqLrDGw@mail.gmail.com>
Subject: Re: [RFC v2 05/11] block: add infra to handle dmabuf tokens
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: linux-block@vger.kernel.org, io-uring@vger.kernel.org, 
	Vishal Verma <vishal1.verma@intel.com>, tushar.gohad@intel.com, 
	Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, 
	Sagi Grimberg <sagi@grimberg.me>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Sumit Semwal <sumit.semwal@linaro.org>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org, 
	linux-fsdevel@vger.kernel.org, linux-media@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251124_053855_777001_4B21453B 
X-CRM114-Status: UNSURE (   8.74  )
X-CRM114-Notice: Please train this message.
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

> +void blk_mq_dma_map_move_notify(struct blk_mq_dma_token *token)
> +{
> +       blk_mq_dma_map_remove(token);
> +}
this needs to be exported as it is referenced from the nvme-pci driver,
otherwise we get a build error

