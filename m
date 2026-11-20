Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6150860A2612
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Nov 2026 18:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=gPrn8yCz;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.a=rsa-sha256 header.s=google2022 header.b=Qi3rtRSa
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=GnsEcx87GzzaejT9L6e8FDpU3hLwBs+MljkBJ8PhOT0=; b=gPrn8yCzKbyO2L
	WQDmGAaXzASc9ub7Tci3K2p0p5IWGONW1iGy7mpkYtgBeLUHxCnAfymt7eJz7KH/zJS86XN7mNdBQ
	R7DZp6IgZ4YUos8KAGJMzYyLKjJ1LBSbLDe8aq9y0kEKtZ0/MaoTBK9OfuPwvhrBRiEkcOceKtWpG
	g/Gp8SwCRE7LVWW779Fhi9RnMc4jdb066iQheAxNrCXx2DQdVWYtArFXWzOXl4GW4uw5cSK0DqnWE
	vbCI/doji5ZauXZ8Sk7XwHV2cA9oHBOLaBH/GvG6roBFGrS9sDPKdjRVF5RCK0bJwpzJFNPlsqYBn
	VOtZ4LgoJFL9v/Pj+Tvw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xUSxj-0000000Fqwf-1c2H;
	Fri, 20 Nov 2026 18:03:51 +0000
Received: from mail-oo1-xc32.google.com ([2607:f8b0:4864:20::c32])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xUSxe-0000000FqvF-1kOl
	for linux-nvme@lists.infradead.org;
	Fri, 20 Nov 2026 18:03:49 +0000
Received: by mail-oo1-xc32.google.com with SMTP id 006d021491bc7-71acd8968cdso59144eaf.1
        for <linux-nvme@lists.infradead.org>; Fri, 20 Nov 2026 10:03:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795197823; cv=none;
        d=google.com; s=arc-20260327;
        b=boWXSfP/yHa8tWk6NHuemrjqBdb4exz+6YGv5N7TSV9DU6pfACcYuQ4cx95tdYokaC
         7sSSoAklgWNC3WYSQK+7wCi8Ni06JArQjhrlI5tIardIPa2qtlm/TtUl9PXRcnTcRol/
         zPn7BcbyCUiKbGZO5siWHsEyY14/+zzVs7qyu+0Qdg8uBJSFz3q07qKlZG9avvTGsvdK
         v7vXg7nodO2OixObm8K12u8IiI/0CZ1cPBc5fEvgZn3kfbAAkAjCq8Ze9b4D+4BXBcWr
         jRnhvqKIx86iyRRvJB3pa4TxOC/8B9WpwhDKkwvqzphmIXe2S8/FWPbvN8huja5Uah9P
         GMbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=GnsEcx87GzzaejT9L6e8FDpU3hLwBs+MljkBJ8PhOT0=;
        fh=bMFw5jp58w9cR9TVFQqakrJseQfaccOY/6lSrUKWJRU=;
        b=Fe3H2kmtSrr3wsEmAgo9Qx1OquE9Ruewcvro6H8x6mhR5lfMAFtbMKhSkakNsL+ZTE
         9xV9MToLZvgpCe+MIrUq++1s3npTUute7IPLDe+vL4twMjqJze7fLNMZziJJA8mwmqvz
         3Yn5IY3bKo2FTQbUcJ2AlslGBzAepzezsnnJzmiL30G+WYvHZ1f7H7XKE4iA49NJTr1i
         HTsyuhW5e+raV8Gp4ciDcZvU5UNqSdrIe25WgRQWrQzgxYib8BGXg/4LGpNjrSq5WTqD
         IcF9HOt6GnLN80eZoXeNCHYgbpiFFX3mweC/9kahiMYyuvSPnMjbJD7G6WpUbFTy+CCa
         hH6w==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1795197823; x=1795802623; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=GnsEcx87GzzaejT9L6e8FDpU3hLwBs+MljkBJ8PhOT0=;
        b=Qi3rtRSa7Fu2SpWEz9Xj2M3W6sgcUl9JvKf5bwf9J2jH4sNo3lyz9KBgyBHLNYj62j
         DvkOLOKlDZ92oeWk57GnOjeYgHcwiPdB0vM5h4fDwkC04SHY7cRDj1kN7bt5QbtawRzx
         Zxn27XKGkk0vlqln+/mh920ia6D4W2AT31SOHkH9yLGc7Th9CkVGvoZbn59zFKHB+ryE
         Yb49Ix+SDrdjUajTTxixUOsQbBC/gYJ05UD+a2i77VztxpcpmwJt6TY1rSERoWforstt
         PuYxtjk4Zm8bb78nb6L6P1PmD803Piru+aJqMXyJTQ7Th/FWF1sSkGSGWKmQOru/dU8E
         VHug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795197823; x=1795802623;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GnsEcx87GzzaejT9L6e8FDpU3hLwBs+MljkBJ8PhOT0=;
        b=C014AmNarjXOPTPG5gQgMXi0E3ccH1FfjKxV7ZNC6JG//SWFk9FyZU28XfmMwSDpy7
         I9q8pDKRqR2Z+VW6/5te5f4V35EmCGsMGgGNOz4z1IpEVSR4bulm1kSOf2UztsCNO4iO
         r/u9hnwcHDIPenCbw3Um6R4m2g8xmRTgdEKc/93H4FLGq63gp+CqKzXcIQTRqyDsS9Cd
         3xtRhcYJeaAZ7ECFqO4z0dWU8LxSLlyTbSGyPlMsaEgslJPbm2DhQ46rRwntpAvgmqRo
         dPnFXYeGpwzdWBwJnEoDtzRY4QtCOkv28jFoHf/kDPbCwMtiSmlc1DnFamJZlv/LynWU
         id0A==
