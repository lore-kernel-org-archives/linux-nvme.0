From: sagi@lightbits.io (Sagi Grimberg)
Date: Thu, 9 Jun 2016 14:09:53 +0300
Subject: nvme-fabrics: crash at nvme connect-all
In-Reply-To: <574056153.32082017.1465466832847.JavaMail.zimbra@kalray.eu>
References: <53708289.31891804.1465463883806.JavaMail.zimbra@kalray.eu>
 <575936F0.9000600@lightbits.io>
 <574056153.32082017.1465466832847.JavaMail.zimbra@kalray.eu>
Message-ID: <57594E81.9060302@lightbits.io>


> Hello Sagi,
> Unfortunately it crashes still (this time at the first connect already).
> I'm investigating this.

OK, looking further into your bug report its actually different from
the one I got. I do think that this patch makes sense regardless.

 From your log I can only guess that you are using iWARP devices?
because I see that nvmet tries to init an MR pool and seem to
run out of memory...

Which device are you using? Are you running on a low memory machine?
Perhaps the rdma rw code needs to check max_mr capability?

Also, are you running the host and target on a single server? it might
be possible that it requires more resources than the host (or device)
has?
