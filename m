Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F3D8CCD1AB
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Oct 2025 06:24:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MnZkr7TjjA5oyXjysydnhLnRes3dsjebDwBOG2wiF6w=; b=WSFFN1kFv421Mtqduy4hsPYiWF
	aXw6VDF6HpFftZRf1ZmZA/B9X8hS3vJEDcwnZtvBbxCi4LvxeBbaR+fjNrdLE+cFp36ux8I0ow15N
	Frvp1LLKMEwv52aP1fFN9YkYYIDAb/8UO5CSR00Yo3bIIEo0ycrX18ype3W4OzLyBj7V/OMr+t7Wh
	9dNOwO1GAJN2cEPEfV76d9ad1uA8iJZ6fLlD7VWGvI8tHQNDkpEntL6RsJueVW3dzpN0vmkX2oapZ
	TGuOPPt3VSLuAA4IuHFDNRDNOAmw3BhZKuf1WF2t6JzJMnCUxZZp0hLfx3+eDKe3CSAfBH4plTSu6
	/HcG9FCg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vBSHF-00000001eUG-1pJn;
	Wed, 22 Oct 2025 06:24:53 +0000
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vBSHD-00000001eTp-0IW5
	for linux-nvme@lists.infradead.org;
	Wed, 22 Oct 2025 06:24:52 +0000
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-7833765433cso8106689b3a.0
        for <linux-nvme@lists.infradead.org>; Tue, 21 Oct 2025 23:24:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761114290; x=1761719090; darn=lists.infradead.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=MnZkr7TjjA5oyXjysydnhLnRes3dsjebDwBOG2wiF6w=;
        b=g9yDypWRrgovKv/g2QgNNe6HitblDtlw2GD1dsu3zDa03HCoUaFwtx9jUDmGN5texm
         psiJgCXlwheb0YLcpb7075X2Xm7DXGgCI9Jjq7oWhlKnKdVvblbcZb0DYdPpZoaIxa2u
         U+6ThnV/DnKevPxWqo94w5LzQntusxJ9k/FDcXQwQPl2pGvo16n6+3u8aFMXvkAag4HB
         Le3YH5TSypHi7DDP+dBIJXm1aduyjpzu6zDDy7f9gbxcaEV4hMlyV07Fdx84Z5eeltYv
         rozjYtOgZJzKkhtQgwrWAtCkml8KpGYJ+HOqmGSW8HwLrDGpRaoUQzMm9I0qdhCVB32a
         PJiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761114290; x=1761719090;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MnZkr7TjjA5oyXjysydnhLnRes3dsjebDwBOG2wiF6w=;
        b=CIFuA4peB+7SmkGWXGSxM3UqaWGwdei8p3AsPqQWRRtS3tqK8tBMs45gl2pxfbKcQw
         T9PdODxkFku+ulUdNdagVobltLgW45lu51LefeIAY3U0utiEmSzJ1XOhKRVWjIsXtbYb
         k/B4GqbNWCNeDh+2WFJZBeTvZnf7nLwdj+/SOVdPm/q2UpV5rlO7rR9zLNTyt022CRt8
         OgXnqz7ugTyo3gg7Q9+0ldnDOKtyag4X1p5+0kYI7PvUyhZ1QLqUVf9F0VRbACcHMcsE
         Zl+MCCswT9wMX4ZPpQKVMIvTSeFkVLrYOuPpoK98bjV9/O0ubf7pN8bZEy0/bCuLXJc0
         W1Ww==
X-Forwarded-Encrypted: i=1; AJvYcCUTDO0w+UgDd9/8ATpHf7pVAwiA9sYfVp5u0eEcRav/E0YhzX9KvAmXpFGeK2o0B6x+52E3TfCB3DLv@lists.infradead.org
X-Gm-Message-State: AOJu0YzkB4Gfd6+OiTyCfOlmFEEM4UH3c50lurwmNpq2mTVACB+bWhhO
	xFIAL8MFMKT29fZ+4SjnvTwJ309/Cg3MtGv0MdRWnLYaUPqXr0JYD4xs
