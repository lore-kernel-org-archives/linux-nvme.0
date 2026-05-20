Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4672ECD4F5B
	for <linux-nvme@archiver.kernel.org>; Wed, 20 May 2026 02:59:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Nm6CIpHH9aBKYNyn4RB4weM0wPhHggfU/Ja8w2ciW80=; b=kSbdgcbj+0b/i5bIZ12ZTPOJCE
	7a5aWU6mg7rxKfopoJ4fGkXbqPgAaUys/U9V88vfCKbzwJWTW3EvlcnhzWodPGdfaDXNx4RTCz0OL
	TIRhyQyI+NhpLLWK2e/k59dI7m8IodfOJIebUcXpQhbDSmB41K3hAt4687K2i5lnUc5CZOdNdEtl6
	QTTTCED79brsPBDZBw4HiEbz7DLnaHDZDznkhzn3MMTw5JYz4w5VIZkq1FHTTk/bEd/Iksm4TvHTf
	7AjIAcCKK64QLEdcvvSn8D06WeLQ/HEcfFSgGIM0aS/VZi9BRNuByUkjB85C9/HfEt6yxhTJKAtWz
	DZ09UWOw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wPX9w-00000003LuT-3E1S;
	Wed, 20 May 2026 02:59:48 +0000
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wPX9u-00000003Ltm-0VIx
	for linux-nvme@lists.infradead.org;
	Wed, 20 May 2026 02:59:47 +0000
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-67b32c695efso10585315a12.1
        for <linux-nvme@lists.infradead.org>; Tue, 19 May 2026 19:59:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779245984; cv=none;
        d=google.com; s=arc-20240605;
        b=CJ7U6/VgS/ICvYKdAkLriQNslnBOqTu8fsicczVkXA/E++hGUCVf4y8sE+YYJANy/z
         DS/ssYr6uwVO/HDAPDcbEQbK6mtAq8VAI2AA8cLPDNVGELmGeU6I7LkWAyVrg3ZlppBE
         NCfZQQLbQtz+0TKrzysz0ryWThWyS4XweFJA/GQOWdUBvwuecfnlHId3pVt+v3s+hdmX
         9+l4ajk3TWgie3y3nC0qbCPe0V5oRI3mEj9dbzP1vblBPvVCeQGbYwECgmVr+0rE3zvu
         Ht7/2X/FblwYbT0VDlXBvbjpT/FKnPAmM0r5F3IyODg1rsmJ/h4hXpUVHDrZM9F6ZP87
         YcGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Nm6CIpHH9aBKYNyn4RB4weM0wPhHggfU/Ja8w2ciW80=;
        fh=WoSGW1QG7/3ZXcfid6HFJYB+kHO1yIzeyu2Pwx/dUGI=;
        b=VlQmRD5OXyK9/hnMb2MfWmKoSOK2WvImWkfMF9cdtJ2qN1KKN5a8iofseducx5WP9a
         AAtHlqdp46n04HM9DUKgcKOvSdwUf8qwmxFuHeo6ZVgjkvkXpnSEKnAVtSXaCtnf1OU0
         u77tLbIIFcJR1wI4Vs1GwX3dO3b7M7cfdMh5c5trwXaAlaEVeX87Yq7QJ8gxH4uK/07e
         yqELORCFjsuxz0rfacqSYaJAvlg0DOAPNQOzEh5lzbPFuGKwX6MRf89PKmMWMIvYqbH/
         eHFz2T4p5T7l9UrM4l2mvV0YMeBcCQAOiSqWv4JY5R+JrAogXDs7L7OzEqrjeDExjKn+
         lvzQ==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779245984; x=1779850784; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nm6CIpHH9aBKYNyn4RB4weM0wPhHggfU/Ja8w2ciW80=;
        b=dzMMfIp5AKsflxkBSoxmZrsuR1H/JeEHViuVpIA/J80KRkHxqHtCcIhs7ruTGsv88x
         8cpERlwzXHXSYKOZuA57r9kn81rm1p+IhKuc5GpfXBPkPWmOLrrdgG15kQwxTkwOih9h
         9kRNUA1xgLnVFxo3MqgCJXozB0S6Q9N6ZbMW3yKGCn4yRXIzjR6MfULBkNOhCNhWqR2E
         m2e/m2YzwIk8RhEnKDHSEBpkJsb7ArT4FjNtys3EkC1Pkckv0mXc1w3d6zeI2mdi2YPt
         9KDov0bUXAv3itAshPyrsBXs2afmvHbKqzqHoZ+i+nK6YDDbxmSrOk91DfvRk1hCnOjs
         cNOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779245984; x=1779850784;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Nm6CIpHH9aBKYNyn4RB4weM0wPhHggfU/Ja8w2ciW80=;
        b=YqmBkacV7OOKEI8gIeEvzi3ljvIjbSuDjpox9XXZ8CrvQHy+5AuH6Ivhku6kb8O6XV
         +eRYFJ+goU/3aeylyY/N8hwkzQInr+sZ2MIuDEDOHkHftCQxiaImNQ2Np/pYUMJ9e4C2
         tb5SKO6YJwvMosVpKWhBUs9wuUWHY7qo35eiCSTAM3QCdzRS0+Auh5wKZEoASk4GeUwX
         VJ4oNIj+q9mLEJw6FkQEcvYgOmN4coJBkjXg4fu2vMZ+B7yhmIkGkStkM0MrU4fG31q1
         2Ei9PVVKP+Oqo50HECrPqx7DQQ3a8mypzcIGZMaTt2hIhf/EjcdZOl0Lob4VnmZ/TYGJ
         /fTA==
