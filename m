Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0DDA606A31C
	for <linux-nvme@archiver.kernel.org>; Tue, 20 Oct 2026 20:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=zM9vISwL;
	dkim=pass (2048-bit key, unprotected) header.d=purestorage.com header.i=@purestorage.com header.a=rsa-sha256 header.s=google2022 header.b=fFrf9Ugv
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1MHe8EqbKutlp8VC2MFVDV0PA6f7JPZmNraEYGReU1U=; b=zM9vISwLM21ewQYbdnnRybbEcb
	JOarbsWqpO2T/IJErLW8yaCUiZW9e8GAvzdTc/zAEX42lW+1Mq10EETCQNuvm+vyqxEDe6GWGDg5p
	WpJhOqH9dCED0fwf4J5fGPZgIa0+ZzJaEuaMGLK0zicMxI6IMzHAwgbhOI9WObrNNHLWAQtCPQBf/
	vdt7j74QXcNIYAPn/DLOrY/qZqmKM7mwzNeDQ4/l8noBt+6EraUTScTSaIqs9vRTQJATjQ8I4hh3Q
	pjgQkyOpCuXk9ji9W71jZ6twKVPhJIjjor431g4BuezA5KzvKwVWk/OC0CIoK4WeVb1dH/tMqpdpf
	HSnNg9jA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xJGlq-0000000Adgc-2RjQ;
	Tue, 20 Oct 2026 20:49:18 +0000
Received: from mail-qt1-x831.google.com ([2607:f8b0:4864:20::831])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xJGll-0000000AdeG-1dA0
	for linux-nvme@lists.infradead.org;
	Tue, 20 Oct 2026 20:49:17 +0000
Received: by mail-qt1-x831.google.com with SMTP id d75a77b69052e-5367cc15121so1356021cf.0
        for <linux-nvme@lists.infradead.org>; Tue, 20 Oct 2026 13:49:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792529352; cv=none;
        d=google.com; s=arc-20260327;
        b=OnPNiw9bH8xUY3uI7D7pOQ91W4r/aP/ERvONKZhRekBHBioMpZXtrI63RHfDMnbIHL
         JrvprgCE0ZLV+S6IwqNC8P/lL6w3ftzLWSbln9zhAecSFOEREUFD/HX3CnszCcOIXMAF
         2nxq4MXC02RHL07zRKlwkqxpGAOOkQfmeCRwytoz/gUWMG3k8YboWxGIKtCAWhqxegxH
         Wqzk2mV/dM+XOjvJ7VDkasaKvEhE9qge76wpBMmq83p7RuNIjN7SuqVQYmTOul7GLIjG
         nCuB+1zp1f9abG9AmlSBq2ElMM9GK3fRF6mxuvnCe5+VXUtcL5sc9Wfg9JGCGp1Vc6gH
         2FSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1MHe8EqbKutlp8VC2MFVDV0PA6f7JPZmNraEYGReU1U=;
        fh=2lMejIuHdon0l8l8tAeZistMgo5ZiPCCj17mDtRP1Fc=;
        b=YTnD1IJyoSL11r/V09GdEeqHAAgeoaC6vfu8uBXADiNDX1TzDR+zq/PFEEr3JxtaYF
         CIGG2kO4JuspCpmYlf3ehfZOThpSTx8OA79yQbT6XqBuveJVjg26egQ4tuOev5FYHhLD
         fogzjeexCS7Iqe20q+yoyZJNlP18QjLecOsKJ2clvbAcNtbRwg2cdwU6wLB46yYxhWOW
         g+NdW0klAPdWHkZPOGIwbuBKGImLP1ipivIPIq57B8Zmta3lfaX3NlHRvwkGkJhDgJAF
         6oukr5VCp9cMmZiJ1YzYnD1ko+W4+2cRfzEqQowSTeOS1Ay1K8lEIc1fjUIRtzZyjP4/
         uU2g==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1792529352; x=1793134152; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1MHe8EqbKutlp8VC2MFVDV0PA6f7JPZmNraEYGReU1U=;
        b=fFrf9UgvMx98/R+BkLzEdHkHoaav2pHSAH+xAxBzuvuaCdeBV77mNsX+m0cPeVYAC+
         bPc2qDhjmS+Szqx581jbeqicrL5t5o27+m9ESe2L9bnYcTfKKehPokbrkX9iMyvzjnlh
         9WfYjBK8WZASBhD0Ptaz98aBA2wtY00V3h7VPQel/K3QjZsFFIQhwq92faI5ePDMqXps
         Xdy/cXHZnuIhIhos9Qhagqp3SOS/LcT8UMaIOaO+3wfFp3/HI192MP4pTFsgAsY4mxrm
         Izi+pryNkQYOXZ9rkSfFDfppMnAHNheREo3QPt2UQCnao/bDVQW8D3R0G+QZ6F428oPY
         mgDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792529352; x=1793134152;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1MHe8EqbKutlp8VC2MFVDV0PA6f7JPZmNraEYGReU1U=;
        b=w7u3O9Okob2uacwFYsjgbIKsoKyz2e1zYZStBPcqeQfNws23o++qbG29jvGjSOogmN
         F3pHEc8y67B0E8F91EfXxF+BUecFRIW2raII3lJ9uardzKAOBZ0FvsJqT9+XfcctMNLh
         275gx4kO1GnNitGgHZROlPDhjFwfSQIIuuGMlQsjqBpwgG1MduffWc4aEZn6zfb/QPnT
         nqDWf4DCW/86t27nubNCVWvBKln1/l8o7mil6kM7iDhKCQKKj/9Bj/wKElpqT3avJqLs
         RkATBRtpdubJk/Myg6nxrGVl6SO/DoyzmMk7+3J8q7M4ekw/l6ndzqt2bCt2ZbJ5hmqy
         1sOg==
