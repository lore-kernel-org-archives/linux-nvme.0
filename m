From: kbusch@kernel.org (Keith Busch)
Date: Mon, 25 Mar 2019 11:27:25 -0600
Subject: The state of Compare and Write testing using linux-nvme
In-Reply-To: <CAPrnrPDCNUhXDMaqUTMoMsAsNe7FgvjwHS4+eqpSkOtJVFkkMg@mail.gmail.com>
References: <CAPrnrPDCNUhXDMaqUTMoMsAsNe7FgvjwHS4+eqpSkOtJVFkkMg@mail.gmail.com>
Message-ID: <20190325172725.GB4328@localhost.localdomain>

On Mon, Mar 25, 2019@07:09:11PM +0200, Eyal BenDavid wrote:
> Questions:
> Why the check for flags in the kernel module? The fix is trivial
> (I would suggest a module parameter that can be set from sysfs)
> 
> I have a side branch for nvme-cli with the compare and write implemented
> (from two threads), but it?s useless if nvme-core rejects fused flags.
> If it?s desirable I can provide a pull request.
> 
> How can a user space program select a specific submission queue?

I think you discovered why we don't allow arbitrary flags. We can't
enforce the user to run in such a way that the commands are submitted in
the correct order on the same queue.

We'd need to provide a new ioctl for fused commands to make this work
correctly.
