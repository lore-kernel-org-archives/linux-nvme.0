From: hch@lst.de (Christoph Hellwig)
Date: Mon, 12 Jun 2017 13:03:57 +0200
Subject: [PATCH v2] nvme: use uuid_t in nvme_ns
In-Reply-To: <52228639-aedd-fdb9-0f02-448f8982758a@suse.de>
References: <20170612091240.18343-1-jthumshirn@suse.de>
 <CAHp75Ve+-+s3Fx4MnjXoXf3tjh_PkdnEKAKrXnmFWA_38_abnw@mail.gmail.com>
 <52228639-aedd-fdb9-0f02-448f8982758a@suse.de>
Message-ID: <20170612110357.GA22745@lst.de>

On Mon, Jun 12, 2017@12:04:18PM +0200, Johannes Thumshirn wrote:
> > So, this reveals two thins:
> > 1) shall we define NVME_NIDT_UUID_LEN to be UUID_LEN or substitute it
> > completely with the latter?
> 
> No, we have NVME_NIDT_UUID_LEN but also NVME_NIDT_NGUID_LEN and
> NVME_NIDT_EUI64_LEN.

Yeah, and I'd rather keep the defines for fields defined in the spec
in nvme.h

> I'm not sure the NVMe NGUID is the same as a GUID (a.k.a little endian
> UUID). Quoting from the spec:

It's not at all, the field just has a very unfortunate name in the
spec.
