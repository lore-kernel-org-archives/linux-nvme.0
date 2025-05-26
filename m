Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B23EC54FB3
	for <linux-nvme@archiver.kernel.org>; Mon, 26 May 2025 10:06:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TPh1Ct6QshCKWmDEdMk7hCZKp6Jz8m7ODsFZr4dzpn0=; b=ceC0o92tult3A84GnIbgO1tffZ
	uf/G4IgiPp4KWT+1YeEU86NJPzNPtSw4PmyVxkOn4k0yRw2QXFaXwsq86ITqw7Z8Q70pSx48NpcF3
	I7cLOFXxkgEjJU0hVyBXSHo9wY0LFAJEkufWwKOQNdCNioGv0UKXrfp9nuJGCE5fN2FpAaxVfLHD6
	ptFy8pAUyqrQ6X562n8WSuj6hmpQT/KoUZWwhvcUylWIQl0ME8OVyqcVNdz8isv7++9syOgih1AEx
	CP27SrRHtfsF2fZih6gVaEMGtiAor3ADK/V2ZUJVHEF8uWXDspg8sUAz/9hpl+FSGWaBkN7cpNeQj
	psZdvFkQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uJUjB-00000008aWi-31QO;
	Mon, 26 May 2025 10:06:41 +0000
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uJUj5-00000008aUf-1GY2
	for linux-nvme@lists.infradead.org;
	Mon, 26 May 2025 10:06:36 +0000
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-3a363d15c64so1459351f8f.3
        for <linux-nvme@lists.infradead.org>; Mon, 26 May 2025 03:06:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748253994; x=1748858794; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TPh1Ct6QshCKWmDEdMk7hCZKp6Jz8m7ODsFZr4dzpn0=;
        b=Uh0vbj16lmgY+T9x/yEJ9Uo6ko/HDfZDso60gLYA5VkDqhYjV2n5ToCWcSFcwKi1WJ
         /3b5a6Mb1Ms26in2f3j4MzM6xoBmyXMjGKsfxm55xL/DS9W9B6rz0jQYhvXVKlOlL7Ut
         T5bZ9Ewf7Oj5aza2b6IoEISGklXm5U7oFsmkCBnYTCWPq++BvxmoFzkPuaON2UDrclyu
         YFIkEKEwKNyy3BIeB4oSKv3AVmURt8V4pH1EAUM1HXWDj15yMfSB4lLAHoVvyYrmTKRy
         /fjJLQb3idTMre0IQhHNdrq0iUZeOZ1v3sWWiyacfoDk5c9qQWd3awigdPb8IEWY1Vfz
         gtsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748253994; x=1748858794;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TPh1Ct6QshCKWmDEdMk7hCZKp6Jz8m7ODsFZr4dzpn0=;
        b=TsjguHGbGt67mY9udEAM/YgbrZo63fdG/xiE3LUlPlRnAfZy+bvNmcdRgCD4NnZEkk
         bn44CFTh1yBrjWf874ra4wzMVCuwazde5KTQXoUw5ynrVsRrf/7EpG/3DWL2m8pdkKkI
         ugZhQIDkR1iFUHPwUhKlMaflzDJ3SBt91VqQwZr0ILxn1tnfK+xoWps9Au1hHEiyVk7J
         WuOI9s6t1F2TIxLc88hRWvwYdC43flLzSkpIU2OvjIt77aVdGOfZDXDBzlpK5aSi7Jpx
         HESq1fWj8kLut8nn1wvKEs758AATJko6kRDjyQBRLIE2kfxl6cfQ4xPRa1R94vyofYVB
         5lRw==
X-Forwarded-Encrypted: i=1; AJvYcCVst31z9dz370tViuF6DowfEnw0ul3X6VVRIBpq/EVhJYLCYJ9iur4IAGNtjm8GtDXjnekNcffFV0Ds@lists.infradead.org
X-Gm-Message-State: AOJu0YxpHOVPgKrIH5udRRT//Coiwguj/iGStHyrCoQKerP40maZtiTJ
	crSZdXv4lcp7vDD5Gzbe5sbYhqfEvdTjogrPWpXkEFOEeejTAm3HjGxG
