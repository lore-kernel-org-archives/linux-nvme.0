From: kbusch@kernel.org (Keith Busch)
Date: Thu, 16 May 2019 09:26:23 -0600
Subject: [PATCH 1/2] nvme: add thermal zone infrastructure
In-Reply-To: <CAC5umyhh7eNHa4D9sndsoB7EgTJZTEL9OTd=a+7x817XvPZ_eQ@mail.gmail.com>
References: <1557933437-4693-1-git-send-email-akinobu.mita@gmail.com>
 <1557933437-4693-2-git-send-email-akinobu.mita@gmail.com>
 <20190515191518.GA21916@localhost.localdomain>
 <CAC5umyhh7eNHa4D9sndsoB7EgTJZTEL9OTd=a+7x817XvPZ_eQ@mail.gmail.com>
Message-ID: <20190516152622.GC23416@localhost.localdomain>

On Fri, May 17, 2019@12:22:51AM +0900, Akinobu Mita wrote:
> > Since this routine is intended for use in the device initialization path,
> > the error returns are extra important. We have used < 0 to indicate we
> > need to abandon initialization because we won't be able communicate with
> > the device if we proceed. Since thermal reporting is not mandatory to
> > manage our controllers, out-of-memory or a device that doesn't support
> > SMART should just return 0. We should only halt init if the controller
> > is unresponsive here.
> 
> Make sense.  I'll change the return type to void, and print warning in
> case of some errors as Minwoo said in other reply.

Oh, still needs to be an 'int' return, but just suppress non-fatal
errors by returning 0. If the 'nvme_get_log' times out, though, we need
to return that error since the caller will need to abort initialization.
