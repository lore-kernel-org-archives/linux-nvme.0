From: glider@google.com (Alexander Potapenko)
Date: Tue, 9 Jan 2018 15:07:44 +0100
Subject: Uninitialized memory used to generate nqn in nvmf_host_default()
Message-ID: <CAG_fn=XLt4z3-UWYxg3YWb-ZcXGqJOfMXj-JaRR5gT0mJqV0OQ@mail.gmail.com>

Hi Christoph, Keith,

according to KMSAN (and common sense as well) the following code in
drivers/nvme/host/fabrics.c
(http://elixir.free-electrons.com/linux/latest/source/drivers/nvme/host/fabrics.c#L68):

  72         host = kmalloc(sizeof(*host), GFP_KERNEL);
  73         if (!host)
  74                 return NULL;
  75
  76         kref_init(&host->ref);
  77         snprintf(host->nqn, NVMF_NQN_SIZE,
  78                 "nqn.2014-08.org.nvmexpress:uuid:%pUb", &host->id);

uses uninitialized heap memory to generate the unique id for the NVMF host.
If I'm understanding correctly, it can be then passed to the
userspace, so the contents of the uninitialized chunk may potentially
leak.
If the specification doesn't rely on this UID to be random or unique,
I suggest using kzalloc() here, otherwise it might be a good idea to
use a real RNG.

Is my reasoning correct?

-- 
Alexander Potapenko
Software Engineer

Google Germany GmbH
Erika-Mann-Stra?e, 33
80636 M?nchen

Gesch?ftsf?hrer: Paul Manicle, Halimah DeLaine Prado
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
