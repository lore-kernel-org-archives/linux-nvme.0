From: herbert1984106@gmail.com (sheng qiu)
Date: Mon, 16 Mar 2015 14:03:47 -0700
Subject: discard cmd through ioctl
In-Reply-To: <alpine.LNX.2.00.1502070239360.15481@localhost.lm.intel.com>
References: <CAB7xdi=CDHmc1p-jRnTKfh1fhpVE9wY1i8ZrB6ZxO4rU9iAfvA@mail.gmail.com>
 <alpine.LNX.2.00.1502061845360.15481@localhost.lm.intel.com>
 <CAB7xdikDj5=n_o16VjKNaXe7G5+Odm3kmucXAy0zaWwXXT7ikw@mail.gmail.com>
 <alpine.LNX.2.00.1502070239360.15481@localhost.lm.intel.com>
Message-ID: <CAB7xdi=oDjWsoDMMAVXRs37LNxLU+X3TQ6TkWGz_w6fbDEHG8Q@mail.gmail.com>

Hi all,

may i ask if there's any plan to support the fused command?

Thanks!
Sheng

On Fri, Feb 6, 2015@6:52 PM, Keith Busch <keith.busch@intel.com> wrote:
> On Fri, 6 Feb 2015, sheng qiu wrote:
>>
>> Hi Keith,
>>
>> thanks for your reply.
>> for the struct "nvme_passthru_cmd", can you tell me what's the "flags"
>> and "rsvd1" used for? which cmd filed does it associated to the NVMe
>> Spec?
>
>
> The IOCTL's structure tries to match an NVMe command except for parts
> user space has no way of knowing about; those parts are command id and
> bus addresses.
>
> The 'flags' are CDW0's bits 8-15, just after the opcode. The only spec
> defined use for them is fuse and SGL, neither of which are supported by
> the driver, so should be cleared to 0 for now.
>
> 'rsvd1' is for CDW3. The spec has no defined use for it, but we have a
> field in the IOCTL's arg so we have a placeholder for it in the future
> without breaking ABI.
