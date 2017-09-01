From: yizhan@redhat.com (Yi Zhang)
Date: Fri, 1 Sep 2017 07:08:08 -0400 (EDT)
Subject: kernel tried to execute NX-protected page - exploit attempt?
 (uid: 0) and kernel BUG observed on 4.13.0-rc7
In-Reply-To: <862abde5-894b-3378-bd5b-7cd803d63667@redhat.com>
References: <625458077.3545624.1504152059580.JavaMail.zimbra@redhat.com>
 <9925ad05-5bfc-d645-5abd-5519cb8e2323@grimberg.me>
 <862abde5-894b-3378-bd5b-7cd803d63667@redhat.com>
Message-ID: <1813385109.3857319.1504264088445.JavaMail.zimbra@redhat.com>

Hi Sagi

I reproduced this issue again, here is the full log:
server1: https://pastebin.com/4wTfrbLj
server2: https://pastebin.com/K1tpApgt

It's more complex to reproduce it this time:
steps I used:
1. set up target on both server1 and server2.
2. On server1, connect server2, do IO background and reset operation, cancel it after several seconds.
3. On server2, connect server1, do IO background and reset operation, cancel it after several seconds.
4. Do step 2-3 until reproduced it.


Best Regards,
  Yi Zhang


----- Original Message -----
From: "Yi Zhang" <yizhan@redhat.com>
To: linux-nvme at lists.infradead.org, "Sagi Grimberg" <sagi at grimberg.me>
Cc: "Max Gurtovoy" <maxg at mellanox.com>
Sent: Thursday, August 31, 2017 9:09:57 PM
Subject: Re: kernel tried to execute NX-protected page - exploit attempt? (uid: 0) and kernel BUG observed on 4.13.0-rc7



On 08/31/2017 08:19 PM, Sagi Grimberg wrote:
> Hi Yi,
>
> Can you share th host dmesg prior to the crash?
>

Hi Sagi
Here is the full console log from client side.
https://pastebin.com/dfmvuPhJ

> It looks like we get a timeout expiration on a request with
> an already freed resources...
>
> Did one of the controller resets in the loop fail by any chance?
>

I remember this bug occurred at the first reset operation and hang at 
there, from the log we can also confirm it

> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-nvme


_______________________________________________
Linux-nvme mailing list
Linux-nvme at lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
