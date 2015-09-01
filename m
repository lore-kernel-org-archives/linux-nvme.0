From: keith.busch@intel.com (Keith Busch)
Date: Tue, 1 Sep 2015 17:25:48 +0000 (UTC)
Subject: [PATCH] NVMe:Expose model attribute in sysfs
In-Reply-To: <20150901165554.GB12201@localhost.localdomain>
References: <20150825045412.GA20360@localhost.localdomain>
 <alpine.LNX.2.00.1508251510330.3969@localhost.lm.intel.com>
 <20150901165554.GB12201@localhost.localdomain>
Message-ID: <alpine.LNX.2.00.1509011717550.23840@localhost.lm.intel.com>

On Tue, 1 Sep 2015, Sujith Pandel wrote:
> On Tue, Aug 25, 2015@12:14:39PM -0500, Keith Busch wrote:
>> But if we're going to have more than one sysfs entry, we can manage
>> this easier using attribute groups instead. There are lots of examples
>> in the kernel for this, like scsi_sysfs.c or blk-mq-sysfs.c
>
> Since there are only two sysfs attributes here as of now,
> I will be going with your former suggestion of using a new goto label.

Aww, that just forces the person who finds a need to add a third entry
to implement a better design, or maybe he/she will use the same reasoning
to shift that problem to the next person.

The "zero, one, infinity rule" puts 2 in the same catagory as infinity.
