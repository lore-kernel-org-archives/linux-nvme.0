From: jonathan.derrick@intel.com (Jon Derrick)
Date: Fri, 11 Aug 2017 05:08:37 -0600
Subject: nvme-4.14 rebased
In-Reply-To: <20170816081346.GA18770@lst.de>
References: <20170816081346.GA18770@lst.de>
Message-ID: <fe7dede5-824f-fc20-766d-417775193c66@intel.com>

On 08/16/2017 02:13 AM, Christoph Hellwig wrote:
> Hi all,
> 
> I've rebased the nvme-4.14 branch on top of the nvme-4.13 branch
> to avoid conflicts.  As part of that I made the timestamp set features
> return an error similar to the other reset fixes.
> 
> Jon: can you double check the change is correct?
> 

Hi Christoph,

The only thing I'd suggest is not letting a failure to set the timestamp
be a failure to initialize the controller.

Regards,
Jon
