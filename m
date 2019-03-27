From: hch@lst.de (Christoph Hellwig)
Date: Wed, 27 Mar 2019 14:55:48 +0100
Subject: [PATCH 7/8] nvme/pci: Remove volatile from cqe
In-Reply-To: <ad2add1c-efa6-c446-9685-6ea4ce7c2c45@grimberg.me>
References: <20190308174313.5134-1-keith.busch@intel.com>
 <20190308174313.5134-7-keith.busch@intel.com> <20190311183324.GG11448@lst.de>
 <ad2add1c-efa6-c446-9685-6ea4ce7c2c45@grimberg.me>
Message-ID: <20190327135548.GE25849@lst.de>

On Mon, Mar 11, 2019@04:56:14PM -0700, Sagi Grimberg wrote:
>
>>> The cqe isn't volatile once we confirm the phase bit. Remove the volatile
>>> keyword and let the compiler optimize out an unnecessary additional read
>>> to the command id.
>>
>> Hmm.  I've never been happy about how we used volatile to start with,
>> but I'm not sure more casts sort out this problem.
>>
>> Wouldn't the right fix be to drop the volatile entirely and force
>> a strong barrier before first reading the phase bit?
>
> Is there a fundamental difference efficiency-wise?

I'm not sure.  The latter is just more our usual Linux style.
