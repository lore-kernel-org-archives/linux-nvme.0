From: sagi@grimberg.me (Sagi Grimberg)
Date: Thu, 18 Aug 2016 12:56:17 +0300
Subject: Configured nqn
In-Reply-To: <FECD6836D08A8545A696BA54811397B92E7E6253@EXMAIL1.taec.toshiba.com>
References: <14E6FCBE6C7E3A47A6CD7D77E639D51C2F73FABD@oczmail.ocz.ocztechnology.com>
 <f94a27cf-8dcf-c881-4fe9-a45d0ce7c9c6@grimberg.me>
 <1470678878.2626.6.camel@linux.intel.com>
 <FECD6836D08A8545A696BA54811397B92E7E5ED9@EXMAIL1.taec.toshiba.com>
 <1471471446.6059.11.camel@linux.intel.com>
 <FECD6836D08A8545A696BA54811397B92E7E6253@EXMAIL1.taec.toshiba.com>
Message-ID: <cf880042-60bf-4639-7a8b-d62bc4be7a76@grimberg.me>


> Hi
> I think the host nqn file should exist even before the first connection attempt, so
> That a management software will be able to first configure the storage to allow connection from this nqn(with ACL).
> The rpm spec can run a script during first install to take care of that.

Sounds reasonable...

Care to send a patch? ;)
