Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F648109316C
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Mar 2026 08:14:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ezHaoobBTnk6435KZH6iM+ulq7CLOXWZm7suvZqxDXI=; b=FVq5rnM2BsvE8Q3pMTtP3K2OWC
	eWdhZ30G5mn39c3Bn62Jx4TRPvstDvotLmt+leaR+r31fqIelF5FI+D5lyfkkXmlIfYA2v2KWRZO5
	6TcDzl9b29k6pvNto/Rx4SZgAabbiz8EKfJQptlASc4A31UOkPBZBsas8nnBYHFQjg0cQFr7OGyXA
	L/6xLY2jtkkQnSBuyXuFmmOhTKRGY511kWtbZibb1xu7a/tYi5Vh37t6IODy3ZEDXcFEK9+5XVI0a
	AWSfgbOoQphjYs6v5Cl/IUmJLItJZDascv2E7UM3GziylImgCOtp5h5+TuIFW4uuf/AA7CPmQyHs6
	lzT8QFrQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w3Uzh-0000000CJff-2c5q;
	Fri, 20 Mar 2026 08:14:09 +0000
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w3Uze-0000000CJfI-3qeo
	for linux-nvme@lists.infradead.org;
	Fri, 20 Mar 2026 08:14:08 +0000
Received: by mail-pj1-x102b.google.com with SMTP id 98e67ed59e1d1-3585ec417f6so1282552a91.1
        for <linux-nvme@lists.infradead.org>; Fri, 20 Mar 2026 01:14:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773994446; cv=none;
        d=google.com; s=arc-20240605;
        b=ixbjoZW55zocXVxUQ1Lvs6nZ6QSBvyvGKoqLonD7Kj/XoX2CIpNumsZP0AVCD4ppdn
         BiYZdfook6CsMeOGzx4+Pl35dEf7d9pt86XgIb793y0FNEm7kacW3S/e76DwvBy5qLd4
         ImnL3b9Rcu+c4N0CYBbBsMumg5SyXahMXShyI24zzn+haUUpl0H//kR/PYgBudAnt4dM
         cykzklwbyrjG9KbQu+ys5ao0lzjH/6N/iNyfdRzkHiyBSCQdWQV5ywi7mYeoLTCzz+Wz
         vSU42QPDuM6MuG+Jjnas/npmeF2Lnxio5I5NkxJyXWqnuH+I8u/ettAqxJ0thxxrCinl
         Paug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ezHaoobBTnk6435KZH6iM+ulq7CLOXWZm7suvZqxDXI=;
        fh=RKMrJuM5/D7F22DtrYePR8hhT/Enp3yvzUx90mP+1jg=;
        b=Q3Ro8EYlBUhlS4nHWaI24CruK9N3P7UjYHXbVJ7NBXMwmbcM/KUSFp4ZAWxYC/SAzf
         XgGssZi4rRH2q3wHpFAxDzCLQS9IPHbb8BJ1K3GWvBbQd5oG0rxExZf/OpEXGUWSAFx7
         Dtrhx3zvwnNv4mtiloh3cLNoaTlGcTUxLCDKt/C4kb9sOk1hoHMP9fAisYKmogClSyNH
         3EmtQFw1mbW4PC8y7KWSu2tosX6KHbxrUQv0HMi6UJIdRdE/dzwKWAzzt1RY7d+LGeiu
         IT3Rh89UjaUW3sBhWakL4AC7GMdObFgKctXYoe/imasfuMW9MQCWoZtRYrZzzu0YCcw+
         1rdQ==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773994446; x=1774599246; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ezHaoobBTnk6435KZH6iM+ulq7CLOXWZm7suvZqxDXI=;
        b=NJjcFCkirtKDOxYgX1rHBfgk8W+qHQVNakoL5hbasnTo9foxZdS7UBkzXNysxgXyMu
         k+ZykeFkhebPASFdo3NLklVqeVjiSuE7sVwu6FJU3mITohfLiV+USqmZfAiHb3Ui1tqk
         2GgLuDczq/MiZduenrLhzzJlnowFAaNBR0y7pVtsq5JHjgPPbSSvF50WNQLN02yfU8nH
         lGg+xKMoYD7CiXxHT9aBfsJzWRhVeaEemhM3HNVFGwtB/Eq/RvBwmFdF+lBti+Yo+R9S
         ZVu9mRQwsM4uWidvsSftP0KCEFB43Zm4JGGps1AzOq69j+iapH64XzHQXtr3WNwBf/LP
         RW/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773994446; x=1774599246;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ezHaoobBTnk6435KZH6iM+ulq7CLOXWZm7suvZqxDXI=;
        b=OE7gxMOd/y/DzKm+ZggcedyhKWVf11vKVUGqDSIzcWAAhPH6g8tIWu2sMm5qSK3L4p
         cun7Qs3OHtiY2logFVH8BYJtRpWlC4gKG1sMlE2H5lqSc/OieI6HM/hd1CAyd6m0VoGa
         cNAqZW+cCSwCtaaKIVIM4SQGjayg7CGD2LKYLqPSBEjFNJ2ZjLZ2dZsx0SbPnlrdTNKD
         PtSWvdAvdkSxGHdvcpvdhGJB9SloKp2a2fVRtd/BBt/OefwHcjvl+7TXXKzgsnIqIYqn
         v0G+mBj0I6qxKiOO3uMP7j9eFu81Y/sQov/YWjHkrROtjctoXCaqgCAm3Nhm+2pHo7hr
         ggHQ==
