Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30AF2CFD376
	for <linux-nvme@archiver.kernel.org>; Fri, 28 Nov 2025 12:58:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nNammxq+ggHJRHkPcyBw0qZgJjTAIfnPB/5V2CCXd5w=; b=pbqbfVrZg2GZDZBCuq1dIi7kjO
	9+Z4UMgI7J+I/eVpnEbYuwJN+Va1rJzFgOYB48buvmY0fVCuUeO+danKaceOxd5VWnTS1PtaAi96E
	MJqsWVMxeUoCXAIAqghUepk9KcHoJps4DZz/QLqSsI981mdPQXg+vxQR0qKT1jEX0FawW3uMd0eQc
	2ckCd/A6HxEY9Y1t6NIYM7XOQveBHOZVGE7pT/I4vRdggArmexcNgRQOjiMOO1zdgIQH0JjTy9usG
	Kr7SlJharH8kkrZI6sQddr4XANOeUXV3NQOSgIplmuJNEpq8bgpJvJc+Lxs7vMP3cQmGcINZdA63I
	kCW2DRjw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vOy3F-00000000S4J-2T4H;
	Fri, 28 Nov 2025 12:58:17 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vOy3D-00000000S3d-3tqb
	for linux-nvme@lists.infradead.org;
	Fri, 28 Nov 2025 12:58:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764334694;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nNammxq+ggHJRHkPcyBw0qZgJjTAIfnPB/5V2CCXd5w=;
	b=NiGPlu2LcA1cx82YdOuKKX6/J07YnJm0lMvHxNP4GVjb8FxhVPd79diVjfw2hSntZh7Xj7
	OrAmJSLhbRlPguUvXegQeOKCZaLyaoOyThXP/60LSzP/cT55Jsn6m6enWGTCW06mVdAIS9
	DLqNM4oxG21gx0GxUFwYd1HtoKMfNo4=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-272-LxYOh7XNMp68wGDIXHiHTA-1; Fri, 28 Nov 2025 07:58:11 -0500
X-MC-Unique: LxYOh7XNMp68wGDIXHiHTA-1
X-Mimecast-MFC-AGG-ID: LxYOh7XNMp68wGDIXHiHTA_1764334691
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-787ee7b3ddfso22825317b3.1
        for <linux-nvme@lists.infradead.org>; Fri, 28 Nov 2025 04:58:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764334691; x=1764939491;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nNammxq+ggHJRHkPcyBw0qZgJjTAIfnPB/5V2CCXd5w=;
        b=V9CJjUpiCOCheH/rrF/KyHaVxtczXu35TYIAoepFZX78YvlsdgIgJBvH/YQj4Xkj9w
         Me+O+sW3bqbaXQ1kjx9SfTFs/tDV6LxKUwN2Oqg/sFtEvvmtjnuKSqFm+AMS1E8aeCFe
         64zbKH39UV3bySSFtpZlthFUIQN0eHQj5Jwc9wOZVSQXYI7yNw9zdtExXw8vramn3W7Q
         Iu1eUIWJFaw+CemHLCwcD3eccKZJTJuuzB3OgvokuCqKeh9HM9XF5UkfNzaEr0ps7B2k
         cOFdqNJZR+53wKk226/1iln6rBU0/IONf2/lsFwGN+vxr6f8jMK1mex1aU1v64Jt6TJN
         ZX8Q==
X-Forwarded-Encrypted: i=1; AJvYcCVpl5il2llF18QxRCIOG8MSJh8wiy/iVcNUH3U+HSTOYdrKh5Ksaj0FpzmJEpEOE6TPgAaqMDrH8r35@lists.infradead.org
X-Gm-Message-State: AOJu0Yzxz1NP1oKmNSBHCKo+f2SLwIsRKnQ1QfjOJP6Ge3cFxiQEDFxF
	wSugFi3B0bDhULN2M9tjvpuiziiEiD2adyC1T7QHSNDFNpLkU9/l0zqaG3AQ8LWWhNmLSEqjBKv
	T4h72H8c9T30OcJklWEsPUH/GvCTemw+JE6Gk6kE2OZ5Uh0Vj6qZCAk5f9Sc3liHYy3m4lNox/e
	maQhCv3oeYzRJFcB21oBCPNulpVPICwBebRoW5BbiCYa8=
