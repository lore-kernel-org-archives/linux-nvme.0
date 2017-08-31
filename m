From: yizhan@redhat.com (Yi Zhang)
Date: Thu, 31 Aug 2017 21:09:57 +0800
Subject: kernel tried to execute NX-protected page - exploit attempt?
 (uid: 0) and kernel BUG observed on 4.13.0-rc7
In-Reply-To: <9925ad05-5bfc-d645-5abd-5519cb8e2323@grimberg.me>
References: <625458077.3545624.1504152059580.JavaMail.zimbra@redhat.com>
 <9925ad05-5bfc-d645-5abd-5519cb8e2323@grimberg.me>
Message-ID: <862abde5-894b-3378-bd5b-7cd803d63667@redhat.com>



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
