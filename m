Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 428C3606A329
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Nov 2026 12:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=Pw+EUyau;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Vpzm+1Kg
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=98mXXJR5XCg4Z4S2yqrizowpYg4fQiN0pgPOU/BiUFY=; b=Pw+EUyauWAbHqT
	//eaGSCSSDaxpiwLrnA/ESlfXrwD/+hacG5A9SF8tFFks+hJ5VBKnuCjKRl1FUTEuRQHo35kvCRGx
	Tyof+CqhRkX6kEA8P3uVYAFf2F0yYqX8Ik7rOmWbyAUA5zoznCbf1Hj8uGLDFOj+lJzKi4KlrHIIW
	uOBVQKMPmXPCVrW1umoJHAR7SBLO3Wa2rI6VzIyYVZ5hGZXpmhC9WLvpGO9Cy9E7Elv/9LJreU/tI
	xJ1EoZFDr8oWhEt/gxGePQJj6LXawsvKk6esLjEOR/B6Oe3R31l9vqq9kmm4NlxHuLyWhROtJGT8B
	n0B2n8XmRa60scqSsWgA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSvzW-00000002NiS-24vf;
	Mon, 16 Nov 2026 12:39:22 +0000
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSN2Z-0000000GsVP-1huC
	for linux-nvme@lists.infradead.org;
	Sat, 14 Nov 2026 23:20:12 +0000
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-6b596569640so4611867a12.1
        for <linux-nvme@lists.infradead.org>; Sat, 14 Nov 2026 15:20:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794698409; cv=none;
        d=google.com; s=arc-20260327;
        b=ETQDd/ok3xAhOQQJ3d2qLeJqn60aLDMDUeInBp8kXuR40P24vjYHz6n1HJNlEfRu9N
         wfrmhqihdHz1AK6lSebeOu/EOC3Gr2aPYKDNfIdT8IaPRjliu12QYhwolM/62h1ZwX7P
         TpW7PSoqukdE6mMMuYUruzkoA6QrZUtnfmA8bhpq/ZDcQM9fuqobdEtoD74ty0nguNFH
         uJc2sfZ82u+WTdWsdWMlL9zLmugcgzxWvVNvcJ6hjXklaRaEUat9FNJVzgJkXm9E/pDK
         T6nDjojBvXuiSdtBrjfjz1lDwLKX3MpemDmu1NDIHrrMB/ZK2dqeBihlZ3R8DdyJWh2j
         sN8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=98mXXJR5XCg4Z4S2yqrizowpYg4fQiN0pgPOU/BiUFY=;
        fh=fweCvOQPqH3b4ceeqcPzXBB3NTUlGOnh3O3uzjGrsYU=;
        b=YEYYUr5c9xKaw+6sWM8x1iFxq8eUBSpH/YazgSRV+8R58gQQHcmr4dbG3pHjWlt1Uw
         012r2gpJOa4Ac2BE6hdiASvgN/ajxiaIBIIgWPN5xgth9/T+kGnA0HzXnY3E+IJphi8u
         8SIMHMhJ8sMvUu91AOTB2bWT6BCkmtOs/M7rufClaAm15YmqtpTLdKQg8e4LkV/Nys/t
         nq7MShz2zRtRUSd0TxFHzXZk4JoCT+sxUZmdkN711rJBPMX5nqbEcp6cZB3Pvb3tG5tM
         PJQEL0wfyO+aeMjyc1WH6JkqddVrgu2gnkeQ6ESHuHSMLk93fhRjiyrYTh9DiLv42fN4
         gsIg==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794698409; x=1795303209; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=98mXXJR5XCg4Z4S2yqrizowpYg4fQiN0pgPOU/BiUFY=;
        b=Vpzm+1Kg6fn/FtACoI2WFXtX2a0Rd6mT1cJ5ZsDGqEEJ4+RURrWV9uQ+g7KgVUz9AW
         Co+gyPqlFl32zN8YwcekWTTiTuItdD1Wy3MD8Nl4cUTjf2GIg3aVzPq8Y2FW7w+kIU7s
         EESaM7Wx+mQ6BTuirFKUFn9xGKLElj+SC+MjOVvAnclJfKxpDWX9dAgcegpamNdrClQm
         d1llR3Qd4mzezRnLkaAlDxLjbQhz9eTgVARa9bCFwbHuLOuwRFM/0tca+BQ8q7MaV3fC
         OuvZh9/4iRo95+9czBWsasnqz0ICWGNZLTFpsBUKXLy95j/zO+eV+YjsLDgQsYtPO+l6
         12gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794698409; x=1795303209;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=98mXXJR5XCg4Z4S2yqrizowpYg4fQiN0pgPOU/BiUFY=;
        b=gMVNs5DRCu32JziqJiRsx1CQlAvaX31A2UHLdgU1c5q+ZG8dY4IZhHNtFCeLlI2zod
         m8WTsY7+ei5ykLeI9OtU6ya0maZqtTSB4ZMSjmvRlMd2zOjP8DGm5jV16OoxbgK9aKmG
         4Iu2m725KwKNCumNi13kKCw6tP0q6iAbPEQt3F/7mGH+CEkRGb3omun4a6bj5V8idhCQ
         U6PViJbqm9Dn5Ql0M/AKu/JGDeIP3+ZNgYWclBeJR3AGrBs3h0w3tJsa3A3Yj2QEqPCT
         uuig2kvX2jeSYU8+0zQunqtZ6+Hb7LDieIAq9is9/DdB56MsGxizOrvdOKQV7eWgncq+
         9JQg==