X-Gm-Gg: ASbGnctQt1IJhO328RnWcEqPL+LHqS07XhgIgP9KguVWI5md3TWmBm5vlxDwTPNYPB0
	FiNQXgQpjQUiBcCwfFerI0AO7R5XJUiw0kf7Yyxsx9WKkWwS13heoieGgpY7KrA17FZ47wLsdQh
	8yvzW36NmB9KgXPgs6Cgvo1IePq8YxUS1/MwCtcxo7yHfez+86D3Xz7iuYM6nW+Shm
X-Received: by 2002:a05:690c:4c12:b0:786:68da:26d6 with SMTP id 00721157ae682-78a8b47f539mr225392507b3.2.1764334691006;
        Fri, 28 Nov 2025 04:58:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE6o2vx3XDXGg+LlkIovRC1qPDpHivJwIyySPFZW+LOu2PT9QpULnJt3ZozP3PJjgQPuJtToIp2pCOkRf4ONwA=
X-Received: by 2002:a05:690c:4c12:b0:786:68da:26d6 with SMTP id
 00721157ae682-78a8b47f539mr225392307b3.2.1764334690627; Fri, 28 Nov 2025
 04:58:10 -0800 (PST)
MIME-Version: 1.0
References: <20251128083219.2332407-1-zhangshida@kylinos.cn> <20251128083219.2332407-5-zhangshida@kylinos.cn>
In-Reply-To: <20251128083219.2332407-5-zhangshida@kylinos.cn>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Fri, 28 Nov 2025 13:57:59 +0100
X-Gm-Features: AWmQ_bkpqINzOqnBww77x7L-xnpoIyN1fhsiEmRMn1madN6s7Ak0j6O_sI0bIl0
Message-ID: <CAHc6FU6dmK1udCgj9vMj1ew-4+bZOK7BA47kyEgONEwGg42veg@mail.gmail.com>
Subject: Re: [PATCH v2 04/12] block: prohibit calls to bio_chain_endio
To: zhangshida <starzhangzsd@gmail.com>
Cc: Johannes.Thumshirn@wdc.com, hch@infradead.org, gruenba@redhat.com, 
	ming.lei@redhat.com, siangkao@linux.alibaba.com, linux-block@vger.kernel.org, 
	linux-bcache@vger.kernel.org, nvdimm@lists.linux.dev, 
	virtualization@lists.linux.dev, linux-nvme@lists.infradead.org, 
	gfs2@lists.linux.dev, ntfs3@lists.linux.dev, linux-xfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, zhangshida@kylinos.cn
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: nNoO69Y5y9PItDxo75Vswz0FSjtyOLcRzMjbbkhHVnA_1764334691
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251128_045816_037855_587C36FF 
X-CRM114-Status: GOOD (  17.37  )
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

On Fri, Nov 28, 2025 at 9:33=E2=80=AFAM zhangshida <starzhangzsd@gmail.com>=
 wrote:
> From: Shida Zhang <zhangshida@kylinos.cn>
>
> Now that all potential callers of bio_chain_endio have been
> eliminated, completely prohibit any future calls to this function.
>
> Suggested-by: Ming Lei <ming.lei@redhat.com>
> Suggested-by: Andreas Gruenbacher <agruenba@redhat.com>
> Suggested-by: Christoph Hellwig <hch@infradead.org>
> Signed-off-by: Shida Zhang <zhangshida@kylinos.cn>
> ---
>  block/bio.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/block/bio.c b/block/bio.c
> index aa43435c15f..2473a2c0d2f 100644
> --- a/block/bio.c
> +++ b/block/bio.c
> @@ -323,8 +323,13 @@ static struct bio *__bio_chain_endio(struct bio *bio=
)
>         return parent;
>  }
>
> +/**
> + * This function should only be used as a flag and must never be called.
> + * If execution reaches here, it indicates a serious programming error.
> + */
>  static void bio_chain_endio(struct bio *bio)
>  {
> +       BUG_ON(1);

The below call is dead code and should be removed. With that, nothing
remains of the first patch in this queue ("block: fix incorrect logic
in bio_chain_endio") and that patch can be dropped.

>         bio_endio(bio);
>  }
>
> --
> 2.34.1
>

Thanks,
Andreas


