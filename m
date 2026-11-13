Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 721F7606A32E
	for <linux-nvme@archiver.kernel.org>; Fri, 13 Nov 2026 19:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=JQWMIKgI;
	dkim=pass (2048-bit key, unprotected) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=dhbf/2lx
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=G8DmFU4pJwAPCJlqHBF8SKasEEThxtJNlC1sg/CSkLw=; b=JQWMIKgIccPTmoFz3MxzajQjwa
	EZQ6YJHBFKclEiij1EhBmwZkHxIGbCNjp2ZqOQf9LXMG9crYpeRtEUU4Jg2JFmBTwl/xu13+e8Thl
	Q3eBUGagm42rEaMW6wD1AaQZR0nPIGk1B6c8SExmuT09YKmg4bwGZvfkbvT+oTRM9ZTuXhK0y+1Ed
	dvBZOorIxrA8LF5lN9NOJn+4CiSJoh7gq6Y/+AkzmhtP+p0jLiYsOE/7SQqqZs8hYjZPdBLNlmszk
	lWVpBLroZR7sbTCFVPmsBFlWSlTF03WtjswMQaHryi1Mb8cZkf94syCU+IRPxv+lNWW1tR6rj6B6U
	uHCCwZrw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRx3I-0000000ECfY-0OHX;
	Fri, 13 Nov 2026 19:35:12 +0000
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRnzp-0000000CGp7-2re1
	for linux-nvme@lists.infradead.org;
	Fri, 13 Nov 2026 09:55:03 +0000
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-c3f04e0e65fso169260666b.2
        for <linux-nvme@lists.infradead.org>; Fri, 13 Nov 2026 01:54:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20260707.gappssmtp.com; s=20260707; t=1794563698; x=1795168498; darn=lists.infradead.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=G8DmFU4pJwAPCJlqHBF8SKasEEThxtJNlC1sg/CSkLw=;
        b=dhbf/2lxAAghIUQl4WtvFyk963ukEkZB15xldlEN9aycWtR1FZKVbdNStNQuqE0PEq
         BRYfNsRKRdHgNgbTbHQj3KeAoMaZtxlfCtP/Vo84tmzy3DlGQgWHdjSO73ug7PrYNwPO
         K7OGo+dfk8uIM3VFjRSINgMM9b6wUPtYDFVC7UXU28iiRgS/j8Q+z/eUbtsfrjcAXjOc
         bTFlaDHU97fRpe1m8aBIeeLfFg6+vAUw0QJRa3+CQdh55hfeD4fTo1f0flumI9Vk9R4P
         roKvVsM7ltE24jmCYmO0L0NTkyWHNXJFrQ8fkOd8AjpFjvGzu7B4vPbG/W34V4qsoqFl
         joAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794563698; x=1795168498;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=G8DmFU4pJwAPCJlqHBF8SKasEEThxtJNlC1sg/CSkLw=;
        b=0t3T1IZZq7Nd/8CKZfRNYOR4wgR4Atv/XR02fOg+eyIEZDeEZ7Uvqw/WyIz4ulZoGU
         KCb/lVEmbpWVo2xErtzUAkZancXuKnvSssCK+wjNZVqjv3NkhkmB6QF+Ff2QvaZ1ChUl
         IhYofrPaXe1LXX2BjN0DBkw2/8gJnVR0g2cANKuusbGKEZuaSKRVhCshpF/Jvi1y0t1x
         9Sy2IJtLYprjWu48kP+Vze8KvLNYGvWhfnMy0LBJuUB28IwPktjr9+BXSzCw9/TD5kJ5
         Dr9WztoaviR1B3afXsgqhUO9o9uDREidTFA2WSLVH95twum7nzXH+8hRxxso8xw/nj0Q
         /csg==
X-Forwarded-Encrypted: i=1; AL+hErGzUib1UA0cWNFt1HXFXVEUL51qaOWzLT83YA7/OW2emEQdSnzuIqpV12pb0ZH7px+cYlo9ObxFPC6J@lists.infradead.org
X-Gm-Message-State: APuU4Z82IsOPFyxqotehVrDCBoH5HxY6Erw+ctQ7yScCjrZxUcW4MKgR
	Ald3eVl6fBtT1QswwkSxzk9RqMu2CNdfHqN2VtsE5WCqjuHZROmwsJEtUNcFBvkOglkN
X-Gm-Gg: AYBFou2MPovo2lkDrzmwx0Dv9iDNhwWNiUkFq5oUfnVXIbpRSNQeL5HWNkLPOIGBWwV
	2DS6XNlRk4UDu7ehM0W3O6WmquoVHwM/NUXLEnHAiN7sb/xvbwctGmTaoNpd3LOLdgDtMmctqZ/
	Oh7qKr+wGysB/i4qKRoZQbtdj8tqSIiTjX2Rb0t+fXsmRReRcQjtdLKoGcq+N/XwpxupvbotNrO
	AGSR39PJIPeTqc3gvyD6flfmL/MJrYuXAQ19mYtmAMUUaEOhcc+uzdmpFNR3zWjPgmfGaVqOJZ2
	vyN6Ecxvipz0WP5fLq+AAEWJeyf5yte0w5ry39WIOWWxb9lztb44x5vPa6SgwkFpllKthu+/iRt
	WFRFI6C4LLzj/ZMQbs5UZPphrdY/dwXPGW5jvTifI9s5YIZ0fz7U9RROITL3+nPQGQJ7SHzf68/
	9o6aQFSz92sSIsk9ZHwz7CB4a4xwQGJw63no2H2BN2Ptzdl4wGadKgCR0MgJKEVOYKmLprvu6yE
	5McsOsB+dQ/scXNKjB8wDjCDJPJWuIU2q+e3kX64wMJKxYJpwe9W12t0KfkkkvQjNYQyr3HtQ6N
	DrFPti5rwDT6FFKI5Ye95UPfSsIUH3BHeoXutotR9EwxBs6uhriTak+f0epmpuI=
