Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B85CDCAC592
	for <linux-nvme@archiver.kernel.org>; Mon, 15 Sep 2025 16:31:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6Jt1+UfETZdYDXjYgLzR6vo2AiP+w48VdZv8wawn+0M=; b=vCnycc2YKNuGgFvHynHKkcUbnp
	jFJvQbroLO1bb7vv7duhotCXnwvV99NprD0fSlH0TKBTkerf6qY1c6ACKEbe73hnzRPrxWe5YoslJ
	iC3q7MQ8lhkfXILOriy1TWlRUH/LpYeUI2zJyEdrGaeVqKqgZ1f2XuNlpJj4gqrh9Ezctfd858cum
	LmOQXfFUwZeNMOo4U091DwXcZBc+avPKfvj1tyxAA/8pka2nZTcSC2mU4D9Ex/kww0AnttBG42ndm
	JHuHEZSPRUSScPG6e8lyOjZQsB/D9NxC+yX/PPa+lrQhkpAHe+d9fcgD0E8gWHuEF4OlQ/KVZrsqU
	x5CbkmHg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uyC7E-000000057p3-3yM6;
	Mon, 15 Sep 2025 16:31:44 +0000
Received: from mail-lj1-x232.google.com ([2a00:1450:4864:20::232])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uyC7B-000000057n3-2OWK
	for linux-nvme@lists.infradead.org;
	Mon, 15 Sep 2025 16:31:43 +0000
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-33730e1cda7so42220211fa.3
        for <linux-nvme@lists.infradead.org>; Mon, 15 Sep 2025 09:31:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03; t=1757953899; x=1758558699; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6Jt1+UfETZdYDXjYgLzR6vo2AiP+w48VdZv8wawn+0M=;
        b=C/3LgVA0YprHUywBEmTKsmcpfTUwYzkfTZudG/ROL7xmdyjBLnO/KChovbf07NGVco
         90CTWi9uFQZ6L3zmLxXJQJda5etCe4a4SWDpWMByxjf0KRtVCz0k7JHeajbO0RzJPR+F
         BT/4aqOiyDvrujB6XG07LCG8rDAHxZxSO4MvNhe9/qo94Sbca+8BwcvZg/OjuPM4223j
         MeUeHJ2Fh/u+6IxB3p7uszRwzcLDmn+82s3krmrwuv07VhTKVlD7D7q+vtXvtv0Gm14Y
         Xvy25qtjYNNg+11GHTQp9RWn8y8FrOe/S4oVdKtDlI1sfH27xb6mkB55ZSO8qIAFEWlN
         dSxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757953899; x=1758558699;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6Jt1+UfETZdYDXjYgLzR6vo2AiP+w48VdZv8wawn+0M=;
        b=CXWO3d2CDTfJImwR4gH18jZJ4rR1badauLv3wNaN6h7EA4rv+mmX/wLKKpKV9+2Bkp
         UN3qyc4KH/3l5FZtRelBRA/9DS30fWRP1N6GAluriTIvNOO/v1y49JoUEBjjw3V1NTlZ
         L9xrRMM6Dv+7VNtV5ZnJRSFqVktHMUJjtuCJ9ZIBAv4mSw5YZ+ZNUXylU0VeGB64jU0d
         qo4dnpKfUwzaFq4rbTIop33dM6+dzGfw1KeyM8e16IFmh/d+XkLTtXNioDCZMvtQLIjx
         Z4c1AKPjiFA4KdkSkqaVFFodvvDwZ5LWUWIDX/bPj91O7z6zVA/ZD29K/CTM6xRgmLW5
         vuQg==
X-Forwarded-Encrypted: i=1; AJvYcCWau0Yb0NcY9UuUyxcbgC8QDHRv0QZLlcUXLvVKcDDYB8MwVOd0lMn+Q60jI2ZjMsmYx9tpEh5rLoQR@lists.infradead.org
X-Gm-Message-State: AOJu0Yy/Qc/ao7OpmiLypVS8UwUM+G6JuBnq5kHEL7ZM/ZR1J5vRJoIF
	NBTM6stFaIkI8toxDysEEu+zD1K5fH0ajOZCuKBubs+2M3lLAjzleGZqLVbmCb2Z55dCVMCi4dz
	63LYNRPqelir5ssKa+QO/7Xff9yJ97uw=
