Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31755CD6E56
	for <linux-nvme@archiver.kernel.org>; Tue,  2 Jun 2026 03:32:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:Subject:Cc:To:From:Date:Message-ID:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=j0CKbJj8QrYuhAIDLjRrGgebNjuXjxYKwkDAf/9N+ss=; b=IrTlVm1/dsKSmYcpRrG+DQbe6b
	vVG83Tl5JVFZzqLYXlZSbbFpW59wvJNcXZMdmHXGy0yBByhmpYPHp+NswFdC3B6UlqCAzwLfFAzRl
	Sh3eG7N/LLxhoRQh/8G/rUGdA67lODm28dPHferJObbRR6sdjDwu6+YegBIf79FTycEDkCQa4tKfS
	etnhBqAkxN2ckbEzNJXpFf8TDHzlBCJo04xscd4/JrEsUwxm75sM3FaU6wqj/1+iqfMiot5PfNmt/
	dlW6DnIJKC5d+H6h3wdQeMVFLd9Aky5EORc4SOYAHkcepM8lTy5yfPhG2ITMShBKM8qyoPNuA1xgG
	cOOp+LIg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wUFs1-0000000CERf-3VUa;
	Tue, 02 Jun 2026 03:32:49 +0000
Received: from mail-qv1-xf32.google.com ([2607:f8b0:4864:20::f32])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wUFrz-0000000CEQZ-0wIr
	for linux-nvme@lists.infradead.org;
	Tue, 02 Jun 2026 03:32:48 +0000
Received: by mail-qv1-xf32.google.com with SMTP id 6a1803df08f44-8ccf887de87so31250426d6.0
        for <linux-nvme@lists.infradead.org>; Mon, 01 Jun 2026 20:32:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780371166; x=1780975966; darn=lists.infradead.org;
        h=mime-version:content-transfer-encoding:subject:cc:to:from:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=j0CKbJj8QrYuhAIDLjRrGgebNjuXjxYKwkDAf/9N+ss=;
        b=FBGcwBsPe25rR48QUdR4FKiKBYxPHo/stGM5duFl089de/iod5ZY9vbbmuRzlwjQ9F
         etgFh4jUtW1f8D1COPdTv+77USnIDhNcqQskt/SYWCdDdnra3egrzm35gEYp9yEeiZ+3
         CdSRHULlTzd1Wm01VmGeYv2RCTCKqC6lBiCttIzGaIMI0+OImQiv4ueUyMH/K71dxICX
         ZpaVrqCu+BR+A6LN/uTY63eLz37pMwNQKa+bjiQjMfYF7Ia2sgjoDwYvd8Ou4FFvQdag
         wdzylGh8DpltzZjq5UF0giCiD76q4xMSCYRoO6kP7rA2eQRsIQa3vPYlhlZhfwpDou1g
         Wr+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780371166; x=1780975966;
        h=mime-version:content-transfer-encoding:subject:cc:to:from:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j0CKbJj8QrYuhAIDLjRrGgebNjuXjxYKwkDAf/9N+ss=;
        b=nP8jHAE4kNesDZjdrN+52o7tPpU5cZNkcnjbKYHQKoF7E1LwSY6cOQkOAJHC/eQ86p
         oyOMzTU708AmhpAKx8yUGxs/N7NjvMKIguT+0q9YJn5ykY1Zy2xNwCH5mP5Fq8+aIkBG
         +VPj8yIB6dOMJbLqMmSjYQauHn4KSxZUTJnYKOqdyrljIT6OUZkLDrs2/1SzZFYlRWTk
         n9I1dlZXFkFoSgjNGxpQz5glMlZ2phw5vBKDQbgc9+MRbh4syoz94bs/NYwiWD8CDmKJ
         teVJqUySSw88w7C1ToRd4gGPPKq9SJ8blad7xp9xE00ODnRs0FXXrdp1Df2Z3BdIO3fH
         hdFg==
X-Forwarded-Encrypted: i=1; AFNElJ8Fu7pxKq2TpfjoFpP93QcCF7tedH/kaf049GYh4rmbqhPuzt4wQZ3S4HfotssQb7l1f/deTWz7tpIG@lists.infradead.org
X-Gm-Message-State: AOJu0YxnundaYED1f4XQPp5vgoI5W3EjrnHiPZ5R5vaat6cW4TV8x4bX
	8qkHEtXG7zG/myNJa7RKeYU9X1b/15pOoNUn/MksNYGzkizyhvyHlMklmiG+JNxX48c=
