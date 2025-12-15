Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 423DDD59D99
	for <linux-nvme@archiver.kernel.org>; Mon, 15 Dec 2025 12:16:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=66cm4AE8iwdbIFNfiKnrHamTq8MkL9fALh8Yic0JPdc=; b=V+p+I6F1pSH3Ix/9jqYg0OnzWu
	nVmk0WNMAgIS81Aj8oy96xsohFD/0WV9fZilA8/jc2N8rJEqqWxYG2a23X/WzQVcqkUoltodWOAA8
	ld9OadDDd0GQlhjt6UALwg26l7r/kLOXhYARV+8H/OaKbaKn6IxdInSb1SxHTJBSNUeyDMicZkR1g
	eCI2hdbMRWfwnaZ1YpStAt0NvSIsd1eKZSIoX8mmh5dpxC4hb10zfDYS9ee/o2l5u+TZvZh11jWLV
	p8Yz1t3OpC9x12Gul51MJI/E+QkcZYg0ajnZotjhoYznBOljS1alDxM2t1ygczWYkYc9DHVUODLwr
	iOgFIL9w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vV7V7-00000003aTz-0q9n;
	Mon, 15 Dec 2025 12:16:29 +0000
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vV7V4-00000003aT7-0t4b
	for linux-nvme@lists.infradead.org;
	Mon, 15 Dec 2025 12:16:28 +0000
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-6418b55f86dso4679146a12.1
        for <linux-nvme@lists.infradead.org>; Mon, 15 Dec 2025 04:16:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765800983; x=1766405783; darn=lists.infradead.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=66cm4AE8iwdbIFNfiKnrHamTq8MkL9fALh8Yic0JPdc=;
        b=jqP8+yiQrcZ3grJotyjW1pXs129Bdu0nAjcT2T9zNKPwlr8/r6VK2RnZnqhk6THvZF
         gzIQhD0XabMJrTyf4Wwd+X6CTcuKR5eZyrO9V+aQEzrTtPqYr/lTYDwDt4L3RRoFQMzM
         17+YNC/QWgoCvVXhJPTQNht99ZQK+ZBMRfobgpRfm7kfz5STKIVWhOae9BQD8GwUZSW7
         3l5moNoGKE38MCn1K17fo+uH8jRLjiMUFCM7cZ1qfYSvojntgRds5gyTIGEPlslJrJX9
         Um/IsahnKNdUdFu+f1NcD4Q+FgJTBpsXUPnx8MpRcIOpdLro5xBTj8MCu9pXeDFaE6+G
         izpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765800983; x=1766405783;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=66cm4AE8iwdbIFNfiKnrHamTq8MkL9fALh8Yic0JPdc=;
        b=NGADD1jx6amIpTvTpEV6snFIE7WjdOi+7xQ7m/EOkJbfXudkItXI8ElmyrWBkFtLRA
         1kRWrIxJws7/KmtwWSV9UcH0Zf9JCoGiHMkg4GK/vXsj2kccRe8bu7fQXAj3UPaIJiH4
         InGfunKNukuziWwuCnCDl+hoEVgiodOLrsq1QoMFnQ8BastZodItCVoPif/DxkaZm/D4
         C8dk8/zQREHDRC9Scj/1kBG6eW5MJnbt71MGWALdyQbk8GHns8nMf1t2WQGeKJFINyIP
         H5TSsu2wWdxt7BCZMnqq3tx0LfK9RjYxuzxztn1ucS4r7rix4I8PWYRD0iGNc7u2eK3S
         bP/w==
X-Forwarded-Encrypted: i=1; AJvYcCXIdec38QWJLIt2MzFfO20LAYYHvEJYf/EedD2Spvq7jPZ0wf/t7UcWt4ZFdlRnZz0UiED5U9GkVaut@lists.infradead.org
X-Gm-Message-State: AOJu0YxNGpykNKf8yByDX1+BIGA8w9O3duOSTXLGq56JY/3/eXGx50Y4
	n3WNxuZlFQEkqWEWTJSD3Pqd4cU7x6JzHhXM2VqOpd1Q78Ww8ezdYoc/KHyANPrgg6sf/6ZqMFb
	bFdNh9VnwdovAIVQ4QFfd3C8nB93SBZc=
