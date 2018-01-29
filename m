From: dledford@redhat.com (Doug Ledford)
Date: Mon, 29 Jan 2018 16:27:20 -0500
Subject: Reconnect on RDMA device reset
In-Reply-To: <EFFF4091-3CBA-474B-B9D7-FF7EDA3B1613@oracle.com>
References: <CADZhsQqDFc1NWmsihOwki8_2Zj0HuYKC_N_x0jMnCtU9Rww1UA@mail.gmail.com>
 <f0a14240-1566-1bae-1b9f-21880bc3f3a0@grimberg.me>
 <CADZhsQqvK0LMd9sfxzz+x_5qVnoi4FP0FCFMsTPjpeXyqfXKew@mail.gmail.com>
 <77cef33e-a563-97fc-7ba6-69f220f1be84@grimberg.me>
 <1516904022.27592.187.camel@redhat.com>
 <679C11A4-744C-4574-9F50-2D2C3B0F08B0@oracle.com>
 <92367a43-4c2e-887f-35ff-38fa05d47c49@grimberg.me>
 <EFFF4091-3CBA-474B-B9D7-FF7EDA3B1613@oracle.com>
Message-ID: <1517261240.27592.245.camel@redhat.com>

On Mon, 2018-01-29@15:11 -0500, Chuck Lever wrote:
> > On Jan 29, 2018,@3:01 PM, Sagi Grimberg <sagi@grimberg.me> wrote:
> > 
> > Hi Chuck,
> > 
> > > For NFS/RDMA, I think of the "failover" case where a device is
> > > removed, then a new one is plugged in (or an existing cold
> > > replacement is made available) with the same IP configuration.
> > > On a "hard" NFS mount, we want the upper layers to wait for
> > > a new suitable device to be made available, and then to use
> > > it to resend any pending RPCs. The workload should continue
> > > after a new device is available.
> > 
> > Really? so the context is held forever (in case the device never
> > comes back)?
> 
> I didn't say this was the best approach :-) And it certainly can
> change if we have something better.

Whether it's the best or not, it's the defined behavior of the "hard"
mount option.  So if someone doesn't want that, you don't use a hard
mount ;-)

Hard mounts are great for situations where you have a high degree of
faith that even if they server disappears, it will reappear soon.  They
suck when the server totally dies though, because now all the hard mount
clients are stuck :-/.

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
URL: <http://lists.infradead.org/pipermail/linux-nvme/attachments/20180129/178ad2ea/attachment-0001.sig>