X-Forwarded-Encrypted: i=1; AL+hErEJDKydRVxIPee26vAe+zcua+XKeZekSBfjLbkRaDKaSeaUfa4isJomZJS8foVfvTKZN7e+Uaut8XDx@lists.infradead.org
X-Gm-Message-State: APuU4Z9GJaHOH9aiAc1wuIluyQiQlzBl2BuaL6oK/yCkrACfD4xbk4z9
	yNG2zjQd4TSbFKulrvwYkKixwy9A1dHfo+bS8YfeMAo7D6n5owde6nr21PNbLkLYqVNZ1a1hqZh
	6Mgi83EO/HXdoPUuZXla0X+jlAj59PE4=
X-Gm-Gg: AYBFou0usf70McR1KQ29ooObjbcGGthQIxLHWeh7maqPZohikmNfv5DsmpN182L5nDF
	0QbYHijsST9E+5nHOth4ZlFgEZopFmEqzAGf1rPVBvOaJifJ6+e9JmNQ3F57Gn7si7iQAWP3pJS
	gmMZumgUMz28j416oJUbpO/UYYBexZT4XZg/qneEyeGcBwyF+skwLwm9waElPsm+B+2q8ysMB8x
	Umb8k4pLAvUNsgb1yjemONwMVdV1aWmIsB6PuAb16q273meogQ4GO0bthSDNwFMOLICe7JU1Phr
	EMckVVlCPuCo7x6AxZrR2sYWJsBerdusPddaQqF9fixF8O3kQGiTM+zUaLjmW728RsSr1Atrc38
	up09/5+mU77W+n/QFaGtJO3hXHJ9C6LGczd8iMWqb6oxrYBJvWr8w0oLb7SfKdj548qtMuw==
X-Received: by 2002:a05:6402:e10:b0:6b7:f00e:5e56 with SMTP id
 4fb4d7f45d1cf-6b7f00e5f37mr1542816a12.1.1794698409123; Sat, 14 Nov 2026
 15:20:09 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261114-work-loop-pseudo-v2-0-98639a2286fb@kernel.org>
 <20261114-work-loop-pseudo-v2-33-98639a2286fb@kernel.org> <20261114120557.4bc1eb6e57218cdc@chrisdown.name>
