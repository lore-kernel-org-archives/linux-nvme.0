From: daniel.verkamp@intel.com (Daniel Verkamp)
Date: Tue, 19 Jun 2018 10:54:20 -0700
Subject: NVME-CLI : Fabrics property-get and 64 bit property (CAP)
In-Reply-To: <CAPrnrPD2PtPO38cAzMfKdhS18GFj1vk032p0h0rQf0CFP+R=cw@mail.gmail.com>
References: <CAPrnrPD2PtPO38cAzMfKdhS18GFj1vk032p0h0rQf0CFP+R=cw@mail.gmail.com>
Message-ID: <e75d7829-9aeb-90fb-249a-c7ac4cef10bd@intel.com>

On 06/19/2018 09:23 AM, Eyal BenDavid wrote:
> Hi all,
> 
> We use show-regs in NVME-CLI for fabrics (FC) property-get (CAP, CC etc)
> 
> The controller capabilities property (CAP) is 64 bit.
> 
> The result field of struct nvme_passthru_cmd is of type __u32
> 
> Therefore the following code snippet from file nvme-ioctl.c,
> function nvme_property() might lose information:
> 
> Code:
>    /*   __le64 *value  */
> 
>     err = nvme_submit_admin_passthru(fd, &cmd);
>     if (!err && fctype == nvme_fabrics_type_property_get)
>         *value = cpu_to_le64(cmd.result);    // <<<<<<  HERE
> 
> When running show-regs command the high dword of CAP is always 0.
> 
> My questions:
> how can I use nvme-cli to get the whole 8 byte range for CAP property
> in property-get command.
> Can I get the missing dword by an additional call to offset 4? (using
> admin-passtru)
> Is it legal for the controller to answer for this request?

I don't know the answer to the nvme-cli question above, but it seems
like struct nvme_completion is insufficient to represent the Property
Get response, since it only has a 32-bit result field, as you mentioned.

For the question about retrieving CAP via 4-byte accesses, I don't think
this is allowed.  NVMe-oF 1.0 base spec section 3.5.1 (Property
Definitions) says: "The host shall access properties in their native
width with an offset that is at the beginning of the property."

Thanks,
-- Daniel