X-Gm-Gg: ASbGncvVrdas8q3GFZPlr4dH1WaJ+ejH3d8j8MKMf097G1iBA2LCb1wJkRpXiK6Fxa8
	EOCe0g2lVrGxRMBLFQ0yx0CI35Gda7L8eBql4ap4Jq+peeKqgZz23l49Br7OjeVYZPTVlepEH6M
	1cWdt8FUTOY8Nz7BEFb38jUkBEMhg4F8LqnIvMG5VoSF619kfpbctjrYpffdbewMrS6KNad7u1W
	ocV7yYVuyNkJgWboYDZ6UUL3ZnmHdYoggHOVXZlsZYuuPkjq+g=
X-Google-Smtp-Source: AGHT+IHtnSmph/h0KC4z9f50Q+6BzwUwJ7iaIGmhibPS8jP1Axx85iUNHkIBK0jPFftttcjbVKygL9roo+c760YHvw4=
X-Received: by 2002:a05:651c:23d2:20b0:337:f597:60e8 with SMTP id
 38308e7fff4ca-3513e8e00d8mr31239581fa.32.1757953898612; Mon, 15 Sep 2025
 09:31:38 -0700 (PDT)
MIME-Version: 1.0
References: <20250905024659.811386-1-alistair.francis@wdc.com> <68e45231-8344-447d-95cc-4b95a13df353@suse.de>
In-Reply-To: <68e45231-8344-447d-95cc-4b95a13df353@suse.de>
From: Olga Kornievskaia <aglo@umich.edu>
Date: Mon, 15 Sep 2025 12:31:26 -0400
X-Gm-Features: AS18NWAUnzqMw0mf78fw1HcxM7rJw20nnCVSUeVV84heV6QHUZw_m51aGBmhNP8
Message-ID: <CAN-5tyFpuEieD8x83vFGgHy8KZBCsAsm7LiZmzpc6OpWPHVFgA@mail.gmail.com>
Subject: Re: [PATCH v2 0/7] nvme-tcp: Support receiving KeyUpdate requests
To: Hannes Reinecke <hare@suse.de>, alistair23@gmail.com
Cc: chuck.lever@oracle.com, hare@kernel.org, 
	kernel-tls-handshake@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-nvme@lists.infradead.org, linux-nfs@vger.kernel.org, kbusch@kernel.org, 
	axboe@kernel.dk, hch@lst.de, sagi@grimberg.me, kch@nvidia.com, 
	Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250915_093141_766418_97B77F47 
X-CRM114-Status: GOOD (  50.05  )
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

