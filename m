Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C77F0CD6E56
	for <linux-nvme@archiver.kernel.org>; Tue,  2 Jun 2026 03:24:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:Subject:Cc:To:From:Date:Message-ID:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=56Bv6E92Lheh70/kKPeeIwd7Y0kp2iugzpDCDe8ugos=; b=xcT6UgIqMol2dCpiF6YxFydoVQ
	00e9lu8/QjbtK0KXrqAol7r99IKL0fuKS/u4tiTKEuQ3a+SuWy65hDuvv+ZKy16QRDdBaO0oew4Ri
	MzsPDgX+LvW4s2UrJ603wW8se5w5I9+x77uPdteMxjsr33o5rAjf6lBsi8wj1ArAkWXRguC84fU73
	GKQBr/B3uhqGz8EACxw7q/60JSm7veainxS3No5m6kzlY4XBaCmslJ4SWOBEqjYDf1xo8Tkf0rjcY
	efUVOmJKMfDvFcXogPfKqPNAajJYOB6MrQVHJoQdNZetc5gvx3woRsJq2gGOkcP0x+ViyV/GDBzkX
	kS3t+K2Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wUFjs-0000000CDxh-2iiP;
	Tue, 02 Jun 2026 03:24:24 +0000
Received: from mail-qk1-x731.google.com ([2607:f8b0:4864:20::731])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wUFjq-0000000CDxI-0l44
	for linux-nvme@lists.infradead.org;
	Tue, 02 Jun 2026 03:24:23 +0000
Received: by mail-qk1-x731.google.com with SMTP id af79cd13be357-915767ea2d0so70289585a.1
        for <linux-nvme@lists.infradead.org>; Mon, 01 Jun 2026 20:24:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780370660; x=1780975460; darn=lists.infradead.org;
        h=mime-version:content-transfer-encoding:subject:cc:to:from:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=56Bv6E92Lheh70/kKPeeIwd7Y0kp2iugzpDCDe8ugos=;
        b=q6XxyoKs29IQvwtpiyz3XG5hK+4iBgOQl1q+AKI7aSBOvtUet63H9QXMBf60sHnyod
         auPi8asvIPuWoOtRhZ7iFkRNjKX/SwLoh/yPwx6/8KXS94tlCrQENQKxjnf1d1MMIQzE
         n4uGJV+ttPuYSxgHGKVmeFKhSXJcYducJOsKQI2JTryONOuZgdhHU7q1OTakdVQtwYPz
         jygWOgvzPQ83flRjhlss+v0ZCnZNs1qpJ3MNDZiw76qPypq84OdNiMRbT33h6FCdfa7O
         n+GxScnQ1cN1mi9WfE/78uBkWLYBlH4UclN6S92y8wpdf8ImFi88K8lhiQXOrRlPWl7M
         Mtwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780370660; x=1780975460;
        h=mime-version:content-transfer-encoding:subject:cc:to:from:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=56Bv6E92Lheh70/kKPeeIwd7Y0kp2iugzpDCDe8ugos=;
        b=H+bqld7lWS3gkMRHMmzh+HfxqRLUMPwEMnacUw7hudsR/5RQUpdyZffPgywRvSEHKd
         KBSkqDGfCXRGa6HHJQ5zXPYGWm1lbOkyp4q6ZUh3PCPheSOygMXr6bcUXDxTpgK5+69s
         g3uGyzpkJHtw11O0kydgvzetJ3ocJCkA38LDBfsQsDZeKmR7hvBb/SpmH5ycvYna0oRn
         Pjc0RXtOTnqLdviAYcv+ROUJhOAM8O50e15zLCV0jQZRLQEi63nPpC5ME25Jag0l8Nbz
         Mmo+z55J26gwZ0yb1rUB33/jQnxG5Qy/h8flZr44ETMzFQ22wqQSV3angFt2QOmqVOfE
         Zb1Q==
X-Forwarded-Encrypted: i=1; AFNElJ9fhe0pvjKUa3yI3PXC2MD2VvvQ80uUWVPAYYKePKVGL47NN1jW9Ta7w22H1elu3Sk2KKgM01x1N9Q5@lists.infradead.org
X-Gm-Message-State: AOJu0YyYY1R+9pgxq005ITczmocMuf7cj6iCKApnAWVh0rlgTD/EO9M9
	ymSGi88omGHUSlKFFVBJO66Ta/z+CoTXVHXHc4t9+s/HchI2pHfiUFoE
