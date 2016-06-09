From: mrybczyn@kalray.eu (Marta Rybczynska)
Date: Thu, 9 Jun 2016 12:07:12 +0200 (CEST)
Subject: nvme-fabrics: crash at nvme connect-all
In-Reply-To: <575936F0.9000600@lightbits.io>
References: <53708289.31891804.1465463883806.JavaMail.zimbra@kalray.eu>
 <575936F0.9000600@lightbits.io>
Message-ID: <574056153.32082017.1465466832847.JavaMail.zimbra@kalray.eu>

----- Le 9 Juin 16, ? 11:29, Sagi Grimberg sagi at lightbits.io a ?crit :
> 
> Hi Marta,
> 
> I got the same bug report, it looks like we're might
> be facing a double-free condition.
> 
> Does this patch help?
> --
> commit fd36b6ef3d0881b1bccc1eac8737baaf8c863a21


Hello Sagi,
Unfortunately it crashes still (this time at the first connect already).
I'm investigating this.

Regards,

-- 

Marta Rybczynska 

Phone : +33 6 71 09 68 03 
mrybczyn at kalray.eu
