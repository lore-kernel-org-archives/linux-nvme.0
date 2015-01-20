From: keith.busch@intel.com (Keith Busch)
Date: Tue, 20 Jan 2015 16:03:24 +0000 (UTC)
Subject: Request on information for driver contribution 
In-Reply-To: <6891C2FAE3B0F342A5B80AFBDCFB5797169CFBE864@BLRX7MCDC204.AMER.DELL.COM>
References: <6891C2FAE3B0F342A5B80AFBDCFB5797169CFBE864@BLRX7MCDC204.AMER.DELL.COM>
Message-ID: <alpine.LNX.2.00.1501201546450.15481@localhost.lm.intel.com>

Hi Lakshmi,

Glad you'd like to get involved. I suppose the best way to contribute is
to turn the question around: what feature is the current driver missing
or doing poorly at that you'd like to see? For example, most of my recent
patches were from testing nvme hot-plug with blk-mq.

If there's a feature you want to develop before capable h/w exists,
we can see if it'll fit in the qemu device, kind of like I did for
Controller Memory Buffer (still hoping that works out!).

On Mon, 19 Jan 2015, Lakshmi_Narayanan_Du@Dell.com wrote:
> Hi Keith,
>
> I am a newbie but interested to contribute to linux upstream . I do have NVMe HW and interested to contribute for the development/issue fixing  part.
> Kindly let me know the open issues and any new implementation like blk-mq.  Sorry to ask but , please help me with the steps of how should I pitch in quickly to
> pick the issues and start working on it.
> Do you have any list of issues that I can repro and make my start
>
> Thanks,
> Lakshmi
