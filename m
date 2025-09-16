Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B30A7CAC599
	for <linux-nvme@archiver.kernel.org>; Tue, 16 Sep 2025 00:51:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1OpZgX9tytLoNm6IprJcc0k2pObmzkvGtIN3dOD3Knw=; b=emGlF9o68e8OTpXJaUwYVFd6ku
	+dkAxo9cF8tZ7dv9TzXQdK/c6As7NeY87Y7FVP4SBcXPDAe32ff3aoM9pt3J1nGs0qUJSd7ZKosWg
	DmmOWDCagrIzOWOyGFNAmb2f3xrCbmca8aIAfC6PLVRQFPuWXOLiCM+OmXk9YPZEs9ppJ+jpc6xi0
	e1J8nxnuLgLWqbk+DyUPra0V3ztLdu8aO8EM6mmyMPWSoFh0X0vYdGToQL1HVUmrTZ32LgdjgZy37
	T8xNe8KFOl6L3ro0Ogcq8T1J0i2rGJmCkAoPoror1wxII7QZbTBnxQiPZ0HveSZVorPi6pK/p2m6D
	lVMeu2pA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uyJut-000000064ue-0HJw;
	Tue, 16 Sep 2025 00:51:31 +0000
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uyJup-000000064ta-3k2h
	for linux-nvme@lists.infradead.org;
	Tue, 16 Sep 2025 00:51:29 +0000
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-b0787fdb137so714522366b.0
        for <linux-nvme@lists.infradead.org>; Mon, 15 Sep 2025 17:51:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757983886; x=1758588686; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1OpZgX9tytLoNm6IprJcc0k2pObmzkvGtIN3dOD3Knw=;
        b=CsZYY53hOM10LDv+qzZpBYpt+IQY5dx8iVXz9E+kXhEXObFvMFbNNOMa2tnzw5GCuY
         +mqVo1XMvXG9iqNhMEF8HWc72l8MGpeUQLpDRu8AHKeX7ggGKY/xDTPd0/bEFIRZQPOE
         cBo6IWc2PU9ssQjOL0evSaigSRuvHQ4r0sKZaX3AtMvA3BQdd35uw5O1u9O66DO1O1TB
         nfB9j+l962zGe3b8OS+yJGXuarx8S73IaILc9i714AIgGYubrxagJ1CPmiUTObjAPtLi
         //W8HWvz3072+7HPeU6UYApKvjfunW+SNss1WHchtrJ/c0YdEFyTHQImc7AUE/U3Lhpp
         IGIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757983886; x=1758588686;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1OpZgX9tytLoNm6IprJcc0k2pObmzkvGtIN3dOD3Knw=;
        b=Bq9itgtfTgPwvheoDAlWGnojxQbcFNyaw0jBTgYxj+mEgBZl3sNyLN12IsVOTs3B+T
         Xx8lSfmFxuEtcjH2m9efBgYJ0py+6TRXI4vgtKkHYxw0Lgtscl+ATdJ7Yn4tRDascZU1
         JhOpOCmadfUvYSoR0iEaEkuWalEoTEwMRlxoNeAx6qpKMsUSbnG78j1fZSiMIACkYpxj
         CBGRNkYWmKiALKDEAGnLuVpwJATUhtBWWEjmOB9hV7mFuitQpAIUDwxWTBnW+fjZCJGc
         Tx2BLk8M7UhHBIDmtfcng7V7X0VTBiBPR+wN3g/j9oM/cd3XNtvxExwdKJ9olErFMoGx
         aGfw==
X-Forwarded-Encrypted: i=1; AJvYcCX6sMPidLmZ19oVeBLKFyOqgRtzC7Z62/75I1u1h8rLKLK0idYGJnqe3C0hHXNAMVcwZSvbtz0o+54D@lists.infradead.org
X-Gm-Message-State: AOJu0YwzWac1b6HXmWpgiToW6daWVaWiu0A332ZNpbnYodd7OTSIqeTC
	uLv6zGivv32wtQSqSXighkuHYxo9MRXkrLG1LI7VE3WfVI+k2LQdLlPZS2f+YYT0Prgf3M10JYy
	KdPUOPjYdLIeaCvcACmjNnFMVkZPEvys=
X-Gm-Gg: ASbGncsPc1MhZw44L/PjC2WLfj50Ng30yt83gOOh59KKINBsgDgvC11LgEqmMpKwnnt
	RODbk9hytU8UvcQT17G+2ldlF3kVzmMkLtODQTgyXBrmn7XNdGCCsuP/Rwd79Da3G873zr976aH
	fNP9OLZTiV+DoWb0hDRUaoDF5RFOw3ICpXdRKYHAu6/N6b9IF98Yi6IotJy6r36p+VC1gMeWJ5S
	EoMnDMEZUkeyLV6jfFCFVqs0B61cBWvMmSuNQ==
