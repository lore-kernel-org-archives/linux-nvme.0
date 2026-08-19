Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F443C5B572
	for <linux-nvme@archiver.kernel.org>; Wed, 19 Aug 2026 14:36:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kDjXqP8m0kVACEIX1owlQEem0wUj0wazig15t7e9Pq4=; b=N0sBnlfRAxAJlJDRU/z9P3HNA8
	J1VJs7IN6NBamMvq6tjAjQT6PxUKXyhTuMs59oyONMSgkSEAriFg00CsZI8vzzlrMITNXEbT22tOb
	s4lL2naXOAKEFEaJOsE5NRwRYAQUhUDdE+Uv3+TrZ2dlNC3lv8pe4nbuMXee8dbeJNv/r+IO96EoR
	2F88lbH0ysQ2n8P2w+CYr48vPfFUZtFdAductHnoBipARxZwCvdIqDiiMK/r246mZ/XFvJxjnXR8o
	IJw/0DGfMT8v6CvWb1yNCbt32QyfieUi3tAsyNQnPuiS/BpDcuDknIuT+i3K03RvtTiNuNySixGJ/
	7Hr7NiOg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wwhPC-00000009ziV-25ot;
	Wed, 19 Aug 2026 14:36:38 +0000
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wwhPA-00000009ziC-3HDA
	for linux-nvme@lists.infradead.org;
	Wed, 19 Aug 2026 14:36:37 +0000
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-c15cb6f5c12so182315866b.0
        for <linux-nvme@lists.infradead.org>; Wed, 19 Aug 2026 07:36:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787150194; cv=none;
        d=google.com; s=arc-20260327;
        b=QeL1q6fDvQmN96qS2H185kG7KrDEzK36TVJkoMccqRU4nssHH5atB6s9ADUsR8ct18
         R5tIR1p+1HnedXmMqoNZfeLmIcILx0TmZTtU/2yxwuiSlji4kwhjX/1LQ+bXfJMBMCvE
         hu/H8iw/eTE7VUn5G4ExWFqZ75urtJFCdPXUPOICkF9Of4vAPFNjxjlybbPkuY3mtSlI
         7MHyo4oqhc58tqdPdywJmtHtVJnmh+T4Zaxs1XIn43af9M+lg1HRlyVwIHkagjLMdfLz
         avqYt9Yjd70r1U89maeLtkTqA35SztosUat30QN5difoawXu7YXaxAzH7fywXHxAzUbi
         aUaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=kDjXqP8m0kVACEIX1owlQEem0wUj0wazig15t7e9Pq4=;
        fh=bs4ejtUM1pFIx2ezUWZf2MZERyPwgMAIzDVMD41P0Cc=;
        b=eHVC4UD5yzdDS1WJSThrhXEmD0tFleTPH07tuwDeBg1sFUTeeawyHR5GvT2y+2t5v4
         FBv1NNXlEMfxNTm79C+BoieM5I6Mn5nhq6HEaCaUuGCPMgECsAZB/VGy2v+iRopgcYBA
         hFSspugHsnGUAc7bO88xwhbHJhn7pnp/alKCtvHZG+DSG5wv6a+4qulDQwk2NjDTiRce
         wGANjgaC4F6rGoRwESzMar1fFlDGWyHrIvZOj34L8Yxjo9Cx2qYHblfXUwBHauk5FXcK
         WP1lYgZpb0DZ5lWnHlvVI8NWmZI1qkvOQxuvElhZ8gySt6hQiia5vEyVq5nLXpOXHQHl
         /J5Q==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787150194; x=1787754994; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=kDjXqP8m0kVACEIX1owlQEem0wUj0wazig15t7e9Pq4=;
        b=aPM7RHrzPXnbo0t0BLiF8qszGzcK9kMFPAYXyT5Zk24UQm3j0joeGMhL0eNCwWm3/t
         qESq2f8WXJ5rFZW3CxaWQ8KyBvMO/jd8cxounz+FVf31Ml3uazsMFu5EFOXoxC6Q2Tde
         sKOSwSnc+EHD+78Av1UjzKjk2HrFuzBpfZLmWJTuhf5RAtpYTwiid6HofgJjmiltDU6x
         aRRVDS/ne7CDn+/Z71E0kogcImNnvXYQCzw4M5HLMx08ueLxLIc6j0sqsefhvq2Gr1nn
         /+ro18epoLfJg9mKzwpxIvOO2eKs7qQcp6yK8rUKmbWReS5cM242IUYdaq5FxRuyrxvR
         7uDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787150194; x=1787754994;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kDjXqP8m0kVACEIX1owlQEem0wUj0wazig15t7e9Pq4=;
        b=q2tE9ZgP6Cv1ODPeZcZIjafF69/Ynd3YFgyIhZAoc9euj6DzRjewIZZowHJ1lyw8Jf
         WUxTNnxK65J2icgVmMrWWohBXlf7hM1h8vhyxAvOKgzh99zNfFn3ek6HczgDY0Er7X8q
         CWVtqaenjSO4Omum6VF0rsDJu/LA4Gq3YmWDGYWOn19AsW80dLqzXCsNTdwv9XeKrry2
         dEtHUoTsXry+RkUI2kpsSwJettSAd7K9QwygP5jucRp1WB0cJe7Az3x6zUd38YINlj/l
         psCFEHXx39z23CjFmEMahZWQXYHs1YypDpWjXAW9CA6TgJGBLpPrYw2mK8pHJLRfsECR
         U/LQ==
