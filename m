Return-Path: <SRS0=xKei=LR=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86F59C4743C
	for <linux-nvme@archiver.kernel.org>; Wed, 23 Jun 2021 19:03:19 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 505CF6120D
	for <linux-nvme@archiver.kernel.org>; Wed, 23 Jun 2021 19:03:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 505CF6120D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Arn810UEeaV9e3oJR1pN0ZFopDOYP0slcpEO+YGO/xc=; b=1kZM0zguB37vwV
	HfTzU1WmA0ceDJyXW37qhUEAE4ZNrR0ybWBb+X0/7q2DFb01NwMlvqu0zE49/KCrRqBXRgm9WrWMo
	tdMSsK8Np+VA5JqXrdKiAgx91vOUJMpOLHob4jWpXunqjxNqDSZMxnioYTQ05yXjOhMir07DVP/Fd
	3OXghBxOI1gr3ij78yY9asr5e98x9cJn2hxadzDnebSr+OGo3Do6UFytBALYyCSaDf69OBP3oClBs
	uxdPWO8AsbWb5NR+fJIewmIA/kHOH6qr6sk4DxJHYK/U6VhfxnfXZzCSKs71oCOOSP9ZI3Y9LQWz6
	UXTFGTfvOrkx4pTwL+Vw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lw89P-00BkQ3-S2; Wed, 23 Jun 2021 19:03:03 +0000
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lw89N-00BkPC-8U
 for linux-nvme@lists.infradead.org; Wed, 23 Jun 2021 19:03:02 +0000
Received: by mail-ed1-x529.google.com with SMTP id r7so4889255edv.12
 for <linux-nvme@lists.infradead.org>; Wed, 23 Jun 2021 12:03:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Jbpl6CTf6VyVoHnrXMMPDm/GF5brZ3xxDs70WGxyBS8=;
 b=NqiEuXjvGHomBdhKBtN2CCvx0cE5M56lc2eCSX0ZYHWViIDbKBzNfDPA0Wfht+P0hR
 Md1ETa9q43WRtGdJEQNGP+hxadP+GWxTi/4tZ9rdN7zFRs3H7CYF6pOJo5uYO2RdSe4S
 yaB0uJCxqY7bF0uk/olg5Eht73AqyTB8p9ye/QnJ75BgdRX12cwOrp5SThzsASz1oaBt
 J5QcgFHcdypB/mysHUvaoDXSqzQQKc3YOjhVG5TL5O1VJYuD2Kqnj+KQrF/AX9qYAu2S
 1a7ZT4QbPMYYlSJ66Hz6VerlbJUq/+DLgPOeR+4SWWe0zog38XjCgutdHg0mhyPZH8U0
 TUpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Jbpl6CTf6VyVoHnrXMMPDm/GF5brZ3xxDs70WGxyBS8=;
 b=sJcIgj37oSWZKr0zMwHfbDYzx3N10wCuIMtkp6JGUxxfEBKStTTgfHJfcaxqKJKO7K
 A9Rb5Cy8TOfS9E+5DQRazd5FLzlRx0kCYiaLQV/w/nhtBiXVfAxARo6HR00TlmmVVoeq
 F0XtiAgWpV4rHZmXOaUX4/Mm5KAc6NoR2a/B+kjaKqpXX6xlQ/smiJzwfQ5pv5uyrTha
 cGNS0RbYd1RuEdNokuB+aJcnGK8LH6twnCa9c1UANzch/OIj0rabVCBu/8yd6nXXHL9J
 ebCKKLeoV16wgCv50dKcQf6oJ1i8vao3HpMQAUKz2+XG3ZarejPVgFi0hsRztnjN0lhY
 9INA==
X-Gm-Message-State: AOAM533BRYuObELxqFHRqwv6E+jI4S7BC64KRXCRWPZUA6u7MiCCTxSa
 pDjCobwmxRO451RqaJk9zym3QSuNhqGTIZT3BiY=
X-Google-Smtp-Source: ABdhPJwh5wqG3nnYrKJKNEN9LK2fbrNR2BdpJRAWXyRszlH2M4iH5Ue4HCM/rPboDUawt0lkKW6retaQbmEFcuqgA28=
X-Received: by 2002:aa7:dc42:: with SMTP id g2mr1704137edu.362.1624474979841; 
 Wed, 23 Jun 2021 12:02:59 -0700 (PDT)
MIME-Version: 1.0
References: <20210621051046.28783-1-smalin@marvell.com>
 <20210621051046.28783-5-smalin@marvell.com>
 <20210621065024.GB6019@lst.de>
In-Reply-To: <20210621065024.GB6019@lst.de>
From: Shai Malin <malin1024@gmail.com>
Date: Wed, 23 Jun 2021 22:02:48 +0300
Message-ID: <CAKKgK4w6wpMfdiGrvNDRrrMztdvijCYcRQwCgchMG9onOh=Pew@mail.gmail.com>
Subject: Re: [PATCH v2 4/8] nvme-tcp-offload: Add device scan implementation
To: Christoph Hellwig <hch@lst.de>
Cc: Shai Malin <smalin@marvell.com>, linux-nvme@lists.infradead.org, 
 Sagi Grimberg <sagi@grimberg.me>, axboe@fb.com, kbusch@kernel.org,
 davem@davemloft.net, 
 Ariel Elior <aelior@marvell.com>, Michal Kalderon <mkalderon@marvell.com>,
 okulkarni@marvell.com, pkushwaha@marvell.com, prabhakar.pkin@gmail.com, 
 Dean Balandin <dbalandin@marvell.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210623_120301_342089_FD65CB1F 
X-CRM114-Status: UNSURE (   8.53  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Mon, 21 Jun 2021 at 09:50, Christoph Hellwig <hch@lst.de> wrote:
> On Mon, Jun 21, 2021 at 08:10:42AM +0300, Shai Malin wrote:
> > +static inline struct nvme_tcp_ofld_ctrl *to_tcp_ofld_ctrl(struct nvme_ctrl *nctrl)
>
> Please fix all these overly long lines in the whole series.

Sure. Will be fixed in v3.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
