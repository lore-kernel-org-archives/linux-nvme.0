Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C4AFC433EF
	for <linux-nvme@archiver.kernel.org>; Tue, 22 Mar 2022 16:57:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TWipBvtrLS7SDRJREmYi7xhXNmXrdgMxstsUKJVGDuE=; b=Le02KqpDtFlZSuUa9CWZXJtBoc
	FoorvI6UyDGsGPRTVUty0sIgHgc8Y3NIZk4JNrj4b6/D1sZkoKdnxNfMSH29m9+KNQyeIXvFOdw1m
	xkd0FHSJ/AqccwjTrvzeXSJtQfZZgxUix2u3isgt0tKqLWOLB1FvohvBh+FUziRK7ju/aJ7gu5WzZ
	3lRW9GqcSsFIiSUrgcw8GGWNv0dX7N5L6PBfkzRRcGD2Mk0Oc9ckDB+D8uBzB5ByAebBsaGO9NTvy
	vwYxRyRPA5mEiRqsFTemU3NqGUe1rObxderV0oXFzV5p03LMRzNSHno6vD+hq4Q8VZBiA1ogA7Duq
	EcIedCqg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nWhp9-00Bff4-F2; Tue, 22 Mar 2022 16:57:35 +0000
Received: from mail-lj1-x230.google.com ([2a00:1450:4864:20::230])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nWhp6-00BfeG-OI
 for linux-nvme@lists.infradead.org; Tue, 22 Mar 2022 16:57:33 +0000
Received: by mail-lj1-x230.google.com with SMTP id g24so23591197lja.7
 for <linux-nvme@lists.infradead.org>; Tue, 22 Mar 2022 09:57:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=TWipBvtrLS7SDRJREmYi7xhXNmXrdgMxstsUKJVGDuE=;
 b=G7IqZ71UBXpyaD09zRRZv35E6IQjNOWS/SSNBW5UAnfM4GHf9uJT4rJj3b/YDCt3A+
 6eis8nStO2jnaTjbRwXLsthm2oDAB3vwvYcHsQy54d1OOvn13oAOwbLL5SYVeiqXhmHQ
 ERQ3VR5V83EjdMqE+ZTZlOjQ5QGITMqwqCdktKtWbO3SyGTtX+6bVbpw2Lsg06JKKVKC
 r/ZN3ShnOKZdPM3dvYaSh+DKYbB5CdqqLSfucplI2CFshpcz3/lIVs+Yp2Wy88eIrcqK
 hQFNaTZGtb7w5wT2JEonDuxMgomo5atJQ7aid05aXQG97yQyTvuiekPUGJvXkrK0qulS
 PnYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=TWipBvtrLS7SDRJREmYi7xhXNmXrdgMxstsUKJVGDuE=;
 b=TtGNK7lK0zmoqk3mes1XiemvFDyDHJRIR2xM9lwL6Rl9oxZ85zgfOtd7UCgpImQ+8V
 /hiBbZ4eEujsmiBGDa2HuqEuX3CcRvX04/E5SOoU3Kfbtm9lFKgwudQ163JV2PQ4/IkJ
 gm+xi610knZlXjoM3QY9NMl8WgikHcs1QLPQ725PVybBCoXJ25DWrdu8xEngjPTuCItV
 eb3I3Pg3nNXIrYelSzEsSrdHSivH0S+s06x8wghJb94iDmtWRtMw2iwtBCh75T2FzXUx
 6fWPosFq5qi18+83JXWzK4QjdiPWEfrsLXZwQH2EJn145bquORPibO0YEzPI9qZ6yZgG
 cnCw==
X-Gm-Message-State: AOAM533X18qlGlqA7gjbQKVbNuE4PdW/jMfFN/332pXh9yi9PuzlR2D9
 bjzjhpre2vNuVQz1RMZNIzlO3RaYBH15qOEL3O4=
X-Google-Smtp-Source: ABdhPJypKsaffUKrJLUbPFtEm8ZS8M14Y/ZHi1ZyW8gvPWJb8Da3NB80ZPwSsX4MEjwRtEjI3cuSkXUCCALqZo+EQq0=
X-Received: by 2002:a2e:9990:0:b0:249:88f6:f637 with SMTP id
 w16-20020a2e9990000000b0024988f6f637mr6185841lji.14.1647968248527; Tue, 22
 Mar 2022 09:57:28 -0700 (PDT)
MIME-Version: 1.0
References: <20220308152105.309618-1-joshi.k@samsung.com>
 <CGME20220308152702epcas5p1eb1880e024ac8b9531c85a82f31a4e78@epcas5p1.samsung.com>
 <20220308152105.309618-6-joshi.k@samsung.com>
 <d66a6bb2d0974171b44777dd07889473@kioxia.com>
In-Reply-To: <d66a6bb2d0974171b44777dd07889473@kioxia.com>
From: Kanchan Joshi <joshiiitr@gmail.com>
Date: Tue, 22 Mar 2022 22:27:02 +0530
Message-ID: <CA+1E3rL=Wt=sorCOXxGJ5MJXW+9Pbayy+S2+EuS3tzFh2yGNXg@mail.gmail.com>
Subject: Re: [PATCH 05/17] nvme: wire-up support for async-passthru on
 char-device.
To: Clay Mayers <Clay.Mayers@kioxia.com>
Cc: Kanchan Joshi <joshi.k@samsung.com>, "axboe@kernel.dk" <axboe@kernel.dk>,
 "hch@lst.de" <hch@lst.de>, "kbusch@kernel.org" <kbusch@kernel.org>,
 "asml.silence@gmail.com" <asml.silence@gmail.com>, 
 "io-uring@vger.kernel.org" <io-uring@vger.kernel.org>, 
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, 
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "sbates@raithlin.com" <sbates@raithlin.com>, 
 "logang@deltatee.com" <logang@deltatee.com>,
 "pankydev8@gmail.com" <pankydev8@gmail.com>, 
 "javier@javigon.com" <javier@javigon.com>,
 "mcgrof@kernel.org" <mcgrof@kernel.org>, 
 "a.manzanares@samsung.com" <a.manzanares@samsung.com>,
 "anuj20.g@samsung.com" <anuj20.g@samsung.com>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220322_095732_839206_B05BC1AE 
X-CRM114-Status: UNSURE (   8.56  )
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

> > +
> > +     if (!status && pdu->meta_buffer) {
> > +             if (copy_to_user(pdu->meta_buffer, pdu->meta, pdu-
> > >meta_len))
>
> This copy is incorrectly called for writes.

Indeed. Will fix this up in v2, thanks.

-- 
Kanchan

