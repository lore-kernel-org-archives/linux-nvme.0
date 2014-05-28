From: wyung@micron.com (Winson Yung (wyung))
Date: Wed, 28 May 2014 13:35:28 -0700
Subject: [PATCH] NVMe: Add support to receive NVMe asynchronous events
In-Reply-To: <alpine.LRH.2.03.1405261834070.4700@AMR>
References: <53839E67.1010006@micron.com>
 <20140526235156.GS6121@linux.intel.com>
 <alpine.LRH.2.03.1405261834070.4700@AMR>
Message-ID: <53864890.5070609@micron.com>

I had a look of the patch, it looks it does what I was trying to enable, 
except it misses the portion that enables it by calling set feature cmd. 
Is it something we can consider now? Also, for these critical warnings 
that exposed by the async events, can we also put them in the kernel log 
as well when they enabled?

/Winson

On 5/26/2014 5:56 PM, Keith Busch wrote:
> On Mon, 26 May 2014, Matthew Wilcox wrote:
>> You should probably take a look at Keith's work last year to allow userspace
>> to send async event requests:
>>
>> http://lists.infradead.org/pipermail/linux-nvme/2013-August/000350.html
>
> Yeah, that proposal just lets userspace consume the results of an async
> request from a FIFO read through the character device. The driver still
> has to do the sending since there's no mechanism for requests from user
> space with infinite timeout.
>
> I've no idea if the proposed method for consuming results of this kind
> of information was typical. I assumed it wasn't since it didn't get much
> traction. :)
>
