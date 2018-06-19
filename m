From: bdeyal@gmail.com (Eyal BenDavid)
Date: Wed, 20 Jun 2018 00:33:37 +0300
Subject: NVME-CLI : Fabrics property-get and 64 bit property (CAP)
In-Reply-To: <CAPrnrPA2rUeWsrU5K_s9do30EjuxU3Z0VD_EVCk_81+n-kX+gQ@mail.gmail.com>
References: <CAPrnrPD2PtPO38cAzMfKdhS18GFj1vk032p0h0rQf0CFP+R=cw@mail.gmail.com>
 <e75d7829-9aeb-90fb-249a-c7ac4cef10bd@intel.com>
 <CAPrnrPBKcYUsuQ6krkcjB6BOzLcPz47vje4qjic5Xw9PQN3pTQ@mail.gmail.com>
 <20180619194802.GF19922@localhost.localdomain>
 <CAPrnrPCM79jUwngOQd0t6-pT3RocHNBnt_TS059d+NK-rodqDA@mail.gmail.com>
 <20180619202514.GG19922@localhost.localdomain>
 <CAPrnrPA2rUeWsrU5K_s9do30EjuxU3Z0VD_EVCk_81+n-kX+gQ@mail.gmail.com>
Message-ID: <CAPrnrPCy20UbgF2thtNnxcUZriDZdvGEs6MkZ0074w-ZLgyrdw@mail.gmail.com>

> Yeah, you should be able to see it if you've a recent enough kernel with
> event tracers enabled. First enable the tracing:
>
>   echo 1 > /sys/kernel/debug/tracing/events/nvme/enable
>
> Then after running your nvme command, you should see the result with:
>
>   cat /sys/kernel/debug/tracing/trace

BTW I think there is a bug in function nvme_get_properties() (the
function called for show-regs in the fabric case)
In the case of 64 bit property, the offset loop variable is advanced
correctly only on error.
When the call to nvme_property is successful (and thus err == 0) the
offset variable is advanced by 4 bytes only.

I saw this when looking at the trace:
nvme-25616 [...] nvme_setup_admin_cmd:  cmdid=13, flags=0x0, meta=0x0,
cmd=(0x7f cdw10=00 00 00 00 **04** 00 ...)
show regs tried to get property for location 4.

Here is the code:

    for (off = NVME_REG_CAP; off <= NVME_REG_CMBSZ; off += 4) {
        switch (off) {
        case NVME_REG_CAP:
        case NVME_REG_ASQ:
        case NVME_REG_ACQ:
            is64bit = true;
            break;
        default:
            is64bit = false;
        }
        err = nvme_property(fd, nvme_fabrics_type_property_get,
                off, &value64, is64bit ? 1: 0);
        if (err) {
            if (is64bit)    // <<<<<<<<<<<<<<<<<< Only here
                off += 4;
            continue;
        }
        ret = 0;
        if (is64bit)
            *(uint64_t *)(*pbar + off) = le64_to_cpu(value64);
        else
            *(uint32_t *)(*pbar + off) = le32_to_cpu(value64);
    }
