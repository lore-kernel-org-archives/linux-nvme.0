From: Alex_Gagniuc@Dellteam.com (Alex_Gagniuc@Dellteam.com)
Date: Sun, 5 Aug 2018 15:48:57 +0000
Subject: How /dev/nvme numbers are allocated/mapped to BDF
References: <073447516980487e950bbc428225ae02@ausx13mps321.AMER.DELL.COM>
 <20180803071820.GA22003@infradead.org>
 <20180803144025.GA4381@localhost.localdomain>
 <097442158bb64b9cbf07cc6e6c25ef1a@ausx13mps321.AMER.DELL.COM>
 <20180803165411.GA4551@localhost.localdomain>
 <20180804081636.GA4421@infradead.org>
Message-ID: <248c8975982541a5ac5b6de088366e27@ausx13mps321.AMER.DELL.COM>

On 08/04/2018 03:16 AM, Christoph Hellwig wrote:
> On Fri, Aug 03, 2018@10:54:11AM -0600, Keith Busch wrote:
>> The sammy drives do not have compliant serial number. Spec requires
>> strings are left justified, padding spaces to the right.
> 
> It doesn't look like Samsung fucked it up but Dell..
> 
> On the plus side that should give us more of a chance to fix it :)

You underestimate Dell's kindness. These drives were intentionally 
released with Koren serial numbers to give the linux folk a test 
platform. :)
