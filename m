From: jonathan.derrick@intel.com (Jon Derrick)
Date: Fri, 26 Jun 2015 12:10:47 -0600
Subject: [PATCH] NVMe: Fixed race between nvme_thread & probe path.
In-Reply-To: <CAGgvQNRjgwRFdN54v7j5gnS1xEXpRADr=0WZO3iH4AcQaNsY8g@mail.gmail.com>
References: <1434624230-25050-1-git-send-email-Parav.pandit@avagotech.com>
 <20150618155932.GA1276@localhost.localdomain>
 <CAGgvQNRjgwRFdN54v7j5gnS1xEXpRADr=0WZO3iH4AcQaNsY8g@mail.gmail.com>
Message-ID: <20150626181047.GA3128@localhost.localdomain>

> >> +     smp_wmb();
> >
> > This has been applied already as an explicit mb()
> 
> Since these structure is only accessible by software, won't smp_wmb()
> sufficient enough?
> 

Seems reasonable to me
