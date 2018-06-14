From: james.smart@broadcom.com (James Smart)
Date: Thu, 14 Jun 2018 09:29:24 -0700
Subject: please revert a nvme-cli commit
In-Reply-To: <20180614124237.GA28896@lst.de>
References: <20180613075557.GA22940@lst.de>
 <64647508-fd1f-9ec2-171d-88ba2a5653b7@broadcom.com>
 <20180614124237.GA28896@lst.de>
Message-ID: <a4ece148-00b6-01de-ab6b-3fc8a89818f8@broadcom.com>



On 6/14/2018 5:42 AM, Christoph Hellwig wrote:
> On Wed, Jun 13, 2018@08:51:38AM -0700, James Smart wrote:
>> Really ?? sigh.? I have lots of consumers that have no issues with these
>> changes and there is nothing that acts "incompatible".?? It's been 1.5
>> months - where have you been?
>>
>> These conditions can occur independent of any change in kernel
>> implementation and are significant robustness corrections.
> I don't agree.  For one so far we've guaranteed the device node
> appears before we return from the write to the /dev/nvme-fabrics
> device.  If that changes it is a significant ABI break, and we need
> to fix that in the kernel.

what provides the guarantee that it appears first ?

Based on what I've seen there is nothing but time that guarantees it, 
and if that's true, the udev user side always has a potential of getting 
hung up and exceeding the time.


>
> And if it wasn't the fix is still wrong - we'd need to wait for it to
> appear using libudev APIs and/or one of the file notification syscalls
> rather than adding a probing loop that is in a different place than
> the actual open.

that's fine, I can certainly go look in that direction.

>
> And for retrying the actual I/O we need to decide on the exact semantics
> we want to support first.  Blind n time retry is always a bad idea,
> we need to build some sort of reliable infrastructure.  Be that
> optionally marking requests as not failfast, and/or some sort of poll
> notification for a device that is ready.

Ok. Given I've already had complaints that the cli shouldn't hang out 
for a minute or more - the time it takes for a controller to lose 
connectivity and fail the loss timeout, and that's not considering the 
cmds that probe several controllers each of which could do this 
sequentially resulting in a delay of many minutes - and as the user may 
want to kill the waiting cli, I'm of the opinion that the kernel request 
should be terminated not suspended. Thus the ios should continue to be 
failfast and let the policy be in the cli based on what the command is.? 
Making the cli use the poll notification to find when the controller is 
ready again is fine.

what should be the general policy for any command? if receive an EAGAIN 
(not ready) then poll until ready or device failure ????? or return 
failure immediately unless command is connect-all (discovery log read) 
then it waits for ready/failure ?

what should be the policy for the commands that probe multiple 
controllers ? ?? do commands fail immediately causing command to skip 
controllers not ready (message when does so) ??? note: the skip is 
already there on command failure, but if we suspend as a general policy, 
it would affect it.

-- james
