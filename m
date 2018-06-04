From: roland@purestorage.com (Roland Dreier)
Date: Mon, 4 Jun 2018 14:58:49 -0700
Subject: [PATCH 0/3] Provide more fine grained control over multipathing
In-Reply-To: <db1aa53f-1152-c003-ccc1-3e439ca6916d@grimberg.me>
References: <20180525125322.15398-1-jthumshirn@suse.de>
 <20180525130535.GA24239@lst.de> <20180525135813.GB9591@redhat.com>
 <db1aa53f-1152-c003-ccc1-3e439ca6916d@grimberg.me>
Message-ID: <CAL1RGDV0eT4juuMwHWkjqc2oTsk-CHRJ0A90veXxLsVZYa5esQ@mail.gmail.com>

> Moreover, I also wanted to point out that fabrics array vendors are
> building products that rely on standard nvme multipathing (and probably
> multipathing over dispersed namespaces as well), and keeping a knob that
> will keep nvme users with dm-multipath will probably not help them
> educate their customers as well... So there is another angle to this.

As a vendor who is building an NVMe-oF storage array, I can say that
clarity around how Linux wants to handle NVMe multipath would
definitely be appreciated.  It would be great if we could all converge
around the upstream native driver but right now it doesn't look
adequate - having only a single active path is not the best way to use
a multi-controller storage system.  Unfortunately it looks like we're
headed to a world where people have to write separate "best practices"
documents to cover RHEL, SLES and other vendors.

We plan to implement all the fancy NVMe standards like ANA, but it
seems that there is still a requirement to let the host side choose
policies about how to use paths (round-robin vs least queue depth for
example).  Even in the modern SCSI world with VPD pages and ALUA,
there are still knobs that are needed.  Maybe NVMe will be different
and we can find defaults that work in all cases but I have to admit
I'm skeptical...

 - R.