X-Forwarded-Encrypted: i=1; AHgh+RpzmQzpw40edzKQd+F8lzcldwrn/etZgasqXowz2iqBz8lqzJTrgT7NErLfCL2rgUWABAjgGJTXqaGg@lists.infradead.org
X-Gm-Message-State: AOJu0Yw+/BheLiGD9NLvqjYsXoj5fa+SxTl7UZyIbn59oS62AVDuYKHZ
	9CLXjhYt0liVA4YYrhGfdDNWI222oOQkJa2m7SAkPXMLokU/6A5ueJiBEi1Z7x/6ggNi22GL9hY
	kXcDe5r64KxhunEuf2A/h1vQQ/Q3cJWc=
X-Gm-Gg: AR+sD10jFMU0RC5DNyqNYh5YyP7yudf/ZZsF59z/OJKUsbPF5BlLj55EtNGF88W1lf8
	dxdLBQxeP9LFeZexnPcz8kRFe7fFb7T0J+4gmqALyP03ioCEnxW9VI+bVxrOMFAbI0OI+9p17DV
	2fYtQD8r13Nyt8ES34YPdZcBf3m5TrTkYprus70DlxL5UXo+91R2GWkcx/OfeTwmu9ps3+C1eYn
	Nmr3QjjYfW07AVlNtOOernbsLO+FJuLpp5gXxNLH7lS9uohSH3COWcVTOUI9lzW+ij4HEY9TRTJ
	w9kEfcR8ShNuYVygCgTgiuBIlwgE8I3GnAnlwBem2OMNBw==
X-Received: by 2002:a17:907:d382:b0:c12:3059:4071 with SMTP id
 a640c23a62f3a-c242e21037cmr389133366b.15.1787150194142; Wed, 19 Aug 2026
 07:36:34 -0700 (PDT)
MIME-Version: 1.0
References: <20260817175859.2966055-1-coshi036@gmail.com> <20260819055219.GC326@lst.de>
In-Reply-To: <20260819055219.GC326@lst.de>
From: Chris S <coshi036@gmail.com>
Date: Wed, 19 Aug 2026 10:36:22 -0400
X-Gm-Features: AcwNN1WoGj_WrlxBwgGBkMOQVQx5sPpl7pnF5ffM10kKDwbOz4EwrE2E8ISW4EY
Message-ID: <CACd_6n2d3XF1YfRFjm50pjZD4N0D7nJ18iEOx5T=pK6TcW7FFQ@mail.gmail.com>
Subject: Re: [PATCH v3] nvme: skip the zoned limits update if the zone info
 query failed
To: Christoph Hellwig <hch@lst.de>
Cc: kbusch@kernel.org, sagi@grimberg.me, axboe@kernel.dk, dlemoal@kernel.org, 
	joshi.k@samsung.com, linux-nvme@lists.infradead.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Weidong Zhu <weizhu@fiu.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260819_073636_824998_7AE5FBEB 
X-CRM114-Status: UNSURE (   9.31  )
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

Thank you so much!

Best,
Chao

On Wed, Aug 19, 2026 at 1:52=E2=80=AFAM Christoph Hellwig <hch@lst.de> wrot=
e:
>
> Looks good:
>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
>

