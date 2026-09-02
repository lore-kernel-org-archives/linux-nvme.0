Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5745AC61DD6
	for <linux-nvme@archiver.kernel.org>; Wed,  2 Sep 2026 21:26:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BzEZU3zeMRYJSpuhNSZ/KarCUxW8+F0Dr/9w7Hweq+0=; b=giHpp3xA/tOGT2Ydle3jLEmcS2
	Jw+1F2bZxF290q0sK7w3/Yo4BxugYWdU4bwIAXUDA3++FmBmYTh3RtCsmse6wlfdixC/xepuDYWVY
	MC1sUm8rVCwkP4xKkoB0TB7vg/+axKc3KOpy5/zE0l8CijlHnDihIm3vqpFDCmJt6NI5Z5Wh5s4wS
	GaBJtfCbEddqfCERG2tykxP943o7hTzQMycAo5pHB9V7xMYYYJnVZWxropblhaQ0gcyTgRq1m0DK7
	YF30KwyloUft2VRaZmVwwImXk8sgGRHXgJUury/o2ShuuUx0T1oQL9Ve0ulN0DtZrY2QpsmqRYOif
	iKZ3ubOA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x1sTQ-0000000Fw5d-2frZ;
	Wed, 02 Sep 2026 21:26:24 +0000
Received: from mail-qt1-x82d.google.com ([2607:f8b0:4864:20::82d])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x1sTN-0000000Fw5G-3zqE
	for linux-nvme@lists.infradead.org;
	Wed, 02 Sep 2026 21:26:23 +0000
Received: by mail-qt1-x82d.google.com with SMTP id d75a77b69052e-52d5bfa4bafso17980861cf.3
        for <linux-nvme@lists.infradead.org>; Wed, 02 Sep 2026 14:26:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788384379; cv=none;
        d=google.com; s=arc-20260327;
        b=VqCe3nnKLtTgw9j2gARUrMaQjV3ejBiLK6ksvd227yrxauTfVCTi76hxyN9dkWsmkW
         dTO4+MWbg4p/eZ4nzgxJi+hntoT77RQGOcS1RrJVutD2K4bL0v97DuontNOvBRLExDOJ
         q+lgDf2ZNteKgECt+rLMXIyR3QJt3G67zR3yWKMn2diilQ1pkH0RdhQNB56GUkYf7XeE
         nBeHP0JvoR5WBTc+p9cB/C2z/mGBZ09OvA7uVfx3KlDGLDp5mwn0RUqsm6xoaPwB51+p
         mMyYaymsUaA34h+Nd9EYl8yVObyKN36waW/r4z2Q/gamEq5aXNRwSmft8/DTaIGvMIM+
         R+mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=BzEZU3zeMRYJSpuhNSZ/KarCUxW8+F0Dr/9w7Hweq+0=;
        fh=Ufzb4jbWEfHy6+FKzk7dxFnu2LjIsk0kw3iEmJLvYTo=;
        b=QSpwBesnMBPqIU024d357Btpho72A/ejQ0+xkTFzDWObK5Nobc0TcUyCPmgQcyPt2O
         FzUkxeSw1+SDDLOMCixoy98cjWao4fPkHH8HM6bE656Zz2INVcF6e21AcnQ8Rr7h7bgv
         g93cURk21QbzfOJj1DU7x0bwodSpOUMSWMCQcIMOZxrxlTrTRVleNNfJjGXUVJQW75Zo
         d7UqF0G7BA1PZPcGTxjtI6UlUqC0JnXUvPULEFYA10OXn+YtioUfjGDNTGO3XnPCChAJ
         NBHL1DC2RmA0OdqV0oHicRBwSPIRAj/3FYOgzOPmKyd6g0ZqiLU1T4tpyvy6d1qlZLvr
         K1lA==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1788384379; x=1788989179; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=BzEZU3zeMRYJSpuhNSZ/KarCUxW8+F0Dr/9w7Hweq+0=;
        b=SzTECidpsZEpL4ba/CN5J7gBip4XbYDDIE4M7lpc4ohHFM1zoNF01cdfvf1KahvmRb
         UHAT1gy4aj9n8SqWQBk9sBCmRn0EmuFSH2vOgaVq1PoO63sk3uXSUS7ZEU6un+zIUTVq
         XmQ3ZlI73eD0FREIeCJUfXUrDDb67/3cUFUrv4Rs58uD4mcuvD7X4nHacEdSWGBMQyWx
         89K5qHPBkn7z44MPztleoPAQIfPevdNxjDZb0jzabrFrDfyC55oELoufCNQYwJp1WWWG
         G9K3IXWvbMY8l4zUXMk5xlWoE2QA0czRkE3+h0K3uZWDByuBS94qpJASFxQv4b21xHso
         5yjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788384379; x=1788989179;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BzEZU3zeMRYJSpuhNSZ/KarCUxW8+F0Dr/9w7Hweq+0=;
        b=oQgNGc8M6RyRc8ou4RcdCOrtUz2oWiRbDY1d43I81WT83RLczeoXkv/sib9nifpCVa
         7T8yL6nqaPjmOc4bU63a5u9aldLjYKnvtR4Egeg3xpX1LB+w3yek+fcRML2AUM1EsgqH
         BKKjilWCoZ6SP8BSMupmi8Aqqr+KCJVkUgPFBonMrjQdOMCNdp8BJibvZCC3QNZsSgjs
         /o+Rw17dnqUPF/GDwYfG1ZU11F8tyZotoLywBPLEK/JyKabD81mQkkQK8jqzhyAPzgnI
         GqTvZdEVjYyOErHb0wEadmG2VAtvymNx+Hs2AhQ24UWzsxfLXpGzvSWcpDAYZ1C3rjrx
         pLEQ==