X-Gm-Gg: ASbGnct3pVJd1X0rJafTIi3bilLfx70Uj1ehwKLUNhx9A367wXKLdG8hO9z6A8SxnKx
	S4G1jIYbXogGRZNUt0mpm5YtGO6tLFFn7zyMXymN9TYxMRybCkfwFXAu+S68Hg+aLA8zHJk43cX
	E/vEfFuMUbWCasxjKixqTDMKZnHW4UJTPHUVOshT1kP1qQZFxOUnJK3Oi04bsf0Sd3fxKPiHohh
	2BZaiCBdG4Es2P3iWToEksoB/uYnDk2CfnFzgXFx8ToZBpWlBm471xBKw9dCUVDe2U/zpF5+2Nu
	A3+ulgXs/zvjM3njy9SJ/Rzq4AfnN/kCrI8C3EddvS3V6+wjHndrHyBnvn/9nVsTF56Tw7lQrc8
	jqxV30J+d80Naeg==
X-Google-Smtp-Source: AGHT+IFNZkvn3tGi7ARy4dpQ3TrKaZGPDzyR33srZYXPNzWELPLp52hjHD63j/jTAmYk0WDJMq4RNg==
X-Received: by 2002:a05:6000:238a:b0:3a4:d367:c5aa with SMTP id ffacd0b85a97d-3a4d367c798mr4219403f8f.20.1748253993614;
        Mon, 26 May 2025 03:06:33 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a4d67795eesm3561697f8f.86.2025.05.26.03.06.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 May 2025 03:06:33 -0700 (PDT)
Date: Mon, 26 May 2025 11:06:32 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Kuniyuki Iwashima <kuniyu@amazon.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Willem de Bruijn
 <willemb@google.com>, Simon Horman <horms@kernel.org>, Kuniyuki Iwashima
 <kuni1840@gmail.com>, Chuck Lever <chuck.lever@oracle.com>, Jeff Layton
 <jlayton@kernel.org>, Matthieu Baerts <matttbe@kernel.org>, Keith Busch
 <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, Wenjia Zhang
 <wenjia@linux.ibm.com>, Jan Karcher <jaka@linux.ibm.com>, Steve French
 <sfrench@samba.org>, netdev@vger.kernel.org, mptcp@lists.linux.dev,
 linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-nvme@lists.infradead.org
Subject: Re: [PATCH v2 net-next 1/7] socket: Un-export __sock_create().
Message-ID: <20250526110632.7ab3323e@pumpkin>
In-Reply-To: <20250526052907.GB11639@lst.de>
References: <20250523182128.59346-1-kuniyu@amazon.com>
	<20250523182128.59346-2-kuniyu@amazon.com>
	<20250526052907.GB11639@lst.de>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250526_030635_340422_E1D40DB3 
X-CRM114-Status: GOOD (  28.38  )
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

On Mon, 26 May 2025 07:29:07 +0200
Christoph Hellwig <hch@lst.de> wrote:

> On Fri, May 23, 2025 at 11:21:07AM -0700, Kuniyuki Iwashima wrote:
> > Since commit eeb1bd5c40ed ("net: Add a struct net parameter to
> > sock_create_kern"), we no longer need to export __sock_create()
> > and can replace all non-core users with sock_create_kern().
> >=20
> > Let's convert them and un-export __sock_create(). =20
>=20
> The changes looks good, but the commit log including subject line
> is rather confusing.  What you do is to replace all uses of
> __sock_create with sock_create_kern, which works because
> sock_create_kern just calls __sock_create with the last argument set
> to 1 as those callers do it.  This then allows marking __sock_create
> static because all outside users are gone.
>=20
> Please state that, i.e.
>=20
> Subect: use sock_create_kern insteadf of opencoding it
>=20
> Replace all callers of __sock_create that set the kernel argument to 1
> with sock_create_kern, which is the improve interface for that.
> Mark __sock_create static now that all users outside of socket.c
> are gone.

I'd also like to see an explicit statement on all these patches
about whether the created sockets hold a reference to the namespace.

I know it is documented in the function definitions, but the issue
has always been that the callers get it wrong.

=46rom what I remember, as this point in the patch series sock_create_kern()
doesn't holds a reference, but by the end of the series it does.
That just has to be a recipe for disaster and pretty much requires the
changes all go through the same tree in one merge window.
But the code touches multiple areas and the changes would normally go throu=
gh
multiple trees.
So it's going to be hard to get all the acks and the patch accepted.
(Unless you persuade Linus to 'just apply the changes'.

I think you need to look at three merge windows.
1) Add new function(s) for creating user/kernel sockets with/without holding
   a namespace reference.
2) Update all the callers to use the new functions.
3) Delete the old functions.

There is no point modifying the callers twice, and the commits need to
explicitly state whether they want the namespace held or not.

	David