X-Google-Smtp-Source: AGHT+IHPJv+bTBNTeL/MVnMWVNgygry+A18f2/vKjgIuOgWGXPTmc9yHqTETAd2lHq94TaKCPdNN9pZ7qI2l7kdueMA=
X-Received: by 2002:a17:907:2d2c:b0:b07:9c13:153e with SMTP id
 a640c23a62f3a-b07c353e3f8mr1471142666b.2.1757983885391; Mon, 15 Sep 2025
 17:51:25 -0700 (PDT)
MIME-Version: 1.0
References: <20250905024659.811386-1-alistair.francis@wdc.com>
 <68e45231-8344-447d-95cc-4b95a13df353@suse.de> <CAN-5tyFpuEieD8x83vFGgHy8KZBCsAsm7LiZmzpc6OpWPHVFgA@mail.gmail.com>
In-Reply-To: <CAN-5tyFpuEieD8x83vFGgHy8KZBCsAsm7LiZmzpc6OpWPHVFgA@mail.gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 16 Sep 2025 10:50:59 +1000
X-Gm-Features: AS18NWBZ9XgG75BX61NTXxYXdSD62EA-LC37QqP65E-mYxfkmPX6bvhZKH0LJnQ
Message-ID: <CAKmqyKPajmBva5n1qfQ-iQKCtOyD7CsFAdhEiwP8BXV98_OSiw@mail.gmail.com>
Subject: Re: [PATCH v2 0/7] nvme-tcp: Support receiving KeyUpdate requests
To: Olga Kornievskaia <aglo@umich.edu>
Cc: Hannes Reinecke <hare@suse.de>, chuck.lever@oracle.com, hare@kernel.org, 
	kernel-tls-handshake@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-nvme@lists.infradead.org, linux-nfs@vger.kernel.org, kbusch@kernel.org, 
	axboe@kernel.dk, hch@lst.de, sagi@grimberg.me, kch@nvidia.com, 
	Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250915_175127_971657_F5914BE9 
X-CRM114-Status: GOOD (  64.01  )
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

On Tue, Sep 16, 2025 at 2:31=E2=80=AFAM Olga Kornievskaia <aglo@umich.edu> =
wrote:
>
> On Mon, Sep 15, 2025 at 7:46=E2=80=AFAM Hannes Reinecke <hare@suse.de> wr=
ote:
> >
> > On 9/5/25 04:46, alistair23@gmail.com wrote:
> > > From: Alistair Francis <alistair.francis@wdc.com>
> > >
> > > The TLS 1.3 specification allows the TLS client or server to send a
> > > KeyUpdate. This is generally used when the sequence is about to
> > > overflow or after a certain amount of bytes have been encrypted.
> > >
> > > The TLS spec doesn't mandate the conditions though, so a KeyUpdate
> > > can be sent by the TLS client or server at any time. This includes
> > > when running NVMe-OF over a TLS 1.3 connection.
> > >
> > > As such Linux should be able to handle a KeyUpdate event, as the
> > > other NVMe side could initiate a KeyUpdate.
> > >
> > > Upcoming WD NVMe-TCP hardware controllers implement TLS support
> > > and send KeyUpdate requests.
> > >
> > > This series builds on top of the existing TLS EKEYEXPIRED work,
> > > which already detects a KeyUpdate request. We can now pass that
> > > information up to the NVMe layer (target and host) and then pass
> > > it up to userspace.
> > >
> > > Userspace (ktls-utils) will need to save the connection state
> > > in the keyring during the initial handshake. The kernel then
> > > provides the key serial back to userspace when handling a
> > > KeyUpdate. Userspace can use this to restore the connection
> > > information and then update the keys, this final process
> > > is similar to the initial handshake.
> > >
> > > Link: https://datatracker.ietf.org/doc/html/rfc8446#section-4.6.3
> > >
> > > v2:
> > >   - Change "key-serial" to "session-id"
> > >   - Fix reported build failures
> > >   - Drop tls_clear_err() function
> > >   - Stop keep alive timer during KeyUpdate
> > >   - Drop handshake message decoding in the NVMe layer
> > >
> > > Alistair Francis (7):
> > >    net/handshake: Store the key serial number on completion
> > >    net/handshake: Make handshake_req_cancel public
> > >    net/handshake: Expose handshake_sk_destruct_req publically
> > >    nvmet: Expose nvmet_stop_keep_alive_timer publically
> > >    net/handshake: Support KeyUpdate message types
> > >    nvme-tcp: Support KeyUpdate
> > >    nvmet-tcp: Support KeyUpdate
> > >
> > >   Documentation/netlink/specs/handshake.yaml |  19 +++-
> > >   Documentation/networking/tls-handshake.rst |   4 +-
> > >   drivers/nvme/host/tcp.c                    |  88 +++++++++++++++--
> > >   drivers/nvme/target/core.c                 |   1 +
> > >   drivers/nvme/target/tcp.c                  | 104 ++++++++++++++++++=
+--
> > >   include/net/handshake.h                    |  17 +++-
> > >   include/uapi/linux/handshake.h             |  14 +++
> > >   net/handshake/genl.c                       |   5 +-
> > >   net/handshake/handshake.h                  |   1 -
> > >   net/handshake/request.c                    |  18 ++++
> > >   net/handshake/tlshd.c                      |  46 +++++++--
> > >   net/sunrpc/svcsock.c                       |   3 +-
> > >   net/sunrpc/xprtsock.c                      |   3 +-
> > >   13 files changed, 289 insertions(+), 34 deletions(-)
> > >
> >
> > Hey Alistair,
> > thanks for doing this. While the patchset itself looks okay-ish, there
> > are some general ideas/concerns for it:
> >
> > - I have posted a patch for replacing the current 'read_sock()'
> > interface with a recvmsg() base workflow. That should give us
> > access to the 'real' control message, so it would be good if you
> > could fold it in.

