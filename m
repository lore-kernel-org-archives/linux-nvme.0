From: sim@linux.vnet.ibm.com (Narasimhan V)
Date: Mon, 31 Jul 2017 20:11:59 +0530
Subject: [PATCH] nvme: avoid connecting to the same subsystem from the
 same path gain.
In-Reply-To: <31fc10fb-386a-c430-4ca6-1a48e6b356d0@huawei.com>
References: <1493040417-15680-1-git-send-email-guanjunxiong@huawei.com>
 <20170424145842.GA32128@infradead.org>
 <4e371196-36af-a389-a1a2-bdac1bb70e21@huawei.com>
 <20170427064041.GB28074@infradead.org>
 <31fc10fb-386a-c430-4ca6-1a48e6b356d0@huawei.com>
Message-ID: <be62cd00899ecf800cb2d2d9fd4267ab@linux.vnet.ibm.com>

On 2017-04-27 12:46, Guan Junxiong wrote:
> On 2017/4/27 14:40, Christoph Hellwig wrote:
>> On Tue, Apr 25, 2017@09:20:00AM +0800, Guan Junxiong wrote:
>>> Hi ,Christoph:
>>>    What's the benefits of this feature? If we execute the following 
>>> cmd
>>> 10 times, it will generate 10 character and at least 20 block 
>>> devices.
>> 
>> The number of block devices will depend on the number of namespaces
>> configured, but yes, this is expected.  The NVMe architecture allows
>> for multiple connections from a given host to a subsystem.
>> 
>> .
>> 
> Hi, Christoph,Thanks for your reply!
> 
> Currently, the number of block devices will depend on both the number 
> of
> namespaces configured in a subsystem and the number of connections 
> created by
> connect command.
> 
> In addition , I still have the suggestion:
> Can this feature or problematic behavior be adjusted to prevent 
> generating
> another block devices when a new connection is created from a given 
> host to
> a subsystem via the same patho< Maybe a character device (controller) 
> or
> block device (namespaces) can represent more connections given the same 
> path.
> 
> Looking forward for you response. Thanks.

Hellwig,

I think this is more of a confusing/problematic behaviour than a 
feature, as stated.

We might connect to same subsystem again, and see a different nvme 
subsystem, block devices.
Tools like fdisk will discover duplicate block devices as different 
ones.
So, we might think it is a different subsystem. And thus, might have 
data corruption issues.

Looking forward for your clarification in such scenarios, and probably 
your take on this
being feature vs issue.

-- 
Regards
Narasimhan V