X-Forwarded-Encrypted: i=1; AKwUvBy6ZkPQXgsrVoQZ1nq+WHmTvYW5hBrQp5E66EIkl+eZ/7M2sVxA3tb/UsrZVpdLL7OoJ5U5fzpUeC+r@lists.infradead.org
X-Gm-Message-State: AFq9FYLRqOzJnP+apl5vTsupNDO/nwRJrgE2PfJrunO2VJ9z0ouxnH37
	wZwoq7ruac/tDfPWrQodmiIGZplQXQxQH/woy9IP1ZAZ8e6bRE/zY997ohx5lgyPArQCGTEUgTm
	B+Vw6aJOZQzFx3uVqWMuseFYzzoUgD0bgOQkyx98arw==
X-Gm-Gg: AYBFou1sBxZq8/jNDNXghPcGaK7BXSLiXtwIiK1zdI9jjK3eqk+QX2JcfwleJYFwBeH
	Xk8xRAvBp6cLJkQzAHCYPYkUHwVWNeEmWHBzyVfcuBJyeXwDH8MllRKjuxUFIeuXtX76YIhK3aT
	O4xZu7fIDA+RavH6lVmCFM85B4iIriyx3p7wmXUj26hW6ukitr8BEoyJl12inqVkIP39l1MrzuM
	9wrxqgdfsSzmckWs57jGXRyrAeTpOT46bx39Tc/2DwIB7mc39OSn1cz9p81yxTQooVbr3erOW0u
	FNc2Vfr63idaZm3i1sDH56aH8unJJ8+kk4OVG5FKLMhFLf61RwTeZjhByiJfLe8QxQ==
X-Received: by 2002:ac8:5e0d:0:b0:536:7dd:16b3 with SMTP id
 d75a77b69052e-536460fe7bbmr180159991cf.75.1792529351307; Tue, 20 Oct 2026
 13:49:11 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20260922200718.3941465-1-sgogte@purestorage.com>
 <20260922200718.3941465-4-sgogte@purestorage.com> <atSzF3URmcpP2_i2@shinmob>
In-Reply-To: <atSzF3URmcpP2_i2@shinmob>
From: "Surabhi Gogte (she/her)" <sgogte@purestorage.com>
Date: Tue, 20 Oct 2026 13:48:33 -0700
X-Gm-Features: AclHuK8HnIWR43B83mn1rOX-ik0z2fMODrU0_UyKTgRbiVGURkvqnAvBk4LN8CE
Message-ID: <CAMof9cVxoNxM70uJa=N+a88YBMmh+EKfXrrckXz=N45U0EKQcg@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] nvme-tcp: parallelize I/O queue allocation and startup
To: "Shin'ichiro Kawasaki" <shinichiro.kawasaki@wdc.com>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, 
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org, 
	linux-kernel@vger.kernel.org, mkhalfella@purestorage.com, 
	randyj@purestorage.com, adailey@purestorage.com, 
	Hannes Reinecke <hare@kernel.org>, dwagner@suse.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261020_134913_812766_F76A633A 
X-CRM114-Status: GOOD (  24.08  )
X-Spam-Score: -2.1 (--)
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
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sun, Oct 18, 2026 at 5:26=E2=80=AFAM Shin'ichiro Kawasaki
<shinichiro.kawasaki@wdc.com> wrote:
>
> On Sep 22, 2026 / 14:07, Surabhi Gogte wrote:
>
> Recently, blktests-CI runs for the kernel at block/for-next branch starte=
d
> reporting failures of the test case nvme/004 (with tcp transport) and md/=
001.
> The kernel reported a WARN related to lock->magic, and it caused the fail=
ures.
> FYI, here I share the failure run log at md/001 [1] and dmesg at the fail=
ure.
>
>   The md/001 confirms a bug fix in md driver. The bug was triggered when =
a
>   nvme device with tcp transport is used as its backend. Then the test ca=
se
>   exercises the nvme-tcp driver, which this patch touches.
>
> I bisected and found that this commit is the trigger of the failures. Whe=
n I
> revert this commit from the block/for-next branch tip with git hash
> 34fbfb9d8d1f, the failure goes away.
>
> Surabhi, could you take a look in the failure?
>

