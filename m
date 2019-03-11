From: sagi@grimberg.me (Sagi Grimberg)
Date: Mon, 11 Mar 2019 16:56:14 -0700
Subject: [PATCH 7/8] nvme/pci: Remove volatile from cqe
In-Reply-To: <20190311183324.GG11448@lst.de>
References: <20190308174313.5134-1-keith.busch@intel.com>
 <20190308174313.5134-7-keith.busch@intel.com> <20190311183324.GG11448@lst.de>
Message-ID: <ad2add1c-efa6-c446-9685-6ea4ce7c2c45@grimberg.me>


>> The cqe isn't volatile once we confirm the phase bit. Remove the volatile
>> keyword and let the compiler optimize out an unnecessary additional read
>> to the command id.
> 
> Hmm.  I've never been happy about how we used volatile to start with,
> but I'm not sure more casts sort out this problem.
> 
> Wouldn't the right fix be to drop the volatile entirely and force
> a strong barrier before first reading the phase bit?

Is there a fundamental difference efficiency-wise?