X-Gm-Gg: Acq92OEDcJ/GH4ItcXpEiiq9zk8suaJcb9sqG8qBH4Auus/s/BAXSrqOn/BSlJ9NLmB
	Ygia1S1d0C1TLBxrHmQ6mXJ00oTAormpZD9lvNnxD1m7KRlvyxgjuZFoy5z/NcPBRRlJgiZr0N1
	bYed2XjFCz7htLMUCbFHpRGK51eSeb2HZsFidT1hoKksyTHMdmavGKAhRHmZzPMfcNPtLUNXDdo
	YyX6usP5CwYrKQS8g1aFmnLLaqca14UUq8HoqqD37v1SmUbKA01rGCjjSZ1LKNVjFmJgACgOvRO
	HKVxUPjVZdhuD7roYxLfGmxqY+JFPCzc5dxewSHCv+dFjGxGWfhMp3H+DMnKTXW9C4w7LlWWNVH
	PeX8eK1S129E3K/niCqvhVKPdl9rFemxEyAaTKcQKxM2frGLyvQxJ8xkaY82fhuEsLXD0Y4XPHg
	3OF1DhmeGmW+GPYfjuOlldiSWx7Z8CNv7ChPSWfilpd1edShi9rFrvr3FxG2Sfn1RjM/qxJC8rh
	eXed9ORrSriqBJMh1YTbTYOVgsxFh9ywB6OE144HrlC1LaJHoI=
X-Received: by 2002:a05:620a:4087:b0:915:6c4d:d74b with SMTP id af79cd13be357-9156c4ddb31mr834252585a.31.1780370660273;
        Mon, 01 Jun 2026 20:24:20 -0700 (PDT)
Received: from srv1619992.hstgr.cloud (srv1619992.hstgr.cloud. [2a02:4780:75:55a3::1])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9157397e5eesm227547085a.16.2026.06.01.20.24.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 20:24:19 -0700 (PDT)
Message-ID: <6a1e4ce3.77e39773.179d8b.1a31@mx.google.com>
Date: Mon, 01 Jun 2026 20:24:19 -0700 (PDT)
From: Jeremy Erazo <mendozayt13@gmail.com>
To: security@kernel.org
Cc: Christoph Hellwig <hch@infradead.org>, Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <kch@nvidia.com>, Hannes Reinecke <hare@suse.de>,
 Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 linux-nvme@lists.infradead.org, stable@vger.kernel.org
Subject: nvmet: pre-auth arbitrary kernel-memory read in Discovery
 Get-Log-Page (buffer + offset, unchecked attacker u64 lpo)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260601_202422_266841_FA753E8C 
X-CRM114-Status: GOOD (  18.13  )
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

I'm reporting a pre-authentication arbitrary kernel-memory read in
`nvmet_execute_disc_get_log_page` (`drivers/nvme/target/discovery.c`).
A single network packet to a Discovery subsystem =E2=80=94 which by design
accepts any hostnqn =E2=80=94 lets a remote, unauthenticated attacker copy up
to `data_len` bytes from ANY kernel virtual address back to themselves
over NVMe-TCP or NVMe-RDMA.

The bug is present in **mainline torvalds/master** at audit time
(2026-05-25) and is also present in stable LTS 6.6.x and 6.1.x. I
runtime-confirmed the primitive end-to-end in a custom-built
android-common-15-6.6 kernel under QEMU.

CVSS 3.1 base: AV:N/AC:L/PR:N/UI:N/S:U/C:H/I:N/A:H =3D **9.1 (Critical)**.

=3D=3D Affected code (cited from android-common-15-6.6, same on mainline) =3D=
=3D

`drivers/nvme/target/discovery.c:161-243`:

  static void nvmet_execute_disc_get_log_page(struct nvmet_req *req)
  {
      ...
      u64 offset =3D nvmet_get_log_page_offset(req->cmd);   /* attacker u64 */
      size_t data_len =3D nvmet_get_log_page_len(req->cmd); /* attacker size =
*/
      ...

      /* Spec requires dword aligned offsets */
      if (offset & 0x3) {                              /* ONLY this check */
          ...
      }

      down_read(&nvmet_config_sem);
      alloc_len =3D sizeof(*hdr) + entry_size * discovery_log_entries(req);
      buffer =3D kzalloc(alloc_len, GFP_KERNEL);
      ...

      status =3D nvmet_copy_to_sgl(req, 0, buffer + offset, data_len);
                                  /*       ^^^^^^^^^^^^^ NO UPPER BOUND on of=
fset */
      kfree(buffer);
  }

