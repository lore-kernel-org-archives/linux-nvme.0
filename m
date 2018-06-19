From: bdeyal@gmail.com (Eyal BenDavid)
Date: Tue, 19 Jun 2018 19:23:00 +0300
Subject: NVME-CLI : Fabrics property-get and 64 bit property (CAP)
Message-ID: <CAPrnrPD2PtPO38cAzMfKdhS18GFj1vk032p0h0rQf0CFP+R=cw@mail.gmail.com>

Hi all,

We use show-regs in NVME-CLI for fabrics (FC) property-get (CAP, CC etc)

The controller capabilities property (CAP) is 64 bit.

The result field of struct nvme_passthru_cmd is of type __u32

Therefore the following code snippet from file nvme-ioctl.c,
function nvme_property() might lose information:

Code:
   /*   __le64 *value  */

    err = nvme_submit_admin_passthru(fd, &cmd);
    if (!err && fctype == nvme_fabrics_type_property_get)
        *value = cpu_to_le64(cmd.result);    // <<<<<<  HERE

When running show-regs command the high dword of CAP is always 0.

My questions:
how can I use nvme-cli to get the whole 8 byte range for CAP property
in property-get command.
Can I get the missing dword by an additional call to offset 4? (using
admin-passtru)
Is it legal for the controller to answer for this request?

Thanks
Eyal
