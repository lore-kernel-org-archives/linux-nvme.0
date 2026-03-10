Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9ED93FD4F19
	for <linux-nvme@archiver.kernel.org>; Tue, 10 Mar 2026 18:14:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=48NkwjfxB9Ou5X/gX3NRY0aODFsOoy0dku0gc7W64Mw=; b=LKW6/wbLnucz0xl4ih6kCMPaKA
	7G6VvG7OA01gUzjISeVwA5yzEW7To8fRy12LXimKiOHruQwueiVW3y/E+eOu6CQa0Iow/SIwsL0HD
	/hCxFl0L+v+ObzZmot1KoGH37oqFkPHQpRJyu0DytpPtR4WieNa9b8ojAKfZaBk8hx5bmltA9tbbv
	yx4W5vkcIodL3YkzUoLUcXtu74quKA2Zqk3Ids8xVsG1QQqQIpw1FeMtTaVvv+P71ULQuKgljUaHp
	TpSpaQt70xpUR8KmRDOupfEKheGHos4svQMp3mxsMXSigi7qBrUcrYeh/WG0D+9byK9sYE69zE+fI
	xbV4UDQg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w01ay-0000000A3Yt-1EUv;
	Tue, 10 Mar 2026 18:14:16 +0000
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w01av-0000000A3Xr-38Il
	for linux-nvme@lists.infradead.org;
	Tue, 10 Mar 2026 18:14:15 +0000
Received: by mail-pj1-x1034.google.com with SMTP id 98e67ed59e1d1-3598e7155bbso6537286a91.2
        for <linux-nvme@lists.infradead.org>; Tue, 10 Mar 2026 11:14:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773166453; cv=none;
        d=google.com; s=arc-20240605;
        b=d54IDTaSLJv3nUIxzKriqgQz5W1g4O5d2GWXfX5MoLqCk/2neFki/2q9LAB1jsXgQD
         HfcouNDz6uAqox11FstLULkhwXx/V10pfa3jVMPzkVZU4SttyauSEdaJPrKX/3de4Ytl
         Z/D/A8q4t4ietO8D7P3XOg6j0+8D3n/GwgV9roLp4YezIbI8tnRgKb4Feu4GCU+4/ByC
         F4tpQxuL8xLPK+VK4dZN/EkTtBhLQN5PFCsHTZYLduGg6j63mvYTbSReYvACQZoPpxRF
         SXd33Yeba0ibkyA7RltVqtSEdvqdIaLRpf0Jhfk/vleXDjlKNEq/erNwDtP9P3xEybVN
         rSbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=48NkwjfxB9Ou5X/gX3NRY0aODFsOoy0dku0gc7W64Mw=;
        fh=+6Jbsur3ge6cs8OW8Z29sDLZhPzUJVDg8cJahHVVF5s=;
        b=F4Z7lqr9PhQBrcnut2F9yY3z4taTxOeStpErvhjOHiaTUSM2wWBuVAo22vfbQCWIRe
         F2pBDkB95g3BMZlElBliAQ53g+VIJtiZCv73YRl3dWpuIwtQUcyOsUMxa93nLi+Fdweg
         sPPtSCd+2b71k9GLYFhgDW8eldC2fHNclWge3yQ/+lwaVrhG964cjxKRd1QcxVIahPzK
         ZUICZVzwDfF/IXuF1yYu7oYYF8lGy/phyyAinAwoe/H/qZuvli3W8JrN7oe1B6sE8X25
         gFCNnjWL35lrh3kjhCUSe8/CwXmLBvRcw5CJFJCp4PLM9kPtb1nqeDiDk60YN4Vx1eej
         KURQ==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773166453; x=1773771253; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=48NkwjfxB9Ou5X/gX3NRY0aODFsOoy0dku0gc7W64Mw=;
        b=IoEMr0zPcc2APRhQRqHrdq/sIBGARGUaEeB8ZRwn9zhpVRQnLUihIk9tDnJhQdzx1g
         d+LiprqU+tmJCvijAMuFm5xzgoJvfmbJ7uuyR+WYeyQ5cEl1vvdHPnrBonj1tbVtnw2h
         XgI7VnMoorPqRDGvc7sQe5fbszzUK6tFY9sv8ZwFnvXtKAg3a+iVA02FJoZUjn8VY01+
         Gl+OZM+SHSXPQ6eefNRlS3hBhQttuQoSJqdOdPpd+ltesz7LK7OdyO6Tpu6WrLLYIEPh
         BFJ0VKYQT7ClH4bFUxaPgBbKmjBXUGqdZJnNs+asCZUgF1gpFWR4TXuQ2wHp2St3Z69c
         eaxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773166453; x=1773771253;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=48NkwjfxB9Ou5X/gX3NRY0aODFsOoy0dku0gc7W64Mw=;
        b=uyLBKlLky9Dov8csvWNiEcimu5rxk7x4/wUQ+Y0HZ2Hwl3YZUPrUxzhtXjsyvGbmtA
         RpWETR5pKzlpCifqEVtspa9PZor5ppw8p88Z7ZWGpeX4aCJhHxOCieuPSwgoNQqSXK8e
         wSmpQhJ7DBoYyGDD0jmHg4ztaLT6YdibuXkMz+TkV1Z7JVOs10pDxvRXa4UE/2Xcy7GW
         wYkqMJFnlcmrL43TxNH7GKPEgODnBsR5hSOvMeJI2l8i5w2G8b3t2x622ddDDmSPxDO+
         sF5rqR+6T8wIkJJ3KaNX/XkRlQTy5xeOKf6y4BQjev8LBdE/G2YAkMlm4BZY4R04VPh4
         N34A==