X-Gm-Gg: AY/fxX4CrhHYgsTQYv/EmZiGbF5LMfPmhkRajYzq0HBtSrWhfsE5hQtv7lElxTXfA/x
	vizGZeFvQJllMb7kjnoqMDlTmkUvb1iRNqSx56OWQnZnpkUeJAfjy5enms9x5qk4pnyycPzuawW
	zENhJgnM1y+1tcVXPwK/B+vTd4Op3wd2jgzKJ966DArp73oOVgv5P4pYLP/sVrIV7KGBJyYHrWf
	SgrSIwD+22XSY2Wd58baeg+i0NrJVNZR9+oKGUrAYGusblhhMY2FoeuYhO4//cskYiwSmx9bPDV
	0UDNqaw08nihnBMbRd60dFBVnd6Cn238q5RuXaBhwVi35zwt8vrBIqQ1XT9KrmibuY+64nN/vsx
	eipDHL/jkipY8+xRK3yTkwA4=
X-Google-Smtp-Source: AGHT+IHDAjWNz66ghfuwbdzKfc0RMks2gAfCjUpqtUXoSJWtg5dRPNZxfIoS2CP0BPRdlgmLjV/8JQ9Gg3EFlAu5lKA=
X-Received: by 2002:a05:6402:40cc:b0:649:2cc5:795a with SMTP id
 4fb4d7f45d1cf-6499b1f1eeamr10221036a12.18.1765800982639; Mon, 15 Dec 2025
 04:16:22 -0800 (PST)
MIME-Version: 1.0
References: <CACbz5yFi8hiPD0Avg=KVTpdEeJC=3MMSkGtYOBQ=OmB_O0khyQ@mail.gmail.com>
 <aRzb6U1se40SrQRM@kbusch-mbp> <CACbz5yE1RNmJkg-RSBe2u60Y5yd1zxkEZ=pVy_gTa2JLh9d5xQ@mail.gmail.com>
 <aR-CUUzWzQKIAfqx@kbusch-mbp> <CACbz5yE52zBkN_mhMhY_bA62z0Fajt3K+K65Fyf8bWBd13yC-Q@mail.gmail.com>
 <aSS3fP1pnWvEHFLh@kbusch-mbp>
In-Reply-To: <aSS3fP1pnWvEHFLh@kbusch-mbp>
From: Thomas ten Cate <ttencate@gmail.com>
Date: Mon, 15 Dec 2025 13:15:54 +0100
X-Gm-Features: AQt7F2ra5cUNF321lzSCSKXHgMyYCyF5LpW6SmN-Qdh455ovIifuBhtZdn-WV4I
Message-ID: <CACbz5yEJ_Fz8gtnCYsjvM09-UxosYOYOzbVODHe+HrEcS2oPPg@mail.gmail.com>
Subject: Re: "controller is down; will reset" on SK Hynix NVMe drive in Lenovo
 IdeaPad Pro 5
To: Keith Busch <kbusch@kernel.org>
Cc: Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: multipart/mixed; boundary="00000000000050c2db0645fc9462"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251215_041626_393665_7F39320E 
X-CRM114-Status: GOOD (  28.74  )
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

--00000000000050c2db0645fc9462
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Sorry it took a while to get back to this.

Interestingly, the device ID is already in the table under the name
"BC901", with NVME_QUIRK_DISABLE_WRITE_ZEROES. From
https://product.skhynix.com/products/ssd/cssd/pc801_bc901.go I gather
that HFS001TEJ4X112N is *probably* an incarnation of the BC901 series,
although that exact model name is not listed there. The BC901 series
is supposed to be extra low-power... not waking up from sleep is
certainly a great way to accomplish that ;-)

