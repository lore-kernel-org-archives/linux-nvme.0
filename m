From: dledford@redhat.com (Doug Ledford)
Date: Tue, 30 Jan 2018 12:24:56 -0500
Subject: Reconnect on RDMA device reset
In-Reply-To: <CADZhsQpWXQQ2dKxAorGMhk7HFvqoQ2Y5LxVKt66XjkcUbEuXpA@mail.gmail.com>
References: <CADZhsQqDFc1NWmsihOwki8_2Zj0HuYKC_N_x0jMnCtU9Rww1UA@mail.gmail.com>
 <f0a14240-1566-1bae-1b9f-21880bc3f3a0@grimberg.me>
 <CADZhsQqvK0LMd9sfxzz+x_5qVnoi4FP0FCFMsTPjpeXyqfXKew@mail.gmail.com>
 <77cef33e-a563-97fc-7ba6-69f220f1be84@grimberg.me>
 <1516904022.27592.187.camel@redhat.com>
 <26056a83-2f81-6b56-7bbf-fcecfc4518d6@grimberg.me>
 <1517264899.27592.277.camel@redhat.com>
 <CADZhsQpWXQQ2dKxAorGMhk7HFvqoQ2Y5LxVKt66XjkcUbEuXpA@mail.gmail.com>
Message-ID: <1517333096.27592.281.camel@redhat.com>

On Tue, 2018-01-30@17:03 +0200, Oren Duer wrote:
> Not sure why we need to keep track whether it is the same device or not.
> I fail to understand why we trust the system admin to create the connections
> at the beginning, but we should not trust him anymore if the device was
> removed, a new device was added in place of it, and it was configured with the
> same network IP/subnet. To me it looks like the admin wanted exactly that:
> for the connections to be restored over the new device.

In my original email, I pointed out that I didn't know how the NVMe over
Fabrics was doing addressing.  If it were like SRP, then it wouldn't
work because the device GUID is part of the addressing scheme, so a new
device wouldn't automatically show as matching that address.  If,
however, you use IP like iSER, then yes, I agree fully you can just test
the ability to route over the new device using the IP address and
restore if it works.

-- 
Doug Ledford <dledford at redhat.com>
    GPG KeyID: B826A3330E572FDD
    Key fingerprint = AE6B 1BDA 122B 23B4 265B  1274 B826 A333 0E57 2FDD
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-nvme/attachments/20180130/52de7d54/attachment.sig>