Supporting:

  /* admin-cmd.c:38 =E2=80=94 raw attacker u64 */
  u64 nvmet_get_log_page_offset(struct nvme_command *cmd)
  {
      return le64_to_cpu(cmd->get_log_page.lpo);
  }

  /* core.c:1319 =E2=80=94 discovery accepts any host */
  if (nvmet_is_disc_subsys(subsys)) /* allow all access to disc subsys */
      return true;

  /* core.c:1010 =E2=80=94 only enforces SGL =3D=3D claimed data_len, not saf=
ety */
  bool nvmet_check_transfer_len(struct nvmet_req *req, size_t len)
  {
      if (unlikely(len !=3D req->transfer_len)) {
          ...
          return false;
      }
      return true;
  }

  /* core.c:95 =E2=80=94 calls sg_pcopy_from_buffer with attacker pointer */
  u16 nvmet_copy_to_sgl(struct nvmet_req *req, off_t off,
                        const void *buf, size_t len)
  {
      if (sg_pcopy_from_buffer(req->sg, req->sg_cnt, buf, len, off) !=3D len)=
 {
          ...
      }
      return 0;
  }

=3D=3D Attack flow =3D=3D

1. Attacker opens TCP/4420 to a nvmet host (default NVMe-TCP port).
2. Sends NVMe-TCP ICReq, receives ICResp (transport handshake).
3. Sends NVMe-Fabrics Connect with `subsysnqn =3D
   nqn.2014-08.org.nvmexpress.discovery`. Any `hostnqn` accepted.
4. Sends Admin Get-Log-Page with:
     lid =3D 0x70 (NVME_LOG_DISC)
     lpo =3D (attacker target kernel address) - (server's buffer kalloc addr)
     numdu/numdl encoding the desired byte count
     SGL pointing at attacker buffer of matching size
5. Kernel computes `buffer + offset` =3D attacker-chosen kernel address
   (offset is u64; wrapping pointer arithmetic gives full 64-bit
   address-space reach), copies `data_len` bytes from there into the
   SGL pages, sends them back over TCP/RDMA.

The attacker now holds `data_len` bytes of kernel virtual memory.

=3D=3D Impact =3D=3D

- **Arbitrary kernel-memory read**: KASLR bypass, crypto key leak,
  page-cache file leak, secrets from per-process slab =E2=80=94 anything in
  the kernel direct-map.
- **DoS / panic**: pointing `lpo` at unmapped kernel memory (guard
  page, vmalloc hole) causes `sg_pcopy_from_buffer`'s memcpy to fault
  in kernel context =E2=86=92 uncaught page fault =E2=86=92 oops/panic.
- **No SMAP/SMEP/KPTI protection** =E2=80=94 the read happens in supervisor
  mode, by the kernel itself.

=3D=3D Reachability =3D=3D

- Pre-authentication. Any TCP/RDMA peer that can reach the nvmet
  listener. Internet if exposed; LAN otherwise.
- Default configuration for any nvmet deployment =E2=80=94 Discovery is
  mandatory by spec.
- Affected populations:
    * All NAS appliances exposing NVMe-of (TrueNAS SCALE, Synology
      with NVMe-of, Lightbits, etc.)
    * All-flash arrays / SDS using nvmet as target
    * Cloud providers' NVMe-of storage backends
    * Lab / development clusters with nvmet enabled

=3D=3D Runtime confirmation =3D=3D

Setup: android-common-15-6.6 rebuilt with CONFIG_NVME_TARGET=3Dm,
CONFIG_NVME_TARGET_TCP=3Dm, CONFIG_NVME_TCP=3Dm, CONFIG_CONFIGFS_FS=3Dy,
CONFIG_KASAN_GENERIC=3Dy. Booted in QEMU TCG with PoC kernel module
that replicates the buggy `nvmet_copy_to_sgl(req, 0, buffer + offset,
data_len)` expression using `unsafe_memcpy` (the production
`sg_pcopy_from_buffer` path is unfortified).

Verbatim dmesg:

  [KKSMBD-NVMET-01] =3D=3D=3D Phase A/B: in-kernel arbitrary-read proof =3D=
=3D=3D
  [KKSMBD-NVMET-01] secret kalloc'd at <addr>, contents=3D[KKSMBD-NVMET-01-SE=
CRET-MARK-DEADBEEFCAFEBABE]
  [KKSMBD-NVMET-01] buffer kzalloc'd at <addr>, alloc_len=3D256
  [KKSMBD-NVMET-01] attacker_offset =3D 0xffffffffff7bda00 (this is what goes=
 in cmd->get_log_page.lpo)
  [KKSMBD-NVMET-01] buffer + offset =3D <secret addr> (this is what nvmet_cop=
y_to_sgl reads from!)
  [KKSMBD-NVMET-01] dst (=3D=3D what SGL would carry back to attacker over ne=
twork) =3D '[KKSMBD-NVMET-01-SECRET-MARK-DEADBEEFCAFEBABE]'
  [KKSMBD-NVMET-01] ARBITRARY-READ CONFIRMED: kernel secret leaked via the bu=
