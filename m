From: james.smart@broadcom.com (James Smart)
Date: Wed, 13 Jun 2018 08:51:38 -0700
Subject: please revert a nvme-cli commit
In-Reply-To: <20180613075557.GA22940@lst.de>
References: <20180613075557.GA22940@lst.de>
Message-ID: <64647508-fd1f-9ec2-171d-88ba2a5653b7@broadcom.com>

Really ?? sigh.? I have lots of consumers that have no issues with these 
changes and there is nothing that acts "incompatible".?? It's been 1.5 
months - where have you been?

These conditions can occur independent of any change in kernel 
implementation and are significant robustness corrections.

On 6/13/2018 12:55 AM, Christoph Hellwig wrote:
> d8f949c21e9d832149518f26c71dfd8de16cd628 does bogus blind retries
> on failure, and the kernel part of it was rejected.  Let's sort this
> out properly.

title: nvme-cli: Add ioctl retry support for "connect-all"

This should have been sorted out a long time ago. The current 
implementation is completely "happy path".? Failure can occur anytime 
when an error occurs with a discovery controller that causes a 
reconnect.?? This change is isolated to retrieving discovery log records 
and is specifically tied to an EAGAIN status - not a "blind failure".

>
> Similarly at least for now bb2d87d7f386882005bb87fe9412af23c646c876 is
> bogus as well.  We require fabrics connect to be synchronous, and changing
> that will require a longer discussion first.

title: nvme-cli: Wait for device file if not present after successful 
add_ctrl

This, in general, has little to do with kernel implementation which only 
influences it's likelyhood. There's always the possibility the that the 
creation of the /dev node in userspace takes time and the return from 
the create thread could beat it.? It's only more unlikely with the full 
finish-connect before return as that added time.

thus there's no "synchronous" requirement - what does that even mean ??? 
What is the difference between a controller being created then 
immediately failing and going into a reconnect that delays ?

-- james
