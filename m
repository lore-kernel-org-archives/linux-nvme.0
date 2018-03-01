From: sagi@grimberg.me (Sagi Grimberg)
Date: Thu, 1 Mar 2018 11:28:58 +0200
Subject: [PATCH V2] nvme-pci: assign separate irq vectors for adminq and
 ioq0
In-Reply-To: <20180228164726.GB16536@lst.de>
References: <1519832921-13915-1-git-send-email-jianchao.w.wang@oracle.com>
 <20180228164726.GB16536@lst.de>
Message-ID: <ddfc2ab4-1a51-c488-25e8-bc434edf8aba@grimberg.me>


> Note that we originally allocates irqs this way, and Keith changed
> it a while ago for good reasons.  So I'd really like to see good
> reasons for moving away from this, and some heuristics to figure
> out which way to use.  E.g. if the device supports more irqs than
> I/O queues your scheme might always be fine.

I still don't understand what this buys us in practice. Seems redundant
to allocate another vector without any (even marginal) difference.
