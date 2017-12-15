From: keith.busch@intel.com (Keith Busch)
Date: Fri, 15 Dec 2017 11:23:33 -0700
Subject: [PATCH 1/2] nvme-cli: update Firmware Activate command for new
 feature
In-Reply-To: <1513360971-15566-2-git-send-email-minwoo.im.dev@gmail.com>
References: <1513360971-15566-1-git-send-email-minwoo.im.dev@gmail.com>
 <1513360971-15566-2-git-send-email-minwoo.im.dev@gmail.com>
Message-ID: <20171215182333.GG26752@localhost.localdomain>

On Sat, Dec 16, 2017@03:02:50AM +0900, Minwoo Im wrote:
> Firmware Activate command were known as "Firmware Activate" in NVMe 1.0 and 1.1.
> It has been changed to Firmware Commit since 1.2.
> Also NVMe 1.3 spec introduced boot partition feature to Firmware Commit
> command.
> 
> Update Firmware Activate command name and add a few new feature of boot
> partition.

Hm, I can't really accept this. The tool existed when the command was
still called firmware activate in the spec. There are scripts in people's
environments that automate firmware updates, and we can't just break them
by changing a command name.

What I would accept is an alias command so we can deprecate/hide the
old command name. I've wanted to add infrastructure for creating aliased
commands, but I've not had time to get around to it.
