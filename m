Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5A58C4453A
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Jul 2026 20:02:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vu4r/k+6CRzm0HvAmjC2f8PLSYRb0q27NObpyU+llPc=; b=TlXJRrqlRfXjnNOjnWE/P61+bz
	24NzYq7aR79f8Q/JTdJVhRU4BanWT2bemB34VxTiXLC4f4zPc0LqDbIxu9Ya45q3sS51tImGJRj72
	yELAstMayPzdApION5L36BPUAgEwvxiR+/7TNa8eEWvAyhVxVUwkGKN+XPsuqWoZk2xpnGS2nTtso
	uDZW/L3Rzvq457Abg7+uI0W/534kwWgzuRNwXplM/7q3Wa/zd8gghmX520isE3ayQ0Ol+7GW26Gjb
	grq9B38be4ZsYjenzo7x3eYi4E7K9a/rRJcOinL+KeCFruAmXKaYk2X/9OseIMTOyaO1S2xEl3wEt
	gLAV5Obw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wmd9d-0000000Cfw3-3bvc;
	Wed, 22 Jul 2026 20:02:57 +0000
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wmd9a-0000000CfvS-3Dnz
	for linux-nvme@lists.infradead.org;
	Wed, 22 Jul 2026 20:02:56 +0000
Received: by mail-pj1-x102b.google.com with SMTP id 98e67ed59e1d1-38759bcd877so11710168a91.2
        for <linux-nvme@lists.infradead.org>; Wed, 22 Jul 2026 13:02:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784750574; cv=none;
        d=google.com; s=arc-20260327;
        b=eklp/Zb0dzRHLn/oL09JAB7GrGlrxY+aL0QBRtjJc/+8yXWwDvhuhhsFxdcdbxK5Ng
         rOYLzUOU+Oo/0LlA6I1O4F/z8Ye95K6y8YxCupAul8Nm4NrwQyaRiIiUL7UsDE44zxDf
         Bpt3JYMdaWrIqrvJ7Tw37c8rei8I3C2vS1YHq8IalponHdhMDMsAILd5tmEWNyyHV1kX
         pCKOHfQ92DgMZh0sV9zlubSP+DcdNIZZAxKXiTqzq1L91efOfMrN/znocEmgmXtEktFk
         7Aq5qLtGffTu5uzo9Q/BnjFFaBjsvf4icWihc2GyrlhZPuCAEGmfc0du2z22qR02B9/m
         L0/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=vu4r/k+6CRzm0HvAmjC2f8PLSYRb0q27NObpyU+llPc=;
        fh=jriasNrB2bXc6fZpfxQG0RsURkiQ0bkZsBL39qC98yU=;
        b=HFz900Lx0H+KezQbIfHAowcC6OvDxWyJVaZS9cQS7JQLBCMuYwhNQWCE1u2OsQnEKg
         aZV03KE/YVXO6u7AVZt46GUJc60peC7U5xmC8JY1zbSYCQanh3HkGxsKoLuw9lZ+G6re
         pgtdyaWU0wj1cps2AdUKz26lqoT7zbZRVZp+QDLm28UV/cg1OUQgzPgGmg7CrhfieIMq
         BsRAdzIZl28JMGHNUyUQWg7IxdT/1Zm9BOJv1aPskgZm1S1+bdYznZnj3mmwLtgHgIyE
         UN1wV2OcHBSDbutCA8O3axBfcgiXUCVT/HBCxZjoKeKHO25lMHolVhVC1OLLbt2hpUPE
         HV3A==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=meshstor.io; s=google; t=1784750574; x=1785355374; darn=lists.infradead.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vu4r/k+6CRzm0HvAmjC2f8PLSYRb0q27NObpyU+llPc=;
        b=BYVv+euz5rhzrr3NdR52a/8npMJt7Q/VAFVZjDgq5dlgEX6OS357NzbjxLHLaJl3t4
         Kaz6akrB6wAfpjjr3JibEU7AT+g5E0HlzDByOKd0xm93oydx0moa9MlF45p/0fxcEKwK
         1xajJI5Vb7g7qyMzWG6VGLrEvfbl4+RRBKSkj19G1SVEUbAzSn7PWDwewPhVvGM2eZn/
         gBTflYuE8x4785Lw0XS0CeVrKiEIeRTpJRNXsJSdLTlNmO0CumuIU98RPfZM7yBooDyH
         msMcd8HX7FzitJ91frdtYWnoQPGWTNIa6C6aMzVj18x29NdR6Zo7epwkzxJV+mpQ0ivA
         A/uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784750574; x=1785355374;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=vu4r/k+6CRzm0HvAmjC2f8PLSYRb0q27NObpyU+llPc=;
        b=Qho6ndXscF7l8au52ST5bKVP9jXGxhiU8sbAy1G8ZHmLTDG2l1SXXZ9cHNrFjsd598
         29cY7/BDUX0SAw1MPFMO4mi7AZJR6gOPArp3PTU1kbUJ4mz84ZvWnv7skQ7unOBdKsIP
         QgbICQYr8vRQ1y11b2Ls2VOLe+Avl5E94a5EOIwWTTAkU4koAyC36Y390CK96sZeChTV
         hiv/Q6sG0ncYWaYbmEewS+ZcpU7J2OyWr9Cq2/QTcbErzjfsNgkaG340bH5nahvucgp/
         rtjJC1ydrqrw08KXYwpJ3UvV2SxO8w4dm9epVh2dYuRXtvcbfGHEDk3CUgKdpaGig2eg
         pxXg==
