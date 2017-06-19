From: sagi@grimberg.me (Sagi Grimberg)
Date: Mon, 19 Jun 2017 19:21:10 +0300
Subject: [PATCH rfc 28/30] nvme: update tagset nr_hw_queues when
 reallocating io queues
In-Reply-To: <20170619080622.GA396@ming.t460p>
References: <1497799324-19598-1-git-send-email-sagi@grimberg.me>
 <1497799324-19598-29-git-send-email-sagi@grimberg.me>
 <20170619072148.GE13168@lst.de> <20170619080622.GA396@ming.t460p>
Message-ID: <e8698703-fcbd-bbfb-9904-c8af86b26cd1@grimberg.me>


>>> Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
>>
>> Could use a changelog.
>>
>> Ming: does this solve your problem of not seeing the new queues
>> after a qemu CPU hotplug + reset?
> 
> The issue I observed is that there isn't NVMe reset triggered after
> CPU becomes online.

This won't help with that.

> It may take a while since the test need to apply the whole patchset.
> Or is it fine to figure out one fix on this issue? Sagi?

No need, all this doesn't even touch pci for now...
