Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7005BD58E49
	for <linux-nvme@archiver.kernel.org>; Mon,  2 Mar 2026 03:42:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zrqDabodpEsJKkxhWN4KcMXtyCJKBr+QE9ZCQZCYGgw=; b=OAmZBOBM5os4lyj+FYd2X7Pap3
	cFPpDZO/BpU/v4WjPe/3UcPcFzfzBkHWKb8i0HcCdCFLJ31yRDTTJkMzMx/+FV8Ur8jTe4Rer7v0I
	1ni0nHsP6zGydbA1/KrIXCKhXBUwp+qEDVogh1H4NAytFJpKd0urg4mY438A5Gr1zOQHSH2g0xtY0
	FLOTGROCIEgxUIW776wASorSyrIanz4GnPvT4Xv2/NMumwHBkSeQjVMRAc92c/lGsAiWhD0ADiT0E
	iU8X23gxuWdadVllk2uHAtGAF9Q5tjFzjcwESiuL4uGVEY8+T92sBMqgZDHXPTz1u30aDszAJJwes
	YPTSZ2mA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vwuB5-0000000CBxq-1Uil;
	Mon, 02 Mar 2026 03:42:39 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vwuB4-0000000CBxf-1D7M
	for linux-nvme@bombadil.infradead.org;
	Mon, 02 Mar 2026 03:42:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=zrqDabodpEsJKkxhWN4KcMXtyCJKBr+QE9ZCQZCYGgw=; b=jnHc9xh7+pvd3lKtug5lpcLvKW
	NCBhTjcCcN5+Spb7NbSNlu7xIsIXF9ELMlTtpuk1E1IrvzxACSk53zIRpxPPEkERntLD3CYibQG3h
	SUCFqFZvMX/xvUYirrc9koA83HJfeYBe9tyE+f2fJskGAP66RptwggMgTQIfiexHIi+8/zDGk08wF
	fcgEu04H0DNaZ4mSW+IHH1tMH9MToWDtreObBMtUL0/tpVpacTUE+sOlVChl+CN6chAjXi3z8SfmN
	I2onePPSt9f0xf4PIkeyd8f1XN1Y3EizlFkS7OzlYttiS7lC6SCkqtTs7YmIijXmrP9iIk4uDm11d
	RhoHpw5g==;
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
	by desiato.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vwuB0-0000000GkTw-3QJi
	for linux-nvme@lists.infradead.org;
	Mon, 02 Mar 2026 03:42:36 +0000
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-65c0891f4e9so6989956a12.1
        for <linux-nvme@lists.infradead.org>; Sun, 01 Mar 2026 19:42:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772422952; cv=none;
        d=google.com; s=arc-20240605;
        b=FLz1G0oWTbeHBBRRRFW+FO9XrwzvWIj/C8rt/7Ez/Pr2VU0oxAgAmdvnSU7dc1E6jT
         H3PpfH4nlUoJ7ZdGICO0fL9+ZB3nNLVY5uREF8jvoiysqIbVajZwicIIv5kjYVFKFa1X
         HkRfaWcDPhR9TZ7fP+P39G0DNw4SSxJIbBDaitGxxNO7Z4/X61njVmjkWqzxBToX3pPb
         nZEETOHGUkrsrShgj7bhlRWyTcRwCDbKwDZYr0ntGu2ho9RXAiD8gyOWzVw3qMsmLuow
         IbqTuKgv/Qlj+T6ALdz9ek+Ddcj0ohK+1peaaH95AO6wMsuKv0Dzp58GVtf06CFWU/pY
         bJWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zrqDabodpEsJKkxhWN4KcMXtyCJKBr+QE9ZCQZCYGgw=;
        fh=KeJGBf/MPSGIrG927m6LiBOUZYcHOleAjgvLlHcBAWk=;
        b=T30gh+dQUzKHzzl0LBeYHj2Ay6f+Bat8oG6taxKhwingQJKdIuWV3Ub9b2+3TYnECU
         TKiAuJX9p8gok0tpGL1kUKufW3cUvWxPxwbYMNsc8zQRO8ExdjDeXbApSP0YDOSFr5kt
         8dmyj6bffqbLIcdH3ppo5DoRgKQ18ZvymgjVs18w6GfB6L+Dih8TheEvHIHLxe1I8v6Q
         YFzk/k4T8C/awUN2OeMvHHtr8WIkEFLRX3Hst65VbpvJN44DPwM1pU3Lm7+khmfENuoE
         7QsZw07s8K/gCXhGavUU3BAQl+fpjk5nP1n3XnFOesH3wXPRKKIDbdejXcwBhKIBwqV2
         pvaA==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772422952; x=1773027752; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zrqDabodpEsJKkxhWN4KcMXtyCJKBr+QE9ZCQZCYGgw=;
        b=KgeGUzVWttMn8DeOWL+JLI/AcrJy/k5Xjc2pzZ+KtsHbNDv/F7OpuA1sdZtgIae2il
         ErLWY99x9tgxMQWXQE3UUqSgj2Ik8HOCE3tzd/X0LEIakH5eBhXRDY3c+Pi/biBb2/G3
         QEbSJZn32bLk8ONh8PNFXe0hNVlr+bN9m2mXzDkc0I2k2yrsJl3dIJjLVkfHG3vFXe5s
         qarPxX6RyHL2xgW0t9g4TWHrASI20VjpzB2hewenOTfs1kD8XA1J2RDdRzbYyMfCb6GD
         XOhEKfeM3jI+hWquRBlD6AB3Z8v/wwqfnTnQX26bYScfCp44NSHvLU48P68iVzVXsG/Z
         Ca2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772422952; x=1773027752;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zrqDabodpEsJKkxhWN4KcMXtyCJKBr+QE9ZCQZCYGgw=;
        b=tJHKXSu5ZObP3rGF4IfiO+jrlrMAQKFKPMUoEffcsPb0nzhdInrMiwXrFXNqEZa8nT
         bmBL9euGED2yTAFYMdops08wKNPqmdxltmKfxmntqa5uygaEwyfA8RD4mxZt6IZfQxMx
         SrxbLCDRXWVPBkbryQuAy7dac6UNiBkgFtePfu+mFEzfWIPK7I8NPKBQsUo1fkNAezhd
         TrRM4SeC1DXRL5uiQsLJaLAmwV3BEG9ziEVoDZyJP3ecEu/UOPlMRgErHfFtwDYQ82rV
         68YameauT2SJPttL+DcRehosHQ9b3nGtZO/4m/NppPUKFuqILrh8UEo7rm4IB1tnFGQZ
         EpRA==
