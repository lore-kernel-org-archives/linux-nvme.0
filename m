From: m@bjorling.me (=?UTF-8?B?TWF0aWFzIEJqw7hybGluZw==?=)
Date: Wed, 02 Sep 2015 12:59:48 +0200
Subject: [PATCH v7 0/5] Support for Open-Channel SSDs
In-Reply-To: <55E6721F.4040307@cn.fujitsu.com>
References: <1438957791-24632-1-git-send-email-mb@lightnvm.io>
 <55E6721F.4040307@cn.fujitsu.com>
Message-ID: <55E6D6A4.605@bjorling.me>

>> Any feedback is greatly appreciated.
>
> Hi Matias,
>      After a reading of your code, that's a great idea.
> I tried it with null_nvm and qemu-nvm. I have two questions
> here.

Hi Yang, thanks for taking a look. I appreciate it.

>      (1), Why we name it lightnvm? IIUC, this framework
> can work for other flashes not only NVMe protocol.

Indeed, there are people that work on using it with rapidio. It can also 
work with SATA/SAS, etc.

The lightnvm name came from the technique to offload devices (which 
contains non-volatile memory) so they only care about managing the 
media. In that sense "light" nvm. I'm open to other suggestions. I 
really wanted the OpenNVM / OpenSSD name, but they where already taken.

>      (2), There are gc and bm, but where is the wear leveling?
> In hardware?

It should be implemented within each target. The rrpc module implements 
it within its gc routines. Currently rrpc only looks at the least about 
of invalid pages. The PE cycles should also be taken into account. 
Properly some weighted function to decide the cost. Similar to the 
cost-based gc used in the DFTL paper.

>
> Thanx
> Yang
