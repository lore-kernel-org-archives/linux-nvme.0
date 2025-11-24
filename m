Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE309CFD313
	for <linux-nvme@archiver.kernel.org>; Mon, 24 Nov 2025 01:28:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Y/rWYDjm0xShtpWJ/wMbqIqCozvhm5iHYOzGvjLTIVQ=; b=z1dOjfXvL5tjzi3Cv2BUaJ0Ujb
	QofTWpBntrY8s8CS84v/AYaEOsb7Y0rJsj3zQQl/ivM8PP57Q6eN6mmZ9TWKx4D9LFSmCCaG+XSi1
	qukkko2gb129PY4MtjmlZ/EaBayFrhKxh9lYse3fMG+tjJohfTYEbHK0gvbA/l6DzBPDXw6scKsre
	aJXSHRui23tqwwzKFSX/XlFkj/+0kwTaAEG2QOWv32ZcLqTU/qpOmjAzoqiODf8ibiMsR0xs1EBK2
	iYpZCVAiaR08OxYNZDOxhPt9nUBUmVcMmWoGXJiZeStIXrkrn4PkXOMyJoitGSbv/EnNED8qlu91e
	exDHKHTA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vNLNp-0000000AvL4-1LVN;
	Mon, 24 Nov 2025 01:28:49 +0000
Received: from mail-qv1-xf33.google.com ([2607:f8b0:4864:20::f33])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vNLNm-0000000AvKY-35cS
	for linux-nvme@lists.infradead.org;
	Mon, 24 Nov 2025 01:28:47 +0000
Received: by mail-qv1-xf33.google.com with SMTP id 6a1803df08f44-88267973e5cso23618746d6.3
        for <linux-nvme@lists.infradead.org>; Sun, 23 Nov 2025 17:28:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763947725; x=1764552525; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y/rWYDjm0xShtpWJ/wMbqIqCozvhm5iHYOzGvjLTIVQ=;
        b=EQPyWeihkoPnLuIgPhccRTYrc1MV+z7vhvmODCQlVfGe6aNnLamtcbHWdw1pYDbNxX
         htO8lKpEKWzH7QYPbQiYb4cOm4IYJx9N9wUYL9Os5/So78xiO85K+SwCmM1isLI2iSUj
         tVgEE5MnouXfjZICYi/sVrGziHg0hkw942/qWOc+eguqrUl8BxJnGZdXChIkb5YiuWJL
         pYucpTx2oHawqMvc4Ptg4EVNcnITDxPcV41Oy1knlUHTZsLNUywZ5CQkHJJ1T65EEDTN
         BZWEbvrds2uJGU2iQc/WjA5vtduHB9rbjykFEU99AuWaCwSp3dcPqShVq+ob1uDIMSgN
         pttg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763947725; x=1764552525;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Y/rWYDjm0xShtpWJ/wMbqIqCozvhm5iHYOzGvjLTIVQ=;
        b=EnzMSsN+pLUPbterdBykPQVhyMo20167eizkMN6Y0jsWkKgdysG3IM2edC9U0OFd2O
         LnzLzY/yY8j+S4USc3knwZ9Yz8UkhYYTz9LKDsrClfwSN4sddBs/2t76OYUowVv+6XGO
         Qlp+aaMK9QN/uHzhnBTYcGOYiYpT/YEg6W1eA8nm0QETSo+3o4gkUOptKde12PvcajFi
         GdBIp5BK05BfiqoePsGTmVyCb86zwj9XPYMli1EdWh4NyRemzo1dHqCQkwuTCNDiR8i1
         je89y+VeKeC/+MBX4HGQ702sP5J+8HmxGzMP89nCISbioDoGZDN1iKY6T4a8eXPqOQE6
         5vWg==
X-Forwarded-Encrypted: i=1; AJvYcCUdqXwOgaCtqKk386pxZ8gms+jI01mh48++X6LLIpKWqbbCY/vRwxK+SFhRmAmDghjMM0GwYkexNs7x@lists.infradead.org
X-Gm-Message-State: AOJu0YzMxX6l5ZscBHZiF4ES3/naUHA6hccXyPvAg+pgY0oFXmfeMUwV
	J9ycnz6n7RgFpjJY6hvfemn9DmeTVhe/AcJGmyTaWsvprKuwOm2NMapan4f2BoUgq0u/rfrUMh5
	rfnpuH+2m2BXYjlvo+W07xh14dFlD8s0=