On Mon, Sep 15, 2025 at 7:46=E2=80=AFAM Hannes Reinecke <hare@suse.de> wrot=
e:
>
> On 9/5/25 04:46, alistair23@gmail.com wrote:
> > From: Alistair Francis <alistair.francis@wdc.com>
> >
> > The TLS 1.3 specification allows the TLS client or server to send a
> > KeyUpdate. This is generally used when the sequence is about to
> > overflow or after a certain amount of bytes have been encrypted.
> >
> > The TLS spec doesn't mandate the conditions though, so a KeyUpdate
> > can be sent by the TLS client or server at any time. This includes
> > when running NVMe-OF over a TLS 1.3 connection.
> >
> > As such Linux should be able to handle a KeyUpdate event, as the
> > other NVMe side could initiate a KeyUpdate.
> >
> > Upcoming WD NVMe-TCP hardware controllers implement TLS support
> > and send KeyUpdate requests.
> >
> > This series builds on top of the existing TLS EKEYEXPIRED work,
> > which already detects a KeyUpdate request. We can now pass that
> > information up to the NVMe layer (target and host) and then pass
> > it up to userspace.
> >
> > Userspace (ktls-utils) will need to save the connection state
> > in the keyring during the initial handshake. The kernel then
> > provides the key serial back to userspace when handling a
> > KeyUpdate. Userspace can use this to restore the connection
> > information and then update the keys, this final process
> > is similar to the initial handshake.
> >
> > Link: https://datatracker.ietf.org/doc/html/rfc8446#section-4.6.3
> >
> > v2:
> >   - Change "key-serial" to "session-id"
> >   - Fix reported build failures
> >   - Drop tls_clear_err() function
> >   - Stop keep alive timer during KeyUpdate
> >   - Drop handshake message decoding in the NVMe layer
> >
> > Alistair Francis (7):
> >    net/handshake: Store the key serial number on completion
> >    net/handshake: Make handshake_req_cancel public
> >    net/handshake: Expose handshake_sk_destruct_req publically
> >    nvmet: Expose nvmet_stop_keep_alive_timer publically
> >    net/handshake: Support KeyUpdate message types
> >    nvme-tcp: Support KeyUpdate
> >    nvmet-tcp: Support KeyUpdate
> >
> >   Documentation/netlink/specs/handshake.yaml |  19 +++-
> >   Documentation/networking/tls-handshake.rst |   4 +-
> >   drivers/nvme/host/tcp.c                    |  88 +++++++++++++++--
> >   drivers/nvme/target/core.c                 |   1 +
> >   drivers/nvme/target/tcp.c                  | 104 +++++++++++++++++++-=
-
> >   include/net/handshake.h                    |  17 +++-
> >   include/uapi/linux/handshake.h             |  14 +++
> >   net/handshake/genl.c                       |   5 +-
> >   net/handshake/handshake.h                  |   1 -
> >   net/handshake/request.c                    |  18 ++++
> >   net/handshake/tlshd.c                      |  46 +++++++--
> >   net/sunrpc/svcsock.c                       |   3 +-
> >   net/sunrpc/xprtsock.c                      |   3 +-
> >   13 files changed, 289 insertions(+), 34 deletions(-)
> >
>
> Hey Alistair,
> thanks for doing this. While the patchset itself looks okay-ish, there
> are some general ideas/concerns for it:
>
> - I have posted a patch for replacing the current 'read_sock()'
> interface with a recvmsg() base workflow. That should give us
> access to the 'real' control message, so it would be good if you
> could fold it in.
> - Olga has send a patchset fixing a security issue with control
> messages; the gist is that the network code expects a 'kvec' based
> msg buffer when receiving a control message. So essentially one
> has to receive a message _without_ a control buffer, check for
> MSG_CTRUNC, and then read the control message via kvec.
> Can you ensure that your patchset follows these guidelines?
> - There is no method to trigger a KeyUpdate, making it really hard
> to test this feature (eg by writin a blktest for it). Ideally we
> should be able to trigger it from both directions, but having just
> one (eg on the target side) should be enough for starters.
> A possible interface would be to implement write support to the
> 'tls_key' debugfs attribute; when writing the same key ID as
> the one currently in use the KeyUpdate mechanism could be started.
>
> But thanks for doing the work!

Hi Alistart,

I would like to pingy-pack on this message and ask a few questions as
I'm a bit confused about this implemenation.

NFS is also interested in being able to handle KeyUpdate functionality
of TLS and having NvME doing it serves as an example. But the general
approach confuses me.

All messages go thru a TLS (kernel) layer portion of sock_recvmsg
(kernel_recvmsg). When the TLS kernel layer detects that it's
non-TLS-data payload, it does various things depending on whether or
not control buffer was set up prior to the call to sock_recvmsg.
KeyUpdate message is a type of HANDSHAKE message and thus non-TLS-data
payload. While I was doing my changes to NvME code I noticed that
there are multiple places NvME (target) calls into kernel_recvmsg()
and thus those places would need to handle receiving non-TLS-data
payloads. Previously there was a TLS alert which is non-data but now
there is Handshake (specifically Keyupdate, but not others).

I guess where I'm going is I don't see how NvMe is connecting
receiving KeyUpdate (ie, identifying that it received specifically
that and not other handshake type) and its handling of KeyUpdate from
kernel_recvmsg the when NvME is just normally receiving data.

This patch series reads to me as it is expecting KeyUpdate to be a
part of the Handshake process (ie., there is a patch to "cancel" an
ongoing handshake, there is an upcall to tlshd with the KeyUpdate?).
This doesn't make sense to me. KeyUpdate, while a type of Handshake
message, is not done during the handshake -- it is done after sending
the Finished message which concludes the handshake flow (and
involvement of tlshd) and can happen at any time during normal TLS
encrypted message exchange after the handshake. Here's a snippet from
the TLS spec:

The KeyUpdate handshake message is used to indicate that the sender
   is updating its sending cryptographic keys.  This message can be sent
   by either peer after it has sent a Finished message.  Implementations
   that receive a KeyUpdate message prior to receiving a Finished
   message MUST terminate the connection with an "unexpected_message"
   alert.



>
> Cheers,
>
> Hannes
> --
> Dr. Hannes Reinecke                  Kernel Storage Architect
> hare@suse.de                                +49 911 74053 688
> SUSE Software Solutions GmbH, Frankenstr. 146, 90461 N=C3=BCrnberg
> HRB 36809 (AG N=C3=BCrnberg), GF: I. Totev, A. McDonald, W. Knoblich
>

