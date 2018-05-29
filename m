From: maxg@mellanox.com (Max Gurtovoy)
Date: Tue, 29 May 2018 15:47:37 +0300
Subject: [PATCH 05/17] nvme: Fix extended data LBA supported setting
In-Reply-To: <20180528072244.GF5618@lst.de>
References: <1527436222-15494-1-git-send-email-maxg@mellanox.com>
 <1527436222-15494-6-git-send-email-maxg@mellanox.com>
 <20180528072244.GF5618@lst.de>
Message-ID: <fb6528ea-cb9e-fb26-d0b4-4b3693bfe109@mellanox.com>



On 5/28/2018 10:22 AM, Christoph Hellwig wrote:
> On Sun, May 27, 2018@06:50:10PM +0300, Max Gurtovoy wrote:
>> This value depands on the metadata support value.
>>
>> Signed-off-by: Max Gurtovoy <maxg at mellanox.com>
> 
> Looks fine, I'll pull this into the nvme tree ASAP.
> 

great.
BTW, we can use it for stable kernel as well IMO.
I get NMI and many ref tag errors while configuring my nvme drive with 
extended LBA format and running local fio test. It shouldn't init the 
integrity (by calling blk_integrity_register) in this case at all since 
the driver support only pointer mode metadata. The right behavior in 
this case is to set the PRACT bit (and it's done in nvme_setup_rw).

-Max.
