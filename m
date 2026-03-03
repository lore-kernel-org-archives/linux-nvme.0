Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE7B4E67A6C
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Mar 2026 05:46:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=taIAs3AXYkzr7vIokYXTXrN/WN4WkhUR0T51l939rz4=; b=oTBPXYFdirNtNC9Us7kiR5r/50
	m8MrLne4BWl99DlhozdLtkTQiJ0bYVZlfo/doGBJVkZ4gaJNiZdIrtj8fTpdLHqaWKwtMcODAX55J
	dKSzDl9KFiXvGFrwWcerws52tz2CD9NOHkH5yf4E9eQFWPKHTD/irCspIY+roc0cT/jyu8ZCQUzH/
	ve+s+qmCNqL2G4XM4d2CWzJP879+0OHilpBTLG7oAWrOTPxUTQtjAgKQsaK0VRZ1T5H9pSpEcvkW7
	+22tsyiEU6QQfdRCAQu+aatlBQVKUN2gqaerF+ZX+oBCg1NV8ohdI1Furcz2b7ugMD2D5nS+o2r+w
	rvmKJVXA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vxIap-0000000EZB1-2oxy;
	Tue, 03 Mar 2026 05:46:51 +0000
Received: from mail-lj1-x22a.google.com ([2a00:1450:4864:20::22a])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vxIan-0000000EZA5-2gD7
	for linux-nvme@lists.infradead.org;
	Tue, 03 Mar 2026 05:46:50 +0000
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-38706b10b3bso96447571fa.1
        for <linux-nvme@lists.infradead.org>; Mon, 02 Mar 2026 21:46:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772516807; cv=none;
        d=google.com; s=arc-20240605;
        b=AhENjD//blD8U8NGRL2d0JVUBOOvk6OB1Lmlzgqt9cod9ztDUDN3Cz4rOPNkDx6qbK
         IzxAxNTH3+WBG87R+asREF5pBCCBEVfnZpbTPmcRFIRRoo0quUZ+yStajUo0l1BoAUs2
         rAW9bQnXaBtypgLhD+JfL8tfnUEfl9oDY3+wmtHGxyO5t8V50zB1zZPuCHJ3slzyELR5
         gCSsa2ZlCB47KlAMCQUVTV290s4FSmF1aPU+Fj81VZ4VCARhe+tybfM3dTbq5ORrsLa4
         gSrcwXBKCkCJBwxJl2WBYLpaeJD4AUcjUxqT2ImSvmtyR3gXkWNwWIwo1DuwrUHmbKqK
         8FwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=taIAs3AXYkzr7vIokYXTXrN/WN4WkhUR0T51l939rz4=;
        fh=9cC6xgEI6kWRISAzlxkXU+YkS2gJotRMeB1zzJZTCCg=;
        b=Kdpicbntxnvn2y3vWdipo6V5p7phwXZKlkiNx5ejICjCrvawVQNi0omXnwwNn6oDLC
         YTyIQ4OfdeBNLwz2eXBeo6mvC92N6v/rPjlJ4hEEgv75xYOsAlD4Lf/FMuq8KM9Gm0am
         PHBaUsHhxts2xr+vvS6BUdyXQniE5/HggJ+oDWknSQmgR96tFqygxwRa7JiroHbPcTF4
         /2Ap1/hK56/VLhPpmZGlvN9LEBrgh1plpuXMgvasJM3MNUMjUW7UelbhF/YTMLRD13Yo
         q1rsLTqz25TumPc7HmbMb5jj750meOIq1kU7jv0hoWgLg92UUO5g66FtXlrPmRLV2vIw
         TMNw==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudlinux.com; s=google; t=1772516807; x=1773121607; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=taIAs3AXYkzr7vIokYXTXrN/WN4WkhUR0T51l939rz4=;
        b=TnGwkot3gSugYZOt7Bg107dakSVUCZOgSb9oFhcxCPoVLtUxdDGj0rZ4hzNbWA0bg/
         U08vUnA7Xt9mu33KzSRuKC0NeOv4eBR+B1Ou7Wt5ZFZ/oB7MfBHBZXrWbCMr6TZgTo3e
         7FqjXnxVX2mPTTNUjuiyGih+ULFT67KKC6wuSFJ8AA/j0fa7+Iz7Ja2TrjaJSNUJgTah
         3Qkypo9DT/5Y/04DQdEqH/J90k72uoTtCKqdAr0c+pE1Tr7HnNUDLPcAeEPu4jQ8I4JT
         0jieAe7eDlZCp1upxv3to3OaUbrmlZxm+XPWY2ieCAGztCbwj0jmPC8OnY6szetZ/UsW
         0slg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772516807; x=1773121607;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=taIAs3AXYkzr7vIokYXTXrN/WN4WkhUR0T51l939rz4=;
        b=pi9oCflOo8CtZn7ud3oHJ3iUdnVGTXL+kHWTJq8JR7EC1PCskoAqgVKMTZ9YmkWqrw
         jOHJndzm+GREx7GvJ0OZ9hmZeVghJeIld8GJWiYSGwwkuBrQlI3qpLCBZQSUqUhO2cTb
         xQLv+RIIO/ty5hXypW+6jSQsKhkhqE19g0uqbjvq2TiVH0CVAQfFJUfhl4V+PWS5FSdI
         j4XhjWtux2VGlVhiq1Gj3TLuaua7Bpiv6TQZbnJBhDGHXDPSt3IC9eVf6aVekSNbzRO+
         54PS1AdMtn6Df26BuyNKXN8WtFLsyYbfs0XfFVzEfEVR5UMMFjkypjMmmnKwLwX6LotT
         iEsQ==
