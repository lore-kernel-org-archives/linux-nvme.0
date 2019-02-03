From: bdeyal@gmail.com (Eyal BenDavid)
Date: Sun, 3 Feb 2019 17:36:41 +0200
Subject: "nvme-cli : wrong connection string for /dev/nvme-facrics (FC)"
Message-ID: <CAPrnrPC_8aM2mc17gU=FvM2TMC+oFvMQGJW4svOBCrZwfC09Yg@mail.gmail.com>

Hi all,

I tried latest nvme-cli with FC and kept getting "invalid argument"
from nvme-fabrics.

I added a print of the connection string.

The connection string is probably wrong (or it can't work with older kernels)

The transport arg in the conn string is "...,transport=fibre-channel,..."

I think it should be "fc" and not "fibre-channel"

dmesg says: [515366.391531] nvme_fabrics: no handler found for
transport fibre-channel

The commit that removed explicit "transport=fc"  is:

commit 55b4ec12ffe43c5abd78fa5806fd2141b49aa1db
Author: Sagi Grimberg <sagi at grimberg.me>
Date:   Tue Nov 20 13:26:06 2018 -0800

    fabrics: use trtype_str when parsing a discovery log entry

    Reduce some code duplication.

    Signed-off-by: Sagi Grimberg <sagi at grimberg.me>


Thanks
Eyal