Yes, there is a bug in commit 61b0ed3be81b ("nvme-tcp: parallelize I/O
queue allocation and startup").  To know the queue range before the
queues are set up, it moved the I/O tag set allocation ahead of I/O
queue allocation.  blk_mq_alloc_tag_set() calls
nvme_tcp_init_request() for every request, which takes pf_cache_lock
of the request's queue, but nvme_tcp_alloc_queue() only initializes
that mutex later:
  nvme_tcp_configure_io_queues()
    nvme_alloc_io_tag_set()
      blk_mq_alloc_tag_set()
        blk_mq_alloc_rqs()
          nvme_tcp_init_request()  mutex_lock(pf_cache_lock) <- WARN
    nvme_tcp_setup_io_queues()
      nvme_tcp_alloc_queue()   mutex_init(pf_cache_lock)

So with CONFIG_DEBUG_MUTEXES the first connect trips
DEBUG_LOCKS_WARN_ON(lock->magic !=3D lock) in __mutex_lock().
That matches the call trace in your dmesg.

Daniel Wagner posted a fix for this as patch 1 of [PATCH 0/5]
nvme-fabrics: fix connects with isolated CPUs and queue mapping bugs:
lore : https://lore.kernel.org/all/20261014-nvme-fabrics-isolcpu-v1-0-35515=
6be27b2@kernel.org

It initializes pf_cache_lock for all queues in nvme_tcp_alloc_ctrl(),
right after the queues array is allocated, and drops the
mutex_destroy() calls so the lock stays valid for the lifetime of the
controller.

I ran blktests with his fix on top of block/for-next (34fbfb9d8d1f, the
same tip you bisected on) and md/001 passes with no WARN related to
lock->magic.  Without the fix, the same tree and config fails md/001
with the WARN at kernel/locking/mutex.c:625.

With the fix : nvme-tcp: initialize pf_cache_lock when allocating the contr=
oller
lore : https://lore.kernel.org/all/20261014-nvme-fabrics-isolcpu-v1-1-35515=
6be27b2@kernel.org/

~/blktests$ sudo ./check md/001
md/001 (Raid with bitmap on tcp nvmet with opt-io-size over bitmap
size) [passed]
    runtime  1.779s  ...  1.814s

dmesg :
[  424.545232] run blktests md/001 at 2026-10-20 13:09:35.913402801
[  424.801620] brd: module loaded
[  425.003577] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
[  425.022620] nvmet_tcp: enabling port 0 (127.0.0.1:4420)
[  425.096622] nvmet: Created nvm controller 1 for subsystem
blktests-subsystem-1 for NQN
nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349.
[  425.100018] nvme nvme0: creating 8 I/O queues.
[  425.100179] nvme nvme0: mapped 8/0/0 default/read/poll queues.
[  425.107350] nvme nvme0: new ctrl: NQN "blktests-subsystem-1", addr
127.0.0.1:4420, hostnqn:
nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349
[  425.280674] md: async del_gendisk mode will be removed in future,
please upgrade to mdadm-4.5+
[  425.280688] block device autoloading is deprecated and will be removed.
[  425.328822] md127: array will not be assembled in old kernels that
lack configurable LBS support (<=3D 6.18)
[  425.328835] md/raid1:md127: active with 1 out of 2 mirrors
[  425.330749] md127: detected capacity change from 0 to 2093056
[  425.486853] md127: detected capacity change from 2093056 to 0
[  425.486864] md: md127 stopped.
[  425.512755] nvme nvme0: Removing ctrl: NQN "blktests-subsystem-1"
[  426.367495] brd: module unloaded
[  615.773842] loop0: detected capacity change from 0 to 8
[  915.773735] loop0: detected capacity change from 0 to 8

Tested-by: Surabhi Gogte <sgogte@purestorage.com>



>
> [1] failure of md/001
>
> md/001 (Raid with bitmap on tcp nvmet with opt-io-size over bitmap size) =
[failed]
>     runtime  3.021s  ...  2.970s
>     something found in dmesg:
>     [   79.786635] [    T966] run blktests md/001 at 2026-10-18 20:35:29.=
594227680
>     [   80.157789] [    T984] brd: module loaded
>     [   80.566933] [   T1008] nvmet: adding nsid 1 to subsystem blktests-=
subsystem-1
>     [   80.637888] [   T1011] nvmet_tcp: enabling port 0 (127.0.0.1:4420)
>     [   80.925883] [    T312] nvmet: Created nvm controller 1 for subsyst=
em blktests-subsystem-1 for NQN nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f=
7f-4856-b0b3-51e60b8de349.
>     [   80.940866] [   T1018] nvme nvme5: creating 4 I/O queues.
>     [   80.942243] [   T1018] nvme nvme5: mapped 4/0/0 default/read/poll =
queues.
>     [   80.942689] [   T1018] ------------[ cut here ]------------
>     [   80.942879] [   T1018] DEBUG_LOCKS_WARN_ON(lock->magic !=3D lock)
>     [   80.942882] [   T1018] WARNING: kernel/locking/mutex.c:625 at __mu=
tex_lock+0x1008/0x2510, CPU#0: nvme/1018
>     ...
>     (See '/home/shin/Blktests/blktests/results/nodev/md/001.dmesg' for th=
e entire message)
>
>
> [2] dmesg during md/001
>
> 2026-10-17T22:40:06Z {detected_level=3D"unknown"} [ 2568.828164] run blkt=
ests md/001 at 2026-10-17 22:40:06.674885632
> 2026-10-17T22:40:07Z {detected_level=3D"unknown"} [ 2569.162185] brd: mod=
ule loaded
> 2026-10-17T22:40:07Z {detected_level=3D"unknown"} [ 2569.587993] nvmet: a=
dding nsid 1 to subsystem blktests-subsystem-1
> 2026-10-17T22:40:07Z {detected_level=3D"unknown"} [ 2569.629198] nvmet_tc=
p: enabling port 0 (127.0.0.1:4420)
> 2026-10-17T22:40:07Z {detected_level=3D"unknown"} [ 2569.848587] nvmet: C=
reated nvm controller 1 for subsystem blktests-subsystem-1 for NQN nqn.2014=
-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349.
> 2026-10-17T22:40:07Z {detected_level=3D"unknown"} [ 2569.875225] nvme nvm=
e2: creating 4 I/O queues.
> 2026-10-17T22:40:07Z {detected_level=3D"unknown"} [ 2569.878288] nvme nvm=
e2: mapped 4/0/0 default/read/poll queues.
> 2026-10-17T22:40:07Z {detected_level=3D"unknown"} [ 2569.883211] --------=
----[ cut here ]------------
> 2026-10-17T22:40:07Z {detected_level=3D"debug"}   [ 2569.883660] DEBUG_LO=
CKS_WARN_ON(lock->magic !=3D lock)
> 2026-10-17T22:40:07Z {detected_level=3D"warn"}    [ 2569.883666] WARNING:=
 kernel/locking/mutex.c:625 at __mutex_lock+0xb73/0x2350, CPU#2: nvme/55686
> 2026-10-17T22:40:07Z {detected_level=3D"unknown"} [ 2569.887533] Modules =
linked in: nvme_tcp(E) nvme_fabrics(E) nvmet_tcp(E) nvmet(E) brd(E) raid1(E=
) dm_dust(E) loop(E) xfs(E) tun(E) nvme(E) iTCO_wdt(E) intel_rapl_msr(E) in=
tel_pmc_bxt(E) intel_rapl_common(E) pcspkr(E) i2c_i801(E) i2c_smbus(E) nvme=
_core(E) nvme_keyring(E) virtio_balloon(E) nvme_auth(E) virtio_scsi(E) lpc_=
ich(E) bochs(E) serio_raw(E) qemu_fw_cfg(E) vmw_vsock_virtio_transport(E) v=
mw_vsock_virtio_transport_common(E) vsock(E)
> 2026-10-17T22:40:07Z {detected_level=3D"debug"}   [ 2569.887693] Unloaded=
 tainted modules: nvme_tcp(E):1 nvmet(E):63 nvme_fabrics(E):63 nvme_loop(E)=
:63 loop(E):14 ublk_drv(E):2 null_blk(E):37 scsi_debug(E):53 amd_atl(E):1 e=
dac_mce_amd(E):1 bpf_preload(E):1 [last unloaded: scsi_debug(E)]
> 2026-10-17T22:40:07Z {detected_level=3D"unknown"} [ 2569.899624] CPU: 2 U=
ID: 0 PID: 55686 Comm: nvme Tainted: G            E       7.3.0-rc7 #1 PREE=
MPT(lazy)
> 2026-10-17T22:40:07Z {detected_level=3D"unknown"} [ 2569.902229] Tainted:=
 [E]=3DUNSIGNED_MODULE
> 2026-10-17T22:40:07Z {detected_level=3D"unknown"} [ 2569.903507] Hardware=
 name: KubeVirt None/RHEL, BIOS 1.16.3-4.el9 04/01/2014
> 2026-10-17T22:40:07Z {detected_level=3D"unknown"} [ 2569.905532] RIP: 001=
0:__mutex_lock+0xb7a/0x2350
> 2026-10-17T22:40:07Z {detected_level=3D"unknown"} [ 2569.907336] Code: 38=
 d0 7c 08 84 d2 0f 85 52 17 00 00 44 8b 05 8d af 8d 02 45 85 c0 0f 85 0a f6=
 ff ff 48 8d 3d ad cc 8e 02 48 c7 c6 c0 fd 2f 85 <67> 48 0f b9 3a e9 f2 f5 =
ff ff 4d 8d a7 e0 0e 00 00 4c 89 e7 e8 3d
> 2026-10-17T22:40:07Z {detected_level=3D"unknown"} [ 2569.912320] RSP: 001=
8:ffff8881438c7370 EFLAGS: 00010246
> 2026-10-17T22:40:07Z {detected_level=3D"unknown"} [ 2569.914185] RAX: 000=
0000000000003 RBX: ffff8881face6460 RCX: 1ffffffff0f35008
> 2026-10-17T22:40:07Z {detected_level=3D"unknown"} [ 2569.916368] RDX: 000=
0000000000000 RSI: ffffffff852ffdc0 RDI: ffffffff879b9d70
> 2026-10-17T22:40:07Z {detected_level=3D"unknown"} [ 2569.918675] RBP: fff=
f8881438c74e0 R08: 0000000000000000 R09: fffffbfff0f35008
> 2026-10-17T22:40:07Z {detected_level=3D"unknown"} [ 2569.920803] R10: fff=
fffff879a8047 R11: ffff88812d120008 R12: 0000000000000000
> 2026-10-17T22:40:07Z {detected_level=3D"unknown"} [ 2569.923039] R13: 000=
0000000000000 R14: dffffc0000000000 R15: ffff88812d3a0000
> 2026-10-17T22:40:07Z {detected_level=3D"unknown"} [ 2569.925258] FS:  000=
07fd431b6b640(0000) GS:ffff8882ac2ea000(0000) knlGS:0000000000000000
> 2026-10-17T22:40:07Z {detected_level=3D"unknown"} [ 2569.927640] CS:  001=
0 DS: 0000 ES: 0000 CR0: 0000000080050033
> 2026-10-17T22:40:07Z {detected_level=3D"unknown"} [ 2569.929481] CR2: 000=
07f50088d0c1c CR3: 000000010d0d4006 CR4: 0000000000770ef0
> 2026-10-17T22:40:07Z {detected_level=3D"unknown"} [ 2569.932053] PKRU: 55=
555554
> 2026-10-17T22:40:07Z {detected_level=3D"unknown"} [ 2569.933507] Call Tra=
ce:
> 2026-10-17T22:40:07Z {detected_level=3D"unknown"} [ 2569.934813]  <TASK>
> 2026-10-17T22:40:07Z {detected_level=3D"unknown"} [ 2569.936625]  ? nvme_=
tcp_init_request+0xc8/0x300 [nvme_tcp]
> 2026-10-17T22:40:07Z {detected_level=3D"unknown"} [ 2569.938805]  ? srso_=
alias_return_thunk+0x5/0xfbef5
> 2026-10-17T22:40:07Z {detected_level=3D"unknown"} [ 2569.940675]  ? __all=
oc_frozen_pages_noprof+0x543/0x7c0
> 2026-10-17T22:40:07Z {detected_level=3D"unknown"} [ 2569.942464]  ? __pfx=
___mutex_lock+0x10/0x10
> 2026-10-17T22:40:07Z {detected_level=3D"unknown"} [ 2569.944123]  ? srso_=
alias_return_thunk+0x5/0xfbef5
> 2026-10-17T22:40:07Z {detected_level=3D"unknown"} [ 2569.945814]  ? alloc=
_pages_node_noprof+0xae/0x150
> 2026-10-17T22:40:07Z {detected_level=3D"unknown"} [ 2569.947474]  ? nvme_=
tcp_init_request+0xc8/0x300 [nvme_tcp]
> 2026-10-17T22:40:07Z {detected_level=3D"unknown"} [ 2569.949268]  nvme_tc=
p_init_request+0xc8/0x300 [nvme_tcp]
> 2026-10-17T22:40:07Z {detected_level=3D"unknown"} [ 2569.951141]  blk_mq_=
alloc_rqs+0x3fc/0x6f0
> 2026-10-17T22:40:07Z {detected_level=3D"unknown"} [ 2569.952747]  blk_mq_=
alloc_map_and_rqs+0x168/0x320
> 2026-10-17T22:40:07Z {detected_level=3D"unknown"} [ 2569.954450]  ? srso_=
alias_return_thunk+0x5/0xfbef5
> 2026-10-17T22:40:07Z {detected_level=3D"unknown"} [ 2569.956260]  blk_mq_=
alloc_set_map_and_rqs+0x1be/0x5a0
> 2026-10-17T22:40:07Z {detected_level=3D"unknown"} [ 2569.958088]  blk_mq_=
alloc_tag_set+0x59a/0xc40
> 2026-10-17T22:40:07Z {detected_level=3D"unknown"} [ 2569.959710]  ? srso_=
alias_return_thunk+0x5/0xfbef5
> 2026-10-17T22:40:07Z {detected_level=3D"unknown"} [ 2569.961321]  ? dev_p=
rintk_emit+0xbe/0xf3
> 2026-10-17T22:40:07Z {detected_level=3D"unknown"} [ 2569.962736]  nvme_al=
loc_io_tag_set+0x37d/0x6a0 [nvme_core]
> 2026-10-17T22:40:07Z {detected_level=3D"unknown"} [ 2569.964446]  ? __pfx=
_nvme_alloc_io_tag_set+0x10/0x10 [nvme_core]
> 2026-10-17T22:40:07Z {detected_level=3D"unknown"} [ 2569.966345]  ? percp=
u_ref_put_many.constprop.0+0x7f/0x1b0
> 2026-10-17T22:40:07Z {detected_level=3D"unknown"} [ 2569.968109]  ? __nvm=
e_submit_sync_cmd+0x1e2/0x320 [nvme_core]
> 2026-10-17T22:40:07Z {detected_level=3D"unknown"} [ 2569.970040]  ? srso_=
alias_return_thunk+0x5/0xfbef5
> 2026-10-17T22:40:07Z {detected_level=3D"unknown"} [ 2569.971714]  ? srso_=
alias_return_thunk+0x5/0xfbef5
> 2026-10-17T22:40:07Z {detected_level=3D"info"}    [ 2569.973339]  ? _dev_=
info+0xe6/0x11a
> 2026-10-17T22:40:07Z {detected_level=3D"info"}    [ 2569.974760]  ? __pfx=
__dev_info+0x10/0x10
> 2026-10-17T22:40:07Z {detected_level=3D"unknown"} [ 2569.976153]  ? __pfx=
_nvme_set_queue_count+0x10/0x10 [nvme_core]
> 2026-10-17T22:40:07Z {detected_level=3D"unknown"} [ 2569.977938]  ? lock_=
acquire.part.0+0xc7/0x240
> 2026-10-17T22:40:07Z {detected_level=3D"unknown"} [ 2569.979582]  nvme_tc=
p_configure_io_queues.cold+0x27f/0x8ee [nvme_tcp]
> 2026-10-17T22:40:07Z {detected_level=3D"unknown"} [ 2569.981436]  ? __pfx=
_nvme_enable_ctrl+0x10/0x10 [nvme_core]
> 2026-10-17T22:40:07Z {detected_level=3D"unknown"} [ 2569.983132]  ? lockd=
ep_hardirqs_on_prepare.part.0+0x9b/0x140
> 2026-10-17T22:40:07Z {detected_level=3D"unknown"} [ 2569.984762]  ? __pfx=
_nvme_tcp_configure_io_queues+0x10/0x10 [nvme_tcp]
> 2026-10-17T22:40:07Z {detected_level=3D"unknown"} [ 2569.986525]  nvme_tc=
p_setup_ctrl+0x281/0x5f0 [nvme_tcp]
> 2026-10-17T22:40:07Z {detected_level=3D"unknown"} [ 2569.988113]  ? srso_=
alias_return_thunk+0x5/0xfbef5
> 2026-10-17T22:40:07Z {detected_level=3D"unknown"} [ 2569.989665]  nvme_tc=
p_create_ctrl+0xf6/0x120 [nvme_tcp]
> 2026-10-17T22:40:07Z {detected_level=3D"unknown"} [ 2569.991236]  nvmf_cr=
eate_ctrl+0x34e/0x920 [nvme_fabrics]
> 2026-10-17T22:40:07Z {detected_level=3D"unknown"} [ 2569.992832]  nvmf_de=
v_write+0xd5/0x180 [nvme_fabrics]
> 2026-10-17T22:40:07Z {detected_level=3D"unknown"} [ 2569.994357]  vfs_wri=
te+0x1c7/0x1060
> 2026-10-17T22:40:07Z {detected_level=3D"unknown"} [ 2569.995622]  ? __pfx=
_vfs_write+0x10/0x10
> 2026-10-17T22:40:07Z {detected_level=3D"unknown"} [ 2569.996900]  ksys_wr=
ite+0xf9/0x1d0
> 2026-10-17T22:40:07Z {detected_level=3D"unknown"} [ 2569.998093]  ? __pfx=
_ksys_write+0x10/0x10
> 2026-10-17T22:40:07Z {detected_level=3D"unknown"} [ 2569.999349]  ? srso_=
alias_return_thunk+0x5/0xfbef5
> 2026-10-17T22:40:07Z {detected_level=3D"unknown"} [ 2570.000692]  ? lockd=
ep_hardirqs_on_prepare.part.0+0x9b/0x140
> 2026-10-17T22:40:07Z {detected_level=3D"unknown"} [ 2570.002249]  ? srso_=
alias_return_thunk+0x5/0xfbef5
> 2026-10-17T22:40:07Z {detected_level=3D"unknown"} [ 2570.003675]  ? trace=
_hardirqs_on+0x18/0x160
> 2026-10-17T22:40:07Z {detected_level=3D"unknown"} [ 2570.005046]  do_sysc=
all_64+0xef/0x5a0
> 2026-10-17T22:40:07Z {detected_level=3D"unknown"} [ 2570.006137]  ? kmem_=
cache_free+0x143/0x600
> 2026-10-17T22:40:07Z {detected_level=3D"unknown"} [ 2570.007405]  ? srso_=
alias_return_thunk+0x5/0xfbef5
> 2026-10-17T22:40:07Z {detected_level=3D"unknown"} [ 2570.008722]  ? do_sy=
s_openat2+0x107/0x180
> 2026-10-17T22:40:07Z {detected_level=3D"unknown"} [ 2570.009946]  ? __pfx=
_do_sys_openat2+0x10/0x10
> 2026-10-17T22:40:07Z {detected_level=3D"unknown"} [ 2570.011180]  ? srso_=
alias_return_thunk+0x5/0xfbef5
> 2026-10-17T22:40:07Z {detected_level=3D"unknown"} [ 2570.012539]  ? fput_=
close_sync+0xe5/0x1a0
> 2026-10-17T22:40:07Z {detected_level=3D"unknown"} [ 2570.013752]  ? __pfx=
_fput_close_sync+0x10/0x10
> 2026-10-17T22:40:07Z {detected_level=3D"unknown"} [ 2570.015062]  ? srso_=
alias_return_thunk+0x5/0xfbef5
> 2026-10-17T22:40:07Z {detected_level=3D"unknown"} [ 2570.016455]  ? __x64=
_sys_openat+0x108/0x1d0
> 2026-10-17T22:40:07Z {detected_level=3D"unknown"} [ 2570.017722]  ? __pfx=
___x64_sys_openat+0x10/0x10
> 2026-10-17T22:40:07Z {detected_level=3D"unknown"} [ 2570.019017]  ? trace=
_hardirqs_on_prepare+0x119/0x150
> 2026-10-17T22:40:07Z {detected_level=3D"unknown"} [ 2570.020393]  ? do_sy=
scall_64+0x1d7/0x5a0
> 2026-10-17T22:40:07Z {detected_level=3D"unknown"} [ 2570.021623]  ? do_sy=
scall_64+0x1b9/0x5a0
> 2026-10-17T22:40:07Z {detected_level=3D"unknown"} [ 2570.022876]  ? srso_=
alias_return_thunk+0x5/0xfbef5
> 2026-10-17T22:40:07Z {detected_level=3D"unknown"} [ 2570.024209]  ? trace=
_hardirqs_on_prepare+0x119/0x150
> 2026-10-17T22:40:07Z {detected_level=3D"unknown"} [ 2570.025581]  ? do_sy=
scall_64+0x1b9/0x5a0
> 2026-10-17T22:40:07Z {detected_level=3D"unknown"} [ 2570.026867]  ? srso_=
alias_return_thunk+0x5/0xfbef5
> 2026-10-17T22:40:07Z {detected_level=3D"unknown"} [ 2570.028225]  ? trace=
_hardirqs_on_prepare+0x119/0x150
> 2026-10-17T22:40:07Z {detected_level=3D"unknown"} [ 2570.029718]  ? srso_=
alias_return_thunk+0x5/0xfbef5
> 2026-10-17T22:40:07Z {detected_level=3D"unknown"} [ 2570.031169]  ? do_sy=
scall_64+0x1d7/0x5a0
> 2026-10-17T22:40:07Z {detected_level=3D"unknown"} [ 2570.032408]  ? do_sy=
scall_64+0x1b9/0x5a0
> 2026-10-17T22:40:07Z {detected_level=3D"unknown"} [ 2570.033704]  ? srso_=
alias_return_thunk+0x5/0xfbef5
> 2026-10-17T22:40:07Z {detected_level=3D"unknown"} [ 2570.035099]  ? trace=
_hardirqs_on_prepare+0x119/0x150
> 2026-10-17T22:40:07Z {detected_level=3D"unknown"} [ 2570.036605]  ? srso_=
alias_return_thunk+0x5/0xfbef5
> 2026-10-17T22:40:07Z {detected_level=3D"unknown"} [ 2570.037956]  ? do_sy=
scall_64+0x1d7/0x5a0
> 2026-10-17T22:40:07Z {detected_level=3D"unknown"} [ 2570.039181]  ? srso_=
alias_return_thunk+0x5/0xfbef5
> 2026-10-17T22:40:07Z {detected_level=3D"unknown"} [ 2570.040575]  ? __loc=
k_release.isra.0+0x5b/0x180
> 2026-10-17T22:40:07Z {detected_level=3D"unknown"} [ 2570.041947]  ? srso_=
alias_return_thunk+0x5/0xfbef5
> 2026-10-17T22:40:07Z {detected_level=3D"unknown"} [ 2570.043389]  ? do_us=
er_addr_fault+0x8d3/0xe80
> 2026-10-17T22:40:07Z {detected_level=3D"unknown"} [ 2570.044575]  ? irqen=
try_exit+0xb8/0x810
> 2026-10-17T22:40:07Z {detected_level=3D"unknown"} [ 2570.045690]  ? srso_=
alias_return_thunk+0x5/0xfbef5
> 2026-10-17T22:40:07Z {detected_level=3D"unknown"} [ 2570.046990]  ? do_sy=
scall_64+0x2d/0x5a0
> 2026-10-17T22:40:07Z {detected_level=3D"unknown"} [ 2570.048067]  ? srso_=
alias_return_thunk+0x5/0xfbef5
> 2026-10-17T22:40:07Z {detected_level=3D"unknown"} [ 2570.049302]  ? srso_=
alias_return_thunk+0x5/0xfbef5
> 2026-10-17T22:40:07Z {detected_level=3D"unknown"} [ 2570.050545]  ? do_sy=
scall_64+0x5c/0x5a0
> 2026-10-17T22:40:07Z {detected_level=3D"unknown"} [ 2570.051649]  entry_S=
YSCALL_64_after_hwframe+0x76/0x7e
> 2026-10-17T22:40:07Z {detected_level=3D"unknown"} [ 2570.052916] RIP: 003=
3:0x7fd431c3d56e
> 2026-10-17T22:40:07Z {detected_level=3D"unknown"} [ 2570.053948] Code: 4d=
 89 d8 e8 d4 bd 00 00 4c 8b 5d f8 41 8b 93 08 03 00 00 59 5e 48 83 f8 fc 74=
 11 c9 c3 0f 1f 80 00 00 00 00 48 8b 45 10 0f 05 <c9> c3 83 e2 39 83 fa 08 =
75 e7 e8 03 ff ff ff 0f 1f 00 f3 0f 1e fa
> 2026-10-17T22:40:07Z {detected_level=3D"unknown"} [ 2570.057937] RSP: 002=
b:00007ffdaa469710 EFLAGS: 00000202 ORIG_RAX: 0000000000000001
> 2026-10-17T22:40:07Z {detected_level=3D"unknown"} [ 2570.059733] RAX: fff=
fffffffffffda RBX: 00005609fa418740 RCX: 00007fd431c3d56e
> 2026-10-17T22:40:07Z {detected_level=3D"unknown"} [ 2570.061425] RDX: 000=
00000000000cf RSI: 00005609fa418740 RDI: 0000000000000003
> 2026-10-17T22:40:07Z {detected_level=3D"unknown"} [ 2570.063121] RBP: 000=
07ffdaa469720 R08: 0000000000000000 R09: 0000000000000000
> 2026-10-17T22:40:07Z {detected_level=3D"unknown"} [ 2570.064826] R10: 000=
0000000000000 R11: 0000000000000202 R12: 0000000000000003
> 2026-10-17T22:40:07Z {detected_level=3D"unknown"} [ 2570.066523] R13: 000=
05609fa4175b0 R14: 00000000000000cf R15: 00005609fa4175b0
> 2026-10-17T22:40:07Z {detected_level=3D"unknown"} [ 2570.068235]  </TASK>
> 2026-10-17T22:40:07Z {detected_level=3D"unknown"} [ 2570.069130] irq even=
t stamp: 11409
> 2026-10-17T22:40:07Z {detected_level=3D"unknown"} [ 2570.070225] hardirqs=
 last  enabled at (11409): [<ffffffff850e58f5>] _raw_spin_unlock_irqrestore=
+0x45/0x60
> 2026-10-17T22:40:07Z {detected_level=3D"unknown"} [ 2570.072350] hardirqs=
 last disabled at (11408): [<ffffffff817db728>] __raw_spin_lock_irqsave+0x5=
8/0x60
> 2026-10-17T22:40:07Z {detected_level=3D"unknown"} [ 2570.074391] softirqs=
 last  enabled at (11372): [<ffffffff815ffc88>] handle_softirqs+0x638/0x880
> 2026-10-17T22:40:08Z {detected_level=3D"unknown"} [ 2570.076357] softirqs=
 last disabled at (11365): [<ffffffff8160003f>] __irq_exit_rcu+0x15f/0x290
> 2026-10-17T22:40:08Z {detected_level=3D"unknown"} [ 2570.078305] ---[ end=
 trace 0000000000000000 ]---
> 2026-10-17T22:40:08Z {detected_level=3D"unknown"} [ 2570.084017] nvme nvm=
e2: new ctrl: NQN "blktests-subsystem-1", addr 127.0.0.1:4420, hostnqn: nqn=
.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349
> 2026-10-17T22:40:08Z {detected_level=3D"unknown"} [ 2570.400433] md127: a=
rray will not be assembled in old kernels that lack configurable LBS suppor=
t (<=3D 6.18)
> 2026-10-17T22:40:08Z {detected_level=3D"unknown"} [ 2570.401014] md/raid1=
:md127: active with 1 out of 2 mirrors
> 2026-10-17T22:40:08Z {detected_level=3D"unknown"} [ 2570.404015] md127: d=
etected capacity change from 0 to 2093056
> 2026-10-17T22:40:08Z {detected_level=3D"unknown"} [ 2570.559964] md127: d=
etected capacity change from 2093056 to 0
> 2026-10-17T22:40:08Z {detected_level=3D"unknown"} [ 2570.560710] md: md12=
7 stopped.
> 2026-10-17T22:40:08Z {detected_level=3D"unknown"} [ 2570.632174] nvme nvm=
e2: Removing ctrl: NQN "blktests-subsystem-1"
> 2026-10-17T22:40:09Z {detected_level=3D"unknown"} [ 2571.118121] brd: mod=
ule unloaded
> 2026-10-17T22:40:09Z {detected_level=3D"debug"}   [ 2572.039779] scsi_deb=
ug:sdebug_driver_probe: scsi_debug: trim poll_queues to 0. poll_q/nr_hw =3D=
 (0/1)
> 2026-10-17T22:40:09Z {detected_level=3D"debug"}   [ 2572.040354] scsi hos=
t66: scsi_debug: version 0191 [20210520]
> 2026-10-17T22:40:09Z {detected_level=3D"unknown"} [ 2572.040354]   dev_si=
ze_mb=3D8, opts=3D0x0, submit_queues=3D1, statistics=3D0
> 2026-10-17T22:40:09Z {detected_level=3D"debug"}   [ 2572.046424] scsi 66:=
0:0:0: Direct-Access     Linux    scsi_debug       0191 PQ: 0 ANSI: 7
> 2026-10-17T22:40:09Z {detected_level=3D"unknown"} [ 2572.053271] scsi 66:=
0:0:0: Power-on or device reset occurred
> 2026-10-17T22:40:09Z {detected_level=3D"unknown"} [ 2572.063350] sd 66:0:=
0:0: [sda] 16384 512-byte logical blocks: (8.39 MB/8.00 MiB)
> 2026-10-17T22:40:09Z {detected_level=3D"unknown"} [ 2572.063603] sd 66:0:=
0:0: Attached scsi generic sg1 type 0
> 2026-10-17T22:40:09Z {detected_level=3D"unknown"} [ 2572.064965] sd 66:0:=
0:0: [sda] Write Protect is off
> 2026-10-17T22:40:09Z {detected_level=3D"unknown"} [ 2572.065470] sd 66:0:=
0:0: [sda] Mode Sense: 73 00 10 08
> 2026-10-17T22:40:09Z {detected_level=3D"unknown"} [ 2572.068116] sd 66:0:=
0:0: [sda] Write cache: enabled, read cache: enabled, supports DPO and FUA
> 2026-10-17T22:40:09Z {detected_level=3D"unknown"} [ 2572.075669] sd 66:0:=
0:0: [sda] permanent stream count =3D 5
> 2026-10-17T22:40:10Z {detected_level=3D"unknown"} [ 2572.080471] sd 66:0:=
0:0: [sda] Preferred minimum I/O size 512 bytes
> 2026-10-17T22:40:10Z {detected_level=3D"unknown"} [ 2572.082032] sd 66:0:=
0:0: [sda] Optimal transfer size 524288 bytes
> 2026-10-17T22:40:10Z {detected_level=3D"unknown"} [ 2572.131009] sd 66:0:=
0:0: [sda] Attached SCSI disk

