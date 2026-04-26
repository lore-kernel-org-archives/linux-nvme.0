Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77CECFF8850
	for <linux-nvme@archiver.kernel.org>; Sun, 26 Apr 2026 23:57:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gzMcqJw4PFTe0iaVOhhDJ3isvB+To0xFXsTzORiz9Ow=; b=3zMxAW7ldczUG7sgWekbrIugJL
	dMCzDIJdXvwdGKKrAlg2YjCCeRP1RQ/qOW8CoZeHHxo6uiw4GyNw1/6jj6qU02aPUeIcSKa7yDoTx
	73oq+v6tPCB3s40fAo3T8Qg5WvVc3pfi+nwsJ1RYfaTcQLoQpD5bYCrvpuZm/lT0N1Sj3Yj51Jc3K
	xeHZGEuJwSfsTNN44RPum8Q85au9N0kO44QT/rZn1cxvQrkwIaU0ozoH/rJ/wN/r6MLX5eyrazQNd
	jRD3X1LRjVTLANE8T74TYTiWbzsD7V+EEKFBokat5tfX0bdULnxX33lh333kLqViRzORGJQA5Zjza
	eFapzrsA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wH9M5-0000000Fx9H-17Mr;
	Sun, 26 Apr 2026 23:57:41 +0000
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wH9M3-0000000Fx8m-19tw
	for linux-nvme@lists.infradead.org;
	Sun, 26 Apr 2026 23:57:40 +0000
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-43cfd1f9fd1so5887587f8f.3
        for <linux-nvme@lists.infradead.org>; Sun, 26 Apr 2026 16:57:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777247856; cv=none;
        d=google.com; s=arc-20240605;
        b=FpInV9LWzXAMq5py7V5qfXtcgqudYPP6VUYvlaIqm/pphU5ypFzDamhYRJ4lxOqYlF
         Ha3ZRQReGxiwCsU9OdYJsOyDkXOMSrswySfpgAT+GF1Obwc7ANlPK8itvVbs2e3SWTq/
         zi3jIIImvMnmjnSI1ZkCAGaE/JiKEHKbp1FGQmGCsvihGEj/dDCfyaSG4Kane/Qxa5Ij
         Eb/l4CoKOJ+7TgCP6/cS+Paf5ulz/0mXB1XUn2nM7XgJ0OioEZWOqlb1yCT2aQCudj2n
         KfSlltx0xaR0MVuxVj8h+pK3a4KdJzsmpFwgXzwoiwMqO1EJ2jkQ2QThbLZsscjHm5sn
         GoPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=gzMcqJw4PFTe0iaVOhhDJ3isvB+To0xFXsTzORiz9Ow=;
        fh=Zkewc28i61SqjCJtg6YkQra0HoWniDyGtr2B2kBEEJ8=;
        b=S/5QaG1wybBPxunI+BO9zdJsWi+CBM83f+OtaGZzdO4mtDP6ERywTbe4d08HwpxLVn
         NP2VDxIFGqXWuNvjPfNYqLr9DyCzBmm5JXIOYHTCmTcnOkbwPgiSW9XlLQO6Rp/+AH2A
         tvCwMwlHCKWOq6SM5v294Cp/YCd3VLW04Kr2xk8VqwGcZTp1f4w4YQLCWbpsKrso0Nyi
         mv/xUcEIYS7Te4gtghdho9Uxaux/bcrfCTXKYFBR5d9jNjGXsKLVvEpA1y0yegr6FnMJ
         FggoemF/glH94Z1xpJSF7MB5FPNorSud0Q/ILt8g0A76Y7ZfXsV+vRkJvA5YIjxThm5e
         6njA==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777247856; x=1777852656; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gzMcqJw4PFTe0iaVOhhDJ3isvB+To0xFXsTzORiz9Ow=;
        b=jsAvDvw/uip0oNtl0YvIgXwqUdYpanRDoeHwBhmJ9CSTqtk9yEi5TUnymCtXFefzjo
         uvzxkxq3W78qW5mr5jtV+GpcqtxYzsge/LAPrFoEuY6eTT05TslJPRWRnB9LAojiR5iw
         NaUX6QtOz+kaEsDxB9MXNat6r/lll0Hu9nGjPK3jRxJASZummsg0Og/DdAamSnC4Aslx
         SIRYuxXmi6jhfoqQPVGACxxqlMh7zzqI3YVOiP7V1Zeae8x0u61DZpVyfPpviwwYnb4G
         Pkv/XX4mTVC5OwyWodVERw5pGBdNO3vCRLs+l6G6DRhVh9q2XHc9/Bd4LP6zPcvC+Ci8
         bejA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777247856; x=1777852656;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gzMcqJw4PFTe0iaVOhhDJ3isvB+To0xFXsTzORiz9Ow=;
        b=nNbueGPUHeLDnJ97YXaiR+ifOUnVnb0Gxy9t/lAcMzIO5DV9ow5sLpN2tOj7B/rOAo
         wxeWxeG9PVxhfx5bcr/8qClHupR3U2l9M1JqpS2hxT2BuaMrId2c04kCSXliwuR9uROz
         d0M9iN11/UQzFN79QUWwgpZ6jmUHcnASZ6OwoYObJti0vqqWTmthT3tzOc1Kbl8A9Q18
         8Z9vPkNaeLro914khfNWo/ayTzjUal2AP352KXZSW4BpgV1vPzsLL2Ku73JROLuYqwhu
         ie1BAurj6pkwTYUsbM1amnrLj1Rce7WPafVpCF2dn9aKtX//8GhqWtuvWihrNbBvHuA7
         d40w==