X-Gm-Gg: Acq92OG3XRcCcP9N5SeAW2hTe2X2ZY3oKc9UyWIbdnRc64OL7HGgNofi/c6I1b4dJHQ
	MQShQgs1O0JdWp6jpl334I8wZ0YzpW05coVtwJu57GzrCpIEPqhqIHxEjZXJygABMKy1FHpMg9I
	/GGawx2DzHhglZh7IUB7hvWMPr9qu1c5j5naL4Z8hkdJRWB7yb3ZmRY7acOeu0THQc1Bkls+LZx
	sAl7sYjJmlRn7YGiuAer5YEX1Ys9xgHpDG4HaLOusNneekp2EJWkCv6MmkKuzTbQKbfj4Amg5pi
	DBWgbDbJp+NY1NCWKJfyExn8Z6I+HU4xHTdhyymL0b2S9vxhvSEEOQblMm8KUtFnlWMkmeRDlqr
	ITsZdcQoNw6CA74L5nBVmcGpDevhZAUHscf9Xzs+Plp/3GdLN5KSRJC2kOJnsbf6ry6/ygzvlhK
	8pbm02zLDnn+k/JLEFPpKKVLn4VvMCTSpPxDUBUauJ2MpEd4KN5iLIyJS9xF26K8KAo3HUEm0l7
	5hM+46Up8dhMzkmJ+eEelFM7pJQztuVyWvUKxqIVN0rroUQqJA=
X-Received: by 2002:a05:6214:3482:b0:8cd:7c6a:8147 with SMTP id 6a1803df08f44-8cd7c6a8436mr158018216d6.10.1780371165867;
        Mon, 01 Jun 2026 20:32:45 -0700 (PDT)
Received: from srv1619992.hstgr.cloud (srv1619992.hstgr.cloud. [2a02:4780:75:55a3::1])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ccea042373sm110086696d6.9.2026.06.01.20.32.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 20:32:45 -0700 (PDT)
Message-ID: <6a1e4edd.541e6ed7.68248.dfe4@mx.google.com>
Date: Mon, 01 Jun 2026 20:32:45 -0700 (PDT)
From: Jeremy Erazo <mendozayt13@gmail.com>
To: security@kernel.org
Cc: Christoph Hellwig <hch@infradead.org>, Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <kch@nvidia.com>, Hannes Reinecke <hare@suse.de>,
 Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 linux-nvme@lists.infradead.org, stable@vger.kernel.org
Subject: nvmet: pre-auth heap OOB read in DH-HMAC-CHAP authentication
 (data->hl unchecked in nvmet_auth_reply)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260601_203247_289932_89ED8DF7 
X-CRM114-Status: GOOD (  23.12  )
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

Hi,

I'm reporting an out-of-bounds read in `nvmet_auth_reply()`
(`drivers/nvme/target/fabrics-cmd-auth.c`), reachable from an
unauthenticated remote attacker against any nvmet host that has
DH-HMAC-CHAP authentication enabled on a configured subsystem.

The bug is present in **mainline torvalds/master** at audit time
(2026-06-02, verified via raw.githubusercontent.com fetch). It is
also present in stable LTS 6.6.x and other branches that ship the
NVMe-oF DH-HMAC-CHAP target (the function was added with the
DH-HMAC-CHAP target feature in 6.0).

CVSS 3.1 base: AV:N/AC:L/PR:N/UI:N/S:U/C:H/I:N/A:N =3D **7.5 (High)**.

This is filed shortly after my earlier report of an arbitrary
kernel-memory read in `nvmet_execute_disc_get_log_page` (sent today
to this list). Both are in `drivers/nvme/target/` and both are
attacker-controlled-length-meets-pointer-arithmetic class =E2=80=94 but they
are independent bugs with independent fixes.

=3D=3D Affected code (cited from torvalds/master, 2026-06-02) =3D=3D

`drivers/nvme/target/fabrics-cmd-auth.c::nvmet_execute_auth_send()`
(the AUTH_Send PDU dispatcher) does:

  tl =3D le32_to_cpu(req->cmd->auth_send.tl);  /* attacker u32 */
  if (!tl) { ... goto done; }
  if (!nvmet_check_transfer_len(req, tl)) return;
  d =3D kmalloc(tl, GFP_KERNEL);
  if (!d) { ... }
  status =3D nvmet_copy_from_sgl(req, 0, d, tl);
  /* ... dispatch by data->auth_id ... */
  if (data->auth_id =3D=3D NVME_AUTH_DHCHAP_MESSAGE_REPLY)
      dhchap_status =3D nvmet_auth_reply(req, d);

