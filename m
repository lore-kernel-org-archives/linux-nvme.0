From: akinobu.mita@gmail.com (Akinobu Mita)
Date: Sat, 18 May 2019 00:36:21 +0900
Subject: [PATCH 1/2] nvme: add thermal zone infrastructure
In-Reply-To: <20190517150924.GA25006@localhost.localdomain>
References: <1557933437-4693-1-git-send-email-akinobu.mita@gmail.com>
 <1557933437-4693-2-git-send-email-akinobu.mita@gmail.com>
 <2bf1e2cf-b922-d947-c939-375aba75994d@intel.com>
 <CAC5umygRTpq3GktaMKBdC8+-ghkJKCzFME+rm+V6vasrOAyOPw@mail.gmail.com>
 <20190517150924.GA25006@localhost.localdomain>
Message-ID: <CAC5umyhu6_s_CTvOL4_Rp7unqcw+jt9fPo++iGnumqDFQJecxA@mail.gmail.com>

2019?5?18?(?) 0:14 Keith Busch <kbusch at kernel.org>:
>
> On Sat, May 18, 2019@12:01:57AM +0900, Akinobu Mita wrote:
> >
> > This is work_struct, not workqueue.  So it can't be destroyed.
> > But I noticed that we should call flush_work for thermal_work at
> > unregistering thermal zone devices.
>
> Instead of creating yet-another-work_struct, let's append this event's
> action to the existing async_event_work.

Good idea.
