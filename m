From: Lakshmi_Narayanan_Du@Dell.com (Lakshmi_Narayanan_Du@Dell.com)
Date: Wed, 21 Jan 2015 11:08:48 +0530
Subject: Request on information for driver contribution 
In-Reply-To: <alpine.LNX.2.00.1501201546450.15481@localhost.lm.intel.com>
References: <6891C2FAE3B0F342A5B80AFBDCFB5797169CFBE864@BLRX7MCDC204.AMER.DELL.COM>
 <alpine.LNX.2.00.1501201546450.15481@localhost.lm.intel.com>
Message-ID: <6891C2FAE3B0F342A5B80AFBDCFB5797169CFBEABE@BLRX7MCDC204.AMER.DELL.COM>

Thank you very much for the prompt response Keith . 
So let me start playing around with blk-mq .

Currently ,I am working with the " linux-next"  git code .. Is this fine ? 
Kindly  help with your confirmation 

Thanks,
Lakshmi 

-----Original Message-----
From: Keith Busch [mailto:keith.busch@intel.com] 
Sent: Tuesday, January 20, 2015 9:33 PM
To: Du, Lakshmi Narayanan
Cc: keith.busch at intel.com; linux-nvme at lists.infradead.org
Subject: Re: Request on information for driver contribution 

Hi Lakshmi,

Glad you'd like to get involved. I suppose the best way to contribute is to turn the question around: what feature is the current driver missing or doing poorly at that you'd like to see? For example, most of my recent patches were from testing nvme hot-plug with blk-mq.

If there's a feature you want to develop before capable h/w exists, we can see if it'll fit in the qemu device, kind of like I did for Controller Memory Buffer (still hoping that works out!).

On Mon, 19 Jan 2015, Lakshmi_Narayanan_Du@Dell.com wrote:
> Hi Keith,
>
> I am a newbie but interested to contribute to linux upstream . I do have NVMe HW and interested to contribute for the development/issue fixing  part.
> Kindly let me know the open issues and any new implementation like 
> blk-mq.  Sorry to ask but , please help me with the steps of how should I pitch in quickly to pick the issues and start working on it.
> Do you have any list of issues that I can repro and make my start
>
> Thanks,
> Lakshmi
