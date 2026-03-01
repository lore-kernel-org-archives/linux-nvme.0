Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C195FD0057
	for <linux-nvme@archiver.kernel.org>; Sun,  1 Mar 2026 14:35:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WJBlH8942r0mu6b66pi+a4jVVYztLmifNnMRXNqv7Ks=; b=1uHrGX5CLgAEh1lYCkI14bJ3xn
	qu0gup843HQLdQIEBueT+Vhs7aNmyC3/9XX14WEWN82guU/5DeVhj+olzwgxizUtEhbAkxRgkVgAy
	ZjMOV/Z4isLR/HtR64ZGv26cjA3BYVCdXhIjk42h+Jv7UNPh94nZ6r1TLD286lXhJd2QeSaNH9n7a
	4S0IVNKtLMeAp8ghA5McbZnztS2TTyfDTdXsZ4gS6QWOPBEQnVwiSRj9ooqQ988NiwNJsTP6uVBv8
	QxXru3PMCKlh62GPOKgKgUY3Ic78jAesGGLwkS8G65wnhV29yjGDsNP2vg9mKXtFZuFK6SlC5IKVJ
	oAwafhBQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vwhtJ-0000000BaE9-3yey;
	Sun, 01 Mar 2026 14:35:29 +0000
Received: from mail-ot1-x329.google.com ([2607:f8b0:4864:20::329])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vwhtH-0000000BaDk-2Kl1
	for linux-nvme@lists.infradead.org;
	Sun, 01 Mar 2026 14:35:29 +0000
Received: by mail-ot1-x329.google.com with SMTP id 46e09a7af769-7d4bc9e48bbso1667542a34.2
        for <linux-nvme@lists.infradead.org>; Sun, 01 Mar 2026 06:35:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772375726; cv=none;
        d=google.com; s=arc-20240605;
        b=Z9AX1xL5UyMttql3rLPUMgEWfI85JeY2BPe7LU8FrO0rp+818YFPHB9lQCHVPE8++G
         F/lknDySDpWPAEFo97ildHnXmUwBkudFYp2i0y2NlJN7x0xF5KYPyPyIseRazTWrfDDi
         3GwD5EPt6yArJrzMY90SrXMmx27e9W8MGfd6dsgjGcfvpNy7psJuSmY23pLyZW4o4Z1p
         EQmpdp7E1YHOrZNaKBMethgDWn6xC3Gc/0O3/twnT+wT3cONm0vRkBIdA08u1e+iV6hp
         A3dFL7ZBCgah65LSKcCdPoPP7EKyOKgCQJdoSqQlviMoFyAxTC0VQUuD4xoKTswnPweE
         mvEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=WJBlH8942r0mu6b66pi+a4jVVYztLmifNnMRXNqv7Ks=;
        fh=Bpw7Zj1lWxh02I805VVMYsQM8pymL2SPLlC8p3f1Nu8=;
        b=lnvC8qq/rWWt+gmxMRArDILFscaOn+CYRnfp0vO/3MXsLmgKpxtcvwigm4RGocB5Ww
         9/SyS5n1Vgp0KVAfl6bKTGG5evgVwra/i9kfXsLm9v6TUCvQOrc0m8g6L3m92VWA6tRj
         imacgyRb3XNnZ0Jp07cKxpA5jbZRIN/JlfesiR+FD3ODL6NEFI6aBb37CZjuTWYVh7zF
         nLg2jsXsCAQMEnCkCPoLPFxlRIyMiyMQ9PQnJuAHE6174mlsU9R5LI+r98sSkR8QpVyq
         DwY69cexDrD+tawkZ9UWmnjcj22WVMx+EOjKM+eq68wshnb7zz0DvNtrzoCAVvgDRzBi
         o81w==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772375726; x=1772980526; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WJBlH8942r0mu6b66pi+a4jVVYztLmifNnMRXNqv7Ks=;
        b=NVkA9PC/NwB6GdrhFUnr+hRAVfJ8fNruDxxoDYaaD2oKrNpfRHhmbV21LAHJVUap7z
         ayz0qP2ho3iXBS2iwFYnPloDj5TUpf6ZjzzufN/O8dwWKXcpRE+w8vYm5uAY7IwEHKx+
         jd0i8QMn7jlC9e28DCoMOzJ1vaaD1fgH/ATQ5A4cZu7y1C0lNZQkrrVUJD1oSUqGPdX1
         Cj881lewB4W0N3zbNYp3+ooKAaTvlkfiO3CGB7rSO+5HcwKhc3i1hKC7WdApLXivEqCc
         2mxLgdpe4IZTmLas0AVqYOF7nV1YSB3a2rIK3cs4MnTmIBtIrx6udk84iVwrxSWSL35g
         oMeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772375726; x=1772980526;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WJBlH8942r0mu6b66pi+a4jVVYztLmifNnMRXNqv7Ks=;
        b=Y7f93El49UOGiAWlFanomtgNAXFd0qEbgNWhQ7os196P6pVSaGGCSq4kIs+mTYfBs5
         ZDTkDprhxZXLKOwmCz9Fl/avryaoGcBEJPGa10J7JLLYZ+5eMthx0y/EdxYzg1RYAvxj
         R721i0JLc1EfFwD6Zdu/6BTmiVMHuPq8Znmer1cRvF9PU1sG+yOsDLnoNhdp+3uQiy0o
         RFf1zVWee0efWVwqPfm8VcIxBxa/1M00d5/8yEH3u9IoENFIKwLQmsE9xwfFXkOGeUPw
         D173z08N5cbQ0nU7ZEeIAveRbwnZRJm0mFj97IYDIC4OkjeJIAwd29ZHPb0QKJyMRX5C
         IeZA==
