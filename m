From: sagi@grimberg.me (Sagi Grimberg)
Date: Sat, 22 Oct 2016 00:53:56 +0300
Subject: [PATCH RFC v2 0/3] connect reject event helpers
In-Reply-To: <cover.1477003235.git.swise@opengridcomputing.com>
References: <cover.1477003235.git.swise@opengridcomputing.com>
Message-ID: <a46f48f3-01b3-fd9b-b642-c20555759107@grimberg.me>


> While reviewing:
>
> http://lists.infradead.org/pipermail/linux-nvme/2016-October/006681.html
>
> I decided to propose transport-agnostic helper functions to better
> handle connection reject event information.  I've included a nvme_rdma
> patch to utilize the new helpers.
>
> Thoughts?

Hey Steve,

This looks nice and useful. Would be great if you can
also help other ULPs that use this (e.g. srp/srpt)
