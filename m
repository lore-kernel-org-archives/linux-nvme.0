From: kbusch@kernel.org (Keith Busch)
Date: Fri, 10 May 2019 08:02:09 -0600
Subject: [PATCH] nvme-pci: Use non-operational power state instead of D3
 on Suspend-to-Idle
In-Reply-To: <BC5EB1D0-8718-48B3-ACAB-F7E5571D821D@canonical.com>
References: <20190509095601.GA19041@lst.de>
 <225CF4F7-C8E1-4C66-B362-97E84596A54E@canonical.com>
 <20190509103142.GA19550@lst.de>
 <AB325926-0D77-4851-8E8A-A10599756BF9@canonical.com>
 <31b7d7959bf94c15a04bab0ced518444@AUSX13MPC101.AMER.DELL.COM>
 <20190509192807.GB9675@localhost.localdomain>
 <7a002851c435481593f8629ec9193e40@AUSX13MPC101.AMER.DELL.COM>
 <20190509215409.GD9675@localhost.localdomain>
 <495d76c66aec41a8bfbbf527820f8eb9@AUSX13MPC101.AMER.DELL.COM>
 <BC5EB1D0-8718-48B3-ACAB-F7E5571D821D@canonical.com>
Message-ID: <20190510140209.GG9675@localhost.localdomain>

On Thu, May 09, 2019@11:05:42PM -0700, Kai-Heng Feng wrote:
> Yes, that? what I was told by the NVMe vendor, so all I know is to impose a  
> memory barrier.
> If mb() shouldn?t be used here, what?s the correct variant to use in this  
> context?

I'm afraid the requirement is still not clear to me. AFAIK, all our
barriers routines ensure data is visible either between CPUs, or between
CPU and devices. The CPU never accesses HMB memory, so there must be some
other reasoning if this barrier is a real requirement for this device.
