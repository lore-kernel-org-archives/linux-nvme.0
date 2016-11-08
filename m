From: swise@opengridcomputing.com (Steve Wise)
Date: Tue, 8 Nov 2016 14:45:22 -0600
Subject: nvmet_rdma crash - DISCONNECT event with NULL queue
In-Reply-To: <b499abb0-afc9-2985-c4c4-3ceba4ca6f33@grimberg.me>
References: <01b401d23458$af277210$0d765630$@opengridcomputing.com>
 <6f42d056-284d-00fc-2b98-189f54957980@grimberg.me>
 <01cc01d2345b$d445acd0$7cd10670$@opengridcomputing.com>
 <4cc25277-429a-4ab9-470c-b3af1428ce93@grimberg.me>
 <01d101d2345e$2f054390$8d0fcab0$@opengridcomputing.com>
 <dbe5f18d-7928-f065-920f-753b30fb99a2@grimberg.me>
 <01d901d2345f$da0d2e00$8e278a00$@opengridcomputing.com>
 <1d09c064-1cbe-7e6e-43d2-cfa6cf0c19ea@grimberg.me>
 <024e01d23476$6668b890$333a29b0$@opengridcomputing.com>
 <3512b8bb-4d29-b90a-49e1-ebf1085c47d7@grimberg.me>
 <004701d2351a$d9e4ad70$8dae0850$@opengridcomputing.com>
 <01d601d2353d$e3d10810$ab731830$@opengridcomputing.com>
 <b499abb0-afc9-2985-c4c4-3ceba4ca6f33@grimberg.me>
Message-ID: <01b401d23a01$06945b50$13bd11f0$@opengridcomputing.com>

> > Running the same test over mlx4/roce, I hit a warning in list_debug, and
then a
> > stuck CPU...
> 
> Steve,
> 
> Does this patch help?
> --

Hey Sagi,

With this patch applied, I haven't seen any more target side crashes.  I say
this with a caveat, though, that I'm chasing a few other host side issues
still...

Steve.