X-Forwarded-Encrypted: i=1; AJvYcCULG1uyfuYXbyscma/xCj5UjCGZGjoKLnE+eOun6pkdB6vSQdE2GGQ58ZgHg990oyWv8wJjNLX6hvcO@lists.infradead.org
X-Gm-Message-State: AOJu0YyXzSARiuckOMz4Yedk/EyeZ+ECzir2x9N1XAh6LXLIKAwotK0O
	I9nsaGY1POXmWE48GgK7n5loR/K3AzVcrcKvB8gAusk2J2txjjx0J9QiQ/KdS8z8n5E7DJ3TKG4
	XZ4LKYmU2ZyR+/VccrX1cRwnjPEk85vM=
X-Gm-Gg: ATEYQzxP3g82kzRd4kdSaNu/pLziIoIIT2ULIjfoTwJRDHonjJRvnR9QXZS0Cefm1d+
	Stln4KVdL6+iN88YQ+f3cLl8knUfXno6zhoJUeKbIF9ElSyjk34g1Z9PQ9nwIo8b1n0O7mUidKA
	/DUhsdQtYHttO7LKrBEqEt6z/lv3AoIXCpYMcvJ3r3H5C+fMhNRMrfjBI7jAlCYqgOMcaxfjtin
	QFPKKo4ERf9iu6oZvDE5+p5bLlmnIlIA7qaAj7zkxEi4zAlmUOLElmwn5WLDYGgGbP4XCuf8eQw
	xks5rLE=
X-Received: by 2002:a17:90b:39c5:b0:359:99e4:c3fb with SMTP id
 98e67ed59e1d1-359be3443bbmr14563435a91.33.1773166452745; Tue, 10 Mar 2026
 11:14:12 -0700 (PDT)
MIME-Version: 1.0
References: <20260211160859.GA11869@lst.de> <20260212013338.1417091-1-ioerts@kookmin.ac.kr>
 <5eca9b82-c6bc-4d8f-a939-db3399baca57@suse.de> <CAMX6_QG0A=Tow01x7N39iAp=chWCMJGxAF6N+tqGpGQFwjVy6g@mail.gmail.com>