X-Forwarded-Encrypted: i=1; AJvYcCXjB/NprdLPIUJSnXUprYO1Tzkb1V0AodaiKpGNASR37aRxmi6dZrt+eSVzoRkTqZmDrBLOkcVXZiAt@lists.infradead.org
X-Gm-Message-State: AOJu0YxW4mGx7JIvbOKupoROYFAMSs13gEvn120AAeVH/HoqVNgT9pri
	dWfMh6TKMPhoZmqvq/xAQy+gTTXAX/BrbTl44O8wRTwEvPx+aIma3R2JtGcvi++IjIsCjnDXTR2
	JYxbsLf+VQrLUH/5Rq30CGuq0LuaAhhk=
X-Gm-Gg: ATEYQzznF22GgZAea1YdFk/AjSx1Su9yDwrCJgY6tapj6ZKfv088Ww7+7xuQJ41OY8X
	sWLfdt2s6ZayBhJabIPOxufrx6Hvo2V5cA7RnXJ8Jv6wzINoWhR1DG3tFH2qVStUpTpuwAiTqB0
	mTKCHqRNHpp0WQcDHblRpV7+LmC8oGAksw3LeuzT4R1hiCyhdIMU841X+czL5wNU8ONR0OvCoah
	xY/v27fraUDoDqk0em2cEavH1N5x76UwvlUMXA8cJXCKG9AIKaTHGzgc1UICdE3it15YUTTLupl
	4Qf5uLulWDVz2EZaLK56hRMo/oX8j4n1YmResQ==
X-Received: by 2002:a05:6402:444c:b0:658:cbf0:6a08 with SMTP id
 4fb4d7f45d1cf-65fddce9a96mr4519593a12.17.1772422951788; Sun, 01 Mar 2026
 19:42:31 -0800 (PST)
MIME-Version: 1.0
References: <20251202051755.1312158-1-alistair.francis@wdc.com>
In-Reply-To: <20251202051755.1312158-1-alistair.francis@wdc.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 2 Mar 2026 13:42:05 +1000
X-Gm-Features: AaiRm53yH__MmXNc8M2DGIvjFYj6-3caIHh5iQg22smno_PgoGcTVnpNu3kw6-o
Message-ID: <CAKmqyKMN+g3hRuLwMwF6qnce415O0ZAG56AoUgm_=wDX8Gwqug@mail.gmail.com>
Subject: Re: [PATCH v4 0/4] Support PSK reauthentication (REPLACETLSPSK)
To: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me, 
	hare@suse.de, kch@nvidia.com, linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260302_034235_212703_DE221649 
X-CRM114-Status: GOOD (  20.23  )
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

On Tue, Dec 2, 2025 at 3:18=E2=80=AFPM <alistair23@gmail.com> wrote:
>
> From: Alistair Francis <alistair.francis@wdc.com>
>
> Allow userspace on the host to trigger a reauth (REPLACETLSPSK) from
> sysfs. This will replace the PSK for the admin queue when using
> a secure concat connection.
>
> This can be done by writing 0 to the `tls_configured_key` sysfs file,
> for example something like this
>
> ```shell
> echo 0 > /sys/devices/virtual/nvme-fabrics/ctl/nvme0/tls_configured_key
> ```
>
> `tls_configured_key` will only appear for concat connections as that is
> all that is supported.
>
> Reading `tls_configured_key` will return the current configured key, whic=
h
> changes after each REPLACETLSPSK operation.
>
> This series also include some fixes for the NVMe target code to ensure
> this works against a Linux NVMe target.
>
> v4:
>  - Forcefully reset the connection after updating the keys
> v3:
>  - Only trigger if a 0 is written to `tls_configured_key`
>  - Add documentation
>
> Alistair Francis (4):
>   nvmet-tcp: Don't error if TLS is enabed on a reset
>   nvmet-tcp: Don't free SQ on authentication success
>   nvme: Expose the tls_configured sysfs for secure concat connections
>   nvme: Allow reauth from sysfs

This series is ready to merge. Can it be picked up?

Alistair

>
>  Documentation/ABI/testing/sysfs-nvme   | 13 ++++++++
>  drivers/nvme/host/sysfs.c              | 46 ++++++++++++++++++++++++--
>  drivers/nvme/target/auth.c             |  4 +--
>  drivers/nvme/target/core.c             |  2 +-
>  drivers/nvme/target/fabrics-cmd-auth.c | 12 +++----
>  drivers/nvme/target/nvmet.h            |  4 +--
>  6 files changed, 68 insertions(+), 13 deletions(-)
>  create mode 100644 Documentation/ABI/testing/sysfs-nvme
>
> --
> 2.51.1
>