X-Forwarded-Encrypted: i=1; AL+hErHCQiqhODXEQvJKIA8Sf2mkoNcitIMrRwsj/YW19bhhriEcqIpKm2xUByZ6LSQBky08ZJzDgOsJYs+B@lists.infradead.org
X-Gm-Message-State: APuU4Z8Jw4cCPdI//fX4n0aARNZk5gX0SwSBZ/AlvSrzAzMWQTpbdxik
	5XUYVPRKmvYOj9hR/TGpFPiJM0NF9gSgIeuaFzIcJP9/Z0g12TP8OGW2F6H416DnI4ssotvOoKn
	87wwE7eYimPTTbQ8WN3iFSTmOo+5MMXnrNGFggjBfaA==
X-Gm-Gg: AYBFou35nJ+Ezf2CRItd49VoJ0//q7jkIqqfN4VbpILOkIW8vjAUwB7VI3j7svCq02M
	s1i5tk6nmEiX6F7OMlEqqZdyL/sGNzirYTrrnE07H/vBdGeXxSE9I3OW0ZAfUvyMJOdS21zMYyo
	l8+vA/shLFSll58/hJ1SSsX89FxEm8S1utpApOTaIPW/NsFMl64SdaG4XgVP34ZKEFpW2YKCfwi
	It09YpqtmlyrdKnr/3EBRJ/kH+3kWr9l91xY7tObInb9WGXfXgVw8xB/11n15LBUCFXbwb8buXh
	+MatKDAKu7duzL5gRTHZ5pcdSEePqkYALiaZEzWnAG8iyTCOS947KojyJmFa1J4TpzYUpn1guHH
	PV0eq/Cebb1T0iMu+LT2ZUK/lcc0/BJjEODtwDtq1L0RXeD9DxKUtPHwFDw==
X-Received: by 2002:a05:6820:840d:b0:71a:ee8a:5d26 with SMTP id
 006d021491bc7-71b3903669fmr3370770eaf.0.1795197823321; Fri, 20 Nov 2026
 10:03:43 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <202611150127512368BGQ07ZNIRAIwClkam-8u@zte.com.cn> <20261115012754244CUh01sEOwZp4S8maAbDDM@zte.com.cn>
