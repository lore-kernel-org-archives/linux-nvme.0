From: sudheendra.sampath@gmail.com (Sudheendra Sampath)
Date: Fri, 12 Oct 2018 11:45:05 -0700
Subject: Help needed: nvmet configuration
In-Reply-To: <20181012183714.GA15812@localhost.localdomain>
References: <CABnqofxasv=-xbQQ+XZH8jad4Oa0gnvKusk5sF_a-kdSLvK1Ww@mail.gmail.com>
 <20181012183714.GA15812@localhost.localdomain>
Message-ID: <CABnqofzQjkBa-DTyTGVrFDBJjF2KEhqttRfuxwK5nHc=LWdY4w@mail.gmail.com>

Hi,

Sorry for the confusion.

I am running into the following error and need help I am doing
something incorrect.

/ports/1/subsystems> create testvm

=====> Could not symlink testvm in configFS: [Errno 19] No such device  <======

/ports/1/subsystems> exit


When I look at ?dmesg?, I see :



[Fri Oct 12 10:42:16 2018] null: module loaded

[Fri Oct 12 10:42:54 2018] nvmet: adding nsid 1 to subsystem testvm

====> [Fri Oct 12 10:44:53 2018] nvmet_rdma: binding CM ID to
12.12.12.38:4420 failed (-19)  <=======
On Fri, Oct 12, 2018 at 11:40 AM Keith Busch
<keith.busch@linux.intel.com> wrote:
>
> On Fri, Oct 12, 2018@11:08:21AM -0700, Sudheendra Sampath wrote:
> > Any help appreciated.
>
> I didn't find a single question or problem description in this information
> dump, so I've no idea what help you're seeking. Also, please turn off
> word wrap next time for console output.



-- 
Regards

Sudheendra Sampath