The ONLY validation of `tl` is "non-zero" and that the SGL transfer
length matches the command's declared length. There is no check that
`tl` is large enough to contain the struct header *plus* the
payload that the message body advertises.

`nvmet_auth_reply()` then does:

  struct nvmf_auth_dhchap_reply_data *data =3D d;
  u16 dhvlen =3D le16_to_cpu(data->dhvlen);
  u8 *response;

  if (dhvlen) {
      if (!ctrl->dh_tfm) ...
      if (nvmet_auth_ctrl_sesskey(req, data->rval + 2 * data->hl,  /* OOB#3 */
                                  dhvlen) < 0) ...
  }

  response =3D kmalloc(data->hl, GFP_KERNEL);
  ...
  if (nvmet_auth_host_hash(req, response, data->hl) < 0) ...
  if (memcmp(data->rval, response, data->hl))            /* OOB#1 */
      ...
  if (data->cvalid) {
      req->sq->dhchap_c2 =3D kmemdup(data->rval + data->hl, data->hl, /* OOB#=
2 */
                                   GFP_KERNEL);
      ...
  }

Three call sites use `data->hl` (an attacker-controlled u8, range
0-255 from the wire) and `data->dhvlen` (an attacker-controlled
__le16, range 0-65535) as offsets into / lengths reading from
`data->rval` without any prior check that the PDU transfer length
contained the corresponding bytes.

Supporting struct (`include/linux/nvme.h:1712`):

  struct nvmf_auth_dhchap_reply_data {
      __u8    auth_type;
      __u8    auth_id;
      __le16  rsvd1;
      __le16  t_id;
      __u8    hl;          /* attacker u8 */
      __u8    rsvd2;
      __u8    cvalid;
      __u8    rsvd3;
      __le16  dhvlen;      /* attacker __le16 */
      __le32  seqnum;
      /* 'hl' bytes of response data */
      __u8    rval[];
      /* followed by 'hl' bytes of Challenge value */
      /* followed by 'dhvlen' bytes of DH value */
  };

`sizeof(struct nvmf_auth_dhchap_reply_data)` =3D 16 bytes (header only).

=3D=3D Attack flow =3D=3D

1. Attacker opens TCP/4420 to a nvmet host that has DH-HMAC-CHAP
   configured on at least one subsystem.
2. Sends NVMe-TCP ICReq, receives ICResp (transport handshake).
3. Sends NVMe-Fabrics Connect with `subsysnqn =3D <target subsys with
   CHAP>`, any `hostnqn`. (Connect succeeds; the controller now
   expects the host to drive the CHAP exchange.)
4. Sends AUTH_Send with `auth_id =3D MESSAGE_NEGOTIATE`, advertising
   any supported hash (e.g., SHA-256).
5. AUTH_Receive =E2=80=94 controller sends CHALLENGE.
6. Sends a malicious AUTH_Send with:
     auth_type  =3D NVME_AUTH_DHCHAP_MESSAGES (1)
     auth_id    =3D NVME_AUTH_DHCHAP_MESSAGE_REPLY (2)
     tl         =3D 16 (sizeof(struct nvmf_auth_dhchap_reply_data) only;
                       no rval[] payload)
     data->hl   =3D 0xff
     data->cvalid =3D 1
     data->dhvlen =3D 0
