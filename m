From: Gili.Buzaglo@taec.toshiba.com (Gili Buzaglo)
Date: Thu, 18 Aug 2016 15:27:25 +0000
Subject: Configured nqn
In-Reply-To: <cf880042-60bf-4639-7a8b-d62bc4be7a76@grimberg.me>
References: <14E6FCBE6C7E3A47A6CD7D77E639D51C2F73FABD@oczmail.ocz.ocztechnology.com>
 <f94a27cf-8dcf-c881-4fe9-a45d0ce7c9c6@grimberg.me>
 <1470678878.2626.6.camel@linux.intel.com>
 <FECD6836D08A8545A696BA54811397B92E7E5ED9@EXMAIL1.taec.toshiba.com>
 <1471471446.6059.11.camel@linux.intel.com>
 <FECD6836D08A8545A696BA54811397B92E7E6253@EXMAIL1.taec.toshiba.com>
 <cf880042-60bf-4639-7a8b-d62bc4be7a76@grimberg.me>
Message-ID: <FECD6836D08A8545A696BA54811397B92E7E6460@EXMAIL1.taec.toshiba.com>

Probalbly yes, we'll see who's available ..
Thanks

-----Original Message-----
From: Sagi Grimberg [mailto:sagi@grimberg.me] 
Sent: Thursday, August 18, 2016 12:56 PM
To: Gili Buzaglo; J Freyensee; linux-nvme at lists.infradead.org
Subject: Re: Configured nqn


> Hi
> I think the host nqn file should exist even before the first 
> connection attempt, so That a management software will be able to first configure the storage to allow connection from this nqn(with ACL).
> The rpm spec can run a script during first install to take care of that.

Sounds reasonable...

Care to send a patch? ;)