X-Gm-Message-State: AOJu0Ywg8lygwY49PKrdmX3OhM+THeOHJojfB+D92cFa9DRO+6VfslcY
	w4qy9MiZ7sNAVBk/n+fHENrcTp7wxZT09IPnWsG1pk9f5v2f5Y0NfgdERmMp84CAoq30dvKJfiJ
	/Ec+d3n78k6S0wmd2+qLxqRolxEmi1opSoRbx
X-Gm-Gg: ATEYQzz6TCQpu2jZPX364a/5qwx2dik1rfKa+aDYRS3/OKyefApC4pIvR9Xxl3Xw5UJ
	W0+ulqKL4FXlsURnfys5HktbaO1oUSdLDkupZZkKZgqEP1Wot/PYT85d7qB04P9fYp7ZoccJcv9
	DsVKdZ7XDJJnr33myugOeWdvOD4eAheAGZMDj5iIveWrUcaSUMwh38wwIBlxtYQp2djNFwb+bvp
	J06zUzFNzhgv9ZXk/6K6ZwkZOPQlw49RAL90nQup6ca9UwjptaUNVKDvgkPqZkgQdZG5UIPZhZD
	4J3eQ2wO
X-Received: by 2002:a05:6830:914:b0:7c7:731:7905 with SMTP id
 46e09a7af769-7d591be612bmr6476951a34.24.1772375726198; Sun, 01 Mar 2026
 06:35:26 -0800 (PST)
MIME-Version: 1.0
References: <CAN7C2SCFgVzj+Jr8kc1ySLH9KAPjGFN8XTEKQjvefEVyRT9K5w@mail.gmail.com>
 <DGRHI7H6BTSG.12V7ZG8WJGOVB@bsdbackstore.eu> <CAN7C2SD7mLjrKARiwuu3ygfYNgaM2tX9Tco9gqUk-hNP_efC0g@mail.gmail.com>
In-Reply-To: <CAN7C2SD7mLjrKARiwuu3ygfYNgaM2tX9Tco9gqUk-hNP_efC0g@mail.gmail.com>
From: Sune Brian <briansune@gmail.com>
Date: Sun, 1 Mar 2026 22:35:14 +0800
X-Gm-Features: AaiRm51lvkoxQt172ifnrAxTxga3Y5NL82LUUkEhAbKAF9w_5RrreJfudg77yD8
Message-ID: <CAN7C2SC3-d7dPCyfNoPHp0ybeVgnS0j-8XgLNQ=DEmfK0Uro4A@mail.gmail.com>
Subject: Re: [BUG] NVMe: Discard timeout/hang on a801 during mkfs
To: Maurizio Lombardi <mlombard@bsdbackstore.eu>
Cc: linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260301_063527_700046_C4F98B9A 
X-CRM114-Status: GOOD (  23.76  )
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

