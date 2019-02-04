From: james.smart@broadcom.com (James Smart)
Date: Mon, 4 Feb 2019 13:41:04 -0800
Subject: "nvme-cli : wrong connection string for /dev/nvme-facrics (FC)"
In-Reply-To: <CAPrnrPC_8aM2mc17gU=FvM2TMC+oFvMQGJW4svOBCrZwfC09Yg@mail.gmail.com>
References: <CAPrnrPC_8aM2mc17gU=FvM2TMC+oFvMQGJW4svOBCrZwfC09Yg@mail.gmail.com>
Message-ID: <7b8e7f70-d520-2a64-ba5b-636dc033fe04@broadcom.com>

Eyal,

Yes, that patch switched things up on FC and made it no longer match the 
fc transport.
I just submitted a patch to correct it.

Thank You

-- james


On 2/3/2019 7:36 AM, Eyal BenDavid wrote:
> Hi all,
>
> I tried latest nvme-cli with FC and kept getting "invalid argument"
> from nvme-fabrics.
>
> I added a print of the connection string.
>
> The connection string is probably wrong (or it can't work with older kernels)
>
> The transport arg in the conn string is "...,transport=fibre-channel,..."
>
> I think it should be "fc" and not "fibre-channel"
>
> dmesg says: [515366.391531] nvme_fabrics: no handler found for
> transport fibre-channel
>
> The commit that removed explicit "transport=fc"  is:
>
> commit 55b4ec12ffe43c5abd78fa5806fd2141b49aa1db
> Author: Sagi Grimberg <sagi at grimberg.me>
> Date:   Tue Nov 20 13:26:06 2018 -0800
>
>      fabrics: use trtype_str when parsing a discovery log entry
>
>      Reduce some code duplication.
>
>      Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
>
>
> Thanks
> Eyal
>
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-nvme