X-Forwarded-Encrypted: i=1; AFNElJ9glqcmcbnHVDqOJONzEcSLxrJA9w3k3xQNS7mD28IjyiNSkQ1mz4rJDcCgqAsn42A0udOmI/l0t6XP@lists.infradead.org
X-Gm-Message-State: AOJu0Yyu8ZqVul4hov3KHGyjmujWE8kJlz3A3AOucMprRK9B/OA1a33T
	zAV9g5+0UdzPg9H272eMlTbzLtKNFduZwnrvaYFNIw57MfGXSRwZwuvVgiUGU8+X2JR5/cQ/lmg
	Dqh2fWzKP62IOMN+pOjsoosgCrzpNI94=
X-Gm-Gg: Acq92OHtQvZdsIyCzGjPaXMceCgUibg1ggVpMNZ2O13BH9HJwITxGCE6KZ+OVdabDAR
	KcNI+qVqWTExg/PIMw4Z0ynNXq18a22GHdgu7QUBUBY1DoZBQ+3nDTNNlRJg88r90zkkGCTvKn6
	VbviQFUvgH7r9tA5RLiFTbwWyhRJwK6nSGAa9wMQEhbfciy1sYcAn5NcMd9Q/Ngkg7xzwM/r2aZ
	eIzUI7kLNp+124AVXdKdaepz9BzC4Kd5n5+VM+lbhOb1J6mpb7z4cGE3/MKvxullNqsODpRZbWj
	8jk2vKNFN8/vvRS+XABlwKKQ5Yj7mZcBSWXhw5zobHHdlh5M0UI1LbIJ+SA=
X-Received: by 2002:a17:907:9611:b0:bd9:e001:fbc2 with SMTP id
 a640c23a62f3a-bd9e0020955mr188644066b.30.1779245983230; Tue, 19 May 2026
 19:59:43 -0700 (PDT)
MIME-Version: 1.0
References: <20260518-handshake-file-pin-v1-0-4bbcb7e62fda@oracle.com> <20260518-handshake-file-pin-v1-2-4bbcb7e62fda@oracle.com>
In-Reply-To: <20260518-handshake-file-pin-v1-2-4bbcb7e62fda@oracle.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 20 May 2026 12:59:16 +1000
X-Gm-Features: AVHnY4LterXSqMooW_fn189c4rCYxZ0LkAk9IW_2wIKW6Yl8XwJEA0sFFAXx2F0
Message-ID: <CAKmqyKOvK+MVuVy=tMgyVEPoM6gyQGzc2XCxxgRBK8aqRXM=3A@mail.gmail.com>
Subject: Re: [PATCH net 2/7] nvme-tcp: store negative errno in queue->tls_err
To: Chuck Lever <cel@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Chris Mason <clm@meta.com>, Christian Brauner <brauner@kernel.org>, kernel-tls-handshake@lists.linux.dev, 
	linux-nvme@lists.infradead.org, netdev@vger.kernel.org, 
	Chuck Lever <chuck.lever@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260519_195946_181282_C94B9B92 
X-CRM114-Status: GOOD (  19.43  )
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

On Tue, May 19, 2026 at 4:29=E2=80=AFAM Chuck Lever <cel@kernel.org> wrote:
>
> From: Chuck Lever <chuck.lever@oracle.com>
>
> nvme_tcp_tls_done() assigns queue->tls_err in three branches.  The
> ENOKEY lookup failure and the EOPNOTSUPP initializer both store
> negative errnos.  The third branch, reached when the handshake
> layer reports a non-zero status, stores -status.
>
> The handshake layer delivers status to the consumer callback as a
> negative errno; the other in-tree consumers --
> xs_tls_handshake_done() and the nvmet target callback -- treat
> their status argument that way.  The extra negation in
> nvme_tcp_tls_done() flips the sign, leaving tls_err as a positive
> value (for instance, +EIO), which nvme_tcp_start_tls() then
> returns to its caller.
>
> Drop the extra negation so queue->tls_err uniformly carries a
> negative errno on failure.
>
> Fixes: be8e82caa685 ("nvme-tcp: enable TLS handshake upcall")
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  drivers/nvme/host/tcp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index 15d36d6a728e..68a1d7640494 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -1702,7 +1702,7 @@ static void nvme_tcp_tls_done(void *data, int statu=
s, key_serial_t pskid)
>                 qid, pskid, status);
>
>         if (status) {
> -               queue->tls_err =3D -status;
> +               queue->tls_err =3D status;
>                 goto out_complete;
>         }
>
>
> --
> 2.54.0
>
>