7. Kernel:
     - kmalloc(16) returns a kmalloc-16 slab object (SLUB rounds up).
     - copy_from_sgl writes the 16-byte attacker header into it.
     - data =3D d; data->rval =3D d + 16 =3D past the allocation.
     - memcmp(data->rval, response, 255) reads 255 bytes starting at
       offset 16 of the kmalloc-16 slab object =E2=80=94 directly into the
       adjacent slab object.
     - If data->cvalid is set, kmemdup(data->rval + 255, 255) reads
       an additional 510 bytes past the allocation and copies 255 of
       them into a new kernel allocation (which the attacker can
       later exfil via further wire messages if the CHAP exchange
       continues, e.g., via AUTH_Receive's payload).

=3D=3D KASAN catch signature (expected) =3D=3D

Under KASAN this produces a slab-out-of-bounds READ report tied to
`memcmp` / `kmemdup` called from `nvmet_auth_reply`:

  BUG: KASAN: slab-out-of-bounds in memcmp+0x... (or __asan_memcmp)
  Read of size 255 at addr ffff... by task kworker/...
  Call Trace:
   memcmp
   nvmet_auth_reply
   nvmet_execute_auth_send
   nvmet_tcp_io_work
   ...

I've prepared an in-kernel proof module
(`nvmet-auth-oob-proof.c`) that replicates the primitive against a
deliberately-undersized buffer to make the KASAN signature explicit;
it's a one-shot module that builds against any current 6.x kernel
tree. Available on request =E2=80=94 withheld from this initial mail to keep
disclosure surface minimal.

A userspace network reproducer (Python NVMe-TCP client driving the
CHAP state machine through the malicious AUTH_Send) is in progress
and will follow.

=3D=3D Fix proposal =3D=3D

Validate the PDU transfer length covers the struct header *plus* the
hl- and dhvlen-derived payload before any pointer arithmetic on
data->rval. The minimal fix sits at the entry to nvmet_auth_reply:

  --- a/drivers/nvme/target/fabrics-cmd-auth.c
  +++ b/drivers/nvme/target/fabrics-cmd-auth.c
  @@ -112,6 +112,7 @@ static u8 nvmet_auth_reply(struct nvmet_req *req, void =
*d)
   {
           struct nvmet_ctrl *ctrl =3D req->sq->ctrl;
           struct nvmf_auth_dhchap_reply_data *data =3D d;
  +        u32 tl =3D le32_to_cpu(req->cmd->auth_send.tl);
           u16 dhvlen =3D le16_to_cpu(data->dhvlen);
           u8 *response;

  @@ -119,6 +120,16 @@ static u8 nvmet_auth_reply(struct nvmet_req *req, void=
 *d)
                    __func__, ctrl->cntlid, req->sq->qid,
                    data->hl, data->cvalid, dhvlen);

  +        /* Confirm the transferred length actually contains the
  +         * rval payload the message body advertises. The host
  +         * response is hl bytes; with cvalid set, hl more bytes
  +         * of challenge follow; with dhvlen set, dhvlen more
  +         * bytes of DH value follow.
  +         */
  +        if (tl < sizeof(*data) + data->hl +
  +                 (data->cvalid ? data->hl : 0) + dhvlen)
  +                return NVME_AUTH_DHCHAP_FAILURE_INCORRECT_PAYLOAD;
  +
           if (dhvlen) {
                   if (!ctrl->dh_tfm)
                           return NVME_AUTH_DHCHAP_FAILURE_INCORRECT_PAYLOAD;

The same shape applies to `nvmet_auth_negotiate` and any other
auth-state handler that reads variable-length fields from the
attacker buffer. A defence-in-depth alternative is to do this length
validation once inside `nvmet_execute_auth_send` before dispatching,
since the handler-specific math (hl, dhvlen, etc.) varies per
message type.

=3D=3D Affected branches =3D=3D

Confirmed vulnerable: mainline torvalds/master at 2026-06-02
(verified via raw.githubusercontent.com fetch).

Probable also vulnerable: linux-stable 6.6.x, 6.1.x (where the
DH-HMAC-CHAP target was backported), and distros tracking those
(Debian/Ubuntu/RHEL/SUSE).

NOT vulnerable: any kernel without `CONFIG_NVME_TARGET_AUTH=3Dy` (the
auth subsystem isn't compiled in).

=3D=3D Threat model =3D=3D

This is reachable pre-final-authentication: the attacker has
completed Fabrics Connect (which establishes the controller binding)
but has not yet completed the CHAP handshake. CHAP is exactly what
this code is supposed to enforce; the bug is in the CHAP enforcement
itself. The kernel cannot rely on CHAP being effective when the CHAP
handler can be tricked into reading past its input buffer before any
secret is verified.

Network reachability is "any host that can open TCP/4420 to the
nvmet target". In production NVMe-oF deployments this is the same
exposure surface that DH-HMAC-CHAP exists to protect =E2=80=94 i.e., the
mitigation is the bug.

=3D=3D Researcher / Credit =3D=3D

Jeremy Erazo (trexnegr0)
mendozayt13@gmail.com
Signed-off-by: Jeremy Erazo <mendozayt13@gmail.com>

=3D=3D Disclosure preferences =3D=3D

I'm happy with any reasonable embargo length (14-30 days). I have
not shared this finding with any third party. Please coordinate CVE
assignment with the kernel.org CNA.

This is the second nvmet finding I'm reporting today; both are
independent bugs but they neighbour each other in the same subsystem
and one combined backport batch on the stable side might be the
cleanest disposition. Happy to coordinate that with whichever route
your team prefers.

Thanks for your time.

=E2=80=94 Jeremy