X-Forwarded-Encrypted: i=1; AHgh+RrL1r3Hu/NmBjQbqIf+s5I7EQJfHvMWD2ixADtiHTxjUac2buv8FcovlHDyGKZM75nVZu9MeIMzENw1@lists.infradead.org
X-Gm-Message-State: AOJu0Yyf4/XuHymlCHWcZp4GFAQvb98EQbaPdJDzA5iJZRTgXNce43in
	tOL5mzCKHPuMXUatmhfHNHnvRbHL+pwUsHEeefwKOKLSmmUDyueMoRzTcY1AZ/Baokr+KsQOQNo
	Tk8QGUa4tuZ6fIskdVVL2p6HOhnWU+z9M6TAruvHC
X-Gm-Gg: AR+sD12vbWRVpAzG9U5n/d19HloibqLi0l6llqo692/x7Fu6pQ5x71656QDafjT3cjA
	8n66sGMLkTm3vy82rJsgf7bNaO1BO+XAy+heAwk2ARxKgeWWAwdM/aMWvTfiDYNMlDa9W7ukagg
	ETxCkzF0mzIpzSnIIsEz6j/W5izsvS2xilu+Zy0JiZchskEaCEbU6SNFRmi0yzE7Jf1E7T8Si+u
	plewSczLBVGEaNXzLgVcrd+qTKbodHVxKQ1TIZA+9dpAq2cQX3+JssYBrRh9V0HmD1stJRryuVw
	Rm6NPwXVoi5sJv9PhEt+BkRXlTxoCkr5N17R7CfoTUFeFTsRbY/y+1ZAhhPiVPiEqKju9BKJ/Yy
	0obqQxjGpwF6bBisSeh3Pc2H8vM+PQFTu6Y0e6A8=
X-Received: by 2002:a17:90b:2d10:b0:38c:a59b:5189 with SMTP id
 98e67ed59e1d1-38ec698af76mr113249a91.15.1784750573899; Wed, 22 Jul 2026
 13:02:53 -0700 (PDT)
MIME-Version: 1.0
References: <20260722185841.449934-1-mykola@meshstor.io> <20260722185841.449934-9-mykola@meshstor.io>
 <536428fd-9c23-45c3-be0a-5eaaf8f3939a@deltatee.com>
In-Reply-To: <536428fd-9c23-45c3-be0a-5eaaf8f3939a@deltatee.com>
From: Mykola Marzhan <mykola@meshstor.io>
Date: Wed, 22 Jul 2026 22:02:41 +0200
X-Gm-Features: AUfX_my0hGYZfb89FIks6uN6jtY1SapXkJQfTk3Dh1NK0AxygDAcUpRTP3iNF6Y
Message-ID: <CAPzsNDscnb+fH0XZF3qBDgxkREmgh6F=rp0GO18Wy7gLc=4Ldw@mail.gmail.com>
Subject: Re: [PATCH v4 8/9] md/raid1,raid10: set IO_BLOCKED in case of BLK_STS_P2PDMA
To: Logan Gunthorpe <logang@deltatee.com>
Cc: Jens Axboe <axboe@kernel.dk>, Song Liu <song@kernel.org>, Yu Kuai <yukuai@fygo.io>, 
	Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
	linux-block@vger.kernel.org, linux-raid@vger.kernel.org, 
	linux-nvme@lists.infradead.org, Li Nan <magiclinan@didiglobal.com>, 
	Xiao Ni <xiao@kernel.org>, Guoqing Jiang <guoqing.jiang@linux.dev>, 
	Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Kiran Kumar Modukuri <kmodukuri@nvidia.com>, Chaitanya Kulkarni <kch@nvidia.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, Shivaji Kant <shivajikant@google.com>, 
	Pranjal Shrivastava <praan@google.com>, Henrique Carvalho <henrique.carvalho@suse.com>, 
	linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org, 
	linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260722_130254_835779_81DC3217 
X-CRM114-Status: GOOD (  10.32  )
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

> I think it would be better to
> move the code more towards similarity with raid1 instead of diverging it
> further.

I'll move bio = r10_bio->devs[slot].bio; up into the declaration so
raid10 matches raid1 in v5.

Thank you!