In-Reply-To: <CAMX6_QG0A=Tow01x7N39iAp=chWCMJGxAF6N+tqGpGQFwjVy6g@mail.gmail.com>
From: yunje shin <yjshin0438@gmail.com>
Date: Wed, 11 Mar 2026 03:14:00 +0900
X-Gm-Features: AaiRm52sbqN0mX9i8X1Z_G9Xr8E6z6pNuVMY67p3qhj0S-x11p-6B8YldkxEkcE
Message-ID: <CAMX6_QEbAp7fquLCAPGzxrjNyAg=eP=NdM-a7Ng5CkK84xEyMQ@mail.gmail.com>
Subject: Re: [PATCH v2] nvmet-auth: validate negotiate payload length(BUG:
 KASAN: slab-out-of-bounds)
To: kbusch@kernel.org
Cc: hch@lst.de, Hannes Reinecke <hare@suse.de>, ioerts@kookmin.ac.kr, kch@nvidia.com, 
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org, 
	sagi@grimberg.me
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260310_111413_823098_3BE51E07 
X-CRM114-Status: GOOD (  17.51  )
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

Hi Keith,

Could you take a look at this patch when you get a chance?

It fixes a KASAN slab-out-of-bounds in nvmet_execute_auth_send() by
validating the negotiate payload length before parsing.

Just wanted to check if this can be queued.

Thanks,

Yunje Shin

On Mon, Mar 9, 2026 at 12:12=E2=80=AFAM yunje shin <yjshin0438@gmail.com> w=
rote:
>
> Hi,
> Gentle ping on this patch.
> I wanted to check if it can be queued.
>
> Thanks,
> Yunje Shin
>
> On Thu, Feb 12, 2026 at 8:03=E2=80=AFPM Hannes Reinecke <hare@suse.de> wr=
ote:
> >
> > On 2/12/26 02:33, YunJe Shin wrote:
> > > From: Yunje Shin <ioerts@kookmin.ac.kr>
> > >
> > > AUTH_SEND negotiation requires at least one DH-HMAC-CHAP protocol des=
criptor.
> > > Validate the payload length before parsing the negotiate payload to a=
void
> > > out-of-bounds reads.
> > >
> > > KASAN splat:
> > > [ 1224.388857] BUG: KASAN: slab-out-of-bounds in nvmet_execute_auth_s=
end+0x1d24/0x2090
> > > [ 1224.407035] The buggy address belongs to the cache kmalloc-8 of si=
ze 8
> > > [ 1224.407998] allocated 8-byte region [ffff88800a6537c0, ffff88800a6=
537c8)
> > > [ 1224.412412] page dumped because: kasan: bad access detected
> > >
> > > Use struct_size() for minimum length computation and move the negotia=
te
> > > restart flow into a helper so the call site stays compact.
> > >
> > > Fixes: db1312dd95488 ("nvmet: implement basic In-Band Authentication"=
)
> > > Signed-off-by: Yunje Shin <ioerts@kookmin.ac.kr>
> > > ---
> > > v2:
> > > - use struct_size() for negotiate payload minimum length
> > > - split negotiate handling into nvmet_restart_dhchap_auth() helper
> > > - use NVME_AUTH_DHCHAP_FAILURE_INCORRECT_PAYLOAD instead of NVMe stat=
us
> > >
> > Reviewed-by: Hannes Reinecke <hare@suse.de>
> >
> > Cheers,
> >
> > Hannes
> > --
> > Dr. Hannes Reinecke                  Kernel Storage Architect
> > hare@suse.de                                +49 911 74053 688
> > SUSE Software Solutions GmbH, Frankenstr. 146, 90461 N=C3=BCrnberg
> > HRB 36809 (AG N=C3=BCrnberg), GF: I. Totev, A. McDonald, W. Knoblich