X-Received: by 2002:a17:907:ea93:b0:c41:4c20:5a80 with SMTP id a640c23a62f3a-c50963bdb9bmr198299566b.44.1794563698514;
        Fri, 13 Nov 2026 01:54:58 -0800 (PST)
Received: from [10.0.0.233] (tmo-086-54.customers.d1-online.com. [80.187.86.54])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c50957c6c1fsm75151566b.0.2026.11.13.01.54.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 01:54:58 -0800 (PST)
Message-ID: <b42c9f4d29a9cbea66929c95cc8f736f12703c72.camel@amutable.com>
Subject: Re: [PATCH RFC 01/41] loop: refuse backing files that aren't open
 for reading
From: Alexander Mikhalitsyn <alex@amutable.com>
To: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org
Cc: Jann Horn <jannh@google.com>, Chris Mason <mason@kernel.org>, Josef
 Bacik	 <josef@toxicpanda.com>, Christoph Hellwig <hch@lst.de>, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-nvme@lists.infradead.org, Alexander Viro <viro@zeniv.linux.org.uk>,
 Jan Kara <jack@suse.cz>, linux-scsi@vger.kernel.org,
 target-devel@vger.kernel.org, 	driver-core@lists.linux.dev,
 linux-mm@kvack.org, bpf@vger.kernel.org, 
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org, 
	apparmor@lists.ubuntu.com, linux-nfs@vger.kernel.org,
 netdev@vger.kernel.org, 	fuse-devel@lists.linux.dev,
 linux-efi@vger.kernel.org, 	xen-devel@lists.xenproject.org,
 ocfs2-devel@lists.linux.dev, 	linux-s390@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, 	linux-usb@vger.kernel.org, Amir Goldstein
 <amir73il@gmail.com>, 	linux-erofs@lists.ozlabs.org,
 linux-kselftest@vger.kernel.org, 	stable@vger.kernel.org
Date: Fri, 13 Nov 2026 10:54:56 +0100
In-Reply-To: <20261110-work-loop-pseudo-v1-1-4c998976c6c7@kernel.org>
References: <20261110-work-loop-pseudo-v1-0-4c998976c6c7@kernel.org>
	 <20261110-work-loop-pseudo-v1-1-4c998976c6c7@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261113_015501_989785_30E441BB 
X-CRM114-Status: GOOD (  21.10  )
X-Spam-Score: -1.9 (-)
X-Mailman-Approved-At: Fri, 13 Nov 2026 11:35:09 -0800
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
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, 2026-11-10 at 10:14 +0100, Christian Brauner wrote:
> loop_configure() takes any file as long as it implements -
> >read_iter().
> Loop itself never checked whether the file was actually opened for
> reading. Buffered I/O went through vfs_iter_read() which refuses
> files
> without FMODE_READ. Direct I/O has called ->read_iter() of the
> backing
> file directly ever since loop grew support for it.
>=20
> Since commit f2fed441c69b ("loop: stop using vfs_iter_{read,write}
> for
> buffered I/O") buffered I/O calls ->read_iter() directly as well.
> That
> commit was about O_DIRECT handling and the FMODE_READ check went away
> as a side effect.
>=20
> So whoever can set up a loop device can read a file it was only
> allowed
> to open for writing. Open the file O_WRONLY, configure a loop device
> with it and read the contents through the loop device.
>=20
> Refuse backing files that aren't open for reading. Loop always reads
> from its backing file so a write-only backing file never made sense
> in
> the first place.
>=20
> Fixes: bc07c10a3603 ("block: loop: support DIO & AIO")
> Fixes: f2fed441c69b ("loop: stop using vfs_iter_{read,write} for
> buffered I/O")
> Cc: stable@vger.kernel.org
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Reviewed-by: Alexander Mikhalitsyn <alex@amutable.com>

> ---
> =C2=A0drivers/block/loop.c | 3 +++
> =C2=A01 file changed, 3 insertions(+)
>=20
> diff --git a/drivers/block/loop.c b/drivers/block/loop.c
> index a3325ceab484..c96e35c3ef42 100644
> --- a/drivers/block/loop.c
> +++ b/drivers/block/loop.c
> @@ -528,6 +528,9 @@ static void loop_assign_backing_file(struct
> loop_device *lo, struct file *file)
> =C2=A0
> =C2=A0static int loop_check_backing_file(struct file *file)
> =C2=A0{
> +	if (!(file->f_mode & FMODE_READ))
> +		return -EBADF;
> +
> =C2=A0	if (!file->f_op->read_iter)
> =C2=A0		return -EINVAL;
> =C2=A0