X-Gm-Message-State: AOJu0Yy3OGYNPD0FbjXpUJJXGSznRM5POmUrIKHF86LSQP9QJJR6R3HW
	AVYHFsKf/J2+lFQ7vB80ux81gJbo0fQmpePxvr4AwPaZZFyo/EN32NIvNLt47QhpKH6rqij8qZ3
	g7Ay9r+u43CNu2SYoZzlL1Z84eEiwddWZDkPmOgvDRg==
X-Gm-Gg: ATEYQzzbJ8kZ2IwGaAzEr7sYNCvxImIUU9eYv6xDhNtEwRLA3JkJixheNl7CkfPUgTO
	IBCuqQNt/0jawwUor9sBKvwzJNOarTXHa/owwVEHQ/NnknIN4yfZQqx/fdKhqKpQokesn/zH3i0
	bvdDJowteR0Y9euxHsc0d2r7Cjcnse8BJbmhxk2rpMF3rzJpmStgWHi9i09J65hIcVIzOYm9k8x
	nxZchqnpIccUwiNnm7tbhhxYO7lahJADOhrtZm4JQ4uLCh5HYDkCZ/1jSzyOC7/D3f2IB3n57DY
	AddH
X-Received: by 2002:a05:651c:547:b0:38a:9c3:f0ab with SMTP id
 38308e7fff4ca-38a09c3f49amr65707161fa.15.1772516807005; Mon, 02 Mar 2026
 21:46:47 -0800 (PST)
MIME-Version: 1.0
References: <20260223172241.291649-1-jsingh@cloudlinux.com>
In-Reply-To: <20260223172241.291649-1-jsingh@cloudlinux.com>
From: Jaskaran Singh <jsingh@cloudlinux.com>
Date: Tue, 3 Mar 2026 11:16:34 +0530
X-Gm-Features: AaiRm52vEs1QY6VJNlxChyn9QoAYsMj43P9BPL_q_G8p0MBXaolgJYvIl2nS3rM
Message-ID: <CAJyTHZzRBH+MuBxJOW7CGiKLyt3DisvwYvmH9_=EQfD1srf+1w@mail.gmail.com>
Subject: Re: [PATCH 5.10.y 0/2] Fix incorrect backport of nvme-fc ioerr_work cancel_work_sync()
To: stable@vger.kernel.org, james.smart@broadcom.com, kbusch@kernel.org, 
	axboe@fb.com, hch@lst.de, sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
	gregkh@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260302_214649_706344_22CA4CC5 
X-CRM114-Status: GOOD (  14.72  )
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

Gentle ping.

Thanks,
Jaskaran.

On Mon, Feb 23, 2026 at 10:52=E2=80=AFPM Jaskaran Singh <jsingh@cloudlinux.=
com> wrote:
>
> The backport of upstream commit 0a2c5495b6d1 ("nvme: nvme-fc: Ensure
> ->ioerr_work is cancelled in nvme_fc_delete_ctrl()") to linux-5.10.y
> was incorrectly applied as commit 3d78e8e01251.
>
> The original upstream fix moves the cancel_work_sync(&ctrl->ioerr_work)
> call within nvme_fc_delete_ctrl() to after nvme_fc_delete_association(),
> so that ->ioerr_work is not running when the nvme_fc_ctrl object is
> freed. However, the stable backport mistakenly placed the
> cancel_work_sync() call in nvme_fc_reset_ctrl_work() instead of
> nvme_fc_delete_ctrl(), leaving the original bug unfixed while
> introducing an unnecessary change to the reset path.
>
> This series reverts the broken backport and then applies the fix
> correctly.
>
> Jaskaran Singh (2):
>   Revert "nvme: nvme-fc: Ensure ->ioerr_work is cancelled in nvme_fc_dele=
te_ctrl()"
>   nvme: nvme-fc: Ensure ->ioerr_work is cancelled in nvme_fc_delete_ctrl(=
)
>
>  drivers/nvme/host/fc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> --
> 2.43.7
>