X-Forwarded-Encrypted: i=1; AJvYcCVFrJ039Py/XxARh79x4FYr42pYyWUjHARyODDFEuOw7+QqSkNmOrjCfbws0xnkQPt0q8SHJ4Z8QrQj@lists.infradead.org
X-Gm-Message-State: AOJu0YzYZ4Sntk34sTby3IfK2JBJ0VT1jHqiBKP/QbNfALyljNTbC+je
	hNvLbSCPx6NcNgk6El5bTqTCVMKkEATCvs8HQdOUz78liwwT35BVldXW98rmmnleJn9H1VxCp76
	NjqwrHqEZhwA4ydc6THONFAF0OD+jwCE=
X-Gm-Gg: ATEYQzxvCv2TRv+2+4IrKZq2FS4lA0LYnmfCeOk6EZW7+O441ZNwq6yiQ8gFCnE9vr8
	R4ceHJOcaYryEtAPz7N2wjYjZ94phgm4kV9tmfNyaqKuEbEsFR7yfy2Qw5UDqismbT9ny/pfExq
	On0hiD5VQpyHbGvGeFQzLSnEtcW49v6h5gIhmmms5efhTzLtDttQQ2BPDrHEm2iwosoPSbaybsg
	knqmHFjkXBurnktfNmpZZr+nzOYjin28CO0o9EU3xK68DfWTR0oeuLgycRA2AazN1u+FdSgjmOT
	bfXBkrw=
X-Received: by 2002:a17:90a:d44b:b0:35b:9703:7664 with SMTP id
 98e67ed59e1d1-35bc6069bfcmr4961262a91.10.1773994445655; Fri, 20 Mar 2026
 01:14:05 -0700 (PDT)
MIME-Version: 1.0
References: <ec03d5ca-a26d-4427-823a-17c5709391f7@suse.de> <20260313052444.3865842-1-ioerts@kookmin.ac.kr>
 <20260317145137.GA6462@lst.de> <CAMX6_QFvhJwCp1v+YNC6BOTsV-7qCW1Q2pKZDOwkPychZOQuSQ@mail.gmail.com>
 <20260320074935.GA14616@lst.de>
In-Reply-To: <20260320074935.GA14616@lst.de>
From: yunje shin <yjshin0438@gmail.com>
Date: Fri, 20 Mar 2026 17:13:53 +0900
X-Gm-Features: AaiRm50OanPLpoES9UMWloJgDfwbzcy0RWK8YgRGPJcQBqeCoCAfeX1G7slpoz4
Message-ID: <CAMX6_QF+gUdSvzAsmq=hgY34BRbXZjHUBzuG5akmJpZyK67pmQ@mail.gmail.com>
Subject: Re: [PATCH v2] nvmet: auth: validate dhchap id list lengths
To: Christoph Hellwig <hch@lst.de>
Cc: hare@suse.de, cleech@redhat.com, ioerts@kookmin.ac.kr, kbusch@kernel.org, 
	kch@nvidia.com, linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org, 
	sagi@grimberg.me, stable@kernel.org, alistair23@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260320_011406_980017_1C5C027F 
X-CRM114-Status: UNSURE (   9.69  )
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

On Tue, Mar 17, 2026 at 11:51=E2=80=AFPM Christoph Hellwig <hch@lst.de> wro=
te:
>
> On Fri, Mar 13, 2026 at 02:24:09PM +0900, YunJe Shin wrote:
> > +#define NVME_AUTH_DHCHAP_MAX_HASH_IDS 30
> > +#define NVME_AUTH_DHCHAP_MAX_DH_IDS 30
>
> Tabs before the values.  Bonus points for a reference to the relevant
> spec.
>

 Thanks. Since Alistair has already sent the nvme.h macro patch with
the spec reference, I'll drop the header changes
  from my patch and send v3