In-Reply-To: <20261114120557.4bc1eb6e57218cdc@chrisdown.name>
From: Amir Goldstein <amir73il@gmail.com>
Date: Sun, 15 Nov 2026 00:19:57 +0100
X-Gm-Features: AclHuK_YVxhIpv6JLzeNAX5mX5IHGfu05WS6uQ-TCKewxE3JKeci2PyA-UDMCbo
Message-ID: <CAOQ4uxhGxpBtMZ5kfuzR1tQAewiecoX7UjXQRo91QjJHH9T_Yw@mail.gmail.com>
Subject: Re: [PATCH RFC v2 33/42] fs: add file_check_backing()
To: Chris Down <chris@chrisdown.name>
Cc: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, 
	Jann Horn <jannh@google.com>, Chris Mason <mason@kernel.org>, Josef Bacik <josef@toxicpanda.com>, 
	Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-nvme@lists.infradead.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Jan Kara <jack@suse.cz>, linux-scsi@vger.kernel.org, target-devel@vger.kernel.org, 
	driver-core@lists.linux.dev, linux-mm@kvack.org, bpf@vger.kernel.org, 
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org, 
	apparmor@lists.ubuntu.com, linux-nfs@vger.kernel.org, netdev@vger.kernel.org, 
	fuse-devel@lists.linux.dev, linux-efi@vger.kernel.org, 
	xen-devel@lists.xenproject.org, ocfs2-devel@lists.linux.dev, 
	linux-s390@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-usb@vger.kernel.org, linux-erofs@lists.ozlabs.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261114_152011_507417_F875BB48 
X-CRM114-Status: GOOD (  23.55  )
X-Spam-Score: -2.1 (--)
X-Mailman-Approved-At: Mon, 16 Nov 2026 04:39:20 -0800
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
X-Spam-Status: No, score=-2.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sat, Nov 14, 2026 at 9:06=E2=80=AFPM Chris Down <chris@chrisdown.name> w=
rote:
>
> Hi Christian,
>
> Christian Brauner writes:
> >+      /* Look through stacking filesystems at the inode with the data. =
*/
> >+      if (d_real_inode(file->f_path.dentry)->i_sb->s_iflags & SB_I_PSEU=
DO)
> >+              return -EINVAL;
>
> This looks good in general, but what the bots said about O_PATH files
> here is real. With FMODE_PATH this is reached for a file that was never
> opened, so on overlayfs nothing has been through ovl_open() to look up
> the lowerdata of a metacopy file yet. ovl_d_real() then does the lookup
> itself, and when that fails it hits the WARN(1) at its end and returns
> the overlayfs dentry, so the check passes as well.
>
> Only fuse passes FMODE_PATH, so it takes CAP_SYS_ADMIN to get there, but
> it's easy to trigger with that. From a quick test with a metacopy file
> whose redirect into a data-only layer points at nothing, registering an
> O_PATH fd of it with FUSE_DEV_IOC_BACKING_OPEN gives
>
>      ovl_d_real(/f, 0): real dentry not found
>      WARNING: fs/overlayfs/super.c:79 at ovl_d_real+0xc9/0x210
>      [...]
>       file_check_backing+0x308/0x5e0
>       fuse_backing_new+0x219/0x4a0
>       fuse_backing_open+0xe8/0x390
>       fuse_dev_ioctl+0x53a/0x7d0
>
> and the ioctl still succeeds. A normal open of that file fails with
> ENOENT, so nothing could have used it as a backing file anyway, but with
> panic_on_warn this is now a panic.
>
> Maybe ovl_d_real() should just stop warning when the lookup fails, now
> that it has a caller that isn't trace_uprobe?

Yeh I guess that this needs to be a Fixes for lazy data lookup.

The correct fix would be to teach all the callers to deal with an error.

> The check would still pass
> for an O_PATH file whose lowerdata couldn't be looked up at that point,
> though.

One observation relevant to this patch set is that a datadir layer has no
business being a pseudo fs and that can and should be blocked explicitly
at overlayfs mount time.

The other observation is that fuse_passthrough_open() should probably
check the backing_file that was opened for io in addition to checking
in fuse_backing_open(), which could have different FMODE and specifically
could be FMODE_PATH.

Thanks,
Amir.

