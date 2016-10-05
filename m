From: sagi@grimberg.me (Sagi Grimberg)
Date: Wed, 5 Oct 2016 19:50:57 +0300
Subject: [PATCH 1/1] nvme : Add sysfs entry for NVMe CMBs when appropriate
In-Reply-To: <20161005143843.GA23281@cgy1-donard.priv.deltatee.com>
References: <1475014513-18083-1-git-send-email-sbates@raithlin.com>
 <1475014513-18083-2-git-send-email-sbates@raithlin.com>
 <9d062df7-d895-4c21-ca0d-b4fc3cb878c1@grimberg.me>
 <20161005143843.GA23281@cgy1-donard.priv.deltatee.com>
Message-ID: <b8f19ee3-e641-1e30-3294-192b1f519181@grimberg.me>


> The fabrics specification currently denotes the CMBLOC and CMBSZ
> properties as reserved [1].

Managed to forget that... So I guess I'm fine with the patch as
it is,

Reviewed-by: Sagi Grimberg <sagi at grimberg.me>

> Also I am wondering where the physical memory backing a fabrics CMB
> would reside. Would this be memory in the fabric NIC on the host, in
> the NIC on the target or somewhere else?

This was discussed in the WG a few times before, not sure if we
can discuss this before its in the spec though...