X-Forwarded-Encrypted: i=1; AKwUvByruXX89Q3Wdwwg9/uPQY/X481TsXelmnFdJp3wLKCpIKu06IqoZHKNAI9+yvcUw3AZTXWBAqN8seQ6@lists.infradead.org
X-Gm-Message-State: AFuF++lr9GOOYU/DhmN6UIYK8HA63tcZTq2/MxJeuq7+NHWWUhE5aJw/
	E3z9G0hNG/4SwzxaIa2MTDBx04sGe2Hq3FY5Eb6jj4p4xFNKqJ13ZOmO+16Aj2e8tEYNdQf/8aD
	VTrO+bxlglF2Qk48Hw4NSXRv/658plAlX+clTRw2BJQ==
X-Gm-Gg: AYBFou0q3/PNKTBJ+sLeTU39XOu1peK8k5abSxMxfIBgG018dLvOKj+iRLlniaZniM+
	vhtRbU/NEzfMGs1lxhZfokJsaWtw/rAQKQNAI9+G9nQrJhwYcj7EJWullh1YN02UigRDvovP+5L
	7CuUvfq8t6qIGXXVG4byR9XoB0WB7/hDjCZ1twbOaRSaJdEZrL52+o/8p4CVOdHeTW1b1x1nw/D
	UNNC/4wpZlq/p4XzvXHyzI6lAr4zeSOBAWHBsD5u4KGdMHd0NsNH22P25M77v8qxrLXTDO8DDZR
	GNqQ+bQ4jRE9JZQWJ0rIImWeWsXq5Di+OwkHKMOu0D0N
X-Received: by 2002:a05:622a:2295:b0:51e:47a4:4851 with SMTP id
 d75a77b69052e-53036b727f7mr105890781cf.8.1788384379448; Wed, 02 Sep 2026
 14:26:19 -0700 (PDT)
MIME-Version: 1.0
References: <20260824225648.316962-1-sgogte@purestorage.com>
 <20260824225648.316962-2-sgogte@purestorage.com> <d55e8223-44cb-42e7-bb41-d659f206d573@grimberg.me>
In-Reply-To: <d55e8223-44cb-42e7-bb41-d659f206d573@grimberg.me>
From: "Surabhi Gogte (she/her)" <sgogte@purestorage.com>
Date: Wed, 2 Sep 2026 14:25:43 -0700
X-Gm-Features: AcwNN1W1Jo8WhaqrqGF3F7_3mFTcz7nsh0oki4TgJRxBqDXnt4EGpkyQItoB3jI
Message-ID: <CAMof9cWp4dv9PqvP4E6hO-arvKBmuBnHoeZ8JVybjM49sZt4_A@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] nvme-tcp: refactor I/O queue setup path
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, 
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
	mkhalfella@purestorage.com, randyj@purestorage.com, adailey@purestorage.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260902_142622_002260_311E1621 
X-CRM114-Status: GOOD (  16.12  )
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

On Sun, Aug 30, 2026 at 2:56=E2=80=AFPM Sagi Grimberg <sagi@grimberg.me> wr=
ote:
>
>
>
> On 25/08/2026 1:56, Surabhi Gogte wrote:
> > Split the I/O queue setup helpers apart so that the individual steps ca=
n
> > be called directly from nvme_tcp_configure_io_queues():
> >
> > - Queue count negotiation moves out of nvme_tcp_alloc_io_queues() into =
a
> >    new nvme_tcp_io_queue_count(), leaving the allocator with just the
> >    per-queue allocation loop.
> > - TLS PSK validation moves out of __nvme_tcp_alloc_io_queues() into a
> >    new nvme_tcp_tls_check_psk().
> > - nvme_tcp_configure_io_queues() now calls the three steps directly in
> >    the same order as before.
> >
> > Signed-off-by: Surabhi Gogte <sgogte@purestorage.com>
> > ---


> >   }
> >
> > -static int nvme_tcp_alloc_io_queues(struct nvme_ctrl *ctrl)
> > +static int nvme_tcp_io_queue_count(struct nvme_ctrl *ctrl)
>
> Strange function name... maybe nvme_tcp_set_io_queue_count?

Yeah, that works better. will update in v3.

