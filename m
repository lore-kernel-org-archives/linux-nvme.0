Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13477D1D89E
	for <linux-nvme@archiver.kernel.org>; Thu,  4 Dec 2025 09:37:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qeEjzVz7GQk6EpiDzPclRlc2LVPc/X5pecZGz9q1Q90=; b=BMzBCh2HmoD5brg90ueROYZzDk
	AzK5433UPthetZd1qU5eBpMHL6OWqYUDB59/jujSi7c51MsvQOAIaUMYpo0CiHuG6RRF8oZsVw2MZ
	1sIzX9l1/5MrACgKwgcEidyJW5P7CwMKovtIFNZ1ORZs42xisuxVFT2tlhilTY91TtObIJV8OO1iz
	W2OLDKmPpBwBI4d8PAyBCuCA3rYvR0ccKc+++K53rjpncLkatbf1HlL5bmf09VmJ384mos4pPhhqF
	tWdfy3Qg/bbP5XOaV4D5Ty5e5fUWS3x4WlWgOecL99lMb9vECwwl9eWOpCf3bOzp9Du7RKr5lWCGm
	fNTEr0gA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vR5lt-00000007mCk-11jN;
	Thu, 04 Dec 2025 09:37:09 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vR5lp-00000007mCJ-1jT1
	for linux-nvme@lists.infradead.org;
	Thu, 04 Dec 2025 09:37:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764841022;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qeEjzVz7GQk6EpiDzPclRlc2LVPc/X5pecZGz9q1Q90=;
	b=J9Xg1hNGgKJjP88Sx51OE4X/POL66noCRL4TOp8zfyt5r0S87yaYlEsZaFCXTn9d7HEudu
	p8V4h9zn+z9NvP99nwlzGjXejKldzFPtjXX2tCy+iphrOE7Zc2jFmAdt6NTxqCTzWi98m1
	cxkdLKadocpvq6QoQCkjbLAyCawE5kU=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-391-mQ76OULnN7erFVNRp4qhtg-1; Thu, 04 Dec 2025 04:37:01 -0500
X-MC-Unique: mQ76OULnN7erFVNRp4qhtg-1
X-Mimecast-MFC-AGG-ID: mQ76OULnN7erFVNRp4qhtg_1764841021
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-78aaf491ea9so7713117b3.2
        for <linux-nvme@lists.infradead.org>; Thu, 04 Dec 2025 01:37:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764841021; x=1765445821;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qeEjzVz7GQk6EpiDzPclRlc2LVPc/X5pecZGz9q1Q90=;
        b=afe62UFjCR/Q39t+LeQAQBivbwVBM+tMSh+6owdHsoJom1rDhz8MzWRwDn1wtTHSfn
         QVt9S7N0+as1Addzp8v3u9sVo51mtzQVoo9t3fdgnzsO9e+TzkC7SUcF8Xtiwyd/vE/G
         AUKkfX+nuU9LH0UTOt5k5UV0dVdVZCefRhdoSKBRi28wFQ/0t27frUeiP/zaRPgv+Hb7
         VG7kbhcvqgOdYBlQ8bkccoPUYpuScZCC4POXWrkqGFz+2l6ZwJttvIN+1dYIb1nJPTy/
         2PyW/9rROOW/zJwtXR4q+j7MrG20sBqPogk5+6pq3X5tZvOZpPCQktY7j3KvNnVNh88P
         EaHg==
X-Forwarded-Encrypted: i=1; AJvYcCU05UC/gJgZvUx+JJco6ghp72U/bU3rEADCda4gr+tL4qFKT9F3F0ApOWibTj+ZDG9MUCqXy9TuBZRk@lists.infradead.org
X-Gm-Message-State: AOJu0Yxw5xJLPr78qxJQLsmje/2cM5UqYrDKgIxwBxeAhDXD9AA+Qls/
	N1WkSD9Ab+z8dPU/I+s3/ErUdfwgv95aXNorcA8dfeYiWedSVIhwOxZiGimAu4+2DaZcE3IpNHu
	qh692u1uPAy26Bu1JKrJmCvVUfeybna6K68HyTgOn5LFVqYOJhsJDmQONZ4PTHmwxTTnGXP62iw
	pCRyt2bPUGfiMqveRfJZ5SrMjn+SKlGBJcM3y6dFJDFbI=
