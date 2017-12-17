From: minwoo.im.dev@gmail.com (Minwoo Im)
Date: Sun, 17 Dec 2017 12:02:01 +0900
Subject: [PATCH 1/2] nvme-cli: update Firmware Activate command for new
 feature
In-Reply-To: <20171215182333.GG26752@localhost.localdomain>
References: <1513360971-15566-1-git-send-email-minwoo.im.dev@gmail.com>
 <1513360971-15566-2-git-send-email-minwoo.im.dev@gmail.com>
 <20171215182333.GG26752@localhost.localdomain>
Message-ID: <CAA7jzteW0ZOPou+VePYcF=SW14KNPsEiYqryvGktQuVaoiy_rA@mail.gmail.com>

Hi Keith,

On Sat, Dec 16, 2017@3:23 AM, Keith Busch <keith.busch@intel.com> wrote:
> On Sat, Dec 16, 2017@03:02:50AM +0900, Minwoo Im wrote:
>> Firmware Activate command were known as "Firmware Activate" in NVMe 1.0 and 1.1.
>> It has been changed to Firmware Commit since 1.2.
>> Also NVMe 1.3 spec introduced boot partition feature to Firmware Commit
>> command.
>>
>> Update Firmware Activate command name and add a few new feature of boot
>> partition.
>
> Hm, I can't really accept this. The tool existed when the command was
> still called firmware activate in the spec. There are scripts in people's
> environments that automate firmware updates, and we can't just break them
> by changing a command name.
>
> What I would accept is an alias command so we can deprecate/hide the
> old command name. I've wanted to add infrastructure for creating aliased
> commands, but I've not had time to get around to it.

I totally agree with you. Sorry for sending a patch without any
considering users
who are using 1.0 and 1.1 NVMe devices. It would make some confusions.

If it's okay, I'll try to send a patch for an alias command infrastructure with
a real use case for Firmware Activate command.

Thanks,
