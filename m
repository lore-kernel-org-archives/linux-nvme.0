From: dledford@redhat.com (Doug Ledford)
Date: Fri, 27 Apr 2018 12:07:52 -0400
Subject: [PATCH 0/6] IB: make INFINIBAND_ADDR_TRANS configurable
In-Reply-To: <20180426181935.32977-1-gthelen@google.com>
References: <20180426181935.32977-1-gthelen@google.com>
Message-ID: <1524845272.11756.51.camel@redhat.com>

On Thu, 2018-04-26@11:19 -0700, Greg Thelen wrote:
> This series allows for CONFIG_INFINIBAND without
> CONFIG_INFINIBAND_ADDR_TRANS (aka RDMA communication manager).
> Fuzzing has been finding fair number of CM bugs.
> So provide an option to disable it in systems which don't need it.
> 
> Changes since last posting (https://lkml.org/lkml/2018/4/25/1266):
> - added ("ib_srp: depend on INFINIBAND_ADDR_TRANS") patch

[ snip explanation of series ]

Thanks for taking the time to research this out.  Series applied.

-- 
Doug Ledford <dledford at redhat.com>
    GPG KeyID: B826A3330E572FDD
    Key fingerprint = AE6B 1BDA 122B 23B4 265B  1274 B826 A333 0E57 2FDD
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-nvme/attachments/20180427/e919981f/attachment.sig>
