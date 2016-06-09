From: mrybczyn@kalray.eu (Marta Rybczynska)
Date: Thu, 9 Jun 2016 14:12:01 +0200 (CEST)
Subject: nvme-fabrics: crash at nvme connect-all
In-Reply-To: <57594E81.9060302@lightbits.io>
References: <53708289.31891804.1465463883806.JavaMail.zimbra@kalray.eu>
 <575936F0.9000600@lightbits.io>
 <574056153.32082017.1465466832847.JavaMail.zimbra@kalray.eu>
 <57594E81.9060302@lightbits.io>
Message-ID: <1218382158.32228335.1465474321289.JavaMail.zimbra@kalray.eu>


----- Le 9 Juin 16, ? 13:09, Sagi Grimberg sagi at lightbits.io a ?crit :

>> Hello Sagi,
>> Unfortunately it crashes still (this time at the first connect already).
>> I'm investigating this.
> 
> OK, looking further into your bug report its actually different from
> the one I got. I do think that this patch makes sense regardless.
> 
> From your log I can only guess that you are using iWARP devices?
> because I see that nvmet tries to init an MR pool and seem to
> run out of memory...
> 
> Which device are you using? Are you running on a low memory machine?
> Perhaps the rdma rw code needs to check max_mr capability?
> 

It's a rather big machine with 8 cores/16GB of memory, never had memory
limitation problems on this one. The card is a Chelsio T5. One of the
targets of this configuration is to check if it works with this card.

> Also, are you running the host and target on a single server? it might
> be possible that it requires more resources than the host (or device)
> has?

Yes, that might be an important point.


-- 

Marta Rybczynska 

Phone : +33 6 71 09 68 03 
mrybczyn at kalray.eu