I've attached a patch that works for me. But, like you said, this does
affect power usage, so I'm not sure it should be applied at all... at
least not until it's confirmed that I'm not the only one with this
problem. I'll leave that decision up to you.




On Mon, Nov 24, 2025 at 8:52=E2=80=AFPM Keith Busch <kbusch@kernel.org> wro=
te:
>
> On Fri, Nov 21, 2025 at 02:06:23PM +0100, Thomas ten Cate wrote:
> > On Thu, Nov 20, 2025 at 10:04=E2=80=AFPM Keith Busch <kbusch@kernel.org=
> wrote:
> >
> > I tried adding the following to linux/drivers/nvme/host/core.c, in the
> > core_quirks[] array. It takes a model name, not a device id, which I
> > took from /sys/class/nvme/nvme0/model.
> >
> > {
> >   .vid =3D 0x1c5c,
> >   .mn =3D "SKHynix_HFS001TEJ4X112N",
> >   .quirks =3D NVME_QUIRK_NO_APST,
> > }
> >
> > With NVME_QUIRK_NO_DEEPEST_PS, it still hung almost immediately. With
> > NVME_QUIRK_NO_APST, it appears to be stable.
> >
> > Would you like me to send a patch?
>
> Sure, but I think it'd be more universal to apply the quirk to the
> nvme-pci driver's pci device table than to make it based on the model.
> It's common for a model name to be different for various capacities, but
> I suspect the power behavior is more generic than that, which should be
> common with the device ID.

--00000000000050c2db0645fc9462
Content-Type: application/x-patch; name="skhynix_hfs001tej4x112n.patch"
Content-Disposition: attachment; filename="skhynix_hfs001tej4x112n.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_mj73moil0>
X-Attachment-Id: f_mj73moil0

ZGlmZiAtLWdpdCBhL2RyaXZlcnMvbnZtZS9ob3N0L3BjaS5jIGIvZHJpdmVycy9udm1lL2hvc3Qv
cGNpLmMKaW5kZXggZmYwMDQzNTBkYzJjLi44ZjM0NDBlN2Q1NzYgMTAwNjQ0Ci0tLSBhL2RyaXZl
cnMvbnZtZS9ob3N0L3BjaS5jCisrKyBiL2RyaXZlcnMvbnZtZS9ob3N0L3BjaS5jCkBAIC0zNjcy
LDcgKzM2NzIsNyBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IHBjaV9kZXZpY2VfaWQgbnZtZV9pZF90
YWJsZVtdID0gewogCXsgUENJX0RFVklDRSgweDFjNWMsIDB4MTc0YSksICAgLyogU0sgSHluaXgg
UDMxIFNTRCAqLwogCQkuZHJpdmVyX2RhdGEgPSBOVk1FX1FVSVJLX0JPR1VTX05JRCwgfSwKIAl7
IFBDSV9ERVZJQ0UoMHgxYzVjLCAweDFENTkpLCAgIC8qIFNLIEh5bml4IEJDOTAxICovCi0JCS5k
cml2ZXJfZGF0YSA9IE5WTUVfUVVJUktfRElTQUJMRV9XUklURV9aRVJPRVMsIH0sCisJCS5kcml2
ZXJfZGF0YSA9IE5WTUVfUVVJUktfRElTQUJMRV9XUklURV9aRVJPRVMgfCBOVk1FX1FVSVJLX05P
X0FQU1QsIH0sCiAJeyBQQ0lfREVWSUNFKDB4MTViNywgMHgyMDAxKSwgICAvKiAgU2FuZGlzayBT
a3loYXdrICovCiAJCS5kcml2ZXJfZGF0YSA9IE5WTUVfUVVJUktfRElTQUJMRV9XUklURV9aRVJP
RVMsIH0sCiAJeyBQQ0lfREVWSUNFKDB4MWQ5NywgMHgyMjYzKSwgICAvKiBTUENDICovCg==
--00000000000050c2db0645fc9462--