X-Forwarded-Encrypted: i=1; AFNElJ8mPXfW9LS1HPUwx6eUvAmW/OJrtleskXQZpon9lrko8GJzsmRFAuQQIWG1zyShGEfPrGzNSPwY5Jbt@lists.infradead.org
X-Gm-Message-State: AOJu0Yy8VU3Xwb6rEl+9qB9MM2jxWAHxjDpPPNutVaielPV3+aaWgoJz
	nW6Zi5hp5PSORG1M9TyKPha5gx/JmyRFb0Qdf7U/p4tqci6H6DmIkNSwZmpWcVAWU5qy2jM+PkB
	QVRZtfV4nIawq/ecj72SQfCPZnWDAO8LafUgH
X-Gm-Gg: AeBDiescJKmxg+vg1jbOLa266xUXE4w0w/Me+8mrHLPRFWunImdrz1naiRkwyhEIh68
	Hn6LcRRvJxba2tW735C1tSTp7R3QKCEYUFpupM3QTppWKgJhHteNjHBss/FGjHzxoirbJ2eO2IX
	se1Jnk7Vd0CnAa+QcaHiDOolQdYOLNRhj4Toteu+ZQLafH357epQQjQclDOpKcAfGV9zQ3Z5Xhs
	WGzqBO9atDEUuC27bLfqvnUAPDTqc0CJCapl9UC3rOC6Hc9TklimYaa5SGrbC0XmPtpDNEw18c+
	BLZRVM9akqDXQYLv
X-Received: by 2002:a05:6000:61e:b0:43d:6fb7:fee2 with SMTP id
 ffacd0b85a97d-43fe3e20b32mr67042199f8f.45.1777247856263; Sun, 26 Apr 2026
 16:57:36 -0700 (PDT)
MIME-Version: 1.0
References: <2026031805-stretch-skid-ae5b@gregkh> <20260319012630.1802025-1-kumar.shivam43666@gmail.com>
 <DH6LLP692EBM.4N82LTNB60WV@arkamax.eu> <CA+ysrSLau_52n+4JMvQ=EtqY-cyWhhZ_pLOyeNL=mwkjkNvoUw@mail.gmail.com>
 <20260320074825.GB14485@lst.de> <CA+ysrS+9bWdF1LvxoZaZW_JLZ97H-RXM548Cm8ZW5KQAD+NCLw@mail.gmail.com>
 <20260407063000.GA6992@lst.de> <DHNK8IM7F6PF.1LX1Z2KTRK5JO@arkamax.eu> <20260409060835.GA6389@lst.de>
In-Reply-To: <20260409060835.GA6389@lst.de>
From: Shivam Kumar <kumar.shivam43666@gmail.com>
Date: Sun, 26 Apr 2026 19:57:25 -0400
X-Gm-Features: AVHnY4JTv92o3YATzCjv1YGzLQGx4GBTTmXlBIhBZkcoyAXOnS8xobkUW8fkudE
Message-ID: <CA+ysrS+fsJQ+4x7jHoSEX_tiYRQJC8LEhuH2stKA6Q4qSK-MWA@mail.gmail.com>
Subject: Re: [PATCH] nvmet-tcp: bound sgl->length check in nvmet_tcp_map_data()
To: Christoph Hellwig <hch@lst.de>
Cc: Maurizio Lombardi <mlombard@arkamax.eu>, gregkh@linuxfoundation.org, security@kernel.org, 
	sagi@grimberg.me, kch@nvidia.com, linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260426_165739_333551_EDD17C9F 
X-CRM114-Status: GOOD (  17.31  )
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

Hi all,

Gentle ping on this. Is there anything else needed from my side?
Or is a consensus forming around the 2 MiB default?

Happy to send an updated patch if that helps move things along.

Thanks,
Shivam

On Thu, Apr 9, 2026 at 2:08=E2=80=AFAM Christoph Hellwig <hch@lst.de> wrote=
:
>
> On Wed, Apr 08, 2026 at 08:30:12AM +0200, Maurizio Lombardi wrote:
> > Personally, I would pick a default of 2 MiB, it should be large
> > enough to avoid excessive splitting while still being reasonable from a
> > memory perspective.
> >
> > Sagi? Any thought on that?
> >
> > I have seen a patch on this mailing list that makes mdts configurable
> > via configfs, so in case of need a user could still change it
> > to his preferred value.
>
> Right now that just allows adjusting down, so picking the larger
> value sounds sane.  We can still increase it later and/or allow
> adjusting above the default to an upper cap if needed.
>

