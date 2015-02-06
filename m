From: herbert1984106@gmail.com (sheng qiu)
Date: Fri, 6 Feb 2015 15:04:08 -0800
Subject: discard cmd through ioctl
In-Reply-To: <alpine.LNX.2.00.1502061845360.15481@localhost.lm.intel.com>
References: <CAB7xdi=CDHmc1p-jRnTKfh1fhpVE9wY1i8ZrB6ZxO4rU9iAfvA@mail.gmail.com>
 <alpine.LNX.2.00.1502061845360.15481@localhost.lm.intel.com>
Message-ID: <CAB7xdikDj5=n_o16VjKNaXe7G5+Odm3kmucXAy0zaWwXXT7ikw@mail.gmail.com>

Hi Keith,

thanks for your reply.
for the struct "nvme_passthru_cmd", can you tell me what's the "flags"
and "rsvd1" used for? which cmd filed does it associated to the NVMe
Spec?

just want to make sure i am composing the correct cmd format.

THanks!
Sheng

On Fri, Feb 6, 2015@12:02 PM, Keith Busch <keith.busch@intel.com> wrote:
> On Fri, 6 Feb 2015, sheng qiu wrote:
>>
>> Hi,
>>
>> May i ask is there a way to issue data set management cmd from
>> application to achieve discard function with current NVMe driver?
>>
>> i see there are regular IO or Admin interface for ioctl at driver
>> side. Is this also applicable to dsm cmd?
>
>
> Sure, you can use the NVME_IOCTL_IO_CMD to submit any arbitary IO command
> you like.
>
> It would probably be easier to use sg_unmap or blkdiscard to achieve the
> same thing unless you require using the DSM command's other attributes
> in addition to deallocate.
>
>> Thanks,
>> Sheng