X-Gm-Gg: ASbGncsUFnydwOP8XBdZXHKtBt5YtULi3yxuZI0bNo+FJmc7bxcUcioZ2chxdbVrix1
	TNlmnm5Z7H8CuxK2ST6pbcxtM8P2VAWBQjQ2LQ14/71vmdDyPzohLR+lpSXbHPhczk376Sf7Fwx
	KIhT4qpkgDyPgHDt8EYpekaggqFwKFPEV5Yt5wYHPjQAC9s1apsdFWi0d5Vrz9iZkaPZzt6MBnu
	XNSkjrDgsKK4Idj9ywhUmFN/F3rXb/l3NFlQdPXok+y/1F3ddLHVNbTV1zkzlVdJHGRXbWPOF4H
	8R3BZlhZgzN8z9QNLRraSleaDJOc+J9HMP9hQafeqEyzl6FTI2PXtcnCxLI476hYDzkS/FtAQpk
	D+plQDKPMm9FFKD9sYsKu3Qye3ehACbFdVouwMPNGTJ645FFJlb8C6EzW7eglKkiIFx1rzb6J7H
	ujHWfr/a6E1auCwNyc47M=
X-Google-Smtp-Source: AGHT+IEgKwi/63UPErEmWe9jK1Imyd4ft7M/bxL6w0CSUK3SnqWRR+2qFCNjFY3yItXU8IxKbojv1Q==
X-Received: by 2002:a05:6a21:6d8a:b0:334:a180:b7ac with SMTP id adf61e73a8af0-334a8616ff5mr27091997637.39.1761114290218;
        Tue, 21 Oct 2025 23:24:50 -0700 (PDT)
Received: from [192.168.0.69] ([159.196.5.243])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a22ff34ba6sm13441565b3a.18.2025.10.21.23.24.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 23:24:49 -0700 (PDT)
Message-ID: <ee6739203c5dbd7452541a3915636b597b34848f.camel@gmail.com>
Subject: Re: [PATCH 2/2] nvme-pci: Add debug message on fail to read CSTS
From: Wilfred Mallawa <wilfred.opensource@gmail.com>
To: Gerd Bayer <gbayer@linux.ibm.com>, Keith Busch <kbusch@kernel.org>, Jens
 Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg
 <sagi@grimberg.me>
Cc: Niklas Schnelle <schnelle@linux.ibm.com>,
 linux-nvme@lists.infradead.org, 	linux-kernel@vger.kernel.org
Date: Wed, 22 Oct 2025 16:24:45 +1000
In-Reply-To: <20251020-nvme_probefail-v1-2-a420046d98f0@linux.ibm.com>
References: <20251020-nvme_probefail-v1-0-a420046d98f0@linux.ibm.com>
	 <20251020-nvme_probefail-v1-2-a420046d98f0@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251021_232451_109692_DD14EA44 
X-CRM114-Status: GOOD (  14.91  )
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

On Mon, 2025-10-20 at 17:29 +0200, Gerd Bayer wrote:
> Add a debug log spelling out that reading the CSTS register failed -
> to
> distinguish this from other reasons for ENODEV.
>=20
> Signed-off-by: Gerd Bayer <gbayer@linux.ibm.com>
> ---
> =C2=A0drivers/nvme/host/pci.c | 1 +
> =C2=A01 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index
> 7544c4bac2c4a230d32cf729abb9e94bf93a921f..c3b0a9d56ac1f32f67ce0890bec
> d6425eb80ebad 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -2906,6 +2906,7 @@ static int nvme_pci_enable(struct nvme_dev
> *dev)
> =C2=A0	pci_set_master(pdev);
> =C2=A0
> =C2=A0	if (readl(dev->bar + NVME_REG_CSTS) =3D=3D -1) {
> +		dev_dbg(dev->ctrl.device, "Read CSTS register
> failed");
> =C2=A0		result =3D -ENODEV;
> =C2=A0		goto disable;
> =C2=A0	}
Reviewed-by: Wilfred Mallawa <wilfred.mallawa@wdc.com>

Wilfred