X-Gm-Gg: ASbGncurjG3ilJw/Uz1Quv1rKgXz7I0h/hCemTs0C6FZH2FHZoj9XfnW4uTxI5Scwdm
	SoME76DYz7hE0BiQipZpoeip17H2E6VD0paFO60gGjQrTFix6Zye0Smfp1krFCz3LZgd5Uq/I3O
	xQFwmRxdMQSamo0icJbrnQz9nP3DGsW77DH9njvMhhTqywdARqhbmmI2A7Glnn4mKp8xi6Btm57
	HscwIrdSAutURWxKZKplFbzFiZhmMQudtv5l1djSC466kcVqAs6M5FmBRRdR7XNTB/Mr9IPLAZW
	KP/0hw==
X-Google-Smtp-Source: AGHT+IFHZruP2YBfL7pdTjTDvePbwJad50RtaobjpQ37TLxnePvW54pVHPb5rvzSUyg3BEeJesXp2k7UVUVu8L9oRt8=
X-Received: by 2002:ac8:5d0f:0:b0:4ee:2080:2597 with SMTP id
 d75a77b69052e-4ee589103cfmr127248731cf.38.1763947725292; Sun, 23 Nov 2025
 17:28:45 -0800 (PST)
MIME-Version: 1.0
References: <20251121081748.1443507-1-zhangshida@kylinos.cn>
 <aSEvg8z9qxSwJmZn@fedora> <CANubcdULTQo5jF7hGSWFqXw6v5DhEg=316iFNipMbsyz64aneg@mail.gmail.com>
 <aSGmBAP0BA_2D3Po@fedora> <CAHc6FU7+riVQBX7L2uk64A355rF+DfQ6xhP425ruQ76d_SDPGA@mail.gmail.com>
 <aSMQyCJrqbIromUd@fedora>
In-Reply-To: <aSMQyCJrqbIromUd@fedora>
From: Stephen Zhang <starzhangzsd@gmail.com>
Date: Mon, 24 Nov 2025 09:28:09 +0800
X-Gm-Features: AWmQ_blFIl-YjYfjpEue9I17YWgGWhW3tKNMKvxlJbU5ZD_pYkwFt7d133xm8_0
Message-ID: <CANubcdX4oOFkwt8Z5OEJMm7L5pusVZW0OaRiN8JyYoPN_F0DpA@mail.gmail.com>
Subject: Re: Fix potential data loss and corruption due to Incorrect BIO Chain Handling
To: Ming Lei <ming.lei@redhat.com>
Cc: Andreas Gruenbacher <agruenba@redhat.com>, linux-kernel@vger.kernel.org, 
	linux-block@vger.kernel.org, nvdimm@lists.linux.dev, 
	virtualization@lists.linux.dev, linux-nvme@lists.infradead.org, 
	gfs2@lists.linux.dev, ntfs3@lists.linux.dev, linux-xfs@vger.kernel.org, 
	zhangshida@kylinos.cn, Coly Li <colyli@fnnas.com>, linux-bcache@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251123_172846_809590_2F6652FC 
X-CRM114-Status: GOOD (  20.25  )
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

Ming Lei <ming.lei@redhat.com> =E4=BA=8E2025=E5=B9=B411=E6=9C=8823=E6=97=A5=
=E5=91=A8=E6=97=A5 21:49=E5=86=99=E9=81=93=EF=BC=9A
>
> On Sat, Nov 22, 2025 at 03:56:58PM +0100, Andreas Gruenbacher wrote:
> > On Sat, Nov 22, 2025 at 1:07=E2=80=AFPM Ming Lei <ming.lei@redhat.com> =
wrote:
> > > > static void bio_chain_endio(struct bio *bio)
> > > > {
> > > >         bio_endio(__bio_chain_endio(bio));
> > > > }
> > >
> > > bio_chain_endio() never gets called really, which can be thought as `=
flag`,
> >
> > That's probably where this stops being relevant for the problem
> > reported by Stephen Zhang.
> >
> > > and it should have been defined as `WARN_ON_ONCE(1);` for not confusi=
ng people.
> >
> > But shouldn't bio_chain_endio() still be fixed to do the right thing
> > if called directly, or alternatively, just BUG()? Warning and still
> > doing the wrong thing seems a bit bizarre.
>
> IMO calling ->bi_end_io() directly shouldn't be encouraged.
>
> The only in-tree direct call user could be bcache, so is this reported
> issue triggered on bcache?
>
> If bcache can't call bio_endio(), I think it is fine to fix
> bio_chain_endio().
>
> >
> > I also see direct bi_end_io calls in erofs_fileio_ki_complete(),
> > erofs_fscache_bio_endio(), and erofs_fscache_submit_bio(), so those
> > are at least confusing.
>
> All looks FS bio(non-chained), so bio_chain_endio() shouldn't be involved
> in erofs code base.
>

Okay, will add that.

Thanks,
Shida

>
> Thanks,
> Ming
>