X-Gm-Gg: ASbGncvlvCxyQ/IWMVKveCdglxwuLh99ZoDkWD3q8bky3CkV3Cz9a+XLVcellYF2OrL
	w54RQpv3ugxEKaQvsuzKbMX/IOJtfRXjTaAAeg9o4wSZSSEmUB1ybqfkHHyi4SjKNSX0f7n31Xs
	2Pq7EA3Cc/H3OuhWql1c0jcmDl/oVY4ni+kxdVK/vQr+efURtZXUz8uIqzhLgjk3ut
X-Received: by 2002:a05:690c:6713:b0:786:4fd5:e5de with SMTP id 00721157ae682-78c0c210028mr42666147b3.67.1764841021008;
        Thu, 04 Dec 2025 01:37:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHBJRkWOGl554rCJxMS1W+VD+59CzpNDKchBFktxp0UKkP2qgdZoPND338wG5ha+uJ8PPPkfv0dwHOd25ifO9U=
X-Received: by 2002:a05:690c:6713:b0:786:4fd5:e5de with SMTP id
 00721157ae682-78c0c210028mr42666067b3.67.1764841020714; Thu, 04 Dec 2025
 01:37:00 -0800 (PST)
MIME-Version: 1.0
References: <20251128083219.2332407-1-zhangshida@kylinos.cn>
 <20251128083219.2332407-7-zhangshida@kylinos.cn> <CANubcdUtncH7OxYg0+4ax0v9OmbuV337AM5DQHOpsBVa-A1cbA@mail.gmail.com>
 <CAHc6FU5DAhrRKyYjuZ+qF84rCsUDiPo3iPoZ67NvN-pbunJH4A@mail.gmail.com>
In-Reply-To: <CAHc6FU5DAhrRKyYjuZ+qF84rCsUDiPo3iPoZ67NvN-pbunJH4A@mail.gmail.com>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Thu, 4 Dec 2025 10:36:49 +0100
X-Gm-Features: AWmQ_blRRqbIFTY0f39yIA51TqtDoPBldWIhSqZwhzNWbMT5aHjbQPCsAOYEw2M
Message-ID: <CAHc6FU57xqs1CTSOd-oho_m52aCTorRVJQKKyVAGJ=rbfh5VxQ@mail.gmail.com>
Subject: Re: [PATCH v2 06/12] gfs2: Replace the repetitive bio chaining code patterns
To: Stephen Zhang <starzhangzsd@gmail.com>
Cc: Johannes.Thumshirn@wdc.com, hch@infradead.org, ming.lei@redhat.com, 
	Gao Xiang <hsiangkao@linux.alibaba.com>, linux-block@vger.kernel.org, 
	linux-bcache@vger.kernel.org, nvdimm@lists.linux.dev, 
	virtualization@lists.linux.dev, linux-nvme@lists.infradead.org, 
	gfs2@lists.linux.dev, ntfs3@lists.linux.dev, linux-xfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, zhangshida@kylinos.cn
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: -IisI2Wd0wgYR7vwZKtmmC8pWKpQ7kR2YXa_866PuRg_1764841021
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251204_013705_527796_AEFF2CD7 
X-CRM114-Status: GOOD (  11.32  )
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

On Mon, Dec 1, 2025 at 11:31=E2=80=AFAM Andreas Gruenbacher <agruenba@redha=
t.com> wrote:
> On Sat, Nov 29, 2025 at 3:48=E2=80=AFAM Stephen Zhang <starzhangzsd@gmail=
.com> wrote:
> > This one should also be dropped because the 'prev' and 'new' are in
> > the wrong order.
>
> Ouch. Thanks for pointing this out.

Linus has merged the fix for this bug now, so this patch can be
updated / re-added.

Thanks,
Andreas