Thanks for sending that. I'll rebase my changes on top of the patch
and update it all.

> > - Olga has send a patchset fixing a security issue with control
> > messages; the gist is that the network code expects a 'kvec' based
> > msg buffer when receiving a control message. So essentially one
> > has to receive a message _without_ a control buffer, check for
> > MSG_CTRUNC, and then read the control message via kvec.

Oh interesting. I'll see if I can find the patchset and update my
series to follow that.

> > Can you ensure that your patchset follows these guidelines?
> > - There is no method to trigger a KeyUpdate, making it really hard
> > to test this feature (eg by writin a blktest for it). Ideally we

I have some patches that do send a KeyUpdate [1] which is what I'm
using to test. It allows me to send a KeyUpdate from either side.

> > should be able to trigger it from both directions, but having just
> > one (eg on the target side) should be enough for starters.
> > A possible interface would be to implement write support to the
> > 'tls_key' debugfs attribute; when writing the same key ID as
> > the one currently in use the KeyUpdate mechanism could be started.

That's a good point about allowing userspace and blktest to initiate a
KeyUpdate. I'll look at adding support for a debugfs attribute

> >
> > But thanks for doing the work!
>
> Hi Alistart,
>
> I would like to pingy-pack on this message and ask a few questions as
> I'm a bit confused about this implemenation.
>
> NFS is also interested in being able to handle KeyUpdate functionality
> of TLS and having NvME doing it serves as an example. But the general
> approach confuses me.
>
> All messages go thru a TLS (kernel) layer portion of sock_recvmsg
> (kernel_recvmsg). When the TLS kernel layer detects that it's
> non-TLS-data payload, it does various things depending on whether or
> not control buffer was set up prior to the call to sock_recvmsg.
> KeyUpdate message is a type of HANDSHAKE message and thus non-TLS-data
> payload. While I was doing my changes to NvME code I noticed that
> there are multiple places NvME (target) calls into kernel_recvmsg()
> and thus those places would need to handle receiving non-TLS-data
> payloads. Previously there was a TLS alert which is non-data but now
> there is Handshake (specifically Keyupdate, but not others).
>
> I guess where I'm going is I don't see how NvMe is connecting
> receiving KeyUpdate (ie, identifying that it received specifically
> that and not other handshake type) and its handling of KeyUpdate from
> kernel_recvmsg the when NvME is just normally receiving data.

The kernel TLS layer is handling the KeyUpdate [2]. The current
upstream Linux TLS layer will decode a KeyUpdate and mark a
`key_update_pending`. Note that upstream doesn't actually do a
KeyUpdate, hence this series.

>
> This patch series reads to me as it is expecting KeyUpdate to be a
> part of the Handshake process (ie., there is a patch to "cancel" an
> ongoing handshake, there is an upcall to tlshd with the KeyUpdate?).

No, KeyUpdate can't be part of the handshake process

> This doesn't make sense to me. KeyUpdate, while a type of Handshake
> message, is not done during the handshake -- it is done after sending
> the Finished message which concludes the handshake flow (and
> involvement of tlshd) and can happen at any time during normal TLS
> encrypted message exchange after the handshake. Here's a snippet from
> the TLS spec:

Exactly, KeyUpdate can happen at any time after the handshake.

The general idea is that the TLS layer will detect a KeyUpdate [2],
then report EKEYEXPIRED to the NVMe layer which then asks
ktls-utils/gnutls in user space to update the keys. Does that make
more sense?

>
> The KeyUpdate handshake message is used to indicate that the sender
>    is updating its sending cryptographic keys.  This message can be sent
>    by either peer after it has sent a Finished message.  Implementations
>    that receive a KeyUpdate message prior to receiving a Finished
>    message MUST terminate the connection with an "unexpected_message"
>    alert.
>

1: https://github.com/alistair23/linux/commit/714d58a0aed5d49fb24ea22497024=
c3d958a60b8
2: https://github.com/torvalds/linux/blob/46a51f4f5edade43ba66b3c151f0e25ec=
8b69cb6/net/tls/tls_sw.c#L1775

Alistair