In-Reply-To: <20261115012754244CUh01sEOwZp4S8maAbDDM@zte.com.cn>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Fri, 20 Nov 2026 10:03:32 -0800
X-Gm-Features: Aa3M54pd1WfunxbMR_7rgO7xsdkMjIOdAlBuB31wGQur8IoVOOkbFLJHq_cPaug
Message-ID: <CADUfDZppuZYzPyOeAc8GfW=KjpGQj5wK0T0D-UXBHokG67Zxbg@mail.gmail.com>
Subject: Re: [PATCH 2/5] nvme: map passthrough data when the length is nonzero
To: shao.mingyin@zte.com.cn
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me, 
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261120_100346_560861_9A91D93D 
X-CRM114-Status: GOOD (  25.01  )
X-Spam-Score: -2.1 (--)
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sat, Nov 14, 2026 at 11:13=E2=80=AFAM <shao.mingyin@zte.com.cn> wrote:
>
> From: Shao Mingyin <shao.mingyin@zte.com.cn>
>
> nvme_submit_user_cmd() skips mapping when the user address is zero,
> even if a nonzero data length was supplied.  Passthrough ioctls and
> NVME_IOCTL_SUBMIT_IO can therefore submit a data-transfer command
> without a mapped payload.  For example, the loop target returns a
> Data SGL Length Invalid status instead of rejecting the user buffer.
>
> Map whenever a length is given and let the mapping helper validate the
> address.  This also permits address zero if the process has valid
> memory mapped there, matching the io_uring passthrough behavior from
> commit 99fde895ff56 ("nvme: map uring_cmd data even if address is 0").
>
> Fixes: d29ec8241c10 ("nvme: submit internal commands through the block la=
yer")
> Cc: stable@vger.kernel.org
> Signed-off-by: Shao Mingyin <shao.mingyin@zte.com.cn>
> ---
> Tested on 7.3.0-next-20261030 (QEMU/TCG guest) with the loop transport
> and a file-backed namespace.
>
> NVME_IOCTL_IO_CMD with addr=3D0 and a nonzero data_len skips the mapping
> on the unpatched kernel and submits the command with an empty data
> pointer, so the target rejects it with "Data SGL Length Invalid" (status
> 0x600f).  With the patch the mapping helper rejects the null user
> address with -EFAULT before the command is submitted:
>
>   unpatched                            patched
>   control read (valid addr) ret 0      control read (valid addr) ret 0
>   read  addr=3D0 len=3D4096 ret 0x600f     read  addr=3D0 len=3D4096 -EFA=
ULT
>   write addr=3D0 len=3D4096 ret 0x600f     write addr=3D0 len=3D4096 -EFA=
ULT
>
>  drivers/nvme/host/ioctl.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
> index a87c9ca9d06c..22efc5412416 100644
> --- a/drivers/nvme/host/ioctl.c
> +++ b/drivers/nvme/host/ioctl.c
> @@ -207,7 +207,7 @@ static int nvme_submit_user_cmd(struct request_queue =
*q,
>                 return PTR_ERR(req);
>
>         req->timeout =3D timeout;
> -       if (ubuffer && bufflen) {
> +       if (bufflen) {

This is a potential UAPI change if a userspace process was setting
only the addr field 0 in struct nvme_user_io/nvme_passthru_cmd to opt
out of data mapping. (This seems quite possible if a struct
nvme_passthru_cmd is reused for multiple commands, one with data and
one without. Or if userspace isn't bothering to initialize data_len
when it sets addr =3D 0.) I agree I would have used this condition if I
were designing this UAPI from scratch, but I'm concerned about
breaking existing users. Are there real applications mapping data at
virtual address 0? The change for nvme_uring_cmd was needed to work
with kernel io_uring registered buffers, where addr =3D 0 represents
"from the start of the registered buffer".

Best,
Caleb

>                 ret =3D nvme_map_user_request(req, ubuffer, bufflen, meta=
_buffer,
>                                 meta_len, NULL, flags);
>                 if (ret)
> --
> 2.43.0
>