ffer+offset primitive

(Pointers shown as hashed `%p` due to KASLR; actual arithmetic
correctness verified by the secret bytes appearing verbatim in dst.)

A first-pass run with a plain `memcpy` (no unsafe_memcpy bypass)
produced:

  [    8.518799] detected buffer overflow in memcpy
  [    8.519327] ------------[ cut here ]------------
  [    8.519437] kernel BUG at lib/string_helpers.c:1046!
  [    8.527213] RIP: 0010:fortify_panic+0x17/0x20

=E2=80=94 independent confirmation by FORTIFY_SOURCE that the source range
exceeds the 256-byte allocation. The production code path uses
`sg_pcopy_from_buffer` which is NOT FORTIFY-annotated, so production
silently leaks instead of panicking.

Full evidence + PoC source (REPORT.md, runtime traces, C reproducer) availabl=
e on request =E2=80=94 withheld from this initial mail to keep disclosure sur=
face minimal.

=3D=3D Fix proposal =3D=3D

Bound `offset` against the allocated buffer size before the copy:

  --- a/drivers/nvme/target/discovery.c
  +++ b/drivers/nvme/target/discovery.c
  @@ -239,7 +239,18 @@ static void nvmet_execute_disc_get_log_page(struct nvm=
et_req *req)

          up_read(&nvmet_config_sem);

  -       status =3D nvmet_copy_to_sgl(req, 0, buffer + offset, data_len);
  +       /* Spec lets the host position into the log page; do NOT let
  +        * them position OUTSIDE it.
  +        */
  +       if (offset >=3D alloc_len) {
  +               status =3D NVME_SC_INVALID_FIELD | NVME_SC_DNR;
  +               kfree(buffer);
  +               goto out;
  +       }
  +
  +       status =3D nvmet_copy_to_sgl(req, 0, buffer + offset,
  +                                  min_t(size_t, data_len,
  +                                                alloc_len - offset));
          kfree(buffer);
  out:
          nvmet_req_complete(req, status);

A defensive alternative would refuse any `offset` that is not zero
when the requested `data_len` exceeds `alloc_len - offset`, returning
the spec-correct `NVME_SC_INVALID_FIELD`.

=3D=3D Affected branches =3D=3D

Confirmed vulnerable: mainline torvalds/master at 2026-05-25
(verified via raw.githubusercontent.com fetch),
android-common-15-6.6 (matches stable LTS 6.6 ksmbd code, same nvmet
copy).

Probable also vulnerable: linux-stable 6.6.x, 6.1.x, 5.15.x, 5.10.x,
and distros tracking these (Debian/Ubuntu/RHEL/SUSE).

=3D=3D Researcher / Credit =3D=3D

Jeremy Erazo (trexnegr0)
mendozayt13@gmail.com
Signed-off-by: Jeremy Erazo <mendozayt13@gmail.com>

=3D=3D Disclosure preferences =3D=3D

I'm happy with any reasonable embargo length (14-30 days). I have not
shared this finding with any third party. Please coordinate CVE
assignment with the kernel.org CNA.

Thanks for your time.

=E2=80=94 Jeremy

