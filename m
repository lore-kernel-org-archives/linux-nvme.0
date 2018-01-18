From: israelr@mellanox.com (Israel Rukshin)
Date: Thu, 18 Jan 2018 15:43:26 +0200
Subject: [PATCH 2/2] nvme: Fix subsystem multiple controllers support check
In-Reply-To: <20180108101626.GA5383@lst.de>
References: <1515081374-22328-1-git-send-email-maxg@mellanox.com>
 <1515081374-22328-2-git-send-email-maxg@mellanox.com>
 <20180108101626.GA5383@lst.de>
Message-ID: <75ea1be7-0dab-a6fd-3120-4ab410739246@mellanox.com>

On 1/8/2018 12:16 PM, Christoph Hellwig wrote:
> Btw, I suspect we'll need to to do something interesting here for
> the multipath case as well.  Can you investigate that?

Hi Christoph,

I have tested the same scenario with the multipath flag and it seems to 
work.
I created a target and took a refcount on "nvme0n1" block device and 
then I removed the nvme pci device.
After probing the pci I got a new name for the same nvme device "nvme0n2".
When I did the same test without the multipath case I got another new 
name "nvme1n2".

Regards,
Israel