On Sun, Mar 1, 2026 at 10:25=E2=80=AFPM Sune Brian <briansune@gmail.com> wr=
ote:
>
> On Sun, Mar 1, 2026 at 9:36=E2=80=AFPM Maurizio Lombardi
> <mlombard@bsdbackstore.eu> wrote:
> >
> > On Sat Feb 28, 2026 at 1:22 PM CET, Sune Brian wrote:
> > > Issue: A fresh NVMe is format below instructions
> > > always result in series of "opcode # (Write) QID 1 timeout"
> > > While normal mount and read write shows no stall
> > > or hang.
> > >
> > > dmesg log is placed at the end.
> > >
> > > During testing it shows that DRAM-less NVMe will result in
> > > timeout but DRAM NVMe does not.
> > >
> > > Please maintainers help to see if there are any possible
> > > causes that could remove these possible PCIe reset.
> > >
> > > Test Kernel: 6.12.33-g3234b1ed8956-dirty
> > > CPU: ARM7l
> >
> > I am not sure from where this kernel comes from but a search on google
> > hints to the Altera FPGA github tree
> > Is this the Altera's kernel?
>
> Hi Maurizio,
>
> Absolutely correct kernels are clones from the Altera trunk.
> I am hoping there are patches missing and let me give it a try.
>
> >
> > I looked at their 6.12 LTS branch

Hi Maurizio,

I had done a quick diff:
https://github.com/altera-fpga/linux-socfpga/blob/socfpga-6.19/drivers/nvme=
/host/pci.c
They had that missing return in the more latest kernel.

Had done a quick wipe and format test works no more timeout very repeatable=
.

The interesting part is DRAM NVMe does not have this issue, only DRAM-less.

Issue solved~

Thanks a lot,
Brian

> > https://github.com/altera-fpga/linux-socfpga/blob/socfpga-6.12.43-lts/d=
rivers/nvme/host/pci.c
> >
> > And they miss a patch that fixes some problems with I/O timeouts in
> > the nvme-pci driver.
>
> >
> > https://lore.kernel.org/linux-nvme/CABXGCsMd_xv8jPDF_sFYhwd8GtANZ23nbaS=
JuCxQRO7cjPtgWg@mail.gmail.com/
> >
> > https://lore.kernel.org/linux-nvme/20250331162859.1407725-1-mlombard@re=
dhat.com/
>
> Thanks,
> Brian
>
> >
> > Maurizio
> >
> > >
> > > 1) sudo wipefs -a /dev/nvme0n1
> > >
> > > /dev/nvme0n1: 8 bytes were erased at offset 0x00000200 (gpt): 45 46 4=
9
> > > 20 50 41 52 54
> > > /dev/nvme0n1: 8 bytes were erased at offset 0x1dcf855e00 (gpt): 45 46
> > > 49 20 50 41 52 54
> > > /dev/nvme0n1: 2 bytes were erased at offset 0x000001fe (PMBR): 55 a
> > >
> > > 2) sudo fdisk /dev/nvme0n1
> > > g
> > > n
> > >
> > > w
> > >
> > > 3) sudo mkfs.ext4 /dev/nvme0n1p1
> > >
> > > mke2fs 1.47.2 (1-Jan-2025)
> > > Discarding device blocks: done
> > > Creating filesystem with 31258368 4k blocks and 7815168 inodes
> > > Filesystem UUID: 8f469cc5-d6e1-4606-bfda-869806245d9f
> > > Superblock backups stored on blocks:
> > >         32768, 98304, 163840, 229376, 294912, 819200, 884736, 1605632=
, 2654208,
> > >         4096000, 7962624, 11239424, 20480000, 23887872
> > >
> > > Allocating group tables: done
> > > Writing inode tables: done
> > > Creating journal (131072 blocks):
> > > done
> > > Writing superblocks and filesystem accounting information: done
> > >
> > > Thanks,
> > > Brian

